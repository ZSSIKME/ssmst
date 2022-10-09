/*
 Navicat Premium Data Transfer

 Source Server         : 本地数据库
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:3306
 Source Schema         : bisheku

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 09/10/2022 12:02:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_actggoods
-- ----------------------------
DROP TABLE IF EXISTS `t_actggoods`;
CREATE TABLE `t_actggoods`  (
  `G_id` int(11) NULL DEFAULT NULL,
  `AC_id` int(11) NULL DEFAULT NULL,
  `AL_num` int(11) NOT NULL,
  INDEX `FK_Relationship_5`(`G_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_5` FOREIGN KEY (`G_id`) REFERENCES `t_goods` (`G_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_activity
-- ----------------------------
DROP TABLE IF EXISTS `t_activity`;
CREATE TABLE `t_activity`  (
  `AC_id` int(11) NOT NULL AUTO_INCREMENT,
  `AC_theme` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AC_organize` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AC_undertaker` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AC_people` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AC_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AC_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AC_location` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AC_money` float NOT NULL,
  `AC_remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `AC_state` int(11) NOT NULL,
  PRIMARY KEY (`AC_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_community
-- ----------------------------
DROP TABLE IF EXISTS `t_community`;
CREATE TABLE `t_community`  (
  `C_id` int(11) NOT NULL AUTO_INCREMENT,
  `R_id` int(11) NULL DEFAULT NULL,
  `C_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `C_people` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `C_num` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `C_sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `C_class` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `C_pwd` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `C_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `C_qq` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `C_introduce` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`C_id`) USING BTREE,
  INDEX `FK_Relationship_2`(`R_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_2` FOREIGN KEY (`R_id`) REFERENCES `t_role` (`R_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods`  (
  `G_id` int(11) NOT NULL AUTO_INCREMENT,
  `G_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `G_num` int(11) NOT NULL,
  PRIMARY KEY (`G_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_manager
-- ----------------------------
DROP TABLE IF EXISTS `t_manager`;
CREATE TABLE `t_manager`  (
  `MA_id` int(11) NOT NULL AUTO_INCREMENT,
  `R_id` int(11) NULL DEFAULT NULL,
  `C_id` int(11) NULL DEFAULT NULL,
  `MA_num` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MA_pwd` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MA_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MA_sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MA_class` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MA_position` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MA_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`MA_id`) USING BTREE,
  INDEX `FK_Relationship_9`(`C_id`) USING BTREE,
  INDEX `FK_Relationship_6`(`R_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_6` FOREIGN KEY (`R_id`) REFERENCES `t_role` (`R_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_9` FOREIGN KEY (`C_id`) REFERENCES `t_community` (`C_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_merber
-- ----------------------------
DROP TABLE IF EXISTS `t_merber`;
CREATE TABLE `t_merber`  (
  `M_id` int(11) NOT NULL AUTO_INCREMENT,
  `C_id` int(11) NULL DEFAULT NULL,
  `R_id` int(11) NULL DEFAULT NULL,
  `M_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `M_pwd` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `M_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `M_sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `M_class` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `M_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `M_qq` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`M_id`) USING BTREE,
  INDEX `FK_Relationship_7`(`C_id`) USING BTREE,
  INDEX `FK_Relationship_1`(`R_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_1` FOREIGN KEY (`R_id`) REFERENCES `t_role` (`R_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_7` FOREIGN KEY (`C_id`) REFERENCES `t_community` (`C_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_privilege
-- ----------------------------
DROP TABLE IF EXISTS `t_privilege`;
CREATE TABLE `t_privilege`  (
  `Pri_id` int(11) NOT NULL AUTO_INCREMENT,
  `Pri_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Pri_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `R_id` int(11) NOT NULL AUTO_INCREMENT,
  `Pri_id` int(11) NULL DEFAULT NULL,
  `R_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`R_id`) USING BTREE,
  INDEX `FK_Relationship_3`(`Pri_id`) USING BTREE,
  CONSTRAINT `FK_Relationship_3` FOREIGN KEY (`Pri_id`) REFERENCES `t_privilege` (`Pri_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
