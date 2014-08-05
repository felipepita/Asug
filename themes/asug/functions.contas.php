<?php
/*
 * Funções relacionadas às contas de usuários
 * Desenvolvido pela MontarSite - www.montarsite.com.br - 2014
 */

 
 
// DEFINIÇÕES GERAIS



global $config;

$config = array(
	'arquivo_log' 			=> trailingslashit( ABSPATH ) . 'ola,_eu_me_chamo_log.log',
	'senha_min' 			=> 6,
	'senha_max' 			=> 32,
	'confirmacao_espera'	=> 300, // segundos
	'tamanho_senha'			=> 10,
);

bit(0);
define( 'FUNCAO_ADMIN', bit() );
define( 'FUNCAO_FUNCIONARIO', bit() );
define( 'FUNCAO_EMPRESA', bit() );
define( 'FUNCAO_REPRESENTANTE', bit() );

define( 'SAP_DATA', 'Y-m-d\\TH:i:s' );
define( 'WP_DATA', 'Y-m-d H:i:s' );

function add_custom_endpoints() {
	global $wp_rewrite;
    add_rewrite_endpoint( 'ajax', EP_PERMALINK | EP_PAGES );
    add_rewrite_endpoint( 'confirmar', EP_PERMALINK | EP_PAGES );
	$wp_rewrite->flush_rules();
}

add_action( 'init', 'add_custom_endpoints' );



// VERIFICAÇÃO DE CONTAS



add_action( 'wp', 'verificarcontas_setup' );
add_action( 'verificarcontas', 'verificarcontas', 10, 0 );

function verificarcontas_setup() {
	// Instala uma tarefa agendada
	if ( !wp_next_scheduled( 'verificarcontas' ) ) {
		$meia_noite_hoje = date( 'Y-m-d' ) . ' 00:00:00';
		$meia_noite_hoje = strtotime( $meia_noite_hoje );
		$meia_noite_hoje -= GMT_OFFSET * HOUR_IN_SECONDS;
		wp_schedule_event( $meia_noite_hoje, 'daily', 'verificarcontas' );
	}
}

function verificarcontas( $debug = false ) {

	// Verifica todas as contas do sistema e manda avisos de expiração
	// @requer plugin user-status-manager, sanitizarData
	
	global $wpdb, $associacao_config;
	
	require_once TEMPLATEPATH . '/inc/config-associacao.php';
	
	// Processa as vars do config
	$notificacao = array(
		'degustacao' => explode( ',', str_replace( ' ', '', $associacao_config['notificacao_degustacao'] ) ),
		'membro' => explode( ',', str_replace( ' ', '', $associacao_config['notificacao_membro'] ) ),
	);
	
	// Adiciona notificação de um dia
	if ( !in_array( 1, $notificacao['degustacao'] ) )
		$notificacao['degustacao'][] = 1;
	if ( !in_array( 1, $notificacao['membro'] ) )
		$notificacao['membro'][] = 1;
	
	$log = "[Verificação de Contas]" . PHP_EOL;
	
	if ( $debug ) {
		$log .= "Modo debug" . PHP_EOL;
		$log .= "Datas de notificação:" . PHP_EOL;
		$log .= "\tDegustação = " . implode( ' / ', $notificacao['degustacao'] ) . PHP_EOL;
		$log .= "\tMembro = " . implode( ' / ', $notificacao['membro'] ) . PHP_EOL;
	}
	
	// Puxa todos os usuários do BD
	$users = "`{$wpdb->prefix}users`";
	$status = "`{$wpdb->prefix}user_status_manager`";
	
	$query = "
		SELECT
			$users.`ID`,
			$users.`user_email`,
			`user_nicename`,
			`display_name`,
			`status`,
			`status_to`
		FROM
			$users,
			$status
		WHERE
			$users.`ID` = $status.`user_id`
	";
	
	$resultados = $wpdb->get_results( $query, ARRAY_A );
	
	if ( !$resultados || !count( $resultados ) )
		return false;
		
	foreach ( $resultados as $usuario ) {
	
		if ( $debug )
			$log .= "Verificando conta #$usuario[ID] de $usuario[display_name] de status \"$usuario[status]\" com expiração em \"$usuario[status_to]\"... ";
		
		// Verifica se a conta está inativa ou não tem data de expiração
		if ( $usuario['status'] == '1' || !$usuario['status_to'] ) {
			if ( $debug )
				$log .= "não tem desativação programada." . PHP_EOL;
			continue;
		}
		
		// Tipo de assinatura
		$tipo = $usuario['status'] == '2'
			? 'degustacao'
			: 'membro'
		;
		
		// Datas
		$hoje = time();
		$expira = strtotime( sanitizarData( $usuario['status_to'] ) );
		$diasRestantes = floor( ( $expira - $hoje ) / DAY_IN_SECONDS );
		
		// Verifica se atingiu o dia da notificação
		if ( !in_array( $diasRestantes, $notificacao[ $tipo ] ) ) {
			if ( $debug )
				$log .= "expira em $diasRestantes dias (fora da data de notificação)." . PHP_EOL;
			continue;
		}
		
		// Envia a mensagem
		
		$tokens = array(
			'dias' => $diasRestantes,
		);
		
		enviarEmailPadronizado(
			$usuario['user_email'],
			$tipo . ( $diasRestantes == 1 ? '_1' : '_x' ),
			$tokens
		);
		
		// Log
			
		if ( $debug )
			$log .= "expira em $diasRestantes dias. NOTIFICAÇÃO ENVIADA!" . PHP_EOL;
		else
			$log .= "Conta #$usuario[ID] de $usuario[display_name] de status \"$usuario[status]\" irá expirar em $usuario[status_to] ($diasRestantes dias)." . PHP_EOL;
		
	}
	
	salvarLog( $log );
	return true;

}



