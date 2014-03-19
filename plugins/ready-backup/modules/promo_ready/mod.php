<?php
class promo_readyBup extends moduleBup {
	private $_specSymbols = array(
		'from'	=> array('?', '&'),
		'to'	=> array('%', '^'),
	);
	
	public function init() {
		//frameBup::_()->addScript('adminPromoOptions', $this->getModule()->getModPath(). 'js/admin.promo.js');
		add_action('admin_footer', array($this, 'displayAdminFooter'), 9);
		parent::init();
	}
	
	public function addWelcome() {
		installerBup::setUsed();
		return $this->getView()->showWelcomePage();
	}
	
	function displayAdminFooter(){
		if (frameBup::_()->isPluginAdminPage()){
				$this->getView()->displayAdminFooter();	
		}
	}
	
	/*public function displayAdminFooter() {
		$this->getView()->displayAdminFooter();	
	}*/
	
	private function _encodeSlug($slug) {
		return str_replace($this->_specSymbols['from'], $this->_specSymbols['to'], $slug);
	}
	private function _decodeSlug($slug) {
		return str_replace($this->_specSymbols['to'], $this->_specSymbols['from'], $slug);
	}
	public function decodeSlug($slug) {
		return $this->_decodeSlug($slug);
	}
	
}
?>