<?php
/**
 * Template Name: Asug internacional
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
                <th>
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
<style>
.tooltip, .tooltip-inner {
    white-space: pre-wrap;
    max-width:none;
}
</style>
        <tbody>
            <tr>
                <td>
                    <div id="primary" class="site-content">
                        <div id="content" role="main">
                            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                                <h2 class="widgettitle">Asug internacional</h2>
                                <div class="revHr">
                                <div class="latRevInt">
<?php
query_posts('posts_per_page=300&post_type=page&post_parent=294&orderby=date&order=DESC');
 while (have_posts()) : the_post();
?>
                                        <div class="postInter">
                                            <div class="postimageRevistasInt">

<h5><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h5>
<?php $image_thumb = get_post_meta($post->ID, 'image-thumb', true); ?>
<p class="asugInter"><a href="<?php the_permalink(); ?>"><?php the_post_thumbnail('single-blog-thumbnail'); ?></a></p>

<p class="resumo"><?php echo substr(get_the_excerpt(), 0,60); ?></p>
</div></div>
<?php endwhile; wp_reset_query(); ?>
                                </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
                                <div class="contRev">
                                                       <?php
                    // TO SHOW THE PAGE CONTENTS
                   while ( have_posts() ) : the_post();?> <!--Because the_content() works only inside a WP Loop -->
                        <div class="entry-content-page">
                            <?php
                                $content = get_the_content();
                                $content = preg_replace("/\n/","<br />",$content);
                                echo $content;
                            ?> <!-- Page Content -->
                        </div><!-- .entry-content-page -->

                    <?php
                    endwhile; //resetting the page loop
                    wp_reset_query(); //resetting the page query
                    ?>
                    </div><!-- #content -->
                </div><!-- #primary -->
            </td>
        </tr>
    </tbody>
</table>
</div><!-- .table-responsive -->
<?php get_footer(); ?>