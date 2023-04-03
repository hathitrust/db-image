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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approver` varchar(255) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `sent` timestamp NULL DEFAULT NULL,
  `received` timestamp NULL DEFAULT NULL,
  `renewed` timestamp NULL DEFAULT NULL,
  `token_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `ht_billing_members`;
CREATE TABLE `ht_billing_members` (
  `inst_id` varchar(32) NOT NULL,
  `parent_inst_id` varchar(32) DEFAULT NULL,
  `weight` decimal(4,2) NOT NULL DEFAULT '0.00',
  `oclc_sym` varchar(10) DEFAULT NULL,
  `marc21_sym` varchar(10) DEFAULT NULL,
  `country_code` char(2) NOT NULL DEFAULT 'us',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`inst_id`)
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

DROP TABLE IF EXISTS `pt_exclusivity_ng`;
CREATE TABLE `pt_exclusivity_ng` (
  `lock_id` varchar(32) NOT NULL,
  `item_id` varchar(32) NOT NULL DEFAULT '',
  `owner` varchar(256) NOT NULL DEFAULT '',
  `affiliation` varchar(128) NOT NULL DEFAULT '',
  `expires` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `renewals` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lock_id`,`owner`,`affiliation`),
  KEY `lock_check` (`lock_id`,`affiliation`),
  KEY `excess_check` (`lock_id`,`affiliation`,`expires`),
  KEY `pt_exclusivity_ng_expires` (`expires`),
  KEY `pt_exclusivity_ng_item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED;

DROP TABLE IF EXISTS `ht_survey`;
CREATE TABLE `ht_survey` (
  `MColl_ID` int(10) unsigned NOT NULL DEFAULT 0,
  `effective_date` date DEFAULT NULL,
  `expires_date` date DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  KEY `MColl_ID` (`MColl_ID`),
  KEY `effective_date` (`effective_date`),
  KEY `expires_date` (`expires_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ht_institutions`;
CREATE TABLE `ht_institutions` (
  `inst_id` varchar(64) DEFAULT NULL,
  `grin_instance` varchar(8) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `template` varchar(256) DEFAULT NULL,
  `domain` varchar(32) DEFAULT NULL,
  `us` tinyint(1) NOT NULL DEFAULT 0,
  `mapto_inst_id` varchar(32) DEFAULT NULL,
  `mapto_name` varchar(256) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `entityID` varchar(256) DEFAULT NULL,
  `allowed_affiliations` text DEFAULT NULL,
  `shib_authncontext_class` varchar(255) DEFAULT NULL,
  `emergency_status` text DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  KEY `ht_institutions_inst_id` (`inst_id`),
  KEY `ht_institutions_mapto_inst_id` (`mapto_inst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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

DROP TABLE IF EXISTS `ht_logs`;
CREATE TABLE `ht_logs` (
  `model` varchar(255) DEFAULT NULL,
  `objid` varchar(255) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `ht_contacts`;
CREATE TABLE `ht_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inst_id` varchar(64) NOT NULL,
  `contact_type` int(11) NOT NULL,
  `email` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `ht_contact_types`;
CREATE TABLE `ht_contact_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
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
  `identity_provider` varchar(255) DEFAULT NULL,
  `inst_id` varchar(64) DEFAULT NULL
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

CREATE TABLE `mb_transfer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(36) NOT NULL DEFAULT '',
  `submitter` varchar(255) NOT NULL DEFAULT '',
  `submitter_usernames` text NOT NULL DEFAULT '[]',
  `receiver` varchar(255) DEFAULT NULL,
  `payload` text DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `completed` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`),
  KEY `submitter` (`submitter`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4;

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
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `note` mediumtext DEFAULT NULL,
  PRIMARY KEY (`namespace`,`id`),
  KEY `time` (`time`),
  KEY `rights_current_attr_index` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `rights_log`;
CREATE TABLE `rights_log` (
  `namespace` varchar(8) NOT NULL,
  `id` varchar(32) NOT NULL DEFAULT '',
  `attr` tinyint(4) NOT NULL,
  `reason` tinyint(4) NOT NULL,
  `source` tinyint(4) NOT NULL,
  `access_profile` tinyint(4) NOT NULL,
  `user` varchar(32) NOT NULL DEFAULT '',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `note` mediumtext DEFAULT NULL,
  PRIMARY KEY (`namespace`,`id`,`time`),
  KEY `time` (`time`),
  KEY `attr` (`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sources`;
CREATE TABLE `sources` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(16) NOT NULL,
  `dscr` text NOT NULL,
  `access_profile` tinyint(3) unsigned DEFAULT NULL,
  `digitization_source` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `oclc_concordance`;
CREATE TABLE `oclc_concordance` (
  `oclc` int(10) unsigned NOT NULL,
  `canonical` int(10) unsigned DEFAULT NULL,
  KEY `oclc_c_oclc` (`oclc`),
  KEY `oclc_c_canon` (`canonical`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


DROP TABLE IF EXISTS `holdings_htitem_htmember`;
CREATE TABLE `holdings_htitem_htmember` (
  `lock_id` varchar(300) NOT NULL,
  `cluster_id` varchar(25) NOT NULL,
  `volume_id` varchar(50) NOT NULL,
  `n_enum` varchar(250) DEFAULT '',
  `member_id` varchar(20) NOT NULL,
  `copy_count` int(11) DEFAULT NULL,
  `lm_count` smallint(6) DEFAULT NULL,
  `wd_count` smallint(6) DEFAULT NULL,
  `brt_count` smallint(6) DEFAULT NULL,
  `access_count` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`volume_id`,`member_id`),
  KEY `member_id` (`member_id`),
  KEY `cluster_id` (`cluster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


GRANT SELECT ON `ht`.* TO 'mdp-lib'@'%' IDENTIFIED BY 'mdp-lib';
GRANT ALL ON `ht`.* TO 'mdp-admin'@'%' IDENTIFIED BY 'mdp-admin';
