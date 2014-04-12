<?php

// Definições dos campos dos perfis e listas

global $campos, $listas;
$campos = array();
$listas = array();



// Listas

definir( $listas, array(

	array(
		'slug'				=> 'estado',
		'nome'				=> 'Estados',
		'valores'			=> array("AC"=>"Acre", "AL"=>"Alagoas", "AM"=>"Amazonas", "AP"=>"Amapá","BA"=>"Bahia","CE"=>"Ceará","DF"=>"Distrito Federal","ES"=>"Espírito Santo","GO"=>"Goiás","MA"=>"Maranhão","MT"=>"Mato Grosso","MS"=>"Mato Grosso do Sul","MG"=>"Minas Gerais","PA"=>"Pará","PB"=>"Paraíba","PR"=>"Paraná","PE"=>"Pernambuco","PI"=>"Piauí","RJ"=>"Rio de Janeiro","RN"=>"Rio Grande do Norte","RO"=>"Rondônia","RS"=>"Rio Grande do Sul","RR"=>"Roraima","SC"=>"Santa Catarina","SE"=>"Sergipe","SP"=>"São Paulo","TO"=>"Tocantins"
		),
	),
	
	array(
		'slug'				=> 'sexo',
		'nome'				=> 'Sexos',
		'valores'			=> array(
			'1' => 'Feminino',
			'2' => 'Masculino',
		),
	),
	
	array(
		'slug'				=> 'status',
		'nome'				=> 'Status',
		'valores'			=> array(
			'1' => 'Ativa',
			'2' => 'Necessita aceitar os termos',
			'0' => 'Desativada',
		),
	),
	
	array(
		'slug'				=> 'nivel_cargo',
		'nome'				=> 'Nível de cargo',
		'valores'			=> array(
			'-1' => '(a ser definido)',
		),
	),
	
	array(
		'slug'				=> 'ramo',
		'nome'				=> 'Ramo de atividade',
		'valores'			=> array(
			'-1' => '(a ser definido)',
		),
	),
	
	array(
		'slug'				=> 'qtd_funcionarios',
		'nome'				=> 'Número de funcionários',
		'valores'			=> array(
			'-1' => '(a ser definido)',
		),
	),
	
	array(
		'slug'				=> 'qtd_usuarios',
		'nome'				=> 'Número de funcionários',
		'valores'			=> array(
			'-1' => '(a ser definido)',
		),
	),
	
	array(
		'slug'				=> 'faturamento',
		'nome'				=> 'Faturamento anual',
		'valores'			=> array(
			'-1' => '(a ser definido)',
		),
	),
	
) );



// Campos