// Confirmação de e-mail



function enviarConfirmacaoEmail( $id ) {
	// Envia a confirmação de e-mail para um usuário
	// @requer obterUsuario, gerarLinkConfirmacao, prepararMensagem, anexarRodape, inc/config-associacao.php
	global $associacao_config;
	$user = obterUsuario( $id );
	// Obtém o link
	$link = gerarLinkConfirmacao( $user );
	if ( !$link ) {
		return false;
	}
	// Prepara o e-mail
	$email_destinatario = $user->user_email;
	$email_assunto = prepararMensagem( $associacao_config['email_confirmacao_assunto'] );
	$tokens = array(
		'nome' => $user->display_name,
		'confirmacao_url' => $link,
	);
	$email_corpo = prepararMensagem( $associacao_config['email_confirmacao_corpo'], $tokens );
	// Envia a mensagem
	wp_mail(
		$email_destinatario,
		$email_assunto,
		anexarRodape( $email_corpo )
	);
	// Fim
	return $link;
}

function gerarLinkConfirmacao( $id = null ) {
	// Gera o código de confirmação e retorna o link
	// @requer obterUsuario
	global $config;
	$user = obterUsuario( $id );
	// Um código já foi gerado?
	$codigo = get_user_meta( $user->ID, 'codigo_confirmacao', true );
	if ( $codigo ) {
		// Verifica se a última confirmação foi enviada à pouco
		$hora_confirmacao = get_user_meta( $user->ID, 'hora_confirmacao', true );	
		if ( $hora_confirmacao && time() - $hora_confirmacao < $config['confirmacao_espera'] ) {
			erro( 'Um e-mail de confirmação já foi enviado para esse endereço há menos de ' . ( $config['confirmacao_espera'] / 60 ) . ' minutos atrás.' );
			return false;
		}
	} else {
		// Gera um código novo e único no sistema
		do {
			// Gera um hexadecimal de 8 caracteres
			$codigo = mt_rand( 0, mt_getrandmax() );
			$codigo = base_convert( $codigo, 10, 16 );
			$codigo = str_pad( $codigo, 8, '0', STR_PAD_LEFT );
		} while ( get_transient( "codigo_confirmacao_$codigo" ) !== false );
		update_user_meta( $user->ID, 'codigo_confirmacao', $codigo );
	}
	// Atualiza a hora do último envio
	update_user_meta( $user->ID, 'hora_confirmacao', time() );
	set_transient( "codigo_confirmacao_$codigo", $user->ID, WEEK_IN_SECONDS );
	// Link
	return home_url( "/conta/confirmar/$codigo" );
}

