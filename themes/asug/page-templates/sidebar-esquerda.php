<?php
/**
 * Template Name: Modelo sidebar esquerdo
 *
 * Description: Twenty Twelve loves the no-sidebar look as much as
 * you do. Use this page template to remove the sidebar from any page.
 *
 * Tip: to remove the sidebar from all posts and pages simply remove
 * any active widgets from the Main Sidebar area, and the sidebar will
 * disappear everywhere.
 *
 * @package WordPress
 * @subpackage Twenty_Twelve
 * @since Twenty Twelve 1.0
 */

get_header(); ?>

<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th colspan="2">
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
				<td><div id="sidebar_esquerda">
					<?php 
						if ( is_page(6) || $post->post_parent == '6' ) {
							widgets_on_template("Sidebar Institucional");
						}
					 ?>
					<?php widgets_on_template("Sidebar Esquerdo"); ?></div></td>
				<td width="100%"><div id="primary" class="site-content two_coluna">
			<div id="content" role="main">

				
				   <?php
				    // TO SHOW THE PAGE CONTENTS
				    while ( have_posts() ) : the_post(); ?> <!--Because the_content() works only inside a WP Loop -->
				        <div class="entry-content-page">
				            <?php
				            $conteudo = get_the_content();
							$conteudo = apply_filters('the_content', $conteudo);
				            $conteudo = str_replace("[bloco]","<div class=\"well\">",$conteudo);
				            $conteudo = str_replace("[fim]","</div>",$conteudo);
				            echo $conteudo;
				            ?> <!-- Page Content -->
				        </div><!-- .entry-content-page -->

				    <?php
				    endwhile; //resetting the page loop
				    wp_reset_query(); //resetting the page query
				    ?>

			</div><!-- #content -->
	</div><!-- #primary --></td>
			</tr>
		</tbody>
	</table>
</div>

<?php get_footer(); ?>