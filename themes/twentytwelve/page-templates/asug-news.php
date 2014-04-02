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

		<tbody>
			<tr>
				<td><div id="primary" class="site-content">
			<div id="content" role="main">

				
<?php
$current_cat_id  = 19; //categoria REVISTA tem o ID 19
$showposts = 120; //Limitamos a 120 para não pesar muito a página
$args = array('cat'=>$current_cat_id, 'orderby' => 'post_date','order' => 'DESC','posts_per_page'=> $showposts,'post_status' => 'publish');
query_posts($args);
    if (have_posts()) : while (have_posts()) : the_post(); ?>   




    <div class="postRevistas">

	    		<div class="postimageRevistas">
					<img src="<?php the_field('capa_da_revista'); ?>" alt="" />
				</div>
				<div class="modal fade" id="modal-id-<?php echo $post->ID; ?>">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body">
								 <iframe width="100%" height="100%" src="<?php echo site_url() . "/wp-content/plugins/pdfjs-viewer-shortcode/web/viewer.php?file=" . get_field('upload_da_revista') . "&amp;download=true&amp;print=true&amp;openfile=false"; ?>"></iframe> 
							</div>
						</div><!-- /.modal-content -->
					</div><!-- /.modal-dialog -->
				</div><!-- /.modal -->
				<div class="postRevistaConteudo">
				    <h2><a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>"><?php the_title(); ?></a></h2>
				    <p><?php the_time('m/d/Y') ?></p>
				    <div class="botoesRevistas">
					    <a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>" class="btn btn-xs btn-primary">Detalhes</a>
					    <a data-toggle="modal" href="#modal-id-<?php echo $post->ID; ?>" data-toggle="tooltip" data-placement="right" title="Clique aqui para ler a revista online" class="btn btn-xs btn-success">Ler revista</a>
					</div>
				</div>
					<ul>
						<li><span>Compatilhar:</span></li>
				    	<li><a class="facebook" href="http://www.facebook.com/sharer.php?u=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>" target="_blank" title="Compartilhar no Facebook">Like</a></li>
				    	<li><a class="twitter" href="http://twitter.com/share?url=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>&text=<?php the_title(); ?>" target="_blank" title="Compartilhar no Twitter">Tweet</a></li>
				    	<li><a class="google" href="https://plusone.google.com/_/+1/confirm?hl=en&url=<?php if(is_home()){echo home_url();}else{the_permalink();} ?>" target="_blank" title="Compartilhar no Google">+1</a></li>
				    	<li><a class="mail" href="mailto: ?subject=<?php the_title(); ?>&body=<?php the_permalink(); ?>">Mail</a></li>
				    </ul>
	</div>

		<?php endwhile; else: ?>
	    <?php echo "Ops, nenhuma revista por enquanto, volte mais tarde..."; ?>
	    <?php endif; ?>
	</div>

			</div><!-- #content -->
	</div><!-- #primary --></td>
			</tr>
		</tbody>
	</table>
</div>

<?php get_footer(); ?>