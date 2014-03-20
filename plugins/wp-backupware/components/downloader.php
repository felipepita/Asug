<?php

// Check tp make sure that the file is installed in WP
// @TODO add adition checks to make sure incase of mutiple installs
if( !file_exists( $_SERVER['DOCUMENT_ROOT'] . '/wp-load.php' )){
	print 'No hook found';
	exit;
}

// Hook into WP
require_once( $_SERVER['DOCUMENT_ROOT'] . '/wp-load.php' );

// Make sure the person is logged in and can manage options
if( !current_user_can('manage_options') )
	exit;

// @TODO.. I am not fully fine with just one check.. Add more

// Make sure that there is a backup provided
if( !isset($_REQUEST['download'] ) ){
	print 'No backup id provided';
	exit;
}


$backupID = intval( $_REQUEST['download'] );

$backup_file = get_post_meta($backupID, 'backup_location', true );

if( empty($backup_file)){
	print 'No Backup Found';
	exit;
}

$file_name = basename( $backup_file );

header("Content-Type: application/zip");
header("Content-Disposition: attachment; filename=$file_name");
header("Content-Length: " . filesize( $backup_file ));

readfile($backup_file);
exit;