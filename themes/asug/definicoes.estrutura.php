<?php
/*
 * ESTRUTURAÇÃO DE DADOS
 * @requer inc/class.relacao.php
 */



define( 'ESTRUTURA_FORM', 'form' );
define( 'ESTRUTURA_WP', 'wp' );
define( 'ESTRUTURA_USER_DATA', 'user_data' );
define( 'ESTRUTURA_USER_META', 'user_meta' );
define( 'ESTRUTURA_SAP', 'sap' );
define( 'ESTRUTURA_ASUG_VELHO', 'asug_velho' );
define( 'ESTRUTURA_ASUG_NOVO', ESTRUTURA_WP );

$estruturaPerfil = new Relacao();

$estruturaPerfil->relacionar(
	array(		ESTRUTURA_SAP,			ESTRUTURA_ASUG_VELHO,	ESTRUTURA_USER_META,	ESTRUTURA_USER_DATA,	ESTRUTURA_ASUG_NOVO,	ESTRUTURA_FORM,			),
	array(
		array( 'status',				'fk_pk_cod_status',		null,					'user_status',			'status',				null,					),
		array( 'userId',				null,					null,					'ID',					'ID',					'user_id',				),
		array( 'username',				null,					null,					'user_login',			'user_login',			null,					),
		array( null,					null,					null,					'user_pass',			'user_pass',			'senha',				),
		array( null,					null,					'tratamento',			null,					'tratamento',			'tratamento',			),
		array( null,					'nom_usuario',			null,					'display_name',			'display_name',			'nome_completo',		),
		array( 'firstName',				null,					'first_name',			null,					'first_name',			'first_name',			),
		array( 'mi',					null,					'middle_name',			null,					'middle_name',			'middle_name',			),
		array( 'lastName',				null,					'last_name',			null,					'last_name',			'last_name',			),
		array( 'gender',				'sexo',					'sexo',					null,					'sexo',					'sexo',					),
		array( 'email', 				'email_usuario',		null,					'user_email',			'user_email',			'email_cadastro',		),
		array( null,					null,					null,					'role',					'role',					'role',					),
		array( 'manager',				null,					null,					null,					'representante1',		null,					),
		// array( 'hr', 'admin' ),
		array( 'department',			null,					'nivel_cargo',			null,					'nivel_cargo',			'nivel_cargo',			),
		// array( 'jobCode',				'fk_pk_cod_cargo',		'cargo',				null,					'cargo',				'cargo',				),
		// array( 'division', 'empresa_nome' ),
		// array( 'location', '' ),
		// array( 'timeZone', '' ),
		array( 'hireDate',				'data_criacao',			null,					'user_registered',		'user_registered',		null,					),
		// array( 'empId', '' ),
		array( 'title',					null,					'capacitacao',			null,					'capacitacao',			'capacitacao',			),
		array( 'businessPhone',			'num_telefone_usu',		'telefone',				null,					'telefone',				'telefone',				),
		array( 'fax',					'num_fax_usu',			'fax',					null,					'fax',					'fax',					),
		array( 'addressLine1',			null,					null,					null,					'endereco_completo',	null,					),
		array( null,					'dsc_endereco_usu',		'endereco',				null,					'endereco',				'endereco',				),
		array( null,					'dsc_bairro_usu',		'bairro',				null,					'bairro',				'bairro',				),
		array( 'addressLine2',			'dsc_complemento_endereco_usu',	'complemento',	null,					'complemento',			'complemento',			),
		array( 'city',					'dsc_cidade_usu',		'cidade',				null,					'cidade',				'cidade',				),
		array( 'state',					'fk_pk_cod_estado',		'estado',				null,					'estado',				'estado',				),
		array( 'zipCode',				'dsc_cep_usu',			'cep',					null,					'cep',					'cep',					),
		array( 'country',				null,					'pais',					null,					'pais',					'pais',					),
		// array( 'reviewFreq', '' ),
		// array( 'lastReviewDate', '' ),
		array( 'custom01',				null,					null,					null,					'representante1_telefone',	null,				),
		// array( 'custom02', 'linkedin' ),
		array( 'custom03',				'data_atualizacao',		'ultima_atualizacao',	null,					'ultima_atualizacao',	null,					),
		// array( 'custom04', 'ramo' ), // industria
		// array( 'custom05', 'negocio' ),
		// array( 'custom06', 'solucao_sap' ),
		array( 'custom07',				null,					null,					null,					'empresa_tipo_associacao',	null,				),
		array( 'custom08',				'fk_pk_cod_tip_usuario',	null,				null,					'funcao',				null,					),
		// array( 'custom09', 'empresa_nome' ),
		// array( 'custom10', '' ),
		// array( 'custom11', '' ),
		// array( 'custom12', '' ),
		// array( 'custom13', '' ),
		// array( 'custom14', '' ),
		// array( 'custom15', '' ),
		array( null,					'informativo_asug',		'informativo',			null,					'informativo',			'informativo',			),
		array( null,					null,					'empresa',				null,					'empresa',				null,					),
		array( null,					null,					'email_confirmado',		null,					'email_confirmado',		'email_confirmado',		),
		array( null,					'pk_seq_usuario',		'id_velho',				null,					'id_velho',				null,					),
		array( null,					'fk_pk_cod_empresa',	'empresa_velha',		null,					'empresa_velha',		null,					),	
		array( null,					null,					'data_importacao',		null,					'data_importacao',		'data_importacao',		),	
	)
);

