USE ht;
LOCK TABLES `ht_proxies` WRITE;
/*!40000 ALTER TABLE `ht_proxies` DISABLE KEYS */;
INSERT INTO `ht_proxies` VALUES ('www.crossfirewall.com','75.119.222.171','2011-01-18 23:12:19');
INSERT INTO `ht_proxies` VALUES ('reserver.ru','69.10.38.26','2011-05-13 19:21:43');
INSERT INTO `ht_proxies` VALUES ('appspot.l.google.com','209.85.147.141','2011-05-20 13:14:45');
/*!40000 ALTER TABLE `ht_proxies` ENABLE KEYS */;
UNLOCK TABLES;
