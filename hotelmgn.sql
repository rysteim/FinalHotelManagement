/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 10.4.28-MariaDB : Database - hotelmgn
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hotelmgn` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `hotelmgn`;

/*Table structure for table `tblaccount` */

DROP TABLE IF EXISTS `tblaccount`;

CREATE TABLE `tblaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `email` varchar(60) NOT NULL,
  `address` varchar(100) NOT NULL,
  `firstName` varchar(40) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `birthdate` date NOT NULL,
  `gender` varchar(15) NOT NULL,
  `image` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tbladdons` */

DROP TABLE IF EXISTS `tbladdons`;

CREATE TABLE `tbladdons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(60) NOT NULL,
  `image` text NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tbladdons_promo` */

DROP TABLE IF EXISTS `tbladdons_promo`;

CREATE TABLE `tbladdons_promo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promoid` int(11) NOT NULL,
  `addonsid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promoid` (`promoid`),
  KEY `addonsid` (`addonsid`),
  CONSTRAINT `tbladdons_promo_ibfk_1` FOREIGN KEY (`promoid`) REFERENCES `tblpromo` (`id`),
  CONSTRAINT `tbladdons_promo_ibfk_2` FOREIGN KEY (`addonsid`) REFERENCES `tbladdons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tblbooking` */

DROP TABLE IF EXISTS `tblbooking`;

CREATE TABLE `tblbooking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenantid` int(11) NOT NULL,
  `bookingStatus` varchar(30) NOT NULL,
  `hotelroomid` int(11) NOT NULL,
  `apid` int(11) NOT NULL,
  `bookingDate` date NOT NULL,
  `numberOfDays` int(11) NOT NULL,
  `totalPrice` double NOT NULL,
  `payment` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tenantid` (`tenantid`),
  KEY `hotelroomid` (`hotelroomid`),
  KEY `apid` (`apid`),
  CONSTRAINT `tblbooking_ibfk_1` FOREIGN KEY (`tenantid`) REFERENCES `tbltenant` (`id`),
  CONSTRAINT `tblbooking_ibfk_2` FOREIGN KEY (`hotelroomid`) REFERENCES `tblhotelroom` (`id`),
  CONSTRAINT `tblbooking_ibfk_3` FOREIGN KEY (`apid`) REFERENCES `tbladdons_promo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tblhotel` */

DROP TABLE IF EXISTS `tblhotel`;

CREATE TABLE `tblhotel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(60) NOT NULL,
  `image` text NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tblhotelroom` */

DROP TABLE IF EXISTS `tblhotelroom`;

CREATE TABLE `tblhotelroom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roomName` varchar(50) NOT NULL,
  `roomGrade` varchar(30) NOT NULL,
  `roomStatus` varchar(30) NOT NULL,
  `hotelid` int(11) NOT NULL,
  `description` varchar(200) NOT NULL,
  `initialPricePerDay` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hotelid` (`hotelid`),
  CONSTRAINT `tblhotelroom_ibfk_1` FOREIGN KEY (`hotelid`) REFERENCES `tblhotel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tblpersonnel` */

DROP TABLE IF EXISTS `tblpersonnel`;

CREATE TABLE `tblpersonnel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountid` int(11) NOT NULL,
  `position` varchar(30) NOT NULL,
  `workShift` varchar(45) NOT NULL,
  `workName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountid` (`accountid`),
  CONSTRAINT `tblpersonnel_ibfk_1` FOREIGN KEY (`accountid`) REFERENCES `tblaccount` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tblpromo` */

DROP TABLE IF EXISTS `tblpromo`;

CREATE TABLE `tblpromo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promoName` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  `percentageDiscount` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tblreservation` */

DROP TABLE IF EXISTS `tblreservation`;

CREATE TABLE `tblreservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bookingid` int(11) NOT NULL,
  `invoiceNumber` varchar(100) NOT NULL,
  `reservationStatus` varchar(50) NOT NULL,
  `checkIn` date NOT NULL,
  `checkOut` date NOT NULL,
  `balance` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tbltenant` */

