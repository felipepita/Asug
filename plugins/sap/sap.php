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
		@mkdir( $sap_log_caminho, umask(), true );
}

register_activation_hook( __FILE__, 'sap_ativarPlugin' );

$sap_relacaoCamposPara = null;
$sap_traduzirValores = array(
	'empresa_tipo_associacao'	=> array(
		'1' => 'Cliente',
		'2' => 'Cliente',
		'3' => 'Parceiro',
		'4' => 'Parceiro',
		'5' => 'Convidado',
		'6' => 'Consultor SAP',
	),
	'sexo'						=> array(
		'M' => 'M',
		'F' => 'F',
	),
);

function sap_init() {

	// Inicializa o plugin
	global $sap_relacaoCamposPara;
	
	// Correspondência dos campos no SAP e no Portal ASUG
	// @requer relacionar

	$sap_relacaoCamposPara = relacionar( array(
		// array( 'status', 'status' ),
		array( 'userId', 'ID' ),
		array( 'username', 'user_login' ),
		array( 'firstName', 'first_name' ),
		// array( 'mi', 'middle_name' ),
		array( 'lastName', 'last_name' ),
		// array( 'gender', 'sexo' ),
		array( 'email', 'user_email' ),
		// array( 'manager', 'representante1' ),
		// array( 'hr', 'admin' ),
		array( 'department', 'nivel_cargo' ),
		array( 'jobCode', 'cargo' ),
		array( 'division', 'empresa_nome' ),
		// array( 'location', '' ),
		// array( 'timeZone', '' ),
		array( 'hireDate', 'user_registered' ),
		// array( 'empId', '' ),
		// array( 'title', 'capacitacao' ),
		array( 'businessPhone', 'telefone' ),
		array( 'fax', 'fax' ),
		array( 'addressLine1', 'endereco_completo' ),
		array( 'addressLine2', 'bairro' ),
		array( 'city', 'cidade' ),
		array( 'state', 'estado' ),
		array( 'zipCode', 'cep' ),
		// array( 'country', 'pais' ),
		// array( 'reviewFreq', '' ),
		// array( 'lastReviewDate', '' ),
		array( 'custom01', 'empresa_tipo_associacao' ),
		array( 'custom02', 'cargo_asug' ),
		array( 'custom03', 'ultima_atualizacao' ),
		// array( 'custom04', 'linkedin' ),
		// array( 'custom05', 'ramo' ), // industria
		// array( 'custom06', 'negocio' ),
		// array( 'custom07', 'solucao_sap' ),
		// array( 'custom08', 'representante1_telefone' ),
		// array( 'custom09', 'empresa_nome' ),
		// array( 'custom10', '' ),
		// array( 'custom11', '' ),
		// array( 'custom12', '' ),
		// array( 'custom13', '' ),
		// array( 'custom14', '' ),
		// array( 'custom15', '' ),
	), 'SAP', 'ASUG' );
	
}

add_action('init', 'sap_init');



// Configurações