function obterLinkConfirmacao( $id ) {
	// Retorna o link de confirmação para um usuário, gerando-o se necessário
	$codigo = get_user_meta( $id, 'codigo_confirmacao', true );
	return $codigo
		? site_url( "/conta/confirmar/$codigo" )
		: gerarLinkConfirmacao( $id )
	;
}

function confirmarEmail( $codigo ) {
	// Verifica o código da confirmação de e-mail e retorna o ID do usuário
	// @requer obterUsuario
	global $config;
	// Verifica um código
	$transient_chave = "codigo_confirmacao_$codigo";
	$user_id = get_transient( $transient_chave );
	if ( !$user_id ) {
		erro( 'O código de confirmação expirou. Por favor, solicite uma nova confirmação.' );
		return false;
	}
	$codigoCerto = get_user_meta( $user_id, 'codigo_confirmacao', true );
	if ( $codigo !== $codigoCerto ) {
		erro( 'O código de confirmação está incorreto. Por favor, certifique-se de que copiou o link completo que recebeu por e-mail. Se estiver tendo dificuldades, entre em contato conosco.' );
		return false;
	}
	// Está certo
	delete_transient( $transient_chave );
	delete_user_meta( $user_id, 'codigo_confirmacao' );
	delete_user_meta( $user_id, 'hora_confirmacao' );
	update_user_meta( $user_id, 'email_confirmado', 1 );
	msg( 'Seu e-mail foi confirmado com êxito.' );
	return $user_id;
}



// Ajax



function ajax_template_redirect() {
    global $wp_query;
 
    // if this is not a request for ajax or a singular object then bail
    if ( ! isset( $wp_query->query_vars['ajax'] ) || ! is_singular() )
        return;
		
	$slug = $wp_query->query_vars['pagename'];
	$file = dirname( __FILE__ ) . "/form.$slug.php";
 
    // include custom template
	if ( file_exists( $file ) ) {
		include $file;
		exit;
	}
}

add_action( 'template_redirect', 'ajax_template_redirect' );



// Usuários e empresas



function obterUsuario( $id = null ) {
	// Retorna um objeto de usuário
	// Se um ID ou objeto WP_User não for fornecido, obtém o usuário atual
	if ( is_numeric( $id ) )
		return get_userdata( $id );
	elseif ( is_null( $id ) )
		return get_userdata( get_current_user_id() );
	elseif ( $id instanceof WP_User )
		return $id;
	else
		return null;
}

function buscarEmpresa( $sufixo ) {
	// Busca o ID de uma empresa por sufixo
	global $wpdb;
	if ( !$sufixo )
		return false;
	$query = $wpdb->prepare( "SELECT `user_id` FROM `$wpdb->usermeta` WHERE `meta_key`='sufixo' AND `meta_value` LIKE '%s'", '%"'.$sufixo.'"%' );
	return $wpdb->get_var( $query );
}

function obterEmpresa( $input = null ) {
	// Retorna um objeto WP_User da empresa
	// Aceita ID numérico ou objeto WP_User de um funcionário/representante, ou string com sufixo/domínio
	// @requer buscarEmpresa, funcaoDesteUsuario
	$user = null;
	if ( is_null( $input ) ) {
		// Nulo - obtém ID do usuário logado
		$input = get_current_user_id();
	}
	if ( is_numeric( $input ) ) {
		// Busca por ID
		$user = get_userdata( $input );
	} elseif ( $input instanceof WP_User ) {
		// Objeto já fornecido
		$user = $input;
	} elseif ( is_string( $input ) ) {
		// Busca por sufixo
		$empresa_id = buscarEmpresa( $input );
		if ( !$empresa_id )
			return null;
		else
			return get_userdata( $empresa_id );
	}
	if ( !$user )
		return null;
	// Identifica a função do $user obtido
	$funcao = funcaoDesteUsuario( $user );
	if ( $funcao == FUNCAO_EMPRESA ) {
		// Já é a empresa
		return $user;
	} elseif ( $funcao == FUNCAO_FUNCIONARIO || $funcao == FUNCAO_REPRESENTANTE ) {
		// Funcionário ou representante
		$empresa_id = get_user_meta( $user->ID, 'empresa', true );
		$empresa = get_userdata( $empresa_id );
		return $empresa;
	} else {
		// Outra função não associada a uma empresa
		return null;
	}
}

