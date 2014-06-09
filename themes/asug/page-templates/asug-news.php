<?php
/**
 * Template Name: Asug-News
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
                                <h2 class="widgettitle">Leia as edições online</h2>
                                <div class="revHr">
                                <div class="latRev">
                                    <?php
                                    $current_cat_id  = 19; //categoria REVISTA tem o ID 19
                                    $showposts = 200; //Limitamos não pesar muito a página
                                    $args = array('cat'=>$current_cat_id, 'orderby' => 'post_date','order' => 'DESC','posts_per_page'=> $showposts,'post_status' => 'publish');
                                    query_posts($args);
                                    if (have_posts()) :
                                        while (have_posts()) : the_post();
                                    ?>
                                    <?php 
                                                //EDITANDO LINK
                                                $link = get_permalink()."?revista=".get_the_ID()."#".get_the_ID();
                                                ?>

                                                <?php 

                                                if ($_GET['revista'] == get_the_ID()){ ?>
                                        <div class="postRevistas destaqueRev">
                                            <div class="postimageRevistas">

                                                

                                                    <a name="<?php the_ID(); ?>" class="thumb_revistas" href="<?php echo $link; ?>"" rel="tooltip" data-toggle="tooltip" data-placement="right" data-html="true" title="<?php get_the_title() ?> <br /> <?php the_time('d/m/Y'); ?>"><img src="<?php the_field('capa_da_revista'); ?>" alt="<?php the_title(); ?>" class="img-responsive" /></a>
                                            </div>
                                        </div>
                                                <?php }else { ?>
                                        <div class="postRevistas">
                                            <div class="postimageRevistas">
                                                    <a name="<?php the_ID(); ?>" class="thumb_revistas" href="<?php echo $link; ?>"" rel="tooltip" data-toggle="tooltip" data-placement="right" data-html="true" title="<?php the_title_attribute() ?> <br /> <?php the_time('d/m/Y'); ?>"><img src="<?php the_field('capa_da_revista'); ?>" alt="<?php the_title(); ?>" class="img-responsive" /></a>
                                            </div>
                                        </div>

                                                <?php } ?>
                                    <?php
                                    endwhile;
                                    else :
                                        echo "Ops, nenhuma revista por enquanto, volte mais tarde...";
                                    endif;

                                    ?>
                                </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
                                <div class="contRev">
                                    <?php

                                    query_posts('cat='.$current_cat_id.'&orderby=post_date&order=DESC&posts_per_page=1post_status=publish');
                                    if ( have_posts() ) : while ( have_posts() ) : the_post();
                                     ?>


                                        <div class="postRevistaConteudo">
                                            <h2><?php the_title(); ?></h2>
                                            <p><?php the_time('m/d/Y') ?></p>
                                            
                                            
                                            <?php
                                            $content = apply_filters ("the_content", $post->post_content);
                                            echo $post->post_content;?>
                                            <!--<div class="botoesRevistas">
                                                <a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>" class="btn btn-xs btn-primary">Detalhes</a>
                                                <a href="#modal-id-<?php echo $post->ID; ?>" data-toggle="modal" data-placement="right" title="Clique aqui para ler a revista online" class="btn btn-xs btn-success">Ler revista</a><?php //data-toggle="tooltip" ?>
                                            </div>-->
                                        </div>
                                        <?php endwhile; endif; ?>
                                        
                    <ul class="Social">
                        <li><a class="facebook" href="http://www.facebook.com/sharer.php?u=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>" target="_blank" title="Compartilhar no Facebook">Like</a></li>
                        <li><a class="twitter" href="http://twitter.com/share?url=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>&text=<?php the_title(); ?>" target="_blank" title="Compartilhar no Twitter">Tweet</a></li>
                        <li><a class="google" href="https://plusone.google.com/_/+1/confirm?hl=en&url=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>" target="_blank" title="Compartilhar no Google">+1</a></li>
                        <li><a class="mail" href="mailto: ?subject=<?php the_title(); ?>&body=<?php the_permalink(); ?>">Mail</a></li>
                    </ul>
                                </div>
                            </div>
                    </div><!-- #content -->
                </div><!-- #primary -->
            </td>
        </tr>
    </tbody>
</table>
</div><!-- .table-responsive -->
<?php get_footer(); ?>