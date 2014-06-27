<<<<<<< HEAD
<?php
/*
 * Configura telas administráveis para opções do tema, conteúdo das mensagens e e-mails
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
// Opções do tema

// Declare the theme's name and shortname
$asug_painel_admin = 'asug_config';
$asug_tema = "ASUG";
$asug_prefixo = "asug";

// Set the array with all the theme options
$asug_opcoes_config = array (

	array(
		'id'		=> 'facebook',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Facebook',
	),

	array(
		'id'		=> 'twitter',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Twitter',
	),

	array(
		'id'		=> 'orkut',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Orkut',
	),

	array(
		'id'		=> 'linkedin',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'LinkedIn',
	),

	array(
		'id'		=> 'yahoo',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Yahoo',
	),

	array(
		'id'		=> 'windows',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Windows',
	),

	array(
		'id'		=> 'instagram',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Instagram',
	),
	
	array(
		'id'		=> 'copyright',
		'type'		=> 'textarea',
		'default'	=> 'ASUG Brasil &ndash; Associção dos Usuários SAP do Brasil &copy; 2014 | <a href="#">TERMOS DE USO</a>',
	),

	/*
	array(
	"desc" => "<h3>General Settings</h3>",
	"type" => "title"),

	array( "name" => "Logo URL:",
	"desc" => "Enter the URL of your logo image",
	"id" => $shortname."_logo_url",
	"type" => "text",
	"std" => ""),

	array( "name" => "Custom Favicon",
	"desc" => "Paste the full URL of Png/Gif image that will represent your website's favicon (16px x 16px) ",
	"id" => $shortname."_custom_favicon",
	"type" => "text",
	"std" => get_bloginfo('url') ."/favicon.ico"),

	array( "name" => "Remove Sidebar Tabs",
	"desc" => "Check this box if you wish to remove the sidebar tabs.",
	"id" => $shortname."_not_tabs",
	"std" => "false",
	"type" => "checkbox"),

	array( "name" => "Footer copyright text",
	"desc" => "Enter the text for the footer",
	"id" => $shortname."_footer_text",
	"type" => "text",
	"std" => ""),

	array( "name" => "Google Analytics Code",
	"desc" => "You can paste your Google Analytics or other tracking code in this box. This will be automatically added to the footer.",
	"id" => $shortname."_tracking_code",
	"std" => "",
	"type" => "textarea"),

	array( "name" => "Email Address for Contact Us Form",
	"desc" => "Enter email address you want to use for the Contact Us Form",
	"id" => $shortname."_contact_email",
	"std" => "test@test.com",
	"type" => "text"),
	
	array(    "name" => "Slide effect",
	"desc" => "Select the effect you wish to apply to the Featured Article slide.",
	"id" => $shortname."_feat_effect",
	"std" => " ",
	"type" => "select",
	"options" => array("fold","fade","random","sliceDown","sliceDownLeft","sliceUp","sliceUpLeft",
	"sliceUpDown","sliceUpDownLeft"),
	),
	*/

);

$asug_opcoes = array();

function asug_obter_opcoes() {

	global $asug_opcoes_config, $asug_opcoes, $asug_prefixo;
	
	foreach ( $asug_opcoes_config as $index => $op ) {
		// Obtém o valor do BD
		$asug_opcoes[ $op['id'] ] = stripslashes( get_option( "{$asug_prefixo}_$op[id]", $op['default'] ) );
		// Cria um alias
		$asug_opcoes_config[ $op['id'] ] =& $asug_opcoes_config[ $index ];
	}

}

