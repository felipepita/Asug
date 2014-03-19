<?php
/*
 * Teste de login no sistema da SAP
 * Desenvolvido pela MontarSite - www.montarsite.com.br - 2014
 */

 
 
$resposta = array(
	'status' => 0,
	'mensagem' => '',
);



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
		
		// Configurações do servidor
		$company = 'acevff';
		$secret_key = 'a';
		$tklogin_key = 'b';
		$pm_actstr = '';
		
		// Hora e hash (tem que ser em ISO-8859-1)
		$expire = date( 'Y-m-d\\TH:i:s' );
		$tz = '';
		$callerhash = md5( $username . $expire . $tklogin_key . $secret_key );
		
		// Monta a requisição
		
		// https://salesdemo4.successfactors.com/login?_s.crb=mj"%"252fKaDgtraE9nqABY5BiKZQ2NpA"%"253d&company=acevff&username=cgrant&password=demo101&passwordHints=Senha&fragment=&flash=&fragment=
		
		$args = array(
			'company' => $company,
			'username' => $username,
			'password' => $password,
			'tklogin_key' => $tklogin_key,
			//'pm_actstr' => $pm_actstr,
			'callerhash' => $callerhash,
			'expire' => $expire,
			//'tz' => $tz,
		);
		
		$query = http_build_query( $args );
		//$login_url = 'https://performancemanager.successfactors.com/login?' . $query;
		$login_url = 'https://salesdemo4.successfactors.com/login?' . $query;
		
		// Envia
		
		$curl = curl_init( $login_url );
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($curl, CURLOPT_POST, 1);
		curl_setopt($curl, CURLOPT_POSTFIELDS, $query);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
		
		$retorno = curl_exec($curl);
		curl_close($curl);
		
		// Verifica a resposta

		$resposta['mensagem'] .= $retorno;
	
	} while ( 0 );


} else {

	// Não há nada postado
	$reposta['mensagem'] .= "Por favor, preencha os dados de login.";

}



// Retorna a resposta do processamento para o navegador

$resposta['mensagem'] = trim( $resposta['mensagem'] );
print json_encode( $resposta );
exit();
