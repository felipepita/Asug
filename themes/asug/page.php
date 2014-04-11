<?php
/**
 * The template for displaying all pages
 *
 * This is the template that displays all pages by default.
 * Please note that this is the WordPress construct of pages
 * and that other 'pages' on your WordPress site will use a
 * different template.
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
				<td>
					<div id="primary" class="site-content">
						<div id="content" role="main">

							<?php while ( have_posts() ) : the_post(); ?>
								<?php get_template_part( 'content', 'page' ); ?>
								<?php comments_template( '', true ); ?>
							<?php endwhile; // end of the loop. ?>

						</div><!-- #content -->
					</div><!-- #primary -->
				</td>
			</tr>
		</tbody>
	</table>
</div>

	


<?php get_footer(); ?>