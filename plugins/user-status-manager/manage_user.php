<script type='text/javascript'>

    jQuery(function() {
		var curr_date = '<?=date("d/m/Y"); ?>';
		jQuery('[id^=txt_from_date_]').datepicker({minDate: curr_date,dateFormat: 'dd/mm/yy'});	
		jQuery('[id^=txt_to_date_]').datepicker({minDate: curr_date,dateFormat: 'dd/mm/yy'});	
    });

 	function dataAut(idUsuario){

 		statusUsuario = jQuery("#set_user_status_" + idUsuario + " option:selected").val();

 		if ( statusUsuario == "0" || statusUsuario == "2" ) {

			var dataHoje = new Date();

			var dataAtual = String( dataHoje.getDate() ).replace( /^(\d)$/, "0$1" ) + "/"
						  + String( dataHoje.getMonth() + 1 ).replace( /^(\d)$/, "0$1" ) + "/"
						  + dataHoje.getFullYear();

			var _1mes = 30 * 24 * 60 * 60 * 1000;
			var _1ano = 365 * 24 * 60 * 60 * 1000;
			var proxData = new Date( dataHoje.getTime() + ( statusUsuario == "0" ? _1ano : _1mes ) );

			var dataExpiracao = String( proxData.getDate() ).replace( /^(\d)$/, "0$1" ) + "/"
							  + String( proxData.getMonth() + 1 ).replace( /^(\d)$/, "0$1" ) + "/"
							  + proxData.getFullYear();

 			jQuery("#txt_from_date_"+idUsuario).val(dataAtual);
 			jQuery("#txt_to_date_"+idUsuario).val(dataExpiracao);

 			jQuery( "#txt_from_date_"+idUsuario + ", #txt_to_date_"+idUsuario ).removeAttr('disabled');

 		}

 		if ( statusUsuario == "1" ) {
 			jQuery( "#txt_from_date_"+idUsuario + ", #txt_to_date_"+idUsuario ).val('').attr( 'disabled', true );
 		}

	}


	function get_head_val(vals){
		is_checked = jQuery("#chk_all_head").is(':checked');
		if(is_checked){
			jQuery(":checkbox").attr("checked", true);
		}else{
			jQuery(":checkbox").attr("checked", false);
		}
	}

	function hide_select_all(){
		jQuery('#chk_all_head').attr("checked", false);
		jQuery('#chk_all_foot').attr("checked", false);
	}

	function get_foot_val(vals){
		is_checked = jQuery("#chk_all_foot").is(':checked');
		if(is_checked){
			jQuery(":checkbox").attr("checked", true);
		}else{
			jQuery(":checkbox").attr("checked", false);
		}
	}

	function operation_ids(){
		var count_val=0;
		var index=0;
		var val_id="";
		var from_date = "";
		var to_date = "";
		var status = "";
		var notify = "";
		console.log('Checking IDs...');
		jQuery('input[name="chk_user[]"]').each( function() {
				if(jQuery(this).is(':checked')){
					count_val++;
				}
		});
		if(count_val==0){
			alert("Por favor, marque as caixas dos usuários a serem alterados.");
			return false;
		}else{
			jQuery('input[name="chk_user[]"]').each(function() {
				if(jQuery(this).is(':checked')){
					id = jQuery(this).val();
					val_id += id+",";
					from_date +=jQuery('#txt_from_date_'+index).val()+","; 
					to_date +=jQuery('#txt_to_date_'+index).val()+","; 
					status +=jQuery('#set_user_status_'+index).val()+","; 
					notify += ( jQuery('#notify' + id).is(':checked') ? id : '' ) + ",";
				}
				index++;
			});
			
			// Remove última vírgula
			val_id = val_id.slice(0, -1);
			from_date = from_date.slice(0, -1);
			to_date = to_date.slice(0, -1);
			status = status.slice(0, -1);
			notify = notify.slice(0, -1);

			var url_val = jQuery('#site_url').val(),
				reqData = { 'user_id': val_id, 'from_date': from_date, 'to_date': to_date, 'status': status, 'notify' : notify };
				
			console.info( '[Ajax] Salvando IDs ' + val_id + '...' )

			jQuery.post( url_val+"save_to_db.php", reqData, function(data) {
				console.info( '[Ajax] Sucesso: ' + data );
				if(data=="yes"){
					alert("Suas configurações foram salvas com êxito!");
				}else{
					alert("Não foi possível salvar suas configurações.");
				}
			}).fail( function( jqXHR, status, erro ) {
				console.group();
				console.warn( '[Ajax] Request para ' + url_val + ' falhou.\nDados enviados:' );
				console.warn( reqData );
				console.warn( 'Erro retornado: ' + status + ': ' + erro );
				console.groupEnd();
			});

			return false;
		}
	}
