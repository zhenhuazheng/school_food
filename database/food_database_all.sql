/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.5.40 : Database - food
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `food_address` */

DROP TABLE IF EXISTS `food_address`;

CREATE TABLE `food_address` (
  `addressId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '地址编号',
  `userId` bigint(20) NOT NULL COMMENT '用户编号',
  `defaulted` tinyint(1) DEFAULT NULL COMMENT '是否首选(1表示是，0表示否)',
  `address` varchar(255) NOT NULL COMMENT '用户住址',
  PRIMARY KEY (`addressId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `food_address` */

insert  into `food_address`(`addressId`,`userId`,`defaulted`,`address`) values (1,1,0,'厦门市集美大学银江路183号'),(2,1,0,'厦门市思明区思明南路40号1107室'),(3,1,0,'厦门市集美大学诚毅集友3号楼209号'),(4,1,1,'厦门市集美大学六社区五组团113'),(5,15,0,'测试地址1');

/*Table structure for table `food_comment` */

DROP TABLE IF EXISTS `food_comment`;

CREATE TABLE `food_comment` (
  `commentId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论编号',
  `orderDetailId` bigint(20) DEFAULT NULL COMMENT '订单细则编号',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户编号(冗余)',
  `commentScore` decimal(5,2) DEFAULT NULL COMMENT '评论评分',
  `commentContent` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `commentTime` datetime DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `food_comment` */

insert  into `food_comment`(`commentId`,`orderDetailId`,`userId`,`commentScore`,`commentContent`,`commentTime`) values (2,47,1,'3.50','还不错','2020-12-08 13:57:03'),(3,46,1,'4.00','还不错','2020-12-08 14:04:20'),(4,48,1,'5.00','好吃','2020-12-08 14:12:46'),(5,47,1,'5.00','好吃\n','2020-12-11 11:16:30'),(6,63,15,'1.50','份量严重不足，就这么小小一份不够吃！','2020-12-17 18:35:12'),(7,65,15,'5.00','肥宅快乐水无敌！！！','2020-12-17 18:35:52'),(8,67,1,'3.50','好不错 下饭','2020-12-23 15:15:04');

/*Table structure for table `food_complaint` */

DROP TABLE IF EXISTS `food_complaint`;

CREATE TABLE `food_complaint` (
  `complaintId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '投诉编号',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户编号',
  `orderId` varchar(20) DEFAULT NULL COMMENT '订单编号',
  `complaintType` int(11) DEFAULT NULL COMMENT '投诉类型(1表示投诉配送员;2表示投诉菜品;3表示其他)',
  `target` varchar(120) DEFAULT NULL COMMENT '投诉对象',
  `complaintContent` varchar(255) DEFAULT NULL COMMENT '投诉内容',
  `complaintTime` datetime DEFAULT NULL COMMENT '投诉时间',
  PRIMARY KEY (`complaintId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `food_complaint` */

insert  into `food_complaint`(`complaintId`,`userId`,`orderId`,`complaintType`,`target`,`complaintContent`,`complaintTime`) values (2,1,'D2020120515470293611',1,'配送员','超时严重!!','2020-12-09 15:47:19'),(3,1,'D2020120515470293611',1,'配送员','配送时间严重超时!!!','2020-12-09 15:59:16'),(4,1,'D2020120515444831014',2,'炒河粉(中份)','太咸了，怎么会这么难吃？？\n搞什么东西？？？\n厨师脑子被驴踢了？？？','2020-12-09 16:06:03'),(5,1,'D2020120515502737442',3,'其他','包装破洞，汤全撒了，怎么吃嘛！','2020-12-09 16:16:31'),(6,1,'D2020121111143447981',1,'配送员','太channel','2020-12-11 11:17:02'),(7,15,'D2020121718331637766',1,'配送员','配送员态度极差！','2020-12-17 18:37:52'),(8,1,'D2020122315012998498',1,'配送员','配送过慢','2020-12-23 15:15:24'),(9,1,'D2020122522345381426',1,'配送员','这个渣男，不配送我的','2020-12-25 22:37:21');

/*Table structure for table `food_deliver` */

DROP TABLE IF EXISTS `food_deliver`;

CREATE TABLE `food_deliver` (
  `deliverId` varchar(16) NOT NULL COMMENT '配送员编号',
  `userId` bigint(20) NOT NULL COMMENT '用户编号',
  `realName` varchar(30) DEFAULT NULL COMMENT '真实姓名',
  `imageUrl` varchar(255) DEFAULT NULL COMMENT '证件照片路径',
  `orderCount` int(11) DEFAULT '0' COMMENT '接单总数',
  `faultCount` int(11) DEFAULT '0' COMMENT '差评总数',
  `finishCount` int(11) DEFAULT '0' COMMENT '结单总数',
  `joinDate` date DEFAULT NULL COMMENT '入职日期',
  `leaveDate` date DEFAULT NULL COMMENT '离职日期',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注（特别说明）',
  PRIMARY KEY (`deliverId`),
  KEY `userId` (`userId`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `food_user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `food_deliver` */

insert  into `food_deliver`(`deliverId`,`userId`,`realName`,`imageUrl`,`orderCount`,`faultCount`,`finishCount`,`joinDate`,`leaveDate`,`remark`) values ('2020111416380943',1,'无敌的管理员','deliver/20201117/9e4116cccd1f4dbb81ceba3c0aae0707.jpg',10,5,7,'2020-11-14',NULL,NULL),('2020111610424485',12,'二狗子','deliver/2020-11-16/2dbfcad525274b488b2e1cbc4bb61a26.jpg',0,0,0,'2020-12-25',NULL,'67th'),('2020111610452940',5,'test4','deliver2020-11-16/7af5fba80cf04f9fb1392eb055b0162a.jpg',0,0,0,'2020-11-16',NULL,'rghedhb rh rbegergege'),('2020111612415504',7,'cbvv','deliver/defaultImages/defaultImage.png',0,0,0,'2020-11-16',NULL,'vdxv'),('2020111619211668',8,'名字','deliver/20201116/69e2cfb06f514cf4bf3a7ed3c9840064.jpg',24,0,23,'2020-11-16',NULL,'scvv'),('2020111619254468',3,'nnn','deliver/defaultImage/defaultImage.png',38,1,29,'2020-11-16',NULL,'zcvxxzcv'),('2020111619284943',9,'999777','deliver/20201117/9c2082271ef14562b2ecace7eaefcce5.jpg',0,0,0,'2020-12-23',NULL,'vzv'),('2020111619301947',13,'BUG Maker','deliver/defaultImage/defaultImage.png',42,4,35,'2020-12-23','2020-12-23','asdasdalkfdjalkfnlaskdfnlkisvnklsjvnksvnsxcz'),('2020112111003748',2,NULL,'deliver/defaultImage/defaultImage.png',0,0,0,'2020-11-28',NULL,NULL),('2020112117440627',14,'kounijiwa','deliver/20201121/18d1ca06077f4cbf9694eaa8ead63e66.jpg',0,0,0,'2020-11-21',NULL,'123'),('2020121718154644',15,'测试用户','deliver/20201217/44691d9d51c14fd89d2d60caef41e7cb.jpg',2,1,1,'2020-12-17',NULL,'女 28岁');

/*Table structure for table `food_food` */

DROP TABLE IF EXISTS `food_food`;

CREATE TABLE `food_food` (
  `foodId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜品编号',
  `foodName` varchar(80) NOT NULL COMMENT '菜品名称',
  `foodTypeId` bigint(20) NOT NULL COMMENT '菜品类别编号',
  `foodIngredient` varchar(255) DEFAULT '暂无信息' COMMENT '菜品配料',
  `foodVegon` varchar(60) DEFAULT '暂无信息' COMMENT '菜品荤素描述',
  `foodCookWay` varchar(60) DEFAULT '暂无信息' COMMENT '菜品烹饪方式',
  `foodFaultCount` int(11) DEFAULT '0' COMMENT '菜品差评数',
  `foodDesc` varchar(255) DEFAULT '暂无信息' COMMENT '菜品描述',
  `foodImage` varchar(255) DEFAULT NULL COMMENT '菜品图片路径',
  `foodSaleCount` int(11) DEFAULT '0' COMMENT '菜品销量',
  `foodViewCount` int(11) DEFAULT '0' COMMENT '菜品浏览量',
  `foodScore` decimal(5,2) DEFAULT '2.50' COMMENT '平均分',
  `commentCount` int(11) DEFAULT '0' COMMENT '评论数',
  `recommend` int(11) DEFAULT '2' COMMENT '是否推荐（1表示是；2表示否）',
  `hotSale` int(11) DEFAULT '2' COMMENT '是否热销（1表示是；2表示否）',
  `foodStatus` int(11) DEFAULT '3' COMMENT '菜品状态（1表示上架中；2表示下架；3表示未完善）',
  `lastModifyBy` varchar(60) DEFAULT NULL COMMENT '上次修改人',
  `lastModifyTime` datetime DEFAULT NULL COMMENT '上次修改时间',
  `dayStock` int(11) DEFAULT NULL COMMENT '每日供量',
  PRIMARY KEY (`foodId`),
  KEY `foodTypeId` (`foodTypeId`),
  CONSTRAINT `food_food_ibfk_1` FOREIGN KEY (`foodTypeId`) REFERENCES `food_foodtype` (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `food_food` */

insert  into `food_food`(`foodId`,`foodName`,`foodTypeId`,`foodIngredient`,`foodVegon`,`foodCookWay`,`foodFaultCount`,`foodDesc`,`foodImage`,`foodSaleCount`,`foodViewCount`,`foodScore`,`commentCount`,`recommend`,`hotSale`,`foodStatus`,`lastModifyBy`,`lastModifyTime`,`dayStock`) values (14,'糖醋排骨',3,'排骨、菠萝、红萝卜','荤菜','糖醋',0,'下饭首选！','food/20201126/45b360068d094f27995e9f9ef9c20598.png',6,4,'2.50',0,2,1,1,'admin','2020-12-11 11:34:47',50),(15,'香煎猪扒',3,'猪扒','荤菜','香煎',0,'       香煎猪扒是一种小吃，主料是猪里脊，配料是鸡蛋等，调料为孜然粉、五香粉、料酒，通过煎制的做法制作而成。\n       猪瘦肉的营养非常全面，不但为人类提供优质蛋白质和必需的脂肪酸，还提供大量的钙、磷、铁、硫胺素、核黄素和尼克酸等营养元素。猪瘦肉的营养优势在于它含有丰富的B族维生素，能调节新陈代谢，维持皮肤和肌肉的健康，增强免疫系统和神经系统的功能，预防贫血发生，而且猪瘦肉中的血红蛋白比植物中的更好吸收。\n','food/20201128/64407c1d92cf4080ac732dda17a1e921.png',14,29,'2.50',0,2,1,1,'admin','2020-11-30 10:04:11',50),(16,'炒饭',6,'高丽菜、胡萝卜、肉丝、东北大米','半荤半素','烹炒',0,'一碗顶十碗','food/20201129/2500ef805f5d44a887f4bbce9a1f5e65.png',22,11,'2.63',2,1,2,1,'admin','2020-12-10 16:57:17',50),(17,'干煸茄子',7,'茄子、肉末','半荤半素','干煸',0,'茄子、肉末','food/20201129/3ade503a24544512b17083a4d57fd1e8.png',64,12,'3.75',4,1,2,1,'admin','2020-11-29 23:21:31',50),(18,'炒河粉',6,'河粉、牛肉、芽菜、葱花、老抽、味精、生抽、糖适量混合待用','半荤半素','炒',1,'炒河粉能够有以下好处：①补充能量：含碳水化合物，糖类，能迅速为身体提供能量。②安神除烦：碳水化合物可以补充大脑消耗的葡萄糖，缓解脑部葡萄糖供养不足而出现的疲惫、易怒、头晕、失眠、夜间出汗、注意力涣散、健忘、极度口渴、沮丧、化紊乱，甚至出现幻觉。','food/20201201/c025b6e7881a4e60b96a72055b8cd3bf.png',23,50,'2.50',1,2,1,1,'admin','2020-12-01 13:38:19',50),(19,'炙烤披萨',6,'火腿粒、香菇、芝士、面团','半荤半素','炙烤',0,'123','food/defaultImage/defaultImage.png',4,6,'2.50',0,1,1,1,'admin','2020-12-18 19:19:01',20),(20,'咖喱土豆丝',7,'土豆','素菜','炒',0,'咖喱土豆丝是一道菜品，主料是土豆，辅料是咖喱酱、盐、油。','food/20201212/a37515aef93d43bcbd28a6712f935e5c.png',1,3,'2.50',0,2,2,1,'admin','2020-12-18 19:17:19',3),(22,'五谷粗粮饭',6,'糙米、米、荞麦、青豆','半荤半素','烹煮',0,'糙米、米、荞麦、青豆。泡四个小时，接着就是跟一般煮饭一样了。混了放电饭锅','food/20201212/9643a3fdfd7a4ac8b8a2ac7af21b2710.png',2,2,'2.50',0,1,2,2,'自动下架','2020-12-12 12:22:17',2),(23,'炸鸡排',3,'鸡排','荤菜','油炸',0,'炸鸡排是小吃，主要食材是鸡大腿或鸡脯肉，工艺是炸，味咸辣。鸡肉中蛋白质含量高，但是油炸食品食用量宜控制。鸡胸肉是在胸部里侧的肉，形状像斗笠。肉质细嫩，滋味鲜美，营养丰富，能滋补养身。 ','food/20201217/ab994c2df18346ba968601861aabac72.png',0,0,'2.50',0,1,2,3,'admin','2020-12-17 13:33:15',15),(24,'可乐',8,'可口可乐调剂','其他','无',0,'有甜味、含咖啡因但不含酒精的碳酸饮料','food/20201217/e714bd9570a047e0865158385471e0e7.png',9,4,'3.75',1,1,1,1,'admin','2020-12-18 19:16:52',15),(25,'炒空心菜',7,'空心菜','荤菜','清炒',0,'炒空心菜是由空心菜为主要食材做成的一道菜品，是一道四川省的传统名菜，属于川菜系。','food/20201223/eb13930f5b3c4ee0a804fc1d60549ee2.png',1,3,'3.00',1,1,1,1,'admin','2020-12-23 14:13:03',600),(26,'炒米粉',6,'河粉（六两）、牛肉（一两）、芽菜（二两）、葱花','半荤半素','烹炒',0,'炒米粉是广东省广州市著名的传统风味小吃，属于广州小吃，后来传至广东各地。制作原料有河粉、猪肉 、鸡蛋、各种青菜 等。','food/20201225/e3eaa32f8a4e4c6b8779a207417353b3.png',3,1,'2.50',0,1,2,2,'自动下架','2020-12-25 22:24:27',2),(27,'雷碧',8,'水，碳水化合物（糖类），二氧化碳（碳酸），食用香精，柠檬酸','其他','无',0,'「雪碧」汽水产品与可口可乐公司的其他饮料产品齐头并进，如今已经成为美国发展速度领先的主要非酒精饮料产品之一，并且是全球深受青睐的柠檬味汽水非酒精饮料产品之一。','food/20201225/619dcf47e8a1498b97524fe3809acc12.png',1,3,'2.50',0,1,1,1,'admin','2020-12-25 22:31:48',100),(28,'格雷三兄弟',8,'仙草布丁珍珠','其他','q',0,'格雷三兄弟是著名的奶茶品种，该品种统一规格为500ml','food/20201226/4fb702d96f3e436c9c78efd8624ec21f.png',2,2,'2.50',0,1,2,2,'自动下架','2020-12-26 11:22:32',2);

/*Table structure for table `food_foodattr` */

DROP TABLE IF EXISTS `food_foodattr`;

CREATE TABLE `food_foodattr` (
  `foodattrId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜品规格集编号',
  `foodattrName` varchar(60) DEFAULT NULL COMMENT '菜品规格集名称',
  PRIMARY KEY (`foodattrId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `food_foodattr` */

insert  into `food_foodattr`(`foodattrId`,`foodattrName`) values (1,'规格'),(2,'口味'),(3,'温度'),(4,'甜度'),(5,'份量'),(6,'主食'),(7,'酱料'),(8,'包装'),(9,'加料'),(10,'小菜'),(11,'小食'),(12,'其他'),(13,'测试test');

/*Table structure for table `food_foodsku` */

DROP TABLE IF EXISTS `food_foodsku`;

CREATE TABLE `food_foodsku` (
  `skuId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜品sku编号',
  `foodId` bigint(20) NOT NULL COMMENT '菜品编号',
  `skuName` varchar(255) NOT NULL COMMENT '菜品sku名称',
  `skuPrice` decimal(5,2) DEFAULT NULL COMMENT '菜品sku价格',
  `skuSale` int(11) DEFAULT '0' COMMENT '菜品sku销量',
  `skuStock` int(11) DEFAULT '0' COMMENT '菜品sku供应量',
  PRIMARY KEY (`skuId`),
  KEY `foodId` (`foodId`),
  CONSTRAINT `food_foodsku_ibfk_1` FOREIGN KEY (`foodId`) REFERENCES `food_food` (`foodId`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

/*Data for the table `food_foodsku` */

insert  into `food_foodsku`(`skuId`,`foodId`,`skuName`,`skuPrice`,`skuSale`,`skuStock`) values (1,14,'糖醋排骨(大份)','46.00',0,0),(2,14,'糖醋排骨(中份)','43.00',6,0),(3,14,'糖醋排骨(小份)','83.00',0,0),(4,14,'糖醋排骨(test)','76.00',56,0),(6,15,'香煎猪扒(番茄酱)','45.00',5,30),(7,15,'香煎猪扒(甜辣酱)','10.00',8,20),(8,15,'香煎猪扒(黑胡椒酱)','10.00',1,23),(9,15,'香煎猪扒(千岛酱)','12.00',0,20),(10,15,'香煎猪扒(猪扒测试)','13.00',0,3),(11,16,'炒饭(牛肉丁)','8.00',2,30),(12,16,'炒饭(猪肉丁)','6.00',14,30),(13,16,'炒饭(火腿肠)','5.00',6,50),(14,17,'干煸茄子(辣)','3.50',0,50),(15,17,'干煸茄子(不辣)','3.50',64,30),(16,18,'炒河粉(大份)','12.00',0,100),(17,18,'炒河粉(中份)','10.00',23,100),(18,18,'炒河粉(小份)','8.00',0,100),(19,19,'test(大份)','16.00',1,0),(20,19,'test(中份)','12.00',1,0),(21,19,'test(小份)','14.00',2,0),(22,20,'咖喱土豆丝(大份)','2.50',1,0),(23,20,'咖喱土豆丝(小份)','1.50',0,0),(24,22,'五谷粗粮饭(大份)','12.00',0,0),(25,22,'五谷粗粮饭(中份)','11.00',2,0),(26,22,'五谷粗粮饭(小份)','10.00',0,0),(27,23,'炸鸡排(孜然味)',NULL,0,0),(28,23,'炸鸡排(微辣)',NULL,0,0),(29,23,'炸鸡排(香辣)',NULL,0,0),(30,24,'可乐(大杯)','2.50',4,0),(31,24,'可乐(中杯)','2.00',0,0),(32,24,'可乐(小杯)','1.50',0,0),(33,24,'可乐(听装)','3.00',5,0),(34,25,'炒空心菜(大份)','3.00',1,0),(35,25,'炒空心菜(中份)','2.00',0,0),(36,25,'炒空心菜(小份)','1.50',0,0),(37,26,'炒米粉(大份)','8.00',3,0),(38,26,'炒米粉(中份)','7.00',0,0),(39,26,'炒米粉(小份)','6.00',0,0),(40,27,'雷碧(冰)','2.00',1,0),(41,27,'雷碧(常温)','2.00',0,0),(42,28,'格雷三兄弟(常温)','5.00',2,0),(43,28,'格雷三兄弟(加冰)','6.00',0,0),(44,28,'格雷三兄弟(wenre)','7.00',0,0);

/*Table structure for table `food_foodtype` */

DROP TABLE IF EXISTS `food_foodtype`;

CREATE TABLE `food_foodtype` (
  `typeId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜品类别编号',
  `typeName` varchar(60) NOT NULL COMMENT '菜品类别名',
  `typeDesc` varchar(255) DEFAULT NULL COMMENT '菜品类别介绍',
  `lastModifyBy` varchar(60) DEFAULT NULL COMMENT '上次修改人',
  `lastModifyTime` datetime DEFAULT NULL COMMENT '上次修改日期',
  `typeStatus` int(11) DEFAULT NULL COMMENT '状态（1表示使用中；2表示下架）',
  `typeImage` varchar(255) DEFAULT NULL COMMENT '菜品类别大图',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `food_foodtype` */

insert  into `food_foodtype`(`typeId`,`typeName`,`typeDesc`,`lastModifyBy`,`lastModifyTime`,`typeStatus`,`typeImage`) values (3,'中餐','123','admin','2020-12-10 19:28:55',1,'foodtype/20201121/11a3b2e87e864abfb2628432086cc41b.jpg'),(4,'面食','gullugluglglglglg','admin','2020-12-25 22:12:03',2,'foodtype/20201121/d9d5688373a54dbe8c30d894aea735fb.png'),(5,'麻辣烫','defaulteddddd','admin','2020-12-25 22:26:15',2,'foodtype/defaultImage/defaultImage.png'),(6,'主食','rice','admin','2020-12-05 15:46:21',1,'foodtype/defaultImage/defaultImage.png'),(7,'小炒','小炒','admin','2020-11-29 23:04:31',1,'foodtype/defaultImage/defaultImage.png'),(8,'饮品','各种饮料','测试用户','2020-12-17 18:01:28',1,'foodtype/defaultImage/defaultImage.png');

/*Table structure for table `food_foodvalue` */

DROP TABLE IF EXISTS `food_foodvalue`;

CREATE TABLE `food_foodvalue` (
  `foodvalueId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜品规格编号',
  `foodattrId` bigint(20) NOT NULL COMMENT '菜品规格集编号',
  `foodId` bigint(20) NOT NULL COMMENT '菜品编号',
  `foodvalueName` varchar(60) NOT NULL COMMENT '菜品规格名',
  PRIMARY KEY (`foodvalueId`),
  KEY `foodattrId` (`foodattrId`),
  KEY `foodId` (`foodId`),
  CONSTRAINT `food_foodvalue_ibfk_1` FOREIGN KEY (`foodattrId`) REFERENCES `food_foodattr` (`foodattrId`),
  CONSTRAINT `food_foodvalue_ibfk_2` FOREIGN KEY (`foodId`) REFERENCES `food_food` (`foodId`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

/*Data for the table `food_foodvalue` */

insert  into `food_foodvalue`(`foodvalueId`,`foodattrId`,`foodId`,`foodvalueName`) values (22,1,14,'大份'),(23,1,14,'中份'),(24,1,14,'小份'),(25,1,14,'test'),(27,7,15,'番茄酱'),(28,7,15,'甜辣酱'),(29,7,15,'黑胡椒酱'),(30,7,15,'千岛酱'),(31,7,15,'猪扒测试'),(32,1,16,'牛肉丁'),(33,1,16,'猪肉丁'),(34,1,16,'火腿肠'),(35,1,17,'辣'),(36,1,17,'不辣'),(37,5,18,'大份'),(38,5,18,'中份'),(39,5,18,'小份'),(40,5,19,'大份'),(41,5,19,'中份'),(42,5,19,'小份'),(43,1,20,'大份'),(44,1,20,'小份'),(45,1,22,'大份'),(46,1,22,'中份'),(47,1,22,'小份'),(48,2,23,'孜然味'),(49,2,23,'微辣'),(50,2,23,'香辣'),(51,1,24,'大杯'),(52,1,24,'中杯'),(53,1,24,'小杯'),(54,1,24,'听装'),(55,1,25,'大份'),(56,1,25,'中份'),(57,1,25,'小份'),(58,5,26,'大份'),(59,5,26,'中份'),(60,5,26,'小份'),(61,3,27,'冰'),(62,3,27,'常温'),(63,3,28,'常温'),(64,3,28,'加冰'),(65,3,28,'wenre');

/*Table structure for table `food_menu` */

DROP TABLE IF EXISTS `food_menu`;

CREATE TABLE `food_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `pid` int(11) DEFAULT '0' COMMENT '父级菜单编号（为空默认为0）',
  `title` varchar(100) DEFAULT NULL COMMENT '菜单名称',
  `href` varchar(255) DEFAULT NULL COMMENT '菜单路径',
  `spread` int(11) DEFAULT '0' COMMENT '是否展开（0表示否，1表示是）',
  `icon` varchar(60) DEFAULT NULL COMMENT '菜单图标',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `food_menu` */

insert  into `food_menu`(`id`,`pid`,`title`,`href`,`spread`,`icon`) values (1,0,'系统管理',NULL,1,NULL),(2,1,'用户管理','/schoolFood/backstage/userManage.html',1,'fa fa-user-o'),(3,1,'角色管理','/schoolFood/backstage/roleManage.html',0,'fa fa-vcard-o'),(4,1,'菜单管理','/schoolFood/backstage/menuManage.html',0,'fa fa-th-list'),(5,6,'菜品管理','',1,'fa fa-gears'),(6,0,'食堂管理','',1,'fa fa-building'),(7,6,'配送员管理','/schoolFood/backstage/deliverManage.html',0,'fa fa-shopping-bag'),(8,0,'用户前台','',1,''),(9,8,'个人中心','/schoolFood/userInfo.html',0,'fa fa-user'),(10,5,'菜品类别管理','/schoolFood/backstage/foodtypeManage.html',0,'fa fa-inbox'),(11,5,'菜品规格组管理','/schoolFood/backstage/foodattrManage.html',1,'fa fa-sitemap'),(12,5,'菜品SPU管理','/schoolFood/backstage/foodManage.html',1,'fa fa-cutlery'),(13,5,'菜品SKU管理','/schoolFood/backstage/foodSkuManage.html',1,'fa fa-tasks'),(14,8,'点餐中心','/schoolFood/reception/foodCenter.html',1,'fa fa-align-center'),(15,6,'优惠券管理','',1,'fa fa-ticket'),(16,15,'优惠券类别管理','/schoolFood/backstage/ticketTypeManage.html',1,'fa fa-bars'),(17,15,'领取记录管理','/schoolFood/backstage/ticketManage.html',1,'fa fa-credit-card'),(18,8,'我的购物车','/schoolFood/reception/shopcart.html',1,'fa fa-shopping-cart'),(19,8,'优惠券商城','/schoolFood/reception/ticketShop.html',1,'fa fa-ticket'),(20,6,'订单分配管理','/schoolFood/backstage/orderAllocationManage.html',1,'fa fa-clipboard'),(21,0,'配送员面板','',1,''),(22,21,'待配送订单','/schoolFood/backstage/orderDeliverManage.html',1,'fa fa-map'),(23,21,'配送记录','/schoolFood/backstage/deliverRecord.html',1,'fa fa-list-alt'),(24,6,'投诉中心','/schoolFood/backstage/complaintManage.html',1,'fa fa-commenting-o'),(25,6,'数据观星','/schoolFood/backstage/dataChart',1,'fa fa-bar-chart-o');

/*Table structure for table `food_order` */

DROP TABLE IF EXISTS `food_order`;

CREATE TABLE `food_order` (
  `orderId` varchar(20) NOT NULL COMMENT '订单编号(D+时间戳+5位随机数)',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户编号',
  `address` varchar(255) DEFAULT NULL COMMENT '地址(冗余)',
  `realName` varchar(30) DEFAULT NULL COMMENT '收货人姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '收货人手机号',
  `totalCount` int(11) DEFAULT NULL COMMENT '总菜品计数',
  `totalPrice` decimal(5,2) DEFAULT NULL COMMENT '应付金额',
  `actualPrice` decimal(5,2) DEFAULT NULL COMMENT '实付金额',
  `ticketId` bigint(20) DEFAULT NULL COMMENT '优惠券编号',
  `cheap` decimal(5,2) DEFAULT '0.00' COMMENT '优惠金额',
  `deliverId` varchar(16) DEFAULT NULL COMMENT '配送员编号',
  `deliverName` varchar(60) DEFAULT NULL COMMENT '配送员姓名(冗余)',
  `deliverPhone` varchar(20) DEFAULT NULL COMMENT '配送员电话(冗余)',
  `orderTime` datetime DEFAULT NULL COMMENT '下单时间',
  `finishTime` datetime DEFAULT NULL COMMENT '送达时间',
  `orderStatus` int(11) DEFAULT NULL COMMENT '订单状态(1表示出餐中；2表示配送中；3表示已完成；4表示未支付；5表示已取消)',
  `complaint` int(11) DEFAULT '2' COMMENT '是否投诉(1表示是；2表示否)',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `food_order` */

insert  into `food_order`(`orderId`,`userId`,`address`,`realName`,`phone`,`totalCount`,`totalPrice`,`actualPrice`,`ticketId`,`cheap`,`deliverId`,`deliverName`,`deliverPhone`,`orderTime`,`finishTime`,`orderStatus`,`complaint`) values ('D2020120515444831014',1,'厦门市思明区思明南路40号1107室','hhj','18750916277',8,'43.50','43.50',NULL,'0.00','2020111416380943','无敌的管理员','18750916277','2020-12-05 15:44:48','2020-12-06 20:27:20',3,1),('D2020120515470293611',1,'厦门市集美大学六社区五组团113','asda','18750916277',2,'13.50','13.50',NULL,'0.00','2020111416380943','无敌的管理员','18750916277','2020-12-05 15:47:02','2020-12-09 16:16:57',3,1),('D2020120515502737442',1,'厦门市思明区思明南路40号1107室','ccc','18750916277',1,'45.00','40.00',10,'5.00',NULL,NULL,NULL,'2020-12-05 15:50:27',NULL,1,1),('D2020120616564945555',1,'厦门市集美大学诚毅集友3号楼209号','马一鸣','18750916277',5,'25.00','25.00',NULL,'0.00',NULL,NULL,NULL,'2020-12-06 16:56:49',NULL,1,2),('D2020120616575351305',1,'厦门市集美大学诚毅集友3号楼209号','张锦龙','18750916277',3,'30.00','30.00',NULL,'0.00',NULL,NULL,NULL,'2020-12-06 16:57:53',NULL,5,2),('D2020121111143447981',1,'厦门市思明区思明南路40号1107室','梁杰','18750916277',9,'286.00','267.00',13,'19.00','2020111416380943','无敌的管理员','18750916277','2020-12-11 11:14:34','2020-12-11 11:15:37',3,1),('D2020121119064868029',1,'厦门市集美大学诚毅集友3号楼209号','张三','18750916277',1,'45.00','45.00',NULL,'0.00','2020111416380943','无敌的管理员','18750916277','2020-12-11 19:06:48','2020-12-11 19:07:29',3,2),('D2020121119155771829',1,'厦门市集美大学诚毅集友3号楼209号','李四','18750916277',2,'28.00','28.00',NULL,'0.00','2020111416380943','无敌的管理员','18750916277','2020-12-11 19:15:57','2020-12-11 19:17:39',3,2),('D2020121212221775706',1,'厦门市集美大学诚毅集友3号楼209号','王五','18750916277',2,'22.00','22.00',NULL,'0.00',NULL,NULL,NULL,'2020-12-12 12:22:17',NULL,1,2),('D2020121319363390616',1,'厦门市集美大学诚毅集友3号楼209号','华哥','18750916277',1,'12.00','12.00',NULL,'0.00',NULL,NULL,NULL,'2020-12-13 19:36:33',NULL,1,2),('D2020121710200022157',1,'厦门市集美大学诚毅集友3号楼209号','测试人','18750916277',3,'96.00','91.00',15,'5.00',NULL,NULL,NULL,'2020-12-17 10:20:00',NULL,1,2),('D2020121718331637766',15,'测试地址1','测试用户','12312312312',8,'32.50','30.50',18,'2.00','2020121718154644','测试用户','12312312312','2020-12-17 18:33:16','2020-12-17 18:34:26',3,1),('D2020122315012998498',1,'厦门市集美大学六社区五组团113','王五','18750916277',12,'79.00','74.00',16,'5.00','2020111416380943','无敌的管理员','18750916277','2020-12-23 15:01:29','2020-12-23 15:11:38',3,1),('D2020122522235795764',1,'厦门市集美大学六社区五组团113','马保国','18750916277',2,'16.00','16.00',NULL,'0.00',NULL,NULL,NULL,'2020-12-25 22:23:57',NULL,1,2),('D2020122522242727817',1,'厦门市集美大学六社区五组团113','hhm','18750916277',1,'8.00','8.00',NULL,'0.00',NULL,NULL,NULL,'2020-12-25 22:24:27',NULL,1,2),('D2020122522345381426',1,'厦门市集美大学诚毅集友3号楼209号','蒋介石','18750916277',2,'47.00','45.00',19,'2.00','2020111416380943','无敌的管理员','18750916277','2020-12-25 22:34:53','2020-12-25 22:37:32',3,1),('D2020122611223241945',1,'厦门市集美大学六社区五组团113','www','18750916277',2,'10.00','10.00',NULL,'0.00',NULL,NULL,NULL,'2020-12-26 11:22:32',NULL,1,2);

/*Table structure for table `food_orderdetail` */

DROP TABLE IF EXISTS `food_orderdetail`;

CREATE TABLE `food_orderdetail` (
  `orderDetailId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单细则编号',
  `orderId` varchar(20) DEFAULT NULL COMMENT '订单编号',
  `skuId` bigint(20) DEFAULT NULL COMMENT '菜品SKU编号',
  `amount` int(11) DEFAULT NULL COMMENT '条目计数',
  `itemPrice` decimal(5,2) DEFAULT NULL COMMENT '条目价格',
  `comment` int(2) DEFAULT NULL COMMENT '是否评价(1表示已评价；2表示未评价)',
  PRIMARY KEY (`orderDetailId`),
  KEY `orderId` (`orderId`),
  CONSTRAINT `food_orderdetail_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `food_order` (`orderId`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

/*Data for the table `food_orderdetail` */

insert  into `food_orderdetail`(`orderDetailId`,`orderId`,`skuId`,`amount`,`itemPrice`,`comment`) values (46,'D2020120515444831014',17,2,'20.00',1),(47,'D2020120515444831014',15,5,'17.50',1),(48,'D2020120515444831014',12,1,'6.00',1),(49,'D2020120515470293611',15,1,'3.50',2),(50,'D2020120515470293611',17,1,'10.00',2),(51,'D2020120515502737442',6,1,'45.00',2),(52,'D2020120616564945555',13,5,'25.00',2),(53,'D2020120616575351305',7,3,'30.00',2),(54,'D2020121111143447981',19,1,'16.00',2),(55,'D2020121111143447981',2,6,'258.00',2),(56,'D2020121111143447981',12,2,'12.00',2),(57,'D2020121119064868029',6,1,'45.00',2),(58,'D2020121119155771829',21,2,'28.00',2),(59,'D2020121212221775706',25,2,'22.00',2),(60,'D2020121319363390616',20,1,'12.00',2),(61,'D2020121710200022157',6,2,'90.00',2),(62,'D2020121710200022157',12,1,'6.00',2),(63,'D2020121718331637766',13,1,'5.00',1),(64,'D2020121718331637766',22,1,'2.50',2),(65,'D2020121718331637766',33,5,'15.00',1),(66,'D2020121718331637766',8,1,'10.00',2),(67,'D2020122315012998498',34,1,'3.00',1),(68,'D2020122315012998498',30,4,'10.00',2),(69,'D2020122315012998498',7,5,'50.00',2),(70,'D2020122315012998498',11,2,'16.00',2),(71,'D2020122522235795764',37,2,'16.00',2),(72,'D2020122522242727817',37,1,'8.00',2),(73,'D2020122522345381426',6,1,'45.00',2),(74,'D2020122522345381426',40,1,'2.00',2),(75,'D2020122611223241945',42,2,'10.00',2);

/*Table structure for table `food_role` */

DROP TABLE IF EXISTS `food_role`;

CREATE TABLE `food_role` (
  `roleId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `roleName` varchar(60) DEFAULT NULL COMMENT '角色名称',
  `roleDesc` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `lastModifyBy` varchar(60) DEFAULT NULL COMMENT '上次修改人',
  `lastModifyTime` datetime DEFAULT NULL COMMENT '上次修改时间',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `food_role` */

insert  into `food_role`(`roleId`,`roleName`,`roleDesc`,`lastModifyBy`,`lastModifyTime`) values (1,'普通用户','普通用户的权限限于前台','admin','2020-11-12 21:27:23'),(2,'配送员','负责餐品的配送服务','admin','2020-11-14 16:27:22'),(3,'食堂管理员','负责食堂日常事务的管理和维护','admin','2020-11-14 16:27:49'),(4,'系统管理员','负责系统的权责划分和用户的角色授予','admin','2020-11-14 16:28:23'),(5,'测试角色','全权限，开发测试专用','admin','2020-11-14 17:02:40');

/*Table structure for table `food_role_menu` */

DROP TABLE IF EXISTS `food_role_menu`;

CREATE TABLE `food_role_menu` (
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色编号',
  `menuId` int(11) DEFAULT NULL COMMENT '菜单编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `food_role_menu` */

insert  into `food_role_menu`(`roleId`,`menuId`) values (5,1),(5,2),(5,3),(5,4),(5,6),(5,5),(5,10),(5,11),(5,12),(5,13),(5,7),(5,15),(5,16),(5,17),(5,20),(5,24),(5,25),(5,8),(5,9),(5,14),(5,18),(5,19),(5,21),(5,22),(5,23),(1,8),(1,9),(1,14),(1,18),(1,19),(2,8),(2,9),(2,21),(2,22),(2,23),(3,6),(3,5),(3,10),(3,11),(3,12),(3,13),(3,7),(3,15),(3,16),(3,17),(3,20),(3,24),(3,25),(3,8),(3,9),(4,1),(4,2),(4,3),(4,4),(4,8),(4,9),(4,14),(4,18),(4,19);

/*Table structure for table `food_shopcart` */

DROP TABLE IF EXISTS `food_shopcart`;

CREATE TABLE `food_shopcart` (
  `shopcartId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '购物车细则编号',
  `skuId` bigint(20) DEFAULT NULL COMMENT '菜品SKU编号',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户编号',
  `numCount` int(11) DEFAULT NULL COMMENT '购买数量',
  PRIMARY KEY (`shopcartId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `food_shopcart` */

/*Table structure for table `food_ticket` */

DROP TABLE IF EXISTS `food_ticket`;

CREATE TABLE `food_ticket` (
  `ticketId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '优惠券编号',
  `ticketTypeId` bigint(20) DEFAULT NULL COMMENT '优惠券类别编号',
  `userId` bigint(20) DEFAULT NULL COMMENT '领取用户编号',
  `endTime` date DEFAULT NULL COMMENT '失效时间',
  `ticketStatus` int(11) DEFAULT NULL COMMENT '优惠券状态(1表示未使用；2表示已使用；3表示已过期；4表示作废;5表示积分已返还)',
  `startTime` date DEFAULT NULL COMMENT '领取时间',
  PRIMARY KEY (`ticketId`),
  KEY `ticketTypeId` (`ticketTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `food_ticket` */

insert  into `food_ticket`(`ticketId`,`ticketTypeId`,`userId`,`endTime`,`ticketStatus`,`startTime`) values (1,2,1,'2020-12-09',4,'2020-12-01'),(2,1,1,'2020-12-08',3,'2020-12-01'),(3,3,1,'2020-12-08',5,'2020-12-01'),(4,3,1,'2020-12-08',2,'2020-12-01'),(5,2,1,'2020-12-09',2,'2020-12-01'),(6,2,1,'2020-12-09',3,'2020-12-01'),(7,1,1,'2020-12-08',4,'2020-12-01'),(8,1,1,'2020-12-08',3,'2020-12-01'),(9,1,1,'2020-10-26',3,'2020-12-01'),(10,2,1,'2020-12-09',2,'2020-12-01'),(11,2,1,'2020-12-10',3,'2020-12-02'),(12,1,1,'2020-12-17',3,'2020-12-10'),(13,4,1,'2020-12-18',2,'2020-12-11'),(14,4,1,'2020-12-21',3,'2020-12-14'),(15,2,1,'2020-12-25',2,'2020-12-17'),(16,2,1,'2020-12-25',2,'2020-12-17'),(17,5,15,'2020-12-22',5,'2020-12-17'),(18,5,15,'2020-12-22',2,'2020-12-17'),(19,5,1,'2020-12-28',2,'2020-12-23');

/*Table structure for table `food_tickettype` */

DROP TABLE IF EXISTS `food_tickettype`;

CREATE TABLE `food_tickettype` (
  `ticketTypeId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '优惠券类别编号',
  `ticketName` varchar(120) DEFAULT NULL COMMENT '优惠券名称',
  `requirement` decimal(5,2) DEFAULT NULL COMMENT '满减门槛',
  `cheap` decimal(5,2) DEFAULT NULL COMMENT '优惠额度',
  `ticketNum` int(11) DEFAULT NULL COMMENT '供应数量',
  `receive` int(11) DEFAULT '0' COMMENT '已领取数',
  `liveTime` int(11) DEFAULT NULL COMMENT '领取后有效天数',
  `lastModifyBy` varchar(60) DEFAULT NULL COMMENT '上次修改人',
  `lastModifyTime` datetime NOT NULL COMMENT '上次修改时间',
  `ticketTypeStatus` int(11) DEFAULT '2' COMMENT '优惠券类别状态(1表示上架；2表示下架)',
  `needScore` int(11) DEFAULT NULL COMMENT '兑换所需积分',
  PRIMARY KEY (`ticketTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `food_tickettype` */

insert  into `food_tickettype`(`ticketTypeId`,`ticketName`,`requirement`,`cheap`,`ticketNum`,`receive`,`liveTime`,`lastModifyBy`,`lastModifyTime`,`ticketTypeStatus`,`needScore`) values (1,'test','100.00','10.00',9898,5,7,'admin','2020-12-10 17:08:42',1,50),(2,'感恩回馈','40.00','5.00',1000,407,8,'admin','2020-11-29 14:24:52',1,60),(3,'可怜的优惠券','20.00','2.00',2,2,7,'admin','2020-12-01 22:49:50',1,10),(4,'qwe','100.00','19.00',100,2,7,'admin','2020-12-11 10:58:33',1,60),(5,'测试优惠券','30.00','2.00',10,3,5,'测试用户','2020-12-17 18:17:25',1,30),(6,'限量抢购','120.00','40.00',20,0,3,'admin','2020-12-23 14:25:07',1,200);

/*Table structure for table `food_user` */

DROP TABLE IF EXISTS `food_user`;

CREATE TABLE `food_user` (
  `userId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `username` varchar(60) NOT NULL COMMENT '用户名',
  `password` varchar(60) NOT NULL COMMENT '密码',
  `phone` varchar(20) NOT NULL COMMENT '用户手机号',
  `email` varchar(60) DEFAULT NULL COMMENT '用户邮箱',
  `gender` int(11) DEFAULT '0' COMMENT '用户性别（1表示男，2表示女，0表示未知）',
  `birthday` date DEFAULT NULL COMMENT '用户出生日期',
  `registerDate` date DEFAULT NULL COMMENT '注册日期',
  `score` int(11) DEFAULT '0' COMMENT '积分',
  `lastLoginTime` datetime DEFAULT NULL COMMENT '上次登入时间',
  `lastLogoutTime` datetime DEFAULT NULL COMMENT '上次登出时间',
  `loginCount` int(11) DEFAULT '0' COMMENT '登录次数',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `food_user` */

insert  into `food_user`(`userId`,`username`,`password`,`phone`,`email`,`gender`,`birthday`,`registerDate`,`score`,`lastLoginTime`,`lastLogoutTime`,`loginCount`) values (1,'admin','admin','18750916277','328092067@qq.com',1,'2020-11-04','2020-11-03',156,'2020-12-26 11:19:08','2020-12-23 12:41:29',599),(2,'deliver','123456','12345678901','',1,'2020-11-01','2020-11-10',0,NULL,NULL,0),(3,'manager','123456','18750916277','328092067@qq.com',1,'1999-04-12','2020-11-10',0,'2020-12-26 11:18:50','2020-12-26 11:19:02',5),(4,'grant','123456','11111111111','',0,'1999-04-12','2020-11-11',0,'2020-11-20 16:27:59','2020-11-20 16:27:38',2),(5,'test4','123456','11111111111','',0,NULL,'2020-11-11',0,NULL,NULL,0),(7,'test6','123456','11111111111','',0,NULL,'2020-11-11',0,NULL,NULL,0),(8,'test7','123456','11111111111','',0,NULL,'2020-11-11',0,NULL,NULL,0),(9,'test8','123456','11111111111','',0,NULL,'2020-11-11',0,'2020-11-17 12:58:25','2020-11-17 12:58:33',1),(10,'test9','123456','11111111111','',0,NULL,'2020-11-11',0,NULL,NULL,0),(11,'test10','123456','11111111111','',0,NULL,'2020-11-11',0,'2020-11-15 14:12:37','2020-11-15 14:12:47',1),(12,'新增用户','123456','12345678900','',0,NULL,'2020-11-12',0,NULL,NULL,0),(13,'sss','123','111',NULL,0,NULL,NULL,0,NULL,NULL,0),(14,'konijiwa','123123','12312312311',NULL,0,NULL,'2020-11-19',0,'2020-11-19 15:19:01',NULL,1),(15,'测试用户','test12','12312312312','test@qq.com',1,'2020-12-10','2020-12-17',476,'2020-12-17 18:27:06','2020-12-17 18:40:52',5);

/*Table structure for table `food_user_role` */

DROP TABLE IF EXISTS `food_user_role`;

CREATE TABLE `food_user_role` (
  `userId` bigint(20) DEFAULT NULL COMMENT '用户编号',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `food_user_role` */

insert  into `food_user_role`(`userId`,`roleId`) values (11,5),(1,1),(1,5),(5,2),(7,2),(8,2),(14,1),(3,1),(3,3),(4,1),(4,4),(2,1),(14,2),(2,2),(15,1),(15,5),(15,2),(9,2),(12,2);

/*Table structure for table `food_view_attr_value` */

DROP TABLE IF EXISTS `food_view_attr_value`;

/*!50001 DROP VIEW IF EXISTS `food_view_attr_value` */;
/*!50001 DROP TABLE IF EXISTS `food_view_attr_value` */;

/*!50001 CREATE TABLE  `food_view_attr_value`(
 `foodattrName` varchar(60) ,
 `foodvalueId` bigint(20) ,
 `foodattrId` bigint(20) ,
 `foodId` bigint(20) ,
 `foodvalueName` varchar(60) 
)*/;

/*Table structure for table `food_view_comment` */

DROP TABLE IF EXISTS `food_view_comment`;

/*!50001 DROP VIEW IF EXISTS `food_view_comment` */;
/*!50001 DROP TABLE IF EXISTS `food_view_comment` */;

/*!50001 CREATE TABLE  `food_view_comment`(
 `commentId` bigint(20) ,
 `userId` bigint(20) ,
 `commentScore` decimal(5,2) ,
 `commentContent` varchar(255) ,
 `commentTime` datetime ,
 `orderdetailId` bigint(20) ,
 `orderId` varchar(20) ,
 `amount` int(11) ,
 `itemPrice` decimal(5,2) ,
 `comment` int(2) ,
 `skuId` bigint(20) ,
 `skuName` varchar(255) ,
 `skuPrice` decimal(5,2) ,
 `skuSale` int(11) ,
 `skuStock` int(11) ,
 `foodId` bigint(20) ,
 `foodName` varchar(80) ,
 `foodTypeId` bigint(20) ,
 `foodIngredient` varchar(255) ,
 `foodVegon` varchar(60) ,
 `foodCookWay` varchar(60) ,
 `foodFaultCount` int(11) ,
 `foodDesc` varchar(255) ,
 `foodImage` varchar(255) ,
 `foodSaleCount` int(11) ,
 `foodViewCount` int(11) ,
 `foodScore` decimal(5,2) ,
 `commentCount` int(11) ,
 `recommend` int(11) ,
 `hotSale` int(11) ,
 `foodStatus` int(11) ,
 `lastModifyBy` varchar(60) ,
 `lastModifyTime` datetime ,
 `typeId` bigint(20) ,
 `typeName` varchar(60) ,
 `typeDesc` varchar(255) ,
 `typeStatus` int(11) 
)*/;

/*Table structure for table `food_view_complaint` */

DROP TABLE IF EXISTS `food_view_complaint`;

/*!50001 DROP VIEW IF EXISTS `food_view_complaint` */;
/*!50001 DROP TABLE IF EXISTS `food_view_complaint` */;

/*!50001 CREATE TABLE  `food_view_complaint`(
 `complaintId` bigint(20) ,
 `userId` bigint(20) ,
 `orderId` varchar(20) ,
 `complaintType` int(11) ,
 `target` varchar(120) ,
 `complaintContent` varchar(255) ,
 `complaintTime` datetime ,
 `username` varchar(60) 
)*/;

/*Table structure for table `food_view_deliver` */

DROP TABLE IF EXISTS `food_view_deliver`;

/*!50001 DROP VIEW IF EXISTS `food_view_deliver` */;
/*!50001 DROP TABLE IF EXISTS `food_view_deliver` */;

/*!50001 CREATE TABLE  `food_view_deliver`(
 `deliverId` varchar(16) ,
 `realName` varchar(30) ,
 `imageUrl` varchar(255) ,
 `orderCount` int(11) ,
 `faultCount` int(11) ,
 `finishCount` int(11) ,
 `joinDate` date ,
 `leaveDate` date ,
 `remark` varchar(255) ,
 `userId` bigint(20) ,
 `username` varchar(60) ,
 `password` varchar(60) ,
 `phone` varchar(20) ,
 `email` varchar(60) ,
 `gender` int(11) ,
 `birthday` date ,
 `registerDate` date ,
 `score` int(11) ,
 `lastLoginTime` datetime ,
 `lastLogoutTime` datetime ,
 `loginCount` int(11) 
)*/;

/*Table structure for table `food_view_food_order` */

DROP TABLE IF EXISTS `food_view_food_order`;

/*!50001 DROP VIEW IF EXISTS `food_view_food_order` */;
/*!50001 DROP TABLE IF EXISTS `food_view_food_order` */;

/*!50001 CREATE TABLE  `food_view_food_order`(
 `orderdetailId` bigint(20) ,
 `orderId` varchar(20) ,
 `amount` int(11) ,
 `itemPrice` decimal(5,2) ,
 `comment` int(2) ,
 `skuId` bigint(20) ,
 `skuName` varchar(255) ,
 `skuPrice` decimal(5,2) ,
 `skuSale` int(11) ,
 `skuStock` int(11) ,
 `foodId` bigint(20) ,
 `foodName` varchar(80) ,
 `foodTypeId` bigint(20) ,
 `foodIngredient` varchar(255) ,
 `foodVegon` varchar(60) ,
 `foodCookWay` varchar(60) ,
 `foodFaultCount` int(11) ,
 `foodDesc` varchar(255) ,
 `foodImage` varchar(255) ,
 `foodSaleCount` int(11) ,
 `foodViewCount` int(11) ,
 `foodScore` decimal(5,2) ,
 `commentCount` int(11) ,
 `recommend` int(11) ,
 `hotSale` int(11) ,
 `foodStatus` int(11) ,
 `lastModifyBy` varchar(60) ,
 `lastModifyTime` datetime ,
 `typeId` bigint(20) ,
 `typeName` varchar(60) ,
 `typeDesc` varchar(255) ,
 `typeStatus` int(11) ,
 `orderTime` datetime 
)*/;

/*Table structure for table `food_view_foodsku` */

DROP TABLE IF EXISTS `food_view_foodsku`;

/*!50001 DROP VIEW IF EXISTS `food_view_foodsku` */;
/*!50001 DROP TABLE IF EXISTS `food_view_foodsku` */;

/*!50001 CREATE TABLE  `food_view_foodsku`(
 `skuId` bigint(20) ,
 `skuName` varchar(255) ,
 `skuPrice` decimal(5,2) ,
 `skuSale` int(11) ,
 `skuStock` int(11) ,
 `foodId` bigint(20) ,
 `foodName` varchar(80) ,
 `foodTypeId` bigint(20) ,
 `foodIngredient` varchar(255) ,
 `foodVegon` varchar(60) ,
 `foodCookWay` varchar(60) ,
 `foodFaultCount` int(11) ,
 `foodDesc` varchar(255) ,
 `foodImage` varchar(255) ,
 `foodSaleCount` int(11) ,
 `foodViewCount` int(11) ,
 `foodScore` decimal(5,2) ,
 `commentCount` int(11) ,
 `recommend` int(11) ,
 `hotSale` int(11) ,
 `foodStatus` int(11) ,
 `lastModifyBy` varchar(60) ,
 `lastModifyTime` datetime ,
 `dayStock` int(11) ,
 `typeId` bigint(20) ,
 `typeName` varchar(60) ,
 `typeDesc` varchar(255) ,
 `typeStatus` int(11) 
)*/;

/*Table structure for table `food_view_foodspu` */

DROP TABLE IF EXISTS `food_view_foodspu`;

/*!50001 DROP VIEW IF EXISTS `food_view_foodspu` */;
/*!50001 DROP TABLE IF EXISTS `food_view_foodspu` */;

/*!50001 CREATE TABLE  `food_view_foodspu`(
 `foodId` bigint(20) ,
 `foodName` varchar(80) ,
 `foodTypeId` bigint(20) ,
 `foodIngredient` varchar(255) ,
 `foodVegon` varchar(60) ,
 `foodCookWay` varchar(60) ,
 `foodFaultCount` int(11) ,
 `foodDesc` varchar(255) ,
 `foodImage` varchar(255) ,
 `foodSaleCount` int(11) ,
 `foodViewCount` int(11) ,
 `foodScore` decimal(5,2) ,
 `commentCount` int(11) ,
 `recommend` int(11) ,
 `hotSale` int(11) ,
 `foodStatus` int(11) ,
 `lastModifyBy` varchar(60) ,
 `lastModifyTime` datetime ,
 `dayStock` int(11) ,
 `typeId` bigint(20) ,
 `typeName` varchar(60) ,
 `typeDesc` varchar(255) ,
 `typeStatus` int(11) 
)*/;

/*Table structure for table `food_view_orderdetail` */

DROP TABLE IF EXISTS `food_view_orderdetail`;

/*!50001 DROP VIEW IF EXISTS `food_view_orderdetail` */;
/*!50001 DROP TABLE IF EXISTS `food_view_orderdetail` */;

/*!50001 CREATE TABLE  `food_view_orderdetail`(
 `orderdetailId` bigint(20) ,
 `orderId` varchar(20) ,
 `amount` int(11) ,
 `itemPrice` decimal(5,2) ,
 `comment` int(2) ,
 `skuId` bigint(20) ,
 `skuName` varchar(255) ,
 `skuPrice` decimal(5,2) ,
 `skuSale` int(11) ,
 `skuStock` int(11) ,
 `foodId` bigint(20) ,
 `foodName` varchar(80) ,
 `foodTypeId` bigint(20) ,
 `foodIngredient` varchar(255) ,
 `foodVegon` varchar(60) ,
 `foodCookWay` varchar(60) ,
 `foodFaultCount` int(11) ,
 `foodDesc` varchar(255) ,
 `foodImage` varchar(255) ,
 `foodSaleCount` int(11) ,
 `foodViewCount` int(11) ,
 `foodScore` decimal(5,2) ,
 `commentCount` int(11) ,
 `recommend` int(11) ,
 `hotSale` int(11) ,
 `foodStatus` int(11) ,
 `lastModifyBy` varchar(60) ,
 `lastModifyTime` datetime ,
 `typeId` bigint(20) ,
 `typeName` varchar(60) ,
 `typeDesc` varchar(255) ,
 `typeStatus` int(11) 
)*/;

/*Table structure for table `food_view_shopcart` */

DROP TABLE IF EXISTS `food_view_shopcart`;

/*!50001 DROP VIEW IF EXISTS `food_view_shopcart` */;
/*!50001 DROP TABLE IF EXISTS `food_view_shopcart` */;

/*!50001 CREATE TABLE  `food_view_shopcart`(
 `shopcartId` bigint(20) ,
 `userId` bigint(20) ,
 `numCount` int(11) ,
 `skuId` bigint(20) ,
 `skuName` varchar(255) ,
 `skuPrice` decimal(5,2) ,
 `skuSale` int(11) ,
 `skuStock` int(11) ,
 `foodId` bigint(20) ,
 `foodName` varchar(80) ,
 `foodTypeId` bigint(20) ,
 `foodIngredient` varchar(255) ,
 `foodVegon` varchar(60) ,
 `foodCookWay` varchar(60) ,
 `foodFaultCount` int(11) ,
 `foodDesc` varchar(255) ,
 `foodImage` varchar(255) ,
 `foodSaleCount` int(11) ,
 `foodViewCount` int(11) ,
 `foodScore` decimal(5,2) ,
 `commentCount` int(11) ,
 `recommend` int(11) ,
 `hotSale` int(11) ,
 `foodStatus` int(11) ,
 `lastModifyBy` varchar(60) ,
 `lastModifyTime` datetime ,
 `dayStock` int(11) ,
 `typeId` bigint(20) ,
 `typeName` varchar(60) ,
 `typeDesc` varchar(255) ,
 `typeStatus` int(11) 
)*/;

/*Table structure for table `food_view_ticket` */

DROP TABLE IF EXISTS `food_view_ticket`;

/*!50001 DROP VIEW IF EXISTS `food_view_ticket` */;
/*!50001 DROP TABLE IF EXISTS `food_view_ticket` */;

/*!50001 CREATE TABLE  `food_view_ticket`(
 `ticketId` bigint(20) ,
 `userId` bigint(20) ,
 `startTime` date ,
 `endTime` date ,
 `ticketStatus` int(11) ,
 `ticketTypeId` bigint(20) ,
 `ticketName` varchar(120) ,
 `requirement` decimal(5,2) ,
 `cheap` decimal(5,2) ,
 `ticketNum` int(11) ,
 `receive` int(11) ,
 `liveTime` int(11) ,
 `lastModifyBy` varchar(60) ,
 `lastModifyTime` datetime ,
 `ticketTypeStatus` int(11) ,
 `needScore` int(11) ,
 `username` varchar(60) 
)*/;

/*View structure for view food_view_attr_value */

/*!50001 DROP TABLE IF EXISTS `food_view_attr_value` */;
/*!50001 DROP VIEW IF EXISTS `food_view_attr_value` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_attr_value` AS select `a`.`foodattrName` AS `foodattrName`,`v`.`foodvalueId` AS `foodvalueId`,`v`.`foodattrId` AS `foodattrId`,`v`.`foodId` AS `foodId`,`v`.`foodvalueName` AS `foodvalueName` from (`food_foodvalue` `v` left join `food_foodattr` `a` on((`a`.`foodattrId` = `v`.`foodattrId`))) */;

/*View structure for view food_view_comment */

/*!50001 DROP TABLE IF EXISTS `food_view_comment` */;
/*!50001 DROP VIEW IF EXISTS `food_view_comment` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_comment` AS select `c`.`commentId` AS `commentId`,`c`.`userId` AS `userId`,`c`.`commentScore` AS `commentScore`,`c`.`commentContent` AS `commentContent`,`c`.`commentTime` AS `commentTime`,`od`.`orderdetailId` AS `orderdetailId`,`od`.`orderId` AS `orderId`,`od`.`amount` AS `amount`,`od`.`itemPrice` AS `itemPrice`,`od`.`comment` AS `comment`,`od`.`skuId` AS `skuId`,`od`.`skuName` AS `skuName`,`od`.`skuPrice` AS `skuPrice`,`od`.`skuSale` AS `skuSale`,`od`.`skuStock` AS `skuStock`,`od`.`foodId` AS `foodId`,`od`.`foodName` AS `foodName`,`od`.`foodTypeId` AS `foodTypeId`,`od`.`foodIngredient` AS `foodIngredient`,`od`.`foodVegon` AS `foodVegon`,`od`.`foodCookWay` AS `foodCookWay`,`od`.`foodFaultCount` AS `foodFaultCount`,`od`.`foodDesc` AS `foodDesc`,`od`.`foodImage` AS `foodImage`,`od`.`foodSaleCount` AS `foodSaleCount`,`od`.`foodViewCount` AS `foodViewCount`,`od`.`foodScore` AS `foodScore`,`od`.`commentCount` AS `commentCount`,`od`.`recommend` AS `recommend`,`od`.`hotSale` AS `hotSale`,`od`.`foodStatus` AS `foodStatus`,`od`.`lastModifyBy` AS `lastModifyBy`,`od`.`lastModifyTime` AS `lastModifyTime`,`od`.`typeId` AS `typeId`,`od`.`typeName` AS `typeName`,`od`.`typeDesc` AS `typeDesc`,`od`.`typeStatus` AS `typeStatus` from (`food_comment` `c` left join `food_view_orderdetail` `od` on((`c`.`orderDetailId` = `od`.`orderdetailId`))) */;

/*View structure for view food_view_complaint */

/*!50001 DROP TABLE IF EXISTS `food_view_complaint` */;
/*!50001 DROP VIEW IF EXISTS `food_view_complaint` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_complaint` AS select `c`.`complaintId` AS `complaintId`,`c`.`userId` AS `userId`,`c`.`orderId` AS `orderId`,`c`.`complaintType` AS `complaintType`,`c`.`target` AS `target`,`c`.`complaintContent` AS `complaintContent`,`c`.`complaintTime` AS `complaintTime`,`u`.`username` AS `username` from (`food_complaint` `c` left join `food_user` `u` on((`c`.`userId` = `u`.`userId`))) */;

/*View structure for view food_view_deliver */

/*!50001 DROP TABLE IF EXISTS `food_view_deliver` */;
/*!50001 DROP VIEW IF EXISTS `food_view_deliver` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_deliver` AS select `d`.`deliverId` AS `deliverId`,`d`.`realName` AS `realName`,`d`.`imageUrl` AS `imageUrl`,`d`.`orderCount` AS `orderCount`,`d`.`faultCount` AS `faultCount`,`d`.`finishCount` AS `finishCount`,`d`.`joinDate` AS `joinDate`,`d`.`leaveDate` AS `leaveDate`,`d`.`remark` AS `remark`,`u`.`userId` AS `userId`,`u`.`username` AS `username`,`u`.`password` AS `password`,`u`.`phone` AS `phone`,`u`.`email` AS `email`,`u`.`gender` AS `gender`,`u`.`birthday` AS `birthday`,`u`.`registerDate` AS `registerDate`,`u`.`score` AS `score`,`u`.`lastLoginTime` AS `lastLoginTime`,`u`.`lastLogoutTime` AS `lastLogoutTime`,`u`.`loginCount` AS `loginCount` from (`food_deliver` `d` left join `food_user` `u` on((`d`.`userId` = `u`.`userId`))) */;

/*View structure for view food_view_food_order */

/*!50001 DROP TABLE IF EXISTS `food_view_food_order` */;
/*!50001 DROP VIEW IF EXISTS `food_view_food_order` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_food_order` AS select `od`.`orderdetailId` AS `orderdetailId`,`od`.`orderId` AS `orderId`,`od`.`amount` AS `amount`,`od`.`itemPrice` AS `itemPrice`,`od`.`comment` AS `comment`,`od`.`skuId` AS `skuId`,`od`.`skuName` AS `skuName`,`od`.`skuPrice` AS `skuPrice`,`od`.`skuSale` AS `skuSale`,`od`.`skuStock` AS `skuStock`,`od`.`foodId` AS `foodId`,`od`.`foodName` AS `foodName`,`od`.`foodTypeId` AS `foodTypeId`,`od`.`foodIngredient` AS `foodIngredient`,`od`.`foodVegon` AS `foodVegon`,`od`.`foodCookWay` AS `foodCookWay`,`od`.`foodFaultCount` AS `foodFaultCount`,`od`.`foodDesc` AS `foodDesc`,`od`.`foodImage` AS `foodImage`,`od`.`foodSaleCount` AS `foodSaleCount`,`od`.`foodViewCount` AS `foodViewCount`,`od`.`foodScore` AS `foodScore`,`od`.`commentCount` AS `commentCount`,`od`.`recommend` AS `recommend`,`od`.`hotSale` AS `hotSale`,`od`.`foodStatus` AS `foodStatus`,`od`.`lastModifyBy` AS `lastModifyBy`,`od`.`lastModifyTime` AS `lastModifyTime`,`od`.`typeId` AS `typeId`,`od`.`typeName` AS `typeName`,`od`.`typeDesc` AS `typeDesc`,`od`.`typeStatus` AS `typeStatus`,`o`.`orderTime` AS `orderTime` from (`food_view_orderdetail` `od` left join `food_order` `o` on((`od`.`orderId` = `o`.`orderId`))) */;

/*View structure for view food_view_foodsku */

/*!50001 DROP TABLE IF EXISTS `food_view_foodsku` */;
/*!50001 DROP VIEW IF EXISTS `food_view_foodsku` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_foodsku` AS select `sku`.`skuId` AS `skuId`,`sku`.`skuName` AS `skuName`,`sku`.`skuPrice` AS `skuPrice`,`sku`.`skuSale` AS `skuSale`,`sku`.`skuStock` AS `skuStock`,`spu`.`foodId` AS `foodId`,`spu`.`foodName` AS `foodName`,`spu`.`foodTypeId` AS `foodTypeId`,`spu`.`foodIngredient` AS `foodIngredient`,`spu`.`foodVegon` AS `foodVegon`,`spu`.`foodCookWay` AS `foodCookWay`,`spu`.`foodFaultCount` AS `foodFaultCount`,`spu`.`foodDesc` AS `foodDesc`,`spu`.`foodImage` AS `foodImage`,`spu`.`foodSaleCount` AS `foodSaleCount`,`spu`.`foodViewCount` AS `foodViewCount`,`spu`.`foodScore` AS `foodScore`,`spu`.`commentCount` AS `commentCount`,`spu`.`recommend` AS `recommend`,`spu`.`hotSale` AS `hotSale`,`spu`.`foodStatus` AS `foodStatus`,`spu`.`lastModifyBy` AS `lastModifyBy`,`spu`.`lastModifyTime` AS `lastModifyTime`,`spu`.`dayStock` AS `dayStock`,`spu`.`typeId` AS `typeId`,`spu`.`typeName` AS `typeName`,`spu`.`typeDesc` AS `typeDesc`,`spu`.`typeStatus` AS `typeStatus` from (`food_foodsku` `sku` left join `food_view_foodspu` `spu` on((`sku`.`foodId` = `spu`.`foodId`))) */;

/*View structure for view food_view_foodspu */

/*!50001 DROP TABLE IF EXISTS `food_view_foodspu` */;
/*!50001 DROP VIEW IF EXISTS `food_view_foodspu` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_foodspu` AS select `f`.`foodId` AS `foodId`,`f`.`foodName` AS `foodName`,`f`.`foodTypeId` AS `foodTypeId`,`f`.`foodIngredient` AS `foodIngredient`,`f`.`foodVegon` AS `foodVegon`,`f`.`foodCookWay` AS `foodCookWay`,`f`.`foodFaultCount` AS `foodFaultCount`,`f`.`foodDesc` AS `foodDesc`,`f`.`foodImage` AS `foodImage`,`f`.`foodSaleCount` AS `foodSaleCount`,`f`.`foodViewCount` AS `foodViewCount`,`f`.`foodScore` AS `foodScore`,`f`.`commentCount` AS `commentCount`,`f`.`recommend` AS `recommend`,`f`.`hotSale` AS `hotSale`,`f`.`foodStatus` AS `foodStatus`,`f`.`lastModifyBy` AS `lastModifyBy`,`f`.`lastModifyTime` AS `lastModifyTime`,`f`.`dayStock` AS `dayStock`,`ft`.`typeId` AS `typeId`,`ft`.`typeName` AS `typeName`,`ft`.`typeDesc` AS `typeDesc`,`ft`.`typeStatus` AS `typeStatus` from (`food_food` `f` left join `food_foodtype` `ft` on((`ft`.`typeId` = `f`.`foodTypeId`))) */;

/*View structure for view food_view_orderdetail */

/*!50001 DROP TABLE IF EXISTS `food_view_orderdetail` */;
/*!50001 DROP VIEW IF EXISTS `food_view_orderdetail` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_orderdetail` AS select `od`.`orderDetailId` AS `orderdetailId`,`od`.`orderId` AS `orderId`,`od`.`amount` AS `amount`,`od`.`itemPrice` AS `itemPrice`,`od`.`comment` AS `comment`,`s`.`skuId` AS `skuId`,`s`.`skuName` AS `skuName`,`s`.`skuPrice` AS `skuPrice`,`s`.`skuSale` AS `skuSale`,`s`.`skuStock` AS `skuStock`,`s`.`foodId` AS `foodId`,`s`.`foodName` AS `foodName`,`s`.`foodTypeId` AS `foodTypeId`,`s`.`foodIngredient` AS `foodIngredient`,`s`.`foodVegon` AS `foodVegon`,`s`.`foodCookWay` AS `foodCookWay`,`s`.`foodFaultCount` AS `foodFaultCount`,`s`.`foodDesc` AS `foodDesc`,`s`.`foodImage` AS `foodImage`,`s`.`foodSaleCount` AS `foodSaleCount`,`s`.`foodViewCount` AS `foodViewCount`,`s`.`foodScore` AS `foodScore`,`s`.`commentCount` AS `commentCount`,`s`.`recommend` AS `recommend`,`s`.`hotSale` AS `hotSale`,`s`.`foodStatus` AS `foodStatus`,`s`.`lastModifyBy` AS `lastModifyBy`,`s`.`lastModifyTime` AS `lastModifyTime`,`s`.`typeId` AS `typeId`,`s`.`typeName` AS `typeName`,`s`.`typeDesc` AS `typeDesc`,`s`.`typeStatus` AS `typeStatus` from (`food_orderdetail` `od` left join `food_view_foodsku` `s` on((`od`.`skuId` = `s`.`skuId`))) */;

/*View structure for view food_view_shopcart */

/*!50001 DROP TABLE IF EXISTS `food_view_shopcart` */;
/*!50001 DROP VIEW IF EXISTS `food_view_shopcart` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_shopcart` AS select `s`.`shopcartId` AS `shopcartId`,`s`.`userId` AS `userId`,`s`.`numCount` AS `numCount`,`sku`.`skuId` AS `skuId`,`sku`.`skuName` AS `skuName`,`sku`.`skuPrice` AS `skuPrice`,`sku`.`skuSale` AS `skuSale`,`sku`.`skuStock` AS `skuStock`,`sku`.`foodId` AS `foodId`,`sku`.`foodName` AS `foodName`,`sku`.`foodTypeId` AS `foodTypeId`,`sku`.`foodIngredient` AS `foodIngredient`,`sku`.`foodVegon` AS `foodVegon`,`sku`.`foodCookWay` AS `foodCookWay`,`sku`.`foodFaultCount` AS `foodFaultCount`,`sku`.`foodDesc` AS `foodDesc`,`sku`.`foodImage` AS `foodImage`,`sku`.`foodSaleCount` AS `foodSaleCount`,`sku`.`foodViewCount` AS `foodViewCount`,`sku`.`foodScore` AS `foodScore`,`sku`.`commentCount` AS `commentCount`,`sku`.`recommend` AS `recommend`,`sku`.`hotSale` AS `hotSale`,`sku`.`foodStatus` AS `foodStatus`,`sku`.`lastModifyBy` AS `lastModifyBy`,`sku`.`lastModifyTime` AS `lastModifyTime`,`sku`.`dayStock` AS `dayStock`,`sku`.`typeId` AS `typeId`,`sku`.`typeName` AS `typeName`,`sku`.`typeDesc` AS `typeDesc`,`sku`.`typeStatus` AS `typeStatus` from (`food_shopcart` `s` left join `food_view_foodsku` `sku` on((`sku`.`skuId` = `s`.`skuId`))) */;

/*View structure for view food_view_ticket */

/*!50001 DROP TABLE IF EXISTS `food_view_ticket` */;
/*!50001 DROP VIEW IF EXISTS `food_view_ticket` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_ticket` AS select `t`.`ticketId` AS `ticketId`,`t`.`userId` AS `userId`,`t`.`startTime` AS `startTime`,`t`.`endTime` AS `endTime`,`t`.`ticketStatus` AS `ticketStatus`,`tt`.`ticketTypeId` AS `ticketTypeId`,`tt`.`ticketName` AS `ticketName`,`tt`.`requirement` AS `requirement`,`tt`.`cheap` AS `cheap`,`tt`.`ticketNum` AS `ticketNum`,`tt`.`receive` AS `receive`,`tt`.`liveTime` AS `liveTime`,`tt`.`lastModifyBy` AS `lastModifyBy`,`tt`.`lastModifyTime` AS `lastModifyTime`,`tt`.`ticketTypeStatus` AS `ticketTypeStatus`,`tt`.`needScore` AS `needScore`,`u`.`username` AS `username` from ((`food_ticket` `t` left join `food_tickettype` `tt` on((`t`.`ticketTypeId` = `tt`.`ticketTypeId`))) left join `food_user` `u` on((`u`.`userId` = `t`.`userId`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
