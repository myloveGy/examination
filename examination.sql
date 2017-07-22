/*
Navicat MySQL Data Transfer

Source Server         : 我的数据库
Source Server Version : 50636
Source Host           : localhost:3306
Source Database       : examination

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2017-07-22 11:40:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ks_admin
-- ----------------------------
DROP TABLE IF EXISTS `ks_admin`;
CREATE TABLE `ks_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '管理员账号',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱',
  `face` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '管理员头像',
  `role` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user' COMMENT '角色',
  `status` smallint(6) NOT NULL DEFAULT '10' COMMENT '状态',
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '自动登录密钥',
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码哈希值',
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '重新登录哈希值',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `created_id` int(11) NOT NULL COMMENT '创建用户',
  `updated_at` int(11) NOT NULL COMMENT '修改时间',
  `updated_id` int(11) DEFAULT NULL COMMENT '修改用户',
  `last_time` int(11) DEFAULT NULL COMMENT '上一次登录时间',
  `last_ip` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '上一次登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `role` (`role`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='管理员信息表';

-- ----------------------------
-- Records of ks_admin
-- ----------------------------
INSERT INTO `ks_admin` VALUES ('1', 'super', 'Super@admin.com', '/public/uploads/avatars/58fac2c467cb0.jpg', 'administrator', '1', 'gKkLFMdB2pvIXOFNpF_Aeemvdf1j0YUM', '$2y$13$Nuf1mzDRoCMxrWI.rIjENu20QshJG41smdEeHFHxq0qdmS99YytHy', '5vLaPpUS-I-XxJaoGP-GZDk474WdnaK3_1469073015', '1457337222', '1', '1492828871', '1', '1476693446', '127.0.0.1');

-- ----------------------------
-- Table structure for ks_auth_assignment
-- ----------------------------
DROP TABLE IF EXISTS `ks_auth_assignment`;
CREATE TABLE `ks_auth_assignment` (
  `item_name` varchar(64) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  CONSTRAINT `ks_auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `ks_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ks_auth_assignment
-- ----------------------------
INSERT INTO `ks_auth_assignment` VALUES ('admin', '2', '1476087710');
INSERT INTO `ks_auth_assignment` VALUES ('administrator', '1', '1476087700');

-- ----------------------------
-- Table structure for ks_auth_item
-- ----------------------------
DROP TABLE IF EXISTS `ks_auth_item`;
CREATE TABLE `ks_auth_item` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `rule_name` varchar(64) DEFAULT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `ks_auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `ks_auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ks_auth_item
-- ----------------------------
INSERT INTO `ks_auth_item` VALUES ('admin', '1', '管理员', null, null, '1476085137', '1476096200');
INSERT INTO `ks_auth_item` VALUES ('admin/address', '2', '管理员地址信息查询', null, null, '1476093015', '1476093015');
INSERT INTO `ks_auth_item` VALUES ('admin/create', '2', '创建管理员信息', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/delete', '2', '删除管理员信息', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/delete-all', '2', '批量删除管理员信息', null, null, '1476095763', '1476095763');
INSERT INTO `ks_auth_item` VALUES ('admin/editable', '2', '管理员信息行内编辑', null, null, '1476090733', '1476090733');
INSERT INTO `ks_auth_item` VALUES ('admin/index', '2', '显示管理员信息', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/search', '2', '搜索管理员信息', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/update', '2', '修改管理员信息', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/upload', '2', '上传管理员头像信息', null, null, '1476088424', '1476088424');
INSERT INTO `ks_auth_item` VALUES ('admin/view', '2', '查看管理员详情信息', null, null, '1476088536', '1476088536');
INSERT INTO `ks_auth_item` VALUES ('administrator', '1', '超级管理员', null, null, '1476085134', '1476085134');
INSERT INTO `ks_auth_item` VALUES ('answer/create', '2', '创建答案信息', null, null, '1476183355', '1476183355');
INSERT INTO `ks_auth_item` VALUES ('answer/delete', '2', '删除答案信息', null, null, '1476183356', '1476183356');
INSERT INTO `ks_auth_item` VALUES ('answer/export', '2', '导出答案信息', null, null, '1476183356', '1476183356');
INSERT INTO `ks_auth_item` VALUES ('answer/index', '2', '显示答案信息', null, null, '1476183355', '1476183355');
INSERT INTO `ks_auth_item` VALUES ('answer/search', '2', '搜索答案信息', null, null, '1476183355', '1476183355');
INSERT INTO `ks_auth_item` VALUES ('answer/update', '2', '修改答案信息', null, null, '1476183355', '1476183355');
INSERT INTO `ks_auth_item` VALUES ('arrange/create', '2', '创建日程管理', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('arrange/delete', '2', '删除日程管理', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('arrange/delete-all', '2', '批量删除日程信息', null, null, '1476095790', '1476095790');
INSERT INTO `ks_auth_item` VALUES ('arrange/editable', '2', '日程管理行内编辑', null, null, '1476088444', '1476088444');
INSERT INTO `ks_auth_item` VALUES ('arrange/export', '2', '日程信息导出', null, null, '1476090884', '1476090884');
INSERT INTO `ks_auth_item` VALUES ('arrange/index', '2', '显示日程管理', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('arrange/search', '2', '搜索日程管理', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('arrange/update', '2', '修改日程管理', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('authority/create', '2', '创建权限信息', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('authority/delete', '2', '删除权限信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('authority/delete-all', '2', '权限信息删除全部', null, null, '1492830288', '1492830288');
INSERT INTO `ks_auth_item` VALUES ('authority/export', '2', '权限信息导出', null, null, '1476090709', '1476090709');
INSERT INTO `ks_auth_item` VALUES ('authority/index', '2', '显示权限信息', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('authority/search', '2', '搜索权限信息', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('authority/update', '2', '修改权限信息', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('car-type/create', '2', '创建车型配置', null, null, '1492831806', '1492831806');
INSERT INTO `ks_auth_item` VALUES ('car-type/delete', '2', '删除车型配置', null, null, '1492831806', '1492831806');
INSERT INTO `ks_auth_item` VALUES ('car-type/export', '2', '导出车型配置', null, null, '1492831806', '1492831806');
INSERT INTO `ks_auth_item` VALUES ('car-type/index', '2', '车型配置显示', null, null, '1492830329', '1492830329');
INSERT INTO `ks_auth_item` VALUES ('car-type/search', '2', '搜索车型配置', null, null, '1492831805', '1492831805');
INSERT INTO `ks_auth_item` VALUES ('car-type/update', '2', '修改车型配置', null, null, '1492831806', '1492831806');
INSERT INTO `ks_auth_item` VALUES ('car-type/upload', '2', '上传车型配置图标', null, null, '1492870551', '1492870551');
INSERT INTO `ks_auth_item` VALUES ('chapter/create', '2', '创建章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('chapter/delete', '2', '删除章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('chapter/export', '2', '导出章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('chapter/index', '2', '显示章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('chapter/search', '2', '搜索章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('chapter/update', '2', '修改章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('china/create', '2', '创建地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('china/delete', '2', '删除地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('china/index', '2', '显示地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('china/search', '2', '搜索地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('china/update', '2', '修改地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('classification/create', '2', '考试类型-创建数据', null, null, '1500693427', '1500693517');
INSERT INTO `ks_auth_item` VALUES ('classification/delete', '2', '考试类型-删除数据', null, null, '1500693449', '1500693512');
INSERT INTO `ks_auth_item` VALUES ('classification/delete-all', '2', '考试类型-多删除数据', null, null, '1500693717', '1500693717');
INSERT INTO `ks_auth_item` VALUES ('classification/export', '2', '考试类型-导出数据', null, null, '1500693693', '1500693693');
INSERT INTO `ks_auth_item` VALUES ('classification/index', '2', '考试类型-首页显示', null, null, '1500693380', '1500693545');
INSERT INTO `ks_auth_item` VALUES ('classification/search', '2', '考试类型-搜索数据', null, null, '1500693503', '1500693503');
INSERT INTO `ks_auth_item` VALUES ('classification/update', '2', '考试类型-修改数据', null, null, '1500693401', '1500693529');
INSERT INTO `ks_auth_item` VALUES ('menu/create', '2', '创建导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('menu/delete', '2', '删除导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('menu/delete-all', '2', '批量删除导航栏目信息', null, null, '1476095845', '1476095845');
INSERT INTO `ks_auth_item` VALUES ('menu/index', '2', '显示导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('menu/search', '2', '搜索导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('menu/update', '2', '修改导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('module/create', '2', '创建模块生成', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('module/index', '2', '显示模块生成', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('module/produce', '2', '模块生成配置文件', null, null, '1476085133', '1476093990');
INSERT INTO `ks_auth_item` VALUES ('module/update', '2', '修改模块生成', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('question/chapter', '2', '题库信息-查询章节', null, null, '1500692829', '1500692829');
INSERT INTO `ks_auth_item` VALUES ('question/child', '2', '查询问题答案', null, null, '1476454541', '1476454541');
INSERT INTO `ks_auth_item` VALUES ('question/create', '2', '创建题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('question/delete', '2', '删除题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('question/delete-all', '2', '题库信息-多删除', null, null, '1500692685', '1500692842');
INSERT INTO `ks_auth_item` VALUES ('question/export', '2', '导出题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('question/index', '2', '显示题库信息', null, null, '1476175765', '1476175765');
INSERT INTO `ks_auth_item` VALUES ('question/search', '2', '搜索题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('question/subject', '2', '题库信息-查询章节', null, null, '1500692789', '1500692789');
INSERT INTO `ks_auth_item` VALUES ('question/update', '2', '修改题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('question/upload', '2', '上传题目图片', null, null, '1476695636', '1476695646');
INSERT INTO `ks_auth_item` VALUES ('role/create', '2', '创建角色信息', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('role/delete', '2', '删除角色信息', null, null, '1476085134', '1476085134');
INSERT INTO `ks_auth_item` VALUES ('role/edit', '2', '角色分配权限', null, null, '1476096038', '1476096038');
INSERT INTO `ks_auth_item` VALUES ('role/index', '2', '显示角色信息', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('role/search', '2', '搜索角色信息', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('role/update', '2', '修改角色信息', null, null, '1476085134', '1476085134');
INSERT INTO `ks_auth_item` VALUES ('role/view', '2', '角色权限查看', null, null, '1476096101', '1476096101');
INSERT INTO `ks_auth_item` VALUES ('special/create', '2', '创建专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('special/delete', '2', '删除专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('special/export', '2', '导出专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('special/index', '2', '显示专项分类', null, null, '1476172609', '1476172609');
INSERT INTO `ks_auth_item` VALUES ('special/search', '2', '搜索专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('special/update', '2', '修改专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('subject/create', '2', '创建科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('subject/delete', '2', '删除科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('subject/export', '2', '导出科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('subject/index', '2', '显示科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('subject/search', '2', '搜索科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('subject/update', '2', '修改科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('subject/upload', '2', '科目信息-上传图片', null, null, '1500693176', '1500693176');
INSERT INTO `ks_auth_item` VALUES ('user', '1', '普通用户', null, null, '1476085137', '1476085137');
INSERT INTO `ks_auth_item` VALUES ('user/create', '2', '创建用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('user/delete', '2', '删除用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('user/delete-all', '2', '批量删除用户信息', null, null, '1476096229', '1476096229');
INSERT INTO `ks_auth_item` VALUES ('user/export', '2', '导出用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('user/index', '2', '显示用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('user/search', '2', '搜索用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('user/update', '2', '修改用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('user/upload', '2', '上传用户头像信息', null, null, '1476149415', '1476149415');

-- ----------------------------
-- Table structure for ks_auth_item_child
-- ----------------------------
DROP TABLE IF EXISTS `ks_auth_item_child`;
CREATE TABLE `ks_auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `ks_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `ks_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ks_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `ks_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ks_auth_item_child
-- ----------------------------
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/address');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/address');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/delete');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/editable');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/editable');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/upload');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/upload');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/view');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/view');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'answer/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'answer/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'answer/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'answer/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'answer/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'answer/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'arrange/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'arrange/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'arrange/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'arrange/delete');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'arrange/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'arrange/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'arrange/editable');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'arrange/editable');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'arrange/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'arrange/export');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'arrange/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'arrange/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'arrange/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'arrange/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'arrange/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'arrange/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'authority/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'authority/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'authority/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'authority/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'authority/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'authority/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'authority/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'car-type/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'car-type/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'car-type/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'car-type/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'car-type/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'car-type/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'car-type/upload');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'chapter/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'chapter/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'chapter/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'chapter/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'chapter/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'chapter/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'china/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'china/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'china/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'china/delete');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'china/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'china/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'china/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'china/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'china/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'china/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'classification/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'classification/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'classification/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'classification/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'classification/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'classification/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'classification/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'menu/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'menu/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'menu/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'menu/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'menu/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'menu/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'module/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'module/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'module/produce');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'module/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/chapter');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/child');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/subject');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'question/upload');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'role/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'role/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'role/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'role/delete');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'role/edit');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'role/edit');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'role/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'role/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'role/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'role/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'role/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'role/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'role/view');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'role/view');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'special/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'special/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'special/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'special/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'special/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'special/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'subject/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'subject/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'subject/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'subject/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'subject/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'subject/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'subject/upload');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'user/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'user/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'user/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'user/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'user/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'user/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'user/export');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'user/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'user/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'user/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'user/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'user/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'user/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'user/upload');

-- ----------------------------
-- Table structure for ks_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `ks_auth_rule`;
CREATE TABLE `ks_auth_rule` (
  `name` varchar(64) NOT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ks_auth_rule
-- ----------------------------

-- ----------------------------
-- Table structure for ks_car_type
-- ----------------------------
DROP TABLE IF EXISTS `ks_car_type`;
CREATE TABLE `ks_car_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `desc` varchar(255) NOT NULL COMMENT '说明',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 状态(1 开启 0 关闭)',
  `sort` tinyint(2) unsigned NOT NULL DEFAULT '100' COMMENT '排序',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '使用图片',
  `created_at` int(11) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='车型配置表';

-- ----------------------------
-- Records of ks_car_type
-- ----------------------------
INSERT INTO `ks_car_type` VALUES ('1', '小车', '小车车型. 适用车型：C1/C2照', '1', '1', '/public/car-type/58fc0f59dd3a5.png', '1492832231');
INSERT INTO `ks_car_type` VALUES ('2', '大车', '大车车型', '1', '2', '/public/car-type/58fc0b7ab557a.png', '1492832259');
INSERT INTO `ks_car_type` VALUES ('3', '客车', '客车车型', '1', '3', '/public/car-type/58fc0ab02cfe1.png', '1492832449');
INSERT INTO `ks_car_type` VALUES ('4', '摩托车', '测试摩托车', '1', '4', '/public/car-type/58fc0bb14ef73.png', '1492913077');

-- ----------------------------
-- Table structure for ks_chapter
-- ----------------------------
DROP TABLE IF EXISTS `ks_chapter`;
CREATE TABLE `ks_chapter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '章节分类ID',
  `name` varchar(255) NOT NULL COMMENT '章节分类名称',
  `sort` smallint(6) NOT NULL DEFAULT '100' COMMENT '排序',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `subject_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属科目',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='章节分类信息表';

-- ----------------------------
-- Records of ks_chapter
-- ----------------------------
INSERT INTO `ks_chapter` VALUES ('1', '第一章 道路交通安全法律、法规和规章', '1', '1476172331', '1493087023', '1');
INSERT INTO `ks_chapter` VALUES ('2', '第二章 交通信号', '2', '1476172350', '1493087099', '1');
INSERT INTO `ks_chapter` VALUES ('3', '第三章 安全行车、文明驾驶基础知识', '3', '1476172371', '1493087105', '2');
INSERT INTO `ks_chapter` VALUES ('4', '第四章 机动车驾驶操作相关基础知识', '4', '1476172399', '1493087111', '2');

-- ----------------------------
-- Table structure for ks_menu
-- ----------------------------
DROP TABLE IF EXISTS `ks_menu`;
CREATE TABLE `ks_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '栏目ID',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父类ID(只支持两级分类)',
  `menu_name` varchar(50) NOT NULL COMMENT '栏目名称',
  `icons` varchar(50) NOT NULL DEFAULT 'icon-desktop' COMMENT '使用的icons',
  `url` varchar(50) DEFAULT 'site/index' COMMENT '访问的地址',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（1启用 0 停用）',
  `sort` int(4) NOT NULL DEFAULT '100' COMMENT '排序字段',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `created_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建用户',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `updated_id` int(11) NOT NULL DEFAULT '0' COMMENT '修改用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='导航栏信息表';

-- ----------------------------
-- Records of ks_menu
-- ----------------------------
INSERT INTO `ks_menu` VALUES ('1', '0', '后台管理', 'menu-icon fa fa-cog', '', '1', '2', '1468985587', '1', '1474340768', '1');
INSERT INTO `ks_menu` VALUES ('2', '1', '导航栏目', '', 'menu/index', '1', '4', '1468987221', '1', '1468994846', '1');
INSERT INTO `ks_menu` VALUES ('3', '1', '模块生成', '', 'module/index', '1', '5', '1468994283', '1', '1468994860', '1');
INSERT INTO `ks_menu` VALUES ('4', '1', '角色管理', '', 'role/index', '1', '2', '1468994665', '1', '1468994676', '1');
INSERT INTO `ks_menu` VALUES ('5', '1', '管理员信息', '', 'admin/index', '1', '2', '1468994769', '1', '1474340722', '1');
INSERT INTO `ks_menu` VALUES ('6', '1', '权限管理', '', 'authority/index', '1', '3', '1468994819', '1', '1469410899', '1');
INSERT INTO `ks_menu` VALUES ('9', '0', '用户信息', 'menu fa fa-user', 'user/index', '1', '5', '1476095210', '1', '1476176242', '1');
INSERT INTO `ks_menu` VALUES ('10', '14', '科目信息', 'icon-cog', 'subject/index', '1', '104', '1476171766', '1', '1476176338', '1');
INSERT INTO `ks_menu` VALUES ('11', '14', '章节信息', 'icon-cog', 'chapter/index', '1', '103', '1476172059', '1', '1476176326', '1');
INSERT INTO `ks_menu` VALUES ('12', '14', '专项分类', 'icon-cog', 'special/index', '1', '102', '1476172610', '1', '1476177469', '1');
INSERT INTO `ks_menu` VALUES ('13', '14', '题库信息', 'icon-cog', 'question/index', '1', '101', '1476175766', '1', '1476176304', '1');
INSERT INTO `ks_menu` VALUES ('14', '0', '题库管理', 'menu-icons fa fa-graduation-cap', '', '1', '6', '1476176095', '1', '1476176095', '1');
INSERT INTO `ks_menu` VALUES ('15', '0', '考试类型', 'menu-icon fa-asterisk', 'classification/index', '1', '100', '1492829715', '1', '1500693629', '1');

-- ----------------------------
-- Table structure for ks_question
-- ----------------------------
DROP TABLE IF EXISTS `ks_question`;
CREATE TABLE `ks_question` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '题目ID',
  `question_title` text NOT NULL COMMENT '题目问题',
  `question_content` text COMMENT '题目说明',
  `question_img` varchar(255) DEFAULT NULL COMMENT '问题图片',
  `answer_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '答案类型(1 单选 2 判断 3 多选 )',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态(1 启用 0 停用)',
  `answer_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '正确答案ID',
  `answers` text COMMENT '问题信息',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `subject_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属科目ID',
  `chapter_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属章节',
  `special_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '专项ID',
  `error_number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '错误人数',
  `do_number` int(11) NOT NULL DEFAULT '0' COMMENT '做了该题目人数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1318 DEFAULT CHARSET=utf8 COMMENT='题库信息表';

-- ----------------------------
-- Records of ks_question
-- ----------------------------
INSERT INTO `ks_question` VALUES ('1', '对违法驾驶发生重大交通事故且构成犯罪的，不追究其刑事责任。', '《道路交通安全法》第一百零一条：违反道路交通安全法律、法规的规定，发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证。', '', '4', '1', '0', '[\"就是测试数据呢\"]', '1476513045', '1500693902', '1', '1', '3', '0', '4');
INSERT INTO `ks_question` VALUES ('2', '造成交通事故后逃逸且构成犯罪的驾驶人，将吊销驾驶证且终生不得重新取得驾驶证。', '《道路交通安全法》第一百零一条：违反道路交通安全法律、法规的规定，发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证。造成交通事故后逃逸的，由公安机关交通管理部门吊销机动车驾驶证，且终生不得重新取得机动车驾驶证。', '', '3', '1', '[0,1,2]', '[\"A.123\",\"B.456\",\"C.789\",\"D.100\"]', '1476513046', '1500693935', '1', '1', '3', '0', '4');
INSERT INTO `ks_question` VALUES ('3', '驾驶机动车在道路上违反交通安全法规的行为属于违法行为。', '“违反道路交通安全法”，违反法律法规即为违法行为。官方已无违章/违规的说法。', '', '2', '1', '0', '[\"A.正确\",\"B.错误\"]', '1476513048', '1500693938', '1', '1', '3', '1', '4');
INSERT INTO `ks_question` VALUES ('4', '驾驶机动车应当随身携带哪种证件？', '《道路交通安全法》第十一条：驾驶机动车上道路行驶，应当悬挂机动车号牌，放置检验合格标志、保险标志，并随车携带机动车行驶证。', '', '1', '1', '0', '[\"A.我的测试数据1\",\"B.还是测试数据2\",\"C.就是测试数据3\",\"D.就是的测试数据4\"]', '1476513049', '1500693939', '1', '1', '3', '0', '3');

-- ----------------------------
-- Table structure for ks_special
-- ----------------------------
DROP TABLE IF EXISTS `ks_special`;
CREATE TABLE `ks_special` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属科目',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父类ID',
  `name` varchar(255) NOT NULL COMMENT '专项分类名称',
  `sort` smallint(4) NOT NULL DEFAULT '100' COMMENT '排序',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='专项分类信息';

-- ----------------------------
-- Records of ks_special
-- ----------------------------
INSERT INTO `ks_special` VALUES ('1', '0', '0', '按知识点类型', '2', '1476173388', '1476174821');
INSERT INTO `ks_special` VALUES ('2', '0', '0', '按内容类型', '1', '1476174815', '1476174815');
INSERT INTO `ks_special` VALUES ('3', '0', '2', '文字题', '1', '1476174894', '1476179981');
INSERT INTO `ks_special` VALUES ('4', '0', '2', '图片题', '2', '1476174917', '1476174917');
INSERT INTO `ks_special` VALUES ('5', '0', '1', '时间题', '1', '1476174958', '1476175078');
INSERT INTO `ks_special` VALUES ('6', '0', '1', '速度题', '2', '1476174996', '1476175072');
INSERT INTO `ks_special` VALUES ('7', '0', '1', '距离题', '3', '1476175066', '1476175253');
INSERT INTO `ks_special` VALUES ('8', '0', '0', '按答案类型', '3', '1476175277', '1476175277');
INSERT INTO `ks_special` VALUES ('9', '0', '8', '正确题', '100', '1476175293', '1476175293');
INSERT INTO `ks_special` VALUES ('10', '0', '2', '难题', '100', '1476519608', '1476519608');

-- ----------------------------
-- Table structure for ks_subject
-- ----------------------------
DROP TABLE IF EXISTS `ks_subject`;
CREATE TABLE `ks_subject` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '科目ID',
  `car_id` smallint(4) unsigned NOT NULL COMMENT '车型ID ',
  `name` varchar(255) NOT NULL COMMENT '科目分类信息',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片信息',
  `config` text NOT NULL COMMENT '配置信息',
  `desc` text NOT NULL COMMENT '说明信息',
  `sort` tinyint(2) unsigned NOT NULL DEFAULT '100' COMMENT '排序',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态 (1 开启 0 关闭)',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='科目信息表(主分类)';

-- ----------------------------
-- Records of ks_subject
-- ----------------------------
INSERT INTO `ks_subject` VALUES ('1', '1', '科目一', '/public/subject/5972c2ff41080.jpg', '{\"passingScore\":\"72\",\"time\":\"60\",\"judgmentNumber\":\"10\",\"selectNumber\":\"40\",\"multipleNumber\":\"30\",\"shortNumber\":\"5\",\"judgmentScore\":\"2\",\"selectScore\":\"2\",\"multipleScore\":\"3\",\"shortScore\":\"5\"}', '科目一，又称科目一理论考试、驾驶员理论考试，是机动车驾驶证考核的一部分 。根据《机动车驾驶证申领和使用规定》，考 试内容包括驾车理论基础、道路安全法律法规、地方性法规等相关知识。考试形式为上机考试，100道题，90分及以上过关。', '1', '1', '1492835463');
INSERT INTO `ks_subject` VALUES ('2', '1', '科目四', '/public/subject/5972c2bdbfc69.jpg', '{\"passingScore\":\"72\",\"time\":\"60\",\"judgmentNumber\":\"10\",\"selectNumber\":\"40\",\"multipleNumber\":\"30\",\"shortNumber\":\"5\",\"judgmentScore\":\"2\",\"selectScore\":\"2\",\"multipleScore\":\"3\",\"shortScore\":\"5\"}', '科目四，又称科目四理论考试、驾驶员理论考试，是机动车驾驶证考核的一部分。公安部123号令实施后，科目三考试分为两项内容，除了路考，增加了安全文明驾驶考试，俗称“科目四”，考量“车德”。因为这个考试在科目三之后进行，所以大家都习惯称之为科目四考试。实际的官方说法中没有科目四一说。', '2', '1', '1492835656');

-- ----------------------------
-- Table structure for ks_user
-- ----------------------------
DROP TABLE IF EXISTS `ks_user`;
CREATE TABLE `ks_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名称',
  `phone` char(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '用户手机号',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱',
  `face` varchar(100) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '用户头像',
  `status` smallint(6) NOT NULL DEFAULT '10' COMMENT '状态',
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '自动登录密钥',
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码哈希值',
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '重新登录哈希值',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '修改时间',
  `last_time` int(11) DEFAULT NULL COMMENT '上一次登录时间',
  `last_ip` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '上一次登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`) USING BTREE COMMENT '用户手机号必须唯一',
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ks_user
-- ----------------------------
INSERT INTO `ks_user` VALUES ('1', 'loveme', '13020137932', '821901008@qq.com', '/public/user/58fb642b13cfa.jpg', '10', 'll3AyfUr4eQc1NFA11ySymQAxTAqrtm_', '$2y$13$11FYya1X0DH3DY5hkQ4XJOVUZn9tQv10Y9PleJMR4qFdmZaFWdVRW', 'FEiOk34tr5BcljPcEy085aM15b8R2054_1492860239', '1476149273', '1492870190', '1492863996', '127.0.0.1');

-- ----------------------------
-- Table structure for ks_user_collect
-- ----------------------------
DROP TABLE IF EXISTS `ks_user_collect`;
CREATE TABLE `ks_user_collect` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户ID',
  `qids` text,
  `subject_id` int(11) NOT NULL,
  UNIQUE KEY `uniqid` (`user_id`,`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏记录表';

-- ----------------------------
-- Records of ks_user_collect
-- ----------------------------
INSERT INTO `ks_user_collect` VALUES ('1', '[6,7,29,4,1,3]', '1');
INSERT INTO `ks_user_collect` VALUES ('4', '[]', '1');
