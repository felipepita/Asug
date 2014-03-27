<?php
class adminmenuViewBup extends viewBup {
    protected $_file = '';
    /**
     * Array for standart menu pages
     * @see initMenu method
     */
    /*protected $_options = array(
        
    );*/
    public function init() {
        $this->_file = 'ready-backup-and-restore';
		//$this->_options = dispatcherBup::applyFilters('adminMenuOptions', $this->_options);
        add_action('admin_menu', array($this, 'initMenu'), 9);
        parent::init();
    }
    public function initMenu() {
		$firstTimeLookedToPlugin = installerBup::isUsed();
		//$firstTimeLookedToPlugin = false;
				
		if($firstTimeLookedToPlugin) {
        	add_menu_page(langBup::_('Ready! Backup'), langBup::_('Ready! Backup'), 10, $this->_file, array(frameBup::_()->getModule('options')->getView(), 'getAdminPage'));
		} else {
		if ( frameBup::_()->getModule('promo_ready') ){
				add_menu_page(langBup::_('Ready! Backup'), langBup::_('Ready! Backup'), 10, $this->_file, array(frameBup::_()->getModule('promo_ready')->getView(), 'showWelcomePage'));
			} else { // if not install module "promo_ready"
				installerBup::setUsed();
				add_menu_page(langBup::_('Ready! Backup'), langBup::_('Ready! Backup'), 10, $this->_file, array(frameBup::_()->getModule('options')->getView(), 'getAdminPage'));
			}
		}
		/*if(!empty($this->_options)) {
			foreach($this->_options as $opt) {
				add_submenu_page($this->_file, langBup::_($opt['title']), langBup::_($opt['title']), $opt['capability'], $opt['menu_slug'], $opt['function']);
			}
		}*/
    }
    public function getFile() {
        return $this->_file;
    }
    /*public function getOptions() {
        return $this->_options;
    }*/
	
}