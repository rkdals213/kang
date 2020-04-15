-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`학과`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`학과` (
  `학과명` VARCHAR(45) NOT NULL,
  `전화번호` VARCHAR(45) NULL,
  `사무실위치` VARCHAR(45) NULL,
  PRIMARY KEY (`학과명`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`학생`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`학생` (
  `학번` INT NOT NULL,
  `이름` VARCHAR(45) NULL,
  `나이` INT NULL,
  `생년월일` DATE NULL,
  `주소` VARCHAR(45) NULL,
  `학과_학과명` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`학번`),
  INDEX `fk_학생_학과_idx` (`학과_학과명` ASC) VISIBLE,
  CONSTRAINT `fk_학생_학과`
    FOREIGN KEY (`학과_학과명`)
    REFERENCES `mydb`.`학과` (`학과명`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