function buscarUsuarioVelho( $id_velho, $eEmpresa = false ) {
	// Encontra o ID novo de um usuário pelo seu ID velho
	// Alternativamente, verifica se o objeto WP_User dado tem um ID velho, retornando o ID velho
	global $wpdb;
	$campoID = $eEmpresa
		? 'id_velho_empresa'
		: 'id_velho'
	;
	if ( is_object( $id_velho ) && $id_velho instanceof WP_User ) {
		return get_user_meta( $id_velho->ID, $campoID, true );
	} elseif ( is_numeric( $id_velho ) ) {
		$query = "SELECT `user_id` FROM `$wpdb->usermeta` WHERE `meta_key`='$campoID' AND ( `meta_value`=$id_velho " . ( FALSE && $eEmpresa ? "OR `meta_value` LIKE '%\"$id_velho\"%'" : '' ) . " ) LIMIT 1"; // Busca por array de IDs desativada
		return $wpdb->get_var( $query );
	} else {
		return false;
	}
}

function buscarEmpresaVelha( $id_velho ) {
	// @alias buscarUsuarioVelho
	return buscarUsuarioVelho( $id_velho, true );
}

function usuarioEstaAtivo( $id = null, $detalhado = false ) {
	// Retorna se este usuário está ativo ou não
	// Opcionalmente, retorna um array com uma descrição
	// @requer obterUsuario, funcaoDesteUsuario, fimDoDia, sanitizarData
	// @retorna boolean ou, no modo $detalhado, uma array com 'status', 'motivo', 'codigo' e 'expiracao'
	// 'codigo' = usuario_inexistente, empresa_inexistente, empresa_inativa, email_nao_verificado, ativacao_expirada, usuario_inativo, usuario_ativo
	global $wpdb;
	$degustacao = false;
	if ( !( $user = obterUsuario( $id ) ) ) {
		return $detalhado
			? array( 'status' => false, 'motivo' => 'usuário inexistente', 'codigo' => 'usuario_inexistente' )
			: false
		;
	}
	$funcao = funcaoDesteUsuario( $user );
	if ( $funcao == FUNCAO_FUNCIONARIO || $funcao == FUNCAO_EMPRESA ) {
		// Para funcionários e empresas, verifica se o representante está ativo
		if ( $funcao == FUNCAO_FUNCIONARIO ) {
			$empresa_id = get_user_meta( $user->ID, 'empresa', true );
			if ( !$empresa_id ) {
				return $detalhado
					? array( 'status' => false, 'motivo' => 'empresa vinculada inexistente', 'codigo' => 'empresa_inexistente' )
					: false
				;
			}
		} else {
			$empresa_id = $user->ID;
		}
		$rep_id = get_user_meta( $empresa_id, 'representante1', true );
		$rep = get_userdata( $rep_id );
		$rep_funcao = funcaoDesteUsuario( $rep );
		if ( $rep_funcao != FUNCAO_REPRESENTANTE ) {
			return $detalhado
				? array( 'status' => false, 'motivo' => 'representante inválido', 'codigo' => 'representante_invalido' )
				: false
			;
		}
		if ( !usuarioEstaAtivo( $rep ) ) {
			return $detalhado
				? array( 'status' => false, 'motivo' => 'empresa inativa', 'codigo' => 'empresa_inativa' )
				: false
			;
		}
	}
	if ( $funcao != FUNCAO_EMPRESA && $funcao != FUNCAO_ADMIN ) {
		// Usuário confirmou o endereço de e-mail?
		//if ( $user->status != 0 ) {
		if ( !get_user_meta( $user->ID, 'email_confirmado', true ) ) {
			return $detalhado
				? array( 'status' => false, 'motivo' => 'e-mail não verificado', 'codigo' => 'email_nao_verificado' )
				: false
			;
		}
	}
	// Verifica status do plugin user_status_manager
	$responsavel_id = $funcao == FUNCAO_EMPRESA
		// Para empresa, verifica o status do representante
		? $rep_id
		: $user->ID
	;
	$tabela = $wpdb->prefix . 'user_status_manager';
	$query = $wpdb->prepare(
		"SELECT `status_to`, `status` FROM `$tabela` WHERE `user_id`=%d",
		$responsavel_id
	);
	$row = $wpdb->get_row( $query );
	if ( $row->status == 2 )
		$degustacao = true;
	// status = 0 (ativo), 1 (inativo), 2 (degustação)
	if ( !$row || $row->status == 1 || ( $row->status_to && fimDoDia( sanitizarData( $row->status_to ) ) < time() ) ) {
		return $detalhado
			? array(
				'status' => false,
				'motivo' => $row->status == 1
					? 'conta desativada'
					: 'ativação expirada'
				,
				'expiracao' => sanitizarData( $row->status_to ),
				'codigo' => $row->status == 1
					? 'usuario_inativo'
					: 'ativacao_expirada'
				,
			)
			: false
		;
	}
	// Está ativo
	return $detalhado
		? array(
			'status' => true,
			'motivo' => $degustacao
				? 'em degustação'
				: 'conta ativa'
			,
			'expiracao' => sanitizarData( $row->status_to ),
			'codigo' => $degustacao
				? 'usuario_degustando'
				: 'usuario_ativo'
			,
		)
		: true
	;
}