function asug_adicionar_admin() {

	global $asug_tema, $asug_opcoes_config, $asug_prefixo, $asug_painel_admin;

	if ( $_GET['page'] == $asug_painel_admin ) {
	
		if ( 'save' == $_REQUEST['action'] ) {

			/*
			foreach ($asug_opcoes_config as $value) {
				$id = "{$asug_prefixo}_$value[id]";
				if($value['type'] != 'multicheck'){
					update_option( $id, $_REQUEST[ $id ] );
				} else {
					foreach ($value['options'] as $mc_key => $mc_value) {
						$up_opt = $id.'_'.$mc_key;
						update_option($up_opt, $_REQUEST[$up_opt] );
					}
				}
			}
			*/

			foreach ($asug_opcoes_config as $value) {
				$id = "{$asug_prefixo}_$value[id]";
				if ($value['type'] != 'multicheck'){
					if( isset( $_REQUEST[ $id ] ) ) {
						//$val = esc_sql( $_REQUEST[ $id ] );
						$val = $_REQUEST[ $id ];
						update_option( $id, $val );
					} /*else {
						delete_option( $id );
					}*/
				} else {
					foreach($value['options'] as $mc_key => $mc_value){
						$up_opt = $id.'_'.$mc_key;
						if( isset( $_REQUEST[ $up_opt ] ) ) {
							//$val = esc_sql( $_REQUEST[ $up_opt ] );
							$val = $_REQUEST[ $up_opt ];
							update_option( $up_opt, $val );
						} /*else {
							delete_option( $up_opt );
						}*/
					}
				}
			}

			header("Location: admin.php?page=".$asug_painel_admin."&saved=true");
			die;
		
		}
		
	}

	add_submenu_page( 'themes.php', 'Configurações do Template ASUG', 'Configurações', 10, $asug_painel_admin, 'asug_renderizar_admin' );
	
}

function asug_renderizar_admin() {

	global $asug_opcoes_config, $asug_opcoes, $asug_prefixo;
	
	$opcao = array_map( 'esc_attr', $asug_opcoes );
	// array_column( $asug_opcoes_config, 'valor', 'id' );
	require TEMPLATEPATH . '/inc/painel-admin.php';

}

// Init

add_action('admin_menu', 'asug_adicionar_admin');
asug_obter_opcoes();



// Configurações da associação

function associacao_criarMenu() {
	// Cria o submenu no admin
	add_submenu_page( 'options-general.php', 'Configurações da Associação', 'Associação', 10, 'associacao', 'associacao_renderizarPainel' );
}

add_action('admin_menu', 'associacao_criarMenu');

function associacao_renderizarPainel() {
	$mensagens = array();
	$erros = array();
	require TEMPLATEPATH . '/inc/config-associacao.php';
	if ( !empty( $_POST ) )
		require TEMPLATEPATH . '/inc/ctrl.painel-associacao.php';
	require TEMPLATEPATH . '/inc/painel-associacao.php';
}

=======
<?php
/*
 * Configura telas administráveis para opções do tema, conteúdo das mensagens e e-mails
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
// Opções do tema

// Declare the theme's name and shortname
$asug_painel_admin = 'asug_config';
$asug_tema = "ASUG";
$asug_prefixo = "asug";

// Set the array with all the theme options
$asug_opcoes_config = array (

	array(
		'id'		=> 'facebook',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Facebook',
	),

	array(
		'id'		=> 'twitter',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Twitter',
	),

	array(
		'id'		=> 'orkut',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Orkut',
	),

	array(
		'id'		=> 'linkedin',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'LinkedIn',
	),

	array(
		'id'		=> 'yahoo',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Yahoo',
	),

	array(
		'id'		=> 'windows',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Windows',
	),

	array(
		'id'		=> 'instagram',
		'type'		=> 'text',
		'default'	=> '#',
		'title'		=> 'Instagram',
	),
	
	array(
		'id'		=> 'copyright',
		'type'		=> 'textarea',
		'default'	=> 'ASUG Brasil &ndash; Associção dos Usuários SAP do Brasil &copy; 2014 | <a href="#">TERMOS DE USO</a>',
	),

	/*
	array(
	"desc" => "<h3>General Settings</h3>",
	"type" => "title"),

	array( "name" => "Logo URL:",
	"desc" => "Enter the URL of your logo image",
	"id" => $shortname."_logo_url",
	"type" => "text",
	"std" => ""),

	array( "name" => "Custom Favicon",
	"desc" => "Paste the full URL of Png/Gif image that will represent your website's favicon (16px x 16px) ",
	"id" => $shortname."_custom_favicon",
	"type" => "text",
	"std" => get_bloginfo('url') ."/favicon.ico"),

	array( "name" => "Remove Sidebar Tabs",
	"desc" => "Check this box if you wish to remove the sidebar tabs.",
	"id" => $shortname."_not_tabs",
	"std" => "false",
	"type" => "checkbox"),

	array( "name" => "Footer copyright text",
	"desc" => "Enter the text for the footer",
	"id" => $shortname."_footer_text",
	"type" => "text",
	"std" => ""),

	array( "name" => "Google Analytics Code",
	"desc" => "You can paste your Google Analytics or other tracking code in this box. This will be automatically added to the footer.",
	"id" => $shortname."_tracking_code",
	"std" => "",
	"type" => "textarea"),

	array( "name" => "Email Address for Contact Us Form",
	"desc" => "Enter email address you want to use for the Contact Us Form",
	"id" => $shortname."_contact_email",
	"std" => "test@test.com",
	"type" => "text"),
	
	array(    "name" => "Slide effect",
	"desc" => "Select the effect you wish to apply to the Featured Article slide.",
	"id" => $shortname."_feat_effect",
	"std" => " ",
	"type" => "select",
	"options" => array("fold","fade","random","sliceDown","sliceDownLeft","sliceUp","sliceUpLeft",
	"sliceUpDown","sliceUpDownLeft"),
	),
	*/

);

