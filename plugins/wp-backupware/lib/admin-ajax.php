<?php
// Admin ajax functions

// Create full system backup
add_action( 'wp_ajax_wpbu_do_full_backup', 'wpbu_do_full_backup' );
function wpbu_do_full_backup() {
	if(class_exists(WPBU_backup)){
		$backup = new WPBU_Backup();
		$backup = $backup->full_backup();
		print json_encode($backup);
	}
	exit;
}

// Create database backup
add_action( 'wp_ajax_wpbu_do_database_backup', 'wpbu_do_database_backup' );
function wpbu_do_database_backup() {
	if(class_exists(WPBU_backup)){
		$backup = new WPBU_Backup();
		$backup = $backup->Create_Database_Backup();
		print json_encode($backup);
	}
	exit;
}

add_action('wp_ajax_wpbu_remove_backup', 'wpbu_remove_backupup');
function wpbu_remove_backupup(){
	$params = $_POST;
	if(empty($params['backupID']))
		return;

	// @todo add feed back for errors
	$backup_location = get_post_meta($params['backupID'], 'backup_location', true);
	if(file_exists($backup_location) && !unlink($backup_location)){
		print '0';
		exit;
	}

	if( wp_delete_post($params['backupID'], true) ){
		print '1';
	}else{
		print '0';
	}
	exit;
}