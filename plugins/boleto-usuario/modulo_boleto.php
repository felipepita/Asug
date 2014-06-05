<?php
/*
Plugin Name: Módulo de boleto
Plugin URI: http://montarsite.com.br
Description: Anexar e enviar boleto para usuário
Version: 1.0
Author: MontarSite
Author URI: http://montarsite.com.br
License: GPLv2
*/

function link_gerar_boleto($actions, $user_object) {
$user = new WP_User( $user_object->ID );
		if($user->roles[0] == 'representante'){

			$actions['edit_badges'] = "<a class='cgc_ub_edit_badges' href='" . admin_url( "/user-edit.php?user_id=$user_object->ID&wp_http_referer=%2Fasug%2Fwp-admin%2Fusers.php#boleto") . "'>Anexar boleto</a>";
			return $actions;
		}
}

add_filter('user_row_actions', 'link_gerar_boleto', 10, 2);

function incluir_bootstrap() {

		if ( (get_the_id()!=315) && (get_post_type() != "post") && (get_post_type() != "acf") ) {
	?>
	<link rel="stylesheet" media="screen" href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css">
	<script src="//code.jquery.com/jquery.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
	<style>
	* {
		-webkit-box-sizing: content-box;
		-moz-box-sizing: content-box;
		box-sizing: content-box;
	}
	html body { background-color: transparent }
	.hidden {
		display: none !important;
		visibility: visible !important;
	}

	.hidden[style*=block] {
		display: block !important;
	}
	.thumbnail {
		padding: 0;
		background: transparent;
		border: none;
		border-radius: 0;
	}
	</style>
	<?php
	}
}

add_action( 'admin_print_scripts', 'incluir_bootstrap' );


?>