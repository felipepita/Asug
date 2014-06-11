<?php
/**
 * The Header template for our theme
 *
 * Displays all of the <head> section and everything up till <div id="main">
 *
 * @package WordPress
 * @subpackage Twenty_Twelve
 * @since Twenty Twelve 1.0
 */
?><!DOCTYPE html>
<!--[if IE 7]>
<html class="ie ie7" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 8]>
<html class="ie ie8" <?php language_attributes(); ?>>
<![endif]-->
<!--[if !(IE 7) | !(IE 8)  ]><!-->
<html <?php language_attributes(); ?>>
<!--<![endif]-->
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta name="viewport" content="width=device-width" />
<script src="//code.jquery.com/jquery.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
    $("#linkRevista").tooltip({ placement: 'right'});
    $(".thumb_revistas").tooltip({ placement: 'right'});
});
</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?php wp_title( '|', true, 'right' ); ?></title>
<link rel="profile" href="http://gmpg.org/xfn/11" />
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300' rel='stylesheet' type='text/css'>
<?php // Loads HTML5 JavaScript file to add support for HTML5 elements in older IE versions. ?>
<!--[if lt IE 9]>
<script src="<?php echo get_template_directory_uri(); ?>/js/html5.js" type="text/javascript"></script>
<![endif]-->
<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>

<div id="janela" class="clearfix">

	<div id="page" class="hfeed site clearfix">

		<header id="masthead" class="site-header" role="banner">
		
			<div id="logo">
				<?php if ( get_header_image() ) : ?>
				<a href="<?php echo esc_url( home_url( '/' ) ); ?>"><img src="<?php header_image(); ?>" class="header-image" width="<?php echo get_custom_header()->width; ?>" height="<?php echo get_custom_header()->height; ?>" alt="" /></a>
				<?php endif; ?>
			</div>
			
			<div class="header_dir">
			
				<div id="login">
					<?php if ( is_user_logged_in() ) : ?>
						<?php
						$current_user = get_userdata( get_current_user_id() );
						?>
						Bem-vind<?php print oa() ?> <?php print esc_html( $current_user->display_name ); ?>.
						&ensp;
						<a href="<?php print site_url('/conta') ?>">Sua Conta</a>
						|
						<?php /*
						<a href="<?php print site_url('/sap') // https://performancemanager8.successfactors.com/sf/home ?>">Acesse seu Perfil</a>
						|
						*/ ?>
						<a href="<?php print wp_logout_url( site_url('/') ) ?>">Logout</a>
					<?php else : ?>
						<?php
						wp_login_form( array(
							'echo'           => true,
							'redirect'       => site_url('/'), 
							'form_id'        => 'header-login-form',
							'label_username' => 'e-mail',
							'label_password' => 'senha',
							'label_remember' => 'lembrar',
							'label_log_in'   => 'login',
							'id_username'    => 'user_login',
							'id_password'    => 'user_pass',
							'id_remember'    => 'rememberme',
							'id_submit'      => 'wp-submit',
							'remember'       => true,
							'value_username' => NULL,
							'value_remember' => false
						) );
						?>
						<a href="<?php print site_url('wp-login.php?action=lostpassword') ?>" title="Perdeu a senha?" class="link-perdeu-senha">?</a>
						<?php /* ?>
						<form action='<?php print wp_login_url( site_url('/conta') ) ?>' method="POST" class="form-inline" role="form">
							<div class="form-group">
								<label class="sr-only" for="header_login-user_login">Login</label>
								<input type="text" class="form-control" id="header_login-user_login" placeholder="e-mail" name="user_login" required="required">
								<input type="password" name="user_pass" id="header_login-user_pass" class="form-control" required="required" placeholder="senha" title="">
							</div>
							<button type="submit" class="btn btn-primary">LOGIN</button>
						</form>
					<?php */ endif; ?>
				</div>

				<nav class="navbar navbar-default" role="navigation">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
					</div>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse navbar-ex1-collapse">
									<?php /* Primary navigation */
									wp_nav_menu( array(
									  'menu' => 'top_menu',
									  'depth' => 2,
									  'container' => false,
									  'menu_class' => 'nav navbar-nav',
									  //Process nav menu using our custom nav walker
									  'walker' => new wp_bootstrap_navwalker())
									);
									?>
					</div><!-- /.navbar-collapse -->
				</nav>
				
			</div>

		</header><!-- #masthead -->

		<div id="main" class="wrapper clearfix">