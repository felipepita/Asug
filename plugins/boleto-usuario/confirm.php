<?php 
require($_SERVER['DOCUMENT_ROOT']. '/asug/wp-blog-header.php');
global $wpdb;
global $user;
$ip = $_SERVER['REMOTE_ADDR'];
$browser = $_SERVER['HTTP_USER_AGENT'];

$email = $_GET['email'];
$link = $_GET['link'];
$date = date('d/m/Y H:i:s');

	$headers = "From: Financeiro <financeiro@asug.com.br>" . "\n";
	$headers .= "MIME-Version: 1.0" . "\n";
	$headers .= "Content-type: text/html\r\n";

$content = "<b>Ip que abriu o link:</b><br/>" . $ip . "<br/><br/>";
$content .= "<b>Email em que o boleto foi enviado: </b><br />" . $email ."<br /><br/>";
$content .= "<b>Data que foi aberto:</b><br/>" . $date . "<br/><br/>";
$content .= "<b>Navegador: </b><br/>" . $browser . "<br/><br/>";
$content .= "<b>Link:</b><br/>" . $link . "<br/><br/>";

wp_mail(get_option('admin_email'), "Boleto aberto - ". $email, $content, $headers);

header('Content-type: application/pdf');
readfile($link);

?>