DROP TABLE IF EXISTS `tbltenant`;

CREATE TABLE `tbltenant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountid` int(11) NOT NULL,
  `membership` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountid` (`accountid`),
  CONSTRAINT `tbltenant_ibfk_1` FOREIGN KEY (`accountid`) REFERENCES `tblaccount` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/* Procedure structure for procedure `procAddAccount` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddAccount` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddAccount`(p_username varchar(40),
					p_password varchar(40),
					p_email varchar(60),
					p_address varchar(100),
					p_firstName varchar(40),
					p_lastName varchar(40),
					p_birthdate date,
					p_gender varchar(15),
					p_image text)
BEGIN
		insert into hotelmgn.tblaccount	(username,
						password,
						email,
						address,
						firstName,
						lastName,
						birthdate,
						gender,
						image)
					values	(p_username,
						p_password,
						p_email,
						p_address,
						p_firstName,
						p_lastName,
						p_birthdate,
						p_gender,
						p_image);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddAddons` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddAddons` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddAddons`(p_location varchar(60),
					p_image text,
					p_description varchar(200))
BEGIN
		insert into hotelmgn.tbladdons	(location,
						image,
						description)
					values	(p_location,
						p_image,
						p_description);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddAddons_Promo` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddAddons_Promo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddAddons_Promo`(p_promoid int,
						p_addonsid int)
BEGIN
		insert into hotelmgn.tbladdons_promo	(promoid,
							addonsid)
						values	(p_promoid,
							p_addonsid);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddBooking` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddBooking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddBooking`(p_tenantid int,
					p_bookingStatus varchar(30),
					p_hotelroomid int,
					p_apid int,
					p_bookingDate date,
					p_numberOfDays int,
					p_totalPrice double,
					p_payment double)
BEGIN
		insert into hotelmgn.tblbooking	(tenantid,
						bookingStatus,
						hotelroomid,
						apid,
						bookingDate,
						numberOfDays,
						totalPrice,
						payment)
					values	(p_tenantid,
						p_bookingStatus,
						p_hotelroomid,
						p_apid,
						p_bookingDate,
						p_numberOfDays,
						p_totalPrice,
						p_payment);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddHotel` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddHotel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddHotel`(p_location varchar(60),
					p_image text,
					p_description varchar(200))
BEGIN
		insert into hotelmgn.tblhotel 	(location,
						image,
						description)
					values	(p_location,
						p_image,
						p_description);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddHotelRoom` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddHotelRoom` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddHotelRoom`(p_roomName varchar(50),
					p_roomGrade varchar(30),
					p_roomStatus varchar(30),
					p_hotelid int,
					p_description varchar(200),
					p_initialPricePerDay double)
BEGIN
		insert into hotelmgn.tblhotelroom	(roomName,
							roomGrade,
							roomStatus,
							hotelid,
							description,
							initialPricePerDay)
						values	(p_roomName,
							p_roomGrade,
							p_roomStatus,
							p_hotelid,
							p_description,
							p_initialPricePerDay);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddPersonnel` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddPersonnel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddPersonnel`(p_accountid int,
					p_position varchar(30),
					p_workShift varchar(45),
					p_workName varchar(45))
BEGIN
		insert into hotelmgn.tblpersonnel	(accountid,
							position,
							workShift,
							workName)
						values	(p_accountid,
							p_position,
							p_workShift,
							p_workNam);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddPromo` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddPromo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddPromo`(p_promoName varchar(50),
					p_description varchar(200),
					p_percentageDiscount double)
BEGIN
		insert into hotelmgn.tblpromo	(promoName,
						description,
						percentageDiscount)
					values	(p_promoName,
						p_description,
						p_percentageDiscount);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddReservation` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddReservation` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddReservation`(p_bookingid int,
						p_invoiceNumber varchar(100),
						p_reservationStatus varchar(50),
						p_checkIn date,
						p_checkOut date,
						p_balance double)
