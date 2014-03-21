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

<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th colspan="3">
					<?php
					if ( has_post_thumbnail() ) {
					// mostra a imagem destacada
					the_post_thumbnail('full');
					} else {
					// mostra outra coisa (imagem, texto, etc.)
					}
					?>
				<h1 class="entry-title"><?php the_title(); ?></h1><span class="arrow-w"></span>
				</th>
			</tr>
		</thead>

		<tbody>
			<tr>
				<td><div id="sidebar_esquerda"><?php widgets_on_template("Sidebar Esquerdo"); ?></div></td>
				<td><div id="primary" class="site-content tree_coluna">
			<div id="content" role="main">

				
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
	</div><!-- #primary --></td>
				<td><div id="sidebar_direita"><?php widgets_on_template("Sidebar Direito"); ?></div></td>
			</tr>
		</tbody>
	</table>
</div>

<?php get_footer(); ?>