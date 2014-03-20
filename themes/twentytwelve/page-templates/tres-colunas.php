<?php
/**
 * Template Name: Modelo de 3 Colunas
 *
 * Description: Modelo com três colunas
 *
 * @package WordPress
 * @subpackage Twenty_Twelve
 * @since MontarSite
 */

get_header(); ?>

<div id="sidebar_esquerda"><?php widgets_on_template("Sidebar Esquerdo"); ?></div>

	<div id="primary" class="site-content">
			<div id="content" role="main">

				<h1 class="entry-title"><?php the_title(); ?></h1>
				   <?php
				    // TO SHOW THE PAGE CONTENTS
				    while ( have_posts() ) : the_post(); ?> <!--Because the_content() works only inside a WP Loop -->
				        <div class="entry-content-page">
				            <?php the_content(); ?> <!-- Page Content -->
				        </div><!-- .entry-content-page -->

				    <?php
				    endwhile; //resetting the page loop
				    wp_reset_query(); //resetting the page query
				    ?>

			</div><!-- #content -->
	</div><!-- #primary -->
	<div id="sidebar_esquerda"><?php widgets_on_template("Sidebar Direito"); ?></div>

<?php get_footer(); ?>