function funcaoDesteUsuario( $id = null ) {
	// Retorna o número da função do usuário, conforme as constantes acima
	// @requer obter, obterUsuario
	if ( !$user = obterUsuario( $id ) )
		return false;
	$role = obter( $user->roles, 0 );
	switch ( $role ) {
		case 'representante' :
			$funcao = FUNCAO_REPRESENTANTE;
		break;
		case 'empresa_cliente' :
		case 'empresa_cliente_associada' :
		case 'empresa_parceira' :
		case 'empresa_parceira_associada' :
			$funcao = FUNCAO_EMPRESA;
		break;
		case 'administrator' :
		case 'designer' :
		case 'collaborator' :
			$funcao = FUNCAO_ADMIN;
		break;
		default :
			$funcao = FUNCAO_FUNCIONARIO;
		break;
	}
	return $funcao;
}

function tipoAssociacao( $input = null, $numerico = false ) {
	// Retorna o role da associação deste usuário, baseado na empresa vinculada
	// @retorna string com role da associação, ou número com o tipo de associação
	// @requer obterUsuario, obterEmpresa, funcaoDesteUsuario, obterItem
	$user = obterUsuario( $input );
	$nenhuma = $numerico
		? 0
		: 'nenhuma'
	;
	if ( !$user )
		return $nenhuma;
	$funcao = funcaoDesteUsuario( $user );
	if ( $funcao == FUNCAO_ADMIN ) {
		// Define associação do admin como Consultora SAP
		$assoc = 6;
	} else {
		// Obtém a associação da empresa
		$empresa = obterEmpresa( $user );
		if ( !$empresa )
			return $nenhuma;
		$assoc = intval( get_user_meta( $empresa->ID, 'tipo_associacao', true ) );
		if ( !$assoc )
			return $nenhuma;
	}
	return $numerico
		? $assoc
		: obterItem( 'role_associacao', $assoc, $nenhuma )
	;
}

function gerarSenha() {
	// Gera e retorna uma senha aleatória
	// @requer sortRandom
	global $config;
	$ucChars = 'BCDFGHJKLMNPQRSTVWXYZ';
	$ucChars_lastChar = strlen( $ucChars ) - 1;
	$lcChars = 'bcdfghjkmnpqrstvwxyz';
	$lcChars_lastChar = strlen( $lcChars ) - 1;
	$numerals = '23456789';
	$numerals_lastChar = strlen( $numerals ) - 1;
	$symbols = '!@#$%&=+()';
	$symbols_lastChar = strlen( $symbols ) - 1;
	$pwd = array();
	$pwd[] = $numerals{ rand( 0, $numerals_lastChar ) };
	$pwd[] = $numerals{ rand( 0, $numerals_lastChar ) };
	$pwd[] = $symbols{ rand( 0, $symbols_lastChar ) };
	$pwd[] = $symbols{ rand( 0, $symbols_lastChar ) };
	$randChars = $ucChars . $lcChars . $numerals;
	$randChars_lastChar = strlen( $randChars ) - 1;
	for ( $i = count( $pwd ); $i < $config['tamanho_senha']; $i++ ) {
		$pwd[] = $randChars{ rand( 0, $randChars_lastChar ) };
	}
	usort( $pwd, 'sortRandom' );
	return implode( '', $pwd );
}

