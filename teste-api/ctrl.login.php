<?php
/*
 * Teste de login no sistema da SAP
 * Desenvolvido pela MontarSite - www.montarsite.com.br - 2014
 */

 
 
// Config

$usarBase64 = true; // encripta o usuário
$company = 'ace4u8'; // instância / antigo: 'acevff'
$secret_key = 'asug'; // key
$tklogin_key = 'novoportal'; // token
$pm_actstr = ''; // nome da tela a ser aberta no aplicativo remoto
$tz = ''; // time zone

$resposta = array(
	'status' => 0,
	'mensagem' => '',
	'login_url' => '',
);



// Processamento

if ( !empty( $_POST ) ) {

	do {

		// Dados postados
		$username = substr( trim( $_POST['username'] ), 0, 64 );
		$password = substr( trim( $_POST['password'] ), 0, 64 );
		
		// Verificação
		if ( !$username || !$password ) {
			$resposta['mensagem'] .= "Por favor, preencha os dados de login.\n";
			break;
		}
		
		// Hora e hash (tem que ser em ISO-8859-1)
		$expire = date( 'Y-m-d\\TH:i:s' ); // , strtotime( '2014-03-20T23:24:18' )
		
		if ( $usarBase64 ) {
			$username = base64_encode( $username );
			$username = str_replace(
				array( '+', '/', '=' ),
				array( '.', '_', '-' ),
				$username
			);
			$password = ''; // não utilizado nessa modalidade
			$callerhash = md5( $username . $expire . $secret_key );
		} else {
			$callerhash = md5( $username . $expire . $tklogin_key . $secret_key );
		}
		
		// Monta a requisição
		
		$args = array_filter( array(
			'company' => $company,
			'username' => $username,
			'password' => $password,
			'tklogin_key' => $tklogin_key,
			'pm_actstr' => $pm_actstr,
			'callerhash' => $callerhash,
			'expire' => $expire,
			'tz' => $tz,
		) );
		
		$query = http_build_query( $args );
		// https://salesdemo4.successfactors.com/login?_s.crb=mj"%"252fKaDgtraE9nqABY5BiKZQ2NpA"%"253d&company=acevff&username=cgrant&password=demo101&passwordHints=Senha&fragment=&flash=&fragment=
		// $login_url = 'https://performancemanager.successfactors.com/login?' . $query;
		$login_url = 'https://salesdemo4.successfactors.com/login?' . $query;
		
		//$resposta['mensagem'] .= $login_url . "\n\n";
		
		// Envia
		
		/*
		$curl = curl_init( $login_url );
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($curl, CURLOPT_POST, 1);
		curl_setopt($curl, CURLOPT_POSTFIELDS, $query);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
		$retorno = curl_exec($curl);
		curl_close($curl);
		*/
		
		//$retorno = fopen( $login_url, 'r' );
		$stream = @fopen( $login_url, 'r' );
		
		// Verifica a resposta
		
		if ( isset( $http_response_header ) )
			$retorno = implode( "\n", $http_response_header );
		
		if ( $stream === false ) {
			$resposta['mensagem'] .= "Não foi possível contactar o servidor para autenticação.\n";
		} elseif ( strpos( $http_response_header[0], '302' ) !== false ) {
			// X-SAP-Page-Info
			$resposta['mensagem'] .= "Suas credenciais foram aceitas.\nPor favor aguarde enquanto seu sistema é autenticado...";
			$resposta['status'] = 1;
			$resposta['login_url'] = $login_url;
		} else {
			$resposta['mensagem'] .= "Dados cadastrais inexistentes.";
			//$resposta['mensagem'] .= "$login_url\n\n";
			//$resposta['mensagem'] .= htmlentities( $retorno, ENT_QUOTES );
		}
		
		fclose( $stream );
	
	} while ( 0 );


} else {

	// Não há nada postado
	$resposta['mensagem'] .= "Por favor, preencha os dados de login.";

}



// Retorna a resposta do processamento para o navegador

$resposta['mensagem'] = nl2br( trim( $resposta['mensagem'] ) );
print json_encode( $resposta );
exit();
