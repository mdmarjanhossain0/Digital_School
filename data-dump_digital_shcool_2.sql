-- MySQL dump 10.13  Distrib 8.0.30, for Linux (x86_64)
--
-- Host: localhost    Database: digial_school
-- ------------------------------------------------------
-- Server version	8.0.30-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `academic_course`
--

DROP TABLE IF EXISTS `academic_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `is_available` tinyint(1) NOT NULL,
  `description` longtext,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_course_organization_id_9d2eb9af_fk_account_o` (`organization_id`),
  CONSTRAINT `academic_course_organization_id_9d2eb9af_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_course`
--

LOCK TABLES `academic_course` WRITE;
/*!40000 ALTER TABLE `academic_course` DISABLE KEYS */;
INSERT INTO `academic_course` VALUES (1,'Physics',1,'','2022-07-25 18:40:06.139371','2022-07-25 18:40:06.139424',1),(2,'chemistry',1,'','2022-07-25 18:40:19.285805','2022-07-25 18:40:19.285858',1),(3,'Math',1,'','2022-07-25 18:40:29.802929','2022-07-25 18:40:29.802969',1);
/*!40000 ALTER TABLE `academic_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_exam`
--

DROP TABLE IF EXISTS `academic_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic_exam` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `schedule` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `batch_id` bigint NOT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_exam_organization_id_7061b6c4_fk_account_o` (`organization_id`),
  KEY `academic_exam_batch_id_84590077_fk_account_batch_id` (`batch_id`),
  CONSTRAINT `academic_exam_batch_id_84590077_fk_account_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `account_batch` (`id`),
  CONSTRAINT `academic_exam_organization_id_7061b6c4_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_exam`
--

LOCK TABLES `academic_exam` WRITE;
/*!40000 ALTER TABLE `academic_exam` DISABLE KEYS */;
INSERT INTO `academic_exam` VALUES (1,'Exam 1','2022-07-25 00:00:00.000000','2022-07-25 18:41:00.078905','2022-07-25 18:41:00.078925',1,1),(2,'TC exam','2022-07-26 00:00:00.000000','2022-07-26 12:49:45.583995','2022-07-26 12:49:45.584015',1,1),(3,'tc','2022-07-26 00:00:00.000000','2022-07-26 12:51:19.914954','2022-07-26 12:51:19.914976',1,1),(4,'t','2022-07-27 00:00:00.000000','2022-07-26 12:57:35.258946','2022-07-26 12:57:35.258979',1,1),(5,'t','2022-07-27 00:00:00.000000','2022-07-26 12:57:36.113400','2022-07-26 12:57:36.113420',1,1);
/*!40000 ALTER TABLE `academic_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_exam_courses`
--

DROP TABLE IF EXISTS `academic_exam_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic_exam_courses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `exam_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `academic_exam_courses_exam_id_course_id_8e9dbb60_uniq` (`exam_id`,`course_id`),
  KEY `academic_exam_courses_course_id_d122af8d_fk_academic_course_id` (`course_id`),
  CONSTRAINT `academic_exam_courses_course_id_d122af8d_fk_academic_course_id` FOREIGN KEY (`course_id`) REFERENCES `academic_course` (`id`),
  CONSTRAINT `academic_exam_courses_exam_id_18d25704_fk_academic_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `academic_exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_exam_courses`
--

LOCK TABLES `academic_exam_courses` WRITE;
/*!40000 ALTER TABLE `academic_exam_courses` DISABLE KEYS */;
INSERT INTO `academic_exam_courses` VALUES (1,1,1),(2,1,2),(3,1,3),(4,2,1),(5,2,2),(6,2,3),(7,3,2),(8,4,1),(9,4,2),(10,4,3),(11,5,1),(12,5,2),(13,5,3);
/*!40000 ALTER TABLE `academic_exam_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_result`
--

DROP TABLE IF EXISTS `academic_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic_result` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mark` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  `exam_id` bigint NOT NULL,
  `organization_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_result_exam_id_52ab7793_fk_academic_exam_id` (`exam_id`),
  KEY `academic_result_organization_id_49f01449_fk_account_o` (`organization_id`),
  KEY `academic_result_student_id_0a5d1c17_fk_account_student_id` (`student_id`),
  KEY `academic_result_course_id_4fde7831_fk_academic_course_id` (`course_id`),
  CONSTRAINT `academic_result_course_id_4fde7831_fk_academic_course_id` FOREIGN KEY (`course_id`) REFERENCES `academic_course` (`id`),
  CONSTRAINT `academic_result_exam_id_52ab7793_fk_academic_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `academic_exam` (`id`),
  CONSTRAINT `academic_result_organization_id_49f01449_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`),
  CONSTRAINT `academic_result_student_id_0a5d1c17_fk_account_student_id` FOREIGN KEY (`student_id`) REFERENCES `account_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_result`
--

LOCK TABLES `academic_result` WRITE;
/*!40000 ALTER TABLE `academic_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_account`
--

DROP TABLE IF EXISTS `account_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `mobile` varchar(15) NOT NULL,
  `username` varchar(32) NOT NULL,
  `profile_picture` varchar(100) DEFAULT NULL,
  `date_joined` datetime(6) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `otp` varchar(6) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `is_teacher` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_account`
--

LOCK TABLES `account_account` WRITE;
/*!40000 ALTER TABLE `account_account` DISABLE KEYS */;
INSERT INTO `account_account` VALUES (1,'pbkdf2_sha256$260000$rArSYGADcOeqn4BeNyewEh$m7nm7966oDO7dOyHjSalqkTF7qE7SyDgcgfHMzt3NNU=',NULL,'01711110000','demo dev user','','2022-07-25 18:00:54.068045','2022-09-05 12:30:45.123989',NULL,1,1,1,1,0),(2,'pbkdf2_sha256$260000$os7onNgbgLRv9ayzt8dwB2$dX/KfFQ7XLDT7+xE2GpQOYQUGEwIn0ItNSLtDXXx+nU=','abc3@gmail.com','01711223344','abc','abc01711223344/pp/Mug_2-01.jpg','2022-07-25 18:04:11.786247','2022-08-03 09:37:12.152740',NULL,1,1,0,0,0),(3,'pbkdf2_sha256$260000$iRWpfJSD0ns8ew79DnFj1h$gm+pYK5w4n1pr6zuDXYqukvCHu7T+sXiUGdu6q2GS1I=','','01711223355','Student 1','Student 101711223355/pp/cropped7694707256124692909.jpg','2022-07-25 18:29:13.429340','2022-07-27 19:20:06.193734',NULL,0,1,0,0,0),(4,'pbkdf2_sha256$260000$3xdWu3xZogCybyNnRM6TcQ$1EFnHtggDbMlX4IjUy0AsNnXbNZywm6HbIf49+7Nzgo=','rabintechco@gmail.com','01580696982','Rakib','Rakib01580696982/pp/cropped1891401904204635863.jpg','2022-07-26 13:01:30.278452','2022-08-02 18:22:59.320251',NULL,0,1,0,0,0),(5,'pbkdf2_sha256$260000$uyshYZ9iNoaPceB9YThHF4$N0XJYGpmDucR3fYEK9cdq+kFNcRnY+bsBdAtK+EJ2+o=','teacher1@gmail.com','0175557846','teacher 10000','','2022-07-26 17:51:43.477370','2022-08-19 12:06:49.086713',NULL,0,1,0,0,1),(6,'pbkdf2_sha256$260000$n9hzGNXdjOnnUqypsBapQi$mIj4l22p52wSCHRZR47tY2gXpjL1a/MsMRfR718LTAA=','staff1@gmail.com','017478986','staff1','staff1111017478986/pp/cropped6799648970299698356.jpg','2022-07-26 17:53:07.033611','2022-07-27 19:18:51.113009',NULL,0,1,1,0,0),(7,'pbkdf2_sha256$260000$xMpgxmnMOCJsBZQytfZQwX$mzCCjaGuE17X/vok2kuLX+5W4ExAdWlkfgtKd2Uvxmk=','teachers@gmail.com','0172349787','teacher 1','teacher 10172349784/pp/cropped8143844179276776143.jpg','2022-07-27 18:21:30.220458','2022-07-27 19:31:35.650075',NULL,0,1,0,0,1),(8,'pbkdf2_sha256$260000$OHzJBykRwzoZEMzfx4ZxVP$rJhhawoED+XLnuVd21kFczW8TkR+hD2Rae4Kw0q3zgI=','demos@gmail.com','01711223366','Demo Staff','','2022-07-28 18:48:22.938193','2022-07-28 18:48:22.938263',NULL,0,1,1,0,0),(9,'pbkdf2_sha256$260000$KVyQ4NOOn98khualzmY2AC$108thcz5KYd0Pn9eRavtTa2FiXAFORm8P8sivikWn0U=','tusherscareofficial@gmail.com','01777104777','Rakibul Islam Tusher','','2022-07-31 11:18:58.017179','2022-07-31 11:22:35.889078',NULL,1,1,0,0,0),(10,'pbkdf2_sha256$260000$4bl6X010mLGRTNbkK4k9Vp$39ESp3YE9NtiMmvvBJkC94oa0Llqk75osHvnaQJSi7g=','nahidwxyz@gmail.com','01521372697','Nahidul Islam','','2022-08-01 17:55:36.259186','2022-08-01 17:55:36.259252',NULL,0,1,1,0,0),(12,'pbkdf2_sha256$260000$9QfEm8yESD0od5brXwrCej$PtupCAV7ilpxHS/Pua5hz5k2O2I2d85rJF2JwDoMj6E=','','01922239239','Nahid','','2022-08-02 18:21:29.790315','2022-08-02 18:21:29.790372',NULL,0,1,0,0,0),(13,'pbkdf2_sha256$260000$ipXeXPYM4PG8X02KS3yrQy$OxA7mjHn1+YpupwlbjWYggC4j3568Nf27d9HcA2SQw8=','','01755966950','Sneha Binte Mostaq','','2022-08-02 18:28:17.748401','2022-08-02 18:30:38.819686',NULL,0,1,0,0,0),(14,'pbkdf2_sha256$260000$sRN6ZsU5ryT4Ygba5pkFi7$Kz8tvsqHaVfmrK0ShjqGoZEKYbyYyTP1GNOKQF4KdCA=','ramprosad111@gmail.com','01518678537','Ram Proshad','','2022-08-04 12:38:19.305469','2022-08-04 12:38:19.305531',NULL,0,1,0,0,1),(15,'pbkdf2_sha256$260000$c6zwoK3TCDI9bMpyjMh1Wd$/soDVCct1WZVssUSANr9XdkzuhjhkGEY4n+Oy8Qa/5Q=','ayshekundu04@gmail.com','01302142689','Ayshorjo Kundu','','2022-08-04 15:27:14.558777','2022-08-04 15:27:14.558872',NULL,0,1,0,0,0),(16,'pbkdf2_sha256$260000$ojvm1uoS7Lbg2y7XDyLqrW$nAtWFG5fJegl7Xk53GiArFmy3F202Uzy81biQYktNpM=','','01537277592','Noushin Tabassum Nazia','','2022-08-04 17:31:20.647843','2022-08-04 17:31:20.647901',NULL,0,1,0,0,0),(17,'pbkdf2_sha256$260000$N4tMxRjPiIxdAhL3uq8gIn$cQacjT4XNhFthZ33mywAlYid+MjMhxFLPYpJgPnUDAU=','','01837544428','Sharna Islam','','2022-08-06 12:52:41.306470','2022-08-06 12:52:41.306529',NULL,0,1,0,0,0),(18,'pbkdf2_sha256$260000$ooAZyjyCHZ18lCMItUHeOU$stGpXqtjCU9lGGS3s4kdwz5TuGIbJC8ml4l2dePI1uU=','','01799334174','Jannatul Ferdows','','2022-08-06 12:59:42.019918','2022-08-06 12:59:42.019979',NULL,0,1,0,0,0),(19,'pbkdf2_sha256$260000$0zNxMW7DPrLjSFAdac9y9Y$wrXxbmVhVdxkzytvQFdfNY25Euy5CNX8Cg9d2AmjDgk=','','01786284805','Laboni','','2022-08-06 13:03:44.837797','2022-08-06 13:03:44.837857',NULL,0,1,0,0,0),(20,'pbkdf2_sha256$260000$7VyuqpucwRpvPr4pModNp1$0cK+yo3/7NoA/cvbrKmIvpYNzalmr9YpF6ROiiVjh8U=','','01771077794','Nowshin Tabassum','','2022-08-06 13:06:54.096457','2022-08-06 13:06:54.096515',NULL,0,1,0,0,0),(21,'pbkdf2_sha256$260000$spHHadj5AjD5SxilnWlbaz$9SA+TOvJmtbo6cUTVM/oJ+p0BJ+lLC74i8nLi9PMSI0=','','01904393555','Tasmin jahan choya','','2022-08-06 13:10:56.813619','2022-08-07 14:22:54.431067',NULL,0,1,0,0,0),(22,'pbkdf2_sha256$260000$KrHjIIcTdGtpIoxZKQRjDK$qxtKa5yJFqUCFoEJoX+phrxaQ0H77V7dtf/T3dT/Dkg=','','01888473212','Bidhan kumar saha','','2022-08-06 13:14:13.091481','2022-08-06 13:14:13.091537',NULL,0,1,0,0,0),(23,'pbkdf2_sha256$260000$yVqhLSs0PNalnoDgPqdQfu$UWfpW1Curu0iSbwmS6t4xafCPLtndZki00b17Rox+jo=','','01767414940','Mayesha Rahman','','2022-08-06 13:15:10.056976','2022-08-06 13:15:10.057044',NULL,0,1,0,0,0),(24,'pbkdf2_sha256$260000$Z5g5HPq5q6px1g3mBP3Kgm$jxK/5NoQ1ZHyJTaA7pzNVLymnizNBzsvh0iehIuGPAY=','','01791561899','Anirban Sarkar','','2022-08-06 13:19:39.886967','2022-08-06 13:19:39.887028',NULL,0,1,0,0,0),(25,'pbkdf2_sha256$260000$45b8fIeKBdjsCgkMTA4raD$iss1KG8bimEpPCBqm/IxsvW6P7LrnTcEvA2yIduMP6U=','','01780182057','Rajib Sheikh','','2022-08-06 13:22:36.890274','2022-08-06 13:22:36.890333',NULL,0,1,0,0,0),(26,'pbkdf2_sha256$260000$EGzvtuUOpFR8mITYeVBGdQ$zImkgt57cfv0OscaiVXlGunW57X+TB07LF+mckRUhTw=','','01793564388','Mst. Jeba khatun','','2022-08-06 13:24:44.314289','2022-08-06 13:24:44.314348',NULL,0,1,0,0,0),(27,'pbkdf2_sha256$260000$G8klGVIJ0cVQjFGN7eqCim$qUChKu7NZqwLPJO+gZYhqdIFR2c3lHWo8m2I0kaOVTM=','','01785617731','K.M.A Mubin Hossain Mahim','','2022-08-06 13:26:45.240124','2022-08-06 13:26:45.240184',NULL,0,1,0,0,0),(28,'pbkdf2_sha256$260000$38uBWQ7QXmZEi3y1Kz4qf7$eIwDiNsKEJrXvQGiYoyu9By6fbgojQaUEeaQuhWiEA0=','','01407511422','Salsabil  Takia','','2022-08-06 13:29:21.912095','2022-08-06 13:29:21.912155',NULL,0,1,0,0,0),(29,'pbkdf2_sha256$260000$w1eRBHiqDoF1o1TqcQLwID$ogLyLC33SRAO2EqstbUPrLj92ctcds2TKy4PC2AWrxU=','','01748856286','Tanjim Tanima','','2022-08-06 13:29:46.057160','2022-08-06 13:29:46.057223',NULL,0,1,0,0,0),(30,'pbkdf2_sha256$260000$4VItIBqP6ynH96dM4LQs5c$OsYn4ufu5IWr82LIaA28ZcgrkR7IH1Q3c+0mUr6931U=','','01996541520','Kazi Latifa','','2022-08-06 13:32:01.989533','2022-08-06 13:32:01.989593',NULL,0,1,0,0,0),(31,'pbkdf2_sha256$260000$Sx0M9XTDiOqafCnE7glru1$2D5wfzfxYg4CUi1FEX0LnMU63mj07p0hEhLtrdwJo7U=','','01934186406','Md. Nahul Islam','','2022-08-06 13:32:50.759572','2022-08-06 13:32:50.759633',NULL,0,1,0,0,0),(32,'pbkdf2_sha256$260000$b686jvfuqbVFAgItWV0UhV$rKXEsuBMiSqLgql/t2ST2mSHGCtnsJT5rQIpcg0nt8E=','','01833601667','Suriya Alim Mathin','','2022-08-06 13:37:08.430244','2022-08-06 13:37:08.430315',NULL,0,1,0,0,0),(33,'pbkdf2_sha256$260000$G3kmMGgZPPkpLi49DGU58T$xNQJF2Xq/fPxNJ9x41cxvRwZjIEgwQ8PA/vYX9a/sBM=','','01303905721','Akash Das','','2022-08-06 13:39:50.932488','2022-08-06 13:39:50.932546',NULL,0,1,0,0,0),(34,'pbkdf2_sha256$260000$ezSRKDISYtTncXp1yPxoPb$Om/nI2VJvA/Bmb43kf1Kv/5RVWXTiLValMlCpCbAtTw=','','01776585140','Hafizur Rahman','','2022-08-06 13:52:40.935307','2022-08-06 13:52:40.935366',NULL,0,1,0,0,0),(35,'pbkdf2_sha256$260000$t0h3g20YR18beO2pP1thfo$VqHA7jINcxXP3D9a+uzpc6h3MbheE3LYxr5wKG37hq8=','','01305547976','Akash Biswas','','2022-08-06 13:52:56.152568','2022-08-06 13:52:56.152628',NULL,0,1,0,0,0),(36,'pbkdf2_sha256$260000$HRr6cPfyv873bpFZXcEAR3$niOxvZKF2oMrKRHsilpL+NcRzUUZc8Yzr0+AyxKLvA0=','','01786940826','Kudrot-E-Alahe','','2022-08-06 13:55:33.657787','2022-08-06 13:55:33.657848',NULL,0,1,0,0,0),(37,'pbkdf2_sha256$260000$o9VobK6w5DYvnkWMO85TRi$HI+8lyFPFLZSBgInKosap4d6NaaQYYEjwMgyyUrADEU=','','01754375262','Souborna','','2022-08-06 13:55:39.482611','2022-08-06 13:55:39.482668',NULL,0,1,0,0,0),(38,'pbkdf2_sha256$260000$2QuFkRLPDGhugGeBnjesR6$0XvWD41hdOdsuFG32ixR2PJT7fckG0BEYLBEkzXniTE=','aminurislam3086@gmail.com','01402048382','Md.Aminur','','2022-08-06 14:00:14.712724','2022-08-06 14:00:14.712781',NULL,0,1,0,0,0),(39,'pbkdf2_sha256$260000$0vBmoAXnpV19Nj2j8o3to0$v7hxuTEAIPv3FxZyhJSkVwswMViOmiy/hbU7EJHD4hg=','','01304564049','Suraj Kumar Biswas','','2022-08-06 14:01:35.746230','2022-08-06 14:01:35.746288',NULL,0,1,0,0,0),(40,'pbkdf2_sha256$260000$6x0rmOJA6qNa1RPlLYTQi0$mF6owfFmKiJ2SyrHXIhhypUYsrfaE0ap7ZSABEFghMA=','','01317799105','Halima tuz Sadia Islam','','2022-08-06 14:07:12.551299','2022-08-06 14:07:12.551356',NULL,0,1,0,0,0),(41,'pbkdf2_sha256$260000$mPeujzjoOyjWxQi42tsTOd$GJVluMp8GLFpOAH4ozzEybGADvs6K+iEEfDoSMVIxfo=','','01575486897','Sumaiya Akter Kheya','','2022-08-06 14:07:33.477648','2022-08-06 14:07:33.477722',NULL,0,1,0,0,0),(42,'pbkdf2_sha256$260000$T2KscENkSO6dROjtTksjjz$Ob/iF9XCSpcEeiOWxWdicvTvJlWTG8qy3zyV1RQaVXI=','','01938773538','Jubayer Mia','','2022-08-06 14:10:02.356865','2022-08-06 14:10:02.356922',NULL,0,1,0,0,0),(43,'pbkdf2_sha256$260000$UtFqcAtzl0cuvy9kMsFdhh$gr3pVJC0v/ON1XJIR3ydzoM5Jqh4DONWrx/e3MR7MmI=','','01303569881','Sumaiya Khan','','2022-08-06 14:11:14.094488','2022-08-06 14:11:14.094548',NULL,0,1,0,0,0),(44,'pbkdf2_sha256$260000$reSiueoqsZt2cQawIUuCYP$pAG7Bf+aLJEsC4BtPBXKLiMJ7N6R9bVSgLdbhpfwPxM=','','01792144437','Md.Ariful Islam','','2022-08-06 14:14:16.414972','2022-08-06 14:14:16.415031',NULL,0,1,0,0,0),(45,'pbkdf2_sha256$260000$ENMtO3n940zMIZ89JQvoMw$QBQAyHiMgTijAkS4jUCZbW5nCGIolPoBL5714Y4YoOQ=','','01306620438','Haoya','','2022-08-06 14:15:01.129586','2022-08-06 14:15:01.129666',NULL,0,1,0,0,0),(46,'pbkdf2_sha256$260000$cmCbMN3Lo3jW4nzl0dCQ3Z$xZ+3szkl9THOnk4dNmOaIGqNcy2bCMq3LO/j04dowc0=','','01302762606','Md. Habib Sheikh','','2022-08-06 14:16:58.791979','2022-08-06 14:16:58.792039',NULL,0,1,0,0,0),(47,'pbkdf2_sha256$260000$cw1fKV6lwfIqNDLEJ2Dhte$GEUEb079gqnH6nKmf50/PweY29VGO7uFYbVK89b7NzQ=','','01763764264','Joya Bhoumik','','2022-08-06 14:19:52.590118','2022-08-06 14:19:52.590192',NULL,0,1,0,0,0),(48,'pbkdf2_sha256$260000$pDM781rZtXlmZaod2Tv8EC$gt21Grx9wiUMTv/kMPhJ1qVMEE8Lqp6WjOCaT+izjr4=','','01611086050','Shuvojit Karmakar','','2022-08-06 14:20:47.975009','2022-08-06 14:20:47.975072',NULL,0,1,0,0,0),(49,'pbkdf2_sha256$260000$qWdRHrKFKEnYZrzAsFmJkF$eh1UIEyovSe0R/jEt89418Wh9FIDK+ShjdjmBIpCI4k=','','01303275299','Sushmoy Karmakar','','2022-08-06 14:23:49.292748','2022-08-06 14:23:49.292806',NULL,0,1,0,0,0),(50,'pbkdf2_sha256$260000$T4bowAEAoobIPVLt3A6r9O$OSHh3ArgRwpGPqVDA16Kv7ccCVxSwB/knuRGLlBq/iE=','','01904966071','Sadman Farhad','','2022-08-06 14:26:51.784380','2022-08-06 14:27:34.992637',NULL,0,1,0,0,0),(51,'pbkdf2_sha256$260000$vILDiMCY4COFafmTlnsxrM$Y+ZWk+Q4+q9XRRSKBV2mg9511cm167W5V8YHyK1taBM=','','01719285582','Aritri Chakrabarty','','2022-08-06 14:27:33.318057','2022-08-06 14:27:33.318115',NULL,0,1,0,0,0),(52,'pbkdf2_sha256$260000$VyXtxfQFoqh5IKWAUJz2dW$LGrV4teU2ndjDSuonms65F/P9Up7MijXdoMeBMAdMNQ=','','01761459401','Sanzana Akter Mim','','2022-08-06 14:29:35.649359','2022-08-06 14:29:35.649438',NULL,0,1,0,0,0),(53,'pbkdf2_sha256$260000$KdplYf53kiTUH5qPx80jfo$OCAkZh8gznheyWJx0DbO5YSaTJfKVIsWGMqGwA3qfCI=','','01868047499','Tahmina Akter','','2022-08-06 14:30:06.365450','2022-08-06 14:30:06.365511',NULL,0,1,0,0,0),(54,'pbkdf2_sha256$260000$S10sW5dWLnJDmfYiiJauOv$2rEAwORtvvFPfOd1aDCQaIqs2F1rgAqbQeRyFtoLFUA=','','01728752392','Md. Shahadat hossan','','2022-08-06 14:32:49.941396','2022-08-06 14:32:49.941465',NULL,0,1,0,0,0),(55,'pbkdf2_sha256$260000$uJ3Emanf6Qh5yo6zCQoI9p$UEF+nmmxAT20i3WK41T2KIWIO3edCIq7jSBEA1f7S0w=','','01740424314','Sanjida Alam Nusrat','','2022-08-06 14:33:17.581659','2022-08-06 14:33:17.581735',NULL,0,1,0,0,0),(56,'pbkdf2_sha256$260000$avHkyTcG8z5ILFgFi1ayOP$qKl4GkW3/1UoryIswQsIcGOa7qA69O6WwdoLFj1Y908=','','01785892601','Nusrat jahan','','2022-08-06 14:36:55.237810','2022-08-06 14:36:55.237890',NULL,0,1,0,0,0),(57,'pbkdf2_sha256$260000$QjXEaWwD7P41hHzGboLM7O$3wQjUg9dVmLnvZBbIebbFIzEkM6t3uB+5wMriUgg0hU=','','01725000784','Mohima Zaman','','2022-08-06 14:37:33.002110','2022-08-06 14:37:33.002171',NULL,0,1,0,0,0),(58,'pbkdf2_sha256$260000$0YCYFwnVCZv7TWunFoEmod$7IBsEFdpTdWH5BdrM1uNkVhbl8xIvh8vAoUIOh44SyY=','','01765617504','Tanvir  Hossain Abir','','2022-08-06 14:43:54.084127','2022-08-06 14:43:54.084189',NULL,0,1,0,0,0),(59,'pbkdf2_sha256$260000$mLDsZHFj3gZEAPv735CDSb$tbmvLNR8d8jRxJyBf9zy9HhZZebRj5piaXn4bKomRdo=','','01404392699','Nibir Sardar','','2022-08-06 14:48:10.702457','2022-08-06 14:48:10.702517',NULL,0,1,0,0,0),(60,'pbkdf2_sha256$260000$CrjXnV7JkYGtGW3ZlHGMAU$S5RcMPPgRS/Dv6rPGabB7kDZh6qZqY5l2OSKtWBfDvU=','','01785618394','moniruzzaman monir','','2022-08-06 14:53:50.561894','2022-08-06 14:53:50.561954',NULL,0,1,0,0,0),(61,'pbkdf2_sha256$260000$6EY1xIYqpFi72GONmVDSnM$FOK8bDBndmvzt8DFRybL7YKKgaifFar8Cn/mqwLCWh0=','','01757440059','Md. Mushfiqur Rahman','','2022-08-06 14:56:11.051948','2022-08-06 14:56:11.052010',NULL,0,1,0,0,0),(62,'pbkdf2_sha256$260000$NhfJafo3isSxiQ1sM4yUWb$ViSSDCY+UjkJnkRdreTbjpBmPUBZReKm2aaq/38HxEU=','','01768874901','Sompa Malo','','2022-08-06 14:58:16.932496','2022-08-06 14:58:16.932557',NULL,0,1,0,0,0),(63,'pbkdf2_sha256$260000$l7UeRQ1JWjOiXs0OuMhdYI$35TzCL062syhMZKGYdBH7Oxq8qqISjM+FXFiT8PUGpQ=','','01880775057','Nafis Ahammad Tanim','','2022-08-06 15:04:00.484558','2022-08-06 15:04:00.484615',NULL,0,1,0,0,0),(64,'pbkdf2_sha256$260000$EE2j1aJsG1E02c5vdACNLw$VP2B5mOYTanqizuTBgFIMmcS64n7s9UWmwfSMPTDvS0=','','01941914399','Fariha Afrin','','2022-08-06 15:10:59.083587','2022-08-06 15:23:24.081583',NULL,0,1,0,0,0),(65,'pbkdf2_sha256$260000$yV8xHFy7J8XG8cUiVqhpBq$xGrFA/g2dehzZYFqS169En2wpZCG80bJruD0CmTxfYQ=','','01873712493','Mohona Akter','','2022-08-06 15:18:52.741014','2022-08-06 15:18:52.741077',NULL,0,1,0,0,0),(66,'pbkdf2_sha256$260000$OifyPNFXm7Ae9f1tkAejBs$CUiVhcr7wmJBNQd092YEOGtjXTvqHsdeIXH88MH1i+M=','','01774919039','Zerin Omar Samara','','2022-08-06 15:21:31.594564','2022-08-06 15:21:31.594623',NULL,0,1,0,0,0),(67,'pbkdf2_sha256$260000$R6Q7JtD3TeBWoIAzzCabcJ$gZGa5xOBCWBP7D/CGIHESeLjvkllYp4UtqUk/UaZ4wE=','','01750034660','Ripa Khandaker','','2022-08-06 15:26:08.209188','2022-08-06 15:26:08.209262',NULL,0,1,0,0,0),(68,'pbkdf2_sha256$260000$POiDBxvtJgtzahBlUiY2Bd$M0pPWhKqe8vZarKKknC+Jh5w8Wu5wGL5nitzmdTDOJY=','','01710410167','Ratul Joye Dutta','','2022-08-06 15:28:34.740766','2022-08-06 15:28:34.740821',NULL,0,1,0,0,0),(69,'pbkdf2_sha256$260000$bZbaxTCkzyYmOkLRhI9flr$p9C5sOK/03Dm2p2Xzwilaza0OeCApOZfwjrYKAq1j38=','','01772732074','Mst.Sanjida Sultana','','2022-08-06 15:29:40.421598','2022-08-06 15:29:40.421657',NULL,0,1,0,0,0),(70,'pbkdf2_sha256$260000$IgsEBOJYSSZaWoBkJscRaZ$9ZMUiCWtFLkwkjQWLohgPoVXfqWCUzCWG3P6d9wjW18=','','01319695492','Tajalli Afrin','','2022-08-06 15:31:14.696057','2022-08-06 15:31:14.696115',NULL,0,1,0,0,0),(71,'pbkdf2_sha256$260000$dhRkfA1oJK0EWpVGIdTCJE$MNP3iPy0GpSbyGjNsHhmHWT8x5o20m//j+McwmyRxuY=','','01640050615','Abdullah Faysal','','2022-08-06 15:35:15.841208','2022-08-06 15:35:15.841264',NULL,0,1,0,0,0),(72,'pbkdf2_sha256$260000$BsMne3Q6Nv8taKGAFv1I27$mWvdE4pjcnARRMAVDA0JXkX2A2YDuo/JDF8JmHQ+dlM=','','01748316851','Shah Alam Hossain','','2022-08-06 15:38:16.493555','2022-08-06 15:38:16.493615',NULL,0,1,0,0,0),(73,'pbkdf2_sha256$260000$9Njsiwuwh5UNYjRMQfkn8V$83xE1h8fjzm9UaSemeOUFxAxOZwNOYcPzYMm7VolAs0=','','01708764341','Nafiz Fuad Alvee','','2022-08-06 15:40:32.566731','2022-08-06 15:40:32.566875',NULL,0,1,0,0,0),(74,'pbkdf2_sha256$260000$CY9r4ulLWwiAnevgCHKahE$BkQVI3Oglar/MR7HdX8ytrD4FKXqDj1qcW1mnY777+M=','','01635240149','Md Sakib hossain','','2022-08-06 15:45:41.624299','2022-08-06 15:45:41.624362',NULL,0,1,0,0,0),(75,'pbkdf2_sha256$260000$JkhgUWYaYg5GcOICcG72wT$IWL3jwGwGR9T5t/HUPvGWTLGvQjGWf5FjuktVjhjG0I=','','01798482057','Doli Khatun','','2022-08-07 14:32:59.519770','2022-09-01 14:26:45.799916',NULL,0,1,0,0,0),(76,'pbkdf2_sha256$260000$BIy2uYzFE4KYLKS1i5Y2ML$pWegyQ2CNto3NF/kym193aj/Bq5NUGElY+WnTakQel0=','','01611948154','Sydur Rahman','','2022-08-09 15:27:29.337755','2022-08-09 15:28:35.710586',NULL,0,1,0,0,0),(77,'pbkdf2_sha256$260000$hzwGKqMXI9DvTH8SUNuDtC$ql7LNL9X6GUCGiueL/cMI3JYU7354PhEhYftMEPEVHI=','','01640219175','Nisata Jahan Nirjona','','2022-08-09 15:35:04.907678','2022-08-09 15:35:04.907739',NULL,0,1,0,0,0),(78,'pbkdf2_sha256$260000$1aNpO9ELHcnyYVmsSHNCX1$OHQnPhW/vtr71eV3g5Dac1QdSV7BDlIrXT1dvb0eRdQ=','','01834206752','Jannat','','2022-08-09 17:16:51.311727','2022-08-09 17:16:51.311792',NULL,0,1,0,0,0),(79,'pbkdf2_sha256$260000$EIal1cILER7aK3ZUglB4gr$Z4Z7ranChC77ItRP+Uz3ZamjxDFVYiyTxBMR+HN3Omg=','taefatunnahartonny@gmail.com','01608142412','Khondokar Taefatunnahar Tonny','','2022-08-10 09:46:29.671529','2022-08-10 09:46:29.671589',NULL,0,1,0,0,0),(80,'pbkdf2_sha256$260000$12jguExkArbDuCnpi7KOPi$qhPjKuGZ+cfa3YXz5y869Kkg5GbWINh+NnO1Qg2+9Ic=','','000','000','','2022-08-10 09:49:35.740088','2022-08-10 09:52:11.603675',NULL,0,1,0,0,0),(81,'pbkdf2_sha256$260000$jko5WAoSbFJRRJKpfOFpP5$LTt9CLqPMn6pJ9yjrRLG9aOuIQk0SSyGZ5rl7RtmW7c=','','01788304266','Mehezabin Nira','','2022-08-10 10:47:48.034994','2022-08-10 10:47:48.035055',NULL,0,1,0,0,0),(82,'pbkdf2_sha256$260000$GB1fZVWQGiluEyvdItqWkB$0FiTJt6yWX37/rR26xVoHH1cefvqmB42XKvF/fbperQ=','','01787305286','Kazi Mozammel Hossain','','2022-08-10 17:59:26.108983','2022-08-10 17:59:26.109042',NULL,0,1,0,0,0),(83,'pbkdf2_sha256$260000$wf1Z9MgKAeNVxXB7vchApn$zxU2xt+6bfLNPLXGxn6juC3fpOd6NcE7cElOetcLjxY=','','01304913194','Asif Ebrahim','','2022-08-10 18:18:22.596135','2022-08-10 18:18:22.596195',NULL,0,1,0,0,0),(84,'pbkdf2_sha256$260000$dzFu4tinbYQ7TseOvUgP4I$TehsIMyP3125WsaVfoU/gVUXMrag9dw03+C2iHbNuFs=','goutammandal2002@gmail.com','01768811599','Goutam Chandar Mondal','','2022-08-10 18:24:54.773272','2022-08-10 18:24:54.773330',NULL,0,1,0,0,0),(85,'pbkdf2_sha256$260000$n3V9QylhJ0G0FK3wEmj8UM$5WqeRGv3nS2uTmv+rUa07iwRARZUoiVHw5R4BBr3zEE=','','01716319727','Md. tokibul haque ayon','','2022-08-10 18:45:47.367002','2022-08-10 18:45:47.367061',NULL,0,1,0,0,0),(86,'pbkdf2_sha256$260000$IGGPMrUqclQNCvefa1B4tp$+T096/GLgv80/OJ5cvm6MHg0/UBiNzLWJdRpkAYNypU=','','01777477553','Sourov Saha Badhon','','2022-08-10 18:50:22.041210','2022-08-10 18:50:22.041290',NULL,0,1,0,0,0),(87,'pbkdf2_sha256$260000$A3fe1UndNaGt19RZj4a25p$JN/Wteiiy2ewDF/SZ1kTeISEkiL2MPoEjIALR9jLGts=','','01303888314','Shahanaz Akter Sumaya','','2022-08-10 18:54:14.874007','2022-08-10 18:54:14.874066',NULL,0,1,0,0,0),(88,'pbkdf2_sha256$260000$bqttDSRLG0JGmDBBHEXTRI$1ZRA4xiG6p6rCFFFpkBlD3IFoY/hG4lZGpWGFIzzecU=','mostofa.raihan2002@gmail.com','01745233581','Md. Mpstofa Shake','','2022-08-11 10:29:36.851750','2022-08-11 10:29:36.851813',NULL,0,1,0,0,0),(89,'pbkdf2_sha256$260000$Znee9vXIEv2hPZiNS8d9lC$u8FFmTi6KamliOCvvlRz7PLPZFjp/tv//EMhqordsM4=','','01704485300','Ridita Paul Prity','','2022-08-11 13:50:26.709421','2022-08-11 13:50:26.709492',NULL,0,1,0,0,0),(90,'pbkdf2_sha256$260000$W1irLJByOHBU99LRPwezPi$FAqWH2wu3X9WwloW2hmtlRp1tsDb92d7jTiFRRi4OGo=','','01317014758','MD.Repon Howladar','','2022-08-11 13:55:40.513411','2022-08-11 13:55:40.513471',NULL,0,1,0,0,0),(91,'pbkdf2_sha256$260000$id5IXycldwJ4sjaYjjxCq8$2Ou2w/fXldPKvS+1L7HqWXoeo85s3THBre5U09PAdgY=','','01756688882','Rushda Ruquayya Mimma','','2022-08-11 14:02:07.711243','2022-08-11 14:02:07.711302',NULL,0,1,0,0,0),(92,'pbkdf2_sha256$260000$GuHj1mIE8TA9dxV14ekMpM$dN8ZFM7B1zUzyKKFRs0xqm0GhPXP9Dl3Jdy9N+T8gcY=','','01792479030','Shahazadi Fathima Asha','','2022-08-11 14:06:15.354108','2022-08-11 14:06:15.354169',NULL,0,1,0,0,0),(93,'pbkdf2_sha256$260000$cW0yVcBKvbQ95Lh4hSdNkG$vFFNFDhxzQiT0rHpj59h1ePMsGfZ8irrzS9WBEhO5Cw=','','01722105642','Musfirat Nasrin Mitu','','2022-08-11 14:09:25.140625','2022-08-11 14:09:25.140687',NULL,0,1,0,0,0),(94,'pbkdf2_sha256$260000$WpblSpvSFIh4nf7tc5j6su$FcR92xDIzkJC7x1PgBHEjwuMEmdsUetTkHZo3G1Wcj4=','','01760439516','Jannatul Ferdos','','2022-08-11 14:14:16.139292','2022-08-11 14:14:16.139354',NULL,0,1,0,0,0),(95,'pbkdf2_sha256$260000$tCoyg5HlSKplyLNTw76mMN$ShTxOWa54i3yJ7vtsBiMr7hbZO5pBcp9+751If2bFyg=','','01711134783','Rutaiba khan','','2022-08-11 18:34:54.100222','2022-08-11 18:34:54.100282',NULL,0,1,0,0,0),(96,'pbkdf2_sha256$260000$ziTnSp55inPsL8PpHD7YOe$V5knCLxUDhI9MApxmf2tPEuIACPxxTOCBgbmgajPzeY=','','01708564438','Nusrat Jahan Setu','','2022-08-11 18:41:22.315813','2022-08-11 18:41:22.315873',NULL,0,1,0,0,0),(97,'pbkdf2_sha256$260000$dCSPYmMBcG4gMbUAslSwzS$yRWQSvHRl1i5mto7W8XGIZe9odha7WYzon8LKs4+3Nw=','','01884402198','Mushfiqur Rahman','','2022-08-11 18:44:33.064550','2022-08-11 18:44:33.064612',NULL,0,1,0,0,0),(98,'pbkdf2_sha256$260000$E18QPl4gTcXpGN8Dizu5LL$BHhbEBAtg1hoLj4Gkb1ymq43AUmJ9Jae4bqrB/G2TXs=','','01768429709','Afroza Anan','','2022-08-11 19:55:54.003910','2022-08-11 19:55:54.003973',NULL,0,1,0,0,0),(99,'pbkdf2_sha256$260000$bqBnAMGXsJiv6zK0HEemY0$YNHUCQZ06qzNlpdFBaMjhWVig8zn5HDtkH+aJYhslj8=','','01684936906','Sorna Akter','','2022-08-11 19:59:34.611700','2022-08-11 19:59:34.611762',NULL,0,1,0,0,0),(100,'pbkdf2_sha256$260000$Vy44HOGYydizYJT0QUij8E$VVJg7CEh4LN+7eidc7GlsoSviQKjjGENHnPnZ8Vr9ys=','','01660139712','Lamia Akterk','','2022-08-11 20:02:16.547239','2022-08-11 20:02:16.547300',NULL,0,1,0,0,0),(101,'pbkdf2_sha256$260000$XvQXV5LU4HLuWPV0YnMHDw$m7UfH/Xzqn0P2/FVd92PTHazmeHrsiOrh0dS8EEvazM=','','01912031164','Rifat Ahmed','','2022-08-11 20:04:46.382312','2022-08-11 20:04:46.382373',NULL,0,1,0,0,0),(102,'pbkdf2_sha256$260000$vbujTpSam3Bz4pIyRIanbR$VzR7CPtOQKM4fdeIKmnnBbPrd1CIW0Ih4hfkoGU/iVU=','','01704007078','Prince Sheikh','Prince Sheikh01704007078/pp/cropped2850670074127756874.jpg','2022-08-11 20:07:34.833854','2022-08-12 22:31:06.516130',NULL,0,1,0,0,0),(103,'pbkdf2_sha256$260000$roQTN6VhKvf4q2ZE0bTMqo$K6uvWDA79pcN1ZHblWpWCKFXk1TvkZR+u+2CKy83j1E=','','0171020175','Md. Rifat Molla','','2022-08-13 11:57:06.258665','2022-08-13 12:02:41.496367',NULL,0,1,0,0,0),(104,'pbkdf2_sha256$260000$At4R9cysNIb2WpK4D9trXM$B6v0vgWt1iQBXk3oGoev+arGJ7tCogE5sCxEADmjnlU=','','01706595681','Amina Akter','','2022-08-14 15:54:38.505519','2022-08-14 16:01:15.017869',NULL,0,1,0,0,0),(105,'pbkdf2_sha256$260000$VPiB0yPUoX0wDvXqE4jTCc$Mlu5jhdYIBCq+UnlsS8pJ9+n7mX/fEzrhrjuMtIpsPo=','','01612649164','Tonni Islam','','2022-08-15 10:14:02.895084','2022-08-15 10:14:02.895145',NULL,0,1,0,0,0),(106,'pbkdf2_sha256$260000$eQN7RSqCE3zBhVfDNueFuZ$mXBpo17E8jNhlUH5jWg8hZ5TmYwg9PD3k5OQEMLIG5w=','','01736470671','Mst Laboni Akter','','2022-08-17 16:30:41.192082','2022-08-17 18:08:11.791214',NULL,0,1,0,0,0),(107,'pbkdf2_sha256$260000$tABqxzqSbM2gslNpmEv3RT$ptQk7AZtXeFfkYgkHfDIRRpuqO5UPw6rjy6Wnv9Ch0Y=','','01754250075','Akbor Chowdhury','','2022-08-17 18:14:00.943116','2022-08-17 18:14:52.383564',NULL,0,1,0,0,0),(108,'pbkdf2_sha256$260000$88f4GIIy7d2DxgehY5mJKl$7VuiiHoD5FQwjqv5pL4yTdHFpk3Nt45aHBekD+qZio8=','','0172699266','Tasneen Tabsum Aurihi','','2022-08-17 18:18:43.672867','2022-08-17 18:18:43.672928',NULL,0,1,0,0,0),(109,'pbkdf2_sha256$260000$ozR4aoYobaEULC2WJbLXXt$16H7p3CRfr+xQ8koAm931ZLle0u2TUSTkQ83IkFNhLI=','','01312190757','Md. Ridwon','','2022-08-17 18:20:55.092619','2022-08-17 18:20:55.092680',NULL,0,1,0,0,0),(110,'pbkdf2_sha256$260000$De0ZOuVHemwN03Tx4vVRJx$WV82qh+fKeV3hPE9j71KEnMtcHdVssSzBsVbyJ3K6/w=','','01763623233','Ashra Ful','','2022-08-17 18:24:49.159735','2022-08-17 18:24:49.159793',NULL,0,1,0,0,0),(111,'pbkdf2_sha256$260000$sLDi4RyNFWD9p0mWgnFR3b$hRNW/63cEeKZQ8hJ+tpoZg6NbbwCVCK5VS0mX+YkjGM=','','01763427220','Avishek Chandra Biswas','','2022-08-17 18:28:37.481218','2022-08-17 18:28:37.481277',NULL,0,1,0,0,0),(112,'pbkdf2_sha256$260000$N9gHJOPI68tVfKL2yY5FIH$7sW0W3LsXCpCO8+4jS2CB8ueOg7siF7+pAKs0K3igiE=','','01723745689','Lamia Akter','','2022-08-17 18:32:36.690901','2022-08-17 18:32:55.078311',NULL,0,1,0,0,0),(113,'pbkdf2_sha256$260000$NtVKN7OkvMjLi1okXJKbzz$QcWwxvrD9dLjapVy/ZPyj5vsTmXKzNgWB7V3I+nnfJQ=','','01647774247','Mainouddin Ahmed','','2022-08-17 18:35:50.981743','2022-08-17 18:35:50.981804',NULL,0,1,0,0,0),(114,'pbkdf2_sha256$260000$unXiGWvUghxsOHtM46zQbw$1eA4bUp9FMUxMOZ6+ySrZY6gobMhAMvsoY1MEcmI8tc=','','01845434348','Mitali Akter','','2022-08-17 18:39:24.553031','2022-08-17 18:39:24.553093',NULL,0,1,0,0,0),(115,'pbkdf2_sha256$260000$EtIke9xfwakrzEG1HEz0E6$pkzw50onJiYovrPx8F7DaRZ7UAl9n55B4/n+d0yap8g=','','01772682271','Md. Sojb Basar','','2022-08-17 18:42:00.037058','2022-08-17 18:42:00.037118',NULL,0,1,0,0,0),(116,'pbkdf2_sha256$260000$ImCqFRmuYpQAQ4Bui2b7Ik$ldlW+BH8JwkiLb55AdGHVbFK9t4eZZQstaqfy7BvcYs=','','01795597058','Puja Saha','','2022-08-18 09:53:46.127463','2022-08-18 09:53:46.127537',NULL,0,1,0,0,0),(117,'pbkdf2_sha256$260000$6CrmvCo7X4s5RwGSWTYFm2$dg+ujg77CTiyrbFNq6DNEmQr8cCfm5qvkyRSY6KUz30=','','01760464366','Sukhi Akter','','2022-08-18 09:56:36.221981','2022-08-18 09:56:36.222045',NULL,0,1,0,0,0),(118,'pbkdf2_sha256$260000$PLxsRIK1skI7qwz5UY2x1f$3UG6iIFakYkTE/dOedzRV8UU2ATUPMDSrFVEj5soUOE=','','01754416644','Tanjila Akter','','2022-08-18 10:00:55.807345','2022-08-18 10:00:55.807443',NULL,0,1,0,0,0),(119,'pbkdf2_sha256$260000$blTdmi1acWL3LgDs759sXU$1cJraUTMGV+UFyewOTf9spJ0gKWQUPct12tgbOQ0cpw=','','01783315090','Shaharin Munny','','2022-08-18 10:37:00.988078','2022-08-18 10:37:00.988154',NULL,0,1,0,0,0),(120,'pbkdf2_sha256$260000$RDWRvgHD4afCrxnMDDJ6Mf$uNZM5/SPjZGKmQlNbulcQU1zeoSzQXFUht1T5PaQumQ=','','01791999894','Ratna Akter','','2022-08-18 10:40:30.142513','2022-08-18 10:40:30.142575',NULL,0,1,0,0,0),(121,'pbkdf2_sha256$260000$XLMLLXMD37aZ9mh9I6h5f9$2CaDa7dNAklW6qcKHtW5EU+tLYHkoaGLUAAyQzMPNaI=','','01997328960','Krttikar Chinmoyee karipa','','2022-08-18 10:43:27.577202','2022-08-18 10:43:27.577264',NULL,0,1,0,0,0),(122,'pbkdf2_sha256$260000$ksNbR89LQpxdgyzTXXvsbN$bt4D18h/VavXNfDKWFIrQOqgaYLmnZYqeJ2EAiJY/5g=','','01303642969','Jania Akter Jim','','2022-08-18 10:52:28.857291','2022-08-18 10:52:28.857349',NULL,0,1,0,0,0),(123,'pbkdf2_sha256$260000$K8b9U7aE7in4V7COmqJgfm$86Ck8U6jUHYXAfXDyEpltEIuKLXHE5MepD+hFcvZUk0=','','01747710469','Samiya Akter','','2022-08-18 10:56:54.563932','2022-08-18 10:56:54.563995',NULL,0,1,0,0,0),(124,'pbkdf2_sha256$260000$0q9JSP7AFn6KYs6mKenNbl$GT5D7+n7eSdgAlAJ1N6WpkApVhCY565/d/tINcAd9Ng=','','01732005800','Onona Jahan Tithi','','2022-08-18 10:59:30.210095','2022-08-18 10:59:30.210154',NULL,0,1,0,0,0),(125,'pbkdf2_sha256$260000$YG1eznYnZ8dTCS23LsW6cw$eR9a071CQm21nNnkS3kcXB6WsoiUzdA6pnn55Mg9DFw=','','01946900675','Prionty Saha','','2022-08-18 11:02:46.106878','2022-08-18 11:02:46.106940',NULL,0,1,0,0,0),(126,'pbkdf2_sha256$260000$RdG2AeO3LuUICwbGVohfwG$c5VTLrw+FJDHu8mcurSwN+h4JWWu0SsMyIt6wuBEaK8=','','01727534662','MdShaphyqul Eslam Khan','','2022-08-18 11:06:30.817811','2022-08-18 11:06:30.817871',NULL,0,1,0,0,0),(127,'pbkdf2_sha256$260000$cfWxem0ZSU6LsV4Qp4wMDy$9Q+NSVNVH6ypump4CWc7sjp0F65ZljYtE7aIFoDiOUI=','','01770334436','Mahfuzur Rahman','','2022-08-18 11:10:25.596315','2022-08-18 11:10:25.596376',NULL,0,1,0,0,0),(128,'pbkdf2_sha256$260000$nWfs8VzRVBdzvhV1YYPY5Z$+Rt7eTB+rCueNU5TmVeLTjfuDruRm4sc5XnVxjEI0fM=','','01718568820','Ishrat Zarin','','2022-08-18 11:15:15.796555','2022-08-18 11:15:15.796614',NULL,0,1,0,0,0),(129,'pbkdf2_sha256$260000$OZqpYRJj0BRb5osXvghUqz$7YbzPg0ujcR0g6xDlWTrhqZEHTaqn/jUnqHhbg4r1wc=','','01302693025','Jarin Jahan Eisha','','2022-08-18 14:12:28.249319','2022-08-18 14:12:28.249381',NULL,0,1,0,0,0),(130,'pbkdf2_sha256$260000$HvJab8FYMMwp06MbOM5kN6$FjLOJXLJyEhUOjB0dgph+uzZEQUeDvOecO4cAvX2lQc=','','01406964112','Runa Akter','','2022-08-18 14:29:11.341083','2022-08-18 14:29:11.341140',NULL,0,1,0,0,0),(131,'pbkdf2_sha256$260000$fhHcyz2eMDJr9scwWxvVk5$1xC0NpCzAEzRMYFPOLUAvHjAy0o2y7+BuwtuAlKDCOk=','','01794211862','Habiba Akter','','2022-08-18 14:32:38.831927','2022-08-18 14:32:38.831984',NULL,0,1,0,0,0),(132,'pbkdf2_sha256$260000$z1iAQXWvSc5eZGyKk6AIGa$jZEqESvgYXHvqttT2X7CK4i0dTqRhmRaI+LsvbRSjvk=','','01799357937','Arifa Akter','','2022-08-18 14:35:23.784571','2022-08-18 14:35:23.784629',NULL,0,1,0,0,0),(133,'pbkdf2_sha256$260000$16TFaIpnNrVbyykjdLfblz$PUTwaqFifbuYznnDFL+B+VIWkdNu/StTWEsla45bXcQ=','','01786065724','Salman Hossain','','2022-08-18 14:39:44.909694','2022-08-18 14:39:44.909753',NULL,0,1,0,0,0),(134,'pbkdf2_sha256$260000$VQ7c3JyWZQKr8oSMFfzpll$1CfNaiLCsEs0/X69lVGeHhdM7o2/gr/zGWWor+YgtxA=','','01956962690','Sumaiya Akter Mim','','2022-08-18 14:43:28.294465','2022-08-18 14:43:28.294530',NULL,0,1,0,0,0),(135,'pbkdf2_sha256$260000$tMqdi8x1h89VKikjRzfyUZ$Lp9KayFE5YWkvSCLolmNMhRnF1sBV93CR0gjpaYTafs=','','01792954094','Md. Shoriful Islam','','2022-08-18 14:46:37.932976','2022-08-18 14:46:37.933037',NULL,0,1,0,0,0),(136,'pbkdf2_sha256$260000$wXZvBn6s1neGI6eDiT22dY$w6ByuSVOIBEUzH1qck3L5NNmJN1XyKcRXAFygZf7KlU=','','01751435760','Sanjida','','2022-08-21 12:22:18.751775','2022-08-21 12:22:58.085040',NULL,0,1,0,0,0),(137,'pbkdf2_sha256$260000$kVl940YBEzKdHNEFcVKJ8v$MWm+C11xiqDIxMEyE1SbLkglbbOTf+V+w0Rv+M04ehQ=','','01914670587','Shanta Islam Mim','','2022-08-21 12:25:02.625300','2022-08-21 12:25:02.625393',NULL,0,1,0,0,0),(138,'pbkdf2_sha256$260000$wloBbSCo2dnV2rRdE8PXVj$V4denvI9d9zt8A1tckD0dhSR+5MTF1N+V//FG69zj5w=','','01310644033','Md.Nasim','','2022-08-21 12:28:27.593083','2022-08-21 12:28:27.593141',NULL,0,1,0,0,0),(139,'pbkdf2_sha256$260000$Bdb2qdGywvNvJ3gMgOfPiq$LAWQ/9e5C6EIShLOrmG8cF1WPenTrNEl2kN9tnaLmJc=','','01315942379','Tarik Jamil Junayed','','2022-08-21 12:30:54.468836','2022-08-21 12:30:54.468894',NULL,0,1,0,0,0),(140,'pbkdf2_sha256$260000$3M2tANplXTwAbay8t8pMZ5$iM0z42GeqtwpRBLV4zy+x6nv0azdeBkNi5yyv2nPwgY=','','01735525578','Konika Akter','','2022-08-21 12:33:56.838412','2022-08-21 12:33:56.838484',NULL,0,1,0,0,0),(141,'pbkdf2_sha256$260000$tMPnfgcCmSCygdppoOn3bg$dyOK1+L6FmlmV/UV++74FKXvgKGqwK6XOFkVjaznIuA=','','01821901752','Sabrina Alam','','2022-08-21 12:36:32.569980','2022-08-21 12:36:32.570037',NULL,0,1,0,0,0),(142,'pbkdf2_sha256$260000$2MBIihtk6i2VTJvbWtGwBO$emy3umStALnuERaaPtmWxqN0lax4wmO2DdNG5UPud0s=','','01321797543','Nazmin Nahar Eti','','2022-08-21 12:39:00.700211','2022-08-21 12:39:00.700272',NULL,0,1,0,0,0),(143,'pbkdf2_sha256$260000$FhMqimvMhLAXIy1g643HIB$p1Hqfc77eeRbyuYYZvBN1HE1DLgJq9liqm1cGQoXIvk=','','01742012133','Humaira Akter','','2022-08-21 12:42:04.640157','2022-08-21 12:42:04.640215',NULL,0,1,0,0,0),(144,'pbkdf2_sha256$260000$QLfDRoMwM4eP2Vw2LVqwQO$J5vBHGDIB77nC9UG1E4wt4QttPVcZgc9HNVkpZQxfL8=','','01320904465','Mansura Akter','','2022-08-21 12:45:17.912641','2022-08-21 12:45:17.912702',NULL,0,1,0,0,0),(145,'pbkdf2_sha256$260000$LZz6SNpV8etnCSyPbl8bCR$bY3Yf07Gu7tszwiJlUqky2qtBipcdQcqlvDUJll9kic=','','01752320978','Methila Khanom Mim','','2022-08-21 12:48:21.268001','2022-08-21 12:48:21.268062',NULL,0,1,0,0,0),(146,'pbkdf2_sha256$260000$4eSP25Ba1kPC9HxqrJyKUl$O+5Lxf5NBLtly2rGXOsnvWsd8NpaJPVe4ol+Yq4OaUc=','','01611947862','Shila Moni','','2022-08-21 12:50:33.394251','2022-08-21 12:50:57.873351',NULL,0,1,0,0,0),(147,'pbkdf2_sha256$260000$MfmRgZbhc3Y9z5K9ww9wXD$Go9ff/DpUVQ1NOPVYDYE8RfOHHCv/CT7CaQzresJX5E=','','01864563015','Shahriar Chowdhury','','2022-08-21 12:54:07.520609','2022-08-21 12:54:07.520668',NULL,0,1,0,0,0),(148,'pbkdf2_sha256$260000$eeUl4HJoXZxaiSarHIxA3m$dw0557+2WwTe4QJVQm2DwKRV+4xPPQ7U/RpQ6fmJHY8=','','01943561253','Nabajoyti Ghoshal Kabya','','2022-08-21 12:57:25.412367','2022-08-21 12:57:25.412425',NULL,0,1,0,0,0),(149,'pbkdf2_sha256$260000$Djp52Imx9U7T7AEEaX96y9$jtFrIY/2Gvc0Y7uO3QRCeh+RqcmDcUZlx9Gu78SXALw=','','01710318558','Safia bintay Sara','','2022-08-21 13:00:09.415943','2022-08-21 13:00:09.416004',NULL,0,1,0,0,0),(150,'pbkdf2_sha256$260000$6tomXxPFfRLdXydg2R1Wy5$34NgukGYrnA7wo6OMnk0Sy4iV3XqQ8LK/KvoPP2NSBs=','','01718898112','Rahul Karmaker','','2022-08-21 13:06:35.429164','2022-08-21 13:06:35.429270',NULL,0,1,0,0,0),(151,'pbkdf2_sha256$260000$j4zCCt7xi4Kuzui0CpYC6c$fhB/FYmH6v2KpQxxPZ7F71/7tkIdlUfrKzJp5c7RuMw=','','017102201715','Md.  Rifat Molla','','2022-08-21 13:24:09.679004','2022-08-21 13:24:09.679064',NULL,0,1,0,0,0),(152,'pbkdf2_sha256$260000$q9LxfGuR3Y0HSNlVPe7dzy$9aJvUhB7LIP8Z25WpSNHToPwCDZP8jRqMoBYc+OWhpk=','','0175395248','Jahan Tajbi','','2022-08-22 10:47:34.045651','2022-08-22 10:47:34.045732',NULL,0,1,0,0,0),(153,'pbkdf2_sha256$260000$Z6fK9I5Og7nIqhzPOvweEE$ZL5YlU8C1Fr9paFv43tLdfab63fMZSJSTuFq4Ppzo20=','','01777354830','Sadia Islam','','2022-08-22 10:51:35.307252','2022-08-22 10:51:35.307313',NULL,0,1,0,0,0),(154,'pbkdf2_sha256$260000$ah6gNAf5HbdEI6rb1C0ZPF$UHpXooCoWfL3sL6yuQ/PqgNfqcf8xmEvzJXrhA/2eZM=','','01313214324','Sadia Islam Hera','','2022-08-22 10:54:28.897364','2022-08-22 10:54:28.897420',NULL,0,1,0,0,0),(155,'pbkdf2_sha256$260000$bqkfz7QxecAYhV7JPrfK9H$9hpuRZPvQ8VN9mxafpSTiPhB1gNGYoeJvK01xl8XVSc=','','01816309757','Mst Fatema Tujj Zohora','','2022-08-22 10:57:29.182614','2022-08-22 10:57:29.182672',NULL,0,1,0,0,0),(156,'pbkdf2_sha256$260000$uk2HI0rW4GTOhlS1fpAsgP$jTKutO+5myHOvDms4qoGXUJ0pCcdNJjREAYQ4sQXOq8=','','01930208396','Upama Adhikary Riya','','2022-08-22 11:00:42.920170','2022-08-22 11:00:42.920226',NULL,0,1,0,0,0),(157,'pbkdf2_sha256$260000$S6xphb2c7bTQCquSUHp05E$yjQP2wduK66WLckzhDDlJySSzb8aliiF1TqwfsO8Tvs=','','01791271376','Shorna','','2022-08-22 11:03:46.831302','2022-08-22 11:03:46.831359',NULL,0,1,0,0,0),(158,'pbkdf2_sha256$260000$9yAixdZA4dvgGf2hSq02MI$pzVFy1zMh48uhTc6TGJyIU38fgI3dUG7A6qyi428sgY=','','01709690529','Md Motaleb Hossain','','2022-08-22 11:06:50.433465','2022-08-22 11:06:50.433524',NULL,0,1,0,0,0),(159,'pbkdf2_sha256$260000$9BVdpYAuuRCetIRNbNdP0F$iCTH+fRzHFlp3JfvrbEU+el3V9iG9+IMxCIcJxCPxeU=','','01816196389','Md Samcul haque','','2022-08-22 11:10:37.680917','2022-08-22 11:10:37.680975',NULL,0,1,0,0,0),(160,'pbkdf2_sha256$260000$JMNSKPaV05pSYvqtPa0Tqb$UdW8OlnK8taBj1mp0oOhIk1NHUCditI9eKOwxGg8JZo=','','01319622802','mahfiz ahmed','','2022-08-22 11:13:59.322732','2022-08-22 11:13:59.322790',NULL,0,1,0,0,0),(161,'pbkdf2_sha256$260000$FiOmDeDXTaQTqIcBlMgnRB$+cFlanXkoO5tIaxtAHkS535N0j4Tw4+voTWzs0wUyfQ=','','01955222127','Munny Akter','','2022-08-22 12:37:51.941952','2022-08-22 12:38:40.539176',NULL,0,1,0,0,0),(162,'pbkdf2_sha256$260000$r6QQWtpTtI9b8Yu9kVJnDb$JUWHtRm9HBx59i54mQXz0gJnYHoFvKhV8YzvS7Fqk0A=','','01323634753','Nayemur Rahman','','2022-08-28 10:13:17.209530','2022-08-28 10:13:17.209594',NULL,0,1,0,0,0),(163,'pbkdf2_sha256$260000$8bWY8ru6kkb81IVQzxlSay$/2JR0HJ9vR3UvG0XrdbvnzJ/DpBa/514lacddmg5jJA=','','01820941036','Abulkhair Rohan','','2022-08-28 10:22:40.935053','2022-08-28 10:22:40.935114',NULL,0,1,0,0,0),(164,'pbkdf2_sha256$260000$9pQuaXKkvmvrwrFhTXgOSo$/TyHomSLEPVo7/JyjzsAnwd21TE2KHFkMK9SP9jklyQ=','','01795709896','Lamiya Akter','','2022-08-28 10:25:38.547797','2022-08-28 10:25:38.547855',NULL,0,1,0,0,0),(165,'pbkdf2_sha256$260000$3ajo1xgQPOBntNZ1VIIMY4$KSyn07lOSexfes4TSwcjkw7hKttG/3EawOPQWVLwS7c=','','01733562320','Tasmin Aktary','','2022-08-28 11:16:07.346585','2022-08-28 11:16:07.346663',NULL,0,1,0,0,0),(166,'pbkdf2_sha256$260000$HbxsLkRQNfHDIhu0mSzIdy$YsM+IVoIQVBgnuacotBmYJ6sN0xyZ8ZpTnvySsYu+Ng=','','01314020755','Anwara','','2022-08-28 11:19:18.262755','2022-08-28 11:19:18.262847',NULL,0,1,0,0,0),(167,'pbkdf2_sha256$260000$LZs4zo5IT9BR7YjfiIktSi$TY749NOdEPlWQkAM+au6po+ISGokzPDg9xu+Nq9RgRE=','','01303525166','Keya mini','','2022-08-28 11:21:29.011685','2022-08-28 11:31:40.676520',NULL,0,1,0,0,0),(168,'pbkdf2_sha256$260000$uihSORTgKOja01nYmSSef2$pCUStkBb32SiIM+b2P1ZRv3nMga1uoK/h1RixX2/fZ8=','','01308872649','Preantu Saha','','2022-08-28 11:23:56.157178','2022-08-28 11:23:56.157245',NULL,0,1,0,0,0),(169,'pbkdf2_sha256$260000$gr08WNBdtnw6aSYavcJ7ht$oWDa+o9NcwAlWvGJfUcBxlCL24XNe3uNOaSSEErCuAY=','','0173669291','Banna','','2022-08-28 11:26:40.724328','2022-08-28 11:27:42.736489',NULL,0,1,0,0,0),(170,'pbkdf2_sha256$260000$NdVUuK4B1KNrtxFLLJ45yM$xxfFph6lidCwh6KVZaNiq/B7QRPaBFo1x0ngzcqOe68=','','01740964368','Fatema Akter','','2022-08-28 11:31:10.024866','2022-08-28 11:31:10.024927',NULL,0,1,0,0,0),(171,'pbkdf2_sha256$260000$Q3depMftG4YH7yAw6VfssE$B4gl72siYvWdiiZwMcYTjBBbj3nBBEr20UVQ3X23CXg=','','01795501132','Hamida Akter','','2022-08-28 15:22:17.561223','2022-08-28 15:22:17.561280',NULL,0,1,0,0,0),(172,'pbkdf2_sha256$260000$dtPb3iDy3phyvCNfjaVHIe$nuIenXvRXm9w32fZoBmIPA0Lp7tiTcN0gukViVpexp4=','','01304063113','Shammi Akter','','2022-09-02 10:59:32.206448','2022-09-02 10:59:32.206508',NULL,0,1,0,0,0),(173,'pbkdf2_sha256$260000$IHTs7CArtsNFSc26vv7KhF$1+i6MmUiNAGL8TiZlh3f2L53nXwsEt72xELPD/FCi1s=','','01309355070','Sadia Farhana','','2022-09-02 11:06:01.468484','2022-09-02 11:06:01.468543',NULL,0,1,0,0,0),(174,'pbkdf2_sha256$260000$snOp1rApFaMOKi3WaR2Mog$sfW2VTqhtc25QWmHx3F/AL+1iHTbAGCk9tVDR7W8wlY=','','01791726376','Suriya Akter','','2022-09-02 11:08:54.908021','2022-09-02 11:08:54.908080',NULL,0,1,0,0,0),(175,'pbkdf2_sha256$260000$lEVrR44z8xXHpvlDi5RfFZ$cGcMG2ahVl/98JHkEdB7IjZYQMXhzlU+jMFkU6CA144=','','01704984623','Nadia Akter','','2022-09-02 11:15:20.688344','2022-09-02 11:18:22.669090',NULL,0,1,0,0,0),(176,'pbkdf2_sha256$260000$4jpRYk55cIw99aqe7oPcfW$e5BmOFTeaT5x0Z7MYlv2yGvFuaKCkzPgClOFMbMVoFE=','','01725893406','K.M Jubayer Hasan','','2022-09-02 11:17:59.271000','2022-09-02 11:18:50.916555',NULL,0,1,0,0,0),(177,'pbkdf2_sha256$260000$qeqGbeBDqReaPxs7IveiQW$n6YK2d7e3pLnDzywsCdbYHtMEfpsWhaX2PCYOBIv8aI=','','01723361951','Sumaiya Akter','','2022-09-02 11:21:44.726790','2022-09-02 11:21:44.726868',NULL,0,1,0,0,0),(178,'pbkdf2_sha256$260000$BFSI7jOB3njyg7zgResWfp$iKpNe8qrG6JiVqR6wQKl2VaMgoliFZQhJjy9AX6Q8As=','','01867353297','Puja Rani sarker','','2022-09-02 11:25:18.707056','2022-09-02 11:25:18.707128',NULL,0,1,0,0,0),(179,'pbkdf2_sha256$260000$8jPaesfwRBp9r7FKkTL0vw$ZCsFll3M1E/Cv2LEL4GSHh3jegBorZ7xzEYL47KBS1M=','','01867254907','Mariam Khan','','2022-09-02 11:27:30.874883','2022-09-02 11:27:30.874957',NULL,0,1,0,0,0),(180,'pbkdf2_sha256$260000$z2HrgH1UV6Jh4IR9fjv1M5$EO4r3ErKcoKinCsP/+tiflrJsDhOMuNgoymyeCU/WjI=','','01756502276','Kaif Mia','','2022-09-02 11:39:57.030372','2022-09-02 11:39:57.030429',NULL,0,1,0,0,0),(181,'pbkdf2_sha256$260000$deDEXnIJ500MEGrb0S1v23$tDoPBSEgxBtgM364Tn8qim9w0UBmZWRY9sUmfy23EmA=','','01775262603','Habibur Sek','','2022-09-02 11:42:32.885101','2022-09-02 11:42:32.885159',NULL,0,1,0,0,0),(182,'pbkdf2_sha256$260000$8Xh6Fm5o4awFuPLNAuhejf$512mX6iw7ViixtRemRPw3oZ8mBzJo3o11rtpAGT5a9I=','','01703556561','Runack jahan Kanta','','2022-09-02 11:45:10.932620','2022-09-02 11:45:10.932680',NULL,0,1,0,0,0),(183,'pbkdf2_sha256$260000$Tgvi1vWWqG6bdtSAZCQdZC$P7QsMZeaATOi9C3QtXs12bIEVQYY6W8AQ/HuulrnBaE=','','01788404961','Rownanak jahan Neela','','2022-09-02 11:47:33.563992','2022-09-02 11:47:33.564050',NULL,0,1,0,0,0),(184,'pbkdf2_sha256$260000$cXHAIPWtl78E5F8W97PwXL$H974bnUFDqn2OJ2IZl/e+QwxTkQ2pey+k5s+DWipzHQ=','','01608149434','Dilruba Hasan Snaha','','2022-09-02 11:49:59.632432','2022-09-02 11:49:59.632510',NULL,0,1,0,0,0),(185,'pbkdf2_sha256$260000$GD7avLoF1VYrTcxDgATVSW$/tkm8wTl2c5rhgV2jEi1XFAB3qCGk6KpkJlR3+4/hxg=','','01842082237','Md Tawhidur Rahman','','2022-09-02 11:52:19.595474','2022-09-02 11:52:19.595535',NULL,0,1,0,0,0);
/*!40000 ALTER TABLE `account_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_batch`
--

DROP TABLE IF EXISTS `account_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_batch` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `fee` decimal(10,2) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `organization_id` bigint NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `title` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_batch_organization_id_729c2524_fk_account_o` (`organization_id`),
  CONSTRAINT `account_batch_organization_id_729c2524_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_batch`
--

LOCK TABLES `account_batch` WRITE;
/*!40000 ALTER TABLE `account_batch` DISABLE KEYS */;
INSERT INTO `account_batch` VALUES (1,'Science-22',15000.00,'','demo description for website',5000.00,'2022-07-25 18:27:47.757286','2022-07-30 19:27:55.942631',1,1,'Science admission batch'),(2,'B-1',17000.00,'','শুধুমাত্র মানবিক',4000.00,'2022-08-02 18:18:55.316351','2022-08-02 18:18:55.316410',2,1,'Arts 1'),(3,'Advance 1st Year',10000.00,'','Advance 1st Year',2000.00,'2022-08-04 15:23:36.419142','2022-08-04 15:24:29.565369',2,1,'Ad 1st (03.30)'),(4,'Advance 2nd Year',0.00,'','Seminar Booking',0.00,'2022-08-06 13:10:00.759182','2022-08-06 13:10:11.592374',2,1,'Advance 2nd Year Seminar'),(5,'Advance Booking-For Admission A Unit',18000.00,'','Science Unit',4000.00,'2022-08-06 17:10:26.378231','2022-08-06 17:15:02.042210',2,1,'Admission A Unit'),(6,'Advance Booking- Admission B Unit',17000.00,'','Humanities',4000.00,'2022-08-06 17:11:48.973357','2022-08-06 17:15:11.223317',2,1,'B Unit'),(7,'Advance Booking - For admission C Unit',18000.00,'','Business Studies',4000.00,'2022-08-06 17:13:19.778478','2022-08-06 17:15:23.711810',2,1,'C Unit');
/*!40000 ALTER TABLE `account_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_organization`
--

DROP TABLE IF EXISTS `account_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_organization` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(150) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `account_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organization_name` (`organization_name`),
  UNIQUE KEY `account_id` (`account_id`),
  CONSTRAINT `account_organization_account_id_201d42b8_fk_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_organization`
--

LOCK TABLES `account_organization` WRITE;
/*!40000 ALTER TABLE `account_organization` DISABLE KEYS */;
INSERT INTO `account_organization` VALUES (1,'Demo Coaching','BD','2022-07-25 18:13:00.426041','2022-07-25 18:13:00.426085',2),(2,'Tusher\'s Care','Jhiltuli,Faridpur','2022-07-31 11:21:04.625062','2022-07-31 11:22:14.627010',9);
/*!40000 ALTER TABLE `account_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_staff`
--

DROP TABLE IF EXISTS `account_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_staff` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` decimal(10,2) NOT NULL,
  `address` varchar(15) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `account_id` bigint NOT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`),
  KEY `account_staff_organization_id_a6bf1661_fk_account_o` (`organization_id`),
  CONSTRAINT `account_staff_account_id_90c89555_fk_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `account_staff_organization_id_a6bf1661_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_staff`
--

LOCK TABLES `account_staff` WRITE;
/*!40000 ALTER TABLE `account_staff` DISABLE KEYS */;
INSERT INTO `account_staff` VALUES (1,500.00,'BD','2022-07-26 17:53:07.041208','2022-07-30 11:47:04.698442',6,1),(2,0.00,'abc','2022-07-28 18:48:22.963977','2022-07-28 18:48:22.964046',8,1);
/*!40000 ALTER TABLE `account_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_student`
--

DROP TABLE IF EXISTS `account_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_student` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` decimal(10,2) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `group` varchar(100) DEFAULT NULL,
  `parent_mobile` varchar(15) NOT NULL,
  `college_name` varchar(500) DEFAULT NULL,
  `hsc_group` varchar(50) DEFAULT NULL,
  `hsc_year` varchar(50) DEFAULT NULL,
  `hsc_roll` varchar(100) DEFAULT NULL,
  `hsc_gpa` decimal(5,2) DEFAULT NULL,
  `ssc_group` varchar(50) DEFAULT NULL,
  `ssc_year` varchar(50) DEFAULT NULL,
  `ssc_roll` varchar(100) DEFAULT NULL,
  `ssc_gpa` decimal(5,2) DEFAULT NULL,
  `registration_number` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `account_id` bigint NOT NULL,
  `batch_id` bigint NOT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`),
  KEY `account_student_batch_id_008067b5_fk_account_batch_id` (`batch_id`),
  KEY `account_student_organization_id_79bee6a8_fk_account_o` (`organization_id`),
  CONSTRAINT `account_student_account_id_ab37d766_fk_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `account_student_batch_id_008067b5_fk_account_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `account_batch` (`id`),
  CONSTRAINT `account_student_organization_id_79bee6a8_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_student`
--

LOCK TABLES `account_student` WRITE;
/*!40000 ALTER TABLE `account_student` DISABLE KEYS */;
INSERT INTO `account_student` VALUES (1,-7000.00,'BD','group -1','0175733773',NULL,'Science','2019','638383',5.00,'Science','2017','62727',5.00,'8283939','2022-07-25 18:29:13.448680','2022-07-27 19:20:06.189504',3,1,1),(2,-3500.00,NULL,'B-1','01718990172',NULL,'Science',NULL,NULL,NULL,'Science',NULL,NULL,NULL,'1510428309','2022-07-26 13:01:30.285375','2022-08-15 09:12:45.430556',4,1,1),(4,-13000.00,'y','Arts','01777736985',NULL,'Commerce','55','66',55.00,'Commerce','5','55',2.00,'56','2022-08-02 18:21:29.797124','2022-08-02 18:21:29.797188',12,2,2),(5,0.00,'hh','Arts','01755966950',NULL,'Science',NULL,'55',5.00,'Science','55','55',66.00,'55','2022-08-02 18:28:17.756961','2022-08-02 18:45:14.549290',13,2,2),(6,-5000.00,'Jheeltuly Faridpur','Ad Bangla+ English','01703494320',NULL,'Arts','00','00',0.00,'Arts','00','00',0.00,'000','2022-08-04 15:27:14.563545','2022-08-04 15:30:00.751437',15,3,2),(7,-8000.00,'Alipur Faridpur','Arts','01537277592',NULL,'Arts','00','00',0.00,'Arts','00','00',0.00,'00','2022-08-04 17:31:20.654509','2022-08-04 17:31:20.654606',16,3,2),(8,-8000.00,'Durjonkhar Dangi',NULL,'01779189895',NULL,'Science',NULL,NULL,NULL,'Science','2021','160241',5.00,'1810596442','2022-08-06 12:52:41.332028','2022-08-06 12:52:41.332084',17,3,2),(9,-8000.00,'Momin Khar hat, Faridpur',NULL,'01799334174',NULL,'Science',NULL,NULL,NULL,'Science','2021','160243',4.72,'000','2022-08-06 12:59:42.035965','2022-08-06 12:59:42.036020',18,3,2),(10,-8000.00,'Mominkhar hat,Faridpur','ad','01786284805',NULL,'Science','2022',NULL,NULL,'Science','2021','160240',5.00,'00','2022-08-06 13:03:44.844882','2022-08-06 13:03:44.844934',19,3,2),(11,-8000.00,'Gopalpur, Tepakhola, Faridpur','00','01713365754',NULL,'Science','2023',NULL,NULL,'Science','2021','108027',4.72,'00','2022-08-06 13:06:54.101483','2022-08-06 13:06:54.101550',20,3,2),(12,-4000.00,'1no habeli gopalpur,faridpur','Advance','01768427926',NULL,'Commerace','00','00',0.00,'Commerace','2021','607121',4.61,'1810954781','2022-08-06 13:10:56.843892','2022-09-04 11:04:17.024329',21,3,2),(13,0.00,'Onathermor','Seminar 2nd year','01780206882',NULL,'Science','2022','204643',NULL,'Science','2020','162244',5.00,'00','2022-08-06 13:14:13.098662','2022-08-06 13:14:13.098766',22,4,2),(14,-8000.00,'1 NO Habili Gopalpur, Faridpur','00','01767414940',NULL,'Arts','00',NULL,NULL,'Arts','2021','372592',4.78,'1810597699','2022-08-06 13:15:10.064536','2022-08-06 13:15:10.064708',23,3,2),(15,0.00,'Singpara Faridpur','Seminar 2nd year','01736276716',NULL,'Science','2022','204749',NULL,'Science','2020','178196',5.00,'00','2022-08-06 13:19:39.893981','2022-08-06 13:19:39.894048',24,4,2),(16,0.00,'Sadar pur, Faridpur','Seminar 2nd year','01714665906',NULL,'Science','2022','00',NULL,'Science','2020','162380',5.00,'1710405551','2022-08-06 13:22:36.896650','2022-08-06 13:22:36.896718',25,4,2),(17,-8000.00,'Faridpur','00','01761523739',NULL,'Science','2023','00',0.00,'Science','2021','00',5.00,'000','2022-08-06 13:24:44.320146','2022-08-06 13:24:44.320194',26,3,2),(18,0.00,'Baliakandi,Faridpur','Seminar 2nd year','01771582488',NULL,'Science','2022','204586',NULL,'Science','2020','174722',5.00,'00','2022-08-06 13:26:45.246699','2022-08-06 13:26:45.246812',27,4,2),(19,-8000.00,'South jhiltuli Faridpur','00','01407511422',NULL,'Arts','2023','00',0.00,'Arts','2021','00',5.00,'00','2022-08-06 13:29:21.916759','2022-08-06 13:29:21.916874',28,3,2),(20,0.00,'jhiltuli, Faridpur','Seminar 2nd year','00',NULL,'Science','2022','00',NULL,'Science','2020','161721',5.00,'00','2022-08-06 13:29:46.062028','2022-08-06 13:29:46.062079',29,4,2),(21,0.00,'Jhiltuli, Faridpur','Seminar 2nd year','01717822872',NULL,'Science','2020',NULL,NULL,'Science','2020','161694',5.00,'171040414175','2022-08-06 13:32:01.997246','2022-08-06 13:32:01.997303',30,4,2),(22,-8000.00,'Tita, Alfadanga, Faridpur,  Faridpur','00','01922422359',NULL,'Arts','2023',NULL,NULL,'Science','2021','173850',4.78,'1763850','2022-08-06 13:32:50.765168','2022-08-06 13:32:50.765216',31,3,2),(23,-8000.00,'West Garakhula,  Modi khaki Faridpur','00','01712703496',NULL,'Science','00','00',0.00,'Science','2020','00',5.00,'00','2022-08-06 13:37:08.436124','2022-08-06 13:37:08.436173',32,3,2),(24,-8000.00,'Farifpur,Shodor, Faridpur','00','01798485601',NULL,'Science','2023','00',0.00,'Science','2021','00',5.00,'1810551558','2022-08-06 13:39:50.937259','2022-08-06 13:39:50.937304',33,3,2),(25,0.00,'Chorkomlapur, Faridpur','Seminar','01764092609',NULL,'Science','00',NULL,NULL,'Arts','00','00',4.78,'00','2022-08-06 13:52:40.942642','2022-08-06 13:52:40.942693',34,4,2),(26,-8000.00,'Alfadanga, Faridpur','00','01746929401',NULL,'Science','2023','00',0.00,'Arts','2021','159136',4.78,'1810572737','2022-08-06 13:52:56.158848','2022-08-06 13:52:56.158905',35,3,2),(27,0.00,'1no habeli Gopalpur','Seminar 2nd year','00',NULL,'Science','2022','00',NULL,'Science','2020',NULL,4.83,'00','2022-08-06 13:55:33.664188','2022-08-06 13:55:33.664235',36,4,2),(28,-8000.00,'Madaripur, Shibchor','00','01754375262',NULL,'Arts','2023','00',0.00,'Science','2021','00',4.61,'1810552754','2022-08-06 13:55:39.489632','2022-08-06 13:55:39.489687',37,3,2),(29,-8000.00,'Jail tull','advance Fast year','01402048382',NULL,'Arts','2023','00',0.00,'Arts','2021','422272',4.11,'1810560456','2022-08-06 14:00:14.720078','2022-08-06 14:00:14.720188',38,3,2),(30,0.00,'Guho lokkhipur, Faridpur','Seminar 2nd year','01792029997',NULL,'Arts','2022','203615',NULL,'Science','2020','177902',4.94,'1710325417','2022-08-06 14:01:35.751437','2022-08-06 14:01:35.751503',39,4,2),(31,0.00,'Jhiltuli, Faridpur','Seminar 2nd year','01753987096',NULL,'Science','2022','00',0.00,'Science','2020','161671',5.00,'00','2022-08-06 14:07:12.557978','2022-08-06 14:07:12.558026',40,4,2),(32,-8000.00,'Aliabad, Faridpur','Advance','01751975556',NULL,'Arts','00','00',0.00,'Science','2021','22305',4.72,'11','2022-08-06 14:07:33.488301','2022-08-06 14:07:33.488368',41,3,2),(33,0.00,'pion coloni','Seminar 2nd year','00',NULL,'Commerce','2022','00',0.00,'Commerce','2020','617955',4.61,'1710403353','2022-08-06 14:10:02.365411','2022-08-06 14:10:02.365479',42,4,2),(34,-8000.00,'jhil tuli, Faridpur','advance','01716557466',NULL,'Science','2023','00',0.00,'Arts','2021','160761',5.00,'1810518868','2022-08-06 14:11:14.101057','2022-08-06 14:11:14.101123',43,3,2),(35,-8000.00,'Maherpur','Advance','01784757403',NULL,'Science','2023','00',0.00,'Science','2021','00',4.89,'00','2022-08-06 14:14:16.420708','2022-08-06 14:14:16.420775',44,3,2),(36,0.00,'Jhiltuli Faridpur','Seminar 2nd year','01948349981',NULL,'Science','2022','00',NULL,'Science','2020','165933',5.00,'1710377772','2022-08-06 14:15:01.137730','2022-08-06 14:15:01.137803',45,4,2),(37,-8000.00,'Goldangi Faridpur','advance Fast year','01302762606',NULL,'Arts','2023','00',0.00,'Arts','2021','00',3.50,'00','2022-08-06 14:16:58.797087','2022-08-06 14:16:58.797132',46,3,2),(38,-8000.00,'Shovarampur, Faridpur','advance Fast year','01730263304',NULL,'Arts','2023','00',0.00,'Arts','00','00',4.67,'00','2022-08-06 14:19:52.594888','2022-08-06 14:19:52.594994',47,3,2),(39,0.00,'Niltuli, Faridpur','Seminar 2nd year','00',NULL,'Science','2022','00',0.00,'Science','2020','119664',5.00,'00','2022-08-06 14:20:47.979548','2022-08-06 14:20:47.979635',48,4,2),(40,-8000.00,'Boalmari, Faridpur','advance Fast year','01303275299',NULL,'Science','2023','00',0.00,'Arts','2021','00',4.72,'00','2022-08-06 14:23:49.299474','2022-08-06 14:23:49.299565',49,3,2),(41,-8000.00,'Rothkhola,  Faridur','advance Fast year','01716360298',NULL,'Arts','2023','00',0.00,'Science','2021','620179',4.83,'00','2022-08-06 14:26:51.790121','2022-08-06 14:27:34.989995',50,3,2),(42,0.00,'Tepakhola','Seminar 2nd year','00',NULL,'Science','2022','00',0.00,'Science','2020','00',4.83,'00','2022-08-06 14:27:33.323852','2022-08-06 14:27:33.323928',51,4,2),(43,0.00,'South Jhiltuli, Faridpur','Seminar 2nd year','00',NULL,'Science','2022',NULL,NULL,'Science','2020','161781',5.00,'1710414068','2022-08-06 14:29:35.656509','2022-08-06 14:29:35.656585',52,4,2),(44,-8000.00,'Sadarpur, Faridpur','advance Fast year','01783989552',NULL,'Science','2023','00',0.00,'Arts','2021','00',5.00,'00','2022-08-06 14:30:06.371346','2022-08-06 14:30:06.371548',53,3,2),(45,0.00,'Charbhadrasan,Faridpur','Seminar','00',NULL,'Arts','202',NULL,NULL,'Arts','2020','362538',4.61,'00','2022-08-06 14:32:49.946174','2022-08-06 14:32:49.946215',54,4,2),(46,-8000.00,'warlesspara Faridpur','advance Fast year','01740424314',NULL,'Arts','2023','00',0.00,'Science','2021','00',5.00,'00','2022-08-06 14:33:17.586109','2022-08-06 14:33:17.586146',55,3,2),(47,-8000.00,'Jhil Tuli, Faridpur','advance Fast year','01757066715',NULL,'Arts','00','00',0.00,'Science','2021','170106',4.56,'00','2022-08-06 14:36:55.244170','2022-08-06 14:36:55.244276',56,3,2),(48,0.00,'Gerda','Seminar','01320915638',NULL,'Science','2022',NULL,NULL,'Science','2020','162194',4.67,'00','2022-08-06 14:37:33.007538','2022-08-06 14:37:33.007591',57,4,2),(49,0.00,'Shibrampur,Faridpur','Seminar 2nd year','1710413214',NULL,'Science','2022',NULL,NULL,'Science','2020','164444',5.00,'00','2022-08-06 14:43:54.089631','2022-08-06 14:43:54.089682',58,4,2),(50,0.00,'Sadarpur, Faridpur','Seminar 2nd year','00',NULL,'Commerce','2022',NULL,NULL,'Commerce','2020','565850',4.72,'1710366904','2022-08-06 14:48:10.707545','2022-08-06 14:48:10.707593',59,4,2),(51,0.00,'Bongram,Baliakandi,Rajbari','Seminar 2nd year','01936642030',NULL,'Science','00','00',0.00,'Science','2020','00',5.00,'1710346047','2022-08-06 14:53:50.566634','2022-08-06 14:53:50.566673',60,4,2),(52,0.00,'niramoy hospital mor,Faridpur','Seminar 2nd year','01935480203',NULL,'Science','2022',NULL,NULL,'Science','2020','191646',5.00,'1710772618','2022-08-06 14:56:11.056878','2022-08-06 14:56:11.056927',61,4,2),(53,0.00,'Bhanga, Faridpur','Seminar','01736939099',NULL,'Arts','2022',NULL,NULL,'Science','2020',NULL,4.28,'00','2022-08-06 14:58:16.938524','2022-08-06 14:58:16.938569',62,4,2),(54,0.00,'Nagarkanda,Faridpur','Seminar 2nd year','01884989148',NULL,'Science','2022',NULL,NULL,'Science','2020',NULL,5.00,'00','2022-08-06 15:04:00.490942','2022-08-06 15:04:00.490990',63,4,2),(55,0.00,'Goalchamot, Faridpur','Seminar 2nd year','01712309110',NULL,'Science','2022',NULL,NULL,'Science','2020','161737',5.00,'1710413964','2022-08-06 15:10:59.089214','2022-08-06 15:23:24.078242',64,4,2),(56,-8000.00,'west Shampur','advance Fast year','01873712493',NULL,'Arts','2023','00',0.00,'Arts','2021','373999',4.83,'1810591123','2022-08-06 15:18:52.745827','2022-08-06 15:18:52.745883',65,3,2),(57,-8000.00,'jhiltuli, Faridpur','advance Fast year','01733559904',NULL,'Science','2023','00',0.00,'Science','2021','157649',5.00,'00','2022-08-06 15:21:31.600356','2022-08-06 15:21:31.600408',66,3,2),(58,0.00,'Jhiltuli, Faridpur','Seminar 2nd year','01766742962',NULL,'Arts','2022',NULL,NULL,'Science','2020',NULL,4.61,'00','2022-08-06 15:26:08.214670','2022-08-06 15:26:08.214718',67,4,2),(59,-8000.00,'saut juiltuly Faridpur','advance Fast year','01783593503',NULL,'Science','2023','00',0.00,'Science','2023','233303',5.00,'1810521389','2022-08-06 15:28:34.745795','2022-08-06 15:28:34.745836',68,3,2),(60,0.00,'West shampur,Faridpur','Seminar 2nd year','01873712493',NULL,'Arts','2022',NULL,NULL,'Arts','2020','402282',4.89,'1710408293','2022-08-06 15:29:40.426494','2022-08-06 15:29:40.426542',69,4,2),(61,-8000.00,'Baliakandi,  Rajbari','advance Fast year','01714781163',NULL,'Science','2023','00',0.00,'Science','2021','171015',5.00,'00','2022-08-06 15:31:14.701286','2022-08-06 15:31:14.701350',70,3,2),(62,0.00,'Komlapur,Faridpur','Seminar 2nd year','00',NULL,'Arts','2022',NULL,NULL,'Science','2020',NULL,4.61,'00','2022-08-06 15:35:15.847919','2022-08-06 15:35:15.847972',71,4,2),(63,0.00,'Nogorkanda, Faridpur','Seminar 2nd year','01748316851',NULL,'Arts','2022',NULL,NULL,'Arts','2020','366474',3.50,'00','2022-08-06 15:38:16.498040','2022-08-06 15:38:16.498075',72,4,2),(64,0.00,'2no sharak,Goalchamot,Faridpur','Seminar 2nd year','01712566050',NULL,'Science','2022',NULL,NULL,'Science','2020',NULL,5.00,'00','2022-08-06 15:40:32.572643','2022-08-06 15:40:32.572721',73,4,2),(65,0.00,'Komlapur, Faridpur','Seminar 2nd year','01716186463',NULL,'Science','2022',NULL,NULL,'Science','2020','119694',4.94,'1710415599','2022-08-06 15:45:41.629207','2022-08-06 15:45:41.629254',74,4,2),(66,-8000.00,NULL,'Adv','01784248493',NULL,'Science','2022',NULL,NULL,'Science',NULL,NULL,NULL,'00','2022-08-07 14:32:59.526656','2022-09-01 14:26:45.793802',75,3,2),(67,-6000.00,'Jhiltuli','advance admission 1st year','01717822850',NULL,'Science','2023',NULL,NULL,'Science','2021','159272',4.28,'00','2022-08-09 15:27:29.347875','2022-08-09 15:28:35.707027',76,3,2),(68,-8000.00,'Jhiltuli','advance admission 1st year','01703208130',NULL,'Arts','2023',NULL,NULL,'Science','2021',NULL,NULL,'00','2022-08-09 15:35:04.913105','2022-08-09 15:35:04.913154',77,3,2),(69,0.00,'D.I.B Bottola','advance admission 1st year','01834206752',NULL,'Arts','2023',NULL,NULL,'Commerce','2021',NULL,NULL,'00','2022-08-09 17:16:51.319236','2022-08-10 14:58:12.494595',78,3,2),(70,0.00,'Chalkvabanipur','advance 2nd Year','0173584388',NULL,'Arts','2022','00',0.00,'Arts','2020','164424',5.00,'1710413091','2022-08-10 09:46:29.679090','2022-08-10 09:46:29.679148',79,4,2),(71,0.00,'chok vobani pur','000','00',NULL,'Arts','2022','00',0.00,'Science','2020','00',0.00,'00','2022-08-10 09:49:35.745566','2022-08-10 09:52:11.600036',80,4,2),(72,0.00,'boroytola Faridpur','advance','01733125374',NULL,'Science','2022','00',0.00,'Arts','2020',NULL,4.89,'00','2022-08-10 10:47:48.040096','2022-08-10 10:47:48.040173',81,4,2),(73,0.00,'weast alipur faridpur','advance','01787305286',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.50,'1710492181','2022-08-10 17:59:26.118782','2022-08-10 17:59:26.118852',82,4,2),(74,-13000.00,'Boalmary, Faridpur','Humanities','01304913194',NULL,'Arts','2020','203708',3.67,'Arts','2022',NULL,NULL,'1710399125','2022-08-10 18:18:22.602102','2022-08-10 18:18:22.602173',83,6,2),(75,-13000.00,'South Jhiltuly, Faridpur',NULL,'01768811599',NULL,'Arts','00','00',4.80,'Science','2','00',4.83,'1710415699','2022-08-10 18:24:54.778311','2022-08-10 18:24:54.778355',84,6,2),(76,-13000.00,'Vatilacpur Faridpur','advance','01760469965',NULL,'Arts','2022','00',0.00,'Science','2020','119789',4.06,'1710816312','2022-08-10 18:45:47.372864','2022-08-10 18:45:47.372914',85,6,2),(77,-13000.00,'Goalchamot, Singpara, Faridpur','advance','01734844284',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.44,'00','2022-08-10 18:50:22.048802','2022-08-10 18:50:22.048888',86,6,2),(78,-13000.00,'Momin khar hut, Faridpur','advance','01734571172',NULL,'Arts','2022','104756',0.00,'Science','2020','164756',3.94,'1710412828','2022-08-10 18:54:14.879144','2022-08-10 18:54:14.879229',87,6,2),(79,-13000.00,'West Gangabordi, Faridpur Sadar, Faridpur','advance','01721014811',NULL,'Arts','2022','00',0.00,'Science','2020','164694',4.61,'1710413831','2022-08-11 10:29:36.859996','2022-08-11 10:29:36.860044',88,6,2),(80,-13000.00,'Dhuldi Bazar','advance','01735493491',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.89,'00','2022-08-11 13:50:26.718295','2022-08-11 13:50:26.718340',89,6,2),(81,-13000.00,'Chandra Bazar,Vanga,Faridpur','Advance','01762263581',NULL,'Arts','2022','00',0.00,'Science','2020','225331',4.11,'00','2022-08-11 13:55:40.521595','2022-08-11 13:55:40.521643',90,6,2),(82,-13000.00,'Fatehabad Tuen Tower, Tatultola','Advance','01711188333',NULL,'Arts','2022','203591',0.00,'Commerce','2020','161724',5.00,'1710413995','2022-08-11 14:02:07.715962','2022-08-11 14:02:07.716024',91,6,2),(83,-13000.00,'Kanaipur','Advance','01611950576',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.94,'00','2022-08-11 14:06:15.360496','2022-08-11 14:06:15.360573',92,6,2),(84,-13000.00,'Kanaipu','Advance','01777993109',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.72,'00','2022-08-11 14:09:25.149667','2022-08-11 14:09:25.149721',93,6,2),(85,-13000.00,'Alipur,Faridpur','Advance','01715868916',NULL,'Arts','2022','00',0.00,'Science','2020','161697',5.00,'1710414152','2022-08-11 14:14:16.145800','2022-08-11 14:14:16.145854',94,6,2),(86,-13000.00,'Alipur Faridpur','advance','01791475448',NULL,'Arts','2022','00',0.00,'Arts','2022','00',0.00,'00','2022-08-11 18:34:54.107474','2022-08-11 18:34:54.107572',95,6,2),(87,-13000.00,'Kanaipur, Faridpur','advance','01743698288',NULL,'Science','2020','164099',5.00,'Arts','2022','00',0.00,'1710414842','2022-08-11 18:41:22.321413','2022-08-11 18:41:22.321459',96,6,2),(88,-13000.00,'Guholaxmipur, Toki Mollah Road Faridpur','advance','01745331434',NULL,'Arts','2022','00',0.00,'Arts','2020','00',4.44,'1718975025','2022-08-11 18:44:33.069250','2022-08-11 18:44:33.069421',97,6,2),(89,-13000.00,'Kobirpur Faridpur','advance','01768429709',NULL,'Science',NULL,NULL,NULL,'Science','2020','00',4.33,'00','2022-08-11 19:55:54.009479','2022-08-11 19:55:54.009543',98,6,2),(90,-13000.00,'oajuddin munshir dangi','advance','01795108070',NULL,'Arts','2022','00',0.00,'Science','2020','357276',3.83,'00','2022-08-11 19:59:34.617266','2022-08-11 19:59:34.617308',99,6,2),(91,-13000.00,'Weast Kapaa pur Faridpur','adveance','01660139712',NULL,'Arts','2022','00',0.00,'Science','2020','00',3.67,'1710387516','2022-08-11 20:02:16.551949','2022-08-11 20:02:16.552043',100,6,2),(92,-13000.00,'Sadirpur Faridpur','advance','01912031164',NULL,'Arts','2022','00',0.00,'Arts','2020','361269',4.22,'1710402691','2022-08-11 20:04:46.387252','2022-08-11 20:04:46.387327',101,6,2),(93,-13000.00,'Faridpur ShadorFaridpur','advance','01990336058',NULL,'Science','2022',NULL,NULL,'Science','2020','00',4.06,'00','2022-08-11 20:07:34.838747','2022-08-12 22:31:06.504874',102,6,2),(94,-9000.00,'Aliabad, Faridpur','Humanities','0174003984',NULL,'Arts','161924','00',0.00,'Science','2020','161924',4.11,'1610628334','2022-08-13 11:57:06.279912','2022-08-13 12:02:41.493853',103,6,2),(95,-7000.00,'Shadarpur, Faridpur','Advance','01306973858',NULL,'Arts','2023','00',0.00,'Science','2021','374496',4.83,'1810591358','2022-08-14 15:54:38.524092','2022-08-14 16:01:15.013432',104,3,2),(96,-11000.00,'Sadarpur Faridpur','adveance','01712649164',NULL,'Arts','2022','00',0.00,'Arts','2020','00',3.28,'00','2022-08-15 10:14:02.901142','2022-08-15 10:19:56.807685',105,6,2),(97,0.00,'chimbi gat Faridpur','adveance','01766400069',NULL,'Science','2022','00',0.00,'Science','2020','00',3.50,'00','2022-08-17 16:30:41.198079','2022-08-17 18:08:11.782553',106,7,2),(98,0.00,'jhiltuly Faridpur','advance','01736646104',NULL,'Science','2022','00',0.00,'Science','2020','203692',4.50,'00','2022-08-17 18:14:00.949739','2022-08-17 18:14:52.380488',107,6,2),(99,-13000.00,'Faridpur','advance','01803678726',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.78,'00','2022-08-17 18:18:43.679149','2022-08-17 18:18:43.679205',108,6,2),(100,-13000.00,'Faridpur  Medical','advance','01312190575',NULL,'Arts','2022','00',0.00,'Science','2020','00',3.50,'00','2022-08-17 18:20:55.098317','2022-08-17 18:20:55.098366',109,6,2),(101,0.00,'Sadarpur, Faridpur','advance','01749810902',NULL,'Arts','2022','361765',0.00,'Arts','2020','361765',0.00,'1710408634','2022-08-17 18:24:49.165658','2022-08-17 18:24:49.165705',110,4,2),(102,-13000.00,'Kushtia Khulna Bangladesh','advance','01916104032',NULL,'Arts','2022','203608',0.00,'Arts','2019','220721',4.82,'00','2022-08-17 18:28:37.486354','2022-08-17 18:28:37.486401',111,6,2),(103,0.00,'Sadar pur,  Faridpur','advance','01650153455',NULL,'Science','2020','00',0.00,'Science','0','2022',3.26,'1710408220','2022-08-17 18:32:36.696725','2022-08-17 18:32:55.075029',112,6,2),(104,-13000.00,'Sadarpur, Faridpur','Advance','01732990149',NULL,'Arts','2022','162198',0.00,'Science','2020','162198',4.06,'1710407367','2022-08-17 18:35:50.988720','2022-08-17 18:35:50.988786',113,6,2),(105,-13000.00,'Sadarpur, Faridpur','Advance','01756186863',NULL,'Science',NULL,NULL,NULL,'Arts','2020','361287',4.61,'1710407492','2022-08-17 18:39:24.558482','2022-08-17 18:39:24.558530',114,6,2),(106,-13000.00,'Sadarpur Faridpur','advance','01767913401',NULL,'Science','2022',NULL,NULL,'Science','2022','162200',4.22,'1710407369','2022-08-17 18:42:00.042632','2022-08-17 18:42:00.042680',115,6,2),(107,-13000.00,'Sovarampur','Advance','01748231725',NULL,'Arts','2022','00',0.00,'Arts','2020','00',3.83,'00','2022-08-18 09:53:46.148500','2022-08-18 09:53:46.148553',116,6,2),(108,-13000.00,'Sadarpur Faridpur','advance','01760464366',NULL,'Arts','2022','00',0.00,'Commerce','2020','559916',4.36,'1710408257','2022-08-18 09:56:36.228154','2022-08-18 09:56:36.228212',117,6,2),(109,-13000.00,'Lohatek, upzilla, charbhadrosan','advance','01715224226',NULL,'Arts','2022','00',0.00,'Arts','2020','362464',5.00,'1710405111','2022-08-18 10:00:55.813699','2022-08-18 10:00:55.813764',118,6,2),(110,-13000.00,'Loskordia Azimnogor Bhanga Faridpur','advance','01718886677',NULL,'Arts','2022','00',0.00,'Arts','2020','00',4.83,'00','2022-08-18 10:37:00.995997','2022-08-18 10:37:00.996073',119,6,2),(111,-13000.00,'Char Chand pur Sadarpur Faridpur','advance','01706535816',NULL,'Arts','2022','00',0.00,'Arts','2020','361286',5.00,'00','2022-08-18 10:40:30.148781','2022-08-18 10:40:30.148834',120,6,2),(112,0.00,'Char Kaishna Nagar, Faridpur',NULL,'01944316612',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.17,'00','2022-08-18 10:43:27.582841','2022-08-18 10:43:27.582889',121,4,2),(113,0.00,'Chon bazar Faridpur','advance','01731409400',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.89,'1710414092','2022-08-18 10:52:28.893261','2022-08-18 10:52:28.893413',122,4,2),(114,-13000.00,'Raghunandanpur, Faridpur','Advance','01706450537',NULL,'Arts','2022','00',0.00,'Arts','2020','301929',4.79,'00','2022-08-18 10:56:54.570183','2022-08-18 10:56:54.570236',123,6,2),(115,-13000.00,'Momin khar Hat Faridpur','advance','01710024739',NULL,'Arts','2022','00',0.00,'Science','0','00',4.78,'00','2022-08-18 10:59:30.217184','2022-08-18 10:59:30.217332',124,6,2),(116,-13000.00,'Faridpur','Advance','01959950081',NULL,'Arts','2022','00',0.00,'Arts','2020','442051',4.33,'00','2022-08-18 11:02:46.112938','2022-08-18 11:02:46.112996',125,6,2),(117,-13000.00,'Sadarpur, Faridpur','advance','01714563999',NULL,'Arts','2022','00',0.00,'Arts','2020','361750',5.00,'1710408729','2022-08-18 11:06:30.824528','2022-08-18 11:06:30.824584',126,6,2),(118,-13000.00,'Jhiltult Faridpur','Advance','01768429421',NULL,'Arts','2022','00',0.00,'Science','2020','162585',3.78,'1710','2022-08-18 11:10:25.603188','2022-08-18 11:10:25.603239',127,6,2),(119,-13000.00,'Alipur, Faridpur','advance','01772803638',NULL,'Arts','2022','00',0.00,'Arts','2020','369906',4.17,'00','2022-08-18 14:12:28.258137','2022-08-18 14:12:28.258223',129,6,2),(120,-13000.00,'Lohertake, Charbhdrason, Faridpur','advance','01406963358',NULL,'Arts','2022','00',0.00,'Arts','2020','362465',5.00,'1710405110','2022-08-18 14:29:11.346036','2022-08-18 14:29:11.346106',130,6,2),(121,-13000.00,'Kazi Dangi Charbhadrashon Faridpur','Advance','01731296973',NULL,'Arts','2022','00',0.00,'Arts','220','362476',4.72,'1710405079','2022-08-18 14:32:38.837768','2022-08-18 14:32:38.837832',131,6,2),(122,-13000.00,'Lohahdek, Char hades san','Advance','01783160493',NULL,'Arts','2022','00',0.00,'Arts','2020','362469',4.72,'1710405108','2022-08-18 14:35:23.791509','2022-08-18 14:35:23.791588',132,6,2),(123,-13000.00,'Kachari, Dangi, Sadarpur, Faridpur','Advance','01745696236',NULL,'Arts','2022','00',0.00,'Arts','2020','362427',4.44,'1710406496','2022-08-18 14:39:44.916043','2022-08-18 14:39:44.916090',133,6,2),(124,-13000.00,'Sadarpur Faridpur','advance','01768975955',NULL,'Arts','2020','00',0.00,'Arts','2018','162165',4.50,'00','2022-08-18 14:43:28.300191','2022-08-18 14:43:28.300238',134,6,2),(125,-13000.00,'Koyjury Tambulkhana sadar Faridpur','advance','01741482081',NULL,'Arts','2022','00',0.00,'Science','2020','120108',4.61,'1710410181','2022-08-18 14:46:37.939675','2022-08-18 14:46:37.939775',135,6,2),(126,0.00,'Sadarpur','advance','01731825154',NULL,'Science','2022','00',0.00,'Science','2020','00',4.17,'00','2022-08-21 12:22:18.765720','2022-08-21 12:22:58.081865',136,6,2),(127,-13000.00,'Sadarpur','Advance','01912057186',NULL,'Arts','2022','00',0.00,'Arts','2020','361546',4.61,'00','2022-08-21 12:25:02.661013','2022-08-21 12:25:02.661107',137,6,2),(128,-13000.00,'Nagarkanda Faridpur','advance','01718060414',NULL,'Arts','2022','00',0.00,'Science','2020','163414',4.83,'1710393022','2022-08-21 12:28:27.599115','2022-08-21 12:28:27.599177',138,6,2),(129,-13000.00,'Jhultuli Faridpur','advance','01752005806',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.78,'1710393014','2022-08-21 12:30:54.474188','2022-08-21 12:30:54.474230',139,6,2),(130,-13000.00,'Lohartake, Charbhadrason','advance','01768237218',NULL,'Arts','2022','224',0.00,'Arts','2020','362470',4.72,'1710405106','2022-08-21 12:33:56.844250','2022-08-21 12:33:56.844298',140,6,2),(131,-13000.00,'Charbhadraason, Faridpur','advance','01720029020',NULL,'Arts','2022','0',0.00,'Science','2020','162363',4.83,'1710405764','2022-08-21 12:36:32.575088','2022-08-21 12:36:32.575130',141,6,2),(132,-13000.00,'Alom Nagar Faridpur','advance','01720254096',NULL,'Science','2022','00',0.00,'Arts','2020','362472',4.50,'1710405104','2022-08-21 12:39:00.705931','2022-08-21 12:39:00.705985',142,6,2),(133,-13000.00,'Alom Nogor Charbhadrason Faridpur','advance','01745805663',NULL,'Arts','2022','00',0.00,'Arts','2020','362466',4.78,'1710405109','2022-08-21 12:42:04.645406','2022-08-21 12:42:04.645454',143,6,2),(134,-13000.00,'Charbhadrason,  Faridpur','advance','01727199285',NULL,'Arts','2022','00',0.00,'Arts','2020','362473',4.28,'1710405103','2022-08-21 12:45:17.918945','2022-08-21 12:45:17.918995',144,6,2),(135,-13000.00,'Lokman khar Dangi, Sadarpur, Faridpur','Advance','017204747442',NULL,'Arts','2022','00',0.00,'Arts','2020','362278',4.72,'1710405758','2022-08-21 12:48:21.273811','2022-08-21 12:48:21.273879',145,6,2),(136,-13000.00,'B.S Dangi, Charbhadrason Faridpur','advance','1710405767',NULL,'Arts','2022','00',0.00,'Science','2020','362274',5.00,'1710405767','2022-08-21 12:50:33.400056','2022-08-21 12:50:57.870017',146,6,2),(137,-13000.00,'Onath er mor, Faridpur','advance','01887165874',NULL,'Arts','2022','00',0.00,'Science','2020','162148',4.78,'1710406968','2022-08-21 12:54:07.526391','2022-08-21 12:54:07.526454',147,6,2),(138,-13000.00,'Jonasur, kasiani,  Gopalgonj','advanced','0178953996',NULL,'Arts','2022','00',0.00,'Science','2020','162274',4.78,'1710407452','2022-08-21 12:57:25.418898','2022-08-21 12:57:25.418943',148,6,2),(139,-13000.00,'North Tepakhola','advance','01757810776',NULL,'Science','2022','00',0.00,'Science','2020','161806',4.78,'1710414025','2022-08-21 13:00:09.423366','2022-08-21 13:00:09.423511',149,6,2),(140,-13000.00,'Muksudpur Gopalgonj','advance','01712597986',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.94,'00','2022-08-21 13:06:35.435270','2022-08-21 13:06:35.435321',150,6,2),(141,-13000.00,'Aliabad, Faridpur','advance','01740039847',NULL,'Arts','2022','00',0.00,'Science','2020','161924',4.11,'1610628334','2022-08-21 13:24:09.686187','2022-08-21 13:24:09.686294',151,6,2),(142,-13000.00,'Onater mor, Faridpur','advance','01739793077',NULL,'Arts','2022','00',0.00,'Science','2020','163374',4.72,'00','2022-08-22 10:47:34.057479','2022-08-22 10:47:34.057533',152,6,2),(143,-13000.00,'Wirless para Goalchamot Faridpur','advance','01777354830',NULL,'Arts','2022','00',0.00,'Arts','2020','353211',4.89,'00','2022-08-22 10:51:35.313185','2022-08-22 10:51:35.313228',153,6,2),(144,-13000.00,'weast jhiltuli Faridpur','advance','01727353526',NULL,'Arts','2022','00',0.00,'Science','2020','00',0.00,'00','2022-08-22 10:54:28.903296','2022-08-22 10:54:28.903341',154,6,2),(145,-13000.00,'jhultuli Faridpur','Advance','01407425853',NULL,'Arts','2022','00',0.00,'Science','2020','165269',4.21,'00','2022-08-22 10:57:29.187395','2022-08-22 10:57:29.187490',155,6,2),(146,-13000.00,'Singpara','advance','01778933962',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.94,'1710395929','2022-08-22 11:00:42.926071','2022-08-22 11:00:42.926163',156,6,2),(147,-13000.00,'Chor Madhabdia Faridpur','advance','01749066325',NULL,'Arts','2022','00',0.00,'Science','2020','00',3.94,'00','2022-08-22 11:03:46.837228','2022-08-22 11:03:46.837277',157,6,2),(148,-13000.00,'Momin Khar hat Faridpur','Advance','01611060342',NULL,'Arts','2022','00',0.00,'Science','2020','164760',4.39,'1710412945','2022-08-22 11:06:50.438610','2022-08-22 11:06:50.438648',158,6,2),(149,-13000.00,'Nogorkhanda Faridpur','advance','01837379103',NULL,'Arts','2022','00',0.00,'Arts','2020','116201',4.88,'00','2022-08-22 11:10:37.686737','2022-08-22 11:10:37.686784',159,6,2),(150,-13000.00,'Momin khar hat','advance','01745397246',NULL,'Arts','2022','00',0.00,'Science','2020','164761',4.17,'1710412942','2022-08-22 11:13:59.328831','2022-08-22 11:13:59.328878',160,6,2),(151,-13000.00,'Madaripur Rajor','advance','01724344652',NULL,'Science','2022','1',1.00,'Science','2020','165967',3.50,'1710377746','2022-08-22 12:37:51.947300','2022-08-22 12:38:40.533956',161,6,2),(152,-13000.00,'Chorkomlapur Faridpur','advance','01740667115',NULL,'Arts','2022','00',0.00,'Science','2020','174660',3.83,'171034735','2022-08-28 10:13:17.223924','2022-08-28 10:13:17.223967',162,6,2),(153,-13000.00,'Pukhuria, Bhanga, Faridpur','advance','01725430992',NULL,'Arts','2022','00',0.00,'Arts','2020','399259',3.89,'1718975066','2022-08-28 10:22:40.940705','2022-08-28 10:22:40.940752',163,6,2),(154,-13000.00,'Matrichiya Hostel','advance','01703124881',NULL,'Arts','2022','00',0.00,'Arts','2020','00',3.89,'00','2022-08-28 10:25:38.552701','2022-08-28 10:25:38.552768',164,6,2),(155,-13000.00,'Ismil munshir dangy,  mominkhar hat shodar Faridpur','advance','01732066890',NULL,'Arts','2022','00',0.00,'Arts','2020','164751',4.06,'1710412837','2022-08-28 11:16:07.352336','2022-08-28 11:16:07.352385',165,6,2),(156,-13000.00,'Kamar dangy Mominkhar Hat Sadar, Faridpur','advance','01760522460',NULL,'Arts','2022','00',0.00,'Arts','2020','00',4.72,'1710409600','2022-08-28 11:19:18.267636','2022-08-28 11:19:18.267681',166,6,2),(157,-13000.00,'Boalmari, Faridpur','Advance','01889614446',NULL,'Science','2022','00',0.00,'Science','2020','180486',4.39,'1710388621','2022-08-28 11:21:29.020760','2022-08-28 11:31:40.673055',167,6,2),(158,-13000.00,'Kanaipur, Faridpur','Advance','01717011728',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.28,'00','2022-08-28 11:23:56.163137','2022-08-28 11:23:56.163179',168,6,2),(159,0.00,'Momin Khar hat, Faridpur','advance','01746115575',NULL,'Science','2022','00',0.00,'Science','2020','369492',4.89,'1710412840','2022-08-28 11:26:40.731248','2022-08-28 11:27:42.733037',169,6,2),(160,-13000.00,'Bhanga, Faridpur','Advance','01731100712',NULL,'Arts','2022','00',0.00,'Science','2020','162443',4.50,'00','2022-08-28 11:31:10.030158','2022-08-28 11:31:10.030208',170,6,2),(161,-13000.00,'Charvod shoin lohartak Faridpur','advance','01728634115',NULL,'Arts','2022','00',0.00,'Arts','2020','00',4.61,'1710405102','2022-08-28 15:22:17.567573','2022-08-28 15:22:17.567674',171,6,2),(162,-13000.00,'Mothurpur Modhukhali','advance','01736700904',NULL,'Arts','2022','00',4.56,'Science','2020','00',0.00,'00','2022-09-02 10:59:32.216334','2022-09-02 10:59:32.216398',172,6,2),(163,-13000.00,'Ramkrisnomissian','advance','01642181298',NULL,'Arts','2022','00',0.00,'Science','2020','225354',4.69,'00','2022-09-02 11:06:01.474333','2022-09-02 11:06:01.474406',173,6,2),(164,-13000.00,'Vajondanaga baytul aman Faridpur','advance','01773093493',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.83,'00','2022-09-02 11:08:54.913330','2022-09-02 11:08:54.913369',174,6,2),(165,-13000.00,'Jhiltuli Faridpur','Advance','01720276850',NULL,'Science','2022','00',0.00,'Science','2020','173578',4.22,'1710337225','2022-09-02 11:15:20.693726','2022-09-02 11:18:22.622718',175,6,2),(166,-13000.00,'jhiltuli Faridpur','advance','01724103988',NULL,'Science','2022','00',0.00,'Science','2020','00',4.33,'1710406326','2022-09-02 11:17:59.277180','2022-09-02 11:18:50.913242',176,6,2),(167,-13000.00,'Sadar pur Faridpur','advance','00',NULL,'Arts','2022','00',0.00,'Science','2020','00',0.00,'1710408312','2022-09-02 11:21:44.732577','2022-09-02 11:21:44.732627',177,6,2),(168,-13000.00,'Sadarpur Faridpur','advance','01940624213',NULL,'Science','2022','00',0.00,'Science','2020','00',4.72,'00','2022-09-02 11:25:18.712804','2022-09-02 11:25:18.712852',178,6,2),(169,-13000.00,'Sadarpur Faridpur','advance','01731154319',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.83,'1710408322','2022-09-02 11:27:30.880538','2022-09-02 11:27:30.880581',179,6,2),(170,-13000.00,'Ramnagor Khalilpur Rajbari','advance','01739095465',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.83,'00','2022-09-02 11:39:57.036235','2022-09-02 11:39:57.036294',180,6,2),(171,-13000.00,'Karirhar Sadarpur Faridpur','advance','01729396389',NULL,'Commerce','2022','00',0.00,'Science','2020','560032',3.89,'00','2022-09-02 11:42:32.890508','2022-09-02 11:42:32.890555',181,6,2),(172,-13000.00,'Kamlapur Tatultola Faridpur','advance','01703556561',NULL,'Arts','2022','00',0.00,'Science','2020','00',3.33,'00','2022-09-02 11:45:10.963167','2022-09-02 11:45:10.963262',182,6,2),(173,-13000.00,'Nort Komlapur Faridpur','advance','01720640450',NULL,'Arts','2022','00',0.00,'Science','2020','119881',5.00,'00','2022-09-02 11:47:33.569674','2022-09-02 11:47:33.569720',183,6,2),(174,-13000.00,'Guolokhipur Faridpur','advance','01727985782',NULL,'Arts','2022','00',0.00,'Science','2020','00',4.17,'00','2022-09-02 11:49:59.639178','2022-09-02 11:49:59.639226',184,6,2),(175,-13000.00,'Boshontopur Rajbari','advance','01718204129',NULL,'Arts','2022','00',0.00,'Science','2020','16545488',4.00,'00','2022-09-02 11:52:19.660090','2022-09-02 11:52:19.660147',185,6,2);
/*!40000 ALTER TABLE `account_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_teacher`
--

DROP TABLE IF EXISTS `account_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_teacher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` decimal(10,2) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `account_id` bigint NOT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`),
  KEY `account_teacher_organization_id_a9760714_fk_account_o` (`organization_id`),
  CONSTRAINT `account_teacher_account_id_b0735181_fk_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `account_teacher_organization_id_a9760714_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_teacher`
--

LOCK TABLES `account_teacher` WRITE;
/*!40000 ALTER TABLE `account_teacher` DISABLE KEYS */;
INSERT INTO `account_teacher` VALUES (1,1000.00,'BD','2022-07-26 17:51:43.495641','2022-08-19 12:06:49.080395',5,1),(2,0.00,'BD','2022-07-27 18:21:30.236622','2022-07-27 19:31:35.647012',7,1),(3,1000.00,'Jheeltuly Faridpyr','2022-08-04 12:38:19.325716','2022-08-04 18:27:18.400879',14,2);
/*!40000 ALTER TABLE `account_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Token',6,'add_token'),(22,'Can change Token',6,'change_token'),(23,'Can delete Token',6,'delete_token'),(24,'Can view Token',6,'view_token'),(25,'Can add token',7,'add_tokenproxy'),(26,'Can change token',7,'change_tokenproxy'),(27,'Can delete token',7,'delete_tokenproxy'),(28,'Can view token',7,'view_tokenproxy'),(29,'Can add account',8,'add_account'),(30,'Can change account',8,'change_account'),(31,'Can delete account',8,'delete_account'),(32,'Can view account',8,'view_account'),(33,'Can add batch',9,'add_batch'),(34,'Can change batch',9,'change_batch'),(35,'Can delete batch',9,'delete_batch'),(36,'Can view batch',9,'view_batch'),(37,'Can add organization',10,'add_organization'),(38,'Can change organization',10,'change_organization'),(39,'Can delete organization',10,'delete_organization'),(40,'Can view organization',10,'view_organization'),(41,'Can add teacher',11,'add_teacher'),(42,'Can change teacher',11,'change_teacher'),(43,'Can delete teacher',11,'delete_teacher'),(44,'Can view teacher',11,'view_teacher'),(45,'Can add student',12,'add_student'),(46,'Can change student',12,'change_student'),(47,'Can delete student',12,'delete_student'),(48,'Can view student',12,'view_student'),(49,'Can add staff',13,'add_staff'),(50,'Can change staff',13,'change_staff'),(51,'Can delete staff',13,'delete_staff'),(52,'Can view staff',13,'view_staff'),(53,'Can add course',14,'add_course'),(54,'Can change course',14,'change_course'),(55,'Can delete course',14,'delete_course'),(56,'Can view course',14,'view_course'),(57,'Can add exam',15,'add_exam'),(58,'Can change exam',15,'change_exam'),(59,'Can delete exam',15,'delete_exam'),(60,'Can view exam',15,'view_exam'),(61,'Can add result',16,'add_result'),(62,'Can change result',16,'change_result'),(63,'Can delete result',16,'delete_result'),(64,'Can view result',16,'view_result'),(65,'Can add payments',17,'add_payments'),(66,'Can change payments',17,'change_payments'),(67,'Can delete payments',17,'delete_payments'),(68,'Can view payments',17,'view_payments'),(69,'Can add payment',18,'add_payment'),(70,'Can change payment',18,'change_payment'),(71,'Can delete payment',18,'delete_payment'),(72,'Can view payment',18,'view_payment'),(73,'Can add notification',19,'add_notification'),(74,'Can change notification',19,'change_notification'),(75,'Can delete notification',19,'delete_notification'),(76,'Can view notification',19,'view_notification');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('005ff8d404d8708c8b86d55c6b667afaef9cd959','2022-08-06 14:11:14.098416',43),('02134367874ee7ec249edbab88bc0caffbe5a1bb','2022-08-06 12:52:41.316008',17),('046ca2b29875dcf57eeff087c2f2095530d481c7','2022-08-21 12:57:25.416883',148),('0521891eea3bd9383f0af06bb3423368d96c2a20','2022-08-10 18:24:54.776343',84),('056e14335b44abec3fd9fa5fdcee363072152568','2022-09-02 11:39:57.034223',180),('05e6bf10144aca918ef27b4d7c0d8558bdb20e1d','2022-08-28 11:16:07.350156',165),('06b23415b2996e6b18958a0b58208722369cb1b1','2022-08-17 18:20:55.096119',109),('0834031da421d0f899c6ed42c5d79e07ba168c87','2022-08-22 11:00:42.923696',156),('0befe557fb8b5ce71ae5de07f5b79f327af9105c','2022-08-11 18:41:22.319181',96),('0cc0053d72ca9e16e1c1d2aed9f145a8ff10089b','2022-08-09 15:35:04.911056',77),('0d799924771e730c6333559a92e2ce806dbc7ef8','2022-08-06 13:24:44.317778',26),('0e76becd433b2b74c1402c597b822eccb43f44bd','2022-08-06 14:00:14.716787',38),('15dd539be691d646483502aee4d6993b084f52f6','2022-08-22 11:13:59.326392',160),('17c7b00abed2455f964865bec724179afe0784e4','2022-08-06 14:56:11.054702',61),('187e1b6aedfc5c996a4bdbfe018304a56ac67f0e','2022-09-02 11:17:59.274686',176),('1ad2c401b730379e3f72603e81bc1d21d9cf8711','2022-08-06 14:30:06.368806',53),('1d536c11edf8cc26d3b81eb0576bb4c994812732','2022-08-21 12:42:04.643342',143),('1f0afae4cf6f3202e871d5a0c888fdabef88261c','2022-08-06 14:32:49.944695',54),('1f8b63a8cb92684de4e05a0c75e5aa350302dc0a','2022-08-11 14:02:07.714096',91),('2288bdae8ed07f421df3bc37b4f04f067977c59c','2022-08-14 15:54:38.522080',104),('25469fbbeaaa81dbb0006b47639e5d82df9aeead','2022-08-21 12:45:17.916499',144),('269d258a0c31451a4bc605a8710f0947f5905eee','2022-08-02 18:28:17.754000',13),('26dae6fce468e5958c45d5aba7ac38c282122620','2022-08-21 12:50:33.397917',146),('2e6c21b6d8748d7dd470059c1846f53882919257','2022-08-06 15:29:40.424606',69),('2eb0db02a518c0774ba0386e66b52bf06d1fa0c5','2022-08-11 19:55:54.007312',98),('2f96c8b228b36397bfd8e04dd497da022556bc5f','2022-08-22 10:51:35.311117',153),('2fb3b72723ab986c234761490e4cd58a215d0e78','2022-08-21 12:30:54.472300',139),('30589198140deb42572fdd4730da6fa6fd8ec90d','2022-08-18 11:15:15.800779',128),('31d7386d56fdce74958ae00eb04c7958794d69e3','2022-08-21 13:00:09.420747',149),('321082cd01bd8ca504cb7388ee8df489028eb074','2022-08-22 11:03:46.834832',157),('329bf79b53ed36b0a51275a58cd70725509afc2b','2022-08-15 10:14:02.899062',105),('34df7db04c7c95a883ad5f708b031d45e3d66484','2022-08-21 12:25:02.640030',137),('36ac74a7823e49fad75c9cd58191c1d1db6c787d','2022-09-02 11:27:30.878538',179),('397dd36230c9e2cd4184203c10971ed56ca2d5d8','2022-08-18 10:56:54.567677',123),('3db7aa588bf73397a2408fd47cadef3cbc030785','2022-08-10 18:54:14.877292',87),('3e7ff2897ccd751cc892373d7b823b1f92cb1539','2022-08-18 09:56:36.225096',117),('3f23108c8a931f443653234ef91e2abce35baf4b','2022-08-06 15:10:59.087081',64),('3fc86dca6555f77f3ef8ee90309e0ac754c05b52','2022-08-18 10:52:28.890554',122),('40b5461aba261784986cf055ad1afa716a8152f7','2022-08-06 14:14:16.418465',44),('422955c72bd82e4024dba247b32614c98dcd1476','2022-08-21 12:54:07.524324',147),('44a0625a48d94eef600a3de2fe9e3b0897aa3f7d','2022-08-21 13:06:35.432783',150),('44f99a802c8cc6b1d989e488b1cbabadf2daeea8','2022-08-11 13:55:40.519712',90),('45b29f0217636dc2118301b4a6e2dd51727682ef','2022-08-06 15:40:32.570381',73),('464b942c688addfce7d353fbf577599383cc92cb','2022-08-06 14:10:02.362856',42),('470ad2a2734281380e279f7f4c4ccf597f7e6547','2022-08-17 18:35:50.986040',113),('47173af67b9ebdd9cfd2db37be35a38b9d26b231','2022-08-28 11:31:10.028075',170),('473ec00c9cd11eb8f0fdc3a0d7c2045483292e76','2022-08-21 12:28:27.596717',138),('487ec3b613102af0e700982a70b21a86b048e3a2','2022-08-11 19:59:34.615261',99),('4e1574fbbb27f7399bb4f3ed64dd362eeb2088fc','2022-09-02 11:15:20.691954',175),('5059a4e4c8e326e1efbffbf3ba4a572c3df50fe4','2022-08-28 11:19:18.265821',166),('52b189c772c9eef82aaf3432061693dc21793452','2022-08-06 15:35:15.845481',71),('5318ac2575ffe76c4aac0b529e1a47e33cfb3e89','2022-08-06 13:37:08.433830',32),('53833db3de329545af7eb3d8211987dd7ee5ee9a','2022-08-06 15:26:08.212825',67),('56a31a26f81b4114412bcce07526e7be90dd3195','2022-08-06 15:38:16.496610',72),('56fee795040c1e26dfce32e0a0f83167dc621365','2022-08-28 15:22:17.565992',171),('570da3e8c77b99c68af0ef92d7e313204a524dde','2022-08-10 18:50:22.046436',86),('58e6b75065acdea039d2129d00e342737c3464b5','2022-08-06 13:14:13.096009',22),('59c1824ba4959ca58b3a87e78cf556d690534242','2022-08-11 20:02:16.550083',100),('5b34a205da9fc8d91d7b28bc8999d91739aea5dd','2022-08-21 12:22:18.761800',136),('5e74b61f1963e0010cf3c690afb9c85e70601819','2022-09-02 11:06:01.472009',173),('61653f67d0d6e7e3b179fcf6d12621fe7a06c33b','2022-08-11 14:09:25.147183',93),('618f45d71919345338e12fb35a5c863e509e22af','2022-08-06 13:52:40.940191',34),('6229e351d856553df4d8a35e370c3d579835c46e','2022-08-13 11:57:06.277717',103),('62ae447f97033829e1c534bd1593b59841abcff4','2022-08-06 14:58:16.936241',62),('64cc1c5e416d7e02fb140a14a8ae1c48faacf2bd','2022-08-18 14:39:44.913927',133),('65b2662648a236378359d9b156481bcd030b90e9','2022-08-09 15:27:29.345888',76),('6650299355dc3b7695d24368ab1efe4a54919f1a','2022-08-06 13:03:44.841832',19),('66ba492c426f08708ea26cfa4545bfba0fd358a5','2022-08-10 09:49:35.743604',80),('684983124b83290a2d639206edc72c2ad3df1b49','2022-08-09 17:16:51.317465',78),('696d0b869ad43e122ae3801a855c5149c4d685a5','2022-08-10 09:46:29.677113',79),('6b409aa7e6bd0ceaf39ab350d29a1d5452298e77','2022-08-18 10:00:55.811584',118),('6b8374bb15a654e7dd12cb5adb73c1827d9cac30','2022-08-06 14:26:51.788071',50),('6e1ee092256d277909f35f87439677f1345635f9','2022-08-06 15:04:00.488354',63),('6fb878eb6ba2ff162eacc95ab482deaf0adac115','2022-08-28 10:13:17.222043',162),('70716b1055d62504c60327dc91daa1c2f10abbb0','2022-08-17 18:39:24.556493',114),('71267b1ac871e06ef1cb27ef527be9582495db53','2022-08-22 10:54:28.901338',154),('715891d5dad8e2ee7f554554b03ec669610da6dd','2022-08-22 12:37:51.945428',161),('745edb6d322f9e229c47200782ec3823d24b5e54','2022-08-06 14:33:17.584584',55),('7686c99d9d1be0c271d3f473d65435f1b48e6e40','2022-08-02 18:21:29.794831',12),('7710b4825e2df295809be443e380885eefae946d','2022-08-11 14:14:16.142832',94),('7737cca58e10bb23065fb412d690789ef3adfdde','2022-08-06 13:55:39.486356',37),('78468d2942943280425bc68ec6b31b4fd2047a64','2022-08-06 15:21:31.598058',66),('78aab05318d476390cd03b37c121c5f9e1b6047b','2022-08-04 12:38:19.322327',14),('7945b431dff853d11e22df3f27766972a4f73094','2022-08-18 14:43:28.298016',134),('794947d0204c91073fe3b6cb36487fd96df66586','2022-08-06 14:43:54.087784',58),('7a91af8871d369ca2cd4ff5478c4fd81077dd370','2022-08-18 10:43:27.580740',121),('7ba56d11b56294d72c8d6ecb9209aff660b003e3','2022-07-25 18:00:54.074688',1),('7bd4a47bae9b421d4f644e9a1a17dbfd08a93bc6','2022-07-26 17:51:43.481726',5),('7de9597a9a0cdaeeb584dfa6b12cf39621d6ce6b','2022-08-11 14:06:15.357767',92),('7f43d0f8cae97defda0f71f27bb2b9dedbc43688','2022-08-21 12:48:21.271788',145),('80ad8eac428124afb80e2a88b5562f0bce3d14fe','2022-08-17 18:28:37.484223',111),('81ea459f501f063d915812cbfda826c42b0c00f7','2022-08-06 14:23:49.296624',49),('845342b8447195de414bfa7192d77021a77c3c7b','2022-08-17 18:18:43.676595',108),('85d0d9c452e82fe7ac1a245caf04505b0ef01ac3','2022-08-11 20:04:46.385550',101),('889fa532e846d7b1b7c3a3f41abacdadcf747713','2022-08-17 18:24:49.163310',110),('88adc45fbb82349b08c337f3d32c587003c950c1','2022-09-02 11:49:59.637007',184),('8a068cd87806a0481d316cbe2214a2563378550e','2022-08-10 10:47:48.038180',81),('8ac14657f6afa3a137b9210f9597a700d77ccca5','2022-08-06 15:45:41.627400',74),('8b03629008c689fd3a09117496d66ebf10251d54','2022-08-22 11:10:37.684655',159),('8b59fbb29e441958be298cf9e80ed758da07ff64','2022-08-18 10:59:30.213973',124),('8dbef42db81ee085baab60d22e834b4d45867bd4','2022-08-06 13:29:46.060123',29),('8e1952172614db22345c7963e86b54691bc05e8c','2022-08-06 14:36:55.241750',56),('8e5653b62e445abbca4970809e6f60c60707e0e2','2022-08-21 12:39:00.703840',142),('919684259580e0d5fb06dc49480a3f6c7f6a4abf','2022-08-06 13:52:56.156347',35),('924bdcbea9ae402bf130e015fed52f9e735e0a6c','2022-08-28 11:21:29.018340',167),('938626b48d020d787abc2d635994792d442f69fc','2022-08-11 10:29:36.858064',88),('9683be6dec864f137e83eadbc093604827c41249','2022-08-11 18:34:54.105414',95),('979b6b4662b8722d128c79dcd9360ade2cf50126','2022-08-06 13:55:33.662284',36),('9b62bf8dcabd9a736497aaf1a5140d6aad8cb8e1','2022-07-25 18:04:11.788424',2),('9c87177c8f7b63332417d32a2984e00825b5e7f9','2022-08-07 14:32:59.523749',75),('9e1784fe768baa1a201b52044d266b1d895ad73c','2022-08-22 11:06:50.436880',158),('9ea78cd72baab9b1eadd666ae400a6bcda847272','2022-08-18 14:29:11.344073',130),('9eb947acb62825c15709e546a9a688316c6a8601','2022-09-02 11:52:19.657870',185),('a063249320b6926289c3c3bab332754650a50c14','2022-08-06 13:10:56.817067',21),('a1bafff5bab418022dc4a05457c810c735560d6c','2022-08-06 14:07:33.483496',41),('a1f3111674a98ee82d8b3f8661b44060bd00cde1','2022-08-06 14:27:33.321561',51),('a27a807d28d7e1ac158a0f24be7b262b3ca7d78d','2022-08-06 15:28:34.744218',68),('a4013ed9afeb053edafb45496c53da3a5113b4c2','2022-08-06 14:19:52.593296',47),('a4a9ebb787969c49da85fc6a91951acf90cf2c1d','2022-08-21 12:33:56.842021',140),('a5fa3086644fc21a6b0999cb965b11d23be14fd3','2022-07-31 11:18:58.022875',9),('a955570319b5fd55667c3ee590a0955000c53ff1','2022-09-02 11:25:18.710661',178),('acabc388a3a8051c93a228bdac6dea13757a2077','2022-07-27 18:21:30.234661',7),('b06a6f7788d8019447a103876483dc8798e3e8dd','2022-08-10 18:45:47.370657',85),('b168b7fcf52a9c97ee7b3343c5e04e7f784a2cea','2022-08-21 13:24:09.683305',151),('b2a82e075836d9cd4ff7213f7955bc0132d6de54','2022-08-06 14:48:10.705603',59),('b31adcafd5596a33e5e7aca19f0d65ebcff2793e','2022-07-26 13:01:30.282828',4),('b367fad8f9d8314e9b271c5e11887561383512ad','2022-08-18 14:35:23.788323',132),('b3c18a8eb8cf5d2ba2301bb02124c02dbb0f2284','2022-08-06 15:18:52.743958',65),('b60797a2aa89087b88e718dddd89768817136d99','2022-08-06 14:16:58.795365',46),('b665839b3fade42b95ea95b0044831f6a51ee3ed','2022-08-11 13:50:26.715989',89),('ba4519fdb193afa41ba5ced75b7bd2397ed9a49d','2022-08-18 10:37:00.993049',119),('bb03d7e01d78ff45256b3da7b1e7d596da6b88ae','2022-08-18 10:40:30.146323',120),('bc566b4e4bd859cb5d4042ffa06e0f5d41442879','2022-09-02 11:21:44.730272',177),('bd301ecd7673925fac437fe41e100103aa278806','2022-09-02 10:59:32.213567',172),('bda2da8a040709e0bc681bbc2cf3377c1dbd0837','2022-08-06 13:32:01.994131',30),('c16a830833d227e4ede672c578a0787b32294c9e','2022-09-02 11:08:54.911441',174),('c207d71b3553a6e4b3c7d65919b31469c2f67a51','2022-08-01 17:55:36.266967',10),('c313397f4657603706a84cc9c809264066083b48','2022-08-17 18:42:00.040622',115),('c3ad3e5deb9adc9dca347671066679702c244ada','2022-08-06 13:32:50.762702',31),('c5bc9f4d352c9ebcdfb0c70b8fc1f46270d55f24','2022-08-18 09:53:46.145701',116),('c5ccefce63ba35c5cd20d8371c1c99e5314689e5','2022-07-25 18:29:13.434917',3),('c76c78f01c64683e76fe85f75e7cd0a86618b76d','2022-08-06 14:37:33.005362',57),('c83c640f67570b35d6c3081012084fce31378e36','2022-08-06 14:07:12.555933',40),('cc3b9417cd75f442f108e46d2cdad4424a86e23a','2022-08-06 14:53:50.564865',60),('cd4218912197e7b7b81c769e661b3331fc5c32b5','2022-08-28 11:26:40.728476',169),('ce32796c4824d11eefac6c9e5a8933d2c751166a','2022-08-17 18:32:36.694478',112),('cf592484a725095e03966053c145e8e1a1e992a3','2022-08-04 17:31:20.652104',16),('cfc78c03d0f53dbcf5db83341fe0ba832fba92ae','2022-08-17 16:30:41.195940',106),('cfd47448c0db479ccfe5734b28483a60e19bec19','2022-08-21 12:36:32.573201',141),('d1006be27c555ab0d0cb82cb2a5413b4685b3877','2022-08-18 14:46:37.936794',135),('d2194e07118ad28ce1c1b23f876d866208a21a8c','2022-08-28 10:22:40.938397',163),('d4e150431427ea33ace487818f508cc5dd1dce6c','2022-08-28 10:25:38.550773',164),('d5e9faf3bf41dec0e81a622b2d3a31d4a06b0c30','2022-08-06 13:15:10.060991',23),('d65d499fd6b91f4f09ee28957de5917cf25b5b5e','2022-08-06 13:22:36.894775',25),('d77a63dc7dd70aeb2181953671ea985e427803b4','2022-09-02 11:45:10.961271',182),('d86dac6f9bc45d8fa605f61ef6e2e38a36dce10b','2022-07-26 17:53:07.038471',6),('d91fb9460721b917484900fc0a5af3bdcaa9bba1','2022-08-10 18:18:22.599695',83),('d942f9c717df77e38041cd620c12ded166623077','2022-08-17 18:14:00.947531',107),('dc8eb660a263f11a20beae2aa53b6ddf0658e845','2022-08-18 14:12:28.255777',129),('ddc94a250347e35a07acb635f070c926f6f18515','2022-08-18 11:06:30.822121',126),('de7bc9c580d9d19eab86661f41bdf769d402a804','2022-08-18 14:32:38.835527',131),('df864d1490d0f5e4fc5965fa7534244dc0bf7d60','2022-08-10 17:59:26.116561',82),('e12dd5d9acaec495a667d59d2e61f0c754c1f3ff','2022-08-06 14:29:35.653451',52),('e3431b782de57dd3b2bb4fb86facd7e0e2db6015','2022-08-11 20:07:34.837186',102),('e3f34b46af2f09619b89a06a556559260fe20991','2022-08-06 15:31:14.699466',70),('e41e1818c8639ec6c39c8c1348dfa2eb192cf4c7','2022-07-28 18:48:22.949539',8),('e713473c06ca4b2b2661514a4bfa091394916434','2022-08-11 18:44:33.067643',97),('e7a805636167b49828f1cc253ddb76f3f6ca1c9c','2022-08-06 13:39:50.935637',33),('e7c7b77d943c49e928191ca734ea91806589bab5','2022-08-28 11:23:56.160920',168),('e8288099c9c9150b7ea398818e297cea9a663c81','2022-09-02 11:42:32.888521',181),('e8e7003bc1800213ed8d02f9961d13a14d98393d','2022-08-06 13:06:54.099795',20),('e9125c401bacde2a6892dceacc6da8768ff82ea4','2022-08-06 13:26:45.244177',27),('e9859b1055576887afd14055c1f6f0c7290555b9','2022-08-06 13:19:39.890130',24),('eafef0e6f9b14974c99593f3f29be17f07c51750','2022-08-06 14:01:35.749712',39),('ec896373cbdf029da8cf1398304fca9351218125','2022-08-06 13:29:21.915357',28),('eda4891a78790b683f6570370534d827ce6223c3','2022-08-18 11:10:25.600884',127),('ef787ce62d20bbbb4ff547a4abd03e99bf6120dd','2022-09-02 11:47:33.567497',183),('f17027b1ed9f778d03adac09943800c2606069e6','2022-08-06 12:59:42.023432',18),('f34a93e18c2d82ea8aa655a9384762b9bfb21637','2022-08-06 14:15:01.134377',45),('f5930c17ede05b56ce4077ed44f1377489e9dde3','2022-08-22 10:47:34.055269',152),('f699b94a62b167e88029386fe11e36532a1cb2b6','2022-08-22 10:57:29.185701',155),('f7010e579c53df69c93bf5e026f3f861df2b48c2','2022-08-04 15:27:14.561586',15),('f95f9d2d26d299b9028921aef14aef8f8d0778d2','2022-08-06 14:20:47.977960',48),('ff48e18dcb94ae0cdb2f798239e83c668a8c1705','2022-08-18 11:02:46.110574',125);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_account_account_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2022-07-25 18:04:11.790659','2','Tusher\'s Care',1,'[{\"added\": {}}]',8,1),(2,'2022-07-25 18:12:26.884556','2','abc01711223344',2,'[{\"changed\": {\"fields\": [\"Email\", \"Mobile\", \"Username\", \"Profile picture\"]}}]',8,1),(3,'2022-07-25 18:13:00.426739','1','Organization object (1)',1,'[{\"added\": {}}]',10,1),(4,'2022-07-25 18:19:42.303767','2','abc01711223344',2,'[{\"changed\": {\"fields\": [\"Is admin\"]}}]',8,1),(5,'2022-07-29 11:23:59.595169','2','abc01711223344',2,'[{\"changed\": {\"fields\": [\"Profile picture\"]}}]',8,1),(6,'2022-07-31 11:18:58.024204','9','Tusher\'s Care',1,'[{\"added\": {}}]',8,1),(7,'2022-07-31 11:19:24.037905','9','Tusher\'s Care01777104777',2,'[{\"changed\": {\"fields\": [\"Email\", \"Mobile\", \"Is admin\"]}}]',8,1),(8,'2022-07-31 11:21:04.625812','2','Organization object (2)',1,'[{\"added\": {}}]',10,1),(9,'2022-07-31 11:22:14.628188','2','Organization object (2)',2,'[{\"changed\": {\"fields\": [\"Address\"]}}]',10,1),(10,'2022-07-31 11:22:35.890859','9','Rakibul Islam Tusher01777104777',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',8,1),(11,'2022-08-02 18:19:04.823094','3','Student object (3)',3,'',12,1),(12,'2022-08-02 18:19:23.198855','11','Sian+441867417227',3,'',8,1),(13,'2022-08-04 18:00:01.472382','3','Teacher object (3)',2,'[{\"changed\": {\"fields\": [\"Balance\"]}}]',11,1),(14,'2022-08-04 18:17:44.681255','3','Teacher object (3)',2,'[{\"changed\": {\"fields\": [\"Balance\"]}}]',11,1),(15,'2022-08-04 18:27:18.401978','3','Teacher object (3)',2,'[{\"changed\": {\"fields\": [\"Balance\"]}}]',11,1),(16,'2022-09-13 15:53:55.457856','8','Batch object (8)',3,'',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (14,'academic','course'),(15,'academic','exam'),(16,'academic','result'),(8,'account','account'),(9,'account','batch'),(10,'account','organization'),(13,'account','staff'),(12,'account','student'),(11,'account','teacher'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(6,'authtoken','token'),(7,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(19,'notification','notification'),(18,'payment','payment'),(17,'payment','payments'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'account','0001_initial','2022-07-25 14:33:04.910090'),(2,'account','0002_auto_20220721_2235','2022-07-25 14:33:04.997239'),(3,'account','0003_alter_batch_title','2022-07-25 14:33:05.055625'),(4,'account','0004_auto_20220722_0148','2022-07-25 14:33:05.129966'),(5,'account','0005_auto_20220722_1112','2022-07-25 14:33:05.219282'),(6,'academic','0001_initial','2022-07-25 14:33:05.592790'),(7,'academic','0002_auto_20220722_2243','2022-07-25 14:33:05.784105'),(8,'contenttypes','0001_initial','2022-07-25 14:33:05.818033'),(9,'admin','0001_initial','2022-07-25 14:33:05.919259'),(10,'admin','0002_logentry_remove_auto_add','2022-07-25 14:33:05.936292'),(11,'admin','0003_logentry_add_action_flag_choices','2022-07-25 14:33:05.955463'),(12,'contenttypes','0002_remove_content_type_name','2022-07-25 14:33:06.015743'),(13,'auth','0001_initial','2022-07-25 14:33:06.219609'),(14,'auth','0002_alter_permission_name_max_length','2022-07-25 14:33:06.273311'),(15,'auth','0003_alter_user_email_max_length','2022-07-25 14:33:06.282637'),(16,'auth','0004_alter_user_username_opts','2022-07-25 14:33:06.294886'),(17,'auth','0005_alter_user_last_login_null','2022-07-25 14:33:06.304086'),(18,'auth','0006_require_contenttypes_0002','2022-07-25 14:33:06.308013'),(19,'auth','0007_alter_validators_add_error_messages','2022-07-25 14:33:06.317324'),(20,'auth','0008_alter_user_username_max_length','2022-07-25 14:33:06.326599'),(21,'auth','0009_alter_user_last_name_max_length','2022-07-25 14:33:06.336620'),(22,'auth','0010_alter_group_name_max_length','2022-07-25 14:33:06.378439'),(23,'auth','0011_update_proxy_permissions','2022-07-25 14:33:06.398089'),(24,'auth','0012_alter_user_first_name_max_length','2022-07-25 14:33:06.406842'),(25,'authtoken','0001_initial','2022-07-25 14:33:06.458379'),(26,'authtoken','0002_auto_20160226_1747','2022-07-25 14:33:06.497578'),(27,'authtoken','0003_tokenproxy','2022-07-25 14:33:06.502763'),(28,'notification','0001_initial','2022-07-25 14:33:06.632540'),(29,'payment','0001_initial','2022-07-25 14:33:06.810629'),(30,'sessions','0001_initial','2022-07-25 14:33:06.834887');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('eg30v7261di3nj78wdysf3ja8hdwzhcp','.eJxVjE0OwiAYBe_C2hBAKNWle89Avj-kaiAp7cp4d23ShW7fzLyXSrAuJa1d5jSxOiurDr8bAj2kboDvUG9NU6vLPKHeFL3Trq-N5XnZ3b-DAr18a085jFnQeJ-tHU4kJgqysIueQmRGxJDd0bIxhGLCSGGIApZjABSn3h8NTDkS:1oHISb:9EEh6uM8QktwtauCA5KO93gpPYTdT-O9ubzee8FF5A4','2022-08-12 11:22:53.172565'),('rvx2cblvcx6o64w3e6ik9uqpgl1zm162','.eJxVjE0OwiAYBe_C2hBAKNWle89Avj-kaiAp7cp4d23ShW7fzLyXSrAuJa1d5jSxOiurDr8bAj2kboDvUG9NU6vLPKHeFL3Trq-N5XnZ3b-DAr18a085jFnQeJ-tHU4kJgqysIueQmRGxJDd0bIxhGLCSGGIApZjABSn3h8NTDkS:1oV5d7:fmL9-3KI70iy84kBLBanwiHL7AmzTaN2cD4Wb8tNRi4','2022-09-19 12:30:45.126536'),('vzdiru7jzbr7yrk7q2vlvuz6uw4wttjw','.eJxVjE0OwiAYBe_C2hBAKNWle89Avj-kaiAp7cp4d23ShW7fzLyXSrAuJa1d5jSxOiurDr8bAj2kboDvUG9NU6vLPKHeFL3Trq-N5XnZ3b-DAr18a085jFnQeJ-tHU4kJgqysIueQmRGxJDd0bIxhGLCSGGIApZjABSn3h8NTDkS:1oFwnT:I4APJCx_cp42EA5pQbAsSQdsqtJrfrX-J5cUKm3BzUU','2022-08-08 18:02:51.538039');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_notification`
--

DROP TABLE IF EXISTS `notification_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_notific_organization_id_a1b3c613_fk_account_o` (`organization_id`),
  CONSTRAINT `notification_notific_organization_id_a1b3c613_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_notification`
--

LOCK TABLES `notification_notification` WRITE;
/*!40000 ALTER TABLE `notification_notification` DISABLE KEYS */;
INSERT INTO `notification_notification` VALUES (1,'Only For Advance 1st Year','Class Schedule : রবি, মঙ্গল, বৃহস্পতি বার  দুপুর ১২ঃ৩০ এবং ০৩.৩০ এ ক্লাস হবে।','','2022-08-04 15:29:25.032171','2022-08-04 15:29:25.032218',2),(2,'!Alart!','ছবি সংক্রান্ত নোটিশঃ যারা এখনো ভর্তি ফরম এর সাথে ছবি দেন নাই তারা আগামী  ১০ আগস্ট এর মধ্যে ছবি প্রদান করবেন।','','2022-08-06 16:27:54.921940','2022-08-06 16:27:54.921985',2);
/*!40000 ALTER TABLE `notification_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_notification_reads`
--

DROP TABLE IF EXISTS `notification_notification_reads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_notification_reads` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `notification_id` bigint NOT NULL,
  `account_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notification_notificatio_notification_id_account__6dd972d7_uniq` (`notification_id`,`account_id`),
  KEY `notification_notific_account_id_51f94a92_fk_account_a` (`account_id`),
  CONSTRAINT `notification_notific_account_id_51f94a92_fk_account_a` FOREIGN KEY (`account_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `notification_notific_notification_id_b87836aa_fk_notificat` FOREIGN KEY (`notification_id`) REFERENCES `notification_notification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_notification_reads`
--

LOCK TABLES `notification_notification_reads` WRITE;
/*!40000 ALTER TABLE `notification_notification_reads` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_notification_reads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_payment`
--

DROP TABLE IF EXISTS `payment_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `note` longtext,
  `fee` decimal(10,2) NOT NULL,
  `fine` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `account_id` bigint DEFAULT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_payment_account_id_c541dc32_fk_account_account_id` (`account_id`),
  KEY `payment_payment_organization_id_2a6ee6cc_fk_account_o` (`organization_id`),
  CONSTRAINT `payment_payment_account_id_c541dc32_fk_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `payment_payment_organization_id_2a6ee6cc_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_payment`
--

LOCK TABLES `payment_payment` WRITE;
/*!40000 ALTER TABLE `payment_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_payments`
--

DROP TABLE IF EXISTS `payment_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `note` longtext,
  `type` varchar(100) NOT NULL,
  `fee` decimal(10,2) NOT NULL,
  `fine` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `account_id` bigint DEFAULT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_payments_account_id_970aa922_fk_account_account_id` (`account_id`),
  KEY `payment_payments_organization_id_ddbb4751_fk_account_o` (`organization_id`),
  CONSTRAINT `payment_payments_account_id_970aa922_fk_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `payment_payments_organization_id_ddbb4751_fk_account_o` FOREIGN KEY (`organization_id`) REFERENCES `account_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_payments`
--

LOCK TABLES `payment_payments` WRITE;
/*!40000 ALTER TABLE `payment_payments` DISABLE KEYS */;
INSERT INTO `payment_payments` VALUES (1,'','Student Payment',3000.00,0.00,0.00,'2022-07-26 12:54:23.794203','2022-07-26 12:54:23.794267',3,1),(2,'','Student Payment',4000.00,0.00,0.00,'2022-07-26 13:02:54.934491','2022-07-26 13:02:54.934536',4,1),(3,'','Staff Payment',500.00,0.00,0.00,'2022-07-30 11:47:04.692338','2022-07-30 11:47:04.692380',6,1),(4,'','Student Payment',13000.00,0.00,0.00,'2022-08-02 18:45:14.543321','2022-08-02 18:45:14.543382',13,2),(5,'Somajkormo','Teacher Payment',1000.00,0.00,0.00,'2022-08-04 12:42:09.723890','2022-08-04 12:42:09.723934',14,2),(6,'','Student Payment',3000.00,0.00,0.00,'2022-08-04 15:30:00.745413','2022-08-04 15:30:00.745480',15,2),(7,'','Teacher Payment',1000.00,0.00,0.00,'2022-08-04 18:13:15.185246','2022-08-04 18:13:15.185291',7,1),(8,'','Teacher Payment',1000.00,0.00,0.00,'2022-08-04 18:13:36.565815','2022-08-04 18:13:36.565858',7,1),(9,'','Teacher Payment',1000.00,0.00,0.00,'2022-08-04 18:15:11.638501','2022-08-04 18:15:11.638542',7,1),(10,'','Teacher Payment',5000.00,0.00,0.00,'2022-08-04 18:22:28.689695','2022-08-04 18:22:28.689761',7,1),(11,'','Teacher Payment',1000.00,0.00,0.00,'2022-08-04 18:26:49.568645','2022-08-04 18:26:49.568698',5,1),(12,'1 Sept New Date','Student Payment',2000.00,0.00,0.00,'2022-08-07 14:20:56.828831','2022-08-07 14:20:56.828895',21,2),(13,'','Student Payment',2000.00,0.00,0.00,'2022-08-09 15:28:17.850877','2022-08-09 15:28:17.850939',76,2),(14,'','Student Payment',7000.00,0.00,1000.00,'2022-08-10 14:58:12.487277','2022-08-10 14:58:12.487324',78,2),(15,'','Student Payment',4000.00,0.00,0.00,'2022-08-13 11:58:04.973766','2022-08-13 11:58:04.973831',103,2),(16,'uh','Student Payment',500.00,50.00,50.00,'2022-08-15 09:12:45.423061','2022-08-15 09:12:45.423107',4,1),(17,'','Student Payment',2000.00,0.00,0.00,'2022-08-15 10:19:56.803510','2022-08-15 10:19:56.803566',105,2),(18,'','Student Payment',2000.00,0.00,0.00,'2022-09-04 11:04:17.016386','2022-09-04 11:04:17.016427',21,2);
/*!40000 ALTER TABLE `payment_payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-13 10:09:31
