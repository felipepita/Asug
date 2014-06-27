<?php
/*
 * Customiza a página de login
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

function filter_login_url( $url ) {
	// Troca o URL do logo
    return get_bloginfo( 'url' );
}

add_filter( 'login_headerurl', 'filter_login_url' );

function filter_login_title( $title ) {
	// Troca o título do logo
	return get_bloginfo( 'title' );
}

add_filter( 'login_headertitle', 'filter_login_title' );

function action_login_head() {
	// Insere estilos na página
	?><style>
	
	.login h1 a {
		width: 230px;
		height: 76px;
		background-image: url('<?php print trailingslashit( get_template_directory_uri() ) ?>images/logo-asug.png');
		background-size: 230px 76px;
	}
	
	</style><?php
	// Adiciona o filtro para o nome do blog
	add_filter( 'bloginfo', 'filter_login_bloginfo', 10, 2 );
}

add_action( 'login_head', 'action_login_head' );

function filter_register_url( $anchor ) {
	// Troca o URL de registro
	return '<a href="' . esc_attr( home_url('associe-se/') ) . '">Associe-se</a>';
}

add_filter( 'register', 'filter_register_url' );

function filter_login_bloginfo( $value, $key = '' ) {
	// Retorna ASUG se for requisitado o título do site
	if ( $key == 'title' )
		return 'ASUG';
	else
		return $value;
}