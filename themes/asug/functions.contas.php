<?php
/*
 * Funções relacionadas às contas de usuários
 * Desenvolvido pela MontarSite - www.montarsite.com.br - 2014
 */

 
 
// DEFINIÇÕES GERAIS



define( 'GMT_OFFSET', get_option('gmt_offset') );
$usuarioAlvo = null;
$entidadeAlvo = null;



// LOGGER



$arquivoLog = trailingslashit( ABSPATH ) . 'ola,_eu_me_chamo_log.log';

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



// Ajax



function add_ajax_endpoint() {
	global $wp_rewrite;
    add_rewrite_endpoint( 'ajax', EP_PERMALINK | EP_PAGES );
	$wp_rewrite->flush_rules();
}

add_action( 'init', 'add_ajax_endpoint' );

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



// Funções gerais



define( 'TUDO', pow( 2, 16 ) - 1 );
define( 'NADA', 0 );

function bit() {
	// Retorna um bit que não foi utilizado antes
	static $bit = 0;
	return pow( 2, $bit++ );
}

function ent( $string ) {
	// Retorna a $string com entidades codificadas com os parâmetros corretos
	return htmlentities( $string, ENT_QUOTES | ENT_HTML5, 'UTF-8', true );
}

function ln() {
	// Imprime todos os argumentos convertidos em strings, dando quebras em cada um
	// @requer toString
	$args = func_get_args();
	foreach ( $args as $string )
		print toString( $string ) . PHP_EOL;
}

function toString( $var ) {
	// Converte valores em uma string
	if ( is_string( $var ) )
		return $var;
	if ( is_numeric( $var ) )
		return (string) $var;
	if ( is_array( $var ) )
		return json_encode( $var );
	if ( is_object( $var ) )
		return get_class( $var );
	if ( is_null( $var ) )
		return 'NULL';
	if ( is_bool( $var ) )
		return $var
			? 'TRUE'
			: 'FALSE'
		;
	return gettype( $var );
}

$erro = false;
$acao = null;
$mensagens = array();

function erro( $msg = '' ) {
	// Registra uma mensagem de erro
	global $erro;
	if ( !$msg )
		return false;
	$erro = true;
	$args = func_get_args();
	call_user_func_array( 'msg', $args );
	// Retorna false para poder ser usado em conjunto com return de uma função
	// ex. return erro('Falha!')
	return false;
}

function msg( $msg = '' ) {
	// Registra uma mensagem; se mais parâmetros forem dados, aplica um sprintf em $msg
	global $mensagens;
	if ( !$msg )
		return true;
	$params = func_num_args();
	if ( $params > 1 ) {
		$args = func_get_args();
		$msg = call_user_func_array( 'sprintf', $args );
	}
	$mensagens[] = $msg;
	return true;
}

function retornarMensagens() {

	// Imprime todas as mensagens como resposta em JSON para o Ajax e termina a execução

	global $mensagens, $erro, $acao;
	
	$msg = nl2br( trim( implode( '<br>', $mensagens ) ) );
	
	$resposta = array(
		'status' => ( $erro ? false : true ),
		'mensagem' => $msg,
		'acao' => $acao,
	);
	
	print json_encode( $resposta );
	exit();
	
}

function obterPost( $listaVars, $allowGet = false ) {
	// Verifica se uma ou mais variáveis postadas existem, se não inicializa e retorna status; opcionalmente obtém variáveis GET
	$status = true;
	if ( $allowGet )
		$req =& $_REQUEST;
	else
		$req =& $_POST;
	if ( !is_array( $listaVars ) )
		$listaVars = array( $listaVars );
	foreach ( $listaVars as $var ) {
		if ( isset( $req[ $var ] ) )
			$req[ $var ] = trim( $req[ $var ] );
		else
			$req[ $var ] = '';
		$status = $status && $req[ $var ] !== '';
	}
	//return $valor;
	return $status;
}

function obterQuery( $listaVars ) {
	// @alias obterPost()
	return obterPost( $listaVars, true );
}



// Tratamento de dados



define( 'FUNC_RETURN', bit() );
define( 'FUNC_PRINT', bit() );

define( 'LISTAR_OPTION', bit() );
define( 'LISTAR_LI', bit() );
define( 'LISTAR_BR', bit() );
define( 'LISTAR_NL', bit() );

define( 'ESTADO_UF', bit() );
define( 'ESTADO_NOME', bit() );