$estruturaEmpresa = new Relacao();

$estruturaEmpresa->relacionar(
	array(		ESTRUTURA_ASUG_VELHO,	 	ESTRUTURA_USER_META,	ESTRUTURA_USER_DATA,	ESTRUTURA_ASUG_NOVO,	ESTRUTURA_FORM,			),
	array(
		array(	'fk_pk_cod_status',			null,					'user_status',			'status',				null,					),
		array(	null,						null,					'ID',					'ID',					'user_id',				),
		array(	'nom_fantasia_emp',			null,					'display_name',			'display_name',			'nome_fantasia',		),
		array(	null,						'first_name',			null,					'first_name',			'first_name',			),
		array(	'razao_social',				'razao_social',			null,					'razao_social',			'razao_social',			),
		array(	'cnpj_empresa',				'cnpj',					null,					'cnpj',					'cnpj',					),
		array(	'grupo_controlador',		'grupo_controlador',	null,					'grupo_controlador',	'grupo_controlador',	),
		array(	'fk_pk_cod_ramo_atividade',	'ramo',					null,					'ramo',					'ramo',					),
		array(	'fk_pk_cod_faturamento',	'faturamento',			null,					'faturamento',			'faturamento',			),
		array(	'fk_pk_num_funcionarios',	'qtd_funcionarios',		null,					'qtd_funcionarios',		'qtd_funcionarios',		),
		array(	'fk_pk_num_usuarios',		'qtd_usuarios',			null,					'qtd_usuarios',			'qtd_usuarios',			),
		array(	'num_cep',					'cep',					null,					'cep',					'cep',					),
		array(	'dsc_endereco',				'endereco',				null,					'endereco',				'endereco',				),
		array(	'dsc_bairro',				'bairro',				null,					'bairro',				'bairro',				),
		array(	'dsc_cidade',				'cidade',				null,					'cidade',				'cidade',				),
		array(	'fk_pk_cod_estado',			'estado',				null,					'estado',				'estado',				),
		array(	'num_telefone',				'telefone',				null,					'telefone',				'telefone',				),
		array(	'num_fax',					'fax',					null,					'fax',					'fax',					),
		array(	null,						'versao_erp',			null,					'versao_erp',			'versao_erp',			),
		array(  'dsc_dominio_email',		'sufixo',				null,					'sufixo',				'sufixo',				),
		array(  null,						null,					'user_url',				'user_url',				null,					),
		array(	null,						null,					'role',					'role',					'role',					),
		array(	'fk_pk_cod_tip_empresa',	'tipo_associacao',		null,					'tipo_associacao',		'tipo_associacao',		),
		array(	'nom_rep_fin',				null,					null,					'fin_nome_completo',	'fin_nome_completo',	),
		array(	'email_rep_fin',			null,					null,					'fin_email',			'fin_email_cadastro',	),
		// array(	'fk_pk_cod_cargo_rep_fin',	null,					null,					'fin_cargo',			'fin_cargo',			),
		// array(	'fk_pk_cod_cargo_rep_ev',	null,					null,					'rep2_cargo',			'rep2_cargo',			),
		// Planilha 'Cadastro'
		array(	'ca_gerente',				null,					null,					'rep2_nome_completo',	'rep2_nome_completo',	),
		// array(	'ca_representante',			null,					null,					'rep1_nome_completo',	'rep1_nome_completo',	),
		// array(	'ca_cargo',					null,					null,					'rep1_cargo',			'rep1_cargo',			),
		array(	null,						'contato_publico',		null,					'contato_publico',		'contato_publico',		),
		array(	'pk_cod_empresa',			'id_velho_empresa',		null,					'id_velho_empresa',		null,					),
		array(	null,						'representante1',		null,					'representante1',		null,					),
		array(	null,						'representante2',		null,					'representante2',		null,					),
		array(	null,						'cio',					null,					'cio',					null,					),
		array(	null,						'financeiro',			null,					'financeiro',			null,					),
		array(	null,						'usuarios',				null,					'usuarios',				null,					),
		array(	null,						'logo',					null,					'logo',					null,					),
		array(	null,						'data_importacao',		null,					'data_importacao',		'data_importacao',		),	
	)
);
