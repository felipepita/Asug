<?php
/*
 * Página de visualização e edição de Perfil do associado
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */
 
if ( !is_user_logged_in() ) {
	wp_redirect( site_url('/conta') );
}

get_header();
$perfil = perfilUsuario();

?>



<style>

#form-perfil {
	margin: 0 !important;
	padding-top: 1em;
}

#content input.form-control,
#content select.form-control {
	width: 100%;
	padding: 2px 4px;
}

label.obrigatorio:before {
	color: #e57824;
	content: '* ';
}

label.checkbox,
label.radio {
	display: inline-block;
	margin-right: 1em;
	cursor: pointer;
}

#content input {
	text-transform: none !important;
}

.btn.btn-lg {
	height: auto;
}

.col-campos {
	overflow: hidden;
}

</style>



<div id="primary" class="site-content">
	<div id="content" role="main" class="table-responsive">
	
	
	
		<h1 class="entry-title">Seu Perfil</h1>
		<span class="arrow-w"></span>

		<form id="form-perfil" role="form" class="row ajax" action="./ajax/" method="post">
		
			<?php wp_nonce_field( 'perfil', 'csrfToken' ) ?>

			<div class="col-xs-12 col-sm-6 col-campos">
				
				<div class="form-group">
					<label for="form-senha">Alterar senha:</label>
					<input id="form-senha" name="senha" type="password" class="form-control">
					<p class="help-block">Se não for alterar, por favor, deixe em branco.</p>
				</div>
				
				<div class="form-group">
					<label for="form-repetir_senha">Repita a senha nova:</label>
					<input id="form-repetir_senha" name="repetir_senha" type="password" class="form-control">
				</div>
				
				<div class="row">
				
					<div class="col-xs-5">
						
						<div class="form-group">
							<label for="form-tratamento" class="obrigatorio">Tratamento:</label>
							<select id="form-tratamento" name="tratamento" class="form-control">
								<?php gerarLista( 'tratamento', $perfil['tratamento'] ) ?>
							</select>
						</div>
				
					</div>
					<div class="col-xs-7">
						
						<div class="form-group">
							<label for="form-nome_completo" class="obrigatorio">Seu nome completo:</label>
							<input id="form-nome_completo" name="nome_completo" type="text" class="form-control" value="<?php print esc_attr( $perfil['display_name'] ) ?>">
						</div>
					
					</div>
				
				</div>
				
				<div class="form-group">
					<label for="form-sexo" class="obrigatorio">Sexo:</label>
					<select id="form-sexo" name="sexo" class="form-control">
						<?php gerarLista( 'sexo', $perfil['sexo'] ) ?>
					</select>
				</div>
				
				<div class="form-group" class="obrigatorio">
					<label for="form-cargo" class="obrigatorio">Cargo:</label>
					<select id="form-cargo" name="cargo" class="form-control">
						<?php gerarLista( 'cargo', $perfil['cargo'] ) ?>
					</select>
				</div>
				
				<div class="form-group" class="obrigatorio">
					<label for="form-nivel_cargo" class="obrigatorio">Departamento:</label>
					<select id="form-nivel_cargo" name="nivel_cargo" class="form-control">
						<?php gerarLista( 'nivel_cargo', $perfil['nivel_cargo'] ) ?>
					</select>
				</div>
				
				<?php /*
				<div class="form-group" class="obrigatorio">
					<label for="form-capacitacao" class="obrigatorio">Nível de capacitação:</label>
					<select id="form-capacitacao" name="capacitacao" class="form-control">
						<?php gerarLista( 'capacitacao', $perfil['capacitacao'] ) ?>
					</select>
				</div>
				*/ ?>
				
				<div class="form-group">
					<label for="form-telefone" class="obrigatorio">Telefone comercial:</label>
					<input id="form-telefone" name="telefone" type="text" class="form-control input-telefone" value="<?php print formatarTelefone( $perfil['telefone'] ) ?>">
				</div>
				
				<div class="form-group">
					<label for="form-fax">Fax comercial:</label>
					<input id="form-fax" name="fax" type="text" class="form-control input-fax" value="<?php print formatarTelefone( $perfil['fax'] ) ?>">
				</div>
				
			</div>
			<div class="col-xs-12 col-sm-6 col-campos">
				
				<div class="form-group">
					<label for="form-cep" class="obrigatorio">CEP:</label>
					<input id="form-cep" name="cep" type="text" class="form-control input-cep" value="<?php print formatarCEP( $perfil['cep'] ) ?>">
				</div>
				
				<div class="form-group">
					<label for="form-endereco" class="obrigatorio">Endereço comercial:</label>
					<input id="form-endereco" name="endereco" type="text" class="form-control input-endereco" value="<?php print esc_attr( $perfil['endereco'] ) ?>">
				</div>
				
				<div class="form-group">
					<label for="form-complemento">Complemento:</label>
					<input id="form-complemento" name="complemento" type="text" class="form-control input-complemento" value="<?php print esc_attr( $perfil['complemento'] ) ?>">
				</div>
				
				<div class="form-group">
					<label for="form-bairro" class="obrigatorio">Bairro:</label>
					<input id="form-bairro" name="bairro" type="text" class="form-control input-bairro" value="<?php print esc_attr( $perfil['bairro'] ) ?>">
				</div>
				
				<div class="form-group">
					<label for="form-cidade" class="obrigatorio">Cidade:</label>
					<input id="form-cidade" name="cidade" type="text" class="form-control input-cidade" value="<?php print esc_attr( $perfil['cidade'] ) ?>">
				</div>
				
				<div class="form-group">
					<label for="form-estado" class="obrigatorio">Estado:</label>
					<select id="form-estado" name="estado" class="form-control input-estado">
						<?php gerarLista( 'estado', $perfil['estado'] ) ?>
					</select>
				</div>
				
				<div class="form-group">
					<label for="form-informativo" class="checkbox">
						<input id="form-informativo" name="informativo" type="checkbox" value="1" <?php if ( $perfil['informativo'] ) print 'checked' ?>>
						Desejo receber o informativo da ASUG
					</label>
				</div>
				
				<div class="form-group">
					<label for="form-confirmar_senha" class="obrigatorio">Digite sua senha atual para confirmar a operação:</label>
					<input id="form-confirmar_senha" name="confirmar_senha" type="password" class="form-control">
				</div>
				
				<button type="submit" class="btn btn-primary btn-lg pull-right">Salvar</button>
				
			</div>
			
		</form>
		
		<script src="<?php print get_template_directory_uri() ?>/js/ajaxform.js"></script>
		
		<script>
		
			resetOnSuccess = false;
			//redirectOnSuccess = "<?php print site_url('/conta') ?>";
			runOnSuccess = function (dados) {
				jQuery('.col-campos').slideUp(350)
			};
		
		</script>
		
		
		
	</div><!-- #content -->
</div><!-- #primary -->



<?php
get_footer();