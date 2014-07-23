<?php
/*
Plugin Name: Dashboard usuario
Plugin URI: http://montarsite.com.br
Description: Personalizar o dashboard do usuario
Version: 1.0
Author: MontarSite
Author URI: http://montarsite.com.br
License: GPLv2
*/
function listar_todos_usuarios_msm_email_inativos($sufixoemail) {
	global $wpdb, $current_user;
	// $listadeusers = $wpdb->get_results("SELECT * FROM $wpdb->users WHERE user_email LIKE '$sufixoemail'");
    get_currentuserinfo();
	$idregistrado = $current_user->id;
	
	$empresa_id = get_user_meta( $current_user->id, 'empresa', true );
	$listadeusers = get_user_meta( $empresa_id, 'usuarios', true );
	
	$i = 0;

	foreach ( (array) $listadeusers as $author_id ) { 
		// Pula se for o próprio representante
		if ( $idregistrado ==  $author_id )
			continue;
		$author = get_userdata( $author_id );
		// Está inativo?
		$verificaativado = $wpdb->get_results("SELECT * FROM  wp_user_status_manager WHERE user_id =  $author->ID AND status LIKE 0");
		if ( $verificaativado )
			continue;
		// HTML
		?>
		
		<li>
		
			<a class="btn btn-danger" data-toggle="modal" href='#modal-id-<?php echo $i; ?>' id='user-id-<?php echo $author->ID ?>'><?php echo $author->user_email; ?></a>
			
			<div class="modal fade" id="modal-id-<?php echo $i; ?>">
				<div class="modal-dialog">
					<div class="modal-content">
						<form action='index.php' method="POST">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title">Informações de usuário</h4>
							</div>
							<div class="modal-body">
								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<th><?php echo $author->user_email; ?></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>Nome</td>
											<td><?php echo $author->user_name; ?></td>
										</tr>
										<tr>
											<td>Data de registro</td>
											<td><?php echo $author->user_registered; ?></td>
										</tr>
											<input type="hidden" value="<?php echo $author->ID; ?>" name="idUserAtivar">
											<input type="hidden" value="<?php echo $author->user_email; ?>" name="EmailUserAtivacao">
									</tbody>
								</table>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Ativar</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
							</div>
						</form>
					</div><!-- /.modal-content -->
				</div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			
		</li>

		<?php
		$i++;
	}
}

//Listar todos os usuarios ativos
function listar_todos_usuarios_msm_email_ativos($sufixoemail) {
	global $wpdb, $current_user;
    // $listadeusers_ativos = $wpdb->get_results("SELECT * FROM $wpdb->users WHERE user_email LIKE '$sufixoemail'");
    get_currentuserinfo();
	$idregistrado = $current_user->id;
	
	$empresa_id = get_user_meta( $current_user->id, 'empresa', true );
	$listadeusers = get_user_meta( $empresa_id, 'usuarios', true );
	
    $i = 0;

	foreach ( (array) $listadeusers as $author_id ) {
		// Pula se for o próprio representante
		if ( $idregistrado ==  $author_id )
			continue;
		$author = get_userdata( $author_id );
		// Está ativo?
		$verificaativado = $wpdb->get_results("SELECT * FROM  wp_user_status_manager WHERE user_id =  $author->ID AND status LIKE 1");
		if ( $verificaativado )
			continue;
		// HTML
		?>
		
		<li>
		
			<a class="btn btn-success" data-toggle="modal" href='#modal-id-ativo-<?php echo $i; ?>' id='user-id-ativo-<?php echo $author->ID ?>'><?php echo $author->user_email; ?></a>
			
			<div class="modal fade" id="modal-id-ativo-<?php echo $i; ?>">
				<div class="modal-dialog">
					<div class="modal-content">
						<form action='index.php' method="POST">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title">Informações de usuário</h4>
						</div>
						<div class="modal-body">
							<table class="table table-striped table-hover">
								<thead>
									<tr>
										<th><?php echo $author->user_email; ?></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Nome</td>
										<td><?php echo $author->user_name; ?></td>
									</tr>
									<tr>
										<td>Data de registro</td>
										<td><?php echo $author->user_registered; ?></td>
									</tr>
										<input type="hidden" value="<?php echo $author->ID; ?>" name="idUserDesativar">
								</tbody>
							</table>
						</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-danger">Desativar</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
							</div>
						</form>
					</div><!-- /.modal-content -->
				</div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
		</li>

        <?php
        $i++;
    }
}


