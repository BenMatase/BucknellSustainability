-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema energyhill
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema energyhill
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `energyhill` DEFAULT CHARACTER SET latin1 ;
USE `energyhill` ;

-- -----------------------------------------------------
-- Table `energyhill`.`alerts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `energyhill`.`alerts` (
  `alertId` INT(11) NOT NULL AUTO_INCREMENT,
  `alertTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `handled` TINYINT(4) NULL DEFAULT '0',
  `sensorId` INT(11) NULL DEFAULT '1',
  PRIMARY KEY (`alertId`),
  INDEX `sensorId_idx` (`sensorId` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1917
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `energyhill`.`site`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `energyhill`.`site` (
  `siteId` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(200) NOT NULL DEFAULT ' ',
  `longitude` DOUBLE NULL DEFAULT NULL,
  `latitude` DOUBLE NOT NULL,
  `link` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`siteId`),
  UNIQUE INDEX `siteId_UNIQUE` (`siteId` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `energyhill`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `energyhill`.`project` (
  `projectId` INT(11) NOT NULL AUTO_INCREMENT,
  `siteId` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`projectId`),
  INDEX `siteId` (`siteId` ASC),
  CONSTRAINT `siteId`
    FOREIGN KEY (`siteId`)
    REFERENCES `energyhill`.`site` (`siteId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `energyhill`.`sensor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `energyhill`.`sensor` (
  `sensorId` INT(11) NOT NULL AUTO_INCREMENT,
  `projectId` INT(11) NOT NULL,
  `units` VARCHAR(40) NULL DEFAULT NULL,
  `name` VARCHAR(40) NULL DEFAULT NULL,
  `description` VARCHAR(50) NULL DEFAULT NULL,
  `alertsEnabled` TINYINT(4) NULL DEFAULT NULL,
  `alertMinVal` DOUBLE NULL DEFAULT NULL,
  `alertMaxVal` DOUBLE NULL DEFAULT NULL,
  `alertEmail` VARCHAR(45) NULL DEFAULT NULL,
  `alertMessage` VARCHAR(45) NULL DEFAULT 'ALERT',
  PRIMARY KEY (`sensorId`),
  INDEX `projectId_idx` (`projectId` ASC),
  CONSTRAINT `projectId`
    FOREIGN KEY (`projectId`)
    REFERENCES `energyhill`.`project` (`projectId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `energyhill`.`data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `energyhill`.`data` (
  `dataId` INT(11) NOT NULL AUTO_INCREMENT,
  `sensorId` INT(11) NOT NULL,
  `value` DOUBLE NOT NULL,
  `dateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dataId`),
  INDEX `sensorId_idx` (`sensorId` ASC),
  CONSTRAINT `sensorId`
    FOREIGN KEY (`sensorId`)
    REFERENCES `energyhill`.`sensor` (`sensorId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4207014
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `energyhill`.`datahourly`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `energyhill`.`datahourly` (
  `sensorId` INT(11) NULL DEFAULT NULL,
  `averageValue` DOUBLE NULL DEFAULT NULL,
  `sampleRate` INT(11) NULL DEFAULT NULL,
  `dateTime` DATETIME NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