$asug_opcoes = array();

function asug_obter_opcoes() {

	global $asug_opcoes_config, $asug_opcoes, $asug_prefixo;
	
	foreach ( $asug_opcoes_config as $index => $op ) {
		// Obtém o valor do BD
		$asug_opcoes[ $op['id'] ] = stripslashes( get_option( "{$asug_prefixo}_$op[id]", $op['default'] ) );
		// Cria um alias
		$asug_opcoes_config[ $op['id'] ] =& $asug_opcoes_config[ $index ];
	}

}

function asug_adicionar_admin() {

	global $asug_tema, $asug_opcoes_config, $asug_prefixo, $asug_painel_admin;

	if ( $_GET['page'] == $asug_painel_admin ) {
	
		if ( 'save' == $_REQUEST['action'] ) {

			/*
			foreach ($asug_opcoes_config as $value) {
				$id = "{$asug_prefixo}_$value[id]";
				if($value['type'] != 'multicheck'){
					update_option( $id, $_REQUEST[ $id ] );
				} else {
					foreach ($value['options'] as $mc_key => $mc_value) {
						$up_opt = $id.'_'.$mc_key;
						update_option($up_opt, $_REQUEST[$up_opt] );
					}
				}
			}
			*/

			foreach ($asug_opcoes_config as $value) {
				$id = "{$asug_prefixo}_$value[id]";
				if ($value['type'] != 'multicheck'){
					if( isset( $_REQUEST[ $id ] ) ) {
						//$val = esc_sql( $_REQUEST[ $id ] );
						$val = $_REQUEST[ $id ];
						update_option( $id, $val );
					} /*else {
						delete_option( $id );
					}*/
				} else {
					foreach($value['options'] as $mc_key => $mc_value){
						$up_opt = $id.'_'.$mc_key;
						if( isset( $_REQUEST[ $up_opt ] ) ) {
							//$val = esc_sql( $_REQUEST[ $up_opt ] );
							$val = $_REQUEST[ $up_opt ];
							update_option( $up_opt, $val );
						} /*else {
							delete_option( $up_opt );
						}*/
					}
				}
			}

			header("Location: admin.php?page=".$asug_painel_admin."&saved=true");
			die;
		
		}
		
	}

	add_submenu_page( 'themes.php', 'Configurações do Template ASUG', 'Configurações', 10, $asug_painel_admin, 'asug_renderizar_admin' );
	
}

function asug_renderizar_admin() {

	global $asug_opcoes_config, $asug_opcoes, $asug_prefixo;
	
	$opcao = array_map( 'esc_attr', $asug_opcoes );
	// array_column( $asug_opcoes_config, 'valor', 'id' );
	require TEMPLATEPATH . '/inc/painel-admin.php';

}

// Init

add_action('admin_menu', 'asug_adicionar_admin');
asug_obter_opcoes();



// Configurações da associação

function associacao_criarMenu() {
	// Cria o submenu no admin
	add_submenu_page( 'options-general.php', 'Configurações da Associação', 'Associação', 10, 'associacao', 'associacao_renderizarPainel' );
}

add_action('admin_menu', 'associacao_criarMenu');

function associacao_renderizarPainel() {
	$mensagens = array();
	$erros = array();
	require TEMPLATEPATH . '/inc/config-associacao.php';
	if ( !empty( $_POST ) )
		require TEMPLATEPATH . '/inc/ctrl.painel-associacao.php';
	require TEMPLATEPATH . '/inc/painel-associacao.php';
}

>>>>>>> origin/master
