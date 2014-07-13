<?php
/*
 * Renderiza o painel do admin
 * Plugin: Sincronizador de Dados SAP
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

if ( !defined( 'ABSPATH' ) || !is_admin() || !current_user_can('manage_options') )
	wp_die('Acesso restrito.');

?>

<style>

#message.info {
	border-left-color: #189D8F;
	color: inherit;
}
.button-line {
	line-height: 28px !important;
}

	.button-line .button {
		margin: 0 1em;
	}
	
.limitado {
	width: 25em;
}
	
.right {
	text-align: right;
}

.legenda,
.label-radio {
	margin-right: 1em;
}

input[type=checkbox],
input[type=radio] {
    margin-top: -0.5px;
}

input.small-text[type="number"] {
    width: 70px;
}
	
</style>



<div class="wrap">

	<form id="importar" action="<?php echo $_SERVER['REQUEST_URI']; ?>" method="post" enctype="multipart/form-data">

	

		<h2>Importar Usuários</h2>

		<?php
		if ( $info ) :
			?>
			
			<div id="message" class="updated info">
				<p><?php print implode( '<br />', $info ) ?></p>
			</div>
			
			<?php
		endif;
		imprimirMensagensAdmin()
		?>
		
		<h2 class="hidden">&nbsp;</h2>
		
		

		<h3>Dados</h3>

		
		
		<table class="form-table">
			<tbody>
			
				<?php if ( $arquivo = imp_uploadExistente() ) : ?>
				
				<tr>
					<th scope="row">
						<label for="fonte-arquivo">
							<input id="fonte-arquivo" name="fonte" type="radio" value="arquivo" <?php checked( $_POST['fonte'], 'arquivo' ) OR checked( $_POST['fonte'], 'upload' ) ?>>
							Re-utilizar aquivo:
						</label>
					</th>
					<td>
						Enviado em
						<?php
						$mtime = filemtime( $arquivo );
						ajustarFusoHorario();
						print date( 'd/m/Y à\\s H:i', $mtime );
						print ' (há ' . human_time_diff( $mtime, time() ) . ' atrás)';
						?>
					</td>
				</tr>
				
				<?php endif; ?>
				
				<tr>
					<th scope="row">
						<label for="fonte-upload">
							<input id="fonte-upload" name="fonte" type="radio" value="upload" <?php if ( !$arquivo ) checked( $_POST['fonte'], 'upload' ) ?>>
							Enviar arquivo CSV:
						</label>
					</th>
					<td>
						<input id="upload" name="upload" type="file" accept=".csv">
						<p class="description">(tamanho máximo: <?php print formatarTamanho( limiteUpload(), 0 ) ?>)</p>
					</td>
				</tr>
				
				<tr>
					<th scope="row">
						<label for="fonte-texto">
							<input id="fonte-texto" name="fonte" type="radio" value="texto" <?php checked( $_POST['fonte'], 'texto' ) OR checked( $_POST['fonte'], '' ) ?>>
							Colar entradas:
						</label>
					</th>
					<td>
						<textarea id="texto" name="texto" rows="10" cols="50" class="large-text code" wrap="off"><?php print esc_html( stripslashes( obter( $_POST, 'texto', '' ) ) ) ?></textarea>
						<span class="legenda">Formato:</span>
						<label for="texto_csv_nao" class="label-radio">
							<input name="texto_csv" id="texto_csv_nao" value="0" type="radio" <?php checked( $_POST['texto_csv'], 0 ) OR checked( $_POST['texto_csv'], '' ) ?>>
							Tabular
						</label>
						<label for="texto_csv_sim" class="label-radio">
							<input name="texto_csv" id="texto_csv_sim" value="1" type="radio" <?php checked( $_POST['texto_csv'], 1 ) ?>>
							CSV
						</label>
						<p class="description">Lembre-se de que a primeira linha deve conter os nomes das colunas.</p>
					</td>
				</tr>
				
			</tbody>
		</table>



		<h3>Opções</h3>
		
		<table class="form-table">
			<tbody>
			
				<tr>
					<th scope="row">
						<label for="tipo">Tipo de entrada</label>
					</th>
					<td>
						<label for="tipo_pf" class="label-radio">
							<input name="tipo" id="tipo_pf" value="pf" type="radio" <?php checked( $_POST['tipo'], 'pf' ) ?>>
							Usuários
						</label>
						<label for="tipo_pj" class="label-radio">
							<input name="tipo" id="tipo_pj" value="pj" type="radio" <?php checked( $_POST['tipo'], 'pj' ) ?>>
							Empresas
						</label>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="inicio">Entradas a processar</label>
					</th>
					<td>
						Linhas
						<input name="inicio" id="inicio" value="<?php post('inicio', 1) ?>" class="small-text" type="number">
						a
						<input name="fim" id="fim" value="<?php post('fim', 1000) ?>" class="small-text" type="number">
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="confirmar_email">Confirmação</label>
					</th>
					<td>
						<label for="confirmar_email">
							<input name="confirmar_email" id="confirmar_email" value="1" type="checkbox" <?php checked( $_POST['confirmar_email'], 1 ) ?>>
							Enviar confirmação de e-mail para os usuários
						</label>
					</td>
				</tr>
				
			</tbody>
		</table>
		
		<?php wp_nonce_field( 'importar-usuarios', 'csrfToken' ) ?>
		<button id="btn-importar" type="submit" class="button button-primary">Importar</button>
		
		
		
		<?php if ( file_exists( "$imp_config[caminho_arquivos]/$imp_config[arquivo_exportar]" ) ) : ?>
		
			<p>&nbsp;</p>
		
			<h3>Relação de Usuários Notificados</h3>
			
			<p>Uma relação de todos os usuários que foram importados e receberam notificação se encontra no arquivo abaixo:</p>
			
			<p class="code"><a href="<?php print "$imp_config[url_arquivos]/$imp_config[arquivo_exportar]" ?>"><?php print "$imp_config[url_arquivos]/$imp_config[arquivo_exportar]" ?></a></p>
		
		<?php endif; ?>


	</form>

</div>



<script>

jQuery( function($) {
	// Upload
	$('#upload').on( 'change', function() {
		if ( this.value )
			$('#fonte-upload').click();
	} );
	// Texto
	$('#texto').on( 'paste', function() {
		if ( this.value )
			$('#fonte-texto').click();
	} );
} );

</script>
