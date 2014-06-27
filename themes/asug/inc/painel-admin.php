<div class="wrap">
<form id="asug-admin" action="<?php echo $_SERVER['REQUEST_URI']; ?>" method="post">

	<h2 id="backtotop">Configurações do Template ASUG</h2>

	<?php if ( $_REQUEST['saved'] ) : ?>
	
		<div id="message" class="updated">
			<p>Suas configurações foram salvas.</p>
		</div>
		
	<?php endif; ?>

	<p class="submit">
		<input name="save" type="submit" value="Salvar configurações" class="button button-primary">
	</p>
	
	<table class="form-table">
	
		<tbody>
		
			<tr>
				<th scope="row">
					<label for="asug_copyright">Copyright no rodapé</label>
				</th>
				<td>
					<textarea name="asug_copyright" id="asug_copyright" cols="49" rows="6"><?php print $opcao['copyright'] ?></textarea>
				</td>
			</tr>
			
		</tbody>
	
	</table>
	
	<h3 class="title">Redes Sociais</h3>
	
	<p>Deixe um campo em branco para que o ícone correspondente não apareça no rodapé.</p>
	
	<table class="form-table">
	
		<tbody>
		
			<tr>
				<th scope="row">
					<label for="asug_facebook">Facebook</label>
				</th>
				<td>
					<input name="asug_facebook" id="asug_facebook" value="<?php print $opcao['facebook'] ?>" class="regular-text" type="text">
				</td>
			</tr>
		
			<tr>
				<th scope="row">
					<label for="asug_twitter">Twitter</label>
				</th>
				<td>
					<input name="asug_twitter" id="asug_twitter" value="<?php print $opcao['twitter'] ?>" class="regular-text" type="text">
				</td>
			</tr>
		
			<tr>
				<th scope="row">
					<label for="asug_linkedin">LinkedIn</label>
				</th>
				<td>
					<input name="asug_linkedin" id="asug_linkedin" value="<?php print $opcao['linkedin'] ?>" class="regular-text" type="text">
				</td>
			</tr>
		
			<tr>
				<th scope="row">
					<label for="asug_yahoo">Yahoo</label>
				</th>
				<td>
					<input name="asug_yahoo" id="asug_yahoo" value="<?php print $opcao['yahoo'] ?>" class="regular-text" type="text">
				</td>
			</tr>
		
			<tr>
				<th scope="row">
					<label for="asug_windows">Windows</label>
				</th>
				<td>
					<input name="asug_windows" id="asug_windows" value="<?php print $opcao['windows'] ?>" class="regular-text" type="text">
				</td>
			</tr>
		
			<tr>
				<th scope="row">
					<label for="asug_orkut">Orkut</label>
				</th>
				<td>
					<input name="asug_orkut" id="asug_orkut" value="<?php print $opcao['orkut'] ?>" class="regular-text" type="text">
				</td>
			</tr>
		
			<tr>
				<th scope="row">
					<label for="asug_instagram">Instagram</label>
				</th>
				<td>
					<input name="asug_instagram" id="asug_instagram" value="<?php print $opcao['instagram'] ?>" class="regular-text" type="text">
				</td>
			</tr>
		
		</tbody>
	
	</table>

	<p class="submit">
		<input name="save" type="submit" value="Salvar configurações" class="button button-primary">
		<input type="hidden" name="action" value="save" />
	</p>

</form>
</div>