BEGIN
		insert into hotelmgn.tblreservation	(bookingid,
							invoiceNumber,
							reservationStatus,
							checkIn,
							checkOut,
							balance)
						values	(p_bookingid,
							p_invoiceNumber,
							p_reservationStatus,
							p_checkIn,
							p_checkOut,
							p_balance);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procAddTenant` */

/*!50003 DROP PROCEDURE IF EXISTS  `procAddTenant` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procAddTenant`(p_accountid int,
					p_membership varchar(50))
BEGIN
		insert into hotelmgn.tbltenant	(accountid,
						membership)
					values	(p_accountid,
						p_membership);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeleteAccount` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeleteAccount` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeleteAccount`(p_id int)
BEGIN
		delete from hotelmgn.tblaccount where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeleteAddons` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeleteAddons` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeleteAddons`(p_id int)
BEGIN
		delete from hotelmgn.tbladdons where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeleteAddons_Promo` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeleteAddons_Promo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeleteAddons_Promo`(p_id int)
BEGIN
		delete from hotelmgn.tbladdons_promo where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeleteBooking` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeleteBooking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeleteBooking`(p_id int)
BEGIN
		delete from hotelmgn.tblbooking where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeleteHotel` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeleteHotel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeleteHotel`(p_id int)
BEGIN
		delete from hotelmgn.tblhotel where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeleteHotelRoom` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeleteHotelRoom` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeleteHotelRoom`(p_id int)
BEGIN
		delete from hotelmgn.tblHotelRoom where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeletePersonnel` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeletePersonnel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeletePersonnel`(p_id int)
BEGIN
		delete from hotelmgn.tblpersonnel where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeletePromo` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeletePromo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeletePromo`(p_id int)
BEGIN
		delete from hotelmgn.tblpromo where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeleteReservation` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeleteReservation` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeleteReservation`(p_id int)
BEGIN
		delete from hotelmgn.tblreservation where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procDeleteTenant` */

/*!50003 DROP PROCEDURE IF EXISTS  `procDeleteTenant` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procDeleteTenant`(p_id int)
BEGIN
		delete from hotelmgn.tbltenant where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdateAccount` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdateAccount` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdateAccount`(p_id int,
					p_username varchar(40),
					p_password varchar(40),
					p_email varchar(60),
					p_address varchar(100),
					p_firstName varchar(40),
					p_lastName varchar(40),
					p_birthdate date,
					p_gender varchar(15),
					p_image text)
BEGIN
		update hotelmgn.tblaccount set  username = p_username,
						password = p_password,
						email = p_email,
						address = p_address,
						firstName = p_firstName,
						lastName = p_lastName,
						birthdate = p_birthdate,
						gender = p_gender,
						image = p_image
					where	id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdateAddons` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdateAddons` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdateAddons`(p_id int,
					p_location varchar(60),
					p_image text,
					p_description varchar(200))
BEGIN
		update tbladdons set location = p_location,
				image = p_image,
				description = p_description
			where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdateBooking` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdateBooking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdateBooking`(p_id int,
						p_tenantid int,
						p_bookingStatus varchar(30),
						p_hotelroomid int,
						p_apid int,
						p_bookingDate date,
						p_numberOfDays int,
						p_totalPrice double,
						p_payment double)
BEGIN
		update tblbooking set tenantid = p_tenantid,
					bookingStatus = p_bookingStatus,
					hotelroomid = p_hotelroomid,
					apid = p_apid,
					bookingDate = p_bookingDate,
					numberOfDays = p_numberOfDays,
					totalPrice = p_totalPrice,
					payment = p_payment
			where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdateHotel` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdateHotel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdateHotel`(p_id int,
					p_location varchar(60),
					p_image text,
					p_description varchar(200))
