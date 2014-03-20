<?php
/**
 * Component Name: WPBU Core backup
 * Version: 1.0.0
 * Description: Adds backup functonality for WPBU.
 * Author: wpbackupware
 * Author URI: http://wpbackupware.com
 * License: GPL2
*/
class WPBU_Backup {

	public $version = "1.2.0";
	public $mysql_version;
	public $time;
	public $database_backup;
	public $backup_zip;
	public $start_time;
	public $end_time;

	public $file_structure = array();
	public $backup_exeptions = array('wpbu-backups');

	/*
	 |--------------------------------------------------------------------------
	 | Construct Method
	 |--------------------------------------------------------------------------
	 |
	 | Sets the class up for success
	 |
	 */
	public function __construct(){
		
		ignore_user_abort(true);

		// Ensure that the backup directory exists
		$this->wpbu_backupdir_check();

		// The backup time
		$this->time = time();

		// Gets the backup version
		$this->mysql_version = $this->get_mysql_version();

		// Designate the database backup .SQL file
		$this->database_backup = WPBU_BACKUP_DIR . '/'. $this->time.'.sql';

		// Designate the backup ZIP file
		$this->backup_zip = WPBU_BACKUP_DIR .'/'. $this->time.'.zip';

		// Since the backup can be triggered by anyone (wp cron) we need to make
		// the user id something. We will use something big just in case.
		$this->user_id = 999999999;

	}

	/*
	 |--------------------------------------------------------------------------
	 | Check and create backup directory
	 |--------------------------------------------------------------------------
	 |
	 | This should already be done but this is just in case
	 |
	 */
	public function wpbu_backupdir_check(){
		if( !file_exists( WPBU_BACKUP_DIR ))
			mkdir( WPBU_BACKUP_DIR, 0755 , true );
		if( !file_exists( WPBU_BACKUP_DIR . '/.htaccess' )){
			$htaccess = fopen( WPBU_BACKUP_DIR . '/.htaccess', 'w');
			$data = 'deny from all';
			fwrite( $htaccess, $data);
			fclose( $htaccess );
		}
		return;
	}

	/*
	 |--------------------------------------------------------------------------
	 | Start the backup process
	 |--------------------------------------------------------------------------
	 |
	 | The start of the backup
	 |
	 */
	public function full_backup(){

		// Create the zip file that will be used for the backup
		$zip = new ZipArchive();
		$zip->open( $this->backup_zip, ZipArchive::CREATE);

		// Create the backup post first so w

		// Start the database backup
		global $wpdb;
    	$tables = $wpdb->get_results( "SHOW TABLES" );
		$table_call = 'Tables_in_'.DB_NAME;
		foreach( $tables as $table ){
  
		  // Table name
		  $table_name = $table->$table_call;
			  
		  // Table Comment
		  $this->write( "--" );
		  $this->write( "-- Table structure for table `".$table_name."`");
		  $this->write( "--" );
		  $this->write( "");
  
		  // Drop Table
		  $this->write( "DROP TABLE IF EXISTS `".$table_name."`;");
  
		  // Write "Create Table"
		  $create_table = $this->show_create_table( $table_name );
		  $this->write( $create_table . ";" );
		  $this->write( "");
  
		  // Comment for dump content
		  $this->write( "--");
		  $this->write( "-- Dumping data for table `".$table_name."`");
			  $this->write( "--");
			  $this->write( "");
  
			  // Lock Table
			  $this->write( "LOCK TABLES `".$table_name."` WRITE;");
  
			  // There is currently no way to create  insert table
			  // I will use a custom buile method for this
			  $this->write( $this->show_create_insert( $table_name ) );
  
			  // Unlock the table and continue
			  $this->write( "UNLOCK TABLES;");
			  $this->write( "");
		  }	

		  // Add the Database backup to the backupZIP
		  $zip->addFile( $this->database_backup, '/database_backup.sql');
  
		  // Now we need to create the file system backup
		  $this->dir_tree( ABSPATH );
		  foreach( $this->file_structure as $file ){
		  	  $zip->addFile( ABSPATH . $file, $file );
		  }

		  // Make sure the file is closed. if not the filesize will not be able to read it
		  $zip->close();

		  // Create the backup in WordPress
		  $page['post_type']    = 'wpbu_backups';
		  $page['post_content'] = 'WP Backupware - ' . $this->time;
		  $page['post_parent']  = 0;
		  $page['post_author']  = $this->user_id;
		  $page['post_status']  = 'private';
		  $page['post_title']   = 'WP Backupware - ' . $this->time;
		  $pageid = wp_insert_post ($page);
		  if ($pageid != 0) { 

			// Insert custom meta data
			add_post_meta( $pageid, 'backup_location', $this->backup_zip);
			add_post_meta( $pageid, 'backup_type', 'Full');
	  
			@$backup_size = $this->get_file_size( $this->backup_zip, 'MB', $pageid );
			add_post_meta( $pageid, 'backup_size', $backup_size);
	  
				  
			// Remove database SQL (clean up)
			@unlink( $this->database_backup );    
				  
			// @TODO Trigger additional FTP, Dropbox, Upload (comming soon)
			return array(
						  'status' => 'Completed',
						  'time' => date('F jS, Y  @ H: i: s'),
						  'id' => $pageid,
						  'title' => $page['post_title'],
						  'size' => $backup_size,
						  'type' => 'Full',
						  'download_path' => WPBU_DOWNLOADER
						  );
	  
			}else{
				  return array(
							  'backup_status' => 'failed',
							  'error' => 'The backup could not be completed'
							  );
	  
			}

	}

