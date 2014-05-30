<?php
/*
 * Salva as informações do painel de admin, testa os dados de login e armazena a chave de autenticação
 * Plugin: Sincronizador de Dados SAP
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */
 
if ( !defined( 'ABSPATH' ) || !is_admin() || !current_user_can('manage_options') )
	wp_die('Acesso restrito.');

	
	
// Processa o POST

if ( !empty( $_POST ) ) {

	obterPost( array(
		'operacao',
		'servidor',
		'company',
		'username',
		'password',
		'logar',
		'tklogin_key',
		'secret_key',
	) );
	
	switch ( $_POST['operacao'] ) {
	
		case 'salvar' :
		
			// Verifica e salva os dados

			$alterado = false;
		
			if ( $_POST['servidor'] != $sap_config['servidor'] ) {
			
				$alterado = true;
		
				if ( $_POST['servidor'] ) {
			
					if ( !preg_match( '#^http#', $_POST['servidor'] ) )
						$_POST['servidor'] = 'https://' . $_POST['servidor'];
						
					$_POST['servidor'] = preg_replace( '#https?://.+?\K/.*#', '', $_POST['servidor'] );
					$_POST['servidor'] .= '/';
					
				}
				
				sap_salvarOpcao( 'servidor', $_POST['servidor'] );
			
			}
			
			if ( $_POST['company'] != $sap_config['company'] ) {
				$alterado = true;
				sap_salvarOpcao( 'company', $_POST['company'] );
			}
			
			if ( $_POST['username'] != $sap_config['username'] ) {
				$alterado = true;
				sap_salvarOpcao( 'username', $_POST['username'] );
			}
			
			if ( $_POST['password'] && $_POST['password'] != $sap_config['password'] ) {
				$alterado = true;
				sap_salvarOpcao( 'password', $_POST['password'] );
			}
			
			$_POST['logar'] = (int) $_POST['logar'];
			
			if ( $_POST['logar'] != $sap_config['logar'] ) {
				sap_salvarOpcao( 'logar', $_POST['logar'] );
			}
			
			// Os dados de login foram alterados?
			
			$sap_mensagens[] = 'Suas configurações foram salvas.';
			
			if ( $alterado ) {
				sap_log( 'Configurações de autenticação alteradas.' );
				$chave = sap_gerarAutenticacao();
				sap_salvarOpcao( 'chave_auth', $chave );
				if ( $chave ) {
					sap_testar();
				} else {
					sap_salvarOpcao( 'login_valido', 0 );
					sap_log( 'As configurações de autenticação estão incompletas.' );
					$sap_erros[] = 'As configurações de autenticação estão incompletas!';
				}
			}
			
			// Salvar dados do SSO
			
			$sso_alterado = false;
			
			if ( $_POST['tklogin_key'] != $sap_config['tklogin_key'] ) {
				$sso_alterado = true;
				sap_salvarOpcao( 'tklogin_key', $_POST['tklogin_key'] );
			}
			
			if ( $_POST['secret_key'] != $sap_config['secret_key'] ) {
				$sso_alterado = true;
				sap_salvarOpcao( 'secret_key', $_POST['secret_key'] );
			}
			
			// Os dados do SSO foram alterados?
			
			if ( $sso_alterado || $alterado ) {
			
				$utilizavel = todosVerdadeirosDe( $sap_config['username'], $sap_config['company'], $sap_config['tklogin_key'], $sap_config['secret_key'], $sap_config['servidor'] )
					? 1
					: 0
				;
				
				sap_salvarOpcao( 'sso_utilizavel', $utilizavel );
				
				if ( $utilizavel ) {
					sap_log( 'Validação do login via SSO.' );
					sap_testarLoginSSOPadrao();
				} else {
					sap_salvarOpcao( 'sso_valido', 0 );
					sap_log( 'As configurações do SSO estão incompletas.' );
					$sap_erros[] = 'As configurações do SSO estão incompletas.';
				}
			
			}
		
		break;
		case 'validar_odata' :
		
			// Testa o login novamente
		
			if ( $sap_config['chave_auth'] ) {
				sap_log( 'Revalidação das configurações de autenticação.' );
				sap_testar();
			} else {
				$sap_erros[] = 'As configurações de autenticação estão incompletas!';
			}
		
		break;
		case 'validar_sso' :
		
			// Testa o SSO novamente
		
			if ( $sap_config['sso_utilizavel'] ) {
				sap_log( 'Revalidação do login via SSO.' );
				sap_testarLoginSSOPadrao();
			} else {
				$sap_erros[] = 'As configurações do SSO estão incompletas.';
			}
		
		break;
	
	}

}