definir( $campos, array(

	array(
		'slug'				=> 'id',
		'nome'				=> 'ID',
		'sanitizador'		=> 'sanitizarNumerico',
	),

	array(
		'slug'				=> 'nome',
		'nome'				=> 'Nome',
		'msg_vazio'			=> 'Por favor, digite um nome.',
		'maxlength'			=> 64,
	),

	array(
		'slug'				=> 'nome_completo',
		'nome'				=> 'Nome completo',
		'msg_vazio'			=> 'Por favor, digite o nome completo.',
		'maxlength'			=> 128,
		'validador'			=> 'validarNomeCompleto',
	),

	array(
		'slug'				=> 'username',
		'nome'				=> 'Username',
		'msg_vazio'			=> 'Por favor, digite um nome de usuário.',
		'msg_invalido'		=> 'O nome do usuário deve conter apenas letras sem acentos, números e subtraços, deve começar com uma letra e conter entre 5 e 32 caracteres.',
		'msg_existente'		=> 'Esse username já está sendo utilizado por outro usuário no sistema.',
		'minlength'			=> 5,
		'maxlength'			=> 32,
		'validador'			=> 'validarVariavel',
	),

	array(
		'slug'				=> 'razao_social',
		'nome'				=> 'Razão social',
		'msg_vazio'			=> 'Por favor, informe a razão social.',
		'maxlength'			=> 128,
	),

	array(
		'slug'				=> 'email',
		'nome'				=> 'E-mail',
		'msg_vazio'			=> 'Por favor, informe um endereço de e-mail.',
		'msg_invalido'		=> 'O endereço de e-mail é inválido.',
		'msg_existente'		=> 'Já existe um usuário cadastrado com este endereço de e-mail.',
		'validador'			=> 'validarEmailUsuario',
		'maxlength'			=> 64,
	),

	array(
		'slug'				=> 'senha',
		'nome'				=> 'Senha',
		'msg_vazio'			=> 'Por favor, digite uma senha.',
		'msg_invalido'		=> "A senha deve conter pelo menos $config[senha_min] e não mais que $config[senha_max] caracteres.",
		'validador'			=> 'validarSenha',
		'minlength'			=> $config['senha_min'],
		'maxlength'			=> $config['senha_max'], // 14 com sinais
	),

	array(
		'slug'				=> 'repetir_senha',
		'nome'				=> 'Repetir a senha',
		'msg_vazio'			=> 'É necessário re-digitar a senha.',
		'msg_invalido'		=> 'As senhas não combinam.',
		'validador'			=> 'validarRepetirSenha',
		'minlength'			=> $config['senha_min'],
		'maxlength'			=> $config['senha_max'], // 14 com sinais
	),

	array(
		'slug'				=> 'confirmar_senha',
		'nome'				=> 'Confirme a operação digitando sua senha atual',
		'msg_vazio'			=> 'É necessário digitar a sua senha atual para confirmar a operação.',
		'msg_invalido'		=> "A senha de confirmação não está correta.",
		'validador'			=> 'validarConfirmarSenha',
		'minlength'			=> $config['senha_min'],
		'maxlength'			=> $config['senha_max'], // 14 com sinais
	),

	array(
		'slug'				=> 'cpf',
		'nome'				=> 'CPF',
		'msg_vazio'			=> 'Por favor, informe o CPF.',
		'msg_invalido'		=> 'Este CPF é inválido.',
		'msg_existente'		=> 'Já existe um usuário cadastrado com este CPF.',
		'sanitizador'		=> 'sanitizarNumerico',
		'validador'			=> 'validarCPFUsuario',
		'minlength'			=> 11,
		'maxlength'			=> 11, // 14 com sinais
	),

	array(
		'slug'				=> 'status',
		'nome'				=> 'Status da conta',
		'msg_vazio'			=> 'Defina um status.',
		'msg_invalido'		=> 'O status definido é inválido.',
		'sanitizador'		=> 'sanitizarInteiro',
		'lista'				=> 'status',
	),

	array(
		'slug'				=> 'cnpj',
		'nome'				=> 'CNPJ',
		'msg_vazio'			=> 'Por favor, preencha o CNPJ.',
		'msg_invalido'		=> 'Este CNPJ é inválido.',
		'msg_existente'		=> 'Já existe uma entidade cadastrada com esse CNPJ.',
		'sanitizador'		=> 'sanitizarNumerico',
		'validador'			=> 'validarCNPJEntidade',
		'minlength'			=> 14,
		'maxlength'			=> 14, // 18 com sinais
	),

	array(
		'slug'				=> 'nascimento',
		'nome'				=> 'Data de nascimento',
		'msg_vazio'			=> 'Por favor, informe a data de nascimento.',
		'msg_invalido'		=> 'Este site deve ser utilizado por maiores de 18 anos de idade.',
		'sanitizador'		=> 'sanitizarData',
		'validador'			=> 'validarIdade',
		'minlength'			=> 10,
		'maxlength'			=> 10,
	),

	array(
		'slug'				=> 'sexo',
		'nome'				=> 'Sexo',
		'msg_vazio'			=> 'Por favor, informe o sexo.',
		'sanitizador'		=> 'sanitizarSexo',
		'minlength'			=> 1,
		'maxlength'			=> 1,
	),

	array(
		'slug'				=> 'cep',
		'nome'				=> 'CEP',
		'msg_vazio'			=> 'Por favor, informe o CEP.',
		'msg_invalido'		=> 'O CEP não é válido.',
		'sanitizador'		=> 'sanitizarNumerico',
		'validador'			=> 'validarCEP',
		'minlength'			=> 8,
		'maxlength'			=> 8, // 9 com sinais
	),

	array(
		'slug'				=> 'endereco',
		'nome'				=> 'Endereço',
		'msg_vazio'			=> 'Por favor, informe o endereço completo.',
		'maxlength'			=> 128,
	),

	array(
		'slug'				=> 'numero',
		'nome'				=> 'Número',
		'msg_vazio'			=> 'Por favor, informe o número do logradouro.',
		'sanitizador'		=> 'sanitizarInteiro',
		'maxlength'			=> 5,
	),

	array(
		'slug'				=> 'complemento',
		'nome'				=> 'Complemento',
		'maxlength'			=> 128,
	),

	array(
		'slug'				=> 'bairro',
		'nome'				=> 'Bairro',
		'msg_vazio'			=> 'Por favor, informe o bairro.',
		'maxlength'			=> 64,
	),

	array(
		'slug'				=> 'cidade',
		'nome'				=> 'Cidade',
		'msg_vazio'			=> 'Por favor, informe a cidade.',
		'maxlength'			=> 64,
	),

	array(
		'slug'				=> 'estado',
		'nome'				=> 'Estado',
		'msg_vazio'			=> 'Por favor, informe o estado.',
		'msg_invalido'		=> 'Por favor, informe uma unidade federal.',
		'sanitizador'		=> 'sanitizarEstado',
		'minlength'			=> 2,
		'maxlength'			=> 2,
		'lista'				=> 'estado',
	),

	array(
		'slug'				=> 'telefone',
		'nome'				=> 'Telefone',
		'msg_vazio'			=> 'Por favor, informe um telefone de contato.',
		'msg_invalido'		=> 'Por favor, informe o DDD e telefone no formato (##) ####-####.',
		'sanitizador'		=> 'sanitizarNumerico',
		'minlength'			=> 10,
		'maxlength'			=> 11, // 15 com sinais
	),

	array(
		'slug'				=> 'fax',
		'nome'				=> 'Fax',
		'msg_vazio'			=> 'Por favor, informe o número do fax.',
		'msg_invalido'		=> 'Por favor, informe o número do fax no formato (##) ####-####.',
		'sanitizador'		=> 'sanitizarNumerico',
		'minlength'			=> 10,
		'maxlength'			=> 10,
	),

	array(
		'slug'				=> 'termos',
		'nome'				=> 'Termos de Uso',
		'msg_vazio'			=> 'Você deve concordar com os termos de uso para prosseguir.',
		'sanitizador'		=> 'sanitizarBoolean',
	),

	array(
		'slug'				=> 'newsletter',
		'nome'				=> 'Informativo',
		'msg_vazio'			=> 'Especifique se deseja receber nosso informativo.',
		'sanitizador'		=> 'sanitizarBoolean',
	),

	array(
		'slug'				=> 'cargo',
		'nome'				=> 'Cargo',
		'msg_vazio'			=> 'Por favor, informe o cargo.',
		'maxlength'			=> 64,
	),

	array(
		'slug'				=> 'nivel_cargo',
		'nome'				=> 'Nível de cargo',
		'msg_vazio'			=> 'Por favor, informe o nível do cargo.',
		'msg_invalido'		=> 'Por favor, informe um nível de cargo da lista.',
		'sanitizador'		=> 'sanitizarInteiro',
		'lista'				=> 'nivel_cargo',
	),

), 'CAMPO_' );