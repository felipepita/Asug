<?php
get_header();
$url = trailingslashit( get_template_directory_uri() );
obterQuery( 'revelar' );


add_action( 'wp_print_scripts', 'de_script', 100 );

function de_script() {
    wp_deregister_script( 'jquery-form' );
    wp_dequeue_script( 'contact-form-7' );
}


?>



<style>

#content {
	overflow: hidden;
	transition: all 500ms ease-out;
}

.container-paineis {
	margin: 0;
	<?php if ( !$_GET['revelar'] ) : ?>
	width: 500%;
	<?php endif; ?>
	transition: all 500ms ease-out;
}

.painel {
	<?php if ( !$_GET['revelar'] ) : ?>
	float: left;
	margin: 0;
	width: 20%;
	<?php endif; ?>
	overflow: hidden;
	padding: 0 0 1em;
	transition: height 750ms ease-in;
}

#content h1 {
	margin-bottom: 0;
}

#content h1:after {
    display: block;
	position: absolute;
	left: 0;
	right: 0;
	bottom: -14px;
    z-index: 10;
	margin: 0 auto;
    width: 12px;
    height: 0px;
    border-style: solid;
    border-width: 6px 1em 1em;
    border-color: #364473 transparent transparent;
    line-height: 0px;
	font-size: 8px;
	content: '';
}

#content h2 {
    font-family: 'Open Sans Condensed',sans-serif;
    color: #FFF;
    background-color: rgba(0, 154, 142, 0.9);
    margin: 0 0 1em;
    display: block;
    padding: 8px 0px;
    font-size: 24px;
    text-transform: uppercase;
    text-align: center;
    position: relative;
}

#content h3 {
	margin-bottom: 1em;
}

#content ul > li {
	list-style: circle;
	margin-left: 20px;
	padding-left: 5px;
}

#content dt {
	clear: left;
	float: left;
	margin-right: 0.25em;
}

#content dd {
	float: left;
}

fieldset {
	margin-bottom: 1em;
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

#content .mensagens {
	clear: both;
	margin: 1em 0;
	padding: 0.5em 1em;
}

.ajax-loader {
	display: inline-block;
	float: right;
	margin: 7px 15px 0;
	width: 32px;
	height: 32px;
	background: url('<?php print $url ?>images/ajax-loader-redondo.gif') no-repeat;
	line-height: 20px;
}

input.carregando {
	background-image: url('<?php print $url ?>images/inline-loader.gif');
	background-position: 95% center;
	background-repeat: no-repeat;
}

.btn.btn-lg {
	height: auto;
}

#desc_associacao {
	overflow: hidden;
	transition: all ease-out 375ms;
}

</style>