function usernameUnico( $usernameOriginal ) {
	// Certifica-se de que o $usernameOriginal é único no sistema e adiciona números se necessário
	// @requer sluggify
	if ( !$usernameOriginal )
		return false;
	$loop = true;
	$usernameOriginal = sluggify( $usernameOriginal );
	$username = $usernameOriginal;
	for ( $n = 0; $loop; $n++ ) {
		if ( $n )
			$username = $usernameOriginal . $n;
		$loop = (bool) get_user_by( 'login', $username );
	}
	return $username;
}

function atualizarStatus( $id, $status, $inicio = '', $fim = '' ) {
	// Atualiza o status de um usuário
	global $wpdb;
	$tabela = $wpdb->prefix . 'user_status_manager';
	// Verifica se a entrada já existe no BD
	$query = $wpdb->prepare(
		"SELECT id FROM `$tabela` WHERE `user_id`=%d",
		$id
	);
	if ( !$wpdb->query( $query ) ) {
		// Cria
		$userdata = get_userdata( $id );
		$query = $wpdb->prepare(
			"INSERT INTO `$tabela` (
				`user_id`,
				`user_name`,
				`user_email`,
				`status_from`,
				`status_to`,
				`status`
			) VALUES (
				%d,
				'%s',
				'%s',
				'%s',
				'%s',
				%d,
			)",
			$id,
			$userdata->display_name,
			$userdata->user_email,
			$inicio,
			$fim,
			$status
		);
	} else {
		// Atualiza
		$query = $wpdb->prepare(
			"UPDATE `$tabela` SET `status`=%d, `status_from`='%s', `status_to`='%s' WHERE `user_id`=%d",
			$status,
			$inicio,
			$fim,
			$id
		);
	}
	// Roda e retorna
	return (bool) $wpdb->query( $query );
}



// Perfil e estrutura de dados



function perfilUsuario( $id = null ) {
	// Retorna uma array unificada com todos os campos do user data e meta, junto com status, função e campos necessários à sincronização com o SAP
	// @requer obterUsuario, funcaoDesteUsuario, usuarioEstaAtivo, mapMeta, obterItem
	$perfil = array();
	$user = obterUsuario( $id );
	if ( !$user )
		return $perfil;
	$perfil += get_object_vars( $user->data );
	$user_meta = array_map( 'mapMeta', get_user_meta( $user->ID ) );
	$perfil += $user_meta;
	$perfil['funcao'] = funcaoDesteUsuario( $user );
	$user_status = usuarioEstaAtivo( $user, true );
	$perfil += $user_status;
	$perfil['endereco_completo'] = $perfil['endereco'] . ( $perfil['complemento']
		? ', ' . $perfil['complemento'] // formatarEndereco( $perfil, false );
		: ''
	);
	if ( isset( $perfil['empresa'] ) ) {
		$empresa = get_userdata( $perfil['empresa'] );
		$perfil['empresa_nome'] = $empresa->display_name;
		$perfil['empresa_tipo_associacao'] = get_user_meta( $perfil['empresa'], 'tipo_associacao', true );
		$perfil['representante1'] = get_user_meta( $perfil['empresa'], 'representante1', true );
		$rep1 = get_userdata( $perfil['representante1'] );
		$perfil['representante1_login'] = $rep1->user_login;
		$perfil['representante1_telefone'] = get_user_meta( $perfil['representante1'], 'telefone', true );
	}
	return $perfil;
}

