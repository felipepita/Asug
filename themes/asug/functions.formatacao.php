<?php
/*
 * Formulários, inputs e formatação de dados
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
// Verificação dos campos



function sanitizarPost( $perfil, $modo = null, $prefixo = null ) {
	// Altera o POST / retorna uma array ($modo = FUNC_RETURN) contendo apenas os campos do $perfil
	global $perfis;
	// Obtém os campos do perfil
	if ( is_string( $perfil ) ) {
		if ( !isset( $perfis[ $perfil ] ) )
			return false;
		$campos =& $perfis[ $perfil ]['campos'];
	} elseif ( is_array( $perfil ) ) {
		$campos =& $perfil;
	} else {
		return false;
	}
	// Extrai os pares do post
	if ( $prefixo ) {
		// Remove o prefixo das chaves
		$prefixo .= '_';
		$postSanitizado = array();
		foreach ( $campos as $chave => $valor ) {
			if ( is_numeric( $chave ) )
				$chave = $valor;
			$chavePrefixada = $prefixo . $chave;
			if ( !isset( $_POST[ $chavePrefixada ] ) )
				continue;
			$postSanitizado[ $chave ] = $_POST[ $chavePrefixada ];
		}
	} else {
		// Extrai as chaves tais e quais
		$postSanitizado = array_intersect_key( $_POST, $campos );
	}
	// Retorna
	if ( $modo ) {
		return $postSanitizado;
	} else {
		$_POST = $postSanitizado;
		return $_POST;
	}
}

function processarCampos( $perfil, $prefixo = '', $opcional = false ) {
	// Processa todos os campos deste $perfil, obtendo do $_POST e rodando a validação automática em cada um
	// @requer obterPost
	global $perfis;
	$statusGeral = true;
	$camposDoPerfil = $perfis[ $perfil ]['campos'];
	obterPost( array_keys( $camposDoPerfil ), false, $prefixo );
	foreach( $camposDoPerfil as $slug => $obrigatorio ) {
		$statusGeral = verificarValor( $slug, $obrigatorio, $prefixo ) && $statusGeral;
	}
	return $statusGeral;
}

function verificarValor( $slug, $obrigatorio = false, $prefixo = null ) {

	// Roda os processos automatizados de verificação em um valor e gera as mensagens
	// Opcionalmente adiciona um $prefixo e subtraço aos nomes dos campos
	
	global $campos, $listas;
	
	$postSlug = $prefixo
		? "{$prefixo}_$slug"
		: $slug
	;
	$valor =& $_POST[ $postSlug ];
	$campo =& $campos[ $slug ];
	//erro( $postSlug . ' = "' . $valor . '"' );
	
	// Sanitização
	$valor = trim( $valor );
	if ( isset( $campo['sanitizador'] ) )
		$valor = call_user_func( $campo['sanitizador'], $valor, $slug );
		
	// Corta caracteres acima do máximo
	if ( is_string( $valor ) && isset( $campo['maxlength'] ) && strlen( $valor ) > $campo['maxlength'] )
		$valor = substr( $valor, 0, $campo['maxlength'] );
		
	// Valor nulo
	if ( vazio( $valor ) ) {
		if ( $obrigatorio )
			return erro( $campo['msg_vazio'] );
		else
			return true;
	}
	
	// Valor abaixo do mínimo de caracteres
	if ( is_string( $valor ) && isset( $campo['minlength'] ) && strlen( $valor ) < $campo['minlength'] )
		return erro( $campo['msg_invalido'] );
	
	// Valor fora da lista
	if ( isset( $campo['lista'] ) ) {
		if ( is_array( $valor ) ) {
			if ( array_diff_key( $valor, $listas[ $campo['lista'] ]['valores'] ) )
				return erro( $campo['msg_invalido'] );
		} else {
			if ( !isset( $listas[ $campo['lista'] ]['valores'][ $valor ] ) )
				return erro( $campo['msg_invalido'] );
		}
	}
	
	// Função de validação
	if ( isset( $campo['validador'] ) ) {
		$retorno = call_user_func( $campo['validador'], $valor, $slug, $campo );
		// Mensagem de erro customizada
		if ( is_string( $retorno ) ) {
			return erro( $campo["msg_$retorno"] );
		} elseif ( is_array( $retorno ) ) {
			$retorno[0] = $campo["msg_$retorno[0]"];
			return erro( call_user_func_array( 'sprintf', $retorno ) );
		// Retorno booleano simples
		} elseif ( !$retorno ) {
			return erro( $campo['msg_invalido'] );
		}
	}
	
	return true;
	
}



// Booleanos



function sanitizarBoolean( $valor ) {
	// Transforma um valor em 1 ou 0
	$valor = $valor
		? 1
		: 0
	;
	return $valor;
}

function sanitizarBooleanInvertido( $valor ) {
	// Sanitiza um valor booleano e inverte-o
	return $valor
		? 0
		: 1
	;
}

function validarTrue( $valor ) {
	// Verifica se um valor converte em TRUE
	return (bool) $valor;
}



// Numéricos



function sanitizarNumerico( $valor ) {
	// Remove caracteres que não sejam números, mas mantém como string e deixa zeros à esquerda
	if ( is_string( $valor ) )
		$valor = preg_replace( '#\D#', '', $valor );
	return $valor;
}

function sanitizarInteiro( $valor ) {
	// Retorna um número inteiro
	return (int) trim( $valor );
}

function sanitizarNatural( $valor ) {
	// Retorna um número natural (inteiro positivo)
	$valor = (int) trim( $valor );
	return abs( $valor );
}

function sanitizarTamanho( $valor ) {
	// Processa um valor em bytes com ou sem prefixo nos formatos KB, KiB e K
	$int = intval( $valor );
	$unidades = 'KMGTP';
	if ( preg_match( "/([$unidades])(?:B|iB)?$/i", $valor, $matches ) ) {
		$potencia = 1 + strpos( $unidades, $matches[1] );
		$int *= pow( 1024, $potencia );
	}
	return $int;
}

function formatarTamanho( $bytes, $decimals = 2 ) {
	// Retorna o tamanho em formato legível
	// by rommel at rommelsantor dot com
	// http://id1.php.net/manual/en/function.filesize.php#106569
	$sz = 'BKMGTP';
	$factor = floor( (strlen( $bytes ) - 1 ) / 3 );
	return sprintf( "%.{$decimals}f", $bytes / pow( 1024, $factor ) ) . @$sz[ $factor ];
}



// Nomes



function validarNomeCompleto( $valor ) {
	// Verifica se há pelo menos duas palavras
	return preg_match( '/[^\s]{2,}\s[^\s]{2,}/', $valor );
}

function validarVariavel( $valor ) {
	// Verifica se é nome de variável válido
	return preg_match( '/^[a-z][_a-z0-9]*$/i', $valor );
}

function validarUsername( $valor ) {
	// Verifica se o username utiliza caracteres válidos e é único no sistema
	// @requer exclusivo()
	global $usuarioAlvo, $campos;
	// Validação padrão
	if ( !validarVariavel( $valor ) )
		return false;
	// Username existente não mudou
	if ( $usuarioAlvo && $valor == $usuarioAlvo->user_login )
		return true;
	// Verifica se o username é único no sistema
	if ( !exclusivo( 'user_login', $valor, USER_DATA ) )
		return 'existente';
	return true;
}

function separarNomes( $nomeCompleto ) {
	// Retorna uma array com 3 índices: primeiro nome, nomes do meio e sobrenome
	preg_match( '/^(\S+?)\s+(?:(.+?)\s+)?(\S+)$/', trim( $nomeCompleto ), $nomes );
	if ( !$nomes ) {
		return array( $nomeCompleto, '', '' );
	}
	$nomes[2] = trim( $nomes[2] );
	array_shift( $nomes );
	return $nomes;
}

function sluggify( $valor ) {
	// Converte um nome em um slug (alfanumérico em minúsculas com subtraços)
	if ( !is_string( $valor ) || !$valor )
		return '';
	$valor = mb_strtolower( trim( $valor ) );
	$acentosDe		= array( 'à', 'á', 'ã', 'è', 'é', 'ê', 'ì', 'í', 'ò', 'ó', 'õ', 'ô', 'ú', 'ü', 'ç', 'ñ' );
	$acentosPara	= array( 'a', 'a', 'a', 'e', 'e', 'e', 'i', 'i', 'o', 'o', 'o', 'o', 'u', 'u', 'c', 'n' );
	$espacos		= array( ' ', "\t", '-', '.', ',', '/', '\\', '(', ')' );
	$valor = str_replace( $acentosDe, $acentosPara, $valor );
	$valor = str_replace( $espacos, '_', $valor );
	$valor = preg_replace( '#[^_a-z0-9]#', '', $valor );
	$valor = preg_replace( '#^[_0-9]+|_\K_+|_+$#', '', $valor );
	return $valor;
}



// E-mails



global $emailRegexp;

$emailRegexp = '#^(?:[a-zA-Z0-9_\'^&amp;/+-])+(?:\.(?:[a-zA-Z0-9_\'^&amp;/+-])+)*@(?:(?:\[?(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\.){3}(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\]?)|(?:[a-zA-Z0-9-]+\.)+(?:[a-zA-Z]){2,}\.?)$#';

function validarEmail( $valor ) {
	// Retorna se é um e-mail válido
	global $emailRegexp;
	if ( !$valor )
		return false;
	if ( !preg_match( $emailRegexp, $valor ) )
		return false;
	return true;
}

function validarEmailUsuario( $valor ) {
	// Verifica se o endereço é válido e é único no sistema
	// @requer exclusivo()
	global $usuarioAlvo, $campos;
	// Validação padrão
	if ( !validarEmail( $valor ) )
		return false;
	// E-mail utilizado atualmente não mudou
	if ( $usuarioAlvo && $valor == $usuarioAlvo->user_email )
		return true;
	// Verifica se o endereço é único no sistema
	if ( !exclusivo( 'user_email', $valor, USER_DATA ) )
		return 'existente';
	return true;
}

function validarSufixos( $valor ) {
	// Verifica se os sufixos na array são válidos
	$regexpSufixo = '/^(?:[-_a-zA-Z0-9]+\.)+[a-zA-Z]{2,5}$/';
	if ( !$valor )
		return false;
	if ( !is_array( $valor ) )
		$valor = array( $valor );
	foreach ( $valor as $sufixo ) {
		if ( !preg_match( $regexpSufixo, $sufixo ) )
			return false;
	}
	return true;
}

function prepararMensagem( $mensagem, $tokensExtras = array() ) {
	// Substitui os tokens da mensagem com os tokens globais e os $tokensExtras
	// @requer formatarData, obter
	static $tokensGlobais;
	if ( !$tokensGlobais ) {
		$tokensGlobais = array(
			'nome_site' => wp_specialchars_decode( get_option('blogname'), ENT_QUOTES ),
			'home_url' => site_url('/'),
			'admin_url' => admin_url('/'),
			'data' => formatarData( time() ),
			'hora' => date('h:i'),
			'login_url' => site_url('/conta'),
		);
	}
	$tokens = array_merge( $tokensGlobais, $tokensExtras );
	// Substitui os tokens disponíveis
	foreach ( $tokens as $token => $valor ) {
		$mensagem = str_replace( "<%$token%>", $valor, $mensagem );
	}
	// Remove todos os tokens não utilizados
	$mensagem = preg_replace( '#<%.*?%>#', '', $mensagem );
	// Substitui palavras com gênero utilizando o token 'sexo' como referência, se existente
	$offset = 0;
	$fem = obter( $tokens, 'sexo', 0 );
	while ( preg_match( '#\[(.+?)/(.+?)\]#', $mensagem, $match, PREG_OFFSET_CAPTURE, $offset ) ) {
		$palavra = $fem
			? $match[2][0]
			: $match[1][0]
		;
		$mensagem = str_replace( $match[0][0], $palavra, $mensagem );
		$offset += strlen( $palavra );
	}
	return $mensagem;
}

function anexarRodape( $mensagem = '' ) {
	// Adiciona o rodapé ao final da mensagem
	// @requer inc/config-associacao.php
	global $associacao_config;
	return $mensagem . PHP_EOL . PHP_EOL . $associacao_config['email_rodape'];
}



// URLs



global $linkRegexp;

$linkRegexp = '#(http:\/\/.*?)(?:\s|$)#';

function linkify( $texto ) {
	// Encontra URLs no texto e transforma em âncoras HTML
	global $linkRegexp;
	$texto = preg_replace( $linkRegexp, '<a href="\1">\1</a>', $texto );
	return $texto;
}

function sanitizarURL( $valor ) {
	// Adiciona http ao URL se estiver faltando
	$valor = strtolower( trim( $valor ) );
	if ( !preg_match( '#^https?://#', $valor ) )
		$valor = 'http://' . $valor;
	return $valor;
}

function validarURL( $valor ) {
	// Valida se a porção do domínio é válida
	return preg_match( '#^https?://(?:[a-z][-a-z0-9]{2,}\.)+[a-z]{2,}(?:/|$)#', $valor );
}

function extrairTLD( $valor ) {
	// Obtém o top-level domain (TLD) de uma URL ou de um e-mail
	preg_match( '#([a-z][-a-z0-9]+(?:\.[a-z]{2,4})+)(?:/|$)#', $valor, $matches );
	if ( !$matches || !isset( $matches[1] ) )
		return '';
	else
		return str_replace( 'www.', '', $matches[1] );
}



// Senha



function validarSenha( $valor ) {
	global $config;
	if ( !$valor )
		return false;
	$len = strlen( $valor );
	if ( $len < $config['senha_min'] || $len > $config['senha_max'] )
		return false;
	return true;
}

function validarRepetirSenha( $valor ) {
	return $valor == $_POST['senha'];
}

function validarConfirmarSenha( $valor ) {
	// Só funciona para o usuário atual
	// @requer obterUsuario
	if ( !$valor )
		return false;
	$usuario = obterUsuario();
	if ( !$usuario )
		return false;
	// $auth = apply_filters( 'authenticate', null, $usuario->user_login, $valor );
	$auth = wp_check_password( $valor, $usuario->user_pass, $usuario->ID );
	if ( !$auth )
		return false;
	return true;
}



// Listas e arrays

function sanitizarLista( $valor ) {
	// Transforma uma lista separada por vírgulas em array
	$lista = explode( ',', $valor );
	$lista = array_map( 'trim', $lista );
	return $lista;
}



// Preços



function formatarPreco( $valor, $html = true ) {
	$valor = (string) $valor;
	if ( $valor === '' )
		return '';
	$minus = false;
	if ( substr( $valor, 0, 1 ) == '-' ) {
		$minus = true;
		$valor = substr( $valor, 1 );
	}
	$len = strlen( $valor );
	if ( $len < 3 ) {
		$valor = str_pad( $valor, 3, '0', STR_PAD_LEFT );
		$len = 3;
	}
	$valor = ( $html ? '<span class="preco' . ( $minus ? ' preco-negativo' : '' ) . '">' : '' )
			   . ( $html ? '<span class="moeda">' : '' )
			   . 'R$'
			   . ( $html ? '</span><span class="unidade">' : '' )
			   . ( $minus ? '-' : '' )
			   . ( $len > 11 ? substr( $valor, -14, -11 ) . '.' : '' )
			   . ( $len > 8 ? substr( $valor, -11, -8 ) . '.' : '' )
			   . ( $len > 5 ? substr( $valor, -8, -5 ) . '.' : '' )
			   . substr( $valor, -5, -2 )
			   . ( $html ? '</span><span class="centavos">' : '' )
			   . ','
			   . substr( $valor, -2 )
			   . ( $html ? '</span>' : '' )
		   . ( $html ? '</span>' : '' )
	;
	return $valor;
}



// CNPJ



function validarCNPJ( $x ) {
	// Validação de CPF, escrito por Michael
	// http://phpbrasil.com/script/DJH2yYgfq-Z5/validando-cnpj-com-php
	$soma1=0;
	$soma2=0;
	$cnpj=ereg_replace ("[^0-9]","",$x); // Retiramos todos os caracteres que não sejam números
	if ( !$cnpj ) return false;
	$cnpj=sprintf("%014s",$cnpj); // Preenche os campos vazios com zero, caso o cnpj da pessoa tenha menos de 14 digitos.
	$a=array (5,4,3,2,9,8,7,6,5,4,3,2);
	foreach ($a as $j=>$i) {
		$soma1+=$cnpj[$j]*$i;
	}
	$v1=($soma1%11<2?0:11-($soma1%11)); // Se o módolo da soma for menor que 2, resultamos no validador 1, caso contrário o validador 1 será o resto do próprio módulo por 11
	$a=array (6,5,4,3,2,9,8,7,6,5,4,3);
	foreach ($a as $j=>$i) {
		$soma2+=$cnpj[$j]*$i;
	}
	$soma2+=$v1*2;
	$v2=($soma2%11<2?0:11-($soma2%11)); // Se o módolo da soma for menor que 2, resultamos no validador 1, caso contrário o validador 1 será o resto do próprio módulo por 11
	$r=($v1.$v2==substr($cnpj,-2)?true:false);
	if (strlen($cnpj)!=14) { // Verificando a quantidade de caracteres digitados no CNPJ
		$r=false;
	}
	return $r;
}

function validarCNPJEntidade( $valor ) {
	// @requer exclusivo()
	global $entidadeAlvo, $campos;
	// Validação padrão
	if ( !validarCNPJ( $valor ) )
		return false;
	// CNPJ existente não mudou
	if ( $entidadeAlvo && $valor == $entidadeAlvo->cnpj )
		return true;
	// Verifica se o CNPJ é único no sistema
	if ( !exclusivo( 'cnpj', $valor, USER_META ) )
		return 'existente';
	return true;
}

function formatarCNPJ( $valor ) {
	$valor = (string) $valor;
	if ( $valor === '' )
		return '';
	return substr( $valor, 0, 2 ) . '.'
		 . substr( $valor, 2, 3 ) . '.'
		 . substr( $valor, 5, 3 ) . '/'
		 . substr( $valor, 8, 4 ) . '-'
		 . substr( $valor, 12 );
}



// CPF



function validarCPF( $cpf = null ) {
 
    // Verifica se um número foi informado
    if(empty($cpf)) {
        return false;
    }
 
    // Elimina possivel mascara
    $cpf = ereg_replace('[^0-9]', '', $cpf);
    $cpf = str_pad($cpf, 11, '0', STR_PAD_LEFT);
     
    // Verifica se o numero de digitos informados é igual a 11
    if (strlen($cpf) != 11) {
        return false;
    }
    // Verifica se nenhuma das sequências invalidas abaixo
    // foi digitada. Caso afirmativo, retorna falso
    else if ($cpf == '00000000000' ||
        $cpf == '11111111111' ||
        $cpf == '22222222222' ||
        $cpf == '33333333333' ||
        $cpf == '44444444444' ||
        $cpf == '55555555555' ||
        $cpf == '66666666666' ||
        $cpf == '77777777777' ||
        $cpf == '88888888888' ||
        $cpf == '99999999999') {
        return false;
     // Calcula os digitos verificadores para verificar se o
     // CPF é válido
     } else {  
         
        for ($t = 9; $t < 11; $t++) {
             
            for ($d = 0, $c = 0; $c < $t; $c++) {
                $d += $cpf{$c} * (($t + 1) - $c);
            }
            $d = ((10 * $d) % 11) % 10;
            if ($cpf{$c} != $d) {
                return false;
            }
        }
 
        return true;
    }
	
}

function validarCPFUsuario( $valor ) {
	// @requer exclusivo()
	global $usuarioAlvo, $campos;
	// Validação padrão
	if ( !validarCPF( $valor ) )
		return false;
	// CPF existente não mudou
	if ( $usuarioAlvo && $valor == $usuarioAlvo->cpf )
		return true;
	// Verifica se o CPF é único no sistema
	if ( !exclusivo( 'cpf', $valor, USER_META ) )
		return 'existente';
	return true;
}

function formatarCPF( $valor ) {
	$valor = (string) $valor;
	if ( $valor === '' )
		return '';
	return substr( $valor, 0, 3 ) . '.'
		 . substr( $valor, 3, 3 ) . '.'
		 . substr( $valor, 6, 3 ) . '-'
		 . substr( $valor, 9, 2 );
}



// Sexo



function formatarSexo( $valor ) {
	if ( $valor == 1 )
		return 'Feminino';
	if ( $valor == 2 )
		return 'Masculino';
	return '';
}

function oa( $fem = 'a', $mas = 'o' ) {
	// Retorna $fem ou $mas, dependendo do sexo do usuário
	$user_id = get_current_user_id();
	$sexo = get_user_meta( $user_id, 'sexo', true );
	return $sexo == 'F'
		? $fem
		: $mas
	;
}



// Endereço e CEP



function validarCEP( $valor ) {
	return strlen( $valor ) == 8;
}

function formatarCEP( $valor ) {
	$valor = (string) $valor;
	if ( $valor === '' )
		return '';
	return substr( $valor, 0, 5 ) . '-'
		 . substr( $valor, 5, 3 );
}

function sanitizarEstado( $valor ) {
	if ( !$valor )
		return '';
	$valor = strtoupper( substr( $valor, 0, 2 ) );
	return $valor;
}

function formatarEndereco( $dados, $usarComplemento = true ) {
	// Retorna o endereço completo a partir do array de $dados
	return $dados['endereco'] . ', ' . ', ' . ( $usarComplemento && $dados['complemento'] ? $dados['complemento'] : '' ) . $dados['bairro'] . ' &ndash; ' . $dados['cidade'] . ' / ' . $dados['estado'] . ' &ndash; CEP ' . $dados['cep'];
	//  . ( $dados['numero'] ? $dados['numero'] : 'sem número' )
}



// Telefone



function formatarTelefone( $valor ) {
	$valor = (string) $valor;
	if ( $valor === '' )
		return '';
	$len = strlen( $valor );
	$tel = '(';
	if ( empty( $valor ) )
		return '';
	$tel .= substr( $valor, 0, 2 ) . ') ';
	if ( $len == 11 ) {
		$tel .= substr( $valor, 2, 3 ) . '-'
			  . substr( $valor, 5, 3 ) . '-'
			  . substr( $valor, 8, 3 );
	} else {
		$tel .= substr( $valor, 2, 4 ) . '-'
			  . substr( $valor, 6, 4 );
	}
	return $tel;
}



// Datas



function formatarData( $data ) {
	if ( !$data )
		return '';
	if ( !is_numeric( $data ) ) {
		$data = strtotime( $data );
	}
	return date( 'd/m/Y', $data );
}

function formatarTempo( $data ) {
	if ( empty( $data ) )
		return '';
	if ( !is_numeric( $data ) ) {
		$data = strtotime( $data );
	}
	return date( 'd/m/Y H:i', $data );
}

function idade( $nascimento ) {
	if ( !is_numeric( $nascimento ) )
		$nascimento = strtotime( $nascimento );
	$idade = round( ( time() - $nascimento ) / YEAR_IN_SECONDS );
	return $idade;
}

function validarIdade( $birthday, $age = 18 ) {

	// $birthday can be UNIX_TIMESTAMP or just a string-date.
	if( !is_numeric($birthday) ){
		$birthday = strtotime($birthday);
	}

	// check
	// 31536000 is the number of seconds in a 365 days year.
	if( time() - $birthday < $age * 31536000 ) {
		return false;
	}

	return true;

}

function sanitizarData( $data ) {
	if ( preg_match( '#^[0-3][0-9]/[01][0-9]/[12][09][0-9][0-9]$#', $data ) ) {
		// Converte de dd/mm/YYYY para ISO YYYY-mm-dd
		$data =
			substr( $data, 6, 4 ) . '-' .
			substr( $data, 3, 2 ) . '-' .
			substr( $data, 0, 2 );
	} elseif ( preg_match( '#^[12][09][0-9][0-9]-[01][0-9]-[0-3][0-9]$#', $data ) ) {
	} else {
		$data = '';
	}
	return $data;
}

global $originalDias, $traducaoDias, $originalMeses, $traducaoMeses;

$originalDias = array( 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' );
$traducaoDias = array( 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado', 'Domingo' );
$originalMeses = array( 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' );
$traducaoMeses = array( 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro' );

function traduzirData( $data ) {
	global $originalDias, $traducaoDias, $originalMeses, $traducaoMeses;
	$data = str_ireplace( $originalDias, $traducaoDias, $data );
	$data = str_ireplace( $originalMeses, $traducaoMeses, $data );
	return $data;
}

function validarDataPassada( $data ) {
	if ( !$data || !is_numeric( $data ) )
		return false;
	return $data <= time();
}

function ajustarFusoHorario() {
	// Ajusta o fuso horário, para utilizar na função date()
	$current_offset = get_option('gmt_offset');
	$tzstring = get_option('timezone_string');
	if ( empty($tzstring) ) { // Create a UTC+- zone if no timezone string exists
		if ( 0 == $current_offset )
			$tzstring = 'UTC+0';
		elseif ($current_offset < 0)
			$tzstring = 'UTC' . $current_offset;
		else
			$tzstring = 'UTC+' . $current_offset;
	}
	date_default_timezone_set( $tzstring );
	return $tzstring;
}



// JSON



function sanitizarJSON( $valor ) {
	// Transforma uma string JSON em array, ou retorna uma array vazia
	if ( !$valor || !is_string( $valor ) )
		return array();
	$valor = json_decode( $valor, true );
	if ( !$valor )
		return array();
	return $valor;
}



// Usuários



function validarUsuario( $id ) {
	// Verifica se existe um usuário com este ID
	global $wpdb;
	$query = $wpdb->prepare( "SELECT `id` FROM $wpdb->users WHERE id=%d", $id );
	$existe = $wpdb->get_row( $query );
	return !is_null( $existe );
}

function validarUsuarioPeloEmail( $email ) {
	// Verifica se existe um usuário com este e-mail e retorna o ID
	// @requer umDe()
	global $wpdb;
	$query = $wpdb->prepare( "SELECT `id` FROM $wpdb->users WHERE user_email='%s'", $email );
	$existe = $wpdb->get_row( $query );
	return umDe(
		is_null( $existe ),
		$existe->id
	);
}
