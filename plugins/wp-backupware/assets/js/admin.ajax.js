/**
 * WPBU Admin JS functions
 *
 * This file contains js functions for the admin area "as needed". We should use WP JS hooks when possible. Nobody likes hijackers
 *
 * @author wpbackupware
 */
(function($){
	
	/*
	|--------------------------------------------------------------------------
	| WBOU Admin namespace
	|--------------------------------------------------------------------------
	|
	| If there is a function that we need, it should be ran through this lib
	|
	*/
	wpbu = {};

	wpbu.doing_backup = false;
	wpbu.placeholder_id = 'backup_placeholder';

	/*
	|--------------------------------------------------------------------------
	| WPBU Admin Init functions
	|--------------------------------------------------------------------------
	|
	| Simply resets listeners to a fresh state. We would use something like 
	| "on" or "live" but they never are stable, so we will do it the old fashion
	| way.
	|
	*/
	wpbu.init = function(){

		/*
		|--------------------------------------------------------------------------
		| RESET
		|--------------------------------------------------------------------------
		|
		| RESETS eventlisteners so new elements can hook without 
		| adding to old events.
		|
		*/
		$('a#create-full-system-backup').unbind();
		$('a#create-database-backup').unbind();
		$('.wpbu-remove-backup').unbind();

		/*
		|--------------------------------------------------------------------------
		| EVENTLISTENER - Create a full backup
		|--------------------------------------------------------------------------
		|
		| AJAX calls and initializes a full backup
		|
		*/
		$('a#create-full-system-backup').click(function(e){
			e.preventDefault();

			if(wpbu.doing_backup)
				return;

			$('.doing-backup').fadeIn();
			wpbu.doing_backup = true;
			var data = {
				action: 'wpbu_do_full_backup'
			};
			$.post(ajaxurl, data, function(response) {
				var response = $.parseJSON(response);
				params = {
					id: response.id,
					time: response.time,
					type: response.type,
					status: response.status,
					size: response.size,
					download_path: response.download_path
				}
				wpbu.populate_backuplist(params);
				wpbu.doing_backup = false;
				$('.doing-backup').fadeOut();
			});
		});

		/*
		|--------------------------------------------------------------------------
		| EVENTLISTENER - Create a database backup
		|--------------------------------------------------------------------------
		|
		| Create a database backup
		|
		*/
		$('a#create-database-backup').click(function(e){
			e.preventDefault();

			if(wpbu.doing_backup)
				return;

			$('.doing-backup').fadeIn();
			wpbu.doing_backup = true;
			var data = {
				action: 'wpbu_do_database_backup'
			};
			$.post(ajaxurl, data, function(response) {
				var response = $.parseJSON(response);
				params = {
					id: response.id,
					time: response.time,
					type: response.type,
					status: response.status,
					size: response.size,
					download_path: response.download_path
				}
				wpbu.populate_backuplist(params);
				wpbu.doing_backup = false;
				$('.doing-backup').fadeOut();
			});
		});

		/*
		|--------------------------------------------------------------------------
		| EVENTLISTENER - Removes a backup
		|--------------------------------------------------------------------------
		|
		| Removed a backup from teh system and the backup list
		|
		*/
		$('.wpbu-remove-backup').click(function(e){
			e.preventDefault();
			var backupID = $(this).attr('data-id');
			var hook = $('#wpbu-backup-'+backupID);
			if(confirm('Are you sure that you want to DELETE this backup?')){
				$(hook).animate({
					opacity: 0.5
				});
				var data = {
					action: 'wpbu_remove_backup',
					backupID: backupID
				};
				$.post(ajaxurl, data, function(response) {
					if(response === '1'){
						if($('#wpbu-backup-list tr').length < 2){
							$(hook).fadeOut(500, function(){
								$(this).remove();
								$('#wpbu-backup-list').append('<td id="no-backups-found"> There are no backups found. </td>');
							});
						}else{
							$(hook).fadeOut(500, function(){
								$(this).remove();
							});
						}
					}else{
						alert('There was an error removing the backup.');
					}
				});
			}
			wpbu.init();
		});
	}

	/*
	|--------------------------------------------------------------------------
	| AJAX Remove a backup
	|--------------------------------------------------------------------------
	|
	| AJAX call to remove backup
	|
	*/
	wpbu.remove_backup = function( backupID ){
		if( confirm('Are you sure you want to DELETE this backup? There is no turning back. ') ){
			var data = {
				action: 'wpbu_remove_backup',
				backupID: backupID
			};
			$.post(ajaxurl, data, function(response) {
				if(response === '1'){
					wpbu.removebacup_fromlist('#wpbu-backup-' + backupID);
				}else{
					alert('There was an error removing the backup.');
				}
			});
			wpbu.init();
		}
	};

	/*
	|--------------------------------------------------------------------------
	| WPBU populate backup list
	|--------------------------------------------------------------------------
	|
	| Takes params and adds a backup to the backup list
	|
	*/
	wpbu.populate_backuplist = function( params ){
		if($('#wpbu-backup-list #no-backups-found').length > 0){
			console.log(params);
			$('#wpbu-backup-list #no-backups-found').remove();
			var backup_content = '\
				<tr id="wpbu-backup-'+params.id+'">\
				     <td>'+params.id+'</td>\
				     <td>'+params.time+'\
				     	<b></b>\
				     	<div class="row-actions">\
				     			<span class="download"><a class="download-backup" title="Download this backup to your local computer" href="'+params.download_path+'?download='+params.id+'">Download</a> | </span>\
				     			<span class="delete"><a class="wpbu-remove-backup" href="javascript:void(0);" title="Delete the backup from the the server" data-id="'+params.id+'">Remove</a></span>\
				     		</div>\
				     </td>\
				     <td>'+params.type+'</td>\
				     <td><b>'+params.status+'</b></td>\
				     <td><b>'+params.size+'</b></td>\
				    </tr>\
			';
			$('#wpbu-backup-list').append(backup_content);
		}else{
			console.log(params);
			var backup_content = '\
				<tr id="wpbu-backup-'+params.id+'">\
				     <td>'+params.id+'</td>\
				     <td>'+params.time+'\
				     	<b></b>\
				     	<div class="row-actions">\
				     			<span class="download"><a class="download-backup" title="Download this backup to your local computer" href="'+params.download_path+'?download='+params.id+'">Download</a> | </span>\
				     			<span class="delete"><a class="wpbu-remove-backup" href="javascript:void(0);" title="Delete the backup from the the server" data-id="'+params.id+'">Remove</a></span>\
				     		</div>\
				     </td>\
				     <td>'+params.type+'</td>\
				     <td><b>'+params.status+'</b></td>\
				     <td><b>'+params.size+'</b></td>\
				    </tr>\
			';
			$('#wpbu-backup-list').append(backup_content);
		}

		wpbu.init();
	}

	wpbu.init();
})(jQuery)