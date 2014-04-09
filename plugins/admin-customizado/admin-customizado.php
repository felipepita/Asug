<?php
/*
Plugin Name: Customização de admin
Plugin URI: http://montarsite.com.br
Description: Customização de cores e logo área adminsitrativa
Version: 1.0
Author: MontarSite
Author URI: http://montarsite.com.br
License: GPLv2
*/
function change_adminbar_colors() {  
    $change_adminbar_colors = '<style type="text/css">  
       
       #wpadminbar #wp-admin-bar-wp-logo {
			background-image: url("images/asug_admin.png");
			background-repeat: no-repeat;
			background-position: left 2px;
			width: 84px;
			height: 32px;
			overflow: hidden;
			text-ident: -99999px;
		}
		#wpadminbar ul li#wp-admin-bar-wp-logo * {
			background-color: transparent;
		}
		#wpadminbar #wp-admin-bar-wp-logo>.ab-item .ab-icon:before{
			display: none;
		}
		#adminmenu li.wp-has-current-submenu a.wp-has-current-submenu, #adminmenu li.current a.menu-top, .folded #adminmenu li.wp-has-current-submenu, .folded #adminmenu li.current.menu-top, #adminmenu .wp-menu-arrow, #adminmenu .wp-has-current-submenu .wp-submenu .wp-submenu-head, #adminmenu .wp-menu-arrow div {
				background-color: #189d8f;
		}

    }
    </style>';  
    echo $change_adminbar_colors;  
}  
/* wp-admin area */  
if ( is_admin() ) {  
    add_action( 'admin_head', 'change_adminbar_colors' );  
}  
/* websites */  
if ( !is_admin() ) {  
    add_action( 'wp_head', 'change_adminbar_colors' );  
}  

//Desabilitar painel de cores do usuario
function admin_color_scheme() {
   global $_wp_admin_css_colors;
   $_wp_admin_css_colors = 0;
}
add_action('admin_head', 'admin_color_scheme');

?>