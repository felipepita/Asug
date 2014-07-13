<?php
/*
 * Salva as informações do painel de admin, testa os dados de login e armazena a chave de autenticação
 * Plugin: Sincronizador de Dados SAP
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
if ( !defined( 'ABSPATH' ) || !is_admin() || !current_user_can('manage_options') )
	wp_die('Acesso restrito.');
	
if ( ! function_exists( 'wp_handle_upload' ) )
	require_once( ABSPATH . 'wp-admin/includes/file.php' );
	
$msg = array(
	'nonce'					=> 'Sua sessão expirou. Por favor, recarregue a página.',
	'tipo_vazio'			=> 'Você deve escolher o tipo de usuário a importar.',
	'upload_erro'			=> 'Falha ao relocar o upload.',
	'upload_vazio'			=> 'Você não enviou nenhum arquivo.',
	'entradas_vazio'		=> 'Não há entradas a processar.',
	'tipo'					=> 'Importando %1$s&hellip;',
	'faixa'					=> 'Processando uma faixa de %4$d entradas, compreendendo as linhas %1$d a %2$d, de um total de %3$d entradas&hellip;',
	'tempo'					=> 'Processamento finalizado em %1$.3fs, com uma média de %2$.3fs por entrada.',
	'resultado_vazio'		=> 'Não há nenhuma entrada válida a ser importada.',
	'sucesso'				=> 'Um total de %1$s entradas válidas foram importadas com sucesso!',
	'notificado'			=> 'Os usuários foram notificados para confirmarem seus endereços de e-mail. Uma relação com os links de confirmação foi <a href="%1$s">foi exportada</a>.',
);

	
	
// Processa o POST
	
do {

	$entradas = null;
	
	if ( !wp_verify_nonce( $_POST['csrfToken'], 'importar-usuarios' ) ) {
		erro( $msg['nonce'] );
		break;
	}
	
	if ( $post_tipo != 'pf' && $post_tipo != 'pj' ) {
		erro( $msg['tipo_vazio'] );
		break;
	}
	
	$imp_cronometro = new Cronometro();
	set_time_limit(0);

	switch ( $post_fonte ) {

		case 'upload' :
		
			if ( isset( $_FILES['upload'] ) && $_FILES['upload']['error'] == UPLOAD_ERR_OK ) {
				$tmp = $_FILES['upload']['tmp_name'];
				$caminho = "$imp_config[caminho_arquivos]/$imp_config[arquivo_importar]";
				if ( !move_uploaded_file( $tmp, $caminho ) ) {
					erro( $msg['upload_erro'] );
					break 2;
				}
			} else {
				erro( $msg['upload_vazio'] );
				break 2;
			}
		
			// Deixa entrar na próxima condição para carregar os dados do arquivo
		
		case 'arquivo' :
		
			$entradas = imp_carregarUpload();
		
		break;
		case 'texto' :
		
			$post_texto = stripslashes( $post_texto );
			$entradas = $post_texto_csv
				? raw_csv_to_array( $post_texto )
				: raw_csv_to_array( $post_texto, "\t" )
			;
		
		break;

	}
	
	if ( !$entradas ) {
		erro( $msg['entradas_vazio'] );
		break;
	}
	
	$total = count( $entradas );
	$inicio = max( intval( $post_inicio ), 1 ) - 1;
	$fim = min( intval( $post_fim ), 10000 ) - 1;
	$faixa = min( $fim - $inicio + 1, $total );
	$eEmpresa = $post_tipo == 'pj';
	$notificar = !$eEmpresa && (bool) $post_confirmar_email;
	
	$info[] = sprintf( $msg['tipo'], $eEmpresa ? 'empresas' : 'usuários' );
	$info[] = sprintf( $msg['faixa'], $inicio+1, $fim+1, $total, $faixa );
	
	if ( $faixa < 1 ) {
		erro( $msg['entradas_vazio'] );
		break;
	}
	
	$resultado = imp_importar( $entradas, $eEmpresa, $inicio, $fim, $notificar );
	$info[] = sprintf( $msg['tempo'],
		$imp_cronometro->tempoDecorrido(),
		$imp_cronometro->mediaOperacao('importar')
	);
	
	if ( !$resultado ) {
		erro( $msg['resultado_vazio'], $faixa );
		break;
	}
	
	msg( $msg['sucesso'], $resultado, $faixa );
	
	if ( $notificar ) {
		msg( $msg['notificado'], "$imp_config[url_arquivos]/$imp_config[arquivo_exportar]" );
	}

} while(0);
