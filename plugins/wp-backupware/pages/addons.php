<?php 
function wpbu_addons_ui(){
	wpbu_admin_styles();
	wpbu_top_ui_callout();
	?>

	<div class="wrap">

		<?php if(isset($_GET['settings-updated'])): ?>
				<div id="setting-error-settings_updated" class="updated settings-error"> 
					<p>
						<strong>General settings saved.</strong>
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
				<h3> Addons </h3>
			  	<p>
			  		Addons are bolt-on features that extend the functionality of the WP Backupware Plugin
			  	</p>
			</div>
			  	
			<h3>Currently Installed</h3>
			<table class="widefat">
				<thead>
				    <tr>
				        <th><b>Name</b></th>
				        <th><b>Description</b></th>
				        <th><b>Version</b></th> 
				        <th><b>Author</b></th>
				    </tr>
				</thead>
				<tfoot>
				    <tr>
				    	<th><b>Name</b></th>
				        <th><b>Description</b></th>
				        <th><b>Version</b></th> 
				        <th><b>Author</b></th>
				    </tr>
				</tfoot>
				<tbody id="ccb-backup-list">
					<?php
					global $wpbu;
					foreach($wpbu->components as $components):
						foreach($components as $component):
					?>
					<tr>
				    	<td><b><i><?= $component['title']; ?></i></b></td>
				     	<td><?= $component['description']; ?></td>
				     	<td><?= $component['version']; ?></td>
				     	<td><?= $component['auhtor']; ?></td>
				    </tr>
					<?php endforeach; endforeach; ?>
				</tbody>
				</table>
		</div>		

	</div>
	<!-- /wrap -->


<?php }