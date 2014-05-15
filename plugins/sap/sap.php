<?php
/*
Plugin Name: Sincronizador de Dados SAP
Plugin URI: http://montarsite.com.br
Description: Sincroniza os usuários do WordPress com uma base externa da SAP.
Version: 1.0
Author: MontarSite
Author URI: http://montarsite.com.br
License: Copyright. Todos os direitos reservados.
*/



// Inicialização

$sap_config = array();
$sap_mensagens = array();
$sap_erros = array();
$sap_caminho = trailingslashit( dirname(__FILE__) );
$sap_log_dir = 'wp-content/uploads/logs/sap/';
$sap_log_caminho = trailingslashit( ABSPATH ) . $sap_log_dir;
$sap_log_url = trailingslashit( home_url( $sap_log_dir ) );
$sap_log_arquivo = 'sap_%s.log';

function sap_ativarPlugin() {
	// Roda na ativação
	global $sap_log_caminho;
	if ( !file_exists( $sap_log_caminho ) )
		mkdir( $sap_log_caminho, umask(), true );
}

register_activation_hook( __FILE__, 'sap_ativarPlugin' );

function sap_init() {
	// Inicializa o plugin
}

//	add_action('init', 'sap_init');



// Configurações

function sap_carregarConfig( $recarregar = false ) {
	// Carrega as opções de configuração do BD
	global $sap_config;
	if ( !$recarregar && $sap_config )
		// Já foi previamente carregado
		return $sap_config;
	$opcoes = array(
		'ultima_sinc',
		'servidor',
		'company',
		'username',
		'password',
		'login_valido',
		'chave_auth',
		'logar',
	);
	foreach ( $opcoes as $chave )
		$sap_config[ $chave ] = get_option( 'sap_' . $chave );
	return $sap_config;
}

function sap_salvarOpcao( $nome, $valor = false ) {
	// Salva uma opção no BD e também altera o config que já foi carregado
	global $sap_config;
	update_option( 'sap_' . $nome, $valor );
	if ( $sap_config )
		$sap_config[ $nome ] = $valor;
}



// Logger

function sap_log( $info ) {
	// Grava alguma informação no log do dia
	global $sap_log_caminho, $sap_log_arquivo;
	$config = sap_carregarConfig();
	if ( !$config['logar'] )
		return false;
	$arquivo_hoje = $sap_log_caminho . sprintf( $sap_log_arquivo, date( 'Y-m-d' ) );
	$log = fopen( $arquivo_hoje, 'a' );
	if ( !$log )
		return false;
	fwrite( $log, '[' . date( 'h:i' ) . ']' . PHP_EOL );
	fwrite( $log, trim( $info ) );
	fwrite( $log, PHP_EOL . PHP_EOL );
	fclose( $log );
	return true;
}



// Painel Admin

function sap_criarMenu() {
	// Cria o item no menu do admin
	$painel_admin = 'sap';
	add_submenu_page( 'tools.php', 'Sincronizador de Dados SAP', 'Sincronizador SAP', 10, $painel_admin, 'sap_renderizarPainelAdmin' );
}

function sap_renderizarPainelAdmin() {
	// Renderiza o painel no admin
	global $sap_config, $sap_caminho, $sap_mensagens, $sap_erros, $sap_log_caminho, $sap_log_url, $sap_log_arquivo;
	sap_carregarConfig();
	sap_controladorPainelAdmin();
	require $sap_caminho . 'painel-admin.php';
}

add_action('admin_menu', 'sap_criarMenu');

function sap_controladorPainelAdmin() {
	// Processa dados enviados pelo painel do admin
	global $sap_config, $sap_caminho, $sap_mensagens, $sap_erros;
	if ( !empty( $_POST ) )
		require $sap_caminho . 'ctrl.painel-admin.php';
}

//add_action('parse_request', 'sap_controladorPainelAdmin');



// Integração - Funções de Baixo Nível

function codigoHttp( $header ) {
	// Extrai o código HTTP de um header
	// @retorna array( $codigo, $mensagem )
	if ( is_array( $header ) )
		$header = $header[0];
	if ( !is_string( $header ) )
		return array(
			0,
			'Undefined'
		);
	preg_match( '/^HTTP\/\d+(?:\.\d+)? (\d+) (.+?)$/', $header, $matches );
	if ( !$matches || count( $matches ) < 3 )
		return array(
			0,
			'Undefined'
		);
	return array(
		(int) $matches[1],
		$matches[2]
	);
}

function sap_gerarAutenticacao() {
	// Gera e retorna a chave de autenticação
	$config = sap_carregarConfig();
	if ( !$config['username'] || !$config['company'] || !$config['password'] )
		return '';
	$chave = base64_encode( "$config[username]@$config[company]:$config[password]" );
	return $chave;
}

