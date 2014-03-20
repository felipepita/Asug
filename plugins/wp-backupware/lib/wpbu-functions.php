<?php
/*
|--------------------------------------------------------------------------
| WPBU Register PostType
|--------------------------------------------------------------------------
|
| Registers WPBU Post Type - DO NOT MODIFY THIS
|
*/
add_action('init', 'register_wpbu_posttype');
function register_wpbu_posttype(){
	$labels = array(
	    'name'               => 'Backups',
	    'singular_name'      => 'Backup',
	    'add_new'            => 'Backup',
	    'add_new_item'       => 'Add New Backup',
 		'edit_item'          => 'Edit Backup',
	   	'new_item'           => 'New Backup',
	   	'all_items'          => 'All Backup',
	   	'view_item'          => 'View Backup',
	   	'search_items'       => 'Search Backups',
	   	'not_found'          => 'No Backups found',
	   	'not_found_in_trash' => 'No Backups found in Trash',
	   	'parent_item_colon'  => '',
	   	'menu_name'          => 'Backups'
	);
	$args = array(
	   	'labels'             => $labels,
	   	'public'             => false,
	   	'publicly_queryable' => false,
	   	'show_ui'            => false,
	   	'show_in_menu'       => false,
	   	'query_var'          => false,
	   	'rewrite'            => array( 'slug' => 'wpbu_backups' ),
	   	'capability_type'    => 'post',
	   	'has_archive'        => false,
	   	'hierarchical'       => false,
	   	'menu_position'      => null,
	   	'supports'           => array( 'title', 'editor', 'custom-fields' )
	);
  	register_post_type( 'wpbu_backups', $args );
}

/*
|--------------------------------------------------------------------------
| WPBU add main menu
|--------------------------------------------------------------------------
|
| Hardcode mmain page and all other pages will hook under this one
|
*/
add_action('admin_menu', 'wpbu_add_main_page');
function wpbu_add_main_page(){
	require_once( WPBU_ABSPATH . '/pages/overview.php' );
	add_menu_page( 'Backupware', 'Backupware', 'manage_options', 'wpbu_overview', 'wpbu_overview_ui', '', null ); 
}

/*
|--------------------------------------------------------------------------
| WPBU include pages
|--------------------------------------------------------------------------
|
| Uses wpbu_pages filter - DO NOT MODIFY THIS
|
*/
function wpbu_include_pages(){
	$pages = apply_filters('wpbu_pages', $wpbu->pages);
	if(is_array($pages)){
		foreach($pages as $page_info){
			foreach($page_info as $page){
				add_submenu_page( 'wpbu_overview', $page['title'], $page['title'], $page['permission'], $page['slug'], $page['call'] );
			}
		}
	}
}

/*
|--------------------------------------------------------------------------
| WPBU Register and Load Admin Styles
|--------------------------------------------------------------------------
|
| This should not be modified
|
*/
function wpbu_admin_styles(){
	do_action('wpbu_admin_styles');
	wp_register_style( 'wpbu-admin-styles', WPBU_ROOT_DIR . '/assets/css/wpbu-admin-styles.css'  );
	wp_register_style( 'wpbu-admin-fonts', WPBU_ROOT_DIR . '/assets/css/font-awesome.min.css'  );
	wp_enqueue_style( 'wpbu-admin-styles' );
	wp_enqueue_style( 'wpbu-admin-fonts' );
	wp_enqueue_style( 'jquery-color' );
	wp_enqueue_style( 'jquery-ui-core' );
}

/*
|--------------------------------------------------------------------------
| WPBU Register and Load Admin Scripts
|--------------------------------------------------------------------------
|
| This should not be modified
|
*/
function wpbu_admin_scripts(){
	do_action('wpbu_admin_scripts');
	wp_enqueue_script( 'wpbu-admin-js', WPBU_ROOT_DIR . '/assets/js/admin.ajax.js?version=' . time() );
}

/*
|--------------------------------------------------------------------------
| WPBU admin page tabs
|--------------------------------------------------------------------------
|
| Displays formatted data based on the wpbu_pages filter
|
*/
function wpbu_admin_page_tabs(){
	global $wpbu;

	if(isset($wp_query->query_vars['page'])){ 
        $current_page = get_query_var('page');
    }
	$pages = $wpbu->pages['page'];
	print '<ul>';
	foreach($pages as $page){
		$walker_class = '';
		if($page['slug'] === $_GET['page']){
			$walker_class = 'class="active"';
		}

		print '<li><a '.$walker_class.' href="'.admin_url().'admin.php?page='.$page['slug'].'"><span class="'.$page['class'].'"></span> '.$page['title'].' </a></li>';
	}
	print '</ul>';
}

