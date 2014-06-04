<?php
require($_SERVER['DOCUMENT_ROOT']. '/asug/wp-blog-header.php');
global $wpdb;
global $user;

$id_post	=	$_GET['id_post'];
$titulo	=	$_GET['titulo'];
?>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>$titulo</title>
</head>
<body>
	


<?php
$resultado_users = $wpdb->get_results("SELECT * FROM wp_cadastro_eventos WHERE id_post = $id_post");

$file_ending = "xls";

header("Content-Disposition: attachment; filename=$titulo.xls");
header("Content-Type: application/xls; charset=ISO-8859-1",true);
header("Pragma: no-cache");
header("Expires: 0");

$sep = "\t"; //tabbed character

$lista = "<table class=\"table table-condensed table-hove pqnaTable\" border=\"1\">
<tr>
	<td><b>Nome</b></td>
	<td><b>Empresa</b></td>
	<td><b>E-mail</b></td>
	<td><b>Telefone</b></td>
	<td><b>Celular</b></td>
	<td><b>Perfil</b></td>
	<td><b>Cargo</b></td>
	<td><b>Dt de inscrição</b></td>
	<td><b>Aprovar</b></td>
	<td><b>Boleto</b></td>
</tr>";
    foreach ( $resultado_users as $dados ){
    	if ($dados->status==false){
    		$status = "Inativo";
    	}
    	if ($dados->status==true){
    		$status = "Ativo";
    	}

	$lista .= "<tr>";
		$lista .= "<td>" . $dados->nome . "</td>";
		$lista .= "<td>" . $dados->empresa . "</td>";
		$lista .= "<td>" . $dados->email . "</td>";
		$lista .= "<td>" . $dados->telefone . "</td>";
		$lista .= "<td>" . $dados->celular . "</td>";
		$lista .= "<td>" . $dados->perfil . "</td>";
		$lista .= "<td>" . $dados->cargo . "</td>";
		$lista .= "<td>" . $dados->data_de_inscricao . "</td>";
		$lista .= "<td>" . $status . "</td>";
		$lista .= "<td>" . $dados->boleto . "</td>";
	$lista .= "</tr>";
}
$lista .= "</table>";

    echo $lista;

 ?>
</body>
</html>