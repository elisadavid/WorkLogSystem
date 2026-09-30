CREATE DATABASE  IF NOT EXISTS `trainee_worklog_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `trainee_worklog_db`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: trainee_worklog_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `addworklog`
--

DROP TABLE IF EXISTS `addworklog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addworklog` (
  `logId` int NOT NULL AUTO_INCREMENT,
  `traineeId` varchar(10) NOT NULL,
  `logDate` date NOT NULL,
  `projectName` varchar(150) NOT NULL,
  `taskCategory` varchar(100) DEFAULT NULL,
  `taskStatus` varchar(100) DEFAULT NULL,
  `taskDescription` text NOT NULL,
  `hoursWorked` decimal(4,2) NOT NULL,
  `issue` text,
  `filePath` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`logId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addworklog`
--

LOCK TABLES `addworklog` WRITE;
/*!40000 ALTER TABLE `addworklog` DISABLE KEYS */;
INSERT INTO `addworklog` VALUES (1,'T-7901','2026-05-12','sadsfdger','Meeting','In Progress','esrfgtrhbg',1.00,'',NULL,'2026-05-12 10:47:11'),(2,'T-7901','2026-05-12','sadsfdger','Meeting','In Progress','esrfgtrhbg',1.00,'',NULL,'2026-05-12 11:13:04'),(3,'T-7232','2026-05-12','sadsfdger','Testing','In Progress','esrfgtrhbg',1.00,'',NULL,'2026-05-13 06:52:56');
/*!40000 ALTER TABLE `addworklog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designation`
--

DROP TABLE IF EXISTS `designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `designation` (
  `designationId` int NOT NULL AUTO_INCREMENT,
  `designation` varchar(100) NOT NULL,
  PRIMARY KEY (`designationId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designation`
--

LOCK TABLES `designation` WRITE;
/*!40000 ALTER TABLE `designation` DISABLE KEYS */;
INSERT INTO `designation` VALUES (1,'Graduate Apprentice'),(2,'Technician Apprentice'),(3,'Trade');
/*!40000 ALTER TABLE `designation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor_performance`
--

DROP TABLE IF EXISTS `mentor_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentor_performance` (
  `performance_id` int NOT NULL AUTO_INCREMENT,
  `report_id` int NOT NULL,
  `trainee_id` varchar(30) NOT NULL,
  `mentor_id` varchar(30) NOT NULL,
  `performance_rating` varchar(30) DEFAULT NULL,
  `mentor_remark` text,
  `recommendation` varchar(30) DEFAULT NULL,
  `evaluated_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`performance_id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `mentor_performance_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `monthly_report` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor_performance`
--

LOCK TABLES `mentor_performance` WRITE;
/*!40000 ALTER TABLE `mentor_performance` DISABLE KEYS */;
/*!40000 ALTER TABLE `mentor_performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentordesignation`
--

DROP TABLE IF EXISTS `mentordesignation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentordesignation` (
  `mentordesignationId` int NOT NULL AUTO_INCREMENT,
  `mentordesignation` varchar(25) NOT NULL,
  PRIMARY KEY (`mentordesignationId`),
  UNIQUE KEY `mentordesignation` (`mentordesignation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentordesignation`
--

LOCK TABLES `mentordesignation` WRITE;
/*!40000 ALTER TABLE `mentordesignation` DISABLE KEYS */;
INSERT INTO `mentordesignation` VALUES (2,'ASSISTANT '),(3,'PERS.SECRY '),(1,'SCI/ENG');
/*!40000 ALTER TABLE `mentordesignation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthly_report`
--

DROP TABLE IF EXISTS `monthly_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monthly_report` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `trainee_id` varchar(30) NOT NULL,
  `trainee_name` varchar(100) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `report_month` varchar(20) NOT NULL,
  `work_done` text,
  `cl_balance` int DEFAULT '0',
  `scl_balance` int DEFAULT '0',
  `ml_balance` int DEFAULT '0',
  `eol_balance` int DEFAULT '0',
  `report_status` varchar(20) DEFAULT 'PENDING',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthly_report`
--

LOCK TABLES `monthly_report` WRITE;
/*!40000 ALTER TABLE `monthly_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `monthly_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthlyreport`
--

DROP TABLE IF EXISTS `monthlyreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monthlyreport` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `trainee_id` varchar(50) DEFAULT NULL,
  `trainee_name` varchar(100) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `report_month` varchar(30) DEFAULT NULL,
  `report_date` varchar(30) DEFAULT NULL,
  `work_done` text,
  `cl_from` date DEFAULT NULL,
  `cl_to` date DEFAULT NULL,
  `cl_days` int DEFAULT NULL,
  `cl_balance` int DEFAULT NULL,
  `scl_from` date DEFAULT NULL,
  `scl_to` date DEFAULT NULL,
  `scl_days` int DEFAULT NULL,
  `scl_balance` int DEFAULT NULL,
  `ml_from` date DEFAULT NULL,
  `ml_to` date DEFAULT NULL,
  `ml_days` int DEFAULT NULL,
  `ml_balance` int DEFAULT NULL,
  `eol_from` date DEFAULT NULL,
  `eol_to` date DEFAULT NULL,
  `eol_days` int DEFAULT NULL,
  `eol_balance` int DEFAULT NULL,
  `mentor_name` varchar(100) DEFAULT NULL,
  `mentor_designation` varchar(100) DEFAULT NULL,
  `mentor_phone` varchar(20) DEFAULT NULL,
  `aptitude` varchar(50) DEFAULT NULL,
  `performance` varchar(50) DEFAULT NULL,
  `shortcomings` text,
  `reaction` varchar(50) DEFAULT NULL,
  `conduct` varchar(50) DEFAULT NULL,
  `remarks` text,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthlyreport`
--

LOCK TABLES `monthlyreport` WRITE;
/*!40000 ALTER TABLE `monthlyreport` DISABLE KEYS */;
INSERT INTO `monthlyreport` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,0,0,NULL,NULL,0,0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PENDING_MENTOR'),(2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,0,0,NULL,NULL,0,0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PENDING_MENTOR');
/*!40000 ALTER TABLE `monthlyreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration` (
  `mentor_id` int NOT NULL AUTO_INCREMENT,
  `staff_code` varchar(10) NOT NULL,
  `full_name` varchar(250) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `department` varchar(10) NOT NULL,
  `mentor_designation` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mentor_id`),
  UNIQUE KEY `staff_code` (`staff_code`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (1,'VS22111','Elisa David','elisa123@gmail.com','Elisa_1234','9876543576','COM','1','2026-05-12 09:36:42');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Trainee'),(2,'Mentor'),(3,'Division Head');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskstatus`
--

DROP TABLE IF EXISTS `taskstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskstatus` (
  `statusId` int NOT NULL AUTO_INCREMENT,
  `statusName` varchar(30) NOT NULL,
  PRIMARY KEY (`statusId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskstatus`
--

LOCK TABLES `taskstatus` WRITE;
/*!40000 ALTER TABLE `taskstatus` DISABLE KEYS */;
INSERT INTO `taskstatus` VALUES (1,'PENDING'),(2,'ON-PROGRESS'),(3,'COMPLETED');
/*!40000 ALTER TABLE `taskstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainee_leave_details`
--

DROP TABLE IF EXISTS `trainee_leave_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainee_leave_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trainee_id` varchar(50) NOT NULL,
  `month` varchar(30) NOT NULL,
  `leave_from` date NOT NULL,
  `leave_to` date NOT NULL,
  `leave_type` varchar(50) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'PENDING',
  `mentor_remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainee_leave_details`
--

LOCK TABLES `trainee_leave_details` WRITE;
/*!40000 ALTER TABLE `trainee_leave_details` DISABLE KEYS */;
INSERT INTO `trainee_leave_details` VALUES (1,'T-7901','June','2026-06-09','2026-06-10','Casual Leave','test','APPROVED','test'),(2,'T-7901','June','2026-06-18','2026-06-23','Medical Leave','hospital','APPROVED',''),(3,'T-7901','June','2026-06-25','2026-06-26','Casual Leave','t','APPROVED',''),(4,'T-7901','June','2026-06-22','2026-06-30','Medical Leave','s','REJECTED',''),(5,'T-7901','June','2026-06-17','2026-06-17','Special Leave','test','PENDING',NULL);
/*!40000 ALTER TABLE `trainee_leave_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traineeidetails`
--

DROP TABLE IF EXISTS `traineeidetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traineeidetails` (
  `traineeId` varchar(20) NOT NULL,
  `traineeName` varchar(50) NOT NULL,
  `emailId` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(10) NOT NULL,
  `designationId` int DEFAULT NULL,
  `division` varchar(50) DEFAULT NULL,
  `phonenumber` varchar(10) DEFAULT NULL,
  `joiningdate` date DEFAULT NULL,
  `assignedBy` varchar(45) DEFAULT NULL,
  `entryOn` date DEFAULT NULL,
  PRIMARY KEY (`traineeId`),
  UNIQUE KEY `emailId` (`emailId`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traineeidetails`
--

LOCK TABLES `traineeidetails` WRITE;
/*!40000 ALTER TABLE `traineeidetails` DISABLE KEYS */;
INSERT INTO `traineeidetails` VALUES ('T-7232','Elisa','test@gmail.com','test','1234',1,'CSD','4567990543','2026-05-12','VS22111','2026-05-12'),('T-7901','Geethu','geethu@gmail.com','geethuu','geethu_123',2,'Com','2345476869','2026-05-12','VS22111','2026-05-12'),('T-7904','Areena','areena@gmail.com','areenaa','areena123',1,'citg','6789543788','2026-05-12','VS22111','2026-05-12');
/*!40000 ALTER TABLE `traineeidetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traineeworkdetails`
--

DROP TABLE IF EXISTS `traineeworkdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traineeworkdetails` (
  `workId` int NOT NULL AUTO_INCREMENT,
  `traineeId` varchar(50) NOT NULL,
  `taskCategory` varchar(100) NOT NULL,
  `taskDesc` text,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `statusId` int NOT NULL,
  PRIMARY KEY (`workId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traineeworkdetails`
--

LOCK TABLES `traineeworkdetails` WRITE;
/*!40000 ALTER TABLE `traineeworkdetails` DISABLE KEYS */;
INSERT INTO `traineeworkdetails` VALUES (1,'T-7232','Development','sdgvfrtrd','2026-05-14','2026-05-15',2),(2,'T-7901','Documentation','SACszxdv','2026-05-14','2026-05-22',2),(3,'T-7904','Meeting','drgerg','2026-05-14','2026-05-15',2);
/*!40000 ALTER TABLE `traineeworkdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-09 23:07:16
