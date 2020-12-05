SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema boar
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `boar` ;

-- -----------------------------------------------------
-- Schema boar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `boar` DEFAULT CHARACTER SET utf8 ;
USE `boar` ;

-- -----------------------------------------------------
-- Table `boar`.`Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`Project` ;

CREATE TABLE IF NOT EXISTS `boar`.`Project` (
  `ProjectId` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ProjectId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`Metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`Metadata` ;

CREATE TABLE IF NOT EXISTS `boar`.`Metadata` (
  `key` VARCHAR(45) NOT NULL,
  `value` VARCHAR(2000) NULL,
  `type` VARCHAR(45) NOT NULL,
  `ProjectId` INT NOT NULL,
  INDEX `fk_Metadata_Project_idx` (`ProjectId` ASC) VISIBLE,
  CONSTRAINT `fk_Metadata_Project`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `boar`.`Project` (`ProjectId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`UserStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`UserStatus` ;

CREATE TABLE IF NOT EXISTS `boar`.`UserStatus` (
  `UserStatusId` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UserStatusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`User` ;

CREATE TABLE IF NOT EXISTS `boar`.`User` (
  `UserId` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `avatar` VARCHAR(500) NULL,
  `UserStatusId` INT NOT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_User_UserStatus1_idx` (`UserStatusId` ASC) VISIBLE,
  CONSTRAINT `fk_User_UserStatus1`
    FOREIGN KEY (`UserStatusId`)
    REFERENCES `boar`.`UserStatus` (`UserStatusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`Specification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`Specification` ;

CREATE TABLE IF NOT EXISTS `boar`.`Specification` (
  `SpecificationId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(1000) NOT NULL,
  `text` LONGTEXT NOT NULL,
  `datetime` DATETIME NOT NULL,
  `deadline` DATE NOT NULL,
  `ProjectId` INT NOT NULL,
  `Author` INT NOT NULL,
  INDEX `fk_Specification_Project1_idx` (`ProjectId` ASC) VISIBLE,
  PRIMARY KEY (`SpecificationId`),
  INDEX `fk_Specification_User1_idx` (`Author` ASC) VISIBLE,
  CONSTRAINT `fk_Specification_Project1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `boar`.`Project` (`ProjectId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Specification_User1`
    FOREIGN KEY (`Author`)
    REFERENCES `boar`.`User` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`TaskStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`TaskStatus` ;

CREATE TABLE IF NOT EXISTS `boar`.`TaskStatus` (
  `TaskStatusId` INT NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`TaskStatusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`Task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`Task` ;

CREATE TABLE IF NOT EXISTS `boar`.`Task` (
  `TaskId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(1000) NOT NULL,
  `text` LONGTEXT NOT NULL,
  `datetime` DATETIME NOT NULL,
  `deadline` DATE NOT NULL,
  `TaskStatusId` INT NOT NULL,
  `SpecificationId` INT NOT NULL,
  `AssignedTo` INT NOT NULL,
  `Author` INT NOT NULL,
  INDEX `fk_Task_TaskStatus1_idx` (`TaskStatusId` ASC) VISIBLE,
  INDEX `fk_Task_Specification1_idx` (`SpecificationId` ASC) VISIBLE,
  PRIMARY KEY (`TaskId`),
  INDEX `fk_Task_User1_idx` (`Author` ASC) VISIBLE,
  INDEX `fk_Task_User2_idx` (`AssignedTo` ASC) VISIBLE,
  CONSTRAINT `fk_Task_TaskStatus1`
    FOREIGN KEY (`TaskStatusId`)
    REFERENCES `boar`.`TaskStatus` (`TaskStatusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_Specification1`
    FOREIGN KEY (`SpecificationId`)
    REFERENCES `boar`.`Specification` (`SpecificationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_User1`
    FOREIGN KEY (`Author`)
    REFERENCES `boar`.`User` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_User2`
    FOREIGN KEY (`AssignedTo`)
    REFERENCES `boar`.`User` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`Artifact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`Artifact` ;

CREATE TABLE IF NOT EXISTS `boar`.`Artifact` (
  `ArtifactId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(2000) NOT NULL,
  `link` VARCHAR(500) NOT NULL,
  `status` TINYINT(1) NULL,
  PRIMARY KEY (`ArtifactId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`ArtifactConnector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`ArtifactConnector` ;

CREATE TABLE IF NOT EXISTS `boar`.`ArtifactConnector` (
  `TaskId` INT NOT NULL,
  `ArtifactId` INT NOT NULL,
  PRIMARY KEY (`TaskId`, `ArtifactId`),
  INDEX `fk_Task_has_Artifact_Artifact1_idx` (`ArtifactId` ASC) VISIBLE,
  INDEX `fk_Task_has_Artifact_Task1_idx` (`TaskId` ASC) VISIBLE,
  CONSTRAINT `fk_Task_has_Artifact_Task1`
    FOREIGN KEY (`TaskId`)
    REFERENCES `boar`.`Task` (`TaskId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_has_Artifact_Artifact1`
    FOREIGN KEY (`ArtifactId`)
    REFERENCES `boar`.`Artifact` (`ArtifactId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`Role` ;

CREATE TABLE IF NOT EXISTS `boar`.`Role` (
  `RoleId` INT NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RoleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boar`.`Access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boar`.`Access` ;

CREATE TABLE IF NOT EXISTS `boar`.`Access` (
  `ProjectId` INT NOT NULL,
  `UserId` INT NOT NULL,
  `RoleId` INT NOT NULL,
  INDEX `fk_Project_has_User_User1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_Project_has_User_Project1_idx` (`ProjectId` ASC) VISIBLE,
  INDEX `fk_Access_Role1_idx` (`RoleId` ASC) VISIBLE,
  CONSTRAINT `fk_Project_has_User_Project1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `boar`.`Project` (`ProjectId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Project_has_User_User1`
    FOREIGN KEY (`UserId`)
    REFERENCES `boar`.`User` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Access_Role1`
    FOREIGN KEY (`RoleId`)
    REFERENCES `boar`.`Role` (`RoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


