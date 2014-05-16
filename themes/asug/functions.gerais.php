<?php
/*
 * Funções gerais
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 

define( 'TUDO', pow( 2, 16 ) - 1 );
define( 'NADA', 0 );

function bit( $reset = null ) {
	// Retorna um bit que não foi utilizado antes
	static $bit = 0;
	if ( is_numeric( $reset ) )
		return $bit = (int) $reset;
	return pow( 2, $bit++ );
}

define( 'GMT_OFFSET', get_option('gmt_offset') );
$usuarioAlvo = null;
$entidadeAlvo = null;

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

function obter( $arr, $chave, $padrao = null ) {
	// Verifica se a $chave existe na $arr, se não retorna o $padrao
	return is_array( $arr ) && array_key_exists( $chave, $arr )
		? $arr[ $chave ]
		: $padrao
	;
}

function obterArray( $arr, $chave ) {
	// @alias obter()
	return obter( $arr, $chave, array() );
}

function obterPost( $listaVars, $allowGet = false ) {
	// Verifica se uma ou mais variáveis postadas existem, se não inicializa e retorna status; opcionalmente obtém variáveis GET
	$status = true;
	if ( $allowGet )
		$req =& $_GET;
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

function obterItem( $listaDesejada, $item, $padrao = null ) {
	// Retorna um item definido em $listas ou $padrao se não existir
	global $listas;
	if ( !isset( $listas[ $listaDesejada ] ) )
		return $padrao;
	if ( !isset( $listas[ $listaDesejada ]['valores'][ $item ] ) )
		return $padrao;
	return $listas[ $listaDesejada ]['valores'][ $item ];
}

function vazio( $valor ) {
	// Verifica se um valor é realmente vazio (string vazio ou nulo)
	if ( is_string( $valor ) )
		return $valor === '';
	return $valor === null;
}

function umDe() {
	// Retorna o primeiro valor não vazio dos argumentos passados
	// @requer vazio()
	// @alt primeiroDe()
	$args = func_get_args();
	foreach ( $args as $valor )
		if ( !vazio( $valor ) )
			return $valor;
	return false;
}

function umVerdadeiroDe() {
	// Retorna o primeiro valor verdadeiro dos argumentos passados
	$args = func_get_args();
	foreach ( $args as $valor )
		if ( $valor )
			return $valor;
	return false;
}

function filterNull( $value ) {
	// Filtra valores nulos
	return $value !== null;
}

function array_filter_recursive( $input, $callback = null ) {
	// by romain dot lamarche at gmail dot com
	// http://br1.php.net/manual/en/function.array-filter.php#87581
	foreach ( $input as &$value ) {
		if ( is_array($value) ){
			$value = array_filter_recursive( $value, $callback );
		}
	}
	return array_filter( $input, $callback );
}

function array_merge_recursive_distinct( array &$array1, array &$array2 ) {
	// by gabriel dot sobrinho at gmail dot com
	// http://br1.php.net/manual/en/function.array-merge-recursive.php#92195
	$merged = $array1;
	foreach ( $array2 as $key => &$value ) {
		if ( is_array( $value ) && isset( $merged [$key] ) && is_array( $merged [$key] ) ) {
			$merged [$key] = array_merge_recursive_distinct ( $merged [$key], $value );
		} else {
			$merged [$key] = $value;
		}
	}
	return $merged;
}

function mapUnidimensional( &$arr ) {
	// Retorna o primeiro valor da array, para usar com array_map
	return $arr[0];
}

function mapMeta( &$arr ) {
	// Retorna o primeiro valor de cada meta e de-serializa arrays
	// @sintaxe array_map( 'mapMeta', get_user_meta( $id ) )
	$val = $arr[0];
	if ( is_string( $val ) && substr( $val, 0, 2 ) == 'a:' )
		$val = unserialize( $val );
	return $val;
}

function fimDoDia( $data ) {
	// Adiciona 23h59s à um timestamp
	if ( !is_numeric( $data ) )
		$data = strtotime( $data );
	return $data + DAY_IN_SECONDS - 1;
}



// Mensagens



$erro = false;
$acao = null;
$mensagens = array();
$prefixoMensagens = '';

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
	global $mensagens, $prefixoMensagens;
	if ( !$msg )
		return true;
	$params = func_num_args();
	if ( $params > 1 ) {
		$args = func_get_args();
		$msg = call_user_func_array( 'sprintf', $args );
	}
	$mensagens[] = $prefixoMensagens . $msg;
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

function imprimirMensagens() {

	// Imprime as mensagens em HTML na página, utilizando as classes no Bootstrap
	
	global $mensagens, $erro;
	
	if ( !$mensagens )
		return false;
	
	$msg = nl2br( trim( implode( '<br>', $mensagens ) ) );
	
	print $erro
		? '<p class="bg-danger">'
		: '<p class="bg-success">'
	;
	
	print $msg;
	print '</p>';
	return true;
	
}



// LOGGER



function salvarLog( $dados = null ) {
	// Salva informações num arquivo de log
	global $config;
	$file = fopen( $config['arquivo_log'], 'a' );
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



// Tratamento de dados



bit(0);
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
	if ( is_string( $arr ) && isset( $listas[ $arr ] ) ) {
		$arr = $listas[ $arr ]['valores'];
	}
	if ( !is_array( $arr ) ) {
		print "<option value=''>-- Lista Inválida --</option>";
		return;
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
					$label = esc_attr( $dados );
				else
					$dataset .= "data-$chave='" . esc_attr( $dados ) . "' ";
			}
		} else {
			$label = esc_attr( $info );
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
	// Ao estender, é possível remover valores deixando-os nulos
	// Se o $prefixo for ativado, gera uma constante para a 'id' utilizando o $prefixo e o 'slug' como nome da constante
	// @requer array_merge_recursive_distinct, filterNull, array_filter_recursive

	foreach ( $dados as $x ) {
	
		if ( !is_array( $x ) )
			$x = array( 'valor' => $x );
	
		// id
		if ( !isset( $x['id'] ) )
			$x['id'] = count( $arr );
		
		// estender
		if ( isset( $x['estender'] ) && isset( $arr[ $x['estender'] ] ) ) {
			$x = array_merge_recursive_distinct( $arr[ $x['estender'] ], $x );
			$x = array_filter_recursive( $x, 'filterNull' );
		}
		
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