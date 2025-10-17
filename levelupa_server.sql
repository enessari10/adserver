/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.8-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: levelupa_server
-- ------------------------------------------------------
-- Server version	11.4.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `levelupa_server`
--


--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `target_url` text DEFAULT NULL,
  `status` enum('active','paused','archived') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `platform` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`campaign_id`),
  CONSTRAINT `fk_ads_campaigns` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
INSERT INTO `ads` (`id`, `campaign_id`, `title`, `image_url`, `target_url`, `status`, `created_at`, `platform`) VALUES (4,3,'LEVELUP_KOTLER','https://levelupagency.com.tr/img/Kotler-O%CC%88du%CC%88l.jpg','https://levelupagency.com.tr/yilin-en-basarili-dijital-pazarlama-ajansi-levelup','active','2025-09-18 11:25:20','WEB');
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `budget` decimal(12,2) DEFAULT 0.00,
  `status` enum('active','paused','archived') DEFAULT 'active',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` (`id`, `name`, `budget`, `status`, `start_date`, `end_date`, `created_at`) VALUES (3,'LEVELUP_WEB',0.00,'active',NULL,NULL,'2025-09-18 11:24:32');
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clicks`
--

DROP TABLE IF EXISTS `clicks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clicks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `request_id` varchar(64) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `referer` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ad_id` (`ad_id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clicks`
--

LOCK TABLES `clicks` WRITE;
/*!40000 ALTER TABLE `clicks` DISABLE KEYS */;
INSERT INTO `clicks` (`id`, `ad_id`, `campaign_id`, `request_id`, `user_agent`, `referer`, `created_at`) VALUES (1,4,3,'3de7bf66-5b63-47e7-8360-a2239eaf26c2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 12:26:08'),
(2,4,3,'e1596c46-0113-4358-8035-e9e9cb94d8c0','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-19 12:26:19'),
(3,4,3,'3de7bf66-5b63-47e7-8360-a2239eaf26c2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 12:26:26'),
(4,4,3,'50083ec0-e60b-4ba4-a4e3-a0c42f9a8a4a','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-19 12:31:25'),
(5,4,3,'44d302ee-f470-4522-86b9-16351108a904','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.3 Safari/605.1.15','https://levelupagency.com.tr/','2025-09-21 07:38:22'),
(6,4,3,'3a9ddf8f-bd5b-4e18-b3f6-c0cfb19c5a39','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-27 10:00:45'),
(7,4,3,'94205e95-9e27-4d58-8edb-fe159ef910d5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:09:45');
/*!40000 ALTER TABLE `clicks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impressions`
--

DROP TABLE IF EXISTS `impressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `impressions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `request_id` varchar(64) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `referer` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ad_id` (`ad_id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impressions`
--

LOCK TABLES `impressions` WRITE;
/*!40000 ALTER TABLE `impressions` DISABLE KEYS */;
INSERT INTO `impressions` (`id`, `ad_id`, `campaign_id`, `request_id`, `user_agent`, `referer`, `created_at`) VALUES (1,4,3,'e7fbee0a-1f39-48d2-acb8-3171710a101f','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-18 11:56:10'),
(2,4,3,'a84fa298-35e7-4630-87cf-ef8eb96deae0','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-18 11:56:32'),
(3,4,3,'e7a2d64d-8cdd-468f-a54b-cb931c1cc4d7','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-18 11:56:52'),
(4,4,3,'9c451b0f-ec2e-446d-9137-af3fd67aa87a','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-18 12:01:42'),
(5,4,3,'309e40ab-0de0-494e-822e-aa5c4157559d','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-18 12:02:10'),
(6,4,3,'e160b274-b09e-4877-b2e5-b3e96966f1f8','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-18 12:02:36'),
(7,4,3,'3992af05-a7f6-4c73-9766-f458ba2d9a61','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-18 12:03:32'),
(8,4,3,'3e40942e-c561-4caa-a43b-9b1ebbf15814','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-18 12:04:10'),
(9,4,3,'f9769b28-1477-450a-b39d-5f8a405d5a30','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-18 12:05:12'),
(10,4,3,'bbb25801-f91e-43af-abaf-de1b21ed45ca','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-18 12:09:41'),
(11,4,3,'c7bc1dc5-01b7-4e98-9fa0-ecf34866ed00','Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22A3354 Instagram 398.0.0.38.81 (iPhone14,5; iOS 18_0; tr_TR; tr; scale=3.00; 1170x2532; IABMV/1; 791504951)','https://levelupagency.com.tr/','2025-09-18 12:27:23'),
(12,4,3,'cb33f0ef-16a7-4ed3-ab87-3592446babc7','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-18 12:33:31'),
(13,4,3,'58d8bb55-4ac7-4bc3-9ecb-9cc57da88a9b','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-18 12:35:54'),
(14,4,3,'303f2a37-1f44-434a-bbc2-72f8ebc6b74e','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-18 13:02:37'),
(15,4,3,'3bcbf5d6-e767-4529-bce0-0cc68e4470d0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-18 14:39:31'),
(16,4,3,'fb29fa4a-1520-4e0c-9866-47ae63c70d08','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-18 14:42:38'),
(17,4,3,'9cc7263a-0d01-45fd-8f34-41d3cffd2ce3','Mozilla/5.0 (iPhone; CPU iPhone OS 15_8_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.6.7 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-18 15:57:35'),
(18,4,3,'27904a24-bd56-4d35-9ea6-090e4e24674c','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-18 18:30:35'),
(19,4,3,'c1d2eccb-646e-4f3c-b524-ce6d808923fa','Mozilla/5.0 (iPhone; CPU iPhone OS 18_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-18 19:08:19'),
(20,4,3,'d98dc8e7-16b4-46c0-81f6-b5b094d576c6','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 07:45:48'),
(21,4,3,'ba0ead52-f7c4-44eb-aae5-3d44530d1f05','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 08:11:27'),
(22,4,3,'0604f419-8536-44b7-b4fc-dec31f9c3cce','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 08:27:19'),
(23,4,3,'cf637b5e-1e4f-4933-bc18-8375ed97e8c5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 08:28:06'),
(24,4,3,'ad02840c-8fdf-4139-b667-56343d2f6399','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 08:29:27'),
(25,4,3,'89b0c492-deeb-4940-8601-c2e551f0f1a0','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-19 10:25:06'),
(26,4,3,'02ac169d-38c5-4185-aa7f-ba892c917444','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 10:27:16'),
(27,4,3,'9b8c7114-f830-409c-b301-cc5e530c1df5','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://www.levelupagency.com.tr/','2025-09-19 11:02:21'),
(28,4,3,'350a4bcf-f295-4b3e-94fa-91a6d5a98826','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-19 12:02:19'),
(29,4,3,'a0b8569a-c8dd-4f98-8884-4013e1742c15','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-19 12:07:00'),
(30,4,3,'acac9b9d-fb08-4168-a505-2786f0374172','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-19 12:13:59'),
(31,4,3,'0be78446-44b5-47b9-b10a-4ff7448ffd4a','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-19 12:24:36'),
(32,4,3,'e1596c46-0113-4358-8035-e9e9cb94d8c0','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-19 12:25:59'),
(33,4,3,'3de7bf66-5b63-47e7-8360-a2239eaf26c2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 12:26:06'),
(34,4,3,'6789b6dd-0128-4a8f-a9f6-ee979d44c8ec','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-19 12:27:36'),
(35,4,3,'47131d8b-72e8-4f39-9809-fa75fa8df7dd','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-19 12:28:50'),
(36,4,3,'13cfd729-422f-4178-a87a-520c25724d23','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-19 12:30:34'),
(37,4,3,'50083ec0-e60b-4ba4-a4e3-a0c42f9a8a4a','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-19 12:31:24'),
(38,4,3,'931777b6-8d8b-44f2-94f2-4aed59f4cbff','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 12:38:16'),
(39,4,3,'bc2e2597-16c7-4152-88e2-01288f965c1e','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-19 12:38:28'),
(40,4,3,'9c84378e-16f4-4014-8b8a-00e1bf4b633a','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-19 12:38:42'),
(41,4,3,'c96c29f9-3ad0-4598-a2b9-b1979313e58f','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-19 13:34:42'),
(42,4,3,'85346b22-8c49-4f64-b1c8-a4de8560306f','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-19 16:11:46'),
(43,4,3,'8904c105-c687-4f66-96af-4f398b58807b','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/28.0 Chrome/130.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-19 18:50:25'),
(44,4,3,'978c6242-4dda-46cc-a13d-fb496726a166','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-20 05:47:18'),
(45,4,3,'d5062b97-f9d5-4e18-9899-ef2c99cdf231','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22G100 Instagram 398.1.0.39.81 (iPhone15,2; iOS 18_6_2; tr_TR; tr; scale=3.00; 1179x2556; IABMV/1; 792780931)','https://levelupagency.com.tr/','2025-09-20 07:09:45'),
(46,4,3,'f639be39-8ba0-42cb-86c6-9e06624fdda6','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A341 Instagram 398.1.0.39.81 (iPhone16,1; iOS 26_0; en_US; en; scale=3.00; 1179x2556; IABMV/1; 792780931)','https://levelupagency.com.tr/','2025-09-20 15:52:19'),
(47,4,3,'61d9f529-0c56-420b-b97b-630ddce8c290','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-20 17:23:09'),
(48,4,3,'172c4f98-2165-4643-8226-a7d4b90e6b83','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-20 19:56:24'),
(49,4,3,'44d302ee-f470-4522-86b9-16351108a904','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.3 Safari/605.1.15','https://levelupagency.com.tr/','2025-09-21 07:38:21'),
(50,4,3,'290c48da-52ee-4d85-b68e-a5edf7706c91','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-21 08:00:33'),
(51,4,3,'1eee9934-4e2a-4ba1-99b1-447c7024cc6f','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-21 08:21:56'),
(52,4,3,'e80a4df9-fe78-4bc3-9e35-e63d195a7dab','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-21 08:33:58'),
(53,4,3,'98f5c98a-1987-401e-87c9-ca361b36cc60','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://www.levelupagency.com.tr/','2025-09-21 09:09:19'),
(54,4,3,'8efefb65-99f4-4a06-8ccb-d531cfb60531','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-21 10:13:31'),
(55,4,3,'136c2602-43f2-487a-a585-d087fa0719db','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-21 10:30:53'),
(56,4,3,'addbd3ca-62c6-48cc-9c6a-4ffab7a42f5d','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-21 10:31:24'),
(57,4,3,'8edd34b8-2a18-46f6-b790-347e416a26f9','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-21 10:44:33'),
(58,4,3,'1dbd016f-2626-4f2c-a087-39797a9695be','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5044.3','https://www.levelupagency.com.tr/','2025-09-21 10:48:45'),
(59,4,3,'9f06ab9f-7778-4447-9cf0-a2dabb9ce7e3','Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22H20 Instagram 398.1.0.39.81 (iPhone17,1; iOS 18_7; tr_TR; tr; scale=3.00; 1206x2622; IABMV/1; 792780931)','https://levelupagency.com.tr/','2025-09-21 11:07:07'),
(60,4,3,'8104b3e1-c86e-427b-84b9-fdea37903cb1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-21 11:51:37'),
(61,4,3,'6696a7f2-4bf9-48ea-a4bf-a2c89f4aaae0','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-21 12:34:00'),
(62,4,3,'cd3112a0-b8b5-43f3-98f9-61ad50ace1a3','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-21 13:14:11'),
(63,4,3,'8309f92a-d697-44a9-8891-4320c972e84b','Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://www.levelupagency.com.tr/','2025-09-21 13:15:43'),
(64,4,3,'5285ce1e-fcc7-4ac2-a292-324223b435dd','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/28.0 Chrome/130.0.0.0 Mobile Safari/537.36','https://www.levelupagency.com.tr/','2025-09-21 14:13:26'),
(65,4,3,'3d714843-4ae1-4c05-9bf9-33c369d7e368','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-21 17:37:53'),
(66,4,3,'cc734565-21bb-428d-98f9-417b0e154eee','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-21 20:08:12'),
(67,4,3,'6c07e4e9-7a64-4fad-bddf-18c4e673f13e','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5044.3','https://www.levelupagency.com.tr/','2025-09-21 20:08:19'),
(68,4,3,'eca72a8d-c3ba-4b0e-8631-e54a2205b39b','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-21 20:08:29'),
(69,4,3,'ab86efb3-f82c-4b32-9664-153382c859b9','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://levelupagency.com.tr/','2025-09-21 20:23:36'),
(70,4,3,'c02e7d8d-d021-40be-977e-e0a5a3b61ccb','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-21 21:24:09'),
(71,4,3,'09b91a95-6c98-4712-9fde-ef0c30c970a2','Mozilla/5.0 (Android 15; Mobile; rv:143.0) Gecko/143.0 Firefox/143.0','https://www.levelupagency.com.tr/','2025-09-21 21:36:55'),
(72,4,3,'4ac63036-a8dc-4b35-ab0e-a4ccd4b121b9','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-21 22:21:23'),
(73,4,3,'f1e4df8b-d87f-4fa9-890a-8b16788ce933','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-22 05:21:37'),
(74,4,3,'3643e591-4cc9-40de-89f1-538a8918bc2c','Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5044.3','https://www.levelupagency.com.tr/','2025-09-22 06:28:08'),
(75,4,3,'26e25408-ec0f-4e13-bef2-35681bbfbf2c','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 07:18:50'),
(76,4,3,'fd638f99-daf0-431b-9402-6ff143c54fae','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-22 08:05:36'),
(77,4,3,'3291b724-0390-42e7-b275-5978eae903d6','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 08:06:47'),
(78,4,3,'abafd999-6c6f-45eb-874e-6f73c18f49d4','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 11:06:44'),
(79,4,3,'41a34649-300d-4b66-bf2e-b0b08cf99b57','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 11:46:04'),
(80,4,3,'c5115d66-0fc0-43c2-a2d4-eb487668d0bc','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 12:55:45'),
(81,4,3,'c7894502-4232-4740-b0f5-06529f3bffb8','Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.7258.127 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-22 14:09:01'),
(82,4,3,'6ede3874-8910-4a7f-903e-cda83b40ae08','Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.7258.127 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-22 14:19:17'),
(83,4,3,'6f84b883-57a7-4f8b-86a0-6c5eaf6d9c99','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 14:22:11'),
(84,4,3,'c6bd4eb4-89a1-4f21-909c-fdcbdd04ccef','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://www.levelupagency.com.tr/','2025-09-22 14:28:55'),
(85,4,3,'1338f583-b993-4c7a-9283-517faa17fac3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 14:41:04'),
(86,4,3,'719bd634-451f-4e66-b4c7-e16446e82ac2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 15:47:51'),
(87,4,3,'cb26657b-7ca5-482e-ad9a-c15edbebe3f0','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-22 16:41:37'),
(88,4,3,'e553424b-4132-4e13-9cc9-aa361d6a075a','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-22 16:54:16'),
(89,4,3,'a51b1112-1259-4529-b310-36c7ce10466e','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 16:54:44'),
(90,4,3,'382c92e5-ff16-47b8-93c8-3111da1d174a','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-22 17:11:01'),
(91,4,3,'b96543f2-2d65-4ee6-987c-9477131cfb3a','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-22 17:43:21'),
(92,4,3,'247b41cc-7348-4531-a06e-b660963c641f','Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.7 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-22 17:55:44'),
(93,4,3,'85bb1d4c-1e79-4e10-aad9-792acf38e731','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 20:22:44'),
(94,4,3,'7bfdcb31-58b3-4d9a-ba8f-263e9f8dbb37','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 20:22:55'),
(95,4,3,'4a0b2b7f-af26-4632-97ba-802dc84c1e5c','Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/17.5 Mobile/15A5370a Safari/602.1','https://levelupagency.com.tr/','2025-09-22 20:35:59'),
(96,4,3,'924c5ab9-c686-461a-8b6b-26d119f506b1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 20:36:22'),
(97,4,3,'991268db-5ff0-4347-b058-66cb022a9da5','Mozilla/5.0 (iPhone; CPU iPhone OS 17_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-22 20:41:22'),
(98,4,3,'8d374cb2-5cc9-467b-972c-9a8dc0f1cf02','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-22 20:52:13'),
(99,4,3,'774b1269-187b-4fdb-be47-33bc1a269e76','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A341 Instagram 398.1.0.39.81 (iPhone15,4; iOS 26_0; tr_TR; tr; scale=3.00; 1179x2556; IABMV/1; 792780931)','https://levelupagency.com.tr/','2025-09-22 21:20:57'),
(100,4,3,'7da154d7-563a-4bb9-bdc1-b3076aad2603','Mozilla/5.0 (Linux; Android 9; GM 8 Build/OPM1.171019.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/138.0.7204.179 Mobile Safari/537.36 Instagram 398.1.0.53.77 Android (28/9; 320dpi; 720x1344; General Mobile/GM; GM 8; GM8_sprout; qcom; en_US; 792875589; IABMV/1)','https://levelupagency.com.tr/','2025-09-22 21:27:20'),
(101,4,3,'1b4e192b-5bad-4c07-87f6-97c6988d04ff','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-22 21:55:52'),
(102,4,3,'fa8b312f-c76c-4e25-9580-9f9555a36ba2','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-22 21:55:58'),
(103,4,3,'dfd06222-56fa-4c07-af1d-107aa65641e2','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-22 21:56:24'),
(104,4,3,'6a7f74ce-2bad-4aa5-896e-8502c502e166','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-22 22:20:30'),
(105,4,3,'07cc80a6-b0b2-4564-927d-88f4ce7c14f7','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 06:26:16'),
(106,4,3,'8c21e353-6608-4b9e-af70-3dac836a7dff','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://www.levelupagency.com.tr/','2025-09-23 06:52:45'),
(107,4,3,'47567155-067f-4cbf-975d-ba97822fe5d2','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-23 06:53:33'),
(108,4,3,'ffbceffc-72f0-437e-9b8a-ba56b17c09cf','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 07:22:30'),
(109,4,3,'de8fbaf3-0bd5-4ad8-85c0-7c24c7d616f6','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0','https://levelupagency.com.tr/','2025-09-23 07:37:28'),
(110,4,3,'d57a98fd-1563-4c3b-a628-f7125a7a1249','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 08:24:02'),
(111,4,3,'38bd5e8b-d610-48de-88db-c82b0faeb0b7','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-23 08:24:47'),
(112,4,3,'9bb3a964-deef-408a-94bc-6aa9c65d22b7','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://www.levelupagency.com.tr/','2025-09-23 08:43:42'),
(113,4,3,'8aaf243e-b056-4cc8-840a-73e8937430a6','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-23 09:18:09'),
(114,4,3,'f0f7d201-99c3-4582-9459-93267de5e665','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-23 09:28:50'),
(115,4,3,'e0c3f46f-d6ab-4f7d-915e-0d346bfcdfda','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-23 10:20:23'),
(116,4,3,'5f6f55f5-c45f-4d8d-a5cf-a0823c5822e0','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 11:08:12'),
(117,4,3,'042a5c7a-7f15-4ef3-a25e-c9516f054dd9','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 11:17:47'),
(118,4,3,'aa5384a0-49ea-4cf4-8b6e-9be45c23fb88','Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.26 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-23 11:18:06'),
(119,4,3,'1a70bba1-9daa-4d14-883e-ce4819297bcb','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/386.3.809454442 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-23 12:18:12'),
(120,4,3,'e38f43e5-0e4d-4970-9a66-db2725ed248c','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0','https://www.levelupagency.com.tr/','2025-09-23 12:47:33'),
(121,4,3,'e3d5816e-d9f3-4e8b-b9d9-b17d19708c6a','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 12:58:37'),
(122,4,3,'9c5e72d5-d0ae-4158-b2ae-032be8ba3cec','Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_11 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-23 13:27:51'),
(123,4,3,'55a944a2-4a06-4b87-92c1-58fbafcc54f0','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-23 13:28:32'),
(124,4,3,'e76f09a8-ab4f-492d-8751-ebfc4ef04092','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-23 14:01:40'),
(125,4,3,'a8203a6a-296d-45e7-9788-84fc85825d03','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-23 14:24:04'),
(126,4,3,'6bb582be-e1fc-46a3-b9e7-3732ff0fe34b','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-23 14:25:42'),
(127,4,3,'bf174433-ba6c-41f5-82bc-bb98be47b180','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-23 14:27:04'),
(128,4,3,'ce3e2c0b-0a0c-4027-831c-a82a3a1a0cd0','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 15:24:42'),
(129,4,3,'7ed5881e-f08c-45ca-9d17-d7ec5eb339db','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-23 15:41:06'),
(130,4,3,'1e15f291-a61e-4ea6-a5c1-4ae07ad6687b','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-23 15:53:34'),
(131,4,3,'35f29080-c8a7-40f9-8291-9d3bf4ae88c2','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-23 16:12:00'),
(132,4,3,'d1088904-97c0-41e8-9b89-24261ae0180b','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 17:18:05'),
(133,4,3,'7c1144d1-c03e-4e53-be0a-276ae802e236','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 17:18:38'),
(134,4,3,'9b18ccb9-7fd7-4d2f-a421-aecc7fa15bf3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 19:33:48'),
(135,4,3,'b86082e9-6690-4e28-99a0-dc04dce4fe5a','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-23 20:31:14'),
(136,4,3,'5c11278d-124b-4a3c-a348-3be1271b75a5','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://levelupagency.com.tr/','2025-09-23 20:33:48'),
(137,4,3,'f7cbbb42-a559-4009-9443-157a24dded19','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-23 20:56:08'),
(138,4,3,'9d68c317-0b84-46c5-b71c-0f2908a47e72','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-23 21:10:10'),
(139,4,3,'7a8ba17f-54aa-4b78-a4e2-c03e65ea52ed','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/386.3.809454442 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-23 22:05:54'),
(140,4,3,'6c98fe06-199b-4c4d-9597-dfbbba36a8e2','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-23 23:21:03'),
(141,4,3,'a41b768d-fa60-4af2-8e5f-0e1b90ebb1f3','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 00:20:37'),
(142,4,3,'e00a8eec-305b-45a0-a142-d9eee91299b6','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-24 06:12:34'),
(143,4,3,'33bfc3db-c747-4242-afe8-a9a9acf8b242','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-24 06:14:26'),
(144,4,3,'f90b8069-d70d-474e-be82-8208b8d2c28b','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 08:54:34'),
(145,4,3,'de4d86c1-27fc-4651-b064-ae140c7192a3','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-24 09:25:27'),
(146,4,3,'af111e15-7382-4c05-9d38-12843ff0a25e','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-24 10:03:22'),
(147,4,3,'12728cf8-70e5-4605-9f55-e4c82c695e45','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 11:51:42'),
(148,4,3,'3d4d0cad-8db9-4d2c-8178-f81a31c23f68','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-24 12:07:05'),
(149,4,3,'c70c9f56-116f-449c-820d-f4f94804967f','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 12:08:48'),
(150,4,3,'3746a140-f57a-42d5-bd13-faf7b44fafc5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-24 12:23:47'),
(151,4,3,'1d7dc58d-c014-4d57-abd4-ff61fc32f7fd','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-24 12:53:31'),
(152,4,3,'348c6c9d-6393-4c83-8f5e-f62690b8ca08','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/386.3.809454442 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 13:02:53'),
(153,4,3,'c2dadc50-d5a6-4a2d-aa13-200cc3ab8ec6','Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 13:11:35'),
(154,4,3,'25009990-1dfc-48e9-801d-ee3f9674eb9c','Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 13:14:02'),
(155,4,3,'c37b512b-0a71-4c3a-97aa-e24ff30ce3e2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-24 13:32:45'),
(156,4,3,'e72b6387-dd05-46e8-90a2-4e5692bccfeb','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-24 15:30:13'),
(157,4,3,'684c5b89-01b5-425a-884e-b3431a69e80d','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-24 16:20:28'),
(158,4,3,'0a5bc3c8-085b-4150-bbd3-9df9621bf52a','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 16:20:45'),
(159,4,3,'b55ec197-babd-4bfe-b641-d0066b3d8e30','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 17:11:54'),
(160,4,3,'72115af0-c742-4172-829c-d88114a88b6b','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 17:16:32'),
(161,4,3,'7c9d26ac-2d0e-4859-b596-e0b3e76ffa25','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://www.levelupagency.com.tr/','2025-09-24 18:08:27'),
(162,4,3,'d841a0e9-0b70-438d-a347-10fdac9d8b04','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-24 19:07:58'),
(163,4,3,'7c18dfde-01b9-4fdc-8842-13e6bd2b59b4','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-24 23:02:59'),
(164,4,3,'af98a1ec-31c9-478e-bb0b-fba775d161e3','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/28.0 Chrome/130.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-25 04:21:16'),
(165,4,3,'8e381098-707f-4692-829e-84fa19874ccc','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-25 06:40:42'),
(166,4,3,'6e6bd392-0846-4f96-9bd1-64834177d91e','GoogleOther','https://levelupagency.com.tr/','2025-09-25 07:20:29'),
(167,4,3,'4557fc00-b300-440b-bad3-7abb44267a1e','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-25 07:49:04'),
(168,4,3,'c114bfe8-8336-4b4a-9d50-ca93be13f757','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 08:54:11'),
(169,4,3,'8c6a16f2-86c8-4c02-a43f-26fb5a6c1ebc','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 09:17:46'),
(170,4,3,'66ecbc03-241d-483c-b1d7-7cb6ffefbf9c','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 09:31:21'),
(171,4,3,'bf5cc5c7-f32d-4e8a-989b-949fdc9aa7e4','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 09:57:08'),
(172,4,3,'be840f4c-2750-43b4-b27b-90169e0b4f93','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 10:38:39'),
(173,4,3,'3f67bcbf-4cb2-45c7-bb54-f5769262693b','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 11:17:07'),
(174,4,3,'fb42424b-0352-41d3-9d00-daceda746e93','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 11:21:42'),
(175,4,3,'b8b8c673-ca4b-49f0-96df-7f8847801bb1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 13:25:04'),
(176,4,3,'96a9464d-18cc-4502-9785-01610bc14f95','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 13:25:39'),
(177,4,3,'0d46833a-422b-433b-afaa-6e66a396575d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://www.levelupagency.com.tr/','2025-09-25 13:35:55'),
(178,4,3,'932c9a1e-1278-49b6-8fd7-728dd1f2920b','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-25 13:38:42'),
(179,4,3,'ca23ca5f-8f70-40f4-aab0-9e13d5023c3d','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0','https://levelupagency.com.tr/','2025-09-25 13:46:30'),
(180,4,3,'a1441d99-1f04-463a-905d-477435748ec2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 13:57:28'),
(181,4,3,'091764a3-5b33-4a49-8c76-ce19638fec73','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 14:03:21'),
(182,4,3,'6e058f2a-a2b8-440f-87d6-c9b73aa7a0cf','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 15:09:30'),
(183,4,3,'36f2ba27-f799-4b9a-b2d5-90ecb6b3dc3d','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-25 15:11:06'),
(184,4,3,'5a8a0115-fd58-4db4-9f19-d0d1a8d69a3a','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-25 15:25:15'),
(185,4,3,'5f2dc352-3ea5-4ee2-a7dc-3b0d55270681','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 15:51:27'),
(186,4,3,'2a968310-c6f2-4117-a0d8-75c85ba6b8ae','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-25 17:41:45'),
(187,4,3,'273b76c7-3267-4e7e-86aa-a688d3fb9409','Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5211','https://www.levelupagency.com.tr/','2025-09-25 17:44:30'),
(188,4,3,'e39ecb5d-df94-45e8-9758-a814bee10daa','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-25 18:27:12'),
(189,4,3,'46d5aefe-1443-4f46-8098-a3355921e139','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 20:02:12'),
(190,4,3,'be3c9532-c895-4f9d-bea8-4e48adfce3c1','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 20:03:44'),
(191,4,3,'6762c7d2-3b23-4b68-b546-3fad6a08d595','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 20:07:18'),
(192,4,3,'ef590b8a-8193-4619-af91-8d9e69f8428a','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 21:02:52'),
(193,4,3,'cde62e56-b01a-4b35-9a05-4ae0270f0f38','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 21:08:32'),
(194,4,3,'0aa1ddd9-ca56-40ee-87ac-ba5494fcd94b','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 21:35:19'),
(195,4,3,'72ecebd6-ec49-47aa-a9bf-79e5af21ba94','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-25 21:56:56'),
(196,4,3,'3ac60b5c-59e1-43e6-8e2b-fffbbba9b212','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-25 23:27:33'),
(197,4,3,'435a9ebb-4d2e-4c8c-aa0f-49ea64510b0f','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 01:01:51'),
(198,4,3,'c1b58c5e-b309-4bde-ac8f-da3c6b695580','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 05:49:58'),
(199,4,3,'fdd201d4-2259-430a-9230-250d0a2ccd16','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 07:00:25'),
(200,4,3,'9abf64ed-cd4e-4a00-85b0-5baf9340423c','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 07:11:44'),
(201,4,3,'54c213d6-75f4-4b9b-9c54-22d7b6a7f80d','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 07:19:55'),
(202,4,3,'12566134-99b4-4a37-a5d3-8f96596ca3be','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 07:34:13'),
(203,4,3,'cba7dc2c-d5e3-4251-8eb9-c03ebd0c00f5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 07:57:54'),
(204,4,3,'765f0abb-5d08-4841-a3c1-b87e2f273f36','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/387.1.809473243 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 08:03:45'),
(205,4,3,'1d336dd3-1099-4ee1-8a6e-ccb566407f25','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/387.1.809473243 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 08:03:48'),
(206,4,3,'466c821a-e317-4693-abba-861af58b7a45','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 08:27:54'),
(207,4,3,'d3ba2d82-be61-4922-b9f3-174169037281','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 08:29:13'),
(208,4,3,'d6fd3180-6a4d-4928-9797-0374969d5400','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 08:52:28'),
(209,4,3,'816acc11-d9b0-437e-9d5a-04818ab5506c','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 08:52:32'),
(210,4,3,'a8c74578-0a5f-476e-9b64-e3799e77c705','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 09:49:21'),
(211,4,3,'a9e9925e-9920-43b4-8359-407b5f0d9e46','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 11:13:23'),
(212,4,3,'0e3e7aad-1e82-47c6-a8ea-be4b095fd6ec','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 11:27:08'),
(213,4,3,'f96223ce-9284-4ee5-b983-ce9c248041c0','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 11:27:41'),
(214,4,3,'a5af0832-a1c2-46fb-8414-5f5f133f8947','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 11:45:34'),
(215,4,3,'d43f0869-96f6-40da-b7ff-e20ef584b24d','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 12:23:45'),
(216,4,3,'1a016b46-144a-45d4-9d89-03f8cc9ff529','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 12:32:22'),
(217,4,3,'46d20d2d-f7e4-41c4-814f-0a6de8191ba6','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 12:34:10'),
(218,4,3,'308ea5d2-0ca0-4793-b5c4-4296ec07f40a','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 12:53:05'),
(219,4,3,'30224540-fe32-430b-801d-8b6de6b84e0f','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 13:59:57'),
(220,4,3,'b270e973-7420-4f39-abdb-4dac7b17ae4c','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 14:17:53'),
(221,4,3,'d8332d08-83ea-49d9-ab1c-b54278338d99','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 15:53:31'),
(222,4,3,'e119501e-d458-4b48-b1ac-4162585294e1','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/371.0.763199552 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 16:17:19'),
(223,4,3,'93a487be-d48f-428c-b2d2-e0ee2f05e5e2','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 17:00:34'),
(224,4,3,'0f5574b3-195e-42e4-87f6-3b59b96e3435','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 17:17:10'),
(225,4,3,'74cdd0c7-986d-4a0a-98c7-25b949b0f573','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 18:29:57'),
(226,4,3,'32e7652b-7612-4440-b959-18350d922874','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-26 19:09:13'),
(227,4,3,'3c814475-aaad-41e6-aa96-c4c0804b8b1e','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-26 20:20:36'),
(228,4,3,'3eca8c62-1321-4bd6-aa8e-5f30c72bcfb8','Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/373.1.772062114 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 20:29:18'),
(229,4,3,'21edfad3-cda7-4267-8a2e-48f008a9068a','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/387.1.809473243 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-26 20:30:23'),
(230,4,3,'3af1879f-304b-468f-bb58-ed4668013910','Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22D63 Instagram 399.0.0.34.84 (iPhone12,1; iOS 18_3; tr_TR; tr; scale=2.00; 828x1792; IABMV/1; 795719514)','https://levelupagency.com.tr/','2025-09-27 01:08:29'),
(231,4,3,'5523bbd7-66cd-4fa2-a13c-883bf807fdf0','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 03:19:06'),
(232,4,3,'b7d096ab-cdd3-4de4-9606-e181fb647b2e','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-27 07:12:10'),
(233,4,3,'87699286-7d20-42af-a314-ede3e2fb1709','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-27 07:54:26'),
(234,4,3,'2ddec449-ce30-43e7-87a6-4d33a314e3d4','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-27 08:27:31'),
(235,4,3,'c8a228c2-9adf-4989-b035-067396f57eb2','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-27 09:05:29'),
(236,4,3,'1dbb19e5-7ec0-460b-81b9-acef0dd26806','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 09:08:30'),
(237,4,3,'3a9ddf8f-bd5b-4e18-b3f6-c0cfb19c5a39','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-27 09:33:03'),
(238,4,3,'1371c4c2-07f7-46d6-b707-a3c61225bb16','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 10:55:50'),
(239,4,3,'0ab4ef33-42d8-44e9-b497-89e25fdb39d2','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-27 11:37:00'),
(240,4,3,'d1c5e4a4-eac4-4286-b44d-49fc851db077','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 12:02:19'),
(241,4,3,'cbe0d554-f8d7-47dd-9224-e46d25c159ec','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 12:09:07'),
(242,4,3,'bdb87970-b904-4884-8eb2-b731e57fba08','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-27 12:12:20'),
(243,4,3,'83a4bfc3-3c08-4764-acdc-ca32e1e14d40','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-27 12:13:58'),
(244,4,3,'baa1704c-8e9a-45d4-95a3-7847d5052fea','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/28.0 Chrome/130.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 15:42:42'),
(245,4,3,'a702d19d-a550-4fa5-b52f-e14139a6c4c3','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/387.1.809473243 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-27 15:55:02'),
(246,4,3,'9581229a-5149-4a42-982c-c59e53d6cde5','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 15:59:01'),
(247,4,3,'82c6fbc6-2e23-4c0e-88f3-530a0e5e7f61','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-27 17:19:27'),
(248,4,3,'b75aff46-ee10-4c29-bd58-283a07bf1f72','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 17:31:12'),
(249,4,3,'fe34413c-7bef-40bb-b4ce-b59989a1523e','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-27 17:38:01'),
(250,4,3,'8590237a-703d-40f5-9b72-fe59ace91f1b','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]/9.31.5267','https://www.levelupagency.com.tr/','2025-09-27 17:40:59'),
(251,4,3,'831499c1-f1a4-4767-933d-b810d7bc3573','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 17:51:39'),
(252,4,3,'e28e9648-76e7-44ad-b895-acc5aae78892','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 18:03:16'),
(253,4,3,'6eb0fa37-4120-4204-972b-2f8851b1e717','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 22:11:02'),
(254,4,3,'554ffb4a-8dff-4411-9b88-739dd6eae9e0','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 22:14:07'),
(255,4,3,'4049c45b-183f-4ee1-8ecd-60c14ab922bd','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-27 22:47:01'),
(256,4,3,'4e55563a-c698-407e-bcfd-1ee29446a15d','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-28 06:11:08'),
(257,4,3,'2960603c-55e8-4cfa-95ca-3af56953b853','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-28 06:50:13'),
(258,4,3,'46ac90e1-0134-4f5e-a620-e301586c83ba','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 07:41:18'),
(259,4,3,'970a1af7-5057-4ea3-a35d-52caf6e8ab82','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-28 09:56:50'),
(260,4,3,'dc359ecb-1d1c-48de-88ac-df38e26bd94e','Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/386.3.809454442 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 10:06:21'),
(261,4,3,'764b5265-b5f0-4a49-a913-3897957fd3fe','Mozilla/5.0 (iPhone; CPU iPhone OS 17_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 10:39:18'),
(262,4,3,'4434f705-38a2-4133-9329-d714324679f3','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 12:15:36'),
(263,4,3,'5481c435-24ab-4d6d-9a3b-2d6e1a2329b1','Mozilla/5.0 (iPhone; CPU iPhone OS 18_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 12:57:00'),
(264,4,3,'ca940bff-761f-4292-a2aa-5de59b280dd9','Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22H20 Instagram 399.0.0.34.84 (iPhone11,8; iOS 18_7; tr_TR; tr; scale=2.00; 828x1792; IABMV/1; 795719514)','https://levelupagency.com.tr/','2025-09-28 13:28:33'),
(265,4,3,'0993e920-bf33-4c43-93eb-b1b46528824d','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-28 15:14:25'),
(266,4,3,'e9bf40ba-8613-4fde-bcbc-4ee4814d62fd','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-28 15:38:57'),
(267,4,3,'48cff4df-7987-4ddf-ba7d-da86952167db','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-28 16:03:31'),
(268,4,3,'e90c1771-8284-4aec-bf93-38b2ee3b70b3','GoogleOther','https://levelupagency.com.tr/','2025-09-28 16:39:32'),
(269,4,3,'85fc811c-1aa2-4f28-9c6f-92afabf53f95','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-28 16:45:05'),
(270,4,3,'5baa5743-39cb-4eb2-91ee-e8648aaa12be','Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/387.1.809473243 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 17:53:42'),
(271,4,3,'2ac48ada-406b-4cea-8e0b-a9f36251b9f1','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 19:11:32'),
(272,4,3,'917e8420-b815-48ca-845f-f594559c4916','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 19:11:57'),
(273,4,3,'beef3789-fa0c-4d4c-b0c8-9b0fe3e96847','Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/387.1.809473243 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 19:12:37'),
(274,4,3,'eaf41475-dd50-47e6-85a2-f150f88ad2c0','Mozilla/5.0 (iPhone; CPU iPhone OS 18_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/387.1.809473243 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 19:48:16'),
(275,4,3,'0fd735dd-5cf7-4371-881d-755e77ae47ed','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-28 19:56:57'),
(276,4,3,'bc3bb713-cf4f-49fe-8676-dcba6edea4ac','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/140.0.7339.122 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 20:50:36'),
(277,4,3,'f1107f1d-769a-4537-bb99-4436e7155552','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-28 20:56:57'),
(278,4,3,'f04d77f2-acc9-4a61-b3fa-5e2ca897d1c6','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-28 21:30:06'),
(279,4,3,'888226c4-f527-4ce2-ac75-d6572a8908e7','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-28 21:46:47'),
(280,4,3,'8ea8d9bf-c48b-492e-a4c6-c0b9cac3bdab','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 06:18:37'),
(281,4,3,'da32cad6-1297-4d82-8f49-40d4d89a9bda','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 06:32:09'),
(282,4,3,'7eff86a9-ab64-4290-abb0-c22620af4517','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 06:38:43'),
(283,4,3,'f0b00812-725c-4a68-b2b7-53f4dab5367f','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 08:43:08'),
(284,4,3,'611aa27a-ad47-4b50-a891-68c90ac3f5b0','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 08:51:07'),
(285,4,3,'a7d49589-9489-4daa-b87b-44b82678ab58','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 09:04:30'),
(286,4,3,'ee2d64e2-aa61-491f-b793-6be4f8394547','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 09:18:24'),
(287,4,3,'e8fdcd22-4c85-48ac-b47e-f8fe436077de','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Safari/605.1.15','https://levelupagency.com.tr/','2025-09-29 10:04:37'),
(288,4,3,'bbbb95f1-eda3-4c09-905a-84f2c6e9558a','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:06:55'),
(289,4,3,'c88ad1cc-9c81-4192-9bcd-d26dcd0d5095','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:07:58'),
(290,4,3,'94205e95-9e27-4d58-8edb-fe159ef910d5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:08:56'),
(291,4,3,'e2d94706-4220-4298-8621-22895f467736','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:09:59'),
(292,4,3,'f57eb7f1-5605-4c10-86dc-09682c92b12d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:11:33'),
(293,4,3,'792797fd-95fa-4bb0-b282-98661017cb7b','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:14:14'),
(294,4,3,'05a53366-ae64-4da4-80bc-9f2660f858a9','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:18:25'),
(295,4,3,'c01f3ed9-508d-40b6-b7ba-509e17f6719b','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 10:30:00'),
(296,4,3,'4b1862e5-508f-47b3-9e01-edb9586ed85b','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','https://levelupagency.com.tr/','2025-09-29 11:22:10'),
(297,4,3,'365b014d-d52f-4c5c-bd4b-70eac06bf457','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 11:48:27'),
(298,4,3,'dd69d8ee-1e00-4f89-b349-53a2ab2492bf','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 11:50:46'),
(299,4,3,'5b5ebff0-9ab5-4bdf-a3da-15cef4400a5c','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 12:37:13'),
(300,4,3,'979f5ecb-bba6-4f5c-8541-10e733a17ed0','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 12:47:31'),
(301,4,3,'1e55be92-03da-4fd9-b0a6-d8ef9b09026d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 12:52:12'),
(302,4,3,'dc17566b-7a45-42c5-90e4-ff8f70ca427d','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0','https://levelupagency.com.tr/','2025-09-29 13:05:19'),
(303,4,3,'4e67f598-f664-4cb6-81d4-afb7fb0a0da8','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 13:18:17'),
(304,4,3,'eae297dc-2071-4f20-98b7-31646b21a4c1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','https://levelupagency.com.tr/','2025-09-29 13:40:26'),
(305,4,3,'ce271344-42cb-4639-b7ee-e1b9346def51','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15','https://levelupagency.com.tr/','2025-09-29 13:49:18');
/*!40000 ALTER TABLE `impressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `email`, `password_hash`, `name`, `role`, `created_at`) VALUES (2,'info@levelup.email','$2a$10$txfuHMXVKkQQIraalAoXXOmCjC9IVSCdDzyjM4G5xzZJdgCCS.nN.a','Admin','Admin','2025-09-18 08:10:21'),
(3,'enes.sari@levelup.email','$2a$10$e5TmhzEXc/kId95.pdWE/e8zIwhJzMNjFOfYU07ELqpapcCdvBqOK','Enes Sari','admin','2025-09-18 11:23:20');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'levelupa_server'
--

--
-- Dumping routines for database 'levelupa_server'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-10-17  9:27:23