BEGIN
		update tblhotel set location = p_location,
				image = p_image,
				description = p_description
			where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdateHotelRoom` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdateHotelRoom` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdateHotelRoom`(p_id int,
						p_roomName varchar(50),
						p_roomGrade varchar(30),
						p_roomStatus varchar(30),
						p_hotelid int,
						p_description varchar(200),
						p_initialPricePerDay double)
BEGIN
		update tblhotelroom set roomName = p_roomName,
					roomGrade = p_roomGrade,
					roomStatus = p_roomStatus,
					hotelid = p_hotelid,
					description = p_description,
					initialPricePerDay = p_initialPricePerDay
			where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdatePersonnel` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdatePersonnel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdatePersonnel`(p_id int,
						p_accountid int,
						p_position varchar(30),
						p_workShift varchar(45),
						p_workName varchar(45))
BEGIN
		update tblpersonnel set accountid = p_accountid,
					position = p_postion,
					workShift = p_workShift,
					workName = p_workName
			where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdatePromo` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdatePromo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdatePromo`(p_id int,
					p_promoName varchar(50),
					p_description varchar(200),
					p_percentageDiscount double)
BEGIN
		update tblpromo set promoName = p_promoName,
				description = p_description,
				percentageDiscount = p_percentageDiscount
			where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdateReservation` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdateReservation` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdateReservation`(p_id int,
						p_bookingid int,
						p_invoiceNumber varchar(100),
						p_reservationStatus varchar(50),
						p_checkIn date,
						p_checkOut date,
						p_balance double)
BEGIN
		update tblreservation set bookingid = p_bookingid,
					invoiceNumber = p_invoiceNumber,
					reservationStatus = p_reservationStatus,
					checkIn = p_checkIn,
					checkOut = p_checkOut,
					balance = p_balance
			where id = p_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procUpdateTenant` */

/*!50003 DROP PROCEDURE IF EXISTS  `procUpdateTenant` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procUpdateTenant`(p_id int,
						p_accountid int,
						p_membership varchar(50))
BEGIN
		update tbltenant set accountid = p_accountid,
					membership = p_membership
			where id = p_id;
	END */$$
DELIMITER ;

/*Table structure for table `view_allaccount` */

DROP TABLE IF EXISTS `view_allaccount`;

/*!50001 DROP VIEW IF EXISTS `view_allaccount` */;
/*!50001 DROP TABLE IF EXISTS `view_allaccount` */;

/*!50001 CREATE TABLE  `view_allaccount`(
 `id` int(11) ,
 `username` varchar(40) ,
 `password` varchar(40) ,
 `email` varchar(60) ,
 `address` varchar(100) ,
 `firstName` varchar(40) ,
 `lastName` varchar(40) ,
 `birthdate` date ,
 `gender` varchar(15) ,
 `image` text 
)*/;

/*Table structure for table `view_alladdons` */

DROP TABLE IF EXISTS `view_alladdons`;

/*!50001 DROP VIEW IF EXISTS `view_alladdons` */;
/*!50001 DROP TABLE IF EXISTS `view_alladdons` */;

/*!50001 CREATE TABLE  `view_alladdons`(
 `id` int(11) ,
 `location` varchar(60) ,
 `image` text ,
 `description` varchar(200) 
)*/;

/*Table structure for table `view_allbooking` */

DROP TABLE IF EXISTS `view_allbooking`;

/*!50001 DROP VIEW IF EXISTS `view_allbooking` */;
/*!50001 DROP TABLE IF EXISTS `view_allbooking` */;

/*!50001 CREATE TABLE  `view_allbooking`(
 `id` int(11) ,
 `tenantid` int(11) ,
 `bookingStatus` varchar(30) ,
 `hotelroomid` int(11) ,
 `apid` int(11) ,
 `bookingDate` date ,
 `numberOfDays` int(11) ,
 `totalPrice` double ,
 `payment` double 
)*/;

/*Table structure for table `view_allhotel` */

DROP TABLE IF EXISTS `view_allhotel`;

