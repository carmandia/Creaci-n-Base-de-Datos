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
-- Table `mydb`.`Corredor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Corredor` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  `Nacionalidad` VARCHAR(45) NULL,
  `Altura` DECIMAL(3) NULL,
  `Peso` INT NULL,
  `Fecha_nacimiento` DATE NULL,
  `Nº_carreras_corridas` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Periodo` (
  `Año_inicio_vinc` INT NOT NULL,
  `Año_fin_vinc` INT NOT NULL,
  PRIMARY KEY (`Año_inicio_vinc`, `Año_fin_vinc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Equipo` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Abreviacion` VARCHAR(45) NULL,
  `Marca_bici` VARCHAR(45) NULL,
  `Nº_puntos_UCI_totales` INT NULL,
  `Nacionalidad` VARCHAR(45) NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Esta_vinculado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Esta_vinculado` (
  `Equipo_Nombre` VARCHAR(45) NULL,
  `Corredor_Id` INT NOT NULL,
  `Periodo_Año_inicio_vinc` INT NULL,
  `Periodo_Año_fin_vinc` INT NULL,
  PRIMARY KEY (`Equipo_Nombre`, `Corredor_Id`, `Periodo_Año_inicio_vinc`, `Periodo_Año_fin_vinc`),
  INDEX `fk_Equipo_has_Corredor_Corredor1_idx` (`Corredor_Id` ASC) ,
  INDEX `fk_Equipo_has_Corredor_Equipo_idx` (`Equipo_Nombre` ASC) ,
  INDEX `fk_Equipo_has_Corredor_Periodo1_idx` (`Periodo_Año_inicio_vinc` ASC, `Periodo_Año_fin_vinc` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pais` (
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Provincia` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Pais_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`),
  INDEX `fk_Provincia_Pais1_idx` (`Pais_Nombre` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Municipio` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Provincia_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`),
  INDEX `fk_Municipio_Provincia1_idx` (`Provincia_Nombre` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cod.Postal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cod.Postal` (
  `Codigo` INT NOT NULL,
  `Municipio_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codigo`),
  INDEX `fk_Cod.Postal_Municipio1_idx` (`Municipio_Nombre` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Carrera` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Pais` VARCHAR(45) NULL,
  `Escala_UCI` VARCHAR(45) NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pasa_por`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pasa_por` (
  `Carrera_Nombre` VARCHAR(45) NOT NULL,
  `Municipio_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Carrera_Nombre`, `Municipio_Nombre`),
  INDEX `fk_Carrera_has_Municipio_Municipio1_idx` (`Municipio_Nombre` ASC) ,
  INDEX `fk_Carrera_has_Municipio_Carrera1_idx` (`Carrera_Nombre` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrera_de_un_dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Carrera_de_un_dia` (
  `Carrera_Nombre` VARCHAR(45) NOT NULL,
  `Distancia_Recorrida` INT NULL,
  PRIMARY KEY (`Carrera_Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrera_por_etapas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Carrera_por_etapas` (
  `Carrera_Nombre` VARCHAR(45) NOT NULL,
  `Distancia_total` INT NULL,
  `nº_etapas` INT NULL,
  PRIMARY KEY (`Carrera_Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Presentacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Presentacion` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Dorsal` VARCHAR(45) NULL,
  `Equipo_Nombre` VARCHAR(45) NOT NULL,
  `Corredor_Id` INT NOT NULL,
  `Carrera_Nombre` VARCHAR(45) NOT NULL,
  `PosicionGen` INT NULL,
  `Ptos_UCI_posicionGen` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Presentacion_Equipo1_idx` (`Equipo_Nombre` ASC) ,
  INDEX `fk_Presentacion_Corredor1_idx` (`Corredor_Id` ASC) ,
  INDEX `fk_Presentacion_Carrera1_idx` (`Carrera_Nombre` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Es`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Es` (
  `Id_lider` INT NOT NULL,
  `Id_gregario` INT NOT NULL,
  PRIMARY KEY (`Id_lider`, `Id_gregario`),
  INDEX `fk_Presentacion_has_Presentacion_Presentacion2_idx` (`Id_gregario` ASC) ,
  INDEX `fk_Presentacion_has_Presentacion_Presentacion1_idx` (`Id_lider` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Etapa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Etapa` (
  `Carrera_nombre` VARCHAR(45) NOT NULL,
  `Distancia` INT NULL,
  `Altimetria` INT NULL,
  `nº_etapa` INT NOT NULL,
  PRIMARY KEY (`Carrera_nombre`, `nº_etapa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Corre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Corre` (
  `Etapa_Carrera_nombre` VARCHAR(45) NULL,
  `Etapa_nº_etapa` INT NULL,
  `Presentacion_Id` INT NOT NULL,
  `PosicionEtp` INT NULL,
  `PtosUCIposicionEtp` INT NULL,
  PRIMARY KEY (`Etapa_Carrera_nombre`, `Etapa_nº_etapa`, `Presentacion_Id`),
  INDEX `fk_Etapa_has_Presentacion_Presentacion1_idx` (`Presentacion_Id` ASC) ,
  INDEX `fk_Etapa_has_Presentacion_Etapa1_idx` (`Etapa_Carrera_nombre` ASC, `Etapa_nº_etapa` ASC) )
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
