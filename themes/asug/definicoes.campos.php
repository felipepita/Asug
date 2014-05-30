<?php
/*
 * Definições dos campos dos perfis e listas de valores
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */
 
 
 
global $campos, $listas;
$campos = array();
$listas = array();



// Listas

definir( $listas, array(

	array(
		'slug'				=> 'estado',
		'nome'				=> 'Estado',
		'valores'			=> array("AC"=>"Acre", "AL"=>"Alagoas", "AM"=>"Amazonas", "AP"=>"Amapá","BA"=>"Bahia","CE"=>"Ceará","DF"=>"Distrito Federal","ES"=>"Espírito Santo","GO"=>"Goiás","MA"=>"Maranhão","MT"=>"Mato Grosso","MS"=>"Mato Grosso do Sul","MG"=>"Minas Gerais","PA"=>"Pará","PB"=>"Paraíba","PR"=>"Paraná","PE"=>"Pernambuco","PI"=>"Piauí","RJ"=>"Rio de Janeiro","RN"=>"Rio Grande do Norte","RO"=>"Rondônia","RS"=>"Rio Grande do Sul","RR"=>"Roraima","SC"=>"Santa Catarina","SE"=>"Sergipe","SP"=>"São Paulo","TO"=>"Tocantins"
		),
	),
	
	array(
		'slug'				=> 'sexo',
		'nome'				=> 'Sexo',
		'valores'			=> array(
			'F' => 'Feminino',
			'M' => 'Masculino',
		),
	),
	
	array(
		'slug'				=> 'status',
		'nome'				=> 'Status',
		'valores'			=> array(
			'0' => 'Ativa',
			'1' => 'Desativada',
			'2' => 'Necessita aceitar os termos',
		),
	),
	
	array(
		'slug'				=> 'cargo',
		'nome'				=> 'Cargo',
		'valores'			=> array(
			'ADM'			=> 'Administrador',
			'ANA'			=> 'Analista',
			'ASS'			=> 'Assistente',
			'ATE'			=> 'Atendente',
			'AUD'			=> 'Auditor',
			'AUX'			=> 'Auxiliar',
			'CONS'			=> 'Consultor',
			'CONT'			=> 'Controller',
			'COOR'			=> 'Coordenador',
			'DIR'			=> 'Diretor',
			'ESP'			=> 'Especialista',
			'GER'			=> 'Gerente',
			'PRE'			=> 'Presidente',
			'SUP'			=> 'Supervisor',
			'TEC'			=> 'Técnico',
			'VP'			=> 'Vice-Presidente',
		),
	),
	
	array(
		'slug'				=> 'nivel_cargo',
		'nome'				=> 'Nível de cargo',
		'valores'			=> array(
			'ADMIN'			=> 'Administrativo',
			'CONT'			=> 'Controladoria',
			'DIR'			=> 'Diretoria',
			'FIN'			=> 'Financeiro',
			'MKT'			=> 'Marketing',
			'PRE'			=> 'Presidência',
			'RH'			=> 'Recursos Humanos',
			'TI'			=> 'Tecnologia da Informação',
			'VEN'			=> 'Vendas',
			'VP'			=> 'Vice-Presidência',
		),
	),
	
	array(
		'slug'				=> 'cargo_asug',
		'nome'				=> 'Cargo ASUG',
		'valores'			=> array(
			'ASS'			=> 'Associado',
			'CONV'			=> 'Convidado',
			'COOR'			=> 'Coordenador',
			'DIR'			=> 'Diretor',
			'PRE'			=> 'Presidente',
			'VP'			=> 'Vice-Presidente',
		),
	),
	
	array(
		'slug'				=> 'ramo',
		'nome'				=> 'Ramo de atividade',
		'valores'			=> array(
			'ADE'			=> 'Aeroespacial e Defesa',
			'ATE'			=> 'Alta tecnologia',
			'AME'			=> 'Assistência Médica',
			'AUT'			=> 'Automotivo',
			'BAN'			=> 'Bancário',
			'BCO'			=> 'Bens de consumo',
			'CVI'			=> 'Ciências da vida',
			'DSE'			=> 'Defesa e segurança',
			'DAT'			=> 'Distribuição no atacado',
			'ECO'			=> 'Engenharia, Construção e Operações',
			'ESU'			=> 'Ensino Superior',
			'EEN'			=> 'Esportes e entretenimento',
			'MIC'			=> 'Gerenciamento de ativos',
			'MID'			=> 'Maquinário industrial e Componentes',
			'MIN'			=> 'Mídia',
			'MID'			=> 'Mineração',
			'PEG'			=> 'Petróleo e gás',
			'PRM'			=> 'Produtos de metalurgia',
			'PRQ'			=> 'Produtos químicos',
			'SEG'			=> 'Seguros',
			'SYP'			=> 'Serviços de utilidade pública',
			'SPR'			=> 'Serviços profissionais',
			'SPU'			=> 'Setor público',
			'TEL'			=> 'Telecomunicações',
			'TLO'			=> 'Transporte e Logística',
			'VAR'			=> 'Varejo',
		),
	),
	
	array(
		'slug'				=> 'negocio',
		'nome'				=> 'Tipo de processo de negócio',
		'valores'			=> array(
			'FIN'			=> 'Finanças',
			'CSU'			=> 'Cadeia de suprimento',
			'COM'			=> 'Compras',
			'FAB'			=> 'Fabricação',
			'MKT'			=> 'Marketing',
			'PDE'			=> 'Pesquisa e desenvolvimento, Engenharia',
			'RH'			=> 'Recursos Humanos',
			'SER'			=> 'Serviço',
			'SUS'			=> 'Sustentabilidade',
			'TI'			=> 'Tecnologia da Informação',
			'VEN'			=> 'Vendas',
		),
	),
	
	array(
		'slug'				=> 'solucao_sap',
		'nome'				=> 'Tipo de solução SAP',
		'valores'			=> array(
			'APE'			=> 'Aplicativos Empresariais',
			'ANA'			=> 'Análises',
			'BDT'			=> 'Banco de Dados e Tecnologia',
			'MOV'			=> 'Móvel',
			'NUV'			=> 'Nuvem',
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
	
	array(
		'slug'				=> 'tipo_associacao',
		'nome'				=> 'Tipo de associação',
		'valores'			=> array(
			'1' => 'Empresa Cliente Não Associada',
			'2' => 'Empresa Cliente Associada',
			'3' => 'Empresa Parceira Não Associada',
			'4' => 'Empresa Parceira Associada',
			'5' => 'Empresa Convidada',
			'6' => 'Empresa Consultora SAP',
		),
	),
	
	array(
		'slug'				=> 'role_associacao',
		'nome'				=> 'User roles de associação',
		'valores'			=> array(
			'1' => 'empresa_cliente',
			'2' => 'empresa_cliente_associada',
			'3' => 'empresa_parceira',
			'4' => 'empresa_parceira_associada',
			'5' => 'empresa_convidada',
			'6' => 'empresa_consultora_sap',
		),
	),
	
	array(
		'slug'				=> 'funcoes',
		'nome'				=> 'Funções de usuário',
		'valores'			=> array(
			FUNCAO_ADMIN			=> 'Admin',
			FUNCAO_FUNCIONARIO		=> 'Funcionário',
			FUNCAO_EMPRESA			=> 'Empresa',
			FUNCAO_REPRESENTANTE	=> 'Representante',
		),
	),
	
	array(
		'slug'				=> 'funcao',
		'estender'			=> 'funcoes',
	),
	
	array(
		'slug'				=> 'capacitacao',
		'nome'				=> 'Nível de capacitação',
		'valores'			=> array(
			'DR' => 'Doutorado',
			'LIC' => 'Licenciado',
			'MES' => 'Mestrado',
			'TEC' => 'Técnico',
			'TECN' => 'Tecnólogo',
		),
	),
	
	array(
		'slug'				=> 'tratamento',
		'nome'				=> 'Pronome de tratamento',
		'valores'			=> array(
			'1' => 'Sr.',
			'2' => 'Sra.',
			'3' => 'Srta.',
			'4' => 'Dr.',
			'5' => 'Dra.',
			// '6' => 'Ph.D.',
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
		'minlength'			=> 2,
		'maxlength'			=> 64,
	),
	/*
	array(
		'slug'				=> 'titulo',
		'nome'				=> 'Título',
		'msg_vazio'			=> 'Por favor, informe o título aplicável.',
		'msg_invalido'		=> 'Por favor, informe o título aplicável.',
		'sanitizador'		=> 'sanitizarInteiro',
		'lista'				=> 'titulo',
	),
	*/
	array(
		'slug'				=> 'tratamento',
		'nome'				=> 'Pronome de tratamento',
		'msg_vazio'			=> 'Por favor, informe o pronome de tratamento desejado.',
		'msg_invalido'		=> 'Por favor, informe o pronome de tratamento desejado.',
		'sanitizador'		=> 'sanitizarInteiro',
		'lista'				=> 'tratamento',
	),

	array(
		'slug'				=> 'nome_completo',
		'nome'				=> 'Nome completo',
		'msg_vazio'			=> 'Por favor, informe o nome completo.',
		'msg_invalido'		=> 'Por favor, informe o nome completo.',
		'minlength'			=> 5,
		'maxlength'			=> 128,
		'validador'			=> 'validarNomeCompleto',
	),

	array(
		'slug'				=> 'username',
		'nome'				=> 'Username',
		'msg_vazio'			=> 'Por favor, digite um nome de usuário.',
		'msg_invalido'		=> 'O nome do usuário deve conter apenas letras sem acentos, números e subtraços, deve começar com uma letra e conter entre 3 e 32 caracteres.',
		'msg_existente'		=> 'Esse nome de usuário já está sendo utilizado por outro usuário no sistema.',
		'minlength'			=> 3,
		'maxlength'			=> 32,
		'validador'			=> 'validarUsername',
	),

	array(
		'slug'				=> 'nome_fantasia',
		'nome'				=> 'Nome fantasia',
		'msg_vazio'			=> 'Por favor, digite o nome fantasia da empresa.',
		'maxlength'			=> 128,
	),

	array(
		'slug'				=> 'razao_social',
		'nome'				=> 'Razão social',
		'msg_vazio'			=> 'Por favor, informe a razão social.',
		'maxlength'			=> 128,
	),

	array(
		'slug'				=> 'grupo_controlador',
		'nome'				=> 'Grupo controlador',
		'msg_vazio'			=> 'Por favor, informe o grupo controlador da empresa.',
		'maxlength'			=> 128,
	),

	array(
		'slug'				=> 'email_cadastro',
		'nome'				=> 'E-mail de cadastro',
		'msg_vazio'			=> 'Por favor, informe um endereço de e-mail.',
		'msg_invalido'		=> 'O endereço de e-mail é inválido.',
		'msg_existente'		=> 'Já existe um usuário cadastrado com esse endereço de e-mail.',
		'validador'			=> 'validarEmailUsuario',
		'maxlength'			=> 64,
	),

	array(
		'slug'				=> 'email',
		'nome'				=> 'E-mail',
		'msg_vazio'			=> 'Por favor, informe um endereço de e-mail.',
		'msg_invalido'		=> 'O endereço de e-mail é inválido.',
		'validador'			=> 'validarEmail',
		'maxlength'			=> 64,
	),

	array(
		'slug'				=> 'senha',
		'nome'				=> 'Senha',
		'msg_vazio'			=> 'Por favor, digite uma senha.',
		'msg_invalido'		=> "A senha deve conter pelo menos $config[senha_min] e não mais que $config[senha_max] caracteres.",
		'validador'			=> 'validarSenha',
		'minlength'			=> $config['senha_min'],
		'maxlength'			=> $config['senha_max'],
	),

	array(
		'slug'				=> 'repetir_senha',
		'nome'				=> 'Repetir a senha',
		'msg_vazio'			=> 'É necessário re-digitar a senha.',
		'msg_invalido'		=> 'As senhas não combinam.',
		'validador'			=> 'validarRepetirSenha',
		'minlength'			=> $config['senha_min'],
		'maxlength'			=> $config['senha_max'],
	),

	array(
		'slug'				=> 'confirmar_senha',
		'nome'				=> 'Confirme a operação digitando sua senha atual',
		'msg_vazio'			=> 'É necessário digitar a sua senha atual para confirmar a operação.',
		'msg_invalido'		=> "A senha de confirmação não está correta.",
		'validador'			=> 'validarConfirmarSenha',
		'minlength'			=> $config['senha_min'],
		'maxlength'			=> $config['senha_max'],
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
		'lista'				=> 'sexo',
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
		'msg_invalido'		=> 'Você deve concordar com os termos de uso para prosseguir.',
		'sanitizador'		=> 'sanitizarBoolean',
		'validador'			=> 'validarTrue',
	),

	array(
		'slug'				=> 'newsletter',
		'nome'				=> 'Informativo',
		'msg_vazio'			=> 'Especifique se deseja receber nosso informativo.',
		'sanitizador'		=> 'sanitizarBoolean',
	),

	array(
		'slug'				=> 'email_confirmado',
		'nome'				=> 'E-mail Confirmado',
		'msg_vazio'			=> 'Especifique se o endereço de e-mail foi confirmado.',
		'sanitizador'		=> 'sanitizarBooleanInvertido',
	),

	array(
		'slug'				=> 'cargo',
		'nome'				=> 'Cargo',
		'msg_vazio'			=> 'Por favor, informe o cargo.',
		'msg_invalido'		=> 'Por favor, informe o cargo.',
		'maxlength'			=> 6,
		'lista'				=> 'cargo',
	),

	array(
		'slug'				=> 'nivel_cargo',
		'nome'				=> 'Nível de cargo',
		'msg_vazio'			=> 'Por favor, informe o nível de cargo.',
		'msg_invalido'		=> 'Por favor, informe o nível de cargo.',
		'maxlength'			=> 6,
		'lista'				=> 'nivel_cargo',
	),

	array(
		'slug'				=> 'capacitacao',
		'nome'				=> 'Nível de capacitação',
		'msg_vazio'			=> 'Por favor, informe o nível de capacitação.',
		'msg_invalido'		=> 'Por favor, informe o nível de capacitação.',
		'maxlength'			=> 6,
		'lista'				=> 'capacitacao',
	),

	array(
		'slug'				=> 'cargo_asug',
		'nome'				=> 'Cargo ASUG',
		'msg_vazio'			=> 'Por favor, informe o nível de cargo na ASUG.',
		'msg_invalido'		=> 'Por favor, informe o nível de cargo na ASUG.',
		'maxlength'			=> 6,
		'lista'				=> 'cargo_asug',
	),
	
	array(
		'slug'				=> 'ramo',
		'nome'				=> 'Ramo de atividade',
		'msg_vazio'			=> 'Por favor, informe o ramo de atividade.',
		'msg_invalido'		=> 'Por favor, informe o ramo de atividade.',
		'maxlength'			=> 6,
		'lista'				=> 'ramo',
	),
	
	array(
		'slug'				=> 'negocio',
		'nome'				=> 'Tipo de negócio',
		'msg_vazio'			=> 'Por favor, informe o tipo de negócio.',
		'msg_invalido'		=> 'Por favor, informe o tipo de negócio.',
		'maxlength'			=> 6,
		'lista'				=> 'negocio',
	),
	
	array(
		'slug'				=> 'solucao_sap',
		'nome'				=> 'Tipo de solução SAP',
		'msg_vazio'			=> 'Por favor, informe o tipo de solução SAP.',
		'msg_invalido'		=> 'Por favor, informe o tipo de solução SAP.',
		'maxlength'			=> 6,
		'lista'				=> 'solucao_sap',
	),
	
	array(
		'slug'				=> 'faturamento',
		'nome'				=> 'Faturamento',
		'msg_vazio'			=> 'Por favor, informe a faixa de faturamento.',
		'msg_invalido'		=> 'Por favor, informe a faixa de faturamento.',
		'sanitizador'		=> 'sanitizarInteiro',
		'lista'				=> 'faturamento',
	),
	
	array(
		'slug'				=> 'qtd_funcionarios',
		'nome'				=> 'Número de funcionários',
		'msg_vazio'			=> 'Por favor, informe o número de funcionários.',
		'msg_invalido'		=> 'Por favor, informe o número de funcionários.',
		'sanitizador'		=> 'sanitizarInteiro',
		'lista'				=> 'qtd_funcionarios',
	),
	
	array(
		'slug'				=> 'qtd_usuarios',
		'nome'				=> 'Número de usuários',
		'msg_vazio'			=> 'Por favor, informe o número de usuários.',
		'msg_invalido'		=> 'Por favor, informe o número de usuários.',
		'sanitizador'		=> 'sanitizarInteiro',
		'lista'				=> 'qtd_usuarios',
	),

	array(
		'slug'				=> 'versao_erp',
		'nome'				=> 'Versão do ERP',
		'msg_vazio'			=> 'Por favor, informe a versão do ERP.',
		'maxlength'			=> 32,
	),

	array(
		'slug'				=> 'website',
		'nome'				=> 'Website',
		'msg_vazio'			=> 'Por favor, informe o website.',
		'msg_invalido'		=> 'O website informado não é válido ou não foi digitado corretamente.',
		'maxlength'			=> 128,
		'sanitizador'		=> 'sanitizarURL',
		'validador'			=> 'validarURL',
	),
	
	array(
		'slug'				=> 'contato_publico',
		'nome'				=> 'Autoriza a divulgação dos dados de contato',
		'msg_vazio'			=> 'Por favor, informe se autoriza a divulgação dos dados de contato.',
		'sanitizador'		=> 'sanitizarBoolean',
	),

	array(
		'slug'				=> 'tipo_associacao',
		'nome'				=> 'Tipo de associação',
		'msg_vazio'			=> 'Você deve informar a modalidade de associação da empresa.',
		'msg_invalido'		=> 'Você deve informar a modalidade de associação da empresa.',
		'sanitizador'		=> 'sanitizarNatural',
		'lista'				=> 'tipo_associacao',
	),
	
) );