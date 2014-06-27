<?php
/**
 * The default template for displaying content
 *
 * Used for both single and index/archive/search.
 *
 * @package WordPress
 * @subpackage Twenty_Twelve
 * @since Twenty Twelve 1.0
 */
?>
<?php 
//Verifica se é da categoria REVISTAS 19 para mudar a estrtura
if(in_category( '19' )){
	//REVISTA
	?>
	<style>
	.tooltip, .tooltip-inner {
		white-space: pre-wrap;
		max-width:none;
	}
	#sidebar_direita {
		display: none;
	}
	.table > tbody + tbody {
		border: none;
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
                                    query_posts('cat='.$current_cat_id.'&orderby=post_date&order=DESC&posts_per_page='.$showposts.'post_status=publish'); 
									if ( have_posts() ) : while ( have_posts() ) : the_post();
									?>

									<?php 
	                                    		//EDITANDO LINK
	                                    		$link = get_permalink()."?revista=".get_the_ID()."#".get_the_ID();
	                                    		?>

	                                    		<?php 

	                                    		if ($_GET['revista'] == get_the_ID()){ ?>
										<div class="postRevistas destaqueRev">
	                                    	<div class="postimageRevistas">

	                                    		

	                                    			<a name="<?php the_ID(); ?>" class="thumb_revistas" href="<?php echo $link; ?>"" rel="tooltip" data-toggle="tooltip" data-placement="right" data-html="true" title="<?php the_title_attribute() ?> <br /> <?php the_time('d/m/Y'); ?>"><img src="<?php the_field('capa_da_revista'); ?>" alt="<?php the_title(); ?>" class="img-responsive" /></a>
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
									endwhile; endif;
                                    wp_reset_query();
                                    ?>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
                        	<div class="contRev">
                        		<?php 
                        		$id = get_the_ID();
                        		if ($id) {
                        			$my_query = new WP_Query('page_id='.$id.'&showposts=1&format=html&post_status=publish');
                        		} else {
                        			$my_query = new WP_Query('cat='.$current_cat_id.'&showposts=1&format=html&post_status=publish&posts_per_page=1');
                        			
                        		}
                        		?>
                        		<div class="postRevistaConteudo">
                        			<h2><?php the_title(); ?></h2>
                        			<p><?php the_time('m/d/Y') ?></p>
                        			
                        			<?php
                        			$conteudoR = get_the_content();


                        			

                        			if (get_field('link_do_issuu')) {
                        				echo get_field('link_do_issuu');
                        			}
                        			echo nl2br($conteudoR);
                        			?>
                                            <!--<div class="botoesRevistas">
                                                <a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>" class="btn btn-xs btn-primary">Detalhes</a>
                                                <a href="#modal-id-<?php echo $post->ID; ?>" data-toggle="modal" data-placement="right" title="Clique aqui para ler a revista online" class="btn btn-xs btn-success">Ler revista</a><?php //data-toggle="tooltip" ?>
                                            </div>-->
                                        </div>
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
            <?php
        } else {
	//PADRAO
        	?>
        	<article id="post post-<?php the_ID(); ?>" <?php post_class(); ?>>
        		<?php if ( is_sticky() && is_home() && ! is_paged() ) : ?>
        		<div class="featured-post">
        			<?php _e( 'Featured post', 'twentytwelve' ); ?>
        		</div>
        	<?php endif; ?>
        	<?php if ($_GET['s']==true) { ?>
        	<header class="entry-header">
        		<?php the_post_thumbnail(); ?>
        		<?php if ( is_single() ) : ?>
        		<h1 class="entry-title"><?php the_title(); ?></h1>
        	<?php else : ?>
        	<h1 class="entry-title">
        		<a href="<?php the_permalink(); ?>" rel="bookmark"><?php the_title(); ?></a>
        	</h1>
        <?php endif; // is_single() ?>
        <?php if ( comments_open() ) : ?>
        <div class="comments-link">
        	<?php comments_popup_link( '<span class="leave-reply">' . __( 'Leave a reply', 'twentytwelve' ) . '</span>', __( '1 Reply', 'twentytwelve' ), __( '% Replies', 'twentytwelve' ) ); ?>
        </div><!-- .comments-link -->
    <?php endif; // comments_open() ?>
</header><!-- .entry-header -->
<?php } ?>
<?php if ( is_search() ) : // Only display Excerpts for Search ?>
	<div class="entry-summary">
		<?php the_excerpt(); ?>
	</div><!-- .entry-summary -->
<?php else : ?>
	<div class="entry-content">
		<?php if (get_field('upload_da_revista') && get_field('capa_da_revista')) { ?>
		<div class="revistas_asug">
			<a id="linkRevista" data-toggle="modal" href='#modal-id' data-toggle="tooltip" data-placement="right" title="Clique aqui para ler a revista online"><img src="<?php the_field('capa_da_revista'); ?>" class="img-responsive" alt="" /></a>
			<div class="modal fade" id="modal-id">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-body">
							<iframe width="100%" height="100%" src="<?php echo site_url() . "/wp-content/plugins/pdfjs-viewer-shortcode/web/viewer.php?file=" . get_field('upload_da_revista') . "&amp;download=true&amp;print=true&amp;openfile=false"; ?>"></iframe> 
						</div>
					</div><!-- /.modal-content -->
				</div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
		</div>
		<?php } ?>
		<?php the_content( __( 'Continue reading <span class="meta-nav">&rarr;</span>', 'twentytwelve' ) ); ?>
		<?php wp_link_pages( array( 'before' => '<div class="page-links">' . __( 'Pages:', 'twentytwelve' ), 'after' => '</div>' ) ); ?>
		<ul class="Social">
			<li><a class="facebook" href="http://www.facebook.com/sharer.php?u=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>" target="_blank" title="Compartilhar no Facebook">Like</a></li>
			<li><a class="twitter" href="http://twitter.com/share?url=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>&text=<?php the_title(); ?>" target="_blank" title="Compartilhar no Twitter">Tweet</a></li>
			<li><a class="google" href="https://plusone.google.com/_/+1/confirm?hl=en&url=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>" target="_blank" title="Compartilhar no Google">+1</a></li>
			<li><a class="mail" href="mailto: ?subject=<?php the_title(); ?>&body=<?php the_permalink(); ?>">Mail</a></li>
		</ul>
	</div><!-- .entry-content -->
<?php endif; ?>
<footer class="entry-meta">
	<?php twentytwelve_entry_meta(); ?>
	<?php edit_post_link( __( 'Edit', 'twentytwelve' ), '<span class="edit-link">', '</span>' ); ?>
	<?php if ( is_singular() && get_the_author_meta( 'description' ) && is_multi_author() ) : // If a user has filled out their description and this is a multi-author blog, show a bio on their entries. ?>
	<div class="author-info">
		<div class="author-avatar">
			<?php
			/** This filter is documented in author.php */
			$author_bio_avatar_size = apply_filters( 'twentytwelve_author_bio_avatar_size', 68 );
			echo get_avatar( get_the_author_meta( 'user_email' ), $author_bio_avatar_size );
			?>
		</div><!-- .author-avatar -->
		<div class="author-description">
			<h2><?php printf( __( 'About %s', 'twentytwelve' ), get_the_author() ); ?></h2>
			<p><?php the_author_meta( 'description' ); ?></p>
			<div class="author-link">
				<a href="<?php echo esc_url( get_author_posts_url( get_the_author_meta( 'ID' ) ) ); ?>" rel="author">
					<?php printf( __( 'View all posts by %s <span class="meta-nav">&rarr;</span>', 'twentytwelve' ), get_the_author() ); ?>
				</a>
			</div><!-- .author-link	-->
		</div><!-- .author-description -->
	</div><!-- .author-info -->
<?php endif; ?>
</footer><!-- .entry-meta -->
</article><!-- #post -->
<?php
}
?>
