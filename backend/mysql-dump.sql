-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: vue-your-blog
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderOfElements` varchar(255) DEFAULT NULL,
  `userId` int NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` VALUES (1,'[\"textArea\",\"image\"]',1,'Cats are Secretly Evil'),(2,'[\"textArea\",\"image\"]',1,'Beer is Good for you'),(3,'[\"image\",\"textArea\"]',1,'Charizard is the coolest pokemon'),(4,'[\"image\",\"textArea\"]',1,'How to Build a FullStack App'),(5,'[\"textArea\",\"image\",\"textArea\"]',1,'Switzerland is the best'),(6,'[\"textArea\",\"image\"]',1,'Can\'t have a blog without an image. '),(7,'[\"image\",\"textArea\"]',1,'How to travel in Mexico'),(8,'[\"textArea\",\"image\"]',1,'Robots are Cool'),(9,'[\"textArea\",\"image\"]',4,'TEST HOW TO TEST');
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_comments`
--

DROP TABLE IF EXISTS `blog_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(511) NOT NULL,
  `blogId` int NOT NULL,
  `username` varchar(14) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `blog_id_idx` (`blogId`),
  CONSTRAINT `blog_id` FOREIGN KEY (`blogId`) REFERENCES `blog` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_comments`
--

LOCK TABLES `blog_comments` WRITE;
/*!40000 ALTER TABLE `blog_comments` DISABLE KEYS */;
INSERT INTO `blog_comments` VALUES (1,'<p>test 1</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 8:12 PM PDT'),(2,'<p>test 2</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 8:21 PM PDT'),(3,'<p>test 3</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 8:23 PM PDT'),(4,'<p>test 4</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 8:26 PM PDT'),(5,'<p>test 5</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 8:30 PM PDT'),(6,'<p>test6</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 8:30 PM PDT'),(7,'<p>test7</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 8:34 PM PDT'),(8,'<p>test 8</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 8:37 PM PDT'),(9,'<p>I love you</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 8:38 PM PDT'),(11,'<p>Hey</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 8:49 PM PDT'),(12,'<p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p><p>asdfasdf</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 8:52 PM PDT'),(13,'<p><strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.conter</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:08 PM PDT'),(14,'<p><strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.content.length&nbsp;&lt;=&nbsp;511<strong>this</strong>.currentUserComment.conter</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:11 PM PDT'),(15,'<p>test</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:19 PM PDT'),(16,'<p>testestwserte</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:20 PM PDT'),(17,'<p>testsfasefawefawef</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:21 PM PDT'),(18,'<p>teafdaefawe</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:23 PM PDT'),(19,'<p>asdfawefwaef</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:24 PM PDT'),(20,'<p>awe yeah</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:27 PM PDT'),(21,'<p>I think so too</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 9:31 PM PDT'),(22,'<p>Hey sup </p><p></p><p>ASDFASDF</p>',1,'username','uploads/2021-04-14T12-33-46.148Z-Shawn-tripped.png','Apr 2021, 9:49 PM PDT'),(23,'<p>Wow Mexico looks <strong>cool</strong></p>',7,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 9:53 PM PDT'),(24,'<p>nothin much, you?</p>',1,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 10:49 PM PDT'),(25,'<p>beeeeer </p>',2,'Kiddo','uploads/2021-04-15T04-56-48.672Z-Charizard.png','Apr 2021, 10:50 PM PDT');
/*!40000 ALTER TABLE `blog_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_headers`
--

DROP TABLE IF EXISTS `blog_headers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_headers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `header` varchar(128) NOT NULL,
  `blogId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `blogId_idx` (`blogId`),
  CONSTRAINT `blog_headers_ibfk_1` FOREIGN KEY (`blogId`) REFERENCES `blog` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_headers`
--

