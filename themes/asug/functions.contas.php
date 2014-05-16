<?php
/*
 * Funções relacionadas às contas de usuários
 * Desenvolvido pela MontarSite - www.montarsite.com.br - 2014
 */

 
 
// DEFINIÇÕES GERAIS



$config = array(
	'arquivo_log' => trailingslashit( ABSPATH ) . 'ola,_eu_me_chamo_log.log',
	'senha_min' => 6,
	'senha_max' => 32,
	'confirmacao_espera' => 300, // segundos
);

function add_custom_endpoints() {
	global $wp_rewrite;
    add_rewrite_endpoint( 'ajax', EP_PERMALINK | EP_PAGES );
    add_rewrite_endpoint( 'confirmar', EP_PERMALINK | EP_PAGES );
	$wp_rewrite->flush_rules();
}

add_action( 'init', 'add_custom_endpoints' );



// VERIFICAÇÃO DE CONTAS



$configVerificacao = array(
	// O sistema envia mensagens ao chegar a qualquer um dos valores de X dias antes da expiração da conta, definidos abaixo
	'degustacao'  => array( 10, 5, 1 ),
	'membro'      => array( 60, 30, 10, 5, 1 ),
	'debug'		  => false,
);

$mensagensVerificacao = array(
	// Mensagens genéricas quando faltam X dias
	'degustacao_x_assunto'   => "ASUG - O período de degustação vai terminar em %1\$s dias",
	'degustacao_x_corpo'     => "Olá %2\$s,\n"
							  . "Seu período de degustação no website da ASUG vai expirar em %1\$s dias.\n"
							  . "Evite interrupções no serviço e contate nossa equipe para efetuar sua assinatura.",
	'membro_x_assunto'       => "ASUG - Sua conta vai expirar em %1\$s dias",
	'membro_x_corpo'         => "Olá %2\$s,\n"
							  . "Sua assinatura no website da ASUG vai expirar em %1\$s dias.\n"
							  . "Evite interrupções no serviço e contate nossa equipe para renovar sua assinatura.",
	// Mensagens para quando falta um dia
	'degustacao_1_assunto'   => "ASUG - %2\$s, o período de degustação termina amanhã",
	'degustacao_1_corpo'     => "Olá %2\$s,\n"
							  . "Seu período de degustação no website da ASUG vai expirar amanhã.\n"
							  . "Faça sua assinatura hoje mesmo e obtenha um desconto de 10% na anuidade.\n"
							  . "Corra, a oferta é válida SOMENTE HOJE!",
	'membro_1_assunto'       => "ASUG - %2\$s, sua assinatura termina amanhã",
	'membro_1_corpo'         => "Olá %2\$s,\n"
							  . "Sua assinatura no website da ASUG vai expirar amanhã.\n"
							  . "Aja agora e evite interrupções no serviço renovando sua assinatura.",
	// Assinatura no rodapé de todas as mensagens
	'rodape'				 => "\n\nEquipe ASUG\n" . get_option('admin_email'),
);

add_action( 'wp', 'verificarcontas_setup' );
add_action( 'verificarcontas', 'verificarcontas' );

function verificarcontas_setup() {
	// Instala uma tarefa agendada
	if ( !wp_next_scheduled( 'verificarcontas' ) ) {
		$meia_noite_hoje = date( 'Y-m-d' ) . ' 00:00:00';
		$meia_noite_hoje = strtotime( $meia_noite_hoje );
		$meia_noite_hoje -= GMT_OFFSET * HOUR_IN_SECONDS;
		wp_schedule_event( $meia_noite_hoje, 'daily', 'verificarcontas' );
	}
}

