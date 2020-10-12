USE ht;
LOCK TABLES `access_profiles` WRITE;
/*!40000 ALTER TABLE `access_profiles` DISABLE KEYS */;
INSERT INTO `access_profiles` VALUES (1,'open','Unrestricted image and full-volume download (e.g. Internet Archive)');
INSERT INTO `access_profiles` VALUES (2,'google','Restricted public full-volume download - watermarked PDF only, when logged in or with Data API key (e.g. Google)');
INSERT INTO `access_profiles` VALUES (3,'page','Page access only: no PDF or ZIP download for anyone (e.g. UM Press)');
INSERT INTO `access_profiles` VALUES (4,'page+lowres','Low resolution watermarked image derivatives only (e.g. MDL)');
/*!40000 ALTER TABLE `access_profiles` ENABLE KEYS */;
UNLOCK TABLES;
