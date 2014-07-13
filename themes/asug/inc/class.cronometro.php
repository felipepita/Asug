<?php
/*
 * Classe para controlar o tempo de execução de um script
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 *
 *
 *
 * Permite simplesmente obter o tempo decorrido após a inicialização. Ex:
 *
 * $crono = new Cronometro();
 * sleep(10);
 * print $crono->tempoDecorrido();
 *
 *
 *
 * Permite também controlar o tempo total e médio gasto em uma iteração. Ex:
 *
 * for ( $i = 1; $i <= 10; $i++ ) {
 *   $crono->iniciarOperacao('foo');
 *   sleep(1);
 *   $crono->terminarOperacao('foo');
 * }
 *
 * print $crono->mediaOperacao('foo');
 * print $crono->totalOperacao('foo');
 *
 *
 *
 * Monitora o limite de execução do script vs. o tempo total decorrido para interromper iterações. Ex:
 *
 * while ( $crono->continuarOperacao('bar') ) {
 *   $crono->iniciarOperacao('foo');
 *   sleep(1);
 *   $crono->terminarOperacao('foo');
 * }
 *
 */
 
 
 
class Cronometro {

	public $inicio = 0;
	public $limite = 0;
	public $cronometros = array();
	public $operacoes = array();

	function __construct() {
	
		$this->limite = ini_get('max_execution_time');
		$this->resetar();
	
	}
	
	function tempoDecorrido() {
	
		// Retorna o tempo decorrido desde o início
		
		return microtime(true) - $this->inicio;
	
	}
	
	function resetar() {
	
		// Reinicia o cronômetro
	
		$this->inicio = microtime(true);
	
	}
	
	function iniciarOperacao( $nome = 'padrao' ) {
	
		// Marca o início de uma iteração da operação
	
		if ( !isset( $this->operacoes[ $nome ] ) ) {
			$this->operacoes[ $nome ] = array();
		}
		
		$this->cronometros[ $nome ] = microtime(true);
	
	}
	
	function terminarOperacao( $nome = 'padrao' ) {
	
		// Grava o tempo gasto nesta iteração da operação
	
		if ( !isset( $this->operacoes[ $nome ] ) )
			return 0;
		
		$t = microtime(true) - $this->cronometros[ $nome ];
		$this->operacoes[ $nome ][] = $t;
		return $t;
	
	}
	
	function tempoOperacao( $nome = 'padrao' ) {
	
		// Retorna o total de tempo gasto por uma operação
	
		if ( !isset( $this->operacoes[ $nome ] ) )
			return 0;
		
		return array_sum( $this->operacoes[ $nome ] );
	
	}
	
	function totalOperacao( $nome = 'padrao' ) {
		// @alias tempoOperacao
		return $this->tempoOperacao( $nome );
	}
	
	function mediaOperacao( $nome = 'padrao' ) {
	
		// Retorna a média de tempo gasto por uma operação
	
		if ( !isset( $this->operacoes[ $nome ] ) )
			return 0;
	
		$total = $this->tempoOperacao( $nome );
		$media = $total / count( $this->operacoes[ $nome ] );
		return $media;
	
	}
	
	function continuarOperacao( $nome = 'padrao', $tolerancia = 2.5 ) {
	
		// Julga se é seguro continuar executando uma operação, considerando o tempo decorrido e a média de tempo gasto pela operação, mais uma margem de tolerância (s)
		
		if ( !isset( $this->operacoes[ $nome ] ) )
			return true;
			
		$media = $this->mediaOperacao( $nome );
		$decorrido = $this->tempoDecorrido();
		
		return $decorrido + $media + $tolerancia < $this->limite;
	
	}

}