function verificarcontas() {

	// Verifica todas as contas do sistema e manda avisos de expiração
	// @requer plugin user-status-manager
	
	global $wpdb, $configVerificacao, $mensagensVerificacao;
	
	$debug = $configVerificacao['debug'];
	$log = "[Verificação de Contas]" . PHP_EOL;
	
	if ( $debug ) {
		$log .= "Modo debug" . PHP_EOL;
		$log .= "Datas de notificação:" . PHP_EOL;
		$log .= "\tDegustação = " . implode( ' / ', $configVerificacao['degustacao'] ) . PHP_EOL;
		$log .= "\tMembro = " . implode( ' / ', $configVerificacao['membro'] ) . PHP_EOL;
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
		$expira = strtotime( $usuario['status_to'] );
		$diasRestantes = floor( ( $expira - $hoje ) / DAY_IN_SECONDS );
		
		// Verifica se atingiu o dia da notificação
		if ( !in_array( $diasRestantes, $configVerificacao[$tipo] ) ) {
			if ( $debug )
				$log .= "expira em $diasRestantes dias (fora da data de notificação)." . PHP_EOL;
			continue;
		}
		
		// Prepara a mensagem
		
		$remetente = get_option('blogname') . ' <' . get_option('admin_email') . '>';
		$destinatario = $usuario['user_email'];
		
		$headers = array(
			"From: $remetente",
			"Content-type: text/plain",
		);
		
		$assunto = isset( $mensagensVerificacao[ "$tipo-$diasRestantes-assunto" ] )
			? $mensagensVerificacao[ "$tipo-$diasRestantes-assunto" ]
			: $mensagensVerificacao[ "$tipo-x-assunto" ]
		;
		$assunto = sprintf( $assunto,
			$diasRestantes,
			$usuario['display_name']
		);
		
		$mensagem = isset( $mensagensVerificacao[ "$tipo-$diasRestantes-corpo" ] )
			? $mensagensVerificacao[ "$tipo-$diasRestantes-corpo" ]
			: $mensagensVerificacao[ "$tipo-x-corpo" ]
		;
		$mensagem = sprintf( $mensagem . $rodape,
			$diasRestantes,
			$usuario['display_name']
		);
		
		// Log
			
		if ( $debug )
			$log .= "expira em $diasRestantes dias. NOTIFICAÇÃO ENVIADA!" . PHP_EOL;
		else
			$log .= "Conta #$usuario[ID] de $usuario[display_name] de status \"$usuario[status]\" irá expirar em $usuario[status_to] ($diasRestantes dias)." . PHP_EOL;
		
		// Envia o e-mail
		
		wp_mail(
			$destinatario,
			$assunto,
			$mensagem,
			$headers
		);
	
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
	return true;
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

function confirmarEmail( $codigo ) {
	// Verifica o código da confirmação de e-mail
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
	return true;
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



// Status de usuários e empresas



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

function usuarioEstaAtivo( $id = null, $detalhado = false ) {
	// Retorna se este usuário está ativo ou não
	// Opcionalmente, retorna um array com uma descrição
	// @requer obterUsuario, funcaoDesteUsuario, fimDoDia
	global $wpdb;
	if ( !$user = obterUsuario( $id ) ) {
		return $detalhado
			? array( 'status' => false, 'motivo' => 'usuário inexistente' )
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
					? array( 'status' => false, 'motivo' => 'empresa vinculada inexistente' )
					: false
				;
			}
		} else {
			$empresa_id = $user->ID;
		}
		$rep_id = get_user_meta( $empresa_id, 'representante1', true );
		if ( !usuarioEstaAtivo( $rep_id ) ) {
			return $detalhado
				? array( 'status' => false, 'motivo' => 'empresa inativa' )
				: false
			;
		}
	}
	if ( $funcao != FUNCAO_EMPRESA ) {
		// Usuário confirmou o endereço de e-mail?
		//if ( $user->status != 0 ) {
		if ( !get_user_meta( $user->ID, 'email_confirmado', true ) ) {
			return $detalhado
				? array( 'status' => false, 'motivo' => 'e-mail não verificado' )
				: false
			;
		}
		// Verifica status do plugin user_status_manager
		$tabela = $wpdb->prefix . 'user_status_manager';
		$query = $wpdb->prepare(
			"SELECT `status_to`, `status` FROM `$tabela` WHERE `user_id`=%d",
			$user->ID
		);
		$row = $wpdb->get_row( $query );
		if ( !$row || $row->status != 0 || ( $row->status_to && fimDoDia( $row->status_to ) < time() ) ) {
			return $detalhado
				? array(
					'status' => false,
					'motivo' => $row->status == 0
						? 'ativação expirada'
						: 'conta desativada'
					,
					'expiracao' => $row->status_to,
				)
				: false
			;
		}
	}
	// Está ativo
	return $detalhado
		? array( 'status' => true, 'motivo' => 'conta ativa', 'expiracao' => $row->status_to )
		: true
	;
}

bit(0);
define( 'FUNCAO_ADMIN', bit() );
define( 'FUNCAO_FUNCIONARIO', bit() );
define( 'FUNCAO_EMPRESA', bit() );
define( 'FUNCAO_REPRESENTANTE', bit() );

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
			$funcao = FUNCAO_ADMIN;
		break;
		default :
			$funcao = FUNCAO_FUNCIONARIO;
		break;
	}
	return $funcao;
}

function perfilUsuario( $id = null ) {
	// Retorna uma array unificada com todos os campos do user data e meta, junto com status e função
	// @requer obterUsuario, funcaoDesteUsuario, usuarioEstaAtivo, mapMeta
	$perfil = array();
	$user = obterUsuario( $id );
	$perfil += get_object_vars( $user );
	$user_meta = array_map( 'mapMeta', get_user_meta( $user->ID ) );
	$perfil += $user_meta;
	$perfil['funcao'] = funcaoDesteUsuario( $user );
	$user_status = usuarioEstaAtivo( $user, true );
	$perfil += $user_status;
	return $perfil;
}
