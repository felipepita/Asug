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
		while (($row = fgetcsv($handle, 1000, $delimiter, $enclosure)) !== FALSE)
		{
			// Header
			if (!$header) {
				$header = $row;
				$colunas = count( $row );
			}
			// Linha vazia ou incompatível
			if ( !$row || count( $row ) != $colunas )
				continue;
			// Linha
			else
				$data[] = array_combine($header, $row);
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
		// Linha vazia ou incompatível
		if ( !$row || count( $row ) != $colunas )
			continue;
		$data[] = array_combine( $header, $row );
	}
	
	return $data;

}
