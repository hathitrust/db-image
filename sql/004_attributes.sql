USE ht;
LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (1,'copyright','pd','public domain');
INSERT INTO `attributes` VALUES (2,'copyright','ic','in copyright');
INSERT INTO `attributes` VALUES (3,'copyright','op','out-of-print (implies in-copyright)');
INSERT INTO `attributes` VALUES (4,'copyright','orph','copyright-orphaned (implies in-copyright)');
INSERT INTO `attributes` VALUES (6,'access','umall','available to UM affiliates and walk-in patrons (all campuses)');
INSERT INTO `attributes` VALUES (7,'access','ic-world','in-copyright and permitted as world viewable by the copyright holder');
INSERT INTO `attributes` VALUES (5,'copyright','und','undetermined copyright status');
INSERT INTO `attributes` VALUES (8,'access','nobody','available to nobody; blocked for all users');
INSERT INTO `attributes` VALUES (9,'copyright','pdus','public domain only when viewed in the US');
INSERT INTO `attributes` VALUES (10,'copyright','cc-by-3.0','Creative Commons Attribution license, 3.0 Unported');
INSERT INTO `attributes` VALUES (11,'copyright','cc-by-nd-3.0','Creative Commons Attribution-NoDerivatives license, 3.0 Unported');
INSERT INTO `attributes` VALUES (12,'copyright','cc-by-nc-nd-3.0','Creative Commons Attribution-NonCommercial-NoDerivatives license, 3.0 Unported');
INSERT INTO `attributes` VALUES (13,'copyright','cc-by-nc-3.0','Creative Commons Attribution-NonCommercial license, 3.0 Unported');
INSERT INTO `attributes` VALUES (14,'copyright','cc-by-nc-sa-3.0','Creative Commons Attribution-NonCommercial-ShareAlike license, 3.0 Unported');
INSERT INTO `attributes` VALUES (15,'copyright','cc-by-sa-3.0','Creative Commons Attribution-ShareAlike license, 3.0 Unported');
INSERT INTO `attributes` VALUES (16,'copyright','orphcand','orphan candidate - in 90-day holding period (implies in-copyright)');
INSERT INTO `attributes` VALUES (17,'copyright','cc-zero','Creative Commons Zero license (implies pd)');
INSERT INTO `attributes` VALUES (18,'access','und-world','undetermined copyright status and permitted as world viewable by the depositor');
INSERT INTO `attributes` VALUES (19,'copyright','icus','in copyright in the US');
INSERT INTO `attributes` VALUES (20,'copyright','cc-by-4.0','Creative Commons Attribution 4.0 International license');
INSERT INTO `attributes` VALUES (21,'copyright','cc-by-nd-4.0','Creative Commons Attribution-NoDerivatives 4.0 International license');
INSERT INTO `attributes` VALUES (22,'copyright','cc-by-nc-nd-4.0','Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International license');
INSERT INTO `attributes` VALUES (23,'copyright','cc-by-nc-4.0','Creative Commons Attribution-NonCommercial 4.0 International license');
INSERT INTO `attributes` VALUES (24,'copyright','cc-by-nc-sa-4.0','Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International license');
INSERT INTO `attributes` VALUES (25,'copyright','cc-by-sa-4.0','Creative Commons Attribution-ShareAlike 4.0 International license');
INSERT INTO `attributes` VALUES (26,'access','pd-pvt','public domain but access limited due to privacy concerns');
INSERT INTO `attributes` VALUES (27,'access','supp','suppressed from view; see note for details');
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;