	function Create_Database_Backup(){
	 	$zip = new ZipArchive();
		$zip->open( $this->backup_zip, ZipArchive::CREATE);

	 	global $wpdb;
		//$this->write_mysql_bak_header_information();
    	$tables = $wpdb->get_results( "SHOW TABLES" );
		$table_call = 'Tables_in_'.DB_NAME;
		foreach( $tables as $table ){
		  	$table_name = $table->$table_call;
		  	$this->write( "--" );
		  	$this->write( "-- Table structure for table `".$table_name."`");
		  	$this->write( "--" );
		  	$this->write( "");
		  	$this->write( "DROP TABLE IF EXISTS `".$table_name."`;");
		  	$create_table = $this->show_create_table( $table_name );
		  	$this->write( $create_table . ";" );
		  	$this->write( "");
		  	$this->write( "--");
		  	$this->write( "-- Dumping data for table `".$table_name."`");
			$this->write( "--");
			$this->write( "");
			$this->write( "LOCK TABLES `".$table_name."` WRITE;");
			$this->write( $this->show_create_insert( $table_name ) );
		  	$this->write( "UNLOCK TABLES;");
			$this->write( "");
		  }
		  $zip->addFile( $this->database_backup, '/database_backup.sql');
		  $zip->close();

		  // Create the backup in WordPress
		  $page['post_type']    = 'wpbu_backups';
		  $page['post_content'] = 'WP Backupware - ' . $this->time;
		  $page['post_parent']  = 0;
		  $page['post_author']  = $this->user_id;
		  $page['post_status']  = 'private';
		  $page['post_title']   = 'WP Backupware - ' . $this->time;
		  $pageid = wp_insert_post ($page);
		  if ($pageid != 0) { 

			// Insert custom meta data
			add_post_meta( $pageid, 'backup_location', $this->backup_zip);
			add_post_meta( $pageid, 'backup_type', 'Database');
	  
			@$backup_size = $this->get_file_size( $this->backup_zip, 'MB', $pageid );
			add_post_meta( $pageid, 'backup_size', $backup_size);
				  
			// Remove database SQL (clean up)
			@unlink( $this->database_backup );    
				  
			// @TODO Trigger additional FTP, Dropbox, Upload (comming soon)
			return array(
						  'status' => 'Completed',
						  'time' => date('F jS, Y  @ H: i: s'),
						  'id' => $pageid,
						  'title' => $page['post_title'],
						  'size' => $backup_size,
						  'type' => 'Database',
						  'download_path' => WPBU_DOWNLOADER
						  );
	  
			}else{
				  return array(
							  'backup_status' => 'failed',
							  'error' => 'The backup could not be completed'
							  );
	  
			}

		  return true;
	 }

