<?php
/**
 * Convert a comma separated file into an associated array.
 * The first row should contain the array keys.
 * 
 * Example:
 * 
 * @param string $filename Path to the CSV file
 * @param string $delimiter The separator used in the file
 * @return array
 * @link http://gist.github.com/385876
 * @author Jay Williams <http://myd3.com/>
 * @copyright Copyright (c) 2010, Jay Williams
 * @license http://www.opensource.org/licenses/mit-license.php MIT License
 */
 
function csv_to_array( $filename='', $delimiter=';', $enclosure = '"' ) {
	if(!file_exists($filename) || !is_readable($filename))
		return FALSE;
	
	$header = NULL;
	$data = array();
	if (($handle = fopen($filename, 'r')) !== FALSE)
	{
		while (($row = fgetcsv($handle, 10000, $delimiter, $enclosure)) !== FALSE)
		{
			// Header
			if (!$header) {
				$header = $row;
				$colunas = count( $row );
				continue;
			}
			// Linha vazia
			if ( !$row )
				continue;
			// Linha com colunas a menos
			$total = count( $row );
			if ( $total < $colunas ) {
				for ( $diff = $colunas - $total; $diff; $diff-- ) {
					$row[] = '';
				}
			}
			// Linha com colunas a mais
			if ( $total > $colunas ) {
				array_splice( $row, $colunas );
			}
			// Combina a linha com a coluna
			$data[] = array_combine( $header, $row );
		}
		fclose($handle);
	}
	return $data;
}

function raw_csv_to_array( $input, $delimiter = ';', $enclosure = '"' ) {

	$data = array();
	$rows = explode( "\n", $input );
	$entries = count( $rows ) - 1;
	
	if ( !$entries )
		return false;
	
	$header = str_getcsv( $rows[0], $delimiter, $enclosure );
	$colunas = count( $header );
	
	for ( $i = 1; $i <= $entries; $i++ ) {
		$row = str_getcsv( $rows[$i], $delimiter, $enclosure );
		// Linha vazia
		if ( !$row )
			continue;
		// Linha com colunas a menos
		$total = count( $row );
		if ( $total < $colunas ) {
			for ( $diff = $colunas - $total; $diff; $diff-- ) {
				$row[] = '';
			}
		}
		// Linha com colunas a mais
		if ( $total > $colunas ) {
			array_splice( $row, $colunas );
		}
		// Combina a linha com a coluna
		$data[] = array_combine( $header, $row );
	}
	
	return $data;

}

function array_to_csv( $arr, $del = ';', $enc = '"' ) {
	// Processo inverso
	if ( !is_array( $arr ) || !$arr )
		return '';
	$csv = '';
	$header = array_keys( $arr[0] );
	$csv .= $enc . implode( "$enc$del$enc", $header ) . $enc . PHP_EOL;
	foreach ( $arr as $entrada )
		$csv .= $enc . implode( "$enc$del$enc", $entrada ) . $enc . PHP_EOL;
	return substr( $csv, 0, -1 );
}
