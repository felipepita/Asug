<?php
class promo_readyControllerBup extends controllerBup {
	public function bupSendInfo(){
		$res = new responseBup();
		if($this->getModel()->welcomePageSaveInfo(reqBup::get('post'))) {
			$res->addMessage(langBup::_('Information was saved. Thank you!'));
			$originalPage = reqBup::getVar('original_page');
			$return = $this->getModule()->decodeSlug(str_replace('return=', '', $originalPage));
			$return = admin_url( strpos($return, '?') ? $return : 'admin.php?page='. $return);
			$res->addData('redirect', $return);
			installerBup::setUsed();
		} else {
			$res->pushError($this->getModel()->getErrors());
		}
		return $res->ajaxExec();
	}
}
?>