	/*
	 |--------------------------------------------------------------------------
	 | Get file size
	 |--------------------------------------------------------------------------
	 |
	 */
    public function get_file_size($file, $type, $ID){
       switch($type){
          case "KB":
            $filesize = filesize($file) * .0009765625; // bytes to KB
          	break;
          case "MB":
            $filesize = (filesize($file) * .0009765625) * .0009765625; // bytes to MB
          	break;
          case "GB":
            $filesize = ((filesize($file) * .0009765625) * .0009765625) * .0009765625; // bytes to GB
          	break;
       }
       if($filesize <= 0){
       	@add_post_meta( $ID, 'backup_status', 'Failed');
        return $filesize = 'Unknown';
       }else{
        @add_post_meta( $ID, 'backup_status', 'Completed');
        return round($filesize, 2).' '.$type;
        }
    }

	/*
	 |--------------------------------------------------------------------------
	 | Show create table syntax
	 |--------------------------------------------------------------------------
	 |
	 | Syntax straight form the MySQL server
	 |
	 */
    protected function show_create_table($table = null){
    	if(empty($table))
    		return;
    	global $wpdb;
    	$status = $wpdb->get_results("SHOW CREATE TABLE {$table}");
    	return $status[0]->{'Create Table'};
    }

    /*
	 |--------------------------------------------------------------------------
	 | Show create table syntax
	 |--------------------------------------------------------------------------
	 |
	 | Collect data and returns a formatted dump of any given table contents
	 |
	 */
    protected function show_create_insert($table = null){
    	if(empty($table))
    		return;
    	global $wpdb;
    	$data = $wpdb->get_results("SELECT * FROM {$table}");

    	$return ='';
    	if(count($data)>0){

    		foreach($data as $insert){
    			$value_array = array();
    			foreach($insert as $key=>$value){
    				if ( is_int($value) ){
    					array_push($value_array, $value);
    				}else{
    					array_push($value_array, "'".str_replace("'", "\'", $value)."'");
    				}
    			}
    			$row_values = implode(", ", $value_array);

    			// Build the first half of the insert
    			$return .= "INSERT INTO `".$table."` VALUES (".$row_values."); \n";
    			
    		}

    	}
    	return $return;
    }

	/*
	 |--------------------------------------------------------------------------
	 | Return MySQL Version
	 |--------------------------------------------------------------------------
	 |
	 | Retuns a formatted version number of current MySQL
	 |
	 */
	public function get_mysql_version(){
		global $wpdb;
		$version = $wpdb->get_results("SELECT VERSION()");
       	return $version[0]->{'VERSION()'};
	}

	/*
	 |--------------------------------------------------------------------------
	 | Write header information 
	 |--------------------------------------------------------------------------
	 |
	 | Write header information to the database backup dump
	 |
	 */
	protected function write_mysql_bak_header_information(){
		// Header Information
        $this->write( "-- PHP MySQL Dump Alpha, WP BACKUPWARE (".$this->version.")" );
        $this->write( "--" );
        $this->write( "-- Host: ".DB_HOST."    Database: ".DB_NAME."" );
        $this->write( "--------------------------------------------------------" );
        $this->write( "-- Server version  ".$this->mysql_version."" );
        $this->write( "" );
	}

	/*
	 |--------------------------------------------------------------------------
	 | Gets the file system tree
	 |--------------------------------------------------------------------------
	 |
	 | Returns the entire filesystems absolute paths
	 |
	 */
	public function dir_tree($path){
	    if($dh = opendir($path)){
			while(false !== ($file = readdir($dh))){
				if(($file !== '.') && ($file !== '..')){

					if(in_array($file,$this->backup_exeptions))
						continue;

					if(!is_dir($path.$file)){
						//print str_replace(ABSPATH, '', $path.$file) .'<br>';
						array_push($this->file_structure, str_replace(ABSPATH, '', $path.$file) );
					}else{
						$this->dir_tree($path.$file.'/');
					}
				}
			}
		}
	}

	/*
	 |--------------------------------------------------------------------------
	 | Write to the file current backup file
	 |--------------------------------------------------------------------------
	 |
	 | Retuns a formatted version number of current MySQL
	 |
	 */
	protected function write( $content = null ){
    	if(empty($content))
    		return;

        $handler = fopen( $this->database_backup, 'a' );
        fwrite( $handler,  $content . "\n");
        fclose( $handler );
    }
}