<div id="primary" class="site-content">
	<div id="content" role="main" class="table-responsive">
	
		<h1 class="entry-title">Associe-se</h1>

		<form id="form-associe-se" role="form" class="container-paineis row ajax" action="./ajax/" method="post">
		
			<input id="form-secao" name="secao" type="hidden" value="conta">
			<?php wp_nonce_field( 'associe-se', 'csrfToken' ) ?>
			
			
			
			<section id="section-conta" class="col-xs-12 painel grupo-cep">
			
				<h2>Dados da Conta</h2>
			
				<div class="row">
			
					<div class="col-xs-12 col-sm-6">
						
						<div class="form-group">
							<label for="form-nome_completo" class="obrigatorio">Seu nome completo:</label>
							<input id="form-nome_completo" name="nome_completo" type="text" class="form-control">
						</div>
						
						<div class="form-group">
							<label for="form-username" class="obrigatorio">Nome do usuário:</label>
							<input id="form-username" name="username" type="text" class="form-control input-var">
							<p class="help-block">Por favor, utilize apenas letras sem acentos, números e subtraços (_).</p>
						</div>
					
						<div class="form-group">
							<label for="form-email_cadastro" class="obrigatorio">E-mail:</label>
							<input id="form-email_cadastro" name="email_cadastro" type="email" class="form-control">
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
							<label for="form-sexo" class="obrigatorio">Sexo:</label>
							<select id="form-sexo" name="sexo" class="form-control">
								<?php gerarLista('sexo') ?>
							</select>
						</div>
						
						<div class="form-group" class="obrigatorio">
							<label for="form-cargo">Cargo:</label>
							<input id="form-cargo" name="cargo" type="text" class="form-control">
						</div>
						
					</div>
					<div class="col-xs-12 col-sm-6">
						
						<div class="form-group">
							<label for="form-telefone" class="obrigatorio">Telefone:</label>
							<input id="form-telefone" name="telefone" type="text" class="form-control input-telefone">
						</div>
						
						<div class="form-group">
							<label for="form-cep" class="obrigatorio">CEP:</label>
							<input id="form-cep" name="cep" type="text" class="form-control input-cep">
						</div>
						
						<div class="form-group">
							<label for="form-endereco" class="obrigatorio">Endereço:</label>
							<input id="form-endereco" name="endereco" type="text" class="form-control input-endereco">
						</div>
						
						<div class="form-group">
							<label for="form-complemento">Complemento:</label>
							<input id="form-complemento" name="complemento" type="text" class="form-control input-complemento">
						</div>
						
						<div class="form-group">
							<label for="form-bairro" class="obrigatorio">Bairro:</label>
							<input id="form-bairro" name="bairro" type="text" class="form-control input-bairro">
						</div>
						
						<div class="form-group">
							<label for="form-cidade" class="obrigatorio">Cidade:</label>
							<input id="form-cidade" name="cidade" type="text" class="form-control input-cidade">
						</div>
						
						<div class="form-group">
							<label for="form-estado" class="obrigatorio">Estado:</label>
							<select id="form-estado" name="estado" class="form-control input-estado">
								<?php gerarLista('estado') ?>
							</select>
						</div>
						
						<div class="form-group" class="obrigatorio">
							<label for="form-nivel_cargo">Nível de cargo:</label>
							<select id="form-nivel_cargo" name="nivel_cargo" class="form-control">
								<?php gerarLista('nivel_cargo') ?>
							</select>
						</div>
						
						<div class="form-group">
							<label for="form-informativo" class="checkbox">
								<input id="form-informativo" name="informativo" type="checkbox" value="1">
								Desejo receber o informativo da ASUG
							</label>
						</div>
						
						<button type="submit" class="btn btn-primary btn-lg pull-right">Prosseguir</button>
						
					</div>
					
				</div>
			
			</section>



			<section id="section-associacao" class="col-xs-12 painel grupo-cep hidden">
			
				<h2>Tipo de Associação</h2>
			
				<div class="row">
			
					<div class="col-xs-12">
					
						<p>Sua empresa <strong id="associacao_sufixo">dominio.com</strong> ainda não está cadastrada na ASUG.</p>
					
						<p>Defina a relação de sua empresa com a ASUG e opte ou não pela associação.</p>
						
						<div class="form-group">
							<label for="form-associacao_1" class="radio">
								<input id="form-associacao_1" name="tipo_associacao" type="radio" value="1">
								Cliente Não Associada
							</label>
							<label for="form-associacao_2" class="radio">
								<input id="form-associacao_2" name="tipo_associacao" type="radio" value="2">
								Cliente Associada
							</label>
							<label for="form-associacao_3" class="radio">
								<input id="form-associacao_3" name="tipo_associacao" type="radio" value="3">
								Parceira Não Associada
							</label>
							<label for="form-associacao_4" class="radio">
								<input id="form-associacao_4" name="tipo_associacao" type="radio" value="4">
								Parceira Associada
							</label>
							<button type="submit" class="btn btn-primary btn-lg pull-right">Prosseguir</button>
						</div>
						
					</div>
					
					<div id="desc_associacao" class="col-xs-12"><div class="wrapper"></div></div>

					<div id="info_associacao_1" class="col-xs-12 hidden">
					
						<h3>Empresa cliente não associada &ndash; Anuidade Gratuita</h3>
						
						<ul>
							<li>Cliente não associado consegue fazer o cadastro de usuários do mesmo subdomínio;</li>
							<li>Visualizar todo o conteúdo do portal;</li>
							<li>Pode se inscrever em eventos.</li>
						</ul>
					
					</div>
					
					<div id="info_associacao_2" class="col-xs-12 hidden">
					
						<h3>Empresa cliente associada &ndash; Anuidade R$3500,00</h3>
					
						<p>Pessoas jurídicas de direito público ou privado que tenham a licença de uso de software SAP, para operação de seus negócios no Brasil.</p>

						<p>Benefícios das empresas clientes associadas:</p>

						<ul>
							<li>Cadastro ilimitado de profissionais no Portal ASUG;</li>
							<li>Acesso a todo conteúdo restrito do Portal ASUG;</li>
							<li>Participação nas reuniões de Grupos de Pesquisas e Estudos;</li>
							<li>Fórum;</li>
							<li>Download de Apresentações e Cases;</li>
							<li>Participação em Eventos: Conferência Anual, Impact Awards e Eventos Regionais;</li>
							<li>ASUG News (versões impressa e digital).</li>
						</ul>

					</div>
					
					<div id="info_associacao_3" class="col-xs-12 hidden">
					
						<h3>Empresa parceira não associada &ndash; Anuidade Gratuita</h3>
					
						<p>Pessoas jurídicas de direito público ou privado que não desejam se associar, porém, possuem interesse em participar dos eventos da ASUG Brasil.</p>

						<p>Alguns benefícios das empresas cadastradas:</p>

						<ul>
							<li>Cadastro ilimitado de usuários no Portal ASUG;</li>
							<li>ASUG News (versões impressa e digital);</li>
							<li>Recebimento de comunicados e convites da ASUG Brasil.</li>
						</ul>

						<p>Esta categoria não é de associação e, portanto, não têm direito ao voto nas Assembléias e não podem ser eleitos ou indicados para nenhum cargo na ASUG Brasil.</p>
					
					</div>
					
					<div id="info_associacao_4" class="col-xs-12 hidden">
					
						<h3>Empresa parceira associada &ndash; Anuidade R$4400,00</h3>
						
						<p>Pessoas jurídicas de direito público ou privado que, apesar de não atenderem à qualificação de cliente SAP, representam interesse significativo no relacionamento empresarial com a ASUG Brasil, sendo capazes de gerar negócios.</p>

						<p>Benefícios das empresas parceiras associadas:</p>

						<ul>
							<li>Cadastro ilimitado de profissionais no Portal ASUG;</li>
							<li>Acesso a todo conteúdo restrito do Portal ASUG;</li>
							<li>Participação nas reuniões de Grupos de Pesquisas e Estudos;</li>
							<li>O parceiro poderá ministrar assuntos de domínio e específicos para um grupo, além de trocar cartões e gerar oportunidades;</li>
							<li>Fórum;</li>
							<li>Download de Apresentações e Cases;</li>
							<li>ASUG News (versões impressa e digital);</li>
							<li>Recebimento de comunicados e convites para participação nos eventos da ASUG Brasil.</li>
						</ul>
					
					</div>
					
				</div>
				
			</section>
			


			<section id="section-empresa" class="col-xs-12 painel grupo-cep hidden">
			
				<h2>Dados da Empresa</h2>
			
				<div class="row">
			
					<div class="col-xs-12 col-sm-6">
						
						<div class="form-group">
							<label for="form-empresa_nome_fantasia" class="obrigatorio">Nome fantasia:</label>
							<input id="form-empresa_nome_fantasia" name="empresa_nome_fantasia" type="text" class="form-control">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_razao_social" class="obrigatorio">Razão Social:</label>
							<input id="form-empresa_razao_social" name="empresa_razao_social" type="text" class="form-control">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_cnpj" class="obrigatorio">CNPJ:</label>
							<input id="form-empresa_cnpj" name="empresa_cnpj" type="text" class="form-control input-cnpj">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_grupo_controlador">Grupo controlador:</label>
							<input id="form-empresa_grupo_controlador" name="empresa_grupo_controlador" type="text" class="form-control">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_ramo" class="obrigatorio">Ramo:</label>
							<select id="form-empresa_ramo" name="empresa_ramo" class="form-control">
								<?php gerarLista('ramo') ?>
							</select>
						</div>
						
						<div class="form-group">
							<label for="form-empresa_faturamento" class="obrigatorio">Faturamento:</label>
							<select id="form-empresa_faturamento" name="empresa_faturamento" class="form-control">
								<?php gerarLista('faturamento') ?>
							</select>
						</div>
						
						<div class="form-group">
							<label for="form-empresa_qtd_funcionarios" class="obrigatorio">Número de funcionários:</label>
							<select id="form-empresa_qtd_funcionarios" name="empresa_qtd_funcionarios" class="form-control">
								<?php gerarLista('qtd_funcionarios') ?>
							</select>
						</div>
						
						<div class="form-group">
							<label for="form-empresa_qtd_usuarios" class="obrigatorio">Número de usuários:</label>
							<select id="form-empresa_qtd_usuarios" name="empresa_qtd_usuarios" class="form-control">
								<?php gerarLista('qtd_usuarios') ?>
							</select>
						</div>
						
						<div class="form-group">
							<label for="form-empresa_versao_erp" class="obrigatorio">Versão do ERP:</label>
							<input id="form-empresa_versao_erp" name="empresa_versao_erp" type="text" class="form-control">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_website" class="obrigatorio">Website:</label>
							<input id="form-empresa_website" name="empresa_website" type="url" class="form-control" disabled>
							<p class="help-block">É obrigatoriamente o mesmo domínio de seu e-mail.</p>
						</div>
						
					</div>
					<div class="col-xs-12 col-sm-6">
						
						<div class="form-group">
							<label for="form-empresa_telefone" class="obrigatorio">Telefone:</label>
							<input id="form-empresa_telefone" name="empresa_telefone" type="text" class="form-control input-telefone">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_telefone">FAX:</label>
							<input id="form-empresa_telefone" name="empresa_telefone" type="text" class="form-control input-telefone">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_cep" class="obrigatorio">CEP:</label>
							<input id="form-empresa_cep" name="empresa_cep" type="text" class="form-control input-cep">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_endereco" class="obrigatorio">Endereço:</label>
							<input id="form-empresa_endereco" name="empresa_endereco" type="text" class="form-control input-endereco">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_complemento">Complemento:</label>
							<input id="form-empresa_complemento" name="empresa_complemento" type="text" class="form-control input-complemento">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_bairro" class="obrigatorio">Bairro:</label>
							<input id="form-empresa_bairro" name="empresa_bairro" type="text" class="form-control input-bairro">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_cidade" class="obrigatorio">Cidade:</label>
							<input id="form-empresa_cidade" name="empresa_cidade" type="text" class="form-control input-cidade">
						</div>
						
						<div class="form-group">
							<label for="form-empresa_estado" class="obrigatorio">Estado:</label>
							<select id="form-empresa_estado" name="empresa_estado" class="form-control input-estado">
								<?php gerarLista('estado') ?>
							</select>
						</div>
						
						<div class="form-group">
							<label for="form-contato_publico" class="checkbox">
								<input id="form-contato_publico" name="contato_publico" type="checkbox" value="1">
								Tornar público os dados de contato
							</label>
						</div>
						
						<button type="submit" class="btn btn-primary btn-lg pull-right">Prosseguir</button>
						
					</div>
					
				</div>
			
			</section>
			


			<section id="section-funcionarios" class="col-xs-12 painel grupo-cep hidden">
			
				<h2>Dados dos Funcionários</h2>
				
				<fieldset><legend>Representante n&ordm; 1</legend>
				
					<div class="row">
					
						<div class="col-xs-12">
							<strong><em>Você</em> é o representante n&ordm; 1.</strong>
						</div>
					
					</div>
				
				</fieldset>
				
				<fieldset><legend>Representante n&ordm; 2</legend>
			
					<div class="row">
				
						<div class="col-xs-12 col-sm-6">
							
							<div class="form-group">
								<label for="form-rep2_nome_completo" class="obrigatorio">Nome completo:</label>
								<input id="form-rep2_nome_completo" name="rep2_nome_completo" type="text" class="form-control">
							</div>
							
							<div class="form-group">
								<label for="form-rep2_cargo" class="obrigatorio">Cargo:</label>
								<input id="form-rep2_cargo" name="rep2_cargo" type="text" class="form-control">
							</div>
							
							<div class="form-group" class="obrigatorio">
								<label for="form-rep2_nivel_cargo" class="obrigatorio">Nível de cargo:</label>
								<select id="form-rep2_nivel_cargo" name="rep2_nivel_cargo" class="form-control">
									<?php gerarLista('nivel_cargo') ?>
								</select>
							</div>
							
						</div>
						<div class="col-xs-12 col-sm-6">
							
							<div class="form-group">
								<label for="form-rep2_telefone" class="obrigatorio">Telefone:</label>
								<input id="form-rep2_telefone" name="rep2_telefone" type="text" class="form-control input-telefone">
							</div>
							
							<div class="form-group">
								<label for="form-rep2_email" class="obrigatorio">E-mail:</label>
								<input id="form-rep2_email" name="rep2_email" type="email" class="form-control input-email">
							</div>
							
						</div>
						
					</div>
					
				</fieldset>
				
				<fieldset><legend>CIO</legend>
			
					<div class="row">
				
						<div class="col-xs-12 col-sm-6">
							
							<div class="form-group">
								<label for="form-cio_nome_completo" class="obrigatorio">Nome completo:</label>
								<input id="form-cio_nome_completo" name="cio_nome_completo" type="text" class="form-control">
							</div>
							
							<div class="form-group">
								<label for="form-cio_cargo" class="obrigatorio">Cargo:</label>
								<input id="form-cio_cargo" name="cio_cargo" type="text" class="form-control">
							</div>
							
							<div class="form-group" class="obrigatorio">
								<label for="form-cio_nivel_cargo" class="obrigatorio">Nível de cargo:</label>
								<select id="form-cio_nivel_cargo" name="cio_nivel_cargo" class="form-control">
									<?php gerarLista('nivel_cargo') ?>
								</select>
							</div>
							
						</div>
						<div class="col-xs-12 col-sm-6">
							
							<div class="form-group">
								<label for="form-cio_telefone" class="obrigatorio">Telefone:</label>
								<input id="form-cio_telefone" name="cio_telefone" type="text" class="form-control input-telefone">
							</div>
							
							<div class="form-group">
								<label for="form-cio_email" class="obrigatorio">E-mail:</label>
								<input id="form-cio_email" name="cio_email" type="email" class="form-control input-email">
							</div>
							
						</div>
						
					</div>
					
				</fieldset>
				
				<fieldset id="fieldset-fin">
					
					<legend>Financeiro (opcional)</legend>
			
					<div class="row">
					
						<div class="col-xs-12">
						
							<div class="form-group">
								<label for="form-fin_habilitar" class="checkbox">
									<input id="form-fin_habilitar" name="fin_habilitar" type="checkbox" value="1">
									Habilitar
								</label>
							</div>
						
						</div>
				
						<div class="col-xs-12 col-sm-6">
							
							<div class="form-group">
								<label for="form-fin_nome_completo" class="obrigatorio">Nome completo:</label>
								<input id="form-fin_nome_completo" name="fin_nome_completo" type="text" class="form-control">
							</div>
							
							<div class="form-group">
								<label for="form-fin_cargo" class="obrigatorio">Cargo:</label>
								<input id="form-fin_cargo" name="fin_cargo" type="text" class="form-control">
							</div>
							
							<div class="form-group" class="obrigatorio">
								<label for="form-fin_nivel_cargo" class="obrigatorio">Nível de cargo:</label>
								<select id="form-fin_nivel_cargo" name="fin_nivel_cargo" class="form-control">
									<?php gerarLista('nivel_cargo') ?>
								</select>
							</div>
							
						</div>
						<div class="col-xs-12 col-sm-6">
							
							<div class="form-group">
								<label for="form-fin_telefone" class="obrigatorio">Telefone:</label>
								<input id="form-fin_telefone" name="fin_telefone" type="text" class="form-control input-telefone">
							</div>
							
							<div class="form-group">
								<label for="form-fin_email" class="obrigatorio">E-mail:</label>
								<input id="form-fin_email" name="fin_email" type="email" class="form-control input-email">
							</div>
							
						</div>
						
					</div>
					
				</fieldset>
			
				<button type="submit" class="btn btn-primary btn-lg pull-right">Finalizar</button>
						
			</section>



			<section id="section-representante" class="col-xs-12 painel grupo-cep hidden">
			
				<h2>Cadastro Bem-Sucedido!</h2>
				
				<p>O cadastro de sua conta e de sua empresa foram realizados com sucesso!</p>
				
				<p>Uma mensagem foi enviada para seu e-mail. Por favor, siga o link contido nela para validar seu e-mail.</p>
				
				<p id="info_gratuito" class="hidden">Após a validação, um administrador irá rever seu cadastro e liberará sua conta.</p>
				
				<p id="info_pago" class="hidden">Após a validação, um administrador irá rever seu cadastro e lhe enviará um boleto por e-mail para que efetue o pagamento da anuidade. Mediante a confirmação do pagamento, sua conta será liberada.</p>
				
				<p>A partir de então, funcionários de sua empresa poderão se cadastrar no portal da ASUG e gozarão de todos os benefícios do plano de associação de escolheu.</p>
			
			</section>
			
			
			
			<section id="section-sufixo" class="col-xs-12 painel grupo-cep hidden">
			
				<h2>Cadastro Bem-Sucedido!</h2>
				
				<p>O cadastro de sua conta foi realizado com sucesso e sua empresa foi reconhecida no sistema:</p>
				
				<dl>
					<dt></dt>
					<dd id="info_empresa_logo"></dd>
					<?php // <img id="info_empresa_logo" src="" alt="Logotipo da empresa"> ?>
					<dt>Empresa:</dt>
					<dd id="info_empresa_nome"></dd>
					<dt>Tipo de associação:</dt>
					<dd id="info_empresa_tipo_associacao"></dd>
				</dl>
			
			</section>

			
			
		</form>
		
		
		
		<script src="<?php print $url ?>js/ajaxform.js"></script>
		
		<script>
		
		var $secao,
			$primeiroPainel,
			$fieldsetFin,
			paineisNavegados = 0,
			larguraPainel = 0,
			demoraTrocaPainel = 3500,
			animAssociacao = 375,
			sufixo = '';
		
		function retornoAjax( dados ) {
		
			var tipoAssociacao;
			
			jQuery( '#section-' + $secao.val() + ' button[type=submit]' ).attr('disabled', true);
		
			switch ( $secao.val() ) {
			
				case 'conta' :
				
					if ( dados.acao ) {
						//jQuery('#info_empresa_logo').attr( 'src', dados.acao.logo );
						jQuery('#info_empresa_logo').append( dados.acao.logo );
						jQuery('#info_empresa_nome').html( dados.acao.nome );
						jQuery('#info_empresa_tipo_associacao').html( dados.acao.tipo_associacao );
						resetOnSucess = true;
						setTimeout( "trocarPainel('sufixo')", demoraTrocaPainel );
					} else {
						sufixo = jQuery('#form-email_cadastro').val().match( /([a-z][-a-z0-9]+(?:\.[a-z]{2,4})+)(?:\/|$)/ )[1];
						jQuery('#associacao_sufixo').html( sufixo );
						jQuery('#form-empresa_website').val( 'http://' + sufixo );
						setTimeout( "trocarPainel('associacao')", demoraTrocaPainel );
					}
			
				break;
				case 'associacao' :
				
					setTimeout( "trocarPainel('empresa')", demoraTrocaPainel );
					
				break;
				case 'empresa' :
				
					setTimeout( "trocarPainel('funcionarios')", demoraTrocaPainel );
					
				break;
				case 'funcionarios' :
				
					resetOnSucess = true;
					
					$('input[name=tipo_associacao]').each( function() {
						if ( this.checked )
							tipoAssociacao = this.value;
					} );
					
					if ( tipoAssociacao == 1 || tipoAssociacao == 3 ) {
						jQuery('#info_gratuito').removeClass('hidden');
					} else {
						jQuery('#info_pago').removeClass('hidden');
					}
					
					setTimeout( "trocarPainel('representante')", demoraTrocaPainel );
				
				break;
			
			}
		
		}
		
		function trocarPainel( painel ) {
			++paineisNavegados;
			jQuery('form .mensagens').fadeOut( ajaxAnim ).css( 'margin-left', larguraPainel * paineisNavegados + 'px' );
			$secao.val( painel );
			jQuery( '.painel:not(.hidden)' ).css( 'height', '42px' );
			jQuery( '#section-' + painel ).removeClass('hidden');
			$primeiroPainel.css( 'margin-left', -100 * paineisNavegados + '%' );
		}
		
		// onLoad
		
		jQuery( function() {
		
			$secao = jQuery('#form-secao');
			//$primeiroPainel = jQuery('.container-paineis > .painel:first-of-type');
			$primeiroPainel = jQuery('.container-paineis');
			larguraPainel = jQuery('#content').width();
			runOnSuccess = retornoAjax;
			resetOnSuccess = false;
			
			//$infoAssociacao = jQuery('div[id^=info_associacao]');
			//$infoAssociacao.hide();
			$infoAssociacao = jQuery('#desc_associacao'); //.css( 'height', 0 );
			
			jQuery('input[name=tipo_associacao]').on( 'change', function() {
				//$infoAssociacao.hide();
				//console.log( '#info_associacao_' + this.value );
				//jQuery('#info_associacao_' + this.value).show();
				$infoAssociacao
					//.css( 'height', 0 )
					.children()
						.html( jQuery('#info_associacao_' + this.value).html() )
						.end();
					//.css( 'height', $infoAssociacao.children()[0].scrollHeight );
			} );
			
			$fieldsetFin = jQuery('#fieldset-fin').find('.form-control');
			$fieldsetFin.attr( 'disabled', true );
			
			jQuery('#form-fin_habilitar').on( 'change', function() {
				$fieldsetFin.attr( 'disabled', !this.checked );
			} );
			
			<?php if ( $_GET['revelar'] ) : ?>
			jQuery('.painel').removeClass('hidden');
			<?php endif; ?>
			
		} );
		
		</script>



	</div><!-- #content -->
</div><!-- #primary -->



<?php get_footer(); ?>