<?php
/**
 * Component Name: WP Cron Helper
 * Version: 1.0.0
 * Description: Adds more options to WP Cron options
 * Author: wpbackupware
 * Author URI: http://wpbackupware.com
 * License: GPL2
*/
add_filter( 'cron_schedules', 'wpbu_addtional_schedule_options' ); 
function wpbu_addtional_schedule_options( $schedules ) {

	// Once Weekly
	$schedules['weekly'] = array(
		'interval' 	=> 604800,
		'display' 	=> __( 'Once a Week', 'wpbu' )
	);

	// Monthly
	$schedules['monthly'] = array(
		'interval' 	=> 2592000,
		'display' 	=> __( 'Once a Month', 'wpbu' )
	);

	// Development Only
	/*$schedules['minute'] = array(
		'interval' 	=> 60,
		'display' 	=> __( 'Once a Minute', 'wpbu' )
	);*/

	return $schedules;
}