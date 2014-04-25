<?php
/**
 * Template Name: Posts destaques home
 *
 * Description: Listagem de notícias em destaques
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
		<tbody>
			<tr>
				<td>
					<div id="primary" class="site-content">
						<div id="content" role="main">
							<?php
							$current_cat_id  = 20; //categoria REVISTA tem o ID 19
							$showposts = 120; //Limitamos a 120 para não pesar muito a página
							$args = array('cat'=>$current_cat_id, 'orderby' => 'post_date','order' => 'DESC','posts_per_page'=> $showposts,'post_status' => 'publish');
							query_posts($args);
							if (have_posts()) :
								while (have_posts()) : the_post();
									?>   
									<div class="postDestaque">
										<div class="postimageRevistas">
											<?php if ( has_post_thumbnail() ) : ?>
											<div class="img_ntc">
												<a href="<?php the_permalink() ?>" title="<?php the_title(); ?>"><?php the_post_thumbnail(array(75,75)); ?></a>
											</div><!-- .entry-page-image -->
										<?php endif; ?>
										</div>
										<div class="postRevistaConteudo">
											<h2><a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>"><?php the_title(); ?></a></h2>
											<p><?php the_time('m/d/Y') ?></p>
											<p><?php the_excerpt(); ?></p>
											<div class="botoesRevistas">
												<a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>" class="btn btn-xs btn-primary">Detalhes</a>
											</div>
										<ul>
											<li><span>Compatilhar:</span></li>
											<li><a class="facebook" href="http://www.facebook.com/sharer.php?u=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>" target="_blank" title="Compartilhar no Facebook">Like</a></li>
											<li><a class="twitter" href="http://twitter.com/share?url=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>&text=<?php the_title(); ?>" target="_blank" title="Compartilhar no Twitter">Tweet</a></li>
											<li><a class="google" href="https://plusone.google.com/_/+1/confirm?hl=en&amp;url=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>" target="_blank" title="Compartilhar no Google">+1</a></li>
											<li><a class="mail" href="mailto: ?subject=<?php the_title(); ?>&amp;body=<?php the_permalink(); ?>">Mail</a></li>
										</ul>
										</div>
									</div>
								<?php
								endwhile;
							else :
								echo "Ops, nenhuma revista por enquanto, volte mais tarde...";
							endif;
							?>
						</div><!-- #content -->
					</div><!-- #primary -->
				</td>
			</tr>
		</tbody>
	</table>
</div><!-- .table-responsive -->
<?php get_footer(); ?>