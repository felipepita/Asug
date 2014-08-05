<?php
/*
 * Processa as opções, conduz a operação requisitada e retorna as mensagens
 * Plugin: Importar Usuários
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
	'upload_grande'			=> 'O arquivo enviado excede o limite de upload de %1$s.',
	'upload_erro'			=> 'Erro #%1$d no upload.',
	'entradas_vazio'		=> 'Não há entradas a processar.',
	'tipo'					=> 'Importando %1$s&hellip;',
	'faixa'					=> 'Processando uma faixa de %4$d entradas, compreendendo as linhas %1$d a %2$d, de um total de %3$d entradas&hellip;',
	'tempo'					=> 'Processamento finalizado em %1$.3fs, com uma média de %2$.3fs por entrada.',
	'resultado_vazio'		=> 'Não há nenhuma entrada válida a ser importada.',
	'sucesso'				=> 'Um total de %1$s entradas válidas foram importadas com sucesso!',
	'notificado'			=> 'Uma relação dos usuários com os links de confirmação foi exportada para o arquivo <a href="%1$s">%2$s</a>.', // Os usuários foram notificados para confirmarem seus endereços de e-mail. 
	'reconfirmar'			=> 'Uma relação de %1$d representantes e associados, junto com seus links de confirmação, foi exportada para o arquivo <a href="%2$s">%3$s</a>.',
	'excluir_usuarios'		=> 'Todos os %1$d usuários importados anteriormente foram excluídos com sucesso.',
	'excluir_empresas'		=> 'Todas as %1$d empresas importadas anteriormente, juntos com os %2$d usuários associados, foram excluídos com sucesso.',
);

	
	
// Processa o POST
		
if ( !wp_verify_nonce( $_POST['csrfToken'], 'importar-usuarios' ) ) {
	erro( $msg['nonce'] );
	$post_acao = 'nenhuma';
}
	
switch ( $post_acao ) {

	case 'importar' :

		$entradas = null;
		
		if ( $post_tipo != 'pf' && $post_tipo != 'pj' ) {
			erro( $msg['tipo_vazio'] );
			break;
		}
		
		$imp_cronometro = new Cronometro();
		set_time_limit(0);

		switch ( $post_fonte ) {

			case 'upload' :
			
				if ( isset( $_FILES['upload'] ) ) {
					if ( $_FILES['upload']['error'] == UPLOAD_ERR_OK ) {
						$tmp = $_FILES['upload']['tmp_name'];
						$caminho = "$imp_config[caminho_arquivos]/$imp_config[arquivo_importar]";
						if ( !move_uploaded_file( $tmp, $caminho ) ) {
							erro( $msg['upload_erro'] );
							break 2;
						}
					} elseif ( $_FILES['upload']['error'] == UPLOAD_ERR_INI_SIZE || $_FILES['upload']['error'] == UPLOAD_ERR_FORM_SIZE ) {
						erro( $msg['upload_grande'], formatarTamanho( limiteUpload(), 0 ) );
						break 2;
					} else {
						erro( $msg['upload_erro'], $_FILES['upload']['error'] );
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
			
				$post_texto = trim( stripslashes( $post_texto ), "\r\n" );
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
		$fim = min( intval( $post_fim ), 100000 ) - 1;
		$faixa = min( $fim - $inicio + 1, $total - $inicio );
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
			msg( $msg['notificado'],
				"$imp_config[url_arquivos]/$imp_config[arquivo_exportar]",
				$imp_config['arquivo_exportar']
			);
		}
		
	break;
	case 'reconfirmar' :
	
		$inicio = max( intval( $post_inicio ), 1 ) - 1;
		$fim = min( intval( $post_fim ), 100000 ) - 1;
		$faixa = $fim - $inicio + 1;
		// $listaUsuarios = imp_obterUsuariosImportados();
		$listaUsuarios = $wpdb->get_col( "SELECT user_id FROM $wpdb->usermeta WHERE meta_key='empresa' LIMIT $inicio, $faixa" );
		$total = count( $listaUsuarios );
		$entradas = array();
		// Recalcula a faixa, limitando-a ao total real de resultados
		$faixa = min( $faixa, $total );
		
		// for ( $i = $inicio; $i <= $fim && $i < $total; $i++ ) {
		for ( $i = 0; $i < $total; $i++ ) {
		
			$user_id = $listaUsuarios[$i];
			$user = get_userdata( $user_id );
			$link = obterLinkConfirmacao( $user_id );
			$data_importacao = get_user_meta( $user_id, 'data_importacao', true );
			$horario = date( 'd/m/Y h:i', strtotime( $data_importacao ) );
			$id_antigo = get_user_meta( $user_id, 'id_velho', true );
			
			$entradas[] = array(
				$user_id,
				$user->display_name,
				$user->user_email,
				$link,
				$horario,
				( $id_antigo
					? $id_antigo
					: 0
				),
			);
			
		}
		
		// Apaga mensagens geradas pela função gerarLinkConfirmacao
		$mensagens = array();
		
		unlink( "$imp_config[caminho_arquivos]/$imp_config[arquivo_exportar]" );
		imp_exportar( $entradas );
		
		msg( $msg['reconfirmar'],
			$faixa,
			"$imp_config[url_arquivos]/$imp_config[arquivo_exportar]",
			$imp_config['arquivo_exportar']
		);
	
	break;
	case 'excluir_usuarios' :
	
		$listaUsuarios = imp_obterUsuariosImportados();
		$total = count( $listaUsuarios );
		
		foreach ( $listaUsuarios as $user_id ) {
			$empresa_id = get_user_meta( $user_id, 'empresa', true );
			$empresa_usuarios = get_user_meta( $empresa_id, 'usuarios', true );
			// INCOMPLETO
			wp_delete_user( $user_id );
		}
		
		msg( $msg['excluir_usuarios'],
			$total
		);
	
	break;
	case 'excluir_empresas' :
	
		$listaEmpresas = imp_obterUsuariosImportados(true);
		$totalEmpresas = count( $listaEmpresas );
		$totalUsuarios = 0;
		
		foreach ( $listaEmpresas as $empresa_id ) {
			$empresa_usuarios = get_user_meta( $empresa_id, 'usuarios', true );
			$totalUsuarios += count( $empresa_usuarios );
			foreach ( $empresa_usuarios as $user_id ) {
				wp_delete_user( $user_id );
			}
			wp_delete_user( $empresa_id );
		}
		
		msg( $msg['excluir_empresas'],
			$totalEmpresas,
			$totalUsuarios
		);
	
	break;
	
}
