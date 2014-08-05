<?php
/*
Plugin Name: Importar Usuários
Plugin URI: http://montarsite.com.br
Description: Permite importar empresas e usuários exportados do portal antigo da ASUG.
Version: 1.0
Author: MontarSite
Author URI: http://montarsite.com.br
License: Copyright. Todos os direitos reservados.
*/



// Config

$imp_config = array(
	'caminho_plugin'		=> null,
	'caminho_arquivos'		=> null,
	'url_arquivos'			=> null,
	'arquivo_importar'		=> 'importar-usuarios.csv',
	'arquivo_exportar'		=> 'exportar-usuarios.csv',
	'arquivo_bloqueados'	=> 'usuarios-bloqueados.csv',
);

$imp_traduzirValores = array();
$imp_cronometro = null;



// Inicialização

function imp_ativarPlugin() {
	// Roda na ativação
}

register_activation_hook( __FILE__, 'imp_ativarPlugin' );

function imp_init() {
	// Inicializa o plugin
	global $imp_config, $imp_traduzirValores;
	$imp_config['caminho_plugin'] = untrailingslashit( dirname( __FILE__ ) );
	$caminhosDeUpload = wp_upload_dir(null);
	$imp_config['caminho_arquivos'] = untrailingslashit( $caminhosDeUpload['basedir'] );
	$imp_config['url_arquivos'] = untrailingslashit( $caminhosDeUpload['baseurl'] );
	if ( !function_exists('csv_to_array') )
		require_once "$imp_config[caminho_plugin]/csv_to_array.php";
	$imp_traduzirValores += array(
		'tipo_associacao' => array(
			'AC' => 2,
			'AP' => 4,
			'CA' => 1,
			'CP' => 3,
			'CS' => 1,
			'PS' => 5,
		),
		'status' => array(
			'L' => 0,
			'S' => 1,
			'A' => 0,
			'E' => 1,
			'I' => 1,
		),
		'cargo' => array(
			0 => -1,
		),
		'ramo' => array(
			0 => -1,
		),
		'qtd_funcionarios' => array(
			0 => -1,
		),
		'qtd_usuarios' => array(
			0 => -1,
		),
		'faturamento' => array(
			0 => -1,
		),
		'funcao' => array(
			'B' => FUNCAO_FUNCIONARIO,
			'R' => FUNCAO_REPRESENTANTE,
		),
		'informativo' => array(
			'S' => 1,
			'N' => 0,
		),
	);
}

add_action('init', 'imp_init');



// Painel Admin

function imp_criarMenu() {
	// Cria o item no menu do admin
	add_submenu_page(
		'users.php',
		'Importar Usuários',
		'Importar',
		10,
		'importar',
		'imp_renderizarPainelAdmin'
	);
}

add_action('admin_menu', 'imp_criarMenu');

function imp_renderizarPainelAdmin() {
	// Renderiza o painel no admin
	// @requer obterPost, sanitizarPost
	global $wpdb, $imp_config, $imp_cronometro, $erros, $mensagens;
	$info = array();
	$postExiste = !empty( $_POST );
	$vars = array(
		'acao',
		'fonte',
		'upload',
		'texto',
		'texto_csv',
		'inicio',
		'fim',
		'tipo',
		'confirmar_email',
	);
	if ( $postExiste ) {
		// obterPost( $vars );
		// sanitizarPost( $vars );
		extract( $_POST, EXTR_PREFIX_ALL, 'post' );
		require "$imp_config[caminho_plugin]/ctrl.painel-admin.php";
	}
	require "$imp_config[caminho_plugin]/painel-admin.php";
}



// Funções auxiliares

function imp_filterNull( $valor ) {
	// Filtra strings 'NULL'
	return !is_null( $valor ) && ( is_string( $valor ) ? $valor && $valor !== 'NULL' && $valor !== 'Não informado' : true );
}

function imp_uploadExistente() {
	// Retorna o caminho de um arquivo previamente enviado, se existir
	global $imp_config;
	$caminho = "$imp_config[caminho_arquivos]/$imp_config[arquivo_importar]";
	if ( file_exists( $caminho ) )
		return $caminho;
	else
		return false;
}

