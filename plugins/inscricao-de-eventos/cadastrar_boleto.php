<?php
require($_SERVER['DOCUMENT_ROOT']. '/asug/wp-blog-header.php');
global $wpdb;
global $user;


$id_user_input = $_POST['id_user_input'];

$boleto_input = $_POST['boleto_input'];

//echo $id_user_input . "<br/>";
//echo $boleto_input . "<br/>";

$id_do_usuario = explode(",", $id_user_input);
$boleto_do_usuario = explode(",", $boleto_input);


for($i=0;$i<count($id_do_usuario);$i++){
	//echo $id_do_usuario[$i] . " - " . $boleto_do_usuario[$i] . "<br>";
	$id_atual = $id_do_usuario[$i];
	//Confere se ja possui boleto no ID
	$consulta_boleto = $wpdb->get_results("SELECT * FROM wp_cadastro_eventos WHERE id = $id_atual");

	foreach ( $consulta_boleto as $dados ){
			$wpdb->query("UPDATE wp_cadastro_eventos SET boleto = '".$boleto_do_usuario[$i]."' WHERE id = $id_atual");
			echo "UPDATE wp_cadastro_eventos SET boleto = '".$boleto_do_usuario[$i]."' WHERE id = $id_atual";
	}
}

?>