/*
|--------------------------------------------------------------------------
| WPBU admin top content
|--------------------------------------------------------------------------
|
| HTML content displayed at the top of each plugin page
|
*/
function wpbu_top_ui_callout(){ 

	// General Setting (notifications)
	$wpbu_general_settings 	= get_option('wpbu_general_settings');
	$wpbu_schedule_settings = get_option('wpbu_schedule_settings');
	$wpbu_account_settings 	= get_option('wpbu_account_settings');
	global $wpbu;
	?>
	<div id="welcome-panel" class="welcome-panel">

			<div class="welcome-panel-content">
				<h3>WP BACKUPWARE</h3>
				<p class="about-description">The easiest way to backup WordPress</p>
				<div class="welcome-panel-column-container">

					<div class="welcome-panel-column">

						<p class="promo-message">
							
							Having Troubles?<br><br>
							<a  class="button button-primary" href="<?= WPBU_REMOTE_HOME; ?>/register" target="_blank">Visit the Support Forums</a> 
			
						</p>

					</div>
					
					<div class="welcome-panel-column">
						<h4>Quick Links</h4>
						<ul>
							<li><span class="fa fa-fire fa-1x"></span> <a href="<?= WPBU_REMOTE_HOME; ?>/support/community-forums/topic/brand-new-backupware-plugin-released" target="_blank"> Whats New? </a></li>
							<li><span class="fa fa-comments fa-1x"></span> <a href="<?= WPBU_REMOTE_HOME; ?>/support/community-forums/" target="_blank"> Support Forums</a></li>
							<li><span class="fa fa-thumbs-up fa-1x"></span> <a href="http://wordpress.org/support/view/plugin-reviews/wp-backupware" target="_blank">Rate this plugin!</a></li>
						</ul>
					</div>

					<div class="welcome-panel-column welcome-panel-last">
						<h4>Plugin Information</h4>
						<ul>
							<li>Plugin Version: <b><?= $wpbu->version; ?></b> </li>
						</ul>
					</div>

				</div>
			</div>

		</div>
<?php
}

/*
|--------------------------------------------------------------------------
| Filters WP schedules
|--------------------------------------------------------------------------
|
| Filters the installed schedules but does it in a way that won't
| interferre with other schedule hooks that might be being used elsewhere.
| Reomves hourly and twice daily only for WPBU
|
*/
function wpbu_filtered_schedules(){
	$installed_schedules = wp_get_schedules();

	// Remove Hourly and twice daily
	unset($installed_schedules['hourly']);
	unset($installed_schedules['twicedaily']);

	return $installed_schedules;
}

/*
|--------------------------------------------------------------------------
| Schedule Output / WPBU Admin
|--------------------------------------------------------------------------
|
| Gathhers the availiable options and present a form select based on 
| settings.
|
*/
function wpbu_get_admin_schedule_options(){
	$schedule_options = wpbu_filtered_schedules();
	$schedule_keys = array_keys($schedule_options);
	$schedule_options_selected = get_option('wpbu_schedule_settings');

	print '<option> OFF </option>';
	foreach($schedule_keys as $key){
		if($schedule_options_selected['backup_frequency'] == $key){
			print '<option value="'.$key.'" selected="selected"> '.$schedule_options[$key]['display'].' </option>';
		}else{
			print '<option value="'.$key.'"> '.$schedule_options[$key]['display'].' </option>';
		}
	}
}

/*
|--------------------------------------------------------------------------
| WPBU Schedule Event Updater 
|--------------------------------------------------------------------------
|
| Checks the current state for  "OFF" and clear scheduled event else 
| it updates the scheduled event to what ever WPBU is set to.
|
*/
function wpbu_schedule_ensure(){

	$schedule_options = get_option('wpbu_schedule_settings');
	$schedule_setting = $schedule_options['backup_frequency'];

	// Check to see if the setting is "OFF"
	if($schedule_setting == 'OFF'){
		// check to see if the current wp_schedule is set and of so, remove it
		if(wp_next_scheduled( 'wpbu_backup_event' )){
			wp_clear_scheduled_hook('wpbu_backup_event');
		}
	}else{
		// WPBU settings indicate that the setting is set to something other than off
		// We can check t make sure the current settings matches the current scheduled event.
		// If the setting and current schedule event do not match we need to update the settings.
		// Current we see not reason to remove the schedule event since doign wp_scheudle_event seems to update instead of 
		// creating a new instance.
		// Here we will use WP current_time to make sure the timestamp is allows what WP is looking for
		if($schedule_setting != wp_get_schedule('wpbu_backup_event')){
			//print 'We need to update the schedule event; WPBU settings and wp_schedule do not match';
			wp_clear_scheduled_hook('wpbu_backup_event');
			wp_schedule_event( current_time( 'timestamp' ), $schedule_setting, 'wpbu_backup_event');
		}

	}
}

/*
|--------------------------------------------------------------------------
| WPBU backup schedule
|--------------------------------------------------------------------------
|
| Trigger backup
|
*/
function wpbu_backup_event(){
	if(class_exists('WPBU_Backup')){
		$schedule_options = get_option('wpbu_schedule_settings');
		$general_settings = get_option('wpbu_general_settings');

		// Init Backup
		$wpbu_backup = new WPBU_Backup();
		if( $schedule_options['backup_type'] == 'database' ){
			$wpbu_backup->Create_Database_Backup();
		}elseif( $schedule_options['backup_type'] == 'full' ){
			$wpbu_backup->full_backup();
		}

		if( $general_settings['send_email_notification'] == 'ON' ){
			if($general_settings['email_notification_contact'] == ''){
				$email = get_bloginfo('admin_email');
			}else{
				$email = $general_settings['email_notification_contact'];
			}
			wp_mail( $email, 'Backup Notification', 'Backup task as ran for '. site_url() );
		}
	}
}

/*
|--------------------------------------------------------------------------
| Extend WPBU with ajax functionality
|--------------------------------------------------------------------------
|
| Other inludes
|
*/
require_once( dirname(__FILE__) . '/admin-ajax.php');