function wptutsplus_remove_dashboard_widgets() {
    $user = wp_get_current_user();
    if ( ! $user->has_cap( 'manage_options' ) ) {
        remove_meta_box( 'dashboard_recent_comments', 'dashboard', 'normal' );
        remove_meta_box( 'dashboard_incoming_links', 'dashboard', 'normal' );
        remove_meta_box( 'dashboard_quick_press', 'dashboard', 'side' );
        remove_meta_box( 'dashboard_primary', 'dashboard', 'side' );
        remove_meta_box( 'dashboard_secondary', 'dashboard', 'side' );
    }
}
add_action( 'wp_dashboard_setup', 'wptutsplus_remove_dashboard_widgets' );

function dashboard_representante_function() {
    global $current_user;
    if ($current_user->caps['representante']){
        wp_add_dashboard_widget( 'dashboard_representante_inativos', 'Usuários inativos', 'dashboard_representante_inativos' );
        wp_add_dashboard_widget( 'dashboard_representante_ativos', 'Usuários ativos', 'dashboard_representante_ativos' );
    }
}

//Cria a funcao de todos os usuarios inativos
function dashboard_representante_inativos(){
    global $current_user;
    get_currentuserinfo();
    // $email = $current_user->user_email;
    // $sufixo = explode("@", $email);
    // $sufixo = "%@".$sufixo[1]."%";
	$sufixo = null; // não mais utilizado
    echo "<ul>";
        listar_todos_usuarios_msm_email_inativos($sufixo);
    echo "</ul>";

    if($_POST['idUserAtivar']){
        global $wpdb;
        $iduseraSerAtivado =  $_POST['idUserAtivar'];
        $EmailUserAtivacao =  $_POST['EmailUserAtivacao'];
        $nome_tabela = "wp_user_status_manager";
        $ativar = $wpdb->query("UPDATE $nome_tabela SET status = 0 WHERE user_id = $iduseraSerAtivado");
               if($ativar) { 
                 echo 'Usuário ativo com sucesso.';
                 ?>
                <script>
                $(document).ready(function(){
                        $( "#user-id-<?php echo $iduseraSerAtivado; ?>" ).fadeOut("slow");
                });
                </script>

                 <?php
                 enviar_email_ativacao($EmailUserAtivacao);
            }
    }
 }


//Cria a funcao de todos os usuarios ativos
 function dashboard_representante_ativos(){
    global $current_user;
    get_currentuserinfo();
    // $email = $current_user->user_email;
    // $sufixo = explode("@", $email);
    // $sufixo = "%@".$sufixo[1]."%";
	$sufixo = null; // não mais utilizado
    echo "<ul>";
        listar_todos_usuarios_msm_email_ativos($sufixo);
    echo "</ul>";

    if($_POST['idUserDesativar']){
        global $wpdb;
        $iduseraSerDesativado =  $_POST['idUserDesativar'];
        $nome_tabela = "wp_user_status_manager";
        $desativar = $wpdb->query("UPDATE $nome_tabela SET status = 1 WHERE user_id = $iduseraSerDesativado");
               if($desativar) { 
                 echo 'Usuário desativado com sucesso.';
                 ?>
                <script>
                $(document).ready(function(){
                    window.location.reload(true);
                        $( "#user-id-ativo-<?php echo $iduseraSerDesativado; ?>" ).fadeOut("slow");
                });
                </script>
                 <?php

            }
    }
}

function enviar_email_ativacao($email){
    require($_SERVER['DOCUMENT_ROOT']. '/wp-blog-header.php');
    global $wpdb;
    global $user;



        $content_post = get_post(160);
        $content = $content_post->post_content;
        $content = str_replace(']]>', ']]&gt;', $content);

        $headers = "From: Contato <contato@asug.com.br>" . "\n";
        $headers .= "MIME-Version: 1.0" . "\n";
        $headers .= "Content-type: text/html\r\n";


        $attachments = esc_url_raw( get_the_author_meta( 'user_meta_image', $user->ID ) );
        wp_mail($email, "Sua conta foi ativada", $content, $headers);
}
add_action( 'wp_dashboard_setup', 'dashboard_representante_function' );

