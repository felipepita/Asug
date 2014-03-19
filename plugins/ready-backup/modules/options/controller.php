<?php
class optionsControllerBup extends controllerBup {
	
	public function saveGroup() {
		$res = new responseBup();
		
		$post = reqBup::get('post');
		
		if ($result = $this->getModel()->saveGroup($post)) {
			$res->addMessage(langBup::_('Save Complete'));
			$res->addData($result);
		} else 
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}
	
	public function saveMainFromDestGroup(){
		$res = new responseBup();
		$post = reqBup::get('post');
		
		if ($result = $this->getModel()->saveMainFromDestGroup($post)) {
			$res->addMessage(langBup::_('Save Complete'));
			$res->addData($result);
		} else 
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}
	
// -- exemple ---
    /*public function save() {
		$res = new responseBup();
		if($this->getModel()->save(reqBup::get('post'))) {
			$res->addMessage(langBup::_('Done'));
			if(reqBup::getVar('code') == 'template') {
				$plTemplate = $this->getModel()->get('template');		// Current plugin template
				$tplName = ($plTemplate && frameBup::_()->getModule($plTemplate)) ? frameBup::_()->getModule($plTemplate)->getLabel() : '';
				$res->addData('new_name', $tplName);
			}
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
    }*/
	/*public function saveGroup() {
		$res = new responseBup();
		if($this->getModel()->saveGroup(reqBup::get('post'))) {
			$res->addMessage(langBup::_('Done'));
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}
	public function saveBgImg() {
		$res = new responseBup();
		if($this->getModel()->saveBgImg(reqBup::get('files'))) {
			$res->addData(array('imgPath' => frameBup::_()->getModule('options')->getBgImgFullPath()));
			$res->addMessage(langBup::_('Done'));
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}
	public function saveLogoImg() {
		$res = new responseBup();
		if($this->getModel()->saveLogoImg(reqBup::get('files'))) {
			$res->addData(array('imgPath' => frameBup::_()->getModule('options')->getLogoImgFullPath()));
			$res->addMessage(langBup::_('Done'));
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}*/
	/**
	 * Will save main options and detect - whether or not csp mode enabled/disabled to trigger appropriate actions
	 */
	/*public function saveMainGroup() {
		$res = new responseBup();
		$oldMode = $this->getModel()->get('mode');
		if($this->getModel()->saveGroup(reqBup::get('post'))) {
			$res->addMessage(langBup::_('Done'));
			$newMode = $this->getModel()->get('mode');
			if($oldMode != $newMode && $newMode == 'disable' && $this->getModel()->get('sub_notif_end_maint')) {
				// Notify all subscribers that site was opened
				frameBup::_()->getModule('subscribe')->sendSiteOpenNotif();
			}
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}*/
	/**
	 * Will save subscriptions options as usual options + try to re-saive email templates from this part
	 */
	/*public function saveSubscriptionGroup() {
		$res = new responseBup();
		if($this->getModel()->saveGroup(reqBup::get('post'))) {
			$res->addMessage(langBup::_('Done'));
			$emailTplData = reqBup::getVar('email_tpl');
			if(!empty($emailTplData) && is_array($emailTplData)) {
				foreach($emailTplData as $id => $tData) {
					frameBup::_()->getModule('messenger')->getController()->getModel('email_templates')->save(array(
						'id'		=> $id, 
						'subject'	=> $tData['subject'],
						'body'		=> $tData['body'],
					));
				}
			}
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}
	public function setTplDefault() {
		$res = new responseBup();
		$code = reqBup::getVar('code');
		switch($code) {
			case 'bg_image':
				$newOptValue = $this->getModel()->setBgImgDefault(reqBup::get('post'));
				break;
			case 'logo_image':
				$newOptValue = $this->getModel()->setLogoDefault(reqBup::get('post'));
				break;
			case 'msg_title_params':
				$newOptValue = $this->getModel()->setTitleParamsDefault(reqBup::get('post'));
				break;
			case 'msg_text_params':
				$newOptValue = $this->getModel()->setTextParamsDefault(reqBup::get('post'));
				break;
			default:
				$newOptValue = $this->getModel()->setTplDefault(reqBup::get('post'));
				break;
		}
		if($newOptValue !== false) {
			$res->addMessage(langBup::_('Done'));
			$res->addData('newOptValue', $newOptValue);
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}
	public function removeBgImg() {
		$res = new responseBup();
		if($this->getModel()->removeBgImg(reqBup::get('post'))) {
			$res->addMessage(langBup::_('Done'));
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}
	public function removeLogoImg() {
		$res = new responseBup();
		if($this->getModel()->removeLogoImg(reqBup::get('post'))) {
			$res->addMessage(langBup::_('Done'));
		} else
			$res->pushError ($this->getModel('options')->getErrors());
		return $res->ajaxExec();
	}
	public function getPermissions() {
		return array(
			BUP_USERLEVELS => array(
				BUP_ADMIN => array('save', 'saveGroup', 'saveBgImg', 'saveLogoImg', 'saveMainGroup', 'saveSubscriptionGroup', 'setTplDefault', 'removeBgImg', 'removeLogoImg')
			),
		);
	}*/
}

