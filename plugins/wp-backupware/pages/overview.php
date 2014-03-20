<?php
function wpbu_overview_ui(){ 
	wpbu_admin_styles();
	wpbu_admin_scripts();
	wpbu_top_ui_callout();
	?>

	<div class="wrap">

		<?php //ui_top_callout(); ?>
		
		<div class="wpbu-tabs">
		  <?php wpbu_admin_page_tabs(); ?>
		  <div class="clearboth"></div>
		</div>
			
		<!-- Container -->  
		<div class="wpbu-wrapper">

			<div class="tab-description">
				<h3> Overview </h3>
			  	<p>
			  		Below are your current backups.
			  	</p>
			</div>
			  	
			<h3>Backups</h3>
			<table class="widefat">
				<thead>
				    <tr>
				        <th>ID</th>
				        <th>Date</th> 
				        <th>Type</th>
				        <th>Status</th>       
				        <th>Size</th>
				    </tr>
				</thead>
				<tfoot>
				    <tr>
				    	<th>ID</th>
				    	<th>Date</th>
				    	<th>Type</th>
				    	<th>Status</th>
				    	<th>Size</th>
				    </tr>
				</tfoot>
				<tbody id="wpbu-backup-list">
					<?php
						$args = array( 'post_type' => 'wpbu_backups', 'posts_per_page' => 10 );
						$loop = new WP_Query( $args );
						if($loop->have_posts()): while ( $loop->have_posts() ) : $loop->the_post();
						$backup_status =  get_post_meta( $loop->post->ID, 'backup_status', true);
					?>

					<tr id="wpbu-backup-<?= $loop->post->ID; ?>">
				     <td><?php print $loop->post->ID; ?></td>
				     <td><?php the_time('F jS, Y  @ H: i: s'); ?>
				     	<b></b>
				     	<div class="row-actions">
				     			<span class="download"><a class="download-backup" title="Download this backup to your local computer" href="<?= WPBU_DOWNLOADER . '?download=' . $loop->post->ID; ?>">Download</a> | </span>
				     			<span class="delete"><a class="wpbu-remove-backup" href="javascript:void(0);" title="Delete the backup from the the server" data-id="<?= $loop->post->ID; ?>">Remove</a></span>
				     		</div>
				     </td>
				     <td><?= get_post_meta($loop->post->ID, 'backup_type', true); ?></td>
				     <td><b><?= $backup_status; ?></b></td>
				     <td><b><?= get_post_meta($loop->post->ID, 'backup_size', true); ?></b></td>
				    </tr>
					<?php endwhile; else: ?>
					<tr id="no-backups-found">
						<td id="no-backups-found"> There are no backups found. </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<?php endif; ?>
				</tbody>
				</table>

				<br>
				<div class="doing-backup" style="background: #FFF; width: 200px; margin-bottom: 20px; line-height: 30px; height: 30px;">
					<img src="<?= WPBU_ROOT_DIR . 'assets/loading.gif'?>" width="30px" align="left"/> <b>Creating Backup...</b>
				</div>
				<a class="button button-primary" id="create-full-system-backup" href="javascipt:void(0);"> Create Full Backup </a>
				<a class="button button-primary" id="create-database-backup" href="javascript:void(0);"> Create Database Backup </a>
		</div>		

	</div>
	<!-- /wrap -->

<?php }