function gerarLista( $arr, $selecionado = null, $itemNulo = true ) {
	// Gera <option>s para os elementos da lista referenciada ou nomeada
	// Se nomeada, também define o item selecionado da variável de mesmo nome no $form
	global $listas;
	if ( is_string( $arr ) ) {
		$arr = $listas[ $arr ]['valores'];
	}
	$total = count( $arr );
	$lista = '';
	if ( $itemNulo )
		$lista .= "\t<option value=''>-- Escolha --</option>\n";
	foreach ( $arr as $valor => $info ) {
		$sel = $selecionado == $valor
			? 'selected'
			: ''
		;
		$dataset = '';
		if ( is_array( $info ) ) {
			foreach ( $info as $chave => $dados ) {
				if ( $chave == 'label' )
					$label = html( $dados );
				else
					$dataset .= "data-$chave='" . html( $dados ) . "' ";
			}
		} else {
			$label = html( $info );
		}
		$lista .= "\t<option value='$valor' $dataset $sel>$label</option>\n";
	}
	print $lista;
}

$listaEstados = array("AC"=>"Acre", "AL"=>"Alagoas", "AM"=>"Amazonas", "AP"=>"Amapá","BA"=>"Bahia","CE"=>"Ceará","DF"=>"Distrito Federal","ES"=>"Espírito Santo","GO"=>"Goiás","MA"=>"Maranhão","MT"=>"Mato Grosso","MS"=>"Mato Grosso do Sul","MG"=>"Minas Gerais","PA"=>"Pará","PB"=>"Paraíba","PR"=>"Paraná","PE"=>"Pernambuco","PI"=>"Piauí","RJ"=>"Rio de Janeiro","RN"=>"Rio Grande do Norte","RO"=>"Rondônia","RS"=>"Rio Grande do Sul","RR"=>"Roraima","SC"=>"Santa Catarina","SE"=>"Sergipe","SP"=>"São Paulo","TO"=>"Tocantins");

function gerarEstados( $opcoes = 0, $selecionado = '' ) {
	global $listaEstados;
	$total = count( $listaEstados );
	$list = '';
	if ( !$opcoes )
		$opcoes = ESTADO_NOME | LISTAR_OPTION | FUNC_PRINT;
	foreach ( $listaEstados as $uf => $nome ) {
		$prop = ESTADO_NOME & $opcoes
			? $nome
			: $uf
		;
		$sel = $selecionado == $prop
			? 'selected'
			: ''
		;
		if ( LISTAR_OPTION & $opcoes )
			$list .= "\t<option value='$uf' $sel>$prop</option>\n";
		elseif ( LISTAR_LI & $opcoes )
			$list .= "\t<li" . ( $sel ? " class='$sel'" : '' ) . ">$prop</li>\n";
		elseif ( LISTAR_BR & $opcoes )
			$list .= "$prop<br>";
		elseif ( LISTAR_NL & $opcoes )
			$list .= "$prop\r\n";
	}
	if ( FUNC_RETURN & $opcoes )
		return $list;
	else
		print $list;
}

define( 'USER_META', bit() );
define( 'USER_DATA', bit() );

function exclusivo( $campo, $valor, $opcoes = USER_META ) {
	// Verifica no DB do WP se há um userdata ou usermeta igual ao fornecido
	global $wpdb;
	$campo = esc_sql( $campo );
	$valor = esc_sql( $valor );
	$result = false;
	if ( $opcoes & USER_META ) {
		$table = $wpdb->usermeta;
		$result = $wpdb->query( "SELECT user_id FROM $table WHERE meta_key='$campo' AND meta_value='$valor'" );
	} elseif ( $opcoes & USER_DATA ) {
		$table = $wpdb->users;
		$result = $wpdb->query( "SELECT ID FROM $table WHERE `$campo`='$valor'" );
	}
	return !$result;
}



// Definições



function definir( &$arr, $dados, $prefixo = null ) {

	// Armazena cada entrada da array $dados em $arr, utilizando ambas propriedades 'id' e 'slug' (se presentes) como chaves
	// Se a chave 'estender' estiver presente, combina essa array com outra definida anteriormente
	// Se o $prefixo for ativado, gera uma constante para a 'id' utilizando o $prefixo e o 'slug' como nome da constante

	foreach ( $dados as $x ) {
	
		if ( !is_array( $x ) )
			$x = array( 'valor' => $x );
	
		// id
		if ( !isset( $x['id'] ) )
			$x['id'] = count( $arr );
		
		// estender
		if ( isset( $x['estender'] ) && isset( $arr[ $x['estender'] ] ) )
			$x = array_merge( $arr[ $x['estender'] ], $x );
		
		// salvar
		$arr[ $x['id'] ] = $x;
		$ref =& $arr[ $x['id'] ];
		
		// slug
		if ( isset( $x['slug'] ) )
			$arr[ $x['slug'] ] =& $ref;
		else
			$x['slug'] = $x['id'];
		
		// constante
		if ( is_string( $prefixo ) ) {
		
			$const = strtoupper( "$prefixo$x[slug]" );
			
			if ( !defined( $const ) )
				define( $const, $x['id'] );
				
		}
	
	}

}
