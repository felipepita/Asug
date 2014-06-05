<?php
/*
Plugin Name: User Status Manager
Description: Enable And Disable User Status Permanently Or For A Specific Period Of Time
Version: 2.1.2
Author: Rahul Balakrishna
Author URI: http://www.validateinfo.org
License: GPLv2
*/
?>
<?php

	 /************************* new functiona added - delete the user*********************************************************/
		function delete_selected_user($user_id) {
			global $wpdb;
			$table = $wpdb->prefix . 'user_status_manager';
			$row_count_arr  = $wpdb->get_row("select id from ".$table." where user_id=".$user_id);
			$row_count = count($row_count_arr);
			if($row_count>0){
				$wpdb->query('delete from '.$table.' where user_id='.$user_id);
			}
		}
		add_action( 'delete_user', 'delete_selected_user');
	/*************************************************************************************************************************/

	function manage_user_user_control(){
		include('manage_user.php');
	}
	session_start();
	
	// function check_user($user_login, $user) {
	function check_user( $user, $user_login = '', $user_pass = '' ) {
		global $wpdb;
		// if ( is_null( $user ) || is_wp_error( $user ) ) {
		if ( !( $user instanceof WP_User ) ) {
			// Autenticação falhou antes de chegar aqui
			return $user;
		}
		/*
		$user = get_user_by( 'login', $user_login );
		if ( !$user )
			return false;
		*/
		/*
		$user_id = $user->ID;
		$table = $wpdb->prefix . 'user_status_manager';
		$date_val = date('Y/m/d');
		$get_status = $wpdb->get_row('select status,status_from,status_to from '.$table.' where user_id='.$user_id);
		$status_from = $get_status->status_from;
		$status_to 	 = $get_status->status_to;
		if($get_status->status=="0"){
			if($status_from!="" && $status_to!=""){
				if($status_from <= $date_val){
					if($status_to >= $date_val){
						//The User Is Active
						$_SESSION['status_val']=0;
					}else{
						$_SESSION['status_val'] = 1;
					}
				}else{
					$_SESSION['status_val'] = 1;
				}
			}	
		}else{
			if($status_from!="" && $status_to!=""){
				if($status_from <= $date_val){
					if($status_to >= $date_val){
						$_SESSION['status_val'] = 1;
					}
				}
			}else{
				$_SESSION['status_val'] = 1;
			}
		}
		*/
		$condicao = usuarioEstaAtivo( $user, true );
		$mensagens = array(
			'usuario_inexistente'		=> 'Dados de login inexistentes.',
			'empresa_inexistente'		=> 'A sua empresa não tem cadastro no portal.',
			'empresa_inativa'			=> 'A sua empresa não se encontra em situação ativa no momento.',
			'email_nao_verificado'		=> 'Seu e-mail ainda não foi verificado. Caso precisa re-enviar a confirmaçao, <a href="' . site_url('/conta/confirmar') . '">clique aqui</a>.',
			'ativacao_expirada'			=> 'Sua associaçao expirou.',
			'usuario_inativo'			=> 'Sua conta não está ativada.',
			'usuario_ativo'				=> 'Login bem-sucedido!',
		);
		// if ( $_SESSION['status_val'] > 0 ) {
		if ( $condicao['status'] ) {
			// ATIVO
			$_SESSION['status_val'] = 0;
			return $user;
		} else {
			// INATIVO
			$_SESSION['status_val'] = 1;
			// $msg = display_message_usm();
			$msg = $mensagens[ $condicao['codigo'] ];
			return new WP_Error( 'inactive', $msg );
		}
	}
	
	// add_action('wp_login', 'check_user', 10, 2);
	// Roda o filtro tarde (20) para que a autenticação passe antes e defina o $user
	add_filter( 'authenticate', 'check_user', 20, 3 );
	
	function display_message_usm() {
		if ($_SESSION['status_val']==1) {
			global $wpdb;
			$strMessageTable = $wpdb->prefix . 'usm_post_message';
			$arrMessageId = $wpdb->get_results("select id,post_message from $strMessageTable LIMIT 1");
			//$message = '<div id="login_error">'.$arrMessageId[0]->post_message.'</div>';
			$message = $arrMessageId[0]->post_message;
			$_SESSION['status_val']=0;
			return $message;
		}
	}
	//add_filter('login_message', 'display_message_usm');
	
	
	function add_menu_link_user_control()
	{
		//add_menu_page('Status-Manager', 'Status-Manager', 'edit_users',__FILE__, 'manage_user_user_control');
		add_submenu_page( 'users.php', 'Controlar status', 'Controlar status', 'edit_users', __FILE__, 'manage_user_user_control' );
	}
	add_action('admin_menu', 'add_menu_link_user_control');
	
	/******************************* Create Table When Plugin Is Actived ****************************************************/
		function plugin_create_table_user_control()
		{
			// do NOT forget this global
			global $wpdb;
			
			$table = $wpdb->prefix . 'user_status_manager';
			$strMessageTable = $wpdb->prefix . 'usm_post_message';
			
			// this if statement makes sure that the table doe not exist already
			if($wpdb->get_var("show tables like '$table'") != $table || $wpdb->get_var("show tables like '$strMessageTable'") != $strMessageTable) 
			{
				if ( ! empty( $wpdb->charset ) )
					$charset_collate = "DEFAULT CHARACTER SET $wpdb->charset";
				if ( ! empty( $wpdb->collate ) )
					$charset_collate .= " COLLATE $wpdb->collate";
					
				$sql = "CREATE TABLE IF NOT EXISTS `" . $table . "` (
						`id` mediumint(9) NOT NULL AUTO_INCREMENT,
						`user_id` mediumint(9) NOT NULL,
						`user_name` text NOT NULL,
						`user_email` text NOT NULL,
						`status_from` text NOT NULL,
						`status_to` text NOT NULL,
						`status` text NOT NULL,
						UNIQUE KEY `id` (`id`)
					) ENGINE=InnoDB  DEFAULT CHARSET=latin1;";
					
				$sql_message = "CREATE TABLE IF NOT EXISTS `".$strMessageTable."` (
						`id` mediumint(9) NOT NULL AUTO_INCREMENT,
						`post_message` text NOT NULL,
						UNIQUE KEY `id` (`id`)
					)ENGINE=InnoDB  DEFAULT CHARSET=latin1;";
				require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
				dbDelta($sql);
				dbDelta($sql_message);
			}
			if(count($wpdb->get_results("Select post_message from $strMessageTable"))<=0){
				$wpdb->insert($strMessageTable,array('post_message'=>'<strong>Notification</strong>: Admin Have Disabled Your Account. Contact Your Site Administrator<br>'));
			}
		}
		
		// this hook will cause our creation function to run when the plugin is activated
		register_activation_hook( __FILE__, 'plugin_create_table_user_control' );
		wp_enqueue_script(array('jquery-ui-datepicker','jquery'));   
		wp_enqueue_style( 'jquery-style',plugin_dir_url(__FILE__).'css/jquery-ui.css');
	/******************************* End Of Code To Create Table When Plugin Is Activated ****************************************************/
	
	function add_user_USM($user_id) {
		global $wpdb;
		$table = $wpdb->prefix . 'users';
		$table_user_manager = $wpdb->prefix . 'user_status_manager';
		$get_inserted_user  = $wpdb->get_row("select user_login,user_email from ".$table." where id=".$user_id);
		$data = array(
						"user_id"=>$user_id,
						"user_name"=>$get_inserted_user->user_login,
						"user_email"=>$get_inserted_user->user_email,
						"status"=>"1"
					);
		$wpdb->insert($table_user_manager,$data);
	}
	add_action( 'user_register', 'add_user_USM');
	
	function usm_save() {
		// Carrega o processamento da requisição em ajax
		// @requer inc/config-associacao.php, enviarEmailPadronizado
		global $wpdb, $associacao_config;
		check_ajax_referer( 'usm_save', 'nonce' );
		require_once TEMPLATEPATH . '/inc/config-associacao.php';
		require dirname(__FILE__) . '/save_to_db.php';
		exit;
	}
	
	add_action( 'wp_ajax_usm_save', 'usm_save' );
