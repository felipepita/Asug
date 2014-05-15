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

H2 {
	padding-top: 1em !important;
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
	
</style>



<div class="wrap">

	<form id="sap-admin" action="<?php echo $_SERVER['REQUEST_URI']; ?>" method="post">

	

		<h1>Sincronizador de Dados SAP</h1>

		<?php if ( $sap_mensagens ) : ?>
		
			<div id="message" class="updated">
				<p><?php print implode( '<br />', $sap_mensagens ) ?></p>
			</div>
			
		<?php endif; ?>

		<?php if ( $sap_erros ) : ?>
		
			<div id="message" class="error">
				<p><?php print implode( '<br />', $sap_erros ) ?></p>
			</div>
			
		<?php endif; ?>
		
		<h2 class="hidden">&nbsp;</h2>
		
		

		<h2>Status da Conexão</h2>

		
		<table class="form-table">
			<tbody>
			
				<tr>
					<th scope="row">
						Configuração:
					</th>
					<td class="button-line">
						<?php
							print $sap_config['login_valido']
								? '<span style="color:#7a0">Válida</span>'
								: '<span style="color:#c30">Inválida</span>'
						?>
						<button id="btn-validar" type="submit" class="button">Revalidar</button>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						Última transferência:
					</th>
					<td>
						<?php print umVerdadeiroDe( formatarTempo( $sap_config['ultima_sinc'] ), 'Nunca' ) ?>
					</td>
				</tr>
				
			</tbody>
		</table>
		
		<p>Para sincronizar os dados manualmente, entre no perfil de um usuário e clique no botão "Sincronizar Agora".</p>



		<h2>Configurações da Autenticação</h2>
		
		<table class="form-table">
			<tbody>
			
				<tr>
					<th scope="row">
						<label for="servidor">Servidor</label>
					</th>
					<td>
						<input name="servidor" id="servidor" value="<?php print $sap_config['servidor'] ?>" class="regular-text" type="text">
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="company">Company ID</label>
					</th>
					<td>
						<input name="company" id="company" value="<?php print $sap_config['company'] ?>" class="regular-text" type="text">
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="username">Username</label>
					</th>
					<td>
						<input name="username" id="username" value="<?php print $sap_config['username'] ?>" class="regular-text" type="text">
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="password"><?php print $sap_config['password'] ? 'Redefinir' : 'Definir' ?> senha</label>
					</th>
					<td>
						<input name="password" id="password" value="" class="regular-text password" type="password">
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="logar">Log</label>
					</th>
					<td>
						<label for="logar">
							<input name="logar" id="logar" value="1" type="checkbox" <?php if ( $sap_config['logar'] ) print 'checked' ?>>
							Logar operações
						</label>
					</td>
				</tr>
			
				<tr>
					<th scope="row"></th>
					<td>
						<div class="limitado right">
							<button id="btn-salvar" type="submit" class="button button-primary">Salvar</button>
						</div>
					</td>
				</tr>
				
			</tbody>
		</table>
		
		
		
		<h2>Logs</h2>
		
		<?php
		$dirLogs = opendir( $sap_log_caminho );
		$listaLogs = array();
		while ( false !== ( $arquivo = readdir( $dirLogs ) ) ) {
			if ( $arquivo == '.' || $arquivo == '..' )
				continue;
			$listaLogs[] = $arquivo;
		}
		if ( $listaLogs ) :
			$totalLogs = count( $listaLogs );
			print "<p>Há um total de $totalLogs log disponíveis:</p>";
			print "<ul class='logs'>";
			foreach ( $listaLogs as $arquivoLog ) :
				print "<li><a href='$sap_log_url$arquivoLog' target='_blank' title='Abrir esse log em seu navegador'>$arquivoLog</a></li>";
			endforeach;
		else :
			?>
			<p>Não há logs disponíveis no momento.</p>
			<?php
		endif;
		?>
		
		

		<input id="operacao" name="operacao" type="hidden" value="salvar" />

	</form>

</div>

<script>

jQuery('#btn-salvar').on( 'click', function() {
	this.disabled = true;
	document.getElementById('operacao').value = 'salvar';
} );

jQuery('#btn-validar').on( 'click', function() {
	this.disabled = true;
	document.getElementById('operacao').value = 'validar';
} );

</script>
