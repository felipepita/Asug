<?php
/*
 * Página de redirecionamento para a URL de login na SF
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

if ( !defined( 'ABSPATH' ) )
	die('Acesso negado.');

if ( !is_user_logged_in() ) {
	wp_redirect( site_url('/conta') );
	exit;
}

global $user_login;

get_currentuserinfo();

$teste = sap_testarLoginSSO( $user_login );

// wp_redirect( $url );
// exit;

get_header();
?>

<div class="table-responsive">
	
	<h1 class="entry-title">SAP</h1>
	<span class="arrow-w"></span>

	<?php
	if ( $teste['status'] ) :
		$url = sap_gerarLinkSSO( $user_login );
		?>
		
		<iframe style="width: 100%; height: 800px" src="<?php print $url ?>"></iframe>
		
		<?php
	else :
		?>
		
		<p>&nbsp;</p>
		
		<p><strong>Sua conta não tem acesso à SAP.</strong></p>

		<?php
	endif;
	?>

</div>

<?php
get_footer();