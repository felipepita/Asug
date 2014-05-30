<?php
/*
 * Define os campos de perfil que cada formulário utiliza
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */


 
global $perfis;
$perfis = array();

definir( $perfis, array(
	
	// Usuário

	array(
		'slug' => 'usuario',
		'campos' => array(
			//'username'			=> 1,
			'email_cadastro'	=> 1,
			//'senha'				=> 1,
			//'repetir_senha'		=> 1,
			'tratamento'		=> 1,
			'nome_completo'		=> 1,
			'sexo'				=> 1,
			'cargo'				=> 1,
			'nivel_cargo'		=> 1,
			'capacitacao'		=> 1,
			'telefone'			=> 1,
			'fax'				=> 0,
			'cep'				=> 1,
			'endereco'			=> 1,
			'complemento'		=> 0,
			'bairro'			=> 1,
			'cidade'			=> 1,
			'estado'			=> 1,
			'newsletter'		=> 1,
		),
	),

	array(
		'slug' => 'usuario_edicao_admin',
		'estender' => 'usuario',
		'campos' => array(
			'nome_completo'		=> null,
			'username'			=> null,
			'email_cadastro'	=> null,
			//'senha'				=> null,
			//'repetir_senha'		=> null,
			'email_confirmado'	=> 1,
		),
	),

	array(
		'slug' => 'usuario_edicao',
		'estender' => 'usuario',
		'campos' => array(
			'email_cadastro'	=> null,
			//'senha'				=> null,
			//'repetir_senha'		=> null,
		),
	),
	
	// Associação
	
	array(
		'slug' => 'associacao',
		'campos' => array(
			'tipo_associacao'	=> 1,
		),
	),

	// Empresa

	array(
		'slug' => 'empresa',
		'campos' => array(
			'nome_fantasia'		=> 1,
			'razao_social'		=> 1,
			'cnpj'				=> 1,
			'grupo_controlador'	=> 0,
			'ramo'				=> 1,
			'faturamento'		=> 1,
			'qtd_funcionarios'	=> 1,
			'qtd_usuarios'		=> 1,
			'cep'				=> 1,
			'endereco'			=> 1,
			'complemento'		=> 0,
			'bairro'			=> 1,
			'cidade'			=> 1,
			'estado'			=> 1,
			'telefone'			=> 1,
			'fax'				=> 0,
			'versao_erp'		=> 1,
			//'website'			=> 1,
			'contato_publico'	=> 1,
			//'status'			=> 1,
		),
	),

	array(
		'slug' => 'empresa_edicao',
		'estender' => 'empresa',
		'campos' => array(
			'tipo_associacao'	=> 1,
		),
	),
	
	// Funcionário de empresa
	
	array(
		'slug' => 'funcionario',
		'campos' => array(
			'nome_completo'		=> 1,
			'email'				=> 1,
			'cargo'				=> 1,
			'nivel_cargo'		=> 1,
			'telefone'			=> 1,
		),
	),
	
) );
