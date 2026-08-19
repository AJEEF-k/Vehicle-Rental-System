CREATE DATABASE  IF NOT EXISTS `vehicle_rental_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vehicle_rental_system`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: vehicle_rental_system
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
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `vehicle_id` int NOT NULL AUTO_INCREMENT,
  `vendor_id` int NOT NULL,
  `registration_number` varchar(20) NOT NULL,
  `vehicle_name` varchar(100) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `category` enum('Scooter','Bike') NOT NULL,
  `hourly_rate` int NOT NULL,
  `daily_rate` int NOT NULL,
  `battery_range` int NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `operational_status` enum('Available','Maintenance','Inactive') NOT NULL DEFAULT 'Available',
  PRIMARY KEY (`vehicle_id`),
  UNIQUE KEY `registration_number` (`registration_number`),
  KEY `idx_vehicle_vendor` (`vendor_id`),
  KEY `idx_vehicle_category` (`category`),
  KEY `idx_vehicle_status` (`operational_status`),
  CONSTRAINT `fk_vehicle_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `vehicles_chk_1` CHECK ((`hourly_rate` > 0)),
  CONSTRAINT `vehicles_chk_2` CHECK ((`daily_rate` > 0)),
  CONSTRAINT `vehicles_chk_3` CHECK ((`battery_range` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-19 19:13:48
