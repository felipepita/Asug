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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?php wp_title( '|', true, 'right' ); ?></title>
<link rel="profile" href="http://gmpg.org/xfn/11" />
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>" />
<?php // Loads HTML5 JavaScript file to add support for HTML5 elements in older IE versions. ?>
<!--[if lt IE 9]>
<script src="<?php echo get_template_directory_uri(); ?>/js/html5.js" type="text/javascript"></script>
<![endif]-->
<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
<div id="page" class="hfeed site">
	<header id="masthead" class="site-header" role="banner">
		<div id="logo">
			<?php if ( get_header_image() ) : ?>
		<a href="<?php echo esc_url( home_url( '/' ) ); ?>"><img src="<?php header_image(); ?>" class="header-image" width="<?php echo get_custom_header()->width; ?>" height="<?php echo get_custom_header()->height; ?>" alt="" /></a>
		<?php endif; ?>
		</div>
							<div class="header_dir">
						<div id="login">
							<form action='https://salesdemo4.successfactors.com/login?_s.crb=mj"%"252fKaDgtraE9nqABY5BiKZQ2NpA"%"253d&company=acevff&username=cgrant&password=demo101&passwordHints=Senha&fragment=&flash=&fragment=' method="POST" class="form-inline" role="form" target="_blank">
								<div class="form-group">
									<label class="sr-only" for="">label</label>
									<input type="text" class="form-control" id="" placeholder="USUÁRIO" name="usuario">
									<input type="password" name="senha" id="input" class="form-control" required="required" placeholder="SENHA" title="">

								</div>
								<button type="submit" class="btn btn-primary">LOGIN</button>
							</form>
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

	<div id="main" class="wrapper">