<?php

// Define os campos de perfil que cada grupo de usuário utiliza e os campos padrões para todos os objetos daquela classe

global $perfis;
$perfis = array();

definir( $perfis, array(
	
	// Usuário

	array(
		'slug' => 'usuario',
		'campos' => array(
			'nome'				=> 1,
			'username'			=> 1,
			'email'				=> 1,
			'senha'				=> 1,
			'repetir_senha'		=> 1,
			'cpf'				=> 1,
			'cep'				=> 1,
			'endereco'			=> 1,
			'cidade'			=> 1,
			'estado'			=> 1,
			'telefone'			=> 1,
		),
	),

	// Entidades

	array(
		'slug' => 'entidades',
		'tabela' => 'entidades',
		'form' => '',
		'campos' => array(
			'nome'				=> 1,
			'status'			=> 1,
			'telefone'			=> 0,
			'telefone2'			=> 0,
			'email'				=> 0,
			'cnpj'				=> 1,
			'razao_social'		=> 1,
			'cep'				=> 1,
			'endereco'			=> 1,
			'numero'			=> 0,
			'complemento'		=> 0,
			'bairro'			=> 1,
			'cidade'			=> 1,
			'estado'			=> 1,
			'telefone'			=> 1,
			'telefone2'			=> 0,
			'email'				=> 0,
		),
	),
	
), 'PERFIL_' );
