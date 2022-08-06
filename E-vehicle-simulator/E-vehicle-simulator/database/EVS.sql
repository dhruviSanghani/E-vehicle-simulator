-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: evs
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `BookingID` int NOT NULL AUTO_INCREMENT,
  `EVLiveInfoID` int NOT NULL,
  `DropOffKms` int NOT NULL,
  `UserID` int NOT NULL,
  `BookingTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `DropOffTime` datetime DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `FKUserID_idx` (`UserID`),
  CONSTRAINT `FKEYUserID` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chargingstation`
--

DROP TABLE IF EXISTS `chargingstation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chargingstation` (
  `ChargingStationID` int NOT NULL AUTO_INCREMENT,
  `ChargingTypeID` int NOT NULL,
  `NumberOfSlots` int NOT NULL,
  `PowerSource` varchar(45) DEFAULT NULL,
  `Latitude` double NOT NULL,
  `Longitude` double NOT NULL,
  PRIMARY KEY (`ChargingStationID`),
  KEY `FKEYChargingTypeID_idx` (`ChargingTypeID`),
  CONSTRAINT `FKEYChargingTypeID` FOREIGN KEY (`ChargingTypeID`) REFERENCES `chargingtype` (`ChargingTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chargingstation`
--

LOCK TABLES `chargingstation` WRITE;
/*!40000 ALTER TABLE `chargingstation` DISABLE KEYS */;
/*!40000 ALTER TABLE `chargingstation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chargingtype`
--

DROP TABLE IF EXISTS `chargingtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chargingtype` (
  `ChargingTypeID` int NOT NULL AUTO_INCREMENT,
  `ChargingType` varchar(45) NOT NULL,
  `Volts` varchar(45) NOT NULL,
  PRIMARY KEY (`ChargingTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chargingtype`
--

LOCK TABLES `chargingtype` WRITE;
/*!40000 ALTER TABLE `chargingtype` DISABLE KEYS */;
INSERT INTO `chargingtype` VALUES (1,'ccs_combo_type2','250'),(2,'ccs_combo_type1','150'),(3,'Tesla','350');
/*!40000 ALTER TABLE `chargingtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evbrands`
--

DROP TABLE IF EXISTS `evbrands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evbrands` (
  `EVBrandID` int NOT NULL AUTO_INCREMENT,
  `EVBrandName` varchar(45) NOT NULL,
  PRIMARY KEY (`EVBrandID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evbrands`
--

LOCK TABLES `evbrands` WRITE;
/*!40000 ALTER TABLE `evbrands` DISABLE KEYS */;
INSERT INTO `evbrands` VALUES (1,'Tesla'),(2,'Hyundai'),(3,'BMW'),(4,'Audi'),(5,'Volkswagen'),(6,'Volvo'),(7,'Nissan'),(8,'Honda'),(9,'Ford');
/*!40000 ALTER TABLE `evbrands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evcar`
--

DROP TABLE IF EXISTS `evcar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evcar` (
  `CarId` int NOT NULL AUTO_INCREMENT,
  `CarModelName` varchar(45) NOT NULL,
  `CarModelNo` varchar(45) NOT NULL,
  `CarCompany` varchar(45) NOT NULL,
  `EvBrandID` int DEFAULT NULL,
  `MaxCharge` double NOT NULL,
  `ChargingTypeID` int NOT NULL,
  `EnergyConsumption` varchar(45) DEFAULT NULL,
  `ChargingCurve` varchar(45) NOT NULL,
  `HasAutoPilot` tinyint DEFAULT '0',
  `AutoShift` tinyint DEFAULT '0',
  `PeakPower` varchar(45) DEFAULT NULL,
  `TopSpeed` double DEFAULT NULL,
  `RangeOnFullCharge` int DEFAULT NULL,
  `FullChargingTimeForFastCharger` time DEFAULT NULL,
  `FullChargingTimeForTurboCharger` time DEFAULT NULL,
  PRIMARY KEY (`CarId`),
  KEY `FKEYChargingTypeID_idx_idx` (`ChargingTypeID`),
  KEY `FKEYEVBranchID_idx_idx` (`EvBrandID`),
  CONSTRAINT `FKEYChargingTypeID_idx` FOREIGN KEY (`ChargingTypeID`) REFERENCES `chargingtype` (`ChargingTypeID`),
  CONSTRAINT `FKEYEVBranchID_idx` FOREIGN KEY (`EvBrandID`) REFERENCES `evbrands` (`EVBrandID`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evcar`
--

LOCK TABLES `evcar` WRITE;
/*!40000 ALTER TABLE `evcar` DISABLE KEYS */;
INSERT INTO `evcar` VALUES (100,'Tesla Y','TY','Tesla',1,250000,3,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(101,'Hyundai Ioniq','Ioniq 5','Hyundai',2,70000,1,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(102,'Kia','K3','Hyundai',2,80000,1,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(103,'BMQ IX','xDrive 50','BMW',3,196000,1,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(104,'Audi e-tron','50 Quattro','Audi',4,120000,1,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(105,'Volkswagen E-Golf','VW MQB EG','Volkswagen',5,40000,3,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(106,'Volvo XC','XC 40','Volvo',6,133000,1,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(107,'Nissan Leaf','2022','Nissan',7,46000,1,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(108,'Honda E-Advance','HE','Honda',8,56000,1,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL),(109,'Ford Mustang','Mach-E SR RWD','Ford',9,109000,1,'20,160','40000,70000',0,0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `evcar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evliveinfo`
--

DROP TABLE IF EXISTS `evliveinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evliveinfo` (
  `EVLiveInfoID` int NOT NULL AUTO_INCREMENT,
  `CarId` int NOT NULL,
  `CurrentRunningKms` int DEFAULT NULL,
  `CurrentBatteryPercentage` float DEFAULT NULL,
  `SourceLongitude` double DEFAULT NULL,
  `SourceLatitude` double DEFAULT NULL,
  `IsAllocated` tinyint DEFAULT NULL,
  `BatteryPercentageAtDestination` float DEFAULT NULL,
  `DestinationLatitude` double DEFAULT NULL,
  `DestinationLongitude` double DEFAULT NULL,
  PRIMARY KEY (`EVLiveInfoID`),
  UNIQUE KEY `DestinationLongitude_UNIQUE` (`DestinationLongitude`),
  KEY `FKEYEVMODELID_idx_idx` (`CarId`),
  CONSTRAINT `FKEYEVMODEL_idx` FOREIGN KEY (`CarId`) REFERENCES `evcar` (`CarId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evliveinfo`
--

LOCK TABLES `evliveinfo` WRITE;
/*!40000 ALTER TABLE `evliveinfo` DISABLE KEYS */;
INSERT INTO `evliveinfo` VALUES (1,100,NULL,50,-81.214418,43.04263,NULL,46,42.990018,-81.250306),(2,101,NULL,43,-81.223853,42.936349,NULL,39,43.017922,-81.214593),(3,102,NULL,85,-81.255172,43.034952,NULL,83,42.959033,-81.235184),(4,103,NULL,68,-81.214418,43.012817,NULL,61,-81.199929,-81.279478),(5,104,NULL,76,-81.288593,43.038038,NULL,73,43.005131,-81.174015),(6,105,NULL,32,-81.223758,42.958621,NULL,30,42.984434,-81.229931),(7,106,NULL,23,-81.281606,43.025071,NULL,20,42.983343,-81.254411),(8,107,NULL,89,-81.214981,42.980507,NULL,82,42.942299,-81.398029),(9,108,NULL,44,-81.235184,42.959033,NULL,39,42.947609,-81.281203),(10,109,NULL,52,-81.235184,42.959033,NULL,49,42.983012,-81.234849);
/*!40000 ALTER TABLE `evliveinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `PaymentTypeID` int NOT NULL,
  `BookingID` int NOT NULL,
  `Amount` int NOT NULL,
  `PaymentTime` datetime DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `FKEYPaymentTypeID_idx` (`PaymentTypeID`),
  KEY `FKEYBookingID_idx` (`BookingID`),
  CONSTRAINT `FKEYBookingID` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`),
  CONSTRAINT `FKEYPaymentTypeID` FOREIGN KEY (`PaymentTypeID`) REFERENCES `paymenttype` (`PaymentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymenttype`
--

DROP TABLE IF EXISTS `paymenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymenttype` (
  `PaymentTypeID` int NOT NULL AUTO_INCREMENT,
  `PaymentTypeName` varchar(45) NOT NULL,
  PRIMARY KEY (`PaymentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymenttype`
--

LOCK TABLES `paymenttype` WRITE;
/*!40000 ALTER TABLE `paymenttype` DISABLE KEYS */;
/*!40000 ALTER TABLE `paymenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(45) NOT NULL,
  `UserTypeID` int NOT NULL,
  `Password` varchar(55) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `Phone` text NOT NULL,
  `Email` varchar(45) NOT NULL,
  PRIMARY KEY (`UserID`),
  KEY `FKEY_UserTypeID_idx` (`UserTypeID`),
  CONSTRAINT `FKEY_UserTypeID` FOREIGN KEY (`UserTypeID`) REFERENCES `usertype` (`UserTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',1,'admin','Administrator','1111111111','admin@evs.ca');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usertype` (
  `UserTypeID` int NOT NULL AUTO_INCREMENT,
  `UserTypeName` varchar(45) NOT NULL,
  PRIMARY KEY (`UserTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertype`
--

LOCK TABLES `usertype` WRITE;
/*!40000 ALTER TABLE `usertype` DISABLE KEYS */;
INSERT INTO `usertype` VALUES (1,'Admin'),(2,'Operator'),(3,'Rider');
/*!40000 ALTER TABLE `usertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'evs'
--

--
-- Dumping routines for database 'evs'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-06 16:17:25
