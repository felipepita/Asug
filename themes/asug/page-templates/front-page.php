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


			<?php $args = array(
				'show_option_all'    => '',
				'orderby'            => 'ID',
				'order'              => 'ASC',
				'style'              => 'list',
				'show_count'         => 4,
				'hide_empty'         => 1,
				'use_desc_for_title' => 1,
				'child_of'           => 0,
				'hierarchical'       => 1,
				'number'             => null,
				'echo'               => 1,
				'depth'              => 0,
				'current_category'   => 0,
				'pad_counts'         => 0,
				'category_name'      => 'post-destaque',
				'walker'             => null
				); ?>



				<?php query_posts($args); ?>
				<?php
				remove_filter( 'excerpt_length', 'twentyten_excerpt_length' );
				function my_twentyten_excerpt_length( $length ) {
					return 30;
				}
				add_filter( 'excerpt_length', 'my_twentyten_excerpt_length' );
				?>

				<ul class="destaque">
					<?php while ( have_posts() ) : the_post(); ?>
					<li>
						<?php if ( has_post_thumbnail() ) : ?>
						<div class="img_ntc">
							<a href="<?php the_permalink() ?>" title="<?php the_title(); ?>"><?php the_post_thumbnail(array(75,75)); ?></a>
						</div><!-- .entry-page-image -->
					<?php endif; ?>
					<span class="dt_postagem"><time><?php the_date('d/m/Y H:m:s'); ?></time></span>
					<a href="<?php the_permalink() ?>" title="<?php the_title(); ?>"><h2><?php the_title(); ?></h2></a>
					<?php the_excerpt(); ?>
				</li>
			<?php endwhile; // end of the loop. ?>
			<a href="<?php bloginfo('url'); ?>/noticias-em-destaques" class="vm_button">Veja mais</a>
		</ul>
		<?php //get_sidebar( 'front' ); ?>
		<?php //get_sidebar(); ?>

		<div id="bnDesta">
			<?php echo dfads( 'groups=24&limit=5&orderby=random' ); ?>
		</div>

	</div><!-- #content-wrapper -->
</div>
</div><!-- #content -->

<div>
	<div>

		<?php get_footer(); ?>