</script>
<center><h2>Controlar Status dos Usu&aacute;rios</h2></center>
<hr/>
<?php
 global  $wpdb;
 $table = $wpdb->prefix . 'user_status_manager';
 // 'orderby' => 'registered', 'order' => 'ASC' 
 //$blogusers = get_users();
 $args = fnSetArgument();
 
 $strMessageTable = $wpdb->prefix . 'usm_post_message';
 $arrMessageId = $wpdb->get_results("select id,post_message from $strMessageTable LIMIT 1");
  
 $blogusers = new WP_User_Query( $args );
 $arrUserDetails = $blogusers->get_results();
 $intUserCount = count($arrUserDetails);
 
 /*
 // count the number of users found in the query
 echo $total_users = $arrUserDetails ? count($arrUserDetails) : 1;
	
 // grab the current page number and set to 1 if no page number is set
 $page = isset($_GET['p']) ? $_GET['p'] : 1;
	
 // how many users to show per page
 $users_per_page = 2;
	
 // calculate the total number of pages.
 $total_pages = 1;
 $offset = $users_per_page * ($page - 1);
 echo $total_pages = ceil($total_users / $users_per_page);
 
 if($total_pages==1){
 	$arrArgs = fnSetArgument();
 }
 else{
 	$arrArgs = fnSetArgument($offset);
 }
 $arrUserTemp = new WP_User_Query($arrArgs);
 $arrUsers = $arrUserTemp->get_results();
 */
 if(isset($_POST['strPostMessage']) && !empty($_POST['strPostMessage'])){
	$wpdb->update($strMessageTable,array('post_message'=>$_POST['strPostMessage']),array('id'=>$arrMessageId[0]->id));
	$strPostMessage = $_POST['strPostMessage'];
	echo "<script>alert('Mensagem alterada com sucesso!');</script>";
 }
 else{
 	$strPostMessage = $arrMessageId[0]->post_message;
 }
 $path = dirname(__FILE__);
 $path = str_replace("\\","/",$path);
 $path = trailingslashit(get_bloginfo('wpurl')) . trailingslashit(substr($path,strpos($path,"wp-content/")));//Get Plugin URL
 $url  = $path;
 $output = '';
 /*
 $output = "<form method='post'>
 
				<p>
					<b>Mensagem de erro para usu&aacute;rios inativos que tentarem fazer login:</b>
				</p>
				
				<p>
					<textarea cols=55 rows=5 id='strPostMessage' name='strPostMessage'>"
						. esc_html( $strPostMessage ) .
					"</textarea>
				</p>
				
				<p>
					<input type='submit' name='btnSubmitMsg' id='btnSubmitMsg' class='button-primary' value='Alterar'/>
				</p>
				
 			</form>";
 $output.="<hr/>";
 */
 $output.="<form method='post' id=\"form-".$users->id."\">
 			<b>Buscar usu&aacute;rios por nome ou e-mail:</b> <input type='text' id='strUserSearch' name='strUserSearch' style='width: 200px;' value='" . esc_attr( $_REQUEST['strUserSearch'] ) . "'/>
 			<input type='submit' id='btnUserSearch' name='btnUserSearch' value='Buscar' class='button-primary' />
 		</form>
 		<br/>";
 $output.="<form method='post' onsubmit='console.log('Submitting...');return operation_ids()'>";
 $output.= "<table class='widefat'>";

 $output.= "<script type=\"text/javascript\">
 $(document).ready(function (){ 
	$(\".btn-group .representante\").click(function () {
		$(\".btn-group a\").removeClass( \"active\" );
	 	$(\".user_normal\").fadeOut(\"slow\");
	 	$(\".representante_user\").fadeIn(\"slow\");
	 	$(this).addClass(\"active\");
	});
	$(\".btn-group .todos\").click(function () {
		$(\".btn-group a\" ).removeClass( \"active\" );
	 	$(\".representante_user\").fadeIn(\"slow\");
	 	$(\".user_normal\").fadeIn(\"slow\");
	 	$(this).addClass(\"active\");
	});
	$(\".btn-group .comum\").click(function () {
		$(\".btn-group a\").removeClass( \"active\" );
	 	$(\".representante_user\").fadeOut(\"slow\");
	 	$(\".user_normal\").fadeIn(\"slow\");
	 	$(this).addClass(\"active\");
	});
});
</script>
<div class=\"btn-group\">
    <a href=\"#\" class=\"todos btn btn-primary active\">Todos</a>
    <a href=\"#\" class=\"representante btn btn-primary\">Representantes</a>
    <a href=\"#\" class=\"comum btn btn-primary\">Funcionários</a>
</div>
<script >

    function reciboEmail(id) {
    	 var empresa = $('#inputNome_empresa_'+id).val();
    	 var data = $('#inputData_'+id).val();
    	 var valor = $('#inputValor_'+id).val();
    	 var email = $('#email_'+id).val();
    	$( '#modal-id-'+id+' #result' ).fadeOut(\"fast\");
    	$( '#modal-id-'+id+' #load' ).fadeIn(\"fast\");
    	var copia = $( \"#inputCopia\" ).val();
        $( '#modal-id-'+id+' #result' ).load( \"enviar_recibo.php?nome_empresa=\"+empresa+\"&data=\"+data+\"&valor=\"+valor+\"&email=\"+email+\"&recibo=01\", function(){
        	$( '#modal-id-'+id+' #load' ).stop().stop().fadeOut(\"fast\");
        	$( '#modal-id-'+id+' #result' ).stop().stop().fadeIn(\"fast\");
        });
    }

</script>
";

 $output.="	<thead>
				<tr>
					<th><input type='checkbox' value='' id='chk_all_head' name='chk_all_head' onclick='get_head_val(this.value)' /></th>
					<th>Notificar <sup><abbr title='Envia um e-mail ao usuário notificando sobre a mudança de status.'>(?)</abbr></sup></th>
					<th>Nome</th>
					<th>E-mail</th>      
					<th>Função</th>      
					<th>Data de cadastro</th>
					<th>Status</th>
					<th>Desde</th>
					<th>At&eacute;</th>
					<th>A&ccedil;&atilde;o</th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<th><input type='checkbox' value='' id='chk_all_foot' name='chk_all_foot' onclick='get_foot_val(this.value)' /></th>
					<th>Notificar <sup><abbr title='Envia um e-mail ao usuário notificando sobre a mudança de status.'>(?)</abbr></sup></th>
					<th>Nome</th>
					<th>E-mail</th>      
					<th>Função</th>      
					<th>Data de cadastro</th>
					<th>Status</th>
					<th>Desde</th>
					<th>At&eacute;</th>
					<th>A&ccedil;&atilde;o</th>
				</tr>
			</tfoot>";
if($intUserCount > 0){
 foreach($arrUserDetails as $key=>$users){
  $user_array = $wpdb->get_row('select status,status_from,status_to from '.$table.' where user_id='.$users->ID);
    $user_b = new WP_User( $users->ID );
  if($user_b->roles[0] == 'representante'){
  	$id_rp="<tr class=\"representante_user\">";
  	$nomeU = "<a title=\"Enviar boleto\" href='" . admin_url( "/user-edit.php?user_id=".$users->ID."&wp_http_referer=%2Fasug%2Fwp-admin%2Fusers.php#boleto") . "'>".ucwords($users->display_name)."</a>";
  	$emailU = "<a title=\"Enviar boleto\" href='" . admin_url( "/user-edit.php?user_id=".$users->ID."&wp_http_referer=%2Fasug%2Fwp-admin%2Fusers.php#boleto") . "'>".$users->user_email."</a>";
  } else {
  	$id_rp="<tr class=\"user_normal\">";
  	$nomeU = ucwords($users->display_name);
  	$emailU = $users->user_email;
  	$idU = $users->id;
  }
  $funcao = obterItem( 'funcoes', funcaoDesteUsuario( $user_b ) );
  // Pula empresas
  if ( $funcao == 'Empresa' )
	continue;
		$output.=$id_rp;
			$output.="<td><input type='checkbox' id='chk_user".$users->ID."' name='chk_user[]' style='margin:1px 0 0 8px;' onclick='hide_select_all()' value='".$users->ID."' /></td>";
			$output.="<td><input type='checkbox' id='notify".$users->ID."' name='notify[]' style='margin:1px 0 0 8px;' value='".$users->ID."' /></td>";
			$output.="<td>".$nomeU."</td>";
			$output.="<td>".$emailU."</td>";
			$output.="<td>".$funcao."</td>";
			$output.="<td>".$users->user_registered."</td>";
			$output.="<td><select id='set_user_status_".$key."' onchange='dataAut(".$key.")'>";
				if ( $user_array->status === null || $user_array->status === '' )
					$output.="<option value='' selected='selected'>N/D</option>";
				$output.="<option value='0'" . ( $user_array->status == '0' ? " selected='selected'" : '' ) . ">Ativo</option>";
				$output.="<option value='2'" . ( $user_array->status == '2' ? " selected='selected'" : '' ) . ">Degusta&ccedil;&atilde;o</option>";
				$output.="<option value='1'" . ( $user_array->status == '1' ? " selected='selected'" : '' ) . ">Inativo</option>";
			$output.="</select></td>";
			$output.="<td><input type='text' id='txt_from_date_".$key."' name='txt_from_date[]' value='".$user_array->status_from."' class='from_date'" . ( $user_array->status == '1' ? ' disabled' : '' ) . "></td>";
			$output.="<td><input type='text' id='txt_to_date_".$key."' name='txt_to_date[]' value='".$user_array->status_to."' class='to_date'" . ( $user_array->status == '1' ? ' disabled' : '' ) . "></td>";
			if($user_b->roles[0] == 'representante'){
			$output.="<td>
			<a class=\"btn btn-primary\" data-toggle=\"modal\" href='#modal-id-".$users->id."'>Enviar recibo</a>
			
			<div class=\"modal fade\" id=\"modal-id-".$users->id."\">
				<div class=\"modal-dialog\">
					<div class=\"modal-content\">
						<div class=\"modal-body\">
							<form role=\"form\" class=\"contact_".$users->id."\" method=\"post\">

						<table class=\"table table-striped table-hover\">
							<thead>
								<tr>
									<th>Nome da empresa</th>
									<th>Data do recibo</th>
									<th>Valor</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type=\"text\" name=\"inputNome_empresa_".$users->id."\" id=\"inputNome_empresa_".$users->id."\" class=\"form-control\" value=\"\" required=\"required\" pattern=\"\" title=\"\"></td>
									<td><input type=\"date\" name=\"data\" id=\"inputData_".$users->id."\" class=\"form-control\" value=\"".date('d/m/Y')."\" required=\"required\" title=\"\"></td>
									<td><input type=\"text\" name=\"valor\" id=\"inputValor_".$users->id."\" class=\"form-control\" data-symbol=\"R$ \" data-thousands=\".\" data-decimal=\",\"></td>

								</tr>
							</tbody>
						</table>
							
						</div>
						<div class=\"modal-footer\">
							<input type=\"hidden\" name=\"email\" id=\"email_".$users->id."\" value='".$users->user_email."'>
							<div id=\"load\" style=\"display: none\"></div>
							<div id=\"result\"></div>
							<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Fechar</button>
							<button type=\"button\" class=\"btn btn-primary\" id=\"EnviarEmailRecibo\" onclick=\"reciboEmail('".$users->id."')\">Enviar</button>
						</div>
						</form>
					</div><!-- /.modal-content -->
				</div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			
			</td>";

			 }

		

		$output.="</tr>";
 }
}
else{
	$output.="<tr>
				<td colspan='6' align='center'><b>Nenhum usu&aacute;rio encontrado.</b></td>
	         </tr>";
}
 $output.="</table>";
 $output.="<input type='hidden' value='".$url."' id='site_url' />";
 $output.="<input type='hidden' value='' name='hidden_operation' id='hidden_operation' />";
 $output.="<input type='button' class='button-primary' name='save_selected' id='save_selected' value='Salvar' style='margin:5px 5px 0 0;' onclick=\"jQuery('#hidden_operation').val('save');return operation_ids()\" />";
 $output.="</form>";

 $output.="

<style type=\"text/css\">
#load {
	background-image: url('". get_bloginfo('template_directory')."/images/ajax-loader.gif');
	background-repeat: no-repeat;
	background-position: center center;
	width: 100%;
	height: 28px;
	overflow: hidden;
	margin: 0 auto;
	display: block;
}
#result{
	width: 100%;
	height: 28px;
	overflow: hidden;
	margin: 0 auto;
	display: block;
	text-align: center;
	float: left;
}
</style>";
 
  // grab the current query parameters
 /*$query_string = $_SERVER['QUERY_STRING'];

 // The $base variable stores the complete URL to our page, including the current page arg

 // if in the admin, your base should be the admin URL + your page
 $base = admin_url('admin.php?page=USM/start.php') . '&' . remove_query_arg('p', $query_string) . '%_%';
 
 $output.= paginate_links( array(
    'base' => $base, // the base URL, including query arg
    'format' => '&p=%#%', // this defines the query parameter that will be used, in this case "p"
    'prev_text' => __('&laquo; Previous'), // text for previous page
    'next_text' => __('Next &raquo;'), // text for next page
    'total' => $total_pages, // the total number of pages we have
    'current' => $page, // the current page
    'end_size' => 1,
    'mid_size' => 5,
 ));*/
 echo $output;
 
 function fnSetArgument($intOffset = 0)
 {
 	$strSearch = $_REQUEST['strUserSearch'];
 	 if ( $strSearch ) {
		$args = array(
			'search'         => "*".$strSearch."*",
			'search_columns' => array( 'user_login', 'user_email' ),
			'orderby' => 'registered',
			'order' => 'DESC',
			'offset' =>	$intOffset		
		);
	 }
	 else{
	 	$args = array(
			'orderby' => 'registered',
			'order' => 'DESC',
			'offset' => $intOffset
		);
	 }
	 return $args;
 }