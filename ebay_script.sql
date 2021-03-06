-- MySQL Script generated by MySQL Workbench
-- Mon Dec  8 04:20:23 2014
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Ebay
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Ebay
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Ebay` DEFAULT CHARACTER SET latin1 ;
USE `Ebay` ;

-- -----------------------------------------------------
-- Table `Ebay`.`Bid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ebay`.`Bid` (
  `idBid` INT(11) NOT NULL AUTO_INCREMENT,
  `idProduct` INT(11) NULL DEFAULT NULL,
  `membershipNo` INT(11) NULL DEFAULT NULL,
  `bidAmount` DECIMAL(7,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idBid`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Ebay`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ebay`.`User` (
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `addressMain` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` INT(11) NOT NULL,
  `membershipNo` INT(11) NOT NULL AUTO_INCREMENT,
  `isSeller` TINYINT(1) NOT NULL DEFAULT '0',
  `sellerRating` DECIMAL(2,1) NULL DEFAULT '0.0',
  `password` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `last_login` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`membershipNo`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1111111120
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Ebay`.`BuyerCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ebay`.`BuyerCart` (
  `membershipNo` INT(11) NOT NULL,
  `idProduct` INT(11) NOT NULL,
  `isPurchased` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`membershipNo`, `idProduct`),
  INDEX `cart_user_relation_idx` (`membershipNo` ASC),
  CONSTRAINT `cart_user_relation`
    FOREIGN KEY (`membershipNo`)
    REFERENCES `Ebay`.`User` (`membershipNo`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Ebay`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ebay`.`Category` (
  `idCategory` INT(11) NOT NULL AUTO_INCREMENT,
  `categoryName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Ebay`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ebay`.`Product` (
  `idProduct` INT(11) NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(15) NOT NULL,
  `productCondition` VARCHAR(15) NULL DEFAULT NULL,
  `productDesc` VARCHAR(4000) NULL DEFAULT NULL,
  `amount` DECIMAL(7,2) NULL DEFAULT NULL,
  `idCategory` INT(11) NULL DEFAULT NULL,
  `quantity` INT(11) NULL DEFAULT NULL,
  `endDateOfSale` DATETIME NULL DEFAULT NULL,
  `sellType` VARCHAR(15) NULL DEFAULT NULL,
  `sellerId` VARCHAR(45) NOT NULL,
  `productImage` VARCHAR(450) NULL DEFAULT NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB
AUTO_INCREMENT = 196622
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Ebay`.`Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ebay`.`Rating` (
  `buyerMembershipNo` INT(11) NOT NULL,
  `sellerMembershipNo` INT(11) NULL DEFAULT NULL,
  `rating` DECIMAL(2,1) NULL DEFAULT NULL,
  `comment` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`buyerMembershipNo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Ebay`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ebay`.`Transaction` (
  `idTransaction` INT(11) NOT NULL AUTO_INCREMENT,
  `idProduct` INT(11) NOT NULL,
  `buyerMembershipNo` INT(11) NOT NULL,
  `sellerMembershipNo` INT(11) NOT NULL,
  PRIMARY KEY (`idTransaction`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `Ebay`;

DELIMITER $$
USE `Ebay`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `Ebay`.`BuyerCart_AFTER_UPDATE`
AFTER UPDATE ON `Ebay`.`BuyerCart`
FOR EACH ROW
BEGIN
    IF (NEW.`isPurchased` LIKE true)
	THEN 
    UPDATE `Ebay`.`Product` SET `quantity` = `quantity` - 1 WHERE `idProduct` = NEW.`idProduct`;
	END IF;
END$$

USE `Ebay`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `Ebay`.`Product_AFTER_INSERT`
AFTER INSERT ON `Ebay`.`Product`
FOR EACH ROW
BEGIN
UPDATE `Ebay`.`User` SET `isSeller`='1' WHERE `membershipNo`= NEW.`sellerId`;
IF (NEW.`sellType` LIKE 'auction')
THEN 
INSERT INTO `Ebay`.`Bid` (`idProduct`, `membershipNo`, `bidAmount`) VALUES (NEW.`idProduct`, NEW.`sellerId`, NEW.`amount`);
END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
