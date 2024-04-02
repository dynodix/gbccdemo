-- --------------------------------------------------------
-- Strežnik:                     192.168.0.9
-- Verzija strežnika:            11.2.2-MariaDB-1:11.2.2+maria~ubu2204 - mariadb.org binary distribution
-- Operacijski sistem strežnika: debian-linux-gnu
-- HeidiSQL Različica:           12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for gbcc
CREATE DATABASE IF NOT EXISTS `gbcc` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_slovenian_ci */;
USE `gbcc`;

-- Dumping structure for tabela gbcc.games
CREATE TABLE IF NOT EXISTS `games` (
  `gameuuid` uuid NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `image` blob DEFAULT NULL,
  PRIMARY KEY (`gameuuid`),
  KEY `Indeks 2` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_slovenian_ci;

-- Data exporting was unselected.

-- Dumping structure for tabela gbcc.players
CREATE TABLE IF NOT EXISTS `players` (
  `playeruuid` uuid NOT NULL,
  `firstname` varchar(80) DEFAULT NULL,
  `lastname` varchar(80) DEFAULT NULL,
  `borndate` date DEFAULT NULL,
  `documentnr` varchar(50) DEFAULT NULL,
  `gdpraccept` set('Yes','No') DEFAULT 'Yes',
  PRIMARY KEY (`playeruuid`),
  KEY `Indeks 2` (`firstname`),
  KEY `Indeks 3` (`lastname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_slovenian_ci;

-- Data exporting was unselected.

-- Dumping structure for tabela gbcc.playingames
CREATE TABLE IF NOT EXISTS `playingames` (
  `playeruuid` uuid NOT NULL,
  `gameuuid` uuid NOT NULL,
  `lastplay` date DEFAULT NULL,
  PRIMARY KEY (`gameuuid`,`playeruuid`),
  KEY `FK_playingames_players` (`playeruuid`),
  CONSTRAINT `FK_playingames_games` FOREIGN KEY (`gameuuid`) REFERENCES `games` (`gameuuid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_playingames_players` FOREIGN KEY (`playeruuid`) REFERENCES `players` (`playeruuid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_slovenian_ci;

-- Data exporting was unselected.

-- Dumping structure for view gbcc.viewplayingames
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `viewplayingames` (
	`firstname` VARCHAR(80) NULL COLLATE 'utf8mb3_slovenian_ci',
	`lastname` VARCHAR(80) NULL COLLATE 'utf8mb3_slovenian_ci',
	`title` VARCHAR(50) NULL COLLATE 'utf8mb3_slovenian_ci',
	`playdate` DATE NULL,
	`playeruuid` UUID NOT NULL
) ENGINE=MyISAM;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `viewplayingames`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `viewplayingames` AS select `players`.`firstname` AS `firstname`,`players`.`lastname` AS `lastname`,`games`.`title` AS `title`,`playingames`.`lastplay` AS `playdate`,`players`.`playeruuid` AS `playeruuid` from ((`playingames` join `players`) join `games`) where `playingames`.`playeruuid` = `players`.`playeruuid` and `playingames`.`gameuuid` = `games`.`gameuuid`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
