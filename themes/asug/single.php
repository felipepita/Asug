<?php
/**
 * The Template for displaying all single posts
 *
 * @package WordPress
 * @subpackage Twenty_Twelve
 * @since Twenty Twelve 1.0
 */
get_header(); ?>
<style type="text/css">
.acf-map {
	width: 100%;
	height: 400px;
	border: #ccc solid 1px;
	margin: 20px 0;
}
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
<script type="text/javascript">
(function($) {
/*
*  render_map
*
*  This function will render a Google Map onto the selected jQuery element
*
*  @type	function
*  @date	8/11/2013
*  @since	4.3.0
*
*  @param	$el (jQuery element)
*  @return	n/a
*/
function render_map( $el ) {
	// var
	var $markers = $el.find('.marker');
	// vars
	var args = {
		zoom		: 16,
		center		: new google.maps.LatLng(0, 0),
		mapTypeId	: google.maps.MapTypeId.ROADMAP
	};
	// create map	        	
	var map = new google.maps.Map( $el[0], args);
	// add a markers reference
	map.markers = [];
	// add markers
	$markers.each(function(){
		add_marker( $(this), map );
	});
	// center map
	center_map( map );
}
/*
*  add_marker
*
*  This function will add a marker to the selected Google Map
*
*  @type	function
*  @date	8/11/2013
*  @since	4.3.0
*
*  @param	$marker (jQuery element)
*  @param	map (Google Map object)
*  @return	n/a
*/
function add_marker( $marker, map ) {
	// var
	var latlng = new google.maps.LatLng( $marker.attr('data-lat'), $marker.attr('data-lng') );
	// create marker
	var marker = new google.maps.Marker({
		position	: latlng,
		map			: map
	});
	// add to array
	map.markers.push( marker );
	// if marker contains HTML, add it to an infoWindow
	if( $marker.html() )
	{
		// create info window
		var infowindow = new google.maps.InfoWindow({
			content		: $marker.html()
		});
		// show info window when marker is clicked
		google.maps.event.addListener(marker, 'click', function() {
			infowindow.open( map, marker );
		});
	}
}
/*
*  center_map
*
*  This function will center the map, showing all markers attached to this map
*
*  @type	function
*  @date	8/11/2013
*  @since	4.3.0
*
*  @param	map (Google Map object)
*  @return	n/a
*/
function center_map( map ) {
	// vars
	var bounds = new google.maps.LatLngBounds();
	// loop through all markers and create bounds
	$.each( map.markers, function( i, marker ){
		var latlng = new google.maps.LatLng( marker.position.lat(), marker.position.lng() );
		bounds.extend( latlng );
	});
	// only 1 marker?
	if( map.markers.length == 1 )
	{
		// set center of map
		map.setCenter( bounds.getCenter() );
		map.setZoom( 16 );
	}
	else
	{
		// fit to bounds
		map.fitBounds( bounds );
	}
}
/*
*  document ready
*
*  This function will render each map when the document is ready (page has loaded)
*
*  @type	function
*  @date	8/11/2013
*  @since	5.0.0
*
*  @param	n/a
*  @return	n/a
*/
$(document).ready(function(){
	$('.acf-map').each(function(){
		render_map( $(this) );
	});
});
})(jQuery);
</script>
<?php 
$categoria = get_the_category();
?>
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
				<?php if (($categoria[0]->cat_ID)==21){ ?> <!-- Verifica se é algum post com evento -->
				<td><div id="sidebar_esquerda">
<ul>
<?php


$args = array( 'offset'=> 1, 'category' => $categoria[0]->cat_ID );

$myposts = get_posts( $args );
foreach ( $myposts as $post ) : setup_postdata( $post ); ?>
	<li>
		<a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
	</li>
<?php endforeach; 
?>

</ul>



				</div></td>
				<td><div id="primary" class="site-content two_coluna">
					<div id="content" role="main">
						<?php
				    // TO SHOW THE PAGE CONTENTS
						while ( have_posts() ) : the_post(); ?> <!--Because the_content() works only inside a WP Loop -->
						<div class="entry-content-page">
							<?php

//Preenche variaveis
							$upload_do_banner = get_field('upload_do_banner');
							$botao_de_cadastro = get_field('botao_de_cadastro');

//verifica se existe e exibe informações
							if(!empty($upload_do_banner)){ ?>
							<div class="bannerEvento">
								<img src="<?php echo $upload_do_banner; ?>" alt="<?php echo the_title(); ?>" />
							</div>
							<?php } 

get_template_part( 'content', get_post_format() );

							$data_do_evento = get_field('data_do_evento');
//Defidindo local padrao
							setlocale(LC_TIME, 'portuguese'); 
							date_default_timezone_set('America/Sao_Paulo');
//tratando data
							$d = substr($data_do_evento, 0, 2);
							$m = substr($data_do_evento, 3, 2);
							$y = substr($data_do_evento, 7, 4);
//Por extenso
							$extenso = str_replace("/", "-", $data_do_evento);
//exibindo
							echo $data_do_evento;
							echo "<br />";
							echo strftime("%A, %d de %B de %Y", strtotime($extenso));
							$location = get_field('local_do_evento');
							if( !empty($location) ){
								?>
								<div class="acf-map">
									<div class="marker" data-lat="<?php echo $location['lat']; ?>" data-lng="<?php echo $location['lng']; ?>"></div>
								</div>
								<p class="address"><?php echo $location['address']; ?></p>
								<?php } ?>



								<?php 

								if(!empty($botao_de_cadastro)){ ?>

								<a data-toggle="modal" href='#modal-id'><img src="<?php echo $botao_de_cadastro; ?>" alt="Cadastre-se" /></a>
								<div class="modal fade" id="modal-id">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">Inscreção no evento: <b><?php echo the_title(); ?></b></h4>
											</div>
											<div class="modal-body">
												Confirmar inscrição?
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
												<button type="button" class="btn btn-primary">Confirmar</button>
											</div>
										</div><!-- /.modal-content -->
									</div><!-- /.modal-dialog -->
								</div><!-- /.modal -->


								<table class="table table-condensed table-hover">
									<thead>
										<tr>
											<th><h4>Valores</h4></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><b>Usuário registrado</b></td>
											<td>R$ <?php echo get_field('usuario_registrado'); ?></td>
										</tr>
										<tr>
											<td><b>Empresa parceira</b></td>
											<td>R$ <?php echo get_field('empresa_parceira'); ?></td>
										</tr>
										<tr>
											<td><b>Empresa cliente</b></td>
											<td>R$ <?php echo get_field('empresa_cliente'); ?></td>
										</tr>
										<tr>
											<td><b>Não associado</b></td>
											<td>R$ <?php echo get_field('nao_associado'); ?></td>
										</tr>
									</tbody>
								</table>


<ul class="nav nav-tabs">
  <li class="active"><a href="#horario" data-toggle="tab">Horário</a></li>
  <li><a href="#galeria" data-toggle="tab">Galeria de fotos</a></li>
</ul>

<div class="tab-content">
  <div class="tab-pane fade in active" id="horario">
	 					<table class="table table-condensed table-hover">
	 						<thead>
 						<tr class="active">
 							<td><b>Horário</b></td>
 							<td><b>Título da palestra</b></td>
 							<td><b>Detalhes da palestra</b></td>
 							<td><b>Palestrante</b></td>
 							<td><b>Sala</b></td>
 							<td><b>Capacidade da sala</b></td>
 							<td><b>Material</b></td>
 						</tr>
 					</thead>
 					<tbody>
 						

 					<?php 
if( have_rows('grade') ):
    while ( have_rows('grade') ) : the_row();
							$horario = get_sub_field('horario');
							$titulo_da_palestra = get_sub_field('titulo_da_palestra');
							$detalhes_da_palestra = get_sub_field('detalhes_da_palestra');
							$palestrante = get_sub_field('palestrante');
							$sala = get_sub_field('sala');
							$capacidade_da_sala = get_sub_field('capacidade_da_sala');
							$upload_do_material = get_sub_field('upload_do_material');
							?>
			<tr>
	        <td> <?php echo $horario; ?> </td>
	        <td> <?php echo $titulo_da_palestra; ?> </td>
	        <td> <?php echo $detalhes_da_palestra; ?> </td>
	        <td> <?php echo $palestrante; ?> </td>
	        <td> <?php echo $sala; ?> </td>
	        <td> <?php echo $capacidade_da_sala; ?> </td>
	        <td><a href="<?php echo $upload_do_material; ?>" title="<?php echo $titulo_da_palestra; ?>">Download</a></td>
	        </tr>
	        <?php
    endwhile;

endif;
 ?>

</tbody>
 </table>

  </div>
  <div class="tab-pane fade" id="galeria">


<?php 
$count = 1;
if( have_rows('fotos') ):
    while ( have_rows('fotos') ) : the_row();
							$foto_do_evento = get_sub_field('foto_do_evento');


							?>


	    <div class="GaleriaEventos">
	    	<a data-toggle="modal" href='#modal-id-<?php echo $count; ?>'><img src="<?php echo $foto_do_evento; ?>" width="300" /></a>
	    </div>
	    <div class="modal fade" id="modal-id-<?php echo $count; ?>">
	    	<div class="modal-dialog modalImg">
	    		<div class="modal-content">
	    			
	    			<div class="modal-body">
	    				<figure>
	            <img src="<?php echo $foto_do_evento; ?>" alt="<?php echo $titulo_da_palestra; ?>">
	        </figure>

	    			</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>
										
											</div>

	    		</div><!-- /.modal-content -->
	    	</div><!-- /.modal-dialog -->
	    </div><!-- /.modal -->
	        
	        <?php
	        $count++;
    endwhile;

endif;
 ?>


  </div>
</div>


				


 				




								<?php } 
								?>










							</div><!-- .entry-content-page -->
							<?php
				    endwhile; //resetting the page loop
				    wp_reset_query(); //resetting the page query
				    ?>
				</div><!-- #content -->
			</div><!-- #primary --></td>
			<?php } else { ?>
			<td><div id="primary" class="site-content">
				<div id="content" role="main">
					<?php while ( have_posts() ) : the_post(); ?>
					<?php get_template_part( 'content', get_post_format() ); ?>
					<nav class="nav-single">
						<h3 class="assistive-text"><?php _e( 'Post navigation', 'twentytwelve' ); ?></h3>
						<span class="nav-previous"><?php previous_post_link( '%link', '<span class="meta-nav">' . _x( '&larr;', 'Previous post link', 'twentytwelve' ) . '</span> %title' ); ?></span>
						<span class="nav-next"><?php next_post_link( '%link', '%title <span class="meta-nav">' . _x( '&rarr;', 'Next post link', 'twentytwelve' ) . '</span>' ); ?></span>
					</nav><!-- .nav-single -->
					<?php comments_template( '', true ); ?>
				<?php endwhile; // end of the loop. ?>
			</div><!-- #content -->
		</div><!-- #primary --></td>
		<td><div id="sidebar_direita"><?php widgets_on_template("Sidebar Direito"); ?></div></td>
		<?php } ?>
	</tr>
</tbody>
</table>
</div>
<?php get_footer(); ?>