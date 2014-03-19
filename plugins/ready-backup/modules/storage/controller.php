<?php
class storageControllerBup extends controllerBup {
	public function displayStorage(){
		$res = new responseBup();
		$res->addData(array($this->getView()->getAdminOptions()));
		return $res->ajaxExec();
		//echo $this->getView()->getAdminOptions();
		//exit;
	}
	
	
	public function getList() {
		$res = new responseBup();
		$list = $this->getModel()->getList(reqBup::get('post'));
		$res->addData('list', $list);
		$res->addData('count', $this->getModel()->getCount());
		//$res->addMessage(langBup::_('Done'));
		return $res->ajaxExec();
	}
	
}

