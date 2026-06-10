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
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mesa` (
  `id_mesa` INT NOT NULL AUTO_INCREMENT,
  `nro_mesa` INT NOT NULL,
  `capacidad` INT NOT NULL,
  PRIMARY KEY (`id_mesa`))
ENGINE = InnoDB;

ALTER TABLE mesa
ADD COLUMN activo BOOLEAN NOT NULL DEFAULT TRUE;


-- -----------------------------------------------------
-- Table `mydb`.`mozo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mozo` (
  `id_mozo` INT NOT NULL AUTO_INCREMENT,
  `dni` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_mozo`))
ENGINE = InnoDB;

ALTER TABLE mozo
ADD COLUMN activo BOOLEAN NOT NULL DEFAULT TRUE;

-- -----------------------------------------------------
-- Table `mydb`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `categoria_id_categoria` INT NOT NULL,
  `nombre_producto` VARCHAR(100) NOT NULL,
  `precio_actual` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `fk_producto_categoria_idx` (`categoria_id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoria`
    FOREIGN KEY (`categoria_id_categoria`)
    REFERENCES `mydb`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE Producto
ADD COLUMN activo BOOLEAN NOT NULL DEFAULT TRUE;

-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `mesa_id_mesa` INT NULL,
  `mozo_id_mozo` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `estado` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedido_mesa1_idx` (`mesa_id_mesa` ASC) VISIBLE,
  INDEX `fk_pedido_mozo1_idx` (`mozo_id_mozo` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_mesa1`
    FOREIGN KEY (`mesa_id_mesa`)
    REFERENCES `mydb`.`mesa` (`id_mesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_mozo1`
    FOREIGN KEY (`mozo_id_mozo`)
    REFERENCES `mydb`.`mozo` (`id_mozo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`detalle_pedido` (
  `producto_id_producto` INT NOT NULL,
  `pedido_id_pedido` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`producto_id_producto`, `pedido_id_pedido`),
  INDEX `fk_detalle_pedido_pedido1_idx` (`pedido_id_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_pedido_producto1`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `mydb`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_pedido_pedido1`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES `mydb`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