function sap_carregarConfig( $recarregar = false ) {
	// Carrega as opções de configuração do BD
	// @requer ajustarFusoHorario
	global $sap_config;
	if ( !$recarregar && $sap_config )
		// Já foi previamente carregado
		return $sap_config;
	ajustarFusoHorario();
	$opcoes = array(
		'habilitado',
		'ultima_sinc',
		'servidor',
		'company',
		'username',
		'password',
		'login_valido',
		'chave_auth',
		'logar',
		'tklogin_key',
		'secret_key',
		//'pm_actstr',
		//'tz',
		'sso_valido',
		'sso_utilizavel',
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

function sap_arquivoLog() {
	// Retorna o nome do arquivo log de hoje
	global $sap_log_arquivo;
	return sprintf( $sap_log_arquivo, date( 'Y-m-d' ) );
}

function sap_log( $info ) {
	// Grava alguma informação no log do dia
	// @requer salvarLog
	global $sap_log_caminho;
	$sap_config = sap_carregarConfig();
	if ( !$sap_config['logar'] )
		return false;
	$arquivo_hoje = $sap_log_caminho . sap_arquivoLog();
	return salvarLog( $info, $arquivo_hoje );
}



// Painel Admin

function sap_criarMenu() {
	// Cria o item no menu do admin
	add_submenu_page(
		'tools.php',
		'Sincronizador de Dados SAP',
		'Sincronizador SAP',
		10,
		'sap',
		'sap_renderizarPainelAdmin'
	);
	// Cria a outra página utilizada na sincronização
	add_submenu_page(
		null,
		'Sincronizar Usuário',
		'Sincronizar Usuário',
		10,
		'sap_sincronizador',
		'sap_renderizarSincronizacao'
	);
}

add_action('admin_menu', 'sap_criarMenu');

function sap_renderizarPainelAdmin() {
	// Renderiza o painel no admin
	// @requer ajustarFusoHorario
	global $sap_config, $sap_caminho, $sap_mensagens, $sap_erros, $sap_log_caminho, $sap_log_url, $sap_log_arquivo;
	ajustarFusoHorario();
	sap_carregarConfig();
	sap_controladorPainelAdmin();
	require $sap_caminho . 'painel-admin.php';
}

function sap_controladorPainelAdmin() {
	// Processa dados enviados pelo painel do admin
	global $sap_config, $sap_caminho, $sap_mensagens, $sap_erros;
	if ( !empty( $_POST ) )
		require $sap_caminho . 'ctrl.painel-admin.php';
}

//add_action('parse_request', 'sap_controladorPainelAdmin');

function sap_renderizarSincronizacao() {
	// Renderiza a sincronização de usuário
	global $sap_config, $sap_mensagens, $sap_erros, $sap_caminho;
	sap_carregarConfig();
	require $sap_caminho . 'sincronizador.php';
}



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
	// @requer codigoHttp
	
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
			'ignore_errors' => true,
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
		'Dados: ' . json_encode( $resposta['conteudo'] )
	);
	
	// Fim
	if ( $stream )
		fclose( $stream );
	
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

function sap_sincronizarUsuario( $perfil ) {

	// Envia os dados do usuário, obtidos com perfilUsuario, para o servidor e retorna o status da operação
	// @requer obter, formatarTelefone
	// @retorna 0 = falha; 1 = criado; 2 = atualizado; 3 = outro.
	
	global $sap_relacaoCamposPara, $sap_traduzirValores, $listas;
	$sap_config = sap_carregarConfig();
	
	if ( !$sap_config['habilitado'] ) {
		return array(
			'codigo' => array( 000, 'Disabled' ),
			'header' => array(),
			'conteudo' => '',
			'status' => 0,
			'operacao' => 'DISABLED',
		);
	}
	
	if ( $perfil['funcao'] == FUNCAO_FUNCIONARIO ) {
		$rep1 = get_userdata( $perfil['representante1'] );
		$rep1_username = $rep1->display_name;
	} else {
		$rep1_username = $sap_config['username'];
	}
	
	$hr = $perfil['funcao'] == FUNCAO_ADMIN
		? 'NO_HR'
		: 'admin' // $sap_config[username] // asug@asug.com.br
	;
	
	// Dados especiais
	$dados = array(
		'__metadata'		=> array(
			'uri'				=> "User('$perfil[ID]')" // $perfil[user_email]
		),
		'hr'				=> array(
			'__metadata'		=> array(
				'uri'				=> "User('$hr')",
			),
		),
		'manager'			=> array(
			'__metadata'		=> array(
				'uri'				=>  "User('NO_MANAGER')", // $rep1_username
			),
		),
		'status'			=> $perfil['status'] ? 'Active' : 'Inactive',
		'location'			=> 'N/A',
		'timeZone'			=> 'GMT',
		'gender'			=> 'M',
		'country'			=> 'Brazil',
		// 'division'			=> 'ASUG',
		// Campos removidos
		'title'				=> '',
	);
	
	// Dados padronizados
	foreach ( $sap_relacaoCamposPara['SAP'] as $chaveSAP => $chaveASUG ) {
		$dados[ $chaveSAP ] = obter( $perfil, $chaveASUG, '' );
		if ( isset( $sap_traduzirValores[ $chaveASUG ] ) )
			$dados[ $chaveSAP ] = $sap_traduzirValores[ $chaveASUG ][ $dados[ $chaveSAP ] ];
		elseif ( isset( $listas[ $chaveASUG ] ) )
			$dados[ $chaveSAP ] = obterItem( $chaveASUG, $dados[ $chaveSAP ] );
	}
	
	// Converte data do WP
	$dados['hireDate'] = str_replace( ' ', 'T', $dados['hireDate'] );
	
	// Formata telefones
	$dados['businessPhone'] = formatarTelefone( $dados['businessPhone'] );
	$dados['fax'] = formatarTelefone( $dados['fax'] );
	
	// Formata CEP
	$dados['zipCode'] = formatarCEP( $dados['zipCode'] );
	
	// Formata última atualização
	$dados['custom03'] = date( 'd/m/Y', strtotime( $dados['custom03']) );
	
	// Verifica falta de dados obrigatórios (como no caso de um admin)
	if ( !$dados['gender'] )
		$dados['gender'] = 'M';
	if ( !$dados['jobCode'] )
		$dados['jobCode'] = $perfil['funcao'] == FUNCAO_ADMIN
			? 'Administrador'
			: 'Associado'
		;
	if ( !$dados['firstName'] )
		$dados['firstName'] = $perfil['user_login'];
	if ( !$dados['lastName'] )
		$dados['lastName'] = $perfil['user_login'];
	if ( !$dados['department'] )
		$dados['department'] = 'Administrativo';
	if ( !$dados['custom02'] )
		$dados['custom02'] = 'Associado';
	if ( !$dados['division'] )
		$dados['division'] = 'ASUG Brasil';
	
	// return $dados;
	
	// Gera o corpo da requisição
	$conteudo = array( $dados );
	
	// Envia
	$resposta = sap_enviarRequisicao( 'upsert', 'POST', $conteudo );
	
	// Analisa a resposta do servidor
	$status = 0;
	if ( $resposta['status'] && $resposta['conteudo'] ) {
		$status_operacao = $resposta['conteudo']['d'][0]['editStatus'];
		$status_condicao = $resposta['conteudo']['d'][0]['status'] == 'OK'
			? 1
			: 0
		;
		$resposta['status'] = $status_condicao;
		$resposta['operacao'] = $status_operacao;
		$resposta['mensagem'] = $resposta['conteudo']['d'][0]['message'];
		if ( $status_operacao == 'INSERTED' )
			$status = 1;
		elseif ( $status_operacao == 'UPDATED' )
			$status = 2;
	}
	
	// Atualiza o meta do usuário
	update_user_meta( $perfil['ID'], 'sap_ultima_sinc', time() );
	
	// Log
	sap_log(
		"Sincronização do usuário #$perfil[ID] $perfil[user_nicename] "
		. ( $status ? 'bem sucedida.' : 'falhou.' )
	);
	
	// Fim
	return $resposta;
	return $status;
	
}



// Integração - Hooks



// SSO

function sap_gerarLinkSSO( $usuario = null, $expire = null ) {
	// Gera o URL de login no SSO para o usuário dado ou para o usuário do OData
	$sap_config = sap_carregarConfig();
	if ( !$usuario )
		$usuario = $sap_config['username'];
	if ( !$expire )
		$expire = date( 'Y-m-d\\TH:i:s' );
	elseif ( is_numeric( $expire ) )
		$expire = date( 'Y-m-d\\TH:i:s', intval( $expire ) );
	$url_base = $sap_config['servidor'] . 'login?';
	$usuario = base64_encode( $usuario );
	$usuario = str_replace(
		array( '+', '/', '=' ),
		array( '.', '_', '-' ),
		$usuario
	);
	$callerhash = md5( $usuario . $expire . $sap_config['secret_key'] );
	$args = array(
		'company' => $sap_config['company'],
		'username' => $usuario,
		'tklogin_key' => $sap_config['tklogin_key'],
		'callerhash' => $callerhash,
		'expire' => $expire,
	);
	$query = http_build_query( $args );
	return $url_base . $query;
}

function sap_testarLoginSSO( $usuario = null, $expire = null ) {

	// Testa a resposta do servidor para o link de login
	
	$sap_config = sap_carregarConfig();
	
	if ( !$usuario )
		$usuario = $sap_config['username'];
		
	// Teste
	$url = sap_gerarLinkSSO( $usuario, $expire );
	
	// Contexto
	$contexto = stream_context_create( array(
		'http' => array(
			'method' => 'GET',
			'ignore_errors' => false,
			'follow_location' => 0,
		)
	) );
	
	// Log
	sap_log( 'Teste de login via SSO com o usuário "' . $usuario . '"...' );
	
	// Requisição
	$stream = @fopen( $url, 'r', false, $contexto );
	
	// Resposta
	$resposta = array(
		'codigo' => codigoHttp( $http_response_header[0] ),
		'header' => $http_response_header,
		'conteudo' => '',
		'status' => 0,
	);
	
	// $resposta['status'] = $resposta['codigo'][0] == 302;
	
	foreach ( $resposta['header'] as $linha ) {
		if ( strpos( $linha, 'Set-Cookie: loginMethodCookieKey=SSO' ) !== false ) {
			$resposta['status'] = 1;
			break;
		}
	}
	
	// Log
	sap_log( "Login via SSO com o usuário \"$usuario\" " . ( $resposta['status'] ? 'bem sucedido' : 'falhou' ) . '.' );
	
	// Fim
	if ( $stream )
		fclose( $stream );
		
	return $resposta;
	
}

function sap_testarLoginSSOPadrao() {
	// Testa o login com o usuário do OData, salva o resultado e gera mensagens
	global $sap_mensagens, $sap_erros;
	$resposta = sap_testarLoginSSO();
	sap_salvarOpcao( 'sso_valido', $resposta['status'] );
	if ( $resposta['status'] ) {
		$sap_mensagens[] = 'O teste de login via SSO foi bem-sucedido!';
	} else {
		$sap_erros[] = 'Falha no login via SSO.';
	}
	return $resposta['status'];
}
