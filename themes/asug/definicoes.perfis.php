<?php

// Define os campos de perfil que cada grupo de usuário utiliza e os campos padrões para todos os objetos daquela classe

global $perfis;
$perfis = array();

definir( $perfis, array(
	
	// Usuário

	array(
		'slug' => 'usuario',
		'campos' => array(
			'nome_completo'		=> 1,
			'username'			=> 1,
			'email'				=> 1,
			'senha'				=> 1,
			'repetir_senha'		=> 1,
			'sexo'				=> 1,
			'cargo'				=> 1,
			'nivel_cargo'		=> 1,
			'telefone'			=> 1,
			'cep'				=> 1,
			'endereco'			=> 1,
			'complemento'		=> 0,
			'bairro'			=> 1,
			'cidade'			=> 1,
			'estado'			=> 1,
			'newsletter'		=> 1,
		),
	),
	
	// Associação
	
	array(
		'slug' => 'associacao',
		'campos' => array(
			'associacao'		=> 1,
		),
	),

	// Empresa

	array(
		'slug' => 'empresa',
		'campos' => array(
			'nome_fantasia'		=> 1,
			'razao_social'		=> 1,
			'grupo_controlador'	=> 0,
			'cnpj'				=> 1,
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
			'website'			=> 1,
			'contato_publico'	=> 1,
			'status'			=> 1,
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
	
), 'PERFIL_' );
