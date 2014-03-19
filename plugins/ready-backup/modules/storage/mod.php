<?php
class storageBup extends moduleBup {
	public function init() {
		parent::init();
		//dispatcherBup::addFilter('adminOptionsTabs', array($this, 'addOptionsTab'));
	}
	
	/*public function getContentStorage(){
		return $this->getController()->getView()->getAdminOptions();
	}*/
	
}