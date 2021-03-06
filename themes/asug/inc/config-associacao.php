<?php

global $associacao_config, $associacao_email_config;

$associacao_config = array();

$associacao_padroes = array(

	// Configuração de dias restantes para a notificação
	
	'notificacao_degustacao'	=> '10, 5',
	
	'notificacao_membro'		=> '60, 30, 10, 5',

	// Info de associação
	
	'info_representante' => '
<p>Ao cadastrar a empresa, você automaticamente se tornará sua representante.</p>
	',

	// Info do tipo de associação

	'info_associacao1' => '
<h3>Empresa cliente não associada &ndash; Anuidade Gratuita</h3>

<ul>
	<li>Cliente não associado consegue fazer o cadastro de associados do mesmo subdomínio;</li>
	<li>Visualizar todo o conteúdo do portal;</li>
	<li>Pode se inscrever em eventos.</li>
</ul>
	',
	
	'info_associacao2' => '
<h3>Empresa cliente associada &ndash; Anuidade R$3500,00</h3>

<p>Pessoas jurídicas de direito público ou privado que tenham a licença de uso de software SAP, para operação de seus negócios no Brasil.</p>

<p>Benefícios das empresas clientes associadas:</p>

<ul>
	<li>Cadastro ilimitado de profissionais no Portal ASUG;</li>
	<li>Acesso a todo conteúdo restrito do Portal ASUG;</li>
	<li>Participação nas reuniões de Grupos de Pesquisas e Estudos;</li>
	<li>Fórum de discussões (perguntas e respostas);</li>
	<li>Download de Apresentações e Cases (Apresentações realizadas nos eventos e nos Grupos de Estudos);</li>
	<li>Participação em Eventos: Conferência Anual, Impact Awards e Eventos Regionais (inscrições sem custos);</li>
	<li>Recebimento da revista ASUG News (versões impressa e digital).</li>
</ul>
	',
	
	'info_associacao3' => '
<h3>Empresa parceira não associada &ndash; Anuidade Gratuita</h3>

<p>Pessoas jurídicas de direito público ou privado que não desejam se associar, porém, possuem interesse em participar dos eventos da ASUG Brasil.</p>

<p>Alguns benefícios das empresas cadastradas:</p>

<ul>
	<li>Cadastro ilimitado de associados no Portal ASUG;</li>
	<li>ASUG News (versões impressa e digital);</li>
	<li>Recebimento de comunicados e convites da ASUG Brasil.</li>
</ul>

<p>Esta categoria não é de associação e, portanto, não têm direito ao voto nas Assembléias e não podem ser eleitos ou indicados para nenhum cargo na ASUG Brasil.</p>
	',
	
	'info_associacao4' => '
<h3>Empresa parceira associada &ndash; Anuidade R$4400,00</h3>

<p>Pessoas jurídicas de direito público ou privado que, apesar de não atenderem à qualificação de cliente SAP, representam interesse significativo no relacionamento empresarial com a ASUG Brasil, sendo capazes de gerar negócios.</p>

<p>Benefícios das empresas parceiras associadas:</p>

<ul>
	<li>Cadastro ilimitado de profissionais no Portal ASUG;</li>
	<li>Acesso a todo conteúdo restrito do Portal ASUG;</li>
	<li>Participação nas reuniões de Grupos de Pesquisas e Estudos;</li>
	<li>O parceiro poderá ministrar assuntos de domínio e específicos para um grupo, além de trocar cartões e gerar oportunidades;</li>
	<li>Fórum de discussões (perguntas e respostas);</li>
	<li>Download de Apresentações e Cases;</li>
	<li>Recebimento da revista ASUG News (versões impressa e digital).</li>
</ul>
	',
	
	// Cadastro bem sucedido
	
	'representante_cadastrado1' => '
<p>O cadastro de sua conta e de sua empresa foram realizados com sucesso!</p>

<p>Uma mensagem foi enviada para seu e-mail com a senha e a confirmação do cadastro. Por favor, siga o link contido nela para validar seu e-mail.</p>
	',
	
	'representante_cadastrado_gratuito' => '
<p>Após a validação, um administrador irá rever seu cadastro e liberará sua conta.</p>
	',
	
	'representante_cadastrado_pago' => '
<p>Após a validação, um administrador irá rever seu cadastro e lhe enviará um boleto por e-mail para que efetue o pagamento da anuidade. Mediante a confirmação do pagamento, sua conta será liberada.</p>
	',
	
	'representante_cadastrado2' => '
<p>A partir de então, associados de sua empresa poderão se cadastrar no portal da ASUG e gozarão de todos os benefícios do plano de associação que escolheu.</p>
	',
	
	'funcionario_cadastrado' => '
<p>O cadastro de sua conta foi realizado com sucesso!</p>

<p>Uma mensagem foi enviada para seu e-mail com a senha e a confirmação do cadastro. Por favor, siga o link contido nela para validar seu e-mail.</p>

<p>Você foi reconhecido como associado da empresa:</p>
	',
	
	// Falha no cadastro
	
	/*
	'empresa_inexistente' => '
<p>Não foi possível realizar o seu cadastro. A empresa à qual seu e-mail está vinculado não está associada no Portal ASUG:</p>
	',
	*/
	
	// E-mails - Geral
	
	'email_rodape' => '
Atenciosamente,
A Equipe do <%nome_site%>
	',
	
	// E-mails - Cadastro de Empresa / Representante
	
	'email_cadastro_rep_assunto' => '<%nome_site%> - Verifique seu cadastro',
	
	'email_cadastro_rep_corpo' => '
Olá <%nome%>,

Obrigado por cadastrar sua empresa <%empresa%> no <%nome_site%>! Para verificar seu cadastro, precisamos que siga o link abaixo para confirmar seu endereço de e-mail:

<%confirmacao_url%>
	',
	
	// E-mails - Cadastro de Empresa / Representante (p/ Admin)
	
	'email_admin_cadastro_rep_assunto' => '<%nome_site%> - Uma nova empresa se cadastrou e requer ativação',
	
	'email_admin_cadastro_rep_corpo' => '
Uma nova empresa se cadastrou no site <%nome_site%> e requer ativação. Seguem os detalhes da empresa:

<%perfil_empresa%>

Abaixo, os detalhes do representante:

<%perfil_representante%>

Para alterar o status desta empresa, acesse o link abaixo:

<%admin_url%>users.php?page=user-status-manager/start.php&strUserSearch=<%email%>

Para enviar boletos ao representante, acesse seu perfil:

<%admin_url%>user-edit.php?user_id=<%id_representante%>

Pare ver o perfil completo da empresa, acesse o perfil:

<%admin_url%>user-edit.php?user_id=<%id_empresa%>
	',
	
	// E-mails - Cadastro de Associado
	
	'email_cadastro_func_assunto' => '<%nome_site%> - Verifique seu cadastro',
	
	'email_cadastro_func_corpo' => '
Olá <%nome%>,

Obrigado por se cadastrar no <%nome_site%>! Você foi registrado como associado da empresa <%empresa%>.

Para verificar seu cadastro, precisamos que siga o link abaixo para confirmar seu endereço de e-mail:

<%confirmacao_url%>
	',
	
	// E-mails - Cadastro de Associado (p/ Representante)
	
	'email_rep_cadastro_func_assunto' => '<%nome_site%> - Um novo associado de sua empresa se cadastrou',
	
	'email_rep_cadastro_func_corpo' => '
Olá <%nome%>,

Um novo associado de sua empresa <%empresa%> se cadastrou com os seguintes dados:

<%perfil%>
	',
	
	// E-mail - Confirmação
	
	'email_confirmacao_assunto' => '<%nome_site%> - Confirme seu endereço de e-mail',
	
	'email_confirmacao_corpo' => '
Olá <%nome%>,

Precisamos que siga o link abaixo para confirmar seu endereço de e-mail:

<%confirmacao_url%>
	',
	
	// Conta confirmada - ativa
	
	'email_conta_confirmada_ativa_assunto' => '<%nome_site%> - Conta ativada',
	
	'email_conta_confirmada_ativa_corpo' => '
Olá <%nome%>,

Sua conta foi verificada e está ativada! Seguem os dados de login:

E-mail: <%email%>
Senha: <%senha%>

Você pode entrar em sua conta no endereço abaixo:

<%login_url%>
	',
	
	// Conta confirmada - inativa
	
	'email_conta_confirmada_inativa_assunto' => '<%nome_site%> - Conta confirmada',
	
	'email_conta_confirmada_inativa_corpo' => '
Olá <%nome%>,

Sua conta foi verificada e aguarda a ativação de um administrador.
Guarde bem seus dados de login:

E-mail: <%email%>
Senha: <%senha%>
	',
	
	// Conta ativada
	
	'email_conta_ativada_assunto' => '<%nome_site%> - Conta ativada',
	
	'email_conta_ativada_corpo' => '
Olá <%nome%>,

Sua conta foi liberada pela nossa administração e você pode entrar no site pelo seguinte endereço:

<%login_url%>
	',
	
	// Conta desativada
	
	'email_conta_desativada_assunto' => '<%nome_site%> - Conta desativada',
	
	'email_conta_desativada_corpo' => '
Olá <%nome%>,

Informamos que sua conta foi desativada pela nossa administração.
	',
	
	// Senha alterada
	
	'email_senha_alterada_assunto' => '<%nome_site%> - Sua senha foi alterada',
	
	'email_senha_alterada_corpo' => '
Olá <%nome%>,

Estamos te lembrando que sua senha foi alterada. Seguem seus dados de login atuais:

E-mail: <%email%>
Senha: <%senha%>

Faça o login pelo endereço abaixo:

<%login_url%>
	',
	
	// Expiração da Degustação em X dias
	
	'email_degustacao_x_assunto'   => '<%nome_site%> - O período de degustação vai terminar em <%dias%> dias',
	
	'email_degustacao_x_corpo'     => '
Olá <%nome%>,

Seu período de degustação no website da ASUG vai expirar em <%dias%> dias.
Evite interrupções no serviço e contate nossa equipe para efetuar sua assinatura.
	',
	
	// Expiração da Assinatura em X dias
	
	'email_membro_x_assunto'       => '<%nome_site%> - Sua conta vai expirar em <%dias%> dias',
	
	'email_membro_x_corpo'         => '
Olá <%nome%>,

Sua assinatura no website da ASUG vai expirar em <%dias%> dias.

Evite interrupções no serviço e contate nossa equipe para renovar sua assinatura.
	',
							  
	// Expiração da Degustação em 1 dia
	
	'email_degustacao_1_assunto'   => '<%nome_site%> - <%nome%>, o período de degustação termina amanhã',
	
	'email_degustacao_1_corpo'     => '
Olá <%nome%>,

Seu período de degustação no website da ASUG vai expirar amanhã.

Faça sua assinatura hoje mesmo e obtenha um desconto de 10% na anuidade.

Corra, a oferta é válida SOMENTE HOJE!
	',
	
	// Expiração da Assinatura em 1 dia
	
	'email_membro_1_assunto'       => '<%nome_site%> - <%nome%>, sua assinatura termina amanhã',
	
	'email_membro_1_corpo'         => '
Olá <%nome%>,

Sua assinatura no website da ASUG vai expirar amanhã.

Aja agora entrando em contato conosco e evite interrupções no serviço, renovando sua assinatura.
	',
	
	
);



