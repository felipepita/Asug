<?php /*
Plugin Name: Inscrição em eventos
Plugin URI: http://montarsite.com.br
Description: Inscrição de usuarios em eventos
Version: 1.0
Author: MontarSite
Author URI: http://montarsite.com.br
License: GPLv2
*/
global $wpdb;
global $user;
$errors         = array();  	// array to hold validation errors
$data 			= array(); 		// array to pass back data
$id_post	=	$_POST['id_post'];
$id_usuario	=	$_POST['id_usuario'];
$nome	=	$_POST['nome'];
$empresa	=	$_POST['empresa'];
$email	=	$_POST['email'];
$telefone	=	$_POST['telefone'];
$celular	=	$_POST['celular'];
$endereco	=	$_POST['endereco'];
$perfil	=	$_POST['perfil'];
$cargo	=	$_POST['cargo'];
if (empty($id_post)){	$errors['id_post'] = 'ID do POST necessário.'; }
if (empty($id_usuario)){	$errors['id_usuario'] = 'ID do usuário necessário.'; }
if (empty($nome)){	$errors['nome'] = 'nome necessário.'; }
if (empty($empresa)){	$errors['empresa'] = 'Empresa necessário.'; }
if (empty($email)){	$errors['email'] = 'E-mail necessário.'; }
if (empty($telefone)){	$errors['telefone'] = 'Telefone necessário.'; }
if (empty($celular)){	$errors['celular'] = 'Celular necessário.'; }
if (empty($endereco)){	$errors['endereco'] = 'Endereço necessário.'; }
if (empty($perfil)){	$errors['perfil'] = 'PERFIL necessário.'; }
if (empty($cargo)){	$errors['cargo'] = 'Cargo necessário.'; }
if ( ! empty($errors)) {
		// if there are items in our errors array, return those errors
	$data['success'] = false;
	$data['errors']  = $errors;
} else {
	require($_SERVER['DOCUMENT_ROOT']. '/asug/wp-blog-header.php');
	$data['success'] = true;
	$data['message'] = 'Cadastro enviado para a ASUG com sucesso! <br /> Seu cadastro será analisado, aguarde contato em seu e-mail.';
	$wpdb->insert( "wp_cadastro_eventos", array(
		'id' => '',
		'id_post' => $id_post,
		'id_usuario' => $id_usuario,
		'nome' => $nome,
		'empresa' => $empresa,
		'email' => $email,
		'telefone' => $telefone,
		'celular' => $celular,
		'endereco' => $endereco,
		'perfil' => $perfil,
		'cargo' => $cargo,
		'data_de_inscricao' => date('d/m/Y H:i:s'),
		'status' => '0',
		'boleto' => ''
		));
	echo json_encode($data);
	exit();
}
function gerenciamento_inscricoes() {
	add_menu_page( 'Inscritos nos eventos', 'Inscritos', 'manage_options', 'lista-de-incritos', 'incritos_options');
}
function qtde_incritos($id_post) {
	global $wpdb;
	$resultado = $wpdb->get_var("SELECT COUNT(*) FROM wp_cadastro_eventos WHERE id_post = $id_post");
	return  $resultado;
}
function listar_todos($id_post){
	global $wpdb;
	$resultado_users = $wpdb->get_results("SELECT * FROM wp_cadastro_eventos WHERE id_post = $id_post");
	$lista = "<form><table class=\"table table-condensed table-hove pqnaTable\">
<div class=\"btn-group\">
    <a href=\"#\" class=\"BTinativos btn btn-primary active\">Inativos</a>
    <a href=\"#\" class=\"BTativos btn btn-primary\">Ativos</a>
    <a href=\"#\" class=\"BTtodos btn btn-primary\">Todos</a>
</div>

	<tr>
	<td><b>Nome</b></td>
	<td><b>Empresa</b></td>
	<td><b>E-mail</b></td>
	<td><b>Telefone / Celular</b></td>
	<td><b>Dt de inscrição</b></td>
	<td><b>Aprovar</b></td>
	<td><b>Boleto</b></td>
	</tr>";
	foreach ( $resultado_users as $dados ){
		if ($dados->status==false){
			$status = "<button onclick=\"mudarStatus('".$dados->id."');\" id=\"".$dados->id."\" type=\"button\" class=\"btn statusI glyphicon glyphicon-remove btn-danger\">";
			$classe = "btn-danger";
			$classeAouI = "inativo";
		}
		if ($dados->status==true){
			$status = "<button onclick=\"mudarStatus('".$dados->id."');\" id=\"".$dados->id."\" type=\"button\" class=\"btn statusI glyphicon glyphicon-ok btn-success\">";
			$classe = "btn-success";
			$classeAouI = "ativo";
		}
		$lista .= "<tr class=\"".$classeAouI."\">";
		$lista .= "<td>" . $dados->nome . "<br /><em>". $dados->perfil ."</em></td>";
		$lista .= "<td>" . $dados->empresa . "</td>";
		$lista .= "<td>" . $dados->email . "</td>";
		$lista .= "<td>Tel: " . $dados->telefone . "<br />Cel: ". $dados->celular . "</td>";
		$lista .= "<td>" . $dados->data_de_inscricao . "</td>";
		$lista .= "<td>" . $status . "</td>";
		$lista .= "<td>
		<input id=\"upload_pdf_".$dados->id."\" type=\"text\" size=\"36\" value=\"".$dados->boleto."\" name=\"upload_pdf_".$dados->id."\" class=\"upload_pdf_button upload_pdf_button[".$dados->id."]\" value=\"\" />
		<input id=\"upload_pdf_button\" type=\"button\" value=\"+\" class=\"btn glyphicon glyphicon-barcode upload_pdf_button\" />
		</td>";
		$lista .= "</tr>";
	}
	$lista .= "</table></form>
	            </div>
            <div class=\"modal-footer\">
                <button type=\"button\" class=\"btn btn-success SalvarBoleto\">Salvar boletos</button>
                <button type=\"button\" class=\"btn btn-primary\" data-dismiss=\"modal\">Fechar</button>
            </div>";

	return $lista;
}
if (isset($_GET['page']) && $_GET['page'] == 'my_plugin_page') {
	add_action('admin_print_scripts', 'my_admin_scripts');
	add_action('admin_print_styles', 'my_admin_styles');
}
function incritos_options() {
	include plugin_dir_path( __FILE__ ) . 'templates/options.php';
}
add_action('admin_menu', 'gerenciamento_inscricoes');
?>