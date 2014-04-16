<?php
/**
 * Template Name: Front Page Template
 *
 * Description: A page template that provides a key component of WordPress as a CMS
 * by meeting the need for a carefully crafted introductory page. The front page template
 * in Twenty Twelve consists of a page content area for adding text, images, video --
 * anything you'd like -- followed by front-page-only widgets in one or two columns.
 *
 * @package WordPress
 * @subpackage Twenty_Twelve
 * @since Twenty Twelve 1.0
 */

get_header(); ?>

			<div id="slider">
				<?php
				echo do_shortcode('[smartslider2 slider="2"]');
				?>
			</div>

			<div class="banner">
				<?php echo dfads( 'groups=-1&limit=4&orderby=random&return_javascript=1' ); ?>
			</div>
			
	</div><!-- #main -->
</div><!-- #page -->

<div id="content">
	<div class="padrao">
		<div id="content-wrapper" role="main">

			<?php while ( have_posts() ) : the_post(); ?>
				<?php if ( has_post_thumbnail() ) : ?>
					<div class="entry-page-image">
							<?php the_post_thumbnail(); ?>
					</div><!-- .entry-page-image -->
				<?php endif; ?>



				<?php get_template_part( 'content', 'page' ); ?>

			<?php endwhile; // end of the loop. ?>
			<?php get_sidebar( 'front' ); ?>
			<?php get_sidebar(); ?>

		</div><!-- #content-wrapper -->
	</div>
</div><!-- #content -->

<div>
	<div>

<?php get_footer(); ?>