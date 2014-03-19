<?php
class scheduleViewBup extends viewBup {
    public function getAdminOptions() {
		$destList = array();
		frameBup::_()->addScript('adminScheduleOptions', $this->getModule()->getModPath(). 'js/admin.schedule.js');
		
		/*
		* 1 - FTP
		* 2 - DropBox
		*/
		
		$destList[1] = 'FTP';
//		if (frameBup::_()->getModule('dropbox')->getModel()->checkAuthDrDx()){
//			$destList[2] = 'Dropbox';
//		}
		
		$destination = array('value' => frameBup::_()->getModule('options')->get('sch_dest'), 'options' => $destList);
		
		$this->assign('destination', $destination);
			
		return parent::getContent('schedulePage');
	}
}
