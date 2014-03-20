<?php
function wpbu_scheduler_ui(){
	wpbu_admin_styles();
	wpbu_top_ui_callout();
	?>

	<div class="wrap">

		<?php if(isset($_GET['settings-updated'])): ?>
			<div id="setting-error-settings_updated" class="updated settings-error"> 
				<p>
					<strong>Backup schedule saved</strong>
				</p>
			</div>
		<?php endif; ?>

		
		<div class="wpbu-tabs">
		  <?php wpbu_admin_page_tabs(); ?>
		  <div class="clearboth"></div>
		</div>
			
		<!-- Container -->  
		<div class="wpbu-wrapper">

			<div class="tab-description">
				<h3> Schedule Settings </h3>
			  	<p>
			  		Here you will be able to control how often your WordPress website is backed up.<br><br>
			  		<b>NOTE:</b> When saving a backup schedule to anything other than "OFF", WPBU will create a backup as soon as you save. <br>
			  		Scheduled backups will then be based off the time the schedule was saved.
			  	</p>
			</div>
			  	
			<form name="wpbu_general" method="post" action="options.php"/>
				<?php
					$wpbu_settings = get_option('wpbu_schedule_settings');
					settings_fields( 'wpbu-schedule-group' );
				?>
				<table class="form-table">

					<!-- Backup Frequency -->
					<tr>
						<th>
							<label for="backup-notifications">Backup Frequency</label><br>
							<small class="description">
								The schedule uses WP Cron as a means to trigger backups. Backups may not happen excectly on time.<br>
								<a href="http://wp.tutsplus.com/articles/insights-into-wp-cron-an-introduction-to-scheduling-tasks-in-wordpress/" title="Read more about WP Cron" target="_blank">Read more about WP Cron</a>
							</small>
						</th>
						<td>
							<select id="backup-notifications" name="wpbu_schedule_settings[backup_frequency]">
								<?php wpbu_get_admin_schedule_options(); ?>
							</select>
						</td>
					</tr>
					<!-- / backup Frequency -->

					<!-- backup Type -->
					<tr>
						<th>
							<label for="backup-type">Backup Type</label><br>
							<small class="description">
								We recommend only doing database backups while using the automated backup feature.
								Full backups may slow your site down while backing up.
							</small>
						</th>
						<td>
							<select id="backup-type" name="wpbu_schedule_settings[backup_type]">
								<option value="database" <?php if($wpbu_settings['backup_type'] == 'database') print 'selected="selected";'?>> Database (recommended) </option>
								<option value="full" <?php if($wpbu_settings['backup_type'] == 'full') print 'selected="selected";'?>> FULL </option>
							</select>
						</td>
					</tr>
					<!-- / backup Type -->

					<!--
					<tr>
						<th>
							<label for="backup-type">Enable Maintenance Mode</label><br>
							<small class="description">
								This puts your site into "<a href="http://codex.wordpress.org/Function_Reference/wp_maintenance" title="Read more about WP Maintenance Mode" target="_blank">Maintenance Mode</a>" during automted backups.
							</small>
						</th>
						<td>
							<input type="checkbox" name="wpbu_schedule_settings[maintenance_mode]" value="1" <?php if($wpbu_settings['maintenance_mode'] == '1') print 'checked="checked"'; ?>/>
						</td>
					</tr>
					-->

				</table>

				<?php submit_button('Update Backup Schedule Settings'); ?>
			</form>
		</div>		

	</div>
	<!-- /wrap -->










<?php }