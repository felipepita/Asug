<?php
/*
 * Classe de relacionamento entre as chaves de diferentes cole��es
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */



class Relacao {

	public $_idUnico = 1;
	
	// array( $chave => $idUnico )
	public $_chavesMestras = array();
	
	// array( $colecao => array( $idUnico => $chave ) )
	public $_colecoes = array();
	
	public function __construct() {
		$argsTotal = func_num_args();
		if ( $argsTotal ) {
			$args = get_func_args();
			call_user_func_array( array( $this, 'relacionar' ), $args );
		}
	}

	public function relacionar( $slugsColecoes, $relacao ) {
	
		/*
		 * Grava a rela��o de equival�ncia entre as chaves pertencentes �s cole��es nomeadas
		 *
		 * Para duas cole��es, a sintaxe mais simples � a associativa:
		 *   relacionar( array( 'A', 'B' ), array( $chaveA1 => $chaveB1, $chaveA2 => $chaveB2 ) )
		 *
		 * Para mais, utilize arrays:
		 *   relacionar( array( 'A', 'B', 'C' ), array( array( $chaveA1, $chaveB1, $chaveC1 ), array( $chaveA2, $chaveB2, $chaveC2 ) ) )
		 *
		 * Aceita chaves nulas para pular a rela��o de uma chave particular para aquela cole��o
		 */
	
		// Checagem dos par�metros
		if ( !is_array( $slugsColecoes ) || !is_array( $relacao ) )
			return false;
			
		// Registra as novas cole��es se elas n�o existirem
		foreach ( $slugsColecoes as $slug ) {
			if ( !array_key_exists( $slug, $this->_colecoes ) )
				$this->_colecoes[ $slug ] = array();
		}
		
		$totalColecoes = count( $slugsColecoes );
		
		// Processa as rela��es
		foreach ( $relacao as $arrChave => $arrValor ) {
		
			// Junta as chaves
			$chaves = array();
			
			if ( !is_numeric( $arrChave ) ) {
				// Adiciona a chave se n�o for num�rica
				$chaves[] = $arrChave;
			}
		
			if ( is_array( $arrValor ) )
				$chaves = array_merge( $chaves, $arrValor );
			else
				$chaves[] = $arrValor;
			
			// Define a ID da �ltima chave, pulando chaves nulas
			$i = $totalColecoes;
			$chave = null;
			
			while ( $chave === null && --$i >= 0 )
				$chave = $chaves[$i];
			
			$slugColecaoAtual = $slugsColecoes[$i];
			$slugChave = "$slugColecaoAtual.$chave";
				
			if ( array_key_exists( $slugChave, $this->_chavesMestras ) ) {
				// Utiliza a ID existente
				$id = $this->_chavesMestras[ $slugChave ];
			} else {
				// Cria uma nova entrada
				$id = $this->_idUnico++;
				$this->_chavesMestras[ $slugChave ] = $id;
				$this->_colecoes[ $slugColecaoAtual ][ $id ] = $chave;
			}
			
			// Processa as demais chaves
			for ( ; $i >= 0; $i-- ) {
			
				$chave = $chaves[$i];
				
				if ( $chave === null )
					continue;
				
				$slugColecaoAtual = $slugsColecoes[$i];
				$slugChave = "$slugColecaoAtual.$chave";
			
				// Cria ou sobrescreve a rela��o desta chave para a ID definida
				$this->_chavesMestras[ $slugChave ] = $id;
				$this->_colecoes[ $slugColecaoAtual ][ $id ] = $chave;
			
			}
		
		}
		
		return true;
		
	}
	
	public function traduzir( $dadosOrigem, $slugColecaoOrigem, $slugsColecoesDestino, $preservarIntraduziveis = false ) {
	
		// Altera as chaves na array $dadosOrigem para as chaves equivalentes da cole��o de destino
		// Aceita uma array com m�ltiplas cole��es de destino, transformando o resultado em uma array bidimensional com as chaves de cada cole��o e os dados divididos entre elas
		// Chaves n�o encontradas em uma cole��o ser�o buscadas na outra, sucessivamente
		// Chaves intraduz�veis ser�o descartadas ou mantidas intactas, de acordo com a defini��o
		// @retorna array unidimensional com os dados
	
		// Checagem dos par�metros
		if ( !is_array( $dadosOrigem ) || !is_string( $slugColecaoOrigem ) )
			return false;
			
		if ( !is_array( $slugsColecoesDestino ) ) {
			if ( !is_string( $slugsColecoesDestino ) )
				return false;
			$slugsColecoesDestino = array( $slugsColecoesDestino );
		}
			
		// Verifica se as cole��es existem
		if ( !array_key_exists( $slugColecaoOrigem, $this->_colecoes ) )
			return false;
			
		$colecaoOrigem &= $this->_colecoes[ $slugColecaoOrigem ];
		$destinoUnico = count( $slugsColecoesDestino ) == 1;
		$dadosDestino = array();
			
		foreach ( $slugsColecoesDestino as $slug ) {
			if ( !array_key_exists( $slug, $this->_colecoes ) )
				return false;
			if ( !$destinoUnico )
				$dadosDestino[ $slug ] = array();
		}
		
		// Processa os dados
		
		foreach ( $dadosOrigem as $chaveOriginal => $valor ) {
		
			$chaveDestino = null;
			$slugChaveOriginal = "$slugColecaoOrigem.$chaveOriginal";
			
			// Procura a ID interna dessa chave
			if ( array_key_exists( $slugChaveOriginal, $this->_chavesMestras ) ) {
			
				$id = $this->_chavesMestras[ $slugChaveOriginal ];
			
				// Busca sucessivamente nas cole��es de destino pela ID para obter a chave
				foreach ( $slugsColecoesDestino as $slug ) {
				
					$colecaoAtual =& $this->_colecoes[ $slug ];
				
					if ( array_key_exists( $id, $colecaoAtual ) ) {
						// Encontrado, salva os dados e pula para a pr�xima chave
						$chaveDestino = $colecaoAtual[ $id ];
						if ( $destinoUnico )
							$dadosDestino[ $chaveDestino ] = $valor;
						else
							$dadosDestino[ $slug ][ $chaveDestino ] = $valor;
						continue 2;
					}
				
				}
			
			}
			
			// Uma tradu��o para a chave n�o foi encontrada
			if ( $preservarIntraduziveis ) {
				if ( $destinoUnico ) {
					$dadosDestino[ $chaveOriginal ] = $valor;
				} else {
					if ( !isset( $dadosDestino[ $slugColecaoOrigem ] ) )
						$dadosDestino[ $slugColecaoOrigem ] = array();
					$dadosDestino[ $slugColecaoOrigem ][ $chaveOriginal ] = $valor;
				}
			}
		
		}
		
		// Fim
		return $dadosDestino;
	
	}

}
