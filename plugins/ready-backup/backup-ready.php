<?php
/**
 * Plugin Name: Ready! Backup
 * Plugin URI: http://readyshoppingcart.com/product/wordpress-backup-and-restoration-plugin/
 * Description:  Complete online backup + restoration. Manual or automate backup to Dropbox, FTP and Email. Custom backup files, database, plugins
 * Version: 0.4.1
 * Author: Backup Plugin Ready
 * Author URI: http://readyshoppingcart.com
 **/

    require_once(dirname(__FILE__). DIRECTORY_SEPARATOR. 'config.php');
    require_once(dirname(__FILE__). DIRECTORY_SEPARATOR. 'functions.php');
	// require_once( BUP_HELPERS_DIR. 'DropboxClient.php'); //classes/helpers/
	// require_once( BUP_HELPERS_DIR. 'OAuthSimple.php');//classes/helpers/
	// require_once( BUP_GLIB_DIR. 'Google_Client.php');
	// require_once( BUP_GLIB_DIR. 'contrib/Google_DriveService.php');
	//require_once(BUP_HELPERS_DIR. 'pclzip.lib.php');
    importClassBup('dbBup');
    importClassBup('installerBup');
    importClassBup('baseObjectBup');
    importClassBup('moduleBup');
    importClassBup('modelBup');
    importClassBup('viewBup');
    importClassBup('controllerBup');
    importClassBup('helperBup');
    importClassBup('tabBup');
    importClassBup('dispatcherBup');
    importClassBup('fieldBup');
    importClassBup('tableBup');
    importClassBup('frameBup');
    importClassBup('langBup');
    importClassBup('reqBup');
    importClassBup('uriBup');
    importClassBup('htmlBup');
    importClassBup('responseBup');
    importClassBup('fieldAdapterBup');
    importClassBup('validatorBup');
    importClassBup('errorsBup');
    importClassBup('utilsBup');
    importClassBup('modInstallerBup');
    importClassBup('wpUpdater');
	importClassBup('toeWordpressWidgetBup');
	importClassBup('installerDbUpdaterBup');
	importClassBup('templateModuleBup');
	importClassBup('templateViewBup');
	importClassBup('fileuploaderBup');
	//importClassBup('PclZip', BUP_HELPERS_DIR. 'plczip.lib.php');
	//importClassBup('recapcha',			BUP_HELPERS_DIR. 'recapcha.php');
	//importClassBup('mobileDetect',		BUP_HELPERS_DIR. 'mobileDetect.php');

    installerBup::update();
    errorsBup::init();
    
    dispatcherBup::doAction('onBeforeRoute');
    frameBup::_()->parseRoute();
    dispatcherBup::doAction('onAfterRoute');

    dispatcherBup::doAction('onBeforeInit');
    frameBup::_()->init();
    dispatcherBup::doAction('onAfterInit');

    dispatcherBup::doAction('onBeforeExec');
    frameBup::_()->exec();
    dispatcherBup::doAction('onAfterExec');