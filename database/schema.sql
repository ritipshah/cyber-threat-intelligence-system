-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: aegiscore_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attack_campaigns`
--

DROP TABLE IF EXISTS `attack_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attack_campaigns` (
  `campaign_id` int NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) DEFAULT NULL,
  `detected_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text,
  PRIMARY KEY (`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attack_campaigns`
--

LOCK TABLES `attack_campaigns` WRITE;
/*!40000 ALTER TABLE `attack_campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `attack_campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_links`
--

DROP TABLE IF EXISTS `event_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_links` (
  `link_id` int NOT NULL AUTO_INCREMENT,
  `parent_event_id` int DEFAULT NULL,
  `child_event_id` int DEFAULT NULL,
  `relationship_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`link_id`),
  KEY `parent_event_id` (`parent_event_id`),
  KEY `child_event_id` (`child_event_id`),
  CONSTRAINT `event_links_ibfk_1` FOREIGN KEY (`parent_event_id`) REFERENCES `security_events` (`event_id`) ON DELETE CASCADE,
  CONSTRAINT `event_links_ibfk_2` FOREIGN KEY (`child_event_id`) REFERENCES `security_events` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_links`
--

LOCK TABLES `event_links` WRITE;
/*!40000 ALTER TABLE `event_links` DISABLE KEYS */;
INSERT INTO `event_links` VALUES (1,1,5,'ESCALATION');
/*!40000 ALTER TABLE `event_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_types`
--

DROP TABLE IF EXISTS `event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_types` (
  `event_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) NOT NULL,
  `severity_level` varchar(20) NOT NULL,
  PRIMARY KEY (`event_type_id`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_types`
--

LOCK TABLES `event_types` WRITE;
/*!40000 ALTER TABLE `event_types` DISABLE KEYS */;
INSERT INTO `event_types` VALUES (1,'FAILED_LOGIN','HIGH'),(2,'SUCCESSFUL_LOGIN','LOW'),(3,'PRIVILEGE_CHANGE','CRITICAL');
/*!40000 ALTER TABLE `event_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_events`
--

DROP TABLE IF EXISTS `incident_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `incident_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `incident_events_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incidents` (`incident_id`) ON DELETE CASCADE,
  CONSTRAINT `incident_events_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `security_events` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident_events`
--

LOCK TABLES `incident_events` WRITE;
/*!40000 ALTER TABLE `incident_events` DISABLE KEYS */;
INSERT INTO `incident_events` VALUES (1,1,1),(2,1,2),(3,1,3);
/*!40000 ALTER TABLE `incident_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidents`
--

DROP TABLE IF EXISTS `incidents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidents` (
  `incident_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `severity` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'OPEN',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`incident_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidents`
--

LOCK TABLES `incidents` WRITE;
/*!40000 ALTER TABLE `incidents` DISABLE KEYS */;
INSERT INTO `incidents` VALUES (1,'Multiple Failed Logins','User exceeded failed login threshold','HIGH','OPEN','2026-03-02 11:11:56');
/*!40000 ALTER TABLE `incidents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risk_history`
--

DROP TABLE IF EXISTS `risk_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `old_score` int DEFAULT NULL,
  `new_score` int DEFAULT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `risk_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risk_history`
--

LOCK TABLES `risk_history` WRITE;
/*!40000 ALTER TABLE `risk_history` DISABLE KEYS */;
INSERT INTO `risk_history` VALUES (1,1,0,50,'2026-03-02 11:12:35'),(2,1,50,60,'2026-03-02 11:22:30'),(3,1,55,60,'2026-03-02 11:37:59'),(4,1,60,65,'2026-03-03 17:57:37'),(5,NULL,0,20,'2026-03-04 11:50:55'),(6,NULL,0,20,'2026-03-04 11:52:55'),(7,NULL,0,20,'2026-03-04 11:52:56'),(8,NULL,0,20,'2026-03-04 11:53:03'),(9,NULL,0,20,'2026-03-04 11:53:05'),(10,NULL,0,20,'2026-03-04 11:53:05'),(11,NULL,0,20,'2026-03-04 11:53:12'),(12,NULL,0,20,'2026-03-04 11:53:34'),(13,3,0,5,'2026-03-04 12:04:52'),(14,3,0,20,'2026-03-04 12:12:49'),(15,3,0,5,'2026-03-04 12:12:54'),(16,3,0,20,'2026-03-04 12:13:24'),(17,3,0,20,'2026-03-04 12:13:27'),(18,3,0,20,'2026-03-04 12:13:35'),(19,3,0,5,'2026-03-04 12:13:39'),(20,3,0,20,'2026-03-04 12:17:05'),(21,3,0,20,'2026-03-04 12:17:10'),(22,3,0,5,'2026-03-04 12:17:14'),(23,3,0,20,'2026-03-04 12:17:29'),(24,3,0,20,'2026-03-04 12:17:30'),(25,3,0,5,'2026-03-04 12:17:36'),(26,3,0,20,'2026-03-04 12:21:16'),(27,3,0,20,'2026-03-04 12:21:19'),(28,3,0,5,'2026-03-04 12:21:23'),(29,4,0,5,'2026-03-04 12:28:28'),(30,4,0,20,'2026-03-04 12:28:34'),(31,4,10,15,'2026-03-04 12:28:39'),(32,3,0,20,'2026-03-04 12:29:27'),(33,3,0,20,'2026-03-04 12:29:31'),(34,3,0,20,'2026-03-04 12:29:35'),(35,3,0,20,'2026-03-04 12:29:39'),(36,3,0,5,'2026-03-04 12:29:43'),(37,5,0,5,'2026-03-04 12:30:28'),(38,5,0,20,'2026-03-04 12:30:32'),(39,5,10,30,'2026-03-04 12:30:33'),(40,5,20,40,'2026-03-04 12:30:37'),(41,5,30,50,'2026-03-04 12:30:40'),(42,5,40,45,'2026-03-04 12:30:44'),(43,3,0,20,'2026-03-04 12:31:31'),(44,3,0,20,'2026-03-04 12:31:35'),(45,3,0,5,'2026-03-04 12:31:39'),(46,3,0,20,'2026-03-04 12:34:30'),(47,3,0,5,'2026-03-04 12:34:33'),(48,3,0,20,'2026-03-04 12:37:02'),(49,3,100,120,'2026-03-04 12:37:06'),(50,3,100,105,'2026-03-04 12:37:11'),(51,6,0,5,'2026-03-04 12:39:00'),(52,6,0,20,'2026-03-04 12:39:04'),(53,6,10,30,'2026-03-04 12:39:07'),(54,6,20,25,'2026-03-04 12:39:10');
/*!40000 ALTER TABLE `risk_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risk_scores`
--

DROP TABLE IF EXISTS `risk_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_scores` (
  `risk_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `current_score` int DEFAULT '0',
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`risk_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `risk_scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risk_scores`
--

LOCK TABLES `risk_scores` WRITE;
/*!40000 ALTER TABLE `risk_scores` DISABLE KEYS */;
INSERT INTO `risk_scores` VALUES (1,1,65,'2026-03-03 17:57:37'),(2,4,10,'2026-03-04 12:28:39'),(3,5,40,'2026-03-04 12:30:44'),(4,2,0,'2026-03-04 12:34:15'),(5,3,100,'2026-03-04 12:37:11'),(6,6,20,'2026-03-04 12:39:10');
/*!40000 ALTER TABLE `risk_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','System Administrator'),(2,'User','Regular User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_events`
--

DROP TABLE IF EXISTS `security_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `security_events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `event_type_id` int DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `event_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) DEFAULT NULL,
  `login_hour` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `user_id` (`user_id`),
  KEY `event_type_id` (`event_type_id`),
  CONSTRAINT `security_events_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `security_events_ibfk_2` FOREIGN KEY (`event_type_id`) REFERENCES `event_types` (`event_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_events`
--

LOCK TABLES `security_events` WRITE;
/*!40000 ALTER TABLE `security_events` DISABLE KEYS */;
INSERT INTO `security_events` VALUES (1,1,1,'192.168.1.10','2026-03-02 11:11:37','FAILED',NULL,NULL),(2,1,1,'192.168.1.10','2026-03-02 11:11:37','FAILED',NULL,NULL),(3,1,1,'192.168.1.10','2026-03-02 11:11:37','FAILED',NULL,NULL),(4,1,1,'192.168.1.10','2026-03-02 11:16:18','FAILED',NULL,NULL),(5,1,1,'192.168.1.10','2026-03-02 11:22:30','FAILED',NULL,NULL),(6,1,2,'192.168.1.10','2026-03-02 11:37:59','SUCCESS',3,NULL),(7,1,2,NULL,'2026-03-03 17:57:37','SUCCESS',NULL,NULL),(8,NULL,1,NULL,'2026-03-04 11:50:55','FAILED',NULL,NULL),(9,NULL,1,NULL,'2026-03-04 11:52:55','FAILED',NULL,NULL),(10,NULL,1,NULL,'2026-03-04 11:52:56','FAILED',NULL,NULL),(11,NULL,1,NULL,'2026-03-04 11:53:03','FAILED',NULL,NULL),(12,NULL,1,NULL,'2026-03-04 11:53:05','FAILED',NULL,NULL),(13,NULL,1,NULL,'2026-03-04 11:53:05','FAILED',NULL,NULL),(14,NULL,1,NULL,'2026-03-04 11:53:12','FAILED',NULL,NULL),(15,NULL,1,NULL,'2026-03-04 11:53:34','FAILED',NULL,NULL),(16,3,2,NULL,'2026-03-04 12:04:52','SUCCESS',NULL,NULL),(17,3,1,NULL,'2026-03-04 12:12:49','FAILED',NULL,NULL),(18,3,2,NULL,'2026-03-04 12:12:54','SUCCESS',NULL,NULL),(19,3,1,NULL,'2026-03-04 12:13:24','FAILED',NULL,NULL),(20,3,1,NULL,'2026-03-04 12:13:27','FAILED',NULL,NULL),(21,3,1,NULL,'2026-03-04 12:13:35','FAILED',NULL,NULL),(22,3,2,NULL,'2026-03-04 12:13:39','SUCCESS',NULL,NULL),(23,3,1,NULL,'2026-03-04 12:17:05','FAILED',NULL,NULL),(24,3,1,NULL,'2026-03-04 12:17:10','FAILED',NULL,NULL),(25,3,2,NULL,'2026-03-04 12:17:14','SUCCESS',NULL,NULL),(26,3,1,NULL,'2026-03-04 12:17:29','FAILED',NULL,NULL),(27,3,1,NULL,'2026-03-04 12:17:30','FAILED',NULL,NULL),(28,3,2,NULL,'2026-03-04 12:17:36','SUCCESS',NULL,NULL),(29,3,1,NULL,'2026-03-04 12:21:16','FAILED',NULL,NULL),(30,3,1,NULL,'2026-03-04 12:21:19','FAILED',NULL,NULL),(31,3,2,NULL,'2026-03-04 12:21:23','SUCCESS',NULL,NULL),(32,4,2,NULL,'2026-03-04 12:28:28','SUCCESS',NULL,NULL),(33,4,1,NULL,'2026-03-04 12:28:34','FAILED',NULL,NULL),(34,4,2,NULL,'2026-03-04 12:28:39','SUCCESS',NULL,NULL),(35,3,1,NULL,'2026-03-04 12:29:27','FAILED',NULL,NULL),(36,3,1,NULL,'2026-03-04 12:29:31','FAILED',NULL,NULL),(37,3,1,NULL,'2026-03-04 12:29:35','FAILED',NULL,NULL),(38,3,1,NULL,'2026-03-04 12:29:39','FAILED',NULL,NULL),(39,3,2,NULL,'2026-03-04 12:29:43','SUCCESS',NULL,NULL),(40,5,2,NULL,'2026-03-04 12:30:28','SUCCESS',NULL,NULL),(41,5,1,NULL,'2026-03-04 12:30:32','FAILED',NULL,NULL),(42,5,1,NULL,'2026-03-04 12:30:33','FAILED',NULL,NULL),(43,5,1,NULL,'2026-03-04 12:30:37','FAILED',NULL,NULL),(44,5,1,NULL,'2026-03-04 12:30:40','FAILED',NULL,NULL),(45,5,2,NULL,'2026-03-04 12:30:44','SUCCESS',NULL,NULL),(46,3,1,NULL,'2026-03-04 12:31:31','FAILED',NULL,NULL),(47,3,1,NULL,'2026-03-04 12:31:35','FAILED',NULL,NULL),(48,3,2,NULL,'2026-03-04 12:31:39','SUCCESS',NULL,NULL),(49,3,1,NULL,'2026-03-04 12:34:30','FAILED',NULL,NULL),(50,3,2,NULL,'2026-03-04 12:34:33','SUCCESS',NULL,NULL),(51,3,1,NULL,'2026-03-04 12:37:02','FAILED',NULL,NULL),(52,3,1,NULL,'2026-03-04 12:37:06','FAILED',NULL,NULL),(53,3,2,NULL,'2026-03-04 12:37:11','SUCCESS',NULL,NULL),(54,6,2,NULL,'2026-03-04 12:39:00','SUCCESS',NULL,NULL),(55,6,1,NULL,'2026-03-04 12:39:04','FAILED',NULL,NULL),(56,6,1,NULL,'2026-03-04 12:39:07','FAILED',NULL,NULL),(57,6,2,NULL,'2026-03-04 12:39:10','SUCCESS',NULL,NULL);
/*!40000 ALTER TABLE `security_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `home_country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'alice','alice@test.com','User','2026-03-02 11:10:26','India'),(2,'bob','bob@test.com','Admin','2026-03-02 11:10:26',NULL),(3,'riti40654','riti40654@gmail.com','User','2026-03-04 12:04:52',NULL),(4,'pradhik','pradhik@gmail.com','User','2026-03-04 12:28:28',NULL),(5,'moksha.jain71','moksha.jain71@gmail.com','User','2026-03-04 12:30:28',NULL),(6,'abc','abc@gmail.com','User','2026-03-04 12:39:00',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-04 20:34:53
