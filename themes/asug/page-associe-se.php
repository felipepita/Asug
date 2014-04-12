<?php
get_header();
$url = trailingslashit( get_template_directory_uri() );
?>



<style>

#content h2 {
	margin-bottom: 1em;
}

#content input.form-control,
#content select.form-control {
	width: 100%;
	padding: 2px 4px;
}

#content .mensagens {
	margin: 1em;
	padding: 0.25em;
}

.ajax-loader {
	display: inline-block;
	float: right;
	margin: 4px 12px;
	width: 16px;
	height: 11px;
	background: url('<?php print $url ?>images/inline-loader.gif') no-repeat;
	line-height: 20px;
}

input.carregando {
	background-image: url('<?php print $url ?>images/inline-loader.gif');
	background-position: 95% center;
	background-repeat: no-repeat;
}

</style>



<div id="primary" class="site-content">
	<div id="content" role="main" class="table-responsive">
	
		<h1 class="entry-title">Associe-se</h1>
		<span class="arrow-w"></span>

		<form id="form-associe-se" role="form" class="paineis ajax" action="./ajax/" method="post">
		
			<input id="form-secao" name="secao" type="hidden" value="conta">
			
			

			<section id="section-conta" class="painel row">
			
				<h2>Dados da Conta</h2>
			
				<div class="col-xs-12 col-sm-6">
					
					<div class="form-group">
						<label for="form-nome" class="obrigatorio">Seu nome completo:</label>
						<input id="form-nome" name="nome" type="text" class="form-control">
					</div>
					
					<div class="form-group">
						<label for="form-usuario" class="obrigatorio">Nome do usuário:</label>
						<input id="form-usuario" name="usuario" type="text" class="form-control input-var">
						<p class="help-block">Por favor, utilize apenas letras sem acentos, números e subtraços (_).</p>
					</div>
				
					<div class="form-group">
						<label for="form-email" class="obrigatorio">E-mail:</label>
						<input id="form-email" name="email" type="email" class="form-control">
						<p class="help-block">Por favor, utilize seu e-mail profissional com o domínio da empresa. NÃO utilize e-mails pessoais (hotmail, gmail, etc.)</p>
					</div>
					
					<div class="form-group">
						<label for="form-senha" class="obrigatorio">Senha:</label>
						<input id="form-senha" name="senha" type="password" class="form-control">
					</div>
					
					<div class="form-group">
						<label for="form-repetir_senha" class="obrigatorio">Confirme a senha:</label>
						<input id="form-repetir_senha" name="repetir_senha" type="password" class="form-control">
					</div>
					
					<div class="form-group">
						<label for="form-sexo">Sexo:</label>
						<select id="form-sexo" name="sexo" class="form-control">
							<?php gerarLista('sexo') ?>
						</select>
					</div>
					
					<div class="form-group">
						<label for="form-cargo">Cargo:</label>
						<input id="form-cargo" name="cargo" type="text" class="form-control">
					</div>
					
					<div class="form-group">
						<label for="form-nivel_cargo">Nível de cargo:</label>
						<select id="form-nivel_cargo" name="nivel_cargo" class="form-control">
							<?php gerarLista('nivel_cargo') ?>
						</select>
					</div>
					
				</div>
				<div class="col-xs-12 col-sm-6">
					
					<div class="form-group">
						<label for="form-telefone">Telefone:</label>
						<input id="form-telefone" name="telefone" type="text" class="form-control input-telefone">
					</div>
					
					<div class="form-group">
						<label for="form-cep">CEP:</label>
						<input id="form-cep" name="cep" type="text" class="form-control input-cep">
					</div>
					
					<div class="form-group">
						<label for="form-endereco">Endereço:</label>
						<input id="form-endereco" name="endereco" type="text" class="form-control input-endereco">
					</div>
					
					<div class="form-group">
						<label for="form-complemento">Complemento:</label>
						<input id="form-complemento" name="complemento" type="text" class="form-control input-complemento">
					</div>
					
					<div class="form-group">
						<label for="form-bairro">Bairro:</label>
						<input id="form-bairro" name="bairro" type="text" class="form-control input-bairro">
					</div>
					
					<div class="form-group">
						<label for="form-cidade">Cidade:</label>
						<input id="form-cidade" name="cidade" type="text" class="form-control input-cidade">
					</div>
					
					<div class="form-group">
						<label for="form-estado">Estado:</label>
						<select id="form-estado" name="estado" class="form-control input-estado">
							<?php gerarLista('estado') ?>
						</select>
					</div>
					
					<div class="form-group">
						<label for="form-informativo">
							<input id="form-informativo" name="informativo" type="checkbox" value="1">
							Receber o informativo da ASUG
						</label>
					</div>
					
				</div>
				<div class="col-xs-12 clearfix">
					
					<button type="submit" class="btn btn-primary pull-right">Prosseguir</button>
				
				</div>
			
			</section>
			


		</form>
		
		
		
		<script src="<?php print $url ?>js/ajaxform.js"></script>



	</div><!-- #content -->
</div><!-- #primary -->



<?php get_footer(); ?>