/*!50001 DROP VIEW IF EXISTS `view_allhotel` */;
/*!50001 DROP TABLE IF EXISTS `view_allhotel` */;

/*!50001 CREATE TABLE  `view_allhotel`(
 `id` int(11) ,
 `location` varchar(60) ,
 `image` text ,
 `description` varchar(200) 
)*/;

/*Table structure for table `view_allhotelroom` */

DROP TABLE IF EXISTS `view_allhotelroom`;

/*!50001 DROP VIEW IF EXISTS `view_allhotelroom` */;
/*!50001 DROP TABLE IF EXISTS `view_allhotelroom` */;

/*!50001 CREATE TABLE  `view_allhotelroom`(
 `id` int(11) ,
 `roomName` varchar(50) ,
 `roomGrade` varchar(30) ,
 `roomStatus` varchar(30) ,
 `hotelid` int(11) ,
 `description` varchar(200) ,
 `initialPricePerDay` double 
)*/;

/*Table structure for table `view_allpersonnel` */

DROP TABLE IF EXISTS `view_allpersonnel`;

/*!50001 DROP VIEW IF EXISTS `view_allpersonnel` */;
/*!50001 DROP TABLE IF EXISTS `view_allpersonnel` */;

/*!50001 CREATE TABLE  `view_allpersonnel`(
 `id` int(11) ,
 `accountid` int(11) ,
 `position` varchar(30) ,
 `workShift` varchar(45) ,
 `workName` varchar(45) 
)*/;

/*Table structure for table `view_allpromo` */

DROP TABLE IF EXISTS `view_allpromo`;

/*!50001 DROP VIEW IF EXISTS `view_allpromo` */;
/*!50001 DROP TABLE IF EXISTS `view_allpromo` */;

/*!50001 CREATE TABLE  `view_allpromo`(
 `id` int(11) ,
 `promoName` varchar(50) ,
 `description` varchar(200) ,
 `percentageDiscount` double 
)*/;

/*Table structure for table `view_allreservation` */

DROP TABLE IF EXISTS `view_allreservation`;

/*!50001 DROP VIEW IF EXISTS `view_allreservation` */;
/*!50001 DROP TABLE IF EXISTS `view_allreservation` */;

/*!50001 CREATE TABLE  `view_allreservation`(
 `id` int(11) ,
 `bookingid` int(11) ,
 `invoiceNumber` varchar(100) ,
 `reservationStatus` varchar(50) ,
 `checkIn` date ,
 `checkOut` date ,
 `balance` double 
)*/;

/*Table structure for table `view_alltenant` */

DROP TABLE IF EXISTS `view_alltenant`;

/*!50001 DROP VIEW IF EXISTS `view_alltenant` */;
/*!50001 DROP TABLE IF EXISTS `view_alltenant` */;

/*!50001 CREATE TABLE  `view_alltenant`(
 `id` int(11) ,
 `accountid` int(11) ,
 `membership` varchar(50) 
)*/;

/*View structure for view view_allaccount */

/*!50001 DROP TABLE IF EXISTS `view_allaccount` */;
/*!50001 DROP VIEW IF EXISTS `view_allaccount` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_allaccount` AS (select `tblaccount`.`id` AS `id`,`tblaccount`.`username` AS `username`,`tblaccount`.`password` AS `password`,`tblaccount`.`email` AS `email`,`tblaccount`.`address` AS `address`,`tblaccount`.`firstName` AS `firstName`,`tblaccount`.`lastName` AS `lastName`,`tblaccount`.`birthdate` AS `birthdate`,`tblaccount`.`gender` AS `gender`,`tblaccount`.`image` AS `image` from `tblaccount`) */;

/*View structure for view view_alladdons */

/*!50001 DROP TABLE IF EXISTS `view_alladdons` */;
/*!50001 DROP VIEW IF EXISTS `view_alladdons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_alladdons` AS (select `tbladdons`.`id` AS `id`,`tbladdons`.`location` AS `location`,`tbladdons`.`image` AS `image`,`tbladdons`.`description` AS `description` from `tbladdons`) */;

