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
?>