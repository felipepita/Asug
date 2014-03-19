<?php 
	$not_piad = utilsBup::checkPRO() ? '' : 'bupNotPaid';
?>
<form class="cspNiceStyle" id="bupAdminMainForm">
<div class="main-progress-bar" style="display:none;">
	<div class="progress-bar devblue shine"> <!-- -->
    	<span style="width: 100%"></span>
	</div>
</div>
	<div id="BUP_MESS_MAIN"></div>
    <?php
		$wpcontent = ABSPATH.'wp-content';
		$wh = frameBup::_()->getModule('options')->get('warehouse');
		$warehouse = substr(ABSPATH, 0, strlen(ABSPATH)-1).substr($wh, 0, strlen($wh)-1);
		
		//$access_wp_content = (is_writable($wpcontent) && is_readable($wpcontent)) ? true : false;
		$access_wp_content = is_writable($wpcontent) ? true : false;
		//echo $access_wp_content ? 'access_wp_content = true<br />' : 'access_wp_content = false<br />';
		$access_warehouse = (is_writable($warehouse) && is_readable($warehouse)) ? true : false;
		//echo $access_warehouse ? 'access_warehouse = true<br />' : 'access_warehouse = false<br />';

		
		if (!$access_wp_content && !$access_warehouse) {
			echo '<div id="checkWritable" style="color:#C00;"><strong>Warning:</strong> Directory<br />'.ABSPATH.'wp-content/'.substr(ABSPATH, 0, strlen(ABSPATH)-1).frameBup::_()->getModule('options')->get('warehouse').' didn\'t exist. Please create directory with permission 755 or 777 manually!"</div>';
		} elseif (!$access_warehouse) {
			echo '<div id="checkWritable" style="color:#C00;"><strong>Warning:</strong> Directory<br />'.ABSPATH.'wp-content/'.substr(ABSPATH, 0, strlen(ABSPATH)-1).frameBup::_()->getModule('options')->get('warehouse').' didn\'t exist. Please create directory with permission 755 or 777 manually!"</div>';
		}
		
		
	?>

	<table width="100%">
    	<tr class="cspAdminOptionRow cspTblRow">
        	<td width="100">Backup site</td>
            <td>
                <?php echo htmlBup::hidden('reqType', array('value' => 'ajax'))?>
                <?php echo htmlBup::hidden('page', array('value' => 'backup'))?>
				<?php echo htmlBup::hidden('action', array('value' => 'createAction'))?>
				<?php echo htmlBup::submit('backupnow', array('value' => langBup::_('Backup Now'), 'attrs' => 'class="button button-primary button-large"'))?>
            </td>
        </tr>
    </table>
</form>
<form class="cspNiceStyle" > <!--id="bupAdminMainForm"-->
    <table width="100%">
    	<tr class="cspAdminOptionRow cspTblRow">
        	<td width="100">Restore backup</td>
            <td>
            	<?php echo htmlBup::button(array('attrs' => 'class="button button-primary button-large" id="redirStorage"', 'value' => langBup::_('Restore'))); ?>
            </td>
        </tr>
        <tr class="cspAdminOptionRow cspTblRow">
        	<td></td>
            <td></td>
        </tr>
    </table>
</form> 

<div id="resBox"></div>

<div align="left">
    <a id="bup_a_maininfo" href="javascript: void (0)">Options info</a> &darr;
    <div id="BUP_MESS_INFO"></div>
    <div id="bupInfoBlock"></div>
</div>

<div class="bupDest">
    <form id="bupMainFormOptions" method="post">
        <div class="bupMsgDest"></div>
        <div style="margin-bottom:4px;" >Where to Backup:</div>
            <div class="bupMargDest">
                <?php echo htmlBup::radiobutton('dest_opt', array('attrs'=>'class=""', 'value' => 'ftp', 'checked' => frameBup::_()->getModule('options')->get('glb_dest') == 'ftp' ? 'checked' : '')); ?> FTP
			</div>
			<div class="bupMargDest">
				<?php echo htmlBup::radiobutton('dest_opt', array(
					'attrs'   => 'class="'.$not_piad.'"',
					'value'   => 'dropbox',
					'checked' => frameBup::_()->getModule('options')->get('glb_dest') == 'dropbox' ? 'checked' : '',
				)); ?> Dropbox
			</div>
			<div class="bupMargDest">
				<?php echo htmlBup::radiobutton('dest_opt', array(
					'attrs'   => 'class="'.$not_piad.'"',
					'value'   => 'googledrive',
					'checked' => frameBup::_()->getModule('options')->get('glb_dest') == 'googledrive' ? 'checked' : '',
				)); ?> Google Drive
			</div>
            <div class="bupMargDest">
                <?php echo htmlBup::radiobutton('dest_opt', array(
                    'attrs'   => 'class="'.$not_piad.'"', 
                    'value'   => 'amazon',
                    'checked' => frameBup::_()->getModule('options')->get('glb_dest') == 'amazon' ? 'checked' : '',
                )); ?> Amazon S3
            </div>

            <div>
                <?php echo htmlBup::hidden('reqType', array('value' => 'ajax'))?>
                <?php echo htmlBup::hidden('page', array('value' => 'options'))?>
                <?php echo htmlBup::hidden('action', array('value' => 'saveMainFromDestGroup'))?>
                <?php echo htmlBup::submit('saveAll', array('value' => langBup::_('Save'), 'attrs' => 'class="button button-primary button-large"'))?>
            </div>
            <div id="bupMainFormOptionsMsg"></div>
    </form>
</div>