function imp_carregarUpload() {
	// Carrega as entradas do upload, se existir
	// @requer csv_to_array
	$arquivo = imp_uploadExistente();
	if ( !$arquivo )
		return false;
	return csv_to_array( $arquivo );
}

function imp_exportar( $entradas ) {
	// Salva as $entradas no arquivo de exportação
	// @requer ansi
	global $imp_config;
	$caminho = "$imp_config[caminho_arquivos]/$imp_config[arquivo_exportar]";
	$novoArquivo = !file_exists( $caminho );
	$arquivo = fopen( $caminho, 'a' );
	if ( $novoArquivo ) {
		$string = '"user_id";"nome_completo";"email_cadastro";"url_confirmacao";"data_importacao";"id_velho"' . PHP_EOL;
		fwrite( $arquivo, ansi( $string ) );
	}
	foreach ( $entradas as $usuario ) {
		$string = '"' . implode( '";"', $usuario ) . '"' . PHP_EOL;
		fwrite( $arquivo, ansi( $string ) );
	}
	fclose( $arquivo );
	return true;
}

function imp_exportarBloqueados( $entradas ) {
	// Salva as $entradas no arquivo de exportação
	// @requer array_to_csv, ansi
	global $imp_config;
	$caminho = "$imp_config[caminho_arquivos]/$imp_config[arquivo_bloqueados]";
	$arquivo = fopen( $caminho, 'w' );
	$string = array_to_csv( $entradas );
	fwrite( $arquivo, ansi( $string ) );
	fclose( $arquivo );
	return true;
}

function imp_obterUsuariosImportados( $eEmpresa = false ) {
	// Retorna uma lista com IDs dos usuários importados
	global $wpdb;
	$campoID = $eEmpresa
		? 'id_velho_empresa'
		: 'id_velho'
	;
	$busca = $wpdb->get_col( "SELECT user_id FROM $wpdb->usermeta WHERE meta_key='$campoID'" );
	return $busca;
}



// Função principal

