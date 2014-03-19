<?php
class pagesControllerBup extends controllerBup {
    public function recreatePages() {
		$res = new responseBup();
		if($this->getModel()->recreatePages()) {
			$res->addMessage(langBup::_('Pages was recreated'));
		} else {
			$res->pushError($this->getModel()->getErrors());
		}
		$res->ajaxExec();
	}
}