function primeiraAtivacao( $id ) {
	// Roda procedimentos necessários para a primeira ativação do usuário
	// @requer inc/config-associacao.php, obterUsuario, usuarioEstaAtivo, enviarEmailPadronizado, perfilUsuario, sap_sincronizarUsuario
	$user = obterUsuario( $id );
	if ( !$user || !get_user_meta( $user->ID, 'primeiro_login', true ) )
		return false;
	// Gera uma senha e salva no perfil
	$senha = gerarSenha();
	wp_set_password( $senha, $user->ID );
	// Verifica o status
	$user_ativo = usuarioEstaAtivo( $user );
	// Envia por e-mail
	$tokens = array(
		'senha' => $senha,
	);
	enviarEmailPadronizado(
		$user,
		'conta_confirmada_' . ( $user_ativo ? 'ativa' : 'inativa' ),
		$tokens
	);
	return true;
}

function atualizarUsuario( $dadosEntrada, $estruturaDadosEntrada = ESTRUTURA_FORM, $eEmpresa = false ) {

	// Atualiza ou cria um usuário com os dados fornecidos
	// Requer uma entrada com o valor da ID
	// Permite a troca de empresa ao alterar o e-mail de cadastro
	// @requer classe Relacao, sluggify, separarNomes, usernameUnico, perfilUsuario, atualizarStatus, obterItem, sap_sincronizarUsuario
	
	global $estruturaPerfil, $estruturaEmpresa;
	
	if ( $eEmpresa )
		$estrutura =& $estruturaEmpresa;
	else
		$estrutura =& $estruturaPerfil;
	
	$dadosTratados = $estrutura->traduzir(
		$dadosEntrada,
		$estruturaDadosEntrada,
		array( ESTRUTURA_USER_DATA, ESTRUTURA_USER_META )
	);
	
	// Alias
	$data =& $dadosTratados[ ESTRUTURA_USER_DATA ];
	$meta =& $dadosTratados[ ESTRUTURA_USER_META ];
	
	// Determina se é usuário novo
	$novo = !isset( $data['ID'] );
	
	// Nome completo
	if ( isset( $data['display_name'] ) ) {
		$meta['nickname'] = $data['display_name'];
		$data['user_nicename'] = usernameUnico( substr( $data['display_name'], 0, 32 ) );
		if ( !$eEmpresa && !isset( $meta['first_name'] ) ) {
			$nomes = separarNomes( $data['display_name'] );
			$meta['first_name'] = $nomes[0];
			// $meta['middle_name'] = $nomes[1];
			$meta['last_name'] = ( $nomes[1] ? $nomes[1] . ' ' : '' ) . $nomes[2];
		}
	}
	
	// E-mail e afiliação
	if ( isset( $data['user_email'] ) ) {
		$data['user_login'] = $data['user_email'];
		// TO-DO: Troca de empresa
	} elseif ( $eEmpresa && isset( $data['user_nicename'] ) ) {
		$data['user_login'] = $data['user_nicename'];
	}
	
	if ( $eEmpresa && isset( $meta['sufixo'] ) ) {
		// Define um e-mail padrão fictício para empresas
		$data['user_email'] = 'cadastro.asug@' . $meta['sufixo'][0];
	}
	
	// Empresa - Tipo de Associação
	if ( $eEmpresa && isset( $meta['tipo_asssociacao'] ) && !isset( $data['role'] ) ) {
		$data['role'] = obterItem( 'role_associacao', $meta['tipo_asssociacao'] );
	}
	
	// Status - atualiza separadamente na tabela do plugin
	if ( isset( $data['user_status'] ) ) {
		$status = $data['user_status'];
		unset( $data['user_status'] );
	} else {
		$status = false;
	}
		
	// erro( retornarDump( $dadosTratados ) );
	// return false;
	// error_log( 'Atualizando' . PHP_EOL . retornarDump( $dadosTratados ) );
		
	// Salva
	if ( $novo ) {
		// Define campos fixos, não editáveis
		if ( !isset( $data['user_pass'] ) )
			$data['user_pass'] = 'auto' . rand( 1000, 9999 );
		if ( $eEmpresa ) {
			$meta['logo'] = '';
			$meta['usuarios'] = array();
		} else {
			$meta['user_boleto'] = '';
			$meta['email_confirmado'] = 0;
			$meta['primeiro_login'] = 1;
			$meta['cargo_asug'] = 'ASS';
		}
		$id = wp_insert_user( $data );
		$resultado = $id;
	} else {
		$resultado = wp_update_user( $data );
		$id = $data['ID'];
	}
	
	if ( !$resultado || is_wp_error( $resultado ) ) {
		// erro( $meta['sufixo'][0] . ' / ' .  $data['display_name'] . ' / ' . $data['user_email'] . ' / ' . $data['user_nicename'] );
		// erro( $resultado );
		return false;
	}
		
	// Metadados
	foreach ( $meta as $chave => $valor ) {
		update_user_meta( $id, $chave, $valor );
	}
	
	if ( !isset( $meta['ultima_atualizacao'] ) )
		update_user_meta( $id, 'ultima_atualizacao', date( SAP_DATA ) );
	
	// Atualiza status
	if ( $status !== false )
		atualizarStatus( $id, $status );
	
	// Sincroniza no SAP
	if ( !$novo && !$eEmpresa && function_exists( 'sap_sincronizarUsuario' ) ) {
		$perfil = perfilUsuario( $id );
		sap_sincronizarUsuario( $perfil );
	}
	
	return $id;
	
}