function imp_importar( $entradas, $eEmpresa = false, $inicio = 0, $fim = 9999, $notificar = false ) {
	// Importa os usuários/empresas em $entradas, criando usuários correspondentes no BD
	// @requer classe Relacao, classe Cronometro
	// @requer atualizarUsuario, obterItem, buscarUsuarioVelho
	global $wpdb, $imp_config, $imp_traduzirValores, $estruturaPerfil, $estruturaEmpresa, $imp_cronometro;
	if ( !$imp_cronometro )
		$imp_cronometro = new Cronometro();
	$total = count( $entradas );
	$exportar = array();
	$horario = date('d/m/Y h:i');
	$importados = 0;
	$bloqueados = array(
		'status' => 0, // status_negativo
		'incompleto' => 0, // dados_incompletos
		'duplicado' => 0, //
		'pre_existente' => 0, // pre_existente
		'sem_empresa' => 0, // empresa_inexistente
		'falha' => 0, // dados_invalidos
	);
	$exportarBloqueados = array();
	// Determina a estrutura a utilizar
	if ( $eEmpresa )
		$estrutura =& $estruturaEmpresa;
	else
		$estrutura =& $estruturaPerfil;
	// Loop
	for ( $i = $inicio; $i <= $fim && $i < $total; $i++ ) {
		$imp_cronometro->terminarOperacao('importar');
		$imp_cronometro->iniciarOperacao('importar');
		$entradaLimpa = array_filter( $entradas[$i], 'imp_filterNull' );
		$entradaLimpa = array_map( 'trim', $entradaLimpa );
		$perfil = $estrutura->traduzir( $entradaLimpa, ESTRUTURA_ASUG_VELHO, ESTRUTURA_ASUG_NOVO );
		// Converte valores
		foreach ( $perfil as $campo => $valor ) {
			if ( isset( $imp_traduzirValores[ $campo ] ) ) {
				if ( isset( $imp_traduzirValores[ $campo ][ $valor ] ) )
					// Valor equivalente
					$perfil[ $campo ] = $imp_traduzirValores[ $campo ][ $valor ];
				else
					// Valor padrão
					$perfil[ $campo ] = $imp_traduzirValores[ $campo ][0];
			}
		}
		// Pula usuários excluídos ou desativados
		if ( isset( $perfil['status'] ) ) {
			if ( $perfil['status'] == 1 ) {
				$bloqueados['status']++;
				$entradas[$i]['erro'] = 'status_negativo';
				$exportarBloqueados[] =& $entradas[$i];
				continue;
			}
		}
		// Verifica o ID
		$campoID = $eEmpresa
			? 'id_velho_empresa'
			: 'id_velho'
		;
		if ( !isset( $perfil[ $campoID ] ) ) {
			$bloqueados['incompleto']++;
			$entradas[$i]['erro'] = 'dados_incompletos';
			$exportarBloqueados[] =& $entradas[$i];
			continue;
		}
		// Verifica se este usuário já foi importado antes
		$id = buscarUsuarioVelho( $perfil[ $campoID ], $eEmpresa );
		// $query = $wpdb->prepare( "SELECT `user_id` FROM `$wpdb->usermeta` WHERE `meta_key`='$campoID' AND `meta_value`=%d", $perfil[ $campoID ] );
		// $id = $wpdb->query( $query );
		if ( $id ) {
			$bloqueados['duplicado']++;
			// $exportarBloqueados[] =& $entradas[$i];
			continue;
		}
		// Define o status - empresas e usuários são pré-ativados
		$perfil['status'] = $eEmpresa || isset( $perfil['funcao'] ) && $perfil['funcao'] == FUNCAO_USUARIO
			? 0
			: 1
		;
		// Verifica por campos importantes faltantes e realiza ajustes
		if ( !isset( $perfil['display_name'] ) || !$perfil['display_name'] ) {
			$bloqueados['incompleto']++;
			$entradas[$i]['erro'] = 'dados_incompletos';
			$exportarBloqueados[] =& $entradas[$i];
			continue;
		}
		if ( $eEmpresa ) {
			// Função
			if ( !isset( $perfil['tipo_associacao'] ) ) {
				$bloqueados['incompleto']++;
				$entradas[$i]['erro'] = 'dados_incompletos';
				$exportarBloqueados[] =& $entradas[$i];
				continue;
			}
			$perfil['role'] = obterItem( 'role_associacao', $perfil['tipo_associacao'] );
			// Lista os sufixos
			if ( !isset( $perfil['sufixo'] ) ) {
				$bloqueados['incompleto']++;
				$entradas[$i]['erro'] = 'dados_incompletos';
				$exportarBloqueados[] =& $entradas[$i];
				continue;
			}
			$perfil['sufixo'] = str_replace( '@', '', $perfil['sufixo'] );
			$perfil['sufixo'] = preg_replace( '/[\s,;]+/', '|', $perfil['sufixo'] );
			$perfil['sufixo'] = explode( '|', $perfil['sufixo'] );
			// Verifica se os sufixos existem no portal
			foreach ( $perfil['sufixo'] as $index => $sufixo ) {
				if ( buscarEmpresa( $sufixo ) ) {
					unset( $perfil['sufixo'][ $index ] );
					continue;
				}
			}
			// Verifica se sobrou algum sufixo original na empresa
			if ( !$perfil['sufixo'] ) {
				$bloqueados['pre_existente']++;
				$entradas[$i]['erro'] = 'pre_existente';
				$exportarBloqueados[] =& $entradas[$i];
				continue;
			}
			// Website
			if ( !isset( $perfil['user_url'] ) ) {
				$perfil['user_url'] = 'http://' . ( is_array( $perfil['sufixo'] )
					? $perfil['sufixo'][0]
					: $perfil['sufixo']
				);
			}
			// Representante 1
			$perfil['representante1'] = '';
			// Representante 2
			$perfil['representante2'] = array(
				'nome_completo' => '',
				'email' => '',
				'cargo' => '',
				'nivel_cargo' => '',
				'telefone' => '',
			);
			if ( isset( $perfil['rep2_nome_completo'] ) ) {
				$perfil['representante2']['nome_completo'] = $perfil['rep2_nome_completo'];
				unset( $perfil['rep2_nome_completo'] );
			}
			// CIO
			$perfil['cio'] = array(
				'nome_completo' => '',
				'email' => '',
				'cargo' => '',
				'nivel_cargo' => '',
				'telefone' => '',
			);
			// Financeiro
			$perfil['financeiro'] = array(
				'nome_completo' => '',
				'email' => '',
				'cargo' => '',
				'nivel_cargo' => '',
				'telefone' => '',
			);
			if ( isset( $perfil['fin_nome_completo'] ) ) {
				$perfil['financeiro']['nome_completo'] = $perfil['fin_nome_completo'];
				unset( $perfil['fin_nome_completo'] );
			}
			if ( isset( $perfil['fin_email'] ) ) {
				$perfil['financeiro']['email'] = $perfil['fin_email'];
				unset( $perfil['fin_email'] );
			}
			// Demais
			if ( isset( $perfil['cnpj'] ) ) {
				$perfil['cnpj'] = sanitizarNumerico( $perfil['cnpj'] );
			}
			if ( !isset( $perfil['versao_erp'] ) ) {
				$perfil['versao_erp'] = '';
			}
			$perfil['contato_publico'] = 0;
			$perfil['first_name'] = $perfil['display_name'];
		} else {
			// Função
			if ( !isset( $perfil['funcao'] ) ) {
				$bloqueados['incompleto']++;
				$entradas[$i]['erro'] = 'dados_incompletos';
				$exportarBloqueados[] =& $entradas[$i];
				continue;
			}
			$perfil['role'] = obterItem( 'role_funcao', $perfil['funcao'] );
			// Verifica o e-mail
			if ( get_user_by( 'email', $perfil['user_email'] ) ) {
				$bloqueados['pre_existente']++;
				$entradas[$i]['erro'] = 'pre_existente';
				$exportarBloqueados[] =& $entradas[$i];
				continue;
			}
			// Detecta a empresa
			$sufixo = extrairTLD( $perfil['user_email'] );
			$empresa_id = buscarEmpresa( $sufixo );
			// if ( !isset( $perfil['empresa_velha'] ) || !is_numeric( $perfil['empresa_velha'] ) ) {
			if ( !$empresa_id ) {
				$bloqueados['sem_empresa']++;
				$entradas[$i]['erro'] = 'empresa_inexistente';
				$exportarBloqueados[] =& $entradas[$i];
				continue;
			}
			/*
			$empresa_id = $wpdb->get_var( "SELECT `user_id` FROM `$wpdb->usermeta` WHERE `meta_key`='id_velho_empresa' AND ( `meta_value`=$perfil[empresa_velha] OR `meta_value` LIKE '%\"$perfil[empresa_velha]\"%' ) LIMIT 1" );
			if ( !$empresa_id ) {
				$bloqueados['sem_empresa']++;
				$entradas[$i]['erro'] = 'empresa_inexistente';
				$exportarBloqueados[] =& $entradas[$i];
				continue;
			}
			*/
			$perfil['empresa'] = $empresa_id;
			// Se for representante, verifica se a empresa já tem um representante
			if ( $perfil['funcao'] == FUNCAO_REPRESENTANTE && get_user_meta( $empresa_id, 'representante1', true ) ) {
				$perfil['funcao'] = FUNCAO_FUNCIONARIO;
			}
		}
		// Ajusta demais campos
		if ( isset( $perfil['telefone'] ) && isset( $entradaLimpa['num_ddd_telefone'] ) )
			$perfil['telefone'] = sanitizarNumerico( $entradaLimpa['num_ddd_telefone'] . $perfil['telefone'] );
		elseif ( isset( $perfil['telefone'] ) && isset( $entradaLimpa['num_ddd_telefone_usu'] ) )
			$perfil['telefone'] = sanitizarNumerico( $entradaLimpa['num_ddd_telefone_usu'] . $perfil['telefone'] );
		if ( isset( $perfil['fax'] ) && isset( $entradaLimpa['num_ddd_fax'] ) )
			$perfil['fax'] = sanitizarNumerico( $entradaLimpa['num_ddd_fax'] . $perfil['fax'] );
		elseif ( isset( $perfil['fax'] ) && isset( $entradaLimpa['num_ddd_fax_usu'] ) )
			$perfil['fax'] = sanitizarNumerico( $entradaLimpa['num_ddd_fax_usu'] . $perfil['fax'] );
		if ( isset( $perfil['cep'] ) ) {
			$perfil['cep'] = str_pad( sanitizarNumerico( $perfil['cep'] ), 8, '0', STR_PAD_LEFT );
		}
		if ( isset( $perfil['user_registered'] ) ) {
			$perfil['user_registered'] = date( WP_DATA, strtotime( $perfil['user_registered'] ) );
		}
		if ( isset( $perfil['ultima_atualizacao'] ) ) {
			$perfil['ultima_atualizacao'] = date( SAP_DATA, strtotime( $perfil['ultima_atualizacao'] ) );
		}
		$perfil['data_importacao'] = date( WP_DATA );
		// Cria
		$id = atualizarUsuario( $perfil, ESTRUTURA_ASUG_NOVO, $eEmpresa );
		if ( !$id ) {
			$bloqueados['falha']++;
			$entradas[$i]['erro'] = 'dados_invalidos';
			$exportarBloqueados[] =& $entradas[$i];
			continue;
		}
		$importados++;
		// msg( 'Usuário #' . $perfil[ $campoID ] . ' (' . $perfil['display_name'] . ') importado com novo id #' . $id );
		if ( !$eEmpresa ) {
			// Associa à empresa
			if ( $perfil['funcao'] == FUNCAO_REPRESENTANTE ) {
				update_user_meta( $empresa_id, 'representante1', $id );
			}
			$empresa_usuarios = get_user_meta( $empresa_id, 'usuarios', true );
			$empresa_usuarios[] = $id;
			update_user_meta( $empresa_id, 'usuarios', $empresa_usuarios );
		}
		// Notificação
		if ( !$eEmpresa && $notificar ) {
			// $link = enviarConfirmacaoEmail( $id );
			$link = gerarLinkConfirmacao( $id );
			$exportar[] = array(
				$id,
				$perfil['display_name'],
				$perfil['user_email'],
				$link,
				$horario,
				$perfil['id_velho'],
			);
		}
	}
	$imp_cronometro->terminarOperacao('importar');
	// Discrimina os usuários não importados
	if ( $bloqueados['status'] )
		msg( 'Entradas com status negativo: %1$d', $bloqueados['status'] );
	if ( $bloqueados['incompleto'] )
		msg( 'Entradas com dados vitais incompletos: %1$d', $bloqueados['incompleto'] );
	if ( $bloqueados['sem_empresa'] )
		msg( 'Associados com empresa inexistente: %1$d', $bloqueados['sem_empresa'] );
	if ( $bloqueados['pre_existente'] )
		msg( 'Entradas com ' . ( $eEmpresa ? 'sufixo' : 'e-mail' ) . ' já em utilização: %1$d', $bloqueados['pre_existente'] );
	if ( $bloqueados['falha'] )
		msg( 'Entradas que geraram falha ao salvar no sistema: %1$d', $bloqueados['falha'] );
	if ( $bloqueados['duplicado'] )
		msg( 'Entradas previamente importadas: %1$d', $bloqueados['duplicado'] );
	// Exporta as informações de notificação
	if ( !$eEmpresa && $notificar && $importados )
		imp_exportar( $exportar );
	// Exporta os usuários não importados
	if ( $exportarBloqueados ) {
		imp_exportarBloqueados( $exportarBloqueados );
		msg( 'As entradas inúteis foram exportadas para o arquivo <a href="%1$s">%2$s</a>.',
			"$imp_config[url_arquivos]/$imp_config[arquivo_bloqueados]",
			$imp_config['arquivo_bloqueados']
		);
	}
	// Fim
	return $importados;
}