LOCK TABLES `blog_headers` WRITE;
/*!40000 ALTER TABLE `blog_headers` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_headers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_imagepaths`
--

DROP TABLE IF EXISTS `blog_imagepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_imagepaths` (
  `id` int NOT NULL AUTO_INCREMENT,
  `blogId` int NOT NULL,
  `imagePath` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `blogId_idx` (`blogId`),
  CONSTRAINT `blog_imagepaths_ibfk_1` FOREIGN KEY (`blogId`) REFERENCES `blog` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_imagepaths`
--

LOCK TABLES `blog_imagepaths` WRITE;
/*!40000 ALTER TABLE `blog_imagepaths` DISABLE KEYS */;
INSERT INTO `blog_imagepaths` VALUES (1,1,'uploads\\2021-04-14T12-36-34.047Z-American-shorthair-cat-scaled.jpg'),(2,2,'uploads\\2021-04-14T12-41-35.273Z-istockphoto-1058117688-612x612.jpg'),(3,3,'uploads\\2021-04-14T12-58-34.609Z-Charizard.png'),(4,4,'uploads\\2021-04-14T14-35-13.109Z-book-piles.jpg'),(5,5,'uploads\\2021-04-15T05-02-08.065Z-chf.jpg'),(6,6,'uploads\\2021-04-15T05-05-32.030Z-20210308_001034.jpg'),(7,7,'uploads\\2021-04-16T04-52-44.697Z-hotel-strip.jpg'),(8,8,'uploads\\2021-04-16T19-42-27.234Z-robot.jpg'),(9,9,'uploads\\2021-04-16T19-48-25.497Z-fabio-oyXis2kALVg-unsplash.jpg');
/*!40000 ALTER TABLE `blog_imagepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_textareas`
--

DROP TABLE IF EXISTS `blog_textareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_textareas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `textArea` varchar(2047) NOT NULL,
  `blogId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `blogId_idx` (`blogId`),
  CONSTRAINT `blogId` FOREIGN KEY (`blogId`) REFERENCES `blog` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_textareas`
--

LOCK TABLES `blog_textareas` WRITE;
/*!40000 ALTER TABLE `blog_textareas` DISABLE KEYS */;
INSERT INTO `blog_textareas` VALUES (1,'<p>Cats are super cute, they blablablablabal Cats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabalCats are super cute, they blablablablabal</p>',1),(2,'<p>Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer, Beer, beer, yum, beer.</p>',2),(3,'<p>People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he People say Charizard is Firey super awesome and epic because he </p>',3),(4,'<p>Something Random</p>',4),(5,'<p>The best place to stay rich if you are already rich. </p>',5),(6,'<p></p><p>Like, filthy rich is best. You will also find a golddigger to marry if that is something you are interested in, boys <em>and</em> girls. I hope you like cows. There is nothing else to entertain yourself with. <br><br>Enjoy! </p>',5),(7,'<p>Because there is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. <u>There is no joy in life.</u> There is no joy in life. There is no joy in life. There is no joy in life. <strong>There is no joy in life.</strong> There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. <em>There is no joy in life.</em> There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. There is no joy in life. </p>',6),(8,'<p>First thing you do</p><p>Tequila</p><p></p><p>Then do another thing</p><p></p><p><strong>BOOM</strong></p><p></p><p></p><p>asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf</p><p>First thing you do</p><p>Tequila</p><p></p><p>Then do another thing</p><p></p><p></p><p>asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf</p><p>First thing you do</p><p>Tequila</p><p></p><p>Then do another thing</p><p></p><p><strong>BOOM</strong></p><p></p><p></p><p>asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf</p><p>First thing you do</p><p>Tequila</p><p></p><p>Then do another thing</p><p></p><p><strong>BOOM</strong></p><p></p><p></p><p>asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf</p><p>First thing you do</p><p>Tequila</p><p></p><p></p>',7),(9,'<p>I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof I have proof </p>',8),(10,'<p>First things first</p>',9);
/*!40000 ALTER TABLE `blog_textareas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` text,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `authorId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `authorId` (`authorId`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`authorId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bio` text,
  `userId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`),
  CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(14) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profileImagePath` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint DEFAULT '0',
  `disabled` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,NULL,'newemail@email.com','username','$2b$10$v9UxZzsmPi8WZke0cw4oSOSSWhF89KRghFo0vC5FkXR5uiig6po3W','uploads\\2021-04-16T17-05-19.739Z-Shawn-tripped.png',0,0),(2,NULL,'tamara@example.com','tamara','$2b$10$ISGSQLk1CZS9NdR/jqvrUOGuSOIHf1PoLqFllvio2uuO4m8.Op4vq','uploads\\2021-04-14T14-37-31.776Z-American-shorthair-cat-scaled.jpg',0,0),(3,NULL,'kiddo@bluewin.ch','Kiddo','$2b$10$G18A.Loinz2VliEA1HPW5e9bBpOotddFFhOoMcjXiPS4Hn3DFodLW','uploads\\2021-04-15T04-56-48.672Z-Charizard.png',0,0),(4,NULL,'admin@email.com','admin','$2b$10$awDAY8M4OWjJWC2.p21bLuOCSOMzqirWuzKugIiCjK.2fq9rDCqwy','uploads\\2021-04-16T17-52-14.079Z-robot.jpg',1,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-16 13:35:35