// Configuração dos e-mails para a administração

$associacao_email_config = array(

	'email_cadastro_rep' => array(
		'titulo' => 'Empresa e representante cadastrados',
		'tokens' => array(
			'empresa' => 'Nome da empresa.',
			'confirmacao_url' => 'Link para verificação de e-mail.',
		),
	),

	'email_admin_cadastro_rep' => array(
		'titulo' => 'Empresa e representante cadastrados (mensagem p/ Admin)',
		'tokens' => array(
			'perfil_empresa' => 'Perfil completo da empresa.',
			'perfil_representante' => 'Perfil completo do representante.',
			'email' => 'E-mail do representante.',
			'id_representante' => 'ID do representante.',
			'id_empresa' => 'ID da empresa.',
		),
	),

	'email_cadastro_func' => array(
		'titulo' => 'Associado cadastrado',
		'tokens' => array(
			'empresa' => 'Nome da empresa.',
			'confirmacao_url' => 'Link para verificação de e-mail.',
		),
	),
	/*
	'email_rep_cadastro_func' => array(
		'titulo' => 'Associado cadastrado (mensagem p/ Representante)',
		'tokens' => array(
			'empresa' => 'Nome da empresa.',
			'perfil' => 'Perfil completo do associado.',
		),
	),
	*/
	'email_confirmacao' => array(
		'titulo' => 'Re-envio de confirmação de e-mail',
		'tokens' => array(
			'confirmacao_url' => 'Link para verificação de e-mail.',
		),
	),

	'email_conta_confirmada_ativa' => array(
		'titulo' => 'Conta confirmada e ativa',
		'tokens' => array(
			'senha' => 'Senha da conta.',
		),
	),

	'email_conta_confirmada_inativa' => array(
		'titulo' => 'Conta confirmada, mas ainda inativa',
		'tokens' => array(
			'senha' => 'Senha da conta.',
		),
	),

	'email_conta_ativada' => array(
		'titulo' => 'Conta ativada',
		'tokens' => array(
		),
	),

	'email_conta_desativada' => array(
		'titulo' => 'Conta desativada',
		'tokens' => array(
		),
	),

	'email_senha_alterada' => array(
		'titulo' => 'Senha alterada',
		'tokens' => array(
			'senha' => 'Nova senha da conta.',
		),
	),

	'email_degustacao_x' => array(
		'titulo' => 'Expiração da degustação em X dias',
		'tokens' => array(
			'dias' => 'Dias restantes.',
		),
	),

	'email_degustacao_1' => array(
		'titulo' => 'Expiração da degustação em 1 dia',
		'tokens' => array(
		),
	),

	'email_membro_x' => array(
		'titulo' => 'Expiração da assinatura em X dias',
		'tokens' => array(
			'dias' => 'Dias restantes.',
		),
	),

	'email_membro_1' => array(
		'titulo' => 'Expiração da assinatura em 1 dia',
		'tokens' => array(
		),
	),
	
);



// Define o config

foreach ( $associacao_padroes as $opcao => $padrao ) {
	// Puxa do BD e, se indefinido, utiliza o padrão
	$valor = get_option( 'associacao_' . $opcao );
	if ( $valor === false )
		$valor = trim( $padrao );
	$associacao_config[ $opcao ] = $valor;
}