function sap_enviarRequisicao( $uri, $metodo = 'GET', $conteudo = '' ) {

	// Envia uma requisição para o servidor da SAP
	
	// Definições
	$config = sap_carregarConfig();
	$respostaFalha = array(
		'codigo' => array( 401, 'Unauthorized' ),
		'header' => array(),
		'conteudo' => '',
		'status' => 0,
	);
	
	// Autenticação inválida
	if ( !$config['chave_auth'] || !$config['login_valido'] )
		return $respostaFalha;
		
	// URL
	$uri = preg_replace( '#^/#', '', $uri );
	$url = $config['servidor'] . 'odata/v2/' . $uri;
	
	// Header
	$header = 'Authorization: Basic ' . $config['chave_auth'] . PHP_EOL
			. 'Accept: application/json' . PHP_EOL
	;
	
	// Conteúdo
	if ( $conteudo ) {
		$header .= 'Content-type: application/json';
		$conteudo = json_encode( $conteudo );
	}
	
	// Contexto
	$contexto = stream_context_create( array(
		'http' => array(
			'method' => $metodo,
			'header' => $header,
			'content' => $conteudo,
		)
	) );
	
	// Atualiza a última sincronização
	update_option( 'sap_ultima_sinc', time() );
	
	// Log da requisição
	sap_log(
		'Requisição' . PHP_EOL .
		$metodo . ' /' . $uri . PHP_EOL .
		( $conteudo ? 'Dados: ' . $conteudo : '' )
	);
	
	// Requisição
	$stream = @fopen( $url, 'r', false, $contexto );
	
	// Resposta
	$resposta = array(
		'codigo' => codigoHttp( $http_response_header[0] ),
		'header' => $http_response_header,
		'conteudo' => $stream
			? json_decode( stream_get_contents( $stream ), true )
			: ''
		,
	);
	$resposta['status'] = $resposta['codigo'][0] >= 200 && $resposta['codigo'][0] < 300
		? 1
		: 0
	;
	
	// Log da resposta
	sap_log(
		'Resposta' . PHP_EOL .
		$resposta['codigo'][0] . ' ' . $resposta['codigo'][1] . PHP_EOL .
		'Dados: ' . stream_get_contents( $stream )
	);
	
	// Fim
	return $resposta;
	
}



// Integração - Funções de Alto Nível


function sap_testar() {
	// Testa a conexão com o servidor da SAP, salva o resultado no BD e adiciona uma mensagem
	global $sap_config, $sap_mensagens, $sap_erros;
	sap_carregarConfig();
	// Torna válido temporariamente para poder testar
	$sap_config['login_valido'] = 1;
	$resposta = sap_enviarRequisicao('');
	sap_salvarOpcao( 'login_valido', $resposta['status'] );
	if ( $resposta['status'] ) {
		$sap_mensagens[] = 'A configuração de autenticação foi validada com sucesso!';
		sap_log( 'Teste de conexão bem sucedido.' );
	} else {
		$sap_erros[] = 'Essa configuração de autenticação é inválida.';
		sap_log( 'Teste de conexão falhou.' );
	}
	return $resposta['status'];
}

function sap_sincronizarUsuario( $user ) {

	// Envia os dados do usuário para o servidor e retorna o status da operação
	// @retorna 0 = falha; 1 = criado; 2 = atualizado; 3 = outro
	
	// Gera o corpo da requisição
	$conteudo = array(
		array(
			'__metadata'		=> array(
				'uri'			=> "User('$user[user_nicename]')"
			),
			'USERID'			=> $user['ID'],
			'USERNAME'			=> $user['user_nicename'],
			'FIRSTNAME'			=> $user['firstname'],
			'LASTNAME'			=> $user['lastname'],
			'EMAIL'				=> $user['user_email'],
			'GENDER'			=> $user['sexo'] == 1
				? 'F'
				: 'M'
			,
			'HR'				=> $user['admin_id'],
			'MANAGER'			=> $user['rep1_id'],
			'TIMEZONE'			=> 'GMT',
		),
	);
	
	// Envia
	$resposta = sap_enviarRequisicao( 'upsert', 'POST', $conteudo );
	
	// Analisa a resposta do servidor
	$status = 0;
	if ( $resposta['status'] && $resposta['conteudo'] ) {
		$status_operacao = $reposta['conteudo']['d'][0]['editStatus'];
		if ( $status_operacao == 'INSERTED' )
			$status = 1;
		elseif ( $status_operacao == 'UPDATED' )
			$status = 2;
		else
			$status = 3;
	}
	
	// Log
	sap_log(
		"Sincronização do usuário #$user[ID] $user[user_nicename] "
		. ( $status ? 'bem sucedida.' : 'falhou.' )
	);
	
	// Fim
	return $status;
	
}



// Integração - Hooks

