<?php
/*
 * Formulários, inputs e formatação de dados
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
// Funções gerais



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

function separarNomes( $nomeCompleto ) {
	// Retorna uma array com 3 índices: primeiro nome, os do meio e o último
	preg_match( '/^(\w+?\b)(.*?)(\b\w+)$/', $nomeCompleto, $nomes );
	$nomes[2] = trim( $nomes[2] );
	shift( $nomes );
	return $nomes;
}



// Verificação dos campos



function processarCampos( $perfil, $prefixo = '' ) {
	// Processa todos os campos deste $perfil, obtendo do $_POST e rodando a validação automática em cada um
	global $perfis;
	$statusGeral = true;
	erro( toString( $perfil ) );
	erro( toString( $perfis ) );
	$camposDoPerfil = $perfis[ $perfil ]['campos'];
	obterPost( array_keys( $camposDoPerfil ) );
	foreach( $camposDoPerfil as $slug => $obrigatorio ) {
		$statusGeral = verificarValor( $slug, $obrigatorio, $prefixo ) && $statusGeral;
	}
	return $statusGeral;
}

function verificarValor( $slug, $obrigatorio = false, $prefixo ) {

	// Roda os processos automatizados de verificação em um valor e gera as mensagens
	// Opcionalmente adiciona um $prefixo e subtraço aos nomes dos campos
	
	global $campos, $listas;
	
	$postSlug = $prefixo
		? "$prefixo_$slug"
		: $slug
	;
	$valor =& $_POST[ $postSlug ];
	$campo =& $campos[ $slug ];
	
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



// Validação genérica



function sanitizarNumerico( $valor ) {
	// Remove caracteres que não sejam números, mas mantém como string e deixa zeros à esquerda
	if ( is_string( $valor ) )
		$valor = preg_replace( '#\D#', '', $valor );
	return $valor;
}

function sanitizarInteiro( $valor ) {
	// Retorna um número inteiro
	$valor = sanitizarNumerico( $valor );
	return (int) $valor;
}

function sanitizarNatural( $valor ) {
	// Retorna um número natural (positivo)
	$valor = sanitizarNumerico( $valor );
	return abs( $valor );
}

function sanitizarBoolean( $valor ) {
	$valor = $valor
		? 1
		: 0
	;
	return $valor;
}

function vazio( $valor ) {
	// Verifica se um valor é realmente vazio
	if ( is_string( $valor ) )
		return $valor === '';
	return !$valor;
}



// E-mails



$emailRegexp = '#^(?:[a-zA-Z0-9_\'^&amp;/+-])+(?:\.(?:[a-zA-Z0-9_\'^&amp;/+-])+)*@(?:(?:\[?(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\.){3}(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\]?)|(?:[a-zA-Z0-9-]+\.)+(?:[a-zA-Z]){2,}\.?)$#';

function validarEmail( $valor ) {
	global $emailRegexp;
	if ( !$valor )
		return false;
	if ( !preg_match( $emailRegexp, $valor ) )
		return false;
	return true;
}

function validarEmailUsuario( $valor ) {
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



// Senha



function validarSenha( $valor ) {
	global $config;
	if ( !$valor )
		return false;
	$len = strlen( $valor );
	if ( $len < 6 || $len > 32 )
		return false;
	return true;
}

function validarRepetirSenha( $valor ) {
	if ( $valor != $_POST['senha'] )
		return false;
	return true;
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



function sanitizarSexo( $valor ) {
	$valor = (int) $valor;
	if ( $valor != 1 && $valor != 2 )
		return 0;
	return $valor;
}

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
	return $sexo == 1
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

function formatarEndereco( $dados ) {
	// Retorna o endereço completo a partir do array de $dados
	return $dados['endereco'] . ', ' . ( $dados['numero'] ? $dados['numero'] : 'sem número' ) . ', ' . ( $dados['complemento'] ? $dados['complemento'] : '' ) . $dados['bairro'] . ' &ndash; ' . $dados['cidade'] . ' / ' . $dados['estado'] . ' &ndash; CEP ' . $dados['cep'];
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
	if ( is_string( $data ) ) {
		$data = strtotime( $data );
	}
	return date( 'd/m/Y', $data );
}

function idade( $nascimento ) {
	if ( is_string( $nascimento ) )
		$nascimento = strtotime( $nascimento );
	$idade = round( ( time() - $nascimento ) / YEAR_IN_SECONDS );
	return $idade;
}

function validarIdade( $birthday, $age = 18 ) {

	// $birthday can be UNIX_TIMESTAMP or just a string-date.
	if( is_string($birthday) ){
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



// URLs



$linkRegexp = '#(http:\/\/.*?)(?:\s|$)#';

function linkify( $texto ) {
	global $linkRegexp;
	$texto = preg_replace( $linkRegexp, '<a href="\1">\1</a>', $texto );
	return $texto;
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