// Envio de e-mails



function infoEnderecamento( $id = null ) {
	// Retorna uma array com as informações de endereçamento (nomes, tratamento e email) do usuário
	// @requer obterUsuario, obterItem
	$user = obterUsuario( $id );
	$info = array(
		'nome' => get_user_meta( $user->ID, 'first_name', true ),
		'sobrenome' => get_user_meta( $user->ID, 'last_name', true ),
		'titulo' => obterItem( 'tratamento', get_user_meta( $user->ID, 'tratamento', true ), '' ),
		'email' => $user->user_email,
		'nome_completo' => $user->display_name,
		'sexo' => get_user_meta( $user->ID, 'sexo', true ) == 'F' ? 1 : 0,
	);
	$info['nome_formal'] = ( $info['titulo'] ? $info['titulo'] . ' ' : '' ) . $info['nome'];
	$info['sobrenome_formal'] = ( $info['titulo'] ? $info['titulo'] . ' ' : '' ) . $info['sobrenome'];
	return $info;
}

function enviarEmailPadronizado( $id, $slug, $tokens = array(), $rodape = true ) {
	// Envia um e-mail gerenciável de nome $slug para o usuário ou e-mail fornecido
	// Adiciona os tokens de endereçamento do usuário, anexa o rodapé e prepara as mensagens
	// @requer inc/config-associacao.php, obterUsuario, infoEnderecamento, prepararMensagem
	global $associacao_email_config, $associacao_config;
	if ( strpos(  $slug, 'email_' ) !== 0 )
		$slug = 'email_' . $slug;
	if ( !isset( $associacao_email_config[ $slug ] ) )
		return false;
	if ( is_string( $id ) && !empty( $id ) && !is_numeric( $id ) ) {
		// Trata $id como um e-mail
		$destinatario = $id;
		$tokens += array( 'email' => $destinatario );
	} else {
		// Trata $id como um ID ou objeto WP_User
		$user = obterUsuario( $id );
		if ( !$user )
			return false;
		// Adiciona dados do usuário
		$tokens += infoEnderecamento( $user );
		$destinatario = $user->user_email;
	}
	$assunto = prepararMensagem( $associacao_config[ $slug . '_assunto' ], $tokens );
	$mensagem = $associacao_config[ $slug . '_corpo' ];
	if ( $rodape )
		$mensagem = anexarRodape( $mensagem );
	$mensagem = prepararMensagem( $mensagem, $tokens );
	return wp_mail(
		$destinatario,
		$assunto,
		$mensagem
	);
}

function enviarEmailAdmin( $slug, $tokens = array() ) {
	// @alias enviarEmailPadronizado
	$destinatario = get_option('admin_email');
	// $destinatario = 'jim@montarsite.com.br';
	return enviarEmailPadronizado( $destinatario, $slug, $tokens, false );
}
