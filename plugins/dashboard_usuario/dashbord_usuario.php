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
function listar_todos_usuarios_msm_email($sufixoemail) {
	global $wpdb;
	$listadeusers = $wpdb->get_results("SELECT * FROM $wpdb->users WHERE user_email LIKE '$sufixoemail'");
	$i = 0;

	foreach ( (array) $listadeusers as $author ) { 
	global $current_user;
    get_currentuserinfo();
    $idregistrado = $current_user->id;
    if ($idregistrado !=  $author->ID){
    ?>
 	<li>
 		
 	<a class="btn btn-primary" data-toggle="modal" href='#modal-id-<?php echo $i; ?>' id='user-id-<?php echo $author->ID ?>'><?php echo $author->user_email; ?></a>
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
		//1 é inativo
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
    wp_add_dashboard_widget( 'dashboard_representante', 'Listas de usuários', 'dashboard_representante' );

}
function dashboard_representante(){
	global $current_user;
    get_currentuserinfo();
    $email = $current_user->user_email;
    $sufixo = explode("@", $email);
    $sufixo = "%@".$sufixo[1]."%";
    echo "<ul>";
		listar_todos_usuarios_msm_email($sufixo);
    echo "</ul>";

    if($_POST['idUserAtivar']){
    	?>
    	<?php
    	global $wpdb;
    	$iduseraSerAtivado =  $_POST['idUserAtivar'];
    	$nome_tabela = "wp_user_status_manager";
    	$ativar = $wpdb->query("UPDATE $nome_tabela SET status = 0 WHERE user_id = $iduseraSerAtivado");
               if($ativar) { 
                 echo 'Usuário ativo com sucesso.';
                 ?>
				<script>
					$(document).ready(function(){
						$( "#user-id-<?php echo $iduseraSerAtivado; ?>" ).hide();
						$( "#user-id-<?php echo $iduseraSerAtivado; ?>" ).fadeIn("slow");
				});
				</script>

                 <?php
            }
    }
 }


add_action( 'wp_dashboard_setup', 'dashboard_representante_function' );

?>