<?php
/*
 * Funções relacionadas às contas de usuários
 * Desenvolvido pela MontarSite - www.montarsite.com.br - 2014
 */
 
 
 
// DEFINIÇÕES GERAIS



define( 'GMT_OFFSET', get_option('gmt_offset') );



// LOGGER



$arquivoLog = trailingslashit( ABSPATH ) . 'ola,me_chamo_log.log';

function salvarLog( $dados = null ) {
	// Salva informações num arquivo de log
	global $arquivoLog;
	$file = fopen( $arquivoLog, 'a' );
	if ( !$file )
		return false;
	if ( is_array( $dados ) || is_object( $dados ) )
		$dados = json_encode( $dados );
	fwrite( $file, date('c') . PHP_EOL );
	fwrite( $file, trim( $dados ) );
	fwrite( $file, PHP_EOL . PHP_EOL );
	fclose( $file );
	return true;
}



// VERIFICAÇÃO DE CONTAS



$configVerificacao = array(
	// O sistema envia mensagens ao chegar a qualquer um dos valores de X dias antes da expiração da conta, definidos abaixo
	'degustacao'  => array( 10, 5, 1 ),
	'membro'      => array( 60, 30, 10, 5, 1 ),
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
	
	$log = "[Verificação de Contas]" . PHP_EOL;
	$log .= "Datas de notificação:" . PHP_EOL;
	$log .= "\tDegustação = " . implode( ' / ', $configVerificacao['degustacao'] ) . PHP_EOL;
	$log .= "\tMembro = " . implode( ' / ', $configVerificacao['membro'] ) . PHP_EOL;
	
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
	
		$log .= "Verificando conta #$usuario[ID] de $usuario[display_name] de status \"$usuario[status]\" com expiração em \"$usuario[status_to]\"... ";
		
		// Verifica se a conta está inativa ou não tem data de expiração
		if ( $usuario['status'] == '1' || !$usuario['status_to'] ) {
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
			
		$log .= "expira em $diasRestantes dias. NOTIFICAÇÃO ENVIADA!" . PHP_EOL;
		//$log .= "Conta #$usuario[ID] de $usuario[display_name] de status \"$usuario[status]\" irá expirar em $usuario[status_to] ($diasRestantes dias)." . PHP_EOL;
		
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



