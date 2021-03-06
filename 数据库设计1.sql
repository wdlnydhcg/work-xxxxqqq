-- MySQL Script generated by MySQL Workbench
-- Mon Apr 27 09:31:40 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`truck_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`truck_inventory` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL COMMENT '时间',
  `inventory` INT NOT NULL COMMENT '库存件数',
  `code` VARCHAR(50) NOT NULL COMMENT '车辆型号代码',
  `online` INT NULL COMMENT '上线车辆',
  `offline` INT NULL COMMENT '当日下线车辆',
  `delivery` INT NULL COMMENT '当日交车数量',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '按日期与车型分的库存总表';


-- -----------------------------------------------------
-- Table `mydb`.`inven_temp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inven_temp` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(50) NOT NULL COMMENT '车型id',
  `datetime` DATETIME NOT NULL,
  `status` TINYINT(4) NOT NULL COMMENT '具体操作，0为上线，1为下线，2为入库，3为交车',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '车辆库存计算中间表';


-- -----------------------------------------------------
-- Table `mydb`.`truck_statement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`truck_statement` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(50) NOT NULL,
  `vin` VARCHAR(45) NOT NULL,
  `online_time` DATETIME NULL COMMENT '上线时间',
  `offline_time` DATETIME NULL COMMENT '下线时间',
  `status` TINYINT(4) NOT NULL COMMENT '当前状态 0未上线 1已上线 2已下线 3已入库 4已交车',
  `order_id` VARCHAR(45) NOT NULL COMMENT '订单号',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '车辆报表';


-- -----------------------------------------------------
-- Table `mydb`.`mes_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mes_order` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `deptid` VARCHAR(10) NOT NULL COMMENT '工厂编码',
  `deptname` VARCHAR(100) NOT NULL COMMENT '工厂名称',
  `workorderid` VARCHAR(20) NOT NULL COMMENT '生产订单号',
  `serialNo` VARCHAR(10) NOT NULL COMMENT '顺序号',
  `materialld` VARCHAR(30) NOT NULL COMMENT '订单物料编码',
  `vin` VARCHAR(50) NOT NULL COMMENT 'vin',
  `orderSerial` VARCHAR(50) NOT NULL COMMENT '车号/机号',
  `workNum` INT NOT NULL COMMENT '订单计划数量',
  `orderType` VARCHAR(10) NOT NULL COMMENT '订单类型',
  `planBeginTime` DATETIME NOT NULL COMMENT '订单计划上线时间',
  `planEndTime` DATETIME NOT NULL COMMENT '订单计划结束时间',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'mes订单报工自动推送消息抬头信息';


-- -----------------------------------------------------
-- Table `mydb`.`mes_order_seq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mes_order_seq` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `workSeqNo` VARCHAR(10) NOT NULL COMMENT '工序号',
  `workSeqName` VARCHAR(50) NOT NULL COMMENT '工序名称',
  `workNum` INT NOT NULL COMMENT '报工数量-合格',
  `invalidNum` INT NOT NULL COMMENT '报工数量-不合格',
  `beginTime` DATETIME NOT NULL COMMENT '工序开始时间',
  `completeTime` DATETIME NOT NULL COMMENT '工序结束时间',
  `planBeginTime` DATETIME NOT NULL COMMENT '工序计划开始时间',
  `planCompleteTime` DATETIME NOT NULL COMMENT '工序计划结束时间',
  `ctrlNo` VARCHAR(10) NOT NULL COMMENT '工序控制码',
  `userId` VARCHAR(10) NOT NULL COMMENT '报工人工号',
  `userName` VARCHAR(20) NOT NULL COMMENT '报工人姓名',
  `workStaionNo` VARCHAR(20) NULL COMMENT '工作中心编码',
  `workStationName` VARCHAR(100) NULL COMMENT '工作重心名称',
  `vin` VARCHAR(45) NOT NULL COMMENT 'vin码',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '订单工序报工记录';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
