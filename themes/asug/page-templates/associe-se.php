<?php
/**
 * Template Name: Associe-se
 *
 * Description: Sub-seções da guia Associe-se.
 *
 * Tip: Crie sub-páginas nesta seção.
 *
 * @package WordPress
 * @subpackage ASUG
 * @since ASUG 1.0
 */
get_header(); ?>
<div class="table-responsive">
    <table class="table table-hover">
        <thead>
            <tr>
                <th>
                    <?php
                    if ( has_post_thumbnail() )
                        the_post_thumbnail('full');
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
                            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                                <h2 class="widgettitle">Veja mais</h2>
                                <div class="revHr">
									<div class="latRevInt">
										<?php
										$linkAssociese = get_permalink(8);
										/*
										query_posts( array(
											'posts_per_page' => 300,
											'post_type' => 'page',
											'post_parent' => 8,
											'orderby' => 'date',
											'order' => 'DESC'
										) );
										*/
										?>
										<nav class='sidebar'>
											<ul>
												<li><a href="<?php print $linkAssociese ?>">Benefícios</a></li>
												<li><a href="<?php print $linkAssociese ?>?tipo=usuario">Associar usuário</a></li>
												<li><a href="<?php print $linkAssociese ?>?tipo=empresa">Filiar empresas</a></li>
												<?php
												/*
												while ( have_posts() ) :
													the_post();
													?>
													<li><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></li>
													<?php
												endwhile;
												wp_reset_query();
												*/
												?>
											</ul>
										</nav>
									</div><!-- .latRevInt -->
                                </div><!-- .revHr -->
                            </div><!-- .col -->
                            <div class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
                                <div class="contRev">
                                    <?php
									while ( have_posts() ) :
										the_post();
										?>
										<div class="entry-content-page">
											<?php
											print nl2br( get_the_content() );
											?>
										</div><!-- .entry-content-page -->
										<?php
									endwhile;
									wp_reset_query();
									?>
								</div><!-- .contRev -->
							</div><!-- .col -->
						</div><!-- #content -->
					</div><!-- #primary -->
				</td>
			</tr>
		</tbody>
	</table>
</div><!-- .table-responsive -->
<?php get_footer(); ?>