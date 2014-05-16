<?php
/*
 * Salva as configurações de associação
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */
 
if ( !defined( 'ABSPATH' ) || !is_admin() || !current_user_can('manage_options') )
	wp_die('Acesso restrito.');

	
	
// Processa o POST

if ( !empty( $_POST ) ) {

	$camposPostados = array_keys( $associacao_config );
	obterPost( $camposPostados );
	
	do {
	
		foreach ( $camposPostados as $campo ) {
			update_option( 'associacao_' . $campo, $_POST[ $campo ] );
			$associacao_config[ $campo ] = $_POST[ $campo ];
		}
		
		$mensagens[] = 'As configurações foram atualizadas com sucesso.';
	
	} while(0);

}
