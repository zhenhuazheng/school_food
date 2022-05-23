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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`foodId`),
  KEY `foodTypeId` (`foodTypeId`),
  CONSTRAINT `food_food_ibfk_1` FOREIGN KEY (`foodTypeId`) REFERENCES `food_foodtype` (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Table structure for table `food_foodattr` */

DROP TABLE IF EXISTS `food_foodattr`;

CREATE TABLE `food_foodattr` (
  `foodattrId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜品规格集编号',
  `foodattrName` varchar(60) DEFAULT NULL COMMENT '菜品规格集名称',
  PRIMARY KEY (`foodattrId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

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

/*Table structure for table `food_role_menu` */

DROP TABLE IF EXISTS `food_role_menu`;

CREATE TABLE `food_role_menu` (
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色编号',
  `menuId` int(11) DEFAULT NULL COMMENT '菜单编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `food_shopcart` */

DROP TABLE IF EXISTS `food_shopcart`;

CREATE TABLE `food_shopcart` (
  `shopcartId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '购物车细则编号',
  `skuId` bigint(20) DEFAULT NULL COMMENT '菜品SKU编号',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户编号',
  `numCount` int(11) DEFAULT NULL COMMENT '购买数量',
  PRIMARY KEY (`shopcartId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `food_user_role` */

DROP TABLE IF EXISTS `food_user_role`;

CREATE TABLE `food_user_role` (
  `userId` bigint(20) DEFAULT NULL COMMENT '用户编号',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

/*View structure for view food_view_foodsku */

/*!50001 DROP TABLE IF EXISTS `food_view_foodsku` */;
/*!50001 DROP VIEW IF EXISTS `food_view_foodsku` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_foodsku` AS select `sku`.`skuId` AS `skuId`,`sku`.`skuName` AS `skuName`,`sku`.`skuPrice` AS `skuPrice`,`sku`.`skuSale` AS `skuSale`,`sku`.`skuStock` AS `skuStock`,`spu`.`foodId` AS `foodId`,`spu`.`foodName` AS `foodName`,`spu`.`foodTypeId` AS `foodTypeId`,`spu`.`foodIngredient` AS `foodIngredient`,`spu`.`foodVegon` AS `foodVegon`,`spu`.`foodCookWay` AS `foodCookWay`,`spu`.`foodFaultCount` AS `foodFaultCount`,`spu`.`foodDesc` AS `foodDesc`,`spu`.`foodImage` AS `foodImage`,`spu`.`foodSaleCount` AS `foodSaleCount`,`spu`.`foodViewCount` AS `foodViewCount`,`spu`.`foodScore` AS `foodScore`,`spu`.`commentCount` AS `commentCount`,`spu`.`recommend` AS `recommend`,`spu`.`hotSale` AS `hotSale`,`spu`.`foodStatus` AS `foodStatus`,`spu`.`lastModifyBy` AS `lastModifyBy`,`spu`.`lastModifyTime` AS `lastModifyTime`,`spu`.`typeId` AS `typeId`,`spu`.`typeName` AS `typeName`,`spu`.`typeDesc` AS `typeDesc`,`spu`.`typeStatus` AS `typeStatus` from (`food_foodsku` `sku` left join `food_view_foodspu` `spu` on((`sku`.`foodId` = `spu`.`foodId`))) */;

/*View structure for view food_view_foodspu */

/*!50001 DROP TABLE IF EXISTS `food_view_foodspu` */;
/*!50001 DROP VIEW IF EXISTS `food_view_foodspu` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_foodspu` AS select `f`.`foodId` AS `foodId`,`f`.`foodName` AS `foodName`,`f`.`foodTypeId` AS `foodTypeId`,`f`.`foodIngredient` AS `foodIngredient`,`f`.`foodVegon` AS `foodVegon`,`f`.`foodCookWay` AS `foodCookWay`,`f`.`foodFaultCount` AS `foodFaultCount`,`f`.`foodDesc` AS `foodDesc`,`f`.`foodImage` AS `foodImage`,`f`.`foodSaleCount` AS `foodSaleCount`,`f`.`foodViewCount` AS `foodViewCount`,`f`.`foodScore` AS `foodScore`,`f`.`commentCount` AS `commentCount`,`f`.`recommend` AS `recommend`,`f`.`hotSale` AS `hotSale`,`f`.`foodStatus` AS `foodStatus`,`f`.`lastModifyBy` AS `lastModifyBy`,`f`.`lastModifyTime` AS `lastModifyTime`,`ft`.`typeId` AS `typeId`,`ft`.`typeName` AS `typeName`,`ft`.`typeDesc` AS `typeDesc`,`ft`.`typeStatus` AS `typeStatus` from (`food_food` `f` left join `food_foodtype` `ft` on((`ft`.`typeId` = `f`.`foodTypeId`))) */;

/*View structure for view food_view_orderdetail */

/*!50001 DROP TABLE IF EXISTS `food_view_orderdetail` */;
/*!50001 DROP VIEW IF EXISTS `food_view_orderdetail` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_orderdetail` AS select `od`.`orderDetailId` AS `orderdetailId`,`od`.`orderId` AS `orderId`,`od`.`amount` AS `amount`,`od`.`itemPrice` AS `itemPrice`,`od`.`comment` AS `comment`,`s`.`skuId` AS `skuId`,`s`.`skuName` AS `skuName`,`s`.`skuPrice` AS `skuPrice`,`s`.`skuSale` AS `skuSale`,`s`.`skuStock` AS `skuStock`,`s`.`foodId` AS `foodId`,`s`.`foodName` AS `foodName`,`s`.`foodTypeId` AS `foodTypeId`,`s`.`foodIngredient` AS `foodIngredient`,`s`.`foodVegon` AS `foodVegon`,`s`.`foodCookWay` AS `foodCookWay`,`s`.`foodFaultCount` AS `foodFaultCount`,`s`.`foodDesc` AS `foodDesc`,`s`.`foodImage` AS `foodImage`,`s`.`foodSaleCount` AS `foodSaleCount`,`s`.`foodViewCount` AS `foodViewCount`,`s`.`foodScore` AS `foodScore`,`s`.`commentCount` AS `commentCount`,`s`.`recommend` AS `recommend`,`s`.`hotSale` AS `hotSale`,`s`.`foodStatus` AS `foodStatus`,`s`.`lastModifyBy` AS `lastModifyBy`,`s`.`lastModifyTime` AS `lastModifyTime`,`s`.`typeId` AS `typeId`,`s`.`typeName` AS `typeName`,`s`.`typeDesc` AS `typeDesc`,`s`.`typeStatus` AS `typeStatus` from (`food_orderdetail` `od` left join `food_view_foodsku` `s` on((`od`.`skuId` = `s`.`skuId`))) */;

/*View structure for view food_view_shopcart */

/*!50001 DROP TABLE IF EXISTS `food_view_shopcart` */;
/*!50001 DROP VIEW IF EXISTS `food_view_shopcart` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_shopcart` AS select `s`.`shopcartId` AS `shopcartId`,`s`.`userId` AS `userId`,`s`.`numCount` AS `numCount`,`sku`.`skuId` AS `skuId`,`sku`.`skuName` AS `skuName`,`sku`.`skuPrice` AS `skuPrice`,`sku`.`skuSale` AS `skuSale`,`sku`.`skuStock` AS `skuStock`,`sku`.`foodId` AS `foodId`,`sku`.`foodName` AS `foodName`,`sku`.`foodTypeId` AS `foodTypeId`,`sku`.`foodIngredient` AS `foodIngredient`,`sku`.`foodVegon` AS `foodVegon`,`sku`.`foodCookWay` AS `foodCookWay`,`sku`.`foodFaultCount` AS `foodFaultCount`,`sku`.`foodDesc` AS `foodDesc`,`sku`.`foodImage` AS `foodImage`,`sku`.`foodSaleCount` AS `foodSaleCount`,`sku`.`foodViewCount` AS `foodViewCount`,`sku`.`foodScore` AS `foodScore`,`sku`.`commentCount` AS `commentCount`,`sku`.`recommend` AS `recommend`,`sku`.`hotSale` AS `hotSale`,`sku`.`foodStatus` AS `foodStatus`,`sku`.`lastModifyBy` AS `lastModifyBy`,`sku`.`lastModifyTime` AS `lastModifyTime`,`sku`.`typeId` AS `typeId`,`sku`.`typeName` AS `typeName`,`sku`.`typeDesc` AS `typeDesc`,`sku`.`typeStatus` AS `typeStatus` from (`food_shopcart` `s` left join `food_view_foodsku` `sku` on((`sku`.`skuId` = `s`.`skuId`))) */;

/*View structure for view food_view_ticket */

/*!50001 DROP TABLE IF EXISTS `food_view_ticket` */;
/*!50001 DROP VIEW IF EXISTS `food_view_ticket` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `food_view_ticket` AS select `t`.`ticketId` AS `ticketId`,`t`.`userId` AS `userId`,`t`.`startTime` AS `startTime`,`t`.`endTime` AS `endTime`,`t`.`ticketStatus` AS `ticketStatus`,`tt`.`ticketTypeId` AS `ticketTypeId`,`tt`.`ticketName` AS `ticketName`,`tt`.`requirement` AS `requirement`,`tt`.`cheap` AS `cheap`,`tt`.`ticketNum` AS `ticketNum`,`tt`.`receive` AS `receive`,`tt`.`liveTime` AS `liveTime`,`tt`.`lastModifyBy` AS `lastModifyBy`,`tt`.`lastModifyTime` AS `lastModifyTime`,`tt`.`ticketTypeStatus` AS `ticketTypeStatus`,`tt`.`needScore` AS `needScore`,`u`.`username` AS `username` from ((`food_ticket` `t` left join `food_tickettype` `tt` on((`t`.`ticketTypeId` = `tt`.`ticketTypeId`))) left join `food_user` `u` on((`u`.`userId` = `t`.`userId`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
