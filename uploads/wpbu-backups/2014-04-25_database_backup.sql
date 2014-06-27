--
-- Table structure for table `wp_blc_filters`
--
DROP TABLE IF EXISTS `wp_blc_filters`;
CREATE TABLE `wp_blc_filters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `params` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_blc_filters`
--
LOCK TABLES `wp_blc_filters` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_blc_instances`
--
DROP TABLE IF EXISTS `wp_blc_instances`;
CREATE TABLE `wp_blc_instances` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` int(10) unsigned NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  `container_type` varchar(40) NOT NULL DEFAULT 'post',
  `link_text` varchar(250) NOT NULL DEFAULT '',
  `parser_type` varchar(40) NOT NULL DEFAULT 'link',
  `container_field` varchar(250) NOT NULL DEFAULT '',
  `link_context` varchar(250) NOT NULL DEFAULT '',
  `raw_url` text NOT NULL,
  PRIMARY KEY (`instance_id`),
  KEY `link_id` (`link_id`),
  KEY `source_id` (`container_type`,`container_id`),
  KEY `parser_type` (`parser_type`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_blc_instances`
--
LOCK TABLES `wp_blc_instances` WRITE;
INSERT INTO `wp_blc_instances` VALUES ('39', '1', '1', 'comment', 'Sr. WordPress', 'url_field', 'comment_author_url', '', 'http://wordpress.org/'); 
INSERT INTO `wp_blc_instances` VALUES ('44', '7', '137', 'page', 'Funciona', 'link', 'post_content', '', '[boleto_usuario]'); 
INSERT INTO `wp_blc_instances` VALUES ('45', '8', '160', 'page', 'www.asug.com.br', 'link', 'post_content', '', 'http://www.asug.com.br'); 
INSERT INTO `wp_blc_instances` VALUES ('46', '9', '285', 'page', '<img class="alignnone size-full wp-image-255" alt="asug_recibo_rodape" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg" width="1020" height="38" />', 'link', 'post_content', '', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg'); 
INSERT INTO `wp_blc_instances` VALUES ('47', '10', '285', 'page', '', 'image', 'post_content', '', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg'); 
INSERT INTO `wp_blc_instances` VALUES ('48', '11', '285', 'page', '', 'image', 'post_content', '', 'http://fliporto.net/2013/wp-content/uploads/2013/11/JoseSaramagoAssinatura.png'); 
INSERT INTO `wp_blc_instances` VALUES ('49', '9', '285', 'page', '', 'image', 'post_content', '', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_blc_links`
--
DROP TABLE IF EXISTS `wp_blc_links`;
CREATE TABLE `wp_blc_links` (
  `link_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `first_failure` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_check` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_success` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_check_attempt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `check_count` int(4) unsigned NOT NULL DEFAULT '0',
  `final_url` text CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `redirect_count` smallint(5) unsigned NOT NULL DEFAULT '0',
  `log` text NOT NULL,
  `http_code` smallint(6) NOT NULL DEFAULT '0',
  `status_code` varchar(100) DEFAULT '',
  `status_text` varchar(250) DEFAULT '',
  `request_duration` float NOT NULL DEFAULT '0',
  `timeout` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `broken` tinyint(1) NOT NULL DEFAULT '0',
  `may_recheck` tinyint(1) NOT NULL DEFAULT '1',
  `being_checked` tinyint(1) NOT NULL DEFAULT '0',
  `result_hash` varchar(200) NOT NULL DEFAULT '',
  `false_positive` tinyint(1) NOT NULL DEFAULT '0',
  `dismissed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`link_id`),
  KEY `url` (`url`(150)),
  KEY `final_url` (`final_url`(150)),
  KEY `http_code` (`http_code`),
  KEY `broken` (`broken`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_blc_links`
--
LOCK TABLES `wp_blc_links` WRITE;
INSERT INTO `wp_blc_links` VALUES ('1', 'http://wordpress.org/', '0000-00-00 00:00:00', '2014-04-22 21:36:10', '2014-04-22 21:36:10', '2014-04-22 21:36:10', '0', 'http://wordpress.org/', '0', '=== Código HTTP : 200 ===

HTTP/1.1 200 OK
Server: nginx
Date: Tue, 22 Apr 2014 21:36:10 GMT
Content-Type: text/html; charset=utf-8
Connection: keep-alive
Vary: Accept-Encoding
X-nc: HIT lax 250


O link é válido.', '200', '', '', '0.391', '0', '0', '1', '0', '200|0|0|8e73c6b5bc5ba66d98238874d1d08cfb', '0', '0'); 
INSERT INTO `wp_blc_links` VALUES ('7', 'http://127.0.0.1/asug/e-mail-boleto-asug/[boleto_usuario]', '2014-03-23 22:27:44', '2014-04-22 21:36:20', '0000-00-00 00:00:00', '2014-04-22 21:36:20', '11', 'http://127.0.0.1/asug/e-mail-boleto-asug/%5Bboleto_usuario%5D', '0', '=== Código HTTP : 404 ===

HTTP/1.1 404 Not Found
Date: Tue, 22 Apr 2014 21:36:28 GMT
Server: Apache/2.4.7 (Win32) OpenSSL/0.9.8y PHP/5.4.22
X-Powered-By: PHP/5.4.22
Set-Cookie: PHPSESSID=ve8clilk43ruaiphgg2qfq6l81; path=/
Expires: Wed, 11 Jan 1984 05:00:00 GMT
Cache-Control: no-cache, must-revalidate, max-age=0
Pragma: no-cache
X-CF-Powered-By: WP 1.3.13
X-Pingback: http://127.0.0.1/asug/xmlrpc.php
Transfer-Encoding: chunked
Content-Type: text/html; charset=UTF-8


O link está quebrado.', '404', '', '', '1.703', '0', '1', '1', '0', '404|broken|0|102e3d22e48d42ff66c7ff9dda5f7401', '0', '0'); 
INSERT INTO `wp_blc_links` VALUES ('8', 'http://www.asug.com.br', '0000-00-00 00:00:00', '2014-04-22 21:36:10', '2014-04-22 21:36:10', '2014-04-22 21:36:10', '0', 'http://www.asug.com.br/irj/portal/anonymous', '1', '=== Código HTTP : 200 ===

HTTP/1.1 302 Found
Location: http://www.asug.com.br/irj/portal/anonymous
Server: SAP J2EE Engine/7.00
Content-Length: 0
Date: Tue, 22 Apr 2014 21:36:10 GMT

HTTP/1.1 200 OK
Server: SAP J2EE Engine/7.00
Content-Type: text/html; charset=UTF-8
Connection: close
Content-Language: en-US
Date: Tue, 22 Apr 2014 21:36:10 GMT
Set-Cookie: PortalAlias=portal/anonymous; Path=/
Set-Cookie: saplb_*=(J2EE7563700)7563750; Version=1; Path=/
Set-Cookie: JSESSIONID=(J2EE7563700)ID0825668350DBb5e167c102626575e272ec42602108688512a340End; Version=1; Domain=.asug.com.br; Path=/


O link é válido.', '200', '', '', '0.125', '0', '0', '1', '0', '200|0|0|1561d2ec40f2ba63fa6be2e9cad93f4d', '0', '0'); 
INSERT INTO `wp_blc_links` VALUES ('9', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg', '0000-00-00 00:00:00', '2014-04-22 21:36:10', '2014-04-22 21:36:10', '2014-04-22 21:36:10', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg', '0', '=== Código HTTP : 200 ===

HTTP/1.1 200 OK
Date: Tue, 22 Apr 2014 21:36:12 GMT
Server: Apache/2.4.7 (Win32) OpenSSL/0.9.8y PHP/5.4.22
Last-Modified: Fri, 11 Apr 2014 08:15:42 GMT
ETag: "1c16-4f6bff0900780"
Accept-Ranges: bytes
Content-Length: 7190
Content-Type: image/jpeg


O link é válido.', '200', '', '', '0.032', '0', '0', '1', '0', '200|0|0|06f5fc7295840e45d5a8b81b00d36af8', '0', '0'); 
INSERT INTO `wp_blc_links` VALUES ('10', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg', '0000-00-00 00:00:00', '2014-04-22 21:36:16', '2014-04-22 21:36:16', '2014-04-22 21:36:16', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg', '0', '=== Código HTTP : 200 ===

HTTP/1.1 200 OK
Date: Tue, 22 Apr 2014 21:36:20 GMT
Server: Apache/2.4.7 (Win32) OpenSSL/0.9.8y PHP/5.4.22
Last-Modified: Fri, 11 Apr 2014 08:15:42 GMT
ETag: "328e-4f6bff0900780"
Accept-Ranges: bytes
Content-Length: 12942
Content-Type: image/jpeg


O link é válido.', '200', '', '', '0.003413', '0', '0', '1', '0', '200|0|0|11626361f80de65d36a47e46bd8d1caa', '0', '0'); 
INSERT INTO `wp_blc_links` VALUES ('11', 'http://fliporto.net/2013/wp-content/uploads/2013/11/JoseSaramagoAssinatura.png', '0000-00-00 00:00:00', '2014-04-22 21:36:30', '2014-04-22 21:36:30', '2014-04-22 21:36:30', '0', 'http://fliporto.net/2013/wp-content/uploads/2013/11/JoseSaramagoAssinatura.png', '0', '=== Código HTTP : 200 ===

HTTP/1.1 200 OK
Date: Tue, 22 Apr 2014 21:36:30 GMT
Server: Apache/2.2.22 (Debian)
Last-Modified: Sat, 16 Nov 2013 16:13:07 GMT
ETag: "310-1edd-4eb4d972a2f33"
Accept-Ranges: bytes
Content-Length: 7901
Content-Type: image/png


O link é válido.', '200', '', '', '0.125', '0', '0', '1', '0', '200|0|0|49571ecdfc6dc4f39dd39c11cb32b45e', '0', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_blc_synch`
--
DROP TABLE IF EXISTS `wp_blc_synch`;
CREATE TABLE `wp_blc_synch` (
  `container_id` int(20) unsigned NOT NULL,
  `container_type` varchar(40) NOT NULL,
  `synched` tinyint(2) unsigned NOT NULL,
  `last_synch` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`container_type`,`container_id`),
  KEY `synched` (`synched`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_blc_synch`
--
LOCK TABLES `wp_blc_synch` WRITE;
INSERT INTO `wp_blc_synch` VALUES ('1', 'comment', '1', '2014-04-12 16:10:47'); 
INSERT INTO `wp_blc_synch` VALUES ('2', 'page', '1', '2014-04-22 21:21:58'); 
INSERT INTO `wp_blc_synch` VALUES ('6', 'page', '1', '2014-04-12 16:10:48'); 
INSERT INTO `wp_blc_synch` VALUES ('8', 'page', '1', '2014-04-12 16:10:48'); 
INSERT INTO `wp_blc_synch` VALUES ('10', 'page', '1', '2014-04-12 16:10:48'); 
INSERT INTO `wp_blc_synch` VALUES ('12', 'page', '1', '2014-04-12 16:10:48'); 
INSERT INTO `wp_blc_synch` VALUES ('14', 'page', '1', '2014-04-12 16:10:48'); 
INSERT INTO `wp_blc_synch` VALUES ('16', 'page', '1', '2014-04-12 16:10:48'); 
INSERT INTO `wp_blc_synch` VALUES ('18', 'page', '1', '2014-04-12 16:10:48'); 
INSERT INTO `wp_blc_synch` VALUES ('20', 'page', '1', '2014-04-12 16:21:26'); 
INSERT INTO `wp_blc_synch` VALUES ('22', 'page', '1', '2014-04-12 16:22:01'); 
INSERT INTO `wp_blc_synch` VALUES ('35', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('37', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('39', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('41', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('43', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('79', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('80', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('81', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('82', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('83', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('96', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('97', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('98', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('99', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('102', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('103', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('104', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('137', 'page', '1', '2014-04-12 16:10:49'); 
INSERT INTO `wp_blc_synch` VALUES ('160', 'page', '1', '2014-04-12 16:10:50'); 
INSERT INTO `wp_blc_synch` VALUES ('285', 'page', '1', '2014-04-12 16:10:50'); 
INSERT INTO `wp_blc_synch` VALUES ('291', 'page', '1', '2014-04-12 16:16:09'); 
INSERT INTO `wp_blc_synch` VALUES ('294', 'page', '1', '2014-04-12 16:17:50'); 
INSERT INTO `wp_blc_synch` VALUES ('1', 'post', '1', '2014-04-12 16:10:50'); 
INSERT INTO `wp_blc_synch` VALUES ('90', 'post', '1', '2014-04-12 16:10:50'); 
INSERT INTO `wp_blc_synch` VALUES ('92', 'post', '1', '2014-04-12 16:10:50'); 
INSERT INTO `wp_blc_synch` VALUES ('94', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('213', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('222', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('226', 'post', '1', '2014-04-12 23:13:42'); 
INSERT INTO `wp_blc_synch` VALUES ('227', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('228', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('229', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('230', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('231', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('232', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('233', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('234', 'post', '1', '2014-04-12 16:10:51'); 
INSERT INTO `wp_blc_synch` VALUES ('309', 'post', '1', '2014-04-22 21:02:10'); 
INSERT INTO `wp_blc_synch` VALUES ('312', 'post', '1', '2014-04-22 21:15:50'); 
INSERT INTO `wp_blc_synch` VALUES ('313', 'post', '1', '2014-04-22 21:16:42'); 
INSERT INTO `wp_blc_synch` VALUES ('314', 'post', '1', '2014-04-22 21:17:51'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_bup_files`
--
DROP TABLE IF EXISTS `wp_bup_files`;
CREATE TABLE `wp_bup_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `size` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL,
  `date` datetime DEFAULT NULL,
  `download_limit` int(11) NOT NULL DEFAULT '0',
  `period_limit` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `type_id` smallint(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_bup_files`
--
LOCK TABLES `wp_bup_files` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_bup_htmltype`
--
DROP TABLE IF EXISTS `wp_bup_htmltype`;
CREATE TABLE `wp_bup_htmltype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_bup_htmltype`
--
LOCK TABLES `wp_bup_htmltype` WRITE;
INSERT INTO `wp_bup_htmltype` VALUES ('1', 'text', 'Text'); 
INSERT INTO `wp_bup_htmltype` VALUES ('2', 'password', 'Password'); 
INSERT INTO `wp_bup_htmltype` VALUES ('3', 'hidden', 'Hidden'); 
INSERT INTO `wp_bup_htmltype` VALUES ('4', 'checkbox', 'Checkbox'); 
INSERT INTO `wp_bup_htmltype` VALUES ('5', 'checkboxlist', 'Checkboxes'); 
INSERT INTO `wp_bup_htmltype` VALUES ('6', 'datepicker', 'Date Picker'); 
INSERT INTO `wp_bup_htmltype` VALUES ('7', 'submit', 'Button'); 
INSERT INTO `wp_bup_htmltype` VALUES ('8', 'img', 'Image'); 
INSERT INTO `wp_bup_htmltype` VALUES ('9', 'selectbox', 'Drop Down'); 
INSERT INTO `wp_bup_htmltype` VALUES ('10', 'radiobuttons', 'Radio Buttons'); 
INSERT INTO `wp_bup_htmltype` VALUES ('11', 'countryList', 'Countries List'); 
INSERT INTO `wp_bup_htmltype` VALUES ('12', 'selectlist', 'List'); 
INSERT INTO `wp_bup_htmltype` VALUES ('13', 'countryListMultiple', 'Country List with posibility to select multiple countries'); 
INSERT INTO `wp_bup_htmltype` VALUES ('14', 'block', 'Will show only value as text'); 
INSERT INTO `wp_bup_htmltype` VALUES ('15', 'statesList', 'States List'); 
INSERT INTO `wp_bup_htmltype` VALUES ('16', 'textFieldsDynamicTable', 'Dynamic table - multiple text options set'); 
INSERT INTO `wp_bup_htmltype` VALUES ('17', 'textarea', 'Textarea'); 
INSERT INTO `wp_bup_htmltype` VALUES ('18', 'checkboxHiddenVal', 'Checkbox with Hidden field'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_bup_log`
--
DROP TABLE IF EXISTS `wp_bup_log`;
CREATE TABLE `wp_bup_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(64) NOT NULL,
  `data` text,
  `date_created` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_bup_log`
--
LOCK TABLES `wp_bup_log` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_bup_modules`
--
DROP TABLE IF EXISTS `wp_bup_modules`;
CREATE TABLE `wp_bup_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `type_id` smallint(3) NOT NULL DEFAULT '0',
  `params` text,
  `has_tab` tinyint(1) NOT NULL DEFAULT '0',
  `label` varchar(128) DEFAULT NULL,
  `description` text,
  `ex_plug_dir` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_bup_modules`
--
LOCK TABLES `wp_bup_modules` WRITE;
INSERT INTO `wp_bup_modules` VALUES ('1', 'adminmenu', '1', '1', '', '0', 'Admin Menu', '', ''); 
INSERT INTO `wp_bup_modules` VALUES ('2', 'options', '1', '1', '', '1', 'Options', '', ''); 
INSERT INTO `wp_bup_modules` VALUES ('3', 'log', '1', '1', '', '1', 'Log', 'Internal system module to log some actions on server', ''); 
INSERT INTO `wp_bup_modules` VALUES ('4', 'templates', '1', '1', '', '0', 'Templates for Plugin', '', ''); 
INSERT INTO `wp_bup_modules` VALUES ('5', 'backup', '1', '1', '', '1', 'Backup ready!', 'Backup ready!', ''); 
INSERT INTO `wp_bup_modules` VALUES ('6', 'schedule', '1', '1', '', '1', 'Schedule', 'Schedule', ''); 
INSERT INTO `wp_bup_modules` VALUES ('7', 'storage', '1', '1', '', '1', 'Storage', 'Storage', ''); 
INSERT INTO `wp_bup_modules` VALUES ('8', 'promo_ready', '1', '1', '', '0', 'Promo ready', '', ''); 
INSERT INTO `wp_bup_modules` VALUES ('9', 'logger', '1', '1', '', '0', 'System logger', '', ''); 

UNLOCK TABLES;
--
-- Table structure for table `wp_bup_modules_type`
--
DROP TABLE IF EXISTS `wp_bup_modules_type`;
CREATE TABLE `wp_bup_modules_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_bup_modules_type`
--
LOCK TABLES `wp_bup_modules_type` WRITE;
INSERT INTO `wp_bup_modules_type` VALUES ('1', 'system'); 
INSERT INTO `wp_bup_modules_type` VALUES ('2', 'addons'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_bup_options`
--
DROP TABLE IF EXISTS `wp_bup_options`;
CREATE TABLE `wp_bup_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) CHARACTER SET latin1 NOT NULL,
  `value` longtext,
  `label` varchar(128) CHARACTER SET latin1 DEFAULT NULL,
  `description` text CHARACTER SET latin1,
  `htmltype_id` smallint(2) NOT NULL DEFAULT '1',
  `params` text,
  `cat_id` mediumint(3) DEFAULT '0',
  `sort_order` mediumint(3) DEFAULT '0',
  `value_type` varchar(16) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_bup_options`
--
LOCK TABLES `wp_bup_options` WRITE;
INSERT INTO `wp_bup_options` VALUES ('1', 'full', '1', 'Full backup', 'on/off full backup', '1', '', '0', '0', 'dest_backup'); 
INSERT INTO `wp_bup_options` VALUES ('2', 'plugins', '0', 'Plugins', 'on/off backup plugins', '1', '', '0', '0', 'dest_backup'); 
INSERT INTO `wp_bup_options` VALUES ('3', 'themes', '0', 'Themes', 'on/off backup themes', '1', '', '0', '0', 'dest_backup'); 
INSERT INTO `wp_bup_options` VALUES ('4', 'uploads', '0', 'Uploads', 'on/off backup uploads', '1', '', '0', '0', 'dest_backup'); 
INSERT INTO `wp_bup_options` VALUES ('5', 'database', '0', 'Database', 'on/off backup database', '1', '', '0', '0', 'db_backup'); 
INSERT INTO `wp_bup_options` VALUES ('6', 'any_directories', '0', 'Any', 'Any other directories found inside wp-content', '1', '', '0', '0', 'dest_backup'); 
INSERT INTO `wp_bup_options` VALUES ('7', 'warehouse', '/wp-content/upready/', 'Warehouse', 'path to storage', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('8', 'warehouse_ignore', 'upready', 'Warehouse_ignore', 'Name ignore directory storage', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('9', 'safe_array', '', 'Safe array', 'Safe file array', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('10', 'count_folder', '', 'Count folder', 'Count folder', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('11', 'exclude', 'upgrade,cache', 'Exclude', 'Exclude directories', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('12', 'sch_enable', '0', 'Enable shedule', 'Enable shedule', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('13', 'sch_every_hour', '0', 'Schedule every hour', 'Schedule every hour', '1', '', '0', '0', 'every'); 
INSERT INTO `wp_bup_options` VALUES ('14', 'sch_every_day', '0', 'Schedule every day', 'Schedule every day', '1', '', '0', '0', 'every'); 
INSERT INTO `wp_bup_options` VALUES ('15', 'sch_every_day_twice', '0', 'Schedule every day twice', 'Schedule every day twice', '1', '', '0', '0', 'every'); 
INSERT INTO `wp_bup_options` VALUES ('16', 'sch_every_week', '0', 'Schedule every week', 'Schedule every week', '1', '', '0', '0', 'every'); 
INSERT INTO `wp_bup_options` VALUES ('17', 'sch_every_month', '0', 'Schedule every month', 'Schedule every month', '1', '', '0', '0', 'every'); 
INSERT INTO `wp_bup_options` VALUES ('18', 'sch_time', 'a:1:{i:1;i:0;}', 'Schedule time backup', 'Schedule time backup', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('19', 'sch_dest', '1', 'Destination backup', 'Destination backup', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('20', 'email', '', 'Email', 'Email', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('21', 'glb_dest', 'ftp', 'Manual destination', 'Manual destination', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('22', 'force_update', '0', 'Force Update', 'Force Update', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('23', 'safe_update', '1', 'Safe Update', 'Safe Update', '1', '', '0', '0', ''); 
INSERT INTO `wp_bup_options` VALUES ('24', 'replace_newer', '1', 'Replace Newer', 'Replace newer files or not', '1', '', '0', '0', ''); 

UNLOCK TABLES;
--
-- Table structure for table `wp_bup_options_categories`
--
DROP TABLE IF EXISTS `wp_bup_options_categories`;
CREATE TABLE `wp_bup_options_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_bup_options_categories`
--
LOCK TABLES `wp_bup_options_categories` WRITE;
INSERT INTO `wp_bup_options_categories` VALUES ('1', 'General'); 
INSERT INTO `wp_bup_options_categories` VALUES ('2', 'Template'); 
INSERT INTO `wp_bup_options_categories` VALUES ('3', 'Subscribe'); 
INSERT INTO `wp_bup_options_categories` VALUES ('4', 'Social'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_commentmeta`
--
DROP TABLE IF EXISTS `wp_commentmeta`;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_commentmeta`
--
LOCK TABLES `wp_commentmeta` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_comments`
--
DROP TABLE IF EXISTS `wp_comments`;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext NOT NULL,
  `comment_author_email` varchar(100) NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) NOT NULL DEFAULT '',
  `comment_type` varchar(20) NOT NULL DEFAULT '',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_comments`
--
LOCK TABLES `wp_comments` WRITE;
INSERT INTO `wp_comments` VALUES ('1', '1', 'Sr. WordPress', '', 'http://wordpress.org/', '', '2014-03-15 15:51:25', '2014-03-15 15:51:25', 'Olá, Isto é um comentário.
Para excluir um comentário, faça o login e veja os comentários de posts. Lá você terá a opção de editá-los ou excluí-los.', '0', '1', '', '', '0', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_em_bookings`
--
DROP TABLE IF EXISTS `wp_em_bookings`;
CREATE TABLE `wp_em_bookings` (
  `booking_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  `booking_spaces` int(5) NOT NULL,
  `booking_comment` text,
  `booking_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `booking_status` tinyint(1) NOT NULL DEFAULT '1',
  `booking_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `booking_tax_rate` decimal(5,2) DEFAULT NULL,
  `booking_taxes` decimal(10,2) DEFAULT NULL,
  `booking_meta` longtext,
  PRIMARY KEY (`booking_id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_em_bookings`
--
LOCK TABLES `wp_em_bookings` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_em_events`
--
DROP TABLE IF EXISTS `wp_em_events`;
CREATE TABLE `wp_em_events` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `event_slug` varchar(200) DEFAULT NULL,
  `event_owner` bigint(20) unsigned DEFAULT NULL,
  `event_status` int(1) DEFAULT NULL,
  `event_name` text,
  `event_start_time` time DEFAULT NULL,
  `event_end_time` time DEFAULT NULL,
  `event_all_day` int(1) DEFAULT NULL,
  `event_start_date` date DEFAULT NULL,
  `event_end_date` date DEFAULT NULL,
  `post_content` longtext,
  `event_rsvp` tinyint(1) NOT NULL DEFAULT '0',
  `event_rsvp_date` date DEFAULT NULL,
  `event_rsvp_time` time DEFAULT NULL,
  `event_rsvp_spaces` int(5) DEFAULT NULL,
  `event_spaces` int(5) DEFAULT '0',
  `event_private` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `recurrence_id` bigint(20) unsigned DEFAULT NULL,
  `event_category_id` bigint(20) unsigned DEFAULT NULL,
  `event_attributes` text,
  `event_date_created` datetime DEFAULT NULL,
  `event_date_modified` datetime DEFAULT NULL,
  `recurrence` tinyint(1) NOT NULL DEFAULT '0',
  `recurrence_interval` int(4) DEFAULT NULL,
  `recurrence_freq` tinytext,
  `recurrence_byday` tinytext,
  `recurrence_byweekno` int(4) DEFAULT NULL,
  `recurrence_days` int(4) DEFAULT NULL,
  `blog_id` bigint(20) unsigned DEFAULT NULL,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event_status` (`event_status`),
  KEY `post_id` (`post_id`),
  KEY `blog_id` (`blog_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_em_events`
--
LOCK TABLES `wp_em_events` WRITE;
INSERT INTO `wp_em_events` VALUES ('1', '153', '', '1', '0', 'Goiania ASUG DAY', '00:15:00', '02:00:00', '1', '2014-03-24', '2014-03-31', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.', '1', '2014-03-23', '00:00:00', '400', '6000', '0', '4', '0', '0', 'a:0:{}', '2014-03-25 02:14:57', '2014-03-25 02:18:02', '0', '0', '', '', '0', '0', '0', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_em_locations`
--
DROP TABLE IF EXISTS `wp_em_locations`;
CREATE TABLE `wp_em_locations` (
  `location_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `blog_id` bigint(20) unsigned DEFAULT NULL,
  `location_slug` varchar(200) DEFAULT NULL,
  `location_name` text,
  `location_owner` bigint(20) unsigned NOT NULL DEFAULT '0',
  `location_address` varchar(200) DEFAULT NULL,
  `location_town` varchar(200) DEFAULT NULL,
  `location_state` varchar(200) DEFAULT NULL,
  `location_postcode` varchar(10) DEFAULT NULL,
  `location_region` varchar(200) DEFAULT NULL,
  `location_country` char(2) DEFAULT NULL,
  `location_latitude` float(10,6) DEFAULT NULL,
  `location_longitude` float(10,6) DEFAULT NULL,
  `post_content` longtext,
  `location_status` int(1) DEFAULT NULL,
  `location_private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_id`),
  KEY `location_state` (`location_state`),
  KEY `location_region` (`location_region`),
  KEY `location_country` (`location_country`),
  KEY `post_id` (`post_id`),
  KEY `blog_id` (`blog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_em_locations`
--
LOCK TABLES `wp_em_locations` WRITE;
INSERT INTO `wp_em_locations` VALUES ('1', '154', '0', 'escritorio-da-montarsite', 'Escritório da MontarSite', '1', 'Av Goias', 'São Caetano do Sul', 'São Paulo', '09550051', 'ABC', 'BR', '-23.619543', '-46.550900', '', '1', '0'); 
INSERT INTO `wp_em_locations` VALUES ('2', '155', '0', 'escritorio-da-montarsite-2', 'Escritório da MontarSite', '1', 'Av Goias', 'São Caetano do Sul', 'São Paulo', '09550051', 'ABC', 'BR', '-23.619543', '-46.550900', '', '1', '0'); 
INSERT INTO `wp_em_locations` VALUES ('3', '156', '0', 'escritorio-da-montarsite-3', 'Escritório da MontarSite', '1', 'Av Goias', 'São Caetano do Sul', 'São Paulo', '09550051', 'ABC', 'BR', '-23.619543', '-46.550900', '', '1', '0'); 
INSERT INTO `wp_em_locations` VALUES ('4', '157', '0', 'escritorio-da-montarsite-4', 'Escritório da MontarSite', '1', 'Av Goias', 'São Caetano do Sul', 'São Paulo', '09550051', 'ABC', 'BR', '-23.619543', '-46.550900', '', '1', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_em_meta`
--
DROP TABLE IF EXISTS `wp_em_meta`;
CREATE TABLE `wp_em_meta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  `meta_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`meta_id`),
  KEY `object_id` (`object_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_em_meta`
--
LOCK TABLES `wp_em_meta` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_em_tickets`
--
DROP TABLE IF EXISTS `wp_em_tickets`;
CREATE TABLE `wp_em_tickets` (
  `ticket_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned NOT NULL,
  `ticket_name` tinytext NOT NULL,
  `ticket_description` text,
  `ticket_price` decimal(10,2) DEFAULT NULL,
  `ticket_start` datetime DEFAULT NULL,
  `ticket_end` datetime DEFAULT NULL,
  `ticket_min` int(10) DEFAULT NULL,
  `ticket_max` int(10) DEFAULT NULL,
  `ticket_spaces` int(11) DEFAULT NULL,
  `ticket_members` int(1) DEFAULT NULL,
  `ticket_members_roles` longtext,
  `ticket_guests` int(1) DEFAULT NULL,
  `ticket_required` int(1) DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_em_tickets`
--
LOCK TABLES `wp_em_tickets` WRITE;
INSERT INTO `wp_em_tickets` VALUES ('1', '1', 'Ingresso padrão', '', '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '0', '10', '0', '', '0', '0'); 
INSERT INTO `wp_em_tickets` VALUES ('2', '1', 'Ingresso para associados', 'Associados no portal da ASUG', '200.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '0', '200', '0', '', '0', '0'); 
INSERT INTO `wp_em_tickets` VALUES ('3', '1', 'Ingresso padrão', '', '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '0', '10', '0', '', '0', '0'); 
INSERT INTO `wp_em_tickets` VALUES ('4', '1', 'Ingresso para associados', 'Associados no portal da ASUG', '200.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '0', '200', '0', '', '0', '0'); 
INSERT INTO `wp_em_tickets` VALUES ('5', '1', 'Ingresso padrão', '', '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '0', '10', '0', '', '0', '0'); 
INSERT INTO `wp_em_tickets` VALUES ('6', '1', 'Ingresso para associados', 'Associados no portal da ASUG', '200.00', '2014-03-23 00:15:00', '2014-03-31 02:15:00', '20', '30', '200', '0', '', '0', '0'); 
INSERT INTO `wp_em_tickets` VALUES ('7', '1', 'Ingresso padrão', '', '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '0', '10', '0', '', '0', '0'); 
INSERT INTO `wp_em_tickets` VALUES ('8', '1', 'Ingresso para associados', 'Associados no portal da ASUG', '200.00', '2014-03-23 00:15:00', '2014-03-31 02:15:00', '20', '30', '200', '0', '', '0', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_em_tickets_bookings`
--
DROP TABLE IF EXISTS `wp_em_tickets_bookings`;
CREATE TABLE `wp_em_tickets_bookings` (
  `ticket_booking_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` bigint(20) unsigned NOT NULL,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `ticket_booking_spaces` int(6) NOT NULL,
  `ticket_booking_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ticket_booking_id`),
  KEY `booking_id` (`booking_id`),
  KEY `ticket_id` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_em_tickets_bookings`
--
LOCK TABLES `wp_em_tickets_bookings` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_ewwwio_images`
--
DROP TABLE IF EXISTS `wp_ewwwio_images`;
CREATE TABLE `wp_ewwwio_images` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `path` text NOT NULL,
  `image_md5` varchar(55) DEFAULT NULL,
  `results` varchar(55) NOT NULL,
  `gallery` varchar(30) DEFAULT NULL,
  `image_size` int(10) unsigned DEFAULT NULL,
  `orig_size` int(10) unsigned DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_ewwwio_images`
--
LOCK TABLES `wp_ewwwio_images` WRITE;
INSERT INTO `wp_ewwwio_images` VALUES ('1', 'C:xampphtdocsasug/wp-content/uploads/2014/03/asug-brasil-150x76.jpg', '', 'No savings', '', '5539', '5539'); 
INSERT INTO `wp_ewwwio_images` VALUES ('2', 'C:xampphtdocsasug/wp-content/uploads/2014/03/asug-brasil.jpg', '', 'No savings', '', '7992', '7992'); 
INSERT INTO `wp_ewwwio_images` VALUES ('3', 'C:xampphtdocsasug/wp-content/uploads/2014/03/slider-150x150.jpg', '', 'No savings', '', '8444', '8444'); 
INSERT INTO `wp_ewwwio_images` VALUES ('4', 'C:xampphtdocsasug/wp-content/uploads/2014/03/slider-300x138.jpg', '', 'No savings', '', '14952', '14952'); 
INSERT INTO `wp_ewwwio_images` VALUES ('5', 'C:xampphtdocsasug/wp-content/uploads/2014/03/slider.jpg', '', 'No savings', '', '43712', '43712'); 
INSERT INTO `wp_ewwwio_images` VALUES ('6', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner03-150x121.jpg', '', 'No savings', '', '6771', '6771'); 
INSERT INTO `wp_ewwwio_images` VALUES ('7', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner03.jpg', '', 'No savings', '', '28264', '28264'); 
INSERT INTO `wp_ewwwio_images` VALUES ('8', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner04-150x121.jpg', '', 'No savings', '', '9955', '9955'); 
INSERT INTO `wp_ewwwio_images` VALUES ('9', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner04.jpg', '', 'No savings', '', '37298', '37298'); 
INSERT INTO `wp_ewwwio_images` VALUES ('10', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner01-150x122.jpg', '', 'No savings', '', '8160', '8160'); 
INSERT INTO `wp_ewwwio_images` VALUES ('11', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner01.jpg', '', 'No savings', '', '30840', '30840'); 
INSERT INTO `wp_ewwwio_images` VALUES ('12', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner02-150x122.jpg', '', 'No savings', '', '9855', '9855'); 
INSERT INTO `wp_ewwwio_images` VALUES ('13', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner02.jpg', '', 'No savings', '', '37694', '37694'); 
INSERT INTO `wp_ewwwio_images` VALUES ('14', 'C:xampphtdocsasug/wp-content/uploads/2014/03/eventos01.jpg', '', 'No savings', '', '7911', '7911'); 
INSERT INTO `wp_ewwwio_images` VALUES ('15', 'C:xampphtdocsasug/wp-content/uploads/2014/03/eventos02.jpg', '', 'No savings', '', '8019', '8019'); 
INSERT INTO `wp_ewwwio_images` VALUES ('16', 'C:xampphtdocsasug/wp-content/uploads/2014/03/eventos011.jpg', '', 'No savings', '', '7911', '7911'); 
INSERT INTO `wp_ewwwio_images` VALUES ('17', 'C:xampphtdocsasug/wp-content/uploads/2014/03/eventos021.jpg', '', 'No savings', '', '8019', '8019'); 
INSERT INTO `wp_ewwwio_images` VALUES ('18', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner-150x150.jpg', '', 'No savings', '', '8455', '8455'); 
INSERT INTO `wp_ewwwio_images` VALUES ('19', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner-300x73.jpg', '', 'No savings', '', '9936', '9936'); 
INSERT INTO `wp_ewwwio_images` VALUES ('20', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner-90x90.jpg', '', 'No savings', '', '3557', '3557'); 
INSERT INTO `wp_ewwwio_images` VALUES ('21', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner-300x248.jpg', '', 'No savings', '', '30758', '30758'); 
INSERT INTO `wp_ewwwio_images` VALUES ('22', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner-624x151.jpg', '', 'No savings', '', '34087', '34087'); 
INSERT INTO `wp_ewwwio_images` VALUES ('23', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner.jpg', '', 'No savings', '', '234001', '234001'); 
INSERT INTO `wp_ewwwio_images` VALUES ('24', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner_comite-150x150.jpg', '', 'No savings', '', '5446', '5446'); 
INSERT INTO `wp_ewwwio_images` VALUES ('25', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner_comite-300x73.jpg', '', 'No savings', '', '7998', '7998'); 
INSERT INTO `wp_ewwwio_images` VALUES ('26', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner_comite-90x90.jpg', '', 'No savings', '', '2705', '2705'); 
INSERT INTO `wp_ewwwio_images` VALUES ('27', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner_comite-300x248.jpg', '', 'No savings', '', '16411', '16411'); 
INSERT INTO `wp_ewwwio_images` VALUES ('28', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner_comite-624x151.jpg', '', 'No savings', '', '23769', '23769'); 
INSERT INTO `wp_ewwwio_images` VALUES ('29', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner_comite.jpg', '', 'No savings', '', '134225', '134225'); 
INSERT INTO `wp_ewwwio_images` VALUES ('30', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner1-150x150.jpg', '', 'No savings', '', '8455', '8455'); 
INSERT INTO `wp_ewwwio_images` VALUES ('31', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner1-300x73.jpg', '', 'No savings', '', '9936', '9936'); 
INSERT INTO `wp_ewwwio_images` VALUES ('32', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner1-90x90.jpg', '', 'No savings', '', '3557', '3557'); 
INSERT INTO `wp_ewwwio_images` VALUES ('33', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner1-300x248.jpg', '', 'No savings', '', '30758', '30758'); 
INSERT INTO `wp_ewwwio_images` VALUES ('34', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner1-624x151.jpg', '', 'No savings', '', '34087', '34087'); 
INSERT INTO `wp_ewwwio_images` VALUES ('35', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner1.jpg', '', 'No savings', '', '234001', '234001'); 
INSERT INTO `wp_ewwwio_images` VALUES ('36', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner1-96x96.jpg', '', 'No savings', '', '3689', '3689'); 
INSERT INTO `wp_ewwwio_images` VALUES ('37', 'C:xampphtdocsasug/wp-content/uploads/2014/03/banner1-32x32.jpg', '', 'No savings', '', '1028', '1028'); 
INSERT INTO `wp_ewwwio_images` VALUES ('38', 'C:xampphtdocsasug/wp-content/uploads/2014/03/capa-revista-hsm-management-01-150x150.jpg', '', 'No savings', '', '9910', '9910'); 
INSERT INTO `wp_ewwwio_images` VALUES ('39', 'C:xampphtdocsasug/wp-content/uploads/2014/03/capa-revista-hsm-management-01-226x300.jpg', '', 'No savings', '', '25956', '25956'); 
INSERT INTO `wp_ewwwio_images` VALUES ('40', 'C:xampphtdocsasug/wp-content/uploads/2014/03/capa-revista-hsm-management-01.jpg', '', 'No savings', '', '48801', '48801'); 
INSERT INTO `wp_ewwwio_images` VALUES ('41', 'C:xampphtdocsasug/wp-content/uploads/2014/04/capa-revista-gloss-150x150.jpg', '', 'No savings', '', '13992', '13992'); 
INSERT INTO `wp_ewwwio_images` VALUES ('42', 'C:xampphtdocsasug/wp-content/uploads/2014/04/capa-revista-gloss-229x300.jpg', '', 'No savings', '', '36036', '36036'); 
INSERT INTO `wp_ewwwio_images` VALUES ('43', 'C:xampphtdocsasug/wp-content/uploads/2014/04/capa-revista-gloss.jpg', '', 'No savings', '', '92196', '92196'); 
INSERT INTO `wp_ewwwio_images` VALUES ('44', 'C:xampphtdocsasug/wp-content/uploads/2014/03/revista-150x150.jpg', '', 'No savings', '', '7958', '7958'); 
INSERT INTO `wp_ewwwio_images` VALUES ('45', 'C:xampphtdocsasug/wp-content/uploads/2014/03/revista-300x73.jpg', '', 'No savings', '', '9728', '9728'); 
INSERT INTO `wp_ewwwio_images` VALUES ('46', 'C:xampphtdocsasug/wp-content/uploads/2014/03/revista-624x151.jpg', '', 'No savings', '', '31424', '31424'); 
INSERT INTO `wp_ewwwio_images` VALUES ('47', 'C:xampphtdocsasug/wp-content/uploads/2014/03/revista.jpg', '', 'No savings', '', '237535', '237535'); 
INSERT INTO `wp_ewwwio_images` VALUES ('48', 'C:xampphtdocsasug/wp-content/uploads/2014/04/asug_recibo_cabecalho-150x71.jpg', '', 'No savings', '', '1387', '1387'); 
INSERT INTO `wp_ewwwio_images` VALUES ('49', 'C:xampphtdocsasug/wp-content/uploads/2014/04/asug_recibo_cabecalho-300x20.jpg', '', 'No savings', '', '2637', '2637'); 
INSERT INTO `wp_ewwwio_images` VALUES ('50', 'C:xampphtdocsasug/wp-content/uploads/2014/04/asug_recibo_cabecalho-624x43.jpg', '', 'No savings', '', '6458', '6458'); 
INSERT INTO `wp_ewwwio_images` VALUES ('51', 'C:xampphtdocsasug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg', '', 'No savings', '', '12942', '12942'); 
INSERT INTO `wp_ewwwio_images` VALUES ('52', 'C:xampphtdocsasug/wp-content/uploads/2014/04/asug_recibo_rodape-150x38.jpg', '', 'No savings', '', '1332', '1332'); 
INSERT INTO `wp_ewwwio_images` VALUES ('53', 'C:xampphtdocsasug/wp-content/uploads/2014/04/asug_recibo_rodape-300x11.jpg', '', 'No savings', '', '2021', '2021'); 
INSERT INTO `wp_ewwwio_images` VALUES ('54', 'C:xampphtdocsasug/wp-content/uploads/2014/04/asug_recibo_rodape-624x23.jpg', '', 'No savings', '', '4184', '4184'); 
INSERT INTO `wp_ewwwio_images` VALUES ('55', 'C:xampphtdocsasug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg', '', 'No savings', '', '7190', '7190'); 
INSERT INTO `wp_ewwwio_images` VALUES ('56', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/03/copy-asug-brasil-150x76.jpg', '', 'No savings', '', '5539', '5539'); 
INSERT INTO `wp_ewwwio_images` VALUES ('57', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/03/copy-asug-brasil.jpg', '', 'No savings', '', '7992', '7992'); 
INSERT INTO `wp_ewwwio_images` VALUES ('58', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/Technology-news1-150x150.jpg', '', 'No savings', '', '6809', '6809'); 
INSERT INTO `wp_ewwwio_images` VALUES ('59', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/Technology-news1-300x252.jpg', '', 'No savings', '', '14859', '14859'); 
INSERT INTO `wp_ewwwio_images` VALUES ('60', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/Technology-news1-624x525.jpg', '', 'No savings', '', '40840', '40840'); 
INSERT INTO `wp_ewwwio_images` VALUES ('61', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/Technology-news1.jpg', '', 'No savings', '', '474216', '474216'); 
INSERT INTO `wp_ewwwio_images` VALUES ('62', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/circuit-Sqr1-150x150.jpg', '', 'No savings', '', '11594', '11594'); 
INSERT INTO `wp_ewwwio_images` VALUES ('63', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/circuit-Sqr1-300x199.jpg', '', 'No savings', '', '25850', '25850'); 
INSERT INTO `wp_ewwwio_images` VALUES ('64', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/circuit-Sqr1-1024x682.jpg', '', 'No savings', '', '170092', '170092'); 
INSERT INTO `wp_ewwwio_images` VALUES ('65', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/circuit-Sqr1-624x415.jpg', '', 'No savings', '', '80310', '80310'); 
INSERT INTO `wp_ewwwio_images` VALUES ('66', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/circuit-Sqr1.jpg', '', 'No savings', '', '2085243', '2085243'); 
INSERT INTO `wp_ewwwio_images` VALUES ('67', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/technology-hand1-150x150.jpg', '', 'No savings', '', '7380', '7380'); 
INSERT INTO `wp_ewwwio_images` VALUES ('68', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/technology-hand1-300x199.jpg', '', 'No savings', '', '14578', '14578'); 
INSERT INTO `wp_ewwwio_images` VALUES ('69', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/technology-hand1-1024x682.jpg', '', 'No savings', '', '105408', '105408'); 
INSERT INTO `wp_ewwwio_images` VALUES ('70', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/technology-hand1-624x415.jpg', '', 'No savings', '', '47405', '47405'); 
INSERT INTO `wp_ewwwio_images` VALUES ('71', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/technology-hand1.jpg', '', 'No savings', '', '256385', '256385'); 
INSERT INTO `wp_ewwwio_images` VALUES ('72', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/cpuaroundworld_alpha1-150x150.png', '', 'No savings', '', '22176', '22176'); 
INSERT INTO `wp_ewwwio_images` VALUES ('73', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/cpuaroundworld_alpha1-300x225.png', '', 'No savings', '', '49283', '49283'); 
INSERT INTO `wp_ewwwio_images` VALUES ('74', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/cpuaroundworld_alpha1-1024x768.png', '', 'No savings', '', '387476', '387476'); 
INSERT INTO `wp_ewwwio_images` VALUES ('75', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/cpuaroundworld_alpha1-624x468.png', '', 'No savings', '', '166685', '166685'); 
INSERT INTO `wp_ewwwio_images` VALUES ('76', 'C:\xampp\htdocs\asug/wp-content/uploads/2014/04/cpuaroundworld_alpha1.png', '', 'No savings', '', '842053', '842053'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_itsec_lockouts`
--
DROP TABLE IF EXISTS `wp_itsec_lockouts`;
CREATE TABLE `wp_itsec_lockouts` (
  `lockout_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lockout_type` varchar(20) NOT NULL,
  `lockout_start` datetime NOT NULL,
  `lockout_start_gmt` datetime NOT NULL,
  `lockout_expire` datetime NOT NULL,
  `lockout_expire_gmt` datetime NOT NULL,
  `lockout_host` varchar(20) DEFAULT NULL,
  `lockout_user` bigint(20) unsigned DEFAULT NULL,
  `lockout_active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`lockout_id`),
  KEY `lockout_expire_gmt` (`lockout_expire_gmt`),
  KEY `lockout_host` (`lockout_host`),
  KEY `lockout_user` (`lockout_user`),
  KEY `lockout_active` (`lockout_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_itsec_lockouts`
--
LOCK TABLES `wp_itsec_lockouts` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_itsec_log`
--
DROP TABLE IF EXISTS `wp_itsec_log`;
CREATE TABLE `wp_itsec_log` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` varchar(20) NOT NULL DEFAULT '',
  `log_function` varchar(255) NOT NULL DEFAULT '',
  `log_priority` int(2) NOT NULL DEFAULT '1',
  `log_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `log_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `log_host` varchar(20) DEFAULT NULL,
  `log_username` varchar(20) DEFAULT NULL,
  `log_user` bigint(20) unsigned DEFAULT NULL,
  `log_url` varchar(255) DEFAULT NULL,
  `log_referrer` varchar(255) DEFAULT NULL,
  `log_data` longtext NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_type` (`log_type`),
  KEY `log_date_gmt` (`log_date_gmt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_itsec_log`
--
LOCK TABLES `wp_itsec_log` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_itsec_temp`
--
DROP TABLE IF EXISTS `wp_itsec_temp`;
CREATE TABLE `wp_itsec_temp` (
  `temp_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `temp_type` varchar(20) NOT NULL,
  `temp_date` datetime NOT NULL,
  `temp_date_gmt` datetime NOT NULL,
  `temp_host` varchar(20) DEFAULT NULL,
  `temp_user` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`temp_id`),
  KEY `temp_date_gmt` (`temp_date_gmt`),
  KEY `temp_host` (`temp_host`),
  KEY `temp_user` (`temp_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_itsec_temp`
--
LOCK TABLES `wp_itsec_temp` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_links`
--
DROP TABLE IF EXISTS `wp_links`;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_name` varchar(255) NOT NULL DEFAULT '',
  `link_image` varchar(255) NOT NULL DEFAULT '',
  `link_target` varchar(25) NOT NULL DEFAULT '',
  `link_description` varchar(255) NOT NULL DEFAULT '',
  `link_visible` varchar(20) NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) NOT NULL DEFAULT '',
  `link_notes` mediumtext NOT NULL,
  `link_rss` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_links`
--
LOCK TABLES `wp_links` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_communications`
--
DROP TABLE IF EXISTS `wp_m_communications`;
CREATE TABLE `wp_m_communications` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(250) DEFAULT NULL,
  `message` text,
  `periodunit` int(11) DEFAULT NULL,
  `periodtype` varchar(5) DEFAULT NULL,
  `periodprepost` varchar(5) DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `active` int(11) DEFAULT '0',
  `periodstamp` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_communications`
--
LOCK TABLES `wp_m_communications` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_coupons`
--
DROP TABLE IF EXISTS `wp_m_coupons`;
CREATE TABLE `wp_m_coupons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) DEFAULT '0',
  `couponcode` varchar(250) DEFAULT NULL,
  `discount` decimal(11,2) DEFAULT '0.00',
  `discount_type` varchar(5) DEFAULT NULL,
  `discount_currency` varchar(5) DEFAULT NULL,
  `coupon_startdate` datetime DEFAULT NULL,
  `coupon_enddate` datetime DEFAULT NULL,
  `coupon_sub_id` bigint(20) DEFAULT '0',
  `coupon_uses` int(11) DEFAULT '0',
  `coupon_used` int(11) DEFAULT '0',
  `coupon_apply_to` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `couponcode` (`couponcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_coupons`
--
LOCK TABLES `wp_m_coupons` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_levelmeta`
--
DROP TABLE IF EXISTS `wp_m_levelmeta`;
CREATE TABLE `wp_m_levelmeta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `level_id` bigint(20) DEFAULT NULL,
  `meta_key` varchar(250) DEFAULT NULL,
  `meta_value` text,
  `meta_stamp` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `level_id` (`level_id`,`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_levelmeta`
--
LOCK TABLES `wp_m_levelmeta` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_member_payments`
--
DROP TABLE IF EXISTS `wp_m_member_payments`;
CREATE TABLE `wp_m_member_payments` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `sub_id` bigint(20) DEFAULT NULL,
  `level_id` bigint(20) DEFAULT NULL,
  `level_order` int(11) DEFAULT NULL,
  `paymentmade` datetime DEFAULT NULL,
  `paymentexpires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_member_payments`
--
LOCK TABLES `wp_m_member_payments` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_membership_levels`
--
DROP TABLE IF EXISTS `wp_m_membership_levels`;
CREATE TABLE `wp_m_membership_levels` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `level_title` varchar(250) DEFAULT NULL,
  `level_slug` varchar(250) DEFAULT NULL,
  `level_active` int(11) DEFAULT '0',
  `level_count` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_membership_levels`
--
LOCK TABLES `wp_m_membership_levels` WRITE;
INSERT INTO `wp_m_membership_levels` VALUES ('1', 'assinantes', 'assinantes', '1', '0'); 
INSERT INTO `wp_m_membership_levels` VALUES ('2', 'Visitors', 'visitors', '1', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_m_membership_news`
--
DROP TABLE IF EXISTS `wp_m_membership_news`;
CREATE TABLE `wp_m_membership_news` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `newsitem` text,
  `newsdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_membership_news`
--
LOCK TABLES `wp_m_membership_news` WRITE;
INSERT INTO `wp_m_membership_news` VALUES ('1', '<strong>pita</strong> has joined level <strong>assinantes</strong> on subscription <strong>assinantes</strong>', '2014-03-20 02:31:41'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_m_membership_relationships`
--
DROP TABLE IF EXISTS `wp_m_membership_relationships`;
CREATE TABLE `wp_m_membership_relationships` (
  `rel_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0',
  `sub_id` bigint(20) DEFAULT '0',
  `level_id` bigint(20) DEFAULT '0',
  `startdate` datetime DEFAULT NULL,
  `updateddate` datetime DEFAULT NULL,
  `expirydate` datetime DEFAULT NULL,
  `order_instance` bigint(20) DEFAULT '0',
  `usinggateway` varchar(50) DEFAULT 'admin',
  PRIMARY KEY (`rel_id`),
  KEY `user_id` (`user_id`),
  KEY `sub_id` (`sub_id`),
  KEY `usinggateway` (`usinggateway`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_membership_relationships`
--
LOCK TABLES `wp_m_membership_relationships` WRITE;
INSERT INTO `wp_m_membership_relationships` VALUES ('1', '2', '1', '1', '2014-03-20 02:31:41', '2014-03-20 02:31:41', '2015-03-20 02:31:41', '1', 'admin'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_m_membership_rules`
--
DROP TABLE IF EXISTS `wp_m_membership_rules`;
CREATE TABLE `wp_m_membership_rules` (
  `level_id` bigint(20) NOT NULL DEFAULT '0',
  `rule_ive` varchar(20) NOT NULL DEFAULT '',
  `rule_area` varchar(20) NOT NULL DEFAULT '',
  `rule_value` text,
  `rule_order` int(11) DEFAULT '0',
  PRIMARY KEY (`level_id`,`rule_ive`,`rule_area`),
  KEY `rule_area` (`rule_area`),
  KEY `rule_ive` (`rule_ive`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_membership_rules`
--
LOCK TABLES `wp_m_membership_rules` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_ping_history`
--
DROP TABLE IF EXISTS `wp_m_ping_history`;
CREATE TABLE `wp_m_ping_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ping_id` bigint(20) DEFAULT NULL,
  `ping_sent` timestamp NULL DEFAULT NULL,
  `ping_info` text,
  `ping_return` text,
  PRIMARY KEY (`id`),
  KEY `ping_id` (`ping_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_ping_history`
--
LOCK TABLES `wp_m_ping_history` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_pings`
--
DROP TABLE IF EXISTS `wp_m_pings`;
CREATE TABLE `wp_m_pings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pingname` varchar(250) DEFAULT NULL,
  `pingurl` varchar(250) DEFAULT NULL,
  `pinginfo` text,
  `pingtype` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_pings`
--
LOCK TABLES `wp_m_pings` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_subscription_transaction`
--
DROP TABLE IF EXISTS `wp_m_subscription_transaction`;
CREATE TABLE `wp_m_subscription_transaction` (
  `transaction_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_subscription_ID` bigint(20) NOT NULL DEFAULT '0',
  `transaction_user_ID` bigint(20) NOT NULL DEFAULT '0',
  `transaction_sub_ID` bigint(20) DEFAULT '0',
  `transaction_paypal_ID` varchar(30) DEFAULT NULL,
  `transaction_payment_type` varchar(20) DEFAULT NULL,
  `transaction_stamp` bigint(35) NOT NULL DEFAULT '0',
  `transaction_total_amount` bigint(20) DEFAULT NULL,
  `transaction_currency` varchar(35) DEFAULT NULL,
  `transaction_status` varchar(35) DEFAULT NULL,
  `transaction_duedate` date DEFAULT NULL,
  `transaction_gateway` varchar(50) DEFAULT NULL,
  `transaction_note` text,
  `transaction_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`transaction_ID`),
  KEY `transaction_gateway` (`transaction_gateway`),
  KEY `transaction_subscription_ID` (`transaction_subscription_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_subscription_transaction`
--
LOCK TABLES `wp_m_subscription_transaction` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_m_subscriptionmeta`
--
DROP TABLE IF EXISTS `wp_m_subscriptionmeta`;
CREATE TABLE `wp_m_subscriptionmeta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub_id` bigint(20) DEFAULT NULL,
  `meta_key` varchar(250) DEFAULT NULL,
  `meta_value` text,
  `meta_stamp` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_id` (`sub_id`,`meta_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_subscriptionmeta`
--
LOCK TABLES `wp_m_subscriptionmeta` WRITE;
INSERT INTO `wp_m_subscriptionmeta` VALUES ('1', '1', 'joining_ping', '', '0000-00-00 00:00:00'); 
INSERT INTO `wp_m_subscriptionmeta` VALUES ('2', '1', 'leaving_ping', '', '0000-00-00 00:00:00'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_m_subscriptions`
--
DROP TABLE IF EXISTS `wp_m_subscriptions`;
CREATE TABLE `wp_m_subscriptions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub_name` varchar(200) DEFAULT NULL,
  `sub_active` int(11) DEFAULT '0',
  `sub_public` int(11) DEFAULT '0',
  `sub_count` bigint(20) DEFAULT '0',
  `sub_description` text,
  `sub_pricetext` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_subscriptions`
--
LOCK TABLES `wp_m_subscriptions` WRITE;
INSERT INTO `wp_m_subscriptions` VALUES ('1', 'assinantes', '1', '1', '0', '', ''); 

UNLOCK TABLES;
--
-- Table structure for table `wp_m_subscriptions_levels`
--
DROP TABLE IF EXISTS `wp_m_subscriptions_levels`;
CREATE TABLE `wp_m_subscriptions_levels` (
  `sub_id` bigint(20) DEFAULT NULL,
  `level_id` bigint(20) DEFAULT NULL,
  `level_period` int(11) DEFAULT NULL,
  `sub_type` varchar(20) DEFAULT NULL,
  `level_price` decimal(11,2) DEFAULT '0.00',
  `level_currency` varchar(5) DEFAULT NULL,
  `level_order` bigint(20) DEFAULT '0',
  `level_period_unit` varchar(1) DEFAULT 'd',
  KEY `sub_id` (`sub_id`),
  KEY `level_id` (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_subscriptions_levels`
--
LOCK TABLES `wp_m_subscriptions_levels` WRITE;
INSERT INTO `wp_m_subscriptions_levels` VALUES ('1', '1', '1', 'finite', '1800.00', '', '1', 'y'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_m_urlgroups`
--
DROP TABLE IF EXISTS `wp_m_urlgroups`;
CREATE TABLE `wp_m_urlgroups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(250) DEFAULT NULL,
  `groupurls` text,
  `isregexp` int(11) DEFAULT '0',
  `stripquerystring` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_m_urlgroups`
--
LOCK TABLES `wp_m_urlgroups` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_nextend_smartslider_layouts`
--
DROP TABLE IF EXISTS `wp_nextend_smartslider_layouts`;
CREATE TABLE `wp_nextend_smartslider_layouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `slide` longtext,
  `params` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_nextend_smartslider_layouts`
--
LOCK TABLES `wp_nextend_smartslider_layouts` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_nextend_smartslider_sliders`
--
DROP TABLE IF EXISTS `wp_nextend_smartslider_sliders`;
CREATE TABLE `wp_nextend_smartslider_sliders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `type` varchar(30) NOT NULL,
  `params` text NOT NULL,
  `generator` text NOT NULL,
  `slide` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_nextend_smartslider_sliders`
--
LOCK TABLES `wp_nextend_smartslider_sliders` WRITE;
INSERT INTO `wp_nextend_smartslider_sliders` VALUES ('2', 'Slide Home', 'simple', '{"size":"542|*|250|*|1","responsive":"1|*|0","globalfontsize":"12|*|16|*|20","margin":"0|*|0|*|0|*|0|*|px","simplebackgroundimage":"","simplebackgroundimagesize":"auto","simplepadding":"0|*|0|*|0|*|0","simpleborder":"0|*|3E3E3Eff","simpleborderradius":"0|*|0|*|0|*|0","simpleresponsivemaxwidth":"3000","improvedtouch":"horizontal","simpleskins":"","simpleslidercss":"","simpleanimation":"horizontal","simpleanimationproperties":"800|*|0|*|easeInOutQuad|*|1","simplebackgroundanimation":"0|*|bars||blocks","fadeonload":"1|*|0","playfirstlayer":"0","mainafterout":"0","inaftermain":"1","controls":"0|*|horizontal|*|0","blockrightclick":"0","imageload":"0|*|0","backgroundresize":"cover","randomize":"0","autoplay":"1|*|8000","autoplayfinish":"0|*|loop|*|current","stopautoplay":"1|*|1|*|1","resumeautoplay":"0|*|1|*|0","widgetarrow":"transition","widgetarrowdisplay":"1|*|always|*|0|*|0","previousposition":"left|*|0|*|%|*|top|*|height/2-previousheight/2|*|%","previous":"/plugins/smart-slider-2/plugins/nextendsliderwidgetarrow/transition/transition/previous/my-test.png","nextposition":"right|*|0|*|%|*|top|*|height/2-nextheight/2|*|%","next":"/plugins/smart-slider-2/plugins/nextendsliderwidgetarrow/transition/transition/next/my-test.png","arrowbackground":"00000080","arrowbackgroundhover":"7670c7ff","widgetbullet":"numbers","widgetbulletdisplay":"1|*|always|*|0|*|0","bulletposition":"left|*|0|*|%|*|bottom|*|5|*|%","bulletwidth":"100%","bulletorientation":"horizontal","bulletalign":"center","bullet":"/plugins/smart-slider-2/plugins/nextendsliderwidgetbullet/numbers/numbers/bullets/square.png","bulletbackground":"00000060","bulletbackgroundhover":"7670C7ff","fontclassnumber":"sliderfont7","bulletbar":"none","bulletshadow":"none","bulletbarcolor":"00000060","bullethumbnail":"0|*|top","thumbnailsizebullet":"100|*|60","bulletthumbnail":"00000060","widgets":"arrow"}', '{"enabled":"1","cachetime":"1","generateslides":"1000|*|1|*|1","generatorgroup":"1","images":"{"0":{"image":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","title":"slider","url":"","description":""},"1":{"image":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","title":"slider","url":"","description":""},"2":{"image":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","title":"slider","url":"","description":""}}","source":"imagefromfolder_quickimage"}', '{"title":"{|title-1|}","description":"{|description-1|}","published":"1","publishdates":"|*|","thumbnail":"{|thumbnail-1|}","background":"00000000|*|{|image-1|}","link":"{|url-1|}|*|_self","slide":"","adminmode":"all"}'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_nextend_smartslider_slides`
--
DROP TABLE IF EXISTS `wp_nextend_smartslider_slides`;
CREATE TABLE `wp_nextend_smartslider_slides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `slider` int(11) NOT NULL,
  `publish_up` datetime NOT NULL,
  `publish_down` datetime NOT NULL,
  `published` tinyint(1) NOT NULL,
  `first` int(11) NOT NULL,
  `slide` longtext,
  `description` text NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `background` varchar(300) NOT NULL,
  `params` text NOT NULL,
  `ordering` int(11) NOT NULL,
  `generator` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_nextend_smartslider_slides`
--
LOCK TABLES `wp_nextend_smartslider_slides` WRITE;
INSERT INTO `wp_nextend_smartslider_slides` VALUES ('2', 'slider', '2', '2014-03-15 04:49:58', '2024-03-16 04:49:58', '1', '0', '', '', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '00000000|*|http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '{"slider":2,"publish_up":"0000-00-00 00:00:00","publish_down":"0000-00-00 00:00:00","params":"{"link":"#|*|_self","adminmode":"all"}","ordering":0,"link":"#|*|_self","adminmode":"all"}', '1', '0'); 
INSERT INTO `wp_nextend_smartslider_slides` VALUES ('3', 'slider', '2', '2014-03-15 04:49:58', '2024-03-16 04:49:58', '1', '0', '', '', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '00000000|*|http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '{"slider":2,"publish_up":"0000-00-00 00:00:00","publish_down":"0000-00-00 00:00:00","params":"{"link":"#|*|_self","adminmode":"all"}","ordering":1,"link":"#|*|_self","adminmode":"all"}', '2', '0'); 
INSERT INTO `wp_nextend_smartslider_slides` VALUES ('4', 'slider', '2', '2014-03-15 04:49:58', '2024-03-16 04:49:58', '1', '0', '', '', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '00000000|*|http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '{"slider":2,"publish_up":"0000-00-00 00:00:00","publish_down":"0000-00-00 00:00:00","params":"{"link":"#|*|_self","adminmode":"all"}","ordering":2,"link":"#|*|_self","adminmode":"all"}', '3', '0'); 
INSERT INTO `wp_nextend_smartslider_slides` VALUES ('5', 'slider', '2', '2014-03-15 04:50:28', '2024-03-16 04:50:28', '1', '0', '', '', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '00000000|*|http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '{"slider":2,"publish_up":"0000-00-00 00:00:00","publish_down":"0000-00-00 00:00:00","params":"{"link":"#|*|_self","adminmode":"desktop"}","ordering":0,"link":"#|*|_self","adminmode":"desktop"}', '4', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_nextend_smartslider_storage`
--
DROP TABLE IF EXISTS `wp_nextend_smartslider_storage`;
CREATE TABLE `wp_nextend_smartslider_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(200) NOT NULL,
  `value` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_nextend_smartslider_storage`
--
LOCK TABLES `wp_nextend_smartslider_storage` WRITE;
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('1', 'layout', '{"size":"1024|*|768"}'); 
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('2', 'settings', '{"debugmessages":"1","slideeditoralert":"1","translateurl":"|*|","externalcssfile":"","jquery":"1","translate3d":"1","placeholder":"http://www.nextendweb.com/static/placeholder.png","resizeremote":"0","responsivebasedon":"combined","responsivescreenwidth":"480|*|480","slideeditorratios":"1.0|*|1.0|*|0.7|*|0.5","generatordesignermode":"1","tidy-input-encoding":"utf8","tidy-output-encoding":"utf8"}'); 
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('3', 'font', '{"sliderfont1customlabel":"Heading light","sliderfont1":"{"firsttab":"Text","Text":{"color":"ffffffff","size":"320||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.3","bold":1,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"paddingleft":0,"size":"100||%"},"Link:Hover":{"paddingleft":0,"size":"100||%"}}","sliderfont2customlabel":"Heading dark","sliderfont2":"{"firsttab":"Text","Text":{"color":"000000db","size":"320||%","tshadow":"0|*|1|*|0|*|ffffff33","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.3","bold":1,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont3customlabel":"Subheading light","sliderfont3":"{"firsttab":"Text","Text":{"color":"ffffffff","size":"170||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.2","bold":0,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont4customlabel":"Subheading dark","sliderfont4":"{"firsttab":"Text","Text":{"color":"000000db","size":"170||%","tshadow":"0|*|1|*|0|*|ffffff33","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.2","bold":0,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont5customlabel":"Paragraph light","sliderfont5":"{"firsttab":"Text","Text":{"color":"ffffffff","size":"114||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.4","bold":0,"italic":0,"underline":0,"align":"justify","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont6customlabel":"Paragraph dark","sliderfont6":"{"firsttab":"Text","Text":{"color":"000000db","size":"114||%","tshadow":"0|*|1|*|0|*|ffffff33","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.4","bold":0,"italic":0,"underline":0,"align":"justify","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont7customlabel":"Small text light","sliderfont7":"{"firsttab":"Text","Text":{"color":"ffffffff","size":"90||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.2","bold":0,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont8customlabel":"Small text dark","sliderfont8":"{"firsttab":"Text","Text":{"color":"000000db","size":"90||%","tshadow":"0|*|1|*|0|*|ffffff33","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.1","bold":0,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont9customlabel":"Handwritten light","sliderfont9":"{"firsttab":"Text","Text":{"color":"ffffffff","size":"140||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Pacifico);),Arial","lineheight":"1.3","bold":0,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont10customlabel":"Handwritten dark","sliderfont10":"{"firsttab":"Text","Text":{"color":"000000db","size":"140||%","tshadow":"0|*|1|*|0|*|ffffff33","afont":"google(@import url(http://fonts.googleapis.com/css?family=Pacifico);),Arial","lineheight":"1.3","bold":0,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont11customlabel":"Button light","sliderfont11":"{"firsttab":"Text","Text":{"color":"ffffffff","size":"100||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.3","bold":0,"italic":0,"underline":0,"align":"center","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfont12customlabel":"Button dark","sliderfont12":"{"firsttab":"Text","Text":{"color":"000000db","size":"100||%","tshadow":"0|*|1|*|0|*|ffffff33","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.3","bold":0,"italic":0,"underline":0,"align":"center","paddingleft":0},"Link":{"paddingleft":0,"size":"100||%"},"Link:Hover":{"paddingleft":0,"size":"100||%"}}","sliderfontcustom1customlabel":"My first custom font","sliderfontcustom1":"{"firsttab":"Text","Text":{"color":"1abc9cff","size":"360||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Pacifico);),Arial","lineheight":"1.3","bold":0,"italic":0,"underline":0,"align":"left","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfontcustom2customlabel":"My second custom font","sliderfontcustom2":"{"firsttab":"Text","Text":{"color":"ffffffff","size":"140||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.2","bold":0,"italic":0,"underline":0,"align":"center","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfontcustom3customlabel":"My third custom font","sliderfontcustom3":"{"firsttab":"Text","Text":{"color":"1abc9cff","size":"120||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.2","bold":0,"italic":0,"underline":0,"align":"center","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}","sliderfontcustom4customlabel":"My fourthcustom font ","sliderfontcustom4":"{"firsttab":"Text","Text":{"color":"1abc9cff","size":"120||%","tshadow":"0|*|1|*|1|*|000000c7","afont":"google(@import url(http://fonts.googleapis.com/css?family=Open Sans);),Arial","lineheight":"1.2","bold":0,"italic":0,"underline":0,"align":"right","paddingleft":0},"Link":{"size":"100||%","paddingleft":0},"Link:Hover":{"size":"100||%","paddingleft":0}}"}'); 
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('4', 'sliderchanged1', '1'); 
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('5', 'sliderchanged2', '0'); 
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('6', 'font2', '{"sliderfont1customlabel":"Heading light","sliderfont1":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMzIwfHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MXwqfDAwMDAwMGM3IiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjoxLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InBhZGRpbmdsZWZ0IjowLCJzaXplIjoiMTAwfHwlIn0sIkxpbms6SG92ZXIiOnsicGFkZGluZ2xlZnQiOjAsInNpemUiOiIxMDB8fCUifX0=","sliderfont2customlabel":"Heading dark","sliderfont2":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiMDAwMDAwZGIiLCJzaXplIjoiMzIwfHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MHwqfGZmZmZmZjMzIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjoxLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfont3customlabel":"Subheading light","sliderfont3":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMTcwfHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MXwqfDAwMDAwMGM3IiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjIiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfont4customlabel":"Subheading dark","sliderfont4":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiMDAwMDAwZGIiLCJzaXplIjoiMTcwfHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MHwqfGZmZmZmZjMzIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjIiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfont5customlabel":"Paragraph light","sliderfont5":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMTE0fHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MXwqfDAwMDAwMGM3IiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjQiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJqdXN0aWZ5IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfont6customlabel":"Paragraph dark","sliderfont6":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiMDAwMDAwZGIiLCJzaXplIjoiMTE0fHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MHwqfGZmZmZmZjMzIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjQiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJqdXN0aWZ5IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfont7customlabel":"Small text light","sliderfont7":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiOTB8fCUiLCJ0c2hhZG93IjoiMHwqfDF8KnwxfCp8MDAwMDAwYzciLCJhZm9udCI6Imdvb2dsZShAaW1wb3J0IHVybChodHRwOi8vZm9udHMuZ29vZ2xlYXBpcy5jb20vY3NzP2ZhbWlseT1Nb250c2VycmF0KTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuMiIsImJvbGQiOjAsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6ImxlZnQiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfSwiTGluazpIb3ZlciI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfont8customlabel":"Small text dark","sliderfont8":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiMDAwMDAwZGIiLCJzaXplIjoiOTB8fCUiLCJ0c2hhZG93IjoiMHwqfDF8KnwwfCp8ZmZmZmZmMzMiLCJhZm9udCI6Imdvb2dsZShAaW1wb3J0IHVybChodHRwOi8vZm9udHMuZ29vZ2xlYXBpcy5jb20vY3NzP2ZhbWlseT1Nb250c2VycmF0KTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuMSIsImJvbGQiOjAsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6ImxlZnQiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfSwiTGluazpIb3ZlciI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfont9customlabel":"Handwritten light","sliderfont9":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMTQwfHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MXwqfDAwMDAwMGM3IiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9UGFjaWZpY28pOyksQXJpYWwiLCJsaW5laGVpZ2h0IjoiMS4zIiwiYm9sZCI6MCwiaXRhbGljIjowLCJ1bmRlcmxpbmUiOjAsImFsaWduIjoibGVmdCIsInBhZGRpbmdsZWZ0IjowfSwiTGluayI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rOkhvdmVyIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH19","sliderfont10customlabel":"Handwritten dark","sliderfont10":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiMDAwMDAwZGIiLCJzaXplIjoiMTQwfHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MHwqfGZmZmZmZjMzIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9UGFjaWZpY28pOyksQXJpYWwiLCJsaW5laGVpZ2h0IjoiMS4zIiwiYm9sZCI6MCwiaXRhbGljIjowLCJ1bmRlcmxpbmUiOjAsImFsaWduIjoibGVmdCIsInBhZGRpbmdsZWZ0IjowfSwiTGluayI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rOkhvdmVyIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH19","sliderfont11customlabel":"Button light","sliderfont11":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMTAwfHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MXwqfDAwMDAwMGM3IiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJjZW50ZXIiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfSwiTGluazpIb3ZlciI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfont12customlabel":"Button dark","sliderfont12":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiMDAwMDAwZGIiLCJzaXplIjoiMTAwfHwlIiwidHNoYWRvdyI6IjB8KnwxfCp8MHwqfGZmZmZmZjMzIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJjZW50ZXIiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsicGFkZGluZ2xlZnQiOjAsInNpemUiOiIxMDB8fCUifSwiTGluazpIb3ZlciI6eyJwYWRkaW5nbGVmdCI6MCwic2l6ZSI6IjEwMHx8JSJ9fQ==","sliderfontcustom5customlabel":"Post generator title v1","sliderfontcustom5":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiNmI2YjZiZmYiLCJzaXplIjoiMjIwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjoxLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJjZW50ZXIiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowLCJjb2xvciI6Ijg3ZDJjZWZmIn0sIkxpbms6SG92ZXIiOnsiY29sb3IiOiI4MmM3YzNmZiIsInNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom6customlabel":"Post generator categoryv1","sliderfontcustom6":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiODc4Nzg3ZmYiLCJzaXplIjoiMTQwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9QXZlcmFnZSk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJjZW50ZXIiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfSwiTGluazpIb3ZlciI6eyJjb2xvciI6IjY5YmRiOWZmIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfontcustom7customlabel":"Post generator paragraph v1","sliderfontcustom7":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiYTdhN2E3ZmYiLCJzaXplIjoiMTMwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9QXZlcmFnZSk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjYiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJjZW50ZXIiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowLCJjb2xvciI6IjY5YmRiOWIzIn0sIkxpbms6SG92ZXIiOnsiY29sb3IiOiI2OWJkYjlmZiIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfontcustom8customlabel":"Post generator button v1","sliderfontcustom8":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiNmNjOGMzZmYiLCJzaXplIjoiMTEwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9T3BlbitTYW5zKTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuNSIsImJvbGQiOjEsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6ImNlbnRlciIsInBhZGRpbmdsZWZ0IjowfSwiTGluayI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rOkhvdmVyIjp7ImNvbG9yIjoiZmZmZmZmZWIiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom9customlabel":"Post generator title v2","sliderfontcustom9":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiNmI2YjZiZmYiLCJzaXplIjoiMjIwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjoxLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MCwiY29sb3IiOiI4N2QyY2VmZiJ9LCJMaW5rOkhvdmVyIjp7ImNvbG9yIjoiODJjN2MzZmYiLCJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfontcustom10customlabel":"Post generator categoryv2","sliderfontcustom10":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiYWFhYWFhZmYiLCJzaXplIjoiMTAwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9T3BlbitTYW5zKTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuMyIsImJvbGQiOjAsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6ImxlZnQiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfSwiTGluazpIb3ZlciI6eyJjb2xvciI6IjY5YmRiOWZmIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfontcustom11customlabel":"Post generator paragraph v2","sliderfontcustom11":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiYTdhN2E3ZmYiLCJzaXplIjoiMTEwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9T3BlbitTYW5zKTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuNiIsImJvbGQiOjAsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6Imp1c3RpZnkiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowLCJjb2xvciI6IjY5YmRiOWIzIn0sIkxpbms6SG92ZXIiOnsiY29sb3IiOiI2OWJkYjlmZiIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfontcustom12customlabel":"Post generator button v2","sliderfontcustom12":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMTAwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9T3BlbitTYW5zKTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuNSIsImJvbGQiOjAsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6ImNlbnRlciIsInBhZGRpbmdsZWZ0IjowfSwiTGluayI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rOkhvdmVyIjp7ImNvbG9yIjoiZmZmZmZmZWIiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom13customlabel":"Post generator title v3","sliderfontcustom13":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMjIwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjoxLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MCwiY29sb3IiOiJmZmZmZmZlZCJ9LCJMaW5rOkhvdmVyIjp7ImNvbG9yIjoiODJjN2MzZmYiLCJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfontcustom14customlabel":"Post generator paragraph v3","sliderfontcustom14":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmYzQiLCJzaXplIjoiMTEwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9T3BlbitTYW5zKTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuNiIsImJvbGQiOjAsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6Imp1c3RpZnkiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowLCJjb2xvciI6IjY5YmRiOWIzIn0sIkxpbms6SG92ZXIiOnsiY29sb3IiOiI2OWJkYjlmZiIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfontcustom15customlabel":"Post generator title v4","sliderfontcustom15":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMjcwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjoxLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJjZW50ZXIiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowLCJjb2xvciI6ImZmZmZmZmZmIn0sIkxpbms6SG92ZXIiOnsiY29sb3IiOiI4MmM3YzNmZiIsInNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom16customlabel":"Post generator paragraph v4","sliderfontcustom16":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmYzQiLCJzaXplIjoiMTIwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9T3BlbitTYW5zKTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuNiIsImJvbGQiOjAsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6ImNlbnRlciIsInBhZGRpbmdsZWZ0IjowfSwiTGluayI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjAsImNvbG9yIjoiNjliZGI5YjMifSwiTGluazpIb3ZlciI6eyJjb2xvciI6IjY5YmRiOWZmIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfontcustom17customlabel":"Webshop generator title v1 ","sliderfontcustom17":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiNDM1NjY0ZmYiLCJzaXplIjoiMjQwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjIiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MCwiY29sb3IiOiI0MzU2NjRmZiJ9LCJMaW5rOkhvdmVyIjp7ImNvbG9yIjoiOGU0NGFkZmYiLCJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfontcustom18customlabel":"Webshop generator subtitle v1 ","sliderfontcustom18":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiNjA3MjgwZmYiLCJzaXplIjoiMTMwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjIiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MCwiY29sb3IiOiI0MzU2NjRmZiJ9LCJMaW5rOkhvdmVyIjp7ImNvbG9yIjoiOGU0NGFkZmYiLCJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfontcustom19customlabel":"Webshop generator paragraph v1","sliderfontcustom19":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiOGY5NTlkZTYiLCJzaXplIjoiMTEwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9T3BlbitTYW5zKTspLEFyaWFsIiwibGluZWhlaWdodCI6IjEuNCIsImJvbGQiOjAsIml0YWxpYyI6MCwidW5kZXJsaW5lIjowLCJhbGlnbiI6Imp1c3RpZnkiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowLCJjb2xvciI6IjQzNTY2NGZmIn0sIkxpbms6SG92ZXIiOnsiY29sb3IiOiI4ZTQ0YWRmZiIsInNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom20customlabel":"Webshop generator price v1 ","sliderfontcustom20":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiOGU0NGFkZmYiLCJzaXplIjoiMjQwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjIiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJyaWdodCIsInBhZGRpbmdsZWZ0IjowfSwiTGluayI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjAsImNvbG9yIjoiNDM1NjY0ZmYifSwiTGluazpIb3ZlciI6eyJjb2xvciI6IjdmM2M5Y2ZmIiwic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfX0=","sliderfontcustom21customlabel":"Webshop generator title v2","sliderfontcustom21":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiYjQ3MGEyZmYiLCJzaXplIjoiMTcwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9UmFsZXdheSk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsImNvbG9yIjoiZjU4NzAwZmYiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom22customlabel":"Webshop generator price v2","sliderfontcustom22":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiOGU0NGFkZmYiLCJzaXplIjoiMTYwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9TW9udHNlcnJhdCk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjIiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MCwiY29sb3IiOiI0MzU2NjRmZiJ9LCJMaW5rOkhvdmVyIjp7ImNvbG9yIjoiN2YzYzljZmYiLCJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ==","sliderfontcustom23customlabel":"Webshop generator paragraph v2","sliderfontcustom23":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiOTk5OTk5ZmYiLCJzaXplIjoiMTEwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9UmFsZXdheSk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjYiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJqdXN0aWZ5IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsImNvbG9yIjoiZjU4NzAwZmYiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom24customlabel":"Webshop generator price v3","sliderfontcustom24":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiYjQ3MGEyZmYiLCJzaXplIjoiMjYwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9QmViYXMpOyksQXJpYWwiLCJsaW5laGVpZ2h0IjoiMS41IiwiYm9sZCI6MSwiaXRhbGljIjowLCJ1bmRlcmxpbmUiOjAsImFsaWduIjoibGVmdCIsInBhZGRpbmdsZWZ0IjowfSwiTGluayI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rOkhvdmVyIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom25customlabel":"Webshop generator subtitle","sliderfontcustom25":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiOGE4YThhZmYiLCJzaXplIjoiMTEwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9UmFsZXdheSk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjIiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsImNvbG9yIjoiZjU4NzAwZmYiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom26customlabel":"Webshop generator title v3","sliderfontcustom26":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMjYwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9UmFsZXdheSk7KSxBcmlhbCIsImxpbmVoZWlnaHQiOiIxLjMiLCJib2xkIjowLCJpdGFsaWMiOjAsInVuZGVybGluZSI6MCwiYWxpZ24iOiJsZWZ0IiwicGFkZGluZ2xlZnQiOjB9LCJMaW5rIjp7InNpemUiOiIxMDB8fCUiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbms6SG92ZXIiOnsic2l6ZSI6IjEwMHx8JSIsImNvbG9yIjoiZmZmZmZmZDkiLCJwYWRkaW5nbGVmdCI6MH19","sliderfontcustom27customlabel":"Webshop generator price v4","sliderfontcustom27":"eyJmaXJzdHRhYiI6IlRleHQiLCJUZXh0Ijp7ImNvbG9yIjoiZmZmZmZmZmYiLCJzaXplIjoiMzgwfHwlIiwidHNoYWRvdyI6IjB8KnwwfCp8MHwqfGZmZmZmZjAwIiwiYWZvbnQiOiJnb29nbGUoQGltcG9ydCB1cmwoaHR0cDovL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9QmViYXMpOyksQXJpYWwiLCJsaW5laGVpZ2h0IjoiMS4yIiwiYm9sZCI6MCwiaXRhbGljIjowLCJ1bmRlcmxpbmUiOjAsImFsaWduIjoicmlnaHQiLCJwYWRkaW5nbGVmdCI6MH0sIkxpbmsiOnsic2l6ZSI6IjEwMHx8JSIsInBhZGRpbmdsZWZ0IjowfSwiTGluazpIb3ZlciI6eyJzaXplIjoiMTAwfHwlIiwicGFkZGluZ2xlZnQiOjB9fQ=="}'); 
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('7', 'generator2', '{"time":1394945378,"hash":"1a024e4efcbe0642b2e94a249bc37351","data":[{"image":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","title":"slider","url":"#","description":"","thumbnail":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","url_label":"View","author_name":"","author_url":"#"},{"image":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","title":"slider","url":"#","description":"","thumbnail":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","url_label":"View","author_name":"","author_url":"#"},{"image":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","title":"slider","url":"#","description":"","thumbnail":"http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg","url_label":"View","author_name":"","author_url":"#"}]}'); 
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('8', 'slidercache2', '{"time":1397329717,"data":{"css":"http:\/\/127.0.0.1\/asug\/wp-content\/cache\/css\/static\/77b25944e339011508373c057ad4f71f.css","js":{"core":{"C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\assets\\js\\class.js":"C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\assets\\js\\class.js"}},"fonts":{"Montserrat":{"0":400,"1":"latin","400,latin":1},"Pacifico":{"0":400,"1":"latin","400,latin":1},"Average":{"0":400,"1":"latin","400,latin":1},"Open Sans":{"0":400,"1":"latin","400,latin":1},"Raleway":{"0":400,"1":"latin","400,latin":1},"Bebas":{"0":400,"1":"latin","400,latin":1}},"html":"<script type=\"text\/javascript\">\n    window[\'nextend-smart-slider-2-onresize\'] = [];\n<\/script>\n<div class=\"CentralizarS\">\n    <div id=\"nextend-smart-slider-2\" class=\"nextend-slider-fadeload nextend-desktop \" style=\"font-size: 12px;\" data-allfontsize=\"12\" data-desktopfontsize=\"12\" data-tabletfontsize=\"16\" data-phonefontsize=\"20\">\n        <div class=\"smart-slider-border1\" style=\"\">\n            <div class=\"smart-slider-border2\">\n                \n                                    <div class=\"smart-slider-canvas smart-slider-slide-active smart-slider-bg-colored\" style=\"\">\n                                                    <img src=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\" data-desktop=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\"  class=\"nextend-slide-bg\"\/>\n                                                                        <div class=\"smart-slider-canvas-inner\">\n                                                    <\/div>\n                                            <\/div>\n                                    <div class=\"smart-slider-canvas smart-slider-bg-colored\" style=\"\">\n                                                    <img src=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\" data-desktop=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\"  class=\"nextend-slide-bg\"\/>\n                                                                        <div class=\"smart-slider-canvas-inner\">\n                                                    <\/div>\n                                            <\/div>\n                                    <div class=\"smart-slider-canvas smart-slider-bg-colored\" style=\"\">\n                                                    <img src=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\" data-desktop=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\"  class=\"nextend-slide-bg\"\/>\n                                                                        <div class=\"smart-slider-canvas-inner\">\n                                                    <\/div>\n                                            <\/div>\n                                    <div class=\"smart-slider-canvas smart-slider-bg-colored\" style=\"\">\n                                                    <img src=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\" data-desktop=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\"  class=\"nextend-slide-bg\"\/>\n                                                                        <div class=\"smart-slider-canvas-inner\">\n                                                    <\/div>\n                                            <\/div>\n                            <\/div>\n        <\/div>\n        <div onclick=\"njQuery(\'#nextend-smart-slider-2\').smartslider(\'previous\');\" class=\"nextend-widget nextend-widget-always nextend-widget-display-desktop nextend-arrow-previous nextend-transition nextend-transition-previous nextend-transition-previous-my-test\" style=\"position: absolute;left:0%;\" data-sstop=\"height\/2-previousheight\/2\" ><div class=\"smartslider-outer\"><\/div><div class=\"smartslider-inner\"><\/div><\/div><div onclick=\"njQuery(\'#nextend-smart-slider-2\').smartslider(\'next\');\" class=\"nextend-widget nextend-widget-always nextend-widget-display-desktop nextend-arrow-next nextend-transition nextend-transition-next nextend-transition-next-my-test\" style=\"position: absolute;right:0%;\" data-sstop=\"height\/2-nextheight\/2\" ><div class=\"smartslider-outer\"><\/div><div class=\"smartslider-inner\"><\/div><\/div><div style=\"position: absolute;left:0%;bottom:5%;visibility: hidden;z-index:10; line-height: 0;width:100%;text-align:center;\" class=\"nextend-widget nextend-widget-always nextend-widget-display-desktop nextend-widget-bullet \" ><div class=\"nextend-bullet-container nextend-bullet nextend-bullet-numbers nextend-bullet-numbers-square nextend-bullet-horizontal\"><div onclick=\"njQuery(\'#nextend-smart-slider-2\').smartslider(\'goto\',0,false);\" data-thumbnail=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\"  class=\"nextend-bullet nextend-bullet-numbers nextend-bullet-numbers-square nextend-bullet-horizontal\"><span class=\"sliderfont7\">\n                1\n                <\/span><\/div><div onclick=\"njQuery(\'#nextend-smart-slider-2\').smartslider(\'goto\',1,false);\" data-thumbnail=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\"  class=\"nextend-bullet nextend-bullet-numbers nextend-bullet-numbers-square nextend-bullet-horizontal\"><span class=\"sliderfont7\">\n                2\n                <\/span><\/div><div onclick=\"njQuery(\'#nextend-smart-slider-2\').smartslider(\'goto\',2,false);\" data-thumbnail=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\"  class=\"nextend-bullet nextend-bullet-numbers nextend-bullet-numbers-square nextend-bullet-horizontal\"><span class=\"sliderfont7\">\n                3\n                <\/span><\/div><div onclick=\"njQuery(\'#nextend-smart-slider-2\').smartslider(\'goto\',3,false);\" data-thumbnail=\"http:\/\/127.0.0.1\/asug\/wp-content\/uploads\/2014\/03\/slider.jpg\"  class=\"nextend-bullet nextend-bullet-numbers nextend-bullet-numbers-square nextend-bullet-horizontal\"><span class=\"sliderfont7\">\n                4\n                <\/span><\/div><\/div><\/div>    <\/div>\n<\/div>\n<script type=\"text\/javascript\">\n    njQuery(document).ready(function () {\n        njQuery(\'#nextend-smart-slider-2\').smartslider({\"translate3d\":1,\"playfirstlayer\":0,\"mainafterout\":0,\"inaftermain\":1,\"fadeonscroll\":0,\"autoplay\":1,\"autoplayConfig\":{\"duration\":8000,\"counter\":0,\"autoplayToSlide\":0,\"stopautoplay\":{\"click\":1,\"mouseenter\":1,\"slideplaying\":1},\"resumeautoplay\":{\"mouseleave\":0,\"slideplayed\":1,\"slidechanged\":0}},\"responsive\":{\"downscale\":1,\"upscale\":0,\"maxwidth\":3000,\"basedon\":\"combined\",\"screenwidth\":{\"tablet\":480,\"phone\":480},\"ratios\":[1,1,0.7,0.5]},\"controls\":{\"scroll\":0,\"touch\":\"horizontal\",\"keyboard\":0},\"blockrightclick\":0,\"lazyload\":0,\"lazyloadneighbor\":0,\"type\":\"ssSimpleSlider\",\"animation\":[\"horizontal\"],\"animationSettings\":{\"duration\":800,\"delay\":0,\"easing\":\"easeInOutQuad\",\"parallax\":1},\"flux\":[0,[\"bars\",\"blocks\"]],\"touchanimation\":\"horizontal\"});\n    });\n<\/script>\n<div style=\"clear: both;\"><\/div>\n<div id=\"nextend-smart-slider-2-placeholder\" ><img alt=\"\" style=\"width:100%; max-width: 3000px;\" src=\"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAh4AAAD6CAYAAADuiU73AAAEQklEQVR4nO3WMQEAIAzAMMC\/5+GiHCQKenbPAgBonNcBAMA\/jAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZIwHAJAxHgBAxngAABnjAQBkjAcAkDEeAEDGeAAAGeMBAGSMBwCQMR4AQMZ4AAAZ4wEAZC6jWgLztugg\/QAAAABJRU5ErkJggg==\" \/><\/div>","libraries":{"modernizr":{"jsfiles":["C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/modernizr\/modernizr.js"],"js":""},"jquery":{"jsfiles":["C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/njQuery.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/jQuery.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/uacss.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/jquery.unique-element-id.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/jquery.unveil.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/jquery.waitforimages.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/jquery.touchSwipe.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/easing.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\nextend\\javascript\/jquery\/1.9.1\/jquery.transit.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\animationbase.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\smartsliderbase.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\mainslider.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\layers.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\motions\\no.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\motions\\nostatic.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\motions\\fade.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\motions\\fadestatic.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\motions\\slide.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\motions\\slidestatic.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\library\\smartslider\\assets\\js\\motions\\transit.js","C:\\xampp\\htdocs\\asug\\wp-content\\plugins\\smart-slider-2\\plugins\\nextendslidertype\\simple\\simple\\slider.js"],"js":""}}},"slideexpire":1710564598}'); 
INSERT INTO `wp_nextend_smartslider_storage` VALUES ('9', 'sliderchanged3', '1'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_options`
--
DROP TABLE IF EXISTS `wp_options`;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3653 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_options`
--
LOCK TABLES `wp_options` WRITE;
INSERT INTO `wp_options` VALUES ('1', 'siteurl', 'http://127.0.0.1/asug', 'yes'); 
INSERT INTO `wp_options` VALUES ('2', 'blogname', 'Asug | SAP NetWeaver Portal', 'yes'); 
INSERT INTO `wp_options` VALUES ('3', 'blogdescription', 'Só mais um site WordPress', 'yes'); 
INSERT INTO `wp_options` VALUES ('4', 'users_can_register', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('5', 'admin_email', 'contato@montarsite.com.br', 'yes'); 
INSERT INTO `wp_options` VALUES ('6', 'start_of_week', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('7', 'use_balanceTags', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('8', 'use_smilies', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('9', 'require_name_email', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('10', 'comments_notify', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('11', 'posts_per_rss', '10', 'yes'); 
INSERT INTO `wp_options` VALUES ('12', 'rss_use_excerpt', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('13', 'mailserver_url', 'mail.example.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('14', 'mailserver_login', 'login@example.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('15', 'mailserver_pass', 'password', 'yes'); 
INSERT INTO `wp_options` VALUES ('16', 'mailserver_port', '110', 'yes'); 
INSERT INTO `wp_options` VALUES ('17', 'default_category', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('18', 'default_comment_status', 'closed', 'yes'); 
INSERT INTO `wp_options` VALUES ('19', 'default_ping_status', 'open', 'yes'); 
INSERT INTO `wp_options` VALUES ('20', 'default_pingback_flag', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('21', 'posts_per_page', '10', 'yes'); 
INSERT INTO `wp_options` VALUES ('22', 'date_format', 'j de F de Y', 'yes'); 
INSERT INTO `wp_options` VALUES ('23', 'time_format', 'H:i', 'yes'); 
INSERT INTO `wp_options` VALUES ('24', 'links_updated_date_format', 'j de F de Y, H:i', 'yes'); 
INSERT INTO `wp_options` VALUES ('28', 'comment_moderation', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('29', 'moderation_notify', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('30', 'permalink_structure', '/%postname%/', 'yes'); 
INSERT INTO `wp_options` VALUES ('31', 'gzipcompression', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('32', 'hack_file', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('33', 'blog_charset', 'UTF-8', 'yes'); 
INSERT INTO `wp_options` VALUES ('34', 'moderation_keys', '', 'no'); 
INSERT INTO `wp_options` VALUES ('35', 'active_plugins', 'a:32:{i:0;s:56:"New-Media-Image-Uploader-master/tgm-new-media-plugin.php";i:1;s:39:"admin-customizado/admin-customizado.php";i:2;s:29:"ads-by-datafeedrcom/dfads.php";i:3;s:30:"advanced-custom-fields/acf.php";i:4;s:51:"auto-excerpt-everywhere/auto-excerpt-everywhere.php";i:5;s:32:"boleto-usuario/modulo_boleto.php";i:6;s:43:"broken-link-checker/broken-link-checker.php";i:7;s:85:"carousel-horizontal-posts-content-slider/carousel-horizontal-posts-content-slider.php";i:8;s:25:"cloudflare/cloudflare.php";i:9;s:36:"contact-form-7/wp-contact-form-7.php";i:10;s:38:"dashboard_usuario/dashbord_usuario.php";i:11;s:33:"duplicate-post/duplicate-post.php";i:12;s:33:"events-manager/events-manager.php";i:13;s:45:"ewww-image-optimizer/ewww-image-optimizer.php";i:14;s:37:"export-user-data/export-user-data.php";i:15;s:43:"google-analytics-dashboard-for-wp/gadwp.php";i:16;s:50:"google-analytics-for-wordpress/googleanalytics.php";i:17;s:43:"google-font-manager/google-font-manager.php";i:18;s:36:"google-sitemap-generator/sitemap.php";i:19;s:9:"hello.php";i:20;s:24:"log-user-stats/index.php";i:21;s:39:"pdfjs-viewer-shortcode/pdfjs-viewer.php";i:22;s:29:"ready-backup/backup-ready.php";i:23;s:33:"seo-image/seo-friendly-images.php";i:24;s:45:"simple-local-avatars/simple-local-avatars.php";i:25;s:33:"smart-slider-2/smart-slider-2.php";i:26;s:37:"user-role-editor/user-role-editor.php";i:27;s:29:"user-status-manager/start.php";i:28;s:39:"webriti-smtp-mail/webriti-smtp-mail.php";i:29;s:37:"widgets-on-pages/widgets_on_pages.php";i:30;s:31:"wp-backupware/wp-backupware.php";i:31;s:27:"wp-optimize/wp-optimize.php";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('36', 'home', 'http://127.0.0.1/asug', 'yes'); 
INSERT INTO `wp_options` VALUES ('37', 'category_base', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('38', 'ping_sites', 'http://rpc.pingomatic.com/', 'yes'); 
INSERT INTO `wp_options` VALUES ('39', 'advanced_edit', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('40', 'comment_max_links', '2', 'yes'); 
INSERT INTO `wp_options` VALUES ('41', 'gmt_offset', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('42', 'default_email_category', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('43', 'recently_edited', 'a:2:{i:0;s:87:"C:xampphtdocsasug/wp-content/plugins/twenty-eleven-theme-extensions/moztheme2011.php";i:1;s:0:"";}', 'no'); 
INSERT INTO `wp_options` VALUES ('44', 'template', 'asug', 'yes'); 
INSERT INTO `wp_options` VALUES ('45', 'stylesheet', 'asug', 'yes'); 
INSERT INTO `wp_options` VALUES ('46', 'comment_whitelist', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('47', 'blacklist_keys', '', 'no'); 
INSERT INTO `wp_options` VALUES ('48', 'comment_registration', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('49', 'html_type', 'text/html', 'yes'); 
INSERT INTO `wp_options` VALUES ('50', 'use_trackback', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('51', 'default_role', 'subscriber', 'yes'); 
INSERT INTO `wp_options` VALUES ('52', 'db_version', '27916', 'yes'); 
INSERT INTO `wp_options` VALUES ('53', 'uploads_use_yearmonth_folders', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('54', 'upload_path', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('55', 'blog_public', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('56', 'default_link_category', '2', 'yes'); 
INSERT INTO `wp_options` VALUES ('57', 'show_on_front', 'page', 'yes'); 
INSERT INTO `wp_options` VALUES ('58', 'tag_base', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('59', 'show_avatars', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('60', 'avatar_rating', 'G', 'yes'); 
INSERT INTO `wp_options` VALUES ('61', 'upload_url_path', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('62', 'thumbnail_size_w', '150', 'yes'); 
INSERT INTO `wp_options` VALUES ('63', 'thumbnail_size_h', '150', 'yes'); 
INSERT INTO `wp_options` VALUES ('64', 'thumbnail_crop', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('65', 'medium_size_w', '300', 'yes'); 
INSERT INTO `wp_options` VALUES ('66', 'medium_size_h', '300', 'yes'); 
INSERT INTO `wp_options` VALUES ('67', 'avatar_default', 'mystery', 'yes'); 
INSERT INTO `wp_options` VALUES ('68', 'large_size_w', '1024', 'yes'); 
INSERT INTO `wp_options` VALUES ('69', 'large_size_h', '1024', 'yes'); 
INSERT INTO `wp_options` VALUES ('70', 'image_default_link_type', 'file', 'yes'); 
INSERT INTO `wp_options` VALUES ('71', 'image_default_size', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('72', 'image_default_align', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('73', 'close_comments_for_old_posts', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('74', 'close_comments_days_old', '14', 'yes'); 
INSERT INTO `wp_options` VALUES ('75', 'thread_comments', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('76', 'thread_comments_depth', '5', 'yes'); 
INSERT INTO `wp_options` VALUES ('77', 'page_comments', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('78', 'comments_per_page', '50', 'yes'); 
INSERT INTO `wp_options` VALUES ('79', 'default_comments_page', 'newest', 'yes'); 
INSERT INTO `wp_options` VALUES ('80', 'comment_order', 'asc', 'yes'); 
INSERT INTO `wp_options` VALUES ('81', 'sticky_posts', 'a:0:{}', 'yes'); 
INSERT INTO `wp_options` VALUES ('82', 'widget_categories', 'a:2:{i:2;a:4:{s:5:"title";s:0:"";s:5:"count";i:0;s:12:"hierarchical";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('83', 'widget_text', 'a:3:{i:2;a:3:{s:5:"title";s:0:"";s:4:"text";s:2595:"<aside>
					<div id="post_recentes">
						<div class="table-responsive forum_home">
							<table class="table table-hover">
								<thead>
									<tr class="titulos">
										<th class="post_recentes" colspan="2">Fórum | Posts mais recentes</th>
										<th class="post_recentes_f">Ir para o fórum</th>
									</tr>
								</thead>
								<tbody class="textos">
									<tr class="topo">
										<td>Título</td>
										<td>Autor</td>
										<td>Data</td>
									</tr>
									<tr class="posts_recentes">
										<td class="posts">
											<a href="">
												<h3>Auditoria e GRC » Academia AIS</h3>
											</a>
											<p>> "Academia AIS", AIS e AM</p>
										</td>
										<td class="autor">
											<a href="">Adriano Siabno</a>
										</td>
										<td class="data">
											<time>06/05/2013</time>
										</td>
									</tr>
									<tr class="posts_recentes">
										<td>
											<a href="">
												<h3>Auditoria e GRC » Academia AIS</h3>
											</a>
											<p>> "Academia AIS", AIS e AM</p>
										</td>
										<td class="autor">
											<a href="">Adriano Siabno</a>
										</td>
										<td class="data">
											<time>06/05/2013</time>
										</td>
									</tr>
									<tr class="posts_recentes">
										<td>
											<a href="">
												<h3>Auditoria e GRC » Academia AIS</h3>
											</a>
											<p>> "Academia AIS", AIS e AM</p>
										</td>
										<td class="autor">
											<a href="">Adriano Siabno</a>
										</td>
										<td class="data">
											<time>06/05/2013</time>
										</td>
									</tr>
									<tr class="posts_recentes">
										<td>
											<a href="">
												<h3>Auditoria e GRC » Academia AIS</h3>
											</a>
											<p>> "Academia AIS", AIS e AM</p>
										</td>
										<td class="autor">
											<a href="">Adriano Siabno</a>
										</td>
										<td class="data">
											<time>06/05/2013</time>
										</td>
									</tr>
									<tr class="posts_recentes">
										<td>
											<a href="">
												<h3>Auditoria e GRC » Academia AIS</h3>
											</a>
											<p>> "Academia AIS", AIS e AM</p>
										</td>
										<td class="autor">
											<a href="">Adriano Siabno</a>
										</td>
										<td class="data">
											<time>06/05/2013</time>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</aside>";s:6:"filter";b:0;}i:3;a:3:{s:5:"title";s:5:"Teste";s:4:"text";s:7:"Direito";s:6:"filter";b:0;}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('84', 'widget_rss', 'a:0:{}', 'yes'); 
INSERT INTO `wp_options` VALUES ('85', 'uninstall_plugins', 'a:6:{s:41:"better-wp-security/better-wp-security.php";a:2:{i:0;s:11:"ITSEC_Setup";i:1;s:12:"on_uninstall";}s:43:"google-analytics-dashboard-for-wp/gadwp.php";a:2:{i:0;s:16:"GADASH_Uninstall";i:1;s:9:"uninstall";}s:41:"simple-ads-manager/simple-ads-manager.php";a:2:{i:0;s:21:"SimpleAdsManagerAdmin";i:1;s:11:"onUninstall";}s:21:"adrotate/adrotate.php";s:18:"adrotate_uninstall";s:43:"google-font-manager/google-font-manager.php";s:27:"wp_googlefontmgr_deactivate";s:45:"simple-local-avatars/simple-local-avatars.php";s:30:"simple_local_avatars_uninstall";}', 'no'); 
INSERT INTO `wp_options` VALUES ('86', 'timezone_string', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('87', 'page_for_posts', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('88', 'page_on_front', '2', 'yes'); 
INSERT INTO `wp_options` VALUES ('89', 'default_post_format', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('90', 'link_manager_enabled', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('91', 'initial_db_version', '26691', 'yes'); 
INSERT INTO `wp_options` VALUES ('92', 'wp_user_roles', 'a:6:{s:13:"administrator";a:2:{s:4:"name";s:13:"Administrator";s:12:"capabilities";a:86:{s:13:"switch_themes";b:1;s:11:"edit_themes";b:1;s:16:"activate_plugins";b:1;s:12:"edit_plugins";b:1;s:10:"edit_users";b:1;s:10:"edit_files";b:1;s:14:"manage_options";b:1;s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:6:"import";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:8:"level_10";b:1;s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:12:"delete_users";b:1;s:12:"create_users";b:1;s:17:"unfiltered_upload";b:1;s:14:"edit_dashboard";b:1;s:14:"update_plugins";b:1;s:14:"delete_plugins";b:1;s:15:"install_plugins";b:1;s:13:"update_themes";b:1;s:14:"install_themes";b:1;s:11:"update_core";b:1;s:10:"list_users";b:1;s:12:"remove_users";b:1;s:9:"add_users";b:1;s:13:"promote_users";b:1;s:18:"edit_theme_options";b:1;s:13:"delete_themes";b:1;s:6:"export";b:1;s:14:"publish_events";b:1;s:20:"delete_others_events";b:1;s:18:"edit_others_events";b:1;s:22:"manage_others_bookings";b:1;s:24:"publish_recurring_events";b:1;s:30:"delete_others_recurring_events";b:1;s:28:"edit_others_recurring_events";b:1;s:17:"publish_locations";b:1;s:23:"delete_others_locations";b:1;s:16:"delete_locations";b:1;s:21:"edit_others_locations";b:1;s:23:"delete_event_categories";b:1;s:21:"edit_event_categories";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;s:10:"copy_posts";b:1;}}s:6:"editor";a:2:{s:4:"name";s:6:"Editor";s:12:"capabilities";a:58:{s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:14:"publish_events";b:1;s:20:"delete_others_events";b:1;s:18:"edit_others_events";b:1;s:22:"manage_others_bookings";b:1;s:24:"publish_recurring_events";b:1;s:30:"delete_others_recurring_events";b:1;s:28:"edit_others_recurring_events";b:1;s:17:"publish_locations";b:1;s:23:"delete_others_locations";b:1;s:16:"delete_locations";b:1;s:21:"edit_others_locations";b:1;s:23:"delete_event_categories";b:1;s:21:"edit_event_categories";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;s:10:"copy_posts";b:1;}}s:6:"author";a:2:{s:4:"name";s:6:"Author";s:12:"capabilities";a:20:{s:12:"upload_files";b:1;s:10:"edit_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:4:"read";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:22:"delete_published_posts";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;}}s:11:"contributor";a:2:{s:4:"name";s:11:"Contributor";s:12:"capabilities";a:15:{s:10:"edit_posts";b:1;s:4:"read";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;}}s:10:"subscriber";a:2:{s:4:"name";s:10:"Subscriber";s:12:"capabilities";a:12:{s:4:"read";b:1;s:7:"level_0";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;}}s:13:"representante";a:2:{s:4:"name";s:13:"Representante";s:12:"capabilities";a:2:{s:4:"read";i:1;s:7:"level_0";i:1;}}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('93', 'widget_search', 'a:3:{i:2;a:1:{s:5:"title";s:0:"";}i:3;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('94', 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('95', 'widget_recent-comments', 'a:3:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}i:3;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('96', 'widget_archives', 'a:2:{i:2;a:3:{s:5:"title";s:0:"";s:5:"count";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('97', 'widget_meta', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('98', 'sidebars_widgets', 'a:7:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}s:9:"sidebar-2";a:1:{i:0;s:6:"text-2";}s:9:"sidebar-3";a:0:{}s:5:"wop-1";a:2:{i:0;s:7:"pages-2";i:1;s:6:"text-3";}s:5:"wop-2";a:4:{i:0;s:8:"search-3";i:1;s:17:"recent-comments-3";i:2;s:10:"calendar-2";i:3;s:13:"em_calendar-2";}s:13:"array_version";i:3;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('99', 'cron', 'a:15:{i:1398371301;a:2:{s:28:"blc_cron_email_notifications";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:19:"blc_cron_check_news";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1398374901;a:1:{s:13:"sm_ping_daily";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1398384000;a:2:{s:15:"verificarcontas";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:27:"woocommerce_scheduled_sales";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1398385219;a:1:{s:40:"membership_perform_cron_processes_hourly";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"hourly";s:4:"args";a:0:{}s:8:"interval";i:3600;}}}i:1398385701;a:1:{s:20:"blc_cron_check_links";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"hourly";s:4:"args";a:0:{}s:8:"interval";i:3600;}}}i:1398389659;a:2:{s:16:"itsec_purge_logs";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:20:"itsec_purge_lockouts";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1398389668;a:1:{s:28:"woocommerce_cleanup_sessions";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}}i:1398397897;a:1:{s:16:"wp_version_check";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}}i:1398397898;a:2:{s:17:"wp_update_plugins";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:16:"wp_update_themes";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}}i:1398410820;a:1:{s:20:"wp_maybe_auto_update";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}}i:1398441114;a:1:{s:19:"wp_scheduled_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1398443658;a:1:{s:30:"wp_scheduled_auto_draft_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1398453952;a:1:{s:17:"wpbu_backup_event";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1398601701;a:1:{s:29:"blc_cron_database_maintenance";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:9:"bimonthly";s:4:"args";a:0:{}s:8:"interval";i:936000;}}}s:7:"version";i:2;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('105', '_site_transient_update_themes', 'O:8:"stdClass":4:{s:12:"last_checked";i:1398384395;s:7:"checked";a:1:{s:4:"asug";s:3:"1.0";}s:8:"response";a:0:{}s:12:"translations";a:0:{}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('131', 'wpcf7', 'a:1:{s:7:"version";s:3:"3.8";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('132', 'recently_activated', 'a:0:{}', 'yes'); 
INSERT INTO `wp_options` VALUES ('133', 'Yoast_Google_Analytics', 'a:51:{s:16:"advancedsettings";b:0;s:11:"allowanchor";b:0;s:9:"allowhash";b:0;s:11:"allowlinker";b:0;s:11:"anonymizeip";b:0;s:10:"customcode";s:0:"";s:11:"cv_loggedin";b:0;s:13:"cv_authorname";b:0;s:11:"cv_category";b:0;s:17:"cv_all_categories";b:0;s:7:"cv_tags";b:0;s:7:"cv_year";b:0;s:12:"cv_post_type";b:0;s:5:"debug";b:0;s:12:"dlextensions";s:30:"doc,exe,js,pdf,ppt,tgz,zip,xls";s:6:"domain";s:0:"";s:11:"domainorurl";s:6:"domain";s:7:"extrase";b:0;s:10:"extraseurl";s:0:"";s:11:"firebuglite";b:0;s:8:"ga_token";s:0:"";s:16:"ga_api_responses";a:0:{}s:16:"gajslocalhosting";b:0;s:7:"gajsurl";s:0:"";s:16:"ignore_userlevel";s:2:"11";s:12:"internallink";s:0:"";s:17:"internallinklabel";s:0:"";s:16:"outboundpageview";b:0;s:17:"downloadspageview";b:0;s:17:"othercrossdomains";s:0:"";s:8:"position";s:6:"header";s:18:"primarycrossdomain";s:0:"";s:13:"theme_updated";b:0;s:16:"trackcommentform";b:1;s:16:"trackcrossdomain";b:0;s:12:"trackadsense";b:0;s:13:"trackoutbound";b:1;s:17:"trackregistration";b:0;s:14:"rsslinktagging";b:1;s:8:"uastring";s:13:"UA-45871625-6";s:7:"version";s:5:"4.3.5";s:3:"msg";s:0:"";s:14:"tracking_popup";s:4:"done";s:14:"yoast_tracking";b:0;s:15:"gfsubmiteventpv";s:0:"";s:11:"trackprefix";s:0:"";s:13:"admintracking";b:0;s:15:"manual_uastring";b:1;s:11:"taggfsubmit";b:0;s:13:"wpec_tracking";b:0;s:14:"shopp_tracking";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('141', 'acf_version', '4.3.7', 'yes'); 
INSERT INTO `wp_options` VALUES ('147', 'ewww_image_optimizer_disable_pngout', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('148', 'ewww_image_optimizer_optipng_level', '2', 'yes'); 
INSERT INTO `wp_options` VALUES ('149', 'ewww_image_optimizer_pngout_level', '2', 'yes'); 
INSERT INTO `wp_options` VALUES ('150', 'ewww_image_optimizer_version', '185', 'yes'); 
INSERT INTO `wp_options` VALUES ('151', 'ewww_image_optimizer_cloud_jpg', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('152', 'ewww_image_optimizer_cloud_png', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('153', 'ewww_image_optimizer_cloud_gif', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('162', 'wsblc_options', '{"max_execution_time":420,"check_threshold":72,"recheck_count":3,"recheck_threshold":1800,"run_in_dashboard":true,"run_via_cron":true,"mark_broken_links":true,"broken_link_css":".broken_link, a.broken_link {\n\ttext-decoration: line-through;\n}","nofollow_broken_links":false,"mark_removed_links":false,"removed_link_css":".removed_link, a.removed_link {\n\ttext-decoration: line-through;\n}","exclusion_list":[],"send_email_notifications":true,"send_authors_email_notifications":false,"notification_email_address":"","notification_schedule":"daily","last_notification_sent":1397334563,"suggestions_enabled":true,"server_load_limit":4,"enable_load_limit":false,"custom_fields":[],"enabled_post_statuses":["publish"],"autoexpand_widget":true,"dashboard_widget_capability":"edit_others_posts","show_link_count_bubble":true,"table_layout":"flexible","table_compact":true,"table_visible_columns":["new-url","status","used-in","new-link-text"],"table_links_per_page":30,"table_color_code_status":true,"need_resynch":false,"current_db_version":7,"timeout":30,"highlight_permanent_failures":false,"failure_duration_threshold":3,"logging_enabled":false,"log_file":"","custom_log_file_enabled":false,"installation_complete":true,"installation_flag_cleared_on":"2014-04-12T19:10:41+00:00 (1397329841.2321)","installation_flag_set_on":"2014-04-12T19:10:42+00:00 (1397329842.2148)","user_has_donated":false,"donation_flag_fixed":false,"first_installation_timestamp":1397329841,"active_modules":{"http":{"ModuleID":"http","ModuleCategory":"checker","ModuleContext":"on-demand","ModuleLazyInit":true,"ModuleClassName":"blcHttpChecker","ModulePriority":-1,"ModuleCheckerUrlPattern":"","ModuleHidden":false,"ModuleAlwaysActive":false,"ModuleRequiresPro":false,"Name":"Basic HTTP","PluginURI":"","Version":"1.0","Description":"Check all links that have the HTTP\/HTTPS protocol.","Author":"Janis Elsts","AuthorURI":"","TextDomain":"broken-link-checker","DomainPath":"","Network":false,"Title":"Basic HTTP","AuthorName":"Janis Elsts","file":"checkers\/http.php"},"link":{"ModuleID":"link","ModuleCategory":"parser","ModuleContext":"on-demand","ModuleLazyInit":true,"ModuleClassName":"blcHTMLLink","ModulePriority":1000,"ModuleCheckerUrlPattern":"","ModuleHidden":false,"ModuleAlwaysActive":false,"ModuleRequiresPro":false,"Name":"HTML links","PluginURI":"","Version":"1.0","Description":"Example : <code>&lt;a href=\"http:\/\/example.com\/\"&gt;link text&lt;\/a&gt;<\/code>","Author":"Janis Elsts","AuthorURI":"","TextDomain":"broken-link-checker","DomainPath":"","Network":false,"Title":"HTML links","AuthorName":"Janis Elsts","file":"parsers\/html_link.php"},"image":{"ModuleID":"image","ModuleCategory":"parser","ModuleContext":"on-demand","ModuleLazyInit":true,"ModuleClassName":"blcHTMLImage","ModulePriority":900,"ModuleCheckerUrlPattern":"","ModuleHidden":false,"ModuleAlwaysActive":false,"ModuleRequiresPro":false,"Name":"HTML images","PluginURI":"","Version":"1.0","Description":"e.g. <code>&lt;img src=\"http:\/\/example.com\/fluffy.jpg\"&gt;<\/code>","Author":"Janis Elsts","AuthorURI":"","TextDomain":"broken-link-checker","DomainPath":"","Network":false,"Title":"HTML images","AuthorName":"Janis Elsts","file":"parsers\/image.php"},"metadata":{"ModuleID":"metadata","ModuleCategory":"parser","ModuleContext":"on-demand","ModuleLazyInit":true,"ModuleClassName":"blcMetadataParser","ModulePriority":0,"ModuleCheckerUrlPattern":"","ModuleHidden":true,"ModuleAlwaysActive":true,"ModuleRequiresPro":false,"Name":"Metadata","PluginURI":"","Version":"1.0","Description":"Parses metadata (AKA custom fields)","Author":"Janis Elsts","AuthorURI":"","TextDomain":"broken-link-checker","DomainPath":"","Network":false,"Title":"Metadata","AuthorName":"Janis Elsts","file":"parsers\/metadata.php"},"url_field":{"ModuleID":"url_field","ModuleCategory":"parser","ModuleContext":"on-demand","ModuleLazyInit":true,"ModuleClassName":"blcUrlField","ModulePriority":0,"ModuleCheckerUrlPattern":"","ModuleHidden":true,"ModuleAlwaysActive":true,"ModuleRequiresPro":false,"Name":"URL fields","PluginURI":"","Version":"1.0","Description":"Parses data fields that contain a single, plaintext URL.","Author":"Janis Elsts","AuthorURI":"","TextDomain":"broken-link-checker","DomainPath":"","Network":false,"Title":"URL fields","AuthorName":"Janis Elsts","file":"parsers\/url_field.php"},"comment":{"ModuleID":"comment","ModuleCategory":"container","ModuleContext":"all","ModuleLazyInit":false,"ModuleClassName":"blcCommentManager","ModulePriority":0,"ModuleCheckerUrlPattern":"","ModuleHidden":false,"ModuleAlwaysActive":false,"ModuleRequiresPro":false,"Name":"Comments","PluginURI":"","Version":"1.0","Description":"","Author":"Janis Elsts","AuthorURI":"","TextDomain":"broken-link-checker","DomainPath":"","Network":false,"Title":"Comments","AuthorName":"Janis Elsts","file":"containers\/comment.php"},"post":{"Name":"Posts","ModuleCategory":"container","ModuleContext":"all","ModuleClassName":"blcAnyPostContainerManager","ModuleID":"post","file":"","ModuleLazyInit":false,"ModulePriority":0,"ModuleHidden":false,"ModuleAlwaysActive":false,"ModuleRequiresPro":false,"TextDomain":"broken-link-checker","virtual":true},"page":{"Name":"P\u00e1ginas","ModuleCategory":"container","ModuleContext":"all","ModuleClassName":"blcAnyPostContainerManager","ModuleID":"page","file":"","ModuleLazyInit":false,"ModulePriority":0,"ModuleHidden":false,"ModuleAlwaysActive":false,"ModuleRequiresPro":false,"TextDomain":"broken-link-checker","virtual":true},"dummy":{"ModuleID":"dummy","ModuleCategory":"container","ModuleContext":"all","ModuleLazyInit":false,"ModuleClassName":"blcDummyManager","ModulePriority":0,"ModuleCheckerUrlPattern":"","ModuleHidden":true,"ModuleAlwaysActive":true,"ModuleRequiresPro":false,"Name":"Dummy","PluginURI":"","Version":"1.0","Description":"","Author":"Janis Elsts","AuthorURI":"","TextDomain":"broken-link-checker","DomainPath":"","Network":false,"Title":"Dummy","AuthorName":"Janis Elsts","file":"containers\/dummy.php"}},"module_deactivated_when":{"custom_field":1397329841},"last_email":{"subject":"[Asug | SAP NetWeaver Portal] Links quebrados encontrados","timestamp":1397334563,"success":false},"plugin_news":["Admin Menu Editor","http:\/\/wordpress.org\/extend\/plugins\/admin-menu-editor\/"]}', 'yes'); 
INSERT INTO `wp_options` VALUES ('168', '_transient_twentyfourteen_category_count', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('169', 'excerpt_everywhere_length', '500', 'yes'); 
INSERT INTO `wp_options` VALUES ('170', 'excerpt_everywhere_align', 'alignleft', 'yes'); 
INSERT INTO `wp_options` VALUES ('171', 'excerpt_everywhere_moretext', 'Detalhes [...]', 'yes'); 
INSERT INTO `wp_options` VALUES ('172', 'excerpt_everywhere_moreimg', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('173', 'excerpt_everywhere_rss', 'yes', 'yes'); 
INSERT INTO `wp_options` VALUES ('174', 'excerpt_everywhere_homepage', 'no', 'yes'); 
INSERT INTO `wp_options` VALUES ('175', 'excerpt_everywhere_sticky', 'no', 'yes'); 
INSERT INTO `wp_options` VALUES ('176', 'excerpt_everywhere_thumb', 'none', 'yes'); 
INSERT INTO `wp_options` VALUES ('185', 'gadash_options', '{"ga_dash_apikey":"","ga_dash_clientid":"","ga_dash_clientsecret":"","ga_dash_access_front":"manage_options","ga_dash_access_back":"manage_options","ga_dash_tableid_jail":"","ga_dash_pgd":0,"ga_dash_rd":0,"ga_dash_sd":0,"ga_dash_map":0,"ga_dash_traffic":0,"ga_dash_style":"#3366CC","ga_dash_jailadmins":1,"ga_dash_cachetime":3600,"ga_dash_tracking":1,"ga_dash_tracking_type":"classic","ga_dash_default_ua":"","ga_dash_anonim":0,"ga_dash_userapi":0,"ga_event_tracking":0,"ga_event_downloads":"zip|mp3|mpeg|pdf|doc*|ppt*|xls*|jpeg|png|gif|tiff","ga_track_exclude":"manage_options","ga_target_geomap":"","ga_target_number":10,"ga_realtime_pages":10,"ga_dash_token":"","ga_dash_refresh_token":"","ga_dash_profile_list":"","ga_dash_tableid":"","ga_dash_frontend_keywords":0,"ga_tracking_code":"","ga_enhanced_links":0,"ga_dash_default_metric":"visits","ga_dash_default_dimension":"30daysAgo","ga_dash_frontend_stats":0}', 'yes'); 
INSERT INTO `wp_options` VALUES ('186', 'seo_friendly_images_alt', '%name %title', 'yes'); 
INSERT INTO `wp_options` VALUES ('187', 'seo_friendly_images_title', '%title', 'yes'); 
INSERT INTO `wp_options` VALUES ('188', 'seo_friendly_images_override', 'on', 'yes'); 
INSERT INTO `wp_options` VALUES ('189', 'seo_friendly_images_override_title', 'off', 'yes'); 
INSERT INTO `wp_options` VALUES ('190', 'excerpt_everywhere_class', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('192', '_transient_random_seed', '95fb5774030de95e31e8e1a5693a726c', 'yes'); 
INSERT INTO `wp_options` VALUES ('198', 'theme_mods_twentyfourteen', 'a:1:{s:16:"sidebars_widgets";a:2:{s:4:"time";i:1394900750;s:4:"data";a:4:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}s:9:"sidebar-2";a:0:{}s:9:"sidebar-3";a:0:{}}}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('199', 'current_theme', 'ASUG', 'yes'); 
INSERT INTO `wp_options` VALUES ('200', 'theme_mods_twentytwelve', 'a:6:{i:0;b:0;s:18:"nav_menu_locations";a:0:{}s:12:"header_image";s:64:"http://127.0.0.1/asug/wp-content/uploads/2014/03/asug-brasil.jpg";s:17:"header_image_data";a:5:{s:13:"attachment_id";i:61;s:3:"url";s:64:"http://127.0.0.1/asug/wp-content/uploads/2014/03/asug-brasil.jpg";s:13:"thumbnail_url";s:64:"http://127.0.0.1/asug/wp-content/uploads/2014/03/asug-brasil.jpg";s:5:"width";i:229;s:6:"height";i:76;}s:16:"header_textcolor";s:5:"blank";s:16:"sidebars_widgets";a:2:{s:4:"time";i:1398209514;s:4:"data";a:6:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:6:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";i:3;s:10:"archives-2";i:4;s:12:"categories-2";i:5;s:6:"meta-2";}s:9:"sidebar-2";a:1:{i:0;s:6:"text-2";}s:9:"sidebar-3";a:0:{}s:5:"wop-1";a:2:{i:0;s:7:"pages-2";i:1;s:6:"text-3";}s:5:"wop-2";a:4:{i:0;s:8:"search-3";i:1;s:17:"recent-comments-3";i:2;s:10:"calendar-2";i:3;s:13:"em_calendar-2";}}}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('201', 'theme_switched', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('202', 'sm_options', 'a:60:{s:18:"sm_b_prio_provider";s:41:"GoogleSitemapGeneratorPrioByCountProvider";s:9:"sm_b_ping";b:1;s:10:"sm_b_stats";b:0;s:12:"sm_b_pingmsn";b:1;s:11:"sm_b_memory";s:0:"";s:9:"sm_b_time";i:-1;s:18:"sm_b_style_default";b:1;s:10:"sm_b_style";s:0:"";s:11:"sm_b_robots";b:1;s:9:"sm_b_html";b:1;s:12:"sm_b_exclude";a:0:{}s:17:"sm_b_exclude_cats";a:0:{}s:10:"sm_in_home";b:1;s:11:"sm_in_posts";b:1;s:15:"sm_in_posts_sub";b:0;s:11:"sm_in_pages";b:1;s:10:"sm_in_cats";b:0;s:10:"sm_in_arch";b:0;s:10:"sm_in_auth";b:0;s:10:"sm_in_tags";b:0;s:9:"sm_in_tax";a:0:{}s:17:"sm_in_customtypes";a:0:{}s:13:"sm_in_lastmod";b:1;s:10:"sm_cf_home";s:5:"daily";s:11:"sm_cf_posts";s:7:"monthly";s:11:"sm_cf_pages";s:6:"weekly";s:10:"sm_cf_cats";s:6:"weekly";s:10:"sm_cf_auth";s:6:"weekly";s:15:"sm_cf_arch_curr";s:5:"daily";s:14:"sm_cf_arch_old";s:6:"yearly";s:10:"sm_cf_tags";s:6:"weekly";s:10:"sm_pr_home";d:1;s:11:"sm_pr_posts";d:0.59999999999999997779553950749686919152736663818359375;s:15:"sm_pr_posts_min";d:0.200000000000000011102230246251565404236316680908203125;s:11:"sm_pr_pages";d:0.59999999999999997779553950749686919152736663818359375;s:10:"sm_pr_cats";d:0.299999999999999988897769753748434595763683319091796875;s:10:"sm_pr_arch";d:0.299999999999999988897769753748434595763683319091796875;s:10:"sm_pr_auth";d:0.299999999999999988897769753748434595763683319091796875;s:10:"sm_pr_tags";d:0.299999999999999988897769753748434595763683319091796875;s:12:"sm_i_donated";b:0;s:17:"sm_i_hide_donated";b:0;s:17:"sm_i_install_date";i:1394901253;s:14:"sm_i_hide_note";b:0;s:15:"sm_i_hide_works";b:0;s:16:"sm_i_hide_donors";b:0;s:9:"sm_i_hash";s:20:"0331706813ee67293627";s:13:"sm_i_lastping";i:1398212516;s:13:"sm_b_filename";s:11:"sitemap.xml";s:10:"sm_b_debug";b:1;s:8:"sm_b_xml";b:1;s:9:"sm_b_gzip";b:1;s:19:"sm_b_manual_enabled";b:0;s:17:"sm_b_auto_enabled";b:1;s:15:"sm_b_auto_delay";b:1;s:15:"sm_b_manual_key";s:32:"0b0518f847adc712682d32a70b511966";s:14:"sm_b_max_posts";i:-1;s:13:"sm_b_safemode";b:0;s:18:"sm_b_location_mode";s:4:"auto";s:20:"sm_b_filename_manual";s:0:"";s:19:"sm_b_fileurl_manual";s:0:"";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('205', 'sm_status', 'O:28:"GoogleSitemapGeneratorStatus":3:{s:39:" GoogleSitemapGeneratorStatus startTime";d:1398212516.0793459415435791015625;s:37:" GoogleSitemapGeneratorStatus endTime";d:1398212517.0279219150543212890625;s:41:" GoogleSitemapGeneratorStatus pingResults";a:2:{s:6:"google";a:5:{s:9:"startTime";d:1398212516.1167280673980712890625;s:7:"endTime";d:1398212516.5344679355621337890625;s:7:"success";b:0;s:3:"url";s:98:"http://www.google.com/webmasters/sitemaps/ping?sitemap=http%3A%2F%2F127.0.0.1%2Fasug%2Fsitemap.xml";s:4:"name";s:6:"Google";}s:4:"bing";a:5:{s:9:"startTime";d:1398212516.593164920806884765625;s:7:"endTime";d:1398212516.950378894805908203125;s:7:"success";b:1;s:3:"url";s:91:"http://www.bing.com/webmaster/ping.aspx?siteMap=http%3A%2F%2F127.0.0.1%2Fasug%2Fsitemap.xml";s:4:"name";s:4:"Bing";}}}', 'no'); 
INSERT INTO `wp_options` VALUES ('222', 'nav_menu_options', 'a:2:{i:0;b:0;s:8:"auto_add";a:0:{}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('263', 'sam_pointers', 'a:4:{s:6:"places";b:0;s:3:"ads";b:0;s:5:"zones";b:0;s:6:"blocks";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('276', 'adrotate_db_timer', '1394949155', 'yes'); 
INSERT INTO `wp_options` VALUES ('301', 'dfads_transient_data_deleted_time', '1398384395', 'yes'); 
INSERT INTO `wp_options` VALUES ('302', 'nextend_error', 'a:1:{s:13:"missingfooter";a:1:{i:0;s:6:"/asug/";}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('303', 'dfads-settings', 'a:1:{s:28:"dfads_enable_count_for_admin";s:1:"1";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('309', 'dfads_group_children', 'a:0:{}', 'yes'); 
INSERT INTO `wp_options` VALUES ('404', 'dbem_events_page', '79', 'yes'); 
INSERT INTO `wp_options` VALUES ('405', 'dbem_locations_page', '80', 'yes'); 
INSERT INTO `wp_options` VALUES ('406', 'dbem_categories_page', '81', 'yes'); 
INSERT INTO `wp_options` VALUES ('407', 'dbem_tags_page', '82', 'yes'); 
INSERT INTO `wp_options` VALUES ('408', 'dbem_my_bookings_page', '83', 'yes'); 
INSERT INTO `wp_options` VALUES ('409', 'dbem_hello_to_user', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('410', 'dbem_time_format', 'H:i', 'yes'); 
INSERT INTO `wp_options` VALUES ('411', 'dbem_date_format', 'd/m/Y', 'yes'); 
INSERT INTO `wp_options` VALUES ('412', 'dbem_date_format_js', 'dd/mm/yy', 'yes'); 
INSERT INTO `wp_options` VALUES ('413', 'dbem_dates_separator', ' - ', 'yes'); 
INSERT INTO `wp_options` VALUES ('414', 'dbem_times_separator', ' - ', 'yes'); 
INSERT INTO `wp_options` VALUES ('415', 'dbem_default_category', '-1', 'yes'); 
INSERT INTO `wp_options` VALUES ('416', 'dbem_default_location', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('417', 'dbem_events_default_orderby', 'event_start_date,event_start_time,event_name', 'yes'); 
INSERT INTO `wp_options` VALUES ('418', 'dbem_events_default_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('420', 'dbem_events_default_limit', '10', 'yes'); 
INSERT INTO `wp_options` VALUES ('421', 'dbem_search_form_submit', 'Buscar', 'yes'); 
INSERT INTO `wp_options` VALUES ('422', 'dbem_search_form_advanced', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('423', 'dbem_search_form_advanced_hidden', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('424', 'dbem_search_form_advanced_show', 'Show Advanced Search', 'yes'); 
INSERT INTO `wp_options` VALUES ('425', 'dbem_search_form_advanced_hide', 'Hide Advanced Search', 'yes'); 
INSERT INTO `wp_options` VALUES ('426', 'dbem_search_form_text', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('427', 'dbem_search_form_text_label', 'Buscar', 'yes'); 
INSERT INTO `wp_options` VALUES ('428', 'dbem_search_form_geo', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('429', 'dbem_search_form_geo_label', 'Near...', 'yes'); 
INSERT INTO `wp_options` VALUES ('430', 'dbem_search_form_geo_units', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('431', 'dbem_search_form_geo_units_label', 'Within', 'yes'); 
INSERT INTO `wp_options` VALUES ('432', 'dbem_search_form_geo_unit_default', 'mi', 'yes'); 
INSERT INTO `wp_options` VALUES ('433', 'dbem_search_form_geo_distance_default', '25', 'yes'); 
INSERT INTO `wp_options` VALUES ('434', 'dbem_search_form_dates', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('435', 'dbem_search_form_dates_label', 'Dates', 'yes'); 
INSERT INTO `wp_options` VALUES ('436', 'dbem_search_form_dates_separator', 'e', 'yes'); 
INSERT INTO `wp_options` VALUES ('437', 'dbem_search_form_categories', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('438', 'dbem_search_form_categories_label', 'Todas as Categorias', 'yes'); 
INSERT INTO `wp_options` VALUES ('439', 'dbem_search_form_category_label', 'Categoria', 'yes'); 
INSERT INTO `wp_options` VALUES ('440', 'dbem_search_form_countries', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('441', 'dbem_search_form_default_country', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('442', 'dbem_search_form_countries_label', 'Todos os Países', 'yes'); 
INSERT INTO `wp_options` VALUES ('443', 'dbem_search_form_country_label', 'País', 'yes'); 
INSERT INTO `wp_options` VALUES ('444', 'dbem_search_form_regions', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('445', 'dbem_search_form_regions_label', 'Todas as Regiões', 'yes'); 
INSERT INTO `wp_options` VALUES ('446', 'dbem_search_form_region_label', 'Region', 'yes'); 
INSERT INTO `wp_options` VALUES ('447', 'dbem_search_form_states', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('448', 'dbem_search_form_states_label', 'Todos os Estados', 'yes'); 
INSERT INTO `wp_options` VALUES ('449', 'dbem_search_form_state_label', 'State/County', 'yes'); 
INSERT INTO `wp_options` VALUES ('450', 'dbem_search_form_towns', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('451', 'dbem_search_form_towns_label', 'All Cities/Towns', 'yes'); 
INSERT INTO `wp_options` VALUES ('452', 'dbem_search_form_town_label', 'City/Town', 'yes'); 
INSERT INTO `wp_options` VALUES ('453', 'dbem_events_form_editor', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('454', 'dbem_events_form_reshow', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('459', 'dbem_events_form_result_success', 'You have successfully submitted your event, which will be published pending approval.', 'yes'); 
INSERT INTO `wp_options` VALUES ('460', 'dbem_events_form_result_success_updated', 'You have successfully updated your event, which will be republished pending approval.', 'yes'); 
INSERT INTO `wp_options` VALUES ('461', 'dbem_events_anonymous_submissions', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('462', 'dbem_events_anonymous_user', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('463', 'dbem_events_anonymous_result_success', 'You have successfully submitted your event, which will be published pending approval.', 'yes'); 
INSERT INTO `wp_options` VALUES ('464', 'dbem_event_submitted_email_admin', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('465', 'dbem_event_submitted_email_subject', 'Submitted Event Awaiting Approval', 'yes'); 
INSERT INTO `wp_options` VALUES ('466', 'dbem_event_submitted_email_body', 'A new event has been submitted by #_CONTACTNAME.

Name : #_EVENTNAME 

Date : #_EVENTDATES 

Time : #_EVENTTIMES 

Please visit http://127.0.0.1/asug/wp-admin/post.php?action=edit&post=#_EVENTPOSTID to review this event for approval.


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('467', 'dbem_event_resubmitted_email_subject', 'Re-Submitted Event Awaiting Approval', 'yes'); 
INSERT INTO `wp_options` VALUES ('468', 'dbem_event_resubmitted_email_body', 'A previously published event has been modified by #_CONTACTNAME, and this event is now unpublished and pending your approval.

Name : #_EVENTNAME 

Date : #_EVENTDATES 

Time : #_EVENTTIMES 

Please visit http://127.0.0.1/asug/wp-admin/post.php?action=edit&post=#_EVENTPOSTID to review this event for approval.


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('469', 'dbem_event_published_email_subject', 'Published Event - #_EVENTNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('470', 'dbem_event_published_email_body', 'A new event has been published by #_CONTACTNAME.

Name : #_EVENTNAME 

Date : #_EVENTDATES 

Time : #_EVENTTIMES 

Edit this event - http://127.0.0.1/asug/wp-admin/post.php?action=edit&post=#_EVENTPOSTID 

 View this event - #_EVENTURL


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('471', 'dbem_event_approved_email_subject', 'Event Approved - #_EVENTNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('472', 'dbem_event_approved_email_body', 'Dear #_CONTACTNAME, 

Your event #_EVENTNAME on #_EVENTDATES has been approved.

You can view your event here: #_EVENTURL


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('473', 'dbem_event_reapproved_email_subject', 'Event Approved - #_EVENTNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('474', 'dbem_event_reapproved_email_body', 'Dear #_CONTACTNAME, 

Your event #_EVENTNAME on #_EVENTDATES has been approved.

You can view your event here: #_EVENTURL


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('475', 'dbem_events_page_title', 'Eventos', 'yes'); 
INSERT INTO `wp_options` VALUES ('476', 'dbem_events_page_scope', 'future', 'yes'); 
INSERT INTO `wp_options` VALUES ('477', 'dbem_events_page_search_form', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('478', 'dbem_event_list_item_format_header', '<table cellpadding="0" cellspacing="0" class="events-table" >
    <thead>
        <tr>
			<th class="event-time" width="150">Data / Hora</th>
			<th class="event-description" width="*">Evento</th>
		</tr>
   	</thead>
    <tbody>', 'yes'); 
INSERT INTO `wp_options` VALUES ('479', 'dbem_event_list_item_format', '<tr>
			<td>
                #_EVENTDATES<br/>
                #_EVENTTIMES
            </td>
            <td>
                #_EVENTLINK
                {has_location}<br/><i>#_LOCATIONNAME, #_LOCATIONTOWN #_LOCATIONSTATE</i>{/has_location}
            </td>
        </tr>', 'yes'); 
INSERT INTO `wp_options` VALUES ('480', 'dbem_event_list_item_format_footer', '</tbody></table>', 'yes'); 
INSERT INTO `wp_options` VALUES ('481', 'dbem_display_calendar_in_events_page', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('482', 'dbem_single_event_format', '<div style="float:right; margin:0px 0px 15px 15px;">#_LOCATIONMAP</div>
<p>
	<strong>Data / Hora</strong><br/>
	Date(s) - #_EVENTDATES<br /><i>#_EVENTTIMES</i>
</p>
{has_location}
<p>
	<strong>Localização</strong><br/>
	#_LOCATIONLINK
</p>
{/has_location}
<p>
	<strong>Categorias</strong>
	#_CATEGORIES
</p>
<br style="clear:both" />
#_EVENTNOTES
{has_bookings}
<h3>Bookings</h3>
#_BOOKINGFORM
{/has_bookings}', 'yes'); 
INSERT INTO `wp_options` VALUES ('483', 'dbem_event_page_title_format', '#_EVENTNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('484', 'dbem_event_all_day_message', 'All Day', 'yes'); 
INSERT INTO `wp_options` VALUES ('485', 'dbem_no_events_message', 'Não Eventos', 'yes'); 
INSERT INTO `wp_options` VALUES ('486', 'dbem_locations_default_orderby', 'location_name', 'yes'); 
INSERT INTO `wp_options` VALUES ('487', 'dbem_locations_default_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('488', 'dbem_locations_default_limit', '10', 'yes'); 
INSERT INTO `wp_options` VALUES ('489', 'dbem_locations_page_title', 'Evento Locais', 'yes'); 
INSERT INTO `wp_options` VALUES ('490', 'dbem_locations_page_search_form', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('491', 'dbem_no_locations_message', 'Não Locais', 'yes'); 
INSERT INTO `wp_options` VALUES ('492', 'dbem_location_default_country', 'BR', 'yes'); 
INSERT INTO `wp_options` VALUES ('493', 'dbem_location_list_item_format_header', '<ul class="em-locations-list">', 'yes'); 
INSERT INTO `wp_options` VALUES ('494', 'dbem_location_list_item_format', '<li>#_LOCATIONLINK<ul><li>#_LOCATIONFULLLINE</li></ul></li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('495', 'dbem_location_list_item_format_footer', '</ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('496', 'dbem_location_page_title_format', '#_LOCATIONNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('497', 'dbem_single_location_format', '<div style="float:right; margin:0px 0px 15px 15px;">#_LOCATIONMAP</div>
<p>
	<strong>Endereço</strong><br/>
	#_LOCATIONADDRESS<br/>
	#_LOCATIONTOWN<br/>
	#_LOCATIONSTATE<br/>
	#_LOCATIONREGION<br/>
	#_LOCATIONPOSTCODE<br/>
	#_LOCATIONCOUNTRY
</p>
<br style="clear:both" />
#_LOCATIONNOTES

<h3>Upcoming Events</h3>
<p>#_LOCATIONNEXTEVENTS</p>', 'yes'); 
INSERT INTO `wp_options` VALUES ('498', 'dbem_location_no_events_message', '<li>No events in this location</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('499', 'dbem_location_event_list_item_header_format', '<ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('500', 'dbem_location_event_list_item_format', '<li>#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('501', 'dbem_location_event_list_item_footer_format', '</ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('502', 'dbem_location_event_list_limit', '20', 'yes'); 
INSERT INTO `wp_options` VALUES ('503', 'dbem_location_event_single_format', '#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES', 'yes'); 
INSERT INTO `wp_options` VALUES ('504', 'dbem_location_no_event_message', 'No events in this location', 'yes'); 
INSERT INTO `wp_options` VALUES ('505', 'dbem_categories_default_limit', '10', 'yes'); 
INSERT INTO `wp_options` VALUES ('506', 'dbem_categories_default_orderby', 'name', 'yes'); 
INSERT INTO `wp_options` VALUES ('507', 'dbem_categories_default_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('508', 'dbem_categories_list_item_format_header', '<ul class="em-categories-list">', 'yes'); 
INSERT INTO `wp_options` VALUES ('509', 'dbem_categories_list_item_format', '<li>#_CATEGORYLINK</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('510', 'dbem_categories_list_item_format_footer', '</ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('511', 'dbem_no_categories_message', 'Não Categorias', 'yes'); 
INSERT INTO `wp_options` VALUES ('512', 'dbem_category_page_title_format', '#_CATEGORYNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('513', 'dbem_category_page_format', '#_CATEGORYNOTES<h3>Upcoming Events</h3>#_CATEGORYNEXTEVENTS', 'yes'); 
INSERT INTO `wp_options` VALUES ('514', 'dbem_category_no_events_message', '<li>No events in this category</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('515', 'dbem_category_event_list_item_header_format', '<ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('516', 'dbem_category_event_list_item_format', '<li>#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('517', 'dbem_category_event_list_item_footer_format', '</ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('518', 'dbem_category_event_list_limit', '20', 'yes'); 
INSERT INTO `wp_options` VALUES ('519', 'dbem_category_event_single_format', '#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES', 'yes'); 
INSERT INTO `wp_options` VALUES ('520', 'dbem_category_no_event_message', 'No events in this category', 'yes'); 
INSERT INTO `wp_options` VALUES ('521', 'dbem_tags_default_limit', '10', 'yes'); 
INSERT INTO `wp_options` VALUES ('522', 'dbem_tags_default_orderby', 'name', 'yes'); 
INSERT INTO `wp_options` VALUES ('523', 'dbem_tags_default_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('524', 'dbem_tags_list_item_format_header', '<ul class="em-tags-list">', 'yes'); 
INSERT INTO `wp_options` VALUES ('525', 'dbem_tags_list_item_format', '<li>#_TAGLINK</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('526', 'dbem_tags_list_item_format_footer', '</ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('527', 'dbem_no_tags_message', 'Não Tags', 'yes'); 
INSERT INTO `wp_options` VALUES ('528', 'dbem_tag_page_title_format', '#_TAGNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('529', 'dbem_tag_page_format', '<h3>Upcoming Events</h3>#_TAGNEXTEVENTS', 'yes'); 
INSERT INTO `wp_options` VALUES ('530', 'dbem_tag_no_events_message', '<li>No events with this tag</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('531', 'dbem_tag_event_list_item_header_format', '<ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('532', 'dbem_tag_event_list_item_format', '<li>#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('533', 'dbem_tag_event_list_item_footer_format', '</ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('534', 'dbem_tag_event_single_format', '#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES', 'yes'); 
INSERT INTO `wp_options` VALUES ('535', 'dbem_tag_no_event_message', 'No events with this tag', 'yes'); 
INSERT INTO `wp_options` VALUES ('536', 'dbem_tag_event_list_limit', '20', 'yes'); 
INSERT INTO `wp_options` VALUES ('537', 'dbem_rss_limit', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('538', 'dbem_rss_scope', 'future', 'yes'); 
INSERT INTO `wp_options` VALUES ('539', 'dbem_rss_main_title', 'Asug | SAP NetWeaver Portal - Eventos', 'yes'); 
INSERT INTO `wp_options` VALUES ('540', 'dbem_rss_main_description', 'Só mais um site WordPress - Eventos', 'yes'); 
INSERT INTO `wp_options` VALUES ('541', 'dbem_rss_description_format', '#_EVENTDATES - #_EVENTTIMES <br/>#_LOCATIONNAME <br/>#_LOCATIONADDRESS <br/>#_LOCATIONTOWN', 'yes'); 
INSERT INTO `wp_options` VALUES ('542', 'dbem_rss_title_format', '#_EVENTNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('543', 'em_rss_pubdate', 'Sun, 16 Mar 2014 22:39:36 +0000', 'yes'); 
INSERT INTO `wp_options` VALUES ('544', 'dbem_ical_limit', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('545', 'dbem_ical_scope', 'future', 'yes'); 
INSERT INTO `wp_options` VALUES ('546', 'dbem_ical_description_format', '#_EVENTNAME - #_LOCATIONNAME - #_EVENTDATES - #_EVENTTIMES', 'yes'); 
INSERT INTO `wp_options` VALUES ('547', 'dbem_ical_real_description_format', '#_EVENTEXCERPT', 'yes'); 
INSERT INTO `wp_options` VALUES ('548', 'dbem_ical_location_format', '#_LOCATION', 'yes'); 
INSERT INTO `wp_options` VALUES ('549', 'dbem_gmap_is_active', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('550', 'dbem_map_default_width', '400px', 'yes'); 
INSERT INTO `wp_options` VALUES ('551', 'dbem_map_default_height', '300px', 'yes'); 
INSERT INTO `wp_options` VALUES ('552', 'dbem_location_baloon_format', '<strong>#_LOCATIONNAME</strong><br/>#_LOCATIONADDRESS - #_LOCATIONTOWN<br/><a href="#_LOCATIONPAGEURL">Eventos</a>', 'yes'); 
INSERT INTO `wp_options` VALUES ('553', 'dbem_map_text_format', '<strong>#_LOCATIONNAME</strong><p>#_LOCATIONADDRESS</p><p>#_LOCATIONTOWN</p>', 'yes'); 
INSERT INTO `wp_options` VALUES ('554', 'dbem_email_disable_registration', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('555', 'dbem_rsvp_mail_port', '465', 'yes'); 
INSERT INTO `wp_options` VALUES ('556', 'dbem_smtp_host', 'localhost', 'yes'); 
INSERT INTO `wp_options` VALUES ('557', 'dbem_mail_sender_name', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('558', 'dbem_rsvp_mail_send_method', 'mail', 'yes'); 
INSERT INTO `wp_options` VALUES ('559', 'dbem_rsvp_mail_SMTPAuth', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('560', 'dbem_smtp_html', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('561', 'dbem_smtp_html_br', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('562', 'dbem_image_max_width', '700', 'yes'); 
INSERT INTO `wp_options` VALUES ('563', 'dbem_image_max_height', '700', 'yes'); 
INSERT INTO `wp_options` VALUES ('564', 'dbem_image_min_width', '50', 'yes'); 
INSERT INTO `wp_options` VALUES ('565', 'dbem_image_min_height', '50', 'yes'); 
INSERT INTO `wp_options` VALUES ('566', 'dbem_image_max_size', '204800', 'yes'); 
INSERT INTO `wp_options` VALUES ('567', 'dbem_list_date_title', 'Eventos - #j #M #y', 'yes'); 
INSERT INTO `wp_options` VALUES ('568', 'dbem_full_calendar_month_format', 'M Y', 'yes'); 
INSERT INTO `wp_options` VALUES ('569', 'dbem_full_calendar_event_format', '<li>#_EVENTLINK</li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('570', 'dbem_full_calendar_long_events', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('571', 'dbem_full_calendar_initials_length', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('572', 'dbem_full_calendar_abbreviated_weekdays', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('573', 'dbem_display_calendar_day_single_yes', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('574', 'dbem_small_calendar_month_format', 'M Y', 'yes'); 
INSERT INTO `wp_options` VALUES ('575', 'dbem_small_calendar_event_title_format', '#_EVENTNAME', 'yes'); 
INSERT INTO `wp_options` VALUES ('576', 'dbem_small_calendar_event_title_separator', ', ', 'yes'); 
INSERT INTO `wp_options` VALUES ('577', 'dbem_small_calendar_initials_length', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('578', 'dbem_small_calendar_abbreviated_weekdays', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('579', 'dbem_display_calendar_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('580', 'dbem_display_calendar_orderby', 'event_name,event_start_time', 'yes'); 
INSERT INTO `wp_options` VALUES ('581', 'dbem_display_calendar_events_limit', '3', 'yes'); 
INSERT INTO `wp_options` VALUES ('582', 'dbem_display_calendar_events_limit_msg', 'more...', 'yes'); 
INSERT INTO `wp_options` VALUES ('583', 'dbem_calendar_direct_links', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('584', 'dbem_require_location', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('585', 'dbem_locations_enabled', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('586', 'dbem_use_select_for_locations', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('587', 'dbem_attributes_enabled', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('588', 'dbem_recurrence_enabled', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('589', 'dbem_rsvp_enabled', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('590', 'dbem_categories_enabled', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('591', 'dbem_tags_enabled', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('592', 'dbem_placeholders_custom', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('593', 'dbem_location_attributes_enabled', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('594', 'dbem_location_placeholders_custom', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('595', 'dbem_bookings_registration_disable', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('596', 'dbem_bookings_registration_disable_user_emails', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('597', 'dbem_bookings_registration_user', '4', 'yes'); 
INSERT INTO `wp_options` VALUES ('598', 'dbem_bookings_approval', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('599', 'dbem_bookings_approval_reserved', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('600', 'dbem_bookings_approval_overbooking', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('601', 'dbem_bookings_double', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('602', 'dbem_bookings_user_cancellation', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('603', 'dbem_bookings_currency', 'BRL', 'yes'); 
INSERT INTO `wp_options` VALUES ('604', 'dbem_bookings_currency_decimal_point', ',', 'yes'); 
INSERT INTO `wp_options` VALUES ('605', 'dbem_bookings_currency_thousands_sep', '.', 'yes'); 
INSERT INTO `wp_options` VALUES ('606', 'dbem_bookings_currency_format', '@#', 'yes'); 
INSERT INTO `wp_options` VALUES ('607', 'dbem_bookings_tax', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('608', 'dbem_bookings_tax_auto_add', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('609', 'dbem_bookings_submit_button', 'Enviar a sua reserva', 'yes'); 
INSERT INTO `wp_options` VALUES ('610', 'dbem_bookings_login_form', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('611', 'dbem_bookings_anonymous', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('612', 'dbem_bookings_form_max', '20', 'yes'); 
INSERT INTO `wp_options` VALUES ('613', 'dbem_bookings_form_msg_disabled', 'Reservas on-line não estão disponíveis para este evento.', 'yes'); 
INSERT INTO `wp_options` VALUES ('614', 'dbem_bookings_form_msg_closed', 'As reservas estão fechados para este evento.', 'yes'); 
INSERT INTO `wp_options` VALUES ('615', 'dbem_bookings_form_msg_full', 'This event is fully booked.', 'yes'); 
INSERT INTO `wp_options` VALUES ('616', 'dbem_bookings_form_msg_attending', 'You are currently attending this event.', 'yes'); 
INSERT INTO `wp_options` VALUES ('617', 'dbem_bookings_form_msg_bookings_link', 'Manage my bookings', 'yes'); 
INSERT INTO `wp_options` VALUES ('618', 'dbem_booking_warning_cancel', 'Tem certeza de que deseja cancelar a sua reserva?', 'yes'); 
INSERT INTO `wp_options` VALUES ('619', 'dbem_booking_feedback_cancelled', 'Reserva Cancelado', 'yes'); 
INSERT INTO `wp_options` VALUES ('620', 'dbem_booking_feedback_pending', 'Confirmação de reserva bem sucedida, aguardando confirmação(você também receberá um e-mail uma vez confirmado).', 'yes'); 
INSERT INTO `wp_options` VALUES ('621', 'dbem_booking_feedback', 'Reserva  feita com sucesso.', 'yes'); 
INSERT INTO `wp_options` VALUES ('622', 'dbem_booking_feedback_full', 'A sua reserva não pode ser efetuada, não há lugares disponíveis!', 'yes'); 
INSERT INTO `wp_options` VALUES ('623', 'dbem_booking_feedback_log_in', 'Você deve fazer login ou registre-se para fazer uma reserva.', 'yes'); 
INSERT INTO `wp_options` VALUES ('624', 'dbem_booking_feedback_nomail', 'No entanto, tivemos problemas ao enviar um e-mail de confirmação para você e / ou a pessoa de contacto evento. Você também pode entrar em contato diretamente, informando sobre o erro.', 'yes'); 
INSERT INTO `wp_options` VALUES ('625', 'dbem_booking_feedback_error', 'Reserva não  pôde  ser criada:', 'yes'); 
INSERT INTO `wp_options` VALUES ('626', 'dbem_booking_feedback_email_exists', 'Este e-mail já existe em nosso sistema, faça o login para registar-se e prosseguir com a sua reserva.', 'yes'); 
INSERT INTO `wp_options` VALUES ('627', 'dbem_booking_feedback_new_user', 'Uma nova conta de usuário foi criado para você. Por favor verifique seu e-mail para detalhes de acesso.', 'yes'); 
INSERT INTO `wp_options` VALUES ('628', 'dbem_booking_feedback_reg_error', 'Houve um problema ao criar uma conta de usuário, por favor entre em com o administrador do site.', 'yes'); 
INSERT INTO `wp_options` VALUES ('629', 'dbem_booking_feedback_already_booked', 'Você já tem reservado um lugar neste evento.', 'yes'); 
INSERT INTO `wp_options` VALUES ('630', 'dbem_booking_feedback_min_space', 'Você deve solicitar pelo menos um espaço para reservar um evento.', 'yes'); 
INSERT INTO `wp_options` VALUES ('631', 'dbem_booking_feedback_spaces_limit', 'You cannot book more than %d spaces for this event.', 'yes'); 
INSERT INTO `wp_options` VALUES ('632', 'dbem_booking_button_msg_book', 'Reserve agora', 'yes'); 
INSERT INTO `wp_options` VALUES ('633', 'dbem_booking_button_msg_booking', 'Reserva ...', 'yes'); 
INSERT INTO `wp_options` VALUES ('634', 'dbem_booking_button_msg_booked', 'Reserva Submitted', 'yes'); 
INSERT INTO `wp_options` VALUES ('635', 'dbem_booking_button_msg_already_booked', 'Already Booked', 'yes'); 
INSERT INTO `wp_options` VALUES ('636', 'dbem_booking_button_msg_error', 'Reserva Error. Try again?', 'yes'); 
INSERT INTO `wp_options` VALUES ('637', 'dbem_booking_button_msg_full', 'Sold Out', 'yes'); 
INSERT INTO `wp_options` VALUES ('638', 'dbem_booking_button_msg_cancel', 'Cancelar', 'yes'); 
INSERT INTO `wp_options` VALUES ('639', 'dbem_booking_button_msg_canceling', 'Canceling...', 'yes'); 
INSERT INTO `wp_options` VALUES ('640', 'dbem_booking_button_msg_cancelled', 'Cancelado', 'yes'); 
INSERT INTO `wp_options` VALUES ('641', 'dbem_booking_button_msg_cancel_error', 'Cancellation Error. Try again?', 'yes'); 
INSERT INTO `wp_options` VALUES ('642', 'dbem_bookings_notify_admin', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('643', 'dbem_bookings_contact_email', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('644', 'dbem_bookings_contact_email_subject', 'New Booking', 'yes'); 
INSERT INTO `wp_options` VALUES ('645', 'dbem_bookings_contact_email_body', '#_BOOKINGNAME (#_BOOKINGEMAIL) will attend #_EVENTNAME on #_EVENTDATES. He wants to reserve #_BOOKINGSPACES spaces.

 Now there are #_BOOKEDSPACES spaces reserved, #_AVAILABLESPACES are still available.

Yours faithfully,

Events Manager - http://wp-events-plugin.com


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('646', 'dbem_contactperson_email_cancelled_subject', 'Reserva cancelada', 'yes'); 
INSERT INTO `wp_options` VALUES ('647', 'dbem_contactperson_email_cancelled_body', '#_BOOKINGNAME (#_BOOKINGEMAIL) cancelled his booking at #_EVENTNAME on #_EVENTDATES. He wanted to reserve #_BOOKINGSPACES spaces.

 Now there are #_BOOKEDSPACES spaces reserved, #_AVAILABLESPACES are still available.

Yours faithfully,

Events Manager - http://wp-events-plugin.com


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('648', 'dbem_bookings_email_pending_subject', 'Reserva Pendente', 'yes'); 
INSERT INTO `wp_options` VALUES ('649', 'dbem_bookings_email_pending_body', 'Dear #_BOOKINGNAME, 

You have requested #_BOOKINGSPACES space/spaces for #_EVENTNAME.

When : #_EVENTDATES @ #_EVENTTIMES

Where : #_LOCATIONNAME - #_LOCATIONFULLLINE

Your booking is currently pending approval by our administrators. Once approved you will receive an automatic confirmation.

Yours faithfully,

#_CONTACTNAME


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('650', 'dbem_bookings_email_rejected_subject', 'Reserva Rejeitada', 'yes'); 
INSERT INTO `wp_options` VALUES ('651', 'dbem_bookings_email_rejected_body', 'Dear #_BOOKINGNAME, 

Your requested booking for #_BOOKINGSPACES spaces at #_EVENTNAME on #_EVENTDATES has been rejected.

Yours faithfully,

#_CONTACTNAME


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('652', 'dbem_bookings_email_confirmed_subject', 'Reserva Confirmada', 'yes'); 
INSERT INTO `wp_options` VALUES ('653', 'dbem_bookings_email_confirmed_body', 'Dear #_BOOKINGNAME, 

You have successfully reserved #_BOOKINGSPACES space/spaces for #_EVENTNAME.

When : #_EVENTDATES @ #_EVENTTIMES

Where : #_LOCATIONNAME - #_LOCATIONFULLLINE

Yours faithfully,

#_CONTACTNAME


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('654', 'dbem_bookings_email_cancelled_subject', 'Reserva cancelada', 'yes'); 
INSERT INTO `wp_options` VALUES ('655', 'dbem_bookings_email_cancelled_body', 'Dear #_BOOKINGNAME, 

Your requested booking for #_BOOKINGSPACES spaces at #_EVENTNAME on #_EVENTDATES has been cancelled.

Yours faithfully,

#_CONTACTNAME


-------------------------------

Powered by Events Manager - http://wp-events-plugin.com', 'yes'); 
INSERT INTO `wp_options` VALUES ('656', 'dbem_bookings_email_registration_subject', '[Asug | SAP NetWeaver Portal] O seu nome de usuário e senha', 'yes'); 
INSERT INTO `wp_options` VALUES ('657', 'dbem_bookings_email_registration_body', 'You have successfully created an account at Asug | SAP NetWeaver Portal

You can log into our site here : http://127.0.0.1/asug/wp-login.php

Nome de Usuário : %username%

Senha : %password%

To view your bookings, please visit http://127.0.0.1/asug/eventos/minhas-reservas/ after logging in.', 'yes'); 
INSERT INTO `wp_options` VALUES ('658', 'dbem_bookings_tickets_orderby', 'ticket_price DESC, ticket_name ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('659', 'dbem_bookings_tickets_priority', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('660', 'dbem_bookings_tickets_show_unavailable', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('661', 'dbem_bookings_tickets_show_loggedout', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('662', 'dbem_bookings_tickets_single', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('663', 'dbem_bookings_tickets_single_form', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('664', 'dbem_bookings_my_title_format', 'Minhas Reservas', 'yes'); 
INSERT INTO `wp_options` VALUES ('665', 'dbem_bp_events_list_format_header', '<ul class="em-events-list">', 'yes'); 
INSERT INTO `wp_options` VALUES ('666', 'dbem_bp_events_list_format', '<li>#_EVENTLINK - #_EVENTDATES - #_EVENTTIMES<ul><li>#_LOCATIONLINK - #_LOCATIONADDRESS, #_LOCATIONTOWN</li></ul></li>', 'yes'); 
INSERT INTO `wp_options` VALUES ('667', 'dbem_bp_events_list_format_footer', '</ul>', 'yes'); 
INSERT INTO `wp_options` VALUES ('668', 'dbem_bp_events_list_none_format', '<p class="em-events-list">Nenhum Eventos</p>', 'yes'); 
INSERT INTO `wp_options` VALUES ('669', 'dbem_css_editors', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('670', 'dbem_css_rsvp', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('671', 'dbem_css_rsvpadmin', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('672', 'dbem_css_evlist', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('673', 'dbem_css_search', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('674', 'dbem_css_loclist', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('675', 'dbem_css_catlist', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('676', 'dbem_css_taglist', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('677', 'dbem_cp_events_slug', 'events', 'yes'); 
INSERT INTO `wp_options` VALUES ('678', 'dbem_cp_locations_slug', 'locations', 'yes'); 
INSERT INTO `wp_options` VALUES ('679', 'dbem_taxonomy_category_slug', 'events/categories', 'yes'); 
INSERT INTO `wp_options` VALUES ('680', 'dbem_taxonomy_tag_slug', 'events/tags', 'yes'); 
INSERT INTO `wp_options` VALUES ('681', 'dbem_cp_events_template', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('682', 'dbem_cp_events_body_class', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('683', 'dbem_cp_events_post_class', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('684', 'dbem_cp_events_formats', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('685', 'dbem_cp_events_has_archive', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('686', 'dbem_events_default_archive_orderby', '_start_ts', 'yes'); 
INSERT INTO `wp_options` VALUES ('687', 'dbem_events_default_archive_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('688', 'dbem_events_archive_scope', 'past', 'yes'); 
INSERT INTO `wp_options` VALUES ('689', 'dbem_cp_events_archive_formats', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('690', 'dbem_cp_events_search_results', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('691', 'dbem_cp_events_custom_fields', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('692', 'dbem_cp_events_comments', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('693', 'dbem_cp_locations_template', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('694', 'dbem_cp_locations_body_class', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('695', 'dbem_cp_locations_post_class', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('696', 'dbem_cp_locations_formats', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('697', 'dbem_cp_locations_has_archive', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('698', 'dbem_locations_default_archive_orderby', 'title', 'yes'); 
INSERT INTO `wp_options` VALUES ('699', 'dbem_locations_default_archive_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('700', 'dbem_cp_locations_archive_formats', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('701', 'dbem_cp_locations_search_results', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('702', 'dbem_cp_locations_custom_fields', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('703', 'dbem_cp_locations_comments', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('704', 'dbem_cp_categories_formats', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('705', 'dbem_categories_default_archive_orderby', '_start_ts', 'yes'); 
INSERT INTO `wp_options` VALUES ('706', 'dbem_categories_default_archive_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('707', 'dbem_cp_tags_formats', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('708', 'dbem_tags_default_archive_orderby', '_start_ts', 'yes'); 
INSERT INTO `wp_options` VALUES ('709', 'dbem_tags_default_archive_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('710', 'dbem_credits', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('711', 'dbem_time_24h', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('712', 'dbem_version', '5.52', 'yes'); 
INSERT INTO `wp_options` VALUES ('718', 'tchpcs_displayimage', 'YES', 'yes'); 
INSERT INTO `wp_options` VALUES ('719', 'tchpcs_word_limit', '9', 'yes'); 
INSERT INTO `wp_options` VALUES ('720', 'tchpcs_query_posts_showposts', '3', 'yes'); 
INSERT INTO `wp_options` VALUES ('721', 'tchpcs_query_posts_orderby', 'date', 'yes'); 
INSERT INTO `wp_options` VALUES ('722', 'tchpcs_query_posts_order', 'DESC', 'yes'); 
INSERT INTO `wp_options` VALUES ('723', 'tchpcs_query_posts_category', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('957', 'shop_catalog_image_size', 'a:3:{s:5:"width";s:3:"150";s:6:"height";s:3:"150";s:4:"crop";b:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('958', 'shop_single_image_size', 'a:3:{s:5:"width";s:3:"300";s:6:"height";s:3:"300";s:4:"crop";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('959', 'shop_thumbnail_image_size', 'a:3:{s:5:"width";s:2:"90";s:6:"height";s:2:"90";s:4:"crop";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1020', '_transient_woocommerce_processing_order_count', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1031', '_transient_woocommerce_cache_excluded_uris', 'a:6:{i:0;s:4:"p=97";i:1;s:4:"p=98";i:2;s:4:"p=99";i:3;s:9:"/carrinho";i:4;s:17:"/finalizar-compra";i:5;s:12:"/minha-conta";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1036', 'user_role_editor', 'a:4:{s:17:"ure_caps_readable";i:0;s:24:"ure_show_deprecated_caps";i:0;s:19:"ure_hide_pro_banner";i:0;s:15:"show_admin_role";s:1:"1";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1037', 'wp_backup_user_roles', 'a:7:{s:13:"administrator";a:2:{s:4:"name";s:13:"Administrator";s:12:"capabilities";a:138:{s:13:"switch_themes";b:1;s:11:"edit_themes";b:1;s:16:"activate_plugins";b:1;s:12:"edit_plugins";b:1;s:10:"edit_users";b:1;s:10:"edit_files";b:1;s:14:"manage_options";b:1;s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:6:"import";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:8:"level_10";b:1;s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:12:"delete_users";b:1;s:12:"create_users";b:1;s:17:"unfiltered_upload";b:1;s:14:"edit_dashboard";b:1;s:14:"update_plugins";b:1;s:14:"delete_plugins";b:1;s:15:"install_plugins";b:1;s:13:"update_themes";b:1;s:14:"install_themes";b:1;s:11:"update_core";b:1;s:10:"list_users";b:1;s:12:"remove_users";b:1;s:9:"add_users";b:1;s:13:"promote_users";b:1;s:18:"edit_theme_options";b:1;s:13:"delete_themes";b:1;s:6:"export";b:1;s:14:"publish_events";b:1;s:20:"delete_others_events";b:1;s:18:"edit_others_events";b:1;s:22:"manage_others_bookings";b:1;s:24:"publish_recurring_events";b:1;s:30:"delete_others_recurring_events";b:1;s:28:"edit_others_recurring_events";b:1;s:17:"publish_locations";b:1;s:23:"delete_others_locations";b:1;s:16:"delete_locations";b:1;s:21:"edit_others_locations";b:1;s:23:"delete_event_categories";b:1;s:21:"edit_event_categories";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;s:18:"manage_woocommerce";b:1;s:24:"view_woocommerce_reports";b:1;s:12:"edit_product";b:1;s:12:"read_product";b:1;s:14:"delete_product";b:1;s:13:"edit_products";b:1;s:20:"edit_others_products";b:1;s:16:"publish_products";b:1;s:21:"read_private_products";b:1;s:15:"delete_products";b:1;s:23:"delete_private_products";b:1;s:25:"delete_published_products";b:1;s:22:"delete_others_products";b:1;s:21:"edit_private_products";b:1;s:23:"edit_published_products";b:1;s:20:"manage_product_terms";b:1;s:18:"edit_product_terms";b:1;s:20:"delete_product_terms";b:1;s:20:"assign_product_terms";b:1;s:15:"edit_shop_order";b:1;s:15:"read_shop_order";b:1;s:17:"delete_shop_order";b:1;s:16:"edit_shop_orders";b:1;s:23:"edit_others_shop_orders";b:1;s:19:"publish_shop_orders";b:1;s:24:"read_private_shop_orders";b:1;s:18:"delete_shop_orders";b:1;s:26:"delete_private_shop_orders";b:1;s:28:"delete_published_shop_orders";b:1;s:25:"delete_others_shop_orders";b:1;s:24:"edit_private_shop_orders";b:1;s:26:"edit_published_shop_orders";b:1;s:23:"manage_shop_order_terms";b:1;s:21:"edit_shop_order_terms";b:1;s:23:"delete_shop_order_terms";b:1;s:23:"assign_shop_order_terms";b:1;s:16:"edit_shop_coupon";b:1;s:16:"read_shop_coupon";b:1;s:18:"delete_shop_coupon";b:1;s:17:"edit_shop_coupons";b:1;s:24:"edit_others_shop_coupons";b:1;s:20:"publish_shop_coupons";b:1;s:25:"read_private_shop_coupons";b:1;s:19:"delete_shop_coupons";b:1;s:27:"delete_private_shop_coupons";b:1;s:29:"delete_published_shop_coupons";b:1;s:26:"delete_others_shop_coupons";b:1;s:25:"edit_private_shop_coupons";b:1;s:27:"edit_published_shop_coupons";b:1;s:24:"manage_shop_coupon_terms";b:1;s:22:"edit_shop_coupon_terms";b:1;s:24:"delete_shop_coupon_terms";b:1;s:24:"assign_shop_coupon_terms";b:1;}}s:6:"editor";a:2:{s:4:"name";s:6:"Editor";s:12:"capabilities";a:57:{s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:14:"publish_events";b:1;s:20:"delete_others_events";b:1;s:18:"edit_others_events";b:1;s:22:"manage_others_bookings";b:1;s:24:"publish_recurring_events";b:1;s:30:"delete_others_recurring_events";b:1;s:28:"edit_others_recurring_events";b:1;s:17:"publish_locations";b:1;s:23:"delete_others_locations";b:1;s:16:"delete_locations";b:1;s:21:"edit_others_locations";b:1;s:23:"delete_event_categories";b:1;s:21:"edit_event_categories";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;}}s:6:"author";a:2:{s:4:"name";s:6:"Author";s:12:"capabilities";a:20:{s:12:"upload_files";b:1;s:10:"edit_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:4:"read";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:22:"delete_published_posts";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;}}s:11:"contributor";a:2:{s:4:"name";s:11:"Contributor";s:12:"capabilities";a:15:{s:10:"edit_posts";b:1;s:4:"read";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;}}s:10:"subscriber";a:2:{s:4:"name";s:10:"Subscriber";s:12:"capabilities";a:12:{s:4:"read";b:1;s:7:"level_0";b:1;s:15:"manage_bookings";b:1;s:19:"upload_event_images";b:1;s:13:"delete_events";b:1;s:11:"edit_events";b:1;s:19:"read_private_events";b:1;s:23:"delete_recurring_events";b:1;s:21:"edit_recurring_events";b:1;s:14:"edit_locations";b:1;s:22:"read_private_locations";b:1;s:21:"read_others_locations";b:1;}}s:8:"customer";a:2:{s:4:"name";s:8:"Customer";s:12:"capabilities";a:3:{s:4:"read";b:1;s:10:"edit_posts";b:0;s:12:"delete_posts";b:0;}}s:12:"shop_manager";a:2:{s:4:"name";s:12:"Shop Manager";s:12:"capabilities";a:93:{s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:4:"read";b:1;s:18:"read_private_pages";b:1;s:18:"read_private_posts";b:1;s:10:"edit_users";b:1;s:10:"edit_posts";b:1;s:10:"edit_pages";b:1;s:20:"edit_published_posts";b:1;s:20:"edit_published_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"edit_private_posts";b:1;s:17:"edit_others_posts";b:1;s:17:"edit_others_pages";b:1;s:13:"publish_posts";b:1;s:13:"publish_pages";b:1;s:12:"delete_posts";b:1;s:12:"delete_pages";b:1;s:20:"delete_private_pages";b:1;s:20:"delete_private_posts";b:1;s:22:"delete_published_pages";b:1;s:22:"delete_published_posts";b:1;s:19:"delete_others_posts";b:1;s:19:"delete_others_pages";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:17:"moderate_comments";b:1;s:15:"unfiltered_html";b:1;s:12:"upload_files";b:1;s:6:"export";b:1;s:6:"import";b:1;s:10:"list_users";b:1;s:18:"manage_woocommerce";b:1;s:24:"view_woocommerce_reports";b:1;s:12:"edit_product";b:1;s:12:"read_product";b:1;s:14:"delete_product";b:1;s:13:"edit_products";b:1;s:20:"edit_others_products";b:1;s:16:"publish_products";b:1;s:21:"read_private_products";b:1;s:15:"delete_products";b:1;s:23:"delete_private_products";b:1;s:25:"delete_published_products";b:1;s:22:"delete_others_products";b:1;s:21:"edit_private_products";b:1;s:23:"edit_published_products";b:1;s:20:"manage_product_terms";b:1;s:18:"edit_product_terms";b:1;s:20:"delete_product_terms";b:1;s:20:"assign_product_terms";b:1;s:15:"edit_shop_order";b:1;s:15:"read_shop_order";b:1;s:17:"delete_shop_order";b:1;s:16:"edit_shop_orders";b:1;s:23:"edit_others_shop_orders";b:1;s:19:"publish_shop_orders";b:1;s:24:"read_private_shop_orders";b:1;s:18:"delete_shop_orders";b:1;s:26:"delete_private_shop_orders";b:1;s:28:"delete_published_shop_orders";b:1;s:25:"delete_others_shop_orders";b:1;s:24:"edit_private_shop_orders";b:1;s:26:"edit_published_shop_orders";b:1;s:23:"manage_shop_order_terms";b:1;s:21:"edit_shop_order_terms";b:1;s:23:"delete_shop_order_terms";b:1;s:23:"assign_shop_order_terms";b:1;s:16:"edit_shop_coupon";b:1;s:16:"read_shop_coupon";b:1;s:18:"delete_shop_coupon";b:1;s:17:"edit_shop_coupons";b:1;s:24:"edit_others_shop_coupons";b:1;s:20:"publish_shop_coupons";b:1;s:25:"read_private_shop_coupons";b:1;s:19:"delete_shop_coupons";b:1;s:27:"delete_private_shop_coupons";b:1;s:29:"delete_published_shop_coupons";b:1;s:26:"delete_others_shop_coupons";b:1;s:25:"edit_private_shop_coupons";b:1;s:27:"edit_published_shop_coupons";b:1;s:24:"manage_shop_coupon_terms";b:1;s:22:"edit_shop_coupon_terms";b:1;s:24:"delete_shop_coupon_terms";b:1;s:24:"assign_shop_coupon_terms";b:1;}}}', 'no'); 
INSERT INTO `wp_options` VALUES ('1070', 'dbem_thumbnails_enabled', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1071', 'dbem_js_limit', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1072', 'dbem_js_limit_general', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1073', 'dbem_js_limit_search', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1074', 'dbem_js_limit_events_form', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1075', 'dbem_js_limit_edit_bookings', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1076', 'dbem_css_limit', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1077', 'dbem_css_limit_include', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1078', 'dbem_css_limit_exclude', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1079', 'dbem_disable_timthumb', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1080', 'dbem_pro_dev_updates', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1081', 'dbem_disable_title_rewrites', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1082', 'dbem_title_html', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1083', 'dbem_events_current_are_past', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1084', 'dbem_bookings_default_orderby', 'event_name', 'yes'); 
INSERT INTO `wp_options` VALUES ('1085', 'dbem_bookings_default_order', 'ASC', 'yes'); 
INSERT INTO `wp_options` VALUES ('1086', 'dbem_edit_events_page', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1087', 'dbem_edit_locations_page', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1088', 'dbem_edit_bookings_page', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1089', 'dbem_event_list_groupby', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1090', 'dbem_event_list_groupby_format', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1091', 'dbem_display_calendar_day_single', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1092', 'dbem_bookings_tickets_show_member_tickets', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1093', 'dbem_mail_sender_address', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1094', 'dbem_smtp_username', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1095', 'dbem_smtp_password', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1160', 'M_Installed', '14', 'yes'); 
INSERT INTO `wp_options` VALUES ('1161', 'membership_options', 'a:13:{s:17:"registration_page";i:102;s:12:"account_page";i:103;s:14:"nocontent_page";i:104;s:25:"membershipadminshortcodes";a:1:{i:0;s:12:"contact-form";}s:24:"membershipdownloadgroups";a:1:{i:0;s:7:"default";}s:10:"masked_url";s:9:"downloads";s:13:"strangerlevel";i:2;s:15:"paymentcurrency";s:3:"BRL";s:13:"upgradeperiod";s:1:"0";s:13:"renewalperiod";s:3:"365";s:16:"registration_tos";s:0:"";s:20:"freeusersubscription";i:1;s:23:"enableincompletesignups";s:0:"";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1162', 'M_Newsstream_Installed', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('1165', 'membership_active', 'yes', 'yes'); 
INSERT INTO `wp_options` VALUES ('1166', 'membership_activated_gateways', 'a:1:{i:0;s:10:"paypalsolo";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1167', 'membership_wizard_visible', 'no', 'yes'); 
INSERT INTO `wp_options` VALUES ('1168', 'membership_simpleinvite_options', 'a:3:{s:11:"invitecodes";s:0:"";s:14:"inviterequired";s:0:"";s:12:"inviteremove";s:0:"";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1241', 'widget_pages', 'a:2:{i:2;a:3:{s:5:"title";s:6:"TESSSS";s:6:"sortby";s:10:"post_title";s:7:"exclude";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1274', 'wop_options_field', 'a:4:{s:10:"enable_css";s:1:"1";s:19:"num_of_wop_sidebars";s:1:"1";s:10:"wop_name_1";s:16:"Sidebar Esquerdo";s:10:"wop_name_2";s:15:"Sidebar Direito";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1285', 'wpbu_schedule_settings', 'a:2:{s:16:"backup_frequency";s:5:"daily";s:11:"backup_type";s:8:"database";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1295', 'widget_calendar', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1296', 'widget_em_calendar', 'a:2:{i:2;a:3:{s:5:"title";s:11:"Calendário";s:8:"category";s:1:"0";s:11:"long_events";i:0;}s:12:"_multiwidget";i:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1315', 'wp_googlefontmgr_apikey', 'AIzaSyDL8M3sWzyTMRbpDXGctGJfWnUQihDIjuU', 'yes'); 
INSERT INTO `wp_options` VALUES ('1319', 'wp_googlefontmgr_styledefaults', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('1320', 'wp_googlefontmgr_styleopts', 'body{ font-family:\'Carrois Gothic SC\' !important; font-size: 16px !important; }', 'yes'); 
INSERT INTO `wp_options` VALUES ('1431', 'pie_register', 'a:130:{s:13:"paypal_option";s:1:"0";s:14:"paypal_butt_id";s:0:"";s:14:"paypal_sandbox";s:2:"no";s:10:"paypal_pdt";s:0:"";s:13:"loginredirect";s:0:"";s:8:"password";s:1:"1";s:14:"password_meter";s:1:"0";s:5:"short";s:9:"Too Short";s:3:"bad";s:12:"Bad Password";s:4:"good";s:13:"Good Password";s:6:"strong";s:15:"Strong Password";s:8:"mismatch";s:9:"Mis Match";s:4:"code";s:1:"1";s:8:"codename";s:10:"Invitation";s:8:"codepass";s:0:"";s:10:"codeexpiry";s:2:"15";s:13:"code_auto_del";s:1:"1";s:11:"Expcodepass";s:0:"";s:7:"captcha";s:1:"0";s:10:"disclaimer";s:1:"0";s:16:"disclaimer_title";s:10:"Disclaimer";s:18:"disclaimer_content";s:0:"";s:16:"disclaimer_agree";s:21:"Accept the Disclaimer";s:7:"license";s:1:"0";s:13:"license_title";s:17:"License Agreement";s:15:"license_content";s:0:"";s:13:"license_agree";s:28:"Accept the License Agreement";s:7:"privacy";s:1:"0";s:13:"privacy_title";s:14:"Privacy Policy";s:15:"privacy_content";s:0:"";s:13:"privacy_agree";s:25:"Accept the Privacy Policy";s:12:"email_exists";s:1:"0";s:9:"firstname";s:1:"1";s:8:"lastname";s:1:"1";s:7:"website";s:1:"1";s:3:"aim";s:1:"0";s:5:"yahoo";s:1:"0";s:6:"jabber";s:1:"0";s:5:"about";s:1:"0";s:11:"profile_req";a:1:{i:0;s:1:"0";}s:13:"require_style";s:50:"border:solid 1px #E6DB55;background-color:#FFFFE0;";s:11:"dash_widget";s:1:"1";s:12:"email_verify";s:1:"0";s:12:"admin_verify";s:1:"1";s:18:"email_delete_grace";i:7;s:4:"html";s:1:"1";s:13:"emailvmsghtml";s:1:"1";s:13:"adminvmsghtml";s:1:"1";s:9:"adminhtml";s:1:"1";s:4:"from";s:25:"contato@montarsite.com.br";s:8:"fromname";s:27:"Asug | SAP NetWeaver Portal";s:7:"subject";s:56:"[Asug | SAP NetWeaver Portal] Your username and password";s:10:"custom_msg";s:1:"1";s:19:"adminvmsguser_nl2br";s:1:"0";s:9:"adminvmsg";s:225:" %blogname% Registration 
 --------------------------- 

 Here are your credentials: 
 Username: %user_login% 
 Password: %user_pass% 
 Confirm Registration: %siteurl% 

 Thank you for registering with %blogname%!  
";s:19:"emailvmsguser_nl2br";s:1:"0";s:9:"emailvmsg";s:225:" %blogname% Registration 
 --------------------------- 

 Here are your credentials: 
 Username: %user_login% 
 Password: %user_pass% 
 Confirm Registration: %siteurl% 

 Thank you for registering with %blogname%!  
";s:10:"user_nl2br";s:1:"0";s:3:"msg";s:225:" %blogname% Registration 
 --------------------------- 

 Here are your credentials: 
 Username: %user_login% 
 Password: %user_pass% 
 Confirm Registration: %siteurl% 

 Thank you for registering with %blogname%!  
";s:13:"disable_admin";s:1:"0";s:9:"adminfrom";s:25:"contato@montarsite.com.br";s:13:"adminfromname";s:27:"Asug | SAP NetWeaver Portal";s:12:"adminsubject";s:47:"[Asug | SAP NetWeaver Portal] New User Register";s:15:"custom_adminmsg";s:1:"0";s:11:"admin_nl2br";s:1:"0";s:8:"adminmsg";s:114:" New %blogname% Registration 
 --------------------------- 

 Username: %user_login% 
 E-Mail: %user_email% 
";s:4:"logo";s:0:"";s:14:"login_redirect";s:0:"";s:12:"register_css";s:81:"body{height:auto;} #login{width: 370px;} .login #pass-strength-result{width:95%;}";s:9:"login_css";s:18:"body{height:auto;}";s:8:"firstday";s:1:"6";s:10:"dateformat";s:10:"mm/dd/yyyy";s:9:"startdate";s:10:"01/01/1901";s:7:"calyear";s:4:"1999";s:8:"calmonth";s:3:"cur";s:16:"_admin_message_1";s:54:"  Por favor, selecione um usu&aacute;rio para validar!";s:16:"_admin_message_2";s:27:"Usu&aacute;rios Verificados";s:16:"_admin_message_3";s:20:"Caro usu&aacute;rio,";s:16:"_admin_message_4";s:82:"Voc&ecirc; foi registrado com sucesso, mais h&aacute; pend&ecirc;ncias financeiras";s:16:"_admin_message_5";s:94:"Por favor, clique ou copie este link para o navegador para concluir a inscri&ccedil;&atilde;o.";s:16:"_admin_message_6";s:9:"Obrigado.";s:16:"_admin_message_7";s:18:"Pagamento pendente";s:16:"_admin_message_8";s:58:"Por favor, selecione um usu&aacute;rio para enviar o link!";s:16:"_admin_message_9";s:66:"Link de pagamento foi enviado para o e-mail dos usu&aacute;rio (s)";s:17:"_admin_message_10";s:51:"Por favor selecione o usu&aacute;rio a ser deletado";s:17:"_admin_message_12";s:24:"Usu&aacute;rio deleteado";s:17:"_admin_message_13";s:15:"Verificar URL: ";s:17:"_admin_message_14";s:15:"Verificar conta";s:17:"_admin_message_15";s:56:"Os e-mails de verifica&ccedil;&atilde;o foram reenviados";s:17:"_admin_message_16";s:58:"Por favor, selecione um usu&aacute;rio para enviar e-mail.";s:17:"_admin_message_17";s:53:"Sua conta j&aacute; foi ativada por um administrador.";s:17:"_admin_message_18";s:35:"Registro de Conta de Usu&aacute;rio";s:17:"_admin_message_19";s:24:"Digite seu primeiro nome";s:17:"_admin_message_20";s:20:"Digite seu sobrenome";s:17:"_admin_message_21";s:24:"Digite a URL do seu site";s:17:"_admin_message_22";s:29:"Digite seu usu&aacute;rio AIM";s:17:"_admin_message_23";s:31:"Digite seu usu&aacute;rio Yahoo";s:17:"_admin_message_24";s:40:"Digite seu usu&aacute;rio do Google Talk";s:17:"_admin_message_25";s:18:"Digite seu celular";s:17:"_admin_message_26";s:19:"Digite seu telefone";s:17:"_admin_message_27";s:66:"Por favor insira algumas informa&ccedil;&otilde;es sobre si mesmo.";s:17:"_admin_message_28";s:16:"Digite sua senha";s:17:"_admin_message_29";s:33:"Sua senha n&atilde;o corresponde.";s:17:"_admin_message_30";s:43:"Sua senha deve ter pelo menos 6 caracteres.";s:17:"_admin_message_31";s:57:"Valida&ccedil;&atilde;o de imagem n&atilde;o corresponde.";s:17:"_admin_message_32";s:49:"O reCAPTCHA n&atilde;o foi digitado corretamente.";s:17:"_admin_message_33";s:19:"Por favor, aceite o";s:17:"_admin_message_34";s:18:"Por favor insira o";s:17:"_admin_message_35";s:43:"C&oacute;digo expirou ou n&atilde;o aceito.";s:17:"_admin_message_36";s:24:"C&oacute;digo incorreto.";s:17:"_admin_message_37";s:126:"Por favor, verifique seu e-mail e clique no link de confirma&ccedil;&atilde;o para ativar sua conta e completar o seu registo.";s:17:"_admin_message_38";s:134:"Este site est&aacute; fechado para registros p&uacute;blicos. Voc&ecirc; vai precisar de um c&oacute;digo [prcodename] para registrar.";s:17:"_admin_message_39";s:94:"Ter um c&oacute;digo [prcodename]? Digite-o aqui. (Isto n&atilde;o &eacute; necess&aacute;rio)";s:17:"_admin_message_40";s:25:"Digite o texto da imagem.";s:17:"_admin_message_41";s:116:"Sua conta ser&aacute; revisado por um administrador e voc&ecirc; ser&aacute; notificado quando ele &eacute; ativado.";s:17:"_admin_message_42";s:113:"Por favor, ative sua conta usando o link de confirma&ccedil;&atilde;o enviado para seu endere&ccedil;o de e-mail.";s:17:"_admin_message_43";s:51:"Clique abaixo para continuar e concluir o registro.";s:17:"_admin_message_44";s:98:"N&atilde;o h&aacute; taxa de assinatura de um tempo. Clique para completar o seu registo de conta.";s:17:"_admin_message_45";s:142:"seu e-mail foi verificada. N&atilde;o h&aacute; taxa de assinatura de um tempo. Por favor Clique abaixo para completar o seu registo de conta.";s:17:"_admin_message_46";s:36:"para o registo, fa&ccedil;a o login.";s:17:"_admin_message_47";s:65:"seu pagamento foi recebido. Fa&ccedil;a login na sua conta agora!";s:17:"_admin_message_48";s:54:"Voc&ecirc; pagou com sucesso para a sua ades&atilde;o.";s:17:"_admin_message_49";s:47:"H&aacute; um erro ao verificar o seu pagamento.";s:17:"_admin_message_50";s:123:"Obrigado por seu pagamento, estamos verificando o seu pagamento! Por favor, atualize esta p&aacute;gina em poucos segundos.";s:15:"custom_logo_url";s:0:"";s:8:"code_req";N;s:5:"phone";N;s:17:"email_verify_date";N;s:16:"reCAP_public_key";s:0:"";s:17:"reCAP_private_key";s:0:"";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1432', 'pie_register_custom', 'a:1:{i:0;a:6:{s:5:"label";s:6:"Boleto";s:7:"profile";s:1:"1";s:3:"reg";s:1:"1";s:8:"required";N;s:9:"fieldtype";s:6:"select";s:12:"extraoptions";s:7:"a,b,c,d";}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1436', 'user_meta_history', 'a:1:{s:7:"version";a:2:{s:12:"last_version";s:5:"1.1.5";s:5:"1.1.5";a:1:{s:9:"timestamp";i:1395446767;}}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1439', 'user_meta_fields', 'a:1:{i:3;a:8:{s:11:"field_title";s:6:"boleto";s:10:"field_type";s:4:"text";s:14:"title_position";s:3:"top";s:11:"description";s:6:"Boleto";s:8:"meta_key";s:6:"boleto";s:10:"admin_only";s:2:"on";s:9:"read_only";s:2:"on";s:6:"unique";s:2:"on";}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1517', 'mail_from', 'felipe@montarsite.com.br', 'yes'); 
INSERT INTO `wp_options` VALUES ('1518', 'mail_from_name', 'Felipe', 'yes'); 
INSERT INTO `wp_options` VALUES ('1519', 'mailer', 'smtp', 'yes'); 
INSERT INTO `wp_options` VALUES ('1520', 'mail_set_return_path', 'false', 'yes'); 
INSERT INTO `wp_options` VALUES ('1521', 'smtp_host', 'mail.montarsite.com.br', 'yes'); 
INSERT INTO `wp_options` VALUES ('1522', 'smtp_port', '587', 'yes'); 
INSERT INTO `wp_options` VALUES ('1523', 'smtp_ssl', 'none', 'yes'); 
INSERT INTO `wp_options` VALUES ('1524', 'smtp_auth', 'true', 'yes'); 
INSERT INTO `wp_options` VALUES ('1525', 'smtp_user', 'felipe@montarsite.com.br', 'yes'); 
INSERT INTO `wp_options` VALUES ('1526', 'smtp_pass', 'felip538159$', 'yes'); 
INSERT INTO `wp_options` VALUES ('1687', 'event-categories_children', 'a:0:{}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1688', 'em_last_modified', '1395713882', 'yes'); 
INSERT INTO `wp_options` VALUES ('1797', 'wp_dashboard_setup', 'dashboard_representante_inativos', 'yes'); 
INSERT INTO `wp_options` VALUES ('1805', 'itsec_data', 'a:5:{s:5:"build";i:4002;s:20:"activation_timestamp";i:1395884059;s:17:"already_supported";b:0;s:15:"setup_completed";b:1;s:18:"tooltips_dismissed";b:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1806', 'itsec_global', 'a:19:{s:11:"write_files";b:1;s:18:"notification_email";a:1:{i:0;s:25:"contato@montarsite.com.br";}s:12:"backup_email";a:1:{i:0;s:25:"contato@montarsite.com.br";}s:15:"lockout_message";s:5:"error";s:20:"user_lockout_message";s:56:"You have been locked out due to too many login attempts.";s:9:"blacklist";b:1;s:15:"blacklist_count";i:3;s:16:"blacklist_period";i:7;s:14:"lockout_period";i:15;s:18:"lockout_white_list";a:0:{}s:19:"email_notifications";b:1;s:8:"log_type";i:0;s:12:"log_rotation";i:30;s:12:"log_location";s:61:"C:xampphtdocsasug/wp-content/uploads/ithemes-security/logs";s:11:"did_upgrade";b:1;s:14:"allow_tracking";b:0;s:10:"nginx_file";s:31:"C:xampphtdocsasug/nginx.conf";s:24:"infinitewp_compatibility";b:0;s:8:"log_info";s:30:"asug-sap-netweaver-p-pq1OBY9Ee";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1807', 'itsec_initials', 'a:3:{s:5:"login";b:0;s:5:"admin";b:0;s:11:"file_editor";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1808', 'itsec_four_oh_four', 'a:4:{s:12:"check_period";i:5;s:15:"error_threshold";i:20;s:10:"white_list";a:9:{i:0;s:12:"/favicon.ico";i:1;s:11:"/robots.txt";i:2;s:21:"/apple-touch-icon.png";i:3;s:33:"/apple-touch-icon-precomposed.png";i:4;s:17:"/wp-content/cache";i:5;s:18:"/browserconfig.xml";i:6;s:16:"/crossdomain.xml";i:7;s:11:"/labels.rdf";i:8;s:27:"/trafficbasedsspsitemap.xml";}s:7:"enabled";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1809', 'itsec_away_mode', 'a:4:{s:4:"type";i:2;s:7:"enabled";b:0;s:5:"start";i:1395964800;s:3:"end";i:1396072800;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1810', 'itsec_ban_users', 'a:5:{s:9:"host_list";a:0:{}s:10:"agent_list";a:1:{i:0;b:0;}s:10:"white_list";a:0:{}s:7:"enabled";b:0;s:7:"default";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1812', 'itsec_brute_force', 'a:4:{s:17:"max_attempts_host";i:5;s:17:"max_attempts_user";i:10;s:12:"check_period";i:5;s:7:"enabled";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1813', 'itsec_backup', 'a:8:{s:6:"method";i:1;s:8:"location";s:64:"C:xampphtdocsasug/wp-content/uploads/ithemes-security/backups";s:3:"zip";b:1;s:7:"exclude";a:3:{i:0;s:14:"itsec_lockouts";i:1;s:9:"itsec_log";i:2;s:10:"itsec_temp";}s:8:"interval";i:1;s:7:"enabled";b:0;s:9:"all_sites";b:0;s:8:"last_run";i:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1814', 'itsec_file_change', 'a:9:{s:6:"method";b:1;s:9:"file_list";a:1:{i:0;s:0:"";}s:5:"types";a:6:{i:0;s:4:".jpg";i:1;s:5:".jpeg";i:2;s:4:".png";i:3;s:4:".log";i:4;s:3:".mo";i:5;s:3:".po";}s:5:"email";b:1;s:12:"notify_admin";b:1;s:7:"enabled";b:0;s:5:"split";b:0;s:10:"last_chunk";b:0;s:8:"last_run";i:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1815', 'itsec_hide_backend', 'a:4:{s:4:"slug";s:0:"";s:8:"register";s:8:"register";s:7:"enabled";b:0;s:12:"show-tooltip";b:1;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1818', 'itsec_ssl', 'a:3:{s:8:"frontend";i:1;s:5:"login";b:0;s:5:"admin";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1819', 'itsec_strong_passwords', 'a:2:{s:4:"roll";s:13:"administrator";s:7:"enabled";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1820', 'itsec_tweaks', 'a:22:{s:13:"protect_files";b:0;s:18:"directory_browsing";b:0;s:15:"request_methods";b:0;s:24:"suspicious_query_strings";b:0;s:22:"non_english_characters";b:0;s:16:"long_url_strings";b:0;s:17:"write_permissions";b:0;s:13:"generator_tag";b:0;s:18:"wlwmanifest_header";b:0;s:14:"edituri_header";b:0;s:13:"theme_updates";b:0;s:14:"plugin_updates";b:0;s:12:"core_updates";b:0;s:12:"comment_spam";b:0;s:14:"random_version";b:0;s:11:"file_editor";b:0;s:14:"disable_xmlrpc";b:0;s:11:"uploads_php";b:0;s:11:"safe_jquery";b:0;s:12:"login_errors";b:0;s:21:"force_unique_nicename";b:0;s:27:"disable_unused_author_pages";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1830', '_transient_wc_attribute_taxonomies', 'a:0:{}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1857', 'itsec_jquery_version', '1.10.2', 'yes'); 
INSERT INTO `wp_options` VALUES ('1924', 'ips_options', 'a:12:{s:13:"issuu_api_key";s:32:"7kw9itrilpsdfp550gdwm4jqqknbbp63";s:16:"issuu_secret_key";s:32:"pdf6zvpwq9hpz7gadhady4qxmah1wmpu";s:11:"auto_upload";s:1:"1";s:14:"add_ips_button";s:1:"1";s:6:"access";s:6:"public";s:6:"layout";s:1:"1";s:13:"custom_layout";s:7:"default";s:5:"width";s:3:"800";s:6:"height";s:3:"600";s:7:"bgcolor";s:6:"FFFFFF";s:17:"allow_full_screen";s:1:"1";s:13:"flip_timelaps";s:4:"6000";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1940', 'defaults', 'O:8:"stdClass":6:{s:2:"id";s:29:"Please enter your flipbook id";s:5:"width";i:600;s:6:"height";i:600;s:6:"layout";i:1;s:4:"link";s:15:"Got to Flipbook";s:10:"responsive";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('1941', 'flipbooks', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('1947', 'wp-booklet-pdf-limit-status', 'on', 'yes'); 
INSERT INTO `wp_options` VALUES ('1959', 'epaper_dir', 'C:xampphtdocsasug/wp-content/uploads/epaper', 'yes'); 
INSERT INTO `wp_options` VALUES ('1960', 'epaper_url', 'http://127.0.0.1/asug/wp-content/uploads/epaper', 'yes'); 
INSERT INTO `wp_options` VALUES ('2063', 'ewww_image_optimizer_bulk_attachments', 'a:13:{i:0;s:3:"123";i:1;s:3:"120";i:2;s:3:"119";i:3;s:2:"87";i:4;s:2:"86";i:5;s:2:"78";i:6;s:2:"77";i:7;s:2:"67";i:8;s:2:"66";i:9;s:2:"65";i:10;s:2:"64";i:11;s:2:"63";i:12;s:2:"61";}', 'no'); 
INSERT INTO `wp_options` VALUES ('2064', 'ewww_image_optimizer_flag_attachments', '', 'no'); 
INSERT INTO `wp_options` VALUES ('2065', 'ewww_image_optimizer_ngg_attachments', '', 'no'); 
INSERT INTO `wp_options` VALUES ('2066', 'ewww_image_optimizer_aux_attachments', '', 'no'); 
INSERT INTO `wp_options` VALUES ('2083', 'duplicate_post_copyexcerpt', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('2084', 'duplicate_post_copyattachments', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('2085', 'duplicate_post_copychildren', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('2086', 'duplicate_post_copystatus', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('2087', 'duplicate_post_taxonomies_blacklist', 'a:0:{}', 'yes'); 
INSERT INTO `wp_options` VALUES ('2088', 'duplicate_post_show_row', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('2089', 'duplicate_post_show_adminbar', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('2090', 'duplicate_post_show_submitbox', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('2091', 'duplicate_post_version', '2.6', 'yes'); 
INSERT INTO `wp_options` VALUES ('2314', 'sm_rewrite_done', '$Id: sitemap-loader.php 891809 2014-04-12 11:06:34Z arnee $', 'yes'); 
INSERT INTO `wp_options` VALUES ('2315', 'bup_db_version', '0.4.2', 'yes'); 
INSERT INTO `wp_options` VALUES ('2316', 'bup_db_installed', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('2317', 'wp-optimize-schedule', 'false', 'no'); 
INSERT INTO `wp_options` VALUES ('2318', 'wp-optimize-last-optimized', 'Never', 'no'); 
INSERT INTO `wp_options` VALUES ('2319', 'wp-optimize-schedule-type', 'wpo_weekly', 'no'); 
INSERT INTO `wp_options` VALUES ('2320', 'wp-optimize-retention-enabled', 'false', 'no'); 
INSERT INTO `wp_options` VALUES ('2321', 'wp-optimize-retention-period', '2', 'no'); 
INSERT INTO `wp_options` VALUES ('2322', 'wp-optimize-enable-admin-menu', 'false', 'no'); 
INSERT INTO `wp_options` VALUES ('2323', 'wp-optimize-total-cleaned', '0', 'no'); 
INSERT INTO `wp_options` VALUES ('2324', 'wp-optimize-auto', 'a:8:{s:9:"revisions";s:4:"true";s:6:"drafts";s:4:"true";s:5:"spams";s:4:"true";s:10:"unapproved";s:5:"false";s:9:"transient";s:5:"false";s:8:"postmeta";s:5:"false";s:4:"tags";s:5:"false";s:8:"optimize";s:4:"true";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('2385', 'blc_installation_log', 'a:50:{i:0;a:3:{i:0;i:1;i:1;s:40:"Plugin activated at 2014-04-12 19:10:41.";i:2;N;}i:1;a:3:{i:0;i:1;i:1;s:27:"Installation/update begins.";i:2;N;}i:2;a:3:{i:0;i:1;i:1;s:25:"Upgrading the database...";i:2;N;}i:3;a:3:{i:0;i:1;i:1;s:24:"Database schema updated.";i:2;N;}i:4;a:3:{i:0;i:1;i:1;s:31:"Database successfully upgraded.";i:2;N;}i:5;a:3:{i:0;i:1;i:1;s:27:"Cleaning up the database...";i:2;N;}i:6;a:3:{i:0;i:1;i:1;s:38:"... Deleting invalid container records";i:2;N;}i:7;a:3:{i:0;i:0;i:1;s:27:"... 0 synch records deleted";i:2;N;}i:8;a:3:{i:0;i:1;i:1;s:35:"... Deleting invalid link instances";i:2;N;}i:9;a:3:{i:0;i:0;i:1;s:23:"... 0 instances deleted";i:2;N;}i:10;a:3:{i:0;i:0;i:1;s:28:"... 0 more instances deleted";i:2;N;}i:11;a:3:{i:0;i:1;i:1;s:27:"... Deleting orphaned links";i:2;N;}i:12;a:3:{i:0;i:0;i:1;s:19:"... 0 links deleted";i:2;N;}i:13;a:3:{i:0;i:1;i:1;s:20:"Notifying modules...";i:2;N;}i:14;a:3:{i:0;i:0;i:1;s:25:"... Updating module cache";i:2;N;}i:15;a:3:{i:0;i:0;i:1;s:27:"... Notifying module "http"";i:2;N;}i:16;a:3:{i:0;i:0;i:1;s:27:"... Notifying module "link"";i:2;N;}i:17;a:3:{i:0;i:0;i:1;s:59:"...... Parser "link" is marking relevant items as unsynched";i:2;N;}i:18;a:3:{i:0;i:0;i:1;s:272:"...... Executing query: UPDATE wp_blc_synch SET synched = 0 WHERE (container_type = \'page\' AND last_synch >= \'1970-01-01 00:00:00\') OR (container_type = \'post\' AND last_synch >= \'1970-01-01 00:00:00\') OR (container_type = \'comment\' AND last_synch >= \'1970-01-01 00:00:00\')";i:2;N;}i:19;a:3:{i:0;i:0;i:1;s:38:"...... 46 rows affected, 0.033 seconds";i:2;N;}i:20;a:3:{i:0;i:0;i:1;s:28:"... Notifying module "image"";i:2;N;}i:21;a:3:{i:0;i:0;i:1;s:60:"...... Parser "image" is marking relevant items as unsynched";i:2;N;}i:22;a:3:{i:0;i:0;i:1;s:272:"...... Executing query: UPDATE wp_blc_synch SET synched = 0 WHERE (container_type = \'page\' AND last_synch >= \'1970-01-01 00:00:00\') OR (container_type = \'post\' AND last_synch >= \'1970-01-01 00:00:00\') OR (container_type = \'comment\' AND last_synch >= \'1970-01-01 00:00:00\')";i:2;N;}i:23;a:3:{i:0;i:0;i:1;s:37:"...... 0 rows affected, 0.012 seconds";i:2;N;}i:24;a:3:{i:0;i:0;i:1;s:31:"... Notifying module "metadata"";i:2;N;}i:25;a:3:{i:0;i:0;i:1;s:63:"...... Parser "metadata" is marking relevant items as unsynched";i:2;N;}i:26;a:3:{i:0;i:0;i:1;s:32:"... Notifying module "url_field"";i:2;N;}i:27;a:3:{i:0;i:0;i:1;s:64:"...... Parser "url_field" is marking relevant items as unsynched";i:2;N;}i:28;a:3:{i:0;i:0;i:1;s:134:"...... Executing query: UPDATE wp_blc_synch SET synched = 0 WHERE (container_type = \'comment\' AND last_synch >= \'1970-01-01 00:00:00\')";i:2;N;}i:29;a:3:{i:0;i:0;i:1;s:37:"...... 0 rows affected, 0.024 seconds";i:2;N;}i:30;a:3:{i:0;i:0;i:1;s:30:"... Notifying module "comment"";i:2;N;}i:31;a:3:{i:0;i:0;i:1;s:51:"...... Deleting synch. records for removed comments";i:2;N;}i:32;a:3:{i:0;i:0;i:1;s:22:"...... 0 rows affected";i:2;N;}i:33;a:3:{i:0;i:0;i:1;s:47:"...... Creating synch. records for new comments";i:2;N;}i:34;a:3:{i:0;i:0;i:1;s:22:"...... 0 rows affected";i:2;N;}i:35;a:3:{i:0;i:0;i:1;s:27:"... Notifying module "post"";i:2;N;}i:36;a:3:{i:0;i:0;i:1;s:47:"...... Deleting synch records for removed posts";i:2;N;}i:37;a:3:{i:0;i:0;i:1;s:21:"...... 0 rows deleted";i:2;N;}i:38;a:3:{i:0;i:0;i:1;s:41:"...... Marking changed posts as unsynched";i:2;N;}i:39;a:3:{i:0;i:0;i:1;s:21:"...... 0 rows updated";i:2;N;}i:40;a:3:{i:0;i:0;i:1;s:43:"...... Creating synch records for new posts";i:2;N;}i:41;a:3:{i:0;i:0;i:1;s:22:"...... 0 rows inserted";i:2;N;}i:42;a:3:{i:0;i:0;i:1;s:27:"... Notifying module "page"";i:2;N;}i:43;a:3:{i:0;i:0;i:1;s:74:"...... Skipping "page" resyncyh since all post types were already synched.";i:2;N;}i:44;a:3:{i:0;i:0;i:1;s:28:"... Notifying module "dummy"";i:2;N;}i:45;a:3:{i:0;i:1;i:1;s:38:"Updating server load limit settings...";i:2;N;}i:46;a:3:{i:0;i:1;i:1;s:26:"Optimizing the database...";i:2;N;}i:47;a:3:{i:0;i:1;i:1;s:26:"Completing installation...";i:2;N;}i:48;a:3:{i:0;i:1;i:1;s:20:"Configuration saved.";i:2;N;}i:49;a:3:{i:0;i:1;i:1;s:78:"Installation/update completed at 2014-04-12 19:10:42 with 30 queries executed.";i:2;N;}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('2637', '_site_transient_timeout_browser_d88670820d154fdb975c9bc3be8d0cb6', '1398812574', 'yes'); 
INSERT INTO `wp_options` VALUES ('2638', '_site_transient_browser_d88670820d154fdb975c9bc3be8d0cb6', 'a:9:{s:8:"platform";s:7:"Windows";s:4:"name";s:6:"Chrome";s:7:"version";s:13:"34.0.1847.116";s:10:"update_url";s:28:"http://www.google.com/chrome";s:7:"img_src";s:49:"http://s.wordpress.org/images/browsers/chrome.png";s:11:"img_src_ssl";s:48:"https://wordpress.org/images/browsers/chrome.png";s:15:"current_version";s:2:"18";s:7:"upgrade";b:0;s:8:"insecure";b:0;}', 'yes'); 
INSERT INTO `wp_options` VALUES ('2639', '_transient_timeout_feed_ac0b00fe65abe10e0c5b588f3ed8c7ca', '1398250982', 'no'); 
INSERT INTO `wp_options` VALUES ('2640', '_transient_feed_ac0b00fe65abe10e0c5b588f3ed8c7ca', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"


";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:51:"
	
	
	
	
	
	
		
		
	
	
		
		
		
		
		
		
		
		
		
	";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:3:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"WordPress News";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:25:"http://wordpress.org/news";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:14:"WordPress News";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:13:"lastBuildDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 17 Apr 2014 01:07:32 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:5:"en-US";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/?v=4.0-alpha";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:10:{i:0;a:6:{s:4:"data";s:42:"
		
		
		
		
		
				

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:25:"WordPress 3.9 “Smith”";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:40:"http://wordpress.org/news/2014/04/smith/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:49:"http://wordpress.org/news/2014/04/smith/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 16 Apr 2014 18:33:44 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3154";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:411:"Version 3.9 of WordPress, named &#8220;Smith&#8221; in honor of jazz organist Jimmy Smith, is available for download or update in your WordPress dashboard. This release features a number of refinements that we hope you&#8217;ll love. A smoother media editing experience Improved visual editing The updated visual editor has improved speed, accessibility, and mobile support. You can paste into the [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Matt Mullenweg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:23279:"<p>Version 3.9 of WordPress, named &#8220;Smith&#8221; in honor of jazz organist <a href="http://en.wikipedia.org/wiki/Jimmy_Smith_(musician)">Jimmy Smith</a>, is available <a href="http://wordpress.org/download/">for download</a> or update in your WordPress dashboard. This release features a number of refinements that we hope you&#8217;ll love.</p>
<embed src="//v0.wordpress.com/player.swf?v=1.03" type="application/x-shockwave-flash" width="640" height="360" wmode="direct" seamlesstabbing="true" allowfullscreen="true" allowscriptaccess="always" overstretch="true" flashvars="guid=sAiXhCfV&amp;isDynamicSeeking=true" title=""></embed>
<h2 class="about-headline-callout" style="text-align: center">A smoother media editing experience</h2>
<div>
<p><img class="alignright wp-image-3168" src="//wordpress.org/news/files/2014/04/editor1-300x233.jpg" alt="editor" width="228" height="177" /></p>
<h3>Improved visual editing</h3>
<p>The updated visual editor has improved speed, accessibility, and mobile support. You can paste into the visual editor from your word processor without wasting time to clean up messy styling. (Yeah, we’re talking about you, Microsoft Word.)</p>
</div>
<div style="clear: both"></div>
<div>
<p><img class="alignright wp-image-3170" src="//wordpress.org/news/files/2014/04/image1-300x233.jpg" alt="image" width="228" height="178" /></p>
<h3>Edit images easily</h3>
<p>With quicker access to crop and rotation tools, it’s now much easier to edit your images while editing posts. You can also scale images directly in the editor to find just the right fit.</p>
</div>
<div style="clear: both"></div>
<div>
<p><img class="alignright wp-image-3187" src="//wordpress.org/news/files/2014/04/dragdrop1-300x233.jpg" alt="dragdrop" width="228" height="178" /></p>
<h3>Drag and drop your images</h3>
<p>Uploading your images is easier than ever. Just grab them from your desktop and drop them in the editor.</p>
</div>
<div style="clear: both"></div>
<hr />
<h2 style="text-align: center">Gallery previews</h2>
<p><img class="aligncenter size-full wp-image-3169" src="//wordpress.org/news/files/2014/04/gallery1.jpg" alt="gallery" width="980" height="550" /></p>
<p>Galleries display a beautiful grid of images right in the editor, just like they do in your published post.</p>
<hr />
<h2 style="text-align: center">Do more with audio and video</h2>

<a href=\'http://wordpress.org/news/files/2014/04/AintMisbehavin.mp3\'>Ain\'t Misbehavin\'</a>
<a href=\'http://wordpress.org/news/files/2014/04/DavenportBlues.mp3\'>Davenport Blues</a>
<a href=\'http://wordpress.org/news/files/2014/04/JellyRollMorton-BuddyBoldensBlues.mp3\'>Buddy Bolden\'s Blues</a>
<a href=\'http://wordpress.org/news/files/2014/04/Johnny_Hodges_Orchestra-Squaty_Roo-1941.mp3\'>Squaty Roo</a>
<a href=\'http://wordpress.org/news/files/2014/04/Louisiana_Five-Dixie_Blues-1919.mp3\'>Dixie Blues</a>
<a href=\'http://wordpress.org/news/files/2014/04/WolverineBlues.mp3\'>Wolverine Blues</a>

<p>Images have galleries; now we’ve added simple audio and video playlists, so you can showcase your music and clips.</p>
<hr />
<h2 style="text-align: center">Live widget and header previews</h2>
<div style="width: 692px; max-width: 100%;" class="wp-video"><!--[if lt IE 9]><script>document.createElement(\'video\');</script><![endif]-->
<video class="wp-video-shortcode" id="video-3154-1" width="692" height="448" preload="metadata" controls="controls"><source type="video/mp4" src="//wordpress.org/news/files/2014/04/widgets.mp4?_=1" /><a href="//wordpress.org/news/files/2014/04/widgets.mp4">//wordpress.org/news/files/2014/04/widgets.mp4</a></video></div>
<p>Add, edit, and rearrange your site’s widgets right in the theme customizer. No “save and surprise” — preview your changes live and only save them when you’re ready.</p>
<p>The improved header image tool also lets you upload, crop, and manage headers while customizing your theme.</p>
<hr />
<h2 style="text-align: center">Stunning new theme browser</h2>
<p><img class="aligncenter size-full wp-image-3172" src="//wordpress.org/news/files/2014/04/theme1.jpg" alt="theme" width="1003" height="558" /><br />
Looking for a new theme should be easy and fun. Lose yourself in the boundless supply of free WordPress.org themes with the beautiful new theme browser.</p>
<hr />
<h2 style="text-align: center">The Crew</h2>
<p>This release was led by <a href="http://nacin.com/">Andrew Nacin</a> and <a href="http://www.getsource.net/">Mike Schroder</a>, with the help of these fine individuals. There are 267 contributors with props in this release, a new high:</p>
<p><a href="http://profiles.wordpress.org/aaroncampbell">Aaron D. Campbell</a>, <a href="http://profiles.wordpress.org/jorbin">Aaron Jorbin</a>, <a href="http://profiles.wordpress.org/kawauso">Adam Harley</a>, <a href="http://profiles.wordpress.org/adamsilverstein">Adam Silverstein</a>, <a href="http://profiles.wordpress.org/adelval">adelval</a>, <a href="http://profiles.wordpress.org/ajay">Ajay</a>, <a href="http://profiles.wordpress.org/akeda">Akeda Bagus</a>, <a href="http://profiles.wordpress.org/xknown">Alex Concha</a>, <a href="http://profiles.wordpress.org/aliso">Alison Barrett</a>, <a href="http://profiles.wordpress.org/collinsinternet">Allan Collins</a>, <a href="http://profiles.wordpress.org/sabreuse">Amy Hendrix (sabreuse)</a>, <a href="http://profiles.wordpress.org/afercia">Andrea Fercia</a>, <a href="http://profiles.wordpress.org/nacin">Andrew Nacin</a>, <a href="http://profiles.wordpress.org/norcross">Andrew Norcross</a>, <a href="http://profiles.wordpress.org/azaozz">Andrew Ozz</a>, <a href="http://profiles.wordpress.org/rarst">Andrey "Rarst" Savchenko</a>, <a href="http://profiles.wordpress.org/andykeith">Andy Keith</a>, <a href="http://profiles.wordpress.org/andy">Andy Skelton</a>, <a href="http://profiles.wordpress.org/atimmer">Anton Timmermans</a>, <a href="http://profiles.wordpress.org/aubreypwd">Aubrey Portwood</a>, <a href="http://profiles.wordpress.org/barry">Barry</a>, <a href="http://profiles.wordpress.org/toszcze">Bartosz Romanowski</a>, <a href="http://profiles.wordpress.org/bassgang">bassgang</a>, <a href="http://profiles.wordpress.org/bcworkz">bcworkz</a>, <a href="http://profiles.wordpress.org/empireoflight">Ben Dunkle</a>, <a href="http://profiles.wordpress.org/neoxx">Bernhard Riedl</a>, <a href="http://profiles.wordpress.org/bigdawggi">bigdawggi</a>, <a href="http://profiles.wordpress.org/bobbravo2">Bob Gregor</a>, <a href="http://profiles.wordpress.org/bobbingwide">bobbingwide</a>, <a href="http://profiles.wordpress.org/bradt">Brad Touesnard</a>, <a href="http://profiles.wordpress.org/bradparbs">bradparbs</a>, <a href="http://profiles.wordpress.org/bramd">bramd</a>, <a href="http://profiles.wordpress.org/kraftbj">Brandon Kraft</a>, <a href="http://profiles.wordpress.org/brasofilo">brasofilo</a>, <a href="http://profiles.wordpress.org/bravokeyl">bravokeyl</a>, <a href="http://profiles.wordpress.org/bpetty">Bryan Petty</a>, <a href="http://profiles.wordpress.org/cgaffga">cgaffga</a>, <a href="http://profiles.wordpress.org/chiragswadia">Chirag Swadia</a>, <a href="http://profiles.wordpress.org/chouby">Chouby</a>, <a href="http://profiles.wordpress.org/ehg">Chris Blower</a>, <a href="http://profiles.wordpress.org/cmmarslender">Chris Marslender</a>, <a href="http://profiles.wordpress.org/c3mdigital">Chris Olbekson</a>, <a href="http://profiles.wordpress.org/chrisscott">Chris Scott</a>, <a href="http://profiles.wordpress.org/chriseverson">chriseverson</a>, <a href="http://profiles.wordpress.org/chrisguitarguy">chrisguitarguy</a>, <a href="http://profiles.wordpress.org/cfinke">Christopher Finke</a>, <a href="http://profiles.wordpress.org/ciantic">ciantic</a>, <a href="http://profiles.wordpress.org/antorome">Comparativa de Bancos</a>, <a href="http://profiles.wordpress.org/cojennin">Connor Jennings</a>, <a href="http://profiles.wordpress.org/corvannoorloos">Cor van Noorloos</a>, <a href="http://profiles.wordpress.org/corphi">Corphi</a>, <a href="http://profiles.wordpress.org/cramdesign">cramdesign</a>, <a href="http://profiles.wordpress.org/danielbachhuber">Daniel Bachhuber</a>, <a href="http://profiles.wordpress.org/redsweater">Daniel Jalkut (Red Sweater)</a>, <a href="http://profiles.wordpress.org/dannydehaan">Danny de Haan</a>, <a href="http://profiles.wordpress.org/koop">Daryl Koopersmith</a>, <a href="http://profiles.wordpress.org/eightface">Dave Kellam (eightface)</a>, <a href="http://profiles.wordpress.org/dpe415">DaveE</a>, <a href="http://profiles.wordpress.org/davidakennedy">David A. Kennedy</a>, <a href="http://profiles.wordpress.org/davidanderson">David Anderson</a>, <a href="http://profiles.wordpress.org/davidmarichal">David Marichal</a>, <a href="http://profiles.wordpress.org/denis-de-bernardy">Denis de Bernardy</a>, <a href="http://profiles.wordpress.org/dd32">Dion Hulse</a>, <a href="http://profiles.wordpress.org/ocean90">Dominik Schilling</a>, <a href="http://profiles.wordpress.org/dougwollison">Doug Wollison</a>, <a href="http://profiles.wordpress.org/drewapicture">Drew Jaynes</a>, <a href="http://profiles.wordpress.org/drprotocols">DrProtocols</a>, <a href="http://profiles.wordpress.org/dustyf">Dustin Filippini</a>, <a href="http://profiles.wordpress.org/eatingrules">eatingrules</a>, <a href="http://profiles.wordpress.org/plocha">edik</a>, <a href="http://profiles.wordpress.org/eliorivero">Elio Rivero</a>, <a href="http://profiles.wordpress.org/enej">enej</a>, <a href="http://profiles.wordpress.org/ericlewis">Eric Andrew Lewis</a>, <a href="http://profiles.wordpress.org/ericmann">Eric Mann</a>, <a href="http://profiles.wordpress.org/evarlese">Erica Varlese</a>, <a href="http://profiles.wordpress.org/ethitter">Erick Hitter</a>, <a href="http://profiles.wordpress.org/ejdanderson">Evan Anderson</a>, <a href="http://profiles.wordpress.org/fahmiadib">Fahmi Adib</a>, <a href="http://profiles.wordpress.org/fboender">fboender</a>, <a href="http://profiles.wordpress.org/frank-klein">Frank Klein</a>, <a href="http://profiles.wordpress.org/garyc40">Gary Cao</a>, <a href="http://profiles.wordpress.org/garyj">Gary Jones</a>, <a href="http://profiles.wordpress.org/pento">Gary Pendergast</a>, <a href="http://profiles.wordpress.org/genkisan">genkisan</a>, <a href="http://profiles.wordpress.org/soulseekah">Gennady Kovshenin</a>, <a href="http://profiles.wordpress.org/georgestephanis">George Stephanis</a>, <a href="http://profiles.wordpress.org/grahamarmfield">Graham Armfield</a>, <a href="http://profiles.wordpress.org/vancoder">Grant Mangham</a>, <a href="http://profiles.wordpress.org/gcorne">Gregory Cornelius</a>, <a href="http://profiles.wordpress.org/tivnet">Gregory Karpinsky</a>, <a href="http://profiles.wordpress.org/hakre">hakre</a>, <a href="http://profiles.wordpress.org/hanni">hanni</a>, <a href="http://profiles.wordpress.org/helen">Helen Hou-Sandí</a>, <a href="http://profiles.wordpress.org/ippetkov">ippetkov</a>, <a href="http://profiles.wordpress.org/ipstenu">Ipstenu (Mika Epstein)</a>, <a href="http://profiles.wordpress.org/jdgrimes">J.D. Grimes</a>, <a href="http://profiles.wordpress.org/jackreichert">Jack Reichert</a>, <a href="http://profiles.wordpress.org/_jameslee">jameslee</a>, <a href="http://profiles.wordpress.org/avryl">Janneke Van Dorpe</a>, <a href="http://profiles.wordpress.org/janrenn">janrenn</a>, <a href="http://profiles.wordpress.org/jaycc">JayCC</a>, <a href="http://profiles.wordpress.org/jeffsebring">Jeff Sebring</a>, <a href="http://profiles.wordpress.org/jenmylo">Jen Mylo</a>, <a href="http://profiles.wordpress.org/jeremyfelt">Jeremy Felt</a>, <a href="http://profiles.wordpress.org/jesin">Jesin A</a>, <a href="http://profiles.wordpress.org/jayjdk">Jesper Johansen (jayjdk)</a>, <a href="http://profiles.wordpress.org/jnielsendotnet">jnielsendotnet</a>, <a href="http://profiles.wordpress.org/jartes">Joan Artes</a>, <a href="http://profiles.wordpress.org/joedolson">Joe Dolson</a>, <a href="http://profiles.wordpress.org/joehoyle">Joe Hoyle</a>, <a href="http://profiles.wordpress.org/johnbillion">John Blackbourn</a>, <a href="http://profiles.wordpress.org/johnjamesjacoby">John James Jacoby</a>, <a href="http://profiles.wordpress.org/johnpbloch">John P. Bloch</a>, <a href="http://profiles.wordpress.org/johnregan3">John Regan</a>, <a href="http://profiles.wordpress.org/duck_">Jon Cave</a>, <a href="http://profiles.wordpress.org/jond3r">Jonas Bolinder (jond3r)</a>, <a href="http://profiles.wordpress.org/joostdevalk">Joost de Valk</a>, <a href="http://profiles.wordpress.org/shelob9">Josh Pollock</a>, <a href="http://profiles.wordpress.org/joshuaabenazer">Joshua Abenazer</a>, <a href="http://profiles.wordpress.org/jstraitiff">jstraitiff</a>, <a href="http://profiles.wordpress.org/juliobox">Julio Potier</a>, <a href="http://profiles.wordpress.org/kopepasah">Justin Kopepasah</a>, <a href="http://profiles.wordpress.org/justinsainton">Justin Sainton</a>, <a href="http://profiles.wordpress.org/kadamwhite">K.Adam White</a>, <a href="http://profiles.wordpress.org/trepmal">Kailey (trepmal)</a>, <a href="http://profiles.wordpress.org/kasparsd">Kaspars</a>, <a href="http://profiles.wordpress.org/ryelle">Kelly Dwan</a>, <a href="http://profiles.wordpress.org/kerikae">kerikae</a>, <a href="http://profiles.wordpress.org/kworthington">Kevin Worthington</a>, <a href="http://profiles.wordpress.org/kpdesign">Kim Parsell</a>, <a href="http://profiles.wordpress.org/kwight">Kirk Wight</a>, <a href="http://profiles.wordpress.org/kitchin">kitchin</a>, <a href="http://profiles.wordpress.org/klihelp">klihelp</a>, <a href="http://profiles.wordpress.org/knutsp">Knut Sparhell</a>, <a href="http://profiles.wordpress.org/kovshenin">Konstantin Kovshenin</a>, <a href="http://profiles.wordpress.org/obenland">Konstantin Obenland</a>, <a href="http://profiles.wordpress.org/drozdz">Krzysiek Drozdz</a>, <a href="http://profiles.wordpress.org/lancewillett">Lance Willett</a>, <a href="http://profiles.wordpress.org/leewillis77">Lee Willis</a>, <a href="http://profiles.wordpress.org/lkwdwrd">lkwdwrd</a>, <a href="http://profiles.wordpress.org/lpointet">lpointet</a>, <a href="http://profiles.wordpress.org/ldebrouwer">Luc De Brouwer</a>, <a href="http://profiles.wordpress.org/spmlucas">Lucas Karpiuk</a>, <a href="http://profiles.wordpress.org/mark8barnes">Mark Barnes</a>, <a href="http://profiles.wordpress.org/markjaquith">Mark Jaquith</a>, <a href="http://profiles.wordpress.org/markoheijnen">Marko Heijnen</a>, <a href="http://profiles.wordpress.org/marventus">Marventus</a>, <a href="http://profiles.wordpress.org/iammattthomas">Matt (Thomas) Miklic</a>, <a href="http://profiles.wordpress.org/mjbanks">Matt Banks</a>, <a href="http://profiles.wordpress.org/matt">Matt Mullenweg</a>, <a href="http://profiles.wordpress.org/mboynes">Matthew Boynes</a>, <a href="http://profiles.wordpress.org/mdbitz">Matthew Denton</a>, <a href="http://profiles.wordpress.org/mattheu">Matthew Haines-Young</a>, <a href="http://profiles.wordpress.org/mattonomics">mattonomics</a>, <a href="http://profiles.wordpress.org/mattyrob">mattyrob</a>, <a href="http://profiles.wordpress.org/matveb">Matías Ventura</a>, <a href="http://profiles.wordpress.org/maxcutler">Max Cutler</a>, <a href="http://profiles.wordpress.org/mcadwell">mcadwell</a>, <a href="http://profiles.wordpress.org/melchoyce">Mel Choyce</a>, <a href="http://profiles.wordpress.org/meloniq">meloniq</a>, <a href="http://profiles.wordpress.org/michael-arestad">Michael Arestad</a>, <a href="http://profiles.wordpress.org/michelwppi">Michel - xiligroup dev</a>, <a href="http://profiles.wordpress.org/mcsf">Miguel Fonseca</a>, <a href="http://profiles.wordpress.org/gradyetc">Mike Burns</a>, <a href="http://profiles.wordpress.org/mikehansenme">Mike Hansen</a>, <a href="http://profiles.wordpress.org/mikemanger">Mike Manger</a>, <a href="http://profiles.wordpress.org/mikeschinkel">Mike Schinkel</a>, <a href="http://profiles.wordpress.org/dh-shredder">Mike Schroder</a>, <a href="http://profiles.wordpress.org/mikecorkum">mikecorkum</a>, <a href="http://profiles.wordpress.org/mitchoyoshitaka">mitcho (Michael Yoshitaka Erlewine)</a>, <a href="http://profiles.wordpress.org/batmoo">Mohammad Jangda</a>, <a href="http://profiles.wordpress.org/morganestes">Morgan Estes</a>, <a href="http://profiles.wordpress.org/mor10">Morten Rand-Hendriksen</a>, <a href="http://profiles.wordpress.org/Nao">Naoko Takano</a>, <a href="http://profiles.wordpress.org/alex-ye">Nashwan Doaqan</a>, <a href="http://profiles.wordpress.org/nendeb55">nendeb55</a>, <a href="http://profiles.wordpress.org/celloexpressions">Nick Halsey</a>, <a href="http://profiles.wordpress.org/nicolealleyinteractivecom">Nicole Arnold</a>, <a href="http://profiles.wordpress.org/nikv">Nikhil Vimal (NikV)</a>, <a href="http://profiles.wordpress.org/nivijah">nivijah</a>, <a href="http://profiles.wordpress.org/nofearinc">nofearinc</a>, <a href="http://profiles.wordpress.org/nunomorgadinho">Nuno Morgadinho</a>, <a href="http://profiles.wordpress.org/olivm">olivM</a>, <a href="http://profiles.wordpress.org/jbkkd">Omer Korner</a>, <a href="http://profiles.wordpress.org/originalexe">OriginalEXE</a>, <a href="http://profiles.wordpress.org/oso96_2000">oso96_2000</a>, <a href="http://profiles.wordpress.org/patricknami">patricknami</a>, <a href="http://profiles.wordpress.org/pbearne">Paul Bearne</a>, <a href="http://profiles.wordpress.org/djpaul">Paul Gibbs</a>, <a href="http://profiles.wordpress.org/paulwilde">Paul Wilde</a>, <a href="http://profiles.wordpress.org/pavelevap">pavelevap</a>, <a href="http://profiles.wordpress.org/westi">Peter Westwood</a>, <a href="http://profiles.wordpress.org/philiparthurmoore">Philip Arthur Moore</a>, <a href="http://profiles.wordpress.org/mordauk">Pippin Williamson</a>, <a href="http://profiles.wordpress.org/nprasath002">Prasath Nadarajah</a>, <a href="http://profiles.wordpress.org/prettyboymp">prettyboymp</a>, <a href="http://profiles.wordpress.org/raamdev">Raam Dev</a>, <a href="http://profiles.wordpress.org/rachelbaker">rachelbaker</a>, <a href="http://profiles.wordpress.org/mauryaratan">Ram Ratan Maurya</a>, <a href="http://profiles.wordpress.org/ramonchiara">ramonchiara</a>, <a href="http://profiles.wordpress.org/ounziw">Rescuework Support</a>, <a href="http://profiles.wordpress.org/rhyswynne">Rhys Wynne</a>, <a href="http://profiles.wordpress.org/ricardocorreia">Ricardo Correia</a>, <a href="http://profiles.wordpress.org/theorboman">Richard Sweeney</a>, <a href="http://profiles.wordpress.org/iamfriendly">Richard Tape</a>, <a href="http://profiles.wordpress.org/richard2222">richard2222</a>, <a href="http://profiles.wordpress.org/rickalee">Ricky Lee Whittemore</a>, <a href="http://profiles.wordpress.org/miqrogroove">Robert Chapin</a>, <a href="http://profiles.wordpress.org/robmiller">robmiller</a>, <a href="http://profiles.wordpress.org/rodrigosprimo">Rodrigo Primo</a>, <a href="http://profiles.wordpress.org/romaimperator">romaimperator</a>, <a href="http://profiles.wordpress.org/roothorick">roothorick</a>, <a href="http://profiles.wordpress.org/ruudjoyo">ruud@joyo</a>, <a href="http://profiles.wordpress.org/ryan">Ryan Boren</a>, <a href="http://profiles.wordpress.org/rmccue">Ryan McCue</a>, <a href="http://profiles.wordpress.org/salcode">Sal Ferrarello</a>, <a href="http://profiles.wordpress.org/otto42">Samuel Wood (Otto)</a>, <a href="http://profiles.wordpress.org/sandyr">Sandeep</a>, <a href="http://profiles.wordpress.org/scottlee">Scott Lee</a>, <a href="http://profiles.wordpress.org/coffee2code">Scott Reilly</a>, <a href="http://profiles.wordpress.org/wonderboymusic">Scott Taylor</a>, <a href="http://profiles.wordpress.org/greglone">ScreenfeedFr</a>, <a href="http://profiles.wordpress.org/scribu">scribu</a>, <a href="http://profiles.wordpress.org/sdasse">sdasse</a>, <a href="http://profiles.wordpress.org/bootsz">Sean Butze</a>, <a href="http://profiles.wordpress.org/seanchayes">Sean Hayes</a>, <a href="http://profiles.wordpress.org/nessworthy">Sean Nessworthy</a>, <a href="http://profiles.wordpress.org/sergeybiryukov">Sergey Biryukov</a>, <a href="http://profiles.wordpress.org/shahpranaf">shahpranaf</a>, <a href="http://profiles.wordpress.org/shaunandrews">Shaun Andrews</a>, <a href="http://profiles.wordpress.org/shinichin">ShinichiN</a>, <a href="http://profiles.wordpress.org/pross">Simon Prosser</a>, <a href="http://profiles.wordpress.org/simonwheatley">Simon Wheatley</a>, <a href="http://profiles.wordpress.org/siobhan">Siobhan</a>, <a href="http://profiles.wordpress.org/siobhyb">Siobhan Bamber (siobhyb)</a>, <a href="http://profiles.wordpress.org/sirzooro">sirzooro</a>, <a href="http://profiles.wordpress.org/solarissmoke">solarissmoke</a>, <a href="http://profiles.wordpress.org/sonjanyc">sonjanyc</a>, <a href="http://profiles.wordpress.org/spencerfinnell">Spencer Finnell</a>, <a href="http://profiles.wordpress.org/piontkowski">Spencer Piontkowski</a>, <a href="http://profiles.wordpress.org/stephcook22">stephcook22</a>, <a href="http://profiles.wordpress.org/netweb">Stephen Edgar</a>, <a href="http://profiles.wordpress.org/stephenharris">Stephen Harris</a>, <a href="http://profiles.wordpress.org/sbruner">Steve Bruner</a>, <a href="http://profiles.wordpress.org/stevenkword">Steven Word</a>, <a href="http://profiles.wordpress.org/miyauchi">Takayuki Miyauchi</a>, <a href="http://profiles.wordpress.org/tanner-m">Tanner Moushey</a>, <a href="http://profiles.wordpress.org/tlovett1">Taylor Lovett</a>, <a href="http://profiles.wordpress.org/tbrams">tbrams</a>, <a href="http://profiles.wordpress.org/tellyworth">tellyworth</a>, <a href="http://profiles.wordpress.org/tobiasbg">TobiasBg</a>, <a href="http://profiles.wordpress.org/tomauger">Tom Auger</a>, <a href="http://profiles.wordpress.org/willmot">Tom Willmot</a>, <a href="http://profiles.wordpress.org/topher1kenobe">Topher</a>, <a href="http://profiles.wordpress.org/topquarky">topquarky</a>, <a href="http://profiles.wordpress.org/zodiac1978">Torsten Landsiedel</a>, <a href="http://profiles.wordpress.org/toru">Toru</a>, <a href="http://profiles.wordpress.org/wpsmith">Travis Smith</a>, <a href="http://profiles.wordpress.org/umeshsingla">Umesh Kumar</a>, <a href="http://profiles.wordpress.org/undergroundnetwork">undergroundnetwork</a>, <a href="http://profiles.wordpress.org/varunagw">VarunAgw</a>, <a href="http://profiles.wordpress.org/wawco">wawco</a>, <a href="http://profiles.wordpress.org/westonruter">Weston Ruter</a>, <a href="http://profiles.wordpress.org/wokamoto">wokamoto</a>, <a href="http://profiles.wordpress.org/xsonic">xsonic</a>, <a href="http://profiles.wordpress.org/yoavf">Yoav Farhi</a>, <a href="http://profiles.wordpress.org/yurivictor">Yuri Victor</a>, <a href="http://profiles.wordpress.org/zbtirrell">Zach Tirrell</a>, and <a href="http://profiles.wordpress.org/vanillalounge">Ze Fontainhas</a>. Also thanks to <a href="http://michaelpick.wordpress.com/">Michael Pick</a> for producing the release video.</p>
<p>If you want to follow along or help out, check out <a href="http://make.wordpress.org/">Make WordPress</a> and our <a href="http://make.wordpress.org/core/">core development blog</a>. Thanks for choosing WordPress. See you soon for version 4.0!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:45:"http://wordpress.org/news/2014/04/smith/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:33:"WordPress 3.9 Release Candidate 2";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:68:"http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate-2/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:77:"http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate-2/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 09:47:36 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3151";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:356:"The second release candidate for WordPress 3.9 is now available for testing. If you haven&#8217;t tested 3.9 yet, you&#8217;re running out of time! We made about five dozen changes since the first release candidate, and those changes are all helpfully summarized in our weekly post on the development blog. Probably the biggest fixes are to live [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2328:"<p>The second release candidate for WordPress 3.9 is now available for testing.</p>
<p>If you haven&#8217;t tested 3.9 yet, you&#8217;re running out of time! We made about five dozen changes since the <a title="WordPress 3.9 Release Candidate" href="http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate/">first release candidate</a>, and those changes are all helpfully summarized <a href="http://make.wordpress.org/core/?p=10237">in our weekly post</a> on the development blog. Probably the biggest fixes are to live widget previews and the new theme browser, along with some extra TinyMCE compatibility and some RTL fixes.</p>
<p><strong>Plugin authors:</strong> Could you test your plugins against 3.9, and if they&#8217;re compatible, make sure they are marked as tested up to 3.9? It only takes a few minutes and this really helps make launch easier. Be sure to follow along the core development blog; we&#8217;ve been posting <a href="http://make.wordpress.org/core/tag/3-9-dev-notes/">notes for developers for 3.9</a>. (For example: <a href="http://make.wordpress.org/core/2014/04/15/html5-galleries-captions-in-wordpress-3-9/">HTML5</a>, <a href="http://make.wordpress.org/core/2014/04/14/symlinked-plugins-in-wordpress-3-9/">symlinks</a>, <a href="http://make.wordpress.org/core/2014/04/07/mysql-in-wordpress-3-9/">MySQL</a>, <a href="http://make.wordpress.org/core/2014/04/11/plupload-2-x-in-wordpress-3-9/">Plupload</a>.)</p>
<p>To test WordPress 3.9 RC2, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.9-RC2.zip">download the release candidate here</a> (zip). If you’d like to learn more about what’s new in WordPress 3.9, visit the nearly complete About screen in your dashboard (<strong><img src="http://i0.wp.com/core.svn.wordpress.org/branches/3.6/wp-content/themes/twentyten/images/wordpress.png?w=692" alt="" width="16" height="16" /> → About</strong> in the toolbar) and also check out <a title="WordPress 3.9 Beta 1" href="http://wordpress.org/news/2014/03/wordpress-3-9-beta-1/">the Beta 1 post</a>.</p>
<p><em>This is for testing,</em><br />
<em>so not recommended for<br />
production sites—yet.</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:73:"http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate-2/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:42:"
		
		
		
		
		
				

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:35:"WordPress 3.8.3 Maintenance Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:50:"http://wordpress.org/news/2014/04/wordpress-3-8-3/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wordpress.org/news/2014/04/wordpress-3-8-3/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 14 Apr 2014 19:29:13 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3145";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:338:"WordPress 3.8.3 is now available to fix a small but unfortunate bug in the WordPress 3.8.2 security release. The &#8220;Quick Draft&#8221; tool on the dashboard screen was broken in the 3.8.2 update. If you tried to use it, your draft would disappear and it wouldn&#8217;t save. While we doubt anyone was writing a novella using [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2339:"<p>WordPress 3.8.3 is now available to fix a small but unfortunate bug in the <a title="WordPress 3.8.2 Security Release" href="http://wordpress.org/news/2014/04/wordpress-3-8-2/">WordPress 3.8.2 security release</a>.</p>
<p>The &#8220;Quick Draft&#8221; tool on the dashboard screen was broken in the 3.8.2 update. If you tried to use it, your draft would disappear and it wouldn&#8217;t save. While we doubt anyone was writing a novella using this tool, <em>any</em> loss of content is unacceptable to us.</p>
<p>We recognize how much trust you place in us to safeguard your content, and we take this responsibility very seriously. We&#8217;re sorry we let you down.</p>
<p>We&#8217;ve all lost words we&#8217;ve written before, like an email thanks to a cat on the keyboard or a term paper to a blue screen of death. Over the last few WordPress releases, we&#8217;ve made a number of improvements to features like autosaves and revisions. With revisions, an old edit can always be restored. We&#8217;re trying our hardest to save your content somewhere even if your power goes out or your browser crashes. We even monitor your internet connection and prevent you from hitting that &#8220;Publish&#8221; button at the exact moment the coffee shop Wi-Fi has a hiccup.</p>
<p>It&#8217;s <em>possible</em> that the quick draft you lost last week is still in the database, and just hidden from view. As an added complication, these &#8220;discarded drafts&#8221; normally get deleted after seven days, and it&#8217;s already been six days since the release. If we were able to rescue your draft, you&#8217;ll see it on the &#8220;All Posts&#8221; screen after you update to 3.8.3. (We&#8217;ll also be pushing 3.8.3 out as a background update, so you may just see a draft appear.)</p>
<p>So, if you tried to jot down a quick idea last week, I hope WordPress has recovered it for you. Maybe it&#8217;ll turn into that novella.</p>
<p><a href="http://wordpress.org/download/">Download WordPress 3.8.3</a> or click &#8220;Update Now&#8221; on Dashboard → Updates.</p>
<p><em>This affected version 3.7.2 as well, so we&#8217;re pushing a 3.7.3 to these installs, but we&#8217;d encourage you to update to the latest and greatest.</em></p>
<hr />
<p><em>Now for some good news:<br />
WordPress 3.9 is near.<br />
Expect it this week</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2014/04/wordpress-3-8-3/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"WordPress 3.9 Release Candidate";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:75:"http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 08 Apr 2014 21:05:21 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3129";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:338:"As teased earlier, the first release candidate for WordPress 3.9 is now available for testing! We hope to ship WordPress 3.9 next week, but we need your help to get there. If you haven’t tested 3.9 yet, there’s no time like the present. (Please, not on a production site, unless you’re adventurous.) To test WordPress 3.9 [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:3022:"<p><a href="http://wordpress.org/news/2014/04/wordpress-3-8-2/">As teased earlier</a>, the first release candidate for WordPress 3.9 is now available for testing!</p>
<p>We hope to ship WordPress 3.9 <em>next week</em>, but we need your help to get there. If you haven’t tested 3.9 yet, there’s no time like the present. (Please, not on a production site, unless you’re adventurous.)</p>
<p>To test WordPress 3.9 RC1, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.9-RC1.zip">download the release candidate here</a> (zip). If you’d like to learn more about what’s new in WordPress 3.9, visit the work-in-progress About screen in your dashboard (<strong><img src="http://i0.wp.com/core.svn.wordpress.org/branches/3.6/wp-content/themes/twentyten/images/wordpress.png?w=692" alt="" width="16" height="16" /> → About</strong> in the toolbar) and check out <a title="WordPress 3.9 Beta 1" href="http://wordpress.org/news/2014/03/wordpress-3-9-beta-1/">the Beta 1 post</a>.</p>
<p><strong>Think you’ve found a bug? </strong>Please post to the <a href="http://wordpress.org/support/forum/alphabeta/">Alpha/Beta area in the support forums</a>. If any known issues come up, you’ll be able to <a href="http://core.trac.wordpress.org/report/5">find them here</a>.</p>
<p><strong>If you&#8217;re a plugin author</strong>, there are two important changes in particular to be aware of:</p>
<ul>
<li>TinyMCE received a major update, to version 4.0. Any editor plugins written for TinyMCE 3.x might require some updates. (If things broke, we&#8217;d like to hear about them so we can make adjustments.) For more, see TinyMCE&#8217;s <a href="http://www.tinymce.com/wiki.php/Tutorial:Migration_guide_from_3.x">migration guide</a> and <a href="http://www.tinymce.com/wiki.php/api4:index">API documentation</a>, and the notes on the <a href="http://make.wordpress.org/core/2014/01/18/tinymce-4-0-is-in-core/">core development blog</a>.</li>
<li>WordPress 3.9 now uses the MySQLi Improved extension for sites running PHP 5.5. Any plugins that made direct calls to <code>mysql_*</code> functions will experience some problems on these sites. For more information, see the notes on the <a href="http://make.wordpress.org/core/2014/04/07/mysql-in-wordpress-3-9/">core development blog</a>.</li>
</ul>
<p>Be sure to follow along the core development blog, where we will be continuing to post <a href="http://make.wordpress.org/core/tag/3-9-dev-notes/">notes for developers for 3.9</a>. (For example, read <a href="http://make.wordpress.org/core/2014/03/27/masonry-in-wordpress-3-9/">this</a> if you are using Masonry in your theme.) And please, please update your plugin&#8217;s <em>Tested up to</em> version in the readme to 3.9 before April 16.</p>
<p><em>Release candidate<br />
This haiku&#8217;s the easy one<br />
3.9 is near</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:71:"http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:32:"WordPress 3.8.2 Security Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:50:"http://wordpress.org/news/2014/04/wordpress-3-8-2/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wordpress.org/news/2014/04/wordpress-3-8-2/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 08 Apr 2014 19:04:44 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Security";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3124";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:355:"WordPress 3.8.2 is now available. This is an important security release for all previous versions and we strongly encourage you to update your sites immediately. This releases fixes a weakness that could let an attacker force their way into your site by forging authentication cookies. This was discovered and fixed by Jon Cave of the WordPress [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2272:"<p>WordPress 3.8.2 is now available. This is an important security release for all previous versions and we strongly encourage you to update your sites immediately.</p>
<p>This releases fixes a weakness that could let an attacker force their way into your site by forging authentication cookies. This was discovered and fixed by <a href="http://joncave.co.uk/">Jon Cave</a> of the WordPress security team.</p>
<p>It also contains a fix to prevent a user with the Contributor role from improperly publishing posts. Reported by <a href="http://edik.ch/">edik</a>.</p>
<p>This release also fixes nine bugs and contains three other security hardening changes:</p>
<ul>
<li>Pass along additional information when processing pingbacks to help hosts identify potentially abusive requests.</li>
<li>Fix a low-impact SQL injection by trusted users. Reported by <a href="http://www.dxw.com/">Tom Adams</a> of dxw.</li>
<li>Prevent possible cross-domain scripting through Plupload, the third-party library WordPress uses for uploading files. Reported by <a href="http://szgru.website.pl/">Szymon Gruszecki</a>.</li>
</ul>
<p>We appreciated <a href="http://codex.wordpress.org/FAQ_Security">responsible disclosure</a> of these security issues directly to our security team. For more information on all of the changes, see the <a href="http://codex.wordpress.org/Version_3.8.2">release notes</a> or consult <a href="https://core.trac.wordpress.org/log/branches/3.8?rev=28057&amp;stop_rev=27024">the list of changes</a>.</p>
<p><a href="http://wordpress.org/download/">Download WordPress 3.8.2</a> or venture over to <strong>Dashboard → Updates</strong> and simply click &#8220;Update Now.&#8221;</p>
<p>Sites that support automatic background updates will be updated to WordPress 3.8.2 within 12 hours. If you are still on WordPress 3.7.1, you will be updated to 3.7.2, which contains the same security fixes as 3.8.2. We don&#8217;t support older versions, so please update to 3.8.2 for the latest and greatest.</p>
<p>Already testing WordPress 3.9? The first release candidate is <a href="https://wordpress.org/wordpress-3.9-RC1.zip">now available</a> (zip) and it contains these security fixes. Look for a full announcement later today; we expect to release 3.9 next week.</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2014/04/wordpress-3-8-2/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:20:"WordPress 3.9 Beta 3";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-3/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:64:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-3/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 29 Mar 2014 13:15:10 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3106";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:373:"The third (and maybe last) beta of WordPress 3.9 is now available for download. Beta 3 includes more than 200 changes, including: New features like live widget previews and the new theme installer are now more ready for prime time, so check &#8216;em out. UI refinements when editing images and when working with media in the editor. We&#8217;ve also brought [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:2668:"<p>The third (and maybe last) beta of WordPress 3.9 is now available for download.</p>
<p>Beta 3 includes more than 200 <a href="https://core.trac.wordpress.org/log?rev=27850&amp;stop_rev=27639&amp;limit=300">changes</a>, including:</p>
<ul>
<li>New features like live widget previews and the new theme installer are now more ready for prime time, so check &#8216;em out.</li>
<li>UI refinements when editing images and when working with media in the editor. We&#8217;ve also brought back some of the advanced display settings for images.</li>
<li>If you want to test out audio and video playlists, the links will appear in the media manager once you&#8217;ve uploaded an audio or video file.</li>
<li>For theme developers, we&#8217;ve added HTML5 caption support (<a class="reopened ticket" title="task (blessed): HTML5 captions (reopened)" href="https://core.trac.wordpress.org/ticket/26642">#26642</a>) to match the new gallery support (<a class="closed ticket" title="enhancement: HTML5 Galleries (closed: fixed)" href="https://core.trac.wordpress.org/ticket/26697">#26697</a>).</li>
<li>The formatting function that turns straight quotes into smart quotes (among other things) underwent some changes to drastically speed it up, so let us know if you see anything weird.</li>
</ul>
<p><strong>We need your help</strong>. We&#8217;re still aiming for an April release, which means the next week will be critical for identifying and squashing bugs. If you&#8217;re just joining us, please see <a href="https://wordpress.org/news/2014/03/wordpress-3-9-beta-1/">the Beta 1 announcement post</a> for what to look out for.</p>
<p><strong>If you think you’ve found a bug</strong>, you can post to the <a href="http://wordpress.org/support/forum/alphabeta">Alpha/Beta area</a> in the support forums, where friendly moderators are standing by. <b>Plugin developers</b><strong>,</strong> if you haven&#8217;t tested WordPress 3.9 yet, now is the time — and be sure to update the &#8220;tested up to&#8221; version for your plugins so they&#8217;re listed as compatible with 3.9.</p>
<p><strong>This software is still in development,</strong> so we don’t recommend you run it on a production site. Consider setting up a test site just to play with the new version. To test WordPress 3.9, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.9-beta3.zip">download the beta here</a> (zip).</p>
<p><em>WordPress 3.9<br />
Let&#8217;s make the date official<br />
It&#8217;s April 16</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-3/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:20:"WordPress 3.9 Beta 2";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-2/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:64:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-2/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 20 Mar 2014 05:01:25 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3101";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:309:"WordPress 3.9 Beta 2 is now available for testing! We&#8217;ve made more than a hundred changes since Beta 1, but we still need your help if we&#8217;re going to hit our goal of an April release. For what to look out for, please head on over to the Beta 1 announcement post. Some of the changes in [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:1901:"<p>WordPress 3.9 Beta 2 is now available for testing!</p>
<p>We&#8217;ve made more than a hundred <a href="https://core.trac.wordpress.org/log?rev=27639&amp;stop_rev=27500&amp;limit=200">changes</a> since Beta 1, but we still need your help if we&#8217;re going to hit our goal of an April release. For what to look out for, please head on over to <a href="https://wordpress.org/news/2014/03/wordpress-3-9-beta-1/">the Beta 1 announcement post</a>. Some of the changes in Beta 2 include:</p>
<ul>
<li>Rendering of embedded audio and video players directly in the visual editor.</li>
<li>Visual and functional improvements to the editor, the media manager, and theme installer.</li>
<li>Various bug fixes to TinyMCE, the software behind the visual editor.</li>
<li>Lots of fixes to widget management in the theme customizer.</li>
</ul>
<p>As always,<strong> if you think you’ve found a bug</strong>, you can post to the <a href="http://wordpress.org/support/forum/alphabeta">Alpha/Beta area</a> in the support forums. Or, if you’re comfortable writing a reproducible bug report, <a href="https://make.wordpress.org/core/reports/">file one on the WordPress Trac</a>. There, you can also find <a href="http://core.trac.wordpress.org/tickets/major">a list of known bugs</a> and <a href="http://core.trac.wordpress.org/query?status=closed&amp;group=component&amp;milestone=3.9">everything we’ve fixed</a> so far.</p>
<p><strong>This software is still in development,</strong> so we don’t recommend you run it on a production site. Consider setting up a test site just to play with the new version. To test WordPress 3.9, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.9-beta2.zip">download the beta here</a> (zip).</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-2/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:45:"
		
		
		
		
		
				
		

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:20:"WordPress 3.9 Beta 1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-1/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:64:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-1/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 11 Mar 2014 13:42:19 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:2:{i:0;a:5:{s:4:"data";s:11:"Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3083";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:329:"I&#8217;m excited to announce that the first beta of WordPress 3.9 is now available for testing. WordPress 3.9 is due out next month &#8212; but in order to hit that goal, we need your help testing all of the goodies we&#8217;ve added: We updated TinyMCE, the software powering the visual editor, to the latest version. [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:6065:"<p>I&#8217;m excited to announce that the <strong>first beta of WordPress 3.9</strong> is now available for testing.</p>
<p>WordPress 3.9 is due out next month &#8212; but in order to hit that goal, <strong>we need your help</strong> testing all of the goodies we&#8217;ve added:</p>
<ul>
<li>We updated TinyMCE, the software powering the visual editor, to the latest version. Be on the lookout for cleaner markup. Also try the new paste handling &#8212; if you paste in a block of text from Microsoft Word, for example, it will no longer come out terrible. (The &#8220;Paste from Word&#8221; button you probably never noticed has been removed.) It&#8217;s possible some plugins that added stuff to the visual editor (like a new toolbar button) no longer work, so we&#8217;d like to hear about them (<a href="https://core.trac.wordpress.org/ticket/24067">#24067</a>). (And be sure to <a href="http://wordpress.org/support/">open a support thread</a> for the plugin author.)</li>
<li>We&#8217;ve added <strong>widget management to live previews</strong> (the customizer). Please test editing, adding, and rearranging widgets! (<a href="https://core.trac.wordpress.org/ticket/27112">#27112</a>) We&#8217;ve also added the ability to upload, crop, and manage header images, without needing to leave the preview. (<a href="https://core.trac.wordpress.org/ticket/21785">#21785</a>)</li>
<li>We brought 3.8&#8242;s beautiful new theme browsing experience to the <strong>theme installer</strong>. Check it out! (<a title="View ticket" href="https://core.trac.wordpress.org/ticket/27055">#27055</a>)</li>
<li><strong>Galleries</strong> now receive a live preview in the editor. Upload some photos and insert a gallery to see this in action. (<a href="https://core.trac.wordpress.org/ticket/26959">#26959</a>)</li>
<li>You can now <strong>drag-and-drop</strong> images directly onto the editor to upload them. It can be a bit finicky, so try it and help us work out the kinks. (<a href="https://core.trac.wordpress.org/ticket/19845">#19845</a>)</li>
<li>Some things got improved around <strong>editing images</strong>. It&#8217;s a lot easier to make changes to an image after you insert it into a post (<a class="closed" title="View ticket" href="https://core.trac.wordpress.org/ticket/24409">#24409</a>) and you no longer get kicked to a new window when you need to crop or rotate an image (<a href="https://core.trac.wordpress.org/ticket/21811">#21811</a>).</li>
<li>New <strong>audio/video playlists</strong>. Upload a few audio or video files to test these. (<a href="https://core.trac.wordpress.org/ticket/26631">#26631</a>)</li>
</ul>
<p><strong>If you think you’ve found a bug</strong>, you can post to the <a href="http://wordpress.org/support/forum/alphabeta">Alpha/Beta area</a> in the support forums. We&#8217;d love to hear from you! If you’re comfortable writing a reproducible bug report, <a href="https://make.wordpress.org/core/reports/">file one on the WordPress Trac</a>. There, you can also find <a href="http://core.trac.wordpress.org/tickets/major">a list of known bugs</a> and <a href="http://core.trac.wordpress.org/query?status=closed&amp;group=component&amp;milestone=3.9">everything we’ve fixed</a> so far.</p>
<p><strong>This software is still in development,</strong> so we don’t recommend you run it on a production site. Consider setting up a test site just to play with the new version. To test WordPress 3.9, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.9-beta1.zip">download the beta here</a> (zip).</p>
<hr />
<p><strong>DEVELOPERS!</strong> Hello! There&#8217;s lots for you, too.</p>
<p><strong>Please test your plugins and themes!</strong> There&#8217;s a lot of great stuff under the hood in 3.9 and we hope to blog a bit about them in the coming days. If you haven&#8217;t been reading the awesome <a href="http://make.wordpress.org/core/tag/week-in-core/">weekly summaries</a> on the <a href="http://make.wordpress.org/core/">main core development blog</a>, that&#8217;s a great place to start. (You should definitely follow that blog.) For now, here are some things to watch out for when testing:</p>
<ul>
<li>The <strong>load process in multisite</strong> got rewritten. If you notice any issues with your network, see <a href="https://core.trac.wordpress.org/ticket/27003">#27003</a>.</li>
<li>We now use the <strong>MySQL Improved (mysqli) database extension</strong> if you&#8217;re running a recent version of PHP (<a href="https://core.trac.wordpress.org/ticket/21663">#21663</a>). Please test your plugins and see that everything works well, and please make sure you&#8217;re not calling <code>mysql_*</code> functions directly.</li>
<li><strong>Autosave</strong> was refactored, so if you see any issues related to autosaving, heartbeat, etc., let us know (<a href="https://core.trac.wordpress.org/ticket/25272">#25272</a>).</li>
<li>Library updates, in particular Backbone 1.1 and Underscore 1.6 (<a href="https://core.trac.wordpress.org/ticket/26799">#26799</a>). Also Masonry 3 (<a href="https://core.trac.wordpress.org/ticket/25351">#25351</a>), PHPMailer (<a href="https://core.trac.wordpress.org/ticket/25560">#25560</a>), Plupload (<a href="https://core.trac.wordpress.org/ticket/25663">#25663</a>), and TinyMCE (<a href="https://core.trac.wordpress.org/ticket/24067">#24067</a>).</li>
<li>TinyMCE 4.0 is a <em>major</em> update. Please see TinyMCE&#8217;s <a href="http://www.tinymce.com/wiki.php/Tutorial:Migration_guide_from_3.x">upgrade guide</a> and our <a href="https://core.trac.wordpress.org/ticket/24067">implementation ticket</a> for more. If you have any questions or problems, please <a href="http://wordpress.org/support/forum/alphabeta">open a thread in the support forums</a>.</li>
</ul>
<p>Happy testing!</p>
<p><em><em>Lots of improvements<br />
Little things go a long way</em><br />
Please test beta one<br />
</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:60:"http://wordpress.org/news/2014/03/wordpress-3-9-beta-1/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:42:"
		
		
		
		
		
				

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:35:"WordPress 3.8.1 Maintenance Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:50:"http://wordpress.org/news/2014/01/wordpress-3-8-1/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wordpress.org/news/2014/01/wordpress-3-8-1/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 23 Jan 2014 20:37:49 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3063";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:358:"After six weeks and more than 9.3 million downloads of WordPress 3.8, we&#8217;re pleased to announce WordPress 3.8.1 is now available. Version 3.8.1 is a maintenance releases that addresses 31 bugs in 3.8, including various fixes and improvements for the new dashboard design and new themes admin screen. An issue with taxonomy queries in WP_Query [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:3809:"<p>After six weeks and more than <a href="http://wordpress.org/download/counter/">9.3 million downloads</a> of WordPress 3.8, we&#8217;re pleased to announce WordPress 3.8.1 is now available.</p>
<p>Version 3.8.1 is a maintenance releases that addresses 31 bugs in 3.8, including various fixes and improvements for the new dashboard design and new themes admin screen. An issue with taxonomy queries in WP_Query was resolved. And if you&#8217;ve been frustrated by submit buttons that won&#8217;t do anything when you click on them (or thought you were going crazy, like some of us), we&#8217;ve found and fixed this &#8220;dead zone&#8221; on submit buttons.</p>
<p>It also contains a fix for <strong>embedding tweets</strong> (by placing the URL to the tweet on its own line), which was broken due to a recent Twitter API change. (For more on Embeds, see <a href="http://codex.wordpress.org/Embeds">the Codex</a>.)</p>
<p>For a full list of changes, consult the <a href="http://core.trac.wordpress.org/query?milestone=3.8.1">list of tickets</a> and <a href="https://core.trac.wordpress.org/log/branches/3.8?rev=27018&amp;stop_rev=26862">the changelog</a>. There&#8217;s also a <a href="http://make.wordpress.org/core/2014/01/22/wordpress-3-8-1-release-candidate/">detailed summary</a> for developers on the development blog.</p>
<p>If you are one of the millions already running WordPress 3.8, we will start rolling out automatic background updates for WordPress 3.8.1 in the next few hours. For sites <a href="http://wordpress.org/plugins/background-update-tester/">that support them</a>, of course.</p>
<p><a href="http://wordpress.org/download/">Download WordPress 3.8.1</a> or venture over to <strong>Dashboard → Updates</strong> and simply click &#8220;Update Now.&#8221;</p>
<p>Thanks to all of these fine individuals for contributing to 3.8.1:</p>
<p><a href="http://profiles.wordpress.org/jorbin">Aaron Jorbin</a>, <a href="http://profiles.wordpress.org/collinsinternet">Allan Collins</a>, <a href="http://profiles.wordpress.org/nacin">Andrew Nacin</a>, <a href="http://profiles.wordpress.org/azaozz">Andrew Ozz</a>, <a href="http://profiles.wordpress.org/aubreypwd">Aubrey Portwood</a>, <a href="http://profiles.wordpress.org/empireoflight">Ben Dunkle</a>, <a href="http://profiles.wordpress.org/cojennin">Connor Jennings</a>, <a href="http://profiles.wordpress.org/dd32">Dion Hulse</a>, <a href="http://profiles.wordpress.org/ocean90">Dominik Schilling</a>, <a href="http://profiles.wordpress.org/fboender">fboender</a>, <a href="http://profiles.wordpress.org/avryl">Janneke Van Dorpe</a>, <a href="http://profiles.wordpress.org/janrenn">janrenn</a>, <a href="http://profiles.wordpress.org/joedolson">Joe Dolson</a>, <a href="http://profiles.wordpress.org/johnbillion">John Blackbourn</a>, <a href="#">José Pino</a>, <a href="http://profiles.wordpress.org/kovshenin">Konstantin Kovshenin</a>, <a href="http://profiles.wordpress.org/matveb">Matias Ventura</a>, <a href="http://profiles.wordpress.org/mattheu">Matthew Haines-Young</a>, <a href="http://profiles.wordpress.org/iammattthomas">Matt Thomas</a>, <a href="http://profiles.wordpress.org/melchoyce">Mel Choyce</a>, <a href="http://profiles.wordpress.org/batmoo">Mohammad Jangda</a>, <a href="http://profiles.wordpress.org/morganestes">Morgan Estes</a>, <a href="http://profiles.wordpress.org/nivijah">nivijah</a>, <a href="http://profiles.wordpress.org/wonderboymusic">Scott Taylor</a>, <a href="http://profiles.wordpress.org/sergeybiryukov">Sergey Biryukov</a>, <a href="http://profiles.wordpress.org/undergroundnetwork">undergroundnetwork</a>, and <a href="http://profiles.wordpress.org/yurivictor">Yuri Victor</a>.</p>
<p><em>WordPress three eight one<br />
We heard you didn&#8217;t like bugs<br />
So we took them out</em></p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/news/2014/01/wordpress-3-8-1/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:42:"
		
		
		
		
		
				

		
		
				
			
		
		";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:5:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:26:"WordPress 3.8 “Parker”";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:41:"http://wordpress.org/news/2013/12/parker/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:50:"http://wordpress.org/news/2013/12/parker/#comments";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 12 Dec 2013 17:00:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"category";a:1:{i:0;a:5:{s:4:"data";s:8:"Releases";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=2765";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:354:"Version 3.8 of WordPress, named “Parker” in honor of Charlie Parker, bebop innovator, is available for download or update in your WordPress dashboard. We hope you&#8217;ll think this is the most beautiful update yet. Introducing a modern new design WordPress has gotten a facelift. 3.8 brings a fresh new look to the entire admin dashboard. [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Matt Mullenweg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:40:"http://purl.org/rss/1.0/modules/content/";a:1:{s:7:"encoded";a:1:{i:0;a:5:{s:4:"data";s:19098:"<p>Version 3.8 of WordPress, named “Parker” in honor of <a href="http://en.wikipedia.org/wiki/Charlie_Parker">Charlie Parker</a>, bebop innovator, is available <a href="http://wordpress.org/download/">for download</a> or update in your WordPress dashboard. We hope you&#8217;ll think this is the most beautiful update yet.</p>
<div id="v-6wORgoGb-1" class="video-player"><embed id="v-6wORgoGb-1-video" src="http://s0.videopress.com/player.swf?v=1.03&amp;guid=6wORgoGb&amp;isDynamicSeeking=true" type="application/x-shockwave-flash" width="692" height="388" wmode="direct" seamlesstabbing="true" allowfullscreen="true" allowscriptaccess="always" overstretch="true"></embed></div>
<h2 class="aligncenter">Introducing a modern new design</h2>
<p><img class="wp-image-2951 aligncenter" alt="overview" src="http://i0.wp.com/wpdotorg.files.wordpress.com/2013/12/overview.jpg?resize=623%2C193" data-recalc-dims="1" /></p>
<p>WordPress has gotten a facelift. 3.8 brings a fresh new look to the entire admin dashboard. Gone are overbearing gradients and dozens of shades of grey — bring on a bigger, bolder, more colorful design!</p>
<p><img class="aligncenter  wp-image-2856" style="margin-left: 0;margin-right: 0" alt="about-modern-wordpress" src="http://i2.wp.com/wpdotorg.files.wordpress.com/2013/12/design.png?resize=623%2C151" data-recalc-dims="1" /></p>
<h3>Modern aesthetic</h3>
<p>The new WordPress dashboard has a fresh, uncluttered design that embraces clarity and simplicity.</p>
<h3>Clean typography</h3>
<p>The Open Sans typeface provides simple, friendly text that is optimized for both desktop and mobile viewing. It’s even open source, just like WordPress.</p>
<h3>Refined contrast</h3>
<p>We think beautiful design should never sacrifice legibility. With superior contrast and large, comfortable type, the new design is easy to read and a pleasure to navigate.</p>
<hr />
<h2 class="aligncenter">WordPress on every device</h2>
<p><img class="alignright  wp-image-2984" alt="responsive" src="http://i2.wp.com/wpdotorg.files.wordpress.com/2013/12/responsive.jpg?resize=255%2C255" data-recalc-dims="1" />We all access the internet in different ways. Smartphone, tablet, notebook, desktop — no matter what you use, WordPress will adapt and you’ll feel right at home.</p>
<h3>High definition at high speed</h3>
<p>WordPress is sharper than ever with new vector-based icons that scale to your screen. By ditching pixels, pages load significantly faster, too.</p>
<hr />
<h2 class="aligncenter">Admin color schemes to match your personality</h2>
<p><img class="aligncenter  wp-image-2954" alt="colors" src="http://i0.wp.com/wpdotorg.files.wordpress.com/2013/12/colors.jpg?resize=623%2C339" data-recalc-dims="1" /></p>
<p>WordPress just got a colorful new update. We’ve included eight new admin color schemes so you can pick the one that suits you best.</p>
<p>Color schemes can be previewed and changed from your Profile page.</p>
<hr />
<h2 class="aligncenter">Refined theme management</h2>
<p><img class="alignright  wp-image-2967" alt="themes" src="http://i0.wp.com/wpdotorg.files.wordpress.com/2013/12/themes.jpg?resize=360%2C344" data-recalc-dims="1" />The new themes screen lets you survey your themes at a glance. Or want more information? Click to discover more. Then sit back and use your keyboard’s navigation arrows to flip through every theme you’ve got.</p>
<h3>Smoother widget experience</h3>
<p>Drag-drag-drag. Scroll-scroll-scroll. Widget management can be complicated. With the new design, we’ve worked to streamline the widgets screen.</p>
<p>Have a large monitor? Multiple widget areas stack side-by-side to use the available space. Using a tablet? Just tap a widget to add it.</p>
<hr />
<h2 class="aligncenter">Twenty Fourteen, a sleek new magazine theme</h2>
<p><img class="aligncenter size-large wp-image-2789" alt="The new Twenty Fourteen theme displayed on a laptop. tablet and phone" src="http://i0.wp.com/wpdotorg.files.wordpress.com/2013/12/twentyfourteen.jpg?resize=692%2C275" data-recalc-dims="1" /></p>
<h3>Turn your blog into a magazine</h3>
<p>Create a beautiful magazine-style site with WordPress and Twenty Fourteen. Choose a grid or a slider to display featured content on your homepage. Customize your site with three widget areas or change your layout with two page templates.</p>
<p>With a striking design that does not compromise our trademark simplicity, Twenty Fourteen is our most intrepid default theme yet.</p>
<hr />
<h2>Beginning of a new era</h2>
<p>This release was led by Matt Mullenweg. This is our second release using the new plugin-first development process, with a much shorter timeframe than in the past. We think it’s been going great. You can check out the features currently in production on the <a title="Make WordPress Core" href="http://make.wordpress.org/core/" target="_blank">make/core blog</a>.</p>
<p>There are 188 contributors with props in this release:</p>
<p><a href="http://profiles.wordpress.org/aaronholbrook">Aaron Holbrook</a>, <a href="http://profiles.wordpress.org/jorbin">Aaron Jorbin</a>, <a href="http://profiles.wordpress.org/adamsilverstein">adamsilverstein</a>, <a href="http://profiles.wordpress.org/admiralthrawn">admiralthrawn</a>, <a href="http://profiles.wordpress.org/ahoereth">Alexander Hoereth</a>, <a href="http://profiles.wordpress.org/collinsinternet">Allan Collins</a>, <a href="http://profiles.wordpress.org/sabreuse">Amy Hendrix (sabreuse)</a>, <a href="http://profiles.wordpress.org/nacin">Andrew Nacin</a>, <a href="http://profiles.wordpress.org/azaozz">Andrew Ozz</a>, <a href="http://profiles.wordpress.org/aralbald">Andrey Kabakchiev</a>, <a href="http://profiles.wordpress.org/andykeith">Andy Keith</a>, <a href="http://profiles.wordpress.org/apeatling">Andy Peatling</a>, <a href="http://profiles.wordpress.org/ankitgadertcampcom">Ankit Gade</a>, <a href="http://profiles.wordpress.org/atimmer">Anton Timmermans</a>, <a href="http://profiles.wordpress.org/fliespl">Arkadiusz Rzadkowolski</a>, <a href="http://profiles.wordpress.org/aubreypwd">Aubrey Portwood</a>, <a href="http://profiles.wordpress.org/bassgang">bassgang</a>, <a href="http://profiles.wordpress.org/empireoflight">Ben Dunkle</a>, <a href="http://profiles.wordpress.org/bananastalktome">Billy Schneider</a>, <a href="http://profiles.wordpress.org/binarymoon">binarymoon</a>, <a href="http://profiles.wordpress.org/bradyvercher">Brady Vercher</a>, <a href="http://profiles.wordpress.org/bramd">bramd</a>, <a href="http://profiles.wordpress.org/kraftbj">Brandon Kraft</a>, <a href="http://profiles.wordpress.org/rzen">Brian Richards</a>, <a href="http://profiles.wordpress.org/bpetty">Bryan Petty</a>, <a href="http://profiles.wordpress.org/calin">Calin Don</a>, <a href="http://profiles.wordpress.org/carldanley">Carl Danley</a>, <a href="http://profiles.wordpress.org/sixhours">Caroline Moore</a>, <a href="http://profiles.wordpress.org/caspie">Caspie</a>, <a href="http://profiles.wordpress.org/chrisbliss18">Chris Jean</a>, <a href="http://profiles.wordpress.org/iblamefish">Clinton Montague</a>, <a href="http://profiles.wordpress.org/cojennin">Connor Jennings</a>, <a href="http://profiles.wordpress.org/corphi">Corphi</a>, <a href="http://profiles.wordpress.org/dbernar1">Dan Bernardic</a>, <a href="http://profiles.wordpress.org/danieldudzic">Daniel Dudzic</a>, <a href="http://profiles.wordpress.org/koop">Daryl Koopersmith</a>, <a href="http://profiles.wordpress.org/datafeedrcom">datafeedr</a>, <a href="http://profiles.wordpress.org/lessbloat">Dave Martin</a>, <a href="http://profiles.wordpress.org/drw158">Dave Whitley</a>, <a href="http://profiles.wordpress.org/designsimply">designsimply</a>, <a href="http://profiles.wordpress.org/dd32">Dion Hulse</a>, <a href="http://profiles.wordpress.org/ocean90">Dominik Schilling</a>, <a href="http://profiles.wordpress.org/dougwollison">Doug Wollison</a>, <a href="http://profiles.wordpress.org/drewapicture">Drew Jaynes</a>, <a href="http://profiles.wordpress.org/dziudek">dziudek</a>, <a href="http://profiles.wordpress.org/plocha">edik</a>, <a href="http://profiles.wordpress.org/ericlewis">Eric Andrew Lewis</a>, <a href="http://profiles.wordpress.org/ericmann">Eric Mann</a>, <a href="http://profiles.wordpress.org/ethitter">Erick Hitter</a>, <a href="http://profiles.wordpress.org/evansolomon">Evan Solomon</a>, <a href="http://profiles.wordpress.org/faison">Faison</a>, <a href="http://profiles.wordpress.org/fboender">fboender</a>, <a href="http://profiles.wordpress.org/frank-klein">Frank Klein</a>, <a href="http://profiles.wordpress.org/garyj">Gary Jones</a>, <a href="http://profiles.wordpress.org/pento">Gary Pendergast</a>, <a href="http://profiles.wordpress.org/soulseekah">Gennady Kovshenin</a>, <a href="http://profiles.wordpress.org/georgestephanis">George Stephanis</a>, <a href="http://profiles.wordpress.org/gnarf37">gnarf37</a>, <a href="http://profiles.wordpress.org/tivnet">Gregory Karpinsky</a>, <a href="http://profiles.wordpress.org/hanni">hanni</a>, <a href="http://profiles.wordpress.org/helen">Helen Hou-Sandi</a>, <a href="http://profiles.wordpress.org/iandunn">Ian Dunn</a>, <a href="http://profiles.wordpress.org/ipstenu">Ipstenu (Mika Epstein)</a>, <a href="http://profiles.wordpress.org/isaackeyet">Isaac Keyet</a>, <a href="http://profiles.wordpress.org/jdgrimes">J.D. Grimes</a>, <a href="http://profiles.wordpress.org/jacklenox">Jack Lenox</a>, <a href="http://profiles.wordpress.org/janhenckens">janhenckens</a>, <a href="http://profiles.wordpress.org/avryl">Janneke Van Dorpe</a>, <a href="http://profiles.wordpress.org/janrenn">janrenn</a>, <a href="http://profiles.wordpress.org/jblz">Jeff Bowen</a>, <a href="http://profiles.wordpress.org/jeffr0">Jeff Chandler</a>, <a href="http://profiles.wordpress.org/jenmylo">Jen Mylo</a>, <a href="http://profiles.wordpress.org/buffler">Jeremy Buller</a>, <a href="http://profiles.wordpress.org/jeremyfelt">Jeremy Felt</a>, <a href="http://profiles.wordpress.org/jeherve">Jeremy Herve</a>, <a href="http://profiles.wordpress.org/jpry">Jeremy Pry</a>, <a href="http://profiles.wordpress.org/jayjdk">Jesper Johansen (jayjdk)</a>, <a href="http://profiles.wordpress.org/jhned">jhned</a>, <a href="http://profiles.wordpress.org/jim912">jim912</a>, <a href="http://profiles.wordpress.org/jartes">Joan Artes</a>, <a href="http://profiles.wordpress.org/joedolson">Joe Dolson</a>, <a href="http://profiles.wordpress.org/joen">Joen Asmussen</a>, <a href="http://profiles.wordpress.org/johnbillion">John Blackbourn</a>, <a href="http://profiles.wordpress.org/johnafish">John Fish</a>, <a href="http://profiles.wordpress.org/johnjamesjacoby">John James Jacoby</a>, <a href="http://profiles.wordpress.org/duck_">Jon Cave</a>, <a href="http://profiles.wordpress.org/joostdevalk">Joost de Valk</a>, <a href="http://profiles.wordpress.org/joshuaabenazer">Joshua Abenazer</a>, <a href="http://profiles.wordpress.org/nukaga">Junko Nukaga</a>, <a href="http://profiles.wordpress.org/devesine">Justin de Vesine</a>, <a href="http://profiles.wordpress.org/justinsainton">Justin Sainton</a>, <a href="http://profiles.wordpress.org/kadamwhite">K. Adam White</a>, <a href="http://profiles.wordpress.org/trepmal">Kailey (trepmal)</a>, <a href="http://profiles.wordpress.org/codebykat">Kat Hagan</a>, <a href="http://profiles.wordpress.org/littlethingsstudio">Kate Whitley</a>, <a href="http://profiles.wordpress.org/ryelle">Kelly Dwan</a>, <a href="http://profiles.wordpress.org/kpdesign">Kim Parsell</a>, <a href="http://profiles.wordpress.org/kwight">Kirk Wight</a>, <a href="http://profiles.wordpress.org/koki4a">Konstantin Dankov</a>, <a href="http://profiles.wordpress.org/kovshenin">Konstantin Kovshenin</a>, <a href="http://profiles.wordpress.org/obenland">Konstantin Obenland</a>, <a href="http://profiles.wordpress.org/drozdz">Krzysiek Drozdz</a>, <a href="http://profiles.wordpress.org/lancewillett">Lance Willett</a>, <a href="http://profiles.wordpress.org/leewillis77">Lee Willis</a>, <a href="http://profiles.wordpress.org/lite3">lite3</a>, <a href="http://profiles.wordpress.org/lucp">Luc Princen</a>, <a href="http://profiles.wordpress.org/latz">Lutz Schroer</a>, <a href="http://profiles.wordpress.org/mako09">Mako</a>, <a href="http://profiles.wordpress.org/markjaquith">Mark Jaquith</a>, <a href="http://profiles.wordpress.org/markmcwilliams">Mark McWilliams</a>, <a href="http://profiles.wordpress.org/markoheijnen">Marko Heijnen</a>, <a href="http://profiles.wordpress.org/matt">Matt Mullenweg</a>, <a href="http://profiles.wordpress.org/iammattthomas">Matt Thomas</a>, <a href="http://profiles.wordpress.org/mattwiebe">Matt Wiebe</a>, <a href="http://profiles.wordpress.org/mdbitz">Matthew Denton</a>, <a href="http://profiles.wordpress.org/mattheu">Matthew Haines-Young</a>, <a href="http://profiles.wordpress.org/mattonomics">mattonomics</a>, <a href="http://profiles.wordpress.org/matveb">Matías Ventura</a>, <a href="http://profiles.wordpress.org/megane9988">megane9988</a>, <a href="http://profiles.wordpress.org/melchoyce">Mel Choyce</a>, <a href="http://profiles.wordpress.org/micahwave">micahwave</a>, <a href="http://profiles.wordpress.org/cainm">Michael Cain</a>, <a href="http://profiles.wordpress.org/mitchoyoshitaka">Michael Erlewine</a>, <a href="http://profiles.wordpress.org/michelwppi">Michel - xiligroup dev</a>, <a href="http://profiles.wordpress.org/chellycat">Michelle Langston</a>, <a href="http://profiles.wordpress.org/gradyetc">Mike Burns</a>, <a href="http://profiles.wordpress.org/mikehansenme">Mike Hansen</a>, <a href="http://profiles.wordpress.org/mikelittle">Mike Little</a>, <a href="http://profiles.wordpress.org/dh-shredder">Mike Schroder</a>, <a href="http://profiles.wordpress.org/dimadin">Milan Dinic</a>, <a href="http://profiles.wordpress.org/batmoo">Mohammad Jangda</a>, <a href="http://profiles.wordpress.org/morganestes">Morgan Estes</a>, <a href="http://profiles.wordpress.org/mt8biz">moto hachi</a>, <a href="http://profiles.wordpress.org/Nao">Naoko Takano</a>, <a href="http://profiles.wordpress.org/neil_pie">Neil Pie</a>, <a href="http://profiles.wordpress.org/nickdaugherty">Nick Daugherty</a>, <a href="http://profiles.wordpress.org/celloexpressions">Nick Halsey</a>, <a href="http://profiles.wordpress.org/nbachiyski">Nikolay Bachiyski</a>, <a href="http://profiles.wordpress.org/ninio">ninio</a>, <a href="http://profiles.wordpress.org/ninnypants">ninnypants</a>, <a href="http://profiles.wordpress.org/nivijah">nivijah</a>, <a href="http://profiles.wordpress.org/nofearinc">nofearinc</a>, <a href="http://profiles.wordpress.org/nvwd">Nowell VanHoesen</a>, <a href="http://profiles.wordpress.org/odysseygate">odyssey</a>, <a href="http://profiles.wordpress.org/originalexe">OriginalEXE</a>, <a href="http://profiles.wordpress.org/swissspidy">Pascal Birchler</a>, <a href="http://profiles.wordpress.org/pauldewouters">Paul de Wouters</a>, <a href="http://profiles.wordpress.org/pavelevap">pavelevap</a>, <a href="http://profiles.wordpress.org/westi">Peter Westwood</a>, <a href="http://profiles.wordpress.org/senlin">Piet</a>, <a href="http://profiles.wordpress.org/ptahdunbar">Ptah Dunbar</a>, <a href="http://profiles.wordpress.org/raamdev">Raam Dev</a>, <a href="http://profiles.wordpress.org/bamadesigner">Rachel Carden</a>, <a href="http://profiles.wordpress.org/rachelbaker">rachelbaker</a>, <a href="http://profiles.wordpress.org/radices">Radices</a>, <a href="http://profiles.wordpress.org/mauryaratan">Ram Ratan Maurya</a>, <a href="http://profiles.wordpress.org/defries">Remkus de Vries</a>, <a href="http://profiles.wordpress.org/ounziw">Rescuework Support</a>, <a href="http://profiles.wordpress.org/rickalee">Ricky Lee Whittemore</a>, <a href="http://profiles.wordpress.org/rdall">Robert Dall</a>, <a href="http://profiles.wordpress.org/wet">Robert Wetzlmayr, PHP-Programmierer</a>, <a href="http://profiles.wordpress.org/rodrigosprimo">Rodrigo Primo</a>, <a href="http://profiles.wordpress.org/ryan">Ryan Boren</a>, <a href="http://profiles.wordpress.org/otto42">Samuel Wood</a>, <a href="http://profiles.wordpress.org/sanchothefat">sanchothefat</a>, <a href="http://profiles.wordpress.org/sboisvert">sboisvert</a>, <a href="http://profiles.wordpress.org/scottbasgaard">Scott Basgaard</a>, <a href="http://profiles.wordpress.org/coffee2code">Scott Reilly</a>, <a href="http://profiles.wordpress.org/wonderboymusic">Scott Taylor</a>, <a href="http://profiles.wordpress.org/scribu">scribu</a>, <a href="http://profiles.wordpress.org/seanchayes">Sean Hayes</a>, <a href="http://profiles.wordpress.org/sergeybiryukov">Sergey Biryukov</a>, <a href="http://profiles.wordpress.org/shaunandrews">Shaun Andrews</a>, <a href="http://profiles.wordpress.org/shinichin">ShinichiN</a>, <a href="http://profiles.wordpress.org/simonwheatley">Simon Wheatley</a>, <a href="http://profiles.wordpress.org/siobhan">Siobhan</a>, <a href="http://profiles.wordpress.org/siobhyb">Siobhan Bamber (siobhyb)</a>, <a href="http://profiles.wordpress.org/sirbrillig">sirbrillig</a>, <a href="http://profiles.wordpress.org/solarissmoke">solarissmoke</a>, <a href="http://profiles.wordpress.org/netweb">Stephen Edgar</a>, <a href="http://profiles.wordpress.org/stephenharris">Stephen Harris</a>, <a href="http://profiles.wordpress.org/stevenkword">Steven Word</a>, <a href="http://profiles.wordpress.org/iamtakashi">Takashi Irie</a>, <a href="http://profiles.wordpress.org/miyauchi">Takayuki Miyauchi</a>, <a href="http://profiles.wordpress.org/tmtoy">Takuma Morikawa</a>, <a href="http://profiles.wordpress.org/tellyworth">tellyworth</a>, <a href="http://profiles.wordpress.org/thomasguillot">Thomas Guillot</a>, <a href="http://profiles.wordpress.org/tierra">tierra</a>, <a href="http://profiles.wordpress.org/tillkruess">Till Krüss</a>, <a href="http://profiles.wordpress.org/tlamedia">TLA Media</a>, <a href="http://profiles.wordpress.org/tobiasbg">TobiasBg</a>, <a href="http://profiles.wordpress.org/tomdxw">tomdxw</a>, <a href="http://profiles.wordpress.org/tommcfarlin">tommcfarlin</a>, <a href="http://profiles.wordpress.org/zodiac1978">Torsten Landsiedel</a>, <a href="http://profiles.wordpress.org/taupecat">Tracy Rotton</a>, <a href="http://profiles.wordpress.org/trishasalas">trishasalas</a>, <a href="http://profiles.wordpress.org/mbmufffin">Tyler Smith</a>, <a href="http://profiles.wordpress.org/grapplerulrich">Ulrich</a>, <a href="http://profiles.wordpress.org/undergroundnetwork">undergroundnetwork</a>, <a href="http://profiles.wordpress.org/l10n">Vladimir</a>, <a href="http://profiles.wordpress.org/westonruter">Weston Ruter</a>, <a href="http://profiles.wordpress.org/yoavf">Yoav Farhi</a>, <a href="http://profiles.wordpress.org/yonasy">yonasy</a>, <a href="http://profiles.wordpress.org/yurivictor">Yuri Victor</a>, and <a href="http://profiles.wordpress.org/tollmanz">Zack Tollman</a>. Also thanks to <a href="http://benmorrison.org/">Ben Morrison</a> and <a href="http://christineswebb.com/">Christine Webb</a> for help with the video.</p>
<p>Thanks for choosing WordPress. See you soon for version 3.9!</p>
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:36:"http://wellformedweb.org/CommentAPI/";a:1:{s:10:"commentRss";a:1:{i:0;a:5:{s:4:"data";s:46:"http://wordpress.org/news/2013/12/parker/feed/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:38:"http://purl.org/rss/1.0/modules/slash/";a:1:{s:8:"comments";a:1:{i:0;a:5:{s:4:"data";s:1:"0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:4:"href";s:31:"http://wordpress.org/news/feed/";s:3:"rel";s:4:"self";s:4:"type";s:19:"application/rss+xml";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:44:"http://purl.org/rss/1.0/modules/syndication/";a:2:{s:12:"updatePeriod";a:1:{i:0;a:5:{s:4:"data";s:6:"hourly";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:15:"updateFrequency";a:1:{i:0;a:5:{s:4:"data";s:1:"1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:8:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Tue, 22 Apr 2014 23:03:01 GMT";s:12:"content-type";s:23:"text/xml; charset=UTF-8";s:10:"connection";s:5:"close";s:4:"vary";s:15:"Accept-Encoding";s:10:"x-pingback";s:36:"http://wordpress.org/news/xmlrpc.php";s:13:"last-modified";s:29:"Thu, 17 Apr 2014 01:07:32 GMT";s:4:"x-nc";s:11:"HIT lax 249";}s:5:"build";s:14:"20130911070210";}', 'no'); 
INSERT INTO `wp_options` VALUES ('2641', '_transient_timeout_feed_mod_ac0b00fe65abe10e0c5b588f3ed8c7ca', '1398250982', 'no'); 
INSERT INTO `wp_options` VALUES ('2642', '_transient_feed_mod_ac0b00fe65abe10e0c5b588f3ed8c7ca', '1398207782', 'no'); 
INSERT INTO `wp_options` VALUES ('2643', '_transient_timeout_feed_867bd5c64f85878d03a060509cd2f92c', '1398250984', 'no'); 
INSERT INTO `wp_options` VALUES ('2644', '_transient_feed_867bd5c64f85878d03a060509cd2f92c', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"


";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:61:"
	
	
	
	




















































";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"WordPress Planet";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:28:"http://planet.wordpress.org/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:2:"en";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:47:"WordPress Planet - http://planet.wordpress.org/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:50:{i:0;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:67:"WPTavern: New Plugin Adds Less CSS Preprocessor to WordPress Themes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21533";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:178:"http://wptavern.com/new-plugin-adds-less-css-preprocessor-to-wordpress-themes?utm_source=rss&utm_medium=rss&utm_campaign=new-plugin-adds-less-css-preprocessor-to-wordpress-themes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3362:"<p><a href="http://wptavern.com/wp-content/uploads/2014/04/less-theme-support.jpg" rel="prettyphoto[21533]"><img src="http://wptavern.com/wp-content/uploads/2014/04/less-theme-support.jpg" alt="less-theme-support" width="772" height="250" class="aligncenter size-full wp-image-21583" /></a></p>
<p>Many WordPress developers opt to use the <a href="http://lesscss.org/" target="_blank">Less</a> CSS preprocessor to speed up theme development. Its availability of variables, mixins, and functions allows you to do more with CSS and to do it more efficiently. It also makes it easy to compile and minify files for production use. However, the initial setup for adding Less to each theme is a somewhat time-consuming process.</p>
<p>Justin Kopepasah wrote a tutorial in the past for <a href="http://kopepasah.com/tutorial/using-less-in-a-live-wordpress-theme/" target="_blank">using LESS in a live WordPress theme</a>, followed by one that <a href="http://kopepasah.com/tutorial/easily-add-less-css-pre-processor-to-any-wordpress-theme/" target="_blank">automated the process</a> by setting up the functionality as a Git submodule. Over time, he found that adding Less to each theme was becoming quite a chore, so he created a plugin to make the process easier for anyone.</p>
<p>Kopepasah&#8217;s <a href="https://wordpress.org/plugins/less-theme-support/" target="_blank">Less Theme Support</a> plugin radically simplifies the process of adding Less to your WordPress theme. It requires just two simple steps following activation:</p>
<ol>
<li>Add <em>style.less</em> to your theme&#8217;s root directory</li>
<li>Add theme support to the after_setup_theme hook:
<pre class="brush: php; light: true; title: ; notranslate">add_theme_support( \'less\', array( \'enable\' =&gt; true ) );</pre>
</li>
</ol>
<p>Less Theme Support comes with four different options which change how it functions on development vs. production sites. All are boolean values defaulting to false:</p>
<ul>
<li><strong>enable</strong> – Enables Less and enqueues <em>less.min.js</em> on the front end.</li>
<li><strong>develop</strong> – Enables development environment for Less and enqueues <em>less-develop.js</em>.</li>
<li><strong>watch</strong> – Enables watch mode for Less and enqueues <em>less-watch.js</em>.</li>
<li><strong>minify</strong> – Enables usage of a minified stylesheet (<em>style.min.css</em>) on the front end for all other visitors (best generated using lessc -x style.less > style.min.css).</li>
</ul>
<p>These options give you quite a bit of flexibility. For example, during development you might configure your theme support with the enable, develop, and watch options:</p>
<pre class="brush: php; title: ; notranslate">add_theme_support( \'less\', array(
    \'enable\'  =&gt; true,
    \'develop\' =&gt; true,
    \'watch\'  =&gt; true
) );</pre>
<p>Less theme support in production would us the minify option:</p>
<pre class="brush: php; title: ; notranslate">add_theme_support( \'less\', array(
 \'minify\' =&gt; true
) );</pre>
<p>Using the <a href="https://wordpress.org/plugins/less-theme-support/" target="_blank">Less Theme Support</a> plugin provides a much cleaner and easier way to add Less to your theme. Download it from WordPress.org or via the project&#8217;s page on <a href="https://github.com/kopepasah/less-theme-support" target="_blank">Github</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Apr 2014 21:49:29 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:83:"WPTavern: Display Before and After Images In WordPress With The TwentyTwenty Plugin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=20955";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:210:"http://wptavern.com/display-before-and-after-images-in-wordpress-with-the-twentytwenty-plugin?utm_source=rss&utm_medium=rss&utm_campaign=display-before-and-after-images-in-wordpress-with-the-twentytwenty-plugin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4145:"<p>Have you ever wanted to combine two images to show a before and after? You can&#8217;t do that with WordPress out of the box but it&#8217;s possible if you use the <a title="http://wordpress.org/plugins/twentytwenty/" href="http://wordpress.org/plugins/twentytwenty/">TwentyTwenty plugin</a> by <a title="http://aspiringwebdev.com/" href="http://aspiringwebdev.com/">Corey Martin</a>. The plugin takes advantage of the <a title="http://www.w3schools.com/cssref/pr_pos_clip.asp" href="http://www.w3schools.com/cssref/pr_pos_clip.asp">clip property</a> within CSS by stacking two identical sized images on top of each other. The clip property allows the image to show through the container. The slider is responsive and uses custom movement events within the <a title="https://github.com/stephband/jquery.event.move" href="https://github.com/stephband/jquery.event.move">jQuery Event Move library</a> to support <strong>1:1</strong> slider movement on mobile devices.</p>
<p>The plugin is very simple to use. Upload two identical sized images to the media library. When inserting images into a post, make sure the attachment display settings for image size are the same. Add the <strong>[TwentyTwenty]</strong> shortcode above the before image. Add <strong>[/TwentyTwenty]</strong> after the second image. Here&#8217;s an example of the shortcode added to a post.</p>
<div id="attachment_21585" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/TwentyTwentyShortcode.png" rel="prettyphoto[20955]"><img class="size-full wp-image-21585" src="http://wptavern.com/wp-content/uploads/2014/04/TwentyTwentyShortcode.png" alt="TwentyTwenty Shortcode In Action" width="754" height="703" /></a><p class="wp-caption-text">TwentyTwenty Shortcode In Action</p></div>
<p>The shortcode generates a slider that can be moved back and forth. You&#8217;ll see which images are before and after when you hover over the slider. To see either image, users must click and drag the circle left or right.</p>
<div id="attachment_21588" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/TwentyTwentyBefore.png" rel="prettyphoto[20955]"><img class="size-full wp-image-21588" src="http://wptavern.com/wp-content/uploads/2014/04/TwentyTwentyBefore.png" alt="TwentyTwenty Before Image" width="650" height="200" /></a><p class="wp-caption-text">TwentyTwenty Before Image</p></div>
<div id="attachment_21587" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/TwentyTwentyAfter.png" rel="prettyphoto[20955]"><img class="size-full wp-image-21587" src="http://wptavern.com/wp-content/uploads/2014/04/TwentyTwentyAfter.png" alt="TwentyTwenty After Image" width="650" height="200" /></a><p class="wp-caption-text">TwentyTwenty After Image</p></div>
<p>The plugin was written using <a title="http://sass-lang.com/" href="http://sass-lang.com/">Sass</a> and Zurb.com has a <a title="http://zurb.com/playground/twentytwenty" href="http://zurb.com/playground/twentytwenty">listing of each Sass variable</a> used and what its default value is. The variables enable you to control everything from the handle color to the handle radius.</p>
<p>Here are a couple of ideas where TwentyTwenty would be ideal to use.</p>
<ul>
<li>Compare counterfeit merchandise to real merchandise</li>
<li>Website redesigns</li>
<li>Home improvement renovations</li>
</ul>
<p>During my test with WordPress 3.9, I didn&#8217;t experience any problems. According to Martin, <a title="http://wordpress.org/support/plugin/twentytwenty" href="http://wordpress.org/support/plugin/twentytwenty">TwentyTwenty</a> is compatible with the latest versions of Chrome, Safari, FireFox, iOS, IE 9, and above. If you want to see the plugin in action, you can either watch this screencast by Martin or visit the <a title="http://zurb.com/playground/twentytwenty" href="http://zurb.com/playground/twentytwenty">plugin&#8217;s page on Zurb.com</a>.</p>
<p><span class="embed-youtube"></span></p>
<p><strong>Outside of showing before and after images, what other creative ways could this plugin be used?</strong></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Apr 2014 21:20:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:45:"WPTavern: WordPress 3.9 Adds 30 New Dashicons";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21545";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:134:"http://wptavern.com/wordpress-3-9-adds-30-new-dashicons?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-3-9-adds-30-new-dashicons";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1529:"<p><a title="http://melchoyce.github.io/dashicons/" href="http://melchoyce.github.io/dashicons/">Dashicons</a> are what’s known as an icon font and were added to the core of WordPress with the release of 3.8. The icons are vector based so they can be as large or small as you want without losing quality. Plugin authors can use CSS, HTML, or a Glyph for use within Photoshop to display an icon. While 3.8 had 167 icons, WordPress 3.9 shipped with <a title="http://make.wordpress.org/core/2014/04/16/dashicons-in-wordpress-3-9/" href="http://make.wordpress.org/core/2014/04/16/dashicons-in-wordpress-3-9/">30 new Dashicons</a> bringing the total to 197.</p>
<div id="attachment_21547" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WP39Dashicons.png" rel="prettyphoto[21545]"><img class="size-full wp-image-21547" src="http://wptavern.com/wp-content/uploads/2014/04/WP39Dashicons.png" alt="New Dashicons In WordPress 3.9" width="652" height="313" /></a><p class="wp-caption-text">New Dashicons In WordPress 3.9</p></div>
<p>The icons cover Media, TinyMCE, WordPress.org, Sorting, Widgets, Alerts, and Miscellaneous. Some plugin authors have already opted out of using a bitmap image and are using a Dashicon to represent their plugin within the WordPress admin menu. If none of the Dashicons match your use case, try <a title="http://genericons.com" href="http://genericons.com">Genericons</a> instead. Genereicons is also an icon font but has icons that are not focused on WordPress.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Apr 2014 19:37:59 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:70:"WPTavern: Automattic Introduces Postbot App for Scheduling Photo Posts";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21535";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:184:"http://wptavern.com/automattic-introduces-postbot-app-for-scheduling-photo-posts?utm_source=rss&utm_medium=rss&utm_campaign=automattic-introduces-postbot-app-for-scheduling-photo-posts";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4332:"<p>Today Automattic introduced <a href="https://postbot.co/" target="_blank">Postbot</a>, a new stand-alone application for scheduling image posts. The new app allows users to upload multiple images and schedule them out over several days. Postbot creates a post for each image and automatically posts them to the selected blog, saving users the trouble of manually scheduling each one.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/postbot.gif" rel="prettyphoto[21535]"><img src="http://wptavern.com/wp-content/uploads/2014/04/postbot.gif" alt="postbot" width="752" height="376" class="aligncenter size-full wp-image-21539" /></a></p>
<p>When using <a href="https://postbot.co/">Postbot</a>, you&#8217;ll need to connect via WordPress.com. The app is automatically connected to your main WordPress.com blog but once logged in you&#8217;ll have the option to connect other sites. Self-hosted WordPress sites can use the app via <a href="http://jetpack.me/" target="_blank">Jetpack</a> with the <a href="http://jetpack.me/support/json-api/" target="_blank">JSON API module</a> enabled.</p>
<p>Right now, you can only use the app from a desktop or mobile browser and John Godley, representing Automattic, says that a mobile app is not currently in the works. He elaborated on why they chose to create it as a standalone web app:</p>
<blockquote><p>Postbot lets us provide a very targeted set of features to anyone with a WordPress.com or WordPress.org/Jetpack blog (or both), from one central place. It’s already mobile-ready so a special mobile app isn&#8217;t currently planned.</p></blockquote>
<p>The experience of visiting <a href="https://postbot.co/" target="_blank">Postbot.co</a> from a mobile browser is not unlike using a mobile app. Those who plan to use it frequently via mobile can easily set a bookmark for quick launch while on the go.</p>
<h3>Postbot Puts Photo Publishing on Autopilot</h3>
<p>Postbot allows you to upload up to 50 photos at once to be published individually on different dates. While the images are uploading you can edit the titles, tags and content for each. The option to set a category is planned for a future version.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/uploading-postbot.png" rel="prettyphoto[21535]"><img src="http://wptavern.com/wp-content/uploads/2014/04/uploading-postbot.png" alt="uploading-postbot" width="688" height="311" class="aligncenter size-full wp-image-21550" /></a></p>
<p>Scheduling allows you to set the number of days between posts published with the option to ignore weekends.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/schedule_postbot.png" rel="prettyphoto[21535]"><img src="http://wptavern.com/wp-content/uploads/2014/04/schedule_postbot.png" alt="schedule_postbot" width="635" height="42" class="aligncenter size-full wp-image-21551" /></a></p>
<p>The app doesn&#8217;t yet allow you to set the featured image, but it&#8217;s on Automattic&#8217;s list of <a href="https://github.com/Automattic/Postbot/issues/6" target="_blank">feature requests</a> for future enhancements.</p>
<p>Postbot is an excellent example of the kinds of apps that can be created using the <a href="http://developer.wordpress.com/docs/api/" target="_blank">WordPress.com API</a>. If you want to take a peek under the hood, the app&#8217;s code was released under the GPL and can be found on <a href="https://github.com/Automattic/Postbot" target="_blank">Github</a>. This means that anyone can host their own Postbot web app or create interesting variations that interact with WordPress.com services.</p>
<p>Postbot is potentially very useful for photobloggers who want to break up their posts into individual images. It could also be handy for automating sites that are dedicated to publishing photos every day, i.e. &#8220;The Daily Kitten&#8221; or &#8220;Your Daily Dose of Fun.&#8221; It allows these kinds of sites to go on autopilot for publishing fresh content on a regular basis. Publishing new posts multiple times per day is an option <a href="http://en.blog.wordpress.com/2014/04/22/postbot-scheduled-photos/#comment-202397" target="_blank">currently under consideration</a> and may be a possibility in the future. We&#8217;ll be following the app&#8217;s progress as it adds new features based on user feedback.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Apr 2014 19:17:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:41:"Mike Little: Apologies for the old posts.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=2023";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:147:"http://journalized.zed1.com/archives/2014/04/22/apologies-for-the-old-posts/?utm_source=rss&utm_medium=rss&utm_campaign=apologies-for-the-old-posts";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:598:"<p>Folks, it looks like when I moved this old blog from a subdirectory to a subdomain, <a href="http://planet.wordpress.org">planet.wordpress.org</a> (the feed that shows up in your dashboard) thought my last few old posts were new. Hence a lot of old stuff appeared in your dashboard.</p>
<p>Sorry for the confusion&#8230;</p>
<p>Mike</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2014/04/22/apologies-for-the-old-posts/">Apologies for the old posts.</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Apr 2014 14:36:24 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:90:"WPTavern: How The Advanced Image Editing Properties Contributed To WordPress Theme Lock-in";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21488";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:224:"http://wptavern.com/how-the-advanced-image-editing-properties-contributed-to-wordpress-theme-lock-in?utm_source=rss&utm_medium=rss&utm_campaign=how-the-advanced-image-editing-properties-contributed-to-wordpress-theme-lock-in";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:6232:"<p>Although <a title="http://wptavern.com/wordpress-3-9-smith-released" href="http://wptavern.com/wordpress-3-9-smith-released">WordPress 3.9</a> has refined the media editing experience, it did so at the cost of removing a feature users appreciated. In WordPress 3.8, users could easily add a border, vertical, and horizontal padding to images. WordPress 3.9 removed this from the advanced image settings screen.</p>
<p>It’s not just those who use the self-hosted version of WordPress <a title="http://wordpress.org/support/topic/major-problems-with-image-editing-in-wp-39?replies=12" href="http://wordpress.org/support/topic/major-problems-with-image-editing-in-wp-39?replies=12">that are upset with the change</a>. A WordPress.com <a title="http://en.forums.wordpress.com/topic/image-resize-1?replies=430" href="http://en.forums.wordpress.com/topic/image-resize-1?replies=430">support forum thread</a> with over 430 posts is filled with users asking why the feature was removed. In some cases, WordPress.com staff are explaining how to use HTML code to add or remove borders to images.</p>
<p>Thankfully, there&#8217;s a new plugin available that not only restores the original advanced image settings but has expanded upon them. The plugin is called <a title="http://wordpress.org/plugins/advanced-image-styles/" href="http://wordpress.org/plugins/advanced-image-styles/">Advanced Image Styles</a> and is maintained by <a title="http://profiles.wordpress.org/gcorne/" href="http://profiles.wordpress.org/gcorne/">Gregory Cornelius</a>. As you can see, users can now apply padding in all four directions instead of two. You can also apply a border color instead of just the border width.</p>
<div id="attachment_21489" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/AdvancedImageEditingOptions.png" rel="prettyphoto[21488]"><img class="size-full wp-image-21489" src="http://wptavern.com/wp-content/uploads/2014/04/AdvancedImageEditingOptions.png" alt="Advanced Image Editing Styles" width="840" height="401" /></a><p class="wp-caption-text">Advanced Image Styles</p></div>
<p><a title="http://wordpress.org/support/view/plugin-reviews/advanced-image-styles" href="http://wordpress.org/support/view/plugin-reviews/advanced-image-styles">Early reviews</a> indicate users are happy to see these options return despite having to use a plugin. Unfortunately, those on WordPress.com are still out of luck. A member of the WordPress.com staff says <a title="http://en.forums.wordpress.com/topic/image-resize-1/page/15?replies=430#post-1754610" href="http://en.forums.wordpress.com/topic/image-resize-1/page/15?replies=430#post-1754610">it&#8217;s possible</a> the plugin will be merged into the WordPress.com codebase.</p>
<blockquote><p>I have asked the developers if this will be merged. At the moment I have not heard back. I will let you know as soon as possible!</p></blockquote>
<h3>These Options Are Causing Theme Lock-in</h3>
<p>If themes are coded to properly handle image padding and borders, the options within WordPress are redundant and unnecessary. What&#8217;s troubling is users are utilizing these options to override the styling within the theme instead of changing its CSS stylesheet.</p>
<p>In a test on my local server, I used the advanced image editing options to add a black, four pixel border to an image within the media library. Then I switched themes to see if the border was still there. I discovered that settings applied to images via the WordPress image editing options are displayed no matter which theme is used.</p>
<div id="attachment_21520" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/OldTavernDesign.png" rel="prettyphoto[21488]"><img class="size-full wp-image-21520" src="http://wptavern.com/wp-content/uploads/2014/04/OldTavernDesign.png" alt="Old Tavern Design With The Black Image Border" width="605" height="339" /></a><p class="wp-caption-text">Old Tavern Design With The Black Image Border</p></div>
<div id="attachment_21519" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/NewTavernDesign.png" rel="prettyphoto[21488]"><img class="size-full wp-image-21519" src="http://wptavern.com/wp-content/uploads/2014/04/NewTavernDesign.png" alt="New Tavern Design With The Black Image Border" width="665" height="387" /></a><p class="wp-caption-text">New Tavern Design With The Black Image Border</p></div>
<p>If a user switches to a theme that uses a color scheme not compatible with the image border color, each image has to be edited individually within the media library. Each time an image is edited using the advanced settings provided by WordPress, you lose more theme compatibility and it further locks you in to a specific theme.</p>
<h3>WordPress.com vs. Self-hosted WordPress</h3>
<div id="attachment_21515" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WPcomWporg.png" rel="prettyphoto[21488]"><img class="wp-image-21515 size-full" src="http://wptavern.com/wp-content/uploads/2014/04/WPcomWporg.png" alt="WPcomWporg" width="738" height="296" /></a><p class="wp-caption-text">WordPress.com and WordPress.org</p></div>
<p>I understand why WordPress.com users would be so upset with the removal of these options. By default, they don&#8217;t have the ability to edit their theme&#8217;s CSS file. That is reserved as a paid upgrade. So these options give them a chance to override the styling within the theme without having the paid upgrade.</p>
<p>For self-hosted WordPress users, there is no excuse. Image borders and padding should be controlled through the theme, not the advanced image editing options provided by WordPress. Despite the options making it easy to apply those changes to images, users are only hurting themselves by using them.</p>
<p>I think the options for padding and image borders should stay removed from the self-hosted version of WordPress while restored on WordPress.com. In retrospect, these options should have never existed in the first place.</p>
<p><strong>Do you think the image border width, color, and padding options should be restored to the self-hosted version of WordPress?</strong></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Apr 2014 01:37:16 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:53:"Mike Little: WordPress 10th Anniversary: a Reflection";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1929";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:171:"http://journalized.zed1.com/archives/2013/05/27/wordpress-10th-anniversary-a-reflection/?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-10th-anniversary-a-reflection";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:468:"<p>I posted about <a href="http://mikelittle.org/wordpress-10th-anniversary/">WordPress&#8217; 10th Anniversary</a> celebration and reflected on the last 10 years over on my new blog</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2013/05/27/wordpress-10th-anniversary-a-reflection/">WordPress 10th Anniversary: a Reflection</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:44:"Mike Little: WordPress – A 10 year journey";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1867";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:147:"http://journalized.zed1.com/archives/2013/01/25/wordpress-a-10-year-journey/?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-a-10-year-journey";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2530:"<p><a href="http://journalized.zed1.com/wp-content/uploads/2013/01/wordpress-logo-notext-rgb.png"><img class="size-thumbnail wp-image-1873 alignleft" alt="WordPress logo" src="http://journalized.zed1.com/wp-content/uploads/2013/01/wordpress-logo-notext-rgb-150x150.png" width="150" height="150" /></a></p>
<p>I find it hard to believe but it has now been <strong>ten years</strong> since my fateful <a href="http://ma.tt/2003/01/the-blogging-software-dilemma/#comment-445">comment on Matt&#8217;s blog </a>that kicked off what became the <a href="http://wordpress.org/">WordPress</a> project!<br />
From those humble beginnings of a simple unmaintained blogging platform (b2/Cafelog) to a world-beating open source CMS. B2/Cafelog was used by perhaps 2,000 bloggers. Now WordPress runs more than <a href="http://en.wordpress.com/stats/">60 million sites</a> around the world. That&#8217;s over <a href="http://w3techs.com/technologies/overview/content_management/all">17.5% of the web</a>!</p>
<h2>WordPress Industry</h2>
<p>WordPress now supports a world-wide industry from individual <a href="http://mikelittle.org/">WordPress specialists</a> like me (I&#8217;ve just completed my fourth year as my own company <a href="http://zed1.com/">zed1.com</a>); small WordPress-based companies like <a href="http://codeforthepeople.com/">Code for the People</a>; through to multi-million dollar companies like <a href="http://www.copyblogger.com/">Copyblogger</a>, <a href="http://www.woothemes.com/">WooThemes</a>, and of course <a href="http://automattic.com/">Automattic</a>.</p>
<p>Praise must go as usual to the <a href="http://make.wordpress.org/">fantastic community</a> around WordPress, the singular vision of <a href="http://ma.tt/">Matt Mullenweg</a>, and the awesome power of the <a title="GNU General Public License" href="http://www.gnu.org/licenses/gpl.html">GNU GPL</a> open source license.</p>
<h2>Here&#8217;s to the next year</h2>
<p>As WordPress enters it&#8217;s <strong>eleventh</strong> year, with version 3.5.1 recently released and <a href="http://make.wordpress.org/core/">version 3.6 currently in the making</a>, I predict it will be another great year for <a title="Personal Publishing Platform" href="http://wordpress.org">WordPress</a>.</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2013/01/25/wordpress-a-10-year-journey/">WordPress &#8211; A 10 year journey</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:39:"Mike Little: WordCamp Edinburgh UK 2012";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1856";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:145:"http://journalized.zed1.com/archives/2012/05/29/wordcamp-edinburgh-uk-2012/?utm_source=rss&utm_medium=rss&utm_campaign=wordcamp-edinburgh-uk-2012";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1650:"<p><a href="http://journalized.zed1.com/wp-content/uploads/2012/05/wordcamp-edinburgh-header-1.png"><img class="aligncenter size-full wp-image-1857" title="wordcamp-edinburgh-header-1" src="http://journalized.zed1.com/wp-content/uploads/2012/05/wordcamp-edinburgh-header-1.png" alt="" width="855" height="330" /></a></p>
<p>Folks, if you are looking to attend WordCamp Edinburgh UK 2012, on the weekend of the 14th and 15th of July, you need to get your <a href="http://2012.edinburgh.wordcamp.org/tickets/">tickets</a> pretty soon to qualify for the early bird price (£35).</p>
<p>After midday this coming Friday (June 1st) the price will rise to £45. Mind you, that&#8217;s still a fantastic price for a <a href="http://2012.edinburgh.wordcamp.org/"><strong>two-day weekend</strong> filled with WordPressy goodness</a> .</p>
<p>I&#8217;ll be there of course, will you? It&#8217;s looking like a cracker with some <a href="http://wiki.wpuk.org/2012_content_ideas">great ideas for sessions already put forward</a>. I&#8217;ll be running an extended session called <a href="http://2012.edinburgh.wordcamp.org/session/starting-out-with-wordpress/">Starting Out with WordPress</a>. Once again, get your <a href="http://2012.edinburgh.wordcamp.org/tickets/">tickets</a> soon.</p>
<p>I look forward to seeing you there.</p>
<p><a href="http://wpuk.org/">WPUK</a> is organising this event.</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2012/05/29/wordcamp-edinburgh-uk-2012/">WordCamp Edinburgh UK 2012</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:57:"Mike Little: WordPress is Nine. Happy Birthday WordPress!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1852";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:177:"http://journalized.zed1.com/archives/2012/05/27/wordpress-is-nine-happy-birthday-wordpress/?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-is-nine-happy-birthday-wordpress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1387:"<p>Today is the ninth birthday of WordPress (the anniversary of the <a href="http://wordpress.org/news/2003/05/wordpress-now-available/">first release</a>).</p>
<p>WordPress still continues to astonish me in its phenomenal growth. Comparing to <a href="http://journalized.zed1.com/archives/2011/05/27/wordpress-eighth-birthday/">this time last year</a>, WordPress now powers <a href="http://en.wordpress.com/stats/">more than 74 million sites</a>, accounting for <a href="http://w3techs.com/technologies/overview/content_management/all">more than 16% of the internet</a>.</p>
<div>I&#8217;m looking forward to the next year in the world of WordPress. As usual there are lots of exciting things ahead. The first <a href="http://wpappstore.com/">WordPress App Store</a> launched recently, and I&#8217;m sure there will be more (it looks like <a href="http://z1.tl/wpmudevdashboard">WPMU Dev&#8217;s updater/dashboard</a> now lets you buy).</div>
<div></div>
<div>WordPress is really maturing and as a platform and as an industry. There is much more to come and I can&#8217;t wait.</div>
<div></div>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2012/05/27/wordpress-is-nine-happy-birthday-wordpress/">WordPress is Nine. Happy Birthday WordPress!</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:10;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:46:"Mike Little: WordPress 3 for Business Bloggers";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1847";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:159:"http://journalized.zed1.com/archives/2012/03/11/wordpress-3-for-business-bloggers/?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-3-for-business-bloggers";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1071:"<p>I&#8217;m currently reading <a href="http://www.packtpub.com/wordpress-3-for-business-bloggers/book">WordPress 3 for Business Bloggers</a><a href="http://www.packtpub.com/wordpress-3-for-business-bloggers/book"><img class="alignright" title="WordPress 3 for Business Bloggers" src="https://www.packtpub.com/sites/default/files/imagecache/productview/1322OS_WordPress%203%20for%20Business%20Bloggers_Frontcover.jpg" alt="" width="124" height="152" /></a> by Paul Thewlis. I&#8217;m trying to squeeze it in between all the other stuff I seem to have on my plate. I read the first edition of the book a couple of years ago (though I can&#8217;t find my review to point to); so I&#8217;m looking forward to this one.</p>
<p>I&#8217;ll post a proper review when I&#8217;ve finished it.</p>
<p>&nbsp;</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2012/03/11/wordpress-3-for-business-bloggers/">WordPress 3 for Business Bloggers</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:11;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:58:"Mike Little: WordPress – 9 years since it’s conception";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1836";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:169:"http://journalized.zed1.com/archives/2012/01/25/wordpress-9-years-since-its-conception/?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-9-years-since-its-conception";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2138:"<p>Simon D <a title="Simon\'s tweet" href="https://twitter.com/#!/simond/status/162125708506832896">reminded me</a> that it is now nine years since my fateful <a href="http://ma.tt/2003/01/the-blogging-software-dilemma/#comment-445">comment on Matt&#8217;s blog </a>that kicked off this whole WordPress thing!</p>
<blockquote class="twitter-tweet" width="550"><p>Nine years ago today @<a href="https://twitter.com/mikelittlezed1">mikelittlezed1</a> floated an idea which eventually became WordPress. <a href="https://twitter.com/search/%23thanksmike">#thanksmike</a> <a href="http://t.co/teYbVHX8" title="http://ma.tt/2003/01/the-blogging-software-dilemma/">ma.tt/2003/01/the-bl…</a></p>
<p>&mdash; Simon Dickson (@simond) <a href="https://twitter.com/simond/status/162125708506832896">January 25, 2012</a></p></blockquote>
<p></p>
<p>WordPress is really shaping up, and is an evermore stable and functional CMS platform. The statistics continue to astonish me, with more than <a href="http://en.wordpress.com/stats/">70 million sites</a> around the world. That&#8217;s nearly <a href="http://w3techs.com/technologies/overview/content_management/all">16% of the web</a>!</p>
<p>WordPress is supporting a whole industry of WordPress experts, including me: I&#8217;m just starting my fourth year as an <a href="http://zed1.com/">independent WordPress specialist</a>.</p>
<p>Praise must go as usual to the fantastic community around WordPress, the singular vision of <a href="http://ma.tt/">Matt Mullenweg</a>, and the awesome power of the <a title="GNU General Public License" href="http://www.gnu.org/licenses/gpl.html">GNU GPL</a> open source license.</p>
<p>With version 3.4 currently in the making, I predict it will be another great year for <a title="Personal Publishing Platform" href="http://wordpress.org">WordPress</a>.</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2012/01/25/wordpress-9-years-since-its-conception/">WordPress &#8211; 9 years since it&#8217;s conception</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:12;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:41:"Mike Little: WordPress’ Eighth Birthday";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1813";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:143:"http://journalized.zed1.com/archives/2011/05/27/wordpress-eighth-birthday/?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-eighth-birthday";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1737:"<p>Today is WordPress&#8217; official eighth birthday (the anniversary of the <a href="http://wordpress.org/news/2003/05/wordpress-now-available/">first release</a>).</p>
<p>I still marvel at the incredible distance it has come. I&#8217;m also still proud that I had a part in its birth. But even more, I marvel at the wonderful contribution of all the WordPress community make to this fantastic project.</p>
<p>A client said to me this morning &#8220;This WordPress is brilliant isn&#8217;t it?&#8221; As I helped him set up his fourth WordPress site. You can&#8217;t get much clearer praise than that.</p>
<p>So raise a virtual beer (or other non-alcoholic beverage if, like me, you are teetotal) to WordPress, the community, and to another year.</p>
<p><strong>Update:</strong> I just spotted this tweet from <a href="http://twitter.com/#!/nacin">Andrew Nacin</a>:</p>
<blockquote class="twitter-tweet" width="550"><p>At more than 20 million WordPress.com blogs, that puts WordPress at north of 45 million sites. Wowza. Happy birthday indeed.</p>
<p>&mdash; Andrew Nacin (@nacin) <a href="https://twitter.com/nacin/status/74139775761793024">May 27, 2011</a></p></blockquote>
<p></p>
<p>Wow! 25 million <a href="http://wordpress.org/">standalone WordPress</a> sites plus 20 million <a href="http://WordPress.com">WordPress.com</a> sites! No wonder it <a href="http://w3techs.com/technologies/overview/content_management/all">powers more than 14 percent of the web</a>.</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2011/05/27/wordpress-eighth-birthday/">WordPress&#8217; Eighth Birthday</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:13;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:48:"Mike Little: WordPress – 8 Years in the making";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1748";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:155:"http://journalized.zed1.com/archives/2011/01/27/wordpress-8-years-in-the-making/?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-8-years-in-the-making";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2038:"<p>Wow! Another year has passed and it is now eight years since my fateful <a href="http://ma.tt/2003/01/the-blogging-software-dilemma/#comment-445">comment on Matt&#8217;s blog </a>that kicked off this whole WordPress thing!</p>
<p>WordPress is now a mature CMS platform driving <a href="http://w3techs.com/technologies/overview/content_management/all">13% of the web</a>! It is used for an <a href="http://wordpress.org/showcase/">astonishing array</a> of very different web sites around the world, from the humblest one person blog to <a title="I\'m a Scientist, Get me out of here!" href="http://imascientist.org.uk/">award-winning education sites</a>, <a title="The New Adventures of Stephen Fry" href="http://www.stephenfry.com/">celebrity sites</a>, <a title="The New York Times blogs" href="http://www.nytimes.com/interactive/blogs/directory.html">newspapers</a>, and even <a title="The official site of the Prime Minister\'s Office" href="http://www.number10.gov.uk">world leaders</a>!</p>
<p>WordPress is supporting a whole industry of <a title="WordPress consultants" href="http://codepoet.com/">WordPress experts</a>, including me: I&#8217;m now in my third year as an <a href="http://zed1.com/">independent WordPress specialist</a>.</p>
<p>I believe that WordPress has achieved this massive success in no small way because of the fantastic community around it, the keen-eyed vision of <a href="http://ma.tt/">Matt Mullenweg</a>, and the awesome power of the <a title="GNU General Public License" href="http://www.gnu.org/licenses/gpl.html">GNU GPL</a> open source license.</p>
<p>With version 3.1 just around the corner, I predict it will be another great year for <a title="Personal Publishing Platform" href="http://wordpress.org">WordPress</a>.</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2011/01/27/wordpress-8-years-in-the-making/">WordPress &#8211; 8 Years in the making</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:14;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:51:"Mike Little: WordCamp slides featured on Slideshare";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1523";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:169:"http://journalized.zed1.com/archives/2010/07/21/wordcamp-slides-featured-on-slideshare/?utm_source=rss&utm_medium=rss&utm_campaign=wordcamp-slides-featured-on-slideshare";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1285:"<p>The slides from <a href="http://www.slideshare.net/mikelittle/wordcamp-2010-im-a-scientist-get-me-out-of-here-mike-little">my presentation at WordCamp UK</a> in Manchester over the weekend are now on SlideShare. I presented on the fantastic <a href="http://imascientist.org.uk/">I&#8217;m a Scientist Get me Out of Here</a> project website I have built for <a href="http://www.gallomanor.com/">Gallomanor</a> this year.</p>
<p>It&#8217;s best to read the notes in the &#8220;Notes on slide x&#8221; tab so that everything makes sense! I also link to some of the plugins I used at the end.</p>
<p>Amazingly, the presentation features on the <a href="http://www.slideshare.net/">SlideShare home page</a> today along with a couple of other presentations from <a href="http://uk.wordcamp.org/">WordCamp UK</a>! See the &#8220;featured&#8221; section in the right hand column. Woo Hoo!</p>
<p>I have still to finish my write-up of the weekend, but will hopefully get that done &#8216;real soon&#8217;.</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2010/07/21/wordcamp-slides-featured-on-slideshare/">WordCamp slides featured on Slideshare</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:15;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:42:"Mike Little: WordCamp UK A Few Places Left";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://journalized.zed1.com/?p=1519";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:153:"http://journalized.zed1.com/archives/2010/07/15/wordcamp-uk-a-few-tickets-left/?utm_source=rss&utm_medium=rss&utm_campaign=wordcamp-uk-a-few-tickets-left";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1313:"<p>For those of you thinking you may have missed out on this coming weekend&#8217;s WordPress fun at <a href="http://uk.wordcamp.org/">WordCamp UK</a> in Manchester, think again!</p>
<p>As the tickets did not completely sell out, we are making the last few available on the door, as we did last year.</p>
<p>You must email me (mike at my domain ) to reserve a ticket, and then turn up on Saturday morning with your £30 cash.</p>
<p>To recap, WordCamp UK is this weekend, July 17th and 18th, at the <a href="http://www.business.mmu.ac.uk/">Manchester Metropolitan University Business School</a> which is in Manchester city centre, a few minutes walk from the main Piccadilly train Station.</p>
<p>There are <a href="http://wiki.wordcampuk.tonyscott.org.uk/2010_running_order">four simultaneous tracks</a> : General &amp; user, Specialist &amp; developer, Miscellaneous &amp; spontaneous and a &#8216;Genius Bar&#8217; (a range of WordPress experts available to advice attendees on a one-to-one basis).</p>
<p>I look forward to seeing you there.</p>
<p>The post <a rel="nofollow" href="http://journalized.zed1.com/archives/2010/07/15/wordcamp-uk-a-few-tickets-left/">WordCamp UK A Few Places Left</a> appeared first on <a rel="nofollow" href="http://journalized.zed1.com">Mike Little&#039;s Journalized</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 23:00:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:11:"Mike Little";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:16;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:69:"WPTavern: WordPress Projects Announced for Google Summer of Code 2014";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21492";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:182:"http://wptavern.com/wordpress-projects-announced-for-google-summer-of-code-2014?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-projects-announced-for-google-summer-of-code-2014";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2573:"<p><a href="http://wptavern.com/wp-content/uploads/2014/04/gsoc2014.png" rel="prettyphoto[21492]"><img src="http://wptavern.com/wp-content/uploads/2014/04/gsoc2014.png" alt="gsoc2014" width="924" height="156" class="aligncenter size-full wp-image-21501" /></a></p>
<p>Earlier this year, WordPress was <a href="http://wptavern.com/wordpress-accepted-as-a-mentoring-organization-for-google-summer-of-code-2014" target="_blank">accepted</a> as one of 190 mentoring organizations for <a href="http://www.google-melange.com/gsoc/homepage/google/gsoc2014" target="_blank">Google Summer of Code 2014</a>. This year marks the 10th annual GSoC and WordPress&#8217; 7th year participating in the program. Five students have been <a href="http://make.wordpress.org/community/2014/04/21/gsoc-students-accepted/" target="_blank">accepted</a> and will soon begin work on some exciting projects:</p>
<ul>
<li><a href="http://profiles.wordpress.org/secretmapper" target="_blank">Arian Allenson M. Valdez</a> — Working on GlotPress UI and profiles with Yoav Farhi and Marko Heijnen as mentors</li>
<li><a href="http://profiles.wordpress.org/gautamgupta" target="_blank">Gautam Gupta</a> — Working on bbPress improvements with John James Jacoby and Stephen Edgar as mentors</li>
<li><a href="http://profiles.wordpress.org/avryl" target="_blank">Janneke Van Dorpe</a> — Working on front-end editing/content blocks with Gregory Cornelius and Aaron Jorbin as mentors</li>
<li><a href="http://profiles.wordpress.org/celloexpressions" target="_blank">Nick Halsey</a> — Working on adding custom menus to the customizer with Erick Hitter and Konstantin Obenland as mentors</li>
<li><a href="http://profiles.wordpress.org/VarunAgw" target="_blank">Varun Agrawal</a> — Working on SupportPress as a plugin with Ian Dunn, Aaron Campbell, and Alex Mills as mentors</li>
</ul>
<p>The students selected to participate are all very talented and enthusiastic. In fact, several of them are already active in contributing to WordPress core and have several plugins hosted in the directory.</p>
<p>GSoC 2014 kicks off May 19th when the students will begin their summer coding adventures. In the meantime, they will be bonding with their mentoring teams and working to nail down the scope of their projects. Jen Mylo, who is coordinating WordPress&#8217; involvement in the GSoC, will be working with the teams to set up some livestreamed prototype demos at midterm. Students will also be posting on a weekly basis and we&#8217;ll be following the progress on their projects throughout the summer.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 20:15:24 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:17;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:56:"WPTavern: 13 Vagrant Resources for WordPress Development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21194";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:156:"http://wptavern.com/13-vagrant-resources-for-wordpress-development?utm_source=rss&utm_medium=rss&utm_campaign=13-vagrant-resources-for-wordpress-development";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:8671:"<p><a href="http://wptavern.com/wp-content/uploads/2014/04/vagrant.png" rel="prettyphoto[21194]"><img src="http://wptavern.com/wp-content/uploads/2014/04/vagrant.png" alt="vagrant" width="1400" height="632" class="aligncenter size-full wp-image-21435" /></a></p>
<p><a href="http://www.vagrantup.com/" target="_blank">Vagrant</a> is an open source tool that makes it easy to configure and distribute virtual development environments. The project was started in 2010 by Mitchell Hashimoto and John Bender who wanted to create a way to standardize development environments for teams. Vagrant was designed to put an end to the &#8220;works on my machine&#8221; frustration that often surfaces when teams develop on different environments.</p>
<p>Because it&#8217;s so lightweight and portable, many WordPress developers have adopted Vagrant for development, which has resulted in different tools and configurations for various project needs. We&#8217;ve collected a few WordPress-related Vagrant resources here that will help you get started.</p>
<h3>Varying Vagrant Vagrants</h3>
<p><a href="https://github.com/Varying-Vagrant-Vagrants/VVV" target="_blank">Varying Vagrant Vagrants</a> is one of the most widely used and best-supported Vagrant configurations for WordPress development. Originally created by the folks at <a href="http://10up.com/" target="_blank">10up</a>, the open source VVV project <a href="http://10up.com/blog/varying-vagrant-vagrants-future/" target="_blank">became a community organization</a> earlier this year. The company still contributes to its development and maintenance, helping to make it one of the most stable options for setting up a Vagrant-based WordPress development environment. VVV provides a comprehensive configuration for developing themes and plugins as well as for contributing to WordPress core.</p>
<h3>VVV Site Wizard</h3>
<p>If you&#8217;re a VVV user who is often creating and removing sites, then the <a href="https://github.com/aliso/vvv-site-wizard" target="_blank">VVV Site Wizard</a> may be able to save you some time. It completely automates the creation of new sites as well as the teardown of old ones.</p>
<h3>WordPress Theme Review VVV</h3>
<p>If you&#8217;re a VVV user who spends quite a bit of time developing WordPress themes, this is a quick Vagrant setup that adds all the necessary tools for reviewing themes. <a href="https://github.com/aubreypwd/wordpress-themereview-vvv" target="_blank">WordPress Theme Review VVV</a> creates a fresh WordPress site, installs and activates the Developer and Theme-Check plugins, and imports the Theme Unit Test data. Check out our <a href="http://wptavern.com/wordpress-theme-review-vvv-a-quick-vagrant-setup-for-testing-and-reviewing-themes" target="_blank">tutorial</a> for a quick walkthrough on setting it set up.</p>
<h3>Primary Vagrant</h3>
<p><a href="https://github.com/ChrisWiegman/Primary-Vagrant" target="_blank">Primary Vagrant</a> is a configuration created by Chris Wiegman. It&#8217;s similar to VVV but with a few important differences: it uses Apache instead of NGINX and Puppet instead of Bash. Wiegman used VVV and Puppet as a base for a new Vagrant configuration for WordPress plugin or theme development. Primary Vagrant supports Apache and MySQL on Ubuntu and allows for use of different major PHP versions (currently 5.3 – 5.5), which can be easily changed with one line of code.</p>
<h3>VagrantPress</h3>
<p><a href="https://github.com/chad-thompson/vagrantpress" target="_blank">VagrantPress</a> is a simple configuration that sets up a WordPress development environment using Apache with Vagrant/Puppet. It&#8217;s geared toward developing themes and plugins. VagrantPress currently does not allow for multiple installations but Chat Thompson, the project&#8217;s creator, <a href="http://wptavern.com/vagrantpress-a-wordpress-development-environment-for-themes-and-plugins#comment-53714" target="_blank">plans to add more features</a> related to automating the provisioning and maintenance of multiple WordPress installations.</p>
<h3>Chassis</h3>
<p><a href="https://github.com/Chassis/Chassis" target="_blank">Chassis</a> uses Vagrant and Puppet to create a development environment running Ubuntu, Ngnix, PHP 5.4, Imagick, MySQL, Xdebug, WP-CLI, and WordPress, a setup which more closely matches many managed WP hosting environments. Chassis makes it easy to add additional testing domains via a YAML configuration file. It also has support for WordPress multisite, which can be enabled in config.local.yaml or the project configuration file.</p>
<h3>WordPress and Vagrant Google Group</h3>
<p><a href="https://groups.google.com/forum/#!forum/wordpress-and-vagrant" target="_blank">WordPress and Vagrant</a> is a public Google group that you can join to post basic or advanced questions about using Vagrant for development. This can be a helpful resource for troubleshooting some unique issues concerning Vagrant-based WordPress development environments. Most of the threads seem to be about working with VVV, but the group isn&#8217;t specifically limited.</p>
<h3>WordPress Vagrant Boxes</h3>
<p><a href="https://github.com/tierra/wp-vagrant" target="_blank">WordPress Vagrant Boxes</a> is a Vagrant configuration that uses Apache. Although the web server is preconfigured to look for WordPress in a specific location, WordPress Vagrant Boxes is unique in that it doesn&#8217;t checkout or install WordPress at all. It&#8217;s up to you to unpack and install a WordPress ZIP, checkout from SVN, or clone from git.</p>
<h3>VCCW (vagrant-chef-centos-wordpress)</h3>
<p><a href="https://github.com/miya0001/vagrant-chef-centos-wordpress" target="_blank">VCCW</a> (Vagrant + Chef + CentOS + WordPress) was configured for those developing WordPress plugins, themes or websites. It includes 17 customizable constants for setting the WordPress version (or beta release), language, hostname, subdirectory, admin credentials, default plugins, default theme, multisite, SSL and other options. These constants give you a lot of flexibility in tailoring your development environment to your specific needs.</p>
<h3>Throwaway WordPress VMs with Vagrant and Ansible</h3>
<p><a href="https://github.com/jalefkowit/vagrant-ansible-wordpress" target="_blank">Throwaway WordPress VMs</a> uses Vagrant and <a href="http://www.ansible.com/home" target="_blank">Ansible</a> to automate the process of creating and provisioning local virtual machines for WordPress development. The scripts were designed for use with Ubuntu, but you can select any version of Ubuntu you wish to use, or a base box from <a href="http://www.vagrantbox.es/" target="_blank">vagrantbox.es</a>.</p>
<h3>WordPress Machine</h3>
<p><a href="https://github.com/audionerd/wordpress-machine" target="_blank">WordPress Machine</a> sets up WordPress on a LAMP stack. It also includes Composer, <a href="http://wp-cli.org/" target="_blank">WP-CLI</a>, and <a href="http://forge.thethemefoundry.com/" target="_blank">Forge</a> for WordPress theme setup and asset compilation (SCSS, CoffeeScript). This configuration runs <a href="http://ajk.fi/2013/wordpress-as-a-submodule/" target="_blank">WordPress as a submodule</a> using <a href="https://github.com/Darep/wordpress-boilerplate" target="_blank">WordPress Boilerplate</a>, which means that themes, plugins and uploads are separated from the WordPress installation so that WP can be easily updated as a git submodule.</p>
<h3>Monkey Rocket</h3>
<p>The developer who created <a href="https://github.com/Cikica/monkeyrocket" target="_blank">Monkey Rocket</a> used much of the code from VVV, which he found installed more things than he needed for a simple development environment. This Vagrant configuration is basically a stripped down version of VVV that will set you up with the latest stable version of WordPress at local.wordpress.dev on your machine.</p>
<h3>WordPress Kickstart</h3>
<p><a href="https://github.com/jnettome/wordpress_kickstart" target="_blank">WordPress Kickstart</a> is a Vagrant development environment provisioned by Puppet. It was created for use with production stacks that are hosted on <a href="https://www.digitalocean.com/" target="_blank">DigitalOcean</a>. Once you enter your DigitalOcean API credentials into the vagrantfile, you&#8217;ll have a command available for working on production deployment and provisioning. This command allows you to create a new droplet, setup your SSH key for authentication, create a new user account, and run the provisioners configured. You can easily switch back and forth from production to development by removing .vagrant/ from your project&#8217;s root folder.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Apr 2014 14:19:18 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:18;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:66:"WPTavern: WPWeekly Episode 146 – WordPress 3.9 With Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:44:"http://wptavern.com?p=21420&preview_id=21420";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:168:"http://wptavern.com/wpweekly-episode-146-wordpress-3-9-with-andrew-nacin?utm_source=rss&utm_medium=rss&utm_campaign=wpweekly-episode-146-wordpress-3-9-with-andrew-nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2175:"<p>In this weeks edition of WordPress Weekly, we discussed several topics with WordPress lead developer <a href="http://nacin.com/" title="http://nacin.com/">Andrew Nacin</a>. Ever since the release of WordPress 3.7, many have questioned why auto updates are turned on by default for minor and security updates. Nacin described the philosophy behind the auto update system and why the team will be sticking with its current implementation.</p>
<p>We also learned the details behind the release of a major security update to Jetpack. Last but not least, Nacin describes what it was like to lead the release of 3.9 and what he&#8217;ll be focusing on now that he won&#8217;t be leading a release cycle.</p>
<h2>Stories Discussed:</h2>
<p><a href="http://wptavern.com/wordpress-3-9-smith-released" title="http://wptavern.com/wordpress-3-9-smith-released">WordPress 3.9 “Smith” Released</a><br />
<a href="http://wptavern.com/wordpress-3-9-has-built-in-support-for-pasting-from-microsoft-word" title="http://wptavern.com/wordpress-3-9-has-built-in-support-for-pasting-from-microsoft-word">WordPress 3.9 Has Built-In Support for Pasting from Microsoft Word</a><br />
<a href="http://wptavern.com/buddypress-2-0-released-big-performance-improvements-and-new-administration-tools" title="http://wptavern.com/buddypress-2-0-released-big-performance-improvements-and-new-administration-tools">BuddyPress 2.0 Released: Big Performance Improvements and New Administration Tools</a></p>
<h2>WPWeekly Meta:</h2>
<p><strong>Next Episode:</strong> Friday, April 25th 3 P.M. Eastern &#8211; Special Guest &#8211; Japh</p>
<p><strong>Subscribe To WPWeekly Via Itunes: </strong><a href="https://itunes.apple.com/us/podcast/wordpress-weekly/id694849738" target="_blank">Click here to subscribe</a></p>
<p><strong>Subscribe To WPWeekly Via RSS: </strong><a href="http://www.wptavern.com/feed/podcast" target="_blank">Click here to subscribe</a></p>
<p><strong>Subscribe To WPWeekly Via Stitcher Radio: </strong><a href="http://www.stitcher.com/podcast/wordpress-weekly-podcast?refid=stpr" target="_blank">Click here to subscribe</a></p>
<p><strong>Listen To Episode #146:</strong><br />
</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 19 Apr 2014 14:29:46 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:19;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"Andrew: Customizing TinyMCE 4.0";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"http://azaozz.wordpress.com/?p=380";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:63:"http://azaozz.wordpress.com/2014/04/19/customizing-tinymce-4-0/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2358:"<p>Many of the TinyMCE settings have changed in version 4.0. There is a new default theme: Modern, and all the UI settings for the former Advanced theme (<code>theme_advanced...)</code> are deprecated.</p>
<p>One often used setting was <code>theme_advanced_blockformats</code><strong><code>.</code></strong> It was renamed to <code>block_formats</code> and keeps the same formatting. To specify a different set of elements for the &#8216;blockformats&#8217; drop-down (second toolbar row in the WordPress Visual editor), you can set a string of name=value pairs separated by a semicolon in the initialization object:</p>
<pre class="brush: jscript; title: ; notranslate">block_formats: "Paragraph=p;Heading 1=h1;Heading 2=h2;Heading 3=h3"</pre>
<p>Another handy setting: <code>theme_advanced_styles</code> doesn&#8217;t exist any more. However there is a more powerful version: <code>style_formats</code>. Now it can replace or add items to the new &#8220;Formats&#8221; menu.The value is an array of objects each containing a name that is displayed as sub-menu and several settings: a CSS class name or an inline style, and optionally the wrapper element where the class or inline style will be set:</p>
<pre class="brush: jscript; title: ; notranslate">
toolbar3: \'styleselect\',
style_formats_merge: true,
style_formats: { name: \'Custom styles\', [
  {title: \'Red bold text\', inline: \'b\', styles: {color: \'#ff0000\'}},
  {title: \'Red text\', inline: \'span\', styles: {color: \'#ff0000\'}},
  {title: \'Red header\', block: \'h1\', styles: {color: \'#ff0000\'}},
  {title: \'Example 1\', inline: \'span\', classes: \'example1\'},
  {title: \'Example 2\', inline: \'span\', classes: \'example2\'}
]}
</pre>
<p>The above code will add another sub-menu to &#8220;Formats&#8221; without replacing the default menu items. There is <a href="http://www.tinymce.com/wiki.php/Configuration:style_formats">more information</a> and an <a href="http://www.tinymce.com/tryit/custom_formats.php">example</a> on the TinyMCE website.</p><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/azaozz.wordpress.com/380/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/azaozz.wordpress.com/380/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=azaozz.wordpress.com&blog=3380945&post=380&subd=azaozz&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 19 Apr 2014 07:04:36 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Andrew Ozz";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:20;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:66:"WPTavern: Quotable: Highlight and Share WordPress Posts on Twitter";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21400";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:174:"http://wptavern.com/quotable-highlight-and-share-wordpress-posts-on-twitter?utm_source=rss&utm_medium=rss&utm_campaign=quotable-highlight-and-share-wordpress-posts-on-twitter";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3084:"<p><a href="http://wptavern.com/wp-content/uploads/2014/04/quotable.png" rel="prettyphoto[21400]"><img src="http://wptavern.com/wp-content/uploads/2014/04/quotable.png" alt="quotable" width="772" height="250" class="aligncenter size-full wp-image-21403" /></a></p>
<p>Readers may not always identify with the title that you&#8217;ve chosen for your posts but they may find a gem within your article that is more &#8220;quotable&#8221; and worth sharing. <a href="http://wordpress.org/plugins/quotable/" target="_blank">Quotable</a> is a new WordPress plugin that capitalizes on this, allowing readers to highlight any text within your content to quote the article on Twitter.</p>
<p>The plugin, developed by <a href="http://josiahsprague.com/" target="_blank">Josiah Sprague</a>, was partially inspired by the toolbar on Medium.com that enables visitors to tweet or comment on the text they select. Sprague said that he created it out of his love for both WordPress and Twitter:</p>
<blockquote><p> I love how both platforms make it easy for people to share ideas and communicate openly and freely. I love that both serve as a sort of “public square” of the web and support discourse, democracy and free society.</p></blockquote>
<p>Quotable adds a tiny Twitter icon to the end of blockquotes for quick sharing.  It also works with text highlighting. Readers will often instinctively highlight text that they agree with or are wanting to share. When they do, they&#8217;ll naturally discover that it&#8217;s easy to share.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/quotable2.png" rel="prettyphoto[21400]"><img src="http://wptavern.com/wp-content/uploads/2014/04/quotable2.png" alt="quotable2" width="916" height="458" class="aligncenter size-full wp-image-21405" /></a></p>
<p>When you click the Twitter bird, a tweet modal will automatically launch with the quoted text inserted. Quotable also integrates with Twitter accounts configured via Yoast&#8217;s WordPress SEO, which allows you to include Twitter mentions for post authors and suggest following the website&#8217;s Twitter account.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/quotable-1.png" rel="prettyphoto[21400]"><img src="http://wptavern.com/wp-content/uploads/2014/04/quotable-1.png" alt="quotable-1" width="1400" height="1360" class="aligncenter size-full wp-image-21404" /></a></p>
<p>Let&#8217;s face it &#8211; the comments section of your post is not always the locus of the conversation sparked by your blog. Even if your post is the origin of a hotly debated topic, the conversation often moves to Twitter, and that&#8217;s OK. This plugin helps you to be ready to follow the conversation wherever it goes, especially if you configure it to automatically mention you, the post author, when a quote gets tweeted.</p>
<p>I tested Quotable with WordPress 3.9 and found that it works as advertised and fits naturally into any theme without being obtrusive. <a href="http://wordpress.org/plugins/quotable/" target="_blank">Download</a> it for free from WordPress.org.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 18 Apr 2014 23:10:17 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:21;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:44:"Akismet: New in 3.0: Activation with Jetpack";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://blog.akismet.com/?p=1308";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"http://blog.akismet.com/2014/04/18/activation-with-jetpack/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2091:"<p>We launched <a href="http://blog.akismet.com/2014/04/15/akismet-3-0-0/" title="Akismet 3.0.0 is Now Available">Akismet 3.0</a> just a few days ago and hope that you&#8217;ve already upgraded to enjoy its many new features. One of the nifty items we added to the mix is a seamless activation process using the popular <a href="http://wordpress.org/plugins/jetpack/" title="Jetpack by WordPress.com">Jetpack</a> plugin.</p>
<p>Let&#8217;s take a closer look.</p>
<p>If you have Jetpack and Akismet installed and activated on your site &#8211; and the Jetpack plugin connected to a <a href="http://wordpress.com" title="WordPress.com">WordPress.com</a> account &#8211; you will find this new feature in your dashboard via <strong>Jetpack &#8594; Akismet</strong>.</p>
<p>There, you will see which WordPress.com account is connected via Jetpack and an option to activate the Akismet plugin using that very same account.</p>
<p><a href="http://akismet.files.wordpress.com/2014/04/akismet-activation-with-jetpack.png"><img src="http://akismet.files.wordpress.com/2014/04/akismet-activation-with-jetpack.png?w=640&h=263" alt="Akismet Activation with Jetpack" class="alignnone size-large wp-image-1348" /></a></p>
<p>Click on <strong>Use this Akismet account</strong>, and you&#8217;re all set! Of course, you will have the option to disconnect the account at any time from the same page in your dashboard.</p>
<p>And if you want to use a different account to activate Akismet, no worries at all. Simply select the option to register a different email address or manually enter an existing API key.</p>
<p>Digging the new flow? Any problems with it? <a href="http://akismet.com/contact/" title="Contact Akismet">Drop us a line</a>.</p><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/akismet.wordpress.com/1308/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/akismet.wordpress.com/1308/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=blog.akismet.com&blog=116920&post=1308&subd=akismet&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 18 Apr 2014 19:40:30 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Anthony Bubel";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:22;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:76:"WPTavern: WordPress 3.9 Has Built-in Support for Pasting from Microsoft Word";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21366";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:196:"http://wptavern.com/wordpress-3-9-has-built-in-support-for-pasting-from-microsoft-word?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-3-9-has-built-in-support-for-pasting-from-microsoft-word";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2744:"<div id="attachment_21384" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/paste.png" rel="prettyphoto[21366]"><img src="http://wptavern.com/wp-content/uploads/2014/04/paste.png" alt="photo credit: This Year\'s Love - cc" width="900" height="401" class="size-full wp-image-21384" /></a><p class="wp-caption-text">photo credit: <a href="http://www.flickr.com/photos/hand-nor-glove/1481913840/">This Year&#8217;s Love</a> &#8211; <a href="http://creativecommons.org/licenses/by-nc-nd/2.0/">cc</a></p></div>
<p>A common support question that&#8217;s been popping up on the web after WordPress users update to 3.9: <strong>What happened to the &#8220;Paste from Word&#8221; button in the visual editor?</strong> If you find that the button is missing, don&#8217;t worry &#8211; it&#8217;s not a bug.  Prior to this update, the button was located in the kitchen sink of the visual editor:</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/paste-from-word.png" rel="prettyphoto[21366]"><img src="http://wptavern.com/wp-content/uploads/2014/04/paste-from-word.png" alt="paste-from-word" width="622" height="233" class="aligncenter size-full wp-image-21370" /></a></p>
<p>WordPress 3.9, however, <a href="https://core.trac.wordpress.org/changeset/28089" target="_blank">removes the &#8220;paste from word&#8221; button</a> entirely. It includes <a href="http://make.wordpress.org/core/2014/01/18/tinymce-4-0-is-in-core/" target="_blank">TinyMCE 4.0</a> and has better built-in support for pasting in blocks of text for Microsoft Word. The better your software gets, the more the magic happens behind the scenes. WordPress now detects if the pasted text is coming from MS Word and makes the appropriate changes.</p>
<p>Until I saw the <a href="http://www.reddit.com/r/Wordpress/comments/23ah5d/copy_from_word_button_went_missing/" target="_blank">question</a> on Reddit, indicating that the button had gone missing, I had no idea that anyone still used this feature. The missing button is actually an enhancement, not a bug. Hopefully this information has reached you before you started deactivating all your plugins.</p>
<p>Unless you had been closely following the posts at <a href="http://make.wordpress.org" target="_blank">make.wordpress.org</a>, this improvement might have been easy to miss. Check out our <a href="http://wptavern.com/wordpress-3-9-smith-released" target="_blank">summary of everything that&#8217;s new in WordPress 3.9</a>. If you&#8217;re having any problems with the update, you may want to review some of the <a href="http://wptavern.com/common-issues-and-troubleshooting-wordpress-3-9" target="_blank">known issues</a> with plugins before posting in the support forums.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 18 Apr 2014 17:53:15 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:23;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:59:"WPTavern: How to Limit Activity Comment Depth in BuddyPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21347";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:162:"http://wptavern.com/how-to-limit-activity-comment-depth-in-buddypress?utm_source=rss&utm_medium=rss&utm_campaign=how-to-limit-activity-comment-depth-in-buddypress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2642:"<p>BuddyPress 2.0 was <a href="http://wptavern.com/buddypress-2-0-released-big-performance-improvements-and-new-administration-tools" target="_blank">released</a> this week with many new administrative tools that make it easier to manage communities from the backend. One of the lesser known new features is the ability to limit comment depth in the activity stream.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/old-threaded-comments.png" rel="prettyphoto[21347]"><img src="http://wptavern.com/wp-content/uploads/2014/04/old-threaded-comments-300x258.png" alt="old-threaded-comments" width="300" height="258" class="alignright size-medium wp-image-21351" /></a>Activity threads can sometimes get out of control when it comes to replies, which results in the comments box getting progressively squished to an inconveniently small size.</p>
<p>In the past, the only way to change the comment depth was to filter the output of the bp_activity_can_comment_reply() function, but this wasn&#8217;t very user-friendly for community managers.</p>
<p>Since WordPress already has a built-in setting for comment depth, this was a natural fit for activity comments and did not require adding any new settings. BuddyPress 2.0 now <a href="https://buddypress.trac.wordpress.org/ticket/2768" target="_blank">respects WordPress&#8217; comment depth settings</a>. You can adjust them in the admin at <strong>Settings > Discussion > Other Comment Settings</strong>.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/threaded-comments.png" rel="prettyphoto[21347]"><img src="http://wptavern.com/wp-content/uploads/2014/04/threaded-comments.png" alt="threaded-comments" width="1200" height="397" class="aligncenter size-full wp-image-21349" /></a></p>
<p>In the following example, threaded comments have been set to three. You&#8217;ll notice that the third comment has no reply link beneath it. Members can still comment on the activity item itself but will not be able to add more than three replies.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/activity-comments.png" rel="prettyphoto[21347]"><img src="http://wptavern.com/wp-content/uploads/2014/04/activity-comments.png" alt="activity-comments" width="900" height="680" class="aligncenter size-full wp-image-21355" /></a></p>
<p>This update shouldn&#8217;t affect the structure of your previous activity comments/replies, but it will be in effect for threaded comments moving forward. If you&#8217;ve been itching to to limit activity comment depth on your BuddyPress site, this new setting makes it easy to set a limit, without having to touch any code.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 18 Apr 2014 06:42:38 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:24;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:66:"WordPress.tv: Cédric Motte : Sans contenu, WordPress n’est rien";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=34325";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:77:"http://wordpress.tv/2014/04/17/cedric-motte-sans-contenu-wordpress-nest-rien/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:673:"<div id="v-4WgeuUC1-1" class="video-player">
</div><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/34325/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/34325/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=34325&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2014/04/17/cedric-motte-sans-contenu-wordpress-nest-rien/"><img alt="13 &#8211; Cedric Motte-Conf-WCParis2014.mp4" src="http://videos.videopress.com/4WgeuUC1/video-88337de484_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 17 Apr 2014 21:58:16 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:25;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:91:"WPTavern: Automattic Publishes Transparency Report, Reaffirms Support for Freedom of Speech";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21275";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:224:"http://wptavern.com/automattic-publishes-transparency-report-reaffirms-support-for-freedom-of-speech?utm_source=rss&utm_medium=rss&utm_campaign=automattic-publishes-transparency-report-reaffirms-support-for-freedom-of-speech";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5451:"<p>Automattic was created to bring WordPress&#8217; open source publishing software to people on a larger scale. The company shares <a href="http://codex.wordpress.org/WordPress_Policies" target="_blank">WordPress&#8217; mission</a> to democratize publishing. As part of that mission, Automattic published a transparency report, which outlines the number of information requests, takedown demands, and national security requests it has received.</p>
<p>The <a href="http://transparency.automattic.com/" target="_blank">Transparency Report</a> is located on a new site which helps users to navigate what will likely become a large archive of information, as Automattic plans to publish a new report every six months. This report will keep users informed about which governments are making requests and policies for responding to them.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/transparency-report.jpg" rel="prettyphoto[21275]"><img src="http://wptavern.com/wp-content/uploads/2014/04/transparency-report.jpg" alt="transparency-report" width="1280" height="664" class="aligncenter size-full wp-image-21310" /></a></p>
<p>Writing on behalf of Automattic, Jenny Zhu <a href="http://en.blog.wordpress.com/2014/04/17/transparency-report/" target="_blank">summarized</a> the company&#8217;s policy regarding information requests:</p>
<blockquote><p>Our policy is to notify you of any information request we receive regarding your account, so that you may challenge the request. The only exception is if we are prohibited by law (not just asked nicely by the police) from making such a notification. </p></blockquote>
<h3>Automattic is Committed to Actively Pushing Back Against Requests That Violate Freedom of Speech</h3>
<p>Historically, Automattic has demonstrated its support for freedom of speech by <a href="http://en.blog.wordpress.com/2010/07/01/support-the-first-amendment-with-1-for-all/" target="_blank">raising awareness about the First Amendment</a>, even taking to the courts <a href="http://en.blog.wordpress.com/2013/11/21/striking-back-against-censorship/" target="_blank">to stand with users against DMCA abuse</a>. The company also recently joined forces with other organizations around the globe to <a href="http://wptavern.com/wordpress-com-joins-google-reddit-and-tumblr-in-protesting-nsa-surveillance" target="_blank">protest NSA surveillance</a>.</p>
<p>Through its statement today, Automattic emphasized that it will push back against requests that constitute infringements on freedom of speech:</p>
<blockquote><p>We also carefully review all legal requests we receive and actively push back on those that are procedurally deficient, overly-broad, or otherwise improper (i.e., those that target non-criminal free speech).</p></blockquote>
<h3>The US Government Represents 60% of the Information Requests</h3>
<p>Russia, not known for its support of free press, leads the way in <a href="http://transparency.automattic.com/takedown-demands/" target="_blank">takedown demands</a> with 88% of the total requests received by WordPress.com. The United States, however, far and away leads in the number of user <a href="http://transparency.automattic.com/information-requests/" target="_blank">information requests</a> from governments and law enforcement agencies from July 1 – December 31, 2013.</p>
<p>While most of the countries listed have submitted a handful of requests, the US government sent 20 requests, specifying 29 different sites. In 60% of those requests, some or all information was produced. The requests shown here do not include those related to litigation and civil proceedings.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/information-requests.jpg" rel="prettyphoto[21275]"><img src="http://wptavern.com/wp-content/uploads/2014/04/information-requests.jpg" alt="information-requests" width="753" height="736" class="aligncenter size-full wp-image-21315" /></a></p>
<p>Automattic specifies that the company will only turn over private user information upon receipt of valid US legal process. Requests that originate from outside the US are required to be served through a US court or enforcement agency.</p>
<p>The company is not permitted to disclose very much regarding national security requests, despite wishing they could:</p>
<blockquote><p>Finally, we’re reporting the maximum amount of information allowed by law about the number and type(s) of National Security Requests that we received. The disclosures we’re currently allowed to make are limited, and unfortunately, we’re not permitted to paint a more truthful picture.</p></blockquote>
<p>The <a href="http://transparency.automattic.com/" target="_blank">Transparency Report</a> makes it clear that Automattic will not tolerate censorship of its users and is committed to disclosing as much information related to government requests as they are permitted. Many governments are <a href="http://www.bloomberg.com/news/2014-04-11/nsa-said-to-have-used-heartbleed-bug-exposing-consumers.html" target="_blank">ruthless about extracting information from citizens</a>, even when it comes at the expense of the people they serve. Given that the United States leads the pack in information requests, it&#8217;s reassuring to know that WordPress.com, one of the most highly trafficked sites in the US and around the globe, is committed to standing against any request that violates users&#8217; freedom of speech.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 17 Apr 2014 20:43:07 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:26;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:57:"WPTavern: Common Issues and Troubleshooting WordPress 3.9";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21274";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:158:"http://wptavern.com/common-issues-and-troubleshooting-wordpress-3-9?utm_source=rss&utm_medium=rss&utm_campaign=common-issues-and-troubleshooting-wordpress-3-9";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:8165:"<div id="attachment_21291" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WP39Support.png" rel="prettyphoto[21274]"><img class="size-full wp-image-21291" src="http://wptavern.com/wp-content/uploads/2014/04/WP39Support.png" alt="WordPress 3.9 Featured Images" width="639" height="200" /></a><p class="wp-caption-text">photo credit: <a href="http://www.flickr.com/photos/ironrodart/4154904299/">IronRodArt &#8211; Royce Bair (&#8220;Star Shooter&#8221;)</a> &#8211; <a href="http://creativecommons.org/licenses/by-nc-nd/2.0/">cc</a></p></div>
<p>After the release of WordPress 3.9, I decided to help out in the <a title="http://wordpress.org/support/" href="http://wordpress.org/support/">support forums</a> since they usually become busy soon after a release. Providing support in the WordPress.org forums gives you a clear indication on how well a release is being received and whether or not anything major broke. After spending five hours in the support forum, here are some common issues being reported by users.</p>
<h3>Visual Editor Disappeared Or Is Broken</h3>
<p>A lot of users are <a title="http://wordpress.org/tags/visual-editor" href="http://wordpress.org/tags/visual-editor">reporting that the visual editor</a> has either disappeared or is broken. Considering the <a title="http://make.wordpress.org/core/2014/01/18/tinymce-4-0-is-in-core/" href="http://make.wordpress.org/core/2014/01/18/tinymce-4-0-is-in-core/">number</a> of changes that took place with TinyMCE in 3.9, this is not surprising. In most cases, having users go through the following process solved the problem.</p>
<ol>
<li>Deactivate ALL plugins.</li>
<li>Switch to default TwentyFourteen theme.</li>
<li>Manually empty browser cache.</li>
</ol>
<p>If the visual editor doesn&#8217;t work after disabling all plugins and switching to the default theme, there could be a JavaScript issue. Follow <a title="http://codex.wordpress.org/Using_Your_Browser_to_Diagnose_JavaScript_Errors" href="http://codex.wordpress.org/Using_Your_Browser_to_Diagnose_JavaScript_Errors">these instructions</a> to diagnose JavaScript errors in your browser. Then, open up a new support forum thread and make sure to add the following information:</p>
<ul>
<li>the browsers that you are experiencing the problem in</li>
<li>whether SCRIPT_DEBUG fixed the error or not</li>
<li>the JavaScript error</li>
<li>the location of the error &#8211; both the file name and the line number</li>
<li>the context of the error &#8211; including the whole error stack will help developers</li>
</ul>
<p>This detailed information will help volunteer moderators determine the best way to solve your problem.</p>
<h3>Master List Of Known Issues</h3>
<p>Themes and plugins confirmed to be the cause of the problem are documented and added to the <a title="http://wordpress.org/support/topic/wordpress-39-master-list?replies=4" href="http://wordpress.org/support/topic/wordpress-39-master-list?replies=4">master list</a> of known issues with WordPress 3.9. So far, the list of plugins is up to eight with at least one in the process of being fixed.</p>
<ul>
<li><a href="http://wordpress.org/plugins/wysija-newsletters/">MailPoet Newsletters</a> &#8211; Issue with <a href="https://wordpress.org/support/topic/39-update-tinymce-disappeared?replies=6#post-5465005">outdated TinyMCE plugin in version 2.6.3</a>, disabling plugin fixed Visual Editor problem. MailPoet is already working on a fix for the TinyMCE issue in the next versions 2.6.4 (for post editor screen) and 2.6.5 (for newsletter editor).</li>
<li><a href="https://wordpress.org/plugins/ziplist-recipe-plugin/">ZipList Recipe Plugin</a> &#8211; Version 2.2 has a problem with the post editor in <a href="https://wordpress.org/support/topic/plugin-causes-posts-to-not-be-editable?replies=2">both Visual and Text mode</a>.</li>
<li><a href="http://wordpress.org/plugins/zedity/">Zedity</a> &#8211; Version 3.1.0 causes the Visual Editor to break.</li>
<li><a href="https://wordpress.org/plugins/enhanced-media-library/">Enhanced Media Library</a> &#8211; Version 1.0.4 doesn&#8217;t show any media in the media library when the Add Media button is clicked</li>
<li><a href="http://wordpress.org/plugins/soundcloud-is-gold/">SoundCloud Is Gold</a> &#8211; Version 2.2.1 disables the Visual editor and prevents text from being entered</li>
<li><a href="https://wordpress.org/plugins/nofollow/">Ultimate NoFollow</a> &#8211; Version 1.4.1 doesn&#8217;t allow links to be inserted in the visual editor</li>
<li><a href="https://wordpress.org/plugins/many-tips-together/">Admin Tweaks</a> &#8211; version 2.3.8 causes the visual editor to white out.</li>
<li><a href="http://wordpress.org/plugins/qtranslate/">Qtranslate</a> &#8211; version 2.5.39 causes the media uploaded not to function</li>
</ul>
<p>The support team tries their best to help everyone with any WordPress problem even if it&#8217;s for a commercial theme or plugin. However, due to the great variety of existing themes and plugins it is nearly impossible to know everything. Your best option is to contact the developer for support. It’s always best to go to where the theme/plugin is officially supported when trying to get support.</p>
<h3>How To Create An Audio Playlist</h3>
<p>A few users have asked where the link is to create an audio playlist. In order to see the link to create an audio playlist, you either need existing audio files within the media library or you need to add them. It&#8217;s worth noting that if you host your media files on a content delivery network that&#8217;s not synchronized with the WordPress media library, you won&#8217;t be able to take advantage of the playlist feature.</p>
<h3>Easy Way To Add Borders and Padding To Images Removed</h3>
<p>Although WordPress 3.9 has refined the media editing experience, it did so at the cost of removing a feature users appreciated. In WordPress 3.8, users could easily add a border, vertical, and horizontal padding to images. WordPress 3.9 has removed this from the advanced image settings screen.</p>
<div id="attachment_21279" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WP38ImageProperties.png" rel="prettyphoto[21274]"><img class="size-full wp-image-21279" src="http://wptavern.com/wp-content/uploads/2014/04/WP38ImageProperties.png" alt="Image Properties In WordPress 3.8" width="620" height="476" /></a><p class="wp-caption-text">Image Properties In WordPress 3.8</p></div>
<p>It&#8217;s not just those who use the self-hosted version of WordPress that are upset with the change. A WordPress.com <a title="http://en.forums.wordpress.com/topic/image-resize-1?replies=430" href="http://en.forums.wordpress.com/topic/image-resize-1?replies=430">support forum thread</a> with over 430 posts is filled with users asking why the feature was removed. In some cases, WordPress.com staff are explaining how to use HTML code to add or remove borders to images. It&#8217;s possible that a plugin will soon be released that will restore this feature.</p>
<h3>Use Patience When Asking For Support</h3>
<p>Since WordPress 3.9 is a major upgrade, please exercise patience when requesting support on the forum. This <a title="https://codex.wordpress.org/Using_the_Support_Forums#Getting_Your_Questions_Answered_on_the_Forum" href="https://codex.wordpress.org/Using_the_Support_Forums#Getting_Your_Questions_Answered_on_the_Forum">guide on the Codex</a> does a great job explaining how to get your question answered. Last but not least, if a volunteer helps solve your problem, say thank you. During my five-hour support stint, I realized first-hand that providing support is a thankless job. Reading thank you notes and seeing users express joy from having their problem solved gave me the energy to keep on going.</p>
<p>I encourage you to take 15-20 minutes to browse the support forum and help out where you can. Not only will you get a better understanding of problems users are facing, but you&#8217;ll learn a lot in the process. To anyone who&#8217;s taken the time to answer a support question on the forum, <strong>thank you!</strong></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 17 Apr 2014 19:45:25 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:27;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:51:"WordPress.tv: Introducing WordPress 3.9 “Smith”";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=34317";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:63:"http://wordpress.tv/2014/04/16/introducing-wordpress-3-9-smith/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:635:"<div id="v-sAiXhCfV-1" class="video-player">
</div><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/34317/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/34317/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=34317&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2014/04/16/introducing-wordpress-3-9-smith/"><img alt="WordPress3-9-Smith" src="http://videos.videopress.com/sAiXhCfV/wordpress3-9-smith_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 16 Apr 2014 21:10:08 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:28;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:70:"WPTavern: How To Set Up 1 Or 2 Columns For WordPress Dashboard Widgets";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21030";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:184:"http://wptavern.com/how-to-set-up-1-or-2-columns-for-wordpress-dashboard-widgets?utm_source=rss&utm_medium=rss&utm_campaign=how-to-set-up-1-or-2-columns-for-wordpress-dashboard-widgets";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3932:"<p>One of the improvements in <a title="http://wordpress.org/news/2013/12/parker/" href="http://wordpress.org/news/2013/12/parker/">WordPress 3.8</a> was the responsive dashboard. Thanks to this improvement, the option to select the number of columns to display dashboard widgets <a title="http://make.wordpress.org/ui/2013/10/11/dash-update-4/" href="http://make.wordpress.org/ui/2013/10/11/dash-update-4/">was removed</a>. The dashboard now shows the appropriate number of columns using the available screen real estate. Unfortunately, for those using wide-screen monitors, this usually means 4-5 skinny columns. In the screenshot below, you can see that even if a column doesn&#8217;t have a widget assigned to it, the column remains in place.</p>
<div id="attachment_21233" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/DashboardWithFourColumns.png" rel="prettyphoto[21030]"><img class="size-full wp-image-21233" src="http://wptavern.com/wp-content/uploads/2014/04/DashboardWithFourColumns.png" alt="The Result Of A Responsive Dashboard" width="1724" height="417" /></a><p class="wp-caption-text">The Result Of A Responsive Dashboard</p></div>
<p>The issue was <a title="http://imtheirwebguy.com/dont-hit-update-just-yet-wp-3-8-overhauls-ui-breaks-dashboard-widgets/" href="http://imtheirwebguy.com/dont-hit-update-just-yet-wp-3-8-overhauls-ui-breaks-dashboard-widgets/">brought up by Chris Jenkins</a> shortly after the release of WordPress 3.8. WordPress core developer Mark Jaquith agreed that &#8220;dashboard widgets should be able to specify a min-width, such that they span multiple columns if WordPress tries to make them smaller than that.&#8221; Jaquith <a title="https://core.trac.wordpress.org/ticket/26575" href="https://core.trac.wordpress.org/ticket/26575">created a ticket</a> suggesting a fix but so far, a patch has not been created.</p>
<p>Since the ticket was created, Jenkins has developed and released a plugin called <a title="http://wordpress.org/plugins/two-column-admin/" href="http://wordpress.org/plugins/two-column-admin/">Two Column Admin</a>. When activated, the plugin restores the ability to select 1 or 2 columns to the screen options tab. The downside to using this plugin is that selecting two columns will disable the responsiveness of the dashboard widgets. Instead of merging into one column when the screen size gets smaller, the two columns will crash into each other.</p>
<div id="attachment_21234" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/TwoColumnUnresponsiveWidgets.png" rel="prettyphoto[21030]"><img class="size-full wp-image-21234" src="http://wptavern.com/wp-content/uploads/2014/04/TwoColumnUnresponsiveWidgets.png" alt="Two Column Unresponsive Widgets" width="500" height="447" /></a><p class="wp-caption-text">Two Column Unresponsive Widgets</p></div>
<p>Matt Beck <a title="https://core.trac.wordpress.org/ticket/26575#comment:1" href="https://core.trac.wordpress.org/ticket/26575#comment:1">responded to the ticket</a> with a good suggestion in lieu of the column option returning:</p>
<blockquote><p>Best case scenario would be for the number/width of columns to adjust to the number of active dashboard widgets instead of displaying the empty drag/drop areas. In lieu of that, some mechanism to specify either column-count of a widget intended to be wide and/or better yet &#8211; maximum number of columns to display on the dashboard would be great.</p></blockquote>
<p>After being stuck with four columns since the release of 3.8, I&#8217;ve forgotten how nice it is to have wide dashboard widgets. I&#8217;m hopeful that in the future, the ability to specify the number of columns in the dashboard returns as I prefer three, not four columns.</p>
<p><strong>How many of you would like to be able to specify a specific amount of columns versus the current implementation?</strong></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 16 Apr 2014 19:30:38 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:29;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:76:"WPTavern: BuddyPress Development Trunk to Adopt a Grunt-Powered Build System";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21231";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:196:"http://wptavern.com/buddypress-development-trunk-to-adopt-a-grunt-powered-build-system?utm_source=rss&utm_medium=rss&utm_campaign=buddypress-development-trunk-to-adopt-a-grunt-powered-build-system";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3238:"<p><a href="http://wptavern.com/wp-content/uploads/2014/04/grunt.jpg" rel="prettyphoto[21231]"><img src="http://wptavern.com/wp-content/uploads/2014/04/grunt.jpg" alt="grunt" width="916" height="360" class="aligncenter size-full wp-image-21245" /></a></p>
<p>Now that <a href="http://wptavern.com/buddypress-2-0-released-big-performance-improvements-and-new-administration-tools" target="_blank">BuddyPress 2.0</a> has been released, the core development team is refining its workflow to make use of <a href="http://gruntjs.com/" target="_blank">Grunt</a>, the Javascript task runner that the WordPress project <a href="http://make.wordpress.org/core/2013/08/06/a-new-frontier-for-core-development/" target="_blank">adopted</a> last year. The <a href="http://buddypress.svn.wordpress.org/trunk" target="_blank">BuddyPress development trunk</a> will be adopting a similar Grunt-powered build system that will automate many tedious tasks.</p>
<p>The BuddyPress trunk will be reorganized to include a <strong>/src</strong> directory for BuddyPress, minus bbPress 1.1 and the BP-Default theme, which will be removed. The <strong>/tests</strong> directory will house the phpUnit tests. <a href="https://travis-ci.org/buddypress/BuddyPress" target="_blank">Travis-CI</a> and configuration files for tests will be moved to the root.</p>
<h3>Who Is Affected?</h3>
<p>The reorganization of the trunk will not affect production releases of BuddyPress, so for most ordinary users nothing will change. BuddyPress core contributor Paul Gibbs specified who will be affected by the changes in his <a href="http://bpdevel.wordpress.com/2014/04/16/grunt-coming-to-buddypress/" target="_blank">post</a> on the development blog. The changes concern you if:</p>
<ul>
<li>You develop plugins for BuddyPress</li>
<li>You are a core contributor</li>
<li>You run a checkout of trunk on a production site</li>
</ul>
<p>While this cross section of affected users represents just a handful of BuddyPress developers, the good news for everyone is that both core and extension development will become more efficient. That means that improvements and new plugins are likely to reach you faster than before.</p>
<h3>How Will Grunt Make BuddyPress Development More Efficient?</h3>
<p>Grunt will reduce the amount of manual labor that developers put into contributing to the BuddyPress core and creating plugins. The task runner will handle all of the following:</p>
<ul>
<li>Validate and lint CSS/JS</li>
<li>Generate right-to-left CSS</li>
<li>Compress images</li>
<li>Run unit tests</li>
<li>Generate the .pot file for internationalization</li>
<li>Check for missing text domains</li>
<li>Make it easier for developers to apply patches from BuddyPress Trac for testing</li>
</ul>
<p>The core team may add to this list in the future. If you want to get involved in the discussion or keep an eye on the &#8220;grunt-ification&#8221; of the BuddyPress trunk, there&#8217;s a <a href="https://buddypress.trac.wordpress.org/ticket/5160" target="_blank">trac ticket</a> open where updates will be posted. Core contributors and developers running a checkout of trunk on production/development sites will want to stay tuned for any changes that might affect your workflow.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 16 Apr 2014 19:16:36 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:30;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:44:"WPTavern: WordPress 3.9 “Smith” Released";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=19881";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:120:"http://wptavern.com/wordpress-3-9-smith-released?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-3-9-smith-released";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:13415:"<div id="attachment_21131" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WordPress39.png" rel="prettyphoto[19881]"><img class="size-full wp-image-21131" src="http://wptavern.com/wp-content/uploads/2014/04/WordPress39.png" alt="WordPress 3.9 Featured Image" width="637" height="227" /></a><p class="wp-caption-text">photo credit: <a href="http://www.flickr.com/photos/wbaiv/6252639219/">wbaiv</a> &#8211; <a href="http://creativecommons.org/licenses/by-sa/2.0/">cc</a></p></div>
<p><a title="http://wordpress.org/news/2014/04/smith/" href="http://wordpress.org/news/2014/04/smith/">WordPress 3.9 &#8220;Smith&#8221;</a> is now available, just four months after the release of 3.8. This release continues the strategy of developing features as plugins first. <a title="http://wordpress.org/plugins/widget-customizer/" href="http://wordpress.org/plugins/widget-customizer/">Widgets Customizer</a> by <a title="http://profiles.wordpress.org/westonruter" href="http://profiles.wordpress.org/westonruter">Westonruter</a> is the only plugin that was developed and merged into WordPress this time around. Much of the work in <a title="http://codex.wordpress.org/Version_3.9" href="http://codex.wordpress.org/Version_3.9">WordPress 3.9</a> is an improvement of features added in earlier versions. Without further ado, let&#8217;s take a look at what this release has to offer.</p>
<h3>New: Create Audio/Video Playlists</h3>
<p>Building upon the addition of audio and video in WordPress 3.6, WordPress 3.9 offers a lot of enhancements. For starters, you can now create audio playlists. You can also add multiple sources to help with cross-browser compatibility. Managing multiple sources is easy thanks to an improved workflow. WordPress now has subtitle support for videos as long as you supply the appropriate files. <a title="http://html5doctor.com/video-subtitling-and-webvtt/" href="http://html5doctor.com/video-subtitling-and-webvtt/">This post by HTML5Doctor</a> explains how to create the proper files to add subtitles to videos.</p>
<div id="attachment_21126" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WP39AudioPlaylists.png" rel="prettyphoto[19881]"><img class="size-full wp-image-21126" src="http://wptavern.com/wp-content/uploads/2014/04/WP39AudioPlaylists.png" alt="Audio Playlist In The Visual Editor Of WordPress 3.9" width="911" height="464" /></a><p class="wp-caption-text">Audio Playlist In The Visual Editor Of WordPress 3.9</p></div>
<h3>Searching For WordPress Themes Has Never Been Easier</h3>
<p>The theme browsing experience in WordPress 3.8 has been significantly improved in 3.9. The new theme browser features large preview images, indicators on which themes you already have installed, and fast-loading previews. Browsing and installing new themes in WordPress has never been easier.</p>
<div id="attachment_21121" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WP39ThemeExperience.png" rel="prettyphoto[19881]"><img class="size-full wp-image-21121" src="http://wptavern.com/wp-content/uploads/2014/04/WP39ThemeExperience.png" alt="Theme Browser Experience Revamped In WordPress 3.9" width="859" height="503" /></a><p class="wp-caption-text">Theme Browser Experience Revamped In WordPress 3.9</p></div>
<h3>Crop and Edit Images From Within The Visual Editor</h3>
<p>Images are easier to edit and remove from posts. Simply click on the image within the visual editor and select the pencil icon. This will launch the image details screen. From here, you can quickly edit the details of the image and if you select the <strong>Edit Original button</strong>, you&#8217;ll be able to crop, flip, and change the image size. You can also drag and drop images right into the editor. Alternatively, you can crop and edit an image from within the visual editor.</p>
<div id="attachment_21117" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/ImageEditingWP39.png" rel="prettyphoto[19881]"><img class="size-full wp-image-21117" src="http://wptavern.com/wp-content/uploads/2014/04/ImageEditingWP39.png" alt="Image Editing In WordPress 3.9" width="818" height="488" /></a><p class="wp-caption-text">Image Editing In WordPress 3.9</p></div>
<p>Instead of seeing a placeholder, galleries can now be previewed as a grid within the visual editor. You cannot yet drag images around to change the display order, but this feature is expected to be added in a future update.</p>
<div id="attachment_21116" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/LivePreviewGalleries.png" rel="prettyphoto[19881]"><img class="size-full wp-image-21116" src="http://wptavern.com/wp-content/uploads/2014/04/LivePreviewGalleries.png" alt="Preview Galleries Live Within The Visual Editor" width="878" height="625" /></a><p class="wp-caption-text">Preview Galleries Live Within The Visual Editor</p></div>
<h3>Live Widget Previews</h3>
<p>You can now preview changes to widgets in real-time thanks to the theme customizer. Gone are the days of having to refresh the page every time you want to preview a change to a widget.</p>
<div id="attachment_21138" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WP39LiveWidgetPreview.png" rel="prettyphoto[19881]"><img class="size-full wp-image-21138" src="http://wptavern.com/wp-content/uploads/2014/04/WP39LiveWidgetPreview.png" alt="WordPress 3.9 Live Widget Previews" width="1150" height="569" /></a><p class="wp-caption-text">WordPress 3.9 Live Widget Previews</p></div>
<h3>A New Streamlined Post Editor</h3>
<p>The post editor in WordPress 3.9 has been updated to use TinyMCE 4.0. The update provides the following enhancements:</p>
<ul>
<li>New UI and UI API.</li>
<li>New theme.</li>
<li>Revamped events system/API.</li>
<li>Better code quality, readability and build process.</li>
<li>Lots of (inline) documentation.</li>
</ul>
<p>The Paste from Word button has been removed. When text from Microsoft Word is pasted into WordPress, the editor will automatically strip out the special formatting. The distraction free writing mode button is now on the right side of the editor. Distraction free writing mode <a title="http://wptavern.com/distraction-free-writing-mode-will-be-responsive-in-wordpress-3-9" href="http://wptavern.com/distraction-free-writing-mode-will-be-responsive-in-wordpress-3-9">is also responsive</a>. The changes to the editor are a noticeable improvement when compared to WordPress 3.8.</p>
<div id="attachment_21130" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/WP39TinyMCE40.png" rel="prettyphoto[19881]"><img class="size-full wp-image-21130" src="http://wptavern.com/wp-content/uploads/2014/04/WP39TinyMCE40.png" alt="TinyMCE 4.0 In WordPress 3.9" width="683" height="349" /></a><p class="wp-caption-text">TinyMCE 4.0 In WordPress 3.9</p></div>
<h3>oEmbed Support Added For Meetup and Imgur</h3>
<p>Publishing content from either Meetup.com or Imgur is now as simple as <a title="http://wptavern.com/wordpress-3-9-to-add-oembed-support-for-meetup-com-and-imgur" href="http://wptavern.com/wordpress-3-9-to-add-oembed-support-for-meetup-com-and-imgur">pasting the URL</a> into the editor. Meanwhile, oEmbed support for Qik has been removed.</p>
<div id="attachment_20405" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/oembeddedurlformeetupevent2.png" rel="prettyphoto[19881]"><img class="size-full wp-image-20405" src="http://wptavern.com/wp-content/uploads/2014/04/oembeddedurlformeetupevent2.png" alt="Meetup Group Event Embedded Into A Post" width="545" height="255" /></a><p class="wp-caption-text">Meetup Group Event Embedded Into A Post</p></div>
<h3>Take A Tour Of WordPress 3.9</h3>
<p>Michael Pick does a great job showing and explaining the new features in WordPress 3.9.<br />
</p>
<h3>Important Information For WordPress Developers</h3>
<p>There are a lot of under-the-hood improvements in WordPress 3.9. Over the past two-weeks, those responsible for adding specific features to WordPress have written detailed blog posts on the <a title="http://make.wordpress.org/core/" href="http://make.wordpress.org/core/">Make WordPress Core</a> development blog. Here is a list of noteworthy items you may have missed.</p>
<p><a title="http://make.wordpress.org/core/2014/04/15/html5-galleries-captions-in-wordpress-3-9/" href="http://make.wordpress.org/core/2014/04/15/html5-galleries-captions-in-wordpress-3-9/">HTML5 Galleries and Captions in WordPress 3.9</a> &#8211; WordPress 3.6 introduced HTML5 versions of popular template tags, starting out with comments, the comment form, and the search form. With the 3.9 release the team added galleries and captions to that list. Now, when adding HTML5 support for those features, WordPress will use <code>&lt;figure&gt;</code> and <code>&lt;figcaption&gt;</code> elements, instead of the generic definition list markup.</p>
<p><a title="http://make.wordpress.org/core/2014/04/14/symlinked-plugins-in-wordpress-3-9/" href="http://make.wordpress.org/core/2014/04/14/symlinked-plugins-in-wordpress-3-9/">Symlinked Plugins in WordPress 3.9</a> &#8211; One of the cool little features included with 3.9 is the ability to symlink plugin directories. While it has been possible to symlink plugins in the past, functions such as <code>plugins_url()</code> return the wrong URL, which causes breakage in most plugins. The team has corrected this with the help of a new function.</p>
<p><a title="http://make.wordpress.org/core/2014/04/11/plupload-2-x-in-wordpress-3-9/" href="http://make.wordpress.org/core/2014/04/11/plupload-2-x-in-wordpress-3-9/">Plupload 2.x in WordPress 3.9</a> &#8211; Plupload is the library that powers most of the file upload interfaces in WordPress, and in 3.9 the team has updated the bundled library to version 2.1.1. This post lists some of the things that have changed, which may affect WordPress plugins and themes.</p>
<p><a title="http://make.wordpress.org/core/2014/04/07/mysql-in-wordpress-3-9/" href="http://make.wordpress.org/core/2014/04/07/mysql-in-wordpress-3-9/">MySQL in WordPress 3.9</a> &#8211; In WordPress 3.9, we added an extra layer to WPDB, causing it to switch to using the mysqli PHP library, when using PHP 5.5 or higher. For plugin developers, this means that you absolutely shouldn’t be using PHP’s mysql_*() functions any more – you can use the equivalent WPDB functions instead.</p>
<p><a title="http://make.wordpress.org/core/2014/03/27/masonry-in-wordpress-3-9/" href="http://make.wordpress.org/core/2014/03/27/masonry-in-wordpress-3-9/">Masonry in WordPress 3.9</a> &#8211; If you use Masonry in your themes or plugins, here’s what you should know about the 3.9 update.</p>
<p><a title="http://make.wordpress.org/core/2014/03/27/tinymce-4-0-requires-textcss-for-editor-style-files/" href="http://make.wordpress.org/core/2014/03/27/tinymce-4-0-requires-textcss-for-editor-style-files/">TinyMCE 4.0 Requires text/css For Editor Style Files</a> &#8211; As of TinyMCE 4.0, the visual editor iframe now has an HTML5 document type (<code><!--<span class="hiddenSpellError" pre=""-->DOCTYPE html&gt;</code>). In this scenario, CSS files must be served with the <code>text/css</code> content type. A server will serve a <code>*.css</code> file with the proper content type, but if you’re using a PHP file for an editor style file, you need to be the one to do it.</p>
<p><a title="http://make.wordpress.org/core/2014/04/16/multisite-changes-in-3-9/" href="http://make.wordpress.org/core/2014/04/16/multisite-changes-in-3-9/">Multisite Changes In 3.9</a> &#8211; Much of the bootstrap code for Multisite in ms-settings.php has been refactored in<a href="http://core.trac.wordpress.org/ticket/27003"> #27003</a> with the intent to improve how we handle the detection of domains and paths for sites and networks in core. Several other smaller enhancements and bugs have been completed in this and in other tickets.</p>
<p><a title="http://make.wordpress.org/core/2014/04/16/jquery-ui-and-wpdialogs-in-wordpress-3-9/" href="http://make.wordpress.org/core/2014/04/16/jquery-ui-and-wpdialogs-in-wordpress-3-9/">jQuery UI and wpdialogs in WordPress 3.9</a> &#8211; WordPress 3.9 does not use the “wpdialogs” TinyMCE plugin as part of the TinyMCE 4.0 update which comes with a new dialog manager.</p>
<h3>Thanks To Everyone Who Contributed To 3.9</h3>
<p>Although 3.9 doesn&#8217;t have a lot of <strong>new</strong> features, the refinements to existing functionality are just as satisfying. I&#8217;m happy to see a release where the focus was more on improving what WordPress already has versus adding new functionality. Even though the live previews of widgets is my favorite feature, several of the pesky bugs that were squashed are a close second.</p>
<p>WordPress wouldn&#8217;t be what it is today without all of the awesome contributions from the community. Thanks to everyone who helped make 3.9 a reality! This release was led by <a href="http://nacin.com/">Andrew Nacin</a> and <a href="http://www.getsource.net/">Mike Schroder. </a>There are 267 contributors with props in this release, which is a new high for WordPress.</p>
<p><strong>What is your favorite feature or enhancement in WordPress 3.9?</strong></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 16 Apr 2014 18:34:59 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:31;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:35:"Dev Blog: WordPress 3.9 “Smith”";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3154";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:40:"http://wordpress.org/news/2014/04/smith/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:22531:"<p>Version 3.9 of WordPress, named &#8220;Smith&#8221; in honor of jazz organist <a href="http://en.wikipedia.org/wiki/Jimmy_Smith_(musician)">Jimmy Smith</a>, is available <a href="http://wordpress.org/download/">for download</a> or update in your WordPress dashboard. This release features a number of refinements that we hope you&#8217;ll love.</p>

<h2 class="about-headline-callout">A smoother media editing experience</h2>
<div>
<p><img class="alignright wp-image-3168" src="http://wordpress.org/news/files/2014/04/editor1-300x233.jpg" alt="editor" width="228" height="177" /></p>
<h3>Improved visual editing</h3>
<p>The updated visual editor has improved speed, accessibility, and mobile support. You can paste into the visual editor from your word processor without wasting time to clean up messy styling. (Yeah, we’re talking about you, Microsoft Word.)</p>
</div>
<div></div>
<div>
<p><img class="alignright wp-image-3170" src="http://wordpress.org/news/files/2014/04/image1-300x233.jpg" alt="image" width="228" height="178" /></p>
<h3>Edit images easily</h3>
<p>With quicker access to crop and rotation tools, it’s now much easier to edit your images while editing posts. You can also scale images directly in the editor to find just the right fit.</p>
</div>
<div></div>
<div>
<p><img class="alignright wp-image-3187" src="http://wordpress.org/news/files/2014/04/dragdrop1-300x233.jpg" alt="dragdrop" width="228" height="178" /></p>
<h3>Drag and drop your images</h3>
<p>Uploading your images is easier than ever. Just grab them from your desktop and drop them in the editor.</p>
</div>
<div></div>
<hr />
<h2>Gallery previews</h2>
<p><img class="aligncenter size-full wp-image-3169" src="http://wordpress.org/news/files/2014/04/gallery1.jpg" alt="gallery" width="980" height="550" /></p>
<p>Galleries display a beautiful grid of images right in the editor, just like they do in your published post.</p>
<hr />
<h2>Do more with audio and video</h2>

<a href="http://wordpress.org/news/files/2014/04/AintMisbehavin.mp3">Ain\'t Misbehavin\'</a>
<a href="http://wordpress.org/news/files/2014/04/DavenportBlues.mp3">Davenport Blues</a>
<a href="http://wordpress.org/news/files/2014/04/JellyRollMorton-BuddyBoldensBlues.mp3">Buddy Bolden\'s Blues</a>
<a href="http://wordpress.org/news/files/2014/04/Johnny_Hodges_Orchestra-Squaty_Roo-1941.mp3">Squaty Roo</a>
<a href="http://wordpress.org/news/files/2014/04/Louisiana_Five-Dixie_Blues-1919.mp3">Dixie Blues</a>
<a href="http://wordpress.org/news/files/2014/04/WolverineBlues.mp3">Wolverine Blues</a>

<p>Images have galleries; now we’ve added simple audio and video playlists, so you can showcase your music and clips.</p>
<hr />
<h2>Live widget and header previews</h2>
<div class="wp-video"><!--[if lt IE 9]><script>document.createElement(\'video\');</script><![endif]-->
<a href="http://wordpress.org/news/files/2014/04/widgets.mp4">//wordpress.org/news/files/2014/04/widgets.mp4</a></div>
<p>Add, edit, and rearrange your site’s widgets right in the theme customizer. No “save and surprise” — preview your changes live and only save them when you’re ready.</p>
<p>The improved header image tool also lets you upload, crop, and manage headers while customizing your theme.</p>
<hr />
<h2>Stunning new theme browser</h2>
<p><img class="aligncenter size-full wp-image-3172" src="http://wordpress.org/news/files/2014/04/theme1.jpg" alt="theme" width="1003" height="558" /><br />
Looking for a new theme should be easy and fun. Lose yourself in the boundless supply of free WordPress.org themes with the beautiful new theme browser.</p>
<hr />
<h2>The Crew</h2>
<p>This release was led by <a href="http://nacin.com/">Andrew Nacin</a> and <a href="http://www.getsource.net/">Mike Schroder</a>, with the help of these fine individuals. There are 267 contributors with props in this release, a new high:</p>
<p><a href="http://profiles.wordpress.org/aaroncampbell">Aaron D. Campbell</a>, <a href="http://profiles.wordpress.org/jorbin">Aaron Jorbin</a>, <a href="http://profiles.wordpress.org/kawauso">Adam Harley</a>, <a href="http://profiles.wordpress.org/adamsilverstein">Adam Silverstein</a>, <a href="http://profiles.wordpress.org/adelval">adelval</a>, <a href="http://profiles.wordpress.org/ajay">Ajay</a>, <a href="http://profiles.wordpress.org/akeda">Akeda Bagus</a>, <a href="http://profiles.wordpress.org/xknown">Alex Concha</a>, <a href="http://profiles.wordpress.org/aliso">Alison Barrett</a>, <a href="http://profiles.wordpress.org/collinsinternet">Allan Collins</a>, <a href="http://profiles.wordpress.org/sabreuse">Amy Hendrix (sabreuse)</a>, <a href="http://profiles.wordpress.org/afercia">Andrea Fercia</a>, <a href="http://profiles.wordpress.org/nacin">Andrew Nacin</a>, <a href="http://profiles.wordpress.org/norcross">Andrew Norcross</a>, <a href="http://profiles.wordpress.org/azaozz">Andrew Ozz</a>, <a href="http://profiles.wordpress.org/rarst">Andrey "Rarst" Savchenko</a>, <a href="http://profiles.wordpress.org/andykeith">Andy Keith</a>, <a href="http://profiles.wordpress.org/andy">Andy Skelton</a>, <a href="http://profiles.wordpress.org/atimmer">Anton Timmermans</a>, <a href="http://profiles.wordpress.org/aubreypwd">Aubrey Portwood</a>, <a href="http://profiles.wordpress.org/barry">Barry</a>, <a href="http://profiles.wordpress.org/toszcze">Bartosz Romanowski</a>, <a href="http://profiles.wordpress.org/bassgang">bassgang</a>, <a href="http://profiles.wordpress.org/bcworkz">bcworkz</a>, <a href="http://profiles.wordpress.org/empireoflight">Ben Dunkle</a>, <a href="http://profiles.wordpress.org/neoxx">Bernhard Riedl</a>, <a href="http://profiles.wordpress.org/bigdawggi">bigdawggi</a>, <a href="http://profiles.wordpress.org/bobbravo2">Bob Gregor</a>, <a href="http://profiles.wordpress.org/bobbingwide">bobbingwide</a>, <a href="http://profiles.wordpress.org/bradt">Brad Touesnard</a>, <a href="http://profiles.wordpress.org/bradparbs">bradparbs</a>, <a href="http://profiles.wordpress.org/bramd">bramd</a>, <a href="http://profiles.wordpress.org/kraftbj">Brandon Kraft</a>, <a href="http://profiles.wordpress.org/brasofilo">brasofilo</a>, <a href="http://profiles.wordpress.org/bravokeyl">bravokeyl</a>, <a href="http://profiles.wordpress.org/bpetty">Bryan Petty</a>, <a href="http://profiles.wordpress.org/cgaffga">cgaffga</a>, <a href="http://profiles.wordpress.org/chiragswadia">Chirag Swadia</a>, <a href="http://profiles.wordpress.org/chouby">Chouby</a>, <a href="http://profiles.wordpress.org/ehg">Chris Blower</a>, <a href="http://profiles.wordpress.org/c3mdigital">Chris Olbekson</a>, <a href="http://profiles.wordpress.org/chrisscott">Chris Scott</a>, <a href="http://profiles.wordpress.org/chriseverson">chriseverson</a>, <a href="http://profiles.wordpress.org/chrisguitarguy">chrisguitarguy</a>, <a href="http://profiles.wordpress.org/cfinke">Christopher Finke</a>, <a href="http://profiles.wordpress.org/ciantic">ciantic</a>, <a href="http://profiles.wordpress.org/cmmarslender">cmmarslender</a>, <a href="http://profiles.wordpress.org/antorome">Comparativa de Bancos</a>, <a href="http://profiles.wordpress.org/cojennin">Connor Jennings</a>, <a href="http://profiles.wordpress.org/corvannoorloos">Cor van Noorloos</a>, <a href="http://profiles.wordpress.org/corphi">Corphi</a>, <a href="http://profiles.wordpress.org/cramdesign">cramdesign</a>, <a href="http://profiles.wordpress.org/danielbachhuber">Daniel Bachhuber</a>, <a href="http://profiles.wordpress.org/redsweater">Daniel Jalkut (Red Sweater)</a>, <a href="http://profiles.wordpress.org/dannydehaan">Danny de Haan</a>, <a href="http://profiles.wordpress.org/koop">Daryl Koopersmith</a>, <a href="http://profiles.wordpress.org/eightface">Dave Kellam (eightface)</a>, <a href="http://profiles.wordpress.org/dpe415">DaveE</a>, <a href="http://profiles.wordpress.org/davidakennedy">David A. Kennedy</a>, <a href="http://profiles.wordpress.org/davidanderson">David Anderson</a>, <a href="http://profiles.wordpress.org/davidmarichal">David Marichal</a>, <a href="http://profiles.wordpress.org/denis-de-bernardy">Denis de Bernardy</a>, <a href="http://profiles.wordpress.org/dd32">Dion Hulse</a>, <a href="http://profiles.wordpress.org/ocean90">Dominik Schilling</a>, <a href="http://profiles.wordpress.org/dougwollison">Doug Wollison</a>, <a href="http://profiles.wordpress.org/drewapicture">Drew Jaynes</a>, <a href="http://profiles.wordpress.org/drprotocols">DrProtocols</a>, <a href="http://profiles.wordpress.org/dustyf">Dustin Filippini</a>, <a href="http://profiles.wordpress.org/eatingrules">eatingrules</a>, <a href="http://profiles.wordpress.org/plocha">edik</a>, <a href="http://profiles.wordpress.org/eliorivero">Elio Rivero</a>, <a href="http://profiles.wordpress.org/enej">enej</a>, <a href="http://profiles.wordpress.org/ericlewis">Eric Andrew Lewis</a>, <a href="http://profiles.wordpress.org/ericmann">Eric Mann</a>, <a href="http://profiles.wordpress.org/evarlese">Erica Varlese</a>, <a href="http://profiles.wordpress.org/ethitter">Erick Hitter</a>, <a href="http://profiles.wordpress.org/ejdanderson">Evan Anderson</a>, <a href="http://profiles.wordpress.org/fahmiadib">Fahmi</a>, <a href="http://profiles.wordpress.org/fboender">fboender</a>, <a href="http://profiles.wordpress.org/frank-klein">Frank Klein</a>, <a href="http://profiles.wordpress.org/garyc40">Gary Cao</a>, <a href="http://profiles.wordpress.org/garyj">Gary Jones</a>, <a href="http://profiles.wordpress.org/pento">Gary Pendergast</a>, <a href="http://profiles.wordpress.org/genkisan">genkisan</a>, <a href="http://profiles.wordpress.org/soulseekah">Gennady Kovshenin</a>, <a href="http://profiles.wordpress.org/georgestephanis">George Stephanis</a>, <a href="http://profiles.wordpress.org/grahamarmfield">Graham Armfield</a>, <a href="http://profiles.wordpress.org/vancoder">Grant Mangham</a>, <a href="http://profiles.wordpress.org/gcorne">Gregory Cornelius</a>, <a href="http://profiles.wordpress.org/tivnet">Gregory Karpinsky</a>, <a href="http://profiles.wordpress.org/hakre">hakre</a>, <a href="http://profiles.wordpress.org/hanni">hanni</a>, <a href="http://profiles.wordpress.org/helen">Helen Hou-Sandí</a>, <a href="http://profiles.wordpress.org/ippetkov">ippetkov</a>, <a href="http://profiles.wordpress.org/ipstenu">Ipstenu (Mika Epstein)</a>, <a href="http://profiles.wordpress.org/jdgrimes">J.D. Grimes</a>, <a href="http://profiles.wordpress.org/jackreichert">Jack Reichert</a>, <a href="http://profiles.wordpress.org/_jameslee">jameslee</a>, <a href="http://profiles.wordpress.org/avryl">Janneke Van Dorpe</a>, <a href="http://profiles.wordpress.org/janrenn">janrenn</a>, <a href="http://profiles.wordpress.org/jaycc">JayCC</a>, <a href="http://profiles.wordpress.org/jeffsebring">Jeff Sebring</a>, <a href="http://profiles.wordpress.org/jenmylo">Jen Mylo</a>, <a href="http://profiles.wordpress.org/jeremyfelt">Jeremy Felt</a>, <a href="http://profiles.wordpress.org/jesin">Jesin A</a>, <a href="http://profiles.wordpress.org/jayjdk">Jesper Johansen (jayjdk)</a>, <a href="http://profiles.wordpress.org/jnielsendotnet">jnielsendotnet</a>, <a href="http://profiles.wordpress.org/jartes">Joan Artes</a>, <a href="http://profiles.wordpress.org/joedolson">Joe Dolson</a>, <a href="http://profiles.wordpress.org/joehoyle">Joe Hoyle</a>, <a href="http://profiles.wordpress.org/johnbillion">John Blackbourn</a>, <a href="http://profiles.wordpress.org/johnjamesjacoby">John James Jacoby</a>, <a href="http://profiles.wordpress.org/johnpbloch">John P. Bloch</a>, <a href="http://profiles.wordpress.org/johnregan3">John Regan</a>, <a href="http://profiles.wordpress.org/duck_">Jon Cave</a>, <a href="http://profiles.wordpress.org/jond3r">Jonas Bolinder (jond3r)</a>, <a href="http://profiles.wordpress.org/joostdevalk">Joost de Valk</a>, <a href="http://profiles.wordpress.org/shelob9">Josh Pollock</a>, <a href="http://profiles.wordpress.org/joshuaabenazer">Joshua Abenazer</a>, <a href="http://profiles.wordpress.org/jstraitiff">jstraitiff</a>, <a href="http://profiles.wordpress.org/juliobox">Julio Potier</a>, <a href="http://profiles.wordpress.org/kopepasah">Justin Kopepasah</a>, <a href="http://profiles.wordpress.org/justinsainton">Justin Sainton</a>, <a href="http://profiles.wordpress.org/kadamwhite">K.Adam White</a>, <a href="http://profiles.wordpress.org/trepmal">Kailey (trepmal)</a>, <a href="http://profiles.wordpress.org/kasparsd">Kaspars</a>, <a href="http://profiles.wordpress.org/ryelle">Kelly Dwan</a>, <a href="http://profiles.wordpress.org/kerikae">kerikae</a>, <a href="http://profiles.wordpress.org/kworthington">Kevin Worthington</a>, <a href="http://profiles.wordpress.org/kpdesign">Kim Parsell</a>, <a href="http://profiles.wordpress.org/kwight">Kirk Wight</a>, <a href="http://profiles.wordpress.org/kitchin">kitchin</a>, <a href="http://profiles.wordpress.org/klihelp">klihelp</a>, <a href="http://profiles.wordpress.org/knutsp">Knut Sparhell</a>, <a href="http://profiles.wordpress.org/kovshenin">Konstantin Kovshenin</a>, <a href="http://profiles.wordpress.org/obenland">Konstantin Obenland</a>, <a href="http://profiles.wordpress.org/drozdz">Krzysiek Drozdz</a>, <a href="http://profiles.wordpress.org/lancewillett">Lance Willett</a>, <a href="http://profiles.wordpress.org/leewillis77">Lee Willis</a>, <a href="http://profiles.wordpress.org/lkwdwrd">lkwdwrd</a>, <a href="http://profiles.wordpress.org/lpointet">lpointet</a>, <a href="http://profiles.wordpress.org/ldebrouwer">Luc De Brouwer</a>, <a href="http://profiles.wordpress.org/spmlucas">Lucas Karpiuk</a>, <a href="http://profiles.wordpress.org/mark8barnes">Mark Barnes</a>, <a href="http://profiles.wordpress.org/markjaquith">Mark Jaquith</a>, <a href="http://profiles.wordpress.org/markoheijnen">Marko Heijnen</a>, <a href="http://profiles.wordpress.org/marventus">Marventus</a>, <a href="http://profiles.wordpress.org/iammattthomas">Matt (Thomas) Miklic</a>, <a href="http://profiles.wordpress.org/mjbanks">Matt Banks</a>, <a href="http://profiles.wordpress.org/matt">Matt Mullenweg</a>, <a href="http://profiles.wordpress.org/mboynes">Matthew Boynes</a>, <a href="http://profiles.wordpress.org/mdbitz">Matthew Denton</a>, <a href="http://profiles.wordpress.org/mattheu">Matthew Haines-Young</a>, <a href="http://profiles.wordpress.org/mattonomics">mattonomics</a>, <a href="http://profiles.wordpress.org/mattyrob">mattyrob</a>, <a href="http://profiles.wordpress.org/matveb">Matías Ventura</a>, <a href="http://profiles.wordpress.org/maxcutler">Max Cutler</a>, <a href="http://profiles.wordpress.org/mcadwell">mcadwell</a>, <a href="http://profiles.wordpress.org/melchoyce">Mel Choyce</a>, <a href="http://profiles.wordpress.org/meloniq">meloniq</a>, <a href="http://profiles.wordpress.org/michael-arestad">Michael Arestad</a>, <a href="http://profiles.wordpress.org/michelwppi">Michel - xiligroup dev</a>, <a href="http://profiles.wordpress.org/mcsf">Miguel Fonseca</a>, <a href="http://profiles.wordpress.org/gradyetc">Mike Burns</a>, <a href="http://profiles.wordpress.org/mikehansenme">Mike Hansen</a>, <a href="http://profiles.wordpress.org/mikemanger">Mike Manger</a>, <a href="http://profiles.wordpress.org/mikeschinkel">Mike Schinkel</a>, <a href="http://profiles.wordpress.org/dh-shredder">Mike Schroder</a>, <a href="http://profiles.wordpress.org/mikecorkum">mikecorkum</a>, <a href="http://profiles.wordpress.org/mitchoyoshitaka">mitcho (Michael Yoshitaka Erlewine)</a>, <a href="http://profiles.wordpress.org/batmoo">Mohammad Jangda</a>, <a href="http://profiles.wordpress.org/morganestes">Morgan Estes</a>, <a href="http://profiles.wordpress.org/mor10">Morten Rand-Hendriksen</a>, <a href="http://profiles.wordpress.org/Nao">Naoko Takano</a>, <a href="http://profiles.wordpress.org/alex-ye">Nashwan Doaqan</a>, <a href="http://profiles.wordpress.org/nendeb55">nendeb55</a>, <a href="http://profiles.wordpress.org/celloexpressions">Nick Halsey</a>, <a href="http://profiles.wordpress.org/nicolealleyinteractivecom">Nicole Arnold</a>, <a href="http://profiles.wordpress.org/nikv">Nikhil Vimal (NikV)</a>, <a href="http://profiles.wordpress.org/nivijah">nivijah</a>, <a href="http://profiles.wordpress.org/nofearinc">nofearinc</a>, <a href="http://profiles.wordpress.org/nunomorgadinho">Nuno Morgadinho</a>, <a href="http://profiles.wordpress.org/olivm">olivM</a>, <a href="http://profiles.wordpress.org/jbkkd">Omer Korner</a>, <a href="http://profiles.wordpress.org/originalexe">OriginalEXE</a>, <a href="http://profiles.wordpress.org/oso96_2000">oso96_2000</a>, <a href="http://profiles.wordpress.org/patricknami">patricknami</a>, <a href="http://profiles.wordpress.org/djpaul">Paul Gibbs</a>, <a href="http://profiles.wordpress.org/paulwilde">Paul Wilde</a>, <a href="http://profiles.wordpress.org/pavelevap">pavelevap</a>, <a href="http://profiles.wordpress.org/pbearne">Pbearne</a>, <a href="http://profiles.wordpress.org/westi">Peter Westwood</a>, <a href="http://profiles.wordpress.org/philiparthurmoore">Philip Arthur Moore</a>, <a href="http://profiles.wordpress.org/mordauk">Pippin Williamson</a>, <a href="http://profiles.wordpress.org/nprasath002">Prasath Nadarajah</a>, <a href="http://profiles.wordpress.org/prettyboymp">prettyboymp</a>, <a href="http://profiles.wordpress.org/raamdev">Raam Dev</a>, <a href="http://profiles.wordpress.org/rachelbaker">rachelbaker</a>, <a href="http://profiles.wordpress.org/mauryaratan">Ram Ratan Maurya</a>, <a href="http://profiles.wordpress.org/ramonchiara">ramonchiara</a>, <a href="http://profiles.wordpress.org/ounziw">Rescuework Support</a>, <a href="http://profiles.wordpress.org/rhyswynne">Rhys Wynne</a>, <a href="http://profiles.wordpress.org/ricardocorreia">Ricardo Correia</a>, <a href="http://profiles.wordpress.org/theorboman">Richard Sweeney</a>, <a href="http://profiles.wordpress.org/iamfriendly">Richard Tape</a>, <a href="http://profiles.wordpress.org/richard2222">richard2222</a>, <a href="http://profiles.wordpress.org/rickalee">Ricky Lee Whittemore</a>, <a href="http://profiles.wordpress.org/miqrogroove">Robert Chapin</a>, <a href="http://profiles.wordpress.org/robmiller">robmiller</a>, <a href="http://profiles.wordpress.org/rodrigosprimo">Rodrigo Primo</a>, <a href="http://profiles.wordpress.org/romaimperator">romaimperator</a>, <a href="http://profiles.wordpress.org/roothorick">roothorick</a>, <a href="http://profiles.wordpress.org/ruudjoyo">ruud@joyo</a>, <a href="http://profiles.wordpress.org/ryan">Ryan Boren</a>, <a href="http://profiles.wordpress.org/rmccue">Ryan McCue</a>, <a href="http://profiles.wordpress.org/salcode">salcode</a>, <a href="http://profiles.wordpress.org/otto42">Samuel Wood (Otto)</a>, <a href="http://profiles.wordpress.org/sandyr">Sandeep</a>, <a href="http://profiles.wordpress.org/scottlee">Scott Lee</a>, <a href="http://profiles.wordpress.org/coffee2code">Scott Reilly</a>, <a href="http://profiles.wordpress.org/wonderboymusic">Scott Taylor</a>, <a href="http://profiles.wordpress.org/greglone">ScreenfeedFr</a>, <a href="http://profiles.wordpress.org/scribu">scribu</a>, <a href="http://profiles.wordpress.org/sdasse">sdasse</a>, <a href="http://profiles.wordpress.org/bootsz">Sean Butze</a>, <a href="http://profiles.wordpress.org/seanchayes">Sean Hayes</a>, <a href="http://profiles.wordpress.org/nessworthy">Sean Nessworthy</a>, <a href="http://profiles.wordpress.org/sergeybiryukov">Sergey Biryukov</a>, <a href="http://profiles.wordpress.org/shahpranaf">shahpranaf</a>, <a href="http://profiles.wordpress.org/shaunandrews">Shaun Andrews</a>, <a href="http://profiles.wordpress.org/shinichin">ShinichiN</a>, <a href="http://profiles.wordpress.org/pross">Simon Prosser</a>, <a href="http://profiles.wordpress.org/simonwheatley">Simon Wheatley</a>, <a href="http://profiles.wordpress.org/siobhan">Siobhan</a>, <a href="http://profiles.wordpress.org/siobhyb">Siobhan Bamber (siobhyb)</a>, <a href="http://profiles.wordpress.org/sirzooro">sirzooro</a>, <a href="http://profiles.wordpress.org/solarissmoke">solarissmoke</a>, <a href="http://profiles.wordpress.org/sonjanyc">sonjanyc</a>, <a href="http://profiles.wordpress.org/spencerfinnell">Spencer Finnell</a>, <a href="http://profiles.wordpress.org/piontkowski">Spencer Piontkowski</a>, <a href="http://profiles.wordpress.org/stephcook22">stephcook22</a>, <a href="http://profiles.wordpress.org/netweb">Stephen Edgar</a>, <a href="http://profiles.wordpress.org/stephenharris">Stephen Harris</a>, <a href="http://profiles.wordpress.org/sbruner">Steve Bruner</a>, <a href="http://profiles.wordpress.org/stevenkword">Steven Word</a>, <a href="http://profiles.wordpress.org/miyauchi">Takayuki Miyauchi</a>, <a href="http://profiles.wordpress.org/tanner-m">Tanner Moushey</a>, <a href="http://profiles.wordpress.org/tlovett1">Taylor Lovett</a>, <a href="http://profiles.wordpress.org/tbrams">tbrams</a>, <a href="http://profiles.wordpress.org/tellyworth">tellyworth</a>, <a href="http://profiles.wordpress.org/tobiasbg">TobiasBg</a>, <a href="http://profiles.wordpress.org/tomauger">Tom Auger</a>, <a href="http://profiles.wordpress.org/willmot">Tom Willmot</a>, <a href="http://profiles.wordpress.org/topher1kenobe">Topher</a>, <a href="http://profiles.wordpress.org/topquarky">topquarky</a>, <a href="http://profiles.wordpress.org/zodiac1978">Torsten Landsiedel</a>, <a href="http://profiles.wordpress.org/toru">Toru</a>, <a href="http://profiles.wordpress.org/wpsmith">Travis Smith</a>, <a href="http://profiles.wordpress.org/umeshsingla">Umesh Kumar</a>, <a href="http://profiles.wordpress.org/undergroundnetwork">undergroundnetwork</a>, <a href="http://profiles.wordpress.org/varunagw">VarunAgw</a>, <a href="http://profiles.wordpress.org/wawco">wawco</a>, <a href="http://profiles.wordpress.org/westonruter">Weston Ruter</a>, <a href="http://profiles.wordpress.org/wokamoto">wokamoto</a>, <a href="http://profiles.wordpress.org/xsonic">xsonic</a>, <a href="http://profiles.wordpress.org/yoavf">Yoav Farhi</a>, <a href="http://profiles.wordpress.org/yurivictor">Yuri Victor</a>, <a href="http://profiles.wordpress.org/zbtirrell">Zach Tirrell</a>, and <a href="http://profiles.wordpress.org/vanillalounge">Ze Fontainhas</a>. Also thanks to <a href="http://michaelpick.wordpress.com/">Michael Pick</a> for producing the release video.</p>
<p>If you want to follow along or help out, check out <a href="http://make.wordpress.org/">Make WordPress</a> and our <a href="http://make.wordpress.org/core/">core development blog</a>. Thanks for choosing WordPress. See you soon for version 4.0!</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 16 Apr 2014 18:33:44 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Matt Mullenweg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:32;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:92:"WPTavern: BuddyPress 2.0 Released: Big Performance Improvements and New Administration Tools";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21201";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:226:"http://wptavern.com/buddypress-2-0-released-big-performance-improvements-and-new-administration-tools?utm_source=rss&utm_medium=rss&utm_campaign=buddypress-2-0-released-big-performance-improvements-and-new-administration-tools";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4710:"<p>BuddyPress 2.0 &#8220;<a href="http://buddypress.org/2014/04/buddypress-2-0-juliana/" target="_blank">Juliana</a>&#8221; arrived on schedule today, less than a week after the plugin crossed <a href="http://wptavern.com/major-milestone-for-buddypress-2-million-downloads-and-counting" target="_blank">two million downloads</a>. This release focused heavily on improving BuddyPress performance, adding new administrative tools and enhancing the activity stream. It&#8217;s named for <a href="http://julianaspizza.com/" target="_blank">Juliana’s Pizza</a> in Brooklyn, NY, a pizza joint that is special to members of the core development team.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/buddypress20.png" rel="prettyphoto[21201]"><img src="http://wptavern.com/wp-content/uploads/2014/04/buddypress20.png" alt="buddypress20" width="1555" height="1305" class="aligncenter size-full wp-image-21202" /></a></p>
<h3>Performance Improvements</h3>
<p>One of the major highlights of this release is the <a href="http://wptavern.com/ http://wptavern.com/buddypress-2-0-ramps-up-performance-reduces-footprint-by-up-to-75" target="_blank">massive improvement in performance</a>, especially as it relates to Members and Activity directories. BuddyPress 2.0 improves MySQL efficiency, decreasing queries by up to 75% and reducing query time by up to 71%, depending on the your site&#8217;s hosting environment. If your site uses advanced caching systems, such as APC and Memcached, expect a performance increase here, as 2.0 completely overhauls how these are utilized.</p>
<h3>New BuddyPress Administration Tools</h3>
<p>BuddyPress 2.0 introduces a host of new administration tools that make it easier to manage communities. Administrators can now <a href="http://wptavern.com/buddypress-2-0-to-add-profile-editing-in-the-wordpress-admin" target="_blank">edit member profiles</a> in the WordPress admin. This release also ships with a new <a href="http://wptavern.com/buddypress-2-0-to-add-signups-administration-screen" target="_blank">signups administration screen</a> that allows administrators to track the status of pending accounts and facilitate the signup process.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/03/signups-featured.jpg" rel="prettyphoto[21201]"><img src="http://wptavern.com/wp-content/uploads/2014/03/signups-featured.jpg" alt="signups-featured" width="800" height="438" class="aligncenter size-full wp-image-19429" /></a></p>
<p>Community managers will be pleased to know that version 2.0 provides <a href="http://wptavern.com/buddypress-2-0-to-add-better-spam-management-capabilities-for-administrators" target="_blank">better spam management capabilities</a> with the ability to mark users as ham/spam within the admin users panel, a feature that was previously only available on multisite installations.</p>
<p>Version 2.0 includes a handy new &#8220;Repair Tools&#8221; menu at Dashboard > Tools > BuddyPress. This menu makes it easy to correct data that can sometimes get out of sync on BuddyPress sites.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/buddypress-tools.jpg" rel="prettyphoto[21201]"><img src="http://wptavern.com/wp-content/uploads/2014/04/buddypress-tools.jpg" alt="buddypress-tools" width="750" height="516" class="aligncenter size-full wp-image-21219" /></a></p>
<h3>Improved Activity Stream</h3>
<p>The activity stream has received a few enhancements in 2.0. It will now automatically let you know when new items are ready to be loaded. It&#8217;s also much better integrated with blog posts. Comments are synced across blog-related activity items and the actual post itself. This unifies conversations that take place in different areas on a BP site.</p>
<p>The activity stream will also play better with translations. Given that roughly half of BuddyPress installs are in a language other than English, this is a nice update. Check out this demo video created by <a href="https://twitter.com/BoweFrankema/status/455055453706526721" target="_blank">Bowe Frankema</a> to see how that works.</p>
<p></p>
<p></p>
<p>Improvements in BuddyPress 2.0 help the social features to really shine and make community management more efficient for administrators. The plugin has come a long way since <a href="http://buddypress.org/2009/04/buddypress-10-has-arrived/" target="_blank">version 1.0</a> was released almost five years ago. The BuddyPress community has grown and thanks to the work of 42 volunteer contributors, 2.0 is ready for download today. Check out the full <a href="http://codex.buddypress.org/developer/releases/version-2-0/" target="_blank">2.0 changelog</a> to see everything that&#8217;s new and improved.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 16 Apr 2014 15:53:29 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:33;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:40:"BuddyPress: BuddyPress 2.0 “Juliana”";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://buddypress.org/?p=181333";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:53:"http://buddypress.org/2014/04/buddypress-2-0-juliana/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:10225:"<p>The BuddyPress team is thrilled to announce that BuddyPress 2.0 &#8220;Juliana&#8221; is now available!</p>
<p>This release focuses on administrative tools, performance, and improvements to the activity stream. Let&#8217;s take a look at some of the highlights.</p>
<div></div>
<h4>New Administrative Tools</h4>
<p>If you manage a BuddyPress-powered community, BuddyPress 2.0 is for you. We have built a number of new tools that simplify and centralize common administrative tasks:</p>
<ul>
<li><em>Profile editing</em> &#8211; Need to manage a user&#8217;s profile information? We&#8217;ve integrated a new &#8220;Extended Profile&#8221; tab into the Dashboard &gt; Users interface, where you can manage profile data, avatars, user status, and more.<br /><a href="http://buddypress.org/wp-content/uploads/1/2014/04/admin-xprofile.jpg"><img src="http://buddypress.org/wp-content/uploads/1/2014/04/admin-xprofile-300x206.jpg" alt="admin-xprofile" width="300" height="206" class="alignleft size-medium wp-image-181344" /></a>
  </li>
<li><em>Spam User Management</em> &#8211; WordPress Multisite has long had the ability to manage spam users from the Dashboard. We&#8217;ve brought the same capabilities to non-Multisite installations. <br />
<a href="http://buddypress.org/wp-content/uploads/1/2014/04/user-mark-spam.jpg"><img src="http://buddypress.org/wp-content/uploads/1/2014/04/user-mark-spam-300x206.jpg" alt="user-mark-spam" class="size-thumbnail wp-image-181342" /></a>
  </li>
<div> </div>
<li><em>Pending Users</em> &#8211; The Pending users tab in Dashboard &gt; Users lets you see a list of signups that have not yet been activated. You can also perform useful tasks like manual account activation and resending activation emails. <br /><a href="http://buddypress.org/wp-content/uploads/1/2014/04/users-pending.jpg"><img src="http://buddypress.org/wp-content/uploads/1/2014/04/users-pending-300x206.jpg" alt="users-pending" class="size-thumbnail wp-image-181343" /></a>
  </li>
<li><em>Repair Tools</em> &#8211; Occasionally, BP friend counts and other data can get out of sync. The new Tools screen lets admins manually reset these values. <br /><a href="http://buddypress.org/wp-content/uploads/1/2014/04/tools-buddypress.jpg"><img src="http://buddypress.org/wp-content/uploads/1/2014/04/tools-buddypress-300x206.jpg" alt="tools-buddypress" class="size-thumbnail wp-image-181341" /></a>
  </li>
</ul>
<div></div>
<h4>Performance Improvements</h4>
<p>The most successful BuddyPress sites are highly dynamic, with a steady stream of new visitors and new content. This dynamic nature means that BuddyPress is a highly database-driven platform, and database performance is often a bottleneck when it comes to scaling BP sites. BuddyPress 2.0 tackles this problem head-on. We&#8217;ve streamlined some of the most common problematic queries &#8211; such as those in the Members and Activity directories &#8211; to shave up to 95% of the query time off of certain individual queries. The sheer number of queries has been dramatically reduced as well, so that single page views access the database up to 50% less than in BP 1.9. And we&#8217;ve totally overhauled the way that BuddyPress utilizes advanced caching systems like APC and Memcached, so that users of these systems will see up to 75% fewer cache misses on costly queries.</p>
<p>If you&#8217;re a BuddyPress developer or site administrator, you can get more in-depth explanation of changes and an overview of selected benchmarks <a href="http://bpdevel.wordpress.com/2014/04/02/one-of-the-primary-focuses/">in this post on bpdevel.wordpress.com</a>. If you are a BuddyPress user, you can just sit back and enjoy the speedier pageloads and reduced server overhead of your BuddyPress 2.0 site!</p>
<div></div>
<h4>Activity Stream Enhancements</h4>
<p>Spend a lot of time viewing the activity stream? BuddyPress 2.0 automatically lets you know when new items are ready to be loaded.</p>
<p><a href="http://buddypress.org/wp-content/uploads/1/2014/04/load-newest.jpg"><img src="http://buddypress.org/wp-content/uploads/1/2014/04/load-newest.jpg" alt="load-newest" width="558" height="302" class="size-full wp-image-181356" /></a></p>
<p>The activity stream is better integrated with blog posts, too. Comment on a blog post, and an activity item is posted. Comment on a blog-related activity item, and a blog comment is posted. No more worrying about fractured conversations.</p>
<p>We’ve also reworked the way that phrases like &#8220;Boone posted an update&#8221; are handled, so that they’re always up-to-date and always translatable.</p>
<div></div>
<h4>And much more</h4>
<p>BuddyPress 2.0 introduces dozens more small features, and fixes scores of bugs. We&#8217;ve compiled <a href="http://codex.buddypress.org/developer/releases/version-2-0/">a complete 2.0 changelog</a> on the BuddyPress Codex.</p>
<div></div>
<h4>Juliana is Number Two</h4>
<p>BuddyPress 2.0 is named for <a href="http://julianaspizza.com/">Juliana&#8217;s Pizza</a> in Brooklyn, NY. Juliana&#8217;s is the second pizza establishment opened in the same location by master pizzaiolo Patsy Grimaldi (it&#8217;s a long story), and was also the locale for a serious BuddyPress powwow and up-close dining experience by two members of the core team. For these reasons (not to mention the outstanding pizza) we think that BuddyPress 2.0 &#8220;Juliana&#8221; has a special ring to it.</p>
<div></div>
<h4>Thanks, thanks, and more thanks</h4>
<p>BuddyPress is built, with love, by a worldwide network of volunteers. The following people contributed patches during the BuddyPress 2.0 development cycle:</p>
<p><a href="https://profiles.wordpress.org/boonebgorges/">boonebgorges</a>, <a href="https://profiles.wordpress.org/Bowromir/">Bowromir</a>, <a href="https://profiles.wordpress.org/burakali/">burakali</a>, <a href="https://profiles.wordpress.org/chouf1/">chouf1</a>, <a href="https://profiles.wordpress.org/cmmarslender/">cmmarslender</a>, <a href="https://profiles.wordpress.org/danbp/">danbp</a>, <a href="https://profiles.wordpress.org/dcavins/">dcavins</a>, <a href="https://profiles.wordpress.org/Denis-de-Bernardy/">Denis-de-Bernardy</a>, <a href="https://profiles.wordpress.org/DJPaul/">DJPaul</a>, <a href="https://profiles.wordpress.org/ericlewis/">ericlewis</a>, <a href="https://profiles.wordpress.org/glyndavidson/">glyndavidson</a>, <a href="https://profiles.wordpress.org/graham-washbrook/">graham-washbrook</a>, <a href="https://profiles.wordpress.org/henrywright/">henrywright</a>, <a href="https://profiles.wordpress.org/henry.wright/">henry.wright</a>, <a href="https://profiles.wordpress.org/hnla/">hnla</a>, <a href="https://profiles.wordpress.org/imath/">imath</a>, <a href="https://profiles.wordpress.org/johnjamesjacoby/">johnjamesjacoby</a>, <a href="https://profiles.wordpress.org/karmatosed/">karmatosed</a>, <a href="https://profiles.wordpress.org/lenasterg/">lenasterg</a>, <a href="https://profiles.wordpress.org/MacPresss/">MacPresss</a>, <a href="https://profiles.wordpress.org/markoheijnen/">markoheijnen</a>, <a href="https://profiles.wordpress.org/megainfo/">megainfo</a>, <a href="https://profiles.wordpress.org/mercime">mercime</a>, <a href="https://profiles.wordpress.org/modemlooper/">modemlooper</a>, <a href="https://profiles.wordpress.org/mpa4hu/">mpa4hu</a>, <a href="https://profiles.wordpress.org/needle/">needle</a>, <a href="https://profiles.wordpress.org/netweb/">netweb</a>, <a href="https://profiles.wordpress.org/ninnypants/">ninnypants</a>, Pietro Oliva, <a href="https://profiles.wordpress.org/pross/">pross</a>, <a href="https://profiles.wordpress.org/r-a-y/">r-a-y</a>, <a href="https://profiles.wordpress.org/reactuate/">reactuate</a>, <a href="https://profiles.wordpress.org/rodrigorznd/">rodrigorznd</a>, <a href="https://profiles.wordpress.org/rogercoathup/">rogercoathup</a>, <a href="https://profiles.wordpress.org/rzen/">rzen</a>, <a href="https://profiles.wordpress.org/SergeyBiryukov/">SergeyBiryukov</a>, <a href="https://profiles.wordpress.org/shanebp/">shanebp</a>, <a href="https://profiles.wordpress.org/SlothLoveChunk/">SlothLoveChunk</a>, <a href="https://profiles.wordpress.org/StijnDeWitt/">StijnDeWitt</a>, <a href="https://profiles.wordpress.org/terraling/">terraling</a>, <a href="https://profiles.wordpress.org/trishasalas/">trishasalas</a>, <a href="https://profiles.wordpress.org/tw2113/">tw2113</a>, <a href="https://profiles.wordpress.org/vanillalounge/">vanillalounge</a>.</p>
<p>Many thanks to these contributors, and to all who have pitched in the forums and elsewhere.</p>
<p>One final point. Technically, BuddyPress &#8220;2.0&#8243; is just the version between 1.9 and 2.1. But still, there&#8217;s something special about crossing into the 2.x series, especially given the timing: we just crossed <a href="http://wptavern.com/major-milestone-for-buddypress-2-million-downloads-and-counting">2 million downloads</a>, and it&#8217;s been almost exactly five years since <a href="http://buddypress.org/2009/04/buddypress-10-has-arrived/">BuddyPress 1.0 was released</a>. On behalf of the core team and contributors, I&#8217;d like to extend a few special thanks: to founding developer <a href="http://apeatling.com/">Andy Peatling</a> for getting the ball rolling; to <a href="http://ma.tt">Matt Mullenweg</a> for providing support to the BuddyPress project; and especially to the many thousands of BuddyPress users who have followed and advocated for the project over the years. If BP has done great things for the thousands of communities that depend on it (and I think it has), it&#8217;s because of the incredible community around the software itself. <strike>A million</strike> Two million thanks to all of you.</p>
<div></div>
<h4>Upgrade Today</h4>
<p>You can get BuddyPress 2.0 from the <a href="http://wordpress.org/plugins/buddypress/">wordpress.org plugin repository</a>, or right from your WordPress Dashboard. </p>
<p>As always, questions, comments, bug reports, feature requests, and general laudatory remarks can be directed toward our <a href="https://buddypress.org/support/">support forums</a> or our <a href="https://buddypress.trac.wordpress.org">development tracker</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 16 Apr 2014 14:48:04 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Boone Gorges";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:34;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:39:"Akismet: Akismet 3.0.0 is now available";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://blog.akismet.com/?p=1294";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:49:"http://blog.akismet.com/2014/04/15/akismet-3-0-0/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1738:"<p>Version 3.0.0 of the <a href="http://wordpress.org/plugins/akismet/">Akismet plugin for WordPress</a> is now available.</p>
<p>This is a <strong>major rewrite</strong> of the plugin code. It includes many small improvements and some new features. In particular:</p>
<ul>
<li>An easier signup and activation process</li>
<li>An even easier activation process for <a href="http://jetpack.me/">Jetpack</a> users</li>
<li>A redesigned configuration tab</li>
<li>New stats charts (example shown below)</li>
<li>A new discard feature for outright blocking of the worst spam</li>
</ul>
<p><a href="http://akismet.files.wordpress.com/2014/04/stats-at-a-glance2.png"><img src="http://akismet.files.wordpress.com/2014/04/stats-at-a-glance2.png?w=640&h=295" alt="stats-at-a-glance" width="640" height="295" class="alignnone size-large wp-image-1304" /></a></p>
<p>To update to version 3.0.0, just use the plugin updater in your WordPress dashboard. If you&#8217;re running WordPress 3.9, there&#8217;s no need to update. If you haven&#8217;t installed Akismet on your WordPress blog yet, <a href="http://docs.akismet.com/getting-started/activate/">follow these instructions</a> to get started.</p>
<p>Thanks again to everyone who helped <a href="http://blog.akismet.com/2014/04/11/help-test-the-next-akismet-plugin/">test the new plugin</a> and offered suggestions and bug reports.</p><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/akismet.wordpress.com/1294/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/akismet.wordpress.com/1294/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=blog.akismet.com&blog=116920&post=1294&subd=akismet&ref=&feed=1" width="1" height="1" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 23:40:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Alex";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:35;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:55:"Andrew Nacin: My Talk Proposals for Open Source Bridge";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:24:"http://nacin.com/?p=4228";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:69:"http://nacin.com/2014/04/15/my-talk-proposals-for-open-source-bridge/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2106:"<p>I submitted two proposals to <a href="http://opensourcebridge.org/">Open Source Bridge</a>, an annual conference in Portland, Oregon, for &#8220;open source citizens.&#8221; The call for papers is now closed, but they let anyone leave comments on proposals that are private to the conference organizers. If you have any feedback on these, or have seen me speak before, it would be awesome if you could leave a comment. Here they are:</p>
<h2><a href="http://opensourcebridge.org/proposals/1413">Extreme Software Portability as an Art Form</a></h2>
<p>Writing portable software is hard. Throw in thousands of bad and worse shared hosting configurations, a decade of technical debt, the need to cater to a sprawling ecosystem, and PHP — and you have WordPress. We&#8217;ve found breaking changes harm our community and unfairly punish our users, so we don&#8217;t make them. But that doesn&#8217;t mean we don&#8217;t innovate or evolve — we&#8217;re just forced to get really clever. And it works, with adoption continuing to soar.</p>
<h2><a href="http://opensourcebridge.org/proposals/1419">Trust, Community, and Automatic Updates</a></h2>
<p>WordPress shipped in October what is perhaps its most polarizing feature ever — automatic updates in the background of self-hosted web software, on by default and no easy way to turn it off. In most open source communities, this would be cause for open revolt. Learn how through trust, communication, and a steadfast commitment to its philosophies, the WordPress core team convinced a skeptical community to go along, even if it meant users giving up some control.</p>
<p>WordPress contributors Mel Choyce and Aaron Jorbin also both submitted proposals: <a href="http://opensourcebridge.org/proposals/1315">My Journey into Open Source Design</a> and <a href="http://opensourcebridge.org/proposals/1312">Modernizing a Stagnant Toolbox</a>.</p>
<p class="share-sfc-stc"><a href="http://twitter.com/share?url=http%3A%2F%2Fwp.me%2FpQEdq-16c&count=horizontal&related=nacin&text=My Talk Proposals for Open Source Bridge" class="twitter-share-button"></a></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 21:04:08 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:36;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:69:"WPTavern: Ozh’ Tweet Archiver 2.0 Backs Up Your Tweets to WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=20985";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:176:"http://wptavern.com/ozh-tweet-archiver-2-0-backs-up-your-tweets-to-wordpress?utm_source=rss&utm_medium=rss&utm_campaign=ozh-tweet-archiver-2-0-backs-up-your-tweets-to-wordpress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3526:"<p><a href="http://wptavern.com/wp-content/uploads/2014/04/tweet-archiver.png" rel="prettyphoto[20985]"><img src="http://wptavern.com/wp-content/uploads/2014/04/tweet-archiver.png" alt="tweet-archiver" width="772" height="250" class="aligncenter size-full wp-image-21135" /></a></p>
<p>Social networks come and go but your blog lives forever. The advent of social media brought a revolution in how people communicate, but it has also chained us to data silos that house many of our important thoughts, writings and memories. That is, unless you have your own blog or website as your home for your content on the web.</p>
<p>Instead of mindlessly pumping content into a social network that is owned by someone else, you might stop to consider archiving that data to a better place where you can keep it forever. In a time when digital transactions and communications are the lifeblood of our work, owning your own data has become more important than owning land.</p>
<p><a href="http://wordpress.org/plugins/ozh-tweet-archiver/" target="_blank">Ozh Tweet Archiver</a> is one tool that makes owning your Twitter data a practical possibility. This free plugin automatically archives all of your tweets to your WordPress site. Browsing your tweet history is nearly impossible on Twitter, but with Ozh Tweet Archiver in place, you can easily search through your past tweets.</p>
<p>Version 2.0 is compatible with Twitter&#8217;s OAuth API. The plugin should be installed on a fresh WordPress site or subdomain. Once in place, it offers the following benefits:</p>
<ul>
<li>Searching is easier in WordPress than on Twitter</li>
<li>WordPress is not limited to the most recent 3200 tweets</li>
<li>It will automatically expand all those ugly t.co links</li>
<li>All your #hashtags can be converted to WordPress tags</li>
</ul>
<p>Check out a <a href="http://planetozh.com/tweets/" target="_blank">live demo</a> of <a href="http://twitter.com/ozh" target="_blank">@ozh Twitter account</a> archives.</p>
<p>Once the plugin is set up, it will automatically perform checks for new tweets at your chosen interval, so you won&#8217;t need to do anything else.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/twitter-archive-settings.jpg" rel="prettyphoto[20985]"><img src="http://wptavern.com/wp-content/uploads/2014/04/twitter-archive-settings.jpg" alt="twitter-archive-settings" width="585" height="454" class="aligncenter size-full wp-image-21161" /></a></p>
<p>Tweets are imported as regular posts with a few custom fields. The plugin includes an options panel for setting the post author, category for tweets, and the ability to turn on links for usernames. It also has an option to link hashtags to WordPress tags or Twitter hashtags. You can even turn on embedding for images that originate on pic.twitter.com.</p>
<p>Someday Twitter may lose all of its charms and fall to the wayside like many other networks before it. When that day comes, you&#8217;ll be glad that you archived all of your tweets to WordPress. If Twitter is one of your primary communication channels, consider the value of backing up your content to your home on the web with <a href="http://wordpress.org/plugins/ozh-tweet-archiver/" target="_blank">Ozh Tweet Archiver</a>. For more information on getting your archive set up, please refer to the <a href="http://planetozh.com/blog/my-projects/ozh-tweet-archiver-backup-twitter-with-wordpress/" target="_blank">official plugin page</a>, which includes documentation and troubleshooting tips.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 20:36:09 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:37;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:87:"WordPress.tv: Noel Tock : Le design d’interface : la cas d’Happytables (en anglais)";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=34302";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:93:"http://wordpress.tv/2014/04/15/noel-tock-le-design-dinterface-la-cas-dhappytables-en-anglais/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:686:"<div id="v-Fd96ypE1-1" class="video-player">
</div><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/34302/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/34302/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=34302&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2014/04/15/noel-tock-le-design-dinterface-la-cas-dhappytables-en-anglais/"><img alt="12 &#8211; Noel Tock-Conf-WCParis2014.mp4" src="http://videos.videopress.com/Fd96ypE1/video-9cccde5b3b_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 18:02:52 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:38;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:89:"WordPress.tv: Jean-Baptiste Marchand-Arvier : Utiliser WordPress pour son site e-commerce";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=34299";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:105:"http://wordpress.tv/2014/04/15/jean-baptiste-marchand-arvier-utiliser-wordpress-pour-son-site-e-commerce/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:712:"<div id="v-LMP5sHnL-1" class="video-player">
</div><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/34299/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/34299/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=34299&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2014/04/15/jean-baptiste-marchand-arvier-utiliser-wordpress-pour-son-site-e-commerce/"><img alt="11 &#8211; Jean-Baptiste Marchand-Arvier-Conf-WCParis2014.mp4" src="http://videos.videopress.com/LMP5sHnL/video-7717d23a5e_std.original.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 17:09:40 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:39;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:43:"Dev Blog: WordPress 3.9 Release Candidate 2";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3151";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:68:"http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate-2/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2327:"<p>The second release candidate for WordPress 3.9 is now available for testing.</p>
<p>If you haven&#8217;t tested 3.9 yet, you&#8217;re running out of time! We made about five dozen changes since the <a title="WordPress 3.9 Release Candidate" href="http://wordpress.org/news/2014/04/wordpress-3-9-release-candidate/">first release candidate</a>, and those changes are all helpfully summarized <a href="http://make.wordpress.org/core/?p=10237">in our weekly post</a> on the development blog. Probably the biggest fixes are to live widget previews and the new theme browser, along with some extra TinyMCE compatibility and some RTL fixes.</p>
<p><strong>Plugin authors:</strong> Could you test your plugins against 3.9, and if they&#8217;re compatible, make sure they are marked as tested up to 3.9? It only takes a few minutes and this really helps make launch easier. Be sure to follow along the core development blog; we&#8217;ve been posting <a href="http://make.wordpress.org/core/tag/3-9-dev-notes/">notes for developers for 3.9</a>. (For example: <a href="http://make.wordpress.org/core/2014/04/15/html5-galleries-captions-in-wordpress-3-9/">HTML5</a>, <a href="http://make.wordpress.org/core/2014/04/14/symlinked-plugins-in-wordpress-3-9/">symlinks</a>, <a href="http://make.wordpress.org/core/2014/04/07/mysql-in-wordpress-3-9/">MySQL</a>, <a href="http://make.wordpress.org/core/2014/04/11/plupload-2-x-in-wordpress-3-9/">Plupload</a>.)</p>
<p>To test WordPress 3.9 RC2, try the <a href="http://wordpress.org/extend/plugins/wordpress-beta-tester/">WordPress Beta Tester</a> plugin (you’ll want “bleeding edge nightlies”). Or you can <a href="http://wordpress.org/wordpress-3.9-RC2.zip">download the release candidate here</a> (zip). If you’d like to learn more about what’s new in WordPress 3.9, visit the nearly complete About screen in your dashboard (<strong><img src="http://i0.wp.com/core.svn.wordpress.org/branches/3.6/wp-content/themes/twentyten/images/wordpress.png?w=692" alt="" width="16" height="16" /> → About</strong> in the toolbar) and also check out <a title="WordPress 3.9 Beta 1" href="http://wordpress.org/news/2014/03/wordpress-3-9-beta-1/">the Beta 1 post</a>.</p>
<p><em>This is for testing,</em><br />
<em>so not recommended for<br />
production sites—yet.</em></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 09:47:36 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:40;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:79:"WPTavern: Cite: A WordPress Plugin to Help Readers Correctly Attribute Articles";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21094";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:200:"http://wptavern.com/cite-a-wordpress-plugin-to-help-readers-correctly-attribute-articles?utm_source=rss&utm_medium=rss&utm_campaign=cite-a-wordpress-plugin-to-help-readers-correctly-attribute-articles";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2214:"<p><a href="http://wptavern.com/wp-content/uploads/2014/04/cite.jpg" rel="prettyphoto[21094]"><img src="http://wptavern.com/wp-content/uploads/2014/04/cite.jpg" alt="cite" width="772" height="250" class="aligncenter size-full wp-image-21098" /></a></p>
<p>WordPress sites that publish academic or scholarly articles often need to provide information to help readers know how to cite articles correctly. <a href="http://wordpress.org/plugins/cite/" target="_blank">Cite</a> is a new plugin that tackles this requirement using dynamic tags to generate the date, site name, post title and permalink.</p>
<p>Post authors can easily post citation instructions by using the <strong>[cite]</strong> shortcode. It will automatically generate the article attribution information at the bottom of the post.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/cite-example.png" rel="prettyphoto[21094]"><img src="http://wptavern.com/wp-content/uploads/2014/04/cite-example.png" alt="cite-example" width="1661" height="676" class="aligncenter size-full wp-image-21101" /></a></p>
<p>The plugin includes a settings page where you can use any of the available template tags to create a citation template.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/cite-settings.jpg" rel="prettyphoto[21094]"><img src="http://wptavern.com/wp-content/uploads/2014/04/cite-settings.jpg" alt="cite-settings" width="915" height="446" class="aligncenter size-full wp-image-21100" /></a></p>
<p>The <a href="http://demo.enigmaweb.com.au/cite/" target="_blank">live demo</a> on the plugin author&#8217;s website shows how the citation template appears out-of-the-box. Its appearance can be further customized via CSS. The plugin is internationalized and ready for translation for use on academic sites in other languages.</p>
<p>Cite is a free plugin created by <a href="http://profiles.wordpress.org/enigmaweb/" target="_blank">Maeve Lander</a>. It will save you time on every post where you would otherwise manually enter information to help readers cite your article. <a href="http://wordpress.org/plugins/cite/" target="_blank">Download Cite</a> from WordPress.org or install it via your site&#8217;s admin panel.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 06:18:10 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:41;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:57:"WPTavern: WordPress 3.8.3 Released, Fixes Quick Draft Bug";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=21043";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:156:"http://wptavern.com/wordpress-3-8-3-released-fixes-quick-draft-bug?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-3-8-3-released-fixes-quick-draft-bug";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4177:"<p>WordPress 3.8.3 <a title="http://wordpress.org/news/" href="http://wordpress.org/news/">was released today</a> and fixes a pesky bug introduced in WordPress 3.8.2. As <a title="http://wptavern.com/wordpress-3-8-3-to-fix-quick-draft-dashboard-widget" href="http://wptavern.com/wordpress-3-8-3-to-fix-quick-draft-dashboard-widget">we reported a few days ago</a>, one of the security fixes in 3.8.2 caused the Quick Draft dashboard widget to break. Auto-drafts created through the widget were not being promoted to draft status. When a title and content were added to the widget, clicking the save draft button gave the appearance that it was discarded. A Quick Drafted post didn&#8217;t show up within the drafts list even though it existed within the database.</p>
<div id="attachment_21086" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/QuickDraftFixedFeaturedImage.png" rel="prettyphoto[21043]"><img class="size-full wp-image-21086" alt="WordPress 3.8.3 Fixed The Quick Draft Dashboard Widget" src="http://wptavern.com/wp-content/uploads/2014/04/QuickDraftFixedFeaturedImage.png" width="666" height="248" /></a><p class="wp-caption-text">WordPress 3.8.3 Fixed The Quick Draft Dashboard Widget</p></div>
<p>According to the announcement post on the official WordPress developments blog, not only does the update fix the bug but it also attempts to retrieve the last created auto-draft.</p>
<blockquote><p>It’s <em>possible</em> that the quick draft you lost last week is still in the database, and just hidden from view. As an added complication, these “discarded drafts” normally get deleted after seven days, and it’s already been six days since the release. If we were able to rescue your draft, you’ll see it on the “All Posts” screen after you update to 3.8.3.</p></blockquote>
<p>The team also pushed out 3.8.3 as a background update so there&#8217;s a chance you may see a draft appear. WordPress 3.7.2 was affected by the bug as well. You can upgrade to 3.7.3 to fix the issue but you&#8217;re encouraged to upgrade to the latest version which is 3.8.3.</p>
<h3>The Significance of WordPress 3.8.3</h3>
<p>This release is significant for a few reasons. The first is that a security and maintenance release (3.8.2) broke core functionality. When <a title="http://wptavern.com/wordpress-automatic-updates-no-options-for-you" href="http://wptavern.com/wordpress-automatic-updates-no-options-for-you">we wrote about automatic updates</a> in WordPress not having an options panel to configure their behavior, I pointed out minor and security updates rarely break anything dealing with the core of WordPress.</p>
<p>We now have an example of where a security update broke core functionality. Unfortunately, those that argue minor upgrades can break their site now have fuel for their argument. These types of mistakes happen and the core team has apologized.</p>
<blockquote><p>We recognize how much trust you place in us to safeguard your content, and we take this responsibility very seriously. We’re sorry we let you down.</p></blockquote>
<p>Second, the <a title="http://wordpress.org/about/philosophy/" href="http://wordpress.org/about/philosophy/">WordPress philosophy</a> doesn&#8217;t mention anything about preventing content from being lost. While we have post revisions, auto-saves, and auto-drafts, they weren&#8217;t enough to prevent some content from being lost. Whether using the Quick Draft dashboard widget is an <a title="http://www.poststat.us/wordpress-3-8-3-fixes-a-bug-with-quick-draft/" href="http://www.poststat.us/wordpress-3-8-3-fixes-a-bug-with-quick-draft/">edge case or not</a>, it&#8217;s reassuring to see the core team consider <strong>any loss of content</strong>, unacceptable.</p>
<h3>Minor and Security Releases Can Break Things</h3>
<p>Although there was a problem with 3.8.2 and using the Quick Draft widget, the team put together a fix and released it within a few days. Minor and security updates <strong>can</strong> break things but it happens far less frequently than the successful ones.</p>
<p>On a brighter note, WordPress 3.9 is expected to ship later this week.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 15 Apr 2014 03:48:58 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:42;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:78:"WPTavern: Why WordPress Theme Developers Are Moving Functionality Into Plugins";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=20499";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:200:"http://wptavern.com/why-wordpress-theme-developers-are-moving-functionality-into-plugins?utm_source=rss&utm_medium=rss&utm_campaign=why-wordpress-theme-developers-are-moving-functionality-into-plugins";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:11646:"<p>Jonathan Atkinson has been selling WordPress themes on <a href="http://themeforest.net/user/jonathan01" target="_blank">Themeforest</a> for the past five years. Through hard work and customer support, he&#8217;s learned how to <a href="http://wptavern.com/wpweekly-episode-137-making-a-living-on-themeforest-with-jonathan-atkinson" target="_blank">make a living on Themeforest</a> without having to pack hundreds of options into his products.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/plugins.jpg" rel="prettyphoto[20499]"><img src="http://wptavern.com/wp-content/uploads/2014/04/plugins-300x236.jpg" alt="plugins" width="300" height="236" class="alignright size-medium wp-image-21026" /></a>Over the past year, Atkinson and his team at <a href="http://cr3ativ.com/" target="_blank">Cr3ativ.com</a> have made an effort to convert all of their theme functionality into free plugins, eschewing the theme bloat that prevails in this market. Cr3ativ now has a <a href="http://cr3ativ.com/portfolio-category/plugins" target="_blank">plugins page</a> where you can find functionality that enables carousels, careers, portfolios, shortcodes, and staff profiles. They plan to add events, discography and photostreams in the coming weeks.</p>
<h3>The Benefits of Keeping Plugin and Theme Functionality Separate</h3>
<p>Atkinson said they initially created the plugins to be used with their themes and to better serve their buyers. &#8220;I took the decision to make them as generic as possible to ensure they could be just as easily used within any theme &#8211; free or premium,&#8221; he said. &#8220;I also decided to offer them 100% free and full GPL 2.0 so people can hopefully use, learn and extend if they wish.&#8221;</p>
<p>Keeping plugin functionality separate from themes is part of WordPress theme development best practices but Atkinson cites a few additional benefits:</p>
<ul>
<li>Speeds up development of new themes</li>
<li>Enables them to extend capabilities of existing themes</li>
<li>Theme independence allows them to extend plugins without creating a massive and painful update to an existing theme</li>
<li>Gives them more &#8220;breathing room&#8221; to concentrate on other possible outlets for their products, including other marketplaces, their own independent store and other avenues.</li>
</ul>
<p>Atkinson and his team are building new themes that support the use of their plugins and are also retrofitting the old themes to make use of them. The process hasn&#8217;t been easy, but they found help along the way.</p>
<p>&#8220;We have never created a single plugin before embarking on these and had to lean on Pippin from <a href="http://PippinsPlugins.com" target="_blank">PippinsPlugins.com</a> for advice as we moved forward,&#8221; Atkinson said. Branching out into plugins was completely new territory but Pippin Williamson helped to review and test their free plugins. &#8220;We had some things to change and at the end of development we&#8217;re happy we traveled this road.&#8221;</p>
<h3>The Demand for Bloat Keeps Theme Developers From Following Best Practices</h3>
<p>Overall, keeping plugins and themes separate has provided a better experience for Atkinson&#8217;s user base and gives his team more freedom in what they create. If this practice is so beneficial to theme authors, then why aren&#8217;t we seeing a mad rush of others moving to do the same?</p>
<p>The root of the problem is that consumers actually want themes that are packed full of options and functionality. The vast majority of Themeforest customers buy WordPress themes based on the demo. As WordPress has grown to power more than <a href="http://w3techs.com/technologies/overview/content_management/all" target="_blank">21% of the web</a>, theme developers are catering to people who, through no fault of their own, buy themes based solely on visual queues, not the code.</p>
<p>Atkinson explains how the theme market has changed over time:</p>
<blockquote><p>At the very beginning when Themeforest started I think that the buyers were different. The majority of buyers were developers. They may not have been full-on developers but they certainly knew how to roll their sleeves up and do a little bit of CSS. But now we&#8217;ve switched over to where the majority of buyers are actually the website owners&#8230;They know how to upload a theme; they know how to install every plugin on earth and that&#8217;s about it.</p></blockquote>
<p>Consumers want themes that don&#8217;t require installing a bunch of plugins. They want to be able to simply click to customize everything. As a result, bloated WordPress themes sell far better than those that follow best practices. Most of the <a href="http://themeforest.net/popular_item/by_category?category=wordpress" target="_blank">top-selling WordPress themes on Themeforest</a> are products that are packed full of multiple sliders, dozens of homepage options, shortcodes, unlimited layouts, page builders, etc.</p>
<p>Smashing Magazine has recently been <a href="https://twitter.com/smashingmag/status/453171965671395330" target="_blank">promoting</a> a WordPress theme that claims to be &#8220;the last WordPress theme you&#8217;ll ever have to buy.&#8221; The <a href="http://themeforest.net/item/x-the-ultimate-wordpress-theme/5871901" target="_blank">X theme</a>, created based on advice from internet marketers and SEO experts, promises &#8220;truly unlimited styling.&#8221; It is one among many themes that have been built to be all things for all projects.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/x-theme.png" rel="prettyphoto[20499]"><img src="http://wptavern.com/wp-content/uploads/2014/04/x-theme.png" alt="x-theme" width="590" height="300" class="aligncenter size-full wp-image-20875" /></a></p>
<p>The WordPress theme market is saturated with themes that promise to do it all and these products tend to sell very well among non-developers. Specificity of form and purpose has been replaced with generic skeletons boasting unlimited options.</p>
<p><strong>Theme authors are then faced with a grave decision:</strong> Sell a couple hundred niche themes with clean code or build every possible option/functionality into your theme and sell 50,000 copies. For those who are trying to make a living, it&#8217;s difficult to compete. This is a complex problem that doesn&#8217;t have an easy solution.</p>
<h3>Building Themes that Respect WordPress&#8217; Plugin System</h3>
<p>Atkinson and his team at <a href="http://cr3ativ.com/" target="_blank">Cr3ativ.com</a> are among a handful of theme authors who are taking a principled stand against building plugin functionality into WordPress themes. Those who have chosen this path stand out as beacons in a vast sea of bloated products.</p>
<p>Justin Tadlock has long been a vocal proponent of keeping plugin functionality out of themes, especially as it relates to data portability. <strong>&#8220;That&#8217;s just been the way WordPress has worked since the inception of the plugin and theme systems,&#8221;</strong> he said. &#8220;It hadn&#8217;t crossed my mind to add certain functionality into a theme because that&#8217;s not how WordPress was designed. For some reason, a trend started toward adding plugin functionality into themes, which is when I started looking into the issue.&#8221;</p>
<p>Tadlock&#8217;s <a href="http://themehybrid.com/" target="_blank">Theme Hybrid</a> framework comes with a suite of free <a href="http://themehybrid.com/plugins" target="_blank">plugins</a> that offer additional functionality. On occasion, he has made wrong choices and had to retrace his steps:</p>
<blockquote><p>There are things that I&#8217;ve put into themes and later realized that it was not the right choice. I just go about correcting those mistakes one at a time.  Sometimes, it takes a number of months and possibly years of making sure you&#8217;re not breaking things for users.</p></blockquote>
<p>The trend of packing everything into themes was ignited by WordPress&#8217; increasing popularity and the fierce competition among marketplace theme developers to provide the the most value. Unfortunately, consumers don&#8217;t care about best practices and re-educating them is not an easy task. It falls to WordPress theme developers and marketplace regulators to make the tough choice to keep themes clean and preserve data portability.</p>
<h3>First Steps Toward Removing Plugin Functionality From Themes</h3>
<div id="attachment_21080" class="wp-caption aligncenter"><a href="http://wptavern.com/wp-content/uploads/2014/04/salt-pepper.jpg" rel="prettyphoto[20499]"><img src="http://wptavern.com/wp-content/uploads/2014/04/salt-pepper.jpg" alt="photo credit: Sheyla Ruiz - cc" width="1022" height="490" class="size-full wp-image-21080" /></a><p class="wp-caption-text">photo credit: <a href="http://www.flickr.com/photos/sheylaruiz/6968369150/">Sheyla Ruiz</a> &#8211; <a href="http://creativecommons.org/licenses/by-nd/2.0/">cc</a></p></div>
<p>If you&#8217;re a theme developer who is looking to remove functionality from your products and offer it in the form of accompanying plugins, you&#8217;ve got your work cut out for you. Tadlock&#8217;s advice: <strong>&#8220;Just do it. Make sure you offer your users a fairly easy transition, at least as easy as these types of transitions can be.&#8221;</strong></p>
<p>Theme authors don&#8217;t necessarily need to suddenly add plugin development to their skills. Tadlock suggests that making use of existing plugins is a good option.</p>
<blockquote><p>So many developers want to build everything in house when there&#8217;s a much better solution out there already.  I&#8217;m even guilty of this at times. Of course, the infrastructure is not there on WordPress.org to make it easy for developers to work together. That&#8217;s why so many of us have turned to GitHub.</p></blockquote>
<p>Tadlock reports that he&#8217;s seen a considerable jump in other developers using his plugins in their projects after moving his code to Github. Making use of others&#8217; work and collaborating on improvements is less daunting than having to develop all the accompanying plugins yourself.</p>
<h3>Tips for Consumers Buying WordPress Themes</h3>
<p>Since consumers inspecting commercial themes do not have access to the code, it&#8217;s not easy to know if a product is built with best practices in mind. The demo and list of features are often the deciding factors, especially for those who have no technical knowledge of WordPress themes. If you don&#8217;t want to have your data locked into a theme, you need to be on guard to select products that utilize plugins that will preserve your data.</p>
<p>When it comes to theme options, the cold, hard truth is that not everyone is a designer. There is no ultimate visual layout builder or unlimited color chooser that will magically make you into a designer. If this is something you can recognize about yourself, then you may want to steer away from themes that offer massive options panels with unlimited everything. Instead, opt for design-specific themes that follow best practices and offer a few options using WordPress&#8217; native customizer.</p>
<p>Eventually, marketplaces may enforce more strict submission guidelines for their themes, based on community input. Theme developers who have sunk into a hole with their heavy, bloated products, will have to dig their way out or get pushed out. WordPress developers who want to be successful long-term will need to return to WordPress&#8217; original design and keep plugin functionality separate from themes.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 14 Apr 2014 21:58:40 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:43;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:45:"Dev Blog: WordPress 3.8.3 Maintenance Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://wordpress.org/news/?p=3145";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:50:"http://wordpress.org/news/2014/04/wordpress-3-8-3/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2338:"<p>WordPress 3.8.3 is now available to fix a small but unfortunate bug in the <a title="WordPress 3.8.2 Security Release" href="http://wordpress.org/news/2014/04/wordpress-3-8-2/">WordPress 3.8.2 security release</a>.</p>
<p>The &#8220;Quick Draft&#8221; tool on the dashboard screen was broken in the 3.8.2 update. If you tried to use it, your draft would disappear and it wouldn&#8217;t save. While we doubt anyone was writing a novella using this tool, <em>any</em> loss of content is unacceptable to us.</p>
<p>We recognize how much trust you place in us to safeguard your content, and we take this responsibility very seriously. We&#8217;re sorry we let you down.</p>
<p>We&#8217;ve all lost words we&#8217;ve written before, like an email thanks to a cat on the keyboard or a term paper to a blue screen of death. Over the last few WordPress releases, we&#8217;ve made a number of improvements to features like autosaves and revisions. With revisions, an old edit can always be restored. We&#8217;re trying our hardest to save your content somewhere even if your power goes out or your browser crashes. We even monitor your internet connection and prevent you from hitting that &#8220;Publish&#8221; button at the exact moment the coffee shop Wi-Fi has a hiccup.</p>
<p>It&#8217;s <em>possible</em> that the quick draft you lost last week is still in the database, and just hidden from view. As an added complication, these &#8220;discarded drafts&#8221; normally get deleted after seven days, and it&#8217;s already been six days since the release. If we were able to rescue your draft, you&#8217;ll see it on the &#8220;All Posts&#8221; screen after you update to 3.8.3. (We&#8217;ll also be pushing 3.8.3 out as a background update, so you may just see a draft appear.)</p>
<p>So, if you tried to jot down a quick idea last week, I hope WordPress has recovered it for you. Maybe it&#8217;ll turn into that novella.</p>
<p><a href="http://wordpress.org/download/">Download WordPress 3.8.3</a> or click &#8220;Update Now&#8221; on Dashboard → Updates.</p>
<p><em>This affected version 3.7.2 as well, so we&#8217;re pushing a 3.7.3 to these installs, but we&#8217;d encourage you to update to the latest and greatest.</em></p>
<hr />
<p><em>Now for some good news:<br />
WordPress 3.9 is near.<br />
Expect it this week</em></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 14 Apr 2014 19:29:13 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Andrew Nacin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:44;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:76:"WPTavern: WordPress Social Avatar Plugin Provides an Alternative to Gravatar";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=20440";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:196:"http://wptavern.com/wordpress-social-avatar-plugin-provides-an-alternative-to-gravatar?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-social-avatar-plugin-provides-an-alternative-to-gravatar";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2196:"<p>Despite the fact that <a href="http://gravatar.com/" target="_blank">Gravatar</a> is the default avatar service built into WordPress, it&#8217;s not everyone&#8217;s cup of tea. There are times when you may want to use a different avatar on a specific site but don&#8217;t want to change your Gravatar image. In some instances WordPress site admins choose to disable the service for whatever reason, but there is a way to give users more avatar options without turning Gravatar off.</p>
<p><a href="http://wordpress.org/plugins/wp-social-avatar/" target="_blank">WP Social Avatar</a> is a new plugin that makes it easy to use your Facebook or G+ picture as your WordPress avatar. Once activated, users can add their Facebook handles or G+ IDs to <strong>/wp-admin/profile.php</strong>.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/socialavatar.png" rel="prettyphoto[20440]"><img src="http://wptavern.com/wp-content/uploads/2014/04/socialavatar.png" alt="socialavatar" width="1372" height="792" class="aligncenter size-full wp-image-20990" /></a></p>
<p>Your avatar will be instantly updated to the new selection throughout the site.</p>
<p><a href="http://wptavern.com/wp-content/uploads/2014/04/wpsocialavatar.png" rel="prettyphoto[20440]"><img src="http://wptavern.com/wp-content/uploads/2014/04/wpsocialavatar.png" alt="wpsocialavatar" width="1271" height="493" class="aligncenter size-full wp-image-20992" /></a></p>
<p>WP Social Avatar includes a settings panel under the Users menu that allows administrators to set the minimum role/capabilities required to use social avatars.</p>
<p>The plugin does not require Facebook or G+ authentication in order to set your avatar, so it&#8217;s just as convenient to use as Gravatar. It also does not disable Gravatar for users who prefer it. <a href="http://wptavern.com/marutimohanty.wordpress.com" target="_blank">Maruti Mohanty</a>, the plugin&#8217;s developer, plans to add more social avatars in the future. If you want to add a few convenient avatar options to WordPress profiles on your site, download <a href="http://wordpress.org/plugins/wp-social-avatar/" target="_blank">WP Social Avatar</a> from WordPress.org.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 14 Apr 2014 05:32:29 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:45;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:44:"BuddyPress: BuddyPress 2.0 Release Candidate";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:31:"http://buddypress.org/?p=181203";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:63:"http://buddypress.org/2014/04/buddypress-2-0-release-candidate/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1019:"<p>The first release candidate (RC1) for BuddyPress 2.0 is now available (<a href="http://downloads.wordpress.org/plugin/buddypress.2.0-RC1.zip">zip</a>). Since <a href="https://buddypress.org/2014/04/buddypress-2-0-beta2/">the last beta</a>, we have made about 10 small changes; see <a href="https://buddypress.trac.wordpress.org/timeline?from=04%2F13%2F14&daysback=5&authors=&changeset=on&sfp_email=&sfph_mail=&update=Update">the changelog</a> for details.</p>
<p>At this time, BP 2.0 is in a string freeze &#8211; we won&#8217;t be changing any more text between now and the final release. If you are helping to maintain <a href="http://translate.wordpress.org/projects/buddypress">a BuddyPress translation</a>, this is your chance to make final revisions before 2.0 comes out. (We&#8217;re still looking good for April 16.)</p>
<p>Questions, comments, concerns, bugs, praise? Visit <a href="https://buddypress.org/support/">the support forums</a> or <a href="https://buddypress.trac.wordpress.org/">BP Trac</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 13 Apr 2014 20:15:14 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Boone Gorges";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:46;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:62:"WordPress.tv: Sarah Wefald: Twitter Integration With WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wordpress.tv/?p=34148";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:79:"http://wordpress.tv/2014/04/12/sarah-wefald-twitter-integration-with-wordpress/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:679:"<div id="v-s22WSUNH-1" class="video-player">
</div><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/wptv.wordpress.com/34148/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/wptv.wordpress.com/34148/" /></a> <img alt="" border="0" src="http://stats.wordpress.com/b.gif?host=wordpress.tv&blog=5089392&post=34148&subd=wptv&ref=&feed=1" width="1" height="1" /><div><a href="http://wordpress.tv/2014/04/12/sarah-wefald-twitter-integration-with-wordpress/"><img alt="Sarah Wefald: Twitter Integration With WordPress" src="http://videos.videopress.com/s22WSUNH/video-05a42d3046_scruberthumbnail_0.jpg" width="160" height="120" /></a></div>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 12 Apr 2014 12:06:51 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"WordPress.tv";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:47;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:60:"WPTavern: WPWeekly Episode 145 – An OMGBBQWTF Kind Of Week";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:44:"http://wptavern.com?p=20940&preview_id=20940";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:156:"http://wptavern.com/wpweekly-episode-145-an-omgbbqwtf-kind-of-week?utm_source=rss&utm_medium=rss&utm_campaign=wpweekly-episode-145-an-omgbbqwtf-kind-of-week";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:4879:"<p><a title="http://marcuscouch.com/" href="http://marcuscouch.com/">Marcus Couch</a> and I were joined by <a title="http://eamann.com/" href="http://eamann.com/">Eric Mann</a> to discuss the news of the week. After the news, we discussed in-depth a few of the core proposals Mann has published on his blog. We covered the following three WordPress core proposals:</p>
<ul>
<li><a title="http://eamann.com/tech/data-service/" href="http://eamann.com/tech/data-service/">Data Service</a></li>
<li><a title="http://eamann.com/tech/wordpress-portability/" href="http://eamann.com/tech/wordpress-portability/">Portability</a></li>
<li><a title="http://eamann.com/tech/offline-editor/" href="http://eamann.com/tech/offline-editor/">Offline Editor</a></li>
</ul>
<p>After speaking with Mann, it&#8217;s clear he puts a lot of thought into each proposal. I hope you enjoy the show and don&#8217;t forget to give us your feedback in the comments.</p>
<h2>Stories Discussed:</h2>
<p><a title="http://wptavern.com/breaking-jetpack-releases-critical-security-update-immediate-action-required" href="http://wptavern.com/breaking-jetpack-releases-critical-security-update-immediate-action-required">Breaking: Jetpack Releases Critical Security Update, Immediate Action Required</a><br />
<a title="http://wptavern.com/wordpress-3-8-2-first-security-release-shipped-as-a-background-update" href="http://wptavern.com/wordpress-3-8-2-first-security-release-shipped-as-a-background-update">WordPress 3.8.2: First Security Release Shipped as a Background Update</a><br />
<a title="http://wptavern.com/recent-update-to-wordfence-security-breaks-wordpress-mobile-apps" href="http://wptavern.com/recent-update-to-wordfence-security-breaks-wordpress-mobile-apps">Recent Update To Wordfence Security Breaks WordPress Mobile Apps</a><br />
<a title="http://wptavern.com/devpress-sold-to-unknown-buyer-for-14k" href="http://wptavern.com/devpress-sold-to-unknown-buyer-for-14k">DevPress Sold To Unknown Buyer For $14k</a><br />
<a title="http://www.poststat.us/devin-price-new-owner-devpress/" href="http://www.poststat.us/devin-price-new-owner-devpress/">Devin Price is the new owner of DevPress</a><br />
<a title="http://wptavern.com/wordpress-org-profile-redesign-is-live" href="http://wptavern.com/wordpress-org-profile-redesign-is-live">WordPress.org Profile Redesign is Live</a></p>
<h2>Plugins Picked By Marcus:</h2>
<p><a title="http://wordpress.org/plugins/webkite/" href="http://wordpress.org/plugins/webkite/">Webkite for WordPress</a> &#8211; WebKite is a service for getting your data online quickly and easily. Backed by the WebKite API, the WebKite for WordPress plugin delivers the filtering and sorting capabilities of sites like Kayak, Amazon, and Yelp. Users can interact with your content to easily find items that are relevant to their needs, a great way to build rapport and trust with your user base.</p>
<p><a title="http://wordpress.org/plugins/alti-watermark/" href="http://wordpress.org/plugins/alti-watermark/">Watermark</a> &#8211; This plugin allows you to add a watermark on images uploaded to the media library. It applies a watermark on new images as well as images already uploaded.</p>
<p><a href="http://wordpress.org/plugins/forget-about-shortcode-buttons/" title="http://wordpress.org/plugins/forget-about-shortcode-buttons/">Forget About Shortcode Buttons</a> &#8211; Forget About Shortcode (FASC) Buttons are a visual way to add CSS buttons in the post editor screen and to your themes.</p>
<p><a title="http://wordpress.org/plugins/twentytwenty/" href="http://wordpress.org/plugins/twentytwenty/">TwentyTwenty</a> &#8211; Show before and after pictures in your blog, with an interactive slider that allows users to compare them.</p>
<p><a title="http://wordpress.org/plugins/bp-group-documents/" href="http://wordpress.org/plugins/bp-group-documents/">BP Group Documents</a> &#8211; BP Group Documents creates a page within each BuddyPress group to upload and any type of file or document. This allows members of BuddyPress groups to upload and store files and documents that are relevant to the group.</p>
<h2>WPWeekly Meta:</h2>
<p><strong>Next Episode:</strong> Friday, April 18th 3 P.M. Eastern &#8211; Special Guest: <a href="http://nacin.com/" title="http://nacin.com/">Andrew Nacin</a></p>
<p><strong>Subscribe To WPWeekly Via Itunes: </strong><a href="https://itunes.apple.com/us/podcast/wordpress-weekly/id694849738" target="_blank">Click here to subscribe</a></p>
<p><strong>Subscribe To WPWeekly Via RSS: </strong><a href="http://www.wptavern.com/feed/podcast" target="_blank">Click here to subscribe</a></p>
<p><strong>Subscribe To WPWeekly Via Stitcher Radio: </strong><a href="http://www.stitcher.com/podcast/wordpress-weekly-podcast?refid=stpr" target="_blank">Click here to subscribe</a></p>
<p><strong>Listen To Episode #145:</strong><br />
</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 12 Apr 2014 04:22:01 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:48;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:62:"WPTavern: WordPress Plugin CoSchedule Secures $500K In Funding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=20935";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:166:"http://wptavern.com/wordpress-plugin-coschedule-secures-500k-in-funding?utm_source=rss&utm_medium=rss&utm_campaign=wordpress-plugin-coschedule-secures-500k-in-funding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2278:"<p><a title="http://wordpress.org/plugins/coschedule-by-todaymade/" href="http://wordpress.org/plugins/coschedule-by-todaymade/">CoSchedule</a>, the editorial workflow and activity scheduling plugin, has <a title="http://coschedule.com/blog/coschedule-series-a-funding/" href="http://coschedule.com/blog/coschedule-series-a-funding/">secured $500K</a> in a Series A round of funding. The angel investment was led by Sandin Holdings and Bullinger Enterprises of Fargo, North Dakota. Matching funds were provided by the North Dakota Development Fund. Joe Sandin of Sandin Holdings will join CoSchedule&#8217;s Board of Directors, providing strategic guidance and business advice.</p>
<p>When I <a title="http://wptavern.com/coschedule-a-viable-alternative-to-the-edit-flow-wordpress-plugin" href="http://wptavern.com/coschedule-a-viable-alternative-to-the-edit-flow-wordpress-plugin">reviewed the plugin</a> last year, I considered it to be a viable alternative to <a title="http://wordpress.org/plugins/edit-flow/" href="http://wordpress.org/plugins/edit-flow/">Edit Flow</a>. CoSchedule will use the money to hire more employees, increase their marketing budget, and increase the speed of development so new features reach users faster.</p>
<p><span class="embed-youtube"></span></p>
<p>Moon says the company has experienced rapid growth since launching in September of 2013. Since the launch, the plugin has over 6,000 downloads with users in more than 100 countries and paying customers in 35 countries. I asked Moon, what advice does he have for those looking to obtain a round of funding to take their business or service to the next level? He replied:</p>
<blockquote><p>I think a lot of developers hesitate to look for funding for their work because the process is overwhelming and unfamiliar to them. I will definitely admit that it is a ton of work, but it can be hugely valuable. Not only can you get the financing you need to move to the next level, but it really forces you to look at your product in a new way and challenge every assumption that you&#8217;ve made. Investors ask hard questions, and that can be a really good thing.</p></blockquote>
<p>Do you use CoSchedule? If so, what do you think of its editorial workflow and how it handles multiple authors?</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 11 Apr 2014 21:27:17 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jeff Chandler";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:49;a:6:{s:4:"data";s:13:"
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:74:"WPTavern: Major Milestone For BuddyPress: 2 Million Downloads and Counting";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://wptavern.com/?p=20944";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:190:"http://wptavern.com/major-milestone-for-buddypress-2-million-downloads-and-counting?utm_source=rss&utm_medium=rss&utm_campaign=major-milestone-for-buddypress-2-million-downloads-and-counting";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1599:"<p><a href="http://wptavern.com/wp-content/uploads/2014/04/balloons.jpg" rel="prettyphoto[20944]"><img src="http://wptavern.com/wp-content/uploads/2014/04/balloons.jpg" alt="balloons" width="1016" height="466" class="aligncenter size-full wp-image-20946" /></a></p>
<p><a href="http://buddypress.org/">BuddyPress</a> reached a major milestone today, crossing the two million download mark just a week ahead of the official 2.0 release. The plugin, known as &#8220;a social network in a box,&#8221; now has more than 500 related <a href="http://buddypress.org/extend/plugins/" target="_blank">community extensions</a>.</p>
<p>Over the past 7 years, BuddyPress has developed a strong international community of users and contributors. Roughly <a href="http://wptavern.com/7-surprising-results-from-the-2013-buddypress-codex-survey">50% of BuddyPress sites are in English</a>, with the other half comprised of social networks in Spanish, Italian, French, German, Dutch, Swedish, Portugese, Chinese, and many other languages.</p>
<p>The upcoming version 2.0 of the plugin adds a host of new features that help administrators manage their communities more efficiently in the dashboard. It also introduces some remarkable performance improvements that <a href="http://wptavern.com/buddypress-2-0-ramps-up-performance-reduces-footprint-by-up-to-75" target="_blank">reduce the plugin&#8217;s footprint by up to 75%</a> in many places. Help celebrate BuddyPress crossing the two million download mark by testing <a href="http://buddypress.org/2014/04/buddypress-2-0-beta2/" target="_blank">2.0-beta2</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 11 Apr 2014 20:10:57 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Sarah Gooding";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:9:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Tue, 22 Apr 2014 23:03:03 GMT";s:12:"content-type";s:8:"text/xml";s:14:"content-length";s:6:"236424";s:10:"connection";s:5:"close";s:4:"vary";s:15:"Accept-Encoding";s:13:"last-modified";s:29:"Tue, 22 Apr 2014 22:45:12 GMT";s:4:"x-nc";s:11:"HIT lax 249";s:13:"accept-ranges";s:5:"bytes";}s:5:"build";s:14:"20130911070210";}', 'no'); 
INSERT INTO `wp_options` VALUES ('2645', '_transient_timeout_feed_mod_867bd5c64f85878d03a060509cd2f92c', '1398250985', 'no'); 
INSERT INTO `wp_options` VALUES ('2646', '_transient_feed_mod_867bd5c64f85878d03a060509cd2f92c', '1398207785', 'no'); 
INSERT INTO `wp_options` VALUES ('2647', '_transient_timeout_feed_b9388c83948825c1edaef0d856b7b109', '1398250985', 'no'); 
INSERT INTO `wp_options` VALUES ('2648', '_transient_feed_b9388c83948825c1edaef0d856b7b109', 'a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"
	
";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:72:"
		
		
		
		
		
		
				

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

	";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:7:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:39:"WordPress Plugins » View: Most Popular";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:44:"http://wordpress.org/plugins/browse/popular/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:39:"WordPress Plugins » View: Most Popular";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:5:"en-US";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Apr 2014 22:53:30 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:25:"http://bbpress.org/?v=1.1";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:15:{i:0;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:7:"Akismet";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:45:"http://wordpress.org/plugins/akismet/#post-15";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 09 Mar 2007 22:11:30 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"15@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:98:"Akismet checks your comments against the Akismet web service to see if they look like spam or not.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Matt Mullenweg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"Google XML Sitemaps";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:63:"http://wordpress.org/plugins/google-sitemap-generator/#post-132";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 09 Mar 2007 22:31:32 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"132@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:105:"This plugin will generate a special XML sitemap which will help search engines to better index your blog.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:5:"Arnee";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:14:"Contact Form 7";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:54:"http://wordpress.org/plugins/contact-form-7/#post-2141";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 02 Aug 2007 12:45:03 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"2141@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:54:"Just another contact form plugin. Simple but flexible.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Takayuki Miyoshi";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"WordPress SEO by Yoast";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:53:"http://wordpress.org/plugins/wordpress-seo/#post-8321";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 01 Jan 2009 20:34:44 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"8321@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:131:"Improve your WordPress SEO: Write better content and have a fully optimized WordPress site using the WordPress SEO plugin by Yoast.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Joost de Valk";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:24:"Jetpack by WordPress.com";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:48:"http://wordpress.org/plugins/jetpack/#post-23862";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 20 Jan 2011 02:21:38 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"23862@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:104:"Supercharge your WordPress site with powerful features previously only available to WordPress.com users.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"Tim Moore";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"All in One SEO Pack";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:58:"http://wordpress.org/plugins/all-in-one-seo-pack/#post-753";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 30 Mar 2007 20:08:18 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"753@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:126:"All in One SEO Pack is a WordPress SEO plugin to automatically optimize your WordPress blog for Search Engines such as Google.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"uberdose";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:46:"iThemes Security (formerly Better WP Security)";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wordpress.org/plugins/better-wp-security/#post-21738";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 22 Oct 2010 22:06:05 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"21738@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:63:"The easiest, most effective way to secure WordPress in seconds.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Chris Wiegman";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:20:"MailPoet Newsletters";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wordpress.org/plugins/wysija-newsletters/#post-32629";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 02 Dec 2011 17:09:16 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"32629@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:94:"Send newsletters, post notifications or autoresponders from WordPress easily, and beautifully.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"MailPoet Staff";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:33:"WooCommerce - excelling eCommerce";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:52:"http://wordpress.org/plugins/woocommerce/#post-29860";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 05 Sep 2011 08:13:36 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"29860@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:97:"WooCommerce is a powerful, extendable eCommerce plugin that helps you sell anything. Beautifully.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"WooThemes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"TinyMCE Advanced";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:56:"http://wordpress.org/plugins/tinymce-advanced/#post-2082";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 27 Jun 2007 15:00:26 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"2082@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:71:"Enables the advanced features of TinyMCE, the WordPress WYSIWYG editor.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:10:"Andrew Ozz";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:10;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"Wordfence Security";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:50:"http://wordpress.org/plugins/wordfence/#post-29832";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sun, 04 Sep 2011 03:13:51 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"29832@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:121:"Wordfence Security is a free enterprise class security plugin that makes your site up to 50 times faster and more secure.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"Wordfence";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:11;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:22:"Advanced Custom Fields";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:63:"http://wordpress.org/plugins/advanced-custom-fields/#post-25254";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 17 Mar 2011 04:07:30 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"25254@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:150:"Fully customise WordPress edit screens with powerful fields. Boasting a professional interface and a powerful API, it’s a must have for any web deve";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"elliotcondon";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:12;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:18:"WordPress Importer";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"http://wordpress.org/plugins/wordpress-importer/#post-18101";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 20 May 2010 17:42:45 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"18101@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:101:"Import posts, pages, comments, custom fields, categories, tags and more from a WordPress export file.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Brian Colinger";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:13;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:21:"WPtouch Mobile Plugin";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:47:"http://wordpress.org/plugins/wptouch/#post-5468";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 01 May 2008 04:58:09 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"5468@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:63:"Create a slick mobile WordPress website with just a few clicks.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"BraveNewCode Inc.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:14;a:6:{s:4:"data";s:30:"
			
			
			
			
			
			
					";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:15:"NextGEN Gallery";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"http://wordpress.org/plugins/nextgen-gallery/#post-1169";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 23 Apr 2007 20:08:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"1169@http://wordpress.org/plugins/";s:7:"attribs";a:1:{s:0:"";a:1:{s:11:"isPermaLink";s:5:"false";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:120:"The most popular WordPress gallery plugin and one of the most popular plugins of all time with over 9 million downloads.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:9:"Alex Rabe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:4:"href";s:45:"http://wordpress.org/plugins/rss/view/popular";s:3:"rel";s:4:"self";s:4:"type";s:19:"application/rss+xml";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:10:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Tue, 22 Apr 2014 23:03:05 GMT";s:12:"content-type";s:23:"text/xml; charset=UTF-8";s:10:"connection";s:5:"close";s:4:"vary";s:15:"Accept-Encoding";s:7:"expires";s:29:"Tue, 22 Apr 2014 23:28:30 GMT";s:13:"cache-control";s:0:"";s:6:"pragma";s:0:"";s:13:"last-modified";s:31:"Tue, 22 Apr 2014 22:53:30 +0000";s:4:"x-nc";s:11:"HIT lax 249";}s:5:"build";s:14:"20130911070210";}', 'no'); 
INSERT INTO `wp_options` VALUES ('2649', '_transient_timeout_feed_mod_b9388c83948825c1edaef0d856b7b109', '1398250986', 'no'); 
INSERT INTO `wp_options` VALUES ('2650', '_transient_feed_mod_b9388c83948825c1edaef0d856b7b109', '1398207786', 'no'); 
INSERT INTO `wp_options` VALUES ('2651', '_transient_timeout_plugin_slugs', '1398298069', 'no'); 
INSERT INTO `wp_options` VALUES ('2652', '_transient_plugin_slugs', 'a:37:{i:0;s:29:"ads-by-datafeedrcom/dfads.php";i:1;s:30:"advanced-custom-fields/acf.php";i:2;s:63:"advanced-custom-fields-location-field-add-on/location-field.php";i:3;s:51:"acf-field-date-time-picker/acf-date_time_picker.php";i:4;s:19:"akismet/akismet.php";i:5;s:51:"auto-excerpt-everywhere/auto-excerpt-everywhere.php";i:6;s:43:"broken-link-checker/broken-link-checker.php";i:7;s:85:"carousel-horizontal-posts-content-slider/carousel-horizontal-posts-content-slider.php";i:8;s:25:"cloudflare/cloudflare.php";i:9;s:36:"contact-form-7/wp-contact-form-7.php";i:10;s:39:"admin-customizado/admin-customizado.php";i:11;s:38:"dashboard_usuario/dashbord_usuario.php";i:12;s:33:"duplicate-post/duplicate-post.php";i:13;s:39:"webriti-smtp-mail/webriti-smtp-mail.php";i:14;s:33:"events-manager/events-manager.php";i:15;s:45:"ewww-image-optimizer/ewww-image-optimizer.php";i:16;s:37:"export-user-data/export-user-data.php";i:17;s:43:"google-analytics-dashboard-for-wp/gadwp.php";i:18;s:50:"google-analytics-for-wordpress/googleanalytics.php";i:19;s:43:"google-font-manager/google-font-manager.php";i:20;s:36:"google-sitemap-generator/sitemap.php";i:21;s:9:"hello.php";i:22;s:41:"better-wp-security/better-wp-security.php";i:23;s:24:"log-user-stats/index.php";i:24;s:32:"boleto-usuario/modulo_boleto.php";i:25;s:39:"pdfjs-viewer-shortcode/pdfjs-viewer.php";i:26;s:29:"ready-backup/backup-ready.php";i:27;s:33:"seo-image/seo-friendly-images.php";i:28;s:45:"simple-local-avatars/simple-local-avatars.php";i:29;s:33:"smart-slider-2/smart-slider-2.php";i:30;s:56:"New-Media-Image-Uploader-master/tgm-new-media-plugin.php";i:31;s:37:"user-role-editor/user-role-editor.php";i:32;s:29:"user-status-manager/start.php";i:33;s:33:"w3-total-cache/w3-total-cache.php";i:34;s:37:"widgets-on-pages/widgets_on_pages.php";i:35;s:27:"wp-optimize/wp-optimize.php";i:36;s:31:"wp-backupware/wp-backupware.php";}', 'no'); 
INSERT INTO `wp_options` VALUES ('2653', '_transient_timeout_dash_4077549d03da2e451c8b5f002294ff51', '1398250986', 'no'); 
INSERT INTO `wp_options` VALUES ('2654', '_transient_dash_4077549d03da2e451c8b5f002294ff51', '<div class="rss-widget"><ul><li><a class=\'rsswidget\' href=\'http://wordpress.org/news/2014/04/smith/\' title=\'Version 3.9 of WordPress, named “Smith” in honor of jazz organist Jimmy Smith, is available for download or update in your WordPress dashboard. This release features a number of refinements that we hope you’ll love. A smoother media editing experience Improved visual editing The updated visual editor has improved speed, accessibility, and mobile support. You can paste into the […]\'>WordPress 3.9 “Smith”</a> <span class="rss-date">16 16UTC abril 16UTC 2014</span><div class=\'rssSummary\'>Version 3.9 of WordPress, named “Smith” in honor of jazz organist Jimmy Smith, is available for download or update in your WordPress dashboard. This release features a number of refinements that we hope you’ll love. A smoother media editing experience Improved visual editing The updated visual editor has improved speed, accessibility, and mobile support. You [&hellip;]</div></li></ul></div><div class="rss-widget"><ul><li><a class=\'rsswidget\' href=\'http://wptavern.com/new-plugin-adds-less-css-preprocessor-to-wordpress-themes?utm_source=rss&#038;utm_medium=rss&#038;utm_campaign=new-plugin-adds-less-css-preprocessor-to-wordpress-themes\' title=\' Many WordPress developers opt to use the Less CSS preprocessor to speed up theme development. Its availability of variables, mixins, and functions allows you to do more with CSS and to do it more efficiently. It also makes it easy to compile and minify files for production use. However, the initial setup for adding Less to each theme is a somewhat time-consuming process. Justin Kopepasah wrote a tutorial in the past for using LESS in a live WordPress theme, followed by one that automated the process by setting up the functionality as a Git submodule. Over time, he found that adding Less to each theme was becoming quite a chore, so he created a plugin to make the process easier for anyone. Kopepasah’s Less Theme Support plugin radically simplifies the process of adding Less to your WordPress theme. It requires just two simple steps following activation:  Add style.less to your theme’s root directory Add theme support to the after_setup_theme hook: add_theme_support( &#039;less&#039;, array( &#039;enable&#039; =&gt; true ) );   Less Theme Support comes with four different options which change how it functions on development vs. production sites. All are boolean values defaulting to false:  enable – Enables Less and enqueues less.min.js on the front end. develop – Enables development environment for Less and enqueues less-develop.js. watch – Enables watch mode for Less and enqueues less-watch.js. minify – Enables usage of a minified stylesheet (style.min.css) on the front end for all other visitors (best generated using lessc -x style.less &gt; style.min.css).  These options give you quite a bit of flexibility. For example, during development you might configure your theme support with the enable, develop, and watch options: add_theme_support( &#039;less&#039;, array(     &#039;enable&#039;  =&gt; true,     &#039;develop&#039; =&gt; true,     &#039;watch&#039;  =&gt; true ) ); Less theme support in production would us the minify option: add_theme_support( &#039;less&#039;, array(  &#039;minify&#039; =&gt; true ) ); Using the Less Theme Support plugin provides a much cleaner and easier way to add Less to your theme. Download it from WordPress.org or via the project’s page on Github.\'>WPTavern: New Plugin Adds Less CSS Preprocessor to WordPress Themes</a></li><li><a class=\'rsswidget\' href=\'http://wptavern.com/display-before-and-after-images-in-wordpress-with-the-twentytwenty-plugin?utm_source=rss&#038;utm_medium=rss&#038;utm_campaign=display-before-and-after-images-in-wordpress-with-the-twentytwenty-plugin\' title=\'Have you ever wanted to combine two images to show a before and after? You can’t do that with WordPress out of the box but it’s possible if you use the TwentyTwenty plugin by Corey Martin. The plugin takes advantage of the clip property within CSS by stacking two identical sized images on top of each other. The clip property allows the image to show through the container. The slider is responsive and uses custom movement events within the jQuery Event Move library to support 1:1 slider movement on mobile devices. The plugin is very simple to use. Upload two identical sized images to the media library. When inserting images into a post, make sure the attachment display settings for image size are the same. Add the [TwentyTwenty] shortcode above the before image. Add [/TwentyTwenty] after the second image. Here’s an example of the shortcode added to a post. TwentyTwenty Shortcode In Action The shortcode generates a slider that can be moved back and forth. You’ll see which images are before and after when you hover over the slider. To see either image, users must click and drag the circle left or right. TwentyTwenty Before Image TwentyTwenty After Image The plugin was written using Sass and Zurb.com has a listing of each Sass variable used and what its default value is. The variables enable you to control everything from the handle color to the handle radius. Here are a couple of ideas where TwentyTwenty would be ideal to use.  Compare counterfeit merchandise to real merchandise Website redesigns Home improvement renovations  During my test with WordPress 3.9, I didn’t experience any problems. According to Martin, TwentyTwenty is compatible with the latest versions of Chrome, Safari, FireFox, iOS, IE 9, and above. If you want to see the plugin in action, you can either watch this screencast by Martin or visit the plugin’s page on Zurb.com.  Outside of showing before and after images, what other creative ways could this plugin be used?\'>WPTavern: Display Before and After Images In WordPress With The TwentyTwenty Plugin</a></li><li><a class=\'rsswidget\' href=\'http://wptavern.com/wordpress-3-9-adds-30-new-dashicons?utm_source=rss&#038;utm_medium=rss&#038;utm_campaign=wordpress-3-9-adds-30-new-dashicons\' title=\'Dashicons are what’s known as an icon font and were added to the core of WordPress with the release of 3.8. The icons are vector based so they can be as large or small as you want without losing quality. Plugin authors can use CSS, HTML, or a Glyph for use within Photoshop to display an icon. While 3.8 had 167 icons, WordPress 3.9 shipped with 30 new Dashicons bringing the total to 197. New Dashicons In WordPress 3.9 The icons cover Media, TinyMCE, WordPress.org, Sorting, Widgets, Alerts, and Miscellaneous. Some plugin authors have already opted out of using a bitmap image and are using a Dashicon to represent their plugin within the WordPress admin menu. If none of the Dashicons match your use case, try Genericons instead. Genereicons is also an icon font but has icons that are not focused on WordPress.\'>WPTavern: WordPress 3.9 Adds 30 New Dashicons</a></li></ul></div><div class="rss-widget"><ul><li class=\'dashboard-news-plugin\'><span>Plugins populares:</span> <a href=\'http://wordpress.org/plugins/wordfence/\' class=\'dashboard-news-plugin-link\'>Wordfence Security</a></h5>&nbsp;<span>(<a href=\'plugin-install.php?tab=plugin-information&amp;plugin=wordfence&amp;_wpnonce=a55d4da72c&amp;TB_iframe=true&amp;width=600&amp;height=800\' class=\'thickbox\' title=\'Wordfence Security\'>Instalar</a>)</span></li></ul></div>', 'no'); 
INSERT INTO `wp_options` VALUES ('2657', 'db_upgraded', '', 'yes'); 
INSERT INTO `wp_options` VALUES ('2659', '_site_transient_update_core', 'O:8:"stdClass":4:{s:7:"updates";a:2:{i:0;O:8:"stdClass":10:{s:8:"response";s:6:"latest";s:8:"download";s:63:"https://downloads.wordpress.org/release/pt_BR/wordpress-3.9.zip";s:6:"locale";s:5:"pt_BR";s:8:"packages";O:8:"stdClass":5:{s:4:"full";s:63:"https://downloads.wordpress.org/release/pt_BR/wordpress-3.9.zip";s:10:"no_content";b:0;s:11:"new_bundled";b:0;s:7:"partial";b:0;s:8:"rollback";b:0;}s:7:"current";s:3:"3.9";s:7:"version";s:3:"3.9";s:11:"php_version";s:5:"5.2.4";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"3.8";s:15:"partial_version";s:0:"";}i:1;O:8:"stdClass":10:{s:8:"response";s:6:"latest";s:8:"download";s:57:"https://downloads.wordpress.org/release/wordpress-3.9.zip";s:6:"locale";s:5:"en_US";s:8:"packages";O:8:"stdClass":5:{s:4:"full";s:57:"https://downloads.wordpress.org/release/wordpress-3.9.zip";s:10:"no_content";b:0;s:11:"new_bundled";b:0;s:7:"partial";b:0;s:8:"rollback";b:0;}s:7:"current";s:3:"3.9";s:7:"version";s:3:"3.9";s:11:"php_version";s:5:"5.2.4";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"3.8";s:15:"partial_version";s:0:"";}}s:12:"last_checked";i:1398384390;s:15:"version_checked";s:3:"3.9";s:12:"translations";a:0:{}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('2661', 'can_compress_scripts', '1', 'yes'); 
INSERT INTO `wp_options` VALUES ('2665', 'category_children', 'a:0:{}', 'yes'); 
INSERT INTO `wp_options` VALUES ('2681', 'theme_mods_asug', 'a:3:{i:0;b:0;s:12:"header_image";s:69:"http://127.0.0.1/asug/wp-content/uploads/2014/03/copy-asug-brasil.jpg";s:17:"header_image_data";O:8:"stdClass":5:{s:13:"attachment_id";i:308;s:3:"url";s:69:"http://127.0.0.1/asug/wp-content/uploads/2014/03/copy-asug-brasil.jpg";s:13:"thumbnail_url";s:69:"http://127.0.0.1/asug/wp-content/uploads/2014/03/copy-asug-brasil.jpg";s:6:"height";i:76;s:5:"width";i:229;}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('3095', '_site_transient_timeout_poptags_40cd750bba9870f18aada2478b24840a', '1398222402', 'yes'); 
INSERT INTO `wp_options` VALUES ('3096', '_site_transient_poptags_40cd750bba9870f18aada2478b24840a', 'a:40:{s:6:"widget";a:3:{s:4:"name";s:6:"widget";s:4:"slug";s:6:"widget";s:5:"count";s:4:"3898";}s:4:"post";a:3:{s:4:"name";s:4:"Post";s:4:"slug";s:4:"post";s:5:"count";s:4:"2456";}s:6:"plugin";a:3:{s:4:"name";s:6:"plugin";s:4:"slug";s:6:"plugin";s:5:"count";s:4:"2344";}s:5:"admin";a:3:{s:4:"name";s:5:"admin";s:4:"slug";s:5:"admin";s:5:"count";s:4:"1930";}s:5:"posts";a:3:{s:4:"name";s:5:"posts";s:4:"slug";s:5:"posts";s:5:"count";s:4:"1856";}s:7:"sidebar";a:3:{s:4:"name";s:7:"sidebar";s:4:"slug";s:7:"sidebar";s:5:"count";s:4:"1583";}s:7:"twitter";a:3:{s:4:"name";s:7:"twitter";s:4:"slug";s:7:"twitter";s:5:"count";s:4:"1329";}s:6:"google";a:3:{s:4:"name";s:6:"google";s:4:"slug";s:6:"google";s:5:"count";s:4:"1325";}s:8:"comments";a:3:{s:4:"name";s:8:"comments";s:4:"slug";s:8:"comments";s:5:"count";s:4:"1310";}s:6:"images";a:3:{s:4:"name";s:6:"images";s:4:"slug";s:6:"images";s:5:"count";s:4:"1260";}s:4:"page";a:3:{s:4:"name";s:4:"page";s:4:"slug";s:4:"page";s:5:"count";s:4:"1225";}s:5:"image";a:3:{s:4:"name";s:5:"image";s:4:"slug";s:5:"image";s:5:"count";s:4:"1121";}s:9:"shortcode";a:3:{s:4:"name";s:9:"shortcode";s:4:"slug";s:9:"shortcode";s:5:"count";s:4:"1000";}s:8:"facebook";a:3:{s:4:"name";s:8:"Facebook";s:4:"slug";s:8:"facebook";s:5:"count";s:3:"982";}s:5:"links";a:3:{s:4:"name";s:5:"links";s:4:"slug";s:5:"links";s:5:"count";s:3:"974";}s:3:"seo";a:3:{s:4:"name";s:3:"seo";s:4:"slug";s:3:"seo";s:5:"count";s:3:"950";}s:9:"wordpress";a:3:{s:4:"name";s:9:"wordpress";s:4:"slug";s:9:"wordpress";s:5:"count";s:3:"844";}s:7:"gallery";a:3:{s:4:"name";s:7:"gallery";s:4:"slug";s:7:"gallery";s:5:"count";s:3:"821";}s:6:"social";a:3:{s:4:"name";s:6:"social";s:4:"slug";s:6:"social";s:5:"count";s:3:"780";}s:3:"rss";a:3:{s:4:"name";s:3:"rss";s:4:"slug";s:3:"rss";s:5:"count";s:3:"722";}s:7:"widgets";a:3:{s:4:"name";s:7:"widgets";s:4:"slug";s:7:"widgets";s:5:"count";s:3:"686";}s:6:"jquery";a:3:{s:4:"name";s:6:"jquery";s:4:"slug";s:6:"jquery";s:5:"count";s:3:"681";}s:5:"pages";a:3:{s:4:"name";s:5:"pages";s:4:"slug";s:5:"pages";s:5:"count";s:3:"678";}s:5:"email";a:3:{s:4:"name";s:5:"email";s:4:"slug";s:5:"email";s:5:"count";s:3:"623";}s:4:"ajax";a:3:{s:4:"name";s:4:"AJAX";s:4:"slug";s:4:"ajax";s:5:"count";s:3:"615";}s:5:"media";a:3:{s:4:"name";s:5:"media";s:4:"slug";s:5:"media";s:5:"count";s:3:"595";}s:10:"javascript";a:3:{s:4:"name";s:10:"javascript";s:4:"slug";s:10:"javascript";s:5:"count";s:3:"572";}s:5:"video";a:3:{s:4:"name";s:5:"video";s:4:"slug";s:5:"video";s:5:"count";s:3:"570";}s:10:"buddypress";a:3:{s:4:"name";s:10:"buddypress";s:4:"slug";s:10:"buddypress";s:5:"count";s:3:"541";}s:4:"feed";a:3:{s:4:"name";s:4:"feed";s:4:"slug";s:4:"feed";s:5:"count";s:3:"539";}s:7:"content";a:3:{s:4:"name";s:7:"content";s:4:"slug";s:7:"content";s:5:"count";s:3:"530";}s:5:"photo";a:3:{s:4:"name";s:5:"photo";s:4:"slug";s:5:"photo";s:5:"count";s:3:"522";}s:4:"link";a:3:{s:4:"name";s:4:"link";s:4:"slug";s:4:"link";s:5:"count";s:3:"506";}s:6:"photos";a:3:{s:4:"name";s:6:"photos";s:4:"slug";s:6:"photos";s:5:"count";s:3:"505";}s:5:"login";a:3:{s:4:"name";s:5:"login";s:4:"slug";s:5:"login";s:5:"count";s:3:"471";}s:4:"spam";a:3:{s:4:"name";s:4:"spam";s:4:"slug";s:4:"spam";s:5:"count";s:3:"458";}s:5:"stats";a:3:{s:4:"name";s:5:"stats";s:4:"slug";s:5:"stats";s:5:"count";s:3:"453";}s:8:"category";a:3:{s:4:"name";s:8:"category";s:4:"slug";s:8:"category";s:5:"count";s:3:"452";}s:7:"youtube";a:3:{s:4:"name";s:7:"youtube";s:4:"slug";s:7:"youtube";s:5:"count";s:3:"436";}s:7:"comment";a:3:{s:4:"name";s:7:"comment";s:4:"slug";s:7:"comment";s:5:"count";s:3:"432";}}', 'yes'); 
INSERT INTO `wp_options` VALUES ('3620', '_transient_is_multi_author', '0', 'yes'); 
INSERT INTO `wp_options` VALUES ('3638', '_transient_timeout_dfad_df0ZnbU', '1398384393', 'no'); 
INSERT INTO `wp_options` VALUES ('3639', '_transient_dfad_df0ZnbU', '1', 'no'); 
INSERT INTO `wp_options` VALUES ('3640', '_transient_doing_cron', '1398384389.3232269287109375000000', 'yes'); 
INSERT INTO `wp_options` VALUES ('3642', '_transient_timeout_dfad_dfj82Ba', '1398384395', 'no'); 
INSERT INTO `wp_options` VALUES ('3643', '_transient_dfad_dfj82Ba', '1', 'no'); 
INSERT INTO `wp_options` VALUES ('3644', 'auto_updater.lock', '1398384391', 'no'); 
INSERT INTO `wp_options` VALUES ('3648', '_site_transient_timeout_theme_roots', '1398386194', 'yes'); 
INSERT INTO `wp_options` VALUES ('3649', '_site_transient_theme_roots', 'a:1:{s:4:"asug";s:7:"/themes";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('3650', 'rewrite_rules', 'a:170:{s:28:"eventos/(\d{4}-\d{2}-\d{2})$";s:52:"index.php?pagename=eventos/&calendar_day=$matches[1]";s:14:"eventos/rss/?$";s:35:"index.php?post_type=event&feed=feed";s:15:"eventos/feed/?$";s:35:"index.php?post_type=event&feed=feed";s:19:"eventos/event/(.+)$";s:64:"index.php?pagename=eventos/&em_redirect=1&event_slug=$matches[1]";s:22:"eventos/location/(.+)$";s:67:"index.php?pagename=eventos/&em_redirect=1&location_slug=$matches[1]";s:22:"eventos/category/(.+)$";s:67:"index.php?pagename=eventos/&em_redirect=1&category_slug=$matches[1]";s:10:"eventos/?$";s:26:"index.php?pagename=eventos";s:22:"events/([^/]+)/ical/?$";s:34:"index.php?event=$matches[1]&ical=1";s:25:"locations/([^/]+)/ical/?$";s:37:"index.php?location=$matches[1]&ical=1";s:33:"events/categories/([^/]+)/ical/?$";s:45:"index.php?event-categories=$matches[1]&ical=1";s:27:"events/tags/([^/]+)/ical/?$";s:39:"index.php?event-tags=$matches[1]&ical=1";s:24:"locations/([^/]+)/rss/?$";s:36:"index.php?location=$matches[1]&rss=1";s:34:"sitemap(-+([a-zA-Z0-9_-]+))?\.xml$";s:40:"index.php?xml_sitemap=params=$matches[2]";s:38:"sitemap(-+([a-zA-Z0-9_-]+))?\.xml\.gz$";s:49:"index.php?xml_sitemap=params=$matches[2];zip=true";s:35:"sitemap(-+([a-zA-Z0-9_-]+))?\.html$";s:50:"index.php?xml_sitemap=params=$matches[2];html=true";s:38:"sitemap(-+([a-zA-Z0-9_-]+))?\.html.gz$";s:59:"index.php?xml_sitemap=params=$matches[2];html=true;zip=true";s:12:"locations/?$";s:28:"index.php?post_type=location";s:42:"locations/feed/(feed|rdf|rss|rss2|atom)/?$";s:45:"index.php?post_type=location&feed=$matches[1]";s:37:"locations/(feed|rdf|rss|rss2|atom)/?$";s:45:"index.php?post_type=location&feed=$matches[1]";s:29:"locations/page/([0-9]{1,})/?$";s:46:"index.php?post_type=location&paged=$matches[1]";s:9:"events/?$";s:25:"index.php?post_type=event";s:39:"events/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?post_type=event&feed=$matches[1]";s:34:"events/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?post_type=event&feed=$matches[1]";s:26:"events/page/([0-9]{1,})/?$";s:43:"index.php?post_type=event&paged=$matches[1]";s:47:"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:42:"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:35:"category/(.+?)/page/?([0-9]{1,})/?$";s:53:"index.php?category_name=$matches[1]&paged=$matches[2]";s:17:"category/(.+?)/?$";s:35:"index.php?category_name=$matches[1]";s:44:"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:39:"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:32:"tag/([^/]+)/page/?([0-9]{1,})/?$";s:43:"index.php?tag=$matches[1]&paged=$matches[2]";s:14:"tag/([^/]+)/?$";s:25:"index.php?tag=$matches[1]";s:45:"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:40:"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:33:"type/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?post_format=$matches[1]&paged=$matches[2]";s:15:"type/([^/]+)/?$";s:33:"index.php?post_format=$matches[1]";s:52:"events/tags/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?event-tags=$matches[1]&feed=$matches[2]";s:47:"events/tags/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?event-tags=$matches[1]&feed=$matches[2]";s:40:"events/tags/([^/]+)/page/?([0-9]{1,})/?$";s:50:"index.php?event-tags=$matches[1]&paged=$matches[2]";s:22:"events/tags/([^/]+)/?$";s:32:"index.php?event-tags=$matches[1]";s:56:"events/categories/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:55:"index.php?event-categories=$matches[1]&feed=$matches[2]";s:51:"events/categories/(.+?)/(feed|rdf|rss|rss2|atom)/?$";s:55:"index.php?event-categories=$matches[1]&feed=$matches[2]";s:44:"events/categories/(.+?)/page/?([0-9]{1,})/?$";s:56:"index.php?event-categories=$matches[1]&paged=$matches[2]";s:26:"events/categories/(.+?)/?$";s:38:"index.php?event-categories=$matches[1]";s:37:"locations/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:47:"locations/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:67:"locations/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:62:"locations/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:62:"locations/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:30:"locations/([^/]+)/trackback/?$";s:35:"index.php?location=$matches[1]&tb=1";s:50:"locations/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?location=$matches[1]&feed=$matches[2]";s:45:"locations/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?location=$matches[1]&feed=$matches[2]";s:38:"locations/([^/]+)/page/?([0-9]{1,})/?$";s:48:"index.php?location=$matches[1]&paged=$matches[2]";s:45:"locations/([^/]+)/comment-page-([0-9]{1,})/?$";s:48:"index.php?location=$matches[1]&cpage=$matches[2]";s:33:"locations/([^/]+)/ajax(/(.*))?/?$";s:47:"index.php?location=$matches[1]&ajax=$matches[3]";s:30:"locations/([^/]+)(/[0-9]+)?/?$";s:47:"index.php?location=$matches[1]&page=$matches[2]";s:26:"locations/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:36:"locations/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:56:"locations/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:51:"locations/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:51:"locations/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:34:"events/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:44:"events/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:64:"events/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:59:"events/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:59:"events/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:27:"events/([^/]+)/trackback/?$";s:32:"index.php?event=$matches[1]&tb=1";s:47:"events/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:44:"index.php?event=$matches[1]&feed=$matches[2]";s:42:"events/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:44:"index.php?event=$matches[1]&feed=$matches[2]";s:35:"events/([^/]+)/page/?([0-9]{1,})/?$";s:45:"index.php?event=$matches[1]&paged=$matches[2]";s:42:"events/([^/]+)/comment-page-([0-9]{1,})/?$";s:45:"index.php?event=$matches[1]&cpage=$matches[2]";s:30:"events/([^/]+)/ajax(/(.*))?/?$";s:44:"index.php?event=$matches[1]&ajax=$matches[3]";s:27:"events/([^/]+)(/[0-9]+)?/?$";s:44:"index.php?event=$matches[1]&page=$matches[2]";s:23:"events/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:33:"events/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:53:"events/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:48:"events/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:48:"events/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:44:"events-recurring/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:54:"events-recurring/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:74:"events-recurring/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:69:"events-recurring/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:69:"events-recurring/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:37:"events-recurring/([^/]+)/trackback/?$";s:42:"index.php?event-recurring=$matches[1]&tb=1";s:45:"events-recurring/([^/]+)/page/?([0-9]{1,})/?$";s:55:"index.php?event-recurring=$matches[1]&paged=$matches[2]";s:52:"events-recurring/([^/]+)/comment-page-([0-9]{1,})/?$";s:55:"index.php?event-recurring=$matches[1]&cpage=$matches[2]";s:40:"events-recurring/([^/]+)/ajax(/(.*))?/?$";s:54:"index.php?event-recurring=$matches[1]&ajax=$matches[3]";s:37:"events-recurring/([^/]+)(/[0-9]+)?/?$";s:54:"index.php?event-recurring=$matches[1]&page=$matches[2]";s:33:"events-recurring/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:43:"events-recurring/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:63:"events-recurring/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:58:"events-recurring/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:58:"events-recurring/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:52:"dfads_group/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?dfads_group=$matches[1]&feed=$matches[2]";s:47:"dfads_group/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?dfads_group=$matches[1]&feed=$matches[2]";s:40:"dfads_group/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?dfads_group=$matches[1]&paged=$matches[2]";s:22:"dfads_group/([^/]+)/?$";s:33:"index.php?dfads_group=$matches[1]";s:40:"wpbu_backups/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:50:"wpbu_backups/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:70:"wpbu_backups/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:65:"wpbu_backups/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:65:"wpbu_backups/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:33:"wpbu_backups/([^/]+)/trackback/?$";s:54:"index.php?post_type=wpbu_backups&name=$matches[1]&tb=1";s:41:"wpbu_backups/([^/]+)/page/?([0-9]{1,})/?$";s:67:"index.php?post_type=wpbu_backups&name=$matches[1]&paged=$matches[2]";s:48:"wpbu_backups/([^/]+)/comment-page-([0-9]{1,})/?$";s:67:"index.php?post_type=wpbu_backups&name=$matches[1]&cpage=$matches[2]";s:36:"wpbu_backups/([^/]+)/ajax(/(.*))?/?$";s:66:"index.php?post_type=wpbu_backups&name=$matches[1]&ajax=$matches[3]";s:33:"wpbu_backups/([^/]+)(/[0-9]+)?/?$";s:66:"index.php?post_type=wpbu_backups&name=$matches[1]&page=$matches[2]";s:29:"wpbu_backups/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:39:"wpbu_backups/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:59:"wpbu_backups/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:54:"wpbu_backups/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:54:"wpbu_backups/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:48:".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\.php$";s:18:"index.php?feed=old";s:20:".*wp-app\.php(/.*)?$";s:19:"index.php?error=403";s:18:".*wp-register.php$";s:23:"index.php?register=true";s:32:"feed/(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:27:"(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:20:"page/?([0-9]{1,})/?$";s:28:"index.php?&paged=$matches[1]";s:27:"comment-page-([0-9]{1,})/?$";s:38:"index.php?&page_id=2&cpage=$matches[1]";s:41:"comments/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:36:"comments/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:44:"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:39:"search/(.+)/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:32:"search/(.+)/page/?([0-9]{1,})/?$";s:41:"index.php?s=$matches[1]&paged=$matches[2]";s:14:"search/(.+)/?$";s:23:"index.php?s=$matches[1]";s:47:"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:42:"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:35:"author/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?author_name=$matches[1]&paged=$matches[2]";s:17:"author/([^/]+)/?$";s:33:"index.php?author_name=$matches[1]";s:69:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:64:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:57:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:81:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]";s:39:"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$";s:63:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]";s:56:"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:51:"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:44:"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:65:"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]";s:26:"([0-9]{4})/([0-9]{1,2})/?$";s:47:"index.php?year=$matches[1]&monthnum=$matches[2]";s:43:"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:38:"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:31:"([0-9]{4})/page/?([0-9]{1,})/?$";s:44:"index.php?year=$matches[1]&paged=$matches[2]";s:13:"([0-9]{4})/?$";s:26:"index.php?year=$matches[1]";s:27:".?.+?/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:37:".?.+?/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:57:".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:20:"(.?.+?)/trackback/?$";s:35:"index.php?pagename=$matches[1]&tb=1";s:40:"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:35:"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:28:"(.?.+?)/page/?([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&paged=$matches[2]";s:35:"(.?.+?)/comment-page-([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&cpage=$matches[2]";s:23:"(.?.+?)/ajax(/(.*))?/?$";s:47:"index.php?pagename=$matches[1]&ajax=$matches[3]";s:20:"(.?.+?)(/[0-9]+)?/?$";s:47:"index.php?pagename=$matches[1]&page=$matches[2]";s:27:"[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:37:"[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:57:"[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:"[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:52:"[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:20:"([^/]+)/trackback/?$";s:31:"index.php?name=$matches[1]&tb=1";s:40:"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?name=$matches[1]&feed=$matches[2]";s:35:"([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?name=$matches[1]&feed=$matches[2]";s:28:"([^/]+)/page/?([0-9]{1,})/?$";s:44:"index.php?name=$matches[1]&paged=$matches[2]";s:35:"([^/]+)/comment-page-([0-9]{1,})/?$";s:44:"index.php?name=$matches[1]&cpage=$matches[2]";s:23:"([^/]+)/ajax(/(.*))?/?$";s:43:"index.php?name=$matches[1]&ajax=$matches[3]";s:20:"([^/]+)(/[0-9]+)?/?$";s:43:"index.php?name=$matches[1]&page=$matches[2]";s:16:"[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:26:"[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:46:"[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:41:"[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:41:"[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";}', 'yes'); 
INSERT INTO `wp_options` VALUES ('3652', '_site_transient_update_plugins', 'O:8:"stdClass":1:{s:12:"last_checked";i:1398384396;}', 'yes'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_postmeta`
--
DROP TABLE IF EXISTS `wp_postmeta`;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB AUTO_INCREMENT=1045 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_postmeta`
--
LOCK TABLES `wp_postmeta` WRITE;
INSERT INTO `wp_postmeta` VALUES ('1', '2', '_wp_page_template', 'page-templates/front-page.php'); 
INSERT INTO `wp_postmeta` VALUES ('2', '4', '_form', '<p>Seu nome (obrigatório)<br />
    [text* your-name] </p>

<p>Seu e-mail (obrigatório)<br />
    [email* your-email] </p>

<p>Assunto<br />
    [text your-subject] </p>

<p>Sua mensagem<br />
    [textarea your-message] </p>

<p>[submit "Enviar"]</p>'); 
INSERT INTO `wp_postmeta` VALUES ('3', '4', '_mail', 'a:7:{s:7:"subject";s:14:"[your-subject]";s:6:"sender";s:26:"[your-name] <[your-email]>";s:4:"body";s:201:"De: [your-name] <[your-email]>
Assunto: [your-subject]

Corpo da mensagem:
[your-message]

--
Este e-mail foi enviado de um formulário de contato em Asug | SAP NetWeaver Portal (http://127.0.0.1/asug)";s:9:"recipient";s:24:"felipe@montarsite.com.br";s:18:"additional_headers";s:0:"";s:11:"attachments";s:0:"";s:8:"use_html";b:0;}'); 
INSERT INTO `wp_postmeta` VALUES ('4', '4', '_mail_2', 'a:8:{s:6:"active";b:0;s:7:"subject";s:14:"[your-subject]";s:6:"sender";s:26:"[your-name] <[your-email]>";s:4:"body";s:145:"Corpo da mensagem:
[your-message]

--
Este e-mail foi enviado de um formulário de contato em Asug | SAP NetWeaver Portal (http://127.0.0.1/asug)";s:9:"recipient";s:12:"[your-email]";s:18:"additional_headers";s:0:"";s:11:"attachments";s:0:"";s:8:"use_html";b:0;}'); 
INSERT INTO `wp_postmeta` VALUES ('5', '4', '_messages', 'a:21:{s:12:"mail_sent_ok";s:47:"Sua mensagem foi enviada com sucesso. Obrigado.";s:12:"mail_sent_ng";s:115:"Não foi possível enviar a sua mensagem. Por favor, tente mais tarde ou contate o administrador por outro método.";s:16:"validation_error";s:77:"Ocorreram erros de validação. Por favor confira os dados e envie novamente.";s:4:"spam";s:115:"Não foi possível enviar a sua mensagem. Por favor, tente mais tarde ou contate o administrador por outro método.";s:12:"accept_terms";s:43:"Por favor aceite os termos para prosseguir.";s:16:"invalid_required";s:43:"Por favor preencha este campo obrigatório.";s:17:"captcha_not_match";s:35:"O código digitado está incorreto.";s:14:"invalid_number";s:36:"Formato de número parece inválido.";s:16:"number_too_small";s:30:"Este número é muito pequeno.";s:16:"number_too_large";s:29:"Este número é muito grande.";s:13:"invalid_email";s:39:"O endereço de e-mail parece inválido.";s:11:"invalid_url";s:21:"URL parece inválido.";s:11:"invalid_tel";s:26:"Telefone parece inválido.";s:23:"quiz_answer_not_correct";s:29:"Sua resposta está incorreta.";s:12:"invalid_date";s:33:"Formato da data parece inválido.";s:14:"date_too_early";s:32:"Esta data é demasiado primeira.";s:13:"date_too_late";s:29:"Esta data é demasiado tarde.";s:13:"upload_failed";s:27:"Falha no upload do arquivo.";s:24:"upload_file_type_invalid";s:39:"Este tipo de arquivo não é permitido.";s:21:"upload_file_too_large";s:30:"Este arquivo é grande demais.";s:23:"upload_failed_php_error";s:27:"Falha no upload do arquivo.";}'); 
INSERT INTO `wp_postmeta` VALUES ('6', '4', '_additional_settings', ''); 
INSERT INTO `wp_postmeta` VALUES ('7', '4', '_locale', 'pt_BR'); 
INSERT INTO `wp_postmeta` VALUES ('8', '2', '_edit_lock', '1398214009:1'); 
INSERT INTO `wp_postmeta` VALUES ('9', '2', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('11', '6', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('12', '6', '_edit_lock', '1394901177:1'); 
INSERT INTO `wp_postmeta` VALUES ('13', '6', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('14', '6', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('15', '8', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('16', '8', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('18', '8', '_edit_lock', '1394901197:1'); 
INSERT INTO `wp_postmeta` VALUES ('19', '10', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('20', '10', '_edit_lock', '1394901225:1'); 
INSERT INTO `wp_postmeta` VALUES ('21', '10', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('22', '10', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('23', '12', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('24', '12', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('25', '12', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('26', '12', '_edit_lock', '1394901239:1'); 
INSERT INTO `wp_postmeta` VALUES ('27', '14', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('28', '14', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('29', '14', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('30', '14', '_edit_lock', '1394901253:1'); 
INSERT INTO `wp_postmeta` VALUES ('31', '16', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('32', '16', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('33', '16', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('34', '16', '_edit_lock', '1394901293:1'); 
INSERT INTO `wp_postmeta` VALUES ('35', '18', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('36', '18', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('37', '18', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('38', '18', '_edit_lock', '1394901318:1'); 
INSERT INTO `wp_postmeta` VALUES ('39', '20', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('40', '20', '_wp_page_template', 'page-templates/sidebar-direita.php'); 
INSERT INTO `wp_postmeta` VALUES ('41', '20', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('42', '20', '_edit_lock', '1397330428:1'); 
INSERT INTO `wp_postmeta` VALUES ('43', '22', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('44', '22', '_wp_page_template', 'page-templates/asug-news.php'); 
INSERT INTO `wp_postmeta` VALUES ('45', '22', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('46', '22', '_edit_lock', '1397330425:1'); 
INSERT INTO `wp_postmeta` VALUES ('146', '35', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('147', '35', '_edit_lock', '1394901437:1'); 
INSERT INTO `wp_postmeta` VALUES ('148', '35', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('149', '35', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('150', '37', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('151', '37', '_edit_lock', '1395346601:1'); 
INSERT INTO `wp_postmeta` VALUES ('152', '37', '_wp_page_template', 'page-templates/sidebar-esquerda.php'); 
INSERT INTO `wp_postmeta` VALUES ('153', '37', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('154', '39', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('155', '39', '_wp_page_template', 'page-templates/tres-colunas.php'); 
INSERT INTO `wp_postmeta` VALUES ('157', '39', '_edit_lock', '1396565962:1'); 
INSERT INTO `wp_postmeta` VALUES ('158', '41', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('159', '41', '_edit_lock', '1395343282:1'); 
INSERT INTO `wp_postmeta` VALUES ('160', '41', '_wp_page_template', 'page-templates/sidebar-direita.php'); 
INSERT INTO `wp_postmeta` VALUES ('161', '41', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('162', '43', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('163', '43', '_edit_lock', '1395343283:1'); 
INSERT INTO `wp_postmeta` VALUES ('164', '43', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('165', '43', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('166', '45', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('167', '45', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('168', '45', '_menu_item_object_id', '2'); 
INSERT INTO `wp_postmeta` VALUES ('169', '45', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('170', '45', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('171', '45', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('172', '45', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('173', '45', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('184', '47', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('185', '47', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('186', '47', '_menu_item_object_id', '8'); 
INSERT INTO `wp_postmeta` VALUES ('187', '47', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('188', '47', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('189', '47', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('190', '47', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('191', '47', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('193', '48', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('194', '48', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('195', '48', '_menu_item_object_id', '20'); 
INSERT INTO `wp_postmeta` VALUES ('196', '48', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('197', '48', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('198', '48', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('199', '48', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('200', '48', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('202', '49', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('203', '49', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('204', '49', '_menu_item_object_id', '22'); 
INSERT INTO `wp_postmeta` VALUES ('205', '49', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('206', '49', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('207', '49', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('208', '49', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('209', '49', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('211', '50', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('212', '50', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('213', '50', '_menu_item_object_id', '16'); 
INSERT INTO `wp_postmeta` VALUES ('214', '50', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('215', '50', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('216', '50', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('217', '50', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('218', '50', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('247', '54', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('248', '54', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('249', '54', '_menu_item_object_id', '18'); 
INSERT INTO `wp_postmeta` VALUES ('250', '54', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('251', '54', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('252', '54', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('253', '54', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('254', '54', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('265', '56', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('266', '56', '_menu_item_menu_item_parent', '249'); 
INSERT INTO `wp_postmeta` VALUES ('267', '56', '_menu_item_object_id', '39'); 
INSERT INTO `wp_postmeta` VALUES ('268', '56', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('269', '56', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('270', '56', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('271', '56', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('272', '56', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('274', '57', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('275', '57', '_menu_item_menu_item_parent', '249'); 
INSERT INTO `wp_postmeta` VALUES ('276', '57', '_menu_item_object_id', '37'); 
INSERT INTO `wp_postmeta` VALUES ('277', '57', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('278', '57', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('279', '57', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('280', '57', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('281', '57', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('283', '58', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('284', '58', '_menu_item_menu_item_parent', '249'); 
INSERT INTO `wp_postmeta` VALUES ('285', '58', '_menu_item_object_id', '35'); 
INSERT INTO `wp_postmeta` VALUES ('286', '58', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('287', '58', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('288', '58', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('289', '58', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('290', '58', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('292', '59', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('293', '59', '_menu_item_menu_item_parent', '249'); 
INSERT INTO `wp_postmeta` VALUES ('294', '59', '_menu_item_object_id', '41'); 
INSERT INTO `wp_postmeta` VALUES ('295', '59', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('296', '59', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('297', '59', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('298', '59', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('299', '59', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('301', '60', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('302', '60', '_menu_item_menu_item_parent', '249'); 
INSERT INTO `wp_postmeta` VALUES ('303', '60', '_menu_item_object_id', '43'); 
INSERT INTO `wp_postmeta` VALUES ('304', '60', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('305', '60', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('306', '60', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('307', '60', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('308', '60', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('310', '61', '_wp_attached_file', '2014/03/asug-brasil.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('311', '61', '_wp_attachment_context', 'custom-header'); 
INSERT INTO `wp_postmeta` VALUES ('312', '61', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:229;s:6:"height";i:76;s:4:"file";s:23:"2014/03/asug-brasil.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:5:{s:4:"file";s:22:"asug-brasil-150x76.jpg";s:5:"width";i:150;s:6:"height";i:76;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('313', '61', '_wp_attachment_is_custom_header', 'twentytwelve'); 
INSERT INTO `wp_postmeta` VALUES ('314', '63', '_wp_attached_file', '2014/03/slider.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('315', '63', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:542;s:6:"height";i:250;s:4:"file";s:18:"2014/03/slider.jpg";s:5:"sizes";a:2:{s:9:"thumbnail";a:5:{s:4:"file";s:18:"slider-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:18:"slider-300x138.jpg";s:5:"width";i:300;s:6:"height";i:138;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('316', '64', '_wp_attached_file', '2014/03/banner03.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('317', '64', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:235;s:6:"height";i:121;s:4:"file";s:20:"2014/03/banner03.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:5:{s:4:"file";s:20:"banner03-150x121.jpg";s:5:"width";i:150;s:6:"height";i:121;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('318', '65', '_wp_attached_file', '2014/03/banner04.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('319', '65', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:235;s:6:"height";i:121;s:4:"file";s:20:"2014/03/banner04.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:5:{s:4:"file";s:20:"banner04-150x121.jpg";s:5:"width";i:150;s:6:"height";i:121;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('320', '66', '_wp_attached_file', '2014/03/banner01.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('321', '66', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:235;s:6:"height";i:122;s:4:"file";s:20:"2014/03/banner01.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:5:{s:4:"file";s:20:"banner01-150x122.jpg";s:5:"width";i:150;s:6:"height";i:122;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('322', '67', '_wp_attached_file', '2014/03/banner02.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('323', '67', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:234;s:6:"height";i:122;s:4:"file";s:20:"2014/03/banner02.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:5:{s:4:"file";s:20:"banner02-150x122.jpg";s:5:"width";i:150;s:6:"height";i:122;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('324', '68', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('325', '68', '_edit_lock', '1394950263:1'); 
INSERT INTO `wp_postmeta` VALUES ('326', '68', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('327', '68', '_dfads_start_date', '1394928000'); 
INSERT INTO `wp_postmeta` VALUES ('328', '68', '_dfads_end_date', '1430352000'); 
INSERT INTO `wp_postmeta` VALUES ('329', '68', '_dfads_impression_limit', '90000'); 
INSERT INTO `wp_postmeta` VALUES ('330', '68', '_dfads_impression_count', '459'); 
INSERT INTO `wp_postmeta` VALUES ('331', '70', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('332', '70', '_edit_lock', '1394950319:1'); 
INSERT INTO `wp_postmeta` VALUES ('333', '70', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('334', '70', '_dfads_impression_limit', '0'); 
INSERT INTO `wp_postmeta` VALUES ('335', '70', '_dfads_impression_count', '458'); 
INSERT INTO `wp_postmeta` VALUES ('336', '72', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('337', '72', '_edit_lock', '1394950356:1'); 
INSERT INTO `wp_postmeta` VALUES ('338', '72', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('339', '72', '_dfads_impression_limit', '0'); 
INSERT INTO `wp_postmeta` VALUES ('340', '74', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('341', '74', '_edit_lock', '1395233203:1'); 
INSERT INTO `wp_postmeta` VALUES ('342', '74', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('343', '74', '_dfads_impression_limit', '0'); 
INSERT INTO `wp_postmeta` VALUES ('344', '72', '_dfads_impression_count', '457'); 
INSERT INTO `wp_postmeta` VALUES ('345', '74', '_dfads_impression_count', '457'); 
INSERT INTO `wp_postmeta` VALUES ('346', '76', '_menu_item_type', 'custom'); 
INSERT INTO `wp_postmeta` VALUES ('347', '76', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('348', '76', '_menu_item_object_id', '76'); 
INSERT INTO `wp_postmeta` VALUES ('349', '76', '_menu_item_object', 'custom'); 
INSERT INTO `wp_postmeta` VALUES ('350', '76', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('351', '76', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('352', '76', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('353', '76', '_menu_item_url', '#'); 
INSERT INTO `wp_postmeta` VALUES ('355', '77', '_wp_attached_file', '2014/03/eventos01.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('356', '77', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:149;s:6:"height";i:90;s:4:"file";s:21:"2014/03/eventos01.jpg";s:5:"sizes";a:0:{}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('357', '78', '_wp_attached_file', '2014/03/eventos02.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('358', '78', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:149;s:6:"height";i:90;s:4:"file";s:21:"2014/03/eventos02.jpg";s:5:"sizes";a:0:{}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('359', '1', '_edit_lock', '1395013435:1'); 
INSERT INTO `wp_postmeta` VALUES ('360', '86', '_wp_attached_file', '2014/03/eventos011.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('361', '86', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:149;s:6:"height";i:90;s:4:"file";s:22:"2014/03/eventos011.jpg";s:5:"sizes";a:0:{}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('362', '87', '_wp_attached_file', '2014/03/eventos021.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('363', '87', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:149;s:6:"height";i:90;s:4:"file";s:22:"2014/03/eventos021.jpg";s:5:"sizes";a:0:{}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('364', '1', '_thumbnail_id', '87'); 
INSERT INTO `wp_postmeta` VALUES ('365', '1', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('368', '1', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('369', '1', '_wp_old_slug', 'ola-mundo'); 
INSERT INTO `wp_postmeta` VALUES ('370', '90', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('371', '90', '_edit_lock', '1395013464:1'); 
INSERT INTO `wp_postmeta` VALUES ('372', '90', '_thumbnail_id', '86'); 
INSERT INTO `wp_postmeta` VALUES ('375', '90', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('376', '92', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('377', '92', '_edit_lock', '1395013492:1'); 
INSERT INTO `wp_postmeta` VALUES ('378', '92', '_thumbnail_id', '77'); 
INSERT INTO `wp_postmeta` VALUES ('381', '92', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('382', '94', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('383', '94', '_edit_lock', '1395608972:1'); 
INSERT INTO `wp_postmeta` VALUES ('384', '94', '_thumbnail_id', '78'); 
INSERT INTO `wp_postmeta` VALUES ('387', '94', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('393', '117', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395343555.zip'); 
INSERT INTO `wp_postmeta` VALUES ('394', '117', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('395', '117', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('396', '117', 'backup_size', '0.17 MB'); 
INSERT INTO `wp_postmeta` VALUES ('397', '118', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395343586.zip'); 
INSERT INTO `wp_postmeta` VALUES ('398', '118', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('399', '118', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('400', '118', 'backup_size', '0.17 MB'); 
INSERT INTO `wp_postmeta` VALUES ('401', '119', '_wp_attached_file', '2014/03/banner.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('402', '119', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1019;s:6:"height";i:248;s:4:"file";s:18:"2014/03/banner.jpg";s:5:"sizes";a:6:{s:9:"thumbnail";a:5:{s:4:"file";s:18:"banner-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:17:"banner-300x73.jpg";s:5:"width";i:300;s:6:"height";i:73;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"shop_thumbnail";a:5:{s:4:"file";s:16:"banner-90x90.jpg";s:5:"width";i:90;s:6:"height";i:90;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:12:"shop_catalog";a:5:{s:4:"file";s:18:"banner-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:10:"No savings";}s:11:"shop_single";a:5:{s:4:"file";s:18:"banner-300x248.jpg";s:5:"width";i:300;s:6:"height";i:248;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:18:"banner-624x151.jpg";s:5:"width";i:624;s:6:"height";i:151;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('404', '39', '_thumbnail_id', '119'); 
INSERT INTO `wp_postmeta` VALUES ('405', '120', '_wp_attached_file', '2014/03/banner_comite.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('406', '120', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1019;s:6:"height";i:248;s:4:"file";s:25:"2014/03/banner_comite.jpg";s:5:"sizes";a:6:{s:9:"thumbnail";a:5:{s:4:"file";s:25:"banner_comite-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:24:"banner_comite-300x73.jpg";s:5:"width";i:300;s:6:"height";i:73;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"shop_thumbnail";a:5:{s:4:"file";s:23:"banner_comite-90x90.jpg";s:5:"width";i:90;s:6:"height";i:90;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:12:"shop_catalog";a:5:{s:4:"file";s:25:"banner_comite-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:10:"No savings";}s:11:"shop_single";a:5:{s:4:"file";s:25:"banner_comite-300x248.jpg";s:5:"width";i:300;s:6:"height";i:248;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:25:"banner_comite-624x151.jpg";s:5:"width";i:624;s:6:"height";i:151;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('408', '123', '_wp_attached_file', '2014/03/banner1.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('409', '123', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1019;s:6:"height";i:248;s:4:"file";s:19:"2014/03/banner1.jpg";s:5:"sizes";a:6:{s:9:"thumbnail";a:5:{s:4:"file";s:19:"banner1-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:18:"banner1-300x73.jpg";s:5:"width";i:300;s:6:"height";i:73;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"shop_thumbnail";a:5:{s:4:"file";s:17:"banner1-90x90.jpg";s:5:"width";i:90;s:6:"height";i:90;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:12:"shop_catalog";a:5:{s:4:"file";s:19:"banner1-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:10:"No savings";}s:11:"shop_single";a:5:{s:4:"file";s:19:"banner1-300x248.jpg";s:5:"width";i:300;s:6:"height";i:248;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:19:"banner1-624x151.jpg";s:5:"width";i:624;s:6:"height";i:151;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('410', '124', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395431624.zip'); 
INSERT INTO `wp_postmeta` VALUES ('411', '124', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('412', '124', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('413', '124', 'backup_size', '0.21 MB'); 
INSERT INTO `wp_postmeta` VALUES ('414', '126', '_wp_attached_file', '2014/03/sua_fatura_de_energia_mesref_2014031.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('415', '126', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('416', '127', '_wp_attached_file', '2014/03/sua_fatura_de_energia_mesref_2014032.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('417', '127', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('418', '128', '_wp_attached_file', '2014/03/sua_fatura_de_energia_mesref_2014033.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('419', '128', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('420', '129', '_wp_attached_file', '2014/03/sua_fatura_de_energia_mesref_2014034.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('421', '129', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('422', '130', '_wp_attached_file', '2014/03/sua_fatura_de_energia_mesref_2014035.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('423', '130', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('424', '131', '_wp_attached_file', '2014/03/sua_fatura_de_energia_mesref_2014036.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('425', '131', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('426', '132', '_wp_attached_file', '2014/03/sua_fatura_de_energia_mesref_2014037.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('427', '132', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('428', '133', '_wp_attached_file', '2014/03/sua_fatura_de_energia_mesref_2014038.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('429', '133', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('430', '134', '_wp_attached_file', '2014/03/wireframe-interna-ASUG.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('431', '134', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('432', '135', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395596264.zip'); 
INSERT INTO `wp_postmeta` VALUES ('433', '135', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('434', '135', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('435', '135', 'backup_size', '0.21 MB'); 
INSERT INTO `wp_postmeta` VALUES ('436', '136', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395602764.zip'); 
INSERT INTO `wp_postmeta` VALUES ('437', '136', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('438', '136', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('439', '136', 'backup_size', '0.22 MB'); 
INSERT INTO `wp_postmeta` VALUES ('440', '137', '_edit_lock', '1397591990:1'); 
INSERT INTO `wp_postmeta` VALUES ('441', '137', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('442', '137', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('443', '137', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('444', '150', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395700838.zip'); 
INSERT INTO `wp_postmeta` VALUES ('445', '150', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('446', '150', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('447', '150', 'backup_size', '0.22 MB'); 
INSERT INTO `wp_postmeta` VALUES ('448', '153', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('449', '153', '_edit_lock', '1395714047:1'); 
INSERT INTO `wp_postmeta` VALUES ('450', '154', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('451', '154', '_location_id', '1'); 
INSERT INTO `wp_postmeta` VALUES ('452', '154', '_blog_id', ''); 
INSERT INTO `wp_postmeta` VALUES ('453', '154', '_location_address', 'Av Goias'); 
INSERT INTO `wp_postmeta` VALUES ('454', '154', '_location_town', 'São Caetano do Sul'); 
INSERT INTO `wp_postmeta` VALUES ('455', '154', '_location_state', 'São Paulo'); 
INSERT INTO `wp_postmeta` VALUES ('456', '154', '_location_postcode', '09550051'); 
INSERT INTO `wp_postmeta` VALUES ('457', '154', '_location_region', 'ABC'); 
INSERT INTO `wp_postmeta` VALUES ('458', '154', '_location_country', 'BR'); 
INSERT INTO `wp_postmeta` VALUES ('459', '154', '_location_latitude', '-23.6195443'); 
INSERT INTO `wp_postmeta` VALUES ('460', '154', '_location_longitude', '-46.55090089999999'); 
INSERT INTO `wp_postmeta` VALUES ('461', '154', '_location_status', '1'); 
INSERT INTO `wp_postmeta` VALUES ('462', '153', '_event_id', '1'); 
INSERT INTO `wp_postmeta` VALUES ('463', '153', '_event_start_time', '00:15:00'); 
INSERT INTO `wp_postmeta` VALUES ('464', '153', '_event_end_time', '02:00:00'); 
INSERT INTO `wp_postmeta` VALUES ('465', '153', '_event_all_day', '1'); 
INSERT INTO `wp_postmeta` VALUES ('466', '153', '_event_start_date', '2014-03-24'); 
INSERT INTO `wp_postmeta` VALUES ('467', '153', '_event_end_date', '2014-03-31'); 
INSERT INTO `wp_postmeta` VALUES ('468', '153', '_event_rsvp', '1'); 
INSERT INTO `wp_postmeta` VALUES ('469', '153', '_event_rsvp_date', '2014-03-23'); 
INSERT INTO `wp_postmeta` VALUES ('470', '153', '_event_rsvp_time', '00:00:00'); 
INSERT INTO `wp_postmeta` VALUES ('471', '153', '_event_rsvp_spaces', '400'); 
INSERT INTO `wp_postmeta` VALUES ('472', '153', '_event_spaces', '6000'); 
INSERT INTO `wp_postmeta` VALUES ('473', '153', '_location_id', '4'); 
INSERT INTO `wp_postmeta` VALUES ('474', '153', '_recurrence_id', ''); 
INSERT INTO `wp_postmeta` VALUES ('475', '153', '_event_status', ''); 
INSERT INTO `wp_postmeta` VALUES ('476', '153', '_event_private', '0'); 
INSERT INTO `wp_postmeta` VALUES ('477', '153', '_event_date_created', ''); 
INSERT INTO `wp_postmeta` VALUES ('478', '153', '_event_date_modified', ''); 
INSERT INTO `wp_postmeta` VALUES ('479', '153', '_blog_id', ''); 
INSERT INTO `wp_postmeta` VALUES ('480', '153', '_group_id', '0'); 
INSERT INTO `wp_postmeta` VALUES ('481', '153', '_recurrence', '0'); 
INSERT INTO `wp_postmeta` VALUES ('482', '153', '_recurrence_interval', ''); 
INSERT INTO `wp_postmeta` VALUES ('483', '153', '_recurrence_freq', ''); 
INSERT INTO `wp_postmeta` VALUES ('484', '153', '_recurrence_days', '0'); 
INSERT INTO `wp_postmeta` VALUES ('485', '153', '_recurrence_byday', ''); 
INSERT INTO `wp_postmeta` VALUES ('486', '153', '_recurrence_byweekno', ''); 
INSERT INTO `wp_postmeta` VALUES ('487', '153', '_start_ts', '1395620100'); 
INSERT INTO `wp_postmeta` VALUES ('488', '153', '_end_ts', '1396231200'); 
INSERT INTO `wp_postmeta` VALUES ('489', '155', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('490', '155', '_location_id', '2'); 
INSERT INTO `wp_postmeta` VALUES ('491', '155', '_blog_id', ''); 
INSERT INTO `wp_postmeta` VALUES ('492', '155', '_location_address', 'Av Goias'); 
INSERT INTO `wp_postmeta` VALUES ('493', '155', '_location_town', 'São Caetano do Sul'); 
INSERT INTO `wp_postmeta` VALUES ('494', '155', '_location_state', 'São Paulo'); 
INSERT INTO `wp_postmeta` VALUES ('495', '155', '_location_postcode', '09550051'); 
INSERT INTO `wp_postmeta` VALUES ('496', '155', '_location_region', 'ABC'); 
INSERT INTO `wp_postmeta` VALUES ('497', '155', '_location_country', 'BR'); 
INSERT INTO `wp_postmeta` VALUES ('498', '155', '_location_latitude', '-23.6195443'); 
INSERT INTO `wp_postmeta` VALUES ('499', '155', '_location_longitude', '-46.55090089999999'); 
INSERT INTO `wp_postmeta` VALUES ('500', '155', '_location_status', '1'); 
INSERT INTO `wp_postmeta` VALUES ('501', '156', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('502', '156', '_location_id', '3'); 
INSERT INTO `wp_postmeta` VALUES ('503', '156', '_blog_id', ''); 
INSERT INTO `wp_postmeta` VALUES ('504', '156', '_location_address', 'Av Goias'); 
INSERT INTO `wp_postmeta` VALUES ('505', '156', '_location_town', 'São Caetano do Sul'); 
INSERT INTO `wp_postmeta` VALUES ('506', '156', '_location_state', 'São Paulo'); 
INSERT INTO `wp_postmeta` VALUES ('507', '156', '_location_postcode', '09550051'); 
INSERT INTO `wp_postmeta` VALUES ('508', '156', '_location_region', 'ABC'); 
INSERT INTO `wp_postmeta` VALUES ('509', '156', '_location_country', 'BR'); 
INSERT INTO `wp_postmeta` VALUES ('510', '156', '_location_latitude', '-23.6195443'); 
INSERT INTO `wp_postmeta` VALUES ('511', '156', '_location_longitude', '-46.55090089999999'); 
INSERT INTO `wp_postmeta` VALUES ('512', '156', '_location_status', '1'); 
INSERT INTO `wp_postmeta` VALUES ('513', '157', 'bwps_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('514', '157', '_location_id', '4'); 
INSERT INTO `wp_postmeta` VALUES ('515', '157', '_blog_id', ''); 
INSERT INTO `wp_postmeta` VALUES ('516', '157', '_location_address', 'Av Goias'); 
INSERT INTO `wp_postmeta` VALUES ('517', '157', '_location_town', 'São Caetano do Sul'); 
INSERT INTO `wp_postmeta` VALUES ('518', '157', '_location_state', 'São Paulo'); 
INSERT INTO `wp_postmeta` VALUES ('519', '157', '_location_postcode', '09550051'); 
INSERT INTO `wp_postmeta` VALUES ('520', '157', '_location_region', 'ABC'); 
INSERT INTO `wp_postmeta` VALUES ('521', '157', '_location_country', 'BR'); 
INSERT INTO `wp_postmeta` VALUES ('522', '157', '_location_latitude', '-23.6195443'); 
INSERT INTO `wp_postmeta` VALUES ('523', '157', '_location_longitude', '-46.55090089999999'); 
INSERT INTO `wp_postmeta` VALUES ('524', '157', '_location_status', '1'); 
INSERT INTO `wp_postmeta` VALUES ('525', '158', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395788465.zip'); 
INSERT INTO `wp_postmeta` VALUES ('526', '158', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('527', '158', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('528', '158', 'backup_size', '0.21 MB'); 
INSERT INTO `wp_postmeta` VALUES ('529', '159', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395870668.zip'); 
INSERT INTO `wp_postmeta` VALUES ('530', '159', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('531', '159', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('532', '159', 'backup_size', '0.21 MB'); 
INSERT INTO `wp_postmeta` VALUES ('533', '160', '_edit_lock', '1395889098:1'); 
INSERT INTO `wp_postmeta` VALUES ('534', '160', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('535', '160', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('536', '160', 'itsec_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('537', '2', 'itsec_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('538', '165', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1395953779.zip'); 
INSERT INTO `wp_postmeta` VALUES ('539', '165', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('540', '165', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('541', '165', 'backup_size', '0.22 MB'); 
INSERT INTO `wp_postmeta` VALUES ('542', '8', 'itsec_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('543', '39', 'itsec_enable_ssl', ''); 
INSERT INTO `wp_postmeta` VALUES ('545', '167', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1396115234.zip'); 
INSERT INTO `wp_postmeta` VALUES ('546', '167', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('547', '167', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('548', '167', 'backup_size', '0.21 MB'); 
INSERT INTO `wp_postmeta` VALUES ('552', '134', 'issuu_pdf_id', '140329182930-60a7a3782bd04be4987cb898e71b0cb2'); 
INSERT INTO `wp_postmeta` VALUES ('553', '134', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('554', '134', 'issuu_pdf_name', 'wireframe-interna-asug'); 
INSERT INTO `wp_postmeta` VALUES ('555', '133', 'issuu_pdf_id', '140329182930-5580d2df2ee443ce830e8fd4d0b684db'); 
INSERT INTO `wp_postmeta` VALUES ('556', '133', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('557', '133', 'issuu_pdf_name', 'sua_fatura_de_energia_mesref_201403-8'); 
INSERT INTO `wp_postmeta` VALUES ('558', '130', 'issuu_pdf_id', '140329182932-71deedcf1c65431eb83c022ec792d87b'); 
INSERT INTO `wp_postmeta` VALUES ('559', '130', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('560', '130', 'issuu_pdf_name', 'sua_fatura_de_energia_mesref_201403-5'); 
INSERT INTO `wp_postmeta` VALUES ('561', '129', 'issuu_pdf_id', '140329182932-b9b41240b5584226b5020b42823c2a2e'); 
INSERT INTO `wp_postmeta` VALUES ('562', '129', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('563', '129', 'issuu_pdf_name', 'sua_fatura_de_energia_mesref_201403-4'); 
INSERT INTO `wp_postmeta` VALUES ('564', '171', '_edit_lock', '1396118283:1'); 
INSERT INTO `wp_postmeta` VALUES ('566', '171', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('567', '171', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('568', '174', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('569', '174', '_edit_lock', '1396118607:1'); 
INSERT INTO `wp_postmeta` VALUES ('570', '174', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('571', '177', '_edit_lock', '1396118836:1'); 
INSERT INTO `wp_postmeta` VALUES ('572', '132', 'issuu_pdf_id', '140329184352-c2ef9e1b38b44ae79d02eaae2bec44a3'); 
INSERT INTO `wp_postmeta` VALUES ('573', '132', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('574', '132', 'issuu_pdf_name', 'sua_fatura_de_energia_mesref_201403-7'); 
INSERT INTO `wp_postmeta` VALUES ('575', '131', 'issuu_pdf_id', '140329184352-deb970e030f540988ab9de0fb6f2324b'); 
INSERT INTO `wp_postmeta` VALUES ('576', '131', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('577', '131', 'issuu_pdf_name', 'sua_fatura_de_energia_mesref_201403-6'); 
INSERT INTO `wp_postmeta` VALUES ('578', '128', 'issuu_pdf_id', '140329184353-f4610385d1dd4ee48f2a57cea537d97d'); 
INSERT INTO `wp_postmeta` VALUES ('579', '128', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('580', '128', 'issuu_pdf_name', 'sua_fatura_de_energia_mesref_201403-3'); 
INSERT INTO `wp_postmeta` VALUES ('581', '127', 'issuu_pdf_id', '140329184354-1aaffe4a132c4f69b027086e13d8167a'); 
INSERT INTO `wp_postmeta` VALUES ('582', '127', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('583', '127', 'issuu_pdf_name', 'sua_fatura_de_energia_mesref_201403-2'); 
INSERT INTO `wp_postmeta` VALUES ('584', '126', 'issuu_pdf_id', '140329184354-014ffdace3ef4d3a9bcf7bd60e3d3d0d'); 
INSERT INTO `wp_postmeta` VALUES ('585', '126', 'issuu_pdf_username', 'felipeaugustopita'); 
INSERT INTO `wp_postmeta` VALUES ('586', '126', 'issuu_pdf_name', 'sua_fatura_de_energia_mesref_201403'); 
INSERT INTO `wp_postmeta` VALUES ('587', '134', '_edit_lock', '1396118769:1'); 
INSERT INTO `wp_postmeta` VALUES ('588', '134', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('589', '177', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('590', '177', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('592', '171', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('593', '171', '_wp_trash_meta_time', '1396118915'); 
INSERT INTO `wp_postmeta` VALUES ('594', '174', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('595', '174', '_wp_trash_meta_time', '1396118916'); 
INSERT INTO `wp_postmeta` VALUES ('596', '177', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('597', '177', '_wp_trash_meta_time', '1396118916'); 
INSERT INTO `wp_postmeta` VALUES ('600', '182', '_edit_lock', '1396128395:1'); 
INSERT INTO `wp_postmeta` VALUES ('601', '182', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('604', '187', '_wp_attached_file', '2014/03/cartao-sms.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('605', '187', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('607', '189', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1396121168.zip'); 
INSERT INTO `wp_postmeta` VALUES ('608', '189', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('609', '189', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('610', '189', 'backup_size', '0.22 MB'); 
INSERT INTO `wp_postmeta` VALUES ('611', '190', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('612', '190', '_edit_lock', '1396122743:1'); 
INSERT INTO `wp_postmeta` VALUES ('613', '190', 'epaper_meta_realepaper', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('614', '190', 'epaper_meta_pdf', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('615', '190', 'epaper_meta_pages', 'a:1:{i:0;s:27:"aaaaaaaaaaaaaaaaaaaaaaaaaaa";}'); 
INSERT INTO `wp_postmeta` VALUES ('616', '191', '_edit_lock', '1396128400:1'); 
INSERT INTO `wp_postmeta` VALUES ('617', '191', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('618', '194', '_edit_lock', '1396128403:1'); 
INSERT INTO `wp_postmeta` VALUES ('619', '194', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('622', '202', '_edit_lock', '1396398236:1'); 
INSERT INTO `wp_postmeta` VALUES ('623', '202', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('624', '202', 'field_53373670701de', 'a:10:{s:3:"key";s:19:"field_53373670701de";s:5:"label";s:17:"Upload da revista";s:4:"name";s:17:"upload_da_revista";s:4:"type";s:4:"file";s:12:"instructions";s:37:"Faça o upload do PDF da revista aqui";s:8:"required";s:1:"0";s:11:"save_format";s:3:"url";s:7:"library";s:3:"all";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:4:"null";s:8:"operator";s:2:"==";s:5:"value";s:0:"";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:0;}'); 
INSERT INTO `wp_postmeta` VALUES ('627', '202', 'position', 'normal'); 
INSERT INTO `wp_postmeta` VALUES ('628', '202', 'layout', 'no_box'); 
INSERT INTO `wp_postmeta` VALUES ('629', '202', 'hide_on_screen', ''); 
INSERT INTO `wp_postmeta` VALUES ('632', '203', '_edit_lock', '1396130444:1'); 
INSERT INTO `wp_postmeta` VALUES ('633', '203', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('636', '204', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('637', '204', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('638', '204', 'capa_da_revista', '63'); 
INSERT INTO `wp_postmeta` VALUES ('639', '204', '_capa_da_revista', 'field_533736ba701df'); 
INSERT INTO `wp_postmeta` VALUES ('640', '203', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('641', '203', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('642', '203', 'capa_da_revista', '63'); 
INSERT INTO `wp_postmeta` VALUES ('643', '203', '_capa_da_revista', 'field_533736ba701df'); 
INSERT INTO `wp_postmeta` VALUES ('650', '206', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('651', '206', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('652', '206', 'capa_da_revista', '63'); 
INSERT INTO `wp_postmeta` VALUES ('653', '206', '_capa_da_revista', 'field_533736ba701df'); 
INSERT INTO `wp_postmeta` VALUES ('657', '203', '_post_restored_from', 'a:3:{s:20:"restored_revision_id";i:204;s:16:"restored_by_user";i:1;s:13:"restored_time";i:1396128460;}'); 
INSERT INTO `wp_postmeta` VALUES ('658', '208', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('659', '208', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('660', '208', 'capa_da_revista', '63'); 
INSERT INTO `wp_postmeta` VALUES ('661', '208', '_capa_da_revista', 'field_533736ba701df'); 
INSERT INTO `wp_postmeta` VALUES ('664', '209', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('665', '209', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('666', '209', 'capa_da_revista', '63'); 
INSERT INTO `wp_postmeta` VALUES ('667', '209', '_capa_da_revista', 'field_533736ba701df'); 
INSERT INTO `wp_postmeta` VALUES ('670', '210', 'capa_da_revista', '63'); 
INSERT INTO `wp_postmeta` VALUES ('671', '210', '_capa_da_revista', 'field_533736ba701df'); 
INSERT INTO `wp_postmeta` VALUES ('678', '213', '_edit_lock', '1396398181:1'); 
INSERT INTO `wp_postmeta` VALUES ('681', '214', '_wp_attached_file', '2014/03/capa-revista-hsm-management-01.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('682', '214', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:378;s:6:"height";i:500;s:4:"file";s:42:"2014/03/capa-revista-hsm-management-01.jpg";s:5:"sizes";a:2:{s:9:"thumbnail";a:5:{s:4:"file";s:42:"capa-revista-hsm-management-01-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:42:"capa-revista-hsm-management-01-226x300.jpg";s:5:"width";i:226;s:6:"height";i:300;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('684', '213', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('687', '215', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('688', '215', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('689', '215', '_', ''); 
INSERT INTO `wp_postmeta` VALUES ('690', '213', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('691', '213', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('692', '213', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('695', '202', 'field_533745765a5ee', 'a:11:{s:3:"key";s:19:"field_533745765a5ee";s:5:"label";s:15:"Capa da revista";s:4:"name";s:15:"capa_da_revista";s:4:"type";s:5:"image";s:12:"instructions";s:35:"Faça o upload da capada da revista";s:8:"required";s:1:"0";s:11:"save_format";s:3:"url";s:12:"preview_size";s:9:"thumbnail";s:7:"library";s:3:"all";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:2:{s:5:"field";s:4:"null";s:8:"operator";s:2:"==";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:1;}'); 
INSERT INTO `wp_postmeta` VALUES ('696', '202', 'field_5337459f5a5ef', 'a:14:{s:3:"key";s:19:"field_5337459f5a5ef";s:5:"label";s:0:"";s:4:"name";s:0:"";s:4:"type";s:4:"text";s:12:"instructions";s:0:"";s:8:"required";s:1:"0";s:13:"default_value";s:0:"";s:11:"placeholder";s:0:"";s:7:"prepend";s:0:"";s:6:"append";s:0:"";s:10:"formatting";s:4:"html";s:9:"maxlength";s:0:"";s:17:"conditional_logic";a:3:{s:6:"status";s:1:"0";s:5:"rules";a:1:{i:0;a:3:{s:5:"field";s:4:"null";s:8:"operator";s:2:"==";s:5:"value";s:0:"";}}s:8:"allorany";s:3:"all";}s:8:"order_no";i:2;}'); 
INSERT INTO `wp_postmeta` VALUES ('699', '202', 'rule', 'a:5:{s:5:"param";s:9:"user_type";s:8:"operator";s:2:"==";s:5:"value";s:13:"administrator";s:8:"order_no";i:0;s:8:"group_no";i:0;}'); 
INSERT INTO `wp_postmeta` VALUES ('700', '202', 'rule', 'a:5:{s:5:"param";s:13:"post_category";s:8:"operator";s:2:"==";s:5:"value";s:2:"19";s:8:"order_no";i:1;s:8:"group_no";i:0;}'); 
INSERT INTO `wp_postmeta` VALUES ('703', '217', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('704', '217', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('705', '217', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('706', '217', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('707', '217', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('708', '213', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('709', '213', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('713', '194', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('714', '194', '_wp_trash_meta_time', '1396131373'); 
INSERT INTO `wp_postmeta` VALUES ('715', '191', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('716', '191', '_wp_trash_meta_time', '1396131373'); 
INSERT INTO `wp_postmeta` VALUES ('717', '182', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('718', '182', '_wp_trash_meta_time', '1396131373'); 
INSERT INTO `wp_postmeta` VALUES ('719', '203', '_wp_trash_meta_status', 'publish'); 
INSERT INTO `wp_postmeta` VALUES ('720', '203', '_wp_trash_meta_time', '1396131381'); 
INSERT INTO `wp_postmeta` VALUES ('721', '213', '_thumbnail_id', '123'); 
INSERT INTO `wp_postmeta` VALUES ('728', '218', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('729', '218', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('730', '218', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('731', '218', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('732', '218', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('733', '219', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1396392617.zip'); 
INSERT INTO `wp_postmeta` VALUES ('734', '219', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('735', '219', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('736', '219', 'backup_size', '0.22 MB'); 
INSERT INTO `wp_postmeta` VALUES ('737', '222', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('738', '222', '_edit_lock', '1396393500:1'); 
INSERT INTO `wp_postmeta` VALUES ('739', '223', '_wp_attached_file', '2014/04/capa-revista-gloss.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('740', '223', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:377;s:6:"height";i:492;s:4:"file";s:30:"2014/04/capa-revista-gloss.jpg";s:5:"sizes";a:2:{s:9:"thumbnail";a:5:{s:4:"file";s:30:"capa-revista-gloss-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:30:"capa-revista-gloss-229x300.jpg";s:5:"width";i:229;s:6:"height";i:300;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('743', '224', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('744', '224', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('745', '224', 'capa_da_revista', '223'); 
INSERT INTO `wp_postmeta` VALUES ('746', '224', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('747', '224', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('748', '222', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('749', '222', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('750', '222', 'capa_da_revista', '223'); 
INSERT INTO `wp_postmeta` VALUES ('751', '222', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('752', '222', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('753', '226', '_edit_lock', '1397410259:1'); 
INSERT INTO `wp_postmeta` VALUES ('754', '226', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('755', '226', 'upload_da_revista', '298'); 
INSERT INTO `wp_postmeta` VALUES ('756', '226', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('757', '226', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('758', '226', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('759', '226', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('760', '226', '_thumbnail_id', '123'); 
INSERT INTO `wp_postmeta` VALUES ('761', '226', '_dp_original', '213'); 
INSERT INTO `wp_postmeta` VALUES ('762', '227', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('763', '227', '_edit_lock', '1396393500:1'); 
INSERT INTO `wp_postmeta` VALUES ('764', '227', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('765', '227', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('766', '227', 'capa_da_revista', '223'); 
INSERT INTO `wp_postmeta` VALUES ('767', '227', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('768', '227', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('769', '227', '_dp_original', '222'); 
INSERT INTO `wp_postmeta` VALUES ('770', '228', '_edit_lock', '1396398181:1'); 
INSERT INTO `wp_postmeta` VALUES ('771', '228', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('772', '228', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('773', '228', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('774', '228', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('775', '228', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('776', '228', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('777', '228', '_thumbnail_id', '123'); 
INSERT INTO `wp_postmeta` VALUES ('778', '228', '_dp_original', '213'); 
INSERT INTO `wp_postmeta` VALUES ('779', '229', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('780', '229', '_edit_lock', '1396393500:1'); 
INSERT INTO `wp_postmeta` VALUES ('781', '229', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('782', '229', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('783', '229', 'capa_da_revista', '223'); 
INSERT INTO `wp_postmeta` VALUES ('784', '229', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('785', '229', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('786', '229', '_dp_original', '222'); 
INSERT INTO `wp_postmeta` VALUES ('787', '230', '_edit_lock', '1396398181:1'); 
INSERT INTO `wp_postmeta` VALUES ('788', '230', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('789', '230', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('790', '230', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('791', '230', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('792', '230', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('793', '230', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('794', '230', '_thumbnail_id', '123'); 
INSERT INTO `wp_postmeta` VALUES ('795', '230', '_dp_original', '213'); 
INSERT INTO `wp_postmeta` VALUES ('796', '231', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('797', '231', '_edit_lock', '1396393500:1'); 
INSERT INTO `wp_postmeta` VALUES ('798', '231', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('799', '231', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('800', '231', 'capa_da_revista', '223'); 
INSERT INTO `wp_postmeta` VALUES ('801', '231', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('802', '231', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('803', '231', '_dp_original', '222'); 
INSERT INTO `wp_postmeta` VALUES ('804', '232', '_edit_lock', '1396398181:1'); 
INSERT INTO `wp_postmeta` VALUES ('805', '232', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('806', '232', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('807', '232', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('808', '232', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('809', '232', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('810', '232', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('811', '232', '_thumbnail_id', '123'); 
INSERT INTO `wp_postmeta` VALUES ('812', '232', '_dp_original', '213'); 
INSERT INTO `wp_postmeta` VALUES ('813', '233', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('814', '233', '_edit_lock', '1396393500:1'); 
INSERT INTO `wp_postmeta` VALUES ('815', '233', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('816', '233', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('817', '233', 'capa_da_revista', '223'); 
INSERT INTO `wp_postmeta` VALUES ('818', '233', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('819', '233', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('820', '233', '_dp_original', '222'); 
INSERT INTO `wp_postmeta` VALUES ('821', '234', '_edit_lock', '1396398181:1'); 
INSERT INTO `wp_postmeta` VALUES ('822', '234', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('823', '234', 'upload_da_revista', '187'); 
INSERT INTO `wp_postmeta` VALUES ('824', '234', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('825', '234', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('826', '234', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('827', '234', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('828', '234', '_thumbnail_id', '123'); 
INSERT INTO `wp_postmeta` VALUES ('829', '234', '_dp_original', '213'); 
INSERT INTO `wp_postmeta` VALUES ('848', '120', '_edit_lock', '1397489845:1'); 
INSERT INTO `wp_postmeta` VALUES ('849', '244', '_wp_attached_file', '2014/03/revista.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('850', '244', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1019;s:6:"height";i:248;s:4:"file";s:19:"2014/03/revista.jpg";s:5:"sizes";a:3:{s:9:"thumbnail";a:5:{s:4:"file";s:19:"revista-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:18:"revista-300x73.jpg";s:5:"width";i:300;s:6:"height";i:73;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:19:"revista-624x151.jpg";s:5:"width";i:624;s:6:"height";i:151;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('851', '20', '_thumbnail_id', '244'); 
INSERT INTO `wp_postmeta` VALUES ('852', '245', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1396474863.zip'); 
INSERT INTO `wp_postmeta` VALUES ('853', '245', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('854', '245', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('855', '245', 'backup_size', '0.18 MB'); 
INSERT INTO `wp_postmeta` VALUES ('857', '247', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1396562592.zip'); 
INSERT INTO `wp_postmeta` VALUES ('858', '247', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('859', '247', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('860', '247', 'backup_size', '0.23 MB'); 
INSERT INTO `wp_postmeta` VALUES ('861', '249', '_menu_item_type', 'custom'); 
INSERT INTO `wp_postmeta` VALUES ('862', '249', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('863', '249', '_menu_item_object_id', '249'); 
INSERT INTO `wp_postmeta` VALUES ('864', '249', '_menu_item_object', 'custom'); 
INSERT INTO `wp_postmeta` VALUES ('865', '249', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('866', '249', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('867', '249', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('868', '249', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('869', '250', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1396639554.zip'); 
INSERT INTO `wp_postmeta` VALUES ('870', '250', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('871', '250', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('872', '250', 'backup_size', '0.23 MB'); 
INSERT INTO `wp_postmeta` VALUES ('873', '251', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1396726024.zip'); 
INSERT INTO `wp_postmeta` VALUES ('874', '251', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('875', '251', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('876', '251', 'backup_size', '0.23 MB'); 
INSERT INTO `wp_postmeta` VALUES ('877', '253', '_edit_lock', '1396727906:1'); 
INSERT INTO `wp_postmeta` VALUES ('878', '253', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('879', '254', '_wp_attached_file', '2014/04/asug_recibo_cabecalho.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('880', '254', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1020;s:6:"height";i:71;s:4:"file";s:33:"2014/04/asug_recibo_cabecalho.jpg";s:5:"sizes";a:3:{s:9:"thumbnail";a:5:{s:4:"file";s:32:"asug_recibo_cabecalho-150x71.jpg";s:5:"width";i:150;s:6:"height";i:71;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:32:"asug_recibo_cabecalho-300x20.jpg";s:5:"width";i:300;s:6:"height";i:20;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:32:"asug_recibo_cabecalho-624x43.jpg";s:5:"width";i:624;s:6:"height";i:43;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('881', '255', '_wp_attached_file', '2014/04/asug_recibo_rodape.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('882', '255', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1020;s:6:"height";i:38;s:4:"file";s:30:"2014/04/asug_recibo_rodape.jpg";s:5:"sizes";a:3:{s:9:"thumbnail";a:5:{s:4:"file";s:29:"asug_recibo_rodape-150x38.jpg";s:5:"width";i:150;s:6:"height";i:38;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:29:"asug_recibo_rodape-300x11.jpg";s:5:"width";i:300;s:6:"height";i:11;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:29:"asug_recibo_rodape-624x23.jpg";s:5:"width";i:624;s:6:"height";i:23;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('894', '268', '_edit_lock', '1396729924:1'); 
INSERT INTO `wp_postmeta` VALUES ('895', '268', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('902', '275', '_edit_lock', '1396730518:1'); 
INSERT INTO `wp_postmeta` VALUES ('903', '275', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('909', '281', '_edit_lock', '1396731181:1'); 
INSERT INTO `wp_postmeta` VALUES ('910', '281', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('914', '285', '_edit_lock', '1396760978:1'); 
INSERT INTO `wp_postmeta` VALUES ('915', '285', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('916', '285', '_wp_page_template', 'default'); 
INSERT INTO `wp_postmeta` VALUES ('917', '287', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1397329543.zip'); 
INSERT INTO `wp_postmeta` VALUES ('918', '287', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('919', '287', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('920', '287', 'backup_size', '0.22 MB'); 
INSERT INTO `wp_postmeta` VALUES ('921', '268', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('922', '268', '_wp_trash_meta_time', '1397329885'); 
INSERT INTO `wp_postmeta` VALUES ('923', '275', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('924', '275', '_wp_trash_meta_time', '1397329886'); 
INSERT INTO `wp_postmeta` VALUES ('925', '281', '_wp_trash_meta_status', 'draft'); 
INSERT INTO `wp_postmeta` VALUES ('926', '281', '_wp_trash_meta_time', '1397329886'); 
INSERT INTO `wp_postmeta` VALUES ('927', '12', '_wp_trash_meta_status', 'publish'); 
INSERT INTO `wp_postmeta` VALUES ('928', '12', '_wp_trash_meta_time', '1397329904'); 
INSERT INTO `wp_postmeta` VALUES ('929', '14', '_wp_trash_meta_status', 'publish'); 
INSERT INTO `wp_postmeta` VALUES ('930', '14', '_wp_trash_meta_time', '1397329912'); 
INSERT INTO `wp_postmeta` VALUES ('931', '10', '_wp_trash_meta_status', 'publish'); 
INSERT INTO `wp_postmeta` VALUES ('932', '10', '_wp_trash_meta_time', '1397329944'); 
INSERT INTO `wp_postmeta` VALUES ('933', '291', '_edit_lock', '1397330242:1'); 
INSERT INTO `wp_postmeta` VALUES ('934', '291', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('935', '291', '_wp_page_template', 'page-templates/sidebar-direita.php'); 
INSERT INTO `wp_postmeta` VALUES ('936', '293', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('937', '293', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('938', '293', '_menu_item_object_id', '291'); 
INSERT INTO `wp_postmeta` VALUES ('939', '293', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('940', '293', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('941', '293', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('942', '293', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('943', '293', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('945', '294', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('946', '294', '_edit_lock', '1397330444:1'); 
INSERT INTO `wp_postmeta` VALUES ('947', '294', '_wp_page_template', 'page-templates/full-width.php'); 
INSERT INTO `wp_postmeta` VALUES ('948', '296', '_menu_item_type', 'post_type'); 
INSERT INTO `wp_postmeta` VALUES ('949', '296', '_menu_item_menu_item_parent', '0'); 
INSERT INTO `wp_postmeta` VALUES ('950', '296', '_menu_item_object_id', '294'); 
INSERT INTO `wp_postmeta` VALUES ('951', '296', '_menu_item_object', 'page'); 
INSERT INTO `wp_postmeta` VALUES ('952', '296', '_menu_item_target', ''); 
INSERT INTO `wp_postmeta` VALUES ('953', '296', '_menu_item_classes', 'a:1:{i:0;s:0:"";}'); 
INSERT INTO `wp_postmeta` VALUES ('954', '296', '_menu_item_xfn', ''); 
INSERT INTO `wp_postmeta` VALUES ('955', '296', '_menu_item_url', ''); 
INSERT INTO `wp_postmeta` VALUES ('957', '22', '_thumbnail_id', '123'); 
INSERT INTO `wp_postmeta` VALUES ('958', '297', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1397330827.zip'); 
INSERT INTO `wp_postmeta` VALUES ('959', '297', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('960', '297', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('961', '297', 'backup_size', '0.23 MB'); 
INSERT INTO `wp_postmeta` VALUES ('962', '298', '_wp_attached_file', '2014/04/PASSEI_online_menor_1.pdf'); 
INSERT INTO `wp_postmeta` VALUES ('963', '298', '_wp_attachment_metadata', 'a:1:{s:20:"ewww_image_optimizer";s:74:"Missing finfo_file(), getimagesize() and mime_content_type() PHP functions";}'); 
INSERT INTO `wp_postmeta` VALUES ('966', '299', 'upload_da_revista', '298'); 
INSERT INTO `wp_postmeta` VALUES ('967', '299', '_upload_da_revista', 'field_53373670701de'); 
INSERT INTO `wp_postmeta` VALUES ('968', '299', 'capa_da_revista', '214'); 
INSERT INTO `wp_postmeta` VALUES ('969', '299', '_capa_da_revista', 'field_533745765a5ee'); 
INSERT INTO `wp_postmeta` VALUES ('970', '299', '_', 'field_5337459f5a5ef'); 
INSERT INTO `wp_postmeta` VALUES ('971', '300', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1397417427.zip'); 
INSERT INTO `wp_postmeta` VALUES ('972', '300', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('973', '300', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('974', '300', 'backup_size', '0.23 MB'); 
INSERT INTO `wp_postmeta` VALUES ('975', '244', '_edit_lock', '1397489847:1'); 
INSERT INTO `wp_postmeta` VALUES ('976', '119', '_edit_lock', '1397489834:1'); 
INSERT INTO `wp_postmeta` VALUES ('977', '302', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1397505353.zip'); 
INSERT INTO `wp_postmeta` VALUES ('978', '302', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('979', '302', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('980', '302', 'backup_size', '0.24 MB'); 
INSERT INTO `wp_postmeta` VALUES ('982', '304', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1397590261.zip'); 
INSERT INTO `wp_postmeta` VALUES ('983', '304', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('984', '304', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('985', '304', 'backup_size', '0.24 MB'); 
INSERT INTO `wp_postmeta` VALUES ('986', '305', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1398202522.zip'); 
INSERT INTO `wp_postmeta` VALUES ('987', '305', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('988', '305', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('989', '305', 'backup_size', '0.23 MB'); 
INSERT INTO `wp_postmeta` VALUES ('990', '307', '_edit_lock', '1398208054:1'); 
INSERT INTO `wp_postmeta` VALUES ('991', '308', '_wp_attached_file', '2014/03/copy-asug-brasil.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('992', '308', '_wp_attachment_context', 'custom-header'); 
INSERT INTO `wp_postmeta` VALUES ('993', '308', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:229;s:6:"height";i:76;s:4:"file";s:28:"2014/03/copy-asug-brasil.jpg";s:5:"sizes";a:1:{s:9:"thumbnail";a:5:{s:4:"file";s:27:"copy-asug-brasil-150x76.jpg";s:5:"width";i:150;s:6:"height";i:76;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('994', '308', '_wp_attachment_is_custom_header', 'asug'); 
INSERT INTO `wp_postmeta` VALUES ('995', '309', '_edit_lock', '1398211963:1'); 
INSERT INTO `wp_postmeta` VALUES ('996', '309', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('997', '310', '_wp_attached_file', '2014/04/Technology-news1.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('998', '310', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1000;s:6:"height";i:842;s:4:"file";s:28:"2014/04/Technology-news1.jpg";s:5:"sizes";a:3:{s:9:"thumbnail";a:5:{s:4:"file";s:28:"Technology-news1-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:28:"Technology-news1-300x252.jpg";s:5:"width";i:300;s:6:"height";i:252;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:28:"Technology-news1-624x525.jpg";s:5:"width";i:624;s:6:"height";i:525;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('999', '309', '_thumbnail_id', '310'); 
INSERT INTO `wp_postmeta` VALUES ('1002', '312', '_edit_lock', '1398212123:1'); 
INSERT INTO `wp_postmeta` VALUES ('1003', '312', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('1005', '312', '_dp_original', '309'); 
INSERT INTO `wp_postmeta` VALUES ('1006', '313', '_edit_lock', '1398212117:1'); 
INSERT INTO `wp_postmeta` VALUES ('1007', '313', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('1009', '313', '_dp_original', '309'); 
INSERT INTO `wp_postmeta` VALUES ('1010', '314', '_edit_lock', '1398212287:1'); 
INSERT INTO `wp_postmeta` VALUES ('1011', '314', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('1013', '314', '_dp_original', '309'); 
INSERT INTO `wp_postmeta` VALUES ('1014', '315', '_edit_lock', '1398211807:1'); 
INSERT INTO `wp_postmeta` VALUES ('1015', '315', '_edit_last', '1'); 
INSERT INTO `wp_postmeta` VALUES ('1016', '315', 'rule', 'a:5:{s:5:"param";s:9:"post_type";s:8:"operator";s:2:"==";s:5:"value";s:4:"post";s:8:"order_no";i:0;s:8:"group_no";i:0;}'); 
INSERT INTO `wp_postmeta` VALUES ('1017', '315', 'position', 'normal'); 
INSERT INTO `wp_postmeta` VALUES ('1018', '315', 'layout', 'no_box'); 
INSERT INTO `wp_postmeta` VALUES ('1019', '315', 'hide_on_screen', ''); 
INSERT INTO `wp_postmeta` VALUES ('1020', '96', '_wp_trash_meta_status', 'publish'); 
INSERT INTO `wp_postmeta` VALUES ('1021', '96', '_wp_trash_meta_time', '1398211539'); 
INSERT INTO `wp_postmeta` VALUES ('1022', '97', '_wp_trash_meta_status', 'publish'); 
INSERT INTO `wp_postmeta` VALUES ('1023', '97', '_wp_trash_meta_time', '1398211539'); 
INSERT INTO `wp_postmeta` VALUES ('1024', '98', '_wp_trash_meta_status', 'publish'); 
INSERT INTO `wp_postmeta` VALUES ('1025', '98', '_wp_trash_meta_time', '1398211539'); 
INSERT INTO `wp_postmeta` VALUES ('1026', '99', '_wp_trash_meta_status', 'publish'); 
INSERT INTO `wp_postmeta` VALUES ('1027', '99', '_wp_trash_meta_time', '1398211539'); 
INSERT INTO `wp_postmeta` VALUES ('1028', '320', '_wp_attached_file', '2014/04/circuit-Sqr1.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('1029', '320', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1698;s:6:"height";i:1131;s:4:"file";s:24:"2014/04/circuit-Sqr1.jpg";s:5:"sizes";a:4:{s:9:"thumbnail";a:5:{s:4:"file";s:24:"circuit-Sqr1-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:24:"circuit-Sqr1-300x199.jpg";s:5:"width";i:300;s:6:"height";i:199;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:5:"large";a:5:{s:4:"file";s:25:"circuit-Sqr1-1024x682.jpg";s:5:"width";i:1024;s:6:"height";i:682;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:24:"circuit-Sqr1-624x415.jpg";s:5:"width";i:624;s:6:"height";i:415;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";d:4;s:6:"credit";s:0:"";s:6:"camera";s:13:"Canon EOS 10D";s:7:"caption";s:0:"";s:17:"created_timestamp";i:1170176907;s:9:"copyright";s:0:"";s:12:"focal_length";s:2:"50";s:3:"iso";s:3:"100";s:13:"shutter_speed";s:16:"0.16666666666667";s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('1030', '312', '_thumbnail_id', '320'); 
INSERT INTO `wp_postmeta` VALUES ('1033', '322', '_wp_attached_file', '2014/04/technology-hand1.jpg'); 
INSERT INTO `wp_postmeta` VALUES ('1034', '322', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1400;s:6:"height";i:933;s:4:"file";s:28:"2014/04/technology-hand1.jpg";s:5:"sizes";a:4:{s:9:"thumbnail";a:5:{s:4:"file";s:28:"technology-hand1-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:28:"technology-hand1-300x199.jpg";s:5:"width";i:300;s:6:"height";i:199;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:5:"large";a:5:{s:4:"file";s:29:"technology-hand1-1024x682.jpg";s:5:"width";i:1024;s:6:"height";i:682;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:28:"technology-hand1-624x415.jpg";s:5:"width";i:624;s:6:"height";i:415;s:9:"mime-type";s:10:"image/jpeg";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('1035', '313', '_thumbnail_id', '322'); 
INSERT INTO `wp_postmeta` VALUES ('1038', '324', '_wp_attached_file', '2014/04/cpuaroundworld_alpha1.png'); 
INSERT INTO `wp_postmeta` VALUES ('1039', '324', '_wp_attachment_metadata', 'a:6:{s:5:"width";i:1633;s:6:"height";i:1225;s:4:"file";s:33:"2014/04/cpuaroundworld_alpha1.png";s:5:"sizes";a:4:{s:9:"thumbnail";a:5:{s:4:"file";s:33:"cpuaroundworld_alpha1-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:6:"medium";a:5:{s:4:"file";s:33:"cpuaroundworld_alpha1-300x225.png";s:5:"width";i:300;s:6:"height";i:225;s:9:"mime-type";s:9:"image/png";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:5:"large";a:5:{s:4:"file";s:34:"cpuaroundworld_alpha1-1024x768.png";s:5:"width";i:1024;s:6:"height";i:768;s:9:"mime-type";s:9:"image/png";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}s:14:"post-thumbnail";a:5:{s:4:"file";s:33:"cpuaroundworld_alpha1-624x468.png";s:5:"width";i:624;s:6:"height";i:468;s:9:"mime-type";s:9:"image/png";s:20:"ewww_image_optimizer";s:33:"No savings - Previously Optimized";}}s:10:"image_meta";a:10:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";}s:20:"ewww_image_optimizer";s:10:"No savings";}'); 
INSERT INTO `wp_postmeta` VALUES ('1040', '314', '_thumbnail_id', '324'); 
INSERT INTO `wp_postmeta` VALUES ('1041', '327', 'backup_location', 'C:xampphtdocsasug/wp-content/uploads/wpbu-backups/1398302411.zip'); 
INSERT INTO `wp_postmeta` VALUES ('1042', '327', 'backup_type', 'Database'); 
INSERT INTO `wp_postmeta` VALUES ('1043', '327', 'backup_status', 'Completed'); 
INSERT INTO `wp_postmeta` VALUES ('1044', '327', 'backup_size', '0.15 MB'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_posts`
--
DROP TABLE IF EXISTS `wp_posts`;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(20) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_posts`
--
LOCK TABLES `wp_posts` WRITE;
INSERT INTO `wp_posts` VALUES ('1', '1', '2014-03-15 15:51:25', '2014-03-15 15:51:25', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG Day Porto Alegre 2013', '', 'publish', 'open', 'open', '', 'asug-day-porto-alegre-2013', '', '', '2014-03-16 23:45:36', '2014-03-16 23:45:36', '', '0', 'http://127.0.0.1/asug/?p=1', '0', 'post', '', '1'); 
INSERT INTO `wp_posts` VALUES ('2', '1', '2014-03-15 15:51:25', '2014-03-15 15:51:25', '', 'Home', '', 'publish', 'open', 'open', '', 'pagina-exemplo', '', '', '2014-04-23 00:21:50', '2014-04-23 00:21:50', '', '0', 'http://127.0.0.1/asug/?page_id=2', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('4', '1', '2014-03-15 15:55:31', '2014-03-15 15:55:31', '<p>Seu nome (obrigatório)<br />
    [text* your-name] </p>

<p>Seu e-mail (obrigatório)<br />
    [email* your-email] </p>

<p>Assunto<br />
    [text your-subject] </p>

<p>Sua mensagem<br />
    [textarea your-message] </p>

<p>[submit "Enviar"]</p>
[your-subject]
[your-name] <[your-email]>
De: [your-name] <[your-email]>
Assunto: [your-subject]

Corpo da mensagem:
[your-message]

--
Este e-mail foi enviado de um formulário de contato em Asug | SAP NetWeaver Portal (http://127.0.0.1/asug)
felipe@montarsite.com.br




[your-subject]
[your-name] <[your-email]>
Corpo da mensagem:
[your-message]

--
Este e-mail foi enviado de um formulário de contato em Asug | SAP NetWeaver Portal (http://127.0.0.1/asug)
[your-email]



Sua mensagem foi enviada com sucesso. Obrigado.
Não foi possível enviar a sua mensagem. Por favor, tente mais tarde ou contate o administrador por outro método.
Ocorreram erros de validação. Por favor confira os dados e envie novamente.
Não foi possível enviar a sua mensagem. Por favor, tente mais tarde ou contate o administrador por outro método.
Por favor aceite os termos para prosseguir.
Por favor preencha este campo obrigatório.
O código digitado está incorreto.
Formato de número parece inválido.
Este número é muito pequeno.
Este número é muito grande.
O endereço de e-mail parece inválido.
URL parece inválido.
Telefone parece inválido.
Sua resposta está incorreta.
Formato da data parece inválido.
Esta data é demasiado primeira.
Esta data é demasiado tarde.
Falha no upload do arquivo.
Este tipo de arquivo não é permitido.
Este arquivo é grande demais.
Falha no upload do arquivo.', 'Formulário de contato 1', '', 'publish', 'open', 'open', '', 'formulario-de-contato-1', '', '', '2014-03-22 01:17:36', '2014-03-22 01:17:36', '', '0', 'http://127.0.0.1/asug/?post_type=wpcf7_contact_form&#038;p=4', '0', 'wpcf7_contact_form', '', '0'); 
INSERT INTO `wp_posts` VALUES ('5', '1', '2014-03-15 16:34:13', '2014-03-15 16:34:13', 'Esta é uma página de exemplo. É diferente de um post porque ela ficará em um local e será exibida na navegação do seu site (na maioria dos temas). A maioria das pessoas começa com uma página de introdução aos potenciais visitantes do site. Ela pode ser assim:
<blockquote>Olá! Eu sou um bike courrier de dia, ator amador à noite e este é meu blog. Eu moro em São Paulo, tenho um cachorro chamado Tonico e eu gosto de caipirinhas. (E de ser pego pela chuva.)</blockquote>
ou assim:
<blockquote>A XYZ foi fundada em 1971 e desde então vem proporcionando produtos de qualidade a seus clientes. Localizada em Valinhos, XYZ emprega mais de 2.000 pessoas e faz várias contribuições para a comunidade local.</blockquote>
Como um novo usuário do WordPress, você deve ir até o <a href="http://127.0.0.1/asug/wp-admin/">seu painel</a> para excluir essa página e criar novas páginas com seu próprio conteúdo. Divirta-se!', 'Home', '', 'inherit', 'open', 'open', '', '2-revision-v1', '', '', '2014-03-15 16:34:13', '2014-03-15 16:34:13', '', '2', 'http://127.0.0.1/asug/2-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('6', '1', '2014-03-15 16:34:43', '2014-03-15 16:34:43', '', 'Institucional', '', 'publish', 'open', 'open', '', 'institucional', '', '', '2014-03-15 16:34:43', '2014-03-15 16:34:43', '', '0', 'http://127.0.0.1/asug/?page_id=6', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('7', '1', '2014-03-15 16:34:43', '2014-03-15 16:34:43', '', 'Institucional', '', 'inherit', 'open', 'open', '', '6-revision-v1', '', '', '2014-03-15 16:34:43', '2014-03-15 16:34:43', '', '6', 'http://127.0.0.1/asug/6-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('8', '1', '2014-03-15 16:35:03', '2014-03-15 16:35:03', '', 'Associe-se', '', 'publish', 'open', 'open', '', 'associe-se', '', '', '2014-03-15 16:35:03', '2014-03-15 16:35:03', '', '0', 'http://127.0.0.1/asug/?page_id=8', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('9', '1', '2014-03-15 16:35:03', '2014-03-15 16:35:03', '', 'Associe-se', '', 'inherit', 'open', 'open', '', '8-revision-v1', '', '', '2014-03-15 16:35:03', '2014-03-15 16:35:03', '', '8', 'http://127.0.0.1/asug/8-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('10', '1', '2014-03-15 16:35:32', '2014-03-15 16:35:32', '', 'Grupo de estudo', '', 'trash', 'open', 'open', '', 'grupo-de-estudo', '', '', '2014-04-12 19:12:24', '2014-04-12 19:12:24', '', '0', 'http://127.0.0.1/asug/?page_id=10', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('11', '1', '2014-03-15 16:35:32', '2014-03-15 16:35:32', '', 'Grupo de estudo', '', 'inherit', 'open', 'open', '', '10-revision-v1', '', '', '2014-03-15 16:35:32', '2014-03-15 16:35:32', '', '10', 'http://127.0.0.1/asug/10-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('12', '1', '2014-03-15 16:35:45', '2014-03-15 16:35:45', '', 'ABSG', '', 'trash', 'open', 'open', '', 'absg', '', '', '2014-04-12 19:11:44', '2014-04-12 19:11:44', '', '0', 'http://127.0.0.1/asug/?page_id=12', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('13', '1', '2014-03-15 16:35:45', '2014-03-15 16:35:45', '', 'ABSG', '', 'inherit', 'open', 'open', '', '12-revision-v1', '', '', '2014-03-15 16:35:45', '2014-03-15 16:35:45', '', '12', 'http://127.0.0.1/asug/12-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('14', '1', '2014-03-15 16:36:00', '2014-03-15 16:36:00', '', 'DRQ', '', 'trash', 'open', 'open', '', 'drq', '', '', '2014-04-12 19:11:52', '2014-04-12 19:11:52', '', '0', 'http://127.0.0.1/asug/?page_id=14', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('15', '1', '2014-03-15 16:36:00', '2014-03-15 16:36:00', '', 'DRQ', '', 'inherit', 'open', 'open', '', '14-revision-v1', '', '', '2014-03-15 16:36:00', '2014-03-15 16:36:00', '', '14', 'http://127.0.0.1/asug/14-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('16', '1', '2014-03-15 16:36:39', '2014-03-15 16:36:39', '', 'Conferência anual', '', 'publish', 'open', 'open', '', 'conferencia-anual', '', '', '2014-03-15 16:36:39', '2014-03-15 16:36:39', '', '0', 'http://127.0.0.1/asug/?page_id=16', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('17', '1', '2014-03-15 16:36:39', '2014-03-15 16:36:39', '', 'Conferência anual', '', 'inherit', 'open', 'open', '', '16-revision-v1', '', '', '2014-03-15 16:36:39', '2014-03-15 16:36:39', '', '16', 'http://127.0.0.1/asug/16-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('18', '1', '2014-03-15 16:37:04', '2014-03-15 16:37:04', '', 'Impact awards', '', 'publish', 'open', 'open', '', 'impact-awards', '', '', '2014-03-15 16:37:04', '2014-03-15 16:37:04', '', '0', 'http://127.0.0.1/asug/?page_id=18', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('19', '1', '2014-03-15 16:37:04', '2014-03-15 16:37:04', '', 'Impact awards', '', 'inherit', 'open', 'open', '', '18-revision-v1', '', '', '2014-03-15 16:37:04', '2014-03-15 16:37:04', '', '18', 'http://127.0.0.1/asug/18-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('20', '1', '2014-03-15 16:37:26', '2014-03-15 16:37:26', '', 'Asug Day', '', 'publish', 'open', 'open', '', 'asug-day', '', '', '2014-04-12 19:21:12', '2014-04-12 19:21:12', '', '0', 'http://127.0.0.1/asug/?page_id=20', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('21', '1', '2014-03-15 16:37:26', '2014-03-15 16:37:26', '', 'Asug Day', '', 'inherit', 'open', 'open', '', '20-revision-v1', '', '', '2014-03-15 16:37:26', '2014-03-15 16:37:26', '', '20', 'http://127.0.0.1/asug/20-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('22', '1', '2014-03-15 16:37:42', '2014-03-15 16:37:42', '', 'Asug News', '', 'publish', 'open', 'open', '', 'asug-news', '', '', '2014-04-12 19:21:54', '2014-04-12 19:21:54', '', '0', 'http://127.0.0.1/asug/?page_id=22', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('23', '1', '2014-03-15 16:37:42', '2014-03-15 16:37:42', '', 'Asug News', '', 'inherit', 'open', 'open', '', '22-revision-v1', '', '', '2014-03-15 16:37:42', '2014-03-15 16:37:42', '', '22', 'http://127.0.0.1/asug/22-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('35', '1', '2014-03-15 16:39:04', '2014-03-15 16:39:04', '', 'Diretoria', '', 'publish', 'open', 'open', '', 'diretoria', '', '', '2014-03-15 16:39:04', '2014-03-15 16:39:04', '', '6', 'http://127.0.0.1/asug/?page_id=35', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('36', '1', '2014-03-15 16:39:04', '2014-03-15 16:39:04', '', 'Diretoria', '', 'inherit', 'open', 'open', '', '35-revision-v1', '', '', '2014-03-15 16:39:04', '2014-03-15 16:39:04', '', '35', 'http://127.0.0.1/asug/35-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('37', '1', '2014-03-15 16:39:31', '2014-03-15 16:39:31', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl.

Morbi in elementum justo. Aenean commodo sapien vulputate, vehicula lectus non, luctus augue. Nullam pulvinar tincidunt elementum. Integer ipsum neque, fermentum eu dignissim id, ultrices a augue. Integer eleifend neque in nisi euismod condimentum. Vestibulum mauris metus, hendrerit at lectus vel, sollicitudin semper libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla arcu dui, feugiat quis blandit id, elementum at est. Maecenas a nulla imperdiet, egestas est sit amet, cursus lacus. Nunc in ullamcorper mi. Nam purus nulla, cursus eu ornare ut, pellentesque in sapien. Sed ornare sapien nec erat pretium, mollis tincidunt nisl feugiat. Fusce at varius neque, ut vulputate ipsum. Duis sit amet odio lobortis, interdum turpis sit amet, tempor enim. Etiam justo urna, ullamcorper eget mollis vitae, hendrerit ut erat. Duis viverra malesuada consequat.

Nulla venenatis urna a massa suscipit feugiat. Nulla facilisi. Integer libero odio, ultrices et dui ac, cursus sollicitudin sem. Sed ut libero non nulla aliquam accumsan. Nam blandit purus sit amet turpis elementum tincidunt. Nunc quis ipsum sed mauris scelerisque varius at ut nisl. Duis tortor urna, ornare interdum quam at, iaculis lobortis elit. Pellentesque id consectetur felis. Mauris facilisis massa vitae elit consectetur venenatis.

Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis.

Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Conselho administrativo', '', 'publish', 'open', 'open', '', 'conselho-administrativo', '', '', '2014-03-20 15:40:28', '2014-03-20 15:40:28', '', '6', 'http://127.0.0.1/asug/?page_id=37', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('38', '1', '2014-03-15 16:39:31', '2014-03-15 16:39:31', '', 'Conselho administrativo', '', 'inherit', 'open', 'open', '', '37-revision-v1', '', '', '2014-03-15 16:39:31', '2014-03-15 16:39:31', '', '37', 'http://127.0.0.1/asug/37-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('39', '1', '2014-03-15 16:39:51', '2014-03-15 16:39:51', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl. Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis. Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Comitê estratégico', '', 'publish', 'open', 'open', '', 'comite-estrategico', '', '', '2014-04-03 22:57:39', '2014-04-03 22:57:39', '', '6', 'http://127.0.0.1/asug/?page_id=39', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('40', '1', '2014-03-15 16:39:51', '2014-03-15 16:39:51', '', 'Comitê estratégico', '', 'inherit', 'open', 'open', '', '39-revision-v1', '', '', '2014-03-15 16:39:51', '2014-03-15 16:39:51', '', '39', 'http://127.0.0.1/asug/39-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('41', '1', '2014-03-15 16:40:22', '2014-03-15 16:40:22', '', 'Empresas associadas', '', 'publish', 'open', 'open', '', 'empresas-associadas', '', '', '2014-03-20 15:40:33', '2014-03-20 15:40:33', '', '6', 'http://127.0.0.1/asug/?page_id=41', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('42', '1', '2014-03-15 16:40:22', '2014-03-15 16:40:22', '', 'Empresas associadas', '', 'inherit', 'open', 'open', '', '41-revision-v1', '', '', '2014-03-15 16:40:22', '2014-03-15 16:40:22', '', '41', 'http://127.0.0.1/asug/41-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('43', '1', '2014-03-15 16:40:46', '2014-03-15 16:40:46', '', 'Parceiros associados', '', 'publish', 'open', 'open', '', 'parceiros-associados', '', '', '2014-03-20 15:40:53', '2014-03-20 15:40:53', '', '6', 'http://127.0.0.1/asug/?page_id=43', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('44', '1', '2014-03-15 16:40:46', '2014-03-15 16:40:46', '', 'Parceiros associados', '', 'inherit', 'open', 'open', '', '43-revision-v1', '', '', '2014-03-15 16:40:46', '2014-03-15 16:40:46', '', '43', 'http://127.0.0.1/asug/43-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('45', '1', '2014-03-15 17:25:27', '2014-03-15 17:25:27', ' ', '', '', 'publish', 'open', 'open', '', '45', '', '', '2014-04-12 19:19:07', '2014-04-12 19:19:07', '', '0', 'http://127.0.0.1/asug/?p=45', '1', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('47', '1', '2014-03-15 17:25:27', '2014-03-15 17:25:27', ' ', '', '', 'publish', 'open', 'open', '', '47', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '0', 'http://127.0.0.1/asug/?p=47', '8', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('48', '1', '2014-03-15 17:25:27', '2014-03-15 17:25:27', ' ', '', '', 'publish', 'open', 'open', '', '48', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '0', 'http://127.0.0.1/asug/?p=48', '12', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('49', '1', '2014-03-15 17:25:28', '2014-03-15 17:25:28', ' ', '', '', 'publish', 'open', 'open', '', '49', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '0', 'http://127.0.0.1/asug/?p=49', '13', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('50', '1', '2014-03-15 17:25:28', '2014-03-15 17:25:28', ' ', '', '', 'publish', 'open', 'open', '', '50', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '0', 'http://127.0.0.1/asug/?p=50', '10', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('54', '1', '2014-03-15 17:25:28', '2014-03-15 17:25:28', ' ', '', '', 'publish', 'open', 'open', '', '54', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '0', 'http://127.0.0.1/asug/?p=54', '11', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('56', '1', '2014-03-15 17:25:29', '2014-03-15 17:25:29', ' ', '', '', 'publish', 'open', 'open', '', '56', '', '', '2014-04-12 19:19:07', '2014-04-12 19:19:07', '', '6', 'http://127.0.0.1/asug/?p=56', '3', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('57', '1', '2014-03-15 17:25:29', '2014-03-15 17:25:29', ' ', '', '', 'publish', 'open', 'open', '', '57', '', '', '2014-04-12 19:19:07', '2014-04-12 19:19:07', '', '6', 'http://127.0.0.1/asug/?p=57', '4', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('58', '1', '2014-03-15 17:25:29', '2014-03-15 17:25:29', ' ', '', '', 'publish', 'open', 'open', '', '58', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '6', 'http://127.0.0.1/asug/?p=58', '5', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('59', '1', '2014-03-15 17:25:29', '2014-03-15 17:25:29', ' ', '', '', 'publish', 'open', 'open', '', '59', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '6', 'http://127.0.0.1/asug/?p=59', '6', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('60', '1', '2014-03-15 17:25:29', '2014-03-15 17:25:29', ' ', '', '', 'publish', 'open', 'open', '', '60', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '6', 'http://127.0.0.1/asug/?p=60', '7', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('61', '1', '2014-03-15 18:29:14', '2014-03-15 18:29:14', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/asug-brasil.jpg', 'asug-brasil.jpg', '', 'inherit', 'closed', 'open', '', 'asug-brasil-jpg', '', '', '2014-03-15 18:29:14', '2014-03-15 18:29:14', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/asug-brasil.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('63', '1', '2014-03-16 04:34:08', '2014-03-16 04:34:08', '', 'slider', '', 'inherit', 'closed', 'open', '', 'slider', '', '', '2014-03-16 04:34:08', '2014-03-16 04:34:08', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/slider.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('64', '1', '2014-03-16 05:06:14', '2014-03-16 05:06:14', '', 'banner03', '', 'inherit', 'closed', 'open', '', 'banner03', '', '', '2014-03-16 05:06:14', '2014-03-16 05:06:14', '', '72', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/banner03.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('65', '1', '2014-03-16 05:06:17', '2014-03-16 05:06:17', '', 'banner04', '', 'inherit', 'closed', 'open', '', 'banner04', '', '', '2014-03-16 05:06:17', '2014-03-16 05:06:17', '', '74', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/banner04.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('66', '1', '2014-03-16 05:06:21', '2014-03-16 05:06:21', '', 'banner01', '', 'inherit', 'closed', 'open', '', 'banner01', '', '', '2014-03-16 05:06:21', '2014-03-16 05:06:21', '', '68', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/banner01.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('67', '1', '2014-03-16 05:06:24', '2014-03-16 05:06:24', '', 'banner02', '', 'inherit', 'closed', 'open', '', 'banner02', '', '', '2014-03-16 05:06:24', '2014-03-16 05:06:24', '', '70', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/banner02.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('68', '1', '2014-03-16 06:11:23', '2014-03-16 06:11:23', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner01.jpg"><img src="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner01.jpg" alt="banner01" width="235" height="122" class="alignnone size-full wp-image-66" /></a>', 'banner01', '', 'publish', 'closed', 'closed', '', 'banner01', '', '', '2014-03-16 06:12:50', '2014-03-16 06:12:50', '', '0', 'http://127.0.0.1/asug/?post_type=dfads&#038;p=68', '0', 'dfads', '', '0'); 
INSERT INTO `wp_posts` VALUES ('69', '1', '2014-03-16 06:11:23', '2014-03-16 06:11:23', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner01.jpg"><img src="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner01.jpg" alt="banner01" width="235" height="122" class="alignnone size-full wp-image-66" /></a>', 'banner01', '', 'inherit', 'closed', 'open', '', '68-revision-v1', '', '', '2014-03-16 06:11:23', '2014-03-16 06:11:23', '', '68', 'http://127.0.0.1/asug/68-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('70', '1', '2014-03-16 06:13:36', '2014-03-16 06:13:36', '<a href="#"><img src="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner02.jpg" alt="banner02" width="234" height="122" class="alignnone size-full wp-image-67" /></a>', 'banner02', '', 'publish', 'closed', 'closed', '', 'banner02', '', '', '2014-03-16 06:13:36', '2014-03-16 06:13:36', '', '0', 'http://127.0.0.1/asug/?post_type=dfads&#038;p=70', '0', 'dfads', '', '0'); 
INSERT INTO `wp_posts` VALUES ('71', '1', '2014-03-16 06:13:36', '2014-03-16 06:13:36', '<a href="#"><img src="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner02.jpg" alt="banner02" width="234" height="122" class="alignnone size-full wp-image-67" /></a>', 'banner02', '', 'inherit', 'closed', 'open', '', '70-revision-v1', '', '', '2014-03-16 06:13:36', '2014-03-16 06:13:36', '', '70', 'http://127.0.0.1/asug/70-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('72', '1', '2014-03-16 06:14:19', '2014-03-16 06:14:19', '<a href="#"><img src="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner03.jpg" alt="banner03" width="235" height="121" class="alignnone size-full wp-image-64" /></a>', 'banner03', '', 'publish', 'closed', 'closed', '', 'banner03', '', '', '2014-03-16 06:14:19', '2014-03-16 06:14:19', '', '0', 'http://127.0.0.1/asug/?post_type=dfads&#038;p=72', '0', 'dfads', '', '0'); 
INSERT INTO `wp_posts` VALUES ('73', '1', '2014-03-16 06:14:19', '2014-03-16 06:14:19', '<a href="#"><img src="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner03.jpg" alt="banner03" width="235" height="121" class="alignnone size-full wp-image-64" /></a>', 'banner03', '', 'inherit', 'closed', 'open', '', '72-revision-v1', '', '', '2014-03-16 06:14:19', '2014-03-16 06:14:19', '', '72', 'http://127.0.0.1/asug/72-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('74', '1', '2014-03-16 06:14:50', '2014-03-16 06:14:50', '<a href="#"><img src="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner04.jpg" alt="banner04" width="235" height="121" class="alignnone size-full wp-image-65" /></a>', 'banner04', '', 'publish', 'closed', 'closed', '', 'banner04', '', '', '2014-03-16 06:14:50', '2014-03-16 06:14:50', '', '0', 'http://127.0.0.1/asug/?post_type=dfads&#038;p=74', '0', 'dfads', '', '0'); 
INSERT INTO `wp_posts` VALUES ('75', '1', '2014-03-16 06:14:50', '2014-03-16 06:14:50', '<a href="#"><img src="http://127.0.0.1/asug/wp-content/uploads/2014/03/banner04.jpg" alt="banner04" width="235" height="121" class="alignnone size-full wp-image-65" /></a>', 'banner04', '', 'inherit', 'closed', 'open', '', '74-revision-v1', '', '', '2014-03-16 06:14:50', '2014-03-16 06:14:50', '', '74', 'http://127.0.0.1/asug/74-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('76', '1', '2014-03-16 17:36:33', '2014-03-16 17:36:33', '', 'Fórum', '', 'publish', 'closed', 'open', '', 'forum', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '0', 'http://127.0.0.1/asug/?p=76', '9', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('77', '1', '2014-03-16 19:59:29', '2014-03-16 19:59:29', '', 'eventos01', '', 'inherit', 'closed', 'open', '', 'eventos01', '', '', '2014-03-16 19:59:29', '2014-03-16 19:59:29', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/eventos01.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('78', '1', '2014-03-16 19:59:32', '2014-03-16 19:59:32', '', 'eventos02', '', 'inherit', 'closed', 'open', '', 'eventos02', '', '', '2014-03-16 19:59:32', '2014-03-16 19:59:32', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/eventos02.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('79', '1', '2014-03-16 22:38:16', '2014-03-16 22:38:16', 'CONTENTS', 'Eventos', 'CONTENTS', 'publish', 'closed', 'open', '', 'eventos', '', '', '2014-03-16 22:38:16', '2014-03-16 22:38:16', '', '0', 'http://127.0.0.1/asug/eventos/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('80', '1', '2014-03-16 22:38:17', '2014-03-16 22:38:17', 'CONTENTS', 'Locais', '', 'publish', 'closed', 'open', '', 'locais', '', '', '2014-03-16 22:38:17', '2014-03-16 22:38:17', '', '79', 'http://127.0.0.1/asug/eventos/locais/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('81', '1', '2014-03-16 22:38:17', '2014-03-16 22:38:17', 'CONTENTS', 'Categorias', '', 'publish', 'closed', 'open', '', 'categorias', '', '', '2014-03-16 22:38:17', '2014-03-16 22:38:17', '', '79', 'http://127.0.0.1/asug/eventos/categorias/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('82', '1', '2014-03-16 22:38:18', '2014-03-16 22:38:18', 'CONTENTS', 'Tags', '', 'publish', 'closed', 'open', '', 'tags', '', '', '2014-03-16 22:38:18', '2014-03-16 22:38:18', '', '79', 'http://127.0.0.1/asug/eventos/tags/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('83', '1', '2014-03-16 22:38:19', '2014-03-16 22:38:19', 'CONTENTS', 'Minhas Reservas', '', 'publish', 'closed', 'open', '', 'minhas-reservas', '', '', '2014-03-16 22:38:19', '2014-03-16 22:38:19', '', '79', 'http://127.0.0.1/asug/eventos/minhas-reservas/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('86', '1', '2014-03-16 23:39:19', '2014-03-16 23:39:19', '', 'eventos01', '', 'inherit', 'closed', 'open', '', 'eventos01-2', '', '', '2014-03-16 23:39:19', '2014-03-16 23:39:19', '', '1', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/eventos011.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('87', '1', '2014-03-16 23:39:21', '2014-03-16 23:39:21', '', 'eventos02', '', 'inherit', 'closed', 'open', '', 'eventos02-2', '', '', '2014-03-16 23:39:21', '2014-03-16 23:39:21', '', '1', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/eventos021.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('88', '1', '2014-03-16 23:45:29', '2014-03-16 23:45:29', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG Day Porto Alegre 2013', '', 'inherit', 'closed', 'open', '', '1-autosave-v1', '', '', '2014-03-16 23:45:29', '2014-03-16 23:45:29', '', '1', 'http://127.0.0.1/asug/1-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('89', '1', '2014-03-16 23:45:36', '2014-03-16 23:45:36', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG Day Porto Alegre 2013', '', 'inherit', 'closed', 'open', '', '1-revision-v1', '', '', '2014-03-16 23:45:36', '2014-03-16 23:45:36', '', '1', 'http://127.0.0.1/asug/1-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('90', '1', '2014-03-16 23:46:09', '2014-03-16 23:46:09', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG DAY GOIÂNIA 2013', '', 'publish', 'closed', 'open', '', 'asug-day-goiania-2013', '', '', '2014-03-16 23:46:09', '2014-03-16 23:46:09', '', '0', 'http://127.0.0.1/asug/?p=90', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('91', '1', '2014-03-16 23:46:09', '2014-03-16 23:46:09', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG DAY GOIÂNIA 2013', '', 'inherit', 'closed', 'open', '', '90-revision-v1', '', '', '2014-03-16 23:46:09', '2014-03-16 23:46:09', '', '90', 'http://127.0.0.1/asug/90-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('92', '1', '2014-03-16 23:46:37', '2014-03-16 23:46:37', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG DAY SÃO PAULO 2014', '', 'publish', 'closed', 'open', '', 'asug-day-sao-paulo-2014', '', '', '2014-03-16 23:46:37', '2014-03-16 23:46:37', '', '0', 'http://127.0.0.1/asug/?p=92', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('93', '1', '2014-03-16 23:46:37', '2014-03-16 23:46:37', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG DAY SÃO PAULO 2014', '', 'inherit', 'closed', 'open', '', '92-revision-v1', '', '', '2014-03-16 23:46:37', '2014-03-16 23:46:37', '', '92', 'http://127.0.0.1/asug/92-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('94', '1', '2014-03-16 23:47:08', '2014-03-16 23:47:08', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG DAY CURITIBA 2014', '', 'publish', 'closed', 'open', '', 'asug-day-curitiba-2014', '', '', '2014-03-16 23:47:08', '2014-03-16 23:47:08', '', '0', 'http://127.0.0.1/asug/?p=94', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('95', '1', '2014-03-16 23:47:08', '2014-03-16 23:47:08', 'Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!

Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!', 'ASUG DAY CURITIBA 2014', '', 'inherit', 'closed', 'open', '', '94-revision-v1', '', '', '2014-03-16 23:47:08', '2014-03-16 23:47:08', '', '94', 'http://127.0.0.1/asug/94-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('96', '1', '2014-03-19 01:29:33', '2014-03-19 01:29:33', '', 'Loja', '', 'trash', 'closed', 'open', '', 'loja', '', '', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', '0', 'http://127.0.0.1/asug/loja/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('97', '1', '2014-03-19 01:29:34', '2014-03-19 01:29:34', '[woocommerce_cart]', 'Carrinho', '', 'trash', 'closed', 'open', '', 'carrinho', '', '', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', '0', 'http://127.0.0.1/asug/carrinho/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('98', '1', '2014-03-19 01:29:34', '2014-03-19 01:29:34', '[woocommerce_checkout]', 'Finalizar compra', '', 'trash', 'closed', 'open', '', 'finalizar-compra', '', '', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', '0', 'http://127.0.0.1/asug/finalizar-compra/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('99', '1', '2014-03-19 01:29:34', '2014-03-19 01:29:34', '[woocommerce_my_account]', 'Minha conta', '', 'trash', 'closed', 'open', '', 'minha-conta', '', '', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', '0', 'http://127.0.0.1/asug/minha-conta/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('102', '1', '2014-03-20 02:20:18', '2014-03-20 02:20:18', '', 'Register', '', 'publish', 'closed', 'open', '', 'register', '', '', '2014-03-20 02:20:18', '2014-03-20 02:20:18', '', '0', 'http://127.0.0.1/asug/register/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('103', '1', '2014-03-20 02:20:18', '2014-03-20 02:20:18', '', 'Account', '', 'publish', 'closed', 'open', '', 'account', '', '', '2014-03-20 02:20:18', '2014-03-20 02:20:18', '', '0', 'http://127.0.0.1/asug/account/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('104', '1', '2014-03-20 02:20:18', '2014-03-20 02:20:18', '<p>The content you are trying to access is only available to members. Sorry.</p>', 'Protected Content', '', 'publish', 'closed', 'open', '', 'protected', '', '', '2014-03-20 02:20:18', '2014-03-20 02:20:18', '', '0', 'http://127.0.0.1/asug/protected/', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('111', '1', '2014-03-20 15:39:45', '2014-03-20 15:39:45', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl.

Morbi in elementum justo. Aenean commodo sapien vulputate, vehicula lectus non, luctus augue. Nullam pulvinar tincidunt elementum. Integer ipsum neque, fermentum eu dignissim id, ultrices a augue. Integer eleifend neque in nisi euismod condimentum. Vestibulum mauris metus, hendrerit at lectus vel, sollicitudin semper libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla arcu dui, feugiat quis blandit id, elementum at est. Maecenas a nulla imperdiet, egestas est sit amet, cursus lacus. Nunc in ullamcorper mi. Nam purus nulla, cursus eu ornare ut, pellentesque in sapien. Sed ornare sapien nec erat pretium, mollis tincidunt nisl feugiat. Fusce at varius neque, ut vulputate ipsum. Duis sit amet odio lobortis, interdum turpis sit amet, tempor enim. Etiam justo urna, ullamcorper eget mollis vitae, hendrerit ut erat. Duis viverra malesuada consequat.

Nulla venenatis urna a massa suscipit feugiat. Nulla facilisi. Integer libero odio, ultrices et dui ac, cursus sollicitudin sem. Sed ut libero non nulla aliquam accumsan. Nam blandit purus sit amet turpis elementum tincidunt. Nunc quis ipsum sed mauris scelerisque varius at ut nisl. Duis tortor urna, ornare interdum quam at, iaculis lobortis elit. Pellentesque id consectetur felis. Mauris facilisis massa vitae elit consectetur venenatis.

Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis.

Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Comitê estratégico', '', 'inherit', 'closed', 'open', '', '39-revision-v1', '', '', '2014-03-20 15:39:45', '2014-03-20 15:39:45', '', '39', 'http://127.0.0.1/asug/39-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('112', '1', '2014-03-20 15:40:03', '2014-03-20 15:40:03', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl.

Morbi in elementum justo. Aenean commodo sapien vulputate, vehicula lectus non, luctus augue. Nullam pulvinar tincidunt elementum. Integer ipsum neque, fermentum eu dignissim id, ultrices a augue. Integer eleifend neque in nisi euismod condimentum. Vestibulum mauris metus, hendrerit at lectus vel, sollicitudin semper libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla arcu dui, feugiat quis blandit id, elementum at est. Maecenas a nulla imperdiet, egestas est sit amet, cursus lacus. Nunc in ullamcorper mi. Nam purus nulla, cursus eu ornare ut, pellentesque in sapien. Sed ornare sapien nec erat pretium, mollis tincidunt nisl feugiat. Fusce at varius neque, ut vulputate ipsum. Duis sit amet odio lobortis, interdum turpis sit amet, tempor enim. Etiam justo urna, ullamcorper eget mollis vitae, hendrerit ut erat. Duis viverra malesuada consequat.

Nulla venenatis urna a massa suscipit feugiat. Nulla facilisi. Integer libero odio, ultrices et dui ac, cursus sollicitudin sem. Sed ut libero non nulla aliquam accumsan. Nam blandit purus sit amet turpis elementum tincidunt. Nunc quis ipsum sed mauris scelerisque varius at ut nisl. Duis tortor urna, ornare interdum quam at, iaculis lobortis elit. Pellentesque id consectetur felis. Mauris facilisis massa vitae elit consectetur venenatis.

Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis.

Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Conselho administrativo', '', 'inherit', 'closed', 'open', '', '37-autosave-v1', '', '', '2014-03-20 15:40:03', '2014-03-20 15:40:03', '', '37', 'http://127.0.0.1/asug/37-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('113', '1', '2014-03-20 15:40:28', '2014-03-20 15:40:28', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl.

Morbi in elementum justo. Aenean commodo sapien vulputate, vehicula lectus non, luctus augue. Nullam pulvinar tincidunt elementum. Integer ipsum neque, fermentum eu dignissim id, ultrices a augue. Integer eleifend neque in nisi euismod condimentum. Vestibulum mauris metus, hendrerit at lectus vel, sollicitudin semper libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla arcu dui, feugiat quis blandit id, elementum at est. Maecenas a nulla imperdiet, egestas est sit amet, cursus lacus. Nunc in ullamcorper mi. Nam purus nulla, cursus eu ornare ut, pellentesque in sapien. Sed ornare sapien nec erat pretium, mollis tincidunt nisl feugiat. Fusce at varius neque, ut vulputate ipsum. Duis sit amet odio lobortis, interdum turpis sit amet, tempor enim. Etiam justo urna, ullamcorper eget mollis vitae, hendrerit ut erat. Duis viverra malesuada consequat.

Nulla venenatis urna a massa suscipit feugiat. Nulla facilisi. Integer libero odio, ultrices et dui ac, cursus sollicitudin sem. Sed ut libero non nulla aliquam accumsan. Nam blandit purus sit amet turpis elementum tincidunt. Nunc quis ipsum sed mauris scelerisque varius at ut nisl. Duis tortor urna, ornare interdum quam at, iaculis lobortis elit. Pellentesque id consectetur felis. Mauris facilisis massa vitae elit consectetur venenatis.

Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis.

Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Conselho administrativo', '', 'inherit', 'closed', 'open', '', '37-revision-v1', '', '', '2014-03-20 15:40:28', '2014-03-20 15:40:28', '', '37', 'http://127.0.0.1/asug/37-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('114', '1', '2014-03-21 02:04:06', '2014-03-21 02:04:06', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl. Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis. Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Comitê estratégico', '', 'inherit', 'closed', 'open', '', '39-autosave-v1', '', '', '2014-03-21 02:04:06', '2014-03-21 02:04:06', '', '39', 'http://127.0.0.1/asug/39-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('115', '1', '2014-03-20 15:44:13', '2014-03-20 15:44:13', '', 'Parceiros associados', '', 'inherit', 'closed', 'open', '', '43-autosave-v1', '', '', '2014-03-20 15:44:13', '2014-03-20 15:44:13', '', '43', 'http://127.0.0.1/asug/43-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('116', '1', '2014-03-20 16:11:44', '2014-03-20 16:11:44', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl.

Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis.

Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Comitê estratégico', '', 'inherit', 'closed', 'open', '', '39-revision-v1', '', '', '2014-03-20 16:11:44', '2014-03-20 16:11:44', '', '39', 'http://127.0.0.1/asug/39-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('117', '999999999', '2014-03-20 19:25:58', '2014-03-20 19:25:58', 'WP Backupware - 1395343555', 'WP Backupware - 1395343555', '', 'private', 'closed', 'open', '', 'wp-backupware-1395343555', '', '', '2014-03-20 19:25:58', '2014-03-20 19:25:58', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395343555/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('118', '999999999', '2014-03-20 19:26:27', '2014-03-20 19:26:27', 'WP Backupware - 1395343586', 'WP Backupware - 1395343586', '', 'private', 'closed', 'open', '', 'wp-backupware-1395343586', '', '', '2014-03-20 19:26:27', '2014-03-20 19:26:27', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395343586/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('119', '1', '2014-03-21 00:02:02', '2014-03-21 00:02:02', '', 'banner', '', 'inherit', 'closed', 'open', '', 'banner', '', '', '2014-03-21 00:02:02', '2014-03-21 00:02:02', '', '39', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/banner.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('120', '1', '2014-03-21 01:41:03', '2014-03-21 01:41:03', '', 'banner_comite', '', 'inherit', 'closed', 'open', '', 'banner_comite', '', '', '2014-03-21 01:41:03', '2014-03-21 01:41:03', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/banner_comite.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('121', '1', '2014-03-21 02:36:56', '2014-03-21 02:36:56', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl. Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis. Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Comitê estratégico', '', 'inherit', 'closed', 'open', '', '39-revision-v1', '', '', '2014-03-21 02:36:56', '2014-03-21 02:36:56', '', '39', 'http://127.0.0.1/asug/39-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('123', '1', '2014-03-21 15:57:22', '2014-03-21 15:57:22', '', 'banner', '', 'inherit', 'closed', 'open', '', 'banner-2', '', '', '2014-03-21 15:57:22', '2014-03-21 15:57:22', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/banner1.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('124', '999999999', '2014-03-21 19:53:51', '2014-03-21 19:53:51', 'WP Backupware - 1395431624', 'WP Backupware - 1395431624', '', 'private', 'closed', 'open', '', 'wp-backupware-1395431624', '', '', '2014-03-21 19:53:51', '2014-03-21 19:53:51', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395431624/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('125', '1', '2014-03-22 01:17:57', '2014-03-22 01:17:57', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl. Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis. Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.

[contact-form-7 id="4" title="Formulário de contato 1"]', 'Comitê estratégico', '', 'inherit', 'closed', 'open', '', '39-revision-v1', '', '', '2014-03-22 01:17:57', '2014-03-22 01:17:57', '', '39', 'http://127.0.0.1/asug/39-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('126', '1', '2014-03-22 03:46:10', '2014-03-22 03:46:10', '', 'sua_fatura_de_energia_mesref_201403', '', 'inherit', 'closed', 'open', '', 'sua_fatura_de_energia_mesref_201403', '', '', '2014-03-22 03:46:10', '2014-03-22 03:46:10', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014031.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('127', '1', '2014-03-22 04:01:21', '2014-03-22 04:01:21', '', 'sua_fatura_de_energia_mesref_201403', '', 'inherit', 'closed', 'open', '', 'sua_fatura_de_energia_mesref_201403-2', '', '', '2014-03-22 04:01:21', '2014-03-22 04:01:21', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014032.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('128', '1', '2014-03-22 04:02:07', '2014-03-22 04:02:07', '', 'sua_fatura_de_energia_mesref_201403', '', 'inherit', 'closed', 'open', '', 'sua_fatura_de_energia_mesref_201403-3', '', '', '2014-03-22 04:02:07', '2014-03-22 04:02:07', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014033.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('129', '1', '2014-03-22 04:09:29', '2014-03-22 04:09:29', '', 'sua_fatura_de_energia_mesref_201403', '', 'inherit', 'closed', 'open', '', 'sua_fatura_de_energia_mesref_201403-4', '', '', '2014-03-22 04:09:29', '2014-03-22 04:09:29', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014034.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('130', '1', '2014-03-22 04:10:50', '2014-03-22 04:10:50', '', 'sua_fatura_de_energia_mesref_201403', '', 'inherit', 'closed', 'open', '', 'sua_fatura_de_energia_mesref_201403-5', '', '', '2014-03-22 04:10:50', '2014-03-22 04:10:50', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014035.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('131', '1', '2014-03-22 04:12:00', '2014-03-22 04:12:00', '', 'sua_fatura_de_energia_mesref_201403', '', 'inherit', 'closed', 'open', '', 'sua_fatura_de_energia_mesref_201403-6', '', '', '2014-03-22 04:12:00', '2014-03-22 04:12:00', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014036.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('132', '1', '2014-03-22 04:13:12', '2014-03-22 04:13:12', '', 'sua_fatura_de_energia_mesref_201403', '', 'inherit', 'closed', 'open', '', 'sua_fatura_de_energia_mesref_201403-7', '', '', '2014-03-22 04:13:12', '2014-03-22 04:13:12', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014037.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('133', '1', '2014-03-22 04:13:33', '2014-03-22 04:13:33', '', 'sua_fatura_de_energia_mesref_201403', '', 'inherit', 'closed', 'open', '', 'sua_fatura_de_energia_mesref_201403-8', '', '', '2014-03-22 04:13:33', '2014-03-22 04:13:33', '', '171', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014038.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('134', '1', '2014-03-22 04:15:21', '2014-03-22 04:15:21', '', 'wireframe-interna-ASUG', '', 'inherit', 'closed', 'open', '', 'wireframe-interna-asug', '', '', '2014-03-22 04:15:21', '2014-03-22 04:15:21', '', '177', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/wireframe-interna-ASUG.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('135', '999999999', '2014-03-23 17:37:44', '2014-03-23 17:37:44', 'WP Backupware - 1395596264', 'WP Backupware - 1395596264', '', 'private', 'closed', 'open', '', 'wp-backupware-1395596264', '', '', '2014-03-23 17:37:44', '2014-03-23 17:37:44', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395596264/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('136', '999999999', '2014-03-23 19:26:05', '2014-03-23 19:26:05', 'WP Backupware - 1395602764', 'WP Backupware - 1395602764', '', 'private', 'closed', 'open', '', 'wp-backupware-1395602764', '', '', '2014-03-23 19:26:05', '2014-03-23 19:26:05', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395602764/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('137', '1', '2014-03-23 19:39:41', '2014-03-23 19:39:41', '<strong>Modelos</strong> de e-mail da <em>ASUG</em>

<a href="[boleto_usuario]" target="_blank">Funciona</a>???

&nbsp;

teste', 'E-mail Boleto - Asug', '', 'publish', 'closed', 'open', '', 'e-mail-boleto-asug', '', '', '2014-03-23 22:28:28', '2014-03-23 22:28:28', '', '0', 'http://127.0.0.1/asug/?page_id=137', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('138', '1', '2014-03-23 19:39:41', '2014-03-23 19:39:41', 'Modelos de e-mail da ASUG

Funciona???

&nbsp;

teste', 'E-mail Boleto - Asug', '', 'inherit', 'closed', 'open', '', '137-revision-v1', '', '', '2014-03-23 19:39:41', '2014-03-23 19:39:41', '', '137', 'http://127.0.0.1/asug/137-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('139', '1', '2014-03-23 21:09:45', '2014-03-23 21:09:45', '', 'Home', '', 'inherit', 'closed', 'open', '', '2-revision-v1', '', '', '2014-03-23 21:09:45', '2014-03-23 21:09:45', '', '2', 'http://127.0.0.1/asug/2-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('140', '1', '2014-03-23 21:16:53', '2014-03-23 21:16:53', '<ul class="destaque">
						<li>
							<a href="">
								<img class="img_ntc" src="images/notici01.jpg" height="75" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>As perspectivas para a TI</h2>
							</a>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Officiis, eaque, dolorem, explicabo sapiente consectetur quam expedita beatae assumenda enim qui unde eius ullam. Libero, earum, similique iure dolorum modi at.</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia02.jpg" height="75" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>SAP traz novo conceito de treinamento empresarial ao Brasil</h2>
							</a>
								<p>Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia03.jpg" height="74" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>As perspectivas a TI</h2>
							</a>
								<p>Non, fugit, velit rerum suscipit magni optio quam unde dolores eveniet fugiat dolorum nam labore cum quidem aliquam placeat dignissimos. Quas, quis iste placeat veritatis assumenda sapiente praesentium provident facere.</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia04.jpg" height="74" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>SAP traz novo conceito de treinamento empresarial ao Brasil </h2>
							</a>
								<p>Numquam, deserunt, unde alias labore dolorem fugiat eius molestiae! Quisquam, ut, voluptate, unde, culpa necessitatibus beatae itaque nisi ducimus nobis explicabo distinctio possimus eos inventore eligendi amet officiis fugiat accusamus.</p>
						</li>
					</ul>', 'Home', '', 'inherit', 'closed', 'open', '', '2-revision-v1', '', '', '2014-03-23 21:16:53', '2014-03-23 21:16:53', '', '2', 'http://127.0.0.1/asug/2-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('141', '1', '2014-03-23 21:18:30', '2014-03-23 21:18:30', '<ul class="destaque">
						<li>
							<a href=""><img class="img_ntc" src="images/notici01.jpg" height="75" width="75" alt=""></a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href=""><h2>As perspectivas para a TI</h2></a><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Officiis, eaque, dolorem, explicabo sapiente consectetur quam expedita beatae assumenda enim qui unde eius ullam. Libero, earum, similique iure dolorum modi at.</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia02.jpg" height="75" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>SAP traz novo conceito de treinamento empresarial ao Brasil</h2>
							</a>
								<p>Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia03.jpg" height="74" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>As perspectivas a TI</h2>
							</a>
								<p>Non, fugit, velit rerum suscipit magni optio quam unde dolores eveniet fugiat dolorum nam labore cum quidem aliquam placeat dignissimos. Quas, quis iste placeat veritatis assumenda sapiente praesentium provident facere.</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia04.jpg" height="74" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>SAP traz novo conceito de treinamento empresarial ao Brasil </h2>
							</a>
								<p>Numquam, deserunt, unde alias labore dolorem fugiat eius molestiae! Quisquam, ut, voluptate, unde, culpa necessitatibus beatae itaque nisi ducimus nobis explicabo distinctio possimus eos inventore eligendi amet officiis fugiat accusamus.</p>
						</li>
					</ul>', 'Home', '', 'inherit', 'closed', 'open', '', '2-revision-v1', '', '', '2014-03-23 21:18:30', '2014-03-23 21:18:30', '', '2', 'http://127.0.0.1/asug/2-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('142', '1', '2014-03-23 21:23:21', '2014-03-23 21:23:21', '<ul class="destaque">
						<li>
							<a href="">
								<img class="img_ntc" src="images/notici01.jpg" height="75" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>As perspectivas para a TI</h2>
							</a>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Officiis, eaque, dolorem, explicabo sapiente consectetur quam expedita beatae assumenda enim qui unde eius ullam. Libero, earum, similique iure dolorum modi at.</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia02.jpg" height="75" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>SAP traz novo conceito de treinamento empresarial ao Brasil</h2>
							</a>
								<p>Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia03.jpg" height="74" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>As perspectivas a TI</h2>
							</a>
								<p>Non, fugit, velit rerum suscipit magni optio quam unde dolores eveniet fugiat dolorum nam labore cum quidem aliquam placeat dignissimos. Quas, quis iste placeat veritatis assumenda sapiente praesentium provident facere.</p>
						</li>
						<li>
							<a href="">
								<img class="img_ntc" src="images/noticia04.jpg" height="74" width="75" alt="">
							</a>
							<span class="dt_postagem"><time>04/04/2013 19:12:42</time></span>
							<a href="">
								<h2>SAP traz novo conceito de treinamento empresarial ao Brasil </h2>
							</a>
								<p>Numquam, deserunt, unde alias labore dolorem fugiat eius molestiae! Quisquam, ut, voluptate, unde, culpa necessitatibus beatae itaque nisi ducimus nobis explicabo distinctio possimus eos inventore eligendi amet officiis fugiat accusamus.</p>
						</li>
					</ul>', 'Home', '', 'inherit', 'closed', 'open', '', '2-autosave-v1', '', '', '2014-03-23 21:23:21', '2014-03-23 21:23:21', '', '2', 'http://127.0.0.1/asug/2-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('143', '1', '2014-03-23 21:21:16', '2014-03-23 21:21:16', '<ul class="destaque">
<li><a href=""><img class="img_ntc" src="images/notici01.jpg" height="75" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href=""><h2>As perspectivas para a TI</h2></a><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Officiis, eaque, dolorem, explicabo sapiente consectetur quam expedita beatae assumenda enim qui unde eius ullam. Libero, earum, similique iure dolorum modi at.</p></li>

<li><a href=""><img class="img_ntc" src="images/noticia02.jpg" height="75" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href=""><h2>SAP traz novo conceito de treinamento empresarial ao Brasil</h2></a><p>Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!</p></li>

<li><a href=""><img class="img_ntc" src="images/noticia03.jpg" height="74" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span<a href=""><h2>As perspectivas a TI</h2></a><p>Non, fugit, velit rerum suscipit magni optio quam unde dolores eveniet fugiat dolorum nam labore cum quidem aliquam placeat dignissimos. Quas, quis iste placeat veritatis assumenda sapiente praesentium provident facere.</p></li>

<li><a href=""><img class="img_ntc" src="images/noticia04.jpg" height="74" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href=""><h2>SAP traz novo conceito de treinamento empresarial ao Brasil </h2></a><p>Numquam, deserunt, unde alias labore dolorem fugiat eius molestiae! Quisquam, ut, voluptate, unde, culpa necessitatibus beatae itaque nisi ducimus nobis explicabo distinctio possimus eos inventore eligendi amet officiis fugiat accusamus.</p></li>
</ul>', 'Home', '', 'inherit', 'closed', 'open', '', '2-revision-v1', '', '', '2014-03-23 21:21:16', '2014-03-23 21:21:16', '', '2', 'http://127.0.0.1/asug/2-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('144', '1', '2014-03-23 21:23:53', '2014-03-23 21:23:53', '<ul class="destaque">
<li><a href=""><img class="img_ntc" src="images/notici01.jpg" height="75" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href=""><h2>As perspectivas para a TI</h2></a><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Officiis, eaque, dolorem, explicabo sapiente consectetur quam expedita beatae assumenda enim qui unde eius ullam. Libero, earum, similique iure dolorum modi at.</p></li>
<li><a href=""><img class="img_ntc" src="images/noticia02.jpg" height="75" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href=""><h2>SAP traz novo conceito de treinamento empresarial ao Brasil</h2></a><p>Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!</p></li>
<li><a href=""><img class="img_ntc" src="images/noticia03.jpg" height="74" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href=""><h2>As perspectivas a TI</h2></a><p>Non, fugit, velit rerum suscipit magni optio quam unde dolores eveniet fugiat dolorum nam labore cum quidem aliquam placeat dignissimos. Quas, quis iste placeat veritatis assumenda sapiente praesentium provident facere.</p></li>
<li><a href=""><img class="img_ntc" src="images/noticia04.jpg" height="74" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href=""><h2>SAP traz novo conceito de treinamento empresarial ao Brasil </h2></a><p>Numquam, deserunt, unde alias labore dolorem fugiat eius molestiae! Quisquam, ut, voluptate, unde, culpa necessitatibus beatae itaque nisi ducimus nobis explicabo distinctio possimus eos inventore eligendi amet officiis fugiat accusamus.</p>
</li>
</ul>', 'Home', '', 'inherit', 'closed', 'open', '', '2-revision-v1', '', '', '2014-03-23 21:23:53', '2014-03-23 21:23:53', '', '2', 'http://127.0.0.1/asug/2-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('145', '1', '2014-03-23 21:24:35', '2014-03-23 21:24:35', '<ul class="destaque">
<li><a href="#"><img class="img_ntc" src="images/notici01.jpg" height="75" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href="#"><h2>As perspectivas para a TI</h2></a><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Officiis, eaque, dolorem, explicabo sapiente consectetur quam expedita beatae assumenda enim qui unde eius ullam. Libero, earum, similique iure dolorum modi at.</p></li>
<li><a href="#"><img class="img_ntc" src="images/noticia02.jpg" height="75" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href="#"><h2>SAP traz novo conceito de treinamento empresarial ao Brasil</h2></a><p>Accusantium, possimus, harum consequuntur et quis id similique ut repellendus est eaque quas sapiente officiis ullam dolorem ipsa magni porro ex debitis obcaecati assumenda doloribus laudantium a dolorum accusamus adipisci!</p></li>
<li><a href="#"><img class="img_ntc" src="images/noticia03.jpg" height="74" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href="#"><h2>As perspectivas a TI</h2></a><p>Non, fugit, velit rerum suscipit magni optio quam unde dolores eveniet fugiat dolorum nam labore cum quidem aliquam placeat dignissimos. Quas, quis iste placeat veritatis assumenda sapiente praesentium provident facere.</p></li>
<li><a href="#"><img class="img_ntc" src="images/noticia04.jpg" height="74" width="75" alt=""></a><span class="dt_postagem"><time>04/04/2013 19:12:42</time></span><a href="#"><h2>SAP traz novo conceito de treinamento empresarial ao Brasil </h2></a><p>Numquam, deserunt, unde alias labore dolorem fugiat eius molestiae! Quisquam, ut, voluptate, unde, culpa necessitatibus beatae itaque nisi ducimus nobis explicabo distinctio possimus eos inventore eligendi amet officiis fugiat accusamus.</p>
</li>
</ul>', 'Home', '', 'inherit', 'closed', 'open', '', '2-revision-v1', '', '', '2014-03-23 21:24:35', '2014-03-23 21:24:35', '', '2', 'http://127.0.0.1/asug/2-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('146', '1', '2014-03-23 21:29:08', '2014-03-23 21:29:08', '<strong>Modelos</strong> de e-mail da <em>ASUG</em>

Funciona???

&nbsp;

teste', 'E-mail Boleto - Asug', '', 'inherit', 'closed', 'open', '', '137-autosave-v1', '', '', '2014-03-23 21:29:08', '2014-03-23 21:29:08', '', '137', 'http://127.0.0.1/asug/137-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('147', '1', '2014-03-23 21:29:11', '2014-03-23 21:29:11', '<strong>Modelos</strong> de e-mail da <em>ASUG</em>

<a href="#">Funciona</a>???

&nbsp;

teste', 'E-mail Boleto - Asug', '', 'inherit', 'closed', 'open', '', '137-revision-v1', '', '', '2014-03-23 21:29:11', '2014-03-23 21:29:11', '', '137', 'http://127.0.0.1/asug/137-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('148', '1', '2014-03-23 22:27:39', '2014-03-23 22:27:39', '<strong>Modelos</strong> de e-mail da <em>ASUG</em>

<a href="[boleto_usuario]">Funciona</a>???

&nbsp;

teste', 'E-mail Boleto - Asug', '', 'inherit', 'closed', 'open', '', '137-revision-v1', '', '', '2014-03-23 22:27:39', '2014-03-23 22:27:39', '', '137', 'http://127.0.0.1/asug/137-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('149', '1', '2014-03-23 22:28:28', '2014-03-23 22:28:28', '<strong>Modelos</strong> de e-mail da <em>ASUG</em>

<a href="[boleto_usuario]" target="_blank">Funciona</a>???

&nbsp;

teste', 'E-mail Boleto - Asug', '', 'inherit', 'closed', 'open', '', '137-revision-v1', '', '', '2014-03-23 22:28:28', '2014-03-23 22:28:28', '', '137', 'http://127.0.0.1/asug/137-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('150', '999999999', '2014-03-24 22:40:39', '2014-03-24 22:40:39', 'WP Backupware - 1395700838', 'WP Backupware - 1395700838', '', 'private', 'closed', 'open', '', 'wp-backupware-1395700838', '', '', '2014-03-24 22:40:39', '2014-03-24 22:40:39', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395700838/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('153', '1', '2014-03-25 02:18:01', '0000-00-00 00:00:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.', 'Goiania ASUG DAY', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus mollis molestie mauris id adipiscing. Proin sit amet suscipit augue. Mauris et augue vitae urna convallis fermentum eleifend non turpis. In hac habitasse platea dictumst. Nam ac porta massa. Ut vitae pulvinar mauris. Sed viverra sem vitae diam condimentum tristique. Vivamus nulla eros, congue sit amet ante at, dictum posuere nisl. Sed dui purus, congue sed quam eu, tincidunt ullamcorper ante.', 'draft', 'closed', 'open', '', '', '', '', '2014-03-25 02:18:01', '2014-03-25 02:18:01', '', '0', 'http://127.0.0.1/asug/?post_type=event&#038;p=153', '0', 'event', '', '0'); 
INSERT INTO `wp_posts` VALUES ('154', '1', '2014-03-25 02:14:55', '2014-03-25 02:14:55', '', 'Escritório da MontarSite', '', 'publish', 'closed', 'open', '', 'escritorio-da-montarsite', '', '', '2014-03-25 02:14:55', '2014-03-25 02:14:55', '', '0', 'http://127.0.0.1/asug/locations/escritorio-da-montarsite/', '0', 'location', '', '0'); 
INSERT INTO `wp_posts` VALUES ('155', '1', '2014-03-25 02:15:49', '2014-03-25 02:15:49', '', 'Escritório da MontarSite', '', 'publish', 'closed', 'open', '', 'escritorio-da-montarsite-2', '', '', '2014-03-25 02:15:49', '2014-03-25 02:15:49', '', '0', 'http://127.0.0.1/asug/locations/escritorio-da-montarsite-2/', '0', 'location', '', '0'); 
INSERT INTO `wp_posts` VALUES ('156', '1', '2014-03-25 02:17:10', '2014-03-25 02:17:10', '', 'Escritório da MontarSite', '', 'publish', 'closed', 'open', '', 'escritorio-da-montarsite-3', '', '', '2014-03-25 02:17:10', '2014-03-25 02:17:10', '', '0', 'http://127.0.0.1/asug/locations/escritorio-da-montarsite-3/', '0', 'location', '', '0'); 
INSERT INTO `wp_posts` VALUES ('157', '1', '2014-03-25 02:18:01', '2014-03-25 02:18:01', '', 'Escritório da MontarSite', '', 'publish', 'closed', 'open', '', 'escritorio-da-montarsite-4', '', '', '2014-03-25 02:18:01', '2014-03-25 02:18:01', '', '0', 'http://127.0.0.1/asug/locations/escritorio-da-montarsite-4/', '0', 'location', '', '0'); 
INSERT INTO `wp_posts` VALUES ('158', '999999999', '2014-03-25 23:01:11', '2014-03-25 23:01:11', 'WP Backupware - 1395788465', 'WP Backupware - 1395788465', '', 'private', 'closed', 'open', '', 'wp-backupware-1395788465', '', '', '2014-03-25 23:01:11', '2014-03-25 23:01:11', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395788465/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('159', '999999999', '2014-03-26 21:51:11', '2014-03-26 21:51:11', 'WP Backupware - 1395870668', 'WP Backupware - 1395870668', '', 'private', 'closed', 'open', '', 'wp-backupware-1395870668', '', '', '2014-03-26 21:51:11', '2014-03-26 21:51:11', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395870668/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('160', '1', '2014-03-27 01:40:55', '2014-03-27 01:40:55', 'Parabéns o representante da sua empresa acaba de ativar sua conta.

&nbsp;

Apartir de agora você tem permissão para acessar o site <a title="Sita ASUG" href="http://www.asug.com.br">www.asug.com.br</a>

&nbsp;

At.

&nbsp;

Equipe Asug', 'E-mail ativação dos usuários ativados pelo representante', '', 'publish', 'closed', 'closed', '', 'e-mail-ativacao-dos-usuarios-ativados-pelo-representante', '', '', '2014-03-27 01:57:40', '2014-03-27 01:57:40', '', '0', 'http://127.0.0.1/asug/?page_id=160', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('161', '1', '2014-03-27 01:40:55', '2014-03-27 01:40:55', 'Parabéns o [usuario-represetante]

já ativou seu cadastro, agora você tem permissão para acessar o site <a title="Sita ASUG" href="http://www.asug.com.br">www.asug.com.br</a>

At.
Equipe Asug', 'E-mail ativação dos usuários ativados pelo representante', '', 'inherit', 'closed', 'open', '', '160-revision-v1', '', '', '2014-03-27 01:40:55', '2014-03-27 01:40:55', '', '160', 'http://127.0.0.1/asug/160-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('162', '1', '2014-03-27 01:49:27', '2014-03-27 01:49:27', 'Parabéns o representante da sua empresa acaba de ativar sua conta.

Apartir de agora você tem permissão para acessar o site <a title="Sita ASUG" href="http://www.asug.com.br">www.asug.com.br</a>

At.
Equipe Asug', 'E-mail ativação dos usuários ativados pelo representante', '', 'inherit', 'closed', 'open', '', '160-revision-v1', '', '', '2014-03-27 01:49:27', '2014-03-27 01:49:27', '', '160', 'http://127.0.0.1/asug/160-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('163', '1', '2014-03-27 01:56:11', '2014-03-27 01:56:11', 'Parabéns o representante da sua empresa acaba de ativar sua conta.

Apartir de agora você tem permissão para acessar o site <a title="Sita ASUG" href="http://www.asug.com.br">www.asug.com.br</a>

At.

Equipe Asug', 'E-mail ativação dos usuários ativados pelo representante', '', 'inherit', 'closed', 'open', '', '160-autosave-v1', '', '', '2014-03-27 01:56:11', '2014-03-27 01:56:11', '', '160', 'http://127.0.0.1/asug/160-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('164', '1', '2014-03-27 01:57:40', '2014-03-27 01:57:40', 'Parabéns o representante da sua empresa acaba de ativar sua conta.

&nbsp;

Apartir de agora você tem permissão para acessar o site <a title="Sita ASUG" href="http://www.asug.com.br">www.asug.com.br</a>

&nbsp;

At.

&nbsp;

Equipe Asug', 'E-mail ativação dos usuários ativados pelo representante', '', 'inherit', 'closed', 'open', '', '160-revision-v1', '', '', '2014-03-27 01:57:40', '2014-03-27 01:57:40', '', '160', 'http://127.0.0.1/asug/160-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('165', '999999999', '2014-03-27 20:56:57', '2014-03-27 20:56:57', 'WP Backupware - 1395953779', 'WP Backupware - 1395953779', '', 'private', 'closed', 'open', '', 'wp-backupware-1395953779', '', '', '2014-03-27 20:56:57', '2014-03-27 20:56:57', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1395953779/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('167', '999999999', '2014-03-29 17:47:16', '2014-03-29 17:47:16', 'WP Backupware - 1396115234', 'WP Backupware - 1396115234', '', 'private', 'closed', 'open', '', 'wp-backupware-1396115234', '', '', '2014-03-29 17:47:16', '2014-03-29 17:47:16', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1396115234/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('171', '1', '2014-03-29 18:32:42', '2014-03-29 18:32:42', '[pdf issuu_pdf_id="140329182930-60a7a3782bd04be4987cb898e71b0cb2" layout="1" width="800" height="600" bgcolor="FFFFFF" allow_full_screen_="1" flip_timelaps="6000" ]', '', '', 'trash', 'closed', 'open', '', '171', '', '', '2014-03-29 18:48:35', '2014-03-29 18:48:35', '', '0', 'http://127.0.0.1/asug/?page_id=171', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('173', '1', '2014-03-29 18:30:04', '2014-03-29 18:30:04', '[pdf issuu_pdf_id="140329182930-60a7a3782bd04be4987cb898e71b0cb2" layout="1" width="800" height="600" bgcolor="FFFFFF" allow_full_screen_="1" flip_timelaps="6000" ]', '', '', 'inherit', 'closed', 'open', '', '171-revision-v1', '', '', '2014-03-29 18:30:04', '2014-03-29 18:30:04', '', '171', 'http://127.0.0.1/asug/171-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('174', '1', '2014-03-29 18:39:04', '2014-03-29 18:39:04', '[pdf issuu_pdf_id="140329182930-5580d2df2ee443ce830e8fd4d0b684db" layout="1" width="800" height="600" bgcolor="FFFFFF" allow_full_screen_="1" show_flip_buttons="1" autoflip="1" flip_timelaps="6000" ]', '', '', 'trash', 'closed', 'open', '', '174', '', '', '2014-03-29 18:48:36', '2014-03-29 18:48:36', '', '0', 'http://127.0.0.1/asug/?page_id=174', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('175', '1', '2014-03-29 18:38:31', '2014-03-29 18:38:31', '[pdf issuu_pdf_id="140329182930-60a7a3782bd04be4987cb898e71b0cb2" layout="1" width="800" height="600" bgcolor="FFFFFF" allow_full_screen_="1" flip_timelaps="6000" ]', '', '', 'inherit', 'closed', 'open', '', '174-revision-v1', '', '', '2014-03-29 18:38:31', '2014-03-29 18:38:31', '', '174', 'http://127.0.0.1/asug/174-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('176', '1', '2014-03-29 18:39:04', '2014-03-29 18:39:04', '[pdf issuu_pdf_id="140329182930-5580d2df2ee443ce830e8fd4d0b684db" layout="1" width="800" height="600" bgcolor="FFFFFF" allow_full_screen_="1" show_flip_buttons="1" autoflip="1" flip_timelaps="6000" ]', '', '', 'inherit', 'closed', 'open', '', '174-revision-v1', '', '', '2014-03-29 18:39:04', '2014-03-29 18:39:04', '', '174', 'http://127.0.0.1/asug/174-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('177', '1', '2014-03-29 18:46:37', '2014-03-29 18:46:37', '[pdf issuu_pdf_id="140329182930-60a7a3782bd04be4987cb898e71b0cb2" layout="1" width="800" height="600" bgcolor="FFFFFF" allow_full_screen_="1" flip_timelaps="6000" ]', '', '', 'trash', 'closed', 'open', '', '177', '', '', '2014-03-29 18:48:36', '2014-03-29 18:48:36', '', '0', 'http://127.0.0.1/asug/?page_id=177', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('178', '1', '2014-03-29 18:46:37', '2014-03-29 18:46:37', '[pdf issuu_pdf_id="140329182930-60a7a3782bd04be4987cb898e71b0cb2" layout="1" width="800" height="600" bgcolor="FFFFFF" allow_full_screen_="1" flip_timelaps="6000" ]', '', '', 'inherit', 'closed', 'open', '', '177-revision-v1', '', '', '2014-03-29 18:46:37', '2014-03-29 18:46:37', '', '177', 'http://127.0.0.1/asug/177-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('182', '1', '2014-03-29 19:02:43', '2014-03-29 19:02:43', '[flipgorilla flipbook=\'23023990364717993\']', '', '', 'trash', 'closed', 'open', '', '182', '', '', '2014-03-29 22:16:13', '2014-03-29 22:16:13', '', '0', 'http://127.0.0.1/asug/?p=182', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('183', '1', '2014-03-29 19:00:20', '2014-03-29 19:00:20', '[flipgorilla flipbook=\'1\']', '', '', 'inherit', 'closed', 'open', '', '182-revision-v1', '', '', '2014-03-29 19:00:20', '2014-03-29 19:00:20', '', '182', 'http://127.0.0.1/asug/182-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('184', '1', '2014-03-29 19:01:56', '2014-03-29 19:01:56', '[flipgorilla flipbook=\'23023990364717993\']', '', '', 'inherit', 'closed', 'open', '', '182-revision-v1', '', '', '2014-03-29 19:01:56', '2014-03-29 19:01:56', '', '182', 'http://127.0.0.1/asug/182-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('187', '1', '2014-03-29 19:05:34', '2014-03-29 19:05:34', '', 'cartao-sms', '', 'inherit', 'closed', 'open', '', 'cartao-sms', '', '', '2014-03-29 19:05:34', '2014-03-29 19:05:34', '', '190', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('189', '999999999', '2014-03-29 19:26:08', '2014-03-29 19:26:08', 'WP Backupware - 1396121168', 'WP Backupware - 1396121168', '', 'private', 'closed', 'open', '', 'wp-backupware-1396121168', '', '', '2014-03-29 19:26:08', '2014-03-29 19:26:08', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1396121168/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('190', '1', '2014-03-29 19:52:00', '0000-00-00 00:00:00', 'testes', 'Teste', '', 'draft', 'closed', 'closed', '', '', '', '', '2014-03-29 19:52:00', '2014-03-29 19:52:00', '', '0', 'http://127.0.0.1/asug/?post_type=epaper&#038;p=190', '0', 'epaper', '', '0'); 
INSERT INTO `wp_posts` VALUES ('191', '1', '2014-03-29 20:00:42', '2014-03-29 20:00:42', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf" target="_blank">sssssssss</a>

&nbsp;

[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_width=600px viewer_height=700px fullscreen=true download=true print=true openfile=false]', '', '', 'trash', 'closed', 'open', '', '191', '', '', '2014-03-29 22:16:13', '2014-03-29 22:16:13', '', '0', 'http://127.0.0.1/asug/?p=191', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('192', '1', '2014-03-29 19:54:39', '2014-03-29 19:54:39', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf" target="_blank">sssssssss</a>', '', '', 'inherit', 'closed', 'open', '', '191-revision-v1', '', '', '2014-03-29 19:54:39', '2014-03-29 19:54:39', '', '191', 'http://127.0.0.1/asug/191-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('193', '1', '2014-03-29 20:00:42', '2014-03-29 20:00:42', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf" target="_blank">sssssssss</a>

&nbsp;

[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_width=600px viewer_height=700px fullscreen=true download=true print=true openfile=false]', '', '', 'inherit', 'closed', 'open', '', '191-revision-v1', '', '', '2014-03-29 20:00:42', '2014-03-29 20:00:42', '', '191', 'http://127.0.0.1/asug/191-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('194', '1', '2014-03-29 20:06:45', '2014-03-29 20:06:45', '[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_height=700px viewer_width=800px  fullscreen=true download=true print=true openfile=false]', '', '', 'trash', 'closed', 'open', '', '194', '', '', '2014-03-29 22:16:13', '2014-03-29 22:16:13', '', '0', 'http://127.0.0.1/asug/?p=194', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('195', '1', '2014-03-29 20:02:27', '2014-03-29 20:02:27', '[pdfjs-viewer url=http://www.website.com/test.pdf viewer_width=600px viewer_height=700px fullscreen=true download=true print=true openfile=false]', '', '', 'inherit', 'closed', 'open', '', '194-revision-v1', '', '', '2014-03-29 20:02:27', '2014-03-29 20:02:27', '', '194', 'http://127.0.0.1/asug/194-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('196', '1', '2014-03-29 20:03:31', '2014-03-29 20:03:31', '[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_width=600px viewer_height=700px fullscreen=true download=true print=true openfile=false]', '', '', 'inherit', 'closed', 'open', '', '194-revision-v1', '', '', '2014-03-29 20:03:31', '2014-03-29 20:03:31', '', '194', 'http://127.0.0.1/asug/194-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('197', '1', '2014-03-29 20:06:09', '2014-03-29 20:06:09', '[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_width=100% viewer_height=700px fullscreen=true download=true print=true openfile=false]', '', '', 'inherit', 'closed', 'open', '', '194-revision-v1', '', '', '2014-03-29 20:06:09', '2014-03-29 20:06:09', '', '194', 'http://127.0.0.1/asug/194-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('198', '1', '2014-03-29 20:06:23', '2014-03-29 20:06:23', '[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_height=700px fullscreen=true download=true print=true openfile=false]', '', '', 'inherit', 'closed', 'open', '', '194-revision-v1', '', '', '2014-03-29 20:06:23', '2014-03-29 20:06:23', '', '194', 'http://127.0.0.1/asug/194-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('199', '1', '2014-03-29 20:06:45', '2014-03-29 20:06:45', '[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_height=700px viewer_width=800px  fullscreen=true download=true print=true openfile=false]', '', '', 'inherit', 'closed', 'open', '', '194-revision-v1', '', '', '2014-03-29 20:06:45', '2014-03-29 20:06:45', '', '194', 'http://127.0.0.1/asug/194-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('202', '1', '2014-03-29 21:11:12', '2014-03-29 21:11:12', '', 'Revista', '', 'publish', 'closed', 'closed', '', 'acf_revista', '', '', '2014-03-29 22:14:05', '2014-03-29 22:14:05', '', '0', 'http://127.0.0.1/asug/?post_type=acf&#038;p=202', '0', 'acf', '', '0'); 
INSERT INTO `wp_posts` VALUES ('203', '1', '2014-03-29 21:12:41', '2014-03-29 21:12:41', '', 'Revista 01', '', 'trash', 'closed', 'open', '', 'revista-01', '', '', '2014-03-29 22:16:21', '2014-03-29 22:16:21', '', '0', 'http://127.0.0.1/asug/?p=203', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('204', '1', '2014-03-29 21:12:41', '2014-03-29 21:12:41', '', 'Revista 01', '', 'inherit', 'closed', 'open', '', '203-revision-v1', '', '', '2014-03-29 21:12:41', '2014-03-29 21:12:41', '', '203', 'http://127.0.0.1/asug/203-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('206', '1', '2014-03-29 21:18:00', '2014-03-29 21:18:00', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'Revista 01', '', 'inherit', 'closed', 'open', '', '203-revision-v1', '', '', '2014-03-29 21:18:00', '2014-03-29 21:18:00', '', '203', 'http://127.0.0.1/asug/203-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('207', '1', '2014-03-29 21:27:40', '2014-03-29 21:27:40', '', 'Revista 01', '', 'inherit', 'closed', 'open', '', '203-revision-v1', '', '', '2014-03-29 21:27:40', '2014-03-29 21:27:40', '', '203', 'http://127.0.0.1/asug/203-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('208', '1', '2014-03-29 21:30:04', '2014-03-29 21:30:04', '[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_width=600px viewer_height=700px fullscreen=true download=true print=true openfile=false]', 'Revista 01', '', 'inherit', 'closed', 'open', '', '203-autosave-v1', '', '', '2014-03-29 21:30:04', '2014-03-29 21:30:04', '', '203', 'http://127.0.0.1/asug/203-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('209', '1', '2014-03-29 21:43:10', '2014-03-29 21:43:10', '[pdfjs-viewer url=http://127.0.0.1/asug/wp-content/uploads/2014/03/cartao-sms.pdf viewer_width=600px viewer_height=700px fullscreen=true download=true print=true openfile=false]', 'Revista 01', '', 'inherit', 'closed', 'open', '', '203-revision-v1', '', '', '2014-03-29 21:43:10', '2014-03-29 21:43:10', '', '203', 'http://127.0.0.1/asug/203-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('210', '1', '2014-03-29 21:44:22', '2014-03-29 21:44:22', '', 'Revista 01', '', 'inherit', 'closed', 'open', '', '203-revision-v1', '', '', '2014-03-29 21:44:22', '2014-03-29 21:44:22', '', '203', 'http://127.0.0.1/asug/203-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('213', '1', '2014-03-29 22:06:37', '2014-03-29 22:06:37', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'publish', 'closed', 'open', '', 'asug-teste-2', '', '', '2014-03-29 22:39:24', '2014-03-29 22:39:24', '', '0', 'http://127.0.0.1/asug/?p=213', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('214', '1', '2014-03-29 22:06:11', '2014-03-29 22:06:11', '', 'capa-revista-hsm-management-01', '', 'inherit', 'closed', 'open', '', 'capa-revista-hsm-management-01', '', '', '2014-03-29 22:06:11', '2014-03-29 22:06:11', '', '213', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/capa-revista-hsm-management-01.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('215', '1', '2014-03-29 22:06:37', '2014-03-29 22:06:37', '', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '213-revision-v1', '', '', '2014-03-29 22:06:37', '2014-03-29 22:06:37', '', '213', 'http://127.0.0.1/asug/213-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('217', '1', '2014-03-29 22:14:33', '2014-03-29 22:14:33', '', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '213-revision-v1', '', '', '2014-03-29 22:14:33', '2014-03-29 22:14:33', '', '213', 'http://127.0.0.1/asug/213-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('218', '1', '2014-03-29 22:39:24', '2014-03-29 22:39:24', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '213-revision-v1', '', '', '2014-03-29 22:39:24', '2014-03-29 22:39:24', '', '213', 'http://127.0.0.1/asug/213-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('219', '999999999', '2014-04-01 22:50:17', '2014-04-01 22:50:17', 'WP Backupware - 1396392617', 'WP Backupware - 1396392617', '', 'private', 'closed', 'open', '', 'wp-backupware-1396392617', '', '', '2014-04-01 22:50:17', '2014-04-01 22:50:17', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1396392617/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('221', '1', '2014-04-01 22:58:08', '2014-04-01 22:58:08', '', 'Asug Day', '', 'inherit', 'closed', 'open', '', '20-autosave-v1', '', '', '2014-04-01 22:58:08', '2014-04-01 22:58:08', '', '20', 'http://127.0.0.1/asug/20-autosave-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('222', '1', '2014-04-01 23:03:26', '2014-04-01 23:03:26', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'publish', 'closed', 'open', '', 'asug-teste-33', '', '', '2014-04-01 23:03:26', '2014-04-01 23:03:26', '', '0', 'http://127.0.0.1/asug/?p=222', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('223', '1', '2014-04-01 23:02:48', '2014-04-01 23:02:48', '', 'capa-revista-gloss', '', 'inherit', 'closed', 'open', '', 'capa-revista-gloss', '', '', '2014-04-01 23:02:48', '2014-04-01 23:02:48', '', '222', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/capa-revista-gloss.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('224', '1', '2014-04-01 23:03:26', '2014-04-01 23:03:26', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'inherit', 'closed', 'open', '', '222-revision-v1', '', '', '2014-04-01 23:03:26', '2014-04-01 23:03:26', '', '222', 'http://127.0.0.1/asug/222-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('226', '1', '2014-04-02 00:32:31', '2014-04-02 00:32:31', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'publish', 'closed', 'open', '', 'asug-teste-2-6', '', '', '2014-04-13 02:13:33', '2014-04-13 02:13:33', '', '0', 'http://127.0.0.1/asug/?p=226', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('227', '1', '2014-04-02 00:32:30', '2014-04-02 00:32:30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'publish', 'closed', 'open', '', 'asug-teste-33-5', '', '', '2014-04-02 00:32:30', '2014-04-02 00:32:30', '', '0', 'http://127.0.0.1/asug/?p=227', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('228', '1', '2014-04-02 00:32:30', '2014-04-02 00:32:30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'publish', 'closed', 'open', '', 'asug-teste-2-5', '', '', '2014-04-02 00:32:30', '2014-04-02 00:32:30', '', '0', 'http://127.0.0.1/asug/?p=228', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('229', '1', '2014-04-02 00:32:30', '2014-04-02 00:32:30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'publish', 'closed', 'open', '', 'asug-teste-33-4', '', '', '2014-04-02 00:32:30', '2014-04-02 00:32:30', '', '0', 'http://127.0.0.1/asug/?p=229', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('230', '1', '2014-04-02 00:32:30', '2014-04-02 00:32:30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'publish', 'closed', 'open', '', 'asug-teste-2-4', '', '', '2014-04-02 00:32:30', '2014-04-02 00:32:30', '', '0', 'http://127.0.0.1/asug/?p=230', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('231', '1', '2014-04-02 00:32:29', '2014-04-02 00:32:29', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'publish', 'closed', 'open', '', 'asug-teste-33-3', '', '', '2014-04-02 00:32:29', '2014-04-02 00:32:29', '', '0', 'http://127.0.0.1/asug/?p=231', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('232', '1', '2014-04-02 00:32:29', '2014-04-02 00:32:29', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'publish', 'closed', 'open', '', 'asug-teste-2-3', '', '', '2014-04-02 00:32:29', '2014-04-02 00:32:29', '', '0', 'http://127.0.0.1/asug/?p=232', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('233', '1', '2014-04-02 00:32:29', '2014-04-02 00:32:29', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'publish', 'closed', 'open', '', 'asug-teste-33-2', '', '', '2014-04-02 00:32:29', '2014-04-02 00:32:29', '', '0', 'http://127.0.0.1/asug/?p=233', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('234', '1', '2014-04-02 00:32:28', '2014-04-02 00:32:28', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'publish', 'closed', 'open', '', 'asug-teste-2-2', '', '', '2014-04-02 00:32:28', '2014-04-02 00:32:28', '', '0', 'http://127.0.0.1/asug/?p=234', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('235', '1', '2014-04-02 00:32:28', '2014-04-02 00:32:28', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '234-revision-v1', '', '', '2014-04-02 00:32:28', '2014-04-02 00:32:28', '', '234', 'http://127.0.0.1/asug/234-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('236', '1', '2014-04-02 00:32:29', '2014-04-02 00:32:29', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'inherit', 'closed', 'open', '', '233-revision-v1', '', '', '2014-04-02 00:32:29', '2014-04-02 00:32:29', '', '233', 'http://127.0.0.1/asug/233-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('237', '1', '2014-04-02 00:32:29', '2014-04-02 00:32:29', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '232-revision-v1', '', '', '2014-04-02 00:32:29', '2014-04-02 00:32:29', '', '232', 'http://127.0.0.1/asug/232-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('238', '1', '2014-04-02 00:32:29', '2014-04-02 00:32:29', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'inherit', 'closed', 'open', '', '231-revision-v1', '', '', '2014-04-02 00:32:29', '2014-04-02 00:32:29', '', '231', 'http://127.0.0.1/asug/231-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('239', '1', '2014-04-02 00:32:30', '2014-04-02 00:32:30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '230-revision-v1', '', '', '2014-04-02 00:32:30', '2014-04-02 00:32:30', '', '230', 'http://127.0.0.1/asug/230-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('240', '1', '2014-04-02 00:32:30', '2014-04-02 00:32:30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'inherit', 'closed', 'open', '', '229-revision-v1', '', '', '2014-04-02 00:32:30', '2014-04-02 00:32:30', '', '229', 'http://127.0.0.1/asug/229-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('241', '1', '2014-04-02 00:32:30', '2014-04-02 00:32:30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '228-revision-v1', '', '', '2014-04-02 00:32:30', '2014-04-02 00:32:30', '', '228', 'http://127.0.0.1/asug/228-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('242', '1', '2014-04-02 00:32:30', '2014-04-02 00:32:30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 33', '', 'inherit', 'closed', 'open', '', '227-revision-v1', '', '', '2014-04-02 00:32:30', '2014-04-02 00:32:30', '', '227', 'http://127.0.0.1/asug/227-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('243', '1', '2014-04-02 00:32:31', '2014-04-02 00:32:31', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '226-revision-v1', '', '', '2014-04-02 00:32:31', '2014-04-02 00:32:31', '', '226', 'http://127.0.0.1/asug/226-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('244', '1', '2014-04-02 01:51:20', '2014-04-02 01:51:20', '', 'revista', '', 'inherit', 'closed', 'open', '', 'revista', '', '', '2014-04-02 01:51:20', '2014-04-02 01:51:20', '', '20', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/revista.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('245', '999999999', '2014-04-02 21:41:06', '2014-04-02 21:41:06', 'WP Backupware - 1396474863', 'WP Backupware - 1396474863', '', 'private', 'closed', 'open', '', 'wp-backupware-1396474863', '', '', '2014-04-02 21:41:06', '2014-04-02 21:41:06', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1396474863/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('247', '999999999', '2014-04-03 22:03:13', '2014-04-03 22:03:13', 'WP Backupware - 1396562592', 'WP Backupware - 1396562592', '', 'private', 'closed', 'open', '', 'wp-backupware-1396562592', '', '', '2014-04-03 22:03:13', '2014-04-03 22:03:13', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1396562592/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('248', '1', '2014-04-03 22:57:39', '2014-04-03 22:57:39', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus fringilla, tortor quis ullamcorper mollis, nulla felis viverra magna, nec vehicula dui erat et nisl. Suspendisse lobortis pretium iaculis. Integer ut erat justo. Etiam urna leo, bibendum ac suscipit ut, ullamcorper mollis eros. Etiam mollis eleifend dignissim. Donec in mi vel urna tincidunt molestie ac in sem. Donec tristique orci at tincidunt pulvinar. Nullam fermentum dictum mi at tincidunt. Fusce varius accumsan aliquet. Integer luctus molestie diam id ultrices. Nam lacinia leo lectus, nec lobortis lacus ultricies ut. Integer volutpat vestibulum lacinia. Quisque nec erat feugiat, blandit est et, molestie nisl. Aliquam ullamcorper nisi ac nulla consequat iaculis. Vivamus elementum adipiscing semper. Mauris rutrum dui mi, quis tristique massa malesuada nec. Vestibulum dictum, nibh a pretium semper, libero nibh sodales nisi, at mattis nulla felis quis quam. Nulla vitae posuere magna. Nam non nisi nunc. Curabitur feugiat auctor euismod. Maecenas blandit sem eu enim bibendum, sed posuere velit luctus. Curabitur a elit sit amet risus euismod vestibulum. Duis laoreet commodo tellus tristique lobortis. Vivamus quis molestie odio. Suspendisse vulputate est et lacinia dapibus. Nulla tempor semper tortor, eget ullamcorper sapien facilisis sed. Sed at mollis tellus, lacinia porttitor quam. Nunc metus ipsum, tempor id blandit aliquam, bibendum eu nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut at felis justo. Nunc interdum mi ac ligula ullamcorper lobortis. Aliquam et felis felis. Vivamus cursus blandit lacus quis volutpat. Nullam nisi diam, egestas nec bibendum quis, adipiscing et felis. Praesent scelerisque adipiscing ante non pulvinar.', 'Comitê estratégico', '', 'inherit', 'closed', 'open', '', '39-revision-v1', '', '', '2014-04-03 22:57:39', '2014-04-03 22:57:39', '', '39', 'http://127.0.0.1/asug/39-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('249', '1', '2014-04-03 23:23:27', '2014-04-03 23:23:27', '', 'Institucional', '', 'publish', 'closed', 'open', '', 'institucional', '', '', '2014-04-12 19:19:07', '2014-04-12 19:19:07', '', '0', 'http://127.0.0.1/asug/?p=249', '2', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('250', '999999999', '2014-04-04 19:25:55', '2014-04-04 19:25:55', 'WP Backupware - 1396639554', 'WP Backupware - 1396639554', '', 'private', 'closed', 'open', '', 'wp-backupware-1396639554', '', '', '2014-04-04 19:25:55', '2014-04-04 19:25:55', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1396639554/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('251', '999999999', '2014-04-05 19:27:05', '2014-04-05 19:27:05', 'WP Backupware - 1396726024', 'WP Backupware - 1396726024', '', 'private', 'closed', 'open', '', 'wp-backupware-1396726024', '', '', '2014-04-05 19:27:05', '2014-04-05 19:27:05', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1396726024/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('253', '1', '2014-04-05 19:50:43', '0000-00-00 00:00:00', '', 'Recibo', '', 'draft', 'closed', 'open', '', '', '', '', '2014-04-05 19:50:43', '2014-04-05 19:50:43', '', '0', 'http://127.0.0.1/asug/?page_id=253', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('254', '1', '2014-04-05 19:57:58', '2014-04-05 19:57:58', '', 'asug_recibo_cabecalho', '', 'inherit', 'closed', 'open', '', 'asug_recibo_cabecalho', '', '', '2014-04-05 19:57:58', '2014-04-05 19:57:58', '', '253', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('255', '1', '2014-04-05 19:58:01', '2014-04-05 19:58:01', '', 'asug_recibo_rodape', '', 'inherit', 'closed', 'open', '', 'asug_recibo_rodape', '', '', '2014-04-05 19:58:01', '2014-04-05 19:58:01', '', '253', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('268', '1', '2014-04-05 20:31:42', '2014-04-05 20:31:42', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg"><img class="alignnone size-full wp-image-254" alt="asug_recibo_cabecalho" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg" width="1020" height="71" /></a>', '', '', 'trash', 'closed', 'open', '', '268', '', '', '2014-04-12 19:11:25', '2014-04-12 19:11:25', '', '0', 'http://127.0.0.1/asug/?page_id=268', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('275', '1', '2014-04-05 20:41:32', '2014-04-05 20:41:32', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg"><img class="alignnone size-full wp-image-254" alt="asug_recibo_cabecalho" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg" width="1020" height="71" /></a>', '', '', 'trash', 'closed', 'open', '', '275', '', '', '2014-04-12 19:11:26', '2014-04-12 19:11:26', '', '0', 'http://127.0.0.1/asug/?page_id=275', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('281', '1', '2014-04-05 20:50:23', '2014-04-05 20:50:23', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg"><img class="alignnone size-full wp-image-254" alt="asug_recibo_cabecalho" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg" width="1020" height="71" /></a>', '', '', 'trash', 'closed', 'open', '', '281', '', '', '2014-04-12 19:11:26', '2014-04-12 19:11:26', '', '0', 'http://127.0.0.1/asug/?page_id=281', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('285', '1', '2014-04-05 21:07:14', '2014-04-05 21:07:14', '<img class="alignnone size-full wp-image-254" alt="asug_recibo_cabecalho" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg" width="1020" height="71" />

&nbsp;

Recebi do(a) [nome_da_empresa], o valor de R$ [valor], referente à associação do porta Asug (Associação de usuários SAP do brasil),  dando-lhe por este recibo a devida quitação anual.

[data]

&nbsp;

<img class="alignleft" alt="" src="http://fliporto.net/2013/wp-content/uploads/2013/11/JoseSaramagoAssinatura.png" width="424" height="193" />

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

_______________________________________________
João da Silva - Diretor Financeiro Asug Brasil

&nbsp;

&nbsp;

<a href="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg"><img class="alignnone size-full wp-image-255" alt="asug_recibo_rodape" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg" width="1020" height="38" /></a>

&nbsp;', 'Recibo', '', 'publish', 'closed', 'open', '', 'recibo', '', '', '2014-04-05 21:07:14', '2014-04-05 21:07:14', '', '0', 'http://127.0.0.1/asug/?page_id=285', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('286', '1', '2014-04-05 21:07:14', '2014-04-05 21:07:14', '<img class="alignnone size-full wp-image-254" alt="asug_recibo_cabecalho" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg" width="1020" height="71" />

&nbsp;

Recebi do(a) [nome_da_empresa], o valor de R$ [valor], referente à associação do porta Asug (Associação de usuários SAP do brasil),  dando-lhe por este recibo a devida quitação anual.

[data]

&nbsp;

<img class="alignleft" alt="" src="http://fliporto.net/2013/wp-content/uploads/2013/11/JoseSaramagoAssinatura.png" width="424" height="193" />

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

_______________________________________________
João da Silva - Diretor Financeiro Asug Brasil

&nbsp;

&nbsp;

<a href="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg"><img class="alignnone size-full wp-image-255" alt="asug_recibo_rodape" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_rodape.jpg" width="1020" height="38" /></a>

&nbsp;', 'Recibo', '', 'inherit', 'closed', 'open', '', '285-revision-v1', '', '', '2014-04-05 21:07:14', '2014-04-05 21:07:14', '', '285', 'http://127.0.0.1/asug/285-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('287', '999999999', '2014-04-12 19:05:54', '2014-04-12 19:05:54', 'WP Backupware - 1397329543', 'WP Backupware - 1397329543', '', 'private', 'closed', 'open', '', 'wp-backupware-1397329543', '', '', '2014-04-12 19:05:54', '2014-04-12 19:05:54', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1397329543/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('288', '1', '2014-04-12 19:11:25', '2014-04-12 19:11:25', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg"><img class="alignnone size-full wp-image-254" alt="asug_recibo_cabecalho" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg" width="1020" height="71" /></a>', '', '', 'inherit', 'closed', 'open', '', '268-revision-v1', '', '', '2014-04-12 19:11:25', '2014-04-12 19:11:25', '', '268', 'http://127.0.0.1/asug/268-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('289', '1', '2014-04-12 19:11:26', '2014-04-12 19:11:26', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg"><img class="alignnone size-full wp-image-254" alt="asug_recibo_cabecalho" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg" width="1020" height="71" /></a>', '', '', 'inherit', 'closed', 'open', '', '275-revision-v1', '', '', '2014-04-12 19:11:26', '2014-04-12 19:11:26', '', '275', 'http://127.0.0.1/asug/275-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('290', '1', '2014-04-12 19:11:26', '2014-04-12 19:11:26', '<a href="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg"><img class="alignnone size-full wp-image-254" alt="asug_recibo_cabecalho" src="http://127.0.0.1/asug/wp-content/uploads/2014/04/asug_recibo_cabecalho.jpg" width="1020" height="71" /></a>', '', '', 'inherit', 'closed', 'open', '', '281-revision-v1', '', '', '2014-04-12 19:11:26', '2014-04-12 19:11:26', '', '281', 'http://127.0.0.1/asug/281-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('291', '1', '2014-04-12 19:16:04', '2014-04-12 19:16:04', '', 'Fale conosco', '', 'publish', 'closed', 'open', '', 'fale-conosco', '', '', '2014-04-12 19:16:04', '2014-04-12 19:16:04', '', '0', 'http://127.0.0.1/asug/?page_id=291', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('292', '1', '2014-04-12 19:16:04', '2014-04-12 19:16:04', '', 'Fale conosco', '', 'inherit', 'closed', 'open', '', '291-revision-v1', '', '', '2014-04-12 19:16:04', '2014-04-12 19:16:04', '', '291', 'http://127.0.0.1/asug/291-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('293', '1', '2014-04-12 19:17:21', '2014-04-12 19:17:21', '', 'Contato', '', 'publish', 'closed', 'open', '', '293', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '0', 'http://127.0.0.1/asug/?p=293', '15', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('294', '1', '2014-04-12 19:17:44', '2014-04-12 19:17:44', '', 'Asug internacional', '', 'publish', 'closed', 'open', '', 'asug-internacional', '', '', '2014-04-12 19:17:44', '2014-04-12 19:17:44', '', '0', 'http://127.0.0.1/asug/?page_id=294', '0', 'page', '', '0'); 
INSERT INTO `wp_posts` VALUES ('295', '1', '2014-04-12 19:17:44', '2014-04-12 19:17:44', '', 'Asug internacional', '', 'inherit', 'closed', 'open', '', '294-revision-v1', '', '', '2014-04-12 19:17:44', '2014-04-12 19:17:44', '', '294', 'http://127.0.0.1/asug/294-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('296', '1', '2014-04-12 19:18:14', '2014-04-12 19:18:14', ' ', '', '', 'publish', 'closed', 'open', '', '296', '', '', '2014-04-12 19:19:08', '2014-04-12 19:19:08', '', '0', 'http://127.0.0.1/asug/?p=296', '14', 'nav_menu_item', '', '0'); 
INSERT INTO `wp_posts` VALUES ('297', '999999999', '2014-04-12 19:27:07', '2014-04-12 19:27:07', 'WP Backupware - 1397330827', 'WP Backupware - 1397330827', '', 'private', 'closed', 'open', '', 'wp-backupware-1397330827', '', '', '2014-04-12 19:27:07', '2014-04-12 19:27:07', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1397330827/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('298', '1', '2014-04-13 02:13:27', '2014-04-13 02:13:27', '', 'PASSEI_online_menor_[1]', '', 'inherit', 'closed', 'open', '', 'passei_online_menor_1', '', '', '2014-04-13 02:13:27', '2014-04-13 02:13:27', '', '226', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/PASSEI_online_menor_1.pdf', '0', 'attachment', 'application/pdf', '0'); 
INSERT INTO `wp_posts` VALUES ('299', '1', '2014-04-13 02:13:33', '2014-04-13 02:13:33', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi scelerisque ut ligula id convallis. Suspendisse tempor mauris vulputate ipsum viverra pretium. Duis semper cursus posuere. Cras hendrerit consequat leo, sit amet rhoncus nulla condimentum ut. Aenean ut malesuada diam. Pellentesque pellentesque ante mollis, ornare purus eu, feugiat risus. Vivamus id libero dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ante justo. Nam convallis lorem ac tempus tempor. In et dignissim libero. Proin tristique venenatis mi ut bibendum. Nam luctus, justo id convallis mollis, sem dui feugiat justo, ac vulputate ipsum turpis non eros. Nulla facilisi. Vestibulum diam neque, porttitor in arcu vitae, lacinia vulputate velit. Nullam aliquam tellus at bibendum consectetur.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque et orci facilisis, egestas neque quis, euismod ante. Vivamus rutrum, sapien at vulputate molestie, sem justo dignissim ipsum, vitae lobortis urna orci vel odio. Quisque vitae luctus sapien. Suspendisse semper quis velit sit amet congue. Nullam vitae placerat est. Curabitur orci arcu, tristique et dignissim lacinia, iaculis vitae mauris. Proin eu felis id odio gravida congue et at nunc. Vestibulum eget sodales lectus. Morbi a tortor in nunc adipiscing blandit id et arcu. Nulla facilisi. Suspendisse aliquam luctus velit, nec pellentesque tellus condimentum quis. Mauris consectetur arcu ut auctor molestie. In aliquam nunc vitae mattis malesuada.', 'Asug teste 2', '', 'inherit', 'closed', 'open', '', '226-revision-v1', '', '', '2014-04-13 02:13:33', '2014-04-13 02:13:33', '', '226', 'http://127.0.0.1/asug/226-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('300', '999999999', '2014-04-13 19:30:28', '2014-04-13 19:30:28', 'WP Backupware - 1397417427', 'WP Backupware - 1397417427', '', 'private', 'closed', 'open', '', 'wp-backupware-1397417427', '', '', '2014-04-13 19:30:28', '2014-04-13 19:30:28', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1397417427/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('302', '999999999', '2014-04-14 19:56:05', '2014-04-14 19:56:05', 'WP Backupware - 1397505353', 'WP Backupware - 1397505353', '', 'private', 'closed', 'open', '', 'wp-backupware-1397505353', '', '', '2014-04-14 19:56:05', '2014-04-14 19:56:05', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1397505353/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('304', '999999999', '2014-04-15 19:31:03', '2014-04-15 19:31:03', 'WP Backupware - 1397590261', 'WP Backupware - 1397590261', '', 'private', 'closed', 'open', '', 'wp-backupware-1397590261', '', '', '2014-04-15 19:31:03', '2014-04-15 19:31:03', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1397590261/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('305', '999999999', '2014-04-22 21:35:55', '2014-04-22 21:35:55', 'WP Backupware - 1398202522', 'WP Backupware - 1398202522', '', 'private', 'closed', 'open', '', 'wp-backupware-1398202522', '', '', '2014-04-22 21:35:55', '2014-04-22 21:35:55', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1398202522/', '0', 'wpbu_backups', '', '0'); 
INSERT INTO `wp_posts` VALUES ('306', '1', '2014-04-22 23:02:56', '0000-00-00 00:00:00', '', 'Rascunho automático', '', 'auto-draft', 'closed', 'open', '', '', '', '', '2014-04-22 23:02:56', '0000-00-00 00:00:00', '', '0', 'http://127.0.0.1/asug/?p=306', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('307', '1', '2014-04-22 23:05:26', '0000-00-00 00:00:00', '', 'Rascunho automático', '', 'auto-draft', 'closed', 'open', '', '', '', '', '2014-04-22 23:05:26', '0000-00-00 00:00:00', '', '0', 'http://127.0.0.1/asug/?p=307', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('308', '1', '2014-04-22 23:34:29', '2014-04-22 23:34:29', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/copy-asug-brasil.jpg', 'copy-asug-brasil.jpg', '', 'inherit', 'closed', 'open', '', 'copy-asug-brasil-jpg', '', '', '2014-04-22 23:34:29', '2014-04-22 23:34:29', '', '0', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/copy-asug-brasil.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('309', '1', '2014-04-23 00:01:59', '2014-04-23 00:01:59', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer suscipit magna at metus consequat iaculis. Nullam ut nulla facilisis, viverra magna at, pellentesque magna. Sed nibh turpis, tempus non nisi a, pharetra bibendum diam. Nulla aliquet eros enim, eu tempor mi egestas in. Nullam consequat interdum libero, vitae sodales tellus lobortis eu. Vivamus gravida libero ut lacus congue consequat. Duis viverra dolor vel nulla lacinia vehicula.

Suspendisse faucibus orci in turpis tincidunt, a aliquet velit feugiat. Duis eget dui velit. Phasellus ultrices, purus et gravida sodales, risus nibh pharetra dui, sit amet sagittis augue ipsum vitae massa. Fusce molestie laoreet nunc id posuere. In hac habitasse platea dictumst. Quisque vel sem ullamcorper, mattis enim eget, luctus metus. Pellentesque neque diam, vestibulum tincidunt bibendum a, egestas at enim. Nulla eu pellentesque mauris. Nullam aliquet ut nisi non imperdiet.

Donec est magna, tincidunt quis sagittis sed, aliquet non massa. Quisque rutrum arcu vitae massa sollicitudin consequat. Etiam tempor felis ut tortor viverra, vestibulum condimentum est blandit. Cras ultrices vestibulum dolor, nec rhoncus est vulputate nec. Ut sed augue id mi pellentesque interdum. Integer aliquam ipsum ut porttitor consectetur. Nullam sem mi, tristique nec condimentum feugiat, varius sit amet tellus. Integer a turpis ac est pellentesque ornare. Praesent id justo a eros malesuada sagittis. Suspendisse eget sapien id lorem accumsan tincidunt sed sit amet lorem. Ut pharetra purus quam, a luctus elit luctus sit amet. Aliquam placerat purus sem, non posuere velit cursus ullamcorper.

Aenean laoreet a leo sed lacinia. In hac habitasse platea dictumst. Morbi rutrum pharetra egestas. Nam rhoncus, dolor in sodales lacinia, leo nulla rutrum purus, at ornare dolor tortor et lorem. Quisque egestas in magna vitae rhoncus. Sed ligula erat, laoreet at turpis sit amet, tincidunt pulvinar justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus porttitor nec mauris eget rutrum. Nunc semper felis vitae dolor blandit egestas a eget arcu. Praesent ipsum augue, porttitor eget lorem vel, euismod molestie nisi. Nullam dignissim erat id quam tristique, id adipiscing sem semper. Pellentesque ultricies diam sed nibh mattis, id pulvinar nunc suscipit. Praesent id mattis libero. Phasellus ac rhoncus ligula, quis consequat elit. Cras eros turpis, varius mollis odio vitae, consequat convallis quam.', 'AS PERSPECTIVAS PARA A TI', '', 'publish', 'closed', 'open', '', 'as-perspectivas-para-a-ti', '', '', '2014-04-23 00:01:59', '2014-04-23 00:01:59', '', '0', 'http://127.0.0.1/asug/?p=309', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('310', '1', '2014-04-23 00:01:39', '2014-04-23 00:01:39', '', 'Technology-news[1]', '', 'inherit', 'closed', 'open', '', 'technology-news1', '', '', '2014-04-23 00:01:39', '2014-04-23 00:01:39', '', '309', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/Technology-news1.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('311', '1', '2014-04-23 00:01:59', '2014-04-23 00:01:59', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer suscipit magna at metus consequat iaculis. Nullam ut nulla facilisis, viverra magna at, pellentesque magna. Sed nibh turpis, tempus non nisi a, pharetra bibendum diam. Nulla aliquet eros enim, eu tempor mi egestas in. Nullam consequat interdum libero, vitae sodales tellus lobortis eu. Vivamus gravida libero ut lacus congue consequat. Duis viverra dolor vel nulla lacinia vehicula.

Suspendisse faucibus orci in turpis tincidunt, a aliquet velit feugiat. Duis eget dui velit. Phasellus ultrices, purus et gravida sodales, risus nibh pharetra dui, sit amet sagittis augue ipsum vitae massa. Fusce molestie laoreet nunc id posuere. In hac habitasse platea dictumst. Quisque vel sem ullamcorper, mattis enim eget, luctus metus. Pellentesque neque diam, vestibulum tincidunt bibendum a, egestas at enim. Nulla eu pellentesque mauris. Nullam aliquet ut nisi non imperdiet.

Donec est magna, tincidunt quis sagittis sed, aliquet non massa. Quisque rutrum arcu vitae massa sollicitudin consequat. Etiam tempor felis ut tortor viverra, vestibulum condimentum est blandit. Cras ultrices vestibulum dolor, nec rhoncus est vulputate nec. Ut sed augue id mi pellentesque interdum. Integer aliquam ipsum ut porttitor consectetur. Nullam sem mi, tristique nec condimentum feugiat, varius sit amet tellus. Integer a turpis ac est pellentesque ornare. Praesent id justo a eros malesuada sagittis. Suspendisse eget sapien id lorem accumsan tincidunt sed sit amet lorem. Ut pharetra purus quam, a luctus elit luctus sit amet. Aliquam placerat purus sem, non posuere velit cursus ullamcorper.

Aenean laoreet a leo sed lacinia. In hac habitasse platea dictumst. Morbi rutrum pharetra egestas. Nam rhoncus, dolor in sodales lacinia, leo nulla rutrum purus, at ornare dolor tortor et lorem. Quisque egestas in magna vitae rhoncus. Sed ligula erat, laoreet at turpis sit amet, tincidunt pulvinar justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus porttitor nec mauris eget rutrum. Nunc semper felis vitae dolor blandit egestas a eget arcu. Praesent ipsum augue, porttitor eget lorem vel, euismod molestie nisi. Nullam dignissim erat id quam tristique, id adipiscing sem semper. Pellentesque ultricies diam sed nibh mattis, id pulvinar nunc suscipit. Praesent id mattis libero. Phasellus ac rhoncus ligula, quis consequat elit. Cras eros turpis, varius mollis odio vitae, consequat convallis quam.', 'AS PERSPECTIVAS PARA A TI', '', 'inherit', 'closed', 'open', '', '309-revision-v1', '', '', '2014-04-23 00:01:59', '2014-04-23 00:01:59', '', '309', 'http://127.0.0.1/asug/309-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('312', '1', '2014-04-23 00:15:37', '2014-04-23 00:15:37', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer suscipit magna at metus consequat iaculis. Nullam ut nulla facilisis, viverra magna at, pellentesque magna. Sed nibh turpis, tempus non nisi a, pharetra bibendum diam. Nulla aliquet eros enim, eu tempor mi egestas in. Nullam consequat interdum libero, vitae sodales tellus lobortis eu. Vivamus gravida libero ut lacus congue consequat. Duis viverra dolor vel nulla lacinia vehicula.

Suspendisse faucibus orci in turpis tincidunt, a aliquet velit feugiat. Duis eget dui velit. Phasellus ultrices, purus et gravida sodales, risus nibh pharetra dui, sit amet sagittis augue ipsum vitae massa. Fusce molestie laoreet nunc id posuere. In hac habitasse platea dictumst. Quisque vel sem ullamcorper, mattis enim eget, luctus metus. Pellentesque neque diam, vestibulum tincidunt bibendum a, egestas at enim. Nulla eu pellentesque mauris. Nullam aliquet ut nisi non imperdiet.

Donec est magna, tincidunt quis sagittis sed, aliquet non massa. Quisque rutrum arcu vitae massa sollicitudin consequat. Etiam tempor felis ut tortor viverra, vestibulum condimentum est blandit. Cras ultrices vestibulum dolor, nec rhoncus est vulputate nec. Ut sed augue id mi pellentesque interdum. Integer aliquam ipsum ut porttitor consectetur. Nullam sem mi, tristique nec condimentum feugiat, varius sit amet tellus. Integer a turpis ac est pellentesque ornare. Praesent id justo a eros malesuada sagittis. Suspendisse eget sapien id lorem accumsan tincidunt sed sit amet lorem. Ut pharetra purus quam, a luctus elit luctus sit amet. Aliquam placerat purus sem, non posuere velit cursus ullamcorper.

Aenean laoreet a leo sed lacinia. In hac habitasse platea dictumst. Morbi rutrum pharetra egestas. Nam rhoncus, dolor in sodales lacinia, leo nulla rutrum purus, at ornare dolor tortor et lorem. Quisque egestas in magna vitae rhoncus. Sed ligula erat, laoreet at turpis sit amet, tincidunt pulvinar justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus porttitor nec mauris eget rutrum. Nunc semper felis vitae dolor blandit egestas a eget arcu. Praesent ipsum augue, porttitor eget lorem vel, euismod molestie nisi. Nullam dignissim erat id quam tristique, id adipiscing sem semper. Pellentesque ultricies diam sed nibh mattis, id pulvinar nunc suscipit. Praesent id mattis libero. Phasellus ac rhoncus ligula, quis consequat elit. Cras eros turpis, varius mollis odio vitae, consequat convallis quam.', 'SAP traz novo conceito de treinamento empresarial ao Brasil', '', 'publish', 'closed', 'open', '', 'sap-traz-novo-conceito-de-treinamento-empresarial-ao-brasil', '', '', '2014-04-23 00:15:37', '2014-04-23 00:15:37', '', '0', 'http://127.0.0.1/asug/?p=312', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('313', '1', '2014-04-23 00:16:35', '2014-04-23 00:16:35', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer suscipit magna at metus consequat iaculis. Nullam ut nulla facilisis, viverra magna at, pellentesque magna. Sed nibh turpis, tempus non nisi a, pharetra bibendum diam. Nulla aliquet eros enim, eu tempor mi egestas in. Nullam consequat interdum libero, vitae sodales tellus lobortis eu. Vivamus gravida libero ut lacus congue consequat. Duis viverra dolor vel nulla lacinia vehicula.

Suspendisse faucibus orci in turpis tincidunt, a aliquet velit feugiat. Duis eget dui velit. Phasellus ultrices, purus et gravida sodales, risus nibh pharetra dui, sit amet sagittis augue ipsum vitae massa. Fusce molestie laoreet nunc id posuere. In hac habitasse platea dictumst. Quisque vel sem ullamcorper, mattis enim eget, luctus metus. Pellentesque neque diam, vestibulum tincidunt bibendum a, egestas at enim. Nulla eu pellentesque mauris. Nullam aliquet ut nisi non imperdiet.

Donec est magna, tincidunt quis sagittis sed, aliquet non massa. Quisque rutrum arcu vitae massa sollicitudin consequat. Etiam tempor felis ut tortor viverra, vestibulum condimentum est blandit. Cras ultrices vestibulum dolor, nec rhoncus est vulputate nec. Ut sed augue id mi pellentesque interdum. Integer aliquam ipsum ut porttitor consectetur. Nullam sem mi, tristique nec condimentum feugiat, varius sit amet tellus. Integer a turpis ac est pellentesque ornare. Praesent id justo a eros malesuada sagittis. Suspendisse eget sapien id lorem accumsan tincidunt sed sit amet lorem. Ut pharetra purus quam, a luctus elit luctus sit amet. Aliquam placerat purus sem, non posuere velit cursus ullamcorper.

Aenean laoreet a leo sed lacinia. In hac habitasse platea dictumst. Morbi rutrum pharetra egestas. Nam rhoncus, dolor in sodales lacinia, leo nulla rutrum purus, at ornare dolor tortor et lorem. Quisque egestas in magna vitae rhoncus. Sed ligula erat, laoreet at turpis sit amet, tincidunt pulvinar justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus porttitor nec mauris eget rutrum. Nunc semper felis vitae dolor blandit egestas a eget arcu. Praesent ipsum augue, porttitor eget lorem vel, euismod molestie nisi. Nullam dignissim erat id quam tristique, id adipiscing sem semper. Pellentesque ultricies diam sed nibh mattis, id pulvinar nunc suscipit. Praesent id mattis libero. Phasellus ac rhoncus ligula, quis consequat elit. Cras eros turpis, varius mollis odio vitae, consequat convallis quam.', 'AS PERSPECTIVAS PARA A TI', '', 'publish', 'closed', 'open', '', 'as-perspectivas-para-a-ti-2', '', '', '2014-04-23 00:16:35', '2014-04-23 00:16:35', '', '0', 'http://127.0.0.1/asug/?p=313', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('314', '1', '2014-04-23 00:17:40', '2014-04-23 00:17:40', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer suscipit magna at metus consequat iaculis. Nullam ut nulla facilisis, viverra magna at, pellentesque magna. Sed nibh turpis, tempus non nisi a, pharetra bibendum diam. Nulla aliquet eros enim, eu tempor mi egestas in. Nullam consequat interdum libero, vitae sodales tellus lobortis eu. Vivamus gravida libero ut lacus congue consequat. Duis viverra dolor vel nulla lacinia vehicula.

Suspendisse faucibus orci in turpis tincidunt, a aliquet velit feugiat. Duis eget dui velit. Phasellus ultrices, purus et gravida sodales, risus nibh pharetra dui, sit amet sagittis augue ipsum vitae massa. Fusce molestie laoreet nunc id posuere. In hac habitasse platea dictumst. Quisque vel sem ullamcorper, mattis enim eget, luctus metus. Pellentesque neque diam, vestibulum tincidunt bibendum a, egestas at enim. Nulla eu pellentesque mauris. Nullam aliquet ut nisi non imperdiet.

Donec est magna, tincidunt quis sagittis sed, aliquet non massa. Quisque rutrum arcu vitae massa sollicitudin consequat. Etiam tempor felis ut tortor viverra, vestibulum condimentum est blandit. Cras ultrices vestibulum dolor, nec rhoncus est vulputate nec. Ut sed augue id mi pellentesque interdum. Integer aliquam ipsum ut porttitor consectetur. Nullam sem mi, tristique nec condimentum feugiat, varius sit amet tellus. Integer a turpis ac est pellentesque ornare. Praesent id justo a eros malesuada sagittis. Suspendisse eget sapien id lorem accumsan tincidunt sed sit amet lorem. Ut pharetra purus quam, a luctus elit luctus sit amet. Aliquam placerat purus sem, non posuere velit cursus ullamcorper.

Aenean laoreet a leo sed lacinia. In hac habitasse platea dictumst. Morbi rutrum pharetra egestas. Nam rhoncus, dolor in sodales lacinia, leo nulla rutrum purus, at ornare dolor tortor et lorem. Quisque egestas in magna vitae rhoncus. Sed ligula erat, laoreet at turpis sit amet, tincidunt pulvinar justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus porttitor nec mauris eget rutrum. Nunc semper felis vitae dolor blandit egestas a eget arcu. Praesent ipsum augue, porttitor eget lorem vel, euismod molestie nisi. Nullam dignissim erat id quam tristique, id adipiscing sem semper. Pellentesque ultricies diam sed nibh mattis, id pulvinar nunc suscipit. Praesent id mattis libero. Phasellus ac rhoncus ligula, quis consequat elit. Cras eros turpis, varius mollis odio vitae, consequat convallis quam.', 'SAP traz novo conceito de treinamento empresarial ao Brasil ', '', 'publish', 'closed', 'open', '', 'sap-traz-novo-conceito-de-treinamento-empresarial-ao-brasil-2', '', '', '2014-04-23 00:17:40', '2014-04-23 00:17:40', '', '0', 'http://127.0.0.1/asug/?p=314', '0', 'post', '', '0'); 
INSERT INTO `wp_posts` VALUES ('315', '1', '2014-04-23 00:04:35', '2014-04-23 00:04:35', '', 'Impact Awards', '', 'publish', 'closed', 'closed', '', 'acf_impact-awards', '', '', '2014-04-23 00:04:35', '2014-04-23 00:04:35', '', '0', 'http://127.0.0.1/asug/?post_type=acf&#038;p=315', '0', 'acf', '', '0'); 
INSERT INTO `wp_posts` VALUES ('316', '1', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', 'Loja', '', 'inherit', 'closed', 'open', '', '96-revision-v1', '', '', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', '96', 'http://127.0.0.1/asug/96-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('317', '1', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '[woocommerce_cart]', 'Carrinho', '', 'inherit', 'closed', 'open', '', '97-revision-v1', '', '', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', '97', 'http://127.0.0.1/asug/97-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('318', '1', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '[woocommerce_checkout]', 'Finalizar compra', '', 'inherit', 'closed', 'open', '', '98-revision-v1', '', '', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', '98', 'http://127.0.0.1/asug/98-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('319', '1', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '[woocommerce_my_account]', 'Minha conta', '', 'inherit', 'closed', 'open', '', '99-revision-v1', '', '', '2014-04-23 00:05:39', '2014-04-23 00:05:39', '', '99', 'http://127.0.0.1/asug/99-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('320', '1', '2014-04-23 00:15:21', '2014-04-23 00:15:21', '', 'circuit-Sqr[1]', '', 'inherit', 'closed', 'open', '', 'circuit-sqr1', '', '', '2014-04-23 00:15:21', '2014-04-23 00:15:21', '', '312', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/circuit-Sqr1.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('321', '1', '2014-04-23 00:15:37', '2014-04-23 00:15:37', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer suscipit magna at metus consequat iaculis. Nullam ut nulla facilisis, viverra magna at, pellentesque magna. Sed nibh turpis, tempus non nisi a, pharetra bibendum diam. Nulla aliquet eros enim, eu tempor mi egestas in. Nullam consequat interdum libero, vitae sodales tellus lobortis eu. Vivamus gravida libero ut lacus congue consequat. Duis viverra dolor vel nulla lacinia vehicula.

Suspendisse faucibus orci in turpis tincidunt, a aliquet velit feugiat. Duis eget dui velit. Phasellus ultrices, purus et gravida sodales, risus nibh pharetra dui, sit amet sagittis augue ipsum vitae massa. Fusce molestie laoreet nunc id posuere. In hac habitasse platea dictumst. Quisque vel sem ullamcorper, mattis enim eget, luctus metus. Pellentesque neque diam, vestibulum tincidunt bibendum a, egestas at enim. Nulla eu pellentesque mauris. Nullam aliquet ut nisi non imperdiet.

Donec est magna, tincidunt quis sagittis sed, aliquet non massa. Quisque rutrum arcu vitae massa sollicitudin consequat. Etiam tempor felis ut tortor viverra, vestibulum condimentum est blandit. Cras ultrices vestibulum dolor, nec rhoncus est vulputate nec. Ut sed augue id mi pellentesque interdum. Integer aliquam ipsum ut porttitor consectetur. Nullam sem mi, tristique nec condimentum feugiat, varius sit amet tellus. Integer a turpis ac est pellentesque ornare. Praesent id justo a eros malesuada sagittis. Suspendisse eget sapien id lorem accumsan tincidunt sed sit amet lorem. Ut pharetra purus quam, a luctus elit luctus sit amet. Aliquam placerat purus sem, non posuere velit cursus ullamcorper.

Aenean laoreet a leo sed lacinia. In hac habitasse platea dictumst. Morbi rutrum pharetra egestas. Nam rhoncus, dolor in sodales lacinia, leo nulla rutrum purus, at ornare dolor tortor et lorem. Quisque egestas in magna vitae rhoncus. Sed ligula erat, laoreet at turpis sit amet, tincidunt pulvinar justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus porttitor nec mauris eget rutrum. Nunc semper felis vitae dolor blandit egestas a eget arcu. Praesent ipsum augue, porttitor eget lorem vel, euismod molestie nisi. Nullam dignissim erat id quam tristique, id adipiscing sem semper. Pellentesque ultricies diam sed nibh mattis, id pulvinar nunc suscipit. Praesent id mattis libero. Phasellus ac rhoncus ligula, quis consequat elit. Cras eros turpis, varius mollis odio vitae, consequat convallis quam.', 'SAP traz novo conceito de treinamento empresarial ao Brasil', '', 'inherit', 'closed', 'open', '', '312-revision-v1', '', '', '2014-04-23 00:15:37', '2014-04-23 00:15:37', '', '312', 'http://127.0.0.1/asug/312-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('322', '1', '2014-04-23 00:16:24', '2014-04-23 00:16:24', '', 'technology-hand[1]', '', 'inherit', 'closed', 'open', '', 'technology-hand1', '', '', '2014-04-23 00:16:24', '2014-04-23 00:16:24', '', '313', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/technology-hand1.jpg', '0', 'attachment', 'image/jpeg', '0'); 
INSERT INTO `wp_posts` VALUES ('323', '1', '2014-04-23 00:16:35', '2014-04-23 00:16:35', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer suscipit magna at metus consequat iaculis. Nullam ut nulla facilisis, viverra magna at, pellentesque magna. Sed nibh turpis, tempus non nisi a, pharetra bibendum diam. Nulla aliquet eros enim, eu tempor mi egestas in. Nullam consequat interdum libero, vitae sodales tellus lobortis eu. Vivamus gravida libero ut lacus congue consequat. Duis viverra dolor vel nulla lacinia vehicula.

Suspendisse faucibus orci in turpis tincidunt, a aliquet velit feugiat. Duis eget dui velit. Phasellus ultrices, purus et gravida sodales, risus nibh pharetra dui, sit amet sagittis augue ipsum vitae massa. Fusce molestie laoreet nunc id posuere. In hac habitasse platea dictumst. Quisque vel sem ullamcorper, mattis enim eget, luctus metus. Pellentesque neque diam, vestibulum tincidunt bibendum a, egestas at enim. Nulla eu pellentesque mauris. Nullam aliquet ut nisi non imperdiet.

Donec est magna, tincidunt quis sagittis sed, aliquet non massa. Quisque rutrum arcu vitae massa sollicitudin consequat. Etiam tempor felis ut tortor viverra, vestibulum condimentum est blandit. Cras ultrices vestibulum dolor, nec rhoncus est vulputate nec. Ut sed augue id mi pellentesque interdum. Integer aliquam ipsum ut porttitor consectetur. Nullam sem mi, tristique nec condimentum feugiat, varius sit amet tellus. Integer a turpis ac est pellentesque ornare. Praesent id justo a eros malesuada sagittis. Suspendisse eget sapien id lorem accumsan tincidunt sed sit amet lorem. Ut pharetra purus quam, a luctus elit luctus sit amet. Aliquam placerat purus sem, non posuere velit cursus ullamcorper.

Aenean laoreet a leo sed lacinia. In hac habitasse platea dictumst. Morbi rutrum pharetra egestas. Nam rhoncus, dolor in sodales lacinia, leo nulla rutrum purus, at ornare dolor tortor et lorem. Quisque egestas in magna vitae rhoncus. Sed ligula erat, laoreet at turpis sit amet, tincidunt pulvinar justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus porttitor nec mauris eget rutrum. Nunc semper felis vitae dolor blandit egestas a eget arcu. Praesent ipsum augue, porttitor eget lorem vel, euismod molestie nisi. Nullam dignissim erat id quam tristique, id adipiscing sem semper. Pellentesque ultricies diam sed nibh mattis, id pulvinar nunc suscipit. Praesent id mattis libero. Phasellus ac rhoncus ligula, quis consequat elit. Cras eros turpis, varius mollis odio vitae, consequat convallis quam.', 'AS PERSPECTIVAS PARA A TI', '', 'inherit', 'closed', 'open', '', '313-revision-v1', '', '', '2014-04-23 00:16:35', '2014-04-23 00:16:35', '', '313', 'http://127.0.0.1/asug/313-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('324', '1', '2014-04-23 00:17:19', '2014-04-23 00:17:19', '', 'cpuaroundworld_alpha[1]', '', 'inherit', 'closed', 'open', '', 'cpuaroundworld_alpha1', '', '', '2014-04-23 00:17:19', '2014-04-23 00:17:19', '', '314', 'http://127.0.0.1/asug/wp-content/uploads/2014/04/cpuaroundworld_alpha1.png', '0', 'attachment', 'image/png', '0'); 
INSERT INTO `wp_posts` VALUES ('325', '1', '2014-04-23 00:17:40', '2014-04-23 00:17:40', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer suscipit magna at metus consequat iaculis. Nullam ut nulla facilisis, viverra magna at, pellentesque magna. Sed nibh turpis, tempus non nisi a, pharetra bibendum diam. Nulla aliquet eros enim, eu tempor mi egestas in. Nullam consequat interdum libero, vitae sodales tellus lobortis eu. Vivamus gravida libero ut lacus congue consequat. Duis viverra dolor vel nulla lacinia vehicula.

Suspendisse faucibus orci in turpis tincidunt, a aliquet velit feugiat. Duis eget dui velit. Phasellus ultrices, purus et gravida sodales, risus nibh pharetra dui, sit amet sagittis augue ipsum vitae massa. Fusce molestie laoreet nunc id posuere. In hac habitasse platea dictumst. Quisque vel sem ullamcorper, mattis enim eget, luctus metus. Pellentesque neque diam, vestibulum tincidunt bibendum a, egestas at enim. Nulla eu pellentesque mauris. Nullam aliquet ut nisi non imperdiet.

Donec est magna, tincidunt quis sagittis sed, aliquet non massa. Quisque rutrum arcu vitae massa sollicitudin consequat. Etiam tempor felis ut tortor viverra, vestibulum condimentum est blandit. Cras ultrices vestibulum dolor, nec rhoncus est vulputate nec. Ut sed augue id mi pellentesque interdum. Integer aliquam ipsum ut porttitor consectetur. Nullam sem mi, tristique nec condimentum feugiat, varius sit amet tellus. Integer a turpis ac est pellentesque ornare. Praesent id justo a eros malesuada sagittis. Suspendisse eget sapien id lorem accumsan tincidunt sed sit amet lorem. Ut pharetra purus quam, a luctus elit luctus sit amet. Aliquam placerat purus sem, non posuere velit cursus ullamcorper.

Aenean laoreet a leo sed lacinia. In hac habitasse platea dictumst. Morbi rutrum pharetra egestas. Nam rhoncus, dolor in sodales lacinia, leo nulla rutrum purus, at ornare dolor tortor et lorem. Quisque egestas in magna vitae rhoncus. Sed ligula erat, laoreet at turpis sit amet, tincidunt pulvinar justo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus porttitor nec mauris eget rutrum. Nunc semper felis vitae dolor blandit egestas a eget arcu. Praesent ipsum augue, porttitor eget lorem vel, euismod molestie nisi. Nullam dignissim erat id quam tristique, id adipiscing sem semper. Pellentesque ultricies diam sed nibh mattis, id pulvinar nunc suscipit. Praesent id mattis libero. Phasellus ac rhoncus ligula, quis consequat elit. Cras eros turpis, varius mollis odio vitae, consequat convallis quam.', 'SAP traz novo conceito de treinamento empresarial ao Brasil ', '', 'inherit', 'closed', 'open', '', '314-revision-v1', '', '', '2014-04-23 00:17:40', '2014-04-23 00:17:40', '', '314', 'http://127.0.0.1/asug/314-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('326', '1', '2014-04-23 00:21:50', '2014-04-23 00:21:50', '', 'Home', '', 'inherit', 'closed', 'open', '', '2-revision-v1', '', '', '2014-04-23 00:21:50', '2014-04-23 00:21:50', '', '2', 'http://127.0.0.1/asug/2-revision-v1/', '0', 'revision', '', '0'); 
INSERT INTO `wp_posts` VALUES ('327', '999999999', '2014-04-24 01:20:13', '2014-04-24 01:20:13', 'WP Backupware - 1398302411', 'WP Backupware - 1398302411', '', 'private', 'closed', 'open', '', 'wp-backupware-1398302411', '', '', '2014-04-24 01:20:13', '2014-04-24 01:20:13', '', '0', 'http://127.0.0.1/asug/wpbu_backups/wp-backupware-1398302411/', '0', 'wpbu_backups', '', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_term_relationships`
--
DROP TABLE IF EXISTS `wp_term_relationships`;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_term_relationships`
--
LOCK TABLES `wp_term_relationships` WRITE;
INSERT INTO `wp_term_relationships` VALUES ('1', '1', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('1', '4', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('45', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('47', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('48', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('49', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('50', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('54', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('56', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('57', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('58', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('59', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('60', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('68', '3', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('70', '3', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('72', '3', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('74', '3', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('76', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('90', '1', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('90', '4', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('92', '1', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('92', '4', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('94', '1', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('94', '4', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('153', '16', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('153', '17', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('182', '1', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('191', '1', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('191', '18', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('194', '1', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('203', '1', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('213', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('222', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('226', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('227', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('228', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('229', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('230', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('231', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('232', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('233', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('234', '19', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('249', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('293', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('296', '2', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('309', '20', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('312', '20', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('313', '20', '0'); 
INSERT INTO `wp_term_relationships` VALUES ('314', '20', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_term_taxonomy`
--
DROP TABLE IF EXISTS `wp_term_taxonomy`;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_term_taxonomy`
--
LOCK TABLES `wp_term_taxonomy` WRITE;
INSERT INTO `wp_term_taxonomy` VALUES ('1', '1', 'category', 'Destaque em eventos no qual terá relevância na homepage', '0', '4'); 
INSERT INTO `wp_term_taxonomy` VALUES ('2', '2', 'nav_menu', '', '0', '15'); 
INSERT INTO `wp_term_taxonomy` VALUES ('3', '3', 'dfads_group', 'Banners Home', '0', '4'); 
INSERT INTO `wp_term_taxonomy` VALUES ('4', '4', 'category', '', '0', '4'); 
INSERT INTO `wp_term_taxonomy` VALUES ('5', '5', 'product_type', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('6', '6', 'product_type', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('7', '7', 'product_type', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('8', '8', 'product_type', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('9', '9', 'shop_order_status', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('10', '10', 'shop_order_status', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('11', '11', 'shop_order_status', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('12', '12', 'shop_order_status', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('13', '13', 'shop_order_status', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('14', '14', 'shop_order_status', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('15', '15', 'shop_order_status', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('16', '16', 'event-categories', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('17', '17', 'event-tags', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('18', '18', 'post_format', '', '0', '0'); 
INSERT INTO `wp_term_taxonomy` VALUES ('19', '19', 'category', '', '0', '11'); 
INSERT INTO `wp_term_taxonomy` VALUES ('20', '20', 'category', 'Destaque de notícia, no qual ganhará relevância na homepage', '0', '4'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_terms`
--
DROP TABLE IF EXISTS `wp_terms`;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `slug` varchar(200) NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_terms`
--
LOCK TABLES `wp_terms` WRITE;
INSERT INTO `wp_terms` VALUES ('1', 'Destaque Eventos', 'destaque-eventos', '0'); 
INSERT INTO `wp_terms` VALUES ('2', 'Topo', 'topo', '0'); 
INSERT INTO `wp_terms` VALUES ('3', 'Banners Home', 'banners-home', '0'); 
INSERT INTO `wp_terms` VALUES ('4', 'Eventos', 'eventos', '0'); 
INSERT INTO `wp_terms` VALUES ('5', 'simple', 'simple', '0'); 
INSERT INTO `wp_terms` VALUES ('6', 'grouped', 'grouped', '0'); 
INSERT INTO `wp_terms` VALUES ('7', 'variable', 'variable', '0'); 
INSERT INTO `wp_terms` VALUES ('8', 'external', 'external', '0'); 
INSERT INTO `wp_terms` VALUES ('9', 'pending', 'pending', '0'); 
INSERT INTO `wp_terms` VALUES ('10', 'failed', 'failed', '0'); 
INSERT INTO `wp_terms` VALUES ('11', 'on-hold', 'on-hold', '0'); 
INSERT INTO `wp_terms` VALUES ('12', 'processing', 'processing', '0'); 
INSERT INTO `wp_terms` VALUES ('13', 'completed', 'completed', '0'); 
INSERT INTO `wp_terms` VALUES ('14', 'refunded', 'refunded', '0'); 
INSERT INTO `wp_terms` VALUES ('15', 'cancelled', 'cancelled', '0'); 
INSERT INTO `wp_terms` VALUES ('16', 'Asug Day', 'asug-day', '0'); 
INSERT INTO `wp_terms` VALUES ('17', 'asugdays', 'asugdays', '0'); 
INSERT INTO `wp_terms` VALUES ('18', 'post-format-status', 'post-format-status', '0'); 
INSERT INTO `wp_terms` VALUES ('19', 'Revista', 'revista', '0'); 
INSERT INTO `wp_terms` VALUES ('20', 'Notícia destaque', 'post-destaque', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_user_status_manager`
--
DROP TABLE IF EXISTS `wp_user_status_manager`;
CREATE TABLE `wp_user_status_manager` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(9) NOT NULL,
  `user_name` text NOT NULL,
  `user_email` text NOT NULL,
  `status_from` text NOT NULL,
  `status_to` text NOT NULL,
  `status` text NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_user_status_manager`
--
LOCK TABLES `wp_user_status_manager` WRITE;
INSERT INTO `wp_user_status_manager` VALUES ('1', '4', 'pita', 'spynomak@hotmail.com', '', '', '1'); 
INSERT INTO `wp_user_status_manager` VALUES ('2', '5', 'felipe', 'felipe@montarsite.com.br', '', '', '0'); 
INSERT INTO `wp_user_status_manager` VALUES ('3', '6', 'suporte', 'suporte@montarsite.com.br', '', '', '1'); 
INSERT INTO `wp_user_status_manager` VALUES ('4', '7', 'marco', 'marco@montarsite.com.br', '25/02/2014', '25/02/2015', '1'); 
INSERT INTO `wp_user_status_manager` VALUES ('5', '8', 'jim', 'jim@montarsite.com.br', '', '', '0'); 
INSERT INTO `wp_user_status_manager` VALUES ('6', '9', 'teste1', 'teste@montarsite.com.br', '', '', '0'); 
INSERT INTO `wp_user_status_manager` VALUES ('7', '10', 'teste2', 'teste2@ms.com.br', '', '', '0'); 
INSERT INTO `wp_user_status_manager` VALUES ('8', '11', 'teste3', 'teste3@ms.com.br', '2014/03/23', '2015/03/23', '0'); 
INSERT INTO `wp_user_status_manager` VALUES ('9', '1', 'contato@montarsite.com.br', 'contato@montarsite.com.br', '', '', '0'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_usermeta`
--
DROP TABLE IF EXISTS `wp_usermeta`;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_usermeta`
--
LOCK TABLES `wp_usermeta` WRITE;
INSERT INTO `wp_usermeta` VALUES ('1', '1', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('2', '1', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('3', '1', 'nickname', 'adminasugms'); 
INSERT INTO `wp_usermeta` VALUES ('4', '1', 'description', ''); 
INSERT INTO `wp_usermeta` VALUES ('5', '1', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('6', '1', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('7', '1', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('8', '1', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('9', '1', 'show_admin_bar_front', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('10', '1', 'wp_capabilities', 'a:14:{s:13:"administrator";b:1;s:15:"membershipadmin";b:1;s:24:"membershipadmindashboard";b:1;s:22:"membershipadminmembers";b:1;s:21:"membershipadminlevels";b:1;s:28:"membershipadminsubscriptions";b:1;s:22:"membershipadmincoupons";b:1;s:24:"membershipadminpurchases";b:1;s:29:"membershipadmincommunications";b:1;s:21:"membershipadmingroups";b:1;s:20:"membershipadminpings";b:1;s:23:"membershipadmingateways";b:1;s:22:"membershipadminoptions";b:1;s:32:"membershipadminupdatepermissions";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('11', '1', 'wp_user_level', '10'); 
INSERT INTO `wp_usermeta` VALUES ('12', '1', 'dismissed_wp_pointers', 'wp330_toolbar,wp330_saving_widgets,wp340_choose_image_from_library,wp340_customize_current_theme_link,wp350_media,wp360_revisions,wp360_locks,wp390_widgets'); 
INSERT INTO `wp_usermeta` VALUES ('13', '1', 'show_welcome_panel', '1'); 
INSERT INTO `wp_usermeta` VALUES ('14', '1', 'wp_dashboard_quick_press_last_post_id', '306'); 
INSERT INTO `wp_usermeta` VALUES ('15', '1', 'managenav-menuscolumnshidden', 'a:4:{i:0;s:11:"link-target";i:1;s:11:"css-classes";i:2;s:3:"xfn";i:3;s:11:"description";}'); 
INSERT INTO `wp_usermeta` VALUES ('16', '1', 'metaboxhidden_nav-menus', 'a:3:{i:0;s:8:"add-post";i:1;s:12:"add-post_tag";i:2;s:15:"add-post_format";}'); 
INSERT INTO `wp_usermeta` VALUES ('17', '1', 'wp_user-settings', 'imgsize=full&libraryContent=browse&urlbutton=custom&editor=html&hidetb=1&wplink=1'); 
INSERT INTO `wp_usermeta` VALUES ('18', '1', 'wp_user-settings-time', '1398212438'); 
INSERT INTO `wp_usermeta` VALUES ('19', '1', 'nav_menu_recently_edited', '2'); 
INSERT INTO `wp_usermeta` VALUES ('20', '1', 'manageedit-eventcolumnshidden', 'a:1:{i:0;s:8:"event-id";}'); 
INSERT INTO `wp_usermeta` VALUES ('21', '1', 'membership_permissions_updated', 'yes'); 
INSERT INTO `wp_usermeta` VALUES ('49', '4', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('50', '4', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('51', '4', 'nickname', 'pitaaa'); 
INSERT INTO `wp_usermeta` VALUES ('52', '4', 'description', 'teste'); 
INSERT INTO `wp_usermeta` VALUES ('53', '4', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('54', '4', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('55', '4', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('56', '4', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('57', '4', 'show_admin_bar_front', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('58', '4', 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('59', '4', 'wp_user_level', '0'); 
INSERT INTO `wp_usermeta` VALUES ('60', '4', 'default_password_nag', ''); 
INSERT INTO `wp_usermeta` VALUES ('61', '4', 'billing_first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('62', '4', 'billing_last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('63', '4', 'billing_company', ''); 
INSERT INTO `wp_usermeta` VALUES ('64', '4', 'billing_address_1', ''); 
INSERT INTO `wp_usermeta` VALUES ('65', '4', 'billing_address_2', ''); 
INSERT INTO `wp_usermeta` VALUES ('66', '4', 'billing_city', ''); 
INSERT INTO `wp_usermeta` VALUES ('67', '4', 'billing_postcode', ''); 
INSERT INTO `wp_usermeta` VALUES ('68', '4', 'billing_state', ''); 
INSERT INTO `wp_usermeta` VALUES ('69', '4', 'billing_country', ''); 
INSERT INTO `wp_usermeta` VALUES ('70', '4', 'billing_phone', ''); 
INSERT INTO `wp_usermeta` VALUES ('71', '4', 'billing_email', ''); 
INSERT INTO `wp_usermeta` VALUES ('72', '4', 'shipping_first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('73', '4', 'shipping_last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('74', '4', 'shipping_company', ''); 
INSERT INTO `wp_usermeta` VALUES ('75', '4', 'shipping_address_1', ''); 
INSERT INTO `wp_usermeta` VALUES ('76', '4', 'shipping_address_2', ''); 
INSERT INTO `wp_usermeta` VALUES ('77', '4', 'shipping_city', ''); 
INSERT INTO `wp_usermeta` VALUES ('78', '4', 'shipping_postcode', ''); 
INSERT INTO `wp_usermeta` VALUES ('79', '4', 'shipping_state', ''); 
INSERT INTO `wp_usermeta` VALUES ('80', '4', 'shipping_country', ''); 
INSERT INTO `wp_usermeta` VALUES ('81', '4', 'dbem_phone', ''); 
INSERT INTO `wp_usermeta` VALUES ('82', '4', 'manageedit-eventcolumnshidden', 'a:1:{i:0;s:8:"event-id";}'); 
INSERT INTO `wp_usermeta` VALUES ('85', '4', 'display_boleto', 'a:3:{s:4:"file";s:84:"C:xampphtdocsasug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_201403.pdf";s:3:"url";s:88:"http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_201403.pdf";s:4:"type";s:15:"application/pdf";}'); 
INSERT INTO `wp_usermeta` VALUES ('87', '4', 'simple_local_avatar', 'a:4:{s:8:"media_id";i:123;s:4:"full";s:60:"http://127.0.0.1/asug/wp-content/uploads/2014/03/banner1.jpg";i:96;s:66:"http://127.0.0.1/asug/wp-content/uploads/2014/03/banner1-96x96.jpg";i:32;s:66:"http://127.0.0.1/asug/wp-content/uploads/2014/03/banner1-32x32.jpg";}'); 
INSERT INTO `wp_usermeta` VALUES ('88', '4', 'simple_local_avatar_rating', 'G'); 
INSERT INTO `wp_usermeta` VALUES ('90', '4', 'user_meta_image', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/wireframe-interna-ASUG.pdf'); 
INSERT INTO `wp_usermeta` VALUES ('91', '5', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('92', '5', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('93', '5', 'nickname', 'felipe'); 
INSERT INTO `wp_usermeta` VALUES ('94', '5', 'description', ''); 
INSERT INTO `wp_usermeta` VALUES ('95', '5', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('96', '5', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('97', '5', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('98', '5', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('99', '5', 'show_admin_bar_front', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('100', '5', 'wp_capabilities', 'a:1:{s:13:"representante";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('101', '5', 'wp_user_level', '0'); 
INSERT INTO `wp_usermeta` VALUES ('102', '5', 'default_password_nag', ''); 
INSERT INTO `wp_usermeta` VALUES ('103', '6', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('104', '6', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('105', '6', 'nickname', 'suporte'); 
INSERT INTO `wp_usermeta` VALUES ('106', '6', 'description', ''); 
INSERT INTO `wp_usermeta` VALUES ('107', '6', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('108', '6', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('109', '6', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('110', '6', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('111', '6', 'show_admin_bar_front', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('112', '6', 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('113', '6', 'wp_user_level', '0'); 
INSERT INTO `wp_usermeta` VALUES ('114', '6', 'default_password_nag', '1'); 
INSERT INTO `wp_usermeta` VALUES ('115', '7', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('116', '7', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('117', '7', 'nickname', 'marco'); 
INSERT INTO `wp_usermeta` VALUES ('118', '7', 'description', ''); 
INSERT INTO `wp_usermeta` VALUES ('119', '7', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('120', '7', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('121', '7', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('122', '7', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('123', '7', 'show_admin_bar_front', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('124', '7', 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('125', '7', 'wp_user_level', '0'); 
INSERT INTO `wp_usermeta` VALUES ('126', '7', 'default_password_nag', '1'); 
INSERT INTO `wp_usermeta` VALUES ('127', '8', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('128', '8', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('129', '8', 'nickname', 'jim'); 
INSERT INTO `wp_usermeta` VALUES ('130', '8', 'description', ''); 
INSERT INTO `wp_usermeta` VALUES ('131', '8', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('132', '8', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('133', '8', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('134', '8', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('135', '8', 'show_admin_bar_front', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('136', '8', 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('137', '8', 'wp_user_level', '0'); 
INSERT INTO `wp_usermeta` VALUES ('138', '8', 'default_password_nag', '1'); 
INSERT INTO `wp_usermeta` VALUES ('139', '9', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('140', '9', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('141', '9', 'nickname', 'teste1'); 
INSERT INTO `wp_usermeta` VALUES ('142', '9', 'description', ''); 
INSERT INTO `wp_usermeta` VALUES ('143', '9', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('144', '9', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('145', '9', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('146', '9', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('147', '9', 'show_admin_bar_front', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('148', '9', 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('149', '9', 'wp_user_level', '0'); 
INSERT INTO `wp_usermeta` VALUES ('150', '9', 'default_password_nag', '1'); 
INSERT INTO `wp_usermeta` VALUES ('151', '10', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('152', '10', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('153', '10', 'nickname', 'teste2'); 
INSERT INTO `wp_usermeta` VALUES ('154', '10', 'description', ''); 
INSERT INTO `wp_usermeta` VALUES ('155', '10', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('156', '10', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('157', '10', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('158', '10', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('159', '10', 'show_admin_bar_front', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('160', '10', 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('161', '10', 'wp_user_level', '0'); 
INSERT INTO `wp_usermeta` VALUES ('162', '10', 'default_password_nag', '1'); 
INSERT INTO `wp_usermeta` VALUES ('163', '11', 'first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('164', '11', 'last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('165', '11', 'nickname', 'teste3'); 
INSERT INTO `wp_usermeta` VALUES ('166', '11', 'description', ''); 
INSERT INTO `wp_usermeta` VALUES ('167', '11', 'rich_editing', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('168', '11', 'comment_shortcuts', 'false'); 
INSERT INTO `wp_usermeta` VALUES ('169', '11', 'admin_color', 'fresh'); 
INSERT INTO `wp_usermeta` VALUES ('170', '11', 'use_ssl', '0'); 
INSERT INTO `wp_usermeta` VALUES ('171', '11', 'show_admin_bar_front', 'true'); 
INSERT INTO `wp_usermeta` VALUES ('172', '11', 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'); 
INSERT INTO `wp_usermeta` VALUES ('173', '11', 'wp_user_level', '0'); 
INSERT INTO `wp_usermeta` VALUES ('174', '11', 'default_password_nag', '1'); 
INSERT INTO `wp_usermeta` VALUES ('176', '5', 'billing_first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('177', '5', 'billing_last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('178', '5', 'billing_company', ''); 
INSERT INTO `wp_usermeta` VALUES ('179', '5', 'billing_address_1', ''); 
INSERT INTO `wp_usermeta` VALUES ('180', '5', 'billing_address_2', ''); 
INSERT INTO `wp_usermeta` VALUES ('181', '5', 'billing_city', ''); 
INSERT INTO `wp_usermeta` VALUES ('182', '5', 'billing_postcode', ''); 
INSERT INTO `wp_usermeta` VALUES ('183', '5', 'billing_state', ''); 
INSERT INTO `wp_usermeta` VALUES ('184', '5', 'billing_country', ''); 
INSERT INTO `wp_usermeta` VALUES ('185', '5', 'billing_phone', ''); 
INSERT INTO `wp_usermeta` VALUES ('186', '5', 'billing_email', ''); 
INSERT INTO `wp_usermeta` VALUES ('187', '5', 'shipping_first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('188', '5', 'shipping_last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('189', '5', 'shipping_company', ''); 
INSERT INTO `wp_usermeta` VALUES ('190', '5', 'shipping_address_1', ''); 
INSERT INTO `wp_usermeta` VALUES ('191', '5', 'shipping_address_2', ''); 
INSERT INTO `wp_usermeta` VALUES ('192', '5', 'shipping_city', ''); 
INSERT INTO `wp_usermeta` VALUES ('193', '5', 'shipping_postcode', ''); 
INSERT INTO `wp_usermeta` VALUES ('194', '5', 'shipping_state', ''); 
INSERT INTO `wp_usermeta` VALUES ('195', '5', 'shipping_country', ''); 
INSERT INTO `wp_usermeta` VALUES ('196', '5', 'dbem_phone', ''); 
INSERT INTO `wp_usermeta` VALUES ('197', '6', 'user_meta_image', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014036.pdf'); 
INSERT INTO `wp_usermeta` VALUES ('198', '6', 'billing_first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('199', '6', 'billing_last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('200', '6', 'billing_company', ''); 
INSERT INTO `wp_usermeta` VALUES ('201', '6', 'billing_address_1', ''); 
INSERT INTO `wp_usermeta` VALUES ('202', '6', 'billing_address_2', ''); 
INSERT INTO `wp_usermeta` VALUES ('203', '6', 'billing_city', ''); 
INSERT INTO `wp_usermeta` VALUES ('204', '6', 'billing_postcode', ''); 
INSERT INTO `wp_usermeta` VALUES ('205', '6', 'billing_state', ''); 
INSERT INTO `wp_usermeta` VALUES ('206', '6', 'billing_country', ''); 
INSERT INTO `wp_usermeta` VALUES ('207', '6', 'billing_phone', ''); 
INSERT INTO `wp_usermeta` VALUES ('208', '6', 'billing_email', ''); 
INSERT INTO `wp_usermeta` VALUES ('209', '6', 'shipping_first_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('210', '6', 'shipping_last_name', ''); 
INSERT INTO `wp_usermeta` VALUES ('211', '6', 'shipping_company', ''); 
INSERT INTO `wp_usermeta` VALUES ('212', '6', 'shipping_address_1', ''); 
INSERT INTO `wp_usermeta` VALUES ('213', '6', 'shipping_address_2', ''); 
INSERT INTO `wp_usermeta` VALUES ('214', '6', 'shipping_city', ''); 
INSERT INTO `wp_usermeta` VALUES ('215', '6', 'shipping_postcode', ''); 
INSERT INTO `wp_usermeta` VALUES ('216', '6', 'shipping_state', ''); 
INSERT INTO `wp_usermeta` VALUES ('217', '6', 'shipping_country', ''); 
INSERT INTO `wp_usermeta` VALUES ('218', '6', 'dbem_phone', ''); 
INSERT INTO `wp_usermeta` VALUES ('219', '5', 'dismissed_wp_pointers', 'wp330_toolbar'); 
INSERT INTO `wp_usermeta` VALUES ('220', '5', 'meta-box-order_dashboard', 'a:4:{s:6:"normal";s:51:"dashboard_representante_inativos,dashboard_activity";s:4:"side";s:30:"dashboard_representante_ativos";s:7:"column3";s:0:"";s:7:"column4";s:0:"";}'); 
INSERT INTO `wp_usermeta` VALUES ('221', '5', 'closedpostboxes_dashboard', 'a:1:{i:0;s:18:"dashboard_activity";}'); 
INSERT INTO `wp_usermeta` VALUES ('222', '5', 'metaboxhidden_dashboard', 'a:0:{}'); 
INSERT INTO `wp_usermeta` VALUES ('223', '1', 'closedpostboxes_page', 'a:0:{}'); 
INSERT INTO `wp_usermeta` VALUES ('224', '1', 'metaboxhidden_page', 'a:5:{i:0;s:20:"tgm-new-media-plugin";i:1;s:10:"postcustom";i:2;s:16:"commentstatusdiv";i:3;s:7:"slugdiv";i:4;s:9:"authordiv";}'); 
INSERT INTO `wp_usermeta` VALUES ('225', '1', 'closedpostboxes_post', 'a:0:{}'); 
INSERT INTO `wp_usermeta` VALUES ('226', '1', 'metaboxhidden_post', 'a:5:{i:0;s:11:"postexcerpt";i:1;s:13:"trackbacksdiv";i:2;s:10:"postcustom";i:3;s:16:"commentstatusdiv";i:4;s:7:"slugdiv";}'); 
INSERT INTO `wp_usermeta` VALUES ('227', '1', 'total_time', '23278627'); 
INSERT INTO `wp_usermeta` VALUES ('228', '1', 'logged_in_amount', '1'); 
INSERT INTO `wp_usermeta` VALUES ('229', '1', 'average_time', '23278627'); 
INSERT INTO `wp_usermeta` VALUES ('230', '5', 'start_time', '1396718730'); 
INSERT INTO `wp_usermeta` VALUES ('231', '5', 'wp_user-settings', 'mfold=o'); 
INSERT INTO `wp_usermeta` VALUES ('232', '5', 'wp_user-settings-time', '1396723062'); 
INSERT INTO `wp_usermeta` VALUES ('233', '5', 'user_meta_image', 'http://127.0.0.1/asug/wp-content/uploads/2014/03/sua_fatura_de_energia_mesref_2014034.pdf'); 
INSERT INTO `wp_usermeta` VALUES ('234', '1', 'start_time', '1398207771'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_users`
--
DROP TABLE IF EXISTS `wp_users`;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(64) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_boleto` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_users`
--
LOCK TABLES `wp_users` WRITE;
INSERT INTO `wp_users` VALUES ('1', 'adminasugms', '$P$BoPNw4CMc/GAVk1olJyhHsV/qSVDiz/', 'adminasugms', '', 'contato@montarsite.com.br', '', '2014-03-15 15:51:25', '', '0', 'adminasugms'); 
INSERT INTO `wp_users` VALUES ('4', 'pita', '$P$BRqbQvJhgJUx754bqXeru4BtiQSPhO1', 'pita', '', 'spynomak@hotmail.com', '', '2014-03-20 02:57:27', '', '0', 'pita'); 
INSERT INTO `wp_users` VALUES ('5', 'felipe', '$P$BtFWvQW7iPbKUJxbRvsSiCdXVlOmTf0', 'felipe', '', 'felipe@montarsite.com.br', '', '2014-03-23 17:41:05', '', '0', 'felipe'); 
INSERT INTO `wp_users` VALUES ('6', 'suporte', '$P$BwsTYDMxv/iiPSC5Il.DX0rbbpPJpb/', 'suporte', '', 'suporte@montarsite.com.br', '', '2014-03-23 17:54:37', '', '0', 'suporte'); 
INSERT INTO `wp_users` VALUES ('7', 'marco', '$P$BS0264WoA0tsZWx/AouN/gG/hikSOc0', 'marco', '', 'marco@montarsite.com.br', '', '2014-03-23 17:55:33', '', '0', 'marco'); 
INSERT INTO `wp_users` VALUES ('8', 'jim', '$P$B8uOsZKjqoicEVxTk8aUrbdDv8sfVg1', 'jim', '', 'jim@montarsite.com.br', '', '2014-03-23 17:56:10', '', '0', 'jim'); 
INSERT INTO `wp_users` VALUES ('9', 'teste1', '$P$BDdIg/Bi06u5lydRqeXHoZP9m2lwOy/', 'teste1', '', 'teste@montarsite.com.br', '', '2014-03-23 17:56:58', '', '0', 'teste1'); 
INSERT INTO `wp_users` VALUES ('10', 'teste2', '$P$ByUYRpvdhAISTilyvhCBX4Ph2Zs.4k0', 'teste2', '', 'teste2@ms.com.br', '', '2014-03-23 17:57:41', '', '0', 'teste2'); 
INSERT INTO `wp_users` VALUES ('11', 'teste3', '$P$BwgS64xl6h7M8AmR32fnGv4jSvz5ka1', 'teste3', '', 'teste3@ms.com.br', '', '2014-03-23 18:00:05', '', '0', 'teste3'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_usm_post_message`
--
DROP TABLE IF EXISTS `wp_usm_post_message`;
CREATE TABLE `wp_usm_post_message` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `post_message` text NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
--
-- Dumping data for table `wp_usm_post_message`
--
LOCK TABLES `wp_usm_post_message` WRITE;
INSERT INTO `wp_usm_post_message` VALUES ('1', 'Ops'); 

UNLOCK TABLES;
--
-- Table structure for table `wp_woocommerce_order_itemmeta`
--
DROP TABLE IF EXISTS `wp_woocommerce_order_itemmeta`;
CREATE TABLE `wp_woocommerce_order_itemmeta` (
  `meta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_item_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_woocommerce_order_itemmeta`
--
LOCK TABLES `wp_woocommerce_order_itemmeta` WRITE;
UNLOCK TABLES;
--
-- Table structure for table `wp_woocommerce_order_items`
--
DROP TABLE IF EXISTS `wp_woocommerce_order_items`;
CREATE TABLE `wp_woocommerce_order_items` (
  `order_item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_item_name` longtext NOT NULL,
  `order_item_type` varchar(200) NOT NULL DEFAULT '',
  `order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Dumping data for table `wp_woocommerce_order_items`
--
LOCK TABLES `wp_woocommerce_order_items` WRITE;
UNLOCK TABLES;
