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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `boar`.`Project`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`Project` (`ProjectId`) VALUES (1);
INSERT INTO `boar`.`Project` (`ProjectId`) VALUES (2);
INSERT INTO `boar`.`Project` (`ProjectId`) VALUES (3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`Metadata`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`Metadata` (`key`, `value`, `type`, `ProjectId`) VALUES ('name', 'boar', 'text', 1);
INSERT INTO `boar`.`Metadata` (`key`, `value`, `type`, `ProjectId`) VALUES ('description', 'boar is agile-oriented kanban-style Project Management Software(PMS) with lots of ways for customization to make it the best solution for you', 'text', 1);
INSERT INTO `boar`.`Metadata` (`key`, `value`, `type`, `ProjectId`) VALUES ('repository', 'https://github.com/drewg3r/boar', 'link', 1);
INSERT INTO `boar`.`Metadata` (`key`, `value`, `type`, `ProjectId`) VALUES ('name', 'bear', 'text', 2);
INSERT INTO `boar`.`Metadata` (`key`, `value`, `type`, `ProjectId`) VALUES ('description', 'my project', 'text', 2);
INSERT INTO `boar`.`Metadata` (`key`, `value`, `type`, `ProjectId`) VALUES ('website', 'https://bear.com', 'link', 2);
INSERT INTO `boar`.`Metadata` (`key`, `value`, `type`, `ProjectId`) VALUES ('name', 'beaver', 'text', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`UserStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`UserStatus` (`UserStatusId`, `Status`) VALUES (1, 'email not confirmed');
INSERT INTO `boar`.`UserStatus` (`UserStatusId`, `Status`) VALUES (2, 'registered');
INSERT INTO `boar`.`UserStatus` (`UserStatusId`, `Status`) VALUES (3, 'blocked');

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`User` (`UserId`, `username`, `password`, `email`, `avatar`, `UserStatusId`) VALUES (1, 'aliona', '24343347', 'aliona@gmail.com', 'picture/avatar/user1', 3);
INSERT INTO `boar`.`User` (`UserId`, `username`, `password`, `email`, `avatar`, `UserStatusId`) VALUES (2, 'andrew', '35796421', 'andrew@gmail.com', 'picture/avatar/user2', 2);
INSERT INTO `boar`.`User` (`UserId`, `username`, `password`, `email`, `avatar`, `UserStatusId`) VALUES (3, 'liza', '45864356', 'liza@gmail.com', 'picture/avatar/user3', 2);
INSERT INTO `boar`.`User` (`UserId`, `username`, `password`, `email`, `avatar`, `UserStatusId`) VALUES (4, 'mihail', '56675432', 'mihail@gmail.com', 'picture/avatar/user4', 1);
INSERT INTO `boar`.`User` (`UserId`, `username`, `password`, `email`, `avatar`, `UserStatusId`) VALUES (5, 'sofia', '34569086', 'sofia@gmail.com', 'picture/avatar/user5', 2);
INSERT INTO `boar`.`User` (`UserId`, `username`, `password`, `email`, `avatar`, `UserStatusId`) VALUES (6, 'yevhenii', '45689543', 'yevhenii@gmail.com', 'picture/avatar/user6', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`Specification`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`Specification` (`SpecificationId`, `name`, `text`, `datetime`, `deadline`, `ProjectId`, `Author`) VALUES (1, 'boar specification 1', 'text of  boar specification 1', '20.09.2020', '01.10.2020', 1, 2);
INSERT INTO `boar`.`Specification` (`SpecificationId`, `name`, `text`, `datetime`, `deadline`, `ProjectId`, `Author`) VALUES (2, 'boar specification 2', 'text of boar specification 2', '15.10.2020', '15.11.2020', 1, 2);
INSERT INTO `boar`.`Specification` (`SpecificationId`, `name`, `text`, `datetime`, `deadline`, `ProjectId`, `Author`) VALUES (3, 'boar specification 3', 'text of boar specification 3', '27.11.2020', '04.12.2020', 1, 2);
INSERT INTO `boar`.`Specification` (`SpecificationId`, `name`, `text`, `datetime`, `deadline`, `ProjectId`, `Author`) VALUES (4, 'bear specification 1', 'text of bear specification 1', '01.10.2020', '10.11.2020', 2, 4);
INSERT INTO `boar`.`Specification` (`SpecificationId`, `name`, `text`, `datetime`, `deadline`, `ProjectId`, `Author`) VALUES (5, 'bear specifiation 2', 'text of bear specification 2', '15.11.2020', '20.12.2020', 2, 4);
INSERT INTO `boar`.`Specification` (`SpecificationId`, `name`, `text`, `datetime`, `deadline`, `ProjectId`, `Author`) VALUES (6, 'beaver specification 1', 'text of beaver specification 1', '04.11.2020', '12.01.2021', 3, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`TaskStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`TaskStatus` (`TaskStatusId`, `status`) VALUES (1, 'created');
INSERT INTO `boar`.`TaskStatus` (`TaskStatusId`, `status`) VALUES (2, 'developed');
INSERT INTO `boar`.`TaskStatus` (`TaskStatusId`, `status`) VALUES (3, 'tested');
INSERT INTO `boar`.`TaskStatus` (`TaskStatusId`, `status`) VALUES (4, 'checked');
INSERT INTO `boar`.`TaskStatus` (`TaskStatusId`, `status`) VALUES (5, 'done');

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`Task`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`Task` (`TaskId`, `name`, `text`, `datetime`, `deadline`, `TaskStatusId`, `SpecificationId`, `AssignedTo`, `Author`) VALUES (1, 'make readme', 'make readme for boar project', '20.09.2020', '27.09.2020', 5, 1, 1, 2);
INSERT INTO `boar`.`Task` (`TaskId`, `name`, `text`, `datetime`, `deadline`, `TaskStatusId`, `SpecificationId`, `AssignedTo`, `Author`) VALUES (2, 'write FURPS', 'write furps at state of the art', '20.09.2020', '27.09.2020', 5, 2, 3, 2);
INSERT INTO `boar`.`Task` (`TaskId`, `name`, `text`, `datetime`, `deadline`, `TaskStatusId`, `SpecificationId`, `AssignedTo`, `Author`) VALUES (3, 'make business use cases', 'write use cases for all the actors', '20.09.2020', '30.09.2020', 5, 4, 6, 2);
INSERT INTO `boar`.`Task` (`TaskId`, `name`, `text`, `datetime`, `deadline`, `TaskStatusId`, `SpecificationId`, `AssignedTo`, `Author`) VALUES (4, 'make use cases diagram', 'draw use cases diagram and add it to the project', '15.10.2020', '29.10.2020', 5, 5, 5, 2);
INSERT INTO `boar`.`Task` (`TaskId`, `name`, `text`, `datetime`, `deadline`, `TaskStatusId`, `SpecificationId`, `AssignedTo`, `Author`) VALUES (5, 'make sequence diagrams', 'draw sequence diagrams and add them to the project', '27.11.2020', '03.12.2020', 1, 1, 4, 2);
INSERT INTO `boar`.`Task` (`TaskId`, `name`, `text`, `datetime`, `deadline`, `TaskStatusId`, `SpecificationId`, `AssignedTo`, `Author`) VALUES (6, 'write FURPS', 'write furps at state of the art', '01.10.2020', '07.11.2020', 5, 2, 3, 4);
INSERT INTO `boar`.`Task` (`TaskId`, `name`, `text`, `datetime`, `deadline`, `TaskStatusId`, `SpecificationId`, `AssignedTo`, `Author`) VALUES (7, 'make business use cases', 'write use cases for all the actors', '15.11.2020', '09.11.2020', 5, 3, 4, 4);
INSERT INTO `boar`.`Task` (`TaskId`, `name`, `text`, `datetime`, `deadline`, `TaskStatusId`, `SpecificationId`, `AssignedTo`, `Author`) VALUES (8, 'make sequence diagrams', 'draw sequence diagrams and add them to the project', '04.11.2020', '14.12.2020', 2, 3, 3, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`Artifact`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`Artifact` (`ArtifactId`, `name`, `description`, `link`, `status`) VALUES (1, 'stakeholders-needs', 'in this document described stateholsers needs', 'https://github.com/drewg3r/boar/blob/master/docs/requirements/stakeholders-needs.md', 1);
INSERT INTO `boar`.`Artifact` (`ArtifactId`, `name`, `description`, `link`, `status`) VALUES (2, 'usecase', 'this document contains use case diagrams', 'https://github.com/drewg3r/boar/blob/master/docs/use%20cases/usecase.md', 1);
INSERT INTO `boar`.`Artifact` (`ArtifactId`, `name`, `description`, `link`, `status`) VALUES (3, 'scenarios', 'this document contains scenarios of usadge and sequence diagrams', '', 0);
INSERT INTO `boar`.`Artifact` (`ArtifactId`, `name`, `description`, `link`, `status`) VALUES (4, 'stakeholders-needs', 'in this document described stateholsers needs', 'https://github.com/drewg3r/bear/blob/master/docs/requirements/stakeholders-needs.md', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`ArtifactConnector`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`ArtifactConnector` (`TaskId`, `ArtifactId`) VALUES (3, 1);
INSERT INTO `boar`.`ArtifactConnector` (`TaskId`, `ArtifactId`) VALUES (5, 2);
INSERT INTO `boar`.`ArtifactConnector` (`TaskId`, `ArtifactId`) VALUES (2, 3);
INSERT INTO `boar`.`ArtifactConnector` (`TaskId`, `ArtifactId`) VALUES (4, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`Role`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`Role` (`RoleId`, `Role`) VALUES (1, 'PM');
INSERT INTO `boar`.`Role` (`RoleId`, `Role`) VALUES (2, 'TeamLead');
INSERT INTO `boar`.`Role` (`RoleId`, `Role`) VALUES (3, 'Tester');
INSERT INTO `boar`.`Role` (`RoleId`, `Role`) VALUES (4, 'Developer');
INSERT INTO `boar`.`Role` (`RoleId`, `Role`) VALUES (5, 'Owner');

COMMIT;


-- -----------------------------------------------------
-- Data for table `boar`.`Access`
-- -----------------------------------------------------
START TRANSACTION;
USE `boar`;
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (1, 1, 3);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (1, 2, 2);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (1, 2, 5);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (1, 3, 4);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (1, 4, 4);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (1, 5, 3);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (1, 6, 4);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (2, 4, 1);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (2, 4, 4);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (2, 3, 4);
INSERT INTO `boar`.`Access` (`ProjectId`, `UserId`, `RoleId`) VALUES (3, 6, 1);

COMMIT;