/*View structure for view view_allbooking */

/*!50001 DROP TABLE IF EXISTS `view_allbooking` */;
/*!50001 DROP VIEW IF EXISTS `view_allbooking` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_allbooking` AS (select `tblbooking`.`id` AS `id`,`tblbooking`.`tenantid` AS `tenantid`,`tblbooking`.`bookingStatus` AS `bookingStatus`,`tblbooking`.`hotelroomid` AS `hotelroomid`,`tblbooking`.`apid` AS `apid`,`tblbooking`.`bookingDate` AS `bookingDate`,`tblbooking`.`numberOfDays` AS `numberOfDays`,`tblbooking`.`totalPrice` AS `totalPrice`,`tblbooking`.`payment` AS `payment` from `tblbooking`) */;

/*View structure for view view_allhotel */

/*!50001 DROP TABLE IF EXISTS `view_allhotel` */;
/*!50001 DROP VIEW IF EXISTS `view_allhotel` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_allhotel` AS (select `tblhotel`.`id` AS `id`,`tblhotel`.`location` AS `location`,`tblhotel`.`image` AS `image`,`tblhotel`.`description` AS `description` from `tblhotel`) */;

/*View structure for view view_allhotelroom */

/*!50001 DROP TABLE IF EXISTS `view_allhotelroom` */;
/*!50001 DROP VIEW IF EXISTS `view_allhotelroom` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_allhotelroom` AS (select `tblhotelroom`.`id` AS `id`,`tblhotelroom`.`roomName` AS `roomName`,`tblhotelroom`.`roomGrade` AS `roomGrade`,`tblhotelroom`.`roomStatus` AS `roomStatus`,`tblhotelroom`.`hotelid` AS `hotelid`,`tblhotelroom`.`description` AS `description`,`tblhotelroom`.`initialPricePerDay` AS `initialPricePerDay` from `tblhotelroom`) */;

/*View structure for view view_allpersonnel */

/*!50001 DROP TABLE IF EXISTS `view_allpersonnel` */;
/*!50001 DROP VIEW IF EXISTS `view_allpersonnel` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_allpersonnel` AS (select `tblpersonnel`.`id` AS `id`,`tblpersonnel`.`accountid` AS `accountid`,`tblpersonnel`.`position` AS `position`,`tblpersonnel`.`workShift` AS `workShift`,`tblpersonnel`.`workName` AS `workName` from `tblpersonnel`) */;

/*View structure for view view_allpromo */

/*!50001 DROP TABLE IF EXISTS `view_allpromo` */;
/*!50001 DROP VIEW IF EXISTS `view_allpromo` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_allpromo` AS (select `tblpromo`.`id` AS `id`,`tblpromo`.`promoName` AS `promoName`,`tblpromo`.`description` AS `description`,`tblpromo`.`percentageDiscount` AS `percentageDiscount` from `tblpromo`) */;

/*View structure for view view_allreservation */

/*!50001 DROP TABLE IF EXISTS `view_allreservation` */;
/*!50001 DROP VIEW IF EXISTS `view_allreservation` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_allreservation` AS (select `tblreservation`.`id` AS `id`,`tblreservation`.`bookingid` AS `bookingid`,`tblreservation`.`invoiceNumber` AS `invoiceNumber`,`tblreservation`.`reservationStatus` AS `reservationStatus`,`tblreservation`.`checkIn` AS `checkIn`,`tblreservation`.`checkOut` AS `checkOut`,`tblreservation`.`balance` AS `balance` from `tblreservation`) */;

/*View structure for view view_alltenant */

/*!50001 DROP TABLE IF EXISTS `view_alltenant` */;
/*!50001 DROP VIEW IF EXISTS `view_alltenant` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_alltenant` AS (select `tbltenant`.`id` AS `id`,`tbltenant`.`accountid` AS `accountid`,`tbltenant`.`membership` AS `membership` from `tbltenant`) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
