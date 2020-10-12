CREATE DATABASE IF NOT EXISTS ht;
USE ht;

DROP TABLE IF EXISTS `access_profiles`;
CREATE TABLE `access_profiles` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(16) NOT NULL,
  `dscr` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `access_stmts`;
CREATE TABLE `access_stmts` (
  `stmt_key` varchar(32) NOT NULL,
  `stmt_url` text NOT NULL,
  `stmt_head` text NOT NULL,
  `stmt_text` text NOT NULL,
  `stmt_url_aux` text,
  `stmt_icon` text,
  `stmt_icon_aux` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `access_stmts_map`;
CREATE TABLE `access_stmts_map` (
  `a_attr` varchar(32) NOT NULL,
  `a_access_profile` varchar(32) NOT NULL,
  `stmt_key` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `attributes`;
CREATE TABLE `attributes` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('access','copyright') NOT NULL DEFAULT 'access',
  `name` varchar(16) NOT NULL DEFAULT '',
  `dscr` text NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=28;


DROP TABLE IF EXISTS `collection_names`;
CREATE TABLE `collection_names` (
  `collection` varchar(16) NOT NULL,
  `coalesce(mapto_name,name)` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_approval_requests`;
CREATE TABLE `ht_approval_requests` (
  `id` int(11) NOT NULL,
  `approver` varchar(255) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `sent` timestamp NULL DEFAULT NULL,
  `received` timestamp NULL DEFAULT NULL,
  `renewed` timestamp NULL DEFAULT NULL,
  `token_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_collection_digitizers`;
CREATE TABLE `ht_collection_digitizers` (
  `collection` varchar(16) DEFAULT NULL,
  `digitization_source` varchar(16) DEFAULT NULL,
  `access_profile` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_collections`;
CREATE TABLE `ht_collections` (
  `collection` varchar(16) NOT NULL,
  `content_provider_cluster` varchar(255) DEFAULT NULL,
  `responsible_entity` varchar(64) DEFAULT NULL,
  `original_from_inst_id` varchar(32) DEFAULT NULL,
  `billing_entity` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_counts`;
CREATE TABLE `ht_counts` (
  `userid` varchar(256) NOT NULL,
  `accesscount` int(11) NOT NULL,
  `last_access` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `warned` tinyint(1) NOT NULL,
  `certified` tinyint(1) NOT NULL,
  `auth_requested` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_institutions`;
CREATE TABLE `ht_institutions` (
  `sdrinst` varchar(32) NOT NULL,
  `inst_id` varchar(64) DEFAULT NULL,
  `grin_instance` varchar(8) DEFAULT NULL,
  `name` varchar(256) NOT NULL,
  `template` varchar(256) NOT NULL,
  `authtype` varchar(32) NOT NULL,
  `domain` varchar(32) NOT NULL,
  `us` tinyint(1) NOT NULL,
  `mapto_domain` varchar(32) DEFAULT NULL,
  `mapto_sdrinst` varchar(32) DEFAULT NULL,
  `mapto_inst_id` varchar(32) DEFAULT NULL,
  `mapto_name` varchar(256) DEFAULT NULL,
  `mapto_entityID` varchar(256) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `orph_agree` tinyint(1) NOT NULL,
  `entityID` varchar(256) DEFAULT NULL,
  `allowed_affiliations` text,
  `shib_authncontext_class` varchar(255) DEFAULT NULL,
  `emergency_status` text,
  `emergency_contact` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_namespaces`;
CREATE TABLE `ht_namespaces` (
  `namespace` varchar(8) NOT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `grin_instance` varchar(32) DEFAULT NULL,
  `default_source` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_proxies`;
CREATE TABLE `ht_proxies` (
  `host` varchar(64) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_user_logs`;
CREATE TABLE `ht_user_logs` (
  `userid` varchar(255) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_users`;
CREATE TABLE `ht_users` (
  `userid` varchar(256) NOT NULL,
  `displayname` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `activitycontact` varchar(128) DEFAULT NULL,
  `approver` varchar(128) DEFAULT NULL,
  `authorizer` varchar(128) DEFAULT NULL,
  `usertype` varchar(32) DEFAULT NULL,
  `role` varchar(32) DEFAULT NULL,
  `access` varchar(32) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expire_type` varchar(32) DEFAULT NULL,
  `iprestrict` varchar(1024) DEFAULT NULL,
  `mfa` tinyint(1) DEFAULT NULL,
  `identity_provider` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ht_sessions`;
CREATE TABLE `ht_sessions` (
  `id` varchar(32) NOT NULL,
  `a_session` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mb_coll_item`;
CREATE TABLE `mb_coll_item` (
  `extern_item_id` varchar(255) CHARACTER SET utf8 NOT NULL,
  `MColl_ID` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mb_collection`;
CREATE TABLE `mb_collection` (
  `MColl_ID` int(10) unsigned NOT NULL,
  `collname` varchar(100) CHARACTER SET utf8 NOT NULL,
  `owner` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `owner_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `num_items` int(11) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `featured` date DEFAULT NULL,
  `branding` varchar(2048) CHARACTER SET utf8 DEFAULT NULL,
  `contact_info` text CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mb_item`;
CREATE TABLE `mb_item` (
  `extern_item_id` varchar(255) CHARACTER SET utf8 NOT NULL,
  `display_title` text CHARACTER SET utf8,
  `sort_title` varchar(1024) CHARACTER SET utf8 DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `date` date DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rights` tinyint(3) unsigned DEFAULT NULL,
  `bib_id` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `book_id` varchar(2048) CHARACTER SET utf8 DEFAULT NULL,
  `sort_date` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `sort_author` varchar(1024) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reasons`;
CREATE TABLE `reasons` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL DEFAULT '',
  `dscr` text NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=19;


DROP TABLE IF EXISTS `rights_current`;
CREATE TABLE `rights_current` (
	  `namespace` varchar(8) NOT NULL,
	  `id` varchar(32) NOT NULL DEFAULT '',
	  `attr` tinyint(4) NOT NULL,
	  `reason` tinyint(4) NOT NULL,
	  `source` tinyint(4) NOT NULL,
	  `access_profile` tinyint(4) NOT NULL,
	  `user` varchar(32) NOT NULL DEFAULT '',
	  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `note` text,
	  PRIMARY KEY (`namespace`,`id`),
	  KEY `time` (`time`),
	  KEY `rights_current_attr_index` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rights_log`;
CREATE TABLE `rights_log` (
  `namespace` varchar(8) NOT NULL,
  `id` varchar(32) NOT NULL,
  `attr` tinyint(4) NOT NULL,
  `reason` tinyint(4) NOT NULL,
  `source` tinyint(4) NOT NULL,
  `access_profile` tinyint(4) NOT NULL,
  `user` varchar(32) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `note` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `sources`;
CREATE TABLE `sources` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(16) NOT NULL,
  `dscr` text NOT NULL,
  `access_profile` tinyint(3) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


GRANT SELECT ON `ht`.* TO 'mdp-lib'@'%' IDENTIFIED BY 'mdp-lib';
