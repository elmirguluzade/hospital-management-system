-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8 ;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `hospital`.`medical_speciality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`medical_speciality` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`doctor` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`doctor_id`, `department_id`),
  INDEX `fk_doctor_medical_speciality1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_medical_speciality1`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital`.`medical_speciality` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`nurse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`nurse` (
  `nurse_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`nurse_id`, `department_id`),
  INDEX `fk_nurse_medical_speciality_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_nurse_medical_speciality`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital`.`medical_speciality` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`patient` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `social_security_number` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `blood_type` VARCHAR(45) NOT NULL,
  `height` VARCHAR(45) NOT NULL,
  `weight` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`patient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`inpatient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`inpatient` (
  `room` VARCHAR(45) NOT NULL,
  `admission_date` VARCHAR(45) NOT NULL,
  `discharge_date` VARCHAR(45) NOT NULL,
  `patient_id` INT NOT NULL,
  INDEX `fk_inpatient_patient1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_inpatient_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`reservation` (
  `reserv_num` INT NOT NULL AUTO_INCREMENT,
  `reserv_date` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`reserv_num`, `department_id`, `patient_id`),
  INDEX `fk_reservation_medical_speciality1_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_reservation_patient1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_reservation_medical_speciality1`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital`.`medical_speciality` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`examination`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`examination` (
  `examination_details` VARCHAR(45) NOT NULL,
  `examination_date` VARCHAR(45) NOT NULL,
  `doctor_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  INDEX `fk_examination_doctor1_idx` (`doctor_id` ASC) VISIBLE,
  INDEX `fk_examination_patient1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_examination_doctor1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `hospital`.`doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_examination_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`treatment` (
  `treatment_date` VARCHAR(45) NOT NULL,
  `treatment_details` VARCHAR(45) NOT NULL,
  `nurse_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  INDEX `fk_treatment_nurse1_idx` (`nurse_id` ASC) VISIBLE,
  INDEX `fk_treatment_patient1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_treatment_nurse1`
    FOREIGN KEY (`nurse_id`)
    REFERENCES `hospital`.`nurse` (`nurse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_treatment_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`nurse_has_patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`nurse_has_patient` (
  `nurse_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`nurse_id`, `patient_id`),
  INDEX `fk_nurse_has_patient_patient1_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_nurse_has_patient_nurse1_idx` (`nurse_id` ASC) VISIBLE,
  CONSTRAINT `fk_nurse_has_patient_nurse1`
    FOREIGN KEY (`nurse_id`)
    REFERENCES `hospital`.`nurse` (`nurse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nurse_has_patient_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`patient_has_doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`patient_has_doctor` (
  `patient_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  PRIMARY KEY (`patient_id`, `doctor_id`),
  INDEX `fk_patient_has_doctor_doctor1_idx` (`doctor_id` ASC) VISIBLE,
  INDEX `fk_patient_has_doctor_patient1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_has_doctor_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_has_doctor_doctor1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `hospital`.`doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
