CREATE DATABASE  IF NOT EXISTS `beego_blog` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `beego_blog`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: doubleliu.com    Database: beego_blog
-- ------------------------------------------------------
-- Server version	5.1.69

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_album`
--

DROP TABLE IF EXISTS `tb_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_album` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '相册名称',
  `cover` varchar(70) NOT NULL COMMENT '相册封面',
  `posttime` datetime NOT NULL,
  `ishide` tinyint(1) NOT NULL,
  `rank` tinyint(3) NOT NULL DEFAULT '0',
  `photonum` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_mood`
--

DROP TABLE IF EXISTS `tb_mood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_mood` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 NOT NULL,
  `cover` varchar(70) CHARACTER SET utf8 NOT NULL DEFAULT '/static/upload/defaultcover.png' COMMENT '说说图片',
  `posttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_option`
--

DROP TABLE IF EXISTS `tb_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_option` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
INSERT INTO `tb_option` (`id`, `name`, `value`) VALUES (1,'sitename','云卷云舒'),(2,'siteurl','http://blog.doubleliu.com'),(3,'subtitle','带着相机去旅行'),(4,'pagesize','2'),(5,'keywords','摄影'),(6,'description','来一场说走就走的旅行'),(8,'theme','double'),(9,'timezone','8'),(10,'stat','<script language=\"javascript\" type=\"text/javascript\" src=\"http://js.users.51.la/17253002.js\"></script>\r\n<noscript><a href=\"http://www.51.la/?17253002\" target=\"_blank\"><img alt=\"&#x6211;&#x8981;&#x5566;&#x514D;&#x8D39;&#x7EDF;&#x8BA1;\" src=\"http://img.users.51.la/17253002.asp\" style=\"border:none\" /></a></noscript>'),(11,'weibo','http://weibo.com/u/2000465995'),(12,'github','https://github.com/jxufeliujj'),(16,'duoshuo','doubleliu'),(17,'albumsize','9');
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_photo`
--

DROP TABLE IF EXISTS `tb_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_photo` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `albumid` mediumint(8) NOT NULL COMMENT '所属相册ID',
  `des` varchar(100) NOT NULL COMMENT '照片描述',
  `posttime` datetime NOT NULL COMMENT '上传时间',
  `url` varchar(70) NOT NULL COMMENT '照片URL地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 trigger InsertPhoto
after insert on tb_photo
for each row
	update tb_album set photonum=photonum+1 where id = new.albumid */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_post`
--

DROP TABLE IF EXISTS `tb_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_post` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `author` varchar(15) NOT NULL DEFAULT '' COMMENT '作者',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `color` varchar(7) NOT NULL DEFAULT '' COMMENT '标题颜色',
  `urlname` varchar(100) NOT NULL DEFAULT '' COMMENT 'url名',
  `urltype` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'url访问形式',
  `content` mediumtext NOT NULL COMMENT '内容',
  `tags` varchar(100) NOT NULL DEFAULT '' COMMENT '标签',
  `views` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '查看次数',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态{0:正常,1:草稿,2:回收站}',
  `posttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `istop` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否置顶',
  `cover` varchar(70) DEFAULT '/static/upload/defaultcover.png' COMMENT '文章封面',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `posttime` (`posttime`),
  KEY `urlname` (`urlname`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_tag`
--

DROP TABLE IF EXISTS `tb_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_tag` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '标签名',
  `count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '使用次数',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_tag_post`
--

DROP TABLE IF EXISTS `tb_tag_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_tag_post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tagid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '标签id',
  `postid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '内容id',
  `poststatus` tinyint(3) NOT NULL DEFAULT '0' COMMENT '内容状态',
  `posttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `tagid` (`tagid`),
  KEY `postid` (`postid`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(15) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `logincount` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `lastip` varchar(15) NOT NULL DEFAULT '0' COMMENT '最后登录ip',
  `lastlogin` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后登录时间',
  `authkey` char(10) NOT NULL DEFAULT '' COMMENT '登录key',
  `active` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否激活',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `tb_user` VALUES (1,'admin','7fef6171469e80d32c0559f88b377245','admin@admin.com',6,'127.0.0.1','2013-12-25 10:00:11','',1);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-09-15 16:53:52

CREATE TABLE `tb_link` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `sitename` varchar(80) NOT NULL DEFAULT '' COMMENT '网站名字',
  `url` varchar(200) NOT NULL DEFAULT '' COMMENT '友链URL地址',
  `rank` tinyint(4) NOT NULL DEFAULT '0' COMMENT '排序值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_link
-- ----------------------------
INSERT INTO tb_link VALUES ('1', '云卷云舒', 'http://www.doubleliu.com', '0');
INSERT INTO tb_link VALUES ('2', '兜里', 'http://dou.li', '0');