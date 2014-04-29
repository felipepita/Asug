<?php
/*
 * Ação do formulário de associação
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
// Definições



require 'definicoes.campos.php';
require 'definicoes.perfis.php';

global $prefixoMensagens, $wpdb, $acao, $listas;

$blogname = get_option('blogname');

$msg = array(
	'post_vazio'				=> 'Por favor, preencha os dados do formulário.',
	'falha_db'					=> 'Ocorreu uma falha no servidor. Por favor, tente mais tarde.',
	'operacao_invalida'			=> 'Operação inválida.',
	'nonce'						=> 'Seus dados de sessão estão inválidos. Por favor, recarregue a página.',
	'email_pessoal'				=> 'Não utilize um e-mail pessoal para o cadastro. Utilize o e-mail com o domínio da empresa.',
	'usuario_funcionario'		=> 'Seus dados são válidos! Sua empresa já está cadastrada na ASUG.',
	'email_func_assunto'		=> $blogname . ' - Um novo funcionário de sua empresa se cadastrou',
	'email_func_corpo'			=> "Olá %1\$s,\r\n\r\n"
								 . "Um novo funcionário de sua empresa %2\$s se cadastrou com os seguintes dados:\r\n\r\n"
								 . "%3\$s\r\n\r\n"
								 . "O usuário já foi pré-ativado.",
	'usuario_valido'			=> 'Seus dados são válidos! Prosseguindo para a escolha de empresa&hellip;',
	'associacao_valida'			=> 'Sua escolha foi registrada. Prosseguindo para o cadastro de informações da empresa...',
	'empresa_valida'			=> 'Os dados da empresa foram validados com sucesso. Prosseguindo para o registro de funcionários&hellip;',
	'funcionarios_validos'		=> 'Seu cadastro e o de sua empresa foram efetuados com êxito!',
	'email_rep_assunto'			=> $blogname . ' - Uma nova empresa se cadastrou e requer ativação',
	'email_rep_corpo'			=> "Uma nova empresa se cadastrou no site $blogname e requer ativação. Seguem os detalhes da empresa:\r\n\r\n"
								 . "%1\$s\r\n\r\n"
								 . "Abaixo, os detalhes do representante:\r\n\r\n"
								 . "%2\$s\r\n\r\n"
								 . "Para alterar o status desta empresa, acesse o link abaixo:\r\n"
								 . admin_url( 'users.php?page=user-status-manager/start.php&strUserSearch=%3$s' ) . "\r\n\r\n"
								 . "Para enviar boletos ao representante, acesse seu perfil:\r\n"
								 . admin_url( 'user-edit.php?user_id=%4$d' ),
);

$emailsComuns = array(
	'ig.com.br',
	'gmail.com',
	'gmail.com.br',
	'blogspot.com',
	'googlemail.com',
	'hotmail.com',
	'hotmail.com.br',
	'msn.com.br',
	'msn.com',
	'msnl.com',
	'live.com',
	'outlook.com',
	'yahoo.com',
	'yahoo.com.br',
	'rocketmail.com',
	'ymail.com',
	'ymail.com.br',
	'aol.com',
	'aol.com.br',
	'terra.com.br',
	'zaz.com.br',
	'uol.com.br',
	'uol.com',
	'bol.com.br',
	'zipmail.com.br',
	'zip.net',
	'globo.com',
	'globo.com.br',
	'globomail.com',
	'r7.com.br',
	'r7.com',
	'ig.com.br',
	'ig.com',
	'ieg.com.br',
	'igmail.com.br',
	'brturbo.com.br',
	'brturbo.com',
	'superig.com.br',
	'ibest.com.br',
	'ibestvip.com.br',
	'oi.com.br',
	'itelefonica.com.br',
	'uai.com.br',
	'uainet.com.br',
	'uaimail.com.br',
	'sky.com.br',
	'sky.com',
	'telefonica.com.br',
	'facebook.com',
);

function registrarUsuario( $role = 'subscriber', $usermeta = array() ) {

	// Registra um usuário padrão
	
	$nomes = separarNomes( $_POST['nome_completo'] );
	
	$dados = array(
		'display_name'		=> $_POST['nome_completo'],
		'user_login'		=> $_POST['username'],
		'user_pass'			=> $_POST['senha'],
		'user_email'		=> $_POST['email_cadastro'],
		'role'				=> $role,
		// Duplicatas
		'user_nicename'		=> $_POST['username'],
		'nickname'			=> $_POST['nome_completo'],
		'first_name'		=> $nomes[0],
		'last_name'			=> $nomes[2],
	);
	
	if ( is_wp_error( $user_id = wp_insert_user( $dados ) ) ) {
		return erro( $msg['falha_db'] );
	}
	
	// Salva campos padrões
	
	update_user_meta( $user_id, 'sexo', $_POST['sexo'] );
	update_user_meta( $user_id, 'cargo', $_POST['cargo'] );
	update_user_meta( $user_id, 'nivel_cargo', $_POST['nivel_cargo'] );
	update_user_meta( $user_id, 'telefone', $_POST['telefone'] );
	update_user_meta( $user_id, 'cep', $_POST['cep'] );
	update_user_meta( $user_id, 'endereco', $_POST['endereco'] );
	update_user_meta( $user_id, 'complemento', $_POST['complemento'] );
	update_user_meta( $user_id, 'bairro', $_POST['bairro'] );
	update_user_meta( $user_id, 'cidade', $_POST['cidade'] );
	update_user_meta( $user_id, 'estado', $_POST['estado'] );
	update_user_meta( $user_id, 'newsletter', $_POST['newsletter'] );
	update_user_meta( $user_id, 'user_boleto', '' );
	
	// Salva outros campos fornecidos
	
	foreach ( $usermeta as $campo => $valor )
		update_user_meta( $user_id, $campo, $valor );
	
	// Fim
	
	return $user_id;

}

function listarPerfil( $perfil, $camposExtras = array(), $prefixo = '' ) {
	// Lista os campos do perfil e seus valores no $_POST
	// @requer obterArray()
	global $campos, $perfis, $listas;
	if ( !is_array( $camposExtras ) )
		$camposExtras = array();
	$camposPerfil = $camposExtras + obterArray( obterArray( $perfis, $perfil ), 'campos' );
	$lista = array();
	foreach ( $camposPerfil as $campo => $obrigatorio ) {
		$slug = $prefixo
			? $prefixo . '_' . $campo
			: $campo
		;
		if ( isset( $_POST[ $slug ] ) ) {
			if ( isset( $campos[ $campo ] ) )
				$nome = $campos[ $campo ]['nome'];
			else
				$nome = ucwords( $campo );
			if ( isset( $campos[ $campo ] ) && isset( $campos[ $campo ]['lista'] ) )
				$valor = $listas[ $campos[ $campo ]['lista'] ]['valores'][ $_POST[ $slug ] ];
			else
				$valor = $_POST[ $slug ];
			$lista[] = "$nome: $valor";
		}
	}
	return implode( "\r\n", $lista );
}



// Execução



if ( !empty( $_POST ) ) {

	obterPost( 'secao' );
	obterPost( 'csrfToken' );
	
	switch ( $_POST['secao'] ) {
	
		case 'conta' :
		
			// Nonce
			/*
			if ( !wp_verify_nonce( $_POST['csrfToken'], 'associe-se' ) ) {
				erro( $msg['nonce'] );
				break;
			}
			*/
		
			// Verificação automatizada
			if ( !processarCampos('usuario') )
				break;
				
			$user_sufixo = extrairTLD( $_POST['email_cadastro'] );
			
			if ( in_array( $user_sufixo, $emailsComuns ) ) {
				erro( $msg['email_pessoal'] );
				break;
			}
			
			$query = $wpdb->prepare( "SELECT `user_id` FROM `$wpdb->usermeta` WHERE `meta_key`='sufixo' AND `meta_value`='%s'", $user_sufixo );
			$resultado = $wpdb->get_row( $query );
			
			//set_transient( $_POST['username'] . '_sufixo', $user_sufixo, DAY_IN_SECONDS );
			//set_transient( $_POST['username'] . '_empresa', $resultado->user_id, DAY_IN_SECONDS );
			
			if ( $resultado ) {
			
				// Empresa existente
				
				$empresa_id = $resultado->user_id;
				$empresa = get_userdata( $empresa_id );
				
				// Cria o usuário
				
				$meta = array(
					'empresa'			=> $empresa_id,
				);
				
				$user_id = registrarUsuario( 'subscriber', $meta );
				
				if ( !$user_id )
					break;
				
				//$user = get_userdata( $user_id );
				//$user->add_role( 'subscriber' );
				
				$empresa_usuarios = get_user_meta( $empresa_id, 'usuarios', true );
				$empresa_usuarios[] = $user_id;
				update_user_meta( $empresa_id, 'usuarios', $empresa_usuarios );
				
				// Funcionário já é pré-ativado
				
				$tabela_status = $wpdb->prefix . 'user_status_manager';
				$query = $wpdb->prepare(
					"UPDATE `$tabela_status` SET `status`=0 WHERE `user_id`=%d",
					$user_id
				);
				
				if ( $wpdb->query( $query ) === false ) {
					erro( $msg['falha_db'] );
					break;
				}
				
				// Notifica o representante
				
				$representante_id = get_user_meta( $empresa_id, 'representante1', true );
				$representante = get_userdata( $representante_id );
				$representante_nome = get_user_meta( $representante_id, 'first_name', true );
				
				$email_destinatario = $representante->user_email;
				$email_assunto = $msg['email_func_assunto'];
				$email_corpo = sprintf( $msg['email_func_corpo'],
					$representante_nome,
					$empresa->display_name,
					listarPerfil( 'usuario' )
				);
				$email_headers = array();
				
				wp_mail(
					$email_destinatario,
					$email_assunto,
					$email_corpo,
					$email_headers
				);
				
				// Mensagem de retorno
				
				$empresa_tipo_associacao = get_user_meta( $empresa_id, 'tipo_associacao', true );
				
				$acao = array(
					'logo'				=> get_user_meta( $empresa_id, 'logo', true ),
					'nome'				=> $empresa->display_name,
					'tipo_associacao'	=> $listas['tipo_associacao']['valores'][ $empresa_tipo_associacao ],
				);
				
				msg( $msg['usuario_funcionario'] );
				
			} else {
			
				// Representante novo, prossegue com o registro
				
				msg( $msg['usuario_valido'] );
				
			}
		
		break;
		case 'associacao' :
		
			// Verificação automatizada
			if ( !processarCampos('associacao') )
				break;
				
			msg( $msg['associacao_valida'] );
		
		break;
		case 'empresa' :
		
			// Verificação automatizada
			if ( !processarCampos( 'empresa', 'empresa' ) )
				break;
				
			msg( $msg['empresa_valida'] );
		
		break;
		case 'funcionarios' :
		
			// Representante 2 - Verificação automatizada
			$prefixoMensagens = '[Representante 2] ';
			if ( !processarCampos( 'funcionario', 'rep2' ) )
				break;
			
			// CIO - Verificação automatizada
			$prefixoMensagens = '[CIO] ';
			if ( !processarCampos( 'funcionario', 'cio' ) )
				break;
		
			// Financeiro - Verificação automatizada
			obterPost('fin_habilitar');
			if ( $_POST['fin_habilitar'] ) {
				$prefixoMensagens = '[Financeiro] ';
				if ( !processarCampos( 'funcionario', 'financeiro', true ) )
					break;
			}
		
			$prefixoMensagens = '';
			$user_sufixo = extrairTLD( $_POST['email_cadastro'] );
			
			// Registra a empresa
			
			$empresa_slug = sluggify( $_POST['empresa_nome_fantasia'] );
			
			$empresa_dados = array(
				'display_name'		=> $_POST['empresa_nome_fantasia'],
				'user_login'		=> $empresa_slug,
				'user_pass'			=> rand( 10000, 99999 ),
				'user_email'		=> $empresa_slug . '@asug.com.br',
				'role'				=> $listas['role_associacao'][ $_POST['empresa_tipo_associacao'] ],
				'user_url'			=> 'http://' . $user_sufixo,
				// Duplicatas
				'user_nicename'		=> $empresa_slug,
				'nickname'			=> $_POST['empresa_nome_fantasia'],
			);
				
			if ( is_wp_error( $empresa_id = wp_insert_user( $empresa_dados ) ) ) {
				erro( $msg['falha_db'] );
				erro( $empresa_id->get_error_messages() );
				break;
			}
			
			// Atualiza o meta da empresa com os dados do formulário
			
			update_user_meta( $empresa_id, 'razao_social', $_POST['empresa_razao_social'] );
			update_user_meta( $empresa_id, 'cnpj', $_POST['empresa_cnpj'] );
			update_user_meta( $empresa_id, 'grupo_controlador', $_POST['empresa_grupo_controlador'] );
			update_user_meta( $empresa_id, 'ramo', $_POST['empresa_ramo'] );
			update_user_meta( $empresa_id, 'faturamento', $_POST['empresa_faturamento'] );
			update_user_meta( $empresa_id, 'qtd_funcionarios', $_POST['empresa_qtd_funcionarios'] );
			update_user_meta( $empresa_id, 'qtd_usuarios', $_POST['empresa_qtd_usuarios'] );
			update_user_meta( $empresa_id, 'cep', $_POST['empresa_cep'] );
			update_user_meta( $empresa_id, 'endereco', $_POST['empresa_endereco'] );
			update_user_meta( $empresa_id, 'complemento', $_POST['empresa_complemento'] );
			update_user_meta( $empresa_id, 'bairro', $_POST['empresa_bairro'] );
			update_user_meta( $empresa_id, 'cidade', $_POST['empresa_cidade'] );
			update_user_meta( $empresa_id, 'estado', $_POST['empresa_estado'] );
			update_user_meta( $empresa_id, 'telefone', $_POST['empresa_telefone'] );
			update_user_meta( $empresa_id, 'fax', $_POST['empresa_fax'] );
			update_user_meta( $empresa_id, 'versao_erp', $_POST['empresa_versao_erp'] );
			update_user_meta( $empresa_id, 'contato_publico', $_POST['empresa_contato_publico'] );
			
			// Atualiza outros dados internos
			
			update_user_meta( $empresa_id, 'logo', '' );
			update_user_meta( $empresa_id, 'usuarios', array() );
			update_user_meta( $empresa_id, 'sufixo', $user_sufixo );
			update_user_meta( $empresa_id, 'tipo_associacao', $_POST['empresa_tipo_associacao'] );
			
			// Atualiza os funcionários
			
			$rep2_dados = array(
				'nome_completo'		=> $_POST['rep2_nome_completo'],
				'email'				=> $_POST['rep2_email'],
				'cargo'				=> $_POST['rep2_cargo'],
				'nivel_cargo'		=> $_POST['rep2_nivel_cargo'],
				'telefone'			=> $_POST['rep2_telefone'],
			);
			
			update_user_meta( $empresa_id, 'representante2', $rep2_dados );
			
			$cio_dados = array(
				'nome_completo'		=> $_POST['cio_nome_completo'],
				'email'				=> $_POST['cio_email'],
				'cargo'				=> $_POST['cio_cargo'],
				'nivel_cargo'		=> $_POST['cio_nivel_cargo'],
				'telefone'			=> $_POST['cio_telefone'],
			);
			
			update_user_meta( $empresa_id, 'cio', $cio_dados );
			
			if ( !$_POST['fin_habilitar'] )
				$fin_dados = false;
			else	
				$fin_dados = array(
					'nome_completo'		=> $_POST['fin_nome_completo'],
					'email'				=> $_POST['fin_email'],
					'cargo'				=> $_POST['fin_cargo'],
					'nivel_cargo'		=> $_POST['fin_nivel_cargo'],
					'telefone'			=> $_POST['fin_telefone'],
				);
			
			update_user_meta( $empresa_id, 'financeiro', $fin_dados );
			
			// Registra o usuário
			
			$meta = array(
				'empresa'			=> $empresa_id,
			);
				
			$user_id = registrarUsuario( 'representante', $meta );
			
			if ( !$user_id )
				break;
			
			update_user_meta( $empresa_id, 'representante1', $user_id );
			update_user_meta( $empresa_id, 'admin', $user_id );
			
			// Deixa inativo
			
			$tabela_status = $wpdb->prefix . 'user_status_manager';
			$query = $wpdb->prepare(
				"UPDATE `$tabela_status` SET `status`=1 WHERE `user_id`=%d",
				$user_id
			);
			
			if ( $wpdb->query( $query ) === false ) {
				erro( $msg['falha_db'] );
				break;
			}
			
			// Notifica a administração
			
			$vars_empresa = array(
				'website' => 1,
				'tipo_associacao' => 1,
			);
			
			$vars_usuario = array(
			);
			
			$email_para = get_option('admin_email');
			$email_assunto = $msg['email_rep_assunto'];
			$email_mensagem = sprintf( $msg['email_rep_corpo'],
				listarPerfil( 'empresa', $vars_empresa, 'empresa' ),
				listarPerfil( 'usuario', $vars_usuario ),
				$_POST['email_cadastro'],
				$user_id
			);
			$email_headers = array();
			
			wp_mail(
				$email_para,
				$email_assunto,
				$email_mensagem,
				$email_headers
			);
			
			// Mensagem
			
			msg( $msg['funcionarios_validos'] );
		
		break;
		default :
		
			erro( $msg['operacao_invalida'] );
		
		break;
	
	}

} else {

	erro( $msg['post_vazio'] );
	
}


retornarMensagens();
