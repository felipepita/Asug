<?php
/*
 * Painel para configurar a associação (cadastro) de usuários e entidades
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */
 
if ( !defined( 'ABSPATH' ) || !is_admin() || !current_user_can('manage_options') )
	wp_die('Acesso restrito.');
	
?>



<style>

H2 {
	padding-top: 1em !important;
}

H3 {
	font-size: 19px;
	margin-top: 1.75em;
}

.button-line {
	line-height: 28px !important;
}

	.button-line .button {
		margin: 0 1em;
	}
	
textarea {
	max-width: 100%;
	width: 60em;
	height: 12em;
}

table.tokens {
    margin: 1em 0;
    border: 1px solid #DDD;
    border-collapse: collapse;
}

	table.tokens thead {
		background: white;
	}

	table.tokens th,
	table.tokens td {
		padding: 5px 15px;
	}

	table.tokens td {
		border-bottom: dotted 1px #ddd;
	}
	
table.email {
	margin-top: 0 !important;
}

	table.email td {
		vertical-align: top !important;
	}
	
	table.email td:first-child {
		width: 200px !important;
	}
	
	table.email strong {
		line-height: 2em;
	}
	
input.assunto {
	width: 60em !important;
}
	
</style>



<div class="wrap">
	<form id="form-painel-associacao" action="<?php echo $_SERVER['REQUEST_URI']; ?>" method="post">

	
	
		<h1 class="title" id="backtotop">Configurações da Associação</h1>

		<?php if ( $mensagens ) : ?>
		
			<div id="message" class="updated">
				<p><?php print implode( '<br />', $mensagens ) ?></p>
			</div>
			
		<?php endif; ?>

		<?php if ( $erros ) : ?>
		
			<div id="message" class="error">
				<p><?php print implode( '<br />', $erros ) ?></p>
			</div>
			
		<?php endif; ?>
		
		<h2 class="hidden">&nbsp;</h2>
	
		<p class="submit">
			<input name="save" type="submit" value="Salvar configurações" class="button button-primary">
		</p>

		
		
		<h2 class="title">Informações sobre a Associação</h2>
	
		<table class="form-table">
		
			<tbody>
			
				<tr>
					<th scope="row">
						<label for="form-info_associacao1">Cliente Não Associado</label>
					</th>
					<td>
						<textarea name="info_associacao1" id="form-info_associacao1"><?php print $associacao_config['info_associacao1'] ?></textarea>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="form-info_associacao2">Cliente Associado</label>
					</th>
					<td>
						<textarea name="info_associacao2" id="form-info_associacao2"><?php print $associacao_config['info_associacao2'] ?></textarea>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="form-info_associacao3">Parceiro Não Associado</label>
					</th>
					<td>
						<textarea name="info_associacao3" id="form-info_associacao3"><?php print $associacao_config['info_associacao3'] ?></textarea>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="form-info_associacao4">Parceiro Associado</label>
					</th>
					<td>
						<textarea name="info_associacao4" id="form-info_associacao4"><?php print $associacao_config['info_associacao4'] ?></textarea>
					</td>
				</tr>
				
			</tbody>
		
		</table>
	
		<p class="submit">
			<input name="save" type="submit" value="Salvar configurações" class="button button-primary">
		</p>
		
		
		
		<h2 class="title">Mensagens de Cadastro</h2>
	
		<table class="form-table">
		
			<tbody>
			
				<tr>
					<th scope="row">
						<label for="form-funcionario_cadastrado">Funcionário Cadastrado</label>
					</th>
					<td>
						<textarea name="funcionario_cadastrado" id="form-funcionario_cadastrado"><?php print $associacao_config['funcionario_cadastrado'] ?></textarea>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="form-representante_cadastrado1">Representante Cadastrado &ndash; Parte 1</label>
					</th>
					<td>
						<textarea name="representante_cadastrado1" id="form-representante_cadastrado1"><?php print $associacao_config['representante_cadastrado1'] ?></textarea>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="form-representante_cadastrado_gratuito">Representante Cadastrado &ndash; Parte 2 &ndash; Anuidade Gratuita</label>
					</th>
					<td>
						<textarea name="representante_cadastrado_gratuito" id="form-representante_cadastrado_gratuito"><?php print $associacao_config['representante_cadastrado_gratuito'] ?></textarea>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="form-representante_cadastrado_pago">Representante Cadastrado &ndash; Parte 2 &ndash; Anuidade Paga</label>
					</th>
					<td>
						<textarea name="representante_cadastrado_pago" id="form-representante_cadastrado_pago"><?php print $associacao_config['representante_cadastrado_pago'] ?></textarea>
					</td>
				</tr>
			
				<tr>
					<th scope="row">
						<label for="form-representante_cadastrado2">Representante Cadastrado &ndash; Parte 3</label>
					</th>
					<td>
						<textarea name="representante_cadastrado2" id="form-representante_cadastrado2"><?php print $associacao_config['representante_cadastrado2'] ?></textarea>
					</td>
				</tr>
				
			</tbody>
		
		</table>
	
		<p class="submit">
			<input name="save" type="submit" value="Salvar configurações" class="button button-primary">
		</p>
		
		
		
		<h2 class="title">E-mails &ndash; Geral</h2>
		
		<br />
		
		<p>As mensagens suportam a utilização de tokens para a inserção de valores dinâmicos.</p>
		
		<p>Além dos tokens listados abaixo, cada mensagem pode utilizar outros tokens próprios, os quais estão listados ao lado de cada mensagem.</p>
		
		<p>Tokens disponíveis em todas as mensagens:</p>
		
		<table class="tokens">
			<thead>
				<tr>
					<th>Token</th>
					<th>Descrição</th>
					<th>Exemplo</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<tt>&lt;%nome_site%&gt;</tt>
					</td>
					<td>
						Nome do site
					</td>
					<td>
						<?php print esc_html( get_option('blogname') ) ?>
					</td>
				</tr>
				<tr>
					<td>
						<tt>&lt;%home_url%&gt;</tt>
						</td>
					<td>
						URL do site
					</td>
					<td>
						<?php print home_url('/') ?>
					</td>
				</tr>
				<tr>
					<td>
						<tt>&lt;%admin_url%&gt;</tt>
					</td>
					<td>
						URL do admin
					</td>
					<td>
						<?php print admin_url('/') ?>
					</td>
				</tr>
				<tr>
					<td>
						<tt>&lt;%data%&gt;</tt>
					</td>
					<td>
						Data atual
					</td>
					<td>
						<?php print formatarData( time() ) ?>
					</td>
				</tr>
				<tr>
					<td>
						<tt>&lt;%horario%&gt;</tt>
					</td>
					<td>
						Hora e minutos atuais
					</td>
					<td>
						<?php print date('h:i') ?>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table class="form-table">
			<tbody>
				<tr>
					<th scope="row">
						<label for="form-email_rodape">Rodapé dos E-mails</label>
					</th>
					<td>
						<textarea name="email_rodape" id="form-email_rodape"><?php print $associacao_config['email_rodape'] ?></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	
		<p class="submit">
			<input name="save" type="submit" value="Salvar configurações" class="button button-primary">
		</p>
		
		
		
		<h2 class="title">E-mails &ndash; Mensagens individuais</h2>
		
		<?php foreach ( $associacao_email_config as $chave => $email ) : ?>
		
			<h3 class="title"><?php print $email['titulo'] ?></h3>
		
			<table class="form-table email">
				<tbody>
				
					<tr>
						<td>
							<?php if ( $email['tokens'] ) : ?>
								<strong>Tokens:</strong>
								<ul>
									<?php foreach ( $email['tokens'] as $token => $desc ) : ?>
										<li>
											<tt>&lt;%<?php print $token ?>%&gt;</tt>
											<br />
											<?php print $desc ?>
										</li>
									<?php endforeach; ?>
								</ul>
							<?php endif; ?>
						</td>
						<td>
							<ul>
								<li>
									<strong>Assunto:</strong><br />
									<?php print "<input name='{$chave}_assunto' type='text' class='regular-text assunto' value='" . esc_attr( $associacao_config[ $chave . '_assunto' ] ) . "' title='Assunto do e-mail' />"; ?>
								</li>
								<li>
									<strong>Corpo:</strong><br />
									<?php print "<textarea name='{$chave}_corpo' class='email'>" . esc_html( $associacao_config[ $chave . '_corpo' ] ) . "</textarea>"; ?>
								</li>
							</ul>
						</td>
					</tr>
					
				</tbody>
			
			</table>
			
		<?php endforeach; ?>
	
		<p class="submit">
			<input name="save" type="submit" value="Salvar configurações" class="button button-primary">
		</p>

		
		
	</form>
</div>