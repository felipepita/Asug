<!--ASUG DAY-->
<?php
if (in_category(16)){
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
				<?php if ( (($categoria[0]->cat_ID)==23) || (($categoria[0]->cat_ID)==22) || (($categoria[0]->cat_ID)==16) ){ ?>
				<!-- Verifica se é algum post com evento -->
				<style>
				.table-responsive .wp-post-image + h1.entry-title {
					margin: 0px 0px 0px 0px;
					float: left;
				}
				.arrow-w {
					margin: -10px auto;
				}
				.tab-pane, .tab-content {
					width: 100%;
					float: left;
					display: block;
				}
				</style>
				<td><div id="sidebar_esquerda">
					<h2 class="widgettitle">Veja</h2>
					<div class="revHr">
						<div class="latRev">
							<ul>
								<?php
								$latest_post = new WP_Query("post_type=post&cat=".$categoria[0]->cat_ID."&posts_per_page=200&orderby=date&order=DESC");
                                   while ($latest_post -> have_posts()) : $latest_post -> the_post(); ?> 
								<li>
									<a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
								</li>
							<?php endwhile; ?>
						</ul>
					</div>
				</div>
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
						$y = substr($data_do_evento, 6, 4);
//Por extenso
						$extenso = str_replace("/", "-", $data_do_evento);
						$dt_do_evento_comparar = $y.$m.$d;
/*
if ($data_do_evento) {
}
*/
$hoje = date("Ymd"); // Coleta a data de hoje
$hoje++; // Adiciona mais um para as fotos e material ficarem disponivel somente um dia após o evento
//$hoje = "20140219";

if ($dt_do_evento_comparar > $hoje) {
	$eventoPassou = true;
} else {
	$eventoPassou = false;
}


















//BOTAO DE INSCRIÇÃO
							if( (!empty($botao_de_cadastro)) && $eventoPassou ){
								 if ( is_user_logged_in() ) { 
								?>
							<a data-toggle="modal" href='#modal-id' class="botaoInscricao"><img src="<?php echo $botao_de_cadastro; ?>" alt="Cadastre-se" /></a>
							<div class="modal fade" id="modal-id">
								<div class="modal-dialog">
									<div class="modal-content">
										<form action="<?php echo get_bloginfo('url'); ?>/wp-content/plugins/inscricao-de-eventos/inscricao-de-eventos.php" method="POST" role="form" id="formEvento">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">Inscrição no evento: <b><?php echo the_title(); ?></b></h4>
											</div>
											<div class="modal-body">
<div class="well">
	<table class="table table-condensed table-hover">
		<thead>
			<tr>
				<th class="text-center"><h4>Valores</h4></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><b>Parceiro associado</b></td>
				<td><?php echo get_field('parceiro_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Parceiro não associado</b></td>
				<td><?php echo get_field('parceiro_nao_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Cliente associado</b></td>
				<td><?php echo get_field('cliente_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Cliente não associado</b></td>
				<td><?php echo get_field('cliente_nao_associado'); ?></td>
			</tr>
		</tbody>
	</table>
</div>
												<div class="form-group">
													<label for="nome">Nome Completo</label>
													<input type="text" id="input" required="required" placeholder="Nome Completo" value="<?php echo $current_user->user_firstname ." ". $current_user->user_lastname;  ?>" name="nome">
												</div>
												<div class="form-group">
													<label for="empresa">Empresa</label>
													<input type="text" id="input" required="required" placeholder="Empresa" name="empresa">
												</div>
												<div class="form-group">
													<label for="email">E-mail</label>
													<input type="text" id="input" required="required" placeholder="E-mail" name="email" value="<?php echo $current_user->user_email; ?>">
												</div>
												<div class="form-group">
													<label for="telefone">Telefone</label>
													<input type="text" id="input" required="required" placeholder="(##) ####-####" name="telefone">
												</div>
												<div class="form-group">
													<label for="celular">Celular</label>
													<input type="tel" id="input" required="required" placeholder="(##) #####-####" name="celular">
												</div>
												<div class="form-group">
													<label for="endereco">Endereço Completo</label>
													<input type="tel" id="input" required="required" placeholder="Logradouro, número, cidade e estado" name="endereco">
												</div>
												<div class="form-group">
													<label for="cargo">Cargo</label>
													<input type="text" id="input" required="required" placeholder="Cargo" name="cargo">
												</div>
												<div id="results"><p class="bg-success"><b>Cadastro enviado para a ASUG com sucesso!</b> <br /><br /> Seu cadastro será analisado, aguarde contato em seu e-mail.</p></div>
											</div>
											<div class="form-group">
												<input type="hidden" name="id_post" value="<?php echo get_the_ID(); ?>">
												<input type="hidden" name="id_usuario" value="<?php echo get_current_user_id(); ?>">
												<input type="hidden" name="evento" value="asug_day_conferencia_anual">
												<input type="hidden" name="perfil" value="<?php echo $current_user->roles[0]; ?>">
												<script>
												$(document).ready(function(){
													$('#results').hide();
													$('.btnenviar').click( function() {
														var formData = {
								'id_post'					: $('input[name=id_post]').val(),
								'id_usuario'				: $('input[name=id_usuario]').val(),
															'nome'			: $('input[name=nome]').val(),
															'empresa'			: $('input[name=empresa]').val(),
															'email'			: $('input[name=email]').val(),
															'telefone'			: $('input[name=telefone]').val(),
															'celular'			: $('input[name=celular]').val(),
															'endereco'			: $('input[name=endereco]').val(),
															'cargo'			: $('input[name=cargo]').val(),
															'id_post'			: $('input[name=id_post]').val(),
															'id_usuario'			: $('input[name=id_usuario]').val(),
															'perfil'			: $('input[name=perfil]').val(),
															'evento'			: $('input[name=evento]').val()
														};
														$.ajax({
															type: "POST",
															url: '<?php echo get_bloginfo('url'); ?>/wp-content/plugins/inscricao-de-eventos/inscricao-de-eventos.php',
															data 		: formData,
															dataType 	: 'json',
															encode          : true,
															success: function(data){
																alert(data.message);
																if (data.success==true) {
																	window.location.reload();
																}
															}
														})
													});
});
</script>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
	<button type="button" class="btn btn-primary btnenviar" id="submitButton">Confirmar</button>
</div>
</form>
</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<?php
	
	} else {
		logar_modal('1', "<p style=\"text-center\"><img src='". $botao_de_cadastro ."' alt=\"Cadastre-se\" /></p>","botaoInscricao");
	}
}
$location = get_field('local_do_evento');
?>
 <script type="text/javascript" src="https://raw.githubusercontent.com/objectivehtml/GmapHelper/master/gmaphelper.js"></script>
 <script type="text/javascript">
$(function() {
	function mapaFix() {
	var latlng = new google.maps.LatLng( <?php echo $location['lat']; ?>, <?php echo $location['lng']; ?> );
   var mapOptions = {
    center: latlng,
    position	: latlng,
    zoom: 16
   };
   var map = new google.maps.Map(document.getElementById("acf-map"),mapOptions);
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
  $('#mapTab').click(mapaFix);
  $('#mapTab').mouseover(mapaFix);
  $('#mapTab').mouseout(mapaFix);
});
</script>
<ul class="nav nav-tabs gradeHF">
	<li class="active"><a href="#horario" data-toggle="tab">Grade de programação</a></li>
	<li><a href="#localizacao" data-toggle="tab" id="mapTab">Localização do evento</a></li>
	<?php 
	if ( ($eventoPassou==false) && (have_rows('fotos')) ) { ?>
		<li><a href="#galeria" data-toggle="tab">Álbum de fotos</a></li>
	<?php } ?>
</ul>
<div class="tab-content">
	<div class="tab-pane fade in active gradeHF" id="horario">
		<table class="table table-condensed table-hover">
			<thead>
				<tr class="active">
					<td>Horário</td>
					<td>Título da palestra</td>
					<td>Palestrante</td>
					<td>Detalhes da palestra</td>
					<td>Empresa</td>
					<?php if (!$eventoPassou) { ?><td>Material</td><?php } ?>
				</tr>
			</thead>
			<tbody>
				<?php
				$i = 0;
				if( have_rows('grade') ):
					while ( have_rows('grade') ) : the_row();
				$horario = get_sub_field('horario');
				$titulo_da_palestra = get_sub_field('titulo_da_palestra');
				$detalhes_da_palestra = get_sub_field('detalhes_da_palestra');
				$palestrante = get_sub_field('palestrante');
				$empresa_palestra = get_sub_field('empresa');
				//$sala = get_sub_field('sala');
				//$capacidade_da_sala = get_sub_field('capacidade_da_sala');
				$upload_do_material = get_sub_field('upload_do_material');
				?>
				<tr>
				<?php
					$time = mktime(  date('H')+3, date('i') );
					$horario = gmdate("H:i", $horario);
				?>
					<td> <?php echo $horario; ?> </td>
					<td> <?php echo $titulo_da_palestra; ?> </td>
					<td> <?php echo $palestrante; ?> </td>
					<td><small><?php detalhes_modal($detalhes_da_palestra,$i); ?></small></td>
					<td> <?php echo $empresa_palestra; ?> </td>
				<?php if (!$eventoPassou) { ?>
						<?php if($upload_do_material) {
								if ( is_user_logged_in() ) {
							echo "<td><a href=\"".$upload_do_material."\" title=\"".$titulo_da_palestra."\">Download</a></td>";
								} else { ?>
							<td><?php logar_modal($i,"Download","btn btn-primary"); ?></td>
								<?php }
						} else {
							echo "<td>-</td>";
						}?>
					<?php } ?>
				</tr>
				<?php
				$i++;
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
<div class="tab-pane fade" id="localizacao">
		<?php 
						if( !empty($location) ){
							?>
							<div class="acf-map" id="acf-map">
								<div class="marker" data-lat="<?php echo $location['lat']; ?>" data-lng="<?php echo $location['lng']; ?>"></div>
							</div>
							<p class="address text-center"><?php echo $location['address']; ?></p>
							<?php } ?>
</div>
<?php
		if( have_rows('patrocinadores') ):
			echo "<hr>
		<div class=\"panel panel-default patrocinadores\">
		  <div class=\"panel-heading\">Patrocinadores</div>
		  <div class=\"panel-body\">";
			while ( have_rows('patrocinadores') ) : the_row();
		$foto_do_evento = get_sub_field('logo');
		?>
		<img src="<?php echo $foto_do_evento; ?>" alt="Patrocinador" />
		<?php
			endwhile;
			echo "</div></div>";
		endif;
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
<?php get_footer();
}
?>




<!--CONFERENCIA ANUAL-->
<?php
if (in_category(23)){
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
				<?php if ( (($categoria[0]->cat_ID)==23) || (($categoria[0]->cat_ID)==22) || (($categoria[0]->cat_ID)==16) ){ ?>
				<!-- Verifica se é algum post com evento -->
				<style>
				.table-responsive .wp-post-image + h1.entry-title {
					margin: 0px 0px 0px 0px;
					float: left;
				}
				.arrow-w {
					margin: -10px auto;
				}
				.tab-pane, .tab-content {
					width: 100%;
					float: left;
					display: block;
				}
				</style>
				<td><div id="sidebar_esquerda">
					<h2 class="widgettitle">Veja</h2>
					<div class="revHr">
						<div class="latRev">
							<ul>
								<?php
								$latest_post = new WP_Query("post_type=post&cat=".$categoria[0]->cat_ID."&posts_per_page=200&orderby=date&order=DESC");
                                   while ($latest_post -> have_posts()) : $latest_post -> the_post(); ?> 
								<li>
									<a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
								</li>
							<?php endwhile; ?>
						</ul>
					</div>
				</div>
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
						$y = substr($data_do_evento, 6, 4);
//Por extenso
						$extenso = str_replace("/", "-", $data_do_evento);
						$dt_do_evento_comparar = $y.$m.$d;
/*
if ($data_do_evento) {
}
*/
$hoje = date("Ymd"); // Coleta a data de hoje
$hoje++; // Adiciona mais um para as fotos e material ficarem disponivel somente um dia após o evento
//$hoje = "20140620";
if ($dt_do_evento_comparar > $hoje) {
	$eventoPassou = true;
} else {
	$eventoPassou = false;
}























//BOTAO DE INSCRIÇÃO
							if( (!empty($botao_de_cadastro)) && $eventoPassou ){
								if ( is_user_logged_in() ) { ?>
							<a data-toggle="modal" href='#modal-id' class="botaoInscricao"><img src="<?php echo $botao_de_cadastro; ?>" alt="Cadastre-se" /></a>
							<div class="modal fade" id="modal-id">
								<div class="modal-dialog">
									<div class="modal-content">
										<form action="<?php echo get_bloginfo('url'); ?>/wp-content/plugins/inscricao-de-eventos/inscricao-de-eventos.php" method="POST" role="form" id="formEvento">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">Inscrição no evento: <b><?php echo the_title(); ?></b></h4>
											</div>
											<div class="modal-body">
<div class="well">
	<table class="table table-condensed table-hover">
		<thead>
			<tr>
				<th class="text-center"><h4>Valores</h4></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><b>Parceiro associado</b></td>
				<td><?php echo get_field('parceiro_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Parceiro não associado</b></td>
				<td><?php echo get_field('parceiro_nao_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Cliente associado</b></td>
				<td><?php echo get_field('cliente_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Cliente não associado</b></td>
				<td><?php echo get_field('cliente_nao_associado'); ?></td>
			</tr>
		</tbody>
	</table>
</div>
												<div class="form-group">
													<label for="nome">Nome Completo</label>
													<input type="text" id="input" required="required" placeholder="Nome Completo" value="<?php echo $current_user->user_firstname ." ". $current_user->user_lastname;  ?>" name="nome">
												</div>
												<div class="form-group">
													<label for="empresa">Empresa</label>
													<input type="text" id="input" required="required" placeholder="Empresa" name="empresa">
												</div>
												<div class="form-group">
													<label for="email">E-mail</label>
													<input type="text" id="input" required="required" placeholder="E-mail" name="email" value="<?php echo $current_user->user_email; ?>">
												</div>
												<div class="form-group">
													<label for="telefone">Telefone</label>
													<input type="text" id="input" required="required" placeholder="(##) ####-####" name="telefone">
												</div>
												<div class="form-group">
													<label for="celular">Celular</label>
													<input type="tel" id="input" required="required" placeholder="(##) #####-####" name="celular">
												</div>
												<div class="form-group">
													<label for="endereco">Endereço Completo</label>
													<input type="tel" id="input" required="required" placeholder="Logradouro, número, cidade e estado" name="endereco">
												</div>
												<div class="form-group">
													<label for="cargo">Cargo</label>
													<input type="text" id="input" required="required" placeholder="Cargo" name="cargo">
												</div>
												<div id="results"><p class="bg-success"><b>Cadastro enviado para a ASUG com sucesso!</b> <br /><br /> Seu cadastro será analisado, aguarde contato em seu e-mail.</p></div>
											</div>
											<div class="form-group">
												<input type="hidden" name="id_post" value="<?php echo get_the_ID(); ?>">
												<input type="hidden" name="id_usuario" value="<?php echo get_current_user_id(); ?>">
												<input type="hidden" name="evento" value="asug_day_conferencia_anual">
												<input type="hidden" name="perfil" value="<?php echo $current_user->roles[0]; ?>">
												<script>
												$(document).ready(function(){
													$('#results').hide();
													$('.btnenviar').click( function() {
														var formData = {
								'id_post'					: $('input[name=id_post]').val(),
								'id_usuario'				: $('input[name=id_usuario]').val(),
															'nome'			: $('input[name=nome]').val(),
															'empresa'			: $('input[name=empresa]').val(),
															'email'			: $('input[name=email]').val(),
															'telefone'			: $('input[name=telefone]').val(),
															'celular'			: $('input[name=celular]').val(),
															'endereco'			: $('input[name=endereco]').val(),
															'cargo'			: $('input[name=cargo]').val(),
															'id_post'			: $('input[name=id_post]').val(),
															'id_usuario'			: $('input[name=id_usuario]').val(),
															'perfil'			: $('input[name=perfil]').val(),
															'evento'					: $('input[name=evento]').val()
														};
														$.ajax({
															type: "POST",
															url: '<?php echo get_bloginfo('url'); ?>/wp-content/plugins/inscricao-de-eventos/inscricao-de-eventos.php',
															data 		: formData,
															dataType 	: 'json',
															encode          : true,
															success: function(data){
																alert(data.message);
																if (data.success==true) {
																	window.location.reload();
																}
															}
														})
													});
});
</script>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
	<button type="button" class="btn btn-primary btnenviar" id="submitButton">Confirmar</button>
</div>
</form>
</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<?php
	} else {
		logar_modal('1', "<p style=\"text-center\"><img src='". $botao_de_cadastro ."' alt=\"Cadastre-se\" /></p>","botaoInscricao");
	}
}
$location = get_field('local_do_evento');
?>
 <script type="text/javascript" src="https://raw.githubusercontent.com/objectivehtml/GmapHelper/master/gmaphelper.js"></script>
 <script type="text/javascript">
$(function() {
	function mapaFix() {
	var latlng = new google.maps.LatLng( <?php echo $location['lat']; ?>, <?php echo $location['lng']; ?> );
   var mapOptions = {
    center: latlng,
    position	: latlng,
    zoom: 16
   };
   var map = new google.maps.Map(document.getElementById("acf-map"),mapOptions);
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
  $('#mapTab').click(mapaFix);
  $('#mapTab').mouseover(mapaFix);
  $('#mapTab').mouseout(mapaFix);
});
</script>
<ul class="nav nav-tabs gradeHF">
	<li class="active"><a href="#horario" data-toggle="tab">Grade de programação</a></li>
	<li><a href="#localizacao" data-toggle="tab" id="mapTab">Localização do evento</a></li>
	<?php 
	if ( ($eventoPassou==false) && (have_rows('fotos')) ) { ?>
		<li><a href="#galeria" data-toggle="tab">Álbum de fotos</a></li>
	<?php } ?>
</ul>
<div class="tab-content">
	<div class="tab-pane fade in active gradeHF" id="horario">
		<table class="table table-condensed table-hover">
			<thead>
				<tr class="active">
					<td>Horário</td>
					<td>Título da palestra</td>
					<td>Sala</td>
					<td>Palestrante</td>
					<td>Detalhes da palestra</td>
					<td>Empresa</td>

					<?php if (!$eventoPassou) { ?><td>Material</td><?php } ?>
				</tr>
			</thead>
			<tbody>
				<?php
				$i = 0;
				if( have_rows('grade') ):
					while ( have_rows('grade') ) : the_row();
				$horario = get_sub_field('horario');
				$titulo_da_palestra = get_sub_field('titulo_da_palestra');
				$sala = get_sub_field('sala');
				$detalhes_da_palestra = get_sub_field('detalhes_da_palestra');
				$palestrante = get_sub_field('palestrante');
				$empresa_palestra = get_sub_field('empresa');
				//$sala = get_sub_field('sala');
				//$capacidade_da_sala = get_sub_field('capacidade_da_sala');
				$upload_do_material = get_sub_field('upload_do_material');
				?>
				<tr>

					<?php
					$time = mktime(  date('H')+3, date('i') );
					$horario = gmdate("H:i", $horario);
					 ?>
					<td> <?php echo $horario; ?> </td>
					<td> <?php echo $titulo_da_palestra; ?> </td>
					<td> <?php echo $sala; ?> </td>
					<td> <?php echo $palestrante; ?> </td>
					<td><small><?php detalhes_modal($detalhes_da_palestra,$i); ?></small></td>
					<td> <?php echo $empresa_palestra; ?> </td>
					<?php if (!$eventoPassou) { ?>
						<?php if($upload_do_material) {
								if ( is_user_logged_in() ) {
							echo "<td><a href=\"".$upload_do_material."\" title=\"".$titulo_da_palestra."\">Download</a></td>";
								} else { ?>
							<td><?php logar_modal($i,"Download","btn btn-primary"); ?></td>
								<?php }
						} else {
							echo "<td>-</td>";
						}?>
					<?php } ?>
				</tr>
				<?php
				$i++;
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
<div class="tab-pane fade" id="localizacao">
		<?php 
						if( !empty($location) ){
							?>
							<div class="acf-map" id="acf-map">
								<div class="marker" data-lat="<?php echo $location['lat']; ?>" data-lng="<?php echo $location['lng']; ?>"></div>
							</div>
							<p class="address text-center"><?php echo $location['address']; ?></p>
							<?php } ?>
</div>
<?php
		if( have_rows('patrocinadores') ):
			echo "<hr>
		<div class=\"panel panel-default patrocinadores\">
		  <div class=\"panel-heading\">Patrocinadores</div>
		  <div class=\"panel-body\">";
			while ( have_rows('patrocinadores') ) : the_row();
		$foto_do_evento = get_sub_field('logo');
		?>
		<img src="<?php echo $foto_do_evento; ?>" alt="Patrocinador" />
		<?php
			endwhile;
			echo "</div></div>";
		endif;
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
<?php get_footer();
}
?>



<!--IMPACT AWARDS-->
<?php
if (in_category(22)){
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
				<?php if ( (($categoria[0]->cat_ID)==23) || (($categoria[0]->cat_ID)==22) || (($categoria[0]->cat_ID)==16) ){ ?>
				<!-- Verifica se é algum post com evento -->
				<style>
				.table-responsive .wp-post-image + h1.entry-title {
					margin: 0px 0px 0px 0px;
					float: left;
				}
				.arrow-w {
					margin: -10px auto;
				}
				.tab-pane, .tab-content {
					width: 100%;
					float: left;
					display: block;
				}
				</style>
				<td><div id="sidebar_esquerda">
					<h2 class="widgettitle">Veja</h2>
					<div class="revHr">
						<div class="latRev">
							<ul>
								<?php
								$latest_post = new WP_Query("post_type=post&cat=".$categoria[0]->cat_ID."&posts_per_page=200&orderby=date&order=DESC");
                                   while ($latest_post -> have_posts()) : $latest_post -> the_post(); ?> 
								<li>
									<a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
								</li>
							<?php endwhile; ?>
						</ul>
					</div>
				</div>
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
						$data_do_evento = get_field('ate');
//Defidindo local padrao
						setlocale(LC_TIME, 'portuguese');
						date_default_timezone_set('America/Sao_Paulo');
//tratando data
						$d = substr($data_do_evento, 0, 2);
						$m = substr($data_do_evento, 3, 2);
						$y = substr($data_do_evento, 6, 4);
//Por extenso
						$extenso = str_replace("/", "-", $data_do_evento);
						$dt_do_evento_comparar = $y.$m.$d;
/*
if ($data_do_evento) {
}
*/
$hoje = date("Ymd"); // Coleta a data de hoje
$hoje++; // Adiciona mais um para as fotos e material ficarem disponivel somente um dia após o evento
//$hoje = "20140621";

if ($dt_do_evento_comparar >= $hoje) {
	$eventoPassou = true;
} else {
	$eventoPassou = false;
}





if($eventoPassou){
	echo "<div class=\"col-xs-12 col-sm-12 col-md-12 col-lg-12\"><div class=\"alert alert-info\" role=\"alert\">
	<p class=\"text-center\"><b>Período de inscrição: </b>".get_field('periodo_de_inscricao')." até ".get_field('ate')."</p>";
	echo "<p class=\"text-center\"><b>Período de avaliação: </b>".get_field('periodo_de_avaliacao')." até ".get_field('ate_avaliacao')."</p></div></div>";
}















//BOTAO DE INSCRIÇÃO
							if( (!empty($botao_de_cadastro)) && $eventoPassou ){
								if ( is_user_logged_in() ) { ?>
							<a data-toggle="modal" href='#modal-id' class="botaoInscricao"><img src="<?php echo $botao_de_cadastro; ?>" alt="Cadastre-se" /></a>
							<div class="modal fade" id="modal-id">
								<div class="modal-dialog">
									<div class="modal-content">
										<form action="<?php echo get_bloginfo('url'); ?>/wp-content/plugins/inscricao-de-eventos/inscricao-de-eventos.php" method="POST" role="form" id="formEvento">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">Inscrição no evento: <b><?php echo the_title(); ?></b></h4>
											</div>
											<div class="modal-body">



	<h2>01. Cadastro</h2>
												<div class="form-group">
													<label for="nome">Título do case</label>
													<input type="text" id="input" required="required" placeholder="Título do case" name="titulo_do_case">
												</div>
												<div class="form-group">
													<label for="empresa">Empresa</label>
													<input type="text" id="input" required="required" placeholder="Empresa" name="empresa">
												</div>
												<div class="form-group">
													<label for="telefone">Nome do responsável</label>
													<input type="text" id="input" required="required" placeholder="(Profissional que receberá o prêmio no ato solene)" name="nome_do_responsavel">
												</div>
												<div class="form-group">
													<label for="celular">Telefone</label>
													<input type="tel" id="input" required="required" placeholder="(##) #####-####" name="telefone">
												</div>
												<div class="form-group">
													<label for="email">E-mail</label>
													<input type="text" id="input" required="required" placeholder="E-mail" name="email" value="<?php echo $current_user->user_email; ?>">
												</div>



	<h2>02. Parceiro de implementação</h2>
												<div class="form-group">
													<label for="nome">Empresa</label>
													<input type="text" id="input" required="required" placeholder="Empresa responsável pela implementação" name="empresa_parceira">
												</div>
												<div class="form-group">
													<label for="empresa">Nome</label>
													<input type="text" id="input" required="required" placeholder="Nome da pessoa responsável pela implementação" name="nome_parceira">
												</div>
												<div class="form-group">
													<label for="celular">Telefone</label>
													<input type="tel" id="input" required="required" placeholder="(##) #####-####" name="telefone_parceira">
												</div>
												<div class="form-group">
													<label for="email">E-mail</label>
													<input type="text" id="input" required="required" placeholder="E-mail da pessoa responsável pela implamentação" name="email_parceira">
												</div>


	<h2>03. Resenha</h2>
												<div class="form-group">
													<textarea name="resenha" class="resenha"></textarea>
												</div>

												<div id="results"><p class="bg-success"><b>Cadastro enviado para a ASUG com sucesso!</b> <br /><br /> Seu cadastro será analisado, aguarde contato em seu e-mail.</p></div>
											</div>
											<div class="form-group">
												<input type="hidden" name="id_post" value="<?php echo get_the_ID(); ?>">
												<input type="hidden" name="id_usuario" value="<?php echo get_current_user_id(); ?>">
												<input type="hidden" name="perfil" value="<?php echo $current_user->roles[0]; ?>">
												<input type="hidden" name="evento" value="ia">
					<script type="text/javascript">
					$(document).ready(function(){
						$('#results').hide();
						$('#submitButton').click( function() {
							var formData = {
								'id_post'					: $('input[name=id_post]').val(),
								'id_usuario'				: $('input[name=id_usuario]').val(),
								'titulo_do_case'			: $('input[name=titulo_do_case]').val(),
								'empresa'					: $('input[name=empresa]').val(),
								'nome_do_responsavel'		: $('input[name=nome_do_responsavel]').val(),
								'telefone'					: $('input[name=telefone]').val(),
								'email'						: $('input[name=email]').val(),
								'empresa_parceira'			: $('input[name=empresa_parceira]').val(),
								'nome_parceira'				: $('input[name=nome_parceira]').val(),
								'telefone_parceira'			: $('input[name=telefone_parceira]').val(),
								'email_parceira'			: $('input[name=email_parceira]').val(),
								'resenha'					: $('textarea[name=resenha]').val(),
								'evento'					: $('input[name=evento]').val()
							};
							$.ajax({
								type: "POST",
								url: '<?php echo get_bloginfo('url'); ?>/wp-content/plugins/inscricao-de-eventos/inscricao-de-eventos.php',
								data 		: formData,
								dataType 	: 'json',
								encode          : true,
								success: function(data){
									alert(data.message);
										if (data.success==true) {
											window.location.reload();
										}
								}
							})
						});
					});
					</script>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
	<button type="button" class="btn btn-primary btnenviar" id="submitButton">Confirmar</button>
</div>
</form>
</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<?php
	} else {
		logar_modal('1', "<p style=\"text-center\"><img src='". $botao_de_cadastro ."' alt=\"Cadastre-se\" /></p>","botaoInscricao");
	}
}
$location = get_field('local_do_evento');
?>
 <script type="text/javascript" src="https://raw.githubusercontent.com/objectivehtml/GmapHelper/master/gmaphelper.js"></script>
 <script type="text/javascript">
$(function() {

	function mapaFix() {





	var latlng = new google.maps.LatLng( <?php echo $location['lat']; ?>, <?php echo $location['lng']; ?> );
   var mapOptions = {
    center: latlng,
    position	: latlng,
    zoom: 16
   };
   var map = new google.maps.Map(document.getElementById("acf-map"),mapOptions);
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


  $('#mapTab').click(mapaFix);
  $('#mapTab').mouseover(mapaFix);
  $('#mapTab').mouseout(mapaFix);


});
</script>
<ul class="nav nav-tabs gradeHF">
	<li class="active"><a href="#cases" data-toggle="tab">Cases inscritos</a></li>
	<li><a href="#regulamento" data-toggle="tab">Regulamento</a></li>
	<li><a href="#localizacao" data-toggle="tab" id="mapTab">Localização do evento</a></li>
	<?php
	if ( ($eventoPassou==false) && (have_rows('fotos')) ) { ?>
		<li><a href="#galeria" data-toggle="tab">Álbum de fotos</a></li>
	<?php } ?>
</ul>
<div class="tab-content">
	<div class="tab-pane fade in active gradeHF" id="cases">
		<table class="table table-condensed table-hover">
			<thead>
				<tr class="active">
					<td>Título do case</td>
					<td>Arquivo</td>
				</tr>
			</thead>
			<tbody>
				<?php
				$i = 0;
				if( have_rows('cases') ):
					while ( have_rows('cases') ) : the_row();
				$titulo_do_case = get_sub_field('titulo_da_palestra');
				$upload_do_material = get_sub_field('upload_do_material');
				?>
				<tr>
					<td> <?php echo $titulo_do_case; ?> </td>
						<?php if($upload_do_material) {
								if ( is_user_logged_in() ) {
							echo "<td><a href=\"".$upload_do_material."\" title=\"".$titulo_da_palestra."\">Download</a></td>";
								} else { ?>
							<td><?php logar_modal($i,"Download","btn btn-primary"); ?></td>
								<?php }
						} else {
							echo "<td>-</td>";
						}?>

				</tr>
				<?php
				$i++;
				endwhile;
				endif;
				?>
			</tbody>
		</table>
	</div>
<div class="tab-pane fade" id="regulamento">
	<?php
		$regulamento_conteudo = the_field('regulamento_conteudo');
	 	echo $regulamento_conteudo;
 	?>

</div>

<div class="tab-pane fade" id="localizacao">
		<?php 
						if( !empty($location) ){
							?>
							<div class="acf-map" id="acf-map">
								<div class="marker" data-lat="<?php echo $location['lat']; ?>" data-lng="<?php echo $location['lng']; ?>"></div>
							</div>
							<p class="address text-center"><?php echo $location['address']; ?></p>
							<?php } ?>
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

<?php
		if( have_rows('patrocinadores') ):
			echo "<hr>
		<div class=\"panel panel-default patrocinadores\">
		  <div class=\"panel-heading\">Patrocinadores</div>
		  <div class=\"panel-body\">";
			while ( have_rows('patrocinadores') ) : the_row();
		$foto_do_evento = get_sub_field('logo');
		?>
		<img src="<?php echo $foto_do_evento; ?>" alt="Patrocinador" />
		<?php
			endwhile;
			echo "</div></div>";
		endif;
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
<?php get_footer(); 
}
?>





























<?php

if ( (!in_category(16)) && (!in_category(22)) && (!in_category(23)) ){
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
				<?php if ( (($categoria[0]->cat_ID)==23) || (($categoria[0]->cat_ID)==22) || (($categoria[0]->cat_ID)==16) ){ ?>
				<!-- Verifica se é algum post com evento -->
				<style>
				.table-responsive .wp-post-image + h1.entry-title {
					margin: 0px 0px 0px 0px;
					float: left;
				}
				.arrow-w {
					margin: -10px auto;
				}
				.tab-pane, .tab-content {
					width: 100%;
					float: left;
					display: block;
				}
				</style>
				<td><div id="sidebar_esquerda">
					<h2 class="widgettitle">Veja</h2>
					<div class="revHr">
						<div class="latRev">
							<ul>
								<?php
								$latest_post = new WP_Query("post_type=post&cat=".$categoria[0]->cat_ID."&posts_per_page=200&orderby=date&order=DESC");
                                   while ($latest_post -> have_posts()) : $latest_post -> the_post(); ?> 
								<li>
									<a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
								</li>
							<?php endwhile; ?>
						</ul>
					</div>
				</div>
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
						$y = substr($data_do_evento, 6, 4);
//Por extenso
						$extenso = str_replace("/", "-", $data_do_evento);
						$dt_do_evento_comparar = $y.$m.$d;
/*
if ($data_do_evento) {
}
*/
$hoje = date("Ymd"); // Coleta a data de hoje
$hoje++; // Adiciona mais um para as fotos e material ficarem disponivel somente um dia após o evento
//$hoje = "20140620";
if ($dt_do_evento_comparar > $hoje) {
	$eventoPassou = true;
} else {
	$eventoPassou = false;
}























//BOTAO DE INSCRIÇÃO
							if( (!empty($botao_de_cadastro)) && $eventoPassou ){
								if ( is_user_logged_in() ) { ?>
							<a data-toggle="modal" href='#modal-id' class="botaoInscricao"><img src="<?php echo $botao_de_cadastro; ?>" alt="Cadastre-se" /></a>
							<div class="modal fade" id="modal-id">
								<div class="modal-dialog">
									<div class="modal-content">
										<form action="<?php echo get_bloginfo('url'); ?>/wp-content/plugins/inscricao-de-eventos/inscricao-de-eventos.php" method="POST" role="form" id="formEvento">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">Inscrição no evento: <b><?php echo the_title(); ?></b></h4>
											</div>
											<div class="modal-body">
<div class="well">
	<table class="table table-condensed table-hover">
		<thead>
			<tr>
				<th class="text-center"><h4>Valores</h4></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><b>Parceiro associado</b></td>
				<td><?php echo get_field('parceiro_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Parceiro não associado</b></td>
				<td><?php echo get_field('parceiro_nao_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Cliente associado</b></td>
				<td><?php echo get_field('cliente_associado'); ?></td>
			</tr>
			<tr>
				<td><b>Cliente não associado</b></td>
				<td><?php echo get_field('cliente_nao_associado'); ?></td>
			</tr>
		</tbody>
	</table>
</div>
												<div class="form-group">
													<label for="nome">Nome Completo</label>
													<input type="text" id="input" required="required" placeholder="Nome Completo" value="<?php echo $current_user->user_firstname ." ". $current_user->user_lastname;  ?>" name="nome">
												</div>
												<div class="form-group">
													<label for="empresa">Empresa</label>
													<input type="text" id="input" required="required" placeholder="Empresa" name="empresa">
												</div>
												<div class="form-group">
													<label for="email">E-mail</label>
													<input type="text" id="input" required="required" placeholder="E-mail" name="email" value="<?php echo $current_user->user_email; ?>">
												</div>
												<div class="form-group">
													<label for="telefone">Telefone</label>
													<input type="text" id="input" required="required" placeholder="(##) ####-####" name="telefone">
												</div>
												<div class="form-group">
													<label for="celular">Celular</label>
													<input type="tel" id="input" required="required" placeholder="(##) #####-####" name="celular">
												</div>
												<div class="form-group">
													<label for="endereco">Endereço Completo</label>
													<input type="tel" id="input" required="required" placeholder="Logradouro, número, cidade e estado" name="endereco">
												</div>
												<div class="form-group">
													<label for="cargo">Cargo</label>
													<input type="text" id="input" required="required" placeholder="Cargo" name="cargo">
												</div>
												<div id="results"><p class="bg-success"><b>Cadastro enviado para a ASUG com sucesso!</b> <br /><br /> Seu cadastro será analisado, aguarde contato em seu e-mail.</p></div>
											</div>
											<div class="form-group">
												<input type="hidden" name="id_post" value="<?php echo get_the_ID(); ?>">
												<input type="hidden" name="id_usuario" value="<?php echo get_current_user_id(); ?>">
												<input type="hidden" name="evento" value="asug_day_conferencia_anual">
												<input type="hidden" name="perfil" value="<?php echo $current_user->roles[0]; ?>">
												<script>
												$(document).ready(function(){
													$('#results').hide();
													$('.btnenviar').click( function() {
														var formData = {
								'id_post'					: $('input[name=id_post]').val(),
								'id_usuario'				: $('input[name=id_usuario]').val(),
															'nome'			: $('input[name=nome]').val(),
															'empresa'			: $('input[name=empresa]').val(),
															'email'			: $('input[name=email]').val(),
															'telefone'			: $('input[name=telefone]').val(),
															'celular'			: $('input[name=celular]').val(),
															'endereco'			: $('input[name=endereco]').val(),
															'cargo'			: $('input[name=cargo]').val(),
															'id_post'			: $('input[name=id_post]').val(),
															'id_usuario'			: $('input[name=id_usuario]').val(),
															'perfil'			: $('input[name=perfil]').val(),
															'evento'			: $('input[name=evento]').val()
														};
														$.ajax({
															type: "POST",
															url: '<?php echo get_bloginfo('url'); ?>/wp-content/plugins/inscricao-de-eventos/inscricao-de-eventos.php',
															data 		: formData,
															dataType 	: 'json',
															encode          : true,
															success: function(data){
																alert(data.message);
																if (data.success==true) {
																	window.location.reload();
																}
															}
														})
													});
});
</script>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
	<button type="button" class="btn btn-primary btnenviar" id="submitButton">Confirmar</button>
</div>
</form>
</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<?php
	} else {
		logar_modal('1', "<p style=\"text-center\"><img src='". $botao_de_cadastro ."' alt=\"Cadastre-se\" /></p>","botaoInscricao");
	}
}
$location = get_field('local_do_evento');
?>
 <script type="text/javascript" src="https://raw.githubusercontent.com/objectivehtml/GmapHelper/master/gmaphelper.js"></script>
 <script type="text/javascript">
$(function() {
	function mapaFix() {
	var latlng = new google.maps.LatLng( <?php echo $location['lat']; ?>, <?php echo $location['lng']; ?> );
   var mapOptions = {
    center: latlng,
    position	: latlng,
    zoom: 16
   };
   var map = new google.maps.Map(document.getElementById("acf-map"),mapOptions);
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
  $('#mapTab').click(mapaFix);
  $('#mapTab').mouseover(mapaFix);
  $('#mapTab').mouseout(mapaFix);
});
</script>
<ul class="nav nav-tabs gradeHF">
	<li class="active"><a href="#horario" data-toggle="tab">Grade de programação</a></li>
	<li><a href="#localizacao" data-toggle="tab" id="mapTab">Localização do evento</a></li>
	<?php 
	if ( ($eventoPassou==false) && (have_rows('fotos')) ) { ?>
		<li><a href="#galeria" data-toggle="tab">Álbum de fotos</a></li>
	<?php } ?>
</ul>
<div class="tab-content">
	<div class="tab-pane fade in active gradeHF" id="horario">
		<table class="table table-condensed table-hover">
			<thead>
				<tr class="active">
					<td>Horário</td>
					<td>Título da palestra</td>
					<td>Palestrante</td>
					<td>Detalhes da palestra</td>
					<td>Empresa</td>
					<?php if (!$eventoPassou) { ?><td>Material</td><?php } ?>
				</tr>
			</thead>
			<tbody>
				<?php
				$i = 0;
				if( have_rows('grade') ):
					while ( have_rows('grade') ) : the_row();
				$horario = get_sub_field('horario');
				$titulo_da_palestra = get_sub_field('titulo_da_palestra');
				$detalhes_da_palestra = get_sub_field('detalhes_da_palestra');
				$palestrante = get_sub_field('palestrante');
				$empresa_palestra = get_sub_field('empresa');
				//$sala = get_sub_field('sala');
				//$capacidade_da_sala = get_sub_field('capacidade_da_sala');
				$upload_do_material = get_sub_field('upload_do_material');
				?>
				<tr>
										<?php
					$time = mktime(  date('H')+3, date('i') );
					$horario = gmdate("H:i", $horario);
					 ?>
					<td> <?php echo $horario; ?> </td>
					<td> <?php echo $titulo_da_palestra; ?> </td>
					<td> <?php echo $palestrante; ?> </td>
					<td><small><?php detalhes_modal($detalhes_da_palestra,$i); ?></small></td>
					<td> <?php echo $empresa_palestra; ?> </td>
				<?php if (!$eventoPassou) { ?>
						<?php if($upload_do_material) {
								if ( is_user_logged_in() ) {
							echo "<td><a href=\"".$upload_do_material."\" title=\"".$titulo_da_palestra."\">Download</a></td>";
								} else { ?>
							<td><?php logar_modal($i,"Download","btn btn-primary"); ?></td>
								<?php }
						} else {
							echo "<td>-</td>";
						}?>
					<?php } ?>
				</tr>
				<?php
				$i++;
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
<div class="tab-pane fade" id="localizacao">
		<?php 
						if( !empty($location) ){
							?>
							<div class="acf-map" id="acf-map">
								<div class="marker" data-lat="<?php echo $location['lat']; ?>" data-lng="<?php echo $location['lng']; ?>"></div>
							</div>
							<p class="address text-center"><?php echo $location['address']; ?></p>
							<?php } ?>
</div>
<?php
		if( have_rows('patrocinadores') ):
			echo "<hr>
		<div class=\"panel panel-default patrocinadores\">
		  <div class=\"panel-heading\">Patrocinadores</div>
		  <div class=\"panel-body\">";
			while ( have_rows('patrocinadores') ) : the_row();
		$foto_do_evento = get_sub_field('logo');
		?>
		<img src="<?php echo $foto_do_evento; ?>" alt="Patrocinador" />
		<?php
			endwhile;
			echo "</div></div>";
		endif;
		?>
</div><!-- .entry-content-page -->
<?php
				    endwhile; //resetting the page loop
				    wp_reset_query(); //resetting the page query
				    ?>
				</div><!-- #content -->
			</div><!-- #primary --></td>
			<?php } else { ?>
			<td><div id="primary" class="site-content two_coluna">
				<div id="content" role="main">
					<?php while ( have_posts() ) : the_post(); ?>
					<div class="entry-content-page">
						<?php get_template_part( 'content', get_post_format() ); ?>
					</div>
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
<?php get_footer();
}
?>