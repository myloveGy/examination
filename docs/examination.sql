SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ks_admin
-- ----------------------------
DROP TABLE IF EXISTS `ks_admin`;
CREATE TABLE `ks_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '管理员账号',
  `email` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '管理员邮箱',
  `face` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员头像',
  `role` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员角色',
  `status` tinyint(1) NOT NULL DEFAULT '10' COMMENT '状态',
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_time` int(11) NOT NULL DEFAULT '0' COMMENT '上一次登录时间',
  `last_ip` char(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '上一次登录的IP',
  `address` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '地址信息',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `created_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建用户',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `updated_id` int(11) NOT NULL DEFAULT '0' COMMENT '修改用户',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='管理员信息表';

-- ----------------------------
-- Records of ks_admin
-- ----------------------------
BEGIN;
INSERT INTO `ks_admin` VALUES (1, 'super', 'super@admin.com', '', 'admin', 10, 'tGaaJtNH3SXtUEJtA6LIgNb0LQPEjste', '$2y$13$YxX4lUa.8Ju25k4voR1e0ugjV3riwouxczPr/xPbaCG5TT8gTkpOW', 'Coq2MudT_KvDZrYtli2pepgGNEEDsN9W_1529078268', 1528029973, '127.0.0.1', '湖南省,岳阳市,岳阳县', 1526831872, 1, 1542254258, 1);
INSERT INTO `ks_admin` VALUES (2, 'admin', 'admin@admin.com', '', 'admin', 10, 'VWAHqZZOgjZuAovIMmH7gbiBpX76CLS0', '$2y$13$VVNMg4gYETT0YHIJI5VSNOE4O105eKXCA7EIMzyV2KMyUUTx6u7N2', 'GxH7TNQ9kRJAC2JuSGclMQnk0TYvZ2hw_1529078253', 1526831872, '127.0.0.1', '湖南省,岳阳市,岳阳县', 1526831872, 1, 1529078253, 1);
COMMIT;

-- ----------------------------
-- Table structure for ks_admin_operate_logs
-- ----------------------------
DROP TABLE IF EXISTS `ks_admin_operate_logs`;
CREATE TABLE `ks_admin_operate_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作管理员ID',
  `admin_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '操作管理员名称',
  `action` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '方法',
  `index` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '数据标识',
  `request` text COLLATE utf8_unicode_ci NOT NULL COMMENT '请求参数',
  `response` text COLLATE utf8_unicode_ci NOT NULL COMMENT '响应数据',
  `ip` char(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '请求IP',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `admin_name` (`admin_name`) USING BTREE COMMENT '管理员'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='管理员操作日志记录信息表';

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
BEGIN;
INSERT INTO `ks_auth_assignment` VALUES ('admin', '2', 1476087710);
INSERT INTO `ks_auth_assignment` VALUES ('administrator', '1', 1476087700);
COMMIT;

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
  KEY `rule_name` (`rule_name`) USING BTREE,
  KEY `idx-auth_item-type` (`type`) USING BTREE,
  CONSTRAINT `ks_auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `ks_auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ks_auth_item
-- ----------------------------
BEGIN;
INSERT INTO `ks_auth_item` VALUES ('admin', 1, '管理员', NULL, NULL, 1476085137, 1476096200);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/create', 2, '操作日志-添加数据', NULL, NULL, 1529080458, 1529080458);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/delete', 2, '操作日志-删除数据', NULL, NULL, 1529080459, 1529080459);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/delete-all', 2, '操作日志-批量删除', NULL, NULL, 1529080459, 1529080459);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/export', 2, '操作日志-导出数据', NULL, NULL, 1529080459, 1529080459);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/index', 2, '操作日志-显示数据', NULL, NULL, 1529080458, 1529080458);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/search', 2, '操作日志-搜索数据', NULL, NULL, 1529080458, 1529080458);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/update', 2, '操作日志-修改数据', NULL, NULL, 1529080459, 1529080459);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/address', 2, '管理员地址信息查询', NULL, NULL, 1476093015, 1476093015);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/create', 2, '创建管理员信息', NULL, NULL, 1476085130, 1476085130);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/delete', 2, '删除管理员信息', 'admin-delete', NULL, 1476085130, 1529081073);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/delete-all', 2, '批量删除管理员信息', NULL, NULL, 1476095763, 1476095763);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/editable', 2, '管理员信息行内编辑', NULL, NULL, 1476090733, 1476090733);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/index', 2, '显示管理员信息', NULL, NULL, 1476085130, 1476085130);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/search', 2, '搜索管理员信息', NULL, NULL, 1476085130, 1476085130);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/update', 2, '修改管理员信息', 'admin', NULL, 1476085130, 1529081037);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/upload', 2, '上传管理员头像信息', NULL, NULL, 1476088424, 1476088424);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/create', 2, '角色分配-添加数据', NULL, NULL, 1529080404, 1529080404);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/delete', 2, '角色分配-删除数据', 'auth-assignment', NULL, 1529080404, 1529081128);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/delete-all', 2, '角色分配-批量删除', NULL, NULL, 1529080405, 1529080405);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/export', 2, '角色分配-导出数据', NULL, NULL, 1529080405, 1529080405);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/index', 2, '角色分配-显示数据', NULL, NULL, 1529080403, 1529080403);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/search', 2, '角色分配-搜索数据', NULL, NULL, 1529080403, 1529080403);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/update', 2, '角色分配-修改数据', NULL, NULL, 1529080404, 1529080404);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/create', 2, '规则管理-添加数据', NULL, NULL, 1529080726, 1529080726);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/delete', 2, '规则管理-删除数据', NULL, NULL, 1529080727, 1529080727);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/delete-all', 2, '规则管理-批量删除', NULL, NULL, 1529080727, 1529080727);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/export', 2, '规则管理-导出数据', NULL, NULL, 1529080727, 1529080727);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/index', 2, '规则管理-显示数据', NULL, NULL, 1529080726, 1529080726);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/search', 2, '规则管理-搜索数据', NULL, NULL, 1529080726, 1529080726);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/update', 2, '规则管理-修改数据', NULL, NULL, 1529080726, 1529080726);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/create', 2, '创建权限信息', NULL, NULL, 1476085131, 1476085131);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/delete', 2, '删除权限信息', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/delete-all', 2, '权限信息删除全部', NULL, NULL, 1492830288, 1492830288);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/export', 2, '权限信息导出', NULL, NULL, 1476090709, 1476090709);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/index', 2, '显示权限信息', NULL, NULL, 1476085131, 1476085131);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/search', 2, '搜索权限信息', NULL, NULL, 1476085131, 1476085131);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/update', 2, '修改权限信息', NULL, NULL, 1476085131, 1476085131);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/create', 2, '创建导航栏目', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/delete', 2, '删除导航栏目', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/delete-all', 2, '批量删除导航栏目信息', NULL, NULL, 1476095845, 1476095845);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/index', 2, '显示导航栏目', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/search', 2, '搜索导航栏目', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/update', 2, '修改导航栏目', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/module/create', 2, '创建模块生成', NULL, NULL, 1476085133, 1476085133);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/module/index', 2, '显示模块生成', NULL, NULL, 1476085133, 1476085133);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/module/produce', 2, '模块生成配置文件', NULL, NULL, 1476085133, 1476093990);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/module/update', 2, '修改模块生成', NULL, NULL, 1476085133, 1476085133);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/create', 2, '创建角色信息', NULL, NULL, 1476085133, 1476085133);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/delete', 2, '删除角色信息', NULL, NULL, 1476085134, 1476085134);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/edit', 2, '角色分配权限', NULL, NULL, 1476096038, 1476096038);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/index', 2, '显示角色信息', NULL, NULL, 1476085133, 1476085133);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/search', 2, '搜索角色信息', NULL, NULL, 1476085133, 1476085133);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/update', 2, '修改角色信息', NULL, NULL, 1476085134, 1476085134);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/view', 2, '角色权限查看', NULL, NULL, 1476096101, 1476096101);
INSERT INTO `ks_auth_item` VALUES ('admin/admin/view', 2, '查看管理员详情信息', NULL, NULL, 1476088536, 1476088536);
INSERT INTO `ks_auth_item` VALUES ('admin/answer/create', 2, '创建答案信息', NULL, NULL, 1476183355, 1476183355);
INSERT INTO `ks_auth_item` VALUES ('admin/answer/delete', 2, '删除答案信息', NULL, NULL, 1476183356, 1476183356);
INSERT INTO `ks_auth_item` VALUES ('admin/answer/export', 2, '导出答案信息', NULL, NULL, 1476183356, 1476183356);
INSERT INTO `ks_auth_item` VALUES ('admin/answer/index', 2, '显示答案信息', NULL, NULL, 1476183355, 1476183355);
INSERT INTO `ks_auth_item` VALUES ('admin/answer/search', 2, '搜索答案信息', NULL, NULL, 1476183355, 1476183355);
INSERT INTO `ks_auth_item` VALUES ('admin/answer/update', 2, '修改答案信息', NULL, NULL, 1476183355, 1476183355);
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/create', 2, '创建日程管理', NULL, NULL, 1476085131, 1476085131);
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/delete', 2, '删除日程管理', NULL, NULL, 1476085131, 1476085131);
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/delete-all', 2, '批量删除日程信息', NULL, NULL, 1476095790, 1476095790);
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/editable', 2, '日程管理行内编辑', NULL, NULL, 1476088444, 1476088444);
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/export', 2, '日程信息导出', NULL, NULL, 1476090884, 1476090884);
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/index', 2, '显示日程管理', NULL, NULL, 1476085130, 1476085130);
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/search', 2, '搜索日程管理', NULL, NULL, 1476085130, 1476085130);
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/update', 2, '修改日程管理', NULL, NULL, 1476085131, 1476085131);
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/create', 2, '创建章节信息', NULL, NULL, 1476172059, 1476172059);
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/delete', 2, '删除章节信息', NULL, NULL, 1476172059, 1476172059);
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/export', 2, '导出章节信息', NULL, NULL, 1476172059, 1476172059);
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/index', 2, '显示章节信息', NULL, NULL, 1476172059, 1476172059);
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/search', 2, '搜索章节信息', NULL, NULL, 1476172059, 1476172059);
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/update', 2, '修改章节信息', NULL, NULL, 1476172059, 1476172059);
INSERT INTO `ks_auth_item` VALUES ('admin/china/create', 2, '创建地址信息', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/china/delete', 2, '删除地址信息', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/china/index', 2, '显示地址信息', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/china/search', 2, '搜索地址信息', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/china/update', 2, '修改地址信息', NULL, NULL, 1476085132, 1476085132);
INSERT INTO `ks_auth_item` VALUES ('admin/classification/create', 2, '创建车型配置', NULL, NULL, 1492831806, 1492831806);
INSERT INTO `ks_auth_item` VALUES ('admin/classification/delete', 2, '删除车型配置', NULL, NULL, 1492831806, 1492831806);
INSERT INTO `ks_auth_item` VALUES ('admin/classification/delete-all', 2, '考试类型-批量删除', NULL, NULL, 1529075116, 1529075116);
INSERT INTO `ks_auth_item` VALUES ('admin/classification/export', 2, '导出车型配置', NULL, NULL, 1492831806, 1492831806);
INSERT INTO `ks_auth_item` VALUES ('admin/classification/index', 2, '车型配置显示', NULL, NULL, 1492830329, 1492830329);
INSERT INTO `ks_auth_item` VALUES ('admin/classification/search', 2, '搜索车型配置', NULL, NULL, 1492831805, 1492831805);
INSERT INTO `ks_auth_item` VALUES ('admin/classification/update', 2, '修改车型配置', NULL, NULL, 1492831806, 1492831806);
INSERT INTO `ks_auth_item` VALUES ('admin/classification/upload', 2, '上传车型配置图标', NULL, NULL, 1492870551, 1492870551);
INSERT INTO `ks_auth_item` VALUES ('admin/question/chapter', 2, '题库查询章节', NULL, NULL, 1527996561, 1527996561);
INSERT INTO `ks_auth_item` VALUES ('admin/question/child', 2, '查询问题答案', NULL, NULL, 1476454541, 1476454541);
INSERT INTO `ks_auth_item` VALUES ('admin/question/create', 2, '创建题库信息', NULL, NULL, 1476175766, 1476175766);
INSERT INTO `ks_auth_item` VALUES ('admin/question/delete', 2, '删除题库信息', NULL, NULL, 1476175766, 1476175766);
INSERT INTO `ks_auth_item` VALUES ('admin/question/delete-all', 2, '题库管理-批量删除', NULL, NULL, 1542260109, 1542260109);
INSERT INTO `ks_auth_item` VALUES ('admin/question/export', 2, '导出题库信息', NULL, NULL, 1476175766, 1476175766);
INSERT INTO `ks_auth_item` VALUES ('admin/question/index', 2, '显示题库信息', NULL, NULL, 1476175765, 1476175765);
INSERT INTO `ks_auth_item` VALUES ('admin/question/search', 2, '搜索题库信息', NULL, NULL, 1476175766, 1476175766);
INSERT INTO `ks_auth_item` VALUES ('admin/question/subject', 2, '问题获取章节', NULL, NULL, 1528017028, 1528017028);
INSERT INTO `ks_auth_item` VALUES ('admin/question/update', 2, '修改题库信息', NULL, NULL, 1476175766, 1476175766);
INSERT INTO `ks_auth_item` VALUES ('admin/question/upload', 2, '上传题目图片', NULL, NULL, 1476695636, 1476695646);
INSERT INTO `ks_auth_item` VALUES ('admin/question/upload-question', 2, '导入题库信息', NULL, NULL, 1542254880, 1542254880);
INSERT INTO `ks_auth_item` VALUES ('admin/special/create', 2, '创建专项分类', NULL, NULL, 1476172610, 1476172610);
INSERT INTO `ks_auth_item` VALUES ('admin/special/delete', 2, '删除专项分类', NULL, NULL, 1476172610, 1476172610);
INSERT INTO `ks_auth_item` VALUES ('admin/special/export', 2, '导出专项分类', NULL, NULL, 1476172610, 1476172610);
INSERT INTO `ks_auth_item` VALUES ('admin/special/index', 2, '显示专项分类', NULL, NULL, 1476172609, 1476172609);
INSERT INTO `ks_auth_item` VALUES ('admin/special/search', 2, '搜索专项分类', NULL, NULL, 1476172610, 1476172610);
INSERT INTO `ks_auth_item` VALUES ('admin/special/update', 2, '修改专项分类', NULL, NULL, 1476172610, 1476172610);
INSERT INTO `ks_auth_item` VALUES ('admin/subject/create', 2, '创建科目信息', NULL, NULL, 1476171765, 1476171765);
INSERT INTO `ks_auth_item` VALUES ('admin/subject/delete', 2, '删除科目信息', NULL, NULL, 1476171765, 1476171765);
INSERT INTO `ks_auth_item` VALUES ('admin/subject/export', 2, '导出科目信息', NULL, NULL, 1476171765, 1476171765);
INSERT INTO `ks_auth_item` VALUES ('admin/subject/index', 2, '显示科目信息', NULL, NULL, 1476171765, 1476171765);
INSERT INTO `ks_auth_item` VALUES ('admin/subject/search', 2, '搜索科目信息', NULL, NULL, 1476171765, 1476171765);
INSERT INTO `ks_auth_item` VALUES ('admin/subject/update', 2, '修改科目信息', NULL, NULL, 1476171765, 1476171765);
INSERT INTO `ks_auth_item` VALUES ('admin/subject/upload', 2, '章节配置-添加图片', NULL, NULL, 1528002698, 1528002698);
INSERT INTO `ks_auth_item` VALUES ('admin/user/create', 2, '创建用户信息', NULL, NULL, 1476095210, 1476095210);
INSERT INTO `ks_auth_item` VALUES ('admin/user/delete', 2, '删除用户信息', NULL, NULL, 1476095210, 1476095210);
INSERT INTO `ks_auth_item` VALUES ('admin/user/delete-all', 2, '批量删除用户信息', NULL, NULL, 1476096229, 1476096229);
INSERT INTO `ks_auth_item` VALUES ('admin/user/export', 2, '导出用户信息', NULL, NULL, 1476095210, 1476095210);
INSERT INTO `ks_auth_item` VALUES ('admin/user/index', 2, '显示用户信息', NULL, NULL, 1476095210, 1476095210);
INSERT INTO `ks_auth_item` VALUES ('admin/user/search', 2, '搜索用户信息', NULL, NULL, 1476095210, 1476095210);
INSERT INTO `ks_auth_item` VALUES ('admin/user/update', 2, '修改用户信息', NULL, NULL, 1476095210, 1476095210);
INSERT INTO `ks_auth_item` VALUES ('admin/user/upload', 2, '上传用户头像信息', NULL, NULL, 1476149415, 1476149415);
INSERT INTO `ks_auth_item` VALUES ('administrator', 1, '超级管理员', NULL, NULL, 1476085134, 1476085134);
INSERT INTO `ks_auth_item` VALUES ('user', 1, '普通用户', NULL, NULL, 1476085137, 1476085137);
COMMIT;

-- ----------------------------
-- Table structure for ks_auth_item_child
-- ----------------------------
DROP TABLE IF EXISTS `ks_auth_item_child`;
CREATE TABLE `ks_auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`) USING BTREE,
  CONSTRAINT `ks_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `ks_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ks_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `ks_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ks_auth_item_child
-- ----------------------------
BEGIN;
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin-log/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin-log/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin-log/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin-log/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin-log/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin-log/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin-log/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/address');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/address');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/delete');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/editable');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/editable');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/admin/upload');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/admin/upload');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-assignment/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-assignment/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-assignment/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-assignment/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-assignment/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-assignment/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-assignment/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-rule/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-rule/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-rule/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-rule/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-rule/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-rule/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/auth-rule/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/authority/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/authority/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/authority/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/authority/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/authority/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/authority/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/authority/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/menu/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/menu/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/menu/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/menu/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/menu/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/menu/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/module/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/module/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/module/produce');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/module/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/role/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/role/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/role/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/role/delete');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/role/edit');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/role/edit');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/role/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/role/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/role/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/role/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/role/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/role/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/role/view');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/role/view');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/admin/view');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/admin/view');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/answer/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/answer/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/answer/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/answer/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/answer/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/answer/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/arrange/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/arrange/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/arrange/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/arrange/delete');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/arrange/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/arrange/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/arrange/editable');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/arrange/editable');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/arrange/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/arrange/export');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/arrange/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/arrange/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/arrange/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/arrange/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/arrange/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/arrange/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/chapter/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/chapter/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/chapter/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/chapter/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/chapter/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/chapter/update');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/china/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/china/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/china/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/china/delete');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/china/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/china/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/china/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/china/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/china/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/china/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/classification/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/classification/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/classification/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/classification/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/classification/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/classification/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/classification/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/classification/upload');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/chapter');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/child');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/subject');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/upload');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/upload-question');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/special/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/special/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/special/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/special/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/special/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/special/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/subject/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/subject/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/subject/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/subject/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/subject/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/subject/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/subject/upload');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/user/create');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/user/create');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/user/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/user/delete');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/user/delete-all');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/user/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/user/export');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/user/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/user/index');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/user/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/user/search');
INSERT INTO `ks_auth_item_child` VALUES ('admin', 'admin/user/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/user/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/user/upload');
COMMIT;

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
BEGIN;
INSERT INTO `ks_auth_rule` VALUES ('admin', 'O:29:\"jinxing\\admin\\rules\\AdminRule\":3:{s:4:\"name\";s:5:\"admin\";s:9:\"createdAt\";i:1529080802;s:9:\"updatedAt\";i:1529080802;}', 1529080802, 1529080802);
INSERT INTO `ks_auth_rule` VALUES ('admin-delete', 'O:35:\"jinxing\\admin\\rules\\AdminDeleteRule\":3:{s:4:\"name\";s:12:\"admin-delete\";s:9:\"createdAt\";i:1529080818;s:9:\"updatedAt\";i:1529080818;}', 1529080818, 1529080818);
INSERT INTO `ks_auth_rule` VALUES ('auth-assignment', 'O:38:\"jinxing\\admin\\rules\\AuthAssignmentRule\":3:{s:4:\"name\";s:15:\"auth-assignment\";s:9:\"createdAt\";i:1529080831;s:9:\"updatedAt\";i:1529080831;}', 1529080831, 1529080831);
COMMIT;

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
BEGIN;
INSERT INTO `ks_car_type` VALUES (1, '小车', '小车车型. 适用车型：C1/C2照', 1, 1, '/public/car-type/58fc0f59dd3a5.png', 1492832231);
INSERT INTO `ks_car_type` VALUES (2, '大车', '大车车型', 1, 2, '/public/car-type/58fc0b7ab557a.png', 1492832259);
INSERT INTO `ks_car_type` VALUES (3, '客车', '客车车型', 1, 3, '/public/car-type/58fc0ab02cfe1.png', 1492832449);
INSERT INTO `ks_car_type` VALUES (4, '摩托车', '测试摩托车', 1, 4, '/public/car-type/58fc0bb14ef73.png', 1492913077);
COMMIT;

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
BEGIN;
INSERT INTO `ks_chapter` VALUES (1, '第一章 道路交通安全法律、法规和规章', 1, 1476172331, 1493087023, 1);
INSERT INTO `ks_chapter` VALUES (2, '第二章 交通信号', 2, 1476172350, 1493087099, 1);
INSERT INTO `ks_chapter` VALUES (3, '第三章 安全行车、文明驾驶基础知识', 3, 1476172371, 1493087105, 2);
INSERT INTO `ks_chapter` VALUES (4, '第四章 机动车驾驶操作相关基础知识', 1, 1476172399, 1542260806, 2);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='导航栏信息表';

-- ----------------------------
-- Records of ks_menu
-- ----------------------------
BEGIN;
INSERT INTO `ks_menu` VALUES (1, 0, '后台管理', 'menu-icon fa fa-cog', '', 1, 2, 1468985587, 1, 1474340768, 1);
INSERT INTO `ks_menu` VALUES (2, 1, '导航栏目', '', 'admin/admin/menu/index', 1, 4, 1468987221, 1, 1468994846, 1);
INSERT INTO `ks_menu` VALUES (3, 1, '模块生成', '', 'admin/admin/module/index', 1, 5, 1468994283, 1, 1468994860, 1);
INSERT INTO `ks_menu` VALUES (4, 17, '角色管理', 'menu-icon fa fa-graduation-cap ', 'admin/admin/role/index', 1, 10, 1468994665, 1, 1529080660, 1);
INSERT INTO `ks_menu` VALUES (5, 1, '管理员信息', '', 'admin/admin/admin/index', 1, 2, 1468994769, 1, 1474340722, 1);
INSERT INTO `ks_menu` VALUES (6, 17, '权限管理', 'menu-icon fa fa-fire', 'admin/admin/authority/index', 1, 20, 1468994819, 1, 1529080521, 1);
INSERT INTO `ks_menu` VALUES (9, 0, '用户信息', 'menu-icon fa fa-user', 'admin/user/index', 1, 5, 1476095210, 1, 1476176242, 1);
INSERT INTO `ks_menu` VALUES (10, 14, '科目信息', 'menu-icon icon-cog', 'admin/subject/index', 1, 104, 1476171766, 1, 1476176338, 1);
INSERT INTO `ks_menu` VALUES (11, 14, '章节信息', 'menu-icon icon-cog', 'admin/chapter/index', 1, 103, 1476172059, 1, 1476176326, 1);
INSERT INTO `ks_menu` VALUES (12, 14, '专项分类', 'menu-icon icon-cog', 'admin/special/index', 1, 102, 1476172610, 1, 1476177469, 1);
INSERT INTO `ks_menu` VALUES (13, 14, '题库信息', 'menu-icon icon-cog', 'admin/question/index', 1, 101, 1476175766, 1, 1476176304, 1);
INSERT INTO `ks_menu` VALUES (14, 0, '题库管理', 'menu-icon fa fa-graduation-cap', '', 1, 6, 1476176095, 1, 1476176095, 1);
INSERT INTO `ks_menu` VALUES (15, 0, '考试类型', 'menu-icon fa fa-list', 'admin/classification/index', 1, 100, 1492829715, 1, 1527996393, 1);
INSERT INTO `ks_menu` VALUES (17, 1, '后台权限', 'menu-icon fa fa-globe', '', 1, 100, 1529080277, 1, 1529080277, 1);
INSERT INTO `ks_menu` VALUES (18, 17, '角色分配', 'menu-icon fa fa-paper-plane', 'admin/admin/auth-assignment/index', 1, 20, 1529080403, 1, 1529080684, 1);
INSERT INTO `ks_menu` VALUES (19, 1, '操作日志', 'menu-icon fa fa-globe', 'admin/admin/admin-log/index', 1, 30, 1529080457, 1, 1529080457, 1);
INSERT INTO `ks_menu` VALUES (20, 17, '规则管理', 'menu-icon fa fa-globe', 'admin/admin/auth-rule/index', 1, 40, 1529080726, 1, 1529080726, 1);
COMMIT;

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
  `answers` text NOT NULL COMMENT '问题信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态(1 启用 0 停用)',
  `answer_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '正确答案ID',
  `subject_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属科目ID',
  `chapter_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属章节',
  `special_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '专项ID',
  `error_number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '错误人数',
  `do_number` int(11) NOT NULL DEFAULT '0' COMMENT '做了该题目人数',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8 COMMENT='题库信息表';

-- ----------------------------
-- Records of ks_question
-- ----------------------------
BEGIN;
INSERT INTO `ks_question` VALUES (1, '驾驶机动车在道路上违反道路交通安全法的行为，属于什么行为？', '违反《道路交通安全法》，属于违法行为。官方已无违规、违章的说法。', NULL, 1, '[\"A、违规行为\",\"B、过失行为\",\"C、违章行为\",\"D、违法行为\"]', 1, '3', 1, 1, 0, 3, 8, 1542277969, 1542333411);
INSERT INTO `ks_question` VALUES (2, '机动车驾驶人违法驾驶造成重大交通事故构成犯罪的，依法追究什么责任？', '《道路交通安全法》第一百零一条：违反道路交通安全法律、法规的规定，发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证。', NULL, 1, '[\"A、经济责任\",\"B、民事责任\",\"C、直接责任\",\"D、刑事责任\"]', 1, '3', 1, 1, 0, 0, 0, 1542277970, 1542277970);
INSERT INTO `ks_question` VALUES (3, '机动车驾驶人造成事故后逃逸构成犯罪的，吊销驾驶证且多长时间不得重新取得驾驶证？', '《道路交通安全法》第一百零一条：造成交通事故后逃逸的，由公安机关交通管理部门吊销其机动车驾驶证，且终生不得重新取得机动车驾驶证。', NULL, 1, '[\"A、5年内\",\"B、终生\",\"C、20年内\",\"D、10年内\"]', 1, '1', 1, 1, 0, 0, 0, 1542277971, 1542277971);
INSERT INTO `ks_question` VALUES (4, '驾驶机动车违反道路交通安全法律法规发生交通事故属于交通违章行为。', '“违反道路交通安全法”，违反法律法规即为违法行为。现在官方已无违章和违规的说法。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 1, 2, 1542277972, 1542333420);
INSERT INTO `ks_question` VALUES (5, '驾驶机动车在道路上违反道路通行规定应当接受相应的处罚。', '违反道路通行规定势必要受到相应处罚的，避免下次再犯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277974, 1542277974);
INSERT INTO `ks_question` VALUES (6, '对未取得驾驶证驾驶机动车的，追究其法律责任。', '《道路交通安全法》第九十九条：未取得机动车驾驶证、机动车驾驶证被吊销或者机动车驾驶证被暂扣期间驾驶机动车的，由公安机关交通管理部门处二百元以上二千元以下罚款，可以并处十五日以下拘留。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277975, 1542277975);
INSERT INTO `ks_question` VALUES (7, '对违法驾驶发生重大交通事故且构成犯罪的，不追究其刑事责任。', '《道路交通安全法》第一百零一条：违反道路交通安全法律、法规的规定，发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 1, 1542277976, 1542278151);
INSERT INTO `ks_question` VALUES (8, '造成交通事故后逃逸且构成犯罪的驾驶人，将吊销驾驶证且终生不得重新取得驾驶证。', '《道路交通安全法》第一百零一条：违反道路交通安全法律、法规的规定，发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证。造成交通事故后逃逸的，由公安机关交通管理部门吊销机动车驾驶证，且终生不得重新取得机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277977, 1542277977);
INSERT INTO `ks_question` VALUES (9, '驾驶机动车在道路上违反交通安全法规的行为属于违法行为。', '“违反道路交通安全法”，违反法律法规即为违法行为。官方已无违章和违规的说法。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277978, 1542277978);
INSERT INTO `ks_question` VALUES (10, '驾驶机动车应当随身携带哪种证件？', '《道路交通安全法》第十一条：驾驶机动车上道路行驶，应当悬挂机动车号牌，放置检验合格标志、保险标志，并随车携带机动车行驶证。', NULL, 1, '[\"A、工作证\",\"B、身份证\",\"C、职业资格证\",\"D、驾驶证\"]', 1, '3', 1, 1, 0, 0, 0, 1542277979, 1542277979);
INSERT INTO `ks_question` VALUES (11, '未取得驾驶证的学员在道路上学习驾驶技能，下列哪种做法是正确的？', '《公安部令第123号》规定：未取得驾驶证的学员在道路上学习驾驶技能，使用所学车型的教练车由教练员随车指导。', NULL, 1, '[\"A、使用所学车型的教练车单独驾驶学习\",\"B、使用所学车型的教练车由非教练员的驾驶人随车指导\",\"C、使用所学车型的教练车由教练员随车指导\",\"D、使用私家车由教练员随车指导\"]', 1, '2', 1, 1, 0, 0, 0, 1542277981, 1542277981);
INSERT INTO `ks_question` VALUES (12, '机动车驾驶人初次申领驾驶证后的实习期是多长时间？', '《公安部令第123号》规定：机动车驾驶人初次申请机动车驾驶证和增加准驾车型后的12个月为实习期。', NULL, 1, '[\"A、16个月\",\"B、6个月\",\"C、18个月\",\"D、12个月\"]', 1, '3', 1, 1, 0, 0, 0, 1542277982, 1542277982);
INSERT INTO `ks_question` VALUES (13, '在实习期内驾驶机动车的，应当在车身后部粘贴或者悬挂哪种标志？', '《公安部令第123号》规定：在实习期内驾驶机动车的，应当在车身后部粘贴或者悬挂统一式样的实习标志。', NULL, 1, '[\"A、统一式样的实习标志\",\"B、注意避让标志\",\"C、注意车距标志\",\"D、注意新手标志\"]', 1, '0', 1, 1, 0, 0, 1, 1542277983, 1542331176);
INSERT INTO `ks_question` VALUES (14, '贿赂等不正当手段取得驾驶证被依法撤销驾驶许可的，多长时间不得重新申请驾驶许可？', '《公安部令第123号》规定：申请人以欺骗、贿赂等不正当手段取得机动车驾驶证的，公安机关交通管理部门收缴机动车驾驶证，撤销机动车驾驶许可；申请人在三年内不得再次申领机动车驾驶证。', NULL, 1, '[\"A、3年内\",\"B、1年内\",\"C、5年内\",\"D、终身\"]', 1, '0', 1, 1, 0, 0, 0, 1542277984, 1542277984);
INSERT INTO `ks_question` VALUES (15, '驾驶人要按照驾驶证载明的准驾车型驾驶车辆。', '《公安部令第123号》规定：驾驶与准驾车型不符的机动车的违法行为，一次记12分。处罚200以上1000以下的罚款。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277985, 1542277985);
INSERT INTO `ks_question` VALUES (16, '上路行驶的机动车未随车携带身份证的，交通警察可依法扣留机动车。', '《道路交通安全法》第九十五条：上路行驶的机动车未随车携带机动车行驶证的，交通警察可依法扣留机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542277986, 1542277986);
INSERT INTO `ks_question` VALUES (17, '上路行驶的机动车未放置检验合格标志的，交通警察可依法扣留机动车。', '《道路交通安全法》第九十五条：上道路行驶的机动车未悬挂机动车号牌，未放置检验合格标志、保险标志，或者未随车携带行驶证、驾驶证的，公安机关交通管理部门应当扣留机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277988, 1542277988);
INSERT INTO `ks_question` VALUES (18, '变造机动车驾驶证构成犯罪的将被依法追究刑事责任。', '《道路交通安全法》第九十六条：伪造、变造或者使用伪造、变造的机动车登记证书、号牌、行驶证、驾驶证的，由公安机关交通管理部门予以收缴，扣留该机动车，处15日以下拘留，并处2000元以上5000元以下罚款；构成犯罪的，依法追究刑事责任。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 1, 1542277989, 1542331280);
INSERT INTO `ks_question` VALUES (19, '机动车驾驶人在实习期内驾驶机动车不得牵引挂车。', '《公安部令第123号》第六十五条：机动车驾驶人在实习期内不得驾驶公共汽车、营运客车或者执行任务的警车、消防车、救护车、工程救险车以及载有爆炸物品、易燃易爆化学物品、剧毒或者放射性等危险物品的机动车；驾驶的机动车不得牵引挂车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277990, 1542277990);
INSERT INTO `ks_question` VALUES (20, '驾驶拼装机动车上路行驶的驾驶人，除按规定接受罚款外，还要受到哪种处理？', '《道路交通安全法》第一百条：驾驶拼装的机动车或已达到报废标准的机动车上路行驶的驾驶人，处200元以上2000元以下罚款，并吊销机动车驾驶证，对车辆予以收缴，强制报废。', NULL, 1, '[\"A、处10日以下拘留\",\"B、暂扣驾驶证\",\"C、吊销驾驶证\",\"D、追究刑事责任\"]', 1, '2', 1, 1, 0, 0, 0, 1542277991, 1542277991);
INSERT INTO `ks_question` VALUES (21, '驾驶报废机动车上路行驶的驾驶人，除按规定罚款外，还要受到哪种处理？', '《道路交通安全法》第一百条：驾驶拼装的机动车或者已达到报废标准的机动车上道路行驶的，公安机关交通管理部门应当予以收缴，强制报废。对驾驶前款所列机动车上道路行驶的驾驶人，处200元以上2000元以下罚款，并吊销机动车驾驶证。', NULL, 1, '[\"A、撤销驾驶许可\",\"B、吊销驾驶证\",\"C、强制恢复车况\",\"D、收缴驾驶证\"]', 1, '1', 1, 1, 0, 0, 0, 1542277992, 1542277992);
INSERT INTO `ks_question` VALUES (22, '对驾驶已达到报废标准的机动车上路行驶的驾驶人，会受到下列哪种处罚？', '《道路交通安全法》第一百条：驾驶拼装的机动车或者已达到报废标准的机动车上道路行驶的，公安机关交通管理部门应当予以收缴，强制报废。对驾驶前款所列机动车上道路行驶的驾驶人，处200元以上2000元以下罚款，并吊销机动车驾驶证。', NULL, 1, '[\"A、追究刑事责任\",\"B、吊销机动车驾驶证\",\"C、处15日以下拘留\",\"D、处20以上200元以下罚款\"]', 1, '1', 1, 1, 0, 0, 0, 1542277993, 1542277993);
INSERT INTO `ks_question` VALUES (23, '对驾驶拼装机动车上路行驶的驾驶人，会受到下列哪种处罚？', '《道路交通安全法》第一百条：驾驶拼装的机动车或者已达到报废标准的机动车上道路行驶的，公安机关交通管理部门应当予以收缴，强制报废。对驾驶前款所列机动车上道路行驶的驾驶人，处200元以上2000元以下罚款，并吊销机动车驾驶证（非行驶证）。', NULL, 1, '[\"A、依法追究刑事责任\",\"B、处200以上2000元以下罚款\",\"C、处15日以下拘留\",\"D、吊销机动车行驶证\"]', 1, '1', 1, 1, 0, 0, 0, 1542277994, 1542277994);
INSERT INTO `ks_question` VALUES (24, '驾驶机动车上路前应当检查车辆安全技术性能。', '《道路交通安全法》第二十一条：驾驶人驾驶机动车上道路行驶前，应当对机动车的安全技术性能进行认真检查；不得驾驶安全设施不全或者机件不符合技术标准等具有安全隐患的机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277996, 1542277996);
INSERT INTO `ks_question` VALUES (25, '不得驾驶具有安全隐患的机动车上道路行驶。', '《道路交通安全法》第二十一条：驾驶人驾驶机动车上道路行驶前，应当对机动车的安全技术性能进行认真检查；不得驾驶安全设施不全或者机件不符合技术标准等具有安全隐患的机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542277997, 1542277997);
INSERT INTO `ks_question` VALUES (26, '拼装的机动车只要认为安全就可以上路行驶。', '《道路交通安全法》第一百条：驾驶拼装的机动车或者已达到报废标准的机动车上道路行驶的，公安机关交通管理部门应当予以收缴，强制报废。对驾驶前款所列机动车上道路行驶的驾驶人，处200元以上2000元以下罚款，并吊销机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542277998, 1542277998);
INSERT INTO `ks_question` VALUES (27, '已经达到报废标准的机动车经大修后可以上路行驶。', '《道路交通安全法》第一百条规定：驾驶拼装的机动车或者已达到报废标准的机动车上道路行驶的，公安机关交通管理部门应当予以收缴，强制报废。对驾驶前款所列机动车上道路行驶的驾驶人，处200元以上2000元以下罚款，并吊销机动车驾驶证。已经达到报废标准就得报废，再修也是达到报废标准的车子了。不能再上路行驶了。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542277999, 1542277999);
INSERT INTO `ks_question` VALUES (28, '下列哪种证件是驾驶机动车上路行驶应当随车携带？', '《道路交通安全法》第十一条：驾驶机动车上道路行驶，应当悬挂机动车号牌，放置检验合格标志、保险标志，并随车携带机动车行驶证。', NULL, 1, '[\"A、机动车登记证\",\"B、出厂合格证明\",\"C、机动车保险单\",\"D、机动车行驶证\"]', 1, '3', 1, 1, 0, 0, 0, 1542278000, 1542278000);
INSERT INTO `ks_question` VALUES (29, '驾驶这种机动车上路行驶属于什么行为？', '《道路交通安全法》第十一条：机动车号牌应当按照规定悬挂并保持清晰、完整，不得故意遮挡、污损。违反《交通安全法》，所以是违法行为。', 'http://file.open.jiakaobaodian.com/tiku/res/802800.jpg', 1, '[\"A、违规行为\",\"B、犯罪行为\",\"C、违法行为\",\"D、违章行为\"]', 1, '2', 1, 1, 4, 0, 1, 1542278001, 1542333981);
INSERT INTO `ks_question` VALUES (30, '下列哪种标志是驾驶机动车上路行驶应当在车上放置的标志？', '《道路交通安全法》第十一条：驾驶机动车上道路行驶，应当悬挂机动车号牌，放置检验合格标志、保险标志，并随车携带机动车行驶证。', NULL, 1, '[\"A、产品合格标志\",\"B、保持车距标志\",\"C、检验合格标志\",\"D、提醒危险标志\"]', 1, '2', 1, 1, 0, 0, 0, 1542278003, 1542278003);
INSERT INTO `ks_question` VALUES (31, '驾驶人在下列哪种情况下不能驾驶机动车？', '常识性考题，酒后不能开车，酒后开车属违法行为。', NULL, 1, '[\"A、喝茶后\",\"B、喝牛奶后\",\"C、饮酒后\",\"D、喝咖啡后\"]', 1, '2', 1, 1, 0, 0, 0, 1542278004, 1542278004);
INSERT INTO `ks_question` VALUES (32, '这辆在道路上行驶的机动车有下列哪种违法行为？', '图中车辆用光盘遮挡号牌，属于违法行为，直接扣12分。', 'http://file.open.jiakaobaodian.com/tiku/res/803100.jpg', 1, '[\"A、未按规定悬挂号牌\",\"B、故意遮挡号牌\",\"C、占用非机动车道\",\"D、逆向行驶\"]', 1, '1', 1, 1, 4, 0, 1, 1542278005, 1542333993);
INSERT INTO `ks_question` VALUES (33, '驾驶机动车上路行驶应当按规定悬挂号牌。', '《道路交通安全法》第十一条规定：驾驶机动车上道路行驶，应当悬挂机动车号牌，放置检验合格标志、保险标志，并随车携带机动车行驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278006, 1542278006);
INSERT INTO `ks_question` VALUES (34, '驾驶这种机动车上路行驶没有违法行为。', '图中机动车号牌被光碟遮住了。故意遮挡、污损机动车号牌，是违反《道路交通安全法》的行为，也就是违法行为。', 'http://file.open.jiakaobaodian.com/tiku/res/803300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 1, 1542278007, 1542333998);
INSERT INTO `ks_question` VALUES (35, '服用国家管制的精神药品可以短途驾驶机动车。', '《道路交通安全法》第二十二条：饮酒、服用国家管制的精神药品或者麻醉药品，或者患有妨碍安全驾驶机动车的疾病，或者过度疲劳影响安全驾驶的，不得驾驶机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 1, 1542278008, 1542278154);
INSERT INTO `ks_question` VALUES (36, '饮酒后只要不影响驾驶操作可以短距离驾驶机动车。', '《道路交通安全法》第九十一条：饮酒后驾驶机动车的，处暂扣6个月机动车驾驶证，并处1000元以上2000元以下罚款。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278010, 1542278010);
INSERT INTO `ks_question` VALUES (37, '公安机关交通管理部门对驾驶人的交通违法行为除依法给予行政处罚外，实行下列哪种制度？', '《道路交通安全法》第二十四条：公安机关交通管理部门对机动车驾驶人违反道路交通安全法律、法规的行为，除依法给予行政处罚外，实行累积记分制度。', NULL, 1, '[\"A、累积记分制度\",\"B、奖励里程制度\",\"C、违法登记制度\",\"D、强制报废制度\"]', 1, '0', 1, 1, 0, 0, 0, 1542278011, 1542278011);
INSERT INTO `ks_question` VALUES (38, '道路交通安全违法行为累积记分的周期是多长时间？', '《公安部令第123号》第五十五条：道路交通安全违法行为累积记分周期（即记分周期）为12个月，满分为12分，从机动车驾驶证初次领取之日起计算。', NULL, 1, '[\"A、3个月\",\"B、12个月\",\"C、6个月\",\"D、24个月\"]', 1, '1', 1, 1, 0, 0, 0, 1542278012, 1542278012);
INSERT INTO `ks_question` VALUES (39, '公安机关交通管理部门对累积记分达到规定分值的驾驶人怎样处理？', '《道路交通安全法》第二十四条：公安机关交通管理部门对累积记分达到规定分值的机动车驾驶人，扣留机动车驾驶证，对其进行道路交通安全法律、法规教育，重新考试。', NULL, 1, '[\"A、终生禁驾\",\"B、依法追究刑事责任\",\"C、进行法律法规教育，重新考试\",\"D、处15日以下拘留\"]', 1, '2', 1, 1, 0, 0, 0, 1542278013, 1542278013);
INSERT INTO `ks_question` VALUES (40, '驾驶人出现下列哪种情况，不得驾驶机动车？', '驾驶证丢失、损毁的应当向机动车驾驶证核发地车辆管理所申请补发、换证，在此期间不得驾驶机动车。', NULL, 1, '[\"A、驾驶证丢失、损毁\",\"B、驾驶证接近有效期\",\"C、记分达到6分\",\"D、记分达到10分\"]', 1, '0', 1, 1, 0, 0, 0, 1542278014, 1542278014);
INSERT INTO `ks_question` VALUES (41, '驾驶人在驾驶证丢失后3个月内还可以驾驶机动车。', '机动车驾驶证遗失的，机动车驾驶人应当向机动车驾驶证核发地车辆管理所申请补发。在此期间，不符合“随身携带机动车驾驶证”的规定，故不得驾驶机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278015, 1542278015);
INSERT INTO `ks_question` VALUES (42, '驾驶人持超过有效期的驾驶证可以在1年内驾驶机动车。', '《实施条例》第二十八条：机动车驾驶人在机动车驾驶证丢失、损毁、超过有效期或者被依法扣留、暂扣期间以及记分达到12分的，不得驾驶机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278017, 1542278017);
INSERT INTO `ks_question` VALUES (43, '驾驶人的驾驶证损毁后不得驾驶机动车。', '《道路交通安全法实施条例》第二十八条：机动车驾驶人在机动车驾驶证丢失、损毁、超过有效期或者被依法扣留、暂扣期间以及记分达到12分的，不得驾驶机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 1, 1542278018, 1542331269);
INSERT INTO `ks_question` VALUES (44, '记分满12分的驾驶人拒不参加学习和考试的将被公告驾驶证停止使用。', '《道路交通安全法实施条例》第二十五条：机动车驾驶人记分达到12分，拒不参加公安机关交通管理部门通知的学习，也不接受考试的，由公安机关交通管理部门公告其机动车驾驶证停止使用。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278019, 1542278019);
INSERT INTO `ks_question` VALUES (45, '暂扣的情况下不得驾驶机动车。', '《道路交通安全法实施条例》第二十八条：机动车驾驶人在机动车驾驶证丢失、损毁、超过有效期或者被依法扣留、暂扣期间以及记分达到12分的，不得驾驶机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278020, 1542278020);
INSERT INTO `ks_question` VALUES (46, '前方路口这种信号灯亮表示什么意思？', '红灯停、绿灯行、此时前方是红灯，所以是禁止通行的。右转弯的车子在确认安全后是可以通行的。', 'http://file.open.jiakaobaodian.com/tiku/res/804500.jpg', 1, '[\"A、路口警示\",\"B、准许通行\",\"C、禁止通行\",\"D、提醒注意\"]', 1, '2', 1, 1, 4, 0, 1, 1542278021, 1542334002);
INSERT INTO `ks_question` VALUES (47, '交通标线和交通警察的指挥。', '《公安部令第123号》第二十五条：交通信号包括交通信号灯、交通标志、交通标线和交通警察的指挥。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278025, 1542278025);
INSERT INTO `ks_question` VALUES (48, '交通标志和交通标线不属于交通信号。', '《公安部令第123号》第二十五条：交通信号包括交通信号灯、交通标志、交通标线和交通警察的指挥。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278026, 1542278026);
INSERT INTO `ks_question` VALUES (49, '绿灯和黄灯组成。', '《道路交通安全法》第二十六条：交通信号灯由红灯、绿灯、黄灯组成。红灯表示禁止通行，绿灯表示准许通行，黄灯表示警示。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278027, 1542278027);
INSERT INTO `ks_question` VALUES (50, '禁止标线。', '《实施条例》第三十条：交通标志分为：指示标志、警告标志、禁令标志、指路标志、旅游区标志、道路施工安全标志和辅助标志。道路交通标线分为：指示标线、警告标线、禁止标线。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278028, 1542278028);
INSERT INTO `ks_question` VALUES (51, '驾驶机动车在这种道路上如何通行？', '《道路交通安全法》第三十六条：根据道路条件和通行需要，道路划分为机动车道、非机动车道和人行道的，机动车、非机动车、行人实行分道通行。没有划分机动车道、非机动车道和人行道的，机动车在道路中间通行，非机动车和行人在道路两侧通行。', 'http://file.open.jiakaobaodian.com/tiku/res/805200.jpg', 1, '[\"A、可随意通行\",\"B、实行分道通行\",\"C、在道路两边通行\",\"D、在道路中间通行\"]', 1, '3', 1, 1, 4, 0, 1, 1542278029, 1542334009);
INSERT INTO `ks_question` VALUES (52, '道路上划设这种标线的车道内允许下列哪类车辆通行？', '注意道路上的文字“公交专用道”。', 'http://file.open.jiakaobaodian.com/tiku/res/805300.jpg', 1, '[\"A、私家车\",\"B、公交车\",\"C、公务用车\",\"D、出租车\"]', 1, '1', 1, 1, 4, 0, 1, 1542278030, 1542334013);
INSERT INTO `ks_question` VALUES (53, '驾驶机动车在路口遇到这种情况如何行驶？', '图中可以看见交通信号灯是绿色，但是在有交警指挥的情况下，要按照交警的指挥行驶。警察手势为停止信号，示意：不准前方车辆通行，也就是停车等待。', 'http://file.open.jiakaobaodian.com/tiku/res/805400.jpg', 1, '[\"A、遵守交通信号灯\",\"B、靠右侧直行\",\"C、停车等待\",\"D、可以向右转弯\"]', 1, '2', 1, 1, 4, 0, 1, 1542278031, 1542334020);
INSERT INTO `ks_question` VALUES (54, '有这种信号灯的路口允许机动车如何行驶？', '红色信号禁止通行，绿色信号可以通行。只有右转是绿色信号，所以可以向右转弯。', 'http://file.open.jiakaobaodian.com/tiku/res/805500.jpg', 1, '[\"A、向右转弯\",\"B、向左转弯\",\"C、直行通过\",\"D、停车等待\"]', 1, '0', 1, 1, 4, 0, 1, 1542278032, 1542334028);
INSERT INTO `ks_question` VALUES (55, '遇到这种情况的路口怎样通过？', '该路口只有一个信号灯：黄灯，而且一直在闪烁，表示警示，提醒过往车辆注意瞭望，确认安全后通过。', 'http://file.open.jiakaobaodian.com/tiku/res/805600.jpg', 1, '[\"A、加速直行通过\",\"B、确认安全后通过\",\"C、左转弯加速通过\",\"D、右转弯加速通过\"]', 1, '1', 1, 1, 4, 0, 0, 1542278034, 1542278034);
INSERT INTO `ks_question` VALUES (56, '这段道路红车所在车道是什么车道？', '《道路交通安全法实施条例》第四十四条：在道路同方向划有2条以上机动车道的，左侧为快速车道，右侧为慢速车道。红色车在最左侧，所以是在快速车道。', 'http://file.open.jiakaobaodian.com/tiku/res/805700.jpg', 1, '[\"A、快速车道\",\"B、应急车道\",\"C、慢速车道\",\"D、专用车道\"]', 1, '0', 1, 1, 4, 0, 0, 1542278035, 1542278035);
INSERT INTO `ks_question` VALUES (57, '机动车在道路上变更车道需要注意什么？', '《实施条例》第四十四条：在道路同方向划有2条以上机动车道的，变更车道的机动车不得影响相关车道内行驶的机动车的正常行驶。', NULL, 1, '[\"A、不能影响其他车辆正常行驶\",\"B、尽快加速进入左侧车道\",\"C、进入左侧车道时适当减速\",\"D、开启转向灯迅速向左转向\"]', 1, '0', 1, 1, 0, 0, 0, 1542278036, 1542278036);
INSERT INTO `ks_question` VALUES (58, '在这种情况下可以借右侧公交车道超车。', '超车只能左侧超，不能右侧超车，而且也不能占用公交专用车道。仅当发生事故、正常道路封闭有标示注明允许借用或者交警指示等特殊情况允许借道行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/805900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542278037, 1542278037);
INSERT INTO `ks_question` VALUES (59, '在路口遇有交通信号灯和交通警察指挥不一致时，按照交通信号灯通行。', '《道路交通安全法》第三十八条：车辆、行人应当按照交通信号通行；遇有交通警察现场指挥时，应当按照交通警察的指挥通行；在没有交通信号的道路上，应当在确保安全、畅通的原则下通行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278038, 1542278038);
INSERT INTO `ks_question` VALUES (60, '在这种情况下可加速通过交叉路口。', '黄灯，车身未过停止线，请停车等待。', 'http://file.open.jiakaobaodian.com/tiku/res/806100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 1, 1542278039, 1542331258);
INSERT INTO `ks_question` VALUES (61, '在路口这个位置时可以加速通过路口。', '红灯亮表示禁止通行，请停车等待。', 'http://file.open.jiakaobaodian.com/tiku/res/806200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542278040, 1542278040);
INSERT INTO `ks_question` VALUES (62, '驾驶机动车不能进入红色叉形灯或者红色箭头灯亮的车道。', '《实施条例》第四十条：红色叉形灯或者箭头灯亮时，禁止本车道车辆通行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278042, 1542278042);
INSERT INTO `ks_question` VALUES (63, '在这段路的最高时速为每小时50公里。', '看右侧的标志，红圈白底限制最高速度，蓝底限制最低速度。此路段最高车速是80公里/小时。', 'http://file.open.jiakaobaodian.com/tiku/res/806400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542278043, 1542278043);
INSERT INTO `ks_question` VALUES (64, '这辆红色轿车变更车道的方法和路线是正确的。', '红车没有开启转向灯，并且红车明显没留出足够安全的行车距离强行并线。', 'http://file.open.jiakaobaodian.com/tiku/res/806500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542278044, 1542278044);
INSERT INTO `ks_question` VALUES (65, '驾驶机动车在道路上向左变更车道时如何使用灯光？', '《实施条例》第五十七条规定，机动车应当按照下列规定使用转向灯：(一)向左转弯、向左变更车道、准备超车、驶离停车地点或者掉头时，应当提前开启左转向灯；(二)向右转弯、向右变更车道、超车完毕驶回原车道、靠路边停车时，应当提前开启右转向灯。', NULL, 1, '[\"A、提前开启左转向灯\",\"B、不用开启转向灯\",\"C、提前开启右转向灯\",\"D、提前开启近光灯\"]', 1, '0', 1, 1, 0, 0, 1, 1542278045, 1542331214);
INSERT INTO `ks_question` VALUES (66, '驾驶机动车在道路上靠路边停车过程中如何使用灯光？', '《实施条例》第五十七条规定，机动车应当按照下列规定使用转向灯：(一)向左转弯、向左变更车道、准备超车、驶离停车地点或者掉头时，应当提前开启左转向灯；(二)向右转弯、向右变更车道、超车完毕驶回原车道、靠路边停车时，应当提前开启右转向灯。', NULL, 1, '[\"A、开启危险报警闪光灯\",\"B、变换使用远近光灯\",\"C、不用指示灯提示\",\"D、提前开启右转向灯\"]', 1, '3', 1, 1, 0, 0, 0, 1542278046, 1542278046);
INSERT INTO `ks_question` VALUES (67, '在这种天气条件下行车如何使用灯光？', '《道路交通安全法实施条例》第五十八条： 机动车在夜间没有路灯、照明不良或者遇有雾、雨、雪、沙尘、冰雹等低能见度情况下行驶时，应当开启前照灯、示廓灯和后位灯，但同方向行驶的后车与前车近距离行驶时，不得使用远光灯。机动车雾天行驶应当开启雾灯和危险报警闪光灯。', 'http://file.open.jiakaobaodian.com/tiku/res/806800.jpg', 1, '[\"A、使用远光灯\",\"B、使用雾灯\",\"C、使用近光灯\",\"D、不使用灯光\"]', 1, '2', 1, 1, 4, 0, 0, 1542278047, 1542278047);
INSERT INTO `ks_question` VALUES (68, '在这种雨天跟车行驶使用灯光，以下做法正确的是？', '《实施条例》第五十八条：机动车在夜间没有路灯、照明不良或者遇有雾、雨、雪、沙尘、冰雹等低能见度情况下行驶时，应当开启前照灯、示廓灯和后位灯，但同方向行驶的后车与前车近距离行驶时，不得使用远光灯。机动车雾天行驶应当开启雾灯和危险报警闪光灯。', 'http://file.open.jiakaobaodian.com/tiku/res/807000.jpg', 1, '[\"A、使用远光灯\",\"B、不能使用远光灯\",\"C、不能使用近光灯\",\"D、使用雾灯\"]', 1, '1', 1, 1, 4, 0, 0, 1542278050, 1542278050);
INSERT INTO `ks_question` VALUES (69, '在这种环境下通过路口如何使用灯光？', '《实施条例》第五十九条：机动车在夜间通过急弯、坡路、拱桥、人行横道或者没有交通信号灯控制的路口时，应当交替使用远近光灯示意。此处为没有交通信号灯控制的路口，所以需要交替使用远近光灯。', 'http://file.open.jiakaobaodian.com/tiku/res/807100.jpg', 1, '[\"A、使用远光灯\",\"B、关闭远光灯\",\"C、使用危险报警闪光灯\",\"D、交替使用远近光灯\"]', 1, '3', 1, 1, 4, 0, 1, 1542278051, 1542331168);
INSERT INTO `ks_question` VALUES (70, '在这种路段如何行驶？', '《实施条例》第五十九条：机动车在夜间通过急弯、坡路、拱桥、人行横道或者没有交通信号灯控制的路口时，应当交替使用远近光灯示意。机动车驶近急弯、坡道顶端等影响安全视距的路段以及超车或者遇有紧急情况时，应当减速慢行，并鸣喇叭示意。', 'http://file.open.jiakaobaodian.com/tiku/res/807200.jpg', 1, '[\"A、在弯道中心转弯\",\"B、加速鸣喇叭通过\",\"C、占对方道路转弯\",\"D、减速鸣喇叭示意\"]', 1, '3', 1, 1, 4, 0, 0, 1542278052, 1542278052);
INSERT INTO `ks_question` VALUES (71, '驾驶机动车在道路上超车时可以不使用转向灯。', '《实施条例》第五十七条，机动车应当按照下列规定使用转向灯：（一）向左转弯、向左变更车道、准备超车、驶离停车地点或者掉头时，应当提前开启左转向灯；（二）向右转弯、向右变更车道、超车完毕驶回原车道、靠路边停车时，应当提前开启右转向灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 1, 1542278053, 1542331265);
INSERT INTO `ks_question` VALUES (72, '驾驶机动车在道路上超车完毕驶回原车道时需提前开启右转向灯。', '《实施条例》第五十七条，机动车应当按照下列规定使用转向灯：（一）向左转弯、向左变更车道、准备超车、驶离停车地点或者掉头时，应当提前开启左转向灯；（二）向右转弯、向右变更车道、超车完毕驶回原车道、靠路边停车时，应当提前开启右转向灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278054, 1542278054);
INSERT INTO `ks_question` VALUES (73, '驾驶机动车在道路上掉头时提前开启左转向灯。', '《实施条例》第五十七条，机动车应当按照下列规定使用转向灯：（一）向左转弯、向左变更车道、准备超车、驶离停车地点或者掉头时，应当提前开启左转向灯；（二）向右转弯、向右变更车道、超车完毕驶回原车道、靠路边停车时，应当提前开启右转向灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 1, 1542278055, 1542331329);
INSERT INTO `ks_question` VALUES (74, '驾驶机动车在道路上向右变更车道可以不使用转向灯。', '《实施条例》第五十七条规定，机动车应当按照下列规定使用转向灯：（一）向左转弯、向左变更车道、准备超车、驶离停车地点或者掉头时，应当提前开启左转向灯；（二）向右转弯、向右变更车道、超车完毕驶回原车道、靠路边停车时，应当提前开启右转向灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278056, 1542278056);
INSERT INTO `ks_question` VALUES (75, '示廓灯和后位灯。', '《实施条例》第五十八条：机动车在夜间没有路灯、照明不良或者遇有雾、雨、雪、沙尘、冰雹等低能见度情况下行驶时，应当开启前照灯、示廓灯和后位灯，但同方向行驶的后车与前车近距离行驶时，不得使用远光灯。机动车雾天行驶应当开启雾灯和危险报警闪光灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278058, 1542278058);
INSERT INTO `ks_question` VALUES (76, '在这种环境里行车使用近光灯。', '夜间、前方有行人的情况不能使用远光灯，会影响行人视线。所以应开启近光灯。', 'http://file.open.jiakaobaodian.com/tiku/res/807800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542278059, 1542278059);
INSERT INTO `ks_question` VALUES (77, '驾驶机动车在雾天行车开启雾灯和危险报警闪光灯。', '《实施条例》第五十八条：机动车在夜间没有路灯、照明不良或者遇有雾、雨、雪、沙尘、冰雹等低能见度情况下行驶时，应当开启前照灯、示廓灯和后位灯，但同方向行驶的后车与前车近距离行驶时，不得使用远光灯。机动车雾天行驶应当开启雾灯和危险报警闪光灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278060, 1542278060);
INSERT INTO `ks_question` VALUES (78, '在这种急弯道路上行车应交替使用远近光灯。', '《实施条例》第五十九条：机动车在夜间通过急弯、坡路、拱桥、人行横道或者没有交通信号灯控制的路口时，应当交替使用远近光灯示意。', 'http://file.open.jiakaobaodian.com/tiku/res/808000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542278061, 1542278061);
INSERT INTO `ks_question` VALUES (79, '夜间驾驶机动车通过人行横道时需要交替使用远近光灯。', '《实施条例》第五十九条：机动车在夜间通过急弯、坡路、拱桥、人行横道或者没有交通信号灯控制的路口时，应当交替使用远近光灯示意。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278062, 1542278062);
INSERT INTO `ks_question` VALUES (80, '驾驶机动车上坡时，在将要到达坡道顶端时要加速并鸣喇叭。', '《实施条例》第五十九条：机动车驶近急弯、坡道顶端等影响安全视距的路段以及超车或者遇有紧急情况时，应当减速慢行，并鸣喇叭示意。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278063, 1542278063);
INSERT INTO `ks_question` VALUES (81, '下列哪种行为会受到200元以上2000元以下罚款，并处吊销机动车驾驶证？', '《道路交通安全法》规定：机动车行驶超过规定时速50%的由公安交通管理部门处二百元以上二千元以下罚款。有机动车行驶超过规定时速50%行为的，可以并处吊销机动车驾驶证。', NULL, 1, '[\"A、违反道路通行规定\",\"B、超过规定时速50%\",\"C、造成交通事故后逃逸\",\"D、驾车没带驾驶证\"]', 1, '1', 1, 1, 0, 0, 0, 1542278064, 1542278064);
INSERT INTO `ks_question` VALUES (82, '在这条高速公路上行驶时的最高速度不能超过多少？', '《实施条例》规定，道路限速标志标明的车速与上述车道行驶车速的规定不一致的，按照道路限速标志标明的车速行驶。红圈白底，限速标志，最高行驶速度不得超过110公里/小时。', 'http://file.open.jiakaobaodian.com/tiku/res/808400.jpg', 1, '[\"A、100公里/小时\",\"B、90公里/小时\",\"C、110公里/小时\",\"D、120公里/小时\"]', 1, '2', 1, 1, 4, 0, 0, 1542278066, 1542278066);
INSERT INTO `ks_question` VALUES (83, '在这段城市道路上行驶的最高速度不能超过多少？', '《实施条例》第四十五条：在没有限速标志、标线的道路上，机动车不得超过下列最高行驶速度：(一)没有道路中心线的道路，城市道路为每小时30公里，公路为每小时40公里；(二)同方向只有1条机动车道的道路，城市道路为每小时50公里，公路为每小时70公里。', 'http://file.open.jiakaobaodian.com/tiku/res/808500.jpg', 1, '[\"A、40公里/小时\",\"B、30公里/小时\",\"C、50公里/小时\",\"D、70公里/小时\"]', 1, '1', 1, 1, 4, 0, 0, 1542278067, 1542278067);
INSERT INTO `ks_question` VALUES (84, '在这条公路上行驶的最高速度不能超过多少？', '《实施条例》第四十五条：在没有限速标志、标线的道路上，机动车不得超过下列最高行驶速度：(一)没有道路中心线的道路，城市道路为每小时30公里，公路为每小时40公里；(二)同方向只有1条机动车道的道路，城市道路为每小时50公里，公路为每小时70公里。', 'http://file.open.jiakaobaodian.com/tiku/res/808600.jpg', 1, '[\"A、70公里/小时\",\"B、50公里/小时\",\"C、30公里/小时\",\"D、40公里/小时\"]', 1, '3', 1, 1, 4, 0, 0, 1542278068, 1542278068);
INSERT INTO `ks_question` VALUES (85, '在这条城市道路上行驶的最高速度不能超过多少？', '《实施条例》第四十五条：在没有限速标志、标线的道路上，机动车不得超过下列最高行驶速度：(一)没有道路中心线的道路，城市道路为每小时30公里，公路为每小时40公里；(二)同方向只有1条机动车道的道路，城市道路为每小时50公里，公路为每小时70公里。', 'http://file.open.jiakaobaodian.com/tiku/res/808700.jpg', 1, '[\"A、50公里/小时\",\"B、70公里/小时\",\"C、30公里/小时\",\"D、40公里/小时\"]', 1, '0', 1, 1, 4, 0, 0, 1542278069, 1542278069);
INSERT INTO `ks_question` VALUES (86, '在这个弯道上行驶时的最高速度不能超过多少？', '《实施条例》第四十六条规定，机动车行驶中遇有下列情形之一的，最高行驶速度不得超过每小时30公里，其中拖拉机、电瓶车、轮式专用机械车不得超过每小时15公里：(一)进出非机动车道，通过铁路道口、急弯路、窄路、窄桥时；(二)掉头、转弯、下陡坡时；(三)遇雾、雨、雪、沙尘、冰雹，能见度在50米以内时；(四)在冰雪、泥泞的道路上行驶时；(五)牵引发生故障的机动车时。', 'http://file.open.jiakaobaodian.com/tiku/res/808900.jpg', 1, '[\"A、40公里/小时\",\"B、70公里/小时\",\"C、30公里/小时\",\"D、50公里/小时\"]', 1, '2', 1, 1, 4, 0, 0, 1542278072, 1542278072);
INSERT INTO `ks_question` VALUES (87, '结冰等气象条件时应降低行驶速度。', '《道路交通安全法》第四十二条：机动车上道路行驶，不得超过限速标志标明的最高时速。在没有限速标志的路段，应当保持安全车速。夜间行驶或者在容易发生危险的路段行驶，以及遇有沙尘、冰雹、雨、雪、雾、结冰等气象条件时，应当降低行驶速度。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 1, 1542278073, 1542278159);
INSERT INTO `ks_question` VALUES (88, '雪等能见度在50米以内时，最高速度不能超过多少？', '《实施条例》第四十六条：机动车行驶中遇有下列情形之一的，最高行驶速度不得超过每小时30公里，其中拖拉机、电瓶车、轮式专用机械车不得超过每小时15公里。机动车行驶中遇到雾、雨、雪、沙尘、冰雹，能见度在50米以内时，最高行驶速度不得超过每小时30公里。', NULL, 1, '[\"A、40公里/小时\",\"B、30公里/小时\",\"C、70公里/小时\",\"D、50公里/小时\"]', 1, '1', 1, 1, 0, 0, 0, 1542278074, 1542278074);
INSERT INTO `ks_question` VALUES (89, '驾驶机动车在进出非机动车道时，最高速度不能超过多少？', '机动车行驶中遇有下列情形之一的，最高行驶速度不得超过每小时30公里，其中拖拉机、电瓶车、轮式专用机械车不得超过每小时15公里：进出非机动车道，通过铁路道口、急弯路、窄路、窄桥时。', NULL, 1, '[\"A、60公里/小时\",\"B、40公里/小时\",\"C、30公里/小时\",\"D、50公里/小时\"]', 1, '2', 1, 1, 0, 0, 0, 1542278075, 1542278075);
INSERT INTO `ks_question` VALUES (90, '驾驶机动车通过铁路道口时，最高速度不能超过多少？', '《实施条例》第四十六条：机动车行驶中进出非机动车道、通过铁路道口、急弯路、窄路、窄桥时，最高行驶速度不得超过每小时30公里。', NULL, 1, '[\"A、30公里/小时\",\"B、15公里/小时\",\"C、40公里/小时\",\"D、20公里/小时\"]', 1, '0', 1, 1, 0, 0, 0, 1542278076, 1542278076);
INSERT INTO `ks_question` VALUES (91, '驾驶机动车通过急弯路时，最高速度不能超过多少？', '《实施条例》第四十六条：机动车行驶中进出非机动车道、通过铁路道口、急弯路、窄路、窄桥时，最高行驶速度不得超过每小时30公里。', NULL, 1, '[\"A、40公里/小时\",\"B、30公里/小时\",\"C、20公里/小时\",\"D、50公里/小时\"]', 1, '1', 1, 1, 0, 0, 0, 1542278077, 1542278077);
INSERT INTO `ks_question` VALUES (92, '窄桥时，最高速度不能超过多少？', '《实施条例》第四十六条：机动车行驶中进出非机动车道、通过铁路道口、急弯路、窄路、窄桥时，最高行驶速度不得超过每小时30公里。', NULL, 1, '[\"A、50公里/小时\",\"B、30公里/小时\",\"C、60公里/小时\",\"D、40公里/小时\"]', 1, '1', 1, 1, 0, 0, 0, 1542278079, 1542278079);
INSERT INTO `ks_question` VALUES (93, '掉头时，最高速度不能超过多少？', '《实施条例》第四十六条：机动车行驶中掉头、转弯、下陡坡时，最高行驶速度不得超过每小时30公里。', NULL, 1, '[\"A、30公里/小时\",\"B、40公里/小时\",\"C、60公里/小时\",\"D、50公里/小时\"]', 1, '0', 1, 1, 0, 0, 0, 1542278080, 1542278080);
INSERT INTO `ks_question` VALUES (94, '驾驶机动车在冰雪道路行驶时，最高速度不能超过多少？', '《道路交通安全法实施条例》第四十六条：机动车行驶中在冰雪、泥泞的道路上行驶时，最高行驶速度不得超过每小时30公里。', NULL, 1, '[\"A、50公里/小时\",\"B、40公里/小时\",\"C、20公里/小时\",\"D、30公里/小时\"]', 1, '3', 1, 1, 0, 0, 0, 1542278081, 1542278081);
INSERT INTO `ks_question` VALUES (95, '驾驶机动车在泥泞道路行驶时，最高速度不能超过多少？', '《道路交通安全法实施条例》第四十六条：机动车在冰雪、泥泞的道路上行驶时，最高行驶速度不得超过每小时30公里。', NULL, 1, '[\"A、40公里/小时\",\"B、20公里/小时\",\"C、30公里/小时\",\"D、15公里/小时\"]', 1, '2', 1, 1, 0, 0, 0, 1542278082, 1542278082);
INSERT INTO `ks_question` VALUES (96, '驾驶机动车上道路行驶，不允许超过限速标志标明的最高时速。', '《道路交通安全法》第四十二条：机动车上道路行驶，不得超过限速标志标明的最高时速。在没有限速标志的路段，应当保持安全车速。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 1, 1542278083, 1542331297);
INSERT INTO `ks_question` VALUES (97, '驾驶机动车在没有中心线的城市道路上，最高速度不能超过每小时50公里。', '《道路交通安全法实施条例》第四十五条：机动车在道路上行驶不得超过限速标志、标线标明的速度。在没有限速标志、标线的道路上，机动车不得超过下列最高行驶速度： (一)没有道路中心线的道路，城市道路为每小时30公里，公路为每小时40公里;(二)同方向只有1条机动车道的道路，城市道路为每小时50公里，公路为每小时70公里。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278084, 1542278084);
INSERT INTO `ks_question` VALUES (98, '驾驶机动车在没有中心线的公路上，最高速度不能超过每小时70公里。', '《道路交通安全法实施条例》第四十五条：机动车在道路上行驶不得超过限速标志、标线标明的速度。在没有限速标志、标线的道路上，机动车不得超过下列最高行驶速度：(一)没有道路中心线的道路，城市道路为每小时30公里，公路为每小时40公里；(二)同方向只有1条机动车道的道路，城市道路为每小时50公里，公路为每小时70公里。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 1, 2, 1542278085, 1542333415);
INSERT INTO `ks_question` VALUES (99, '车在这种条件的道路上，最高速度不能超过每小时50公里。', '《实施条例》第四十六条：机动车行驶中在冰雪、泥泞的道路上行驶时，最高行驶速度不得超过每小时30公里。', 'http://file.open.jiakaobaodian.com/tiku/res/810200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542278087, 1542278087);
INSERT INTO `ks_question` VALUES (100, '下陡坡时的最高速度不能超过每小时40公里。', '《道路交通安全法实施条例》第四十六条：机动车行驶中掉头、转弯、下陡坡时，最高行驶速度不得超过每小时30公里。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278088, 1542278088);
INSERT INTO `ks_question` VALUES (101, '窄桥时的最高速度不能超过每小时30公里。', '《道路交通安全法实施条例》第四十六条：机动车行驶中进出非机动车道、通过铁路道口、急弯路、窄路、窄桥时，最高行驶速度不得超过每小时30公里。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278089, 1542278089);
INSERT INTO `ks_question` VALUES (102, '这两辆车发生追尾的主要原因是什么？', '因为有人行横道线，所以司机应该知道要提前减速，速度降得低了，后车要刹车就应该不会再追尾了。追尾都是后车的责任，因为没有保持足有的安全距离。', 'http://file.open.jiakaobaodian.com/tiku/res/810500.jpg', 1, '[\"A、前车采取制动过急\",\"B、前车采取制动时没看后视镜\",\"C、后车未与前车保持安全距离\",\"D、后车超车时距离前车太近\"]', 1, '2', 1, 1, 4, 0, 0, 1542278090, 1542278090);
INSERT INTO `ks_question` VALUES (103, '驾驶机动车在下列哪种情形下不能超越前车？', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 1, '[\"A、前车正在右转弯\",\"B、前车正在左转弯\",\"C、前车减速让行\",\"D、前车靠边停车\"]', 1, '1', 1, 1, 0, 0, 0, 1542278091, 1542278091);
INSERT INTO `ks_question` VALUES (104, '在没有中心线的道路上发现后车发出超车信号时，如果条件许可如何行驶？', '如果迅速停车的话，会很容易追尾，降速靠右让路是因为超车规定要在左侧超越。安全文明驾驶原则，后车条件许可超车，前车那就减速靠右行驶。', NULL, 1, '[\"A、迅速停车让行\",\"B、保持原状态行驶\",\"C、加速行驶\",\"D、降速靠右让路\"]', 1, '3', 1, 1, 0, 0, 0, 1542278092, 1542278092);
INSERT INTO `ks_question` VALUES (105, '这种情况超车时，从前车的哪一侧超越？', '超车只能从左侧超越。因为驾驶员在左边，左边超车，驾驶员能观察到相对行驶车道有无来车。而右方超车驾驶员是看不到前方是否来车或速度慢的车辆。', 'http://file.open.jiakaobaodian.com/tiku/res/810800.jpg', 1, '[\"A、从无障碍一侧超越\",\"B、从前车的右侧超越\",\"C、从前车的左侧超越\",\"D、左右两侧均可超越\"]', 1, '2', 1, 1, 4, 0, 0, 1542278093, 1542278093);
INSERT INTO `ks_question` VALUES (106, '同车道行驶的车辆遇前车有下列哪种情形时不得超车？', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 1, '[\"A、正在停车\",\"B、减速让行\",\"C、正常行驶\",\"D、正在超车\"]', 1, '3', 1, 1, 0, 0, 0, 1542278095, 1542278095);
INSERT INTO `ks_question` VALUES (107, '同车道行驶的车辆前方遇到下列哪种车辆不得超车？', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 1, '[\"A、执行任务的警车\",\"B、城市公交车\",\"C、出租汽车\",\"D、大型客货车\"]', 1, '0', 1, 1, 0, 0, 0, 1542278097, 1542278097);
INSERT INTO `ks_question` VALUES (108, '驾驶机动车行经市区下列哪种道路时不得超车？', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 1, '[\"A、单向行驶路段\",\"B、单向两条行车道\",\"C、主要街道\",\"D、交通流量大的路段\"]', 1, '3', 1, 1, 0, 0, 0, 1542278101, 1542278101);
INSERT INTO `ks_question` VALUES (109, '驾驶机动车行经下列哪种路段不得超车？', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 1, '[\"A、环城高速\",\"B、人行横道\",\"C、高架路\",\"D、主要街道\"]', 1, '1', 1, 1, 0, 0, 0, 1542278102, 1542278102);
INSERT INTO `ks_question` VALUES (110, '驾驶机动车行经下列哪种路段时不得超车？', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 1, '[\"A、中心街道\",\"B、交叉路口\",\"C、高架路\",\"D、环城高速\"]', 1, '1', 1, 1, 0, 0, 0, 1542278103, 1542278103);
INSERT INTO `ks_question` VALUES (111, '驾驶机动车在下列哪种路段不得超车？', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 1, '[\"A、窄桥、弯道\",\"B、山区道路\",\"C、城市高架路\",\"D、城市快速路\"]', 1, '0', 1, 1, 0, 0, 0, 1542278104, 1542278104);
INSERT INTO `ks_question` VALUES (112, '驾驶机动车在夜间超车时怎样使用灯光？', '《实施条例》第四十七条：机动车超车时，应当提前开启左转向灯、变换使用远、近光灯或者鸣喇叭。夜间视线不佳，应该变换使用远、近光灯提醒其他车辆。', NULL, 1, '[\"A、开启远光灯\",\"B、关闭前大灯\",\"C、变换远、近光灯\",\"D、开启雾灯\"]', 1, '2', 1, 1, 0, 0, 0, 1542278106, 1542278106);
INSERT INTO `ks_question` VALUES (113, '遇到这种情况不能超车。', '前车正在超车时，后面的车此时超车的话，肯定会导致两车相撞的，所以应该放弃超车。', 'http://file.open.jiakaobaodian.com/tiku/res/811900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542278107, 1542278107);
INSERT INTO `ks_question` VALUES (114, '变换使用远近光灯或鸣喇叭。', '《实施条例》第四十七条：机动车超车时，应当提前开启左转向灯、变换使用远、近光灯或者鸣喇叭。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278108, 1542278108);
INSERT INTO `ks_question` VALUES (115, '驾驶机动车超车后立即开启右转向灯驶回原车道。', '不能立即，应在与被超车辆拉开必要的安全距离后，开启右转向灯驶回原车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278109, 1542278109);
INSERT INTO `ks_question` VALUES (116, '在道路上遇到这种情况可以从两侧超车。', '《中华人民共和国道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', 'http://file.open.jiakaobaodian.com/tiku/res/812200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542278111, 1542278111);
INSERT INTO `ks_question` VALUES (117, '在这种情况下可以加速通过人行横道。', '图中可以看出，人行横道上正在有老人过马路，所以应该是停车等待，等待行人通过后，再驶离人行横道。', 'http://file.open.jiakaobaodian.com/tiku/res/812300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542278112, 1542278112);
INSERT INTO `ks_question` VALUES (118, '遇到这种情况下可以从右侧超车。', '超车只能从左侧超车，任何情况下都是不能从右边超车的。', 'http://file.open.jiakaobaodian.com/tiku/res/812400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 1, 1542278113, 1542331253);
INSERT INTO `ks_question` VALUES (119, '驾驶机动车行经城市没有列车通过的铁路道口时允许超车。', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278114, 1542278114);
INSERT INTO `ks_question` VALUES (120, '陡坡等特殊路段不得超车。', '《道路交通安全法》第四十三条：同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542278115, 1542278115);
INSERT INTO `ks_question` VALUES (121, '遇到这种情形怎样行驶？', '《道路交通安全法实施条例》第四十八条：在没有中心隔离设施或者没有中心线的道路上，在有障碍的路段，无障碍的一方先行；但有障碍的一方已驶入障碍路段而无障碍的一方未驶入时，有障碍的一方先行。', 'http://file.open.jiakaobaodian.com/tiku/res/812700.jpg', 1, '[\"A、开启左转向灯向左行驶\",\"B、开前照灯告知对方让行\",\"C、加速超越障碍后会车\",\"D、停车让对方车辆通过\"]', 1, '3', 1, 1, 4, 0, 0, 1542278116, 1542278116);
INSERT INTO `ks_question` VALUES (122, '驾驶机动车在没有道路中心线的狭窄山路怎样会车？', '《道路交通安全法实施条例》第四十八条：在没有中心隔离设施或者没有中心线的道路上，在狭窄的山路，不靠山体的一方先行。', NULL, 1, '[\"A、速度慢的先行\",\"B、重车让空车先行\",\"C、不靠山体的一方先行\",\"D、靠山体的一方先行\"]', 1, '2', 1, 1, 0, 0, 0, 1542278117, 1542278117);
INSERT INTO `ks_question` VALUES (123, '夜间在道路上会车时，距离对向来车多远将远光灯改用近光灯？', '《实施条例》第四十八条：在没有中心隔离设施或者没有中心线的道路上，夜间会车应当在距相对方向来车150米以外改用近光灯，在窄路、窄桥与非机动车会车时应当使用近光灯。', NULL, 1, '[\"A、不必变换灯光\",\"B、50米以内\",\"C、150米以外\",\"D、100米以内\"]', 1, '2', 1, 1, 0, 0, 0, 1542278119, 1542278119);
INSERT INTO `ks_question` VALUES (124, '驾驶机动车在没有中心线的道路上遇相对方向来车时怎样行驶？', '《实施条例》第四十八条：在没有中心隔离设施或者没有中心线的道路上，机动车遇相对方向来车时应当减速靠右行驶，并与其他车辆、行人保持必要的安全距离。', NULL, 1, '[\"A、减速靠右行驶\",\"B、靠路中心行驶\",\"C、借非机动车道行驶\",\"D、紧靠路边行驶\"]', 1, '0', 1, 1, 0, 0, 0, 1542278120, 1542278120);
INSERT INTO `ks_question` VALUES (125, '窄桥会车怎样使用灯光？', '《实施条例》第四十八条：在没有中心隔离设施或者没有中心线的道路上，机动车夜间会车应当在距相对方向来车150米以外改用近光灯，在窄路、窄桥与非机动车会车时应当使用近光灯。', NULL, 1, '[\"A、开启近光灯\",\"B、关闭前照灯\",\"C、关闭所有灯光\",\"D、开启远光灯\"]', 1, '0', 1, 1, 0, 0, 0, 1542278121, 1542278121);
INSERT INTO `ks_question` VALUES (126, '遇到这种情况可以优先通行。', '《道路交通安全法实施条例》第四十八条：在没有中心隔离设施或者没有中心线的道路上，在有障碍的路段，无障碍的一方先行；但有障碍的一方已驶入障碍路段而无障碍的一方未驶入时，有障碍的一方先行。', 'http://file.open.jiakaobaodian.com/tiku/res/813200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542278122, 1542278122);
INSERT INTO `ks_question` VALUES (127, '未上坡的车辆遇到这种情况让对向下坡车先行。', '《实施条例》第四十八条：在狭窄的坡路，上坡的一方先行；但下坡的一方已行至中途而上坡的一方未上坡时，下坡的一方先行。很明显图中下坡的车已经到了中途，可以先行。', 'http://file.open.jiakaobaodian.com/tiku/res/813300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542278123, 1542278123);
INSERT INTO `ks_question` VALUES (128, '窄桥会车时正确的做法是使用远光灯。', '《实施条例》第四十八条：在没有中心隔离设施或者没有中心线的道路上，机动车夜间会车应当在距相对方向来车150米以外改用近光灯，在窄路、窄桥与非机动车会车时应当使用近光灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542278125, 1542278125);
INSERT INTO `ks_question` VALUES (129, '如何通过这种交叉路口？', '图中路口行人较多，安全起见，应减速慢行。', 'http://file.open.jiakaobaodian.com/tiku/res/813500.jpg', 1, '[\"A、保持速度通过\",\"B、鸣笛催促\",\"C、加速通过\",\"D、减速慢行\"]', 1, '3', 1, 1, 4, 0, 0, 1542278126, 1542278126);
INSERT INTO `ks_question` VALUES (130, '怎样通过这样的路口？', '注意右侧黄底三角标志，前方为无人看守的火车道口，需减速或停车观察。', 'http://file.open.jiakaobaodian.com/tiku/res/813600.jpg', 1, '[\"A、减速或停车观察\",\"B、不减速通过\",\"C、空挡滑行通过\",\"D、加速尽快通过\"]', 1, '0', 1, 1, 4, 0, 0, 1542278127, 1542278127);
INSERT INTO `ks_question` VALUES (131, '在这个路口左转弯选择哪条车道？', '图中最左侧路面上有左转标线，并且两个车道的中间线为虚线，可以跨线变道行驶，所以应选择最左侧车道左转弯。', 'http://file.open.jiakaobaodian.com/tiku/res/813700.jpg', 1, '[\"A、不用变道\",\"B、中间车道\",\"C、最右侧车道\",\"D、最左侧车道\"]', 1, '3', 1, 1, 4, 0, 0, 1542278128, 1542278128);
INSERT INTO `ks_question` VALUES (132, '在这个路口怎样左转弯？', '图中最左侧路面上有左转标线，并且两个车道的中间线为虚线，可以跨线变道行驶，所以应选择最左侧车道左转弯。', 'http://file.open.jiakaobaodian.com/tiku/res/813800.jpg', 1, '[\"A、骑路口中心点转弯\",\"B、靠路口中心点右侧转弯\",\"C、靠路口中心点左侧转弯\",\"D、不能左转弯\"]', 1, '2', 1, 1, 4, 0, 0, 1542278130, 1542278130);
INSERT INTO `ks_question` VALUES (133, '这个路段可以在非机动车道上临时停车。', '在设有禁停标志、标线的路段，在机动车道与非机动车道、人行道之间设有隔离设施的路段以及人行横道、施工地段，不得停车。', 'http://file.open.jiakaobaodian.com/tiku/res/820000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335182, 1542335182);
INSERT INTO `ks_question` VALUES (134, '社会车辆距离消防栓或者消防队（站）门前30米以内的路段不能停车。', '《实施条例》第六十三条，机动车在道路上临时停车，应当遵守下列规定：公共汽车站、急救站、加油站、消防栓或者消防队（站）门前以及距离上述地点30米以内的路段，除使用上述设施的以外，不得停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335183, 1542335183);
INSERT INTO `ks_question` VALUES (135, '隧道50米以内的路段不能停车。', '《实施条例》第六十三条，机动车在道路上临时停车，应当遵守下列规定：交叉路口、铁路道口、急弯路、宽度不足4米的窄路、桥梁、陡坡、隧道以及距离上述地点50米以内的路段，不得停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335185, 1542335185);
INSERT INTO `ks_question` VALUES (136, '距离宽度不足4米的窄路50米以内的路段不能停车。', '《实施条例》第六十三条，机动车在道路上临时停车，应当遵守下列规定：交叉路口、铁路道口、急弯路、宽度不足4米的窄路、桥梁、陡坡、隧道以及距离上述地点50米以内的路段，不得停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335186, 1542335186);
INSERT INTO `ks_question` VALUES (137, '机动车停稳前不能开车门和上下人员。', '停稳后再上下人员，安全第一。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335187, 1542335187);
INSERT INTO `ks_question` VALUES (138, '打开机动车车门时，不得妨碍其他车辆和行人通行。', '《道路交通安全法实施条例》第七十七条，乘坐机动车应当遵守下列规定：(一)不得在机动车道上拦乘机动车；(二)在机动车道上不得从机动车左侧上下车；(三)开关车门不得妨碍其他车辆和行人通行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335188, 1542335188);
INSERT INTO `ks_question` VALUES (139, '在这段高速公路上行驶的最高车速是多少？', '红圈白底，最高限速标志。所以这段高速公路上行驶的最高车速是120公里/小时。', 'http://file.open.jiakaobaodian.com/tiku/res/820600.jpg', 1, '[\"A、120公里/小时\",\"B、90公里/小时\",\"C、60公里/小时\",\"D、100公里/小时\"]', 1, '0', 1, 1, 4, 0, 0, 1542335190, 1542335190);
INSERT INTO `ks_question` VALUES (140, '在这段高速公路上行驶的最低车速是多少？', '红圈白底最高限速标志，蓝底最低限速标志。所以段高速公路上行驶的最低车速是60公里/小时。', 'http://file.open.jiakaobaodian.com/tiku/res/820700.jpg', 1, '[\"A、100公里/小时\",\"B、60公里/小时\",\"C、50公里/小时\",\"D、80公里/小时\"]', 1, '1', 1, 1, 4, 0, 0, 1542335191, 1542335191);
INSERT INTO `ks_question` VALUES (141, '在这条车道行驶的最低车速是多少？', '《实施条例》第七十八条：高速公路应当标明车道的行驶速度，最高车速不得超过每小时120公里，最低车速不得低于每小时60公里。在高速公路上行驶的小型载客汽车最高车速不得超过每小时120公里，其他机动车不得超过每小时100公里，摩托车不得超过每小时80公里。同方向有2条车道的，左侧车道的最低车速为每小时100公里。同方向有3条以上车道的，最左侧车道的最低车速为每小时110公里，中间车道的最低车速为每小时90公里。道路限速标志标明的车速与上述车道行驶车速的规定不一致的，按照道路限速标志标明的车速行驶。我们可以清楚的看出图中的车在同方向车道的左车道，所以最低车速为每小时100公里。', 'http://file.open.jiakaobaodian.com/tiku/res/820800.jpg', 1, '[\"A、100公里/小时\",\"B、110公里/小时\",\"C、60公里/小时\",\"D、90公里/小时\"]', 1, '0', 1, 1, 4, 0, 0, 1542335192, 1542335192);
INSERT INTO `ks_question` VALUES (142, '在这条车道行驶的最高车速是多少？', '标志、标线齐全的路段，按标志、标线行驶。所以最高车速是90公里/小时。', 'http://file.open.jiakaobaodian.com/tiku/res/821000.jpg', 1, '[\"A、110公里/小时\",\"B、120公里/小时\",\"C、90公里/小时\",\"D、100公里/小时\"]', 1, '2', 1, 1, 4, 0, 0, 1542335194, 1542335194);
INSERT INTO `ks_question` VALUES (143, '驾驶小型载客汽车在高速公路行驶的最低车速为90公里/小时。', '《道路交通安全法实施条例》第七十八条：高速公路应当标明车道的行驶速度，最高车速不得超过每小时120公里，最低车速不得低于每小时60公里。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335195, 1542335195);
INSERT INTO `ks_question` VALUES (144, '驾驶机动车在高速公路要按照限速标志标明的车速行驶。', '由于高速公路上车速较快，危险性较高。为了保障安全，一定要严格按照限速标志的车速行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335197, 1542335197);
INSERT INTO `ks_question` VALUES (145, '在这个位置时怎样使用灯光？', '《实施条例》第七十九条：机动车从匝道驶入高速公路，应当开启左转向灯，在不妨碍已在高速公路内的机动车正常行驶的情况下驶入车道。直行不需要使用灯光，进入高速公路需要开左转向灯。', 'http://file.open.jiakaobaodian.com/tiku/res/821300.jpg', 1, '[\"A、开启危险报警闪光灯\",\"B、开启左转向灯\",\"C、开启前照灯\",\"D、开启右转向灯\"]', 1, '1', 1, 1, 4, 0, 0, 1542335198, 1542335198);
INSERT INTO `ks_question` VALUES (146, '进入减速车道时怎样使用灯光？', '减速车道在右侧，应该开启右转向灯提醒后车注意减速避让，然后从虚线处进入减速车道。', 'http://file.open.jiakaobaodian.com/tiku/res/821400.jpg', 1, '[\"A、开启右转向灯\",\"B、开启危险报警闪光灯\",\"C、开启前照灯\",\"D、开启左转向灯\"]', 1, '0', 1, 1, 4, 0, 0, 1542335199, 1542335199);
INSERT INTO `ks_question` VALUES (147, '驾驶小型载客汽车在高速公路上时速超过100公里时的跟车距离是多少？', '《实施条例》第八十条：机动车在高速公路上行驶，车速超过每小时100公里时，应当与同车道前车保持100米以上的距离，车速低于每小时100公里时，与同车道前车距离可以适当缩短，但最小距离不得少于50米。', NULL, 1, '[\"A、保持100米以上\",\"B、保持80米以上\",\"C、保持60米以上\",\"D、保持50米以上\"]', 1, '0', 1, 1, 0, 0, 0, 1542335200, 1542335200);
INSERT INTO `ks_question` VALUES (148, '驾驶小型载客汽车在高速公路上时速低于100公里时的最小跟车距离是多少？', '《实施条例》第八十条：机动车在高速公路上行驶，车速超过每小时100公里时，应当与同车道前车保持100米以上的距离，车速低于每小时100公里时，与同车道前车距离可以适当缩短，但最小距离不得少于50米。', NULL, 1, '[\"A、不得少于30米\",\"B、不得少于10米\",\"C、不得少于20米\",\"D、不得少于50米\"]', 1, '3', 1, 1, 0, 0, 0, 1542335201, 1542335201);
INSERT INTO `ks_question` VALUES (149, '驾驶机动车在高速公路遇到能见度低于200米的气象条件时，最高车速是多少？', '《实施条例》第八十一条：机动车在高速公路上行驶，遇有雾、雨、雪、沙尘、冰雹等低能见度气象条件时，应当遵守下列规定：能见度小于200米时，开启雾灯、近光灯、示廓灯和前后位灯，车速不得超过每小时60公里，与同车道前车保持100米以上的距离。', NULL, 1, '[\"A、不得超过60公里/小时\",\"B、不得超过90公里/小时\",\"C、不得超过100公里/小时\",\"D、不得超过80公里/小时\"]', 1, '0', 1, 1, 0, 0, 0, 1542335202, 1542335202);
INSERT INTO `ks_question` VALUES (150, '驾驶机动车在高速公路遇到能见度低于100米的气象条件时，最高车速是多少？', '《实施条例》第八十一条:机动车在高速公路上行驶，遇有雾、雨、雪、沙尘、冰雹等低能见度气象条件时，应当遵守下列规定：(一)能见度小于200米时，开启雾灯、近光灯、示廓灯和前后位灯，车速不得超过每小时60公里，与同车道前车保持100米以上的距离；(二)能见度小于100米时，开启雾灯、近光灯、示廓灯、前后位灯和危险报警闪光灯，车速不得超过每小时40公里，与同车道前车保持50米以上的距离。', NULL, 1, '[\"A、不得超过40公里/小时\",\"B、不得超过90公里/小时\",\"C、不得超过60公里/小时\",\"D、不得超过80公里/小时\"]', 1, '0', 1, 1, 0, 0, 0, 1542335204, 1542335204);
INSERT INTO `ks_question` VALUES (151, '驾驶机动车在高速公路遇到能见度低于50米的气象条件时，车速不得超过20公里/小时，还应怎么做？', '《实施条例》第八十一条:机动车在高速公路上行驶，遇有雾、雨、雪、沙尘、冰雹等低能见度气象条件时，应当遵守下列规定：(一)能见度小于200米时，开启雾灯、近光灯、示廓灯和前后位灯，车速不得超过每小时60公里，与同车道前车保持100米以上的距离；(二)能见度小于100米时，开启雾灯、近光灯、示廓灯、前后位灯和危险报警闪光灯，车速不得超过每小时40公里，与同车道前车保持50米以上的距离；(三)能见度小于50米时，开启雾灯、近光灯、示廓灯、前后位灯和危险报警闪光灯，车速不得超过每小时20公里，并从最近的出口尽快驶离高速公路。', NULL, 1, '[\"A、进入应急车道行驶\",\"B、尽快在路边停车\",\"C、尽快驶离高速公路\",\"D、在路肩低速行驶\"]', 1, '2', 1, 1, 0, 0, 0, 1542335205, 1542335205);
INSERT INTO `ks_question` VALUES (152, '驾驶机动车驶离高速公路时，在这个位置怎样行驶？', '打开右转向灯，提醒后车注意减速，然后从虚线处进入减速车道。', 'http://file.open.jiakaobaodian.com/tiku/res/822000.jpg', 1, '[\"A、车速降到40公里/小时以下\",\"B、车速保持100公里/小时\",\"C、继续向前行驶\",\"D、驶入减速车道\"]', 1, '3', 1, 1, 4, 0, 0, 1542335206, 1542335206);
INSERT INTO `ks_question` VALUES (153, '可以从这个位置直接驶入高速公路行车道。', '《实施条例》第七十九条：机动车从匝道驶入高速公路，应当开启左转向灯，在不妨碍已在高速公路内的机动车正常行驶的情况下驶入车道。本题中“蓝箭头”虽然往“左”进入高速公路，但是压白线了！', 'http://file.open.jiakaobaodian.com/tiku/res/822100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335207, 1542335207);
INSERT INTO `ks_question` VALUES (154, '驶离高速公路可以从这个位置直接驶入匝道。', '白色实线不能压，只能继续前行寻找下个出口。', 'http://file.open.jiakaobaodian.com/tiku/res/822200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335208, 1542335208);
INSERT INTO `ks_question` VALUES (155, '这辆小型载客汽车进入高速公路行车道的行为是正确的。', '此车压实线，不按标线要求行车。', 'http://file.open.jiakaobaodian.com/tiku/res/822300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335209, 1542335209);
INSERT INTO `ks_question` VALUES (156, '这辆小型载客汽车驶离高速公路行车道的方法是正确的。', '开了右转向灯，也是从虚线地方进入减速车道，是正确的做法。', 'http://file.open.jiakaobaodian.com/tiku/res/822400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542335211, 1542335211);
INSERT INTO `ks_question` VALUES (157, '这辆在高速公路上临时停放的故障车，警告标志应该设置在车后多远处？', '《道路交通安全法》第六十八条：机动车在高速公路上发生故障时，应当依照本法第五十二条的有关规定办理;但是，警告标志应当设置在故障车来车方向一百五十米以外，车上人员应当迅速转移到右侧路肩上或者应急车道内，并且迅速报警。', 'http://file.open.jiakaobaodian.com/tiku/res/822500.jpg', 1, '[\"A、50米以内\",\"B、50～150米\",\"C、50～100米\",\"D、150米以外\"]', 1, '3', 1, 1, 4, 0, 0, 1542335212, 1542335212);
INSERT INTO `ks_question` VALUES (158, '机动车在高速公路上发生故障时错误的做法是什么？', '《道路交通安全法》第六十八条：机动车在高速公路上发生故障时，应当依照本法第五十二条的有关规定办理；但是，警告标志应当设置在故障车来车方向一百五十米以外，车上人员应当迅速转移到右侧路肩上或者应急车道内，并且迅速报警。这里要注意的是，题目需要我们选择错误的做法。', NULL, 1, '[\"A、迅速报警\",\"B、开启危险报警闪光灯\",\"C、按规定设置警告标志\",\"D、车上人员不能下车\"]', 1, '3', 1, 1, 0, 0, 0, 1542335213, 1542335213);
INSERT INTO `ks_question` VALUES (159, '机动车在高速公路上发生故障或交通事故无法正常行驶时由什么车拖曳或牵引？', '《道路交通安全法》第六十八条：机动车在高速公路上发生故障时，应当依照本法第五十二条的有关规定办理；但是，警告标志应当设置在故障车来车方向一百五十米以外，车上人员应当迅速转移到右侧路肩上或者应急车道内，并且迅速报警。机动车在高速公路上发生故障或者交通事故，无法正常行驶的，应当由救援车、清障车拖曳、牵引。', NULL, 1, '[\"A、同行车\",\"B、过路车\",\"C、清障车\",\"D、大客车\"]', 1, '2', 1, 1, 0, 0, 0, 1542335214, 1542335214);
INSERT INTO `ks_question` VALUES (160, '机动车在高速公路上发生故障时，在来车方向50至100米处设置警告标志。', '《道路交通安全法》第六十八条：机动车在高速公路上发生故障时，应当依照本法第五十二条的有关规定办理；但是，警告标志应当设置在故障车来车方向一百五十米以外，车上人员应当迅速转移到右侧路肩上或者应急车道内，并且迅速报警。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335215, 1542335215);
INSERT INTO `ks_question` VALUES (161, '机动车在高速公路上发生故障时，将车上人员迅速转移到右侧路肩上或者应急车道内，并且迅速报警。', '《道路交通安全法》第六十八条：机动车在高速公路上发生故障时，应当依照本法第五十二条的有关规定办理；警告标志应当设置在故障车来车方向一百五十米以外，车上人员应当迅速转移到右侧路肩上或者应急车道内，并且迅速报警。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335216, 1542335216);
INSERT INTO `ks_question` VALUES (162, '牵引。', '《道路交通安全法》第六十八条：机动车在高速公路上发生故障或者交通事故，无法正常行驶的，应当由救援车、清障车拖曳、牵引。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335217, 1542335217);
INSERT INTO `ks_question` VALUES (163, '在道路上发生未造成人员伤亡且无争议的轻微交通事故如何处置？', '《交通安全法》第七十条：在道路上发生交通事故，车辆驾驶人应当立即停车，保护现场；造成人身伤亡的，车辆驾驶人应当立即抢救受伤人员，并迅速报告执勤的交通警察或者公安机关交通管理部门。因抢救受伤人员变动现场的，应当标明位置。乘车人、过往车辆驾驶人、过往行人应当予以协助。在道路上发生交通事故，未造成人身伤亡，当事人对事实及成因无争议的，可以即行撤离现场，恢复交通，自行协商处理损害赔偿事宜；不即行撤离现场的，应当迅速报告执勤的交通警察或者公安机关交通管理部门。在道路上发生交通事故，仅造成轻微财产损失，并且基本事实清楚的，当事人应当先撤离现场再进行协商处理。', NULL, 1, '[\"A、保护好现场再协商\",\"B、疏导其他车辆绕行\",\"C、撤离现场自行协商\",\"D、不要移动车辆\"]', 1, '2', 1, 1, 0, 0, 0, 1542335219, 1542335219);
INSERT INTO `ks_question` VALUES (164, '驾驶机动车在道路上发生交通事故要立即将车移到路边。', '《交通安全法》第七十条：在道路上发生交通事故，车辆驾驶人应当立即停车，保护现场；造成人身伤亡的，车辆驾驶人应当立即抢救受伤人员，并迅速报告执勤的交通警察或者公安机关交通管理部门。因抢救受伤人员变动现场的，应当标明位置。乘车人、过往车辆驾驶人、过往行人应当予以协助。在道路上发生交通事故，未造成人身伤亡，当事人对事实及成因无争议的，可以即行撤离现场，恢复交通，自行协商处理损害赔偿事宜；不即行撤离现场的，应当迅速报告执勤的交通警察或者公安机关交通管理部门。在道路上发生交通事故，仅造成轻微财产损失，并且基本事实清楚的，当事人应当先撤离现场再进行协商处理。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335220, 1542335220);
INSERT INTO `ks_question` VALUES (165, '驾驶人在发生交通事故后因抢救伤员变动现场时要标明位置。', '《交通安全法》第七十条：在道路上发生交通事故，车辆驾驶人应当立即停车，保护现场；造成人身伤亡的，车辆驾驶人应当立即抢救受伤人员，并迅速报告执勤的交通警察或者公安机关交通管理部门。因抢救受伤人员变动现场的，应当标明位置。乘车人、过往车辆驾驶人、过往行人应当予以协助。在道路上发生交通事故，未造成人身伤亡，当事人对事实及成因无争议的，可以即行撤离现场，恢复交通，自行协商处理损害赔偿事宜；不即行撤离现场的，应当迅速报告执勤的交通警察或者公安机关交通管理部门。在道路上发生交通事故，仅造成轻微财产损失，并且基本事实清楚的，当事人应当先撤离现场再进行协商处理。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335221, 1542335221);
INSERT INTO `ks_question` VALUES (166, '在道路上发生交通事故造成人身伤亡时，要立即抢救受伤人员并迅速报警。', '《交通安全法》第七十条：在道路上发生交通事故，车辆驾驶人应当立即停车，保护现场；造成人身伤亡的，车辆驾驶人应当立即抢救受伤人员，并迅速报告执勤的交通警察或者公安机关交通管理部门。因抢救受伤人员变动现场的，应当标明位置。乘车人、过往车辆驾驶人、过往行人应当予以协助。在道路上发生交通事故，未造成人身伤亡，当事人对事实及成因无争议的，可以即行撤离现场，恢复交通，自行协商处理损害赔偿事宜；不即行撤离现场的，应当迅速报告执勤的交通警察或者公安机关交通管理部门。在道路上发生交通事故，仅造成轻微财产损失，并且基本事实清楚的，当事人应当先撤离现场再进行协商处理。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335222, 1542335222);
INSERT INTO `ks_question` VALUES (167, '驾驶人连续驾驶不得超过多长时间？', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 1, '[\"A、10小时\",\"B、4小时\",\"C、8小时\",\"D、6小时\"]', 1, '1', 1, 1, 0, 0, 0, 1542335223, 1542335223);
INSERT INTO `ks_question` VALUES (168, '驾驶人连续驾驶4小时以上，停车休息的时间不得少于多少？', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 1, '[\"A、20分钟\",\"B、15分钟\",\"C、5分钟\",\"D、10分钟\"]', 1, '0', 1, 1, 0, 0, 0, 1542335224, 1542335224);
INSERT INTO `ks_question` VALUES (169, '在什么情况下不得行车？', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 1, '[\"A、音响没关闭\",\"B、车窗没关闭\",\"C、车门没关闭\",\"D、顶窗没关闭\"]', 1, '2', 1, 1, 0, 0, 0, 1542335225, 1542335225);
INSERT INTO `ks_question` VALUES (170, '驾驶机动车下陡坡时不得有哪些危险行为？', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 1, '[\"A、制动减速\",\"B、提前减挡\",\"C、空挡滑行\",\"D、低挡行驶\"]', 1, '2', 1, 1, 0, 0, 0, 1542335227, 1542335227);
INSERT INTO `ks_question` VALUES (171, '在这段道路上一定要减少鸣喇叭的频率。', '右侧的标志是禁止鸣喇叭，而减少不等于禁止。', 'http://file.open.jiakaobaodian.com/tiku/res/823900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335228, 1542335228);
INSERT INTO `ks_question` VALUES (172, '车厢没有关好时不要驾驶机动车起步。', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335229, 1542335229);
INSERT INTO `ks_question` VALUES (173, '不要在驾驶室的前后窗范围内悬挂和放置妨碍驾驶人视线的物品。', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335231, 1542335231);
INSERT INTO `ks_question` VALUES (174, '行车中在道路情况良好的条件下可以观看车载视频。', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335232, 1542335232);
INSERT INTO `ks_question` VALUES (175, '驾驶小型汽车下陡坡时允许熄火滑行。', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335234, 1542335234);
INSERT INTO `ks_question` VALUES (176, '驾驶机动车时可以向道路上抛撒物品。', '《实施条例》第六十二条，驾驶机动车不得有下列行为：(一)在车门、车厢没有关好时行车；(二)在机动车驾驶室的前后窗范围内悬挂、放置妨碍驾驶人视线的物品；(三)拨打接听手持电话、观看电视等妨碍安全驾驶的行为；(四)下陡坡时熄火或者空挡滑行；(五)向道路上抛撒物品；(六)驾驶摩托车手离车把或者在车把上悬挂物品；(七)连续驾驶机动车超过4小时未停车休息或者停车休息时间少于20分钟；(八)在禁止鸣喇叭的区域或者路段鸣喇叭。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335236, 1542335236);
INSERT INTO `ks_question` VALUES (177, '初次申领的机动车驾驶证的有效期为多少年？', '初次申领的机动车驾驶证的有效期为6年，每个计分周期均未达到12分的，换发10年的。', NULL, 1, '[\"A、5年\",\"B、12年\",\"C、3年\",\"D、6年\"]', 1, '3', 1, 1, 0, 0, 0, 1542335237, 1542335237);
INSERT INTO `ks_question` VALUES (178, '准驾车型为小型汽车的，可以驾驶下列哪种车辆？', '准驾车型为小型汽车的，可以驾驶：小型、微型载客汽车以及轻型、微型载货汽车，轻型、微型专项作业车小型、微型自动挡载客汽车以及轻型、微型自动挡载货汽车低速载货汽车三轮汽车提示：C1准予驾驶C2、C3、C4准驾车型。', NULL, 1, '[\"A、轮式自行机械\",\"B、中型客车\",\"C、低速载货汽车\",\"D、三轮摩托车\"]', 1, '2', 1, 1, 0, 0, 0, 1542335238, 1542335238);
INSERT INTO `ks_question` VALUES (179, '准驾车型为小型自动挡汽车的，可以驾驶以下哪种车型？', '小型自动挡汽车（C2）准驾车型：小型、微型自动挡载客汽车以及轻型、微型自动挡载货汽车。', NULL, 1, '[\"A、二轮摩托车\",\"B、低速载货汽车\",\"C、小型汽车\",\"D、轻型自动挡载货汽车\"]', 1, '3', 1, 1, 0, 0, 0, 1542335239, 1542335239);
INSERT INTO `ks_question` VALUES (180, '驾驶人在机动车驾驶证的6年有效期内，每个记分周期均未达到12分的，换发10年有效期的机动车驾驶证。', '《公安部令第123号》第四十七条：机动车驾驶人在机动车驾驶证的六年有效期内，每个记分周期均未记满12分的，换发十年有效期的机动车驾驶证。在机动车驾驶证的十年有效期内，每个记分周期均未记满12分的，换发长期有效的机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335241, 1542335241);
INSERT INTO `ks_question` VALUES (181, '20年。', '《公安部令第123号》第十条：机动车驾驶证有效期分为六年、十年和长期。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335242, 1542335242);
INSERT INTO `ks_question` VALUES (182, '准驾车型为小型汽车的，可以驾驶小型自动挡载客汽车。', '准驾车型为小型汽车的，可以驾驶：小型、微型载客汽车以及轻型、微型载货汽车，轻型、微型专项作业车小型、微型自动挡载客汽车以及轻型、微型自动挡载货汽车低速载货汽车三轮汽车提示：C1准予驾驶C2、C3、C4准驾车型。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335243, 1542335243);
INSERT INTO `ks_question` VALUES (183, '准驾车型为小型自动挡汽车的，可以驾驶低速载货汽车。', '小型自动挡汽车（C2）准驾车型：小型、微型自动挡载客汽车以及轻型、微型自动挡载货汽车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335244, 1542335244);
INSERT INTO `ks_question` VALUES (184, '初次申领的机动车驾驶证的有效期为6年。', '初次申领的机动车驾驶证的有效期为6年，每个计分周期均未达到12分的，换发10年的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335245, 1542335245);
INSERT INTO `ks_question` VALUES (185, '初次申领的机动车驾驶证的有效期为4年。', '初次申领的机动车驾驶证的有效期6年，每个计分周期均未达到12分的，换发10年的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335246, 1542335246);
INSERT INTO `ks_question` VALUES (186, '初次申领机动车驾驶证的，可以申请下列哪种准驾车型？', '《公安部令第123号》第十三条：初次申领机动车驾驶证的，可以申请准驾车型为城市公交车、大型货车、小型汽车、小型自动挡汽车、低速载货汽车、三轮汽车、残疾人专用小型自动挡载客汽车、普通三轮摩托车、普通二轮摩托车、轻便摩托车、轮式自行机械车、无轨电车、有轨电车的机动车驾驶证。', NULL, 1, '[\"A、大型客车\",\"B、普通三轮摩托车\",\"C、中型客车\",\"D、牵引车\"]', 1, '1', 1, 1, 0, 0, 0, 1542335247, 1542335247);
INSERT INTO `ks_question` VALUES (187, '年满20周岁，可以初次申请下列哪种准驾车型？', '年满20周岁，可以初次申请城市公交车、大型货车、无轨电车或者有轨电车准驾车型。', NULL, 1, '[\"A、牵引车\",\"B、大型客车\",\"C、大型货车\",\"D、中型客车\"]', 1, '2', 1, 1, 0, 0, 0, 1542335248, 1542335248);
INSERT INTO `ks_question` VALUES (188, '直角转弯。', '《公安部令第123号》第二十五条科目二考试内容包括：小型汽车、小型自动挡汽车、残疾人专用小型自动挡载客汽车和低速载货汽车考试倒车入库、坡道定点停车和起步、侧方停车、曲线行驶、直角转弯。省级公安机关交通管理部门可以根据实际增加考试内容。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335250, 1542335250);
INSERT INTO `ks_question` VALUES (189, '科目三考试分为道路驾驶技能考试和安全文明驾驶常识考试两部分。', '《公安部令第123号》第二十二条机动车驾驶人考试内容分为道路交通安全法律、法规和相关知识考试科目(以下简称“科目一”)、场地驾驶技能考试科目(以下简称“科目二”)、道路驾驶技能和安全文明驾驶常识考试科目(以下简称“科目三”)。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335251, 1542335251);
INSERT INTO `ks_question` VALUES (190, '科目三道路驾驶技能和安全文明驾驶常识考试满分分别为100分，成绩分别达到80和90分的为合格。', '《公安部令第123号》第三十条第三项：科目三道路驾驶技能和安全文明驾驶常识考试满分分别为100分，成绩分别达到90分的为合格。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335252, 1542335252);
INSERT INTO `ks_question` VALUES (191, '在驾驶技能准考证明的有效期内，科目二和科目三道路驾驶技能考试预约次数不得超过多少次？', '《公安部令第123》第三十七条：在驾驶技能准考证明有效期内，科目二和科目三道路驾驶技能考试预约考试的次数不得超过五次。第五次预约考试仍不合格的，已考试合格的其他科目成绩作废。', NULL, 1, '[\"A、5次\",\"B、4次\",\"C、6次\",\"D、3次\"]', 1, '0', 1, 1, 0, 0, 0, 1542335253, 1542335253);
INSERT INTO `ks_question` VALUES (192, '驾驶技能准考证明的有效期是多久？', '《公安部令第123号》第三十二条：驾驶技能准考证明的有效期为三年，申请人应当在有效期内完成科目二和科目三考试。未在有效期内完成考试的，已考试合格的科目成绩作废。', NULL, 1, '[\"A、3年\",\"B、4年\",\"C、2年\",\"D、1年\"]', 1, '0', 1, 1, 0, 0, 0, 1542335254, 1542335254);
INSERT INTO `ks_question` VALUES (193, '申请人因故不能按照预约时间参加考试的，应当提前一日申请取消预约，对申请人未按照预约考试时间参加考试的，判定该次考试不合格。', '《公安部令第123号》第三十六条：申请人因故不能按照预约时间参加考试的，应当提前一日申请取消预约。对申请人未按照预约考试时间参加考试的，判定该次考试不合格。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335255, 1542335255);
INSERT INTO `ks_question` VALUES (194, '损毁无法辨认时，机动车驾驶人应当向机动车驾驶证核发地车辆管理所申请补发。', '驾驶证遗失、损毁无法辨认时应当向核发地车辆管理所申请补发。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335256, 1542335256);
INSERT INTO `ks_question` VALUES (195, '注射毒品后驾驶驾车行为的机动车驾驶人，不会被注销驾驶证。', '新交规对吸毒和注射毒品是零容忍,将注销其驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335257, 1542335257);
INSERT INTO `ks_question` VALUES (196, '社区康复措施，车辆管理所将注销其驾驶证。', '新交规规定对吸毒者是零忍耐，将注销其驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335259, 1542335259);
INSERT INTO `ks_question` VALUES (197, '换领。', '登记证书、号牌、行驶证是车辆信息，申领的时候在登记地车辆管理所，补办的时候当然也在登记地车辆管理所。', NULL, 1, '[\"A、住地交警支队车辆管理所\",\"B、驾驶证核发地车辆管理所\",\"C、当地公安局\",\"D、登记地车辆管理所\"]', 1, '3', 1, 1, 0, 0, 0, 1542335260, 1542335260);
INSERT INTO `ks_question` VALUES (198, '机动车购买后尚未注册登记，需要临时上道路行驶的，可以凭什么临时上道路行驶？', '《道路交通安全法》第八条：国家对机动车实行登记制度。机动车经公安机关交通管理部门登记后，方可上道路行驶。尚未登记的机动车，需要临时上道路行驶的，应当取得临时通行牌证。', NULL, 1, '[\"A、借用的机动车号牌\",\"B、临时行驶车号牌\",\"C、合法来源凭证\",\"D、法人单位证明\"]', 1, '1', 1, 1, 0, 0, 0, 1542335262, 1542335262);
INSERT INTO `ks_question` VALUES (199, '贿赂等不正当手段取得机动车驾驶证的（被撤销的），申请人在多长时间内不得再次申领机动车驾驶证。', '《公安部令第123号》第七十八条：申请人以欺骗、贿赂等不正当手段取得机动车驾驶证的，公安机关交通管理部门收缴机动车驾驶证，撤销机动车驾驶许可；申请人在三年内不得再次申领机动车驾驶证。', NULL, 1, '[\"A、6个月\",\"B、2年\",\"C、1年\",\"D、3年\"]', 1, '3', 1, 1, 0, 0, 0, 1542335263, 1542335263);
INSERT INTO `ks_question` VALUES (200, '舞弊行为的，取消考试资格，已经通过考试的其他科目成绩无效。', '《公安部令第123号》第七十八条申请人在考试过程中有贿赂、舞弊行为的，取消考试资格，已经通过考试的其他科目成绩无效;申请人在一年内不得再次申领机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335264, 1542335264);
INSERT INTO `ks_question` VALUES (201, '驾驶机动车跨越双实线行驶属于什么行为？', '驾驶机动车跨越双实线行驶是违反《交通安全法》的行为，是违法行为。', NULL, 1, '[\"A、违法行为\",\"B、过失行为\",\"C、违章行为\",\"D、违规行为\"]', 1, '0', 1, 1, 0, 0, 0, 1542335265, 1542335265);
INSERT INTO `ks_question` VALUES (202, '驾驶机动车在人行横道上临时停车属于违法行为。', '在人行横道上临时停车属于违法行为。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335266, 1542335266);
INSERT INTO `ks_question` VALUES (203, '这个标志是何含义？', '警告标志前方有向上的陡坡路段，行车注意安全。', 'http://file.open.jiakaobaodian.com/tiku/res/827200.jpg', 1, '[\"A、提醒车辆驾驶人前方有向下的陡坡路段\",\"B、提醒车辆驾驶人前方有两个及以上的连续上坡路段\",\"C、提醒车辆驾驶人前方有向上的陡坡路段\",\"D、提醒车辆驾驶人前方道路沿水库、湖泊、河流\"]', 1, '2', 1, 1, 4, 0, 0, 1542335268, 1542335268);
INSERT INTO `ks_question` VALUES (204, '死亡，可能会受到什么刑罚？', '《中华人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。题中只说了“违反交通运输管理法规发生重大事故致人重伤、死亡”，并无其他情节，所以是【处3年以下徒刑或者拘役】。', NULL, 1, '[\"A、处3年以下徒刑或者拘役\",\"B、处5年以上徒刑\",\"C、处3年以上7年以下徒刑\",\"D、处7年以上徒刑\"]', 1, '0', 1, 1, 0, 0, 0, 1542335269, 1542335269);
INSERT INTO `ks_question` VALUES (205, '驾驶人违反交通运输管理法规发生重大事故使公私财产遭受重大损失，可能会受到什么刑罚？', '《中华人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。题中说了“使公私财产遭受重大损失”，依照法规，处3年以下徒刑或者拘役。', NULL, 1, '[\"A、处3年以下徒刑或者拘役\",\"B、处5年以上徒刑\",\"C、处3年以上7年以下徒刑\",\"D、处3年以上徒刑\"]', 1, '0', 1, 1, 0, 0, 0, 1542335270, 1542335270);
INSERT INTO `ks_question` VALUES (206, '驾驶人违反交通运输管理法规发生重大事故致人重伤的可能判处3年以下徒刑或拘役。', '《中华人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。很明显是对的嘛！', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335271, 1542335271);
INSERT INTO `ks_question` VALUES (207, '驾驶人违反交通运输管理法规发生重大事故致人死亡的处3年以上有期徒刑。', '《中华人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。依据法规是3年以下哦，对人要宽容，导致他人伤亡是谁也不愿意见到的，题目中没有提到逃逸，所以，是三年以下。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335272, 1542335272);
INSERT INTO `ks_question` VALUES (208, '驾驶人违反交通运输管理法规发生重大事故使公私财产遭受重大损失的可能处3年以下徒刑或拘役。', '《中华人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335273, 1542335273);
INSERT INTO `ks_question` VALUES (209, '驾驶人违反交通运输管理法规发生重大事故致人死亡且逃逸的，处多少年有期徒刑？', '《中华人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。看清楚了，他是“致人死亡且逃逸”，不是“因逃逸致人死亡”，所以是【3年以上7年以下】。如果是“因逃逸致人死亡”，那就是7年以上了。', NULL, 1, '[\"A、7年以上\",\"B、3年以上7年以下\",\"C、10年以上\",\"D、3年以下\"]', 1, '1', 1, 1, 0, 0, 0, 1542335274, 1542335274);
INSERT INTO `ks_question` VALUES (210, '驾驶人违反交通运输管理法规发生重大事故后，因逃逸致人死亡的，处多少年有期徒刑？', '《中华人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。看清楚了，他是“因逃逸致人死亡”，比“致人死亡后逃逸”，情况严重，依据法规是7年以上。', NULL, 1, '[\"A、7年以上\",\"B、2年以下\",\"C、3年以下\",\"D、7年以下\"]', 1, '0', 1, 1, 0, 0, 0, 1542335275, 1542335275);
INSERT INTO `ks_question` VALUES (211, '驾驶人违反交通运输管理法规发生重大事故后，逃逸或者有其他特别恶劣情节的，处7年以上有期徒刑。', '《中华人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑，不是7年以上。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335277, 1542335277);
INSERT INTO `ks_question` VALUES (212, '驾驶人违反交通运输管理法规发生重大事故后，因逃逸致人死亡的，处3年以上7年以下有期徒刑。', '《中华国人民共和国刑法》第一百三十三条：违反交通运输管理法规，因而发生重大事故，致人重伤、死亡或者使公私财产遭受重大损失的，处三年以下有期徒刑或者拘役；交通运输肇事后逃逸或者有其他特别恶劣情节的，处三年以上七年以下有期徒刑；因逃逸致人死亡的，处七年以上有期徒刑。看清题目是因逃逸致人死亡的，不是先死亡再逃逸的，所以应该是7年以上。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335278, 1542335278);
INSERT INTO `ks_question` VALUES (213, '驾驶机动车在道路上追逐竞驶，情节恶劣，会受到什么处罚？', '2011年《刑法修正案（八）》第二十二条：在刑法第一百三十三条后增加一条，作为第一百三十三条之一：“在道路上驾驶机动车追逐竞驶，情节恶劣的，或者在道路上醉酒驾驶机动车的，处拘役，并处罚金。”所以，选择【处拘役，并处罚金】。', NULL, 1, '[\"A、处管制，并处罚金\",\"B、处拘役，并处罚金\",\"C、处6个月徒刑\",\"D、处1年以上徒刑\"]', 1, '1', 1, 1, 0, 0, 0, 1542335279, 1542335279);
INSERT INTO `ks_question` VALUES (214, '驾驶人在道路上驾驶机动车追逐竞驶，情节恶劣的处3年以下有期徒刑。', '《刑法修正案（八）》第二十二在刑法第一百三十三条后增加一条，作为第一百三十三条之一：“在道路上驾驶机动车追逐竞驶，情节恶劣的，或者在道路上醉酒驾驶机动车的，处拘役，并处罚金。亲，只会“处拘役，并处罚金”，没有严重到判刑。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335280, 1542335280);
INSERT INTO `ks_question` VALUES (215, '醉酒驾驶机动车在道路上行驶会受到什么处罚？', '《中华人民共和国刑法修正案（八）》第二十二条规定，在刑法第一百三十三条后增加一条，作为第一百三十三条之一，设定“危险驾驶罪”，将醉酒驾驶机动车、驾驶机动车追逐竞驶等交通违法行为纳入刑法调整范围。醉酒驾驶机动车将被处以一个月以上六个月以下拘役，并处罚金。三年以下的刑罚理论上可以适用缓刑（缓刑还是实刑是由法院判决）。醉酒驾驶机动车辆，吊销驾照，5年内不得重新获取驾照，经过判决后处以拘役，并处罚金。所以本题答案是【处拘役，并处罚金】。', NULL, 1, '[\"A、处2年以上徒刑\",\"B、处拘役，并处罚金\",\"C、处管制，并处罚金\",\"D、处2年以下徒刑\"]', 1, '1', 1, 1, 0, 0, 0, 1542335281, 1542335281);
INSERT INTO `ks_question` VALUES (216, '驾驶人在道路上醉酒驾驶机动车的处3年以上有期徒刑。', '《道路交通安全法》第九十一条：饮酒后驾驶机动车的，处暂扣六个月机动车驾驶证，并处一千元以上二千元以下罚款。因饮酒后驾驶机动车被处罚，再次饮酒后驾驶机动车的，处十日以下拘留，并处一千元以上二千元以下罚款，吊销机动车驾驶证。醉酒驾驶机动车的，由公安机关交通管理部门约束至酒醒，吊销机动车驾驶证，依法追究刑事责任；五年内不得重新取得机动车驾驶证。饮酒后驾驶营运机动车的，处十五日拘留，并处五千元罚款，吊销机动车驾驶证，五年内不得重新取得机动车驾驶证。醉酒驾驶营运机动车的，由公安机关交通管理部门约束至酒醒，吊销机动车驾驶证，依法追究刑事责任；十年内不得重新取得机动车驾驶证，重新取得机动车驾驶证后，不得驾驶营运机动车。饮酒后或者醉酒驾驶机动车发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证，终生不得重新取得机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335282, 1542335282);
INSERT INTO `ks_question` VALUES (217, '上道路行驶的机动车有哪种情形交通警察可依法扣留车辆？', '《交通安全法》第九十五条：上道路行驶的机动车未悬挂机动车号牌，未放置检验合格标志、保险标志，或者未随车携带行驶证、驾驶证的，公安机关交通管理部门应当扣留机动车，通知当事人提供相应的牌证、标志或者补办相应手续，并可以依照本法第九十条的规定予以处罚。当事人提供相应的牌证、标志或者补办相应手续的，应当及时退还机动车。故意遮挡、污损或者不按规定安装机动车号牌的，依照本法第九十条的规定予以处罚。', NULL, 1, '[\"A、未携带保险合同\",\"B、未携带身份证\",\"C、未悬挂机动车号牌\",\"D、未放置城市环保标志\"]', 1, '2', 1, 1, 0, 0, 0, 1542335283, 1542335283);
INSERT INTO `ks_question` VALUES (218, '驾驶人未携带哪种证件驾驶机动车上路，交通警察可依法扣留车辆？', '《道路交通安全法》第九十五条:上道路行驶的机动车未悬挂机动车号牌，未放置检验合格标志、保险标志，或者未随车携带行驶证、驾驶证的，公安机关交通管理部门应当扣留机动车，通知当事人提供相应的牌证、标志或者补办相应手续，并可以依照本法第九十条的规定予以处罚。当事人提供相应的牌证、标志或者补办相应手续的，应当及时退还机动车。', NULL, 1, '[\"A、居民身份证\",\"B、机动车驾驶证\",\"C、从业资格证\",\"D、机动车通行证\"]', 1, '1', 1, 1, 0, 0, 0, 1542335287, 1542335287);
INSERT INTO `ks_question` VALUES (219, '对未放置检验合格标志上道路行驶的车辆，交通警察可依法予以扣留。', '《道路交通安全法》第九十五条:上道路行驶的机动车未悬挂机动车号牌，未放置检验合格标志、保险标志，或者未随车携带行驶证、驾驶证的，公安机关交通管理部门应当扣留机动车，通知当事人提供相应的牌证、标志或者补办相应手续，并可以依照本法第九十条的规定予以处罚。当事人提供相应的牌证、标志或者补办相应手续的，应当及时退还机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335290, 1542335290);
INSERT INTO `ks_question` VALUES (220, '交通警察对未放置保险标志上道路行驶的车辆可依法扣留行驶证。', '《道路交通安全法》第九十五条：上道路行驶的机动车未悬挂机动车号牌，未放置检验合格标志、保险标志，或者未随车携带行驶证、驾驶证的，公安机关交通管理部门应当扣留机动车，通知当事人提供相应的牌证、标志或者补办相应手续，并可以依照本法第九十条的规定予以处罚。是扣留车辆，不是扣留行驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335291, 1542335291);
INSERT INTO `ks_question` VALUES (221, '行驶证嫌疑的车辆，交通警察可依法予以扣留。', '《道路交通安全法》第九十六条:伪造、变造或者使用伪造、变造的机动车登记证书、号牌、行驶证、驾驶证的，由公安机关交通管理部门予以收缴，扣留该机动车，处15日以下拘留，并处2000元以上5000元以下罚款；构成犯罪的，依法追究刑事责任。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335292, 1542335292);
INSERT INTO `ks_question` VALUES (222, '对有使用伪造或变造检验合格标志嫌疑的车辆，交通警察只进行罚款处罚。', '《道路交通安全法》第九十六条:伪造、变造或者使用伪造、变造的检验合格标志、保险标志的，由公安机关交通管理部门予以收缴，扣留该机动车，处10日以下拘留，并处1000元以上3000元以下罚款；构成犯罪的，依法追究刑事责任。不仅会罚款，还会被扣留机动车以及受到拘留。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335293, 1542335293);
INSERT INTO `ks_question` VALUES (223, '行驶证的车辆，交通警察可依法予以扣留。', '《道路交通安全法》第九十六条:使用其他车辆的机动车登记证书、号牌、行驶证、检验合格标志、保险标志的，由公安机关交通管理部门予以收缴，扣留该机动车，处2000元以上5000元以下罚款。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335294, 1542335294);
INSERT INTO `ks_question` VALUES (224, '对未按照国家规定投保交强险的车辆，交通警察可依法予以扣留。', '《道路交通安全法》第九十八条：机动车所有人、管理人未按照国家规定投保机动车第三者责任强制保险的，由公安机关交通管理部门扣留车辆至依照规定投保后，并处依照规定投保最低责任限额应缴纳的保险费的二倍罚款。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335295, 1542335295);
INSERT INTO `ks_question` VALUES (225, '对发生道路交通事故需要收集证据的事故车，交通警察可以依法扣留。', '《道路交通安全违法行为处理程序规定》第二十五条规定：有下列情形之一的，依法扣留车辆：对发生道路交通事故，因收集证据需要的，可以依法扣留事故车辆。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335296, 1542335296);
INSERT INTO `ks_question` VALUES (226, '行驶证嫌疑的，交通警察可依法扣留车辆。', '《道路交通安全违法行为处理程序规定》第二十五条规定，有下列情形之一的，依法扣留车辆：有伪造、变造或者使用伪造、变造的机动车登记证书、号牌、行驶证、检验合格标志、 保险标志、驾驶证或者使用其他车辆的机动车登记证书、号牌、行驶证、检验合格标志、保险标志嫌疑的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335297, 1542335297);
INSERT INTO `ks_question` VALUES (227, '驾驶人有使用其他车辆检验合格标志嫌疑的，交通警察可依法扣留车辆。', '交通警察可依法扣留车辆，等他们查清楚车的来由，当场教导让其车在指定时间内接受车辆检验并放行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335299, 1542335299);
INSERT INTO `ks_question` VALUES (228, '驾驶人有使用其他车辆保险标志嫌疑的，交通警察可依法扣留车辆。', '《道路交通安全违法行为处理程序规定》第二十五条规定，有下列情形之一的，依法扣留车辆：有伪造、变造或者使用伪造、变造的机动车登记证书、号牌、行驶证、检验合格标志、 保险标志、驾驶证或者使用其他车辆的机动车登记证书、号牌、行驶证、检验合格标志、保险标志嫌疑的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335300, 1542335300);
INSERT INTO `ks_question` VALUES (229, '驾驶人有哪种情形，交通警察可依法扣留机动车驾驶证？', '六种情形下可以扣留驾驶证。新法规定，有下列情形之一的，可以扣留机动车驾驶证：(一)饮酒、醉酒后驾驶机动车的； (二)机动车驾驶人将机动车交由未取得机动车驾驶证或者机动车驾驶证被吊销、暂扣的人驾驶的； (三)机动车行驶超过规定时速百分之五十的； (四)驾驶拼装或者已达到报废标准的机动车的； (五)发生重大交通事故，构成犯罪的； (六)在一个记分周期内累积记分达到12分的。', NULL, 1, '[\"A、疲劳后驾驶机动车\",\"B、饮酒后驾驶机动车\",\"C、行车中未系安全带\",\"D、超过规定速度10%\"]', 1, '1', 1, 1, 0, 0, 0, 1542335301, 1542335301);
INSERT INTO `ks_question` VALUES (230, '驾驶人将机动车交由什么样的人驾驶的，交通警察可依法扣留机动车驾驶证？', '六种情形下可以扣留驾驶证 新法规定，有下列情形之一的，可以扣留机动车驾驶证：(一)饮酒、醉酒后驾驶机动车的；(二)机动车驾驶人将机动车交由未取得机动车驾驶证或者机动车驾驶证被吊销、暂扣的人驾驶的；(三)机动车行驶超过规定时速百分之五十的； (四)驾驶拼装或者已达到报废标准的机动车的； (五)发生重大交通事故，构成犯罪的；(六)在一个记分周期内累积记分达到12分的。', NULL, 1, '[\"A、驾驶证记分达到6分的人\",\"B、取得驾驶证的人\",\"C、驾驶证被吊销的人\",\"D、实习期驾驶人\"]', 1, '2', 1, 1, 0, 0, 0, 1542335302, 1542335302);
INSERT INTO `ks_question` VALUES (231, '驾驶人将机动车交给驾驶证被吊销的人驾驶的，交通警察依法扣留驾驶证。', '六种情形下可以扣留驾驶证 新法规定，有下列情形之一的，可以扣留机动车驾驶证：(一)饮酒、醉酒后驾驶机动车的； (二)机动车驾驶人将机动车交由未取得机动车驾驶证或者机动车驾驶证被吊销、暂扣的人驾驶的；(三)机动车行驶超过规定时速百分之五十的； (四)驾驶拼装或者已达到报废标准的机动车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335303, 1542335303);
INSERT INTO `ks_question` VALUES (232, '驾驶人将机动车交给驾驶证被暂扣的人驾驶的，交通警察给予口头警告。', '《道路交通安全法》第九十九条：将机动车交由未取得机动车驾驶证或者机动车驾驶证被吊销、暂扣的人驾驶的，由公安机关交通管理部门处二百元以上二千元以下罚款，可以并处吊销机动车驾驶证,并不是口头警告这么简单。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335304, 1542335304);
INSERT INTO `ks_question` VALUES (233, '驾驶人驾驶有达到报废标准嫌疑机动车上路的，交通警察依法予以拘留。', '交警只能扣留车辆，还没达到拘留人的地步。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335305, 1542335305);
INSERT INTO `ks_question` VALUES (234, '驾驶人在一个记分周期内累积记分达到12分的，交通警察依法扣留驾驶证。', '《实施条例》第二十三条：公安机关交通管理部门对机动车驾驶人的道路交通安全违法行为除给予行政处罚外，实行道路交通安全违法行为累积记分(以下简称记分)制度，记分周期为12个月。对在一个记分周期内记分达到12分的，由公安机关交通管理部门扣留其机动车驾驶证，该机动车驾驶人应当按照规定参加道路交通安全法律、法规的学习并接受考试。考试合格的，记分予以清除，发还机动车驾驶证；考试不合格的，继续参加学习和考试。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335306, 1542335306);
INSERT INTO `ks_question` VALUES (235, '公共设施后可即行撤离现场。', '《实施条例》第八十八条：机动车发生交通事故，造成道路、供电、通讯等设施损毁的，驾驶人应当报警等候处理，不得驶离。机动车可以移动的，应当将机动车移至不妨碍交通的地点。公安机关交通管理部门应当将事故有关情况通知有关部门。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335307, 1542335307);
INSERT INTO `ks_question` VALUES (236, '发生交通事故造成人员受伤时，要保护现场并立即报警。', '《实施条例》第八十八条：机动车发生交通事故，造成道路、供电、通讯等设施损毁的，驾驶人应当报警等候处理，不得驶离。机动车可以移动的，应当将机动车移至不妨碍交通的地点。公安机关交通管理部门应当将事故有关情况通知有关部门。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335310, 1542335310);
INSERT INTO `ks_question` VALUES (237, '醉酒嫌疑时，要保护现场并立即报警。', '根据《道路交通事故处理程序规定》第八条:道路交通事故有下列情形之一的，当事人应当保护现场并立即报警：驾驶人有饮酒、服用国家管制的精神药品或者麻醉药品嫌疑的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335855, 1542335855);
INSERT INTO `ks_question` VALUES (238, '保险标志时，要保护现场并立即报警。', '通事故处理程序规定》第八条，道路交通事故有下列情形之一的，当事人应当保护现场并立即报警：（一）造成人员死亡、受伤的；（二）发生财产损失事故，当事人对事实或者成因有争议的，以及虽然对事实或者成因无争议，但协商损害赔偿未达成协议的；（三）机动车无号牌、无检验合格标志、无保险标志的；（四）载运爆炸物品、易燃易爆化学物品以及毒害性、放射性、腐蚀性、传染病病源体等危险物品车辆的；（五）碰撞建筑物、公共设施或者其他设施的；（六）驾驶人无有效机动车驾驶证的；（七）驾驶人有饮酒、服用国家管制的精神药品或者麻醉药品嫌疑的；（八）当事人不能自行移动车辆的。发生财产损失事故，并具有前款第二项至第五项情形之一，车辆可以移动的，当事人可以在报警后，在确保安全的原则下对现场拍照或者标划停车位置，将车辆移至不妨碍交通的地点等候处理。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335856, 1542335856);
INSERT INTO `ks_question` VALUES (239, '驾驶机动车发生财产损失交通事故，当事人对事实及成因无争议的可先撤离现场。', '《道路交《道路交通事故处理程序规定》第十三条：机动车与机动车、机动车与非机动车发生财产损失事故，当事人对事实及成因无争议的，可以自行协商处理损害赔偿事宜。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335858, 1542335858);
INSERT INTO `ks_question` VALUES (240, '驾驶机动车发生财产损失交通事故后，当事人对事实及成因无争议移动车辆时需要对现场拍照或者标划停车位置。', '《道路交通事故处理程序规定》第十三条：机动车与机动车、机动车与非机动车发生财产损失事故，当事人对事实及成因无争议的，可以自行协商处理损害赔偿事宜。车辆可以移动的，当事人应当在确保安全的原则下对现场拍照或者标划事故车辆现场位置后，立即撤离现场，将车辆移至不妨碍交通的地点，再进行协商。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335859, 1542335859);
INSERT INTO `ks_question` VALUES (241, '机动车发生财产损失交通事故，对应当自行撤离现场而未撤离的，交通警察不可以责令当事人撤离现场。', '《道路交通事故处理程序规定》第十三条：对应当自行撤离现场而未撤离的，交通警察应当责令当事人撤离现场；造成交通堵塞的，对驾驶人处以200元罚款；驾驶人有其他道路交通安全违法行为的，依法一并处罚。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335860, 1542335860);
INSERT INTO `ks_question` VALUES (242, '机动车发生财产损失交通事故，对应当自行撤离现场而未撤离造成交通堵塞的，可以对驾驶人处以200元罚款。', '《道路交通事故处理程序规定》第十三条：对应当自行撤离现场而未撤离的，交通警察应当责令当事人撤离现场；造成交通堵塞的，对驾驶人处以200元罚款；驾驶人有其他道路交通安全违法行为的，依法一并处罚。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335861, 1542335861);
INSERT INTO `ks_question` VALUES (243, '申请小型汽车准驾车型驾驶证的人年龄条件是多少？', '《公安部令第123号》第十一条：申请小型汽车、小型自动挡汽车、残疾人专用小型自动挡载客汽车、轻便摩托车准驾车型的，在18周岁以上、70周岁以下。', NULL, 1, '[\"A、24周岁以上70周岁以下\",\"B、18周岁以上60周岁以下\",\"C、18周岁以上70周岁以下\",\"D、21周岁以上50周岁以下\"]', 1, '2', 1, 1, 0, 0, 0, 1542335862, 1542335862);
INSERT INTO `ks_question` VALUES (244, '3年内有下列哪种行为的人不得申请机动车驾驶证？', '《公安部令第123号》第十二条：三年内有吸食、注射毒品行为或者解除强制隔离戒毒措施未满三年，或者长期服用依赖性精神药品成瘾尚未戒除的，不得申请机动车驾驶证。', NULL, 1, '[\"A、吸烟成瘾\",\"B、酒醉经历\",\"C、注射胰岛素\",\"D、注射毒品\"]', 1, '3', 1, 1, 0, 0, 0, 1542335863, 1542335863);
INSERT INTO `ks_question` VALUES (245, '申请小型汽车驾驶证的，年龄应在18周岁以上70周岁以下。', '《公安部令第123号》第十一条：1、申请小型汽车等准驾车型在18周岁以上，70周岁以下；2、申请低速载货汽车、三轮汽车等准驾车型的，在18周岁以上，60周岁以下。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335864, 1542335864);
INSERT INTO `ks_question` VALUES (246, '酒后驾驶发生重大交通事故被依法追究刑事责任的人不能申请机动车驾驶证。', '饮酒后或者醉酒驾驶机动车发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证，终身不得重新取得机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335866, 1542335866);
INSERT INTO `ks_question` VALUES (247, '造成交通事故后逃逸构成犯罪的人不能申请机动车驾驶证。', '《交通法》第一百零一条：违反道路交通安全法律、法规的规定，发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证。吊销机动车证的为二年，撤销机动车证的为三年，以醉酒吊销五年，因逃跑而吊销是终身，简称“吊二撤三醉五逃终身”。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335867, 1542335867);
INSERT INTO `ks_question` VALUES (248, '驾驶人在驾驶证有效期满前多长时间申请换证？', '《公安部令第123号》第四十八条：机动车驾驶人应当于机动车驾驶证有效期满前九十日内，向机动车驾驶证核发地车辆管理所申请换证。', NULL, 1, '[\"A、30日内\",\"B、90日内\",\"C、60日内\",\"D、6个月内\"]', 1, '1', 1, 1, 0, 0, 0, 1542335868, 1542335868);
INSERT INTO `ks_question` VALUES (249, '驾驶人户籍迁出原车辆管理所需要向什么地方的车辆管所提出申请？', '《公安部令第123号》第四十九条：机动车驾驶人户籍迁出原车辆管理所管辖区的，应当向迁入地车辆管理所申请换证。', NULL, 1, '[\"A、居住地\",\"B、迁入地\",\"C、所在地\",\"D、迁出地\"]', 1, '1', 1, 1, 0, 0, 0, 1542335869, 1542335869);
INSERT INTO `ks_question` VALUES (250, '驾驶证记载的驾驶人信息发生变化的要在多长时间内申请换证？', '《公安部令第123号》第五十一条：具有下列情形之一的，机动车驾驶人应当在三十日内到机动车驾驶证核发地车辆管理所申请换证：（一）在车辆管理所管辖区域内，机动车驾驶证记载的机动车驾驶人信息发生变化的（二）机动车驾驶证损毁无法辨认的。', NULL, 1, '[\"A、50日\",\"B、60日\",\"C、30日\",\"D、40日\"]', 1, '2', 1, 1, 0, 0, 0, 1542335871, 1542335871);
INSERT INTO `ks_question` VALUES (251, '驾驶人在驾驶证核发地车辆管理所管辖区以外居住的，可以向居住地车辆管理所申请换证。', '《公安部令第123号》第四十九条：机动车驾驶人户籍迁出原车辆管理所管辖区的，应当向迁入地车辆管理所申请换证。机动车驾驶人在核发地车辆管理所管辖区以外居住的，可以向居住地车辆管理所申请换证。申请时应当填写申请表，并提交第四十八条规定的证明、凭证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335872, 1542335872);
INSERT INTO `ks_question` VALUES (252, '道路交通违法行为累积记分周期是多长时间？', '《公安部令第123号》第五十五条：道路交通安全违法行为累积记分周期(即记分周期)为12个月，满分为12分，从机动车驾驶证初次领取之日起计算。', NULL, 1, '[\"A、10个月\",\"B、12个月\",\"C、6个月\",\"D、14个月\"]', 1, '1', 1, 1, 0, 0, 0, 1542335873, 1542335873);
INSERT INTO `ks_question` VALUES (253, '道路交通安全违法行为累积记分一个周期满分为12分。', '《公安部令第123号》第五十五条：道路交通安全违法行为累积记分周期(即记分周期)为12个月，满分为12分，从机动车驾驶证初次领取之日起计算。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335874, 1542335874);
INSERT INTO `ks_question` VALUES (254, '驾驶人记分没有达到满分，有罚款尚未缴纳的，记分转入下一记分周期。', '《实施条例》第二十四条：机动车驾驶人在一个记分周期内记分未达到12分，所处罚款已经缴纳的，记分予以清除；记分虽未达到12分，但尚有罚款未缴纳的，记分转入下一记分周期。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335875, 1542335875);
INSERT INTO `ks_question` VALUES (255, '持小型汽车驾驶证的驾驶人在下列哪种情况下需要接受审验？', '小型汽车、摩托车等车型驾驶人审验的情形有两种：一是发生交通事故造成人员死亡承担同等以上责任未被吊销驾驶证的，应当在记分周期结束后三十日内到公安交管部门接受审验；二是驾驶证转到异地或者有效期满换证时，应当到公安交管部门接受审验。需要提醒的是，驾驶人没有按照规定参加审验仍驾驶机动车的，公安交管部门将处200元以上500元以下罚款。', NULL, 1, '[\"A、记分周期未满分\",\"B、一个记分周期末\",\"C、有效期满换发驾驶证时\",\"D、记分周期满12分\"]', 1, '2', 1, 1, 0, 0, 0, 1542335876, 1542335876);
INSERT INTO `ks_question` VALUES (256, '出国（境）等原因无法办理审验时，延期审验期限最长不超过多长时间？', '《公安部令第123号》第六十三条：机动车驾驶人因服兵役、出国（境）等原因，无法在规定时间内办理驾驶证期满换证、审验、提交身体条件证明的，可以向机动车驾驶证核发地车辆管理所申请延期办理。申请时应当填写申请表，并提交机动车驾驶人的身份证明、机动车驾驶证和延期事由证明。延期期限最长不超过三年。延期期间机动车驾驶人不得驾驶机动车。', NULL, 1, '[\"A、3年\",\"B、5年\",\"C、1年\",\"D、2年\"]', 1, '0', 1, 1, 0, 0, 0, 1542335877, 1542335877);
INSERT INTO `ks_question` VALUES (257, '小型汽车驾驶人发生交通事故造成人员死亡，承担同等以上责任未被吊销驾驶证的，应当在记分周期结束后30日内接受审验。', '《公安部令第123号》第六十条：除持有大型客车、牵引车、城市公交车、中型客车、大型货车外准驾车型驾驶证的驾驶人，发生交通事故造成人员死亡承担同等以上责任未被吊销机动车驾驶证的，应当在本记分周期结束后三十日内到公安机关交通管理部门接受审验。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335879, 1542335879);
INSERT INTO `ks_question` VALUES (258, '出国（境）等原因延期审验期间不得驾驶机动车。', '《公安部令第123号》第六十三条：机动车驾驶人因服兵役、出国（境）等原因，无法在规定时间内办理驾驶证期满换证、审验、提交身体条件证明的，可以向机动车驾驶证核发地车辆管理所申请延期办理。申请时应当填写申请表，并提交机动车驾驶人的身份证明、机动车驾驶证和延期事由证明。延期期限最长不超过三年。延期期间机动车驾驶人不得驾驶机动车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335880, 1542335880);
INSERT INTO `ks_question` VALUES (259, '年龄在70周岁以上的驾驶人多长时间提交一次身体条件证明？', '根据2016新规《机动车驾驶证申领和使用规定》中第七十二条：年龄在70周岁以上的机动车驾驶人，应当每年进行一次身体检查，在记分周期结束后三十日内，提交县级或者部队团级以上医疗机构出具的有关身体条件的证明。', NULL, 1, '[\"A、每2年\",\"B、每6个月\",\"C、每1年\",\"D、每3年\"]', 1, '2', 1, 1, 0, 0, 0, 1542335881, 1542335881);
INSERT INTO `ks_question` VALUES (260, '大型货车驾驶人应当每两年提交一次身体条件证明。', '2013年1月1日起施行的公安部123号令，已明确规定，大、中型客货车驾驶人每年参加审验，审验时自己申报身体条件情况。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335882, 1542335882);
INSERT INTO `ks_question` VALUES (261, '机动车驾驶人初次申请机动车驾驶证和增加准驾车型后的多长时间为实习期？', '《公安部令第123号》第六十四条:机动车驾驶人初次申请机动车驾驶证和增加准驾车型后的12个月为实习期。', NULL, 1, '[\"A、6个月\",\"B、2年\",\"C、3个月\",\"D、12个月\"]', 1, '3', 1, 1, 0, 0, 0, 1542335883, 1542335883);
INSERT INTO `ks_question` VALUES (262, '初次申领驾驶证的驾驶人在实习期内可以单独驾驶机动车上高速公路行驶。', '《公安部令第123号》第六十五条：驾驶人在实习期内驾驶机动车上高速公路行驶，应当由持相应或者更高准驾车型驾驶证三年以上的驾驶人陪同。其中，驾驶残疾人专用小型自动挡载客汽车的，可以由持有小型自动挡载客汽车以上准驾车型驾驶证的驾驶人陪同。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335884, 1542335884);
INSERT INTO `ks_question` VALUES (263, '驾驶人在实习期内驾驶机动车时，应当在车身后部粘贴或者悬挂统一式样的实习标志。', '《公安部令第123号》第六十四：在实习期内驾驶机动车的，应当在车身后部粘贴或者悬挂统一式样的实习标志。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335886, 1542335886);
INSERT INTO `ks_question` VALUES (264, '机动车驾驶人在实习期内有记满12分记录的，注销其实习的准驾车型驾驶资格。', '公安部123号令规定：第六十四条 机动车驾驶人初次申请机动车驾驶证和增加准驾车型后的12个月为实习期。第六十九条 机动车驾驶人在实习期内有记满12分记录的，注销其实习的准驾车型驾驶资格。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335887, 1542335887);
INSERT INTO `ks_question` VALUES (265, '提供虚假材料申领驾驶证的申请人会承担下列哪种法律责任？', '修订后的《机动车驾驶证申领和使用规定》第七十八条第一款规定：隐瞒有关情况或者提供虚假材料申领机动车驾驶证的，申请人在一年内不得再次申领机动车驾驶证。', NULL, 1, '[\"A、1年内不得再次申领驾驶证\",\"B、取消申领驾驶证资格\",\"C、处20元以上200元以下罚款\",\"D、2年内不能再次申领驾驶证\"]', 1, '0', 1, 1, 0, 0, 0, 1542335888, 1542335888);
INSERT INTO `ks_question` VALUES (266, '变造驾驶证的驾驶人构成犯罪的，将依法追究刑事责任。', '《道路交通安全法》第九十六条：伪造、变造或者使用伪造、变造的机动车登记证书、号牌、行驶证、驾驶证的，由公安机关交通管理部门予以收缴，扣留该机动车，处十五日以下拘留，并处二千元以上五千元以下罚款；构成犯罪的，依法追究刑事责任。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335889, 1542335889);
INSERT INTO `ks_question` VALUES (267, '驾驶人有下列哪种违法行为一次记12分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、使用伪造机动车号牌\",\"B、违反交通信号灯\",\"C、拨打、接听手机的\",\"D、违反禁令标志指示\"]', 1, '0', 1, 1, 0, 0, 0, 1542335890, 1542335890);
INSERT INTO `ks_question` VALUES (268, '驾驶与准驾车型不符的机动车一次记几分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、2分\",\"B、12分\",\"C、3分\",\"D、6分\"]', 1, '1', 1, 1, 0, 0, 0, 1542335891, 1542335891);
INSERT INTO `ks_question` VALUES (269, '饮酒后驾驶机动车一次记几分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、2分\",\"B、3分\",\"C、6分\",\"D、12分\"]', 1, '3', 1, 1, 0, 0, 0, 1542335892, 1542335892);
INSERT INTO `ks_question` VALUES (270, '造成交通事故后逃逸，尚不构成犯罪的一次记几分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、2分\",\"B、6分\",\"C、12分\",\"D、3分\"]', 1, '2', 1, 1, 0, 0, 0, 1542335893, 1542335893);
INSERT INTO `ks_question` VALUES (271, '上道路行驶的机动车未悬挂机动车号牌的一次记几分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、2分\",\"B、12分\",\"C、6分\",\"D、3分\"]', 1, '1', 1, 1, 0, 0, 0, 1542335895, 1542335895);
INSERT INTO `ks_question` VALUES (272, '不按规定安装机动车号牌的一次记几分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、6分\",\"B、12分\",\"C、2分\",\"D、3分\"]', 1, '1', 1, 1, 0, 0, 0, 1542335896, 1542335896);
INSERT INTO `ks_question` VALUES (273, '变造的机动车号牌一次记几分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、12分\",\"B、6分\",\"C、3分\",\"D、2分\"]', 1, '0', 1, 1, 0, 0, 0, 1542335897, 1542335897);
INSERT INTO `ks_question` VALUES (274, '变造的行驶证一次记几分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、12分\",\"B、6分\",\"C、2分\",\"D、3分\"]', 1, '0', 1, 1, 0, 0, 0, 1542335898, 1542335898);
INSERT INTO `ks_question` VALUES (275, '驾驶人有下列哪种违法行为一次记6分？', '（公安部令123号）机动车驾驶人有下列违法行为之一，一次记6分：(一)机动车驾驶证被暂扣期间驾驶机动车的；(二)驾驶机动车违反道路交通信号灯通行的；(三)驾驶营运客车(不包括公共汽车)、校车载人超过核定人数未达20%的，或者驾驶其他载客汽车载人超过核定人数20%以上的；(四)驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速未达20%的；(五)驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路以外的道路上行驶或者驾驶其他机动车行驶超过规定时速20%以上未达到50%的；(六)驾驶货车载物超过核定载质量30%以上或者违反规定载客的；(七)驾驶营运客车以外的机动车在高速公路车道内停车的；(八)驾驶机动车在高速公路或者城市快速路上违法占用应急车道行驶的；(九)低能见度气象条件下，驾驶机动车在高速公路上不按规定行驶的；(十)驾驶机动车运载超限的不可解体的物品，未按指定的时间、路线、速度行驶或者未悬挂明显标志的；(十一)驾驶机动车载运爆炸物品、易燃易爆化学物品以及剧毒、放射性等危险物品，未按指定的时间、路线、速度行驶或者未悬挂警示标志并采取必要的安全措施的；(十二)以隐瞒、欺骗手段补领机动车驾驶证的；(十三)连续驾驶中型以上载客汽车、危险物品运输车辆以外的机动车超过4小时未停车休息或者停车休息时间少于20分钟的；(十四)驾驶机动车不按照规定避让校车的。', NULL, 1, '[\"A、违法占用应急车道行驶\",\"B、使用其他车辆行驶证\",\"C、车速超过规定时速50%以上\",\"D、饮酒后驾驶机动车\"]', 1, '0', 1, 1, 0, 0, 0, 1542335899, 1542335899);
INSERT INTO `ks_question` VALUES (276, '驾驶人驾驶机动车违反道路交通信号灯通行一次记多少分？', '《公安部令第123号》附件2，驾驶机动车违反道路交通信号灯通行的，一次记6分。', NULL, 1, '[\"A、12分\",\"B、3分\",\"C、6分\",\"D、2分\"]', 1, '2', 1, 1, 0, 0, 0, 1542335900, 1542335900);
INSERT INTO `ks_question` VALUES (277, '有下列哪种违法行为的机动车驾驶人将被一次记6分？', '其它选项驾驶与准驾车型不符的机动车、饮酒后驾驶机动车和未取得校车驾驶资格驾驶校车均扣12分。一次记6分的情况有：驾驶证被暂扣期间驾驶机动车、违反交通信号灯、违法占用应急车道、隐瞒欺骗手段补领驾驶证、不按照规定避让校车等。', NULL, 1, '[\"A、驾驶与准驾车型不符的机动车\",\"B、饮酒后驾驶机动车\",\"C、驾驶机动车违反道路交通信号灯\",\"D、未取得校车驾驶资格驾驶校车\"]', 1, '2', 1, 1, 0, 0, 0, 1542335901, 1542335901);
INSERT INTO `ks_question` VALUES (278, '有下列哪种违法行为的机动车驾驶人将被一次记12分？', '《公安部令第123号》附件2，上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的，一次记12分。其余均为6分。', NULL, 1, '[\"A、驾驶机动车不按照规定避让校车的\",\"B、驾驶故意污损号牌的机动车上道路行驶\",\"C、机动车驾驶证被暂扣期间驾驶机动车的\",\"D、以隐瞒、欺骗手段补领机动车驾驶证的\"]', 1, '1', 1, 1, 0, 0, 0, 1542335902, 1542335902);
INSERT INTO `ks_question` VALUES (279, '造成交通事故后逃逸，尚不构成犯罪的一次记12分。', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335904, 1542335904);
INSERT INTO `ks_question` VALUES (280, '饮酒后驾驶机动车的一次记12分。', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335905, 1542335905);
INSERT INTO `ks_question` VALUES (281, '变造的驾驶证一次记12分。', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335906, 1542335906);
INSERT INTO `ks_question` VALUES (282, '行驶证的一次记3分。', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335907, 1542335907);
INSERT INTO `ks_question` VALUES (283, '穿越中央分隔带掉头的一次记6分。', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335908, 1542335908);
INSERT INTO `ks_question` VALUES (284, '违反交通信号灯通行的一次记6分。', '根据公安部第123号令规定，机动车驾驶人有下列违法行为之一，一次记6分：驾驶机动车违反道路交通信号灯通行的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335909, 1542335909);
INSERT INTO `ks_question` VALUES (285, '车速超过规定时速50%以上的一次记12分。', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335910, 1542335910);
INSERT INTO `ks_question` VALUES (286, '车速超过规定时速达到50%的一次记3分。', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335911, 1542335911);
INSERT INTO `ks_question` VALUES (287, '驾驶机动车在高速公路违法占用应急车道行驶的一次记6分。', '《公安部令第123号》附件2，驾驶机动车在高速公路或者城市快速路上违法占用应急车道行驶的，一次记6分。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335912, 1542335912);
INSERT INTO `ks_question` VALUES (288, '驾驶机动车不按照规定避让校车的，一次记6分。', '根据公安部第123号令规定，机动车驾驶人有下列违法行为之一，一次记6分：驾驶机动车不按照规定避让校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335914, 1542335914);
INSERT INTO `ks_question` VALUES (289, '已注册登记的小型载客汽车有下列哪种情形，所有人不需要办理变更登记？', '《道路交通安全法实施条例》第六条:已注册登记的机动车有下列情形之一的，机动车所有人应当向登记该机动车的公安机关交通管理部门申请变更登记：（一）改变机动车车身颜色的；（二）更换发动机的；（三）更换车身或者车架的；（四）因质量有问题，制造厂更换整车的；（五）营运机动车改为非营运机动车或者非营运机动车改为营运机动车的；（六）机动车所有人的住所迁出或者迁入公安机关交通管理部门管辖区域的。', NULL, 1, '[\"A、加装前后防撞装置\",\"B、更换车身或者车架\",\"C、改变车身颜色\",\"D、机动车更换发动机\"]', 1, '0', 1, 1, 0, 0, 0, 1542335915, 1542335915);
INSERT INTO `ks_question` VALUES (290, '机动车达到国家规定的强制报废标准的不能办理注册登记。', '《道路交通安全法》第十四条规定：报废的机动车必须及时办理注销登记，所以不可以办理注册登记。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335916, 1542335916);
INSERT INTO `ks_question` VALUES (291, '牵引发生事故的机动车时，最高车速不得超过多少？', '《实施条例》第四十六条：机动车行驶中遇有下列情形之一的，最高行驶速度不得超过每小时30公里，其中拖拉机、电瓶车、轮式专用机械车不得超过每小时15公里：(一)进出非机动车道，通过铁路道口、急弯路、窄路、窄桥时；(二)掉头、转弯、下陡坡时；(三)遇雾、雨、雪、沙尘、冰雹，能见度在50米以内时；(四)在冰雪、泥泞的道路上行驶时；(五)牵引发生故障的机动车时。', NULL, 1, '[\"A、30公里/小时\",\"B、20公里/小时\",\"C、50公里/小时\",\"D、40公里/小时\"]', 1, '0', 1, 1, 0, 0, 0, 1542335919, 1542335919);
INSERT INTO `ks_question` VALUES (292, '如图所示，在高速公路上同方向三条机动车道最左侧车道行驶，应保持什么车速？', '《实施条例》第七十八条：同方向有2条车道的，左侧车道的最低车速为每小时100公里；同方向有3条以上车道的，最左侧车道的最低车速为每小时110公里，中间车道的最低车速为每小时90公里。道路限速标志标明的车速与上述车道行驶车速的规定不一致的，按照道路限速标志标明的车速行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/1092300.jpg', 1, '[\"A、110公里/小时-120公里/小时\",\"B、60公里/小时-120公里/小时\",\"C、90公里/小时-120公里/小时\",\"D、100公里/小时-120公里/小时\"]', 1, '0', 1, 1, 4, 0, 0, 1542335920, 1542335920);
INSERT INTO `ks_question` VALUES (293, '交通肇事致一人以上重伤，负事故全部责任或者主要责任，并具有下列哪种行为的，构成交通肇事罪？', '交通肇事致一人受伤（属于一般事故），负事故全部或者主要责任，并具有酒后、无证驾驶、严重超载等情形之一的，以交通肇事罪处罚。', NULL, 1, '[\"A、严重超载驾驶的\",\"B、未抢救受伤人员\",\"C、未及时报警\",\"D、未带驾驶证\"]', 1, '0', 1, 1, 0, 0, 0, 1542335922, 1542335922);
INSERT INTO `ks_question` VALUES (294, '如图所示，在高速公路同方向三条机动车道右侧车道行驶，车速不能低于多少？', '《实施条例》第七十八条：高速公路应当标明车道的行驶速度，最高车速不得超过每小时120公里，最低车速不得低于每小时60公里。', 'http://file.open.jiakaobaodian.com/tiku/res/1092500.jpg', 1, '[\"A、60公里/小时\",\"B、100公里/小时\",\"C、110公里/小时\",\"D、80公里/小时\"]', 1, '0', 1, 1, 4, 0, 0, 1542335923, 1542335923);
INSERT INTO `ks_question` VALUES (295, '在没有交通信号指示的交叉路口，转弯的机动车让直行的车辆和行人先行。', '三个先行原则：转弯的机动车让直行的车辆先行；右方道路来车先行；右转弯车让左转弯车先行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335924, 1542335924);
INSERT INTO `ks_question` VALUES (296, '对向无来车，可以掉头。', '如图所示，地面标线是黄色虚线，可以掉头。机动车在没有禁止掉头或者禁止左转弯的标志地点可以掉头，但不得妨碍正常行驶的车辆。', 'http://file.open.jiakaobaodian.com/tiku/res/1092800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542335925, 1542335925);
INSERT INTO `ks_question` VALUES (297, '当您即将通过交叉路口的时候，才意识到要左转而不是向前，以下说法正确的是什么？', '按规定，交叉路口，不可以停车，不可以倒车，只能继续向前行驶。', NULL, 1, '[\"A、停在交叉路口，等待安全时左转\",\"B、继续向前行驶\",\"C、在确保安全的情况下，倒车然后左转\",\"D、以上说法都不正确\"]', 1, '1', 1, 1, 0, 0, 0, 1542335928, 1542335928);
INSERT INTO `ks_question` VALUES (298, '如图所示，在同向三车道高速公路上行车，车速每小时115公里应该在哪条车道上行驶？', '道路限速标志标明的车速与上述车道行驶车速的规定不一致的，按照道路限速标志标明的车速行驶。如图上面的绿色标志，左侧限速在100-120，中间是80-100，右侧是60-80，车速每小时115公里，应该在左侧车道。', 'http://file.open.jiakaobaodian.com/tiku/res/1093100.jpg', 1, '[\"A、最右侧车道\",\"B、哪条都不行\",\"C、中间车道\",\"D、最左侧车道\"]', 1, '3', 1, 1, 4, 0, 0, 1542335929, 1542335929);
INSERT INTO `ks_question` VALUES (299, '驾驶机动车变更车道为什么要提前开启转向灯？', '提前开启转向灯，提醒后车我方车辆动向，注意减速慢行。', NULL, 1, '[\"A、提示其他车辆我方准备变更车道\",\"B、提示前车让行\",\"C、提示行人让行\",\"D、开阔视野，便于观察路面情况\"]', 1, '0', 1, 1, 0, 0, 0, 1542335930, 1542335930);
INSERT INTO `ks_question` VALUES (300, '如图所示，在高速公路同方向两条机动车道左侧车道行驶，应保持什么车速？', '《实施条例》第七十八条：同方向有2条车道的，左侧车道的最低车速为每小时100公里。', 'http://file.open.jiakaobaodian.com/tiku/res/1093300.jpg', 1, '[\"A、90公里/小时-110公里/小时\",\"B、110公里/小时-120公里/小时\",\"C、60公里/小时-120公里/小时\",\"D、100公里/小时-120公里/小时\"]', 1, '3', 1, 1, 4, 0, 0, 1542335931, 1542335931);
INSERT INTO `ks_question` VALUES (301, '如图所示，铁道路口禁止掉头的原因是什么？', '铁道路口行车条件比较复杂，掉头容易引发事故。', 'http://file.open.jiakaobaodian.com/tiku/res/1093400.jpg', 1, '[\"A、有铁道路口标志\",\"B、有铁道路口信号灯\",\"C、容易引发事故\",\"D、铁道路口车流量大\"]', 1, '2', 1, 1, 4, 0, 0, 1542335932, 1542335932);
INSERT INTO `ks_question` VALUES (302, '如图所示，在这种条件下通过交叉路口时，不得超车的原因是什么？', '按照规定，交叉路口不能超车。因为交叉路口车流量大，行车条件十分复杂，这个时候超车，容易造成事故。', 'http://file.open.jiakaobaodian.com/tiku/res/1093500.jpg', 1, '[\"A、路口内交通情况复杂，易发生交通事故。\",\"B、路口设有信号灯\",\"C、路口有交通监控设备\",\"D、机动车速度慢，不足以超越前车\"]', 1, '0', 1, 1, 4, 0, 0, 1542335933, 1542335933);
INSERT INTO `ks_question` VALUES (303, '如图所示，在这种情况下只要后方没有来车，可以倒车。', '《实施条例》第五十条：机动车倒车时，应当察明车后情况，确认安全后倒车。不得在铁路道口、交叉路口、单行路、桥梁、急弯、陡坡或者隧道中倒车。由标志可知，这段路是单行路，根据规定单行路不能倒车。', 'http://file.open.jiakaobaodian.com/tiku/res/1093600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335935, 1542335935);
INSERT INTO `ks_question` VALUES (304, '如图所示，在高速公路最左侧车道行驶，想驶离高速公路，以下说法正确的是什么？', '变更车道，每次只能变更一条车道，变更之后需行驶一段距离，再变道。不可以连续变更车道。', 'http://file.open.jiakaobaodian.com/tiku/res/1093700.jpg', 1, '[\"A、立即减速后右变更车道\",\"B、找准机会一次变更到右侧车道\",\"C、每次变更一条车道，直到最右侧车道\",\"D、为了快速变更车道可以加速超越右侧车辆后变更车道\"]', 1, '2', 1, 1, 4, 0, 0, 1542335936, 1542335936);
INSERT INTO `ks_question` VALUES (305, '如图所示，机动车遇行人正在通过人行横道时，要停车让行，是因为行人享有优先通过权。', '《道路交通安全法》第四十七条：机动车行经人行横道时，应当减速行驶；遇行人正在通过人行横道，应当停车让行。这说明行人享有优先通过权。', 'http://file.open.jiakaobaodian.com/tiku/res/1093800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542335937, 1542335937);
INSERT INTO `ks_question` VALUES (306, '如图所示，通过这个标志的路口时应该减速让行。', '这个是停车让行的标志，光减速是不够的。另外提示一下，三角的是减速让行，八角的是停车让行。', 'http://file.open.jiakaobaodian.com/tiku/res/1093900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335938, 1542335938);
INSERT INTO `ks_question` VALUES (307, '如图所示，当A车后方有执行任务的救护车驶来时，以下做法正确的是什么？', '行车中遇到执行任务的消防车、救护车、工程救险车时要及时让行。', 'http://file.open.jiakaobaodian.com/tiku/res/1094000.jpg', 1, '[\"A、立刻停车让路\",\"B、不必理会，继续行驶\",\"C、向左转弯让路\",\"D、靠右减速让路\"]', 1, '3', 1, 1, 4, 0, 0, 1542335939, 1542335939);
INSERT INTO `ks_question` VALUES (308, '如图所示，在这种情况下准备进入环形路口时，为了保证车后车流的通畅，应加速超越红车进入路口。', '准备进入环形路口的让已在路口内的机动车先行。', 'http://file.open.jiakaobaodian.com/tiku/res/1094100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335940, 1542335940);
INSERT INTO `ks_question` VALUES (309, '在以下路段不能倒车的是什么？', '《实施条例》第五十条：机动车倒车时，应当察明车后情况，确认安全后倒车。不得在铁路道口、交叉路口、单行路、桥梁、急弯、陡坡或者隧道中倒车。', NULL, 1, '[\"A、三者皆是\",\"B、急弯\",\"C、交叉路口\",\"D、隧道\"]', 1, '0', 1, 1, 0, 0, 0, 1542335942, 1542335942);
INSERT INTO `ks_question` VALUES (310, '如图所示，在这种情形下，对方车辆具有先行权。', '有障碍的让无障碍的一方先行；但有障碍的一方已经驶入有障碍路段而无障碍一方未驶入的，有障碍的一方先行。本题中，本车前方有障碍，且未进入障碍路段，对方先行。', 'http://file.open.jiakaobaodian.com/tiku/res/1094300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542335943, 1542335943);
INSERT INTO `ks_question` VALUES (311, '如图所示，在高速公路同方向三条机动车道中间车道行驶，车速不能低于多少？', '同方向有3条以上车道的，最左侧车道的最低车速为每小时110公里，中间车道的最低车速为每小时90公里。', 'http://file.open.jiakaobaodian.com/tiku/res/1094400.jpg', 1, '[\"A、110公里/小时\",\"B、100公里/小时\",\"C、60公里/小时\",\"D、90公里/小时\"]', 1, '3', 1, 1, 4, 0, 0, 1542335944, 1542335944);
INSERT INTO `ks_question` VALUES (312, '遇前方路段车道减少，车辆行驶缓慢，为保证道路畅通，应借对向车道迅速通过。', '《实施条例》第五十三条：机动车遇有前方交叉路口交通阻塞时，应当依次停在路口以外等候，不得进入路口。机动车在遇有前方机动车停车排队等候或者缓慢行驶时，应当依次排队，不得从前方车辆两侧穿插或者超越行驶，不得在人行横道、网状线区域内停车等候。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335945, 1542335945);
INSERT INTO `ks_question` VALUES (313, '驶离停车地点或者掉头时，提前开启转向灯是为了什么？', '开启转向灯，主要是为了提醒后车，开启左转向灯，当然是向左变更行驶路线了。', NULL, 1, '[\"A、提示前车，将要向左变更行驶路线\",\"B、提示前车，将要向右变更行驶路线\",\"C、提示后车，将要向右变更行驶路线\",\"D、提示后车，将要向左变更行驶路线\"]', 1, '3', 1, 1, 0, 0, 0, 1542335946, 1542335946);
INSERT INTO `ks_question` VALUES (314, '如图所示，当车辆驶进这样的路口时，以下说法错误的是什么？', '安全驾驶，减速慢行。另外提醒大家看清题目意思，我们需要选择的是“错误”的说法。', 'http://file.open.jiakaobaodian.com/tiku/res/1094700.jpg', 1, '[\"A、右前方路口视野受阻如有突然冲出车辆容易引发事故\",\"B、因为视野受阻，应当鸣喇叭提醒侧方道路来车\",\"C、为避免车辆从路口突然冲出引发危险应适当减低车速\",\"D、本车有优先通行权，可加速通过\"]', 1, '3', 1, 1, 4, 0, 0, 1542335947, 1542335947);
INSERT INTO `ks_question` VALUES (315, '超车时应从前车的左侧超越，是因为左侧超车便于观察，有利于安全。', '左侧更便于观察前后方的情况，有利于安全。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335949, 1542335949);
INSERT INTO `ks_question` VALUES (316, '如图所示，在这种情况下通过路口，交替使用远近光灯的目的是什么？', '如图所示，在没有交通信号灯控制的路口，应当交替使用远近光灯示意，提示其他交通参与者。', 'http://file.open.jiakaobaodian.com/tiku/res/1094900.jpg', 1, '[\"A、检查灯光是否能正常使用\",\"B、提示其他交通参与者注意来车\",\"C、准备变更车道\",\"D、超车前提示前车\"]', 1, '1', 1, 1, 4, 0, 0, 1542335950, 1542335950);
INSERT INTO `ks_question` VALUES (317, '如图所示，在这种情况下跟车行驶，不能使用远光灯的原因是什么？', '远光灯会影响前车的视线，使前方驾驶员无法看清周围情况，容易造成事故。', 'http://file.open.jiakaobaodian.com/tiku/res/1095000.jpg', 1, '[\"A、不利于看清远方的路况\",\"B、不利于看清车前的路况\",\"C、会影响自己的视线\",\"D、会影响前车驾驶人的视线\"]', 1, '3', 1, 1, 4, 0, 0, 1542335951, 1542335951);
INSERT INTO `ks_question` VALUES (318, '交叉路口不得倒车的原因是什么？', '交叉路口车流量多，情况很复杂，极易造成拥堵，易发事故，所以不允许倒车的。', NULL, 1, '[\"A、交通警察多\",\"B、车道数量少\",\"C、交通监控设备多\",\"D、交通情况复杂，容易造成交通堵塞甚至引发事故\"]', 1, '3', 1, 1, 0, 0, 0, 1542335952, 1542335952);
INSERT INTO `ks_question` VALUES (319, '行至漫水路段时，应当怎样做？', '《实施条例》第六十四条：机动车行经漫水路或者漫水桥时，应当停车察明水情，确认安全后，低速通过。', NULL, 1, '[\"A、空挡滑行\",\"B、高档位低速通过\",\"C、低速通过涉水路段\",\"D、高速通过，减少涉水时间\"]', 1, '2', 1, 1, 0, 0, 0, 1542335953, 1542335953);
INSERT INTO `ks_question` VALUES (320, '在后方无来车的情况下，在隧道中倒车应该靠边行驶。', '隧道中是不允许倒车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335954, 1542335954);
INSERT INTO `ks_question` VALUES (321, '如图所示，驾驶机动车遇到这种情况能够加速通过，是因为人行横道没有行人通过。', '按规定，驾驶机动车遇到人行横道时必须减速让行，必要时需要停车让行。因为行人具有随意性，突发状况多，需要谨慎减速慢行。', 'http://file.open.jiakaobaodian.com/tiku/res/1095400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335956, 1542335956);
INSERT INTO `ks_question` VALUES (322, '近光灯或者鸣喇叭是为了什么？', '超车时使用变换远、近光灯是提醒前车和后车的意思。', NULL, 1, '[\"A、提醒后车以及前车\",\"B、仅提醒前车\",\"C、提醒行人\",\"D、仅提醒后车\"]', 1, '0', 1, 1, 0, 0, 0, 1542335957, 1542335957);
INSERT INTO `ks_question` VALUES (323, '超车需从前车左侧超越，以下说法正确的是什么？', '我国实行右侧通行原则，左侧为快速车道，右侧为慢速车道。选项描述中只有【便于观察，有利于安全】的说法是正确的。', NULL, 1, '[\"A、便于观察，有利于安全\",\"B、我国实行左侧通行原则\",\"C、右侧为快速车道\",\"D、左侧为慢速车道\"]', 1, '0', 1, 1, 0, 0, 0, 1542335958, 1542335958);
INSERT INTO `ks_question` VALUES (324, '如图所示，在前方路口可以掉头。', '如图所示，前方是铁道路口，根据法规，铁道路口不能掉头。', 'http://file.open.jiakaobaodian.com/tiku/res/1095700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335959, 1542335959);
INSERT INTO `ks_question` VALUES (325, '如图所示，在这种情况下驶进路口，车辆可以怎么行驶？', '注意看图，地面是直行或者左转的箭头，那就只能左转和直行。', 'http://file.open.jiakaobaodian.com/tiku/res/1095800.jpg', 1, '[\"A、直行或右转\",\"B、只能直行\",\"C、左转或者直行\",\"D、左转或右转\"]', 1, '2', 1, 1, 4, 0, 0, 1542335960, 1542335960);
INSERT INTO `ks_question` VALUES (326, '关于机动车灯光的使用，以下说法正确的是什么？', '车辆的灯光不仅仅是在光线不足的情况下提供照明，而更重要的是起到警示作用，即使在白天，人们也会首先注意到亮着灯的车辆，不管是行人还是其他车辆的司机。夜间在照明条件良好的路段行驶，应使用近光灯。', NULL, 1, '[\"A、夜间驾驶机动车在照明条件良好的路段必须使用远光灯\",\"B、夜间驾驶机动车在照明条件良好的路段可以不使用灯光\",\"C、机动车灯光一个重要的作用是提示其他机动车驾驶人和行人\",\"D、机动车灯光的作用仅仅是为了在夜间的照明\"]', 1, '2', 1, 1, 0, 0, 0, 1542335961, 1542335961);
INSERT INTO `ks_question` VALUES (327, '为什么规定辅路车让主路车先行？', '主路车车流量更大，速度更快，更便于观察。本题选择【主路车流量大、速度快】。', NULL, 1, '[\"A、主路车流量大、速度快\",\"B、辅路车便于观察\",\"C、主路车流量小、速度快\",\"D、辅路车速度快\"]', 1, '0', 1, 1, 0, 0, 0, 1542335962, 1542335962);
INSERT INTO `ks_question` VALUES (328, '如图所示，机动车在这样的城市道路上行驶，最高的行驶速度不得超过50公里/小时。', '从图中可以看出，是没有中心线的道路。按照规定，机动车在道路上行驶不得超过限速标志、标线标明的速度。在没有限速标志、标线的道路上，没有道路中心线的道路，城市道路为每小时30公里，公路为每小时40公里。', 'http://file.open.jiakaobaodian.com/tiku/res/1096100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335964, 1542335964);
INSERT INTO `ks_question` VALUES (329, '在涉水路段跟车时，应当怎样做？', '适当增加车距更利于安全行车。', NULL, 1, '[\"A、紧跟其后\",\"B、超越前车，抢先通行\",\"C、适当增加车距\",\"D、并行通过\"]', 1, '2', 1, 1, 0, 0, 0, 1542335965, 1542335965);
INSERT INTO `ks_question` VALUES (330, '如图所示，在这种情况下，会车时必须减速靠右通过。', '会车时必须减速靠右行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/1096300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542335966, 1542335966);
INSERT INTO `ks_question` VALUES (331, '在狭窄的山路会车，规定不靠山体的一方优先行驶的原因是什么？', '不靠山体的一方是悬崖，更危险，所以先行。反过来靠山体的一方是相对安全的。', NULL, 1, '[\"A、靠山体的一方相对安全\",\"B、三项都正确\",\"C、不靠山体的一方车速较快\",\"D、靠山体的一方视野宽阔\"]', 1, '0', 1, 1, 0, 0, 0, 1542335968, 1542335968);
INSERT INTO `ks_question` VALUES (332, '如图所示，通过有这个标志的路口时无需减速。', '如图所示，前方标志为减速让行标志。', 'http://file.open.jiakaobaodian.com/tiku/res/1096600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335969, 1542335969);
INSERT INTO `ks_question` VALUES (333, '牵引故障车，牵引与被牵引的机动车，在行驶中都要开启危险报警闪光灯。', '《实施条例》第六十一条：牵引车和被牵引车均应当开启危险报警闪光灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335970, 1542335970);
INSERT INTO `ks_question` VALUES (334, '雾天行车为了提高能见度，应该开启远光灯。', '在行驶中应该打开雾灯、尾灯、示廓灯和前照灯(近光)，不能使用远光灯。因远光灯光轴偏上，射出的光线被雾气漫反射，在车前形成白茫茫一片，如同隔着磨砂玻璃一样，反而什么都看不见。雾天行车可以靠路面车道标线以及前车的红色尾灯来行车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335971, 1542335971);
INSERT INTO `ks_question` VALUES (335, '其他车辆不准进入专用车道行驶，其目的是为了不影响专用车的正常通行。', '专用车道就说明只供某种车辆通行，其他车辆进入，当然会影响到专用车的正常通行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335974, 1542335974);
INSERT INTO `ks_question` VALUES (336, '如图所示，在这种情况下，您应该轻踩制动踏板减速。', '如图所示，前方道路限速60公里，当车速大于或等于限速时需要踩制动踏板减速。', 'http://file.open.jiakaobaodian.com/tiku/res/1097100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542335975, 1542335975);
INSERT INTO `ks_question` VALUES (337, '驾驶机动车在没有道路中心线的道路上行驶，应该在道路的左侧通行。', '《道路交通安全法》第三十六条：根据道路条件和通行需要，道路划分为机动车道、非机动车道和人行道的，机动车、非机动车、行人实行分道通行。没有划分机动车道、非机动车道和人行道的，机动车在道路中间通行，非机动车和行人在道路两侧通行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335976, 1542335976);
INSERT INTO `ks_question` VALUES (338, '如图所示，这个标志设置在有人看守的铁道路口，提示驾驶人距有人看守的铁路道口的距离还有100米。', '图是无人看守的铁道路口，用来警告车辆驾驶人注意慢行或及时停车，设在无人看守的铁路口以前适当位置。火车头是无人看守，栅栏是有人看守。红色的斜线，一条表示50米，2条100米，3条150米。无人看守说成了有人看守，所以选择【错误】。', 'http://file.open.jiakaobaodian.com/tiku/res/1097300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335977, 1542335977);
INSERT INTO `ks_question` VALUES (339, '如图所示，铁道路口设置这个标志，是提示驾驶人前方路口有单股铁道。', '叉行符号：多股铁路与道路相交。', 'http://file.open.jiakaobaodian.com/tiku/res/1097400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335978, 1542335978);
INSERT INTO `ks_question` VALUES (340, '年龄在70周岁以上，在一个记分周期结束后一年内未提交身体条件证明的，其机动车驾驶证将会被车辆管理所注销。', '根据《机动车驾驶证申领和使用规定》第42条第6项：年龄在70周岁以上，在一个记分周期结束后一年内未提交身体条件证明的，车辆管理所应当注销其机动车驾驶证。被注销机动车驾驶证未超过两年的，机动车驾驶人考试科目一合格后，可以恢复驾驶资格。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335979, 1542335979);
INSERT INTO `ks_question` VALUES (341, '大型货车驾驶证的驾驶人从业单位等信息发生变化的，应当在信息变更后三十日内，向驾驶证核发地车辆管理所备案。', '公安部123号令规定：“机动车驾驶人联系电话、联系地址等信息发生变化，以及持有大型客车、牵引车、城市公交车、中型客车、大型货车准驾车型驾驶证的驾驶人从业单位等信息发生变化，应在信息变更后三十日内，向驾驶证核发地车辆管理所备案”。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335980, 1542335980);
INSERT INTO `ks_question` VALUES (342, '持有小型汽车驾驶证的驾驶人，发生交通事故造成人员死亡承担同等以上责任未被吊销机动车驾驶证的，应当在本记分周期结束后三十日内到公安机关交通管理部门接受审验，同时应当申报身体条件情况。', '《公安部令第123号》第六十条持有本条第三款规定以外准驾车型驾驶证的驾驶人，发生交通事故造成人员死亡承担同等以上责任未被吊销机动车驾驶证的，应当在本记分周期结束后三十日内到公安机关交通管理部门接受审验。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335981, 1542335981);
INSERT INTO `ks_question` VALUES (343, '事故等原因辨认不清或者损坏的，可以向登记地车辆管理所申请备案。', '《机动车登记规定》：发动机号码、车辆识别代号因磨损、锈蚀、事故等原因辨认不清或者损坏的，可以向登记地车辆管理所申请备案。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335983, 1542335983);
INSERT INTO `ks_question` VALUES (344, '机动车登记证书丢失后应及时补办，避免被不法分子利用。', '机动车登记证书丢失后应尽快补办，是正确的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335984, 1542335984);
INSERT INTO `ks_question` VALUES (345, '驾驶机动车发生交通事故未造成人身伤亡的，责任明确双方无争议时，应当如何处置？', '《中华人民共和国道路交通安全法》第七十条明确规定在道路上发生交通事故，未造成人身伤亡，当事人对事实及成因无争议的，可以即行撤离现场，恢复交通，自行协商处理损害赔偿事宜；不即行撤离现场的，应当迅速报告执勤的交通警察或者公安机关交通管理部门。', NULL, 1, '[\"A、不要移动车辆\",\"B、保护好现场再协商\",\"C、撤离现场自行协商\",\"D、疏导其他车辆绕行\"]', 1, '2', 1, 1, 0, 0, 0, 1542335985, 1542335985);
INSERT INTO `ks_question` VALUES (346, '毁灭证据的，应当承担什么责任？', '发生交通事故后当事人逃逸的，故意破坏、伪造现场、毁灭证据的，均承担全部责任。', NULL, 1, '[\"A、次要责任\",\"B、主要责任\",\"C、同等责任\",\"D、全部责任\"]', 1, '3', 1, 1, 0, 0, 0, 1542335986, 1542335986);
INSERT INTO `ks_question` VALUES (347, '行人故意碰撞机动车造成交通事故的，机动车一方不承担赔偿责任。', '《中华人民共和国道路交通安全法》第七十六条：机动车发生交通事故造成人身伤亡、财产损失的，由保险公司在机动车第三者责任强制保险责任限额范围内予以赔偿；不足的部分，按照下列规定承担赔偿责任：（一）机动车之间发生交通事故的，由有过错的一方承担赔偿责任；双方都有过错的，按照各自过错的比例分担责任。（二）机动车与非机动车驾驶人、行人之间发生交通事故，非机动车驾驶人、行人没有过错的，由机动车一方承担赔偿责任；有证据证明非机动车驾驶人、行人有过错的，根据过错程度适当减轻机动车一方的赔偿责任；机动车一方没有过错的，承担不超过百分之十的赔偿责任。交通事故的损失是由非机动车驾驶人、行人故意碰撞机动车造成的，机动车一方不承担赔偿责任。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335987, 1542335987);
INSERT INTO `ks_question` VALUES (348, '如图所示，红圈中标记车辆使用灯光的方法是正确的。', '《中华人民共和国道路交通安全法实施条例》第四十八条规定：在没有中心隔离设施或者没有中心线的道路上，夜间会车应当在距相对方向来车150米以外改用近光灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1120000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335988, 1542335988);
INSERT INTO `ks_question` VALUES (349, '驾驶机动车超车时，可以鸣喇叭替代开启转向灯。', '机动车超车时，应当提前开启左转向灯、变换使用远、近光灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335989, 1542335989);
INSERT INTO `ks_question` VALUES (350, '驾驶机动车变更车道时，以下做法正确的是什么？', '驾驶机动车变更车道时，在道路同方向划有2条以上机动车道的，不得影响相关车道内行驶的机动车的正常行驶。', NULL, 1, '[\"A、在道路同方向划有2条以上机动车道的，不得影响相关车道内行驶的机动车的正常行驶\",\"B、遇前方道路拥堵，可以向应急车道变更\",\"C、开启转向灯的同时变更车道\",\"D、在车辆较少路段，可以随意变更车道\"]', 1, '0', 1, 1, 0, 0, 0, 1542335990, 1542335990);
INSERT INTO `ks_question` VALUES (351, '驾驶机动车应在变更车道的同时开启转向灯。', '机动车在变更车道时，应当提前开启转向灯，夜间还需变换使用远、近光灯或者鸣喇叭。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335991, 1542335991);
INSERT INTO `ks_question` VALUES (352, '如图所示，A车可以从左侧超越B车。', 'A车的左边为实线，A车不能压过实线超车。', 'http://file.open.jiakaobaodian.com/tiku/res/1120400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542335993, 1542335993);
INSERT INTO `ks_question` VALUES (353, '如图所示，驾驶机动车行驶至桥梁涵洞时，以下做法正确的是什么？', '驾驶机动车行驶至桥梁涵洞时，做法正确的是：减速靠右通过。', 'http://file.open.jiakaobaodian.com/tiku/res/1120500.jpg', 1, '[\"A、鸣喇叭后加速通过\",\"B、减速靠右通过\",\"C、加速，在对向车到达前通过\",\"D、保持原速继续正常行驶\"]', 1, '1', 1, 1, 4, 0, 0, 1542335994, 1542335994);
INSERT INTO `ks_question` VALUES (354, '如图所示，驾驶机动车遇到这种情况，以下做法正确的是什么？', '驾驶机动车遇到这种情况，应该：减速慢行、鸣喇叭示意。', 'http://file.open.jiakaobaodian.com/tiku/res/1120600.jpg', 1, '[\"A、加速行驶\",\"B、减速慢行、鸣喇叭示意\",\"C、为拓宽视野，临时占用左侧车道行驶\",\"D、停车观察\"]', 1, '1', 1, 1, 4, 0, 0, 1542335995, 1542335995);
INSERT INTO `ks_question` VALUES (355, '驾驶机动车在隧道内行驶时，可以临时停车。', '机动车在交叉路口、铁路道口、急弯路、宽度不足4米的窄路、桥梁、陡坡、隧道以及距离上述地点50米以内的路段，不得停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542335996, 1542335996);
INSERT INTO `ks_question` VALUES (356, '毁灭证据的，承担全部责任。', '发生交通事故后当事人逃逸的，故意破坏、伪造现场、毁灭证据的，均承担全部责任。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335997, 1542335997);
INSERT INTO `ks_question` VALUES (357, '机动车驾驶证补领后，以下说法正确的是什么？', '《机动车驾驶证申领和使用规定》机动车驾驶人补领机动车驾驶证后，原机动车驾驶证作废，不得继续使用。', NULL, 1, '[\"A、替换使用\",\"B、原驾驶证特殊情况下使用\",\"C、原驾驶证作废，不得继续使用\",\"D、原驾驶证继续使用\"]', 1, '2', 1, 1, 0, 0, 0, 1542335998, 1542335998);
INSERT INTO `ks_question` VALUES (358, '机动车驾驶人补领机动车驾驶证后，原机动车驾驶证作废，不得继续使用。', '《机动车驾驶证申领和使用规定》机动车驾驶人补领机动车驾驶证后，原机动车驾驶证作废，不得继续使用。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542335999, 1542335999);
INSERT INTO `ks_question` VALUES (359, '超过机动车驾驶证有效期一年以上未换证被注销，但未超过2年的，机动车驾驶人应当如何恢复驾驶资格？', '《机动车驾驶证申领和使用规定》机动车驾驶人补领机动车驾驶证后，原机动车驾驶证作废，不得继续使用。', NULL, 1, '[\"A、参加道路驾驶技能考试合格后\",\"B、参加道路交通安全法律、法规和相关知识考试合格后\",\"C、参加安全文明驾驶常识考试合格后\",\"D、参加场地考试合格后\"]', 1, '1', 1, 1, 0, 0, 0, 1542336001, 1542336001);
INSERT INTO `ks_question` VALUES (360, '已注册登记的机动车达到国家规定的强制报废标准的，应当向登记地车辆管理所申请注销登记。', '《中华人民共和国道路交通安全法》第二章第十四条规定:应当报废的机动车必须及时办理注销登记。达到报废标准的机动车不得上道路行驶。报废的大型客、货车及其他营运车辆应当在公安机关交通管理部门的监督下解体。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336002, 1542336002);
INSERT INTO `ks_question` VALUES (361, '存在以下哪种行为的申请人在一年内不得再次申领机动车驾驶证？', '《机动车驾驶证申领和使用规定》第六章，法律责任，第七十八条，隐瞒有关情况或者提供虚假材料申领机动车驾驶证的，申请人在一年内不得再次申领机动车驾驶证。申请人在考试过程中有贿赂、舞弊行为的，取消考试资格，已经通过考试的其他科目成绩无效；申请人在一年内不得再次申领机动车驾驶证。', NULL, 1, '[\"A、在考试过程中出现身体不适\",\"B、不能按照教学大纲认真练习驾驶技能\",\"C、在考试过程中有舞弊行为\",\"D、未参加理论培训\"]', 1, '2', 1, 1, 0, 0, 0, 1542336003, 1542336003);
INSERT INTO `ks_question` VALUES (362, '驾驶人在核发地车辆管理所管辖区以外居住的，可以向居住地车辆管理所申请换证。', '《机动车驾驶证申领和使用规定》第六章，法律责任，第七十八条，隐瞒有关情况或者提供虚假材料申领机动车驾驶证的，申请人在一年内不得再次申领机动车驾驶证。申请人在考试过程中有贿赂、舞弊行为的，取消考试资格，已经通过考试的其他科目成绩无效；申请人在一年内不得再次申领机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336004, 1542336004);
INSERT INTO `ks_question` VALUES (363, '大型货车驾驶证的驾驶人，记分周期内有记分的，应当在记分周期结束后三十日内到公安机关交通管理部门接受审验，同时还应当申报身体条件情况。', '《公安部令第123号》第六十条：持有大型客车、牵引车、城市公交车、中型客车、大型货车驾驶证的驾驶人，应当在每个记分周期结束后三十日内到公安机关交通管理部门接受审验。但在一个记分周期内没有记分记录的，免予本记分周期审验。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336005, 1542336005);
INSERT INTO `ks_question` VALUES (364, '如图所示，夜间驾驶机动车遇对方使用远光灯，无法看清前方路况时，以下做法正确的是什么？', '《公安部令第123号》第六十条：持有大型客车、牵引车、城市公交车、中型客车、大型货车驾驶证的驾驶人，应当在每个记分周期结束后三十日内到公安机关交通管理部门接受审验。但在一个记分周期内没有记分记录的，免予本记分周期审验。', 'http://file.open.jiakaobaodian.com/tiku/res/1121600.jpg', 1, '[\"A、自己也打开远光灯行驶\",\"B、加速通过，尽快摆脱眩目光线\",\"C、保持行驶方向和车速不变\",\"D、降低车速，谨慎会车\"]', 1, '3', 1, 1, 4, 0, 0, 1542336007, 1542336007);
INSERT INTO `ks_question` VALUES (365, '如图所示，驾驶机动车经过这种道路时，如果前方没有其他交通参与者，可在道路上随意通行。', '驾驶机动车经过这种道路时，如果前方没有其他交通参与者，也不可在道路上随意通行，安全第一。', 'http://file.open.jiakaobaodian.com/tiku/res/1121700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336008, 1542336008);
INSERT INTO `ks_question` VALUES (366, '如图所示，驾驶机动车直行遇前方道路堵塞时，车辆可以在黄色网格线区域临时停车等待，但不得在人行横道停车。', '驾驶机动车直行遇前方道路堵塞时，车辆不可在黄色网格线区域临时停车等待，也不可在人行横道停车。', 'http://file.open.jiakaobaodian.com/tiku/res/1121800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336009, 1542336009);
INSERT INTO `ks_question` VALUES (367, '行人的情况下，可以通行。', '驾驶机动车在路口遇到这种交通信号时，右转弯的车辆在不妨碍被放行的车辆、行人的情况下，可以通行。', 'http://file.open.jiakaobaodian.com/tiku/res/1121900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336010, 1542336010);
INSERT INTO `ks_question` VALUES (368, '如图所示，驾驶机动车遇到右侧车辆强行变道，应减速慢行，让右前方车辆顺利变道。', '驾驶机动车遇到右侧车辆强行变道，应减速慢行，让右前方车辆顺利变道。', 'http://file.open.jiakaobaodian.com/tiku/res/1122000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336011, 1542336011);
INSERT INTO `ks_question` VALUES (369, '驾驶机动车行经漫水路或者漫水桥时，应当停车察明水情。', '机动车行经漫水路或者漫水桥时，应当停车察明水情，确认安全后，低速通过。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336012, 1542336012);
INSERT INTO `ks_question` VALUES (370, '当驾驶人的血液中酒精含量为100毫克/100毫升时，属于醉酒驾驶。', '醉酒驾驶是指车辆驾驶人员血液中的酒精含量大于或者等于80mg/100mL的驾驶行为。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336015, 1542336015);
INSERT INTO `ks_question` VALUES (371, '驾驶机动车在道路上发生交通事故，任何情况下都应标明现场位置后，先行撤离现场。', '因为根据交通安全法的规定，如果机动车在道路上面发生了事故，那么必须要马上停车保护现场，如果有人员伤亡的情况，驾驶人应该马上去抢救受伤人员。并且报告执勤的交警或交通管理部门。如果因为抢救伤员而变动了现场的话，就要表明位置。路人或过往的车辆驾驶人或乘客都应该协助帮忙。如果在道路上发生交通事故，没有造成人员伤亡的，当事人没有对事故有任何争议的，可以撤离现场恢复交通秩序，双方自行协商处理损害赔偿就行了。果说有争议的话，那么不要撤离现场，需要马上报给相关的交警来处理。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336016, 1542336016);
INSERT INTO `ks_question` VALUES (372, '申请人有下列哪种行为，三年内不得再次申领机动车驾驶证？', '《机动车驾驶证申领和使用规定》第十二条有下列情形之一的，不得申请机动车驾驶：（一）有器质性心脏病、癫痫病、美尼尔氏症、眩晕症、癔病、震颤麻痹、精神病、痴呆以及影响肢体活动的神经系统疾病等妨碍安全驾驶疾病的；（二）三年内有吸食、注射毒品行为或者解除强制隔离戒毒措施未满三年，或者长期服用依赖性精神药品成瘾尚未戒除的；（三）造成交通事故后逃逸构成犯罪的；（四）申请人以欺骗、贿赂等不正当手段取得机动车驾驶证的；（五）醉酒驾驶营运机动车依法被吊销机动车驾驶证未满十年的。', NULL, 1, '[\"A、实习期记满12分，注销驾驶证的\",\"B、申请人在考试过程中有舞弊行为的\",\"C、申请人未能在培训过程中认真练习的\",\"D、申请人以欺骗、贿赂等不正当手段取得机动车驾驶证的\"]', 1, '3', 1, 1, 0, 0, 0, 1542336017, 1542336017);
INSERT INTO `ks_question` VALUES (373, '申请人患有精神病的，可以申领机动车驾驶证，但是在发病期间不得驾驶机动车。', '《机动车驾驶证申领和使用规定》第十二条有下列情形之一的，不得申请机动车驾驶证：（一）有器质性心脏病、癫痫病、美尼尔氏症、眩晕症、癔病、震颤麻痹、精神病、痴呆以及影响肢体活动的神经系统疾病等妨碍安全驾驶疾病的；（二）三年内有吸食、注射毒品行为或者解除强制隔离戒毒措施未满三年，或者长期服用依赖性精神药品成瘾尚未戒除的；（三）造成交通事故后逃逸构成犯罪的；（四）申请人以欺骗、贿赂等不正当手段取得机动车驾驶证的；（五）醉酒驾驶营运机动车依法被吊销机动车驾驶证未满十年的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336018, 1542336018);
INSERT INTO `ks_question` VALUES (374, '在暂住地初次申领机动车驾驶证的，不能直接申领大型货车驾驶证。', '2016年4月1日已经实施的“公安部139号令”已经删除2012年的“公安部123令”中第十三条第二款关于“不能在暂住地初次申领大型货车驾驶证”的规定，取消了异地考驾照对客货车驾驶证的限制，客货车驾驶证也可以在暂住地申领了，但是需要有当地的居住证或者暂住证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336019, 1542336019);
INSERT INTO `ks_question` VALUES (375, '机动车驾驶证有效期超过一年以上未换证的，驾驶证将被注销。', '《机动车驾驶证申领和使用规定》第四十二条机动车驾驶人具有下列情形之一的，车辆管理所应当注销其机动车驾驶证：（一）死亡的；（二）身体条件不适合驾驶机动车的；（三）提出注销申请的；（四）丧失民事行为能力，监护人提出注销申请的；（五）超过机动车驾驶证有效期一年以上未换证的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336020, 1542336020);
INSERT INTO `ks_question` VALUES (376, '驾驶证审验内容不包括以下哪一项？', '驾驶证审验内容包括：道路交通安全违法行为、交通事故处理情况；身体条件情况；道路交通安全违法行为记分及记满12分后参加学习和考试情况。', NULL, 1, '[\"A、机动车检验情况\",\"B、道路交通安全违法行为记分及记满12分后参加学习和考试情况\",\"C、道路交通安全违法行为、交通事故处理情况\",\"D、身体条件情况\"]', 1, '0', 1, 1, 0, 0, 0, 1542336021, 1542336021);
INSERT INTO `ks_question` VALUES (377, '驾驶机动车在道路上发生交通事故，当事人不能自行移动车辆的，应当保护现场并立即报警。', '《中华人民共和国道路交通安全法》中第七十条第一款规定，在道路上发生交通事故，车辆驾驶人应当立即停车，保护现场。也就是说，司机发生交通事故，不论损失大小，首先必须要停车，保护现场。然后根据损失的大小确定下一步应当做什么。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336022, 1542336022);
INSERT INTO `ks_question` VALUES (378, '隧道内均不能倒车。', '根据交通法，机动车在交叉路口、隧道内均不能倒车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336024, 1542336024);
INSERT INTO `ks_question` VALUES (379, '驾驶机动车发生以下交通事故，哪种情况适用自行协商解决？', '《中华人民共和国道路交通安全法实施条例》第八十六条规定:“机动车与机动车、机动车与非机动车在道路上发生未造成人身伤亡的交通事故，当事人对事实及成因无争议的，在记录交通事故的时间、地点、对方当事人的姓名和联系方式、机动车牌号、驾驶证号、保险凭证号、碰撞部位，并共同签名后，撤离现场，自行协商损害赔偿事宜。当事人对交通事故事实及成因有争议的，应当迅速报警。”', NULL, 1, '[\"A、对事实及成因有争议的\",\"B、对方饮酒的\",\"C、造成人身伤亡的\",\"D、未造成人身伤亡，对事实及成因无争议的\"]', 1, '3', 1, 1, 0, 0, 0, 1542336025, 1542336025);
INSERT INTO `ks_question` VALUES (380, '夜间驾驶机动车在没有中心隔离设施或者没有中心线的道路上行驶，以下哪种情况下应当改用近光灯？', '记住，只有在没有路灯或者没有照明的情况下才能用远光灯，一般都用近光灯。窄路窄桥，你若用远光灯，会让对方完全看不清，掉到桥下去的。夜间驾驶机动车遇到对向来车未关闭远光灯时，变换使用远近光灯提示。', NULL, 1, '[\"A、接近没有交通信号灯控制的交叉路口时\",\"B、与对向机动车会车时\",\"C、接近人行横道时\",\"D、城市道路照明条件不良时\"]', 1, '1', 1, 1, 0, 0, 0, 1542336026, 1542336026);
INSERT INTO `ks_question` VALUES (381, '如图所示，驾驶机动车遇前方车流行驶缓慢时，借用公交专用道超车是正确的。', '机动车不得借用公交专用道行驶或超车。', 'http://file.open.jiakaobaodian.com/tiku/res/1123400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336027, 1542336027);
INSERT INTO `ks_question` VALUES (382, '如图所示，驾驶机动车行驶至车道减少的路段时，遇前方机动车排队等候或行驶缓慢时，以下做法正确的是什么？', '驾驶机动车行驶至车道减少的路段时，前方机动车排队等候或行驶缓慢时，应当每车道一辆依次交替驶入左侧车道。', 'http://file.open.jiakaobaodian.com/tiku/res/1123500.jpg', 1, '[\"A、右侧车寻找空隙提前进入左侧车道\",\"B、左侧车让右侧车先行\",\"C、右侧车让左侧车先行\",\"D、每车道一辆依次交替驶入左侧车道\"]', 1, '3', 1, 1, 4, 0, 0, 1542336028, 1542336028);
INSERT INTO `ks_question` VALUES (383, '机动车驾驶证遗失的，机动车驾驶人应当向哪里的车辆管理所申请补发？', '驾驶证遗失、损毁无法辨认时驾驶员应当向驾驶证核发地车辆管理所申请补发。', NULL, 1, '[\"A、核发地\",\"B、户籍地\",\"C、暂住地\",\"D、居住地\"]', 1, '0', 1, 1, 0, 0, 0, 1542336029, 1542336029);
INSERT INTO `ks_question` VALUES (384, '暂扣期间能否申请补发？', '机动车驾驶证被依法扣押、扣留或者暂扣期间，机动车驾驶人不得申请补发。', NULL, 1, '[\"A、暂扣期间可以临时申请\",\"B、扣留期间可以临时申请\",\"C、可以申请\",\"D、不得申请补发\"]', 1, '3', 1, 1, 0, 0, 0, 1542336031, 1542336031);
INSERT INTO `ks_question` VALUES (385, '驾驶证丢失后,驾驶人可以继续驾驶机动车。', '驾驶证丢失后，驾驶人不可继续驾驶机动车，应该向核发地车辆管理所申请补发。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336032, 1542336032);
INSERT INTO `ks_question` VALUES (386, '已注册登记的机动车，改变机动车车身颜色的应到公安交通管理部门申请变更登记。', '《中华人民共和国道路运输条例》说明，已注册登记的机动车，改变机动车车身颜色的应到公安交通管理部门申请变更登记。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336033, 1542336033);
INSERT INTO `ks_question` VALUES (387, '如图所示，驾驶机动车经过这种道路时，应降低车速在道路中间通行。', '图中道路两侧都有行人，驾驶机动车经过这种道路时，需要降低车速在道路中间通行。', 'http://file.open.jiakaobaodian.com/tiku/res/1124000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336034, 1542336034);
INSERT INTO `ks_question` VALUES (388, '如图所示，驾驶机动车遇到这种情况，可以轻按喇叭提醒前方非机动车和行人后方有来车。', '前方有行人和自行车，道路较窄，驾驶机动车遇到这种情况，可以轻按喇叭提醒前方非机动车和行人后方有来车，这样更加安全。', 'http://file.open.jiakaobaodian.com/tiku/res/1124100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336035, 1542336035);
INSERT INTO `ks_question` VALUES (389, '驾驶机动车通过未设置交通信号灯的交叉路口时，下列说法错误的是什么？', '驾驶机动车通过未设置交通信号灯的交叉路口时，转弯的机动车应当让直行的车辆、行人先行；没有交通标志、标线控制时，在进入路口前停车瞭望，让右方道路的来车先行；相对方向行驶的右转弯机动车让左转弯的车辆先行。', NULL, 1, '[\"A、转弯的机动车让直行的车辆、行人先行\",\"B、没有交通标志、标线控制时，在进入路口前停车瞭望，让右方道路的来车先行\",\"C、相对方向行驶的右转弯机动车让左转弯的车辆先行\",\"D、相对方向行驶的左转弯机动车让右转弯的车辆先行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336036, 1542336036);
INSERT INTO `ks_question` VALUES (390, '如图所示，驾驶机动车遇到这种情况时，以下做法正确的是什么？', '图中所示，河水已经漫过路面，驾驶机动车遇到这种情况时，应停车察明水情，确认安全后，低速通过；不可随意通行。', 'http://file.open.jiakaobaodian.com/tiku/res/1124300.jpg', 1, '[\"A、应停车察明水情，确认安全后，低速通过\",\"B、应减速观察水情，然后加速行驶通过\",\"C、应停车察明水情，确认安全后，快速通过\",\"D、可随意通行\"]', 1, '0', 1, 1, 4, 0, 0, 1542336037, 1542336037);
INSERT INTO `ks_question` VALUES (391, '以下哪项行为可构成危险驾驶罪？', '危险驾驶罪是指在道路上醉酒驾驶机动车或者在道路上驾驶机动车追逐竞驶，情节恶劣的行为。', NULL, 1, '[\"A、无证驾驶\",\"B、疲劳驾驶\",\"C、醉驾\",\"D、闯红灯\"]', 1, '2', 1, 1, 0, 0, 0, 1542336039, 1542336039);
INSERT INTO `ks_question` VALUES (392, '机动车发生轻微财产损失的交通事故，对应当自行撤离现场而未撤离的，交通警察有权责令当事人撤离现场。', '《中华人民共和国道路交通安全法》中第七十条第二、三款规定，在道路上发生交通事故，未造成人身伤亡，当事人对事实及成因无争议的，可以即行撤离现场，恢复交通，自行协商处理损害赔偿事宜；不即行撤离现场的，应当迅速报告执勤的交通警察或者公安机关交通管理部门。在道路上发生交通事故，仅造成轻微财产损失，并且基本事实清楚的，当事人应当先撤离现场再进行协商处理。根据《中华人民共和国道路交通安全法》的有关规定精神，仅造成车物损失或者人体伤情轻微的交通事故，可由一名交通警察按照简易程序处理。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336040, 1542336040);
INSERT INTO `ks_question` VALUES (393, '实习期驾驶人驾驶机动车上高速公路行驶，以下做法正确的是什么？', '相关法律规定，实习期驾驶人驾驶机动车上高速公路行驶，应当由持相应或者更高准驾车型驾驶证三年以上的驾驶人陪同。', NULL, 1, '[\"A、需要持有相应或者更高准驾车型驾驶证、同在实习期内的驾驶人陪同\",\"B、需要持有相应或者更高准驾车型驾驶证三年以上的驾驶人陪同\",\"C、不需要其他人员陪同\",\"D、任何情况下都不允许上高速\"]', 1, '1', 1, 1, 0, 0, 0, 1542336041, 1542336041);
INSERT INTO `ks_question` VALUES (394, '年龄在70周岁以上的机动车驾驶人，应当每年进行一次身体检查的目的是什么？', '2016年4月1日开始实行的新修改的《机动车驾驶证申领和使用规定》规定：年龄在70周岁以上的机动车驾驶人，应当每年进行一次身体检查，在记分周期结束后的三十日内，提交县级或者部队团级以上医疗机构出具的有关身体条件的证明，检查是否患有妨碍安全驾驶的疾病。', NULL, 1, '[\"A、体现对老年人的关心\",\"B、例行程序仅供参考\",\"C、检查是否患有妨碍安全驾驶的疾病\",\"D、检查是否患有老年常见病\"]', 1, '2', 1, 1, 0, 0, 0, 1542336042, 1542336042);
INSERT INTO `ks_question` VALUES (395, '年龄在50周岁以上的机动车驾驶人，应当每年进行一次身体检查，并向公安机关交通管理部门申报身体条件情况。', '2016年4月1日开始实行的新修改的《机动车驾驶证申领和使用规定》规定：年龄在70周岁以上的机动车驾驶人，应当每年进行一次身体检查，在记分周期结束后的三十日内，提交县级或者部队团级以上医疗机构出具的有关身体条件的证明，检查是否患有妨碍安全驾驶的疾病。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336043, 1542336043);
INSERT INTO `ks_question` VALUES (396, '联系地址等信息发生变化，应当在信息变更后三十日内，向驾驶证核发地车辆管理所备案。', '持有大型客车、牵引车、城市公交车、中型客车、大型货车驾驶证的驾驶人联系电话、从业单位等信息发生变化未及时申报变更信息的，公安机关交通管理部门处二十元以上二百元以下罚款。机动车驾驶人联系电话、联系地址等信息发生变化，应当在信息变更后三十日内，向驾驶证核发地车辆管理所备案。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336044, 1542336044);
INSERT INTO `ks_question` VALUES (397, '从业单位等信息发生变化未及时申报变更信息的，公安机关交通管理部门处二十元以上二百元以下罚款。', '持有大型客车、牵引车、城市公交车、中型客车、大型货车驾驶证的驾驶人联系电话、从业单位等信息发生变化未及时申报变更信息的，公安机关交通管理部门处二十元以上二百元以下罚款。机动车驾驶人联系电话、联系地址等信息发生变化，应当在信息变更后三十日内，向驾驶证核发地车辆管理所备案。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336045, 1542336045);
INSERT INTO `ks_question` VALUES (398, '机动车参加安全技术检验的主要目的是检查车辆各项性能系数，及时消除车辆安全隐患，减少事故发生。', '机动车参加安全技术检验的主要目的，都是为了降低交通安全隐患，减少交通事故。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336047, 1542336047);
INSERT INTO `ks_question` VALUES (399, '联系方式变更的，应当向登记地车辆管理所备案。', '修订后的《机动车登记规定》已经2008年4月21日公安部部长办公会议通过，自2008年10月1日起施行。第十七条规定：已注册登记的机动车，机动车所有人住所在车辆管理所管辖区域内迁移或者机动车所有人姓名(单位名称)、联系方式变更的，应当向登记地车辆管理所备案。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336048, 1542336048);
INSERT INTO `ks_question` VALUES (400, '驾驶机动车发生交通事故，仅造成财产损失的，但是对交通事故事实及成因有争议的，应当怎么处理？', '对于事故成因不明的交通事故，应及时报警。', NULL, 1, '[\"A、占道继续和对方争辩\",\"B、迅速报警\",\"C、自行协商损害赔偿事宜\",\"D、找中间人帮忙解决\"]', 1, '1', 1, 1, 0, 0, 0, 1542336049, 1542336049);
INSERT INTO `ks_question` VALUES (401, '如图所示，驾驶机动车驶出这个路口时应当怎样使用灯光?', '驶入开左转向灯，驶出开右转向灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1125400.jpg', 1, '[\"A、不用开启转向灯\",\"B、开启危险报警闪光灯\",\"C、开启左转向灯\",\"D、开启右转向灯\"]', 1, '3', 1, 1, 4, 0, 0, 1542336050, 1542336050);
INSERT INTO `ks_question` VALUES (402, '驾驶机动车在道路上掉头时，应当提前开启左转向灯。', '《中华人民共和国道路交通安全法实施条例》第五十七条机动车应当按照下列规定使用转向灯：（一）向左转弯、向左变更车道、准备超车、驶离停车地点或者掉头时，应当提前开启左转向灯；（二）向右转弯、向右变更车道、超车完毕驶回原车道、靠路边停车时，应当提前开启右转向灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336051, 1542336051);
INSERT INTO `ks_question` VALUES (403, '驾驶机动车在交叉路口前变更车道时，应在进入实线区后，开启转向灯，变更车道。', '在虚线区就要完成车道变更选择而变更车道要提前开启转向灯的，实线区才开转向灯就不能做到提前开启转向灯的要求了，而且实线区禁止变更车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336052, 1542336052);
INSERT INTO `ks_question` VALUES (404, '如图所示，A车具有优先通行权。', '直行先行，但若让A车等待B车，则时间更长，所以都是直行的情况下，A车先行。', 'http://file.open.jiakaobaodian.com/tiku/res/1125700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336053, 1542336053);
INSERT INTO `ks_question` VALUES (405, '如图所示，驾驶机动车在路口前遇到这种情况时，A车具有优先通行权。', '直行优先。', 'http://file.open.jiakaobaodian.com/tiku/res/1125800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336055, 1542336055);
INSERT INTO `ks_question` VALUES (406, '驾驶机动车遇前方交叉路口交通阻塞时，路口内无网状线的，可停在路口内等候。', '《中华人民共和国道路交通安全法实施条例》第五十三条：机动车遇有前方交叉路口交通阻塞时，应当依次停在路口以外等候，不得进入路口。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336056, 1542336056);
INSERT INTO `ks_question` VALUES (407, '驾驶机动车在高速公路上行驶，错过出口时，如果确认后方无来车，可以倒回出口驶离高速公路。', '错过出口时，应在下一个出口出去，不能倒回。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336057, 1542336057);
INSERT INTO `ks_question` VALUES (408, '发生交通事故时，下列哪种情况下当事人应当保护现场并立即报警？', '酒后驾驶属违法行为，应及时报警。', NULL, 1, '[\"A、未发生财产损失事故\",\"B、未损害公共设施及建筑物的\",\"C、未造成人员伤亡的\",\"D、驾驶人有酒后驾驶嫌疑的\"]', 1, '3', 1, 1, 0, 0, 0, 1542336058, 1542336058);
INSERT INTO `ks_question` VALUES (409, '下列哪种情况可以向机动车驾驶证核发地车辆管理所申请补发?', '驾驶证被扣留、扣押及暂扣都可再次取回，机动车驾驶证遗失、损毁无法辨认时，机动车驾驶人应当向机动车驾驶证核发地车辆管理所申请补发。', NULL, 1, '[\"A、驾驶证被暂扣\",\"B、驾驶证被扣留\",\"C、驾驶证遗失\",\"D、驾驶证被扣押\"]', 1, '2', 1, 1, 0, 0, 0, 1542336059, 1542336059);
INSERT INTO `ks_question` VALUES (410, '机动车驾驶人补领机动车驾驶证后，使用原机动车驾驶证驾驶的，除由公安机关交通管理部门收回原机动车驾驶证外，还应当受到何种处罚？', '机动车驾驶人补领机动车驾驶证后，继续使用原机动车驾驶证的,公安机关交通管理部门可处二十元以上二百元以下罚款。', NULL, 1, '[\"A、罚款\",\"B、吊销驾驶证\",\"C、警告\",\"D、拘留驾驶人\"]', 1, '0', 1, 1, 0, 0, 0, 1542336060, 1542336060);
INSERT INTO `ks_question` VALUES (411, '质押备案期间不可以办理转移登记。', '第二十条有下列情形之一的，不予办理转移登记：(一)机动车与该车档案记载内容不一致的；(二)属于海关监管的机动车，海关未解除监管或者批准转让的；(三)机动车在抵押登记、质押备案期间的；(四)有本规定第九条第(一)项、第(二)项、第(七)项、第(八)项、第(九)项规定情形的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336061, 1542336061);
INSERT INTO `ks_question` VALUES (412, '机动车所有人申请转移登记前，应当将涉及该车的道路交通安全违法行为和交通事故处理完毕。', '第十八条已注册登记的机动车所有权发生转移的，现机动车所有人应当自机动车交付之日起三十日内向登记地车辆管理所申请转移登记。机动车所有人申请转移登记前，应当将涉及该车的道路交通安全违法行为和交通事故处理完毕。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336062, 1542336062);
INSERT INTO `ks_question` VALUES (413, '赠予等方式获得机动车后尚未注册登记的，向车辆管理所申领临时行驶车号牌后，方可临时上道路行驶。', '经购买、调拨、赠予等方式获得机动车后尚未注册登记的，向车辆管理所申领临时行驶车号牌后，方可临时上道路行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336064, 1542336064);
INSERT INTO `ks_question` VALUES (414, '财产损失的，机动车一方没有过错的，不承担赔偿责任。', '《道路交通事故》第七十六条：机动车发生交通事故造成人身伤亡、财产损失的，由保险公司在机动车第三者责任强制保险责任限额范围内予以赔偿。超过责任限额的部分，按照下列方式承担赔偿责任：（一）机动车之间发生交通事故的，由有过错的一方承担责任；双方都有过错的，按照各自过错的比例分担责任。（二）机动车与非机动车驾驶人、行人之间发生交通事故的，由机动车一方承担责任；但是，有证据证明非机动车驾驶人、行人违反道路交通安全法律、法规，机动车驾驶人已经采取必要处置措施的，减轻机动车一方的责任。交通事故的损失是由非机动车驾驶人、行人故意造成的，机动车一方不承担责任。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336065, 1542336065);
INSERT INTO `ks_question` VALUES (415, '如图所示，驾驶机动车行驶至此位置时，以下做法正确的是什么？', '驾驶机动车行驶至此位置时，以下做法正确的是：不得左转，应当直行。', 'http://file.open.jiakaobaodian.com/tiku/res/1126800.jpg', 1, '[\"A、倒车退到虚线处换到左转车道\",\"B、从该处直接左转\",\"C、观察左侧无车后，可以左转\",\"D、不得左转，应当直行\"]', 1, '3', 1, 1, 4, 0, 0, 1542336066, 1542336066);
INSERT INTO `ks_question` VALUES (416, '财产轻微损失的交通事故后，以下做法正确的是什么？', '《中华人民共和国道路交通安全法实施条例》第八十六条规定:“机动车与机动车、机动车与非机动车在道路上发生未造成人身伤亡的交通事故，当事人对事实及成因无争议的，在记录交通事故的时间、地点、对方当事人的姓名和联系方式、机动车牌号、驾驶证号、保险凭证号、碰撞部位，并共同签名后，撤离现场，自行协商损害赔偿事宜。当事人对交通事故事实及成因有争议的，应当迅速报警。”', NULL, 1, '[\"A、确保安全的情况下，对现场拍照，然后将车辆移至路边等不妨碍交通的地点\",\"B、停在现场保持不动\",\"C、开车离开现场\",\"D、必须报警，等候警察处理\"]', 1, '0', 1, 1, 0, 0, 0, 1542336067, 1542336067);
INSERT INTO `ks_question` VALUES (417, '以下不属于机动车驾驶证审验内容的是什么？', '机动车驾驶证审验内容：（一）道路交通安全违法行为、交通事故处理情况；（二）身体条件情况；（三）道路交通安全违法行为记分及记满12分后参加学习和考试情况。对交通违法行为或者交通事故未处理完毕的、身体条件不符合驾驶许可条件的、未按照规定参加学习、教育和考试的，不予通过审验。', NULL, 1, '[\"A、驾驶车辆累计行驶里程\",\"B、道路交通安全违法行为、交通事故处理情况\",\"C、记满12分后参加学习和考试情况\",\"D、驾驶人身体条件\"]', 1, '0', 1, 1, 0, 0, 0, 1542336068, 1542336068);
INSERT INTO `ks_question` VALUES (418, '已注册登记的机动车，改变车身颜色，机动车所有人不需要向登记地车辆管理所申请变更登记。', '《中华人民共和国道路运输条例》说明，已注册登记的机动车，改变机动车车身颜色的应到公安交通管理部门申请变更登记。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336069, 1542336069);
INSERT INTO `ks_question` VALUES (419, '驾驶机动车在高速公路上行驶，遇低能见度气象条件时，能见度在200米以下，车速不得超过每小时多少公里，与同车道前车至少保持多少米的距离？', '驾驶机动车在高速公路上行驶，遇低能见度气象条件时，能见度在200米以下，车速不得超过60公里/小时，与同车道前车至少保持100米的车距以保证安全。', NULL, 1, '[\"A、40，80\",\"B、60，100\",\"C、70，100\",\"D、30，80\"]', 1, '1', 1, 1, 0, 0, 0, 1542336070, 1542336070);
INSERT INTO `ks_question` VALUES (420, '如图所示，驾驶机动车遇左侧车道有车辆正在超车时，可以迅速变道，伺机反超。', '遇到左侧车辆超车，应当减速慢行，靠右边行，以保障行车安全。', 'http://file.open.jiakaobaodian.com/tiku/res/1127300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336071, 1542336071);
INSERT INTO `ks_question` VALUES (421, '如图所示，驾驶机动车遇到这种情况，不仅要控制车速留出会车空间，而且要注意与右侧的儿童保持足够的安全距离。', '窄路路边有儿童，这种情况应该控制车速为会车留出足够的空间，同时注意与右侧的儿童保持足够的安全距离。', 'http://file.open.jiakaobaodian.com/tiku/res/1127400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336073, 1542336073);
INSERT INTO `ks_question` VALUES (422, '机动车驾驶人血液中酒精含量大于或者等于多少可认定为醉驾？', '机动车驾驶人血液中酒精含量大于或者等于80毫克/100毫升会被判定为醉驾。', NULL, 1, '[\"A、60毫克/100毫升\",\"B、50毫克/100毫升\",\"C、20毫克/100毫升\",\"D、80毫克/100毫升\"]', 1, '3', 1, 1, 0, 0, 0, 1542336074, 1542336074);
INSERT INTO `ks_question` VALUES (423, '如图所示，驾驶机动车在这种情况下，当C车减速让超车时，A车应该如何行驶？', '因为C车减速让超车的同时又来向B车进行会车，此时继续超车容易造成危险，所以应当放弃超越C车。', 'http://file.open.jiakaobaodian.com/tiku/res/1127600.jpg', 1, '[\"A、放弃超越C车\",\"B、鸣喇叭示意B车让行后超车\",\"C、直接向左变更车道，迫使B车让行\",\"D、加速超越C车\"]', 1, '0', 1, 1, 4, 0, 0, 1542336075, 1542336075);
INSERT INTO `ks_question` VALUES (424, '如图所示，夜间驾驶机动车与同方向行驶的前车距离较近时，以下做法正确的是什么？', '夜间驾驶机动车与同方向行驶的前车距离较近时，禁止使用远光灯，避免灯光照射至前车后视镜造成前车驾驶人眩目。', 'http://file.open.jiakaobaodian.com/tiku/res/1127700.jpg', 1, '[\"A、禁止使用远光灯，避免灯光照射至前车后视镜造成自己眩目\",\"B、使用远光灯，有利于告知前方驾驶人后方有来车\",\"C、禁止使用远光灯，避免灯光照射至前车后视镜造成前车驾驶人眩目\",\"D、使用远光灯，有利于观察路面情况\"]', 1, '2', 1, 1, 4, 0, 0, 1542336076, 1542336076);
INSERT INTO `ks_question` VALUES (425, '非机动车道和人行道的，以下说法正确的是什么？', '驾驶机动车经过无划分车道的道路时，机动车在道路中间通行，非机动车和行人在道路两侧通行。', NULL, 1, '[\"A、机动车、非机动车和行人可随意通行\",\"B、机动车在道路左侧通行，非机动车和行人在道路两侧通行\",\"C、机动车在道路左侧通行，非机动车和行人随意通行\",\"D、机动车在道路中间通行，非机动车和行人在道路两侧通行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336077, 1542336077);
INSERT INTO `ks_question` VALUES (426, '驾驶机动车经过无划分车道的道路时，可以随意通行。', '驾驶机动车经过无划分车道的道路时，机动车在道路中间通行，非机动车和行人在道路两侧通行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336078, 1542336078);
INSERT INTO `ks_question` VALUES (427, '驾驶机动车在路口右转弯时，应提前开启右转向灯，不受信号灯限制，不受车速限制，迅速通过，防止路口堵塞。', '驾驶机动车在路口右转弯时，应提前开启右转向灯，不受信号灯限制，必须限制车速，注意观察行人及来往车辆，安全通过。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336079, 1542336079);
INSERT INTO `ks_question` VALUES (428, '驾驶机动车遇到前方道路拥堵时，可以借用无人通行的非机动车道行驶。', '机动车不得借用非机动车道行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336080, 1542336080);
INSERT INTO `ks_question` VALUES (429, '如图所示，红圈标注的深色车辆的做法是违法的。', '白色实线不允许变道，深色车辆在白色实线上变更车道，属于违法行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/1128200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336081, 1542336081);
INSERT INTO `ks_question` VALUES (430, '驾驶机动车行经漫水路或者漫水桥时，应当停车察明水情，快速通过。', '《中华人民共和国道路交通管理条例》的第四十六条规定：车辆行经漫水路或漫水桥时，必须停车察明水情，确认安全后，低速通过。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336084, 1542336084);
INSERT INTO `ks_question` VALUES (431, '关于醉酒驾驶机动车的处罚，以下说法错误的是什么？', '醉酒驾驶机动车的，由公安机关交通管理部门约束至酒醒，吊销机动车驾驶证，依法追究刑事责任；五年内不得重新取得机动车驾驶证。', NULL, 1, '[\"A、五年内不得重新取得机动车驾驶证\",\"B、吊销驾驶证\",\"C、公安机关交通管理部门约束至酒醒\",\"D、记6分\"]', 1, '3', 1, 1, 0, 0, 0, 1542336085, 1542336085);
INSERT INTO `ks_question` VALUES (432, '驾驶机动车在道路上发生交通事故造成人身伤亡的，驾驶人必须报警。', '《中华人民共和国道路交通安全法》第七十条规定：在道路上发生交通事故，车辆驾驶人应当立即停车，保护现场；造成人身伤亡的，车辆驾驶人应当立即抢救受伤人员，并迅速报告执勤的交通警察或者公安机关交通管理部门。因抢救受伤人员变动现场的，应当标明位置。乘车人、过往车辆驾驶人、过往行人应当予以协助。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336086, 1542336086);
INSERT INTO `ks_question` VALUES (433, '两辆机动车发生轻微碰擦事故后，为保证理赔，必须等保险公司人员到场鉴定后才能撤离现场。', '《中华人民共和国道路交通安全法》中第七十条第二、三款规定，在道路上发生交通事故，未造成人身伤亡，当事人对事实及成因无争议的，可以即行撤离现场，恢复交通，自行协商处理损害赔偿事宜；不即行撤离现场的，应当迅速报告执勤的交通警察或者公安机关交通管理部门。在道路上发生交通事故，仅造成轻微财产损失，并且基本事实清楚的，当事人应当先撤离现场再进行协商处理。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336087, 1542336087);
INSERT INTO `ks_question` VALUES (434, '以下哪种身体条件，不可以申请机动车驾驶证?', '红绿色盲会影响观察红绿灯，不可以申请机动车驾驶证。', NULL, 1, '[\"A、高血压\",\"B、红绿色盲\",\"C、怀孕\",\"D、糖尿病\"]', 1, '1', 1, 1, 0, 0, 0, 1542336088, 1542336088);
INSERT INTO `ks_question` VALUES (435, '申请人患有癫痫病的，可以申领机动车驾驶证，但是驾驶时必须有人陪同。', '申请人患有癫痫病的，不可以申领机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336089, 1542336089);
INSERT INTO `ks_question` VALUES (436, '自愿降级的驾驶人需要到车辆管理所申请换领驾驶证。', '自愿降级的驾驶人，由本人带驾驶证、身份证去车管所提出申请，并换领驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336090, 1542336090);
INSERT INTO `ks_question` VALUES (437, '补领机动车驾驶证应到以下哪个地方办理？', '如果出现驾驶证丢失需补办的情况，需要到驾驶证核发地车辆管理所补领机动车驾驶证。', NULL, 1, '[\"A、所学驾校\",\"B、派出所\",\"C、全国任何地方公安机关交通管理部门\",\"D、驾驶证核发地车辆管理所\"]', 1, '3', 1, 1, 0, 0, 0, 1542336091, 1542336091);
INSERT INTO `ks_question` VALUES (438, '机动车驾驶人驾驶证有效期满换领驾驶证时，须提交县级以上医疗机构出具的身体条件证明。', '《道路运输从业人员管理规定》规定：机动车驾驶人驾驶证有效期满换领驾驶证时，须提交县级以上医疗机构出具的身体条件证明。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336093, 1542336093);
INSERT INTO `ks_question` VALUES (439, '年龄在70周岁以上的机动车驾驶人，应当每年进行一次身体检查。', '2016年4月1日开始实行的新修改的《机动车驾驶证申领和使用规定》规定：年龄在70周岁以上的机动车驾驶人，应当每年进行一次身体检查，在记分周期结束后的三十日内，提交县级或者部队团级以上医疗机构出具的有关身体条件的证明。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336094, 1542336094);
INSERT INTO `ks_question` VALUES (440, '驾驶人吸食或注射毒品后驾驶机动车的，一经查获，其驾驶证将被注销。', '严禁机动车驾驶员酒驾或者毒驾，驾驶人吸食或注射毒品后驾驶机动车的，一经查获，将注销其驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336095, 1542336095);
INSERT INTO `ks_question` VALUES (441, '遇到这种单方交通事故，应如何处理？', '图中的车辆撞到了隔离带，属于损坏公共财物，所以需要先报警，由交警队对交通事故责任进行认定。对于民事赔偿部分，先由保险公司在交强险的范围内承担赔偿责任，超过部分，按照责任比例进行划分。', 'http://file.open.jiakaobaodian.com/tiku/res/1155200.jpg', 1, '[\"A、报警\",\"B、直接联系绿化部门\",\"C、直接联系路政部门进行理赔\",\"D、不用报警\"]', 1, '0', 1, 1, 4, 0, 0, 1542336096, 1542336096);
INSERT INTO `ks_question` VALUES (442, '机动车之间发生交通事故，不管是否有人员伤亡，只要双方当事人同意，都可自行协商解决', '如果造成人员伤亡，特别是非机动车和行人的伤亡，是不能“私了”的，必须报警由交警认定事故中是否存在酒驾等刑事犯罪行为。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336097, 1542336097);
INSERT INTO `ks_question` VALUES (443, '车辆号牌等信息，协助交警快速定位到达现场。', '提供这些信息已经非常完备，事故经过等细节，可以等交警到达现场后进行描述。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336098, 1542336098);
INSERT INTO `ks_question` VALUES (444, '假如您在高速公路上不小心错过了准备驶出的路口，正确的操作应该是？', '《中华人民共和国道路交通安全法》规定：如果在高速公路上倒车、逆行、穿越中央分隔带掉头等严重交通违法行为，200元处罚、一次性记12分。所以应该继续向前行驶，寻找下一个出口。', NULL, 1, '[\"A、紧急刹车，倒车至想要驶出的路口\",\"B、在应急停车道上停车，等待车辆较少的时候再伺机倒车\",\"C、继续前行，到下一出口驶离高速公路掉头\",\"D、借用应急停车道进行掉头，逆向行驶\"]', 1, '2', 1, 1, 0, 0, 0, 1542336099, 1542336099);
INSERT INTO `ks_question` VALUES (445, '下列高速公路交通标志与其含义对应的正确的一项是？', '图1应该是高速公路终点标志；图2是高速公路服务区预告；图4是紧急电话标志而不是公用电话标志。', 'http://file.open.jiakaobaodian.com/tiku/res/1155600.jpg', 1, '[\"A、图3\",\"B、图4\",\"C、图1\",\"D、图2\"]', 1, '0', 1, 1, 4, 0, 0, 1542336100, 1542336100);
INSERT INTO `ks_question` VALUES (446, '驾驶车辆进入高速公路加速车道后，须尽快将车速提高到每小时60公里以上的原因是什么？', '影响主线的交通，其他事故发生等，只是一种可能性。', NULL, 1, '[\"A、以防后方车辆发生追尾事故\",\"B、以防汇入车流时影响主线车道上行驶的车辆\",\"C、以防被其他车辆超过\",\"D、以防违反最低限速要求受到处罚\"]', 1, '1', 1, 1, 0, 0, 0, 1542336102, 1542336102);
INSERT INTO `ks_question` VALUES (447, '在高速公路上开车遇到图中所示的情况时，以下操作不正确的是什么？', '在图中这种能见度低的情况下，保持高速行驶容易发生追尾事故。', 'http://file.open.jiakaobaodian.com/tiku/res/1155800.jpg', 1, '[\"A、能见度低，应该与同车道前车间距保持一定距离\",\"B、继续维持高速行驶，防止后面车辆堵塞\",\"C、应该打开雾灯、近光灯、示廓灯、前后位灯，危险报警灯光\",\"D、降低车速，防止紧急情况下无法及时制动\"]', 1, '1', 1, 1, 4, 0, 0, 1542336103, 1542336103);
INSERT INTO `ks_question` VALUES (448, '雪天在高速公路上驾驶时，关于安全车距错误的说法是什么？', '驾驶机动车在高速公路上行驶，遇低能见度气象条件时，能见度在200米以下，车速不得超过60公里/小时，与同车道前车至少保持100米的车距以保证安全。', NULL, 1, '[\"A、雪天路滑，制动距离比干燥柏油路更长\",\"B、能见度小于50m时，应该驶离高速公路\",\"C、雪天能见度低，应该根据能见度控制安全距离\",\"D、能见度小于200m时，与前车至少保持50m的安全距离\"]', 1, '3', 1, 1, 0, 0, 0, 1542336104, 1542336104);
INSERT INTO `ks_question` VALUES (449, '高速公路上同时有最高和最低速度限制，因为过快或者过慢都容易导致追尾。', '过快容易与前车追尾，过慢容易与后车追尾。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336105, 1542336105);
INSERT INTO `ks_question` VALUES (450, '驾驶人在实习期内驾驶机动车上高速公路行驶，应由持相应或者更高准驾车型驾驶证一年以上的驾驶人陪同。', '《机动车驾驶证申领和使用规定》：初次领证的驾驶人在12个月的实习期内驾驶机动车上高速公路行驶，必须有三年以上驾龄的司机陪同，否则将处以200元罚款，并由交警带离高速公路。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336106, 1542336106);
INSERT INTO `ks_question` VALUES (451, '轧车行道分界线行驶，会同时占用两个车道，导致后方车辆行驶困难，易引发交通事故。', '一辆车占两条道，这是走别人的路，让别人无路可走的节奏啊。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336107, 1542336107);
INSERT INTO `ks_question` VALUES (452, '车辆在高速公路发生故障不能移动时，驾驶人这种尝试排除故障的做法是否正确？', '图中有三个错误：（一）、应立即开启危险报警闪光灯，利用车辆惯性，将车驶入紧急停车带或右侧路肩停下，尽量不要占用行车道；（二）、车辆停放好后，驾驶人和乘车人从路外侧的车门尽快离开车辆，转移到右侧的路肩或者应急车道内，如需到车内或者车下进行维修，也应由外侧的车门出入；（三）、要把故障车警告标志放置在来车方向150米处，并立即报警，如果是夜间，还必须开启示宽灯和尾灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1156300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336108, 1542336108);
INSERT INTO `ks_question` VALUES (453, '下列做法是否正确？', '图中的小型客车是在高速公路上充当牵引车，两车应该在最右侧车道上行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/1156400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336109, 1542336109);
INSERT INTO `ks_question` VALUES (454, '高速公路上车辆发生故障后，开启危险报警闪光灯和摆放警告标志是为了向其他车辆求助。', '开启危险报警灯光和摆放警告标志，是为了让后车注意避让，避免发生事故。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336111, 1542336111);
INSERT INTO `ks_question` VALUES (455, '高速公路上车辆发生故障后，开启危险报警闪光灯和摆放警告标志的作用是警告后续车辆注意避让。', '开启危险报警灯光和摆放警告标志，是为了让后车注意避让，避免发生事故。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336112, 1542336112);
INSERT INTO `ks_question` VALUES (456, '车辆发生故障无法移动时，以下做法是否正确？', '应该把警告标志放置于车辆后的150米以外，图片中放在了车前，是错误的做法。', 'http://file.open.jiakaobaodian.com/tiku/res/1156700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336113, 1542336113);
INSERT INTO `ks_question` VALUES (457, '驾驶机动车在高速公路上发生故障，需要停车排除故障时，若能将机动车移至应急车道内，则不需要开启危险报警闪光灯。', '车辆发生故障了，为了提醒后来车辆注意避免事故发生，都应该开启危险报警闪光灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336114, 1542336114);
INSERT INTO `ks_question` VALUES (458, '车辆发生故障而无法移动时，首先应在车辆后方50-150米处放置危险警告标志，防止后车追尾。', '应该先开启危险报警闪光灯，并在车后50-100米以内放置警告标志。PS：在高速公路上，危险报警标志应放在车后150米外的地方。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336115, 1542336115);
INSERT INTO `ks_question` VALUES (459, '对驾驶过程中接打手机的看法正确的是？', '《中华人民共和国道路交通安全法实施条例》第六十二条 （三）项明确规定：“驾驶机动车不得有下列行为：拨打接听手持电话的行为”，违者罚款200元，扣2分。', NULL, 1, '[\"A、在车流量不大的道路上驾驶时，短时接听手持电话是可以的\",\"B、开车需要接打电话时，应该先找到安全的地方停车再操作\",\"C、根据驾龄和驾车技术，经验丰富的驾驶人可以在驾驶过程中接打手持电话\",\"D、开车过程中不主动打电话，但是有重要电话打进来是可以边开车边接听手持电话的\"]', 1, '1', 1, 1, 0, 0, 0, 1542336116, 1542336116);
INSERT INTO `ks_question` VALUES (460, '蓝色车辆遇到图中的情形时，下列做法正确的是？', '斑马线是行人的，机动车是临时借用的，所以不要朝斑马线的行人鸣笛、闪灯，耐心安静的等待是正确做法。', 'http://file.open.jiakaobaodian.com/tiku/res/1157100.jpg', 1, '[\"A、鸣喇叭提醒，让学生队伍中空出一个缺口，从缺口中穿行过去\",\"B、鸣喇叭，催促还未通过的学生加快速度通过\",\"C、按照前方交通信号灯指示直接通行\",\"D、停车等待，直到学生队伍完全通过\"]', 1, '3', 1, 1, 4, 0, 0, 1542336117, 1542336117);
INSERT INTO `ks_question` VALUES (461, '驾驶车辆时在道路上抛撒物品，以下说法不正确的是？', '《道路交通安全法实施条例》 第六十二条：驾驶机动车不得向道路上抛撒物品。一点垃圾是几乎不影响到燃油消耗的。', NULL, 1, '[\"A、保持车内整洁，减少燃油消耗\",\"B、抛撒纸张等轻质物品会阻挡驾驶人视线，分散驾驶人注意力\",\"C、破坏环境，影响环境整洁，甚至造成路面的损坏\",\"D、有可能引起其他驾驶人紧急躲避等应激反应，进而引发事故\"]', 1, '0', 1, 1, 0, 0, 0, 1542336118, 1542336118);
INSERT INTO `ks_question` VALUES (462, '下面关于下坡熄火滑行的说法错误的是？', '其他三个选项都说的很清楚，这样做很危险，如果为了省油，却伤害自己，不值得。', NULL, 1, '[\"A、对于采用了助力转向系统的车辆而言，下坡时熄火会使转向盘变重，难以控制\",\"B、下坡道熄火时，车辆不能使用发动机制动\",\"C、下坡滑行是利用坡道的位能推动汽车前进，发动机不工作，可以节油，应大力提倡\",\"D、对于采用真空助力刹车系统的车辆而言，下坡时的熄火会使刹车系统失效\"]', 1, '2', 1, 1, 0, 0, 0, 1542336119, 1542336119);
INSERT INTO `ks_question` VALUES (463, '如图所示，当机动车行驶至交叉口时的做法是正确的。', '绿灯的情况下，该车道的标线表示：该车道可以直行可以右转，右转没有任何问题，右转后只有一个车道，不存在转过去要靠最右边车道行驶的问题。', 'http://file.open.jiakaobaodian.com/tiku/res/1157400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336121, 1542336121);
INSERT INTO `ks_question` VALUES (464, '当后排座位没有人乘坐时，后车门未关好就起步也是可以的。', '就算后排没有乘客，如果门没有关好，在行驶途中突然打开，会影响其他车辆的行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336122, 1542336122);
INSERT INTO `ks_question` VALUES (465, '车辆后备箱门未关好，是可以上路行驶的。', '后备箱很可能有其他物品，如果没有关好，行驶途中掉落物品，会影响其它车辆的行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/1157600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336123, 1542336123);
INSERT INTO `ks_question` VALUES (466, '下列哪个交通标志表示不能停车？', '图1：禁止长时停车；图2：禁止停车；图3：停车检查；图4：停车让行。', 'http://file.open.jiakaobaodian.com/tiku/res/1157700.jpg', 1, '[\"A、图1\",\"B、图3\",\"C、图4\",\"D、图2\"]', 1, '3', 1, 1, 4, 0, 0, 1542336124, 1542336124);
INSERT INTO `ks_question` VALUES (467, '图中深色车辆在该地点临时停车是可以的。', '不能在人行横道上停车。', 'http://file.open.jiakaobaodian.com/tiku/res/1157800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336125, 1542336125);
INSERT INTO `ks_question` VALUES (468, '图中标注车辆在该地点停车是可以的。', '公共汽车站、急救站、加油站、消防栓或者消防队（站）门前以及距离上述地点30米以内的路段，除使用上述设施外，不得停车。', 'http://file.open.jiakaobaodian.com/tiku/res/1157900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336126, 1542336126);
INSERT INTO `ks_question` VALUES (469, '图中小型汽车的停车地点是正确的。', '公共汽车站、急救站、加油站、消防栓或者消防队（站）门前以及距离上述地点30以内的路段，除使用上述设施外，不得停车。', 'http://file.open.jiakaobaodian.com/tiku/res/1158000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336127, 1542336127);
INSERT INTO `ks_question` VALUES (470, '如图所示，A车在此处停车是可以的。', '交叉路口、铁道路口，急转弯、宽度不足4米的窄路，桥梁，陡坡、隧道以及距离上述地点50米以内的路段，不得停车；图上的车离路口只有30米，不足50米。', 'http://file.open.jiakaobaodian.com/tiku/res/1158100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336128, 1542336128);
INSERT INTO `ks_question` VALUES (471, '在道路上驾驶机动车追逐竞驶，情节恶劣的，或者在道路上醉酒驾驶机动车的如何处罚？', '根据《中华人民共和国刑法修正法（八）》规定“在道路上驾驶机动车追逐竞驶，情节恶劣的，或者在道路上醉酒驾驶机动车的，处拘役，并处罚金。”', NULL, 1, '[\"A、处拘役，并处罚金\",\"B、7年以下有期徒刑\",\"C、3年以下有期徒刑\",\"D、10年以下有期徒刑\"]', 1, '0', 1, 1, 0, 0, 0, 1542336131, 1542336131);
INSERT INTO `ks_question` VALUES (472, '以下哪种情形不会被扣留车辆？', '《道路交通安全法》第九十五条：上道路行驶的机动车未悬挂机动车号牌，未放置检验合格标志、保险标志，或者未随车携带行驶证、驾驶证的，公安机关交通管理部门应当扣留机动车。', NULL, 1, '[\"A、没有放置保险标志\",\"B、未随车携带灭火器\",\"C、未随车携带行驶证\",\"D、没有按规定悬挂号牌\"]', 1, '1', 1, 1, 0, 0, 0, 1542336132, 1542336132);
INSERT INTO `ks_question` VALUES (473, '以下哪种情形会被扣留车辆？', '《道路交通安全法》第九十五条：上道路行驶的机动车未悬挂机动车号牌，未放置检验合格标志、保险标志，或者未随车携带行驶证、驾驶证的，公安机关交通管理部门应当扣留机动车。', NULL, 1, '[\"A、未放置检验合格标志\",\"B、驾驶人开车打电话\",\"C、车内装饰过多\",\"D、未安装防撞装置\"]', 1, '0', 1, 1, 0, 0, 0, 1542336133, 1542336133);
INSERT INTO `ks_question` VALUES (474, '机动车之间发生交通事故造成轻微财产损失，当事人对事实及成因无争议时，在确保安全的原则下，对现场拍照或标划事故车辆现场位置后，可自行撤离现场处理损害赔偿事宜，主要目的是什么？', '拍照后让开道路，主要是为了不影响交通通行，也避免二次事故的发生。', NULL, 1, '[\"A、为了及时恢复交通，避免造成交通拥堵\",\"B、事故后果很小，无需赔偿\",\"C、找现场证人就行了，不必报警\",\"D、双方互有损失\"]', 1, '0', 1, 1, 0, 0, 0, 1542336134, 1542336134);
INSERT INTO `ks_question` VALUES (475, '事故后果非常严重的交通事故，可自行撤离现场。', '轻微事故才能自行撤离，严重的事故必须报警并保护现场，不能自行撤离。《中华人民共和国道路交通安全法》第七十条规定：在道路发生交通事故，车辆驾驶人应当立即停车，保护现场；造成人身伤亡的，车辆驾驶人应当立即抢救受伤人员，并迅速报告执勤的交通警察或者公安机关交通管理部门。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336135, 1542336135);
INSERT INTO `ks_question` VALUES (476, '车辆发生轻微剐蹭事故，双方驾驶人争执不下，坚持在原地等待警察来处理，造成路面堵塞，该行为会受到罚款的处罚。', '《道路交通事故处理程序规定》第十三条：对应当自行撤离现场而未撤离的，交通警察应当责令当事人撤离现场；造成交通堵塞的，对驾驶人处以200元罚款；驾驶人有其他道路交通安全违法行为的，依法一并处罚。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336136, 1542336136);
INSERT INTO `ks_question` VALUES (477, '安全，应依次交替通行。', '《中华人民共和国道路交通安全法实施条例》第五十三条：机动车在车道减少的路口、路段，遇有前方机动车停车排队等候或者缓慢行驶的，应当每车道一辆依次交替驶入车道减少后的路口、路段。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336137, 1542336137);
INSERT INTO `ks_question` VALUES (478, '驾驶机动车在没有划分道路中心线的城市道路上行驶速度不得超过50公里/小时。', '没有道路中心线的道路，城市道路为每小时30公里，公路为每小时40公里。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336138, 1542336138);
INSERT INTO `ks_question` VALUES (479, '交通肇事致一人以上重伤，负事故全部或者主要责任，并具有下列哪种行为的，构成交通肇事罪？', '交通肇事致一人以上重伤，负事故全部或者主要责任，并具有以下列情形之一的，以交通肇事罪定罪处罚：（一）酒后、吸食毒品后驾驶机动车辆的；（二）无驾驶资格驾驶机动车辆的；（三）明知是安全装置不全或者安全机件失灵的机动车辆而驾驶的；（四）明知是无牌证或者已报废的机动车辆而驾驶的；（五）严重超载驾驶的；（六)为逃避法律追究逃离事故现场的。由以上条例可知，本题应选择无驾驶资格驾驶机动车辆的行为。', NULL, 1, '[\"A、未报警\",\"B、未带驾驶证\",\"C、未抢救受伤人员的\",\"D、明知是安全装置不全或者安全机件失灵的机动车辆而驾驶的\"]', 1, '3', 1, 1, 0, 0, 0, 1542336139, 1542336139);
INSERT INTO `ks_question` VALUES (480, '机动车驾驶人在一个记分周期内累计记分达到12分，拒不参加学习和考试的，将被公安机关交通部门公告其驾驶证停止使用。', '《道路交通安全法实施条例》第二十五条：机动车驾驶人记分达到12分，拒不参加公安机关交通管理部门通知的学习，也不接受考试的，由公安机关交通管理部门告其机动车驾驶证停止使用。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336142, 1542336142);
INSERT INTO `ks_question` VALUES (481, '如图所示，B车具有优先通行权。', '右转让左转，转弯让直行。如图所示，A车直行而B车右转，明显A车先行，B车避让。', 'http://file.open.jiakaobaodian.com/tiku/res/5632300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336144, 1542336144);
INSERT INTO `ks_question` VALUES (482, '事故停车后，不按规定使用灯光和设置警告标志的，将被一次记多少分？', '根据《机动车驾驶证申领和使用规定》第六十五条，道路交通安全违法行为累积记分周期（即记分周期）为12个月，满分为12分，从机动车驾驶证初次领取之日起计算。依据道路交通安全违法行为的严重程度，一次记分的分值为：12分、6分、3分、2分、1分五种。在《道路交通安全违法行为记分分值》中指出，机动车驾驶人有下列违法行为之一， 一次记3分：①驾驶营运客车（不包括公共汽车）、校车以外的载客汽车载人超过核定人数未达20%的；②驾驶中型以上载客载货汽车、危险物品运输车辆在高速公路、城市快速路以外的道路上行驶或者驾驶其他机动车行驶超过规定时速未达20% 的；③驾驶货车载物超过核定载质量未达30% 的；④驾驶机动车在高速公路上行驶低于规定最低时速的；⑤驾驶禁止驶入高速公路的机动车驶入高速公路的；⑥驾驶机动车在高速公路或者城市快速路上不按规定车道行驶的；⑦驾驶机动车行经人行横道，不按规定减速、停车、避让行人的；⑧驾驶机动车违反禁令标志、禁止标线指示的；⑨驾驶机动车不按规定超车、让行的，或者逆向行驶的；⑩驾驶机动车违反规定牵引挂车的；⑪在道路上车辆发生故障、事故停车后，不按规定使用灯光和设置警告标志的；⑫上道路行驶的机动车未按规定定期进行安全技术检验的。', NULL, 1, '[\"A、2分\",\"B、1分\",\"C、6分\",\"D、3分\"]', 1, '3', 1, 1, 0, 0, 0, 1542336146, 1542336146);
INSERT INTO `ks_question` VALUES (483, '在这种情况下，想超越前车，可借右侧公交车道。', '超车只能左侧超，不能右侧超车，而且也不能占用公交专用车道。仅当发生事故、正常道路封闭有标示注明允许借用或者交警指示等特殊情况允许借道行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/10957700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336147, 1542336147);
INSERT INTO `ks_question` VALUES (484, '违反交通管制的规定强行通行，不听劝阻的，由公安机关交通管理部门处两百元以上两千元以下罚款，可以并处十五日以下拘留。', '根据《中华人民共和国道路交通安全法》第九十九条，有下列行为之一的，由公安机关交通管理部门处两百元以上两千元以下罚款:①未取得机动车驾驶证、机动车驾驶证被吊销或者机动车驾驶证被暂扣期间驾驶机动车的；②将机动车交由未取得机动车驾驶证或者机动车驾驶证被吊销、暂扣的人驾驶的；③造成交通事故后逃逸，尚不构成犯罪的；④机动车行驶超过规定时速百分之五十的；⑤强迫机动车驾驶人违反道路交通安全法律、法规和机动车安全驾驶要求驾驶机动车，造成交通事故，尚不构成犯罪的；⑥违反交通管制的规定强行通行，不听劝阻的；⑦故意损毁、移动、涂改交通设施，造成危害后果，尚不构成犯罪的；⑧非法拦截、扣留机动车辆，不听劝阻，造成交通严重阻塞或者较大财产损失的。行为人有前款第二项、第四项情形之一的，可以并处吊销机动车驾驶证；有第一项、第三项、第五项至第八项情形之一的，可以并处十五日以下拘留。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336148, 1542336148);
INSERT INTO `ks_question` VALUES (485, '在路口右转弯遇同车道前车等候放行信号时，要依次停车等候。', '根据《中华人民共和国道路交通安全法实施条例》第五十一条，机动车通过有交通信号灯控制的交叉路口，应当按照下列规定通行：1.在划有导向车道的路口，按所需行进方向驶入导向车道；2.准备进入环形路口的让已在路口内的机动车先行；3.向左转弯时，靠路口中心点左侧转弯。转弯时开启转向灯，夜间行驶开启近光灯；4.遇放行信号时，依次通过；5.遇停止信号时，依次停在停止线以外。没有停止线的，停在路口以外；6.向右转弯遇有同车道前车正在等候放行信号时，依次停车等候；7.在没有方向指示信号灯的交叉路口，转弯的机动车让直行的车辆、行人先行。 相对方向行驶的右转弯机动车让左转弯车辆先行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336150, 1542336150);
INSERT INTO `ks_question` VALUES (486, '驾驶机动车在路口直行遇到这种信号灯应该怎样行驶？', '《实施条例》第三十八条：机动车信号灯和非机动车信号灯表示：(一)绿灯亮时，准许车辆通行，但转弯的车辆不得妨碍被放行的直行车辆、行人通行；(二)黄灯亮时，已越过停止线的车辆可以继续通行；(三)红灯亮时，禁止车辆通行。', 'http://file.open.jiakaobaodian.com/tiku/res/836500.jpg', 1, '[\"A、加速直行通过\",\"B、左转弯行驶\",\"C、不得越过停止线\",\"D、进入路口等待\"]', 1, '2', 1, 1, 4, 0, 0, 1542336151, 1542336151);
INSERT INTO `ks_question` VALUES (487, '驾驶机动车行驶到这个位置时，如果车前轮已越过停止线可以继续通过。', '《实施条例》第三十八条：机动车信号灯和非机动车信号灯表示：(一)绿灯亮时，准许车辆通行，但转弯的车辆不得妨碍被放行的直行车辆、行人通行；(二)黄灯亮时，已越过停止线的车辆可以继续通行；(三)红灯亮时，禁止车辆通行。在未设置非机动车信号灯和人行横道信号灯的路口，非机动车和行人应当按照机动车信号灯的表示通行。红灯亮时，右转弯的车辆在不妨碍被放行的车辆、行人通行的情况下，可以通行。应该是车体全部越过停止线才可以继续通过，红灯时前轮刚过线就必须停下来，不然闯红灯。', 'http://file.open.jiakaobaodian.com/tiku/res/836600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336152, 1542336152);
INSERT INTO `ks_question` VALUES (488, '驾驶机动车在这种信号灯亮的路口，可以右转弯。', '《实施条例》第三十八条：机动车信号灯和非机动车信号灯表示：(一)绿灯亮时，准许车辆通行，但转弯的车辆不得妨碍被放行的直行车辆、行人通行；(二)黄灯亮时，已越过停止线的车辆可以继续通行；(三)红灯亮时，禁止车辆通行。红灯亮时，右转弯的车辆在不妨碍被放行的车辆、行人通行的情况下，可以通行。在红灯为圆圈，而不是方向箭头和红叉时候，右转弯的车辆只要安全的情况下就可以右转。如果路口信号灯有箭头指示灯时，需要根据箭头灯的指示。', 'http://file.open.jiakaobaodian.com/tiku/res/836700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336153, 1542336153);
INSERT INTO `ks_question` VALUES (489, '驾驶机动车在路口遇到这种信号灯禁止通行。', '《实施条例》第三十八条：机动车信号灯和非机动车信号灯表示：(一)绿灯亮时，准许车辆通行，但转弯的车辆不得妨碍被放行的直行车辆、行人通行；(二)黄灯亮时，已越过停止线的车辆可以继续通行；(三)红灯亮时，禁止车辆通行。红灯停，绿灯行。此时路口亮绿灯，车辆是可以通行的。', 'http://file.open.jiakaobaodian.com/tiku/res/836800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336154, 1542336154);
INSERT INTO `ks_question` VALUES (490, '绿灯亮表示前方路口允许机动车通行。', '《实施条例》第三十八条：机动车信号灯和非机动车信号灯表示：(一)绿灯亮时，准许车辆通行，但转弯的车辆不得妨碍被放行的直行车辆、行人通行；(二)黄灯亮时，已越过停止线的车辆可以继续通行；(三)红灯亮时，禁止车辆通行。在未设置非机动车信号灯和人行横道信号灯的路口，非机动车和行人应当按照机动车信号灯的表示通行。红灯亮时，右转弯的车辆在不妨碍被放行的车辆、行人通行的情况下，可以通行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336155, 1542336155);
INSERT INTO `ks_question` VALUES (491, '驾驶机动车在路口遇到这种信号灯亮时，要在停止线前停车瞭望。', '红灯停，绿灯行。图中是绿灯，可放心行驶。如若再磨蹭变成黄灯就真需要停车瞭望了。', 'http://file.open.jiakaobaodian.com/tiku/res/837000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336156, 1542336156);
INSERT INTO `ks_question` VALUES (492, '驾驶机动车在路口遇到这种信号灯亮时，不能右转弯。', '首先，这是圆形灯（如图），即使是红灯亮了也可以在不拥堵的情况下可以右转，但是不直行。再者，单向只有一个车道，绿灯亮时直行和右转都可以。', 'http://file.open.jiakaobaodian.com/tiku/res/837100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336158, 1542336158);
INSERT INTO `ks_question` VALUES (493, '驾驶机动车遇到这种信号灯，可在对面直行车前直接向左转弯。', '通过有交通标志线的路口，右转让左转，转弯让直行。题目中表明对面车辆是直行车，所要减速让行，让对面车辆完全过十字路口后才可转弯。 ', 'http://file.open.jiakaobaodian.com/tiku/res/837200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336159, 1542336159);
INSERT INTO `ks_question` VALUES (494, '驾驶机动车在路口遇到这种信号灯表示什么意思？', '《道路交通安全》第二十六条：通信号灯由红灯、绿灯、黄灯组成。红灯表示禁止通行，绿灯表示准许通行，黄灯表示路口警示。', 'http://file.open.jiakaobaodian.com/tiku/res/837300.jpg', 1, '[\"A、路口警示\",\"B、禁止右转\",\"C、准许直行\",\"D、加速通过\"]', 1, '0', 1, 1, 4, 0, 0, 1542336160, 1542336160);
INSERT INTO `ks_question` VALUES (495, '驾驶机动车在路口看到这种信号灯亮时，要加速通过。', '《道路交通安全法实施条例》第三十八条规定：黄灯亮时，已越过停止线的车辆可以继续前行，未经过停止线的则禁止继续通行。在黄灯亮时且未越过停止线的车辆，如果继续前行则属于违法行为。', 'http://file.open.jiakaobaodian.com/tiku/res/837400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336161, 1542336161);
INSERT INTO `ks_question` VALUES (496, '驾驶机动车在前方路口不能右转弯。', '《实施条例》规定：红灯亮时，右转弯的车辆在不妨碍被放行的车辆、行人通行的情况下，可以通行。没有指示牌和带箭头的交通灯时，红灯亦可右转。但遇到有指示牌（红灯不转）或交通灯右向箭头系红灯时，则不能右转，黄灯也不能走，注意灯的形状。', 'http://file.open.jiakaobaodian.com/tiku/res/837500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336162, 1542336162);
INSERT INTO `ks_question` VALUES (497, '驾驶机动车遇到这种信号灯亮时，如果已越过停止线，可以继续通行。', '《道路交通安全法实施条例》第三十八条规定：黄灯亮时，已越过停止线的车辆可以继续通行；未经过停止线的则禁止继续通行。', 'http://file.open.jiakaobaodian.com/tiku/res/837600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336163, 1542336163);
INSERT INTO `ks_question` VALUES (498, '遇到这种情况时怎样行驶？', '两侧车道都是红灯，所以都不可以通行，因此是禁止车辆在两侧车道通行。', 'http://file.open.jiakaobaodian.com/tiku/res/837700.jpg', 1, '[\"A、进入右侧车道行驶\",\"B、减速进入两侧车道行驶\",\"C、禁止车辆在两侧车道通行\",\"D、加速进入两侧车道行驶\"]', 1, '2', 1, 1, 4, 0, 0, 1542336164, 1542336164);
INSERT INTO `ks_question` VALUES (499, '遇到这种情况时，中间车道不允许车辆通行。', '中间车道是红灯，车辆不得进入红色叉形亮灯的车道行驶，故中间车道不允许通行，因此应该在两侧通行。', 'http://file.open.jiakaobaodian.com/tiku/res/837800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336165, 1542336165);
INSERT INTO `ks_question` VALUES (500, '这辆红色轿车可以在该车道行驶。', '中间红灯标识车道禁行，因此车辆不得进入红色叉形灯亮的车道行驶，此车道禁止通行。红车明显违反规定。', 'http://file.open.jiakaobaodian.com/tiku/res/837900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336166, 1542336166);
INSERT INTO `ks_question` VALUES (501, '驾驶机动车要选择绿色箭头灯亮的车道行驶。', '只有绿色箭头灯亮的车道表示允许通行，所以机动车要选择绿灯亮的车道行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/838000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336168, 1542336168);
INSERT INTO `ks_question` VALUES (502, '这个路口允许车辆怎样行驶？', '绿色箭头亮的车道允许通行，直行和右转灯是绿色。所以在这个路口允许车辆直行或向右转弯。', 'http://file.open.jiakaobaodian.com/tiku/res/838100.jpg', 1, '[\"A、直行或向右转弯\",\"B、向左、向右转弯\",\"C、向左转弯\",\"D、直行或向左转弯\"]', 1, '0', 1, 1, 4, 0, 0, 1542336169, 1542336169);
INSERT INTO `ks_question` VALUES (503, '驾驶机动车在这种情况下不能左转弯。', '红色箭头亮的车道禁止通行，图中左转车道箭头是红色，所以车辆不能左转弯。本题选择【正确】。', 'http://file.open.jiakaobaodian.com/tiku/res/838400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336172, 1542336172);
INSERT INTO `ks_question` VALUES (504, '驾驶机动车在这种情况下可以右转弯。', '红色箭头亮的车道禁止通行，车辆通行要根据箭头的指示来行驶，由图可知，右转车道为红色，所以不能车辆右转弯。本题选择【错误】。', 'http://file.open.jiakaobaodian.com/tiku/res/838500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336173, 1542336173);
INSERT INTO `ks_question` VALUES (505, '驾驶机动车在这种情况下不能直行和左转弯。', '红色箭头亮的车道禁止通行，图中直行和左转车道的箭头都是红色，因此禁止通行。不能执行或转弯。', 'http://file.open.jiakaobaodian.com/tiku/res/838600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336174, 1542336174);
INSERT INTO `ks_question` VALUES (506, '驾驶机动车遇到这种信号灯不断闪烁时怎样行驶？', '黄灯闪烁提示车辆注意减速，警示驾驶人要注意瞭望，确认安全后缓慢通过。', 'http://file.open.jiakaobaodian.com/tiku/res/838700.jpg', 1, '[\"A、注意瞭望安全通过\",\"B、紧急制动\",\"C、靠边停车等待\",\"D、尽快加速通过\"]', 1, '0', 1, 1, 4, 0, 0, 1542336175, 1542336175);
INSERT INTO `ks_question` VALUES (507, '路口黄灯持续闪烁，警示驾驶人要注意瞭望，确认安全通过。', '黄灯闪烁提示车辆注意减速，警示驾驶人注意瞭望，确认安全后缓慢通过。此题正确。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336177, 1542336177);
INSERT INTO `ks_question` VALUES (508, '黄灯持续闪烁，表示机动车可以加速通过。', '黄灯闪烁提示车辆注意减速，确认安全后缓慢通过。遇到此类黄灯时，需减速慢行。且机动车不能加速通过。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336178, 1542336178);
INSERT INTO `ks_question` VALUES (509, '驾驶机动车在铁路道口看到这种信号灯时怎样行驶？', '在铁道路口，红灯一亮，表示有火车驶来，此时绝对禁止通行，不得越过停止线。', 'http://file.open.jiakaobaodian.com/tiku/res/839000.jpg', 1, '[\"A、不换挡加速通过\",\"B、边观察边缓慢通过\",\"C、不得越过停止线\",\"D、在火车到来前通过\"]', 1, '2', 1, 1, 4, 0, 0, 1542336179, 1542336179);
INSERT INTO `ks_question` VALUES (510, '在铁路道口遇到两个红灯交替闪烁时要停车等待。', '无人值守铁道路口，两个红灯交替闪烁说明火车要开过来了。请停车等待。', 'http://file.open.jiakaobaodian.com/tiku/res/839100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336180, 1542336180);
INSERT INTO `ks_question` VALUES (511, '在道路与铁路道口遇到一个红灯亮时要尽快通过道口。', '在铁道路口，一个红灯亮或两个红灯闪烁时，表示火车要来，禁止通行。请停车等待。', 'http://file.open.jiakaobaodian.com/tiku/res/839200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336181, 1542336181);
INSERT INTO `ks_question` VALUES (512, '这属于哪一种标志？', '黄色为警告标志，警告标志的颜色为黄底、黑边、黑图案，形状为等边三角形，顶角朝上。', 'http://file.open.jiakaobaodian.com/tiku/res/839300.jpg', 1, '[\"A、指路标志\",\"B、指示标志\",\"C、禁令标志\",\"D、警告标志\"]', 1, '3', 1, 1, 4, 0, 0, 1542336182, 1542336182);
INSERT INTO `ks_question` VALUES (513, '这是什么交通标志？', '如图所示：斜着的字母“Z”或者“N”表示反向弯路。', 'http://file.open.jiakaobaodian.com/tiku/res/839800.jpg', 1, '[\"A、易滑路段\",\"B、反向弯路\",\"C、连续弯路\",\"D、急转弯路\"]', 1, '1', 1, 1, 4, 0, 0, 1542336188, 1542336188);
INSERT INTO `ks_question` VALUES (514, '禁令标志的作用是什么？', '禁令标志是交通标志中主要标志的一种，对车辆加以禁止或限制的标志，如禁止通行、禁止停车、禁止左转弯、禁止鸣喇叭、限制速度、限制重量等。', NULL, 1, '[\"A、禁止或限制行为\",\"B、指示车辆行进\",\"C、告知方向信息\",\"D、警告前方危险\"]', 1, '0', 1, 1, 0, 0, 0, 1542336246, 1542336246);
INSERT INTO `ks_question` VALUES (515, '这个标志提示哪种车型禁止通行？', '红色-禁令，此标志表示禁止小型客车驶入，轿车属于小型客车。', 'http://file.open.jiakaobaodian.com/tiku/res/845400.jpg', 1, '[\"A、小型货车\",\"B、中型客车\",\"C、各种车辆\",\"D、小型客车\"]', 1, '3', 1, 1, 4, 0, 0, 1542336252, 1542336252);
INSERT INTO `ks_question` VALUES (516, '指示标志的作用是什么？', '指示标志是交通标志中主要标志的一种，用以指示车辆和行人按规定方向、地点行驶。指示标志的颜色为蓝底、白图案；形状分为圆形、长方形和正方形。', NULL, 1, '[\"A、指示车辆、行人行进\",\"B、限制车辆、行人通行\",\"C、告知方向信息\",\"D、警告前方危险\"]', 1, '0', 1, 1, 0, 0, 0, 1542336275, 1542336275);
INSERT INTO `ks_question` VALUES (517, '这属于哪一类标志？', '此标志属于指路标志，是路径指引标志。指示标志都没有文字，有文字的都是指路标志。所以本题是指路标志。', 'http://file.open.jiakaobaodian.com/tiku/res/851100.jpg', 1, '[\"A、指示标志\",\"B、警告标志\",\"C、指路标志\",\"D、禁令标志\"]', 1, '2', 1, 1, 4, 0, 0, 1542336317, 1542336317);
INSERT INTO `ks_question` VALUES (518, '指路标志的作用是什么？', '指路标志用以指示市镇村的境界、目的地的方向和距离、高速公路出入口、著名地点所在等。指路标志是传递道路方向，地点，距离信息的标志。', NULL, 1, '[\"A、限制车辆通行\",\"B、提示限速信息\",\"C、警告前方危险\",\"D、提供方向信息\"]', 1, '3', 1, 1, 0, 0, 0, 1542336318, 1542336318);
INSERT INTO `ks_question` VALUES (519, '这个标志预告什么？', '图中P为停车地方，上图标志为高速公路停车场预告，只提供停车服务。', 'http://file.open.jiakaobaodian.com/tiku/res/856000.jpg', 1, '[\"A、高速公路客车站预告\",\"B、高速公路避险处预告\",\"C、高速公路服务区预告\",\"D、高速公路停车场预告\"]', 1, '3', 1, 1, 4, 0, 0, 1542336375, 1542336375);
INSERT INTO `ks_question` VALUES (520, '这种标志的作用是警告车辆驾驶人前方有危险，谨慎通行。', '警告标志的作用是警告驾驶员前方路段有复杂的交通状况出现，需谨慎通行。此题是正确的。', 'http://file.open.jiakaobaodian.com/tiku/res/856600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336383, 1542336383);
INSERT INTO `ks_question` VALUES (521, '这个标志的作用是用以警告车辆驾驶人谨慎慢行，注意横向来车。', '警告标志，十字路口，驾驶人谨慎慢行，注意两侧横向来车。', 'http://file.open.jiakaobaodian.com/tiku/res/856700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336384, 1542336384);
INSERT INTO `ks_question` VALUES (522, '这个标志的含义是前方即将行驶至Y型交叉路口？', '图中是警告标志，T型交叉路口警告标志。', 'http://file.open.jiakaobaodian.com/tiku/res/856800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336385, 1542336385);
INSERT INTO `ks_question` VALUES (523, '这个标志的含义是警告前方道路有障碍物，车辆减速绕行。', '此标志是向右急转弯标志，提醒前方道路有向右的急转弯出现。', 'http://file.open.jiakaobaodian.com/tiku/res/856900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336386, 1542336386);
INSERT INTO `ks_question` VALUES (524, '这个标志的含义是警告前方出现向左的急转弯路。', '图中表现的是向左的急转弯警告标志，警告驾驶人有向左的急转弯出现，因此此题正确。', 'http://file.open.jiakaobaodian.com/tiku/res/857000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336388, 1542336388);
INSERT INTO `ks_question` VALUES (525, '这个标志的含义是警告前方道路易滑，注意慢行。', '斜着的“N”是反向弯路标志。', 'http://file.open.jiakaobaodian.com/tiku/res/857100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336389, 1542336389);
INSERT INTO `ks_question` VALUES (526, '这个标志的含义是警告前方有两个相邻的反向转弯道路。', '此标志是连续弯路标志。没有“两个相邻的反向转弯道路”的说法。不要和反向标志混淆。', 'http://file.open.jiakaobaodian.com/tiku/res/857200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336390, 1542336390);
INSERT INTO `ks_question` VALUES (527, '这个标志的含义是提醒前方桥面宽度变窄。', '警告标志两侧变窄。用以警告车辆驾驶人注意前方车行道或路面狭窄情况，遇有来车应予减速避让。是车道或路面，不是桥。设在双车道路面宽度缩减为6m以下的路段起点前方。', 'http://file.open.jiakaobaodian.com/tiku/res/857300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336391, 1542336391);
INSERT INTO `ks_question` VALUES (528, '这个标志的含义是提醒前方右侧行车道或路面变窄。', '警告标志右侧变窄，行车注意安全。用以警告车辆驾驶人注意前方车行道或路面狭窄情况，遇有来车应予减速或停车避让。', 'http://file.open.jiakaobaodian.com/tiku/res/857400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336392, 1542336392);
INSERT INTO `ks_question` VALUES (529, '这个标志的含义是提醒前方左侧行车道或路面变窄。', '警告标志左侧变窄，行车注意安全。用以警告车辆驾驶人注意前方车行道或路面狭窄情况，遇有来车应予减速避让。', 'http://file.open.jiakaobaodian.com/tiku/res/857500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336393, 1542336393);
INSERT INTO `ks_question` VALUES (530, '这个标志的含义是提醒前方两侧行车道或路面变窄。', '窄桥警告标志。路面变窄是从下至上由宽变窄，桥面变窄是由宽变窄再变宽。', 'http://file.open.jiakaobaodian.com/tiku/res/857600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336394, 1542336394);
INSERT INTO `ks_question` VALUES (531, '这个标志的含义是提醒前方道路变为不分离双向行驶路段。', '警告标志注意双向交通。用以提醒车辆驾驶人注意会车。设在由双向分离行驶，因某种原因出现临时性或永久性的不分离双向行驶的路段。', 'http://file.open.jiakaobaodian.com/tiku/res/857700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336395, 1542336395);
INSERT INTO `ks_question` VALUES (532, '这个标志的含义是警告车辆驾驶人前方是人行横道。', '警告标志注意行人。用以警告车辆驾驶人减速慢行，注意行人。设在行人密集，或不易被驾驶员发现的人行横道线以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/857800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336397, 1542336397);
INSERT INTO `ks_question` VALUES (533, '这个标志的含义是警告车辆驾驶人前方是学校区域。', '警告标志注意儿童。用以警告车辆驾驶人减速慢行，注意儿童。设在小学、幼儿园、少年宫等儿童经常出入地点前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/857900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336398, 1542336398);
INSERT INTO `ks_question` VALUES (534, '这个标志的含义是警告车辆驾驶人注意前方设有信号灯。', '警告标志警告车辆驾驶人注意前方设有信号灯。用以警告车辆驾驶人注意前方路段设有信号灯，应依信号灯指示行车。', 'http://file.open.jiakaobaodian.com/tiku/res/858000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336399, 1542336399);
INSERT INTO `ks_question` VALUES (535, '这个标志的含义是提醒车辆驾驶人前方是傍山险路路段。', '警告标志注意落石，落石正在下降，很形象。设在有落石危险的傍山路段以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/858100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336400, 1542336400);
INSERT INTO `ks_question` VALUES (536, '这个标志的含义是提醒车辆驾驶人前方有很强的侧向风。', '警告标志，注意横风标志，在山涧隧道出口处有很强的侧向风。用以提醒车辆驾驶人小心驾驶、注意安全。设在经常有很强的侧向风的路段以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/858200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336401, 1542336401);
INSERT INTO `ks_question` VALUES (537, '这个标志的含义是提醒车辆驾驶人前方是急转弯路段。', '此标志为易滑路段标志，警告驾驶员前方路段容易发生侧滑，注意行车安全。注意不是急转标志。', 'http://file.open.jiakaobaodian.com/tiku/res/858300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336402, 1542336402);
INSERT INTO `ks_question` VALUES (538, '这个标志的含义是提醒车辆驾驶人前方是堤坝路段。', '警告标志傍山险路段。用以提醒车辆驾驶人小心驾驶。设在傍山险路路段以前适当位置。注意与落石和堤坝路区分，落石有石头落下，堤坝有水。', 'http://file.open.jiakaobaodian.com/tiku/res/858400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336403, 1542336403);
INSERT INTO `ks_question` VALUES (539, '这个标志的含义是提醒车辆驾驶人前方路段通过村庄或集镇。', '标志含义是注意村庄。用以提醒车辆驾驶人小心驾驶。设在紧靠村庄、集镇且视线不良的路段以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/858500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336405, 1542336405);
INSERT INTO `ks_question` VALUES (540, '这个标志的含义是提醒车辆驾驶人前方是单向行驶并且照明不好的涵洞。', '警告标志注意隧道。用以提醒车辆驾驶人注意慢行、谨慎驾驶。设在双向行驶并且照明不好的隧道口前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/858600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336406, 1542336406);
INSERT INTO `ks_question` VALUES (541, '这个标志的含义是提醒车辆驾驶人前方是车辆渡口。', '是警告标志：渡口，用以提醒车辆驾驶人谨慎驾驶。设在车辆渡口以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/858700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336407, 1542336407);
INSERT INTO `ks_question` VALUES (542, '这个标志的含义是提醒车辆驾驶人前方是桥头跳车较严重的路段。', '警告标志驼峰桥。用以提醒车辆驾驶人谨慎驾驶。设在拱度很大，影响视距的驼峰桥以前适当位置。注意桥头跳车是路面不平的标志，有两个凸。', 'http://file.open.jiakaobaodian.com/tiku/res/858800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336408, 1542336408);
INSERT INTO `ks_question` VALUES (543, '这个标志的含义是提醒车辆驾驶人前方路面颠簸或有桥头跳车现象。', '此标志表示路面不平，用以提醒车辆驾驶人减速慢行。设在路面颠簸路段或桥头跳车较严重的地点以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/858900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336409, 1542336409);
INSERT INTO `ks_question` VALUES (544, '这个标志的含义是提醒车辆驾驶人前方是过水路面或漫水桥路段。', '警告标志过水路面，应当减速慢行，安全通过。设在过水路面或漫水桥路段以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/859000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336410, 1542336410);
INSERT INTO `ks_question` VALUES (545, '这个标志的含义是提醒车辆驾驶人前方是无人看守铁路道口。', '带栅栏是有人看守，带火车头才是无人看守。警告标志有人看守铁道口。用以警告车辆驾驶人注意慢行或及时停车。设在车辆驾驶人不易发现的道口以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/859100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336411, 1542336411);
INSERT INTO `ks_question` VALUES (546, '这个标志的含义是提醒车辆驾驶人前方是非机动车道。', '警告标志注意非机动车。用以提醒车辆驾驶人注意慢行。而不是注意非机动车道。设在经常有非机动车横穿、出入的地点前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/859300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336414, 1542336414);
INSERT INTO `ks_question` VALUES (547, '这个标志的含义是告示前方是拥堵路段，注意减速慢行。', '警告标志事故易发地点。用以告示前方道路为事故易发路段，谨慎驾驶。设在交通事故易发路段以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/859400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336415, 1542336415);
INSERT INTO `ks_question` VALUES (548, '这个标志的含义是告示前方道路施工，车辆左右绕行。', '警告标志左右绕行。图中明显是障碍物，不是施工绕行。', 'http://file.open.jiakaobaodian.com/tiku/res/859500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336416, 1542336416);
INSERT INTO `ks_question` VALUES (549, '这个标志的含义是告示前方道路有障碍物，车辆左侧绕行。', '用以警告标志左侧绕行，谨慎驾驶，注意安全。', 'http://file.open.jiakaobaodian.com/tiku/res/859600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336417, 1542336417);
INSERT INTO `ks_question` VALUES (550, '这个标志的含义是告示前方道路是单向通行路段。', '警告标志右侧绕行。用以告示前方道路有障碍物，车辆应按标志指示减速慢行。设在道路障碍物前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/859700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336418, 1542336418);
INSERT INTO `ks_question` VALUES (551, '这个标志的含义是告示前方是塌方路段，车辆应绕道行驶。', '警告标志注意施工。用以告示前方道路施工，车辆应减速慢行或绕道行驶。该标志可以作为临时标志支设在施工路段以前适当位置。', 'http://file.open.jiakaobaodian.com/tiku/res/859800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336419, 1542336419);
INSERT INTO `ks_question` VALUES (552, '这个标志的含义是告示车辆驾驶人应慢行或停车，确保干道车辆优先。', '禁令标志减速让行，告示车辆驾驶人应慢行或停车，确保干道车辆优先。', 'http://file.open.jiakaobaodian.com/tiku/res/859900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336420, 1542336420);
INSERT INTO `ks_question` VALUES (553, '这个标志的含义是表示车辆会车时，对方车辆应停车让行。', '禁令标志，会车让行。表示车辆会车时，必须停车让对方先行。哪个箭头粗哪个先行。', 'http://file.open.jiakaobaodian.com/tiku/res/860000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336421, 1542336421);
INSERT INTO `ks_question` VALUES (554, '这个标志的含义是指示此处设有室内停车场。', 'P字上边没有遮挡，说明是露天停车场，如果P字上边有遮挡就是室内停车场了。', 'http://file.open.jiakaobaodian.com/tiku/res/860100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336423, 1542336423);
INSERT INTO `ks_question` VALUES (555, '路中心黄色虚线的含义是分隔对向交通流，在保证安全的前提下，可越线超车或转弯。', '道路中心黄色虚线，用于分隔对象行驶的交通流，只是在保证安全的前提下，可以临时越线超车。道路中心实线，禁止压线或越线。此类线均属指示线。', 'http://file.open.jiakaobaodian.com/tiku/res/860300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336425, 1542336425);
INSERT INTO `ks_question` VALUES (556, '这个地面标记的含义是预告前方设有交叉路口。', '这个标志是前方有人行横道，车辆应减速慢行或停车等待。', 'http://file.open.jiakaobaodian.com/tiku/res/860400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336426, 1542336426);
INSERT INTO `ks_question` VALUES (557, '路中心的双黄实线作用是分隔对向交通流，在保证安全的前提下，可越线超车或转弯。', '黄色实线禁止标线，禁止车辆越线超车或转弯。', 'http://file.open.jiakaobaodian.com/tiku/res/860500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336427, 1542336427);
INSERT INTO `ks_question` VALUES (558, '驾驶的车辆正在被其他车辆超越时，若此时后方有跟随行驶的车辆，应怎样做？', '驾驶的车辆正在被其他车辆超越时，应主动稍向右侧行驶，保证横向安全距离。', NULL, 1, '[\"A、靠道路中心行驶\",\"B、稍向右侧行驶，保证横向安全距离\",\"C、加速向右侧让路\",\"D、继续加速行驶\"]', 1, '1', 1, 1, 0, 0, 0, 1542336429, 1542336429);
INSERT INTO `ks_question` VALUES (559, '路中心黄色虚线属于哪一类标线？', '黄色虚线，用于分割对向行驶的交通流，为指示标线。白色表示同向可跨越车道，黄色表示反向可跨越车道，虚线表示可跨越车道。', 'http://file.open.jiakaobaodian.com/tiku/res/860700.jpg', 1, '[\"A、警告标志\",\"B、指示标线\",\"C、辅助标线\",\"D、禁止标线\"]', 1, '1', 1, 1, 4, 0, 0, 1542336430, 1542336430);
INSERT INTO `ks_question` VALUES (560, '指示标线的作用是什么？', '指示标线主要就是引导你正确的行驶，安全行驶，遵守法律法规。', NULL, 1, '[\"A、指示通行\",\"B、限制通行\",\"C、警告提醒\",\"D、禁止通行\"]', 1, '0', 1, 1, 0, 0, 0, 1542336431, 1542336431);
INSERT INTO `ks_question` VALUES (561, '路中白色虚线是什么标线？', '白色表示同向两车道之间的标线，虚线可跨越超车。', 'http://file.open.jiakaobaodian.com/tiku/res/860900.jpg', 1, '[\"A、限制跨越对向车道中心线\",\"B、禁止跨越对向车道中心线\",\"C、单向行驶车道分界中心线\",\"D、可跨越同向车道中心线\"]', 1, '3', 1, 1, 4, 0, 0, 1542336432, 1542336432);
INSERT INTO `ks_question` VALUES (562, '路中黄色分界线的作用是什么？', '分隔对向车道的分界线。箭头是对向，黄虚线用于分隔对向车道。', 'http://file.open.jiakaobaodian.com/tiku/res/861000.jpg', 1, '[\"A、分隔对向行驶的交通流\",\"B、分隔同向行驶的交通流\",\"C、允许在左侧车道行驶\",\"D、禁止跨越对向行车道\"]', 1, '0', 1, 1, 4, 0, 0, 1542336433, 1542336433);
INSERT INTO `ks_question` VALUES (563, '路中两条双黄色虚线是什么标线？', '“潮汐车道”是指根据早晚交通流量不同情况，对有条件的道路，试点开辟潮汐车道，通过车道灯的指示方向变化，控制主干道车道行驶方向，来调整车道数，提高车道使用效率。', 'http://file.open.jiakaobaodian.com/tiku/res/861100.jpg', 1, '[\"A、单向分道线\",\"B、潮汐车道线\",\"C、双向分道线\",\"D、可跨越分道线\"]', 1, '1', 1, 1, 4, 0, 0, 1542336434, 1542336434);
INSERT INTO `ks_question` VALUES (564, '路两侧的车行道边缘白色实线是什么含义？', '白色实线禁止跨越，可以理解为白色实线不可跨越。', 'http://file.open.jiakaobaodian.com/tiku/res/861200.jpg', 1, '[\"A、机动车可临时跨越\",\"B、禁止车辆跨越\",\"C、车辆可临时跨越\",\"D、非机动车可临时跨越\"]', 1, '1', 1, 1, 4, 0, 0, 1542336435, 1542336435);
INSERT INTO `ks_question` VALUES (565, '路右侧车行道边缘白色虚线是什么含义？', '边缘线为实线的，禁止跨越实线行驶；边缘线为虚线的，可临时跨越行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/861300.jpg', 1, '[\"A、应急车道分界线\",\"B、人行横道分界线\",\"C、车辆禁止越线行驶\",\"D、车辆可临时越线行驶\"]', 1, '3', 1, 1, 4, 0, 0, 1542336437, 1542336437);
INSERT INTO `ks_question` VALUES (566, '图中圈内两条白色虚线是什么标线？', '此标线为左弯待转区线。直行灯变绿后，要左转的可以行驶进白色虚线内，等灯变成左转时就可以通行了。当直行、左转弯信号灯都是红灯时，车辆是不可以进入左转弯转区的。', 'http://file.open.jiakaobaodian.com/tiku/res/861400.jpg', 1, '[\"A、左弯待转区线\",\"B、小型车转弯线\",\"C、交叉路停车线\",\"D、掉头引导线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336438, 1542336438);
INSERT INTO `ks_question` VALUES (567, '图中圈内白色虚线是什么标线？', '黄色白色都是路口导向线，黄色与黄实线相延续，白色与白实线相延续。转向时按虚线行驶。划于路口时，用以引导车辆行进。', 'http://file.open.jiakaobaodian.com/tiku/res/861500.jpg', 1, '[\"A、车道连接线\",\"B、非机动车引导线\",\"C、小型车转弯线\",\"D、路口导向线\"]', 1, '3', 1, 1, 4, 0, 0, 1542336439, 1542336439);
INSERT INTO `ks_question` VALUES (568, '图中圈内黄色虚线是什么标线？', '黄色白色都是路口导向线，黄色与黄实线相延续，白色与白实线相延续。转向时按虚线行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/861600.jpg', 1, '[\"A、车道连接线\",\"B、小型车转弯线\",\"C、路口导向线\",\"D、非机动车引导线\"]', 1, '2', 1, 1, 4, 0, 0, 1542336440, 1542336440);
INSERT INTO `ks_question` VALUES (569, '图中圈内白色实线是什么标线？', '具有固定行驶方向的导向车道线。', 'http://file.open.jiakaobaodian.com/tiku/res/861700.jpg', 1, '[\"A、可变导向车道线\",\"B、单向行驶线\",\"C、方向引导线\",\"D、导向车道线\"]', 1, '3', 1, 1, 4, 0, 0, 1542336441, 1542336441);
INSERT INTO `ks_question` VALUES (570, '图中圈内的锯齿状白色实线是什么标线？', '此标线是可变导向车道线。左转右转还是直行都是可以的，关键看信号灯或者路面上的指标牌。两条白实线是固定导向线。', 'http://file.open.jiakaobaodian.com/tiku/res/861800.jpg', 1, '[\"A、方向引导线\",\"B、单向行驶线\",\"C、导向车道线\",\"D、可变导向车道线\"]', 1, '3', 1, 1, 4, 0, 0, 1542336442, 1542336442);
INSERT INTO `ks_question` VALUES (571, '图中圈内的路面标记是什么标线？', '人行横道线，就是我们平常所说的斑马线。', 'http://file.open.jiakaobaodian.com/tiku/res/861900.jpg', 1, '[\"A、人行横道线\",\"B、减速让行线\",\"C、停车让行线\",\"D、路口示意线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336443, 1542336443);
INSERT INTO `ks_question` VALUES (572, '这个地面标记是什么标线？', '此标线为人行横道预告，在距离人行横道30-50米处设置，用来提醒驾驶员已经接近人行横道，需要减速慢行，注意行车安全。', 'http://file.open.jiakaobaodian.com/tiku/res/862000.jpg', 1, '[\"A、交叉路口预告\",\"B、停车让行预告\",\"C、减速让行预告\",\"D、人行横道预告\"]', 1, '3', 1, 1, 4, 0, 0, 1542336444, 1542336444);
INSERT INTO `ks_question` VALUES (573, '图中圈内的白色折线是什么标线？', '车距确认线，帮助更好的识别与前车的距离。仔细看图可以看出右侧有车距距离数值。', 'http://file.open.jiakaobaodian.com/tiku/res/862100.jpg', 1, '[\"A、减速行驶线\",\"B、车距确认线\",\"C、路口减速线\",\"D、车速确认线\"]', 1, '1', 1, 1, 4, 0, 0, 1542336446, 1542336446);
INSERT INTO `ks_question` VALUES (574, '图中圈内的白色半圆状标记是什么标线？', '车距确认线，因为此处路面为凸起状态，车轮压过此处会发出尖锐的声音，并有震动，提醒驾驶员注意横向车距，与路肩保持安全的行车距离。', 'http://file.open.jiakaobaodian.com/tiku/res/862200.jpg', 1, '[\"A、车距确认线\",\"B、路口减速线\",\"C、减速行驶线\",\"D、车速确认线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336447, 1542336447);
INSERT INTO `ks_question` VALUES (575, '路面由白色虚线和三角地带标线组成的是什么标线？', '道路出口标线为白色虚线，主要用在高速公路出口与引导车流使用。', 'http://file.open.jiakaobaodian.com/tiku/res/862300.jpg', 1, '[\"A、道路出口减速线\",\"B、可跨越式分道线\",\"C、道路出口标线\",\"D、道路入口标线\"]', 1, '2', 1, 1, 4, 0, 0, 1542336448, 1542336448);
INSERT INTO `ks_question` VALUES (576, '路面上白色虚线和三角地带标线组成的是什么标线？', '道路入口标线，白色虚线，主要用于高速公路入口引导车流使用。出口入口主要靠箭头指向区分。', 'http://file.open.jiakaobaodian.com/tiku/res/862400.jpg', 1, '[\"A、道路入口减速线\",\"B、道路入口标线\",\"C、道路出口标线\",\"D、可跨越式分道线\"]', 1, '1', 1, 1, 4, 0, 0, 1542336449, 1542336449);
INSERT INTO `ks_question` VALUES (577, '这种白色矩形标线框含义是什么？', '和道路平行的停车位为平行式停车位。', 'http://file.open.jiakaobaodian.com/tiku/res/862500.jpg', 1, '[\"A、出租车专用上下客停车位\",\"B、倾斜式停车位\",\"C、平行式停车位\",\"D、垂直式停车位\"]', 1, '2', 1, 1, 4, 0, 0, 1542336450, 1542336450);
INSERT INTO `ks_question` VALUES (578, '这种停车标线含义是什么？', '这里是固定停车方向停车位，车头应该按箭头方向停放。', 'http://file.open.jiakaobaodian.com/tiku/res/862600.jpg', 1, '[\"A、机动车限时停车位\",\"B、固定停车方向停车位\",\"C、专用上下客停车位\",\"D、专用待客停车位\"]', 1, '1', 1, 1, 4, 0, 0, 1542336451, 1542336451);
INSERT INTO `ks_question` VALUES (579, '红色圆圈内标线含义是什么？', '这里实线是港湾式停靠站', 'http://file.open.jiakaobaodian.com/tiku/res/862800.jpg', 1, '[\"A、临时停靠站\",\"B、公交车停靠站\",\"C、港湾式停靠站\",\"D、应急停车带\"]', 1, '2', 1, 1, 4, 0, 0, 1542336453, 1542336453);
INSERT INTO `ks_question` VALUES (580, '这个导向箭头是何含义？', '垂直箭头标志指示，多画在车道的地面上，指示直行。', 'http://file.open.jiakaobaodian.com/tiku/res/863000.jpg', 1, '[\"A、指示直行\",\"B、指示禁行\",\"C、指示合流\",\"D、指示车道\"]', 1, '0', 1, 1, 4, 0, 0, 1542336456, 1542336456);
INSERT INTO `ks_question` VALUES (581, '路面上导向箭头是何含义？', '向右小转弯，可能需要右转或向右合流。', 'http://file.open.jiakaobaodian.com/tiku/res/863900.jpg', 1, '[\"A、提示前方有障碍需向左合流\",\"B、提示前方有右弯或需向右合流\",\"C、提示前方有左弯或需向左绕行\",\"D、提示前方有左弯或需向左合流\"]', 1, '1', 1, 1, 4, 0, 0, 1542336467, 1542336467);
INSERT INTO `ks_question` VALUES (582, '这个路面数字标记是何含义？', '速度限制标志，黄色数字是最高限速，白色数字是最低限速。要按照规定速度行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/864100.jpg', 1, '[\"A、道路编号标记\",\"B、最小间距标记\",\"C、速度限制标记\",\"D、保持车距标记\"]', 1, '2', 1, 1, 4, 0, 0, 1542336469, 1542336469);
INSERT INTO `ks_question` VALUES (583, '这个路面标记是何含义？', '黄色是最高速度限制，不能超过规定的时速。', 'http://file.open.jiakaobaodian.com/tiku/res/864200.jpg', 1, '[\"A、解除100公里/小时限速\",\"B、最高限速为100公里/小时\",\"C、最低限速为100公里/小时\",\"D、平均速度为100公里/小时\"]', 1, '1', 1, 1, 4, 0, 0, 1542336470, 1542336470);
INSERT INTO `ks_question` VALUES (584, '路中心的双黄实线属于哪一类标线？', '双黄线、单黄线、单实线均为禁止标线。', 'http://file.open.jiakaobaodian.com/tiku/res/864500.jpg', 1, '[\"A、禁止标线\",\"B、辅助标线\",\"C、指示标线\",\"D、警告标志\"]', 1, '0', 1, 1, 4, 0, 0, 1542336473, 1542336473);
INSERT INTO `ks_question` VALUES (585, '路中心双黄实线是何含义？', '双黄线严禁跨越或者压线行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/864600.jpg', 1, '[\"A、禁止跨越对向车行道分界线\",\"B、可跨越对向车道分界线\",\"C、双侧可跨越同向车道分界线\",\"D、单向行驶车道分界线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336475, 1542336475);
INSERT INTO `ks_question` VALUES (586, '路中心黄色虚实线是何含义？', '黄色虚线一方允许跨线行驶，黄色实线一方不允许跨线。', 'http://file.open.jiakaobaodian.com/tiku/res/864700.jpg', 1, '[\"A、虚线一侧禁止越线\",\"B、两侧均可越线行驶\",\"C、实线一侧允许越线\",\"D、实线一侧禁止越线\"]', 1, '3', 1, 1, 4, 0, 0, 1542336476, 1542336476);
INSERT INTO `ks_question` VALUES (587, '路中心的黄色斜线填充是何含义？', '禁止跨越对向车道分界线，看到黄实线就不要跨越了，不管中间有没有填充物。', 'http://file.open.jiakaobaodian.com/tiku/res/864800.jpg', 1, '[\"A、单向行驶车道分界线\",\"B、双侧可跨越同向车道分界线\",\"C、可跨越对向车道分界线\",\"D、禁止跨越对向车行道分界线\"]', 1, '3', 1, 1, 4, 0, 0, 1542336477, 1542336477);
INSERT INTO `ks_question` VALUES (588, '路中心白色实线是何含义？', '实线不可跨越，箭头指向同一方向，是禁止跨越同向车行道分界线。', 'http://file.open.jiakaobaodian.com/tiku/res/864900.jpg', 1, '[\"A、双侧可跨越同向车道分界线\",\"B、单侧可跨越同向车道分界线\",\"C、禁止跨越同向车行道分界线\",\"D、禁止跨越对向车行道分界线\"]', 1, '2', 1, 1, 4, 0, 0, 1542336478, 1542336478);
INSERT INTO `ks_question` VALUES (589, '路缘石上的黄色虚线是何含义？', '路边的黄色虚线表示禁止长时停车，实线禁止停车。', 'http://file.open.jiakaobaodian.com/tiku/res/865000.jpg', 1, '[\"A、禁止长时停车\",\"B、禁止临时停车\",\"C、禁止装卸货物\",\"D、禁止上下人员\"]', 1, '0', 1, 1, 4, 0, 0, 1542336479, 1542336479);
INSERT INTO `ks_question` VALUES (590, '路缘石上的黄色实线是何含义？', '实线禁止停车。', 'http://file.open.jiakaobaodian.com/tiku/res/865100.jpg', 1, '[\"A、仅允许装卸货物\",\"B、仅允许上下人员\",\"C、禁止长时间停车\",\"D、禁止停放车辆\"]', 1, '3', 1, 1, 4, 0, 0, 1542336480, 1542336480);
INSERT INTO `ks_question` VALUES (591, '图中圈内白色横实线是何含义？', '红灯前的停止线，红灯亮时不可越线。', 'http://file.open.jiakaobaodian.com/tiku/res/865200.jpg', 1, '[\"A、停止线\",\"B、让行线\",\"C、待转线\",\"D、减速线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336481, 1542336481);
INSERT INTO `ks_question` VALUES (592, '路口最前端的双白实线是什么含义？', '双实线为停车让行线，用于没有交通信号灯的人行横道前，车辆需在此停车避让行人。', 'http://file.open.jiakaobaodian.com/tiku/res/865300.jpg', 1, '[\"A、左弯待转线\",\"B、停车让行线\",\"C、等候放行线\",\"D、减速让行线\"]', 1, '1', 1, 1, 4, 0, 0, 1542336483, 1542336483);
INSERT INTO `ks_question` VALUES (593, '路口最前端的双白虚线是什么含义？', '双虚线为减速让行线，可以压线过去。', 'http://file.open.jiakaobaodian.com/tiku/res/865400.jpg', 1, '[\"A、等候放行线\",\"B、减速让行线\",\"C、停车让行线\",\"D、左弯待转线\"]', 1, '1', 1, 1, 4, 0, 0, 1542336484, 1542336484);
INSERT INTO `ks_question` VALUES (594, '图中圈内三角填充区域是什么标线？', '导流线的主要形式为一个或几个根据路口地形设置的白色V形线或斜纹线区域，表示车辆必须按照规定路线行驶，不得压线或越线行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/865500.jpg', 1, '[\"A、导流线\",\"B、停车线\",\"C、减速线\",\"D、网状线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336485, 1542336485);
INSERT INTO `ks_question` VALUES (595, '这个路面标记是什么标线？', '设置在交叉路口中心的白色圆形或菱形区域，车辆左转弯时不得压线，只能紧靠中心圈小转弯。', 'http://file.open.jiakaobaodian.com/tiku/res/865600.jpg', 1, '[\"A、中心圈\",\"B、导流线\",\"C、禁驶区\",\"D、网状线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336486, 1542336486);
INSERT INTO `ks_question` VALUES (596, '图中路口中央黄色路面标记是什么标线？', '表示严禁一切车辆长时或临时停放。', 'http://file.open.jiakaobaodian.com/tiku/res/865800.jpg', 1, '[\"A、停车区\",\"B、中心圈\",\"C、网状线\",\"D、导流线\"]', 1, '2', 1, 1, 4, 0, 0, 1542336488, 1542336488);
INSERT INTO `ks_question` VALUES (597, '图中圈内两条黄色虚线间的区域是何含义？', '写明了“公交专用”，黄色虚线是想突出引起驾驶员注意。', 'http://file.open.jiakaobaodian.com/tiku/res/865900.jpg', 1, '[\"A、公交专用车道\",\"B、大客车专用车道\",\"C、营运客车专用车道\",\"D、出租车专用车道\"]', 1, '0', 1, 1, 4, 0, 0, 1542336489, 1542336489);
INSERT INTO `ks_question` VALUES (598, '道路最左侧白色虚线区域是何含义？', '地面上写明了是“多乘员专用”。', 'http://file.open.jiakaobaodian.com/tiku/res/866000.jpg', 1, '[\"A、小型客车专用车道\",\"B、未载客出租车专用车道\",\"C、大型客车专用车道\",\"D、多乘员车辆专用车道\"]', 1, '3', 1, 1, 4, 0, 0, 1542336490, 1542336490);
INSERT INTO `ks_question` VALUES (599, '路面上的黄色标记是何含义？', '禁止掉头，掉头是错误的，打个叉，要扣分的。', 'http://file.open.jiakaobaodian.com/tiku/res/866100.jpg', 1, '[\"A、允许掉头\",\"B、禁止转弯\",\"C、禁止掉头\",\"D、禁止直行\"]', 1, '2', 1, 1, 4, 0, 0, 1542336491, 1542336491);
INSERT INTO `ks_question` VALUES (600, '路面上的白色标线是何含义？', '车行道横向减速标线，用在弯路、坡路、隧道洞口前、长下坡路段及其他需要减速的车道前或道路中间的机动车行车道内。', 'http://file.open.jiakaobaodian.com/tiku/res/866300.jpg', 1, '[\"A、车行道纵向减速标线\",\"B、车道变少提示标线\",\"C、车行道横向减速标线\",\"D、道路施工提示标线\"]', 1, '2', 1, 1, 4, 0, 0, 1542336494, 1542336494);
INSERT INTO `ks_question` VALUES (601, '路面上的黄色标线是何含义？', '该标志是路面宽度渐变标线。', 'http://file.open.jiakaobaodian.com/tiku/res/866400.jpg', 1, '[\"A、路面宽度渐变标线\",\"B、施工路段提示线\",\"C、车行道变多标线\",\"D、接近障碍物标线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336495, 1542336495);
INSERT INTO `ks_question` VALUES (602, '路面上的黄色填充标线是何含义？', '双黄线就是警告注意越界，“打叉的物体”就是不可移动障碍物。', 'http://file.open.jiakaobaodian.com/tiku/res/866500.jpg', 1, '[\"A、接近狭窄路面标线\",\"B、接近移动障碍物标线\",\"C、远离狭窄路面标线\",\"D、接近障碍物标线\"]', 1, '3', 1, 1, 4, 0, 0, 1542336496, 1542336496);
INSERT INTO `ks_question` VALUES (603, '这种黄黑相间的倾斜线条是什么标记？', '记忆题，立面标记的作用是提醒驾驶人注意，在行车道或近旁有高出路面的物体，以防发生碰撞。', 'http://file.open.jiakaobaodian.com/tiku/res/866600.jpg', 1, '[\"A、减速标记\",\"B、实体标记\",\"C、立面标记\",\"D、突起标记\"]', 1, '2', 1, 1, 4, 0, 0, 1542336497, 1542336497);
INSERT INTO `ks_question` VALUES (604, '路面上的菱形块虚线是何含义？', '车行道纵向减速标线，提醒驾驶人需要减速行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/866700.jpg', 1, '[\"A、车行道纵向减速标线\",\"B、道路施工提示标线\",\"C、车道变少提示标线\",\"D、车行道横向减速标线\"]', 1, '0', 1, 1, 4, 0, 0, 1542336498, 1542336498);
INSERT INTO `ks_question` VALUES (605, '这一组交通警察手势是什么信号？', '左手高举过肩，举手朝向前方，无其他动作时是停止信号。', 'http://file.open.jiakaobaodian.com/tiku/res/866800.jpg', 1, '[\"A、停止信号\",\"B、右转弯信号\",\"C、靠边停车信号\",\"D、左转弯信号\"]', 1, '0', 1, 1, 4, 0, 0, 1542336499, 1542336499);
INSERT INTO `ks_question` VALUES (606, '如图所示，当您车速为95km/h时，您可以在哪条车道上行驶？', '如图所示，道路限速标志标明车道B最高限速100KM/h，所以选择车道B。', 'http://file.open.jiakaobaodian.com/tiku/res/1097500.jpg', 1, '[\"A、车道C\",\"B、车道A\",\"C、车道D\",\"D、车道B\"]', 1, '3', 1, 1, 4, 0, 0, 1542336510, 1542336510);
INSERT INTO `ks_question` VALUES (607, '如图所示，在这种情况下遇到红灯交替闪烁时，要尽快通过道口。', '红灯亮说明有火车要开过来了，应停车等待。', 'http://file.open.jiakaobaodian.com/tiku/res/1097600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336511, 1542336511);
INSERT INTO `ks_question` VALUES (608, '遇到下列哪个标志，你不需要主动让行？', '图1表示停车让行；图2表示减速让行；图3表示会车让行。这三张都是禁令标志，而图4是指示标志，表示会车先行标志，所以不用主动让行。', 'http://file.open.jiakaobaodian.com/tiku/res/1158800.jpg', 1, '[\"A、图2\",\"B、图1\",\"C、图3\",\"D、图4\"]', 1, '3', 1, 1, 4, 0, 0, 1542336519, 1542336519);
INSERT INTO `ks_question` VALUES (609, '以下交通标志中，表示禁止一切车辆和行人通行的是？', '图1表示禁止通行；图2表示禁止驶入；图3表示禁止机动车驶入；图4表示禁止直行。', 'http://file.open.jiakaobaodian.com/tiku/res/1158900.jpg', 1, '[\"A、图4\",\"B、图1\",\"C、图2\",\"D、图3\"]', 1, '1', 1, 1, 4, 0, 0, 1542336520, 1542336520);
INSERT INTO `ks_question` VALUES (610, '以下交通标志表示的含义是什么？', '图中标志表示禁止机动车驶入。', 'http://file.open.jiakaobaodian.com/tiku/res/1159000.jpg', 1, '[\"A、禁止非机动车驶入\",\"B、禁止所有车辆驶入\",\"C、禁止机动车驶入\",\"D、禁止小客车驶入\"]', 1, '2', 1, 1, 4, 0, 0, 1542336521, 1542336521);
INSERT INTO `ks_question` VALUES (611, '下列哪个标志禁止一切车辆长时间停放，临时停车不受限制。', '图1表示禁止停车；图2表示停车让行；图3表示禁止驶入；图4表示禁止长时停车。', 'http://file.open.jiakaobaodian.com/tiku/res/1159100.jpg', 1, '[\"A、图3\",\"B、图2\",\"C、图1\",\"D、图4\"]', 1, '3', 1, 1, 4, 0, 0, 1542336522, 1542336522);
INSERT INTO `ks_question` VALUES (612, '遇到这个标志，您不可以左转，但是可以掉头。', '图上是禁止左转标志。所有禁止左转的路口，都禁止掉头。', 'http://file.open.jiakaobaodian.com/tiku/res/1159200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336523, 1542336523);
INSERT INTO `ks_question` VALUES (613, '以下交通标志表示除小客车和货车外，其他车辆可以直行。', '题中的交通标志，在表示小型客车与货车的标志上是禁止直行的禁令标志。', 'http://file.open.jiakaobaodian.com/tiku/res/1159300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336525, 1542336525);
INSERT INTO `ks_question` VALUES (614, '以下哪个标志，表示干路先行？', '图1表示单行路（直行）；图2表示直行；图3表示直行车道；图4表示优先通行。', 'http://file.open.jiakaobaodian.com/tiku/res/1159400.jpg', 1, '[\"A、图1\",\"B、图4\",\"C、图2\",\"D、图3\"]', 1, '1', 1, 1, 4, 0, 0, 1542336526, 1542336526);
INSERT INTO `ks_question` VALUES (615, '以下交通标志表示单行线的是哪一项？', '图1表示单行路（直行）；图2表示直行车道；图3表示路口优先通行；图4表示靠右侧道路行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/1159500.jpg', 1, '[\"A、图2\",\"B、图4\",\"C、图3\",\"D、图1\"]', 1, '3', 1, 1, 4, 0, 0, 1542336527, 1542336527);
INSERT INTO `ks_question` VALUES (616, '下列哪个标志，指示车辆直行和右转合用车道？', '直行和右转合用车道，位于此车道的车辆可向右转弯或直行。', 'http://file.open.jiakaobaodian.com/tiku/res/1159600.jpg', 1, '[\"A、图1\",\"B、图4\",\"C、图3\",\"D、图2\"]', 1, '0', 1, 1, 4, 0, 0, 1542336528, 1542336528);
INSERT INTO `ks_question` VALUES (617, '下列哪个标志为最低限速标志？', '图1表示鸣喇叭；图2表示最低限速；图3表示机动车行驶标志；图4表示非机动车行驶标志。', 'http://file.open.jiakaobaodian.com/tiku/res/1159700.jpg', 1, '[\"A、图3\",\"B、图2\",\"C、图1\",\"D、图4\"]', 1, '1', 1, 1, 4, 0, 0, 1542336529, 1542336529);
INSERT INTO `ks_question` VALUES (618, '下列哪个表示一般道路车道数变少？', '图1表示错车道；图2表示车道数变少；图3表示车道数增加；图4表示隧道出口距离预告。', 'http://file.open.jiakaobaodian.com/tiku/res/1159800.jpg', 1, '[\"A、图3\",\"B、图2\",\"C、图4\",\"D、图1\"]', 1, '1', 1, 1, 4, 0, 0, 1542336531, 1542336531);
INSERT INTO `ks_question` VALUES (619, '当驾驶员看到以下标志时，需减速慢行，是因为什么？', '图中是警告标志，警告车辆驾驶人注意前方车行道或路面变窄。', 'http://file.open.jiakaobaodian.com/tiku/res/1159900.jpg', 1, '[\"A、前方车行道或路面变窄\",\"B、前方有窄桥\",\"C、前方车流量较大\",\"D、前方有弯道\"]', 1, '0', 1, 1, 4, 0, 0, 1542336532, 1542336532);
INSERT INTO `ks_question` VALUES (620, '下列哪个标志提示驾驶人下陡坡？', '图1表示向左急转弯，警告驾驶人减速慢行；图2表示连续弯路，警告驾驶人减速慢行；图3表示反向弯路，警告驾驶人减速慢行；图4表示下坡路，提醒驾驶人下陡坡小心驾驶。', 'http://file.open.jiakaobaodian.com/tiku/res/1160000.jpg', 1, '[\"A、图1\",\"B、图3\",\"C、图2\",\"D、图4\"]', 1, '3', 1, 1, 4, 0, 0, 1542336533, 1542336533);
INSERT INTO `ks_question` VALUES (621, '下列哪个标志提示驾驶人连续弯路？', '图1表示向左急转弯，警告驾驶人减速慢行；图2表示连续弯路，警告驾驶人减速慢行；图3表示反向弯路，警告驾驶人减速慢行；图4表示交叉路口，警告驾驶人谨慎慢行，注意横向来车。', 'http://file.open.jiakaobaodian.com/tiku/res/1160100.jpg', 1, '[\"A、图3\",\"B、图2\",\"C、图4\",\"D、图1\"]', 1, '1', 1, 1, 4, 0, 0, 1542336534, 1542336534);
INSERT INTO `ks_question` VALUES (622, '看到这个标志的时候，您应该开启前照灯。', '该标志表示隧道开车灯，警告驾驶人进入隧道打开前照灯，注意行驶。', 'http://file.open.jiakaobaodian.com/tiku/res/1160200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336535, 1542336535);
INSERT INTO `ks_question` VALUES (623, '遇到这个标志时，您应该主动确认您与前车之间的距离。', '该标志表示注意保持车距，警告驾驶人注意与前车保持安全距离。', 'http://file.open.jiakaobaodian.com/tiku/res/1160300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336537, 1542336537);
INSERT INTO `ks_question` VALUES (624, '在下图所示的交通事故中，有关事故责任认定，正确的说法是什么？', '在信号灯指示A车可以直行的情况下，B车右转弯应该避让直行的A车。', 'http://file.open.jiakaobaodian.com/tiku/res/1160400.jpg', 1, '[\"A、B车可以右转，但不得妨碍被放行的直行车辆，所以B车负全责\",\"B、B车闯红灯，所以B负全责\",\"C、右侧方向的车辆具有优先通行权，故A车负全责\",\"D、直行车辆不得妨碍右转车辆，所以A车负全责\"]', 1, '0', 1, 1, 4, 0, 0, 1542336538, 1542336538);
INSERT INTO `ks_question` VALUES (625, '行经这种交通标线的路段要注意减速慢行。', '道路上的白色菱形是人行横道预告，所以要减速以防止撞到行人。', 'http://file.open.jiakaobaodian.com/tiku/res/10958000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336540, 1542336540);
INSERT INTO `ks_question` VALUES (626, '低能见度气象条件下，驾驶机动车在高速公路上不按规定行驶的，将被一次记6分。', '根据《机动车驾驶证申领和使用规定》第六十五条，道路交通安全违法行为累积记分周期（即记分周期）为12个月，满分为12分，从机动车驾驶证初次领取之日起计算。依据道路交通安全违法行为的严重程度， 一次记分的分值为：12分、6分、3分、2分、1分五种。在《道路交通安全违法行为记分分值》中指出，机动车驾驶人有下列违法行为之一，一次记6 分：①机动车驾驶证被暂扣期间驾驶机动车的；②驾驶机动车违反道路交通信号灯通行的；③驾驶营运客车( 不包括公共汽车)、校车载人超过核定人数未达20% 的，或者驾驶其他载客汽车载人超过核定人数20% 以上的；④驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速未达20% 的；⑤驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路以外的道路上行驶或者驾驶其他机动车行驶超过规定时速20% 以上未达到50% 的；⑥驾驶货车载物超过核定载质量30% 以上或者违反规定载客的；⑦驾驶营运客车以外的机动车在高速公路车道内停车的；⑧驾驶机动车在高速公路或者城市快速路上违法占用应急车道行驶的；⑨低能见度气象条件下，驾驶机动车在高速公路上不按规定行驶的；⑩驾驶机动车运载超限的不可解体的物品， 未按指定的时间、路线、速度行驶或者未悬挂明显标志的；⑪驾驶机动车载运爆炸物品、易燃易爆化学物品以及剧毒、 放射性等危险物品，未按指定的时间、路线、速度行驶或者未悬挂警示标志并采取必要的安全措施的； ⑫以隐瞒、欺骗手段补领机动车驾驶证的；⑬连续驾驶中型以上载客汽车、危险物品运输车辆以外的机动车超过4小时未停车休息或者停车休息时间少于20分钟的；⑭驾驶机动车不按照规定避让校车的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336541, 1542336541);
INSERT INTO `ks_question` VALUES (627, '在交叉路口遇到这种情况，对面红车享有优先通行权。', '三个先行原则：①转弯的机动车让直行的车辆先行；②右方道路来车先行；③右转弯车让左转弯车先行。我们是左转，对方是右转，故我方优先通过。', 'http://file.open.jiakaobaodian.com/tiku/res/10958200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336542, 1542336542);
INSERT INTO `ks_question` VALUES (628, '在这种急弯道路上行车，应该使用什么灯光？', '根据《中华人民共和国道路交通安全法实施条例》第五十九条，机动车在夜间通过急弯、坡路、拱桥、人行横道或者没有交通信号灯控制的路口时，应当交替使用远近光灯示意。机动车驶近急弯、坡道顶端等影响安全视距的路段以及超车或者遇有紧急情况时，应当减速慢行，并鸣喇叭示意。', 'http://file.open.jiakaobaodian.com/tiku/res/10958300.jpg', 1, '[\"A、近光灯\",\"B、交替使用远近光灯\",\"C、远光灯\",\"D、危险报警闪光灯\"]', 1, '1', 1, 1, 4, 0, 0, 1542336544, 1542336544);
INSERT INTO `ks_question` VALUES (629, '雨天对安全行车的主要影响是什么？', '（一）、雨水影响视线，要开适度的雨刮频次；（二）、空气潮湿容易在车的前档内表面形成雾气，要注意除雾；（三）、雨天路面易打滑，要保持安全的低速；（四）、特殊情况下，紧急制动时，务必保持方向稳定，防止侧翻；（五）、雨水易形成路面沟、洞表面积水，易造成驾驶员判断失误，谨慎避开。', NULL, 1, '[\"A、路面湿滑，视线受阻\",\"B、行驶阻力增大\",\"C、电器设备易受潮短路\",\"D、发动机易熄火\"]', 1, '0', 1, 1, 0, 0, 0, 1542336545, 1542336545);
INSERT INTO `ks_question` VALUES (630, '下雨后路面湿滑，车辆行驶中紧急制动时，容易导致什么？', '下雨时路面湿滑，轮胎与路面之间的滑动摩擦系数小，相应的摩擦力也要变小。所以紧急制动时，汽车轮胎停止滚动，而向前滑动。或者说滑动摩擦力不能有效减慢汽车速度导致汽车还要向前滑出很大段距离。因此下雨路滑，宜减速行驶。', NULL, 1, '[\"A、因视线模糊而撞车\",\"B、引起发动机熄火\",\"C、发生侧滑、引发交通事故\",\"D、不被其他车辆驾驶人发现\"]', 1, '2', 1, 1, 0, 0, 0, 1542336546, 1542336546);
INSERT INTO `ks_question` VALUES (631, '雾天对安全行车的主要影响是什么？', '大雾天气眼前白蒙蒙一片，明显是能见度低，视线不清。', NULL, 1, '[\"A、易发生侧滑\",\"B、能见度低，视线不清\",\"C、发动机易熄火\",\"D、行驶阻力增大\"]', 1, '1', 1, 1, 0, 0, 0, 1542336547, 1542336547);
INSERT INTO `ks_question` VALUES (632, '行人参与道路交通的主要特点是什么？', '行动迟缓，是行人中某部分人的特点。喜欢聚集和围观不属于交通形式。因此排除这两个选项，“全部都是”此选项也随之排除。“行走随意性大，方向多变”对驾车不利，该选项最为准确。', NULL, 1, '[\"A、喜欢聚集、围观\",\"B、行走随意性大，方向多变\",\"C、全部都是\",\"D、行动迟缓\"]', 1, '1', 1, 1, 0, 0, 0, 1542336548, 1542336548);
INSERT INTO `ks_question` VALUES (633, '夜间道路环境对安全行车的主要影响是什么？', '夜间行车视线差，在没有照明的路段，驾驶人视线普遍受到影响，不能清楚看到前方事物，或者不能看清和判断前方事物的距离，尤其是在会车的情况下，由于受对向车辆灯光的影响，会产生视觉的盲点，导致看不清或看不见事物，夜间特大道路交通事故明显高于白天。', NULL, 1, '[\"A、驾驶人体力下降\",\"B、路面复杂多变\",\"C、能见度低、不利于观察道路交通情况\",\"D、驾驶人易产生冲动、幻觉\"]', 1, '2', 1, 1, 0, 0, 0, 1542336549, 1542336549);
INSERT INTO `ks_question` VALUES (634, '夜间驾驶人对物体的观察明显比白天差，视距会有什么变化？', '夜晚，在路上行车，由于车灯作用，看到的是黑色背景中的亮色物体，所以亮色物体偏大，而眼睛依旧以近大远小的感觉判断，故视距减小。', NULL, 1, '[\"A、无规律\",\"B、变短\",\"C、变长\",\"D、不变\"]', 1, '1', 1, 1, 0, 0, 0, 1542336550, 1542336550);
INSERT INTO `ks_question` VALUES (635, '冰雪道路对安全行车的主要影响是什么？', '先看清题目，题目问的是“冰雪道路”。冰雪路面很滑，车辆在上面行驶制动性能差，方向易跑偏。因汽车轮胎与路面的摩擦系数减小、附着力大大降低，汽车驱动轮很容易打滑或空转，尤其是上坡、起步、停车时还会出现后溜车的现象;车辆在行驶中如果突然加速或减速，很容易造成侧滑及方向跑偏现象;遇情况紧急制动时，制动距离会大大延长。', NULL, 1, '[\"A、制动性能差，方向易跑偏\",\"B、能见度降低，视野模糊\",\"C、电器设备易受潮短路\",\"D、行驶阻力增大\"]', 1, '0', 1, 1, 0, 0, 0, 1542336551, 1542336551);
INSERT INTO `ks_question` VALUES (636, '冰雪路行车时应注意什么？', '车辆在冰雪路面上行驶，因汽车轮胎与路面的摩擦系数减小、附着力大大降低，所以遇有冰雪路面，车辆在行驶中最重要的是车辆制动问题，要采取点刹、并和前后车保持车距离。遇情况紧急制动时，制动距离会大大延长。', NULL, 1, '[\"A、抗滑能力变大\",\"B、路面附着力增大\",\"C、制动距离延长\",\"D、制动性能没有变化\"]', 1, '2', 1, 1, 0, 0, 0, 1542336553, 1542336553);
INSERT INTO `ks_question` VALUES (637, '泥泞道路对安全行车的主要影响是什么？', '泥泞路面特别松软和粘稠，车辆行驶阻力大，附着力小，车轮极易空转打滑，发生侧滑。', NULL, 1, '[\"A、能见度低，视野模糊\",\"B、行驶阻力变小\",\"C、车轮极易滑转和侧滑\",\"D、路面附着力增大\"]', 1, '2', 1, 1, 0, 0, 0, 1542336554, 1542336554);
INSERT INTO `ks_question` VALUES (638, '水淹路面影响行车安全，不易通行的原因是什么？', '水把路给淹了，看不到路面情况，这个是很危险的；有些没有窨井盖，有些有大石头凸起，都看不到。', NULL, 1, '[\"A、日光反射阻挡视线\",\"B、能见度低，视野模糊\",\"C、路面附着力增大\",\"D、无法观察到暗坑和凸起的路面\"]', 1, '3', 1, 1, 0, 0, 0, 1542336555, 1542336555);
INSERT INTO `ks_question` VALUES (639, '山区道路对安全行车的主要影响是什么？', '山区道路的特点是：坡多、路窄、急弯多，不像平原地区视线开阔。最关键的一点是山区道路行驶时不容易掌握周围情况，也就是所谓视距不足。', NULL, 1, '[\"A、交通情况单一\",\"B、车流密度大\",\"C、道路标志少\",\"D、坡长弯急，视距不足\"]', 1, '3', 1, 1, 0, 0, 0, 1542336556, 1542336556);
INSERT INTO `ks_question` VALUES (640, '行车中突遇对方车辆强行超车，占据自己车道，正确的做法是什么？', '行车要记得安全文明驾驶。后方要超车，我们就让让吧。“宁停三分，不抢一秒”。', NULL, 1, '[\"A、挡住其去路\",\"B、保持原车速行驶\",\"C、加速行驶\",\"D、尽可能减速避让、直至停车\"]', 1, '3', 1, 1, 0, 0, 0, 1542336557, 1542336557);
INSERT INTO `ks_question` VALUES (641, '夜间行车，驾驶人视距变短，影响观察，同时注意力高度集中，易产生疲劳。', '夜间光线不好，视距变短。为了观察路况，注意力需高度集中，容易产生疲劳。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336558, 1542336558);
INSERT INTO `ks_question` VALUES (642, '冰雪道路行车，由于积雪对光线的反射，极易造成驾驶人目眩而产生错觉。', '积雪是白色，反射的光线很强，容易造成驾驶人目眩。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336560, 1542336560);
INSERT INTO `ks_question` VALUES (643, '在冰雪道路上行车时，车辆的稳定性降低，加速过急时车轮极易空转或溜滑。', '轮胎与地面的摩擦系数降低，轮胎不易附着在地面上，只要一加速，就极易空转或溜滑。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336561, 1542336561);
INSERT INTO `ks_question` VALUES (644, '在泥泞路上制动时，车轮易发生侧滑或甩尾，导致交通事故。', '泥泞道路软滑，摩擦系数低，车轮易发生侧滑或甩尾，引发交通事故。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336562, 1542336562);
INSERT INTO `ks_question` VALUES (645, '漫水道路行车时，应挂高速档，快速通过。', '不应该挂高速挡，应选用低速挡，以保证汽车有足够的驱动力；入水时应平稳，以防溅起的水花落入电器设备，造成电器短路；发动机中速运转，保持车速，中途不得停车、换挡和急转转向盘。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336563, 1542336563);
INSERT INTO `ks_question` VALUES (646, '行车中突遇对向车辆强行超车，占据自己车道时，可不予避让，迫使对方让路。', '行车要始终记得安全文明驾驶，对方要超车，那就让让。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336564, 1542336564);
INSERT INTO `ks_question` VALUES (647, '行车中遇有前方发生交通事故，需要帮助时，应怎样做？', '请伸出您的援手，文明和温暖是需要传递的。', NULL, 1, '[\"A、协助保护现场，并立即报警\",\"B、尽量绕道躲避\",\"C、立即报警，停车观望\",\"D、加速通过，不予理睬\"]', 1, '0', 1, 1, 0, 0, 0, 1542336565, 1542336565);
INSERT INTO `ks_question` VALUES (648, '行车中遇交通事故受伤者需要抢救时，应怎样做？', '伤者需要帮助，我们就应该伸出援助之手，及时送伤者去医院或拨打急救电话。', NULL, 1, '[\"A、绕过现场行驶\",\"B、尽量避开，少惹麻烦\",\"C、借故避开现场\",\"D、及时将伤者送医院抢救或拨打急救电话\"]', 1, '3', 1, 1, 0, 0, 0, 1542336566, 1542336566);
INSERT INTO `ks_question` VALUES (649, '行车中遇到对向来车占道行驶，应怎样做？', '记住文明驾驶，礼貌让行。不开赌气车，安全第一。', NULL, 1, '[\"A、逼对方靠右行驶\",\"B、紧靠道路中心行驶\",\"C、用大灯警示对方\",\"D、主动给对方让行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336568, 1542336568);
INSERT INTO `ks_question` VALUES (650, '行车中发现前方道路拥堵时，应怎样做？', '减速停车依次排队，文明驾驶。', NULL, 1, '[\"A、鸣喇叭催促\",\"B、减速停车，依次排队等候\",\"C、从车辆空间穿插通过\",\"D、寻找机会超越前车\"]', 1, '1', 1, 1, 0, 0, 0, 1542336569, 1542336569);
INSERT INTO `ks_question` VALUES (651, '会车中遇到对方来车行进有困难需借道时，应怎样做？', '文明驾驶，礼貌让行。', NULL, 1, '[\"A、尽量礼让对方先行\",\"B、不侵占对方道路，正常行驶\",\"C、靠右侧加速行驶\",\"D、示意对方停车让行\"]', 1, '0', 1, 1, 0, 0, 0, 1542336570, 1542336570);
INSERT INTO `ks_question` VALUES (652, '行车中遇到后方车辆要求超车时，应怎样做？', '文明驾驶，礼貌让行。基于安全和和谐的因素，所以要及时减速让行。', NULL, 1, '[\"A、靠右侧加速行驶\",\"B、保持原有车速行驶\",\"C、及时减速、观察后靠右行驶让行\",\"D、不让行\"]', 1, '2', 1, 1, 0, 0, 0, 1542336571, 1542336571);
INSERT INTO `ks_question` VALUES (653, '不让道，应怎样做？', '前方不让道，说明不具备超车条件，停止超车是最安全的做法。', NULL, 1, '[\"A、停止继续超车\",\"B、连续鸣喇叭加速超越\",\"C、加速继续超越\",\"D、紧跟其后，伺机再超\"]', 1, '0', 1, 1, 0, 0, 0, 1542336572, 1542336572);
INSERT INTO `ks_question` VALUES (654, '驾驶人在行车中经过积水路面时，应怎样做？', '积水路面应低速通过。', NULL, 1, '[\"A、空挡滑行通过\",\"B、加速通过\",\"C、保持正常车速通过\",\"D、减速慢行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336573, 1542336573);
INSERT INTO `ks_question` VALUES (655, '发现前方道路堵塞，正确的做法是什么？', '文明驾驶，礼貌让行。', NULL, 1, '[\"A、按顺序停车等候\",\"B、鸣喇叭示意前方车辆快速行驶\",\"C、继续穿插绕行\",\"D、选择空当逐车超越\"]', 1, '0', 1, 1, 0, 0, 0, 1542336574, 1542336574);
INSERT INTO `ks_question` VALUES (656, '车辆在拥挤路段低速行驶时，遇其他车辆强行插队，应怎样做？', '文明驾驶，礼貌让行。', NULL, 1, '[\"A、加速行驶，紧跟前车，不让其进入\",\"B、主动礼让，确保行车安全\",\"C、挤靠“加塞”车辆，逼其离开\",\"D、鸣喇叭警告，不得进入\"]', 1, '1', 1, 1, 0, 0, 0, 1542336575, 1542336575);
INSERT INTO `ks_question` VALUES (657, '当驾驶车辆行经两侧有行人且有积水的路面时，应怎样做？', '文明驾驶，减速慢行。减速可以防止溅水，按喇叭有提醒的作用，但不能防止溅水。', NULL, 1, '[\"A、连续鸣喇叭\",\"B、减速慢行\",\"C、正常行驶\",\"D、加速通过\"]', 1, '1', 1, 1, 0, 0, 0, 1542336576, 1542336576);
INSERT INTO `ks_question` VALUES (658, '当驾驶车辆行经两侧有非机动车行驶且有积水的路面时，应怎样做？', '安全文明，减速慢行。减速可以防止溅水，按喇叭有提醒的作用，但不能防止溅水。', NULL, 1, '[\"A、正常行驶\",\"B、连续鸣喇叭\",\"C、加速通过\",\"D、减速慢行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336578, 1542336578);
INSERT INTO `ks_question` VALUES (659, '一个合格的驾驶人，不仅表现在技术的娴熟上，更重要的是应该具有良好的驾驶行为习惯和道德修养。', '娴熟的技术固然重要，但没有良好的驾驶习惯和道德修养，同样会破坏正常的交通秩序。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336579, 1542336579);
INSERT INTO `ks_question` VALUES (660, '驾驶车辆在道路上行驶时，应当按照规定的速度安全行驶。', '安全驾驶，按规定行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336580, 1542336580);
INSERT INTO `ks_question` VALUES (661, '驾驶人一边驾车，一边打手持电话是违法行为。', '一边驾车一边打电话违反《道路交通安全法》，属于违法行为。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336581, 1542336581);
INSERT INTO `ks_question` VALUES (662, '在道路上超车时，应尽量加大横向距离，必要时可越实线超车。', '实线不能跨越，本题描述错误。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336582, 1542336582);
INSERT INTO `ks_question` VALUES (663, '在道路上跟车行驶时，跟车距离不是主要的，只须保持与前车相等的速度，即可防止发生追尾事故。', '不保持安全跟车距离，前方遇紧急情况急刹车，后方会来不及反应，造成追尾。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336583, 1542336583);
INSERT INTO `ks_question` VALUES (664, '仔细观察和提前预防。', '谨慎驾驶的三原则是集中注意力、仔细观察和提前预防。一定要牢记哦。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336584, 1542336584);
INSERT INTO `ks_question` VALUES (665, '遇到路口情况复杂时，应做到“宁停三分，不抢一秒”。', '安全驾驶，礼貌让行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336585, 1542336585);
INSERT INTO `ks_question` VALUES (666, '赌气车和带病车。', '安全驾驶，礼貌让行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336586, 1542336586);
INSERT INTO `ks_question` VALUES (667, '驾驶人在观察后方无来车的情况下，未开转向灯就变更车道也是合理的。', '文明驾驶，安全第一。要严格按照变道步骤来。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336587, 1542336587);
INSERT INTO `ks_question` VALUES (668, '女驾驶人穿高跟鞋驾驶车辆，不利于安全行车。', '穿高跟鞋踏制动踏板危险，不利于安全行车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336589, 1542336589);
INSERT INTO `ks_question` VALUES (669, '驾驶车辆时，长时间左臂搭在车门窗上，或者长时间右手抓住变速器操纵杆，是一种驾驶陋习。', '这是一种陋习，这样久了，会导致血脉不通，手臂麻木，容易出事。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336590, 1542336590);
INSERT INTO `ks_question` VALUES (670, '驾驶人一边驾车，一边吸烟对安全行车无影响。', '驾驶车辆吸烟不仅对车上乘客有害，烟雾也会使驾驶员视线迷糊，对安全行车是有影响的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336591, 1542336591);
INSERT INTO `ks_question` VALUES (671, '先停。', '文明行车，礼貌让行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336592, 1542336592);
INSERT INTO `ks_question` VALUES (672, '行车中需要借道绕过前方障碍物，但对向来车已接近障碍物时，应怎样做？', '请注意看题干“对向来车已接近障碍物时”，对方的车更接近障碍物，文明礼让，对向来车优先通行。', NULL, 1, '[\"A、迅速占用车道，迫使对向来车停车让道\",\"B、加速提前抢过\",\"C、鸣喇叭示意对向车辆让道\",\"D、降低速度或停车，让对向来车优先通行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336593, 1542336593);
INSERT INTO `ks_question` VALUES (673, '驾驶车辆在交叉路口前变更车道时，应怎样驶入要变更的车道？', '实线不可跨线行驶，应该在虚线区按导向箭头指示变更车道。', NULL, 1, '[\"A、在路口停止线前\",\"B、在虚线区按导向箭头指示\",\"C、在路口前实线区内根据需要\",\"D、进入路口实线区内\"]', 1, '1', 1, 1, 0, 0, 0, 1542336594, 1542336594);
INSERT INTO `ks_question` VALUES (674, '车辆驶近人行横道时，应怎样做？', '文明驾驶，安全第一。', NULL, 1, '[\"A、鸣喇叭示意行人让道\",\"B、加速通过\",\"C、立即停车\",\"D、先减速注意观察行人、非机动车动态，确认安全后再通过\"]', 1, '3', 1, 1, 0, 0, 0, 1542336595, 1542336595);
INSERT INTO `ks_question` VALUES (675, '车辆临时靠边停车后准备起步时，应先怎样做？', '起步前应先观察周围交通情况，确保安全再起步。先观察，后喇叭。', NULL, 1, '[\"A、鸣喇叭\",\"B、提高发动机转速\",\"C、观察周围交通情况\",\"D、加油起步\"]', 1, '2', 1, 1, 0, 0, 0, 1542336596, 1542336596);
INSERT INTO `ks_question` VALUES (676, '行驶车道绿灯亮时，但车辆前方人行横道仍有行人行走，应怎样做？', '以人为本，安全第一，礼让行人。', NULL, 1, '[\"A、等行人通过后再起步\",\"B、直接起步通过\",\"C、起步后从行人前方绕过\",\"D、起步后从行人后方绕过\"]', 1, '0', 1, 1, 0, 0, 0, 1542336597, 1542336597);
INSERT INTO `ks_question` VALUES (677, '在一般道路倒车时，若发现有过往车辆通过，应怎样做？', '文明驾驶，礼貌让行。', NULL, 1, '[\"A、鸣喇叭示意\",\"B、主动停车避让\",\"C、继续倒车\",\"D、加速倒车\"]', 1, '1', 1, 1, 0, 0, 0, 1542336599, 1542336599);
INSERT INTO `ks_question` VALUES (678, '会车前选择的交会位置不理想时，应怎样做？', '发现交会位置不理想时，应减速或停车让行，以寻找下一个理想会车位置。', NULL, 1, '[\"A、加速选择理想位置\",\"B、打开前照灯，示意对方停车让行\",\"C、向左占道，让对方减速让行\",\"D、减速、低速会车或停车让行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336600, 1542336600);
INSERT INTO `ks_question` VALUES (679, '进入左侧道路超车，无法保证与正常行驶前车的横向安全间距时，应怎样做？', '没有超车条件，放弃超车是最安全的行为。', NULL, 1, '[\"A、放弃超车\",\"B、并行一段距离后再超越\",\"C、加速超越\",\"D、谨慎超越\"]', 1, '0', 1, 1, 0, 0, 0, 1542336601, 1542336601);
INSERT INTO `ks_question` VALUES (680, '驾驶的车辆正在被其他车辆超越时，应怎样做？', '文明驾驶，礼貌让行。', NULL, 1, '[\"A、靠道路中心行驶\",\"B、加速让路\",\"C、继续加速行驶\",\"D、减速，靠右侧行驶\"]', 1, '3', 1, 1, 0, 0, 0, 1542336602, 1542336602);
INSERT INTO `ks_question` VALUES (681, '遇后车发出超车信号后，只要具备让超条件应怎样做？', '文明驾驶，礼貌让行。', NULL, 1, '[\"A、主动减速并靠右侧行驶\",\"B、迅速减速或紧急制动\",\"C、靠道路右侧加速行驶\",\"D、让出适当空间加速行驶\"]', 1, '0', 1, 1, 0, 0, 0, 1542336603, 1542336603);
INSERT INTO `ks_question` VALUES (682, '驾驶车辆行至道路急转弯处，应怎样做？', '安全驾驶，减速慢行。', NULL, 1, '[\"A、急剧制动低速通过\",\"B、靠弯道外侧行驶\",\"C、借对向车道行驶\",\"D、充分减速并靠右侧行驶\"]', 1, '3', 1, 1, 0, 0, 0, 1542336604, 1542336604);
INSERT INTO `ks_question` VALUES (683, '山区道路车辆进入弯道前，在对面没有来车的情况下，应怎样做？', '题目是驶入弯道前，必须鸣笛，因为不确定是否有车辆，减速是必须的，避免有车相撞。通过弯道，减速、鸣喇叭、靠右行，是最安全的做法。', NULL, 1, '[\"A、可短时间借用对方的车道\",\"B、应“减速、鸣喇叭、靠右行”\",\"C、可加速沿弯道切线方向通过\",\"D、可靠弯道外侧行驶\"]', 1, '1', 1, 1, 0, 0, 0, 1542336605, 1542336605);
INSERT INTO `ks_question` VALUES (684, '在堵车的交叉路口绿灯亮时，车辆应怎样做？', '前方堵车，这时进入交叉路口只能更堵。', NULL, 1, '[\"A、在保证安全的情况下驶入交叉路口\",\"B、可借对向车道通过路口\",\"C、不能驶入交叉路口\",\"D、可直接驶入交叉路口\"]', 1, '2', 1, 1, 0, 0, 0, 1542336606, 1542336606);
INSERT INTO `ks_question` VALUES (685, '驾驶车辆通过无人看守的铁路道口时，应怎样做？', '一停，是停在未到铁道前，不是停在铁路上。二看，是在铁道前观察是否有火车要经过。三通过，才是安全通过。', NULL, 1, '[\"A、减速通过\",\"B、匀速通过\",\"C、一停、二看、三通过\",\"D、加速通过\"]', 1, '2', 1, 1, 0, 0, 0, 1542336607, 1542336607);
INSERT INTO `ks_question` VALUES (686, '驾驶车辆驶入铁路道口前减速降挡，进入道口后应怎样做？', '进入铁道路口后不能变换挡位，换挡容易熄火。', NULL, 1, '[\"A、可以变换挡位\",\"B、不能变换挡位\",\"C、停车观察\",\"D、可换为高挡\"]', 1, '1', 1, 1, 0, 0, 0, 1542336609, 1542336609);
INSERT INTO `ks_question` VALUES (687, '行车中超越右侧停放的车辆时，为预防其突然起步或开启车门，应怎样做？', '留出安全距离、并减速，万一右侧车辆启动也有足够的空间和时间避让。', NULL, 1, '[\"A、预留出横向安全距离，减速行驶\",\"B、保持正常速度行驶\",\"C、长鸣喇叭\",\"D、加速通过\"]', 1, '0', 1, 1, 0, 0, 0, 1542336610, 1542336610);
INSERT INTO `ks_question` VALUES (688, '驶近没有人行横道的交叉路口时，发现有人横穿道路，应怎样做？', '安全驾驶，礼貌让行。', NULL, 1, '[\"A、抢在行人之前通过\",\"B、鸣喇叭示意其让道\",\"C、减速或停车让行\",\"D、立即变道绕过行人\"]', 1, '2', 1, 1, 0, 0, 0, 1542336611, 1542336611);
INSERT INTO `ks_question` VALUES (689, '行车中遇有非机动车准备绕过停放的车辆时，应怎样做？', '安全驾驶，礼貌让行。', NULL, 1, '[\"A、让其先行\",\"B、紧随其后鸣喇叭\",\"C、鸣喇叭示意其让道\",\"D、加速绕过\"]', 1, '0', 1, 1, 0, 0, 0, 1542336612, 1542336612);
INSERT INTO `ks_question` VALUES (690, '行车中，遇非机动车抢行时，应怎样做？', '安全驾驶，礼貌让行。', NULL, 1, '[\"A、减速让行\",\"B、加速通过\",\"C、鸣喇叭警告\",\"D、临近时突然加速\"]', 1, '0', 1, 1, 0, 0, 0, 1542336613, 1542336613);
INSERT INTO `ks_question` VALUES (691, '行车中遇抢救伤员的救护车从本车道逆向驶来时，应怎样做？', '遇到正在执行任务的特种车辆，应当予以让行。', NULL, 1, '[\"A、加速变更车道避让\",\"B、靠边减速或停车让行\",\"C、在原车道内继续行驶\",\"D、占用其他车道行驶\"]', 1, '1', 1, 1, 0, 0, 0, 1542336614, 1542336614);
INSERT INTO `ks_question` VALUES (692, '行车中遇儿童时，应怎样做？', '安全驾驶，礼貌让行。', NULL, 1, '[\"A、加速绕行\",\"B、减速慢行，必要时停车避让\",\"C、迅速从一侧通过\",\"D、长鸣喇叭催促\"]', 1, '1', 1, 1, 0, 0, 0, 1542336615, 1542336615);
INSERT INTO `ks_question` VALUES (693, '行车中遇列队横过道路的学生时，应怎样做？', '安全驾驶，礼貌让行。注意，题中说的是列队，所以减速是不够的，必须停车。', NULL, 1, '[\"A、提前加速抢行\",\"B、降低车速、缓慢通过\",\"C、连续鸣喇叭催促\",\"D、停车让行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336616, 1542336616);
INSERT INTO `ks_question` VALUES (694, '车辆通过凹凸路面时，应怎样做？', '安全驾驶，减速慢行。凹凸不平的路面减速慢行不仅对车有好处而且不会因颠簸影响驾驶。', NULL, 1, '[\"A、低速缓慢平稳通过\",\"B、保持原速通过\",\"C、挂空挡滑行驶过\",\"D、依靠惯性加速冲过\"]', 1, '0', 1, 1, 0, 0, 0, 1542336618, 1542336618);
INSERT INTO `ks_question` VALUES (695, '行车中超越同向行驶的自行车时，应怎样做？', '题目中是“行车中超越”，指行车途中要超越自行车，所以需要注意观察动态，减速行驶，留有足够安全距离后再超车。“让自行车先行”是不超车，与题目内容不符。', NULL, 1, '[\"A、连续鸣喇叭提醒其让路\",\"B、持续鸣喇叭并加速超越\",\"C、让自行车先行\",\"D、注意观察动态，减速慢行，留有足够的安全距离\"]', 1, '3', 1, 1, 0, 0, 0, 1542336619, 1542336619);
INSERT INTO `ks_question` VALUES (696, '夜间驾驶车辆遇自行车对向驶来时，应怎样做？', '安全第一。使用远光灯会使对方看不清，变换远近光灯也是一样，不断鸣喇叭会使对方产生抵触情绪，结果适得其反。', NULL, 1, '[\"A、连续变换远、近光灯\",\"B、使用近光灯，减速或停车避让\",\"C、不断鸣喇叭\",\"D、使用远光灯\"]', 1, '1', 1, 1, 0, 0, 0, 1542336620, 1542336620);
INSERT INTO `ks_question` VALUES (697, '车辆在主干道上行驶，驶近主支干道交汇处时，为防止与从支路突然驶入的车辆相撞，应怎样做？', '文明驾驶，安全第一。', NULL, 1, '[\"A、保持正常速度行驶\",\"B、提前加速通过\",\"C、提前减速、观察，谨慎驾驶\",\"D、鸣喇叭，迅速通过\"]', 1, '2', 1, 1, 0, 0, 0, 1542336621, 1542336621);
INSERT INTO `ks_question` VALUES (698, '车辆在交叉路口有优先通行权的，遇有车辆抢行时，应怎样做？', '安全驾驶，礼貌让行。', NULL, 1, '[\"A、减速避让，必要时停车让行\",\"B、抢行通过\",\"C、按优先权规定正常行驶不予避让\",\"D、提前加速通过\"]', 1, '0', 1, 1, 0, 0, 0, 1542336622, 1542336622);
INSERT INTO `ks_question` VALUES (699, '机动车在道路边临时停车时，应怎样做？', '在路边临时停车时应遵循“不影响正常交通”的原则，因此除了要靠路边之外，还要尽可能留出空间便于其他车辆通行。', NULL, 1, '[\"A、可并列停放\",\"B、不得逆向或并列停放\",\"C、可逆向停放\",\"D、只要出去方便，可随意停放\"]', 1, '1', 1, 1, 0, 0, 0, 1542336623, 1542336623);
INSERT INTO `ks_question` VALUES (700, '车辆在雨天临时停车时，应开启什么灯？', '下雨天开车视线不清，因此要临时停车，应当开启危险报警闪光灯，提醒其他车辆注意。', NULL, 1, '[\"A、前后雾灯\",\"B、倒车灯\",\"C、前大灯\",\"D、危险报警闪光灯\"]', 1, '3', 1, 1, 0, 0, 0, 1542336624, 1542336624);
INSERT INTO `ks_question` VALUES (701, '车辆在雪天临时停车时，应开启什么灯？', '下雪天开车危险，因此要临时停车，应当开启危险报警闪光灯，提醒其他车辆注意。', NULL, 1, '[\"A、前大灯\",\"B、倒车灯\",\"C、前后雾灯\",\"D、危险报警闪光灯\"]', 1, '3', 1, 1, 0, 0, 0, 1542336625, 1542336625);
INSERT INTO `ks_question` VALUES (702, '驾驶人行车中看到注意儿童标志的时候，应怎样做？', '看到注意儿童标志的时候说明附近可能是幼儿园等地方，要谨慎选择行车速度以免撞到小孩子。', NULL, 1, '[\"A、加速行驶\",\"B、保持正常车速行驶\",\"C、绕道行驶\",\"D、谨慎选择行车速度\"]', 1, '3', 1, 1, 0, 0, 0, 1542336626, 1542336626);
INSERT INTO `ks_question` VALUES (703, '车辆驶近停在车站的公交车辆时，为预防公交车突然起步或行人从车前穿出，应怎样做？', '安全驾驶，礼貌让行。', NULL, 1, '[\"A、减速，保持足够间距，随时准备停车\",\"B、保持正常车速行驶\",\"C、随时准备紧急制动\",\"D、鸣喇叭提醒，加速通过\"]', 1, '0', 1, 1, 0, 0, 0, 1542336628, 1542336628);
INSERT INTO `ks_question` VALUES (704, '雨天行车，遇撑雨伞和穿雨衣的行人在公路上行走时，应怎样做？', '安全驾驶，减速慢行。遇到撑雨伞和穿雨衣的行人会使视线受阻碍，所以要鸣喇叭，雨天路滑所以要减速。', NULL, 1, '[\"A、加速绕行\",\"B、持续鸣喇叭示意其让道\",\"C、提前鸣喇叭，并适当降低车速\",\"D、以正常速度行驶\"]', 1, '2', 1, 1, 0, 0, 0, 1542336629, 1542336629);
INSERT INTO `ks_question` VALUES (705, '车辆行至交叉路口，遇有转弯的车辆抢行，应怎样做？', '文明驾驶，礼貌让行。', NULL, 1, '[\"A、停车避让\",\"B、提高车速抢先通过\",\"C、鸣喇叭抢先通过\",\"D、保持正常车速行驶\"]', 1, '0', 1, 1, 0, 0, 0, 1542336630, 1542336630);
INSERT INTO `ks_question` VALUES (706, '驾驶车辆变更车道时，应提前开启转向灯，注意观察，保持安全距离，驶入要变更的车道。', '变更车道时提前开启转向灯提醒后车，然后观察有无变更车道的条件，再保持安全距离，驶入要变更的车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336631, 1542336631);
INSERT INTO `ks_question` VALUES (707, '驾驶车辆向右变更车道时，应提前开启右转向灯，注意观察，在确保安全的情况下，驶入要变更的车道。', '变更车道时提前开启转向灯提醒后车，然后观察有无变更车道的条件，再保持安全距离，驶入要变更的车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336632, 1542336632);
INSERT INTO `ks_question` VALUES (708, '变更车道时只需开启转向灯，便可迅速转向驶入相应的行车道。', '不仅要提前开启转向灯，还应观察周边情况，判断有无变更车道的条件，在保持安全距离的情况下，驶入要变更的车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336633, 1542336633);
INSERT INTO `ks_question` VALUES (709, '驾驶车辆汇入车流时，应提前开启转向灯，保持直线行驶，通过后视镜观察左右情况，确认安全后汇入合流。', '在汇入车流是先开转向灯的，是为了提示后面的车避让留下进入车流的空隙，保持直行一段，因为是汇入合流，要确认好车与车横向空隙就要用后视镜看左右了。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336634, 1542336634);
INSERT INTO `ks_question` VALUES (710, '变更车道时，应开启转向灯，迅速驶入侧方车道。', '注意迅速两字，驶入前先观察后慢慢变道。变更车道除了提前开启转向灯，还应观察周边交通情况，在保证安全的情况下驶入要变更的车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336635, 1542336635);
INSERT INTO `ks_question` VALUES (711, '行车中从其他道路汇入车流前，应注意观察侧后方车辆的动态。', '行车中从其他道路线汇入车流前，应注意观察侧后方车辆的动态，后侧方是同向来车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336636, 1542336636);
INSERT INTO `ks_question` VALUES (712, '驾驶车辆通过人行横道线时，应注意礼让行人。', '文明驾驶，礼貌让行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336637, 1542336637);
INSERT INTO `ks_question` VALUES (713, '车辆起步前，驾驶人应对车辆周围交通情况进行观察，确认安全时再开始起步。', '观察周围是起步前准备工作。这道题里的话并没有错，观察周围只是起步前准备工作的一部分，并没有说是不用打转向灯的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336639, 1542336639);
INSERT INTO `ks_question` VALUES (714, '车辆在路边起步后应尽快提速，并向左迅速转向驶入正常行驶道路。', '需要先观察，安全才能开过去，不是一起步就迅速转入正常行驶道行驶，万一后面有车是很危险的，所以“迅速”是错的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336640, 1542336640);
INSERT INTO `ks_question` VALUES (715, '倒车过程中要缓慢行驶，注意观察车辆两侧和后方的情况，随时做好停车准备。', '相同车道上前面是没车，车都是从后面来的。另外题目中并没有说不要看前面，只是说注意观察两侧和后方的情况。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336641, 1542336641);
INSERT INTO `ks_question` VALUES (716, '预计在超车过程中与对面来车有会车可能时，应提前加速超越。', '预计在超车过程中与对面来车有会车可能时，应当放弃超车。若加速超越，可能引起不必要的事故。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336642, 1542336642);
INSERT INTO `ks_question` VALUES (717, '通过隧道时，不得超车。', '《道路交通安全法》第四十三条，同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336643, 1542336643);
INSERT INTO `ks_question` VALUES (718, '通过铁路道口时，不得超车。', '《道路交通安全法》第四十三条，同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336644, 1542336644);
INSERT INTO `ks_question` VALUES (719, '通过急转弯路段时，在车辆较少的情况下可以超车。', '《道路交通安全法》第四十三条，同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336645, 1542336645);
INSERT INTO `ks_question` VALUES (720, '窄桥时，不得超车。', '《道路交通安全法》第四十三条，同车道行驶的机动车，后车应当与前车保持足以采取紧急制动措施的安全距离。有下列情形之一的，不得超车：（一）前车正在左转弯、掉头、超车的；（二）与对面来车有会车可能的；（三）前车为执行紧急任务的警车、消防车、救护车、工程救险车的；（四）行经铁路道口、交叉路口、窄桥、弯道、陡坡、隧道、人行横道、市区交通流量大的路段等没有超车条件的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336646, 1542336646);
INSERT INTO `ks_question` VALUES (721, '车辆转弯时应沿道路右侧行驶，不要侵占对方的车道，做到“左转转大弯，右转转小弯”。', '左转转大弯，但当心身后非机动车。右转转小弯，当心对面右行驶和身后的车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336647, 1542336647);
INSERT INTO `ks_question` VALUES (722, '驾驶车辆进入交叉路口前，应降低行驶速度，注意观察，确认安全。', '安全驾驶，减速慢行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336649, 1542336649);
INSERT INTO `ks_question` VALUES (723, '车辆通过铁道路口时，应用低速挡安全通过，中途不得换挡，以避免发动机熄火。', '通过铁道路口中途换挡容易熄火，如果火车开过来就危险了。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336650, 1542336650);
INSERT INTO `ks_question` VALUES (724, '行车中，发现行人突然横过道路时，应迅速减速避让。', '安全驾驶，礼貌让行。碰到行人的一定避让，减速，甚至停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336651, 1542336651);
INSERT INTO `ks_question` VALUES (725, '当行人出现交通安全违法行为时，车辆可以不给行人让行。', '安全驾驶，礼貌让行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336652, 1542336652);
INSERT INTO `ks_question` VALUES (726, '车辆在交叉路口绿灯亮后，遇非机动车抢道行驶时，可以不让行。', '安全驾驶，文明行车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336653, 1542336653);
INSERT INTO `ks_question` VALUES (727, '掉头过程中，应严格控制车速，仔细观察道路前后方情况，确认安全后方可前进或倒车。', '文明驾驶，安全第一。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336654, 1542336654);
INSERT INTO `ks_question` VALUES (728, '行车中遇残疾人影响通行时，应主动减速礼让。', '安全驾驶，礼貌让行。看到关于避让题目，都遵循避让礼让的原则。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336655, 1542336655);
INSERT INTO `ks_question` VALUES (729, '设有安全带装置的车辆，应要求车内乘员系安全带。', '系安全带有利于安全行车、乘车。请认真看题，是“设有”，不是“没有”。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336656, 1542336656);
INSERT INTO `ks_question` VALUES (730, '行车中前方遇自行车影响通行时，可鸣喇叭提示，加速绕行。', '题目说“自行车影响通行”说明前方交通状况不佳，这时应减速慢行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336657, 1542336657);
INSERT INTO `ks_question` VALUES (731, '机动车在环形路口内行驶，遇有其他车辆强行驶入时，只要有优先权就可以不避让。', '安全驾驶，文明行车。能让就尽量让行。看到关于避让题目，都遵循避让礼让的原则。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336658, 1542336658);
INSERT INTO `ks_question` VALUES (732, '车辆行至交叉路口时，左转弯车辆在任何时段都可以进入左弯待转区。', '左转弯车辆只有在直行车道绿灯亮起时才能进入左转弯待转车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336660, 1542336660);
INSERT INTO `ks_question` VALUES (733, '车辆行至急转弯处时，应减速并靠右侧行驶，防止与越过弯道中心线的对方车辆相撞。', '通过急弯靠右行驶，给对向来车留出足够的行车空间，慢行能在遇到突发状况时有足够的反应时间。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336661, 1542336661);
INSERT INTO `ks_question` VALUES (734, '车辆长时间停放时，应选择停车场停车。', '长时停车应选择停车场。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336662, 1542336662);
INSERT INTO `ks_question` VALUES (735, '车辆通过学校和小区应注意观察标志标线，低速行驶，不要鸣喇叭。', '学校区域和居民区通常禁止鸣笛，减少噪音，以免影响居民生活和学生学习。同时，这些地方人流量大，要时时留意交通状况，减速慢行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336663, 1542336663);
INSERT INTO `ks_question` VALUES (736, '驶入高速公路的收费口时，应选择怎样的入口？', '绿灯是表示收费站正常运行的，所以应该选择在绿灯那边。', NULL, 1, '[\"A、暂停服务\",\"B、绿灯亮\",\"C、红灯亮\",\"D、车辆多\"]', 1, '1', 1, 1, 0, 0, 0, 1542336664, 1542336664);
INSERT INTO `ks_question` VALUES (737, '驾驶车辆进入高速公路加速车道后，应尽快将车速提高到每小时多少公里以上？', '驾驶机动车进入高速公路，应该尽快在加速车道将车速提到60km/h以上，再进入主车道行驶。因为高速公路加速车道最低行驶速度60公里每小时。', NULL, 1, '[\"A、30\",\"B、60\",\"C、40\",\"D、50\"]', 1, '1', 1, 1, 0, 0, 0, 1542336665, 1542336665);
INSERT INTO `ks_question` VALUES (738, '高速公路上行车，如果因疏忽驶过出口，应怎样做？', '高速公路行车不可掉头、不可倒车，错过出口，只能继续行驶，寻找下个出口。', NULL, 1, '[\"A、在原地倒车驶回\",\"B、在原地掉头\",\"C、立即停车\",\"D、继续向前行驶，寻找下一个出口\"]', 1, '3', 1, 1, 0, 0, 0, 1542336666, 1542336666);
INSERT INTO `ks_question` VALUES (739, '车辆因故障必须在高速公路停车时，应在车后方多少米以外设置故障警告标志？', '普通道路50—100米，高速公路150米。', NULL, 1, '[\"A、200\",\"B、150\",\"C、50\",\"D、100\"]', 1, '1', 1, 1, 0, 0, 0, 1542336667, 1542336667);
INSERT INTO `ks_question` VALUES (740, '标线齐全的高速公路上行车，应当按照什么规定的车道和车速行驶？', '这个题有前提，前提是在“在标志、标线齐全的高速公路上行车”。根据规定，在标志、标线齐全的路段，按标志、标线行驶。', NULL, 1, '[\"A、《道路交通安全法》\",\"B、地方法规\",\"C、车辆说明书\",\"D、标志或标线\"]', 1, '3', 1, 1, 0, 0, 0, 1542336668, 1542336668);
INSERT INTO `ks_question` VALUES (741, '机动车在高速公路行驶，下列做法正确的是？', '应急车道是供出现紧急情况是使用的。', NULL, 1, '[\"A、可在减速车道或加速车道上超车、停车\",\"B、非紧急情况时不得在应急车道行驶或者停车\",\"C、可在紧急停车带停车装卸货物\",\"D、可在路肩停车上下人员\"]', 1, '1', 1, 1, 0, 0, 0, 1542336670, 1542336670);
INSERT INTO `ks_question` VALUES (742, '在同向4车道高速公路上行车，车速高于每小时110公里的车辆应在哪条车道上行驶？', '同向四车道左到右最低限速依次为：110、90、90、60。', NULL, 1, '[\"A、第三条\",\"B、最右侧\",\"C、第二条\",\"D、最左侧\"]', 1, '3', 1, 1, 0, 0, 0, 1542336671, 1542336671);
INSERT INTO `ks_question` VALUES (743, '车辆驶入匝道后，迅速将车速提高到每小时60公里以上。', '应该是从匝道进入高速公路加速车道，在加速车道里迅速将车速提高到每小时60公里以上。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336672, 1542336672);
INSERT INTO `ks_question` VALUES (744, '车辆在高速公路匝道上可以停车。', '高速公路匝道禁止停车、掉头、倒车等行为。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336673, 1542336673);
INSERT INTO `ks_question` VALUES (745, '车辆不得在高速公路匝道上掉头。', '规定：驶入确定匝道后，迅速提高车速，但不得超过规定速度，在匝道上，不准超车、掉头、停车、和倒车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336674, 1542336674);
INSERT INTO `ks_question` VALUES (746, '车辆不得在高速公路匝道上倒车。', '规定：驶入确定匝道后，迅速提高车速，但不得超过规定速度，在匝道上，不准超车、掉头、停车、和倒车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336675, 1542336675);
INSERT INTO `ks_question` VALUES (747, '车辆在高速公路匝道提速到每小时60公里以上时，可直接驶入行车道。', '错误的关键在于“直接”两个字，正确的做法是应该先打开左转向灯，再在不妨碍已在高速公路内的机动车正常行驶的情况下驶入车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336676, 1542336676);
INSERT INTO `ks_question` VALUES (748, '车辆应靠高速公路右侧的路肩上行驶。', '右侧路肩是供车辆出现紧急状况时停车的，不可在此行车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336677, 1542336677);
INSERT INTO `ks_question` VALUES (749, '车辆在高速公路以每小时100公里的速度行驶时，距同车道前车100米以上为安全距离。', '《实施条例》第八十条：机动车在高速公路上行驶，车速超过每小时100公里时，应当与同车道前车保持100米以上的距离，车速低于每小时100公里时，与同车道前车距离可以适当缩短，但最小距离不得少于50米。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336678, 1542336678);
INSERT INTO `ks_question` VALUES (750, '车辆在高速公路上行车，可以频繁地变更车道。', '频繁变更车道是种陋习，而且容易引发交通事故。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336679, 1542336679);
INSERT INTO `ks_question` VALUES (751, '车辆驶离高速公路时，应当经减速车道减速后进入匝道。', '匝道：立交桥和高架路上下两条道路相连接的路段，也指高速公路与邻近的辅路相连接的路段。高架路的匝道，进口路和出口路是分开的，只能顺行，不准掉头，车辆错过了下匝道，就不能从上匝道下路，只能从下一个下匝道下路。立交桥的匝道，也是按照设定的标志行驶，谁也不能各行其是高速公路出口的匝道一般限速每小时60公里以下，弯道限速每小时40公里以下。而在高速公路上行驶时的车速远高于这两个数字，因此应当先减速再进入匝道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336681, 1542336681);
INSERT INTO `ks_question` VALUES (752, '在高速公路变更车道时，应提前开启转向灯，观察情况，确认安全后，驶入需要变更的车道。', '变更车道时需要提前开启转向灯提醒后车，然后观察周围交通环境，确认安全后再驶入要变更的车道。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336682, 1542336682);
INSERT INTO `ks_question` VALUES (753, '高速公路因发生事故造成堵塞时，可在右侧紧急停车带或路肩行驶。', '右侧紧急停车带和路肩是供车辆出现紧急状况停车的，不能占用紧急停车带行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336683, 1542336683);
INSERT INTO `ks_question` VALUES (754, '行驶在高速公路上遇大雾视线受阻时，应当立即紧急制动停车。', '大雾天气视线不佳，紧急制动容易发生追尾事故，要逐渐减速停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336684, 1542336684);
INSERT INTO `ks_question` VALUES (755, '机动车在高速公路上遇前方交通受阻时，应当跟随前车顺序排队，并立即开启危险报警闪光灯，防止追尾。', '危险报警闪光灯，通常称为双闪，是一种提醒其他车辆与行人注意本车发生了特殊情况的信号灯。提醒后车请减速慢行，谨防追尾。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336685, 1542336685);
INSERT INTO `ks_question` VALUES (756, '在高速公路上遇分流交通管制时，可不驶出高速公路，就地靠边停靠等待管制结束后继续前行。', '高速公路的分流交通管制就是指在高速公路上遇到紧急情况后，将后续来车在匝道口进行管制通行，避免再次生事故和交通拥堵，亦或是有紧急交通勤务警卫，需要提前封闭道路，故提前分流车辆。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336686, 1542336686);
INSERT INTO `ks_question` VALUES (757, '小型客车行驶在平坦的高速公路上，突然有颠簸感觉时，应迅速降低车速，防止爆胎。', '本题描述是正确。道路本身是平坦的，有颠簸感可能是车出现了故障，要迅速反应，及时减速，找到合适的地点停车检查。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336687, 1542336687);
INSERT INTO `ks_question` VALUES (758, '在高速公路上行驶感觉疲劳时，应立即停车休息。', '在高速公路应在休息区或者服务区停车休息。不能随意停车休息。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336688, 1542336688);
INSERT INTO `ks_question` VALUES (759, '《道路交通安全法实施条例》规定，高速公路上最高时速不得超过120公里。因此在高速公路上行驶只要时速不超过120公里就不违法。', '《实施条例》规定，高速公路最低速度60公里，最高速度120公里。题中只说了不超过120公里，没说不能低于60公里，所以描述错误。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336689, 1542336689);
INSERT INTO `ks_question` VALUES (760, '车辆在高速公路行驶时，可以仅凭感觉确认车速。', '感觉不一定准确，还是要看时速表的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336691, 1542336691);
INSERT INTO `ks_question` VALUES (761, '车辆在山区道路跟车行驶时，应怎样做？', '安全驾驶，保持安全距离。', NULL, 1, '[\"A、适当加大安全距离\",\"B、紧随前车之后\",\"C、尽可能寻找超车机会\",\"D、适当减小安全距离\"]', 1, '0', 1, 1, 0, 0, 0, 1542336692, 1542336692);
INSERT INTO `ks_question` VALUES (762, '在山区道路超车时，应怎样超越？', '下坡不允许超车，超车选择宽阔的缓上坡路段比较安全。上坡有阻力，不易滑车，也不易撞车，所以上坡宽阔地可以超车。', NULL, 1, '[\"A、选择较缓的下坡路\",\"B、选择宽阔的缓上坡路段\",\"C、抓住任何机会尽量\",\"D、选择较长的下坡路\"]', 1, '1', 1, 1, 0, 0, 0, 1542336693, 1542336693);
INSERT INTO `ks_question` VALUES (763, '在山区道路遇对向来车时，应怎样会车？', '山区道路比较复杂，容易出事故，为了安全，会车时要减速或者停车让行。', NULL, 1, '[\"A、减速或停车让行\",\"B、紧靠道路中心\",\"C、加速\",\"D、不减速\"]', 1, '0', 1, 1, 0, 0, 0, 1542336694, 1542336694);
INSERT INTO `ks_question` VALUES (764, '下长坡时，控制车速除了刹车制动以外还有什么有效的辅助方法？', '下坡路段禁止空挡滑行和熄火滑行，除了刹车制动，还可利用发动机制动。发动机制动就是挂低档，让车利用低档位的惯性制动，你可以试一下，你在3挡的速度，直接挂1挡，记住不要踩刹车，直接挂档，你看效果如何，车身会震一下，速度下降的很快。', NULL, 1, '[\"A、关闭发动机熄火滑行\",\"B、利用发动机制动\",\"C、挂入空挡滑行\",\"D、踏下离合器滑行\"]', 1, '1', 1, 1, 0, 0, 0, 1542336695, 1542336695);
INSERT INTO `ks_question` VALUES (765, '下长坡连续使用行车制动会导致什么？', '持续用刹车，会造成刹车片发热，从而制动力减小，严重的会丧失制动能力，所以下长坡要用低挡，用发动机制动。', NULL, 1, '[\"A、会使制动器温度升高而使制动效果急剧下降\",\"B、会缩短发动机寿命\",\"C、增加驾驶人的劳动强度\",\"D、容易造成车辆倾翻\"]', 1, '0', 1, 1, 0, 0, 0, 1542336696, 1542336696);
INSERT INTO `ks_question` VALUES (766, '车辆在较窄的山路上行驶时，如果靠山体的一方不让行，应怎样做？', '安全驾驶，礼貌让行。', NULL, 1, '[\"A、向左占道，谨慎驶过\",\"B、保持正常车速行驶\",\"C、提前减速或停车避让\",\"D、鸣喇叭催其让行\"]', 1, '2', 1, 1, 0, 0, 0, 1542336697, 1542336697);
INSERT INTO `ks_question` VALUES (767, '坡道长度，及时减挡使车辆保持充足的动力。', '提前观察路况可以增加行车时的预见性，及时减档保持充足的动力才能顺利上坡。高挡属于快速挡，而低挡却用于起步或者作有重力的运动而使用，上坡本然就形成一种重力，需要足够的马力才可以行驶，所以需要将挡位降低才可以，如果使用高挡，很可能导致功率不够形成熄火，甚至溜车!', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336698, 1542336698);
INSERT INTO `ks_question` VALUES (768, '车辆下坡行驶，要适当控制车速，充分利用发动机进行制动。', '下坡时不能空挡滑行，应充分利用发动机制动。防止下坡时刹车发生打滑，所以应该利用发动机制动。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336699, 1542336699);
INSERT INTO `ks_question` VALUES (769, '车辆下长坡时要减挡行驶，以充分利用发动机的制动作用。', '意思是，下坡要低挡低速行驶，把车速放在较低的范围内，称之为减挡行驶。变速箱高档位高速持续运转中，迅速降低变速箱的档位转速，使变速箱的低档位转速对车辆本身的惯性高速产生抑制，从而产生短时间内的所谓发动机制动(变速箱制动)。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336701, 1542336701);
INSERT INTO `ks_question` VALUES (770, '靠右行”。', '“减速、鸣喇叭、靠右行”是安全文明的驾驶行为。通过弯道时，大家都知道要减速，而在山区道路，由于前方状况很难了解，因此，若要经过弯道，应当鸣号告知其他车辆你要通过弯道了，靠右行是为了避免在弯道时遇到对向来车，若不靠右行驶，很可能会与来车发生碰撞。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336702, 1542336702);
INSERT INTO `ks_question` VALUES (771, '车辆在山区道路行车下陡坡时，不得超车。', '行经繁华路段、交叉路口、铁路道口、人行横道、急弯路、宽度不足4米的窄路或者窄桥、陡坡、隧道或者容易发生危险的路段，不得超车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336703, 1542336703);
INSERT INTO `ks_question` VALUES (772, '车辆在下坡行驶时，可充分利用空挡滑行。', '危险动作，下坡时，不准熄火或用空挡。如果下坡空档滑行，只靠刹车来控制车速，遇到连续下坡的时候可能会造成刹车负担过重，刹车片过热而失灵。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336704, 1542336704);
INSERT INTO `ks_question` VALUES (773, '车辆进入山区道路后，要特别注意“连续转弯”标志，并主动避让车辆及行人，适时减速和提前鸣喇叭。', '山区本来就是有山的地势，自然就会有坡度，以及拐弯，连续的弯路，容易影响行车的视线，所以要注意“连续转弯”的标志，以防在转弯处突然出现对向来车，为了安全，当然要适时减速和提前鸣喇叭，以提醒车辆与行人。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336705, 1542336705);
INSERT INTO `ks_question` VALUES (774, '迅速，避免拖挡行驶导致发动机动力不足。', '上坡前要减挡，避免因动力不足脱挡或者熄火。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336706, 1542336706);
INSERT INTO `ks_question` VALUES (775, '泥石流的山区地段，应谨慎驾驶，避免停车。', '为了安全着想，应尽量避免停车，以免遇到泥石流遇险。不是说不能停车，只是避免！ ', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336707, 1542336707);
INSERT INTO `ks_question` VALUES (776, '泥石流的山区地段，避免停车。', '为了安全着想，应尽量避免停车，以免遇到泥石流遇险。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336708, 1542336708);
INSERT INTO `ks_question` VALUES (777, '车辆驶入双向行驶隧道前，应开启什么灯？', '车辆进入双向行驶隧道，一般都应该开启近光灯，而不要开启远光灯。若是隧道本身没有灯光的，可以变换灯光行驶，但是会车前要换成近光灯。', NULL, 1, '[\"A、雾灯\",\"B、示廓灯或近光灯\",\"C、危险报警闪光灯\",\"D、远光灯\"]', 1, '1', 1, 1, 0, 0, 0, 1542336709, 1542336709);
INSERT INTO `ks_question` VALUES (778, '立交桥上一般都是单向行驶，车辆不必减速行驶。', '立交桥上车多、路窄、弯多，应减速行驶', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336710, 1542336710);
INSERT INTO `ks_question` VALUES (779, '夜间车辆通过照明条件良好的路段时，应使用什么灯？', '照明条件良好，开启近光就够了。远光会影响前车和前面行人的视线，容易引发危险。', NULL, 1, '[\"A、远光灯\",\"B、危险报警闪光灯\",\"C、雾灯\",\"D、近光灯\"]', 1, '3', 1, 1, 0, 0, 0, 1542336712, 1542336712);
INSERT INTO `ks_question` VALUES (780, '夜间行车中，前方出现弯道时，灯光照射会发生怎样的变化？', '要是没有实地操作，个人为了避免混淆是这样记的：在平直的路面时，灯光距离不变；出现一般的弯道时，灯光也跟着转弯，从路中移至路侧；当上坡时，灯光随着车的上下导致灯光也由高变低；当出现急弯或大坑时，灯光随着车的颠簸也离开路面。', NULL, 1, '[\"A、由高变低\",\"B、离开路面\",\"C、距离不变\",\"D、由路中移到路侧\"]', 1, '3', 1, 1, 0, 0, 0, 1542336713, 1542336713);
INSERT INTO `ks_question` VALUES (781, '夜间行车，驾驶人的视野受限，很难观察到灯光照射区域以外的交通情况，因此要减速行驶。', '晚上开车的时候受到光线暗的局限，相对观察事物的距离也就受到局限，所以视距比较短，很难观察到灯光照射区域以外的交通情况。为了安全考虑，减速行驶是必须的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336714, 1542336714);
INSERT INTO `ks_question` VALUES (782, '夜间驾驶人对事物的观察能力明显比白天差，视距变短。', '此题说的意思是，在白天开车的时候由于光线比较充足，所以观察事物的范围比较广，观察事物的视线距离相对也就比较大，而在晚上受到光线暗的局限，相对观察事物的距离也就受到局限，所以视距比较短，而并不是说人本身的观察有问题，所以此题是正确的!', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336715, 1542336715);
INSERT INTO `ks_question` VALUES (783, '夜间起步前，应当先开启近光灯。', '开启近光，能更好的观察周围环境，有利于安全行车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336716, 1542336716);
INSERT INTO `ks_question` VALUES (784, '夜间会车时，若对方车辆不关闭远光灯，可变换灯光提示对向车辆，同时减速靠右侧行驶或停车。', '夜间安全驾驶知识中第三条就有：“夜间会车应当在距对方来车150米以外改用近光灯，若对方车辆不关闭远光灯，可连续变换灯光提示对向车辆。当遇对面来车仍不关闭远光灯时，应及时减速靠右侧行驶或停车让行。”', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336717, 1542336717);
INSERT INTO `ks_question` VALUES (785, '夜间通过没有路灯或路灯照明不良时，应将近光灯转换为远光灯，但同向行驶的后车不得使用远光灯。', '通过没有路灯或路灯照明不良的路段（非路口）时可以开启远光灯，但是前方有车或行人时，为了不影响他人视线，应关闭远光，改用近光。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336718, 1542336718);
INSERT INTO `ks_question` VALUES (786, '夜间行车，遇对面来车未关闭远光灯时，应减速行驶，以防两车灯光的交汇处有行人通过时发生事故。', '远光会影响视线，容易引发危险，为了安全，减速慢行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336719, 1542336719);
INSERT INTO `ks_question` VALUES (787, '近光灯。', '《实施条例》第五十九条：机动车在夜间通过急弯、坡路、拱桥、人行横道或者没有交通信号灯控制的路口时，应当交替使用远近光灯示意。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336720, 1542336720);
INSERT INTO `ks_question` VALUES (788, '夜间行车，要尽量避免超车，确需超车时，可变换远近光灯向前车示意。', '只要在确保安全和不违规的情况下都可以超车。变换远近灯光是为了提醒前方车辆的注意，虽然只是一个动作，但对于保证安全来说却是很重要的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336722, 1542336722);
INSERT INTO `ks_question` VALUES (789, '夜间尾随前车行驶时，后车可以使用远光灯。', '《道路交通安全法实施条例》第五十八条：机动车在夜间没有路灯、照明不良或者遇有雾、雨、雪、沙尘、冰雹等低能见度情况下行驶时，应当开启前照灯、示廓灯和后位灯，但同方向行驶的后车与前车近距离行驶时，不得使用远光灯。机动车雾天行驶应当开启雾灯和危险报警闪光灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336723, 1542336723);
INSERT INTO `ks_question` VALUES (790, '在暴雨天气驾车，刮水器无法刮净雨水时，应怎样做？', '刮水器无法刮净雨水，肯定看不清路况，这时勉强行车容易引发危险。最安全的做法是立刻靠边停车，并开启危险报警闪光灯，等雨变小再继续行驶。', NULL, 1, '[\"A、立即减速靠边停车\",\"B、集中注意力谨慎驾驶\",\"C、以正常速度行驶\",\"D、减速行驶\"]', 1, '0', 1, 1, 0, 0, 0, 1542336724, 1542336724);
INSERT INTO `ks_question` VALUES (791, '在山区冰雪道路上行车，遇有前车正在爬坡时，后车应怎样做？', '冰雪路面很滑，正在爬坡的车可能会后溜，最安全的做法是选择安全地点停车，等前车通过后再爬坡。', NULL, 1, '[\"A、低速爬坡\",\"B、选择适当地点停车，等前车通过后再爬坡\",\"C、紧随其后爬坡\",\"D、迅速超越前车\"]', 1, '1', 1, 1, 0, 0, 0, 1542336725, 1542336725);
INSERT INTO `ks_question` VALUES (792, '雾天行车时，应及时开启什么灯？', '雾天行车应开启雾灯，遇到大雾要同时开危险报警闪光灯。', NULL, 1, '[\"A、雾灯\",\"B、倒车灯\",\"C、远光灯\",\"D、近光灯\"]', 1, '0', 1, 1, 0, 0, 0, 1542336726, 1542336726);
INSERT INTO `ks_question` VALUES (793, '遇有浓雾或特大雾天能见度过低，行车困难时，应怎样做？', '行车困难，就不要勉强行车。开启危险报警闪光灯和雾灯，选择安全地点停车最安全。', NULL, 1, '[\"A、开启前照灯，继续行驶\",\"B、开启危险报警闪光灯和雾灯，选择安全地点停车\",\"C、开启危险报警闪光灯，继续行驶\",\"D、开启示廓灯、雾灯，靠右行驶\"]', 1, '1', 1, 1, 0, 0, 0, 1542336727, 1542336727);
INSERT INTO `ks_question` VALUES (794, '车辆涉水后，应保持低速行驶，怎样操作制动踏板，以恢复制动效果？', '间断轻踏，给刹车片一些温度可以蒸发一些水，恢复制动。', NULL, 1, '[\"A、持续轻踏\",\"B、持续重踏\",\"C、间断轻踏\",\"D、间断重踏\"]', 1, '2', 1, 1, 0, 0, 0, 1542336728, 1542336728);
INSERT INTO `ks_question` VALUES (795, '雾等复杂气象条件，遇前车速度较低时，应开启前照灯，连续鸣喇叭迅速超越。', '风、雨、雪、雾等复杂气象条件需减速行驶，不得超车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336729, 1542336729);
INSERT INTO `ks_question` VALUES (796, '雨天路面湿滑，车辆制动距离增大，行车中尽量使用紧急制动减速。', '因为路面比较滑，如果紧急制动（急刹车），容易造成车辆翻车，要用发动机制动。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336730, 1542336730);
INSERT INTO `ks_question` VALUES (797, '浓雾天气能见度低，开启远光灯会提高能见度。', '不能开启远光灯，因浓雾会反射灯光。雾天行车应开启雾灯和危险报警闪光灯，不是远光。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336731, 1542336731);
INSERT INTO `ks_question` VALUES (798, '连续降雨天气，山区公路可能会出现路肩疏松和堤坡坍塌现象，行车时应选择道路中间坚实的路面，避免靠近路边行驶。', '疏松和堤坡坍塌现象是极有可能的。为了安全，应该在道路中间行车，除非必要，不要在路边行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336733, 1542336733);
INSERT INTO `ks_question` VALUES (799, '雾天行车多使用喇叭可引起对方注意；听到对方车辆鸣喇叭，也应鸣喇叭回应。', '雾天视线不佳，喇叭可当做一种信号和其他车辆交流，有利于安全行车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336734, 1542336734);
INSERT INTO `ks_question` VALUES (800, '加大安全距离。', '冰雪路面很滑，减低车速、加大安全距离有利于安全行车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336735, 1542336735);
INSERT INTO `ks_question` VALUES (801, '雪天行车中，在有车辙的路段应循车辙行驶。', '有车辙的路段证明有车通行过，说明是可以通行的安全路段，应循车辙行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336736, 1542336736);
INSERT INTO `ks_question` VALUES (802, '车辆在冰雪路面紧急制动易产生侧滑，应低速行驶，可利用发动机制动进行减速。', '冰雪路面很滑，不能紧急制动，应降低车速，充分利用发动机制动。发动机制动：行车（挂上排档，不是空档）中，油门一收，便产生发动机制动！原理：主要靠（停止供油）发动机的压缩力而制止车辆的前进。行车制动：通过刹车踏板，把人体的力量，由总泵至分泵加上助力器的作用，迫使刹车片与刹车盘或刹车毂磨擦至车辆停止前进。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336737, 1542336737);
INSERT INTO `ks_question` VALUES (803, '坚实的路段缓慢通过。', '泥泞翻浆路段行车容易发生侧滑，停车观察，降低车速，应选择平整、坚实的路段缓慢通过。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336738, 1542336738);
INSERT INTO `ks_question` VALUES (804, '在大雨天行车，为避免发生“水滑”而造成危险，要控制速度行驶。', '为了安全，雨天减速行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336739, 1542336739);
INSERT INTO `ks_question` VALUES (805, '前轮胎爆裂已出现转向时，驾驶人不要过度矫正，应在控制住方向的情况下，应怎样做，使车辆缓慢减速？', '爆胎时不能迅速减速，需慢慢减速。采取紧急制动是踩脚刹，使用驻车制动是拉手刹，迅速踏下制动踏板也是踩脚刹，都是属于迅速减速，危险。', NULL, 1, '[\"A、迅速踏下制动踏板\",\"B、采取紧急制动\",\"C、轻踏制动踏板\",\"D、使用驻车制动\"]', 1, '2', 1, 1, 0, 0, 0, 1542336740, 1542336740);
INSERT INTO `ks_question` VALUES (806, '轮胎气压过低时，高速行驶轮胎会出现波浪变形温度升高而导致什么？', '轮胎气不足，就会造成轮胎与地面的摩擦范围增大，所以会使温度升高，从而爆胎。压力过低和过高都会导致爆胎。', NULL, 1, '[\"A、气压更低\",\"B、爆胎\",\"C、行驶阻力增大\",\"D、气压不稳\"]', 1, '1', 1, 1, 0, 0, 0, 1542336741, 1542336741);
INSERT INTO `ks_question` VALUES (807, '避免爆胎的错误的做法是什么？', '轮胎缺气行驶是爆胎的祸根。车辆的缺气（轮胎胎压低于标准胎压）行驶时，随着胎压的下降，轮胎与地面的摩擦成倍增加，胎温急剧升高，轮胎变软，强度急剧下降。这种情况下，如果车辆高速行驶，就可能导致爆胎。如果车辆低速行驶，也会伤胎，而且潜伏期长，隐蔽性大，更有危害性，为以后高速行车时埋下爆胎隐患，所以降低轮胎气压是错误的做法。', NULL, 1, '[\"A、降低轮胎气压\",\"B、及时清理轮胎沟槽里的异物\",\"C、更换掉有裂纹或有很深损伤的轮胎\",\"D、定期检查轮胎\"]', 1, '0', 1, 1, 0, 0, 0, 1542336742, 1542336742);
INSERT INTO `ks_question` VALUES (808, '驾驶人发现轮胎漏气，将车辆驶离主车道时，不要采用紧急制动，以免造成翻车或后车采取制动不及时导致追尾事故。', '轮胎漏气时不能采取紧急制动，容易造成翻车。应控制住方向，慢慢停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336744, 1542336744);
INSERT INTO `ks_question` VALUES (809, '车辆后轮胎爆裂，车尾会摇摆不定，驾驶人应双手紧握转向盘，控制车辆保持直线行驶，减速停车。', '爆胎后，首先要控制住方向，保持直线行驶，再减速停车。因为如果突然爆胎，瞬间靠右，会导致与后方来车相撞，所以只能先保持直线行驶，再减速停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336745, 1542336745);
INSERT INTO `ks_question` VALUES (810, '行车中当驾驶人意识到爆胎时，应在控制住方向的情况下，轻踏制动踏板，使车辆缓慢减速，逐渐平稳地停靠于路边。', '爆胎和意识到爆胎时，首先要做的就是控制住方向，然后缓慢减速，平稳停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336746, 1542336746);
INSERT INTO `ks_question` VALUES (811, '行车中当车辆突然爆胎时，驾驶人切忌慌乱中急踏制动踏板，尽量采用“抢挡”的方法，利用发动机制动使车辆减速。', '爆胎和意识到爆胎时，首先要做的就是控制住方向，然后缓慢减速，平稳停车。不能急踏制动踏板，应充分利用发动机制动。由于车胎爆胎，紧急制动会侧滑。所以只能用抢挡，用发动机制动。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336747, 1542336747);
INSERT INTO `ks_question` VALUES (812, '车辆前轮胎爆裂，危险较大，方向会立刻向爆胎车轮一侧跑偏，直接影响驾驶人对转向盘的控制。', '爆胎后，车辆整体平衡会受到影响，会向爆胎的一边跑偏，直接影响到驾驶人对转向盘的控制。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336748, 1542336748);
INSERT INTO `ks_question` VALUES (813, '车辆发生爆胎后，驾驶人在尚未控制住车速前，不要冒险使用行车制动器停车，以避免车辆横甩发生更大的险情。', '行车制动=制动踏板=脚刹，爆胎后，驾驶人在尚未控制住车速的时候，是不能急踩刹车的，要不然会横甩或者翻车，甚至与后面来车追尾。正确的做法应该是紧握方向盘，控制方向，极力保持直线行驶，利用发动机制动，减档或抢档减速度，轻踏制动踏板缓慢减速，平稳靠边停车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336749, 1542336749);
INSERT INTO `ks_question` VALUES (814, '行车中当车辆前轮爆胎已发生转向时，驾驶人应双手紧握转向盘，尽力控制车辆直线行驶。', '行车中当车辆前轮爆胎已发生转向时：第一步：驾驶人应双手紧握转向盘，尽力控制车辆转回原行驶路线。为什么要这么做?如果不控制方向，很容易翻车，如果急刹车，也很容易翻车。第二步：随后开始减速打起右转向灯，然后靠右最终使车停在路肩上。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336750, 1542336750);
INSERT INTO `ks_question` VALUES (815, '行车中当驾驶人意识到车辆爆胎时，应在控制住方向的情况下采取紧急制动，迫使车辆迅速停住。', '车辆爆胎后，应先控制方向，保持直线行驶，然后利用发动机制动，缓慢减速停车。不能采取紧急制动。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336751, 1542336751);
INSERT INTO `ks_question` VALUES (816, '在行驶过程中，机动车驾驶人要注意与前车保持安全距离。', '安全行车，保持安全距离。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336752, 1542336752);
INSERT INTO `ks_question` VALUES (817, '专用车道规定的专用使用时间之外，其他车辆可以进入专用车道行驶。', '专用车道规定的专用使用时间是专供专用车辆行驶的，其他的时间，可供其他车辆行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336754, 1542336754);
INSERT INTO `ks_question` VALUES (818, '夜间会车规定150米以内使用近光灯的原因是什么？', '常识题。远光会影响前车视线，会车时不得开远光。', NULL, 1, '[\"A、提示后方车辆\",\"B、两车之间相互提示\",\"C、驾驶人的操作习惯行为\",\"D、使用远光灯会造成驾驶人出现眩目，易引发危险\"]', 1, '3', 1, 1, 0, 0, 0, 1542336755, 1542336755);
INSERT INTO `ks_question` VALUES (819, '雾天行车，听到对方鸣喇叭，也应该鸣喇叭回应，以提示对方车辆。', '雾天视线不佳，无法观察周围车况，要充分利用喇叭提示对方。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336756, 1542336756);
INSERT INTO `ks_question` VALUES (820, '夜间行车，可选择下列哪个地段超车？', '夜间行车，尽量避免超车。必须超车，就选择路宽车少的路段。', NULL, 1, '[\"A、路宽车少\",\"B、弯道陡坡\",\"C、交叉路口\",\"D、窄路窄桥\"]', 1, '0', 1, 1, 0, 0, 0, 1542336757, 1542336757);
INSERT INTO `ks_question` VALUES (821, '变更车道时只需开启转向灯，并迅速转向驶入相应的车道，以不妨碍同道机动车正常行驶。', '变更车道需提前开启转向灯，观察周围环境确认安全后再驶入相应的车道，不得妨碍其他车辆正常行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336758, 1542336758);
INSERT INTO `ks_question` VALUES (822, '驾驶机动车变更车道前应仔细观察，目的是判断有无变更车道的条件。', '变更车道需提前开启转向灯，观察周围环境确认安全后再驶入相应的车道，不得妨碍其他车辆正常行驶。本题是强调仔细观察，没说不开转向灯。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336759, 1542336759);
INSERT INTO `ks_question` VALUES (823, '超车时，如果无法保证与被超车辆的安全间距，应主动放弃超车。', '无法保证与被超车辆的安全间距，也就是没有超车条件，这时应主动放弃超车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336760, 1542336760);
INSERT INTO `ks_question` VALUES (824, '人行横道上禁止掉头的原因是什么？', '在人行横道上掉头，很有可能撞到行人，不安全。', NULL, 1, '[\"A、避免妨碍行人正常通行\",\"B、路段有监控设备\",\"C、人行横道禁止停车\",\"D、人行横道禁止车辆通行\"]', 1, '0', 1, 1, 0, 0, 0, 1542336761, 1542336761);
INSERT INTO `ks_question` VALUES (825, '如图所示，以下哪种情况可以超车？', '这种情况超车要符合两个条件：虚线一侧，对向无来车。符合条件是50c。', 'http://file.open.jiakaobaodian.com/tiku/res/1098600.jpg', 1, '[\"A、50d\",\"B、50b\",\"C、50c\",\"D、50a\"]', 1, '2', 1, 1, 4, 0, 0, 1542336762, 1542336762);
INSERT INTO `ks_question` VALUES (826, '如图所示，在超车过程中，遇对向有车来时要放弃超车的原因是什么？', '如图所示，对向车道有来车，前方车辆左侧没有足够的安全距离，应放弃超车，避免与对面车辆发生刮擦、相撞。', 'http://file.open.jiakaobaodian.com/tiku/res/1098700.jpg', 1, '[\"A、对向来车车速太快\",\"B、如继续超车，易与对面机动车发生刮擦、相撞\",\"C、前车车速太快\",\"D、我方车辆提速太慢\"]', 1, '1', 1, 1, 4, 0, 0, 1542336763, 1542336763);
INSERT INTO `ks_question` VALUES (827, '如图所示，B车具有优先通过权。', '右转让左转，转弯让直行。如图所示，A车直行而B车右转，明显是A车先行，B车避让。', 'http://file.open.jiakaobaodian.com/tiku/res/1098800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336765, 1542336765);
INSERT INTO `ks_question` VALUES (828, '如图所示，在这种道路上行驶，应在道路中间通行的主要原因是在道路中间通行速度快。', '机动车在中间通行是为了给行人和非机动车足够的通行空间。', 'http://file.open.jiakaobaodian.com/tiku/res/1098900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336766, 1542336766);
INSERT INTO `ks_question` VALUES (829, '如图所示，当越过停在人行横道前的A车时，B车应当减速，准备停车让行。', '如图所示，B车前方是人行横道，应当减速行驶，当B车越过A车后，若有行人通过，必要时停车让行。', 'http://file.open.jiakaobaodian.com/tiku/res/1099000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336767, 1542336767);
INSERT INTO `ks_question` VALUES (830, '如图所示，A车在这种情况下应适当减速。', '如图所示，A车在B车后，B车开启了右转向灯，减速右转，紧跟B车的A车需要减速，以保持安全距离。', 'http://file.open.jiakaobaodian.com/tiku/res/1099200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336769, 1542336769);
INSERT INTO `ks_question` VALUES (831, '如图所示，A车具有优先通过权。', '三个先行原则：转弯的机动车让直行的车辆先行；右方道路来车先行；右转弯车让左转弯车先行。如图所示，B车是左转弯，A车是右转弯，B车先行。', 'http://file.open.jiakaobaodian.com/tiku/res/1099300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336770, 1542336770);
INSERT INTO `ks_question` VALUES (832, '如图所示，A车在此时进入左侧车道是因为进入实线区不得变更车道。', '如图所示，A车正处在白色虚线区，这个时候可以变更车道。如果这个时候不变更车道，到了实线区就不可以变更车道了，实线是不能跨越的。', 'http://file.open.jiakaobaodian.com/tiku/res/1099400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336771, 1542336771);
INSERT INTO `ks_question` VALUES (833, '如图所示，驾驶机动车遇到没有行人通过的人行横道时不用减速慢行。', '遇到人行横道必须减速行驶，即使没有行人。', 'http://file.open.jiakaobaodian.com/tiku/res/1099500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336772, 1542336772);
INSERT INTO `ks_question` VALUES (834, '遇到前方车辆停车排队或者缓慢行驶时，强行穿插，以下说法正确的是什么？', '强行穿插，会扰乱车流，加重拥堵，是不文明的表现，应该禁止。', NULL, 1, '[\"A、允许，因为可以省油\",\"B、禁止，因为这样扰乱车流，加重拥堵\",\"C、禁止，因为这样不利于省油\",\"D、允许，因为可以快速地通过拥堵区\"]', 1, '1', 1, 1, 0, 0, 0, 1542336773, 1542336773);
INSERT INTO `ks_question` VALUES (835, '鸣喇叭，加速通过，以免造成交通拥堵。', '雾天行驶，应减速，不应该加速。', 'http://file.open.jiakaobaodian.com/tiku/res/1099700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336775, 1542336775);
INSERT INTO `ks_question` VALUES (836, '如图所示，当您超越右侧车辆时，应该尽快超越，减少并行时间。', '超车时，应尽快超越，减少并行时间，驶出安全距离后驶回原车道。此题答案以驾考宝典官方标准答案为主，其他书籍可能存在印刷错误，请各位车友注意甄别！', 'http://file.open.jiakaobaodian.com/tiku/res/1099800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336776, 1542336776);
INSERT INTO `ks_question` VALUES (837, '如图所示，在这种情况下不能够超车的原因是什么？', '如图所示，前面蓝色的车正在超车，这个时候不能超车。此题答案以驾考宝典官方标准答案为主，其他书籍可能存在印刷错误，请各位车友注意甄别！', 'http://file.open.jiakaobaodian.com/tiku/res/1099900.jpg', 1, '[\"A、前车速度过快\",\"B、路中心线为黄线\",\"C、前车正在超车\",\"D、我方车速不足以超越前车\"]', 1, '2', 1, 1, 4, 0, 0, 1542336777, 1542336777);
INSERT INTO `ks_question` VALUES (838, '大雾天行车，多鸣喇叭是为了什么？', '大雾天气能见度低，鸣喇叭是为了提醒对方，这边有车，这样能避免发生事故。', NULL, 1, '[\"A、催促前车让行\",\"B、催促前车提速，避免发生追尾。\",\"C、准备超越前车\",\"D、引起对方注意，避免发生危险\"]', 1, '3', 1, 1, 0, 0, 0, 1542336778, 1542336778);
INSERT INTO `ks_question` VALUES (839, '如图所示，在这种情况下，驾驶机动车要停车让行。', '如图所示，人行横道正有行人通行，要停车让行。', 'http://file.open.jiakaobaodian.com/tiku/res/1100100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336779, 1542336779);
INSERT INTO `ks_question` VALUES (840, '如图所示，直行车辆遇到前方路口堵塞，以下说法正确的是什么？', '《实施条例》第五十三条：机动车遇有前方交叉路口交通阻塞时，应当依次停在路口以外等候，不得进入路口。', 'http://file.open.jiakaobaodian.com/tiku/res/1100200.jpg', 1, '[\"A、等其他机动车进入路口时跟随行驶\",\"B、只有信号灯为绿灯，就可以通行\",\"C、可以直接驶入路口内等候通行\",\"D、等前方道路疏通后，且信号灯为绿灯时方可继续行驶\"]', 1, '3', 1, 1, 4, 0, 0, 1542336780, 1542336780);
INSERT INTO `ks_question` VALUES (841, '如图所示，机动车在这种道路上行驶，在道路中间通行的原因是什么？', '图中是没有中心线的道路，在中间行驶是为了给两侧的非机动车和行人留出充足的通行空间。', 'http://file.open.jiakaobaodian.com/tiku/res/1100300.jpg', 1, '[\"A、给两侧的非机动车和行人留有充足的通行空间\",\"B、在道路中间通行视线好\",\"C、防止车辆冲出路外\",\"D、在道路中间通行速度快\"]', 1, '0', 1, 1, 4, 0, 0, 1542336781, 1542336781);
INSERT INTO `ks_question` VALUES (842, '通过漫水路时要谨慎慢行，不得空挡滑行。', '机动车行经漫水桥路段时，应当停车察明水情，确认安全后，低速通过，不得空挡滑行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336782, 1542336782);
INSERT INTO `ks_question` VALUES (843, '如图所示，在这种情况下通过路口，应该怎么行驶？', '如图所示，蓝色汽车旁边正有个人准备过马路，此时应减速或停车避让行人。', 'http://file.open.jiakaobaodian.com/tiku/res/1100600.jpg', 1, '[\"A、减速或停车避让行人\",\"B、赶在行人前通过\",\"C、加速通过\",\"D、靠左侧行驶\"]', 1, '0', 1, 1, 4, 0, 0, 1542336785, 1542336785);
INSERT INTO `ks_question` VALUES (844, '驾驶机动车向右变更车道前应仔细观察右侧车道车流情况的原因是什么？', '有变更车道条件，确认安全，才能变道。', NULL, 1, '[\"A、准备迅速停车\",\"B、准备抢行\",\"C、判断有无变更车道的条件\",\"D、迅速变更车道\"]', 1, '2', 1, 1, 0, 0, 0, 1542336786, 1542336786);
INSERT INTO `ks_question` VALUES (845, '不越线行驶。', '会车时要放慢车速，临近交会时条件不良，更应控制车速，不能盲目交会，必要时应该先停车，以达到两车顺利交会的目的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336787, 1542336787);
INSERT INTO `ks_question` VALUES (846, '坡道顶端等影响安全视距的路段时，减速慢行并鸣喇叭示意是为了什么？', '急弯、坡道环境复杂，视距短，无法很好地观察对向交通情况，这时需鸣喇叭提示对向交通参与者我方有来车。', NULL, 1, '[\"A、避免行至坡道顶端车辆动力不足\",\"B、提示对向交通参与者我方有来车\",\"C、提示前车后方车辆准备超车\",\"D、测试喇叭是否能正常使用\"]', 1, '1', 1, 1, 0, 0, 0, 1542336788, 1542336788);
INSERT INTO `ks_question` VALUES (847, '夜间行车，需要超车时，变换远近光灯示意是为了提示前车。', '变换远近光灯提示前车我方要超车，有利于安全行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336789, 1542336789);
INSERT INTO `ks_question` VALUES (848, '如图所示，在这种情况下遇右侧车辆变更车道，应减速保持安全间距，注意避让。', '安全行车，礼貌让行。', 'http://file.open.jiakaobaodian.com/tiku/res/1101100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336790, 1542336790);
INSERT INTO `ks_question` VALUES (849, '遇前方路段车道减少，车辆行驶缓慢，为了保证安全有序应该怎么做？', '《实施条例》第五十三条：机动车在车道减少的路口、路段，遇有前方机动车停车排队等候或者缓慢行驶的，应当每车道一辆依次交替驶入车道减少后的路口、路段。', NULL, 1, '[\"A、借对向车道迅速通过\",\"B、穿插到前方排队车辆中通过\",\"C、加速从前车左右超越\",\"D、依次交替通行\"]', 1, '3', 1, 1, 0, 0, 0, 1542336792, 1542336792);
INSERT INTO `ks_question` VALUES (850, '如图所示，A车要在前方掉头行驶，可以在此处变换车道，进入左侧车道准备掉头。', '如图所示，前方是实线区，不可以变换车道。', 'http://file.open.jiakaobaodian.com/tiku/res/1101400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336793, 1542336793);
INSERT INTO `ks_question` VALUES (851, '非机动车和行人实行分道行驶，是为了规范交通秩序，提高通行效率。', '分道行驶，才能保证交通井然有序，从而提高效率。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336794, 1542336794);
INSERT INTO `ks_question` VALUES (852, '如图所示，车辆在拥挤路段排队行驶时，遇到其他车辆强行穿插行驶，以下说法正确的是什么？', '安全行车，礼貌让行。', 'http://file.open.jiakaobaodian.com/tiku/res/1101600.jpg', 1, '[\"A、迅速左转躲避\",\"B、减速或停车让行\",\"C、持续鸣喇叭警告\",\"D、迅速提高车速不让其穿插\"]', 1, '1', 1, 1, 4, 0, 0, 1542336796, 1542336796);
INSERT INTO `ks_question` VALUES (853, '如图所示，在这种情况下，A车可以向左变更车道。', '左边有车，不具备变更车道的条件，不能向左变更车道。', 'http://file.open.jiakaobaodian.com/tiku/res/1101700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336797, 1542336797);
INSERT INTO `ks_question` VALUES (854, '路口转弯过程中，持续开启转向灯，主要原因是因为什么？', '转向灯一般就是起提示其他车辆的作用。', NULL, 1, '[\"A、让其他驾驶人知道您正在转弯\",\"B、完成转弯动作前，关闭转向灯是习惯动作\",\"C、完成转弯动作前，关闭转向灯会对车辆造成损害\",\"D、让其他驾驶人知道您在超车\"]', 1, '0', 1, 1, 0, 0, 0, 1542336798, 1542336798);
INSERT INTO `ks_question` VALUES (855, '驾驶机动车正在被其他车辆超车时，被超车辆减速靠右侧行驶的目的是什么？', '安全驾驶，文明礼让。', NULL, 1, '[\"A、避让行人与非机动车\",\"B、给该车让出足够的超车空间\",\"C、以便随时停车\",\"D、以上选项都不正确\"]', 1, '1', 1, 1, 0, 0, 0, 1542336799, 1542336799);
INSERT INTO `ks_question` VALUES (856, '如图所示，驾驶机动车接打电话容易导致发生交通事故。', '驾驶机动车接打电话会分散驾驶员的注意力，容易导致发生交通事故。', 'http://file.open.jiakaobaodian.com/tiku/res/1129500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336800, 1542336800);
INSERT INTO `ks_question` VALUES (857, '驾驶机动车下长坡时，利用惯性滑行可以减少燃油消耗，值得提倡。', '利用惯性滑行虽然会减少燃油消耗，但此举是危险动作，下坡时，不准熄火或用空挡利用惯性滑行。如果下坡滑行，只靠刹车来控制车速，遇到连续下坡的时候可能会造成刹车负担过重，刹车片过热而失灵。正确的做法是：在下长坡道路行驶，挂入低速档利用发动机的牵阻作用可以减少制动器的负担和减少制动次数，防止制动过热引起制动力热衰减；在冰雪、泥泞的路面上行驶，应用发动机牵阻制动可以防止侧滑。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336801, 1542336801);
INSERT INTO `ks_question` VALUES (858, '驾驶机动车超车时，前方车辆不减速让路，应停止超车并适当减速，与前方车辆保持安全距离。', '不让超车，就别超了，安全第一。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336802, 1542336802);
INSERT INTO `ks_question` VALUES (859, '如图所示，A车货物掉落，导致B车与掉落货物发生碰撞，以下说法正确的是什么？', '货车散落货物，导致后面的车辆撞上，货车全责。', 'http://file.open.jiakaobaodian.com/tiku/res/1129800.jpg', 1, '[\"A、各负一半责任\",\"B、B车自负责任\",\"C、偶然事件，不可避免\",\"D、A车负全部责任\"]', 1, '3', 1, 1, 4, 0, 0, 1542336803, 1542336803);
INSERT INTO `ks_question` VALUES (860, '行人需要快速通过。', '黄灯闪烁提示行人车辆注意，确认安全后通过，快速通过是不对的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336804, 1542336804);
INSERT INTO `ks_question` VALUES (861, '因避让特种车辆而发生违法行为，被电子警察拍到时，可向交管部门复议。', '避让特种车辆而发生违法行为可向交管部门复议，不用担心做好事还受罚了。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336806, 1542336806);
INSERT INTO `ks_question` VALUES (862, '如图所示，驾驶机动车遇到这种情况时，A车应当注意避让。', '《中华人民共和国道路交通安全法》第五十四条明确规定：道路养护车辆、工程作业车进行作业时，在不影响过往车辆通行的前提下，其行驶路线和方向不受交通标志、标线限制，过往车辆和人员应当注意避让。', 'http://file.open.jiakaobaodian.com/tiku/res/1130100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336807, 1542336807);
INSERT INTO `ks_question` VALUES (863, '如图所示，驾驶过程中遇到这种情况时，A车可以长鸣喇叭提醒道路养护车辆暂停喷水。', '《中华人民共和国道路交通安全法》第五十四条明确规定：道路养护车辆、工程作业车进行作业时，在不影响过往车辆通行的前提下，其行驶路线和方向不受交通标志、标线限制，过往车辆和人员应当注意避让。', 'http://file.open.jiakaobaodian.com/tiku/res/1130200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336808, 1542336808);
INSERT INTO `ks_question` VALUES (864, '在高速公路上驾驶机动车，车辆发生故障后的处置方法，以下说法错误的是什么？', '人员安全第一，人员停留在高速公路上推车容易造成危险。', NULL, 1, '[\"A、在车后150米以外设置安全警告标志\",\"B、打开危险报警闪光灯，夜间还应开启示廓灯、后位灯\",\"C、所有人员需离开故障车辆，在紧急停车带或护栏以外安全位置报警并等候救援\",\"D、车内乘员应下车辅助将故障车辆推移到紧急停车带上\"]', 1, '3', 1, 1, 0, 0, 0, 1542336809, 1542336809);
INSERT INTO `ks_question` VALUES (865, '驾驶机动车发生故障或事故不能正常行驶时，应立即打开危险报警闪光灯。', '第一时间打开危险报警闪光灯，警示其他车辆，是正确的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336810, 1542336810);
INSERT INTO `ks_question` VALUES (866, '驾驶机动车在高速公路上行驶，能见度小于200米时，车速不得超过每小时60公里。', '《中华人民共和国道路交通安全法实施条例》第八十一条：机动车在高速公路上行驶，遇有雾、雨、雪、沙尘、冰雹等低能见度气象条件时，应当遵守下列规定：能见度小于200米时，开启雾灯、近光灯、示廓灯和前后位灯，车速不得超过每小时60公里，与同车道前车保持100米以上的距离。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336811, 1542336811);
INSERT INTO `ks_question` VALUES (867, '行驶证的，除扣留机动车外，并受到什么处罚？', '《道路交通安全违法行为处理程序规定》第十三条：“有下列情形之一的，因无其他机动车驾驶人代替驾驶、违法行为尚未消除、需要调查或者证据保全等原因不能立即放行的，可以扣留车辆：未悬挂机动车号牌，未放置检验合格标志、保险标志，或者未携带行驶证、机动车驾驶证的。《道路交通安全法》第九十条：“机动车驾驶人违反道路交通安全法律、法规关于道路通行规定的，处警告或者二十元以上二百元以下罚款。本法另有规定的，依照规定处罚。”具体罚款多少，看省市级公安交通管理机关的规定。', NULL, 1, '[\"A、吊销驾驶证\",\"B、罚款\",\"C、警告\",\"D、拘留\"]', 1, '1', 1, 1, 0, 0, 0, 1542336812, 1542336812);
INSERT INTO `ks_question` VALUES (868, '以下哪种行为处十日以下拘留，并处一千元以上二千元以下罚款，吊销机动车驾驶证？', '依据《中华人民共和国道路交通安全法》：饮酒后驾驶机动车的，处暂扣六个月机动车驾驶证，并处一千元以上二千元以下罚款。因饮酒后驾驶机动车被处罚，再次饮酒后驾驶机动车的，处十日以下拘留，并处一千元以上二千元以下罚款，吊销机动车驾驶证。', NULL, 1, '[\"A、醉酒驾驶机动车的\",\"B、故意遮挡机动车号牌的\",\"C、因饮酒后驾驶机动车被处罚，再次饮酒后驾驶机动车的\",\"D、使用其他车辆保险标志的\"]', 1, '2', 1, 1, 0, 0, 0, 1542336813, 1542336813);
INSERT INTO `ks_question` VALUES (869, '以下哪种违法行为的机动车驾驶人将被一次记6分？', '机动车驾驶人有下列违法行为之一，一次记6分：（一）机动车驾驶证被暂扣期间驾驶机动车的；（二）驾驶机动车违反道路交通信号灯通行的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数未达20％的，或者驾驶其他载客汽车载人超过核定人数20％以上的；（四）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速未达20％的； （五）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路以外的道路上行驶或者驾驶其他机动车行驶超过规定时速20%以上未达到50%的；（六）驾驶货车载物超过核定载质量30%以上或者违反规定载客的；（七）驾驶营运客车以外的机动车在高速公路车道内停车的；（八）驾驶机动车在高速公路或者城市快速路上违法占用应急车道行驶的；（九）低能见度气象条件下，驾驶机动车在高速公路上不按规定行驶的；（十）驾驶机动车运载超限的不可解体的物品，未按指定的时间、路线、速度行驶或者未悬挂明显标志的；（十一）驾驶机动车载运爆炸物品、易燃易爆化学物品以及剧毒、放射性等危险物品，未按指定的时间、路线、速度行驶或者未悬挂警示标志并采取必要的安全措施的；（十二）以隐瞒、欺骗手段补领机动车驾驶证的；（十三）连续驾驶中型以上载客汽车、危险物品运输车辆以外的机动车超过4小时未停车休息或者停车休息时间少于20分钟的；', NULL, 1, '[\"A、驾驶与准驾车型不符的机动车\",\"B、驾驶机动车违反道路交通信号灯\",\"C、车速超过规定时速50%以上\",\"D、未取得校车驾驶资格驾驶校车\"]', 1, '1', 1, 1, 0, 0, 0, 1542336814, 1542336814);
INSERT INTO `ks_question` VALUES (870, '驾驶机动车造成重大交通事故后逃逸，构成犯罪的，由公安机关交通管理部门吊销机动车驾驶证，且终生不得重新取得机动车驾驶证。', '《道路交通安全法》第一百零一条规定：造成交通事故后逃逸的，由公安机关交通管理部门吊销机动车驾驶证，且终身不得重新取得机动车驾驶证。构成犯罪的，依法追究刑事责任。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336816, 1542336816);
INSERT INTO `ks_question` VALUES (871, '隐瞒有关情况或者提供虚假材料申请机动车驾驶证，申请人在多少年内不得再次申领机动车驾驶证？', '《机动车驾驶证申领和使用规定》第六章，第七十八条：隐瞒有关情况或者提供虚假材料申领机动车驾驶证的，申请人在一年内不得再次申领机动车驾驶证。', NULL, 1, '[\"A、2年\",\"B、1年\",\"C、3年\",\"D、4年\"]', 1, '1', 1, 1, 0, 0, 0, 1542336817, 1542336817);
INSERT INTO `ks_question` VALUES (872, '以下哪种行为机动车驾驶人将被一次记12分？', '机动车驾驶人有下列违法行为之一，一次记12分：（一）驾驶与准驾车型不符的机动车的；（二）饮酒后驾驶机动车的；（三）驾驶营运客车（不包括公共汽车）、校车载人超过核定人数20％以上的；（四）造成交通事故后逃逸，尚不构成犯罪的；（五）上道路行驶的机动车未悬挂机动车号牌的，或者故意遮挡、污损、不按规定安装机动车号牌的；（六）使用伪造、变造的机动车号牌、行驶证、驾驶证、校车标牌或者使用其他机动车号牌、行驶证的；（七）驾驶机动车在高速公路上倒车、逆行、穿越中央分隔带掉头的；（八）驾驶营运客车在高速公路车道内停车的；（九）驾驶中型以上载客载货汽车、校车、危险物品运输车辆在高速公路、城市快速路上行驶超过规定时速20％以上或者在高速公路、城市快速路以外的道路上行驶超过规定时速50％以上，以及驾驶其他机动车行驶超过规定时速50%以上的；（十）连续驾驶中型以上载客汽车、危险物品运输车辆超过4小时未停车休息或者停车休息时间少于20分钟的；（十一）未取得校车驾驶资格驾驶校车的。', NULL, 1, '[\"A、驾驶机动车不按规定避让校车的\",\"B、驾驶机动车违反道路交通信号灯通行的\",\"C、驾驶与准驾车型不符的机动车的\",\"D、驾驶证被暂扣期间驾驶机动车的\"]', 1, '2', 1, 1, 0, 0, 0, 1542336818, 1542336818);
INSERT INTO `ks_question` VALUES (873, '驾驶机动车时接打电话容易引发事故，以下原因错误的是什么?', '驾驶机动车时接打电话容易引发事故，主要是因为接电话时单手握方向盘，对机动车控制力下降；驾驶人注意力不集中，不能及时判断危险；驾驶人对路况观察不到位，容易导致操作失误。', NULL, 1, '[\"A、驾驶人注意力不集中，不能及时判断危险\",\"B、单手握方向盘，对机动车控制力下降\",\"C、驾驶人对路况观察不到位，容易导致操作失误\",\"D、电话的信号会对汽车电子设备的运行造成干扰\"]', 1, '3', 1, 1, 0, 0, 0, 1542336819, 1542336819);
INSERT INTO `ks_question` VALUES (874, '如图所示，在这起交通事故中，以下说法正确的是什么？', '这起交通事故主要是因为A车绕开障碍物时未提前观察减速为B车让行造成的，所以A车全责。', 'http://file.open.jiakaobaodian.com/tiku/res/1131300.jpg', 1, '[\"A、B车负主要责任\",\"B、A车负全部责任\",\"C、各负一半的责任\",\"D、B车负全部责任\"]', 1, '1', 1, 1, 4, 0, 0, 1542336820, 1542336820);
INSERT INTO `ks_question` VALUES (875, '驾驶机动车前，以下说法错误的是什么？', '驾驶机动车前，需要：（一）调整驾驶座椅，保证踩踏踏板舒适；（二）调整安全带的松紧与高低；（三）调整适合驾驶的方向盘位置；（四）安全头枕需要对准后脑勺来保护驾驶员的颈椎。', NULL, 1, '[\"A、调整安全带的松紧与高低\",\"B、调整适合驾驶的方向盘位置\",\"C、调整安全头枕高度，使头枕正对驾驶人的颈椎\",\"D、调整驾驶座椅，保证踩踏踏板舒适\"]', 1, '2', 1, 1, 0, 0, 0, 1542336821, 1542336821);
INSERT INTO `ks_question` VALUES (876, '如图所示，驾驶机动车行经该路段时，应减速慢行，避免因眩目导致的交通事故。', '该路段为隧道出口，驾驶机动车行经该路段时，应减速慢行，避免因光线突然变化，阳光眩目导致的交通事故。', 'http://file.open.jiakaobaodian.com/tiku/res/1131500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336822, 1542336822);
INSERT INTO `ks_question` VALUES (877, '驾驶机动车遇到前方低速行驶的洒水车作业时，以下做法错误的是什么？', '驾驶机动车遇到前方低速行驶的洒水车作业时，需要注意避让；若洒水车有指示箭头，在确保安全的情况下按箭头指示方向变更车道；若洒水车无指示箭头，在确保安全的情况下选择合适的车道变更。', NULL, 1, '[\"A、通过洒水车时应急加速通过\",\"B、若洒水车有指示箭头，在确保安全的情况下按箭头指示方向变更车道\",\"C、若洒水车无指示箭头，在确保安全的情况下选择合适的车道变更\",\"D、注意避让\"]', 1, '0', 1, 1, 0, 0, 0, 1542336823, 1542336823);
INSERT INTO `ks_question` VALUES (878, '保持安全距离的原因，以下说法错误的是什么？', '驾驶机动车在高速公路上遇到雨雪天气时能见度下降，驾驶人难以及时发现前方车辆，在此类天气条件下的道路上，车辆的制动距离变长，需要降低车速，为车辆安全行驶提供足够的安全距离。', NULL, 1, '[\"A、为车辆安全行驶提供足够的安全距离\",\"B、能见度下降，驾驶人难以及时发现前方车辆\",\"C、此类天气条件下的道路上，车辆的制动距离变长\",\"D、降低恶劣天气对车辆造成的损害\"]', 1, '3', 1, 1, 0, 0, 0, 1542336824, 1542336824);
INSERT INTO `ks_question` VALUES (879, '驾驶机动车在高速公路发生故障，需要停车排除故障时，以下做法先后顺序正确的是？ ①放置警告标志，转移乘车人员至安全处，迅速报警②开启危险报警闪光灯③将车辆移至不妨碍交通的位置④等待救援', '驾驶机动车在高速公路发生故障，需要停车排除故障时，应当进行如下顺序的操作：开启危险报警闪光灯；将车辆移至不妨碍交通的位置；放置警告标志，转移乘车人员至安全处，迅速报警；等待救援。', NULL, 1, '[\"A、③②①④\",\"B、②③①④\",\"C、④③①②\",\"D、①②③④\"]', 1, '1', 1, 1, 0, 0, 0, 1542336825, 1542336825);
INSERT INTO `ks_question` VALUES (880, '围观。', '这道题如果是单选题的话，则选行人参与道路交通的主要特点是行走随意性大、方向多变。但是此题为判断题，聚集，围观也是行人参与交通的特点。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336827, 1542336827);
INSERT INTO `ks_question` VALUES (881, '冰雹等低能见度气象条件时，能见度在50米以下时，以下做法正确的是什么？', '机动车在高速公路上行驶，遇有雾、雨、雪、沙尘、冰雹等低能见度气象条件时，能见度小于50米时，开启雾灯、近光灯、示廓灯、前后位灯和危险报警闪光灯，车速不得超过每小时20公里，并从最近的出口尽快驶离高速公路。', NULL, 1, '[\"A、加速驶离高速公路\",\"B、可以继续行驶，但车速不得超过每小时40公里\",\"C、在应急车道上停车等待\",\"D、以不超过每小时20公里的车速从最近的出口尽快驶离高速公路\"]', 1, '3', 1, 1, 0, 0, 0, 1542336828, 1542336828);
INSERT INTO `ks_question` VALUES (882, '舞弊行为的，申请人在多少年内不得再次申领机动车驾驶证？', '根据123号令第六章法律责任的规定：申请人在考试过程中有贿赂、舞弊行为的，取消考试资格，已经通过考试的其他科目成绩无效；申请人在一年内不得再次申领机动车驾驶证。', NULL, 1, '[\"A、2年\",\"B、4年\",\"C、1年\",\"D、3年\"]', 1, '2', 1, 1, 0, 0, 0, 1542336829, 1542336829);
INSERT INTO `ks_question` VALUES (883, '驾驶机动车遇紧急事务，可以边开车边接打电话。', '新修订的《机动车驾驶证申领和使用规定》公布后，2013年1月1日起施行，其中规定：驾驶机动车有拨打、接听手持电话等妨碍安全驾驶的行为的一次记2分。此外，边开车边打电话也会危害人身安全。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336830, 1542336830);
INSERT INTO `ks_question` VALUES (884, '如图所示，驾驶机动车时，前风窗玻璃处悬挂放置干扰视线的物品是错误的。', '悬挂物品干扰开车视线，增大了行车危险，容易引发交通事故。', 'http://file.open.jiakaobaodian.com/tiku/res/1132300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336831, 1542336831);
INSERT INTO `ks_question` VALUES (885, '驾驶机动车下长坡时，仅靠行车制动器制动，容易引起行车制动器失灵。', '汽车制动分为三种：1、行车制动，就是脚下的制动踏板，控制四轮；2、驻车制动，就是手刹车，停车时防止前滑后溜；3、发动机制动，也就是抢档，用于刹车失灵，在行车制动失灵时用，一级一级减档，从高到底，利用发动机变速箱的原理使车速降下来。下长坡时，驾驶员长时间使用行车制动器，易造成制动器热衰退，汽车的制动效能变差。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336832, 1542336832);
INSERT INTO `ks_question` VALUES (886, '如图所示，在环岛交叉路口发生的交通事故中，应由A车负全部责任。', '按照规定，驶入环岛的车辆不能影响环岛内车辆的正常通行。因此A车应让B车先行，而此时事故发生，A车应负全责。', 'http://file.open.jiakaobaodian.com/tiku/res/1132600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336834, 1542336834);
INSERT INTO `ks_question` VALUES (887, '行驶过程中发现车门未关好，应及时关闭车门，否则车辆在转弯等激烈运动过程中会造成人员或货物被甩到车外。', '行车过程中，车门要关紧，否则会增加行车风险。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336835, 1542336835);
INSERT INTO `ks_question` VALUES (888, '驾驶机动车在山路行驶时，为了减少油耗，下坡时可以空挡滑行，并使用行车制动器控制速度。', '下坡时用空档滑行容易烧坏变速器，非常危险，属于交通陋习。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336837, 1542336837);
INSERT INTO `ks_question` VALUES (889, '避让特种车辆使其顺利通过后，车辆应有序回到原车道继续行驶，不要尾随特种车辆，以免发生交通事故。', '特种车辆本身车速较快，而且由于其特殊性，驾驶路线与常规车辆也不同。如果跟随特种车会十分危险，因此避让特种车后，要有序回到原车道继续行驶。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336838, 1542336838);
INSERT INTO `ks_question` VALUES (890, '驾驶机动车行驶过程中，遇道路养护车辆从本车道逆向驶来时，以下做法正确的是什么？', '道路养护车辆有优先权，一定要让行，且要注意正确答案中有“靠边”二字。', NULL, 1, '[\"A、在原车道继续行驶\",\"B、鸣喇叭示意其让道\",\"C、靠边减速或停车让行\",\"D、占用非机动车道行驶\"]', 1, '2', 1, 1, 0, 0, 0, 1542336839, 1542336839);
INSERT INTO `ks_question` VALUES (891, '驾驶机动车由加速车道进入高速公路行驶，以下做法错误的是什么？', '《中华人民共和国道路交通安全法实施条例》第七十八条：高速公路应当标明车道的行驶速度，最高车速不得超过每小时120公里，最低车速不得低于每小时60公里。在高速公路上行驶的小型载客汽车最高车速不得超过每小时120公里，其他机动车不得超过每小时100公里，摩托车不得超过每小时80公里。同方向有2条车道的，左侧车道的最低车速为每小时100公里；同方向有3条以上车道的，最左侧车道的最低车速为每小时110公里，中间车道的最低车速为每小时90公里。因此，驾车进入高速公路后，不能直接驶入最左车道，要循序渐进。', NULL, 1, '[\"A、在加速车道上加速，同时要开启左转向灯\",\"B、经加速车道充分加速后，可直接驶入最左侧车道\",\"C、密切注意左侧行车道的车流状态，同时用后视镜观察后方的情况\",\"D、充分利用加速车道的长度加速，确认安全后，平顺地进入行车道\"]', 1, '1', 1, 1, 0, 0, 0, 1542336840, 1542336840);
INSERT INTO `ks_question` VALUES (892, '驾驶机动车在高速公路上车辆发生故障时，为获得其他车辆的帮助，可将警告标志放置在其他车道。', '应在本车道放置警告标志，且放置距离为：高速公路是150米以外，道路是50-100米；且只能同车道摆放。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336841, 1542336841);
INSERT INTO `ks_question` VALUES (893, '冰雹等低能见度气象条件下，能见度在100米以下时，车速不得超过每小时多少公里，与同车道前车至少保持多少米的距离？', '能见度小于200米时，开启雾灯、近光灯、示廓灯和前后位灯，车速不得超过每小时60公里，与同车道前车保持100米以上的距离；能见度小于100米时，开启雾灯、近光灯、示廓灯、前后位灯和危险报警闪光灯，车速不得超过每小时40公里，与同车道前车保持50米以上的距离；能见度小于50米时，开启雾灯、近光灯、示廓灯、前后位灯和危险报警闪光灯，车速不得超过每小时20公里，并从最近的出口尽快驶离高速公路。', NULL, 1, '[\"A、50，30\",\"B、40，50\",\"C、50，40\",\"D、40，40\"]', 1, '1', 1, 1, 0, 0, 0, 1542336842, 1542336842);
INSERT INTO `ks_question` VALUES (894, '驾驶机动车在高速公路上行驶，能见度小于200米时，与同车道前车应保持100米以上的距离。', '能见度小于200米时，开启雾灯、近光灯、示廓灯和前后位灯，车速不得超过每小时60公里，与同车道前车保持100米以上的距离；能见度小于100米时，开启雾灯、近光灯、示廓灯、前后位灯和危险报警闪光灯，车速不得超过每小时40公里，与同车道前车保持50米以上的距离；能见度小于50米时，开启雾灯、近光灯、示廓灯、前后位灯和危险报警闪光灯，车速不得超过每小时20公里，并从最近的出口尽快驶离高速公路。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336843, 1542336843);
INSERT INTO `ks_question` VALUES (895, '机动车驾驶人有以下哪种违法行为的，暂扣六个月机动车驾驶证？', '饮酒驾驶机动车辆，罚款1000元—2000元、记12分并暂扣驾照6个月；饮酒驾驶营运机动车，罚款5000元，记12分，处以15日以下拘留，并且5年内不得重新获得驾照。醉酒驾驶机动车辆，吊销驾照，5年内不得重新获取驾照，经过判决后处以拘役，并处罚金；醉酒驾驶营运机动车辆，吊销驾照，10年内不得重新获取驾照，终生不得驾驶营运车辆，经过判决后处以拘役，并处罚金。', NULL, 1, '[\"A、饮酒后驾驶机动车的\",\"B、醉酒后驾驶机动车的\",\"C、使用伪造、变造机动车驾驶证的\",\"D、伪造、变造机动车驾驶证的\"]', 1, '0', 1, 1, 0, 0, 0, 1542336844, 1542336844);
INSERT INTO `ks_question` VALUES (896, '饮酒后或者醉酒驾驶机动车发生重大交通事故构成犯罪的，依法追究刑事责任，吊销机动车驾驶证，将多少年内不得申请机动车驾驶证？', '饮酒驾驶机动车辆，罚款1000元—2000元、记12分并暂扣驾照6个月；饮酒驾驶营运机动车，罚款5000元，记12分，处以15日以下拘留，并且5年内不得重新获得驾照。醉酒驾驶机动车辆，吊销驾照，5年内不得重新获取驾照，经过判决后处以拘役，并处罚金；醉酒驾驶营运机动车辆，吊销驾照，10年内不得重新获取驾照，终生不得驾驶营运车辆，经过判决后处以拘役，并处罚金。饮酒后或者醉酒驾驶机动车发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证，终生不得重新取得机动车驾驶证。', NULL, 1, '[\"A、十年\",\"B、五年\",\"C、二十年\",\"D、终生\"]', 1, '3', 1, 1, 0, 0, 0, 1542336845, 1542336845);
INSERT INTO `ks_question` VALUES (897, '驾驶拼装的机动车上道路行驶的，公安机关交通管理部门应当予以收缴，强制报废，并吊销机动车驾驶证。', '驾驶拼装的机动车或者已达到报废标准的机动车上道路行驶的，公安机关交通管理部门应当予以收缴，强制报废。对驾驶前款所列机动车上道路行驶的驾驶人，处二百元以上二千元以下罚款，并吊销机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336847, 1542336847);
INSERT INTO `ks_question` VALUES (898, '机动车驾驶人造成重大交通事故后逃逸，构成犯罪的，十年内不能申请机动车驾驶证。', '《交通法》第一百零一条：违反道路交通安全法律、法规的规定，发生重大交通事故，构成犯罪的，依法追究刑事责任，并由公安机关交通管理部门吊销机动车驾驶证。造成交通事故后逃逸的，由公安机关交通管理部门吊销机动车驾驶证，且终生不得重新取得机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336848, 1542336848);
INSERT INTO `ks_question` VALUES (899, '驾驶机动车造成交通事故后逃逸，尚不构成犯罪的，由公安机关交通管理部门处二百元以上二千元以下罚款，可以并处15日以下拘留。', '造成交通事故后逃逸，尚不构成犯罪的由公安机关交通管理部门处二百元以上二千元以下罚款,可以并处15日以下拘留。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336849, 1542336849);
INSERT INTO `ks_question` VALUES (900, '机动车驾驶人一次有两个以上违法行为记分的，应当分别计算累加分值。', '《机动车驾驶证申领和使用规定》第五十六条：对机动车驾驶人的道路交通安全违法行为，处罚与记分同时执行。机动车驾驶人一次有两个以上违法行为记分的，应当分别计算，累加分值。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336850, 1542336850);
INSERT INTO `ks_question` VALUES (901, '隐瞒有关情况或者提供虚假材料申领机动车驾驶证的，申请人在1年内不得再次申领机动车驾驶证。', '《机动车驾驶证申领和使用规定》第七十八条：隐瞒有关情况或者提供虚假材料申领机动车驾驶证的，申请人在一年内不得再次申领机动车驾驶证。申请人在考试过程中有贿赂、舞弊行为的，取消考试资格，已经通过考试的其他科目成绩无效；申请人在一年内不得再次申领机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336851, 1542336851);
INSERT INTO `ks_question` VALUES (902, '驾驶机动车下长坡时，空挡滑行会导致再次挂挡困难。', '驾驶机动车下长坡时，空挡滑行会导致再次挂挡困难。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336852, 1542336852);
INSERT INTO `ks_question` VALUES (903, '驾驶机动车超车时，被超越车辆未减速让路，应迅速提速超越前方车辆完成超车。', '驾驶机动车超车时，被超越车辆未减速让路，应停止超车。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336853, 1542336853);
INSERT INTO `ks_question` VALUES (904, '工程救险车执行紧急任务时，耽误或影响其通行可能会导致严重后果，所以其他车辆和行人应当主动让行。', '警车、消防车、救护车、工程救险车执行紧急任务时，耽误或影响其通行可能会导致严重后果，所以其他车辆和行人应当主动让行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336855, 1542336855);
INSERT INTO `ks_question` VALUES (905, '驾驶机动车在高速公路上车辆发生故障时，若车辆可以移动至应急车道内，只需开启危险报警闪光灯，警告标志可根据交通流情况选择是否放置。', '驾驶机动车在高速公路上车辆发生故障时，若车辆可以移动至应急车道内，应开启危险报警闪光灯，放置警告标志。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336856, 1542336856);
INSERT INTO `ks_question` VALUES (906, '将机动车交由未取得机动车驾驶证的人驾驶的，由公安交通管理部门处二百元以上二千元以下罚款，可以并处以下哪种处罚？', '将机动车交由未取得机动车驾驶证的人驾驶的，由公安交通管理部门处二百元以上二千元以下罚款，并处以吊销驾驶证的处罚。', NULL, 1, '[\"A、吊销驾驶证\",\"B、15日以下拘留\",\"C、5年不得重新取得新驾驶证\",\"D、扣留车辆\"]', 1, '0', 1, 1, 0, 0, 0, 1542336857, 1542336857);
INSERT INTO `ks_question` VALUES (907, '申请人以不正当手段取得机动车驾驶证的，公安机关交通管理部门收缴机动车驾驶证，撤销机动车驾驶许可，申请人在3年内不得再次申领机动车驾驶证。', '《中华人民共和国道路运输条例》说明，申请人以不正当手段取得机动车驾驶证的，公安机关交通管理部门收缴机动车驾驶证，撤销机动车驾驶许可，申请人在3年内不得再次申领机动车驾驶证。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336858, 1542336858);
INSERT INTO `ks_question` VALUES (908, '遇后车超车时，在条件许可的情况下应减速靠右让路，是为了给后车留出超车空间。', '遇后车超车，可减速靠右避让。安全驾驶，礼貌让行。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336859, 1542336859);
INSERT INTO `ks_question` VALUES (909, '这个仪表是何含义？', '上面有转速单位：x1000r/min，指针指示的数字乘以一千就是当时的转速。', 'http://file.open.jiakaobaodian.com/tiku/res/886400.jpg', 1, '[\"A、百公里油耗表\",\"B、行驶速度表\",\"C、发动机转速表\",\"D、区间里程表\"]', 1, '2', 1, 1, 4, 0, 0, 1542336860, 1542336860);
INSERT INTO `ks_question` VALUES (910, '仪表显示当前车速是20公里/小时。', '图显示的单位是 1/min×1000，意思是每一分钟（注意是分钟）1000转。转速指针为2，即2000转每分钟。而车速还要根据车轮大小来确定。【2×车轮半径×3.14（圆周率）】车轮周长×转速。此图，应该是转速标示图。', 'http://file.open.jiakaobaodian.com/tiku/res/886800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336865, 1542336865);
INSERT INTO `ks_question` VALUES (911, '仪表显示当前发动机转速是6000转/分钟。', '题目中仪表中有KM，这是速度和里程表，表示当前汽车的行驶速度是60公里/小时。', 'http://file.open.jiakaobaodian.com/tiku/res/886900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336866, 1542336866);
INSERT INTO `ks_question` VALUES (912, '仪表显示当前冷却液的温度是90度。', '此仪表盘温度表示的是冷却液的温度。', 'http://file.open.jiakaobaodian.com/tiku/res/887000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336867, 1542336867);
INSERT INTO `ks_question` VALUES (913, '仪表显示油箱内存油量已在警告线以内。', '正确，此时应及时补充燃油。看到加油站那个加油的机器没，而且指针都到红色区了，说明油量不足了。', 'http://file.open.jiakaobaodian.com/tiku/res/887100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336868, 1542336868);
INSERT INTO `ks_question` VALUES (914, '机动车仪表板上（如图所示）亮表示什么？', '前雾灯绿色光朝左，后雾灯黄色光朝右。', 'http://file.open.jiakaobaodian.com/tiku/res/887200.jpg', 1, '[\"A、前照灯近光打开\",\"B、前雾灯打开\",\"C、后雾灯打开\",\"D、前照灯远光打开\"]', 1, '1', 1, 1, 4, 0, 0, 1542336869, 1542336869);
INSERT INTO `ks_question` VALUES (915, '打开前雾灯开关，（如图所示）亮起。', '绿光在左是前雾灯，黄光在右是后雾灯。图中是后雾灯。', 'http://file.open.jiakaobaodian.com/tiku/res/887500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336873, 1542336873);
INSERT INTO `ks_question` VALUES (916, '打开后雾灯开关，（如图所示）亮起。', '绿光在左是前雾灯，黄光在右是后雾灯。图中是前雾灯。', 'http://file.open.jiakaobaodian.com/tiku/res/887600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336874, 1542336874);
INSERT INTO `ks_question` VALUES (917, '打开位置灯开关，（如图所示）亮起。', '该指示灯是用来显示车辆示宽灯的工作状态，平时为熄灭状态，当示宽灯打开时，该指示灯随即点亮。当示宽灯关闭或者关闭示宽灯打开大灯时，该指示灯自动熄灭。', 'http://file.open.jiakaobaodian.com/tiku/res/887700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336875, 1542336875);
INSERT INTO `ks_question` VALUES (918, '发动机起动后仪表板上（如图所示）亮表示什么？', '像茶壶一样的就是机油的标志，各位记住就是啦。该指示灯用来显示发动机内机油的压力状况。打开钥匙门，车辆开始自检时，指示灯点亮，启动后熄灭。该指示灯常亮，说明该车发动机机油压力低于规定标准，需要维修。', 'http://file.open.jiakaobaodian.com/tiku/res/887800.jpg', 1, '[\"A、发动机曲轴箱漏气\",\"B、发动机机油压力过高\",\"C、发动机机油压力过低\",\"D、发动机主油道堵塞\"]', 1, '2', 1, 1, 4, 0, 0, 1542336876, 1542336876);
INSERT INTO `ks_question` VALUES (919, '机动车仪表板上（如图所示）亮表示发动机可能机油量不足。', '图中的标志是机油的标志。 该指示灯用来显示发动机内机油的压力状况，该指示灯常亮，说明该车发动机机油压力低于规定标准，需要维修。题目问的是灯亮的原因，而机油量不足是可能的原因，所以选择正确。', 'http://file.open.jiakaobaodian.com/tiku/res/887900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336878, 1542336878);
INSERT INTO `ks_question` VALUES (920, '机动车仪表板上（如图所示）亮表示发动机可能机油压力过高。', '图中的标志是机油的标志。 该指示灯用来显示发动机内机油的压力状况，该指示灯常亮，说明该车发动机机油压力低于规定标准，需要维修。', 'http://file.open.jiakaobaodian.com/tiku/res/888000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336879, 1542336879);
INSERT INTO `ks_question` VALUES (921, '机动车仪表板上（如图所示）亮，表示驻车制动器操纵杆可能没松到底。', '此题描述错误。这个标志为制动系统出现故障标志，出现这个标志应停车检查，待故障排除后再上路行驶。这个中间是个“!”的，且字中间是红色的表示制动系统出现异常;这个中间要是个“P”的，表示驻车制动器制动状态。', 'http://file.open.jiakaobaodian.com/tiku/res/888400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336883, 1542336883);
INSERT INTO `ks_question` VALUES (922, '机动车仪表板上（如图所示）亮，表示行车制动系统可能出现故障。', '圆圈里面是“P” 表示驻车制动器处于制动状态，车辆没有发生故障。 里面是“！” 表示制动系统异常或故障。', 'http://file.open.jiakaobaodian.com/tiku/res/888500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336884, 1542336884);
INSERT INTO `ks_question` VALUES (923, '机动车仪表板上（如图所示）亮时，不影响正常行驶。', '制动报警灯是驻车制动器及系统故障指示灯。驻车制动器操纵杆拉起时，指示灯亮，颜色为红色;松开后，指示灯熄灭。行车途中该灯亮起，表示制动系统出了问题或故障，不能上路。', 'http://file.open.jiakaobaodian.com/tiku/res/888600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336885, 1542336885);
INSERT INTO `ks_question` VALUES (924, '机动车仪表板上（如图所示）亮时，防抱死制动系统处于打开状态。', '防抱死制动系统出现故障标志，出现此标志，应停车检查防抱死系统。', 'http://file.open.jiakaobaodian.com/tiku/res/888700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336886, 1542336886);
INSERT INTO `ks_question` VALUES (925, '机动车仪表板上（如图所示）亮时，表示驻车制动器处于制动状态。', '圆圈里面是“P” 表示驻车制动器处于制动状态，即手刹没松开，但是车辆没有发生故障。 里面是“！” 表示制动系统异常或故障。', 'http://file.open.jiakaobaodian.com/tiku/res/888800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336888, 1542336888);
INSERT INTO `ks_question` VALUES (926, '机动车仪表板上（如图所示）亮时，提醒发动机需要补充机油。', '燃油箱油量达到最低液面，此标志亮起，需要及时补充燃油。不是机油不足，是汽油不足。', 'http://file.open.jiakaobaodian.com/tiku/res/889000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336890, 1542336890);
INSERT INTO `ks_question` VALUES (927, '行车中仪表板上（如图所示）亮表示什么？', '此标志亮起说明发动机水温过高，可能是冷却液不足引起的。', 'http://file.open.jiakaobaodian.com/tiku/res/889100.jpg', 1, '[\"A、发动机温度过高\",\"B、发动机冷却系故障\",\"C、发动机润滑系故障\",\"D、发动机温度过低\"]', 1, '0', 1, 1, 4, 0, 0, 1542336891, 1542336891);
INSERT INTO `ks_question` VALUES (928, '机动车仪表板上（如图所示）亮时，提醒发动机冷却液可能不足。', '此标志亮起说明发动机水温过高，可能是冷却液不足引起的。', 'http://file.open.jiakaobaodian.com/tiku/res/889200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336892, 1542336892);
INSERT INTO `ks_question` VALUES (929, '机动车仪表板上（如图所示）亮时提醒发动机需要加注机油。', '此标志亮起说明发动机水温过高，可能是冷却液不足引起的。', 'http://file.open.jiakaobaodian.com/tiku/res/889300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336893, 1542336893);
INSERT INTO `ks_question` VALUES (930, '机动车仪表板上（如图所示）亮时表示什么？', '光束直射，蓝色向左是远光。', 'http://file.open.jiakaobaodian.com/tiku/res/889400.jpg', 1, '[\"A、已开启前雾灯\",\"B、已开启后雾灯\",\"C、已开启前照灯近光\",\"D、已开启前照灯远光\"]', 1, '3', 1, 1, 4, 0, 0, 1542336894, 1542336894);
INSERT INTO `ks_question` VALUES (931, '开启前照灯远光时仪表板上（如图所示）亮起。', '光束直射蓝色向左是远光；光束向下绿色在左是近光。此标志是前照灯近光。', 'http://file.open.jiakaobaodian.com/tiku/res/889600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336896, 1542336896);
INSERT INTO `ks_question` VALUES (932, '开启前照灯近光时仪表板上（如图所示）亮起。', '光束直射蓝色向左是远光；光束向下绿色在左是近光。此标志为远光。', 'http://file.open.jiakaobaodian.com/tiku/res/889700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336897, 1542336897);
INSERT INTO `ks_question` VALUES (933, '机动车仪表板上（如图所示）亮时，提醒驾驶人座椅没调整好。', '该指示灯用来显示安全带是否处于锁止状态，当该灯点亮时，说明安全带没有及时的扣紧。有些车型会有相应的提示音。当安全带被及时扣紧后，该指示灯自动熄灭。', 'http://file.open.jiakaobaodian.com/tiku/res/889900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336900, 1542336900);
INSERT INTO `ks_question` VALUES (934, '机动车仪表板上（如图所示）亮时，提醒驾驶人安全带插头未插入锁扣。', '该指示灯用来显示安全带是否处于锁止状态，当该灯点亮时，说明安全带没有及时的扣紧。有些车型会有相应的提示音。当安全带被及时扣紧后，该指示灯自动熄灭。', 'http://file.open.jiakaobaodian.com/tiku/res/890000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336901, 1542336901);
INSERT INTO `ks_question` VALUES (935, '危险报警闪光灯可用于下列什么场合？', '机动车发生故障停车时，需要开启危险报警闪光灯。危险报警闪光灯是一种提醒其他车辆与行人注意本车发生了特殊情况的信号灯。', NULL, 1, '[\"A、引领后车行驶时\",\"B、机动车发生故障停车时\",\"C、遇到道路拥堵时\",\"D、在道路上跟车行驶时\"]', 1, '1', 1, 1, 0, 0, 0, 1542336902, 1542336902);
INSERT INTO `ks_question` VALUES (936, '机动车发生故障时，（如图所示）闪烁。', '题上说的是机动车发生故障闪烁，也就是机动车自身的报警指示灯。此灯是机动车发生故障以后，人为开启的警示灯。所以本题“错误”。', 'http://file.open.jiakaobaodian.com/tiku/res/890300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336904, 1542336904);
INSERT INTO `ks_question` VALUES (937, '开启危险报警闪光灯时，（如图所示）闪烁。', '危险报警闪光灯，通常称为“双蹦”(红三角里有个!的标志按扭开关，俗称双闪灯或双跳灯)，是一种提醒其他车辆与行人注意本车发生了特殊情况的信号灯。', 'http://file.open.jiakaobaodian.com/tiku/res/890400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336905, 1542336905);
INSERT INTO `ks_question` VALUES (938, '打开左转向灯开关，（如图所示）亮起。', '开启右转向灯，此标志亮起。', 'http://file.open.jiakaobaodian.com/tiku/res/890700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336909, 1542336909);
INSERT INTO `ks_question` VALUES (939, '打开右转向灯开关，（如图所示）亮起。', '开启左转向灯，此标志亮起。', 'http://file.open.jiakaobaodian.com/tiku/res/890800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336910, 1542336910);
INSERT INTO `ks_question` VALUES (940, '机动车仪表板上（如图所示）这个符号表示什么？', '一般车型，前盖为发动机舱，后边为行李舱。', 'http://file.open.jiakaobaodian.com/tiku/res/891100.jpg', 1, '[\"A、一侧车门开启\",\"B、燃油箱盖开启\",\"C、行李舱开启\",\"D、发动机舱开启\"]', 1, '2', 1, 1, 4, 0, 0, 1542336913, 1542336913);
INSERT INTO `ks_question` VALUES (941, '机动车仪表板上（如图所示）一直亮表示什么？', '圆球表示安全气囊，黄色表示处于故障状态。', 'http://file.open.jiakaobaodian.com/tiku/res/891300.jpg', 1, '[\"A、防抱死制动系统故障\",\"B、安全带没有系好\",\"C、安全气囊处于故障状态\",\"D、安全气囊处于工作状态\"]', 1, '2', 1, 1, 4, 0, 0, 1542336915, 1542336915);
INSERT INTO `ks_question` VALUES (942, '（如图所示）这个符号的开关控制什么装置？', '此为前风窗玻璃刮水器。关于如何区分前风窗玻璃刮水器及洗涤器和后风窗玻璃刮水器及洗涤器，你只需记住一点半弧形的图标是前风窗，四四方方的图标就是后风窗。', 'http://file.open.jiakaobaodian.com/tiku/res/892000.jpg', 1, '[\"A、后风窗玻璃刮水器\",\"B、后风窗玻璃除霜\",\"C、前风窗玻璃除霜\",\"D、前风窗玻璃刮水器\"]', 1, '3', 1, 1, 4, 0, 0, 1542336923, 1542336923);
INSERT INTO `ks_question` VALUES (943, '机动车仪表板上（如图所示）亮，提示发电机向蓄电池充电。', '此标志为充电电路故障。', 'http://file.open.jiakaobaodian.com/tiku/res/892600.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336930, 1542336930);
INSERT INTO `ks_question` VALUES (944, '机动车仪表板上（如图所示）亮，提示两侧车门未关闭。', '看标志两侧的门是打开的状态，如果该灯亮了，就是提醒司机车门是打开的状态。', 'http://file.open.jiakaobaodian.com/tiku/res/892700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336931, 1542336931);
INSERT INTO `ks_question` VALUES (945, '机动车仪表板上（如图所示）亮，提示左侧车门未关闭。', '很明显是右侧车门未关闭。', 'http://file.open.jiakaobaodian.com/tiku/res/892800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336932, 1542336932);
INSERT INTO `ks_question` VALUES (946, '机动车仪表板上（如图所示）亮，提示右侧车门未关闭。', '很明显是左侧车门未关闭。', 'http://file.open.jiakaobaodian.com/tiku/res/892900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336933, 1542336933);
INSERT INTO `ks_question` VALUES (947, '机动车仪表板上（如图所示）亮，提示行李舱开启。', '前面是发动机舱，后面是行李舱。此标志亮起是发动机舱开启。', 'http://file.open.jiakaobaodian.com/tiku/res/893000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336934, 1542336934);
INSERT INTO `ks_question` VALUES (948, '机动车仪表板上（如图所示）亮，提示发动机舱开启。', '前面是发动机舱，后面是行李舱。此标志亮起是行李舱开启。', 'http://file.open.jiakaobaodian.com/tiku/res/893100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336935, 1542336935);
INSERT INTO `ks_question` VALUES (949, '机动车仪表板上（如图所示）一直亮，表示安全气囊处于工作状态。', '此标志亮表示安全气囊现在处于故障状态。', 'http://file.open.jiakaobaodian.com/tiku/res/893200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336936, 1542336936);
INSERT INTO `ks_question` VALUES (950, '机动车仪表板上（如图所示）亮表示启用地板及前风窗玻璃吹风。', '扇型的是前风窗，曲线向上表示前风窗玻璃吹风。箭头向下是地板出风。所以本题是对的。', 'http://file.open.jiakaobaodian.com/tiku/res/893300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336937, 1542336937);
INSERT INTO `ks_question` VALUES (951, '机动车仪表板上（如图所示）一直亮，表示发动机控制系统故障。', '发动机控制系统故障，此标志亮起。', 'http://file.open.jiakaobaodian.com/tiku/res/893400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336938, 1542336938);
INSERT INTO `ks_question` VALUES (952, '这种握转向盘的动作是正确的。', '题中的握法是驾驶的陋习，是有很大的风险的。正确的握法是握住方向盘的9点和3点钟方向。', 'http://file.open.jiakaobaodian.com/tiku/res/893500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336940, 1542336940);
INSERT INTO `ks_question` VALUES (953, '这是什么踏板？', '左边是离合踏板，中间是制动踏板，右边是加速踏板。图中的是离合踏板。', 'http://file.open.jiakaobaodian.com/tiku/res/893600.jpg', 1, '[\"A、驻车制动器\",\"B、离合器踏板\",\"C、加速踏板\",\"D、制动踏板\"]', 1, '1', 1, 1, 4, 0, 0, 1542336941, 1542336941);
INSERT INTO `ks_question` VALUES (954, '这是什么操纵装置？', '此黑色柄顶端有相应的档位1-5档以及R档，所以是变速器操纵杆。', 'http://file.open.jiakaobaodian.com/tiku/res/893900.jpg', 1, '[\"A、驻车制动器操纵杆\",\"B、离合器操纵杆\",\"C、变速器操纵杆\",\"D、节气门操纵杆\"]', 1, '2', 1, 1, 4, 0, 0, 1542336944, 1542336944);
INSERT INTO `ks_question` VALUES (955, '将点火开关转到ACC位置起动机工作。', '图中为点火开关，点火开关4个档位的功能是：LOCK：切断电源，锁定方向盘；ACC：接通附件电源（比如收音机等附件）ON：接通除起动机外的全车全部电源；START：接通起动机电源，起动发动机。', 'http://file.open.jiakaobaodian.com/tiku/res/894200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336947, 1542336947);
INSERT INTO `ks_question` VALUES (956, '点火开关在ON位置，车用电器不能使用。', '图中为点火开关，点火开关4个档位的功能是：LOCK：切断电源，锁定方向盘；ACC：接通附件电源（比如收音机等附件）ON：接通除起动机外的全车全部电源；START：接通起动机电源，起动发动机。', 'http://file.open.jiakaobaodian.com/tiku/res/894300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336949, 1542336949);
INSERT INTO `ks_question` VALUES (957, '点火开关在LOCK位置拔出钥匙转向盘会锁住。', '图中为点火开关，点火开关4个档位的功能是：LOCK：切断电源，锁定方向盘；ACC：接通附件电源（比如收音机等附件）ON：接通除起动机外的全车全部电源；START：接通起动机电源，起动发动机。', 'http://file.open.jiakaobaodian.com/tiku/res/894400.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336950, 1542336950);
INSERT INTO `ks_question` VALUES (958, '点火开关在START位置起动机起动。', '图中为点火开关，点火开关4个档位的功能是：LOCK：切断电源，锁定方向盘；ACC：接通附件电源（比如收音机等附件）ON：接通除起动机外的全车全部电源；START：接通起动机电源，起动发动机。', 'http://file.open.jiakaobaodian.com/tiku/res/894500.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336951, 1542336951);
INSERT INTO `ks_question` VALUES (959, '提拉这个开关控制机动车哪个部位？', '此开关控制左右转向灯。顺便回忆一下转向灯操作：上右下左。', 'http://file.open.jiakaobaodian.com/tiku/res/894700.jpg', 1, '[\"A、倒车灯\",\"B、示廓灯\",\"C、报警闪光灯\",\"D、左右转向灯\"]', 1, '3', 1, 1, 4, 0, 0, 1542336953, 1542336953);
INSERT INTO `ks_question` VALUES (960, '旋转开关这一档控制机动车哪个部位？', '此处为雾灯的控制。顺便回忆一下，哪个控制前雾灯，哪个控制后雾灯。下边的控制前雾灯，上边的控制后雾灯。', 'http://file.open.jiakaobaodian.com/tiku/res/894800.jpg', 1, '[\"A、前后雾灯\",\"B、远光灯\",\"C、左右转向灯\",\"D、近光灯\"]', 1, '0', 1, 1, 4, 0, 0, 1542336954, 1542336954);
INSERT INTO `ks_question` VALUES (961, '将转向灯开关向上提，左转向灯亮。', '上提是右转向灯亮起，下压是左转向灯。', 'http://file.open.jiakaobaodian.com/tiku/res/894900.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336955, 1542336955);
INSERT INTO `ks_question` VALUES (962, '将转向灯开关向下拉，右转向灯亮。', '上提是右转向灯亮起，下压是左转向灯。', 'http://file.open.jiakaobaodian.com/tiku/res/895000.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336956, 1542336956);
INSERT INTO `ks_question` VALUES (963, '灯光开关旋转到这个位置时，全车灯光点亮。', '扭到这一档是前后位置灯点亮。', 'http://file.open.jiakaobaodian.com/tiku/res/895100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336957, 1542336957);
INSERT INTO `ks_question` VALUES (964, '灯光开关在该位置时，前雾灯点亮。', '方向向左是前雾灯，方向向右是后雾灯，注意操纵杆上白色指标对着什么位置，这样旋转会拧至后雾灯位置。', 'http://file.open.jiakaobaodian.com/tiku/res/895200.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336959, 1542336959);
INSERT INTO `ks_question` VALUES (965, '灯光开关在该位置时，后雾灯点亮。', '方向向左是前雾灯，方向向右是后雾灯，这样旋转会拧至后雾灯位置。', 'http://file.open.jiakaobaodian.com/tiku/res/895300.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336960, 1542336960);
INSERT INTO `ks_question` VALUES (966, '这个开关控制机动车哪个部位？', '这个控制风窗玻璃刮水器。风窗玻璃除雾器和危险报警闪光灯都是按钮形式的，照明、信号装置在方向盘左侧。', 'http://file.open.jiakaobaodian.com/tiku/res/895600.jpg', 1, '[\"A、照明、信号装置\",\"B、风窗玻璃刮水器\",\"C、危险报警闪光灯\",\"D、风窗玻璃除雾器\"]', 1, '1', 1, 1, 4, 0, 0, 1542336963, 1542336963);
INSERT INTO `ks_question` VALUES (967, '按下这个开关，后风窗玻璃除霜器开始工作。', '弯曲的箭头表示雾气，扇形的是前风窗，矩形的是后风窗，这个开关控制前风窗玻璃除霜器。', 'http://file.open.jiakaobaodian.com/tiku/res/895700.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 4, 0, 0, 1542336964, 1542336964);
INSERT INTO `ks_question` VALUES (968, '上下扳动这个开关前风窗玻璃刮水器开始工作。', '正确。风窗玻璃刮水器开关，控制刮水器的操作装置，大多安装在方向盘右下方转向柱上，用右手操纵，将开关手柄向下拉或向上推，可选择不同的刮刷挡位。', 'http://file.open.jiakaobaodian.com/tiku/res/895800.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542336965, 1542336965);
INSERT INTO `ks_question` VALUES (969, '安全头枕在发生追尾事故时，能有效保护驾驶人的什么部位？', '发生追尾时，因为有头枕，脖子不会因为冲击力过大而扭伤或者伤及颈椎。', NULL, 1, '[\"A、颈部\",\"B、腰部\",\"C、胸部\",\"D、头部\"]', 1, '0', 1, 1, 0, 0, 0, 1542336966, 1542336966);
INSERT INTO `ks_question` VALUES (970, '安全头枕用于在发生追尾事故时保护驾驶人的头部不受伤害。', '发生追尾时，因为有头枕，脖子不会因为冲击力过大而扭伤或者伤及颈椎。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336967, 1542336967);
INSERT INTO `ks_question` VALUES (971, '机动车发生碰撞时座椅安全带主要作用是什么？', '安全带在紧急情况下，可迅速拉紧，把人束缚在座椅上，防止人因惯性摔出去，减轻驾乘人员伤害。', NULL, 1, '[\"A、保护驾乘人员腰部\",\"B、减轻驾乘人员伤害\",\"C、保护驾乘人员胸部\",\"D、保护驾乘人员颈部\"]', 1, '1', 1, 1, 0, 0, 0, 1542336969, 1542336969);
INSERT INTO `ks_question` VALUES (972, '机动车发生正面碰撞时，安全气囊加上安全带的双重保护才能充分发挥作用。', '研究表明，假设气囊加安全带是100%安全的话，安全带的作用是70%，气囊的作用是30%。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336970, 1542336970);
INSERT INTO `ks_question` VALUES (973, '机动车在发生碰撞时，安全带可以减轻驾乘人员伤害。', '安全带在紧急情况下，可迅速拉紧，把人束缚在座椅上，防止人因惯性摔出去，减轻驾乘人员伤害。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336971, 1542336971);
INSERT INTO `ks_question` VALUES (974, '机动车在紧急制动时ABS系统会起到什么作用？', 'ABS中文译为“防抱死刹车系统”，它是一种具有防滑、防锁死等优点的安全刹车控制系统。可以避免在紧急刹车时方向失控及车轮侧滑，使车轮在刹车时不被锁死，轮胎不在一个点上与地面摩擦，加大摩擦力，使刹车效率达到90％以上。', 'http://file.open.jiakaobaodian.com/tiku/res/896400.jpg', 1, '[\"A、切断动力输出\",\"B、自动控制方向\",\"C、减轻制动惯性\",\"D、防止车轮抱死\"]', 1, '3', 1, 1, 4, 0, 0, 1542336972, 1542336972);
INSERT INTO `ks_question` VALUES (975, '防抱死制动系统（ABS）在什么情况下可以最大限度发挥制动器效能？', '机动车紧急制动时，防抱死制动系统在提供最大制动力的同时能使车前轮保持转向能力。ABS是防抱死系统，就是保证在紧急制动时车轮不会抱死，也就是紧急制动时保持转向能力。ABS防抱死系统是一种具有防滑、防锁死等优点的安全刹车控制系统。没有安装ABS系统的车，在遇到紧急情况时，来不及分布缓刹，只能一脚踩死。这时车轮容易抱死，加之车辆冲刺惯性，便可能发生侧滑、跑偏、方向不受控制等危险状况。而装有ABS的车，当车轮即将到达下一个锁死点时，刹车在一秒内可作用60-120次，相当于不停地刹车、放松，即相当于机械的“点刹”。因此，可以避免在紧急刹车时方向失控及车轮侧滑，使车轮在刹车时不被锁死，轮胎不在一个点上与地面摩擦，加大摩擦力，使刹车效率达到90%以上。', NULL, 1, '[\"A、缓踏制动踏板\",\"B、间歇制动\",\"C、持续制动\",\"D、紧急制动\"]', 1, '3', 1, 1, 0, 0, 0, 1542336973, 1542336973);
INSERT INTO `ks_question` VALUES (976, '机动车紧急制动时，ABS系统在提供最大制动力的同时能使车前轮保持转向能力。', 'ABS系统是“防抱死刹车系统”，也就是防止抱死车轮，没有抱死轮胎就是具有转向能力。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336974, 1542336974);
INSERT INTO `ks_question` VALUES (977, '装有ABS系统的机动车在冰雪路面上会最大限度缩短制动距离。', '安装防抱死系统的车辆保证车辆在急刹车时不会发生失控现象。但不是所有路况下制动都会缩短制动距离，如冰雪、潮湿路面。在冰雪路面紧急制动可能会出现轮胎抱死，当ABS发现有轮胎抱死后，会松开刹车，然后再刹再松，直到车停下。制动距离会增长。本题描述错误。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336975, 1542336975);
INSERT INTO `ks_question` VALUES (978, '驾驶有ABS系统的机动车在紧急制动的同时转向可能会发生侧滑。', '理论版本：ABS使汽车在紧急刹车时车轮不会抱死，这样就能使汽车在紧急制动时仍能保持好的方向稳定性。由于四轮防抱死制动系统保留着控制转向的能力，因此，在制动过程中有可能绕过障碍物，避免可能发生的事故。然而，驾驶有ABS系统的机动车在紧急制动的【同时】转向时是【可能会】发生侧滑的。通俗易懂版：因为安装ABS系统的车在踩刹车的时候方向还能动不会抱死 所以你要是多打方向当然可能会侧滑。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336976, 1542336976);
INSERT INTO `ks_question` VALUES (979, '安装防抱死制动装置（ABS）的机动车紧急制动时，可用力踏制动踏板。', 'ABS系统在紧急制动时能发挥最大的效能，用力踩制动踏板是对的。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542336978, 1542336978);
INSERT INTO `ks_question` VALUES (980, '安装防抱死制动装置（ABS）的机动车制动时，制动距离会大大缩短，因此不必保持安全车距。', '这种错误认识是由于不了解ABS的工作原理导致的。安装防抱死系统的车辆保证车辆在急刹车时不会发生失控现象。但不是所有路况下制动都会缩短制动距离，如冰雪、潮湿路面。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542336979, 1542336979);
INSERT INTO `ks_question` VALUES (981, '安全气囊是一种什么装置？', '安全气囊，设置在车内前方（正副驾驶位），侧方（车内前排和后排）和车顶三个方向。装有安全气囊系统的容器外部都印有SupplementalInflatableRestraintSystem，简称SRS)的字样，直译成中文为“辅助可充气约束系统”。旨在减轻乘员的伤害程度，当发生碰撞事故时，避免乘员发生二次碰撞，或车辆发生翻滚等危险情况下被抛离座位。', NULL, 1, '[\"A、防抱死制动系统\",\"B、电子制动力分配系统\",\"C、驾驶人头颈保护系统\",\"D、辅助驾乘人员保护系统\"]', 1, '3', 1, 1, 0, 0, 0, 1542336980, 1542336980);
INSERT INTO `ks_question` VALUES (982, '正面安全气囊与什么配合才能充分发挥保护作用？', '研究表明，假设气囊加安全带是100%安全的话，安全带的作用是70%，气囊的作用是30%。', 'http://file.open.jiakaobaodian.com/tiku/res/897200.jpg', 1, '[\"A、座椅安全带\",\"B、安全玻璃\",\"C、防抱死制动系统\",\"D、座椅安全头枕\"]', 1, '0', 1, 1, 4, 0, 0, 1542336981, 1542336981);
INSERT INTO `ks_question` VALUES (983, '下列哪个指示灯亮表示车辆在使用近光灯。', '9a：示廓灯；9b：前后雾灯；9c：近光灯；9d：制动系统出现异常或者故障。', 'http://file.open.jiakaobaodian.com/tiku/res/1102000.jpg', 1, '[\"A、9c\",\"B、9d\",\"C、9a\",\"D、9b\"]', 1, '0', 1, 1, 4, 0, 0, 1542336982, 1542336982);
INSERT INTO `ks_question` VALUES (984, '下列哪个指示灯亮表示车辆在使用远光灯？', '10a：车灯总开关；10b：前后雾灯；10c：驻车制动器处于制动状态；10d：远光灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1102100.jpg', 1, '[\"A、10a\",\"B、10d\",\"C、10b\",\"D、10c\"]', 1, '1', 1, 1, 4, 0, 0, 1542336984, 1542336984);
INSERT INTO `ks_question` VALUES (985, '湿滑路面制动过程中，发现车辆偏离方向，以下做法正确的是？', '这个情况下，立即踏制动踏板容易引起侧翻。如后轮一直被刹住的情况下，不松开踏板，汽车会出现甩尾现象；如前轮一直被刹住的情况下不松开踏板，汽车会出现方向失去控制。正确的做法是先握紧方向盘，不要紧急踩刹车。', NULL, 1, '[\"A、不要踩制动踏板\",\"B、用力踩制动踏板\",\"C、任意踩制动踏板\",\"D、连续轻踩轻放制动踏板\"]', 1, '0', 1, 1, 0, 0, 0, 1542336985, 1542336985);
INSERT INTO `ks_question` VALUES (986, '假如你驾车行驶在颠簸路段时，以下做法正确的是什么？', '缓抬加速踏板是为了低速平稳通过颠簸路段，让车辆怠速前进；挂低挡是为了获得更多的发动机牵引力。', NULL, 1, '[\"A、挂低挡档位缓抬加速踏板\",\"B、挂高挡位缓抬加速踏板\",\"C、挂低挡位踏满加速踏板\",\"D、稳住加速踏板\"]', 1, '0', 1, 1, 0, 0, 0, 1542336986, 1542336986);
INSERT INTO `ks_question` VALUES (987, '行驶至这种上坡路段时，以下做法正确的是什么？', '图片中这样的陡坡，挂低挡是为了获得更多的发动机牵引力，如果松开加速踏板，会导致发动机失去动力造成车辆溜坡。', 'http://file.open.jiakaobaodian.com/tiku/res/1160800.jpg', 1, '[\"A、换高挡位，踏加速踏板\",\"B、换低挡位，松开加速踏板\",\"C、换低挡位，踏加速踏板\",\"D、换高挡位，松开加速踏板\"]', 1, '2', 1, 1, 4, 0, 0, 1542336987, 1542336987);
INSERT INTO `ks_question` VALUES (988, '长下坡禁止挂空挡，下列原因错误的是？', '电喷车是指装备电子控制燃油喷射系统的车辆。对于电喷车，下坡挂空挡并不能使油耗下降，反而会失去发动机制动能力。', NULL, 1, '[\"A、下坡挂空挡，油耗容易增多\",\"B、长下坡挂低速挡可以借助发动机控制车速\",\"C、避免因刹车失灵发生危险\",\"D、长下坡空挡滑行导致车速过高时，难以抢挂低速档控制车速\"]', 1, '0', 1, 1, 0, 0, 0, 1542336988, 1542336988);
INSERT INTO `ks_question` VALUES (989, '驾驶机动车下陡坡时，以下说法正确的是？', '空挡会让车失去发动机制动能力，熄火会让刹车和转向失灵。', NULL, 1, '[\"A、可以熄火\",\"B、不准空挡或熄火\",\"C、可以空挡\",\"D、可以空挡但不准熄火\"]', 1, '1', 1, 1, 0, 0, 0, 1542336989, 1542336989);
INSERT INTO `ks_question` VALUES (990, '下面哪种做法能帮助您避免被其他车辆从后方追撞？', '其它三个选项，都不能给其它车辆明确的信号提示。', NULL, 1, '[\"A、在转弯前提前打开相应的转向灯\",\"B、在任何时候都打开转向灯\",\"C、一直打开双闪\",\"D、转弯前鸣笛示意\"]', 1, '0', 1, 1, 0, 0, 0, 1542336990, 1542336990);
INSERT INTO `ks_question` VALUES (991, '夜间行驶，与对向车道车辆交会时，以下做法正确的是？', '打开远光灯或者近光灯不断来回切换，容易影响对面司机的视线。关闭灯光，对面的司机就看不到你了。', 'http://file.open.jiakaobaodian.com/tiku/res/1161200.jpg', 1, '[\"A、远光灯与近光灯之间不断来回切换\",\"B、保持使用远光灯\",\"C、切换为近光灯\",\"D、关闭灯光\"]', 1, '2', 1, 1, 4, 0, 0, 1542336992, 1542336992);
INSERT INTO `ks_question` VALUES (992, '以下安全带系法正确的是？', '容易选错的是图四，如果安全带位置过低，低于肩部，就起不到最基本安全保障作用。而滑落至肩膀，还可能会限制住身体，影响方向盘的操作。', 'http://file.open.jiakaobaodian.com/tiku/res/1161300.jpg', 1, '[\"A、图3\",\"B、图1\",\"C、图4\",\"D、图2\"]', 1, '1', 1, 1, 4, 0, 0, 1542336993, 1542336993);
INSERT INTO `ks_question` VALUES (993, '以下哪个仪表表示发动机转速表？', '转速表刻度不会超过两位数。', 'http://file.open.jiakaobaodian.com/tiku/res/1161400.jpg', 1, '[\"A、图1\",\"B、图4\",\"C、图2\",\"D、图3\"]', 1, '0', 1, 1, 4, 0, 0, 1542336994, 1542336994);
INSERT INTO `ks_question` VALUES (994, '以下哪个仪表表示速度和里程表？', '速度和里程表的刻度标记一般超过两位数。', 'http://file.open.jiakaobaodian.com/tiku/res/1161500.jpg', 1, '[\"A、图1\",\"B、图3\",\"C、图2\",\"D、图4\"]', 1, '2', 1, 1, 4, 0, 0, 1542336995, 1542336995);
INSERT INTO `ks_question` VALUES (995, '以下哪个仪表表示水温表？', '水温表上有个温度标志。', 'http://file.open.jiakaobaodian.com/tiku/res/1161600.jpg', 1, '[\"A、图4\",\"B、图2\",\"C、图3\",\"D、图1\"]', 1, '2', 1, 1, 4, 0, 0, 1542336996, 1542336996);
INSERT INTO `ks_question` VALUES (996, '以下哪个仪表表示燃油表？', '燃油表上有个加油站里的加油机的标志。', 'http://file.open.jiakaobaodian.com/tiku/res/1161700.jpg', 1, '[\"A、图2\",\"B、图3\",\"C、图1\",\"D、图4\"]', 1, '3', 1, 1, 4, 0, 0, 1542336997, 1542336997);
INSERT INTO `ks_question` VALUES (997, '图中哪个报警灯亮，提示充电电路异常或故障？', '图1为燃油指示灯；图2为手刹指示灯；图3为ABS指示灯；图4为电瓶指示灯。有正负极＋－标志的，就表示有电嘛。', 'http://file.open.jiakaobaodian.com/tiku/res/1161800.jpg', 1, '[\"A、图2\",\"B、图1\",\"C、图3\",\"D、图4\"]', 1, '3', 1, 1, 4, 0, 0, 1542336998, 1542336998);
INSERT INTO `ks_question` VALUES (998, '哪个报警灯亮，提示发动机控制系统异常或故障？', '图1为燃油指示灯；图2为气囊指示灯；图3为发动机自检灯；图4为水温指示灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1161900.jpg', 1, '[\"A、图3\",\"B、图2\",\"C、图4\",\"D、图1\"]', 1, '0', 1, 1, 4, 0, 0, 1542336999, 1542336999);
INSERT INTO `ks_question` VALUES (999, '为提示车辆和行人注意，雾天必须开启哪个灯？', '图1为清洗液指示灯；图2为远光指示灯；图3为转向指示灯；图4为雾灯指示灯。雾天当然要开雾灯啦。', 'http://file.open.jiakaobaodian.com/tiku/res/1162000.jpg', 1, '[\"A、图1\",\"B、图4\",\"C、图2\",\"D、图3\"]', 1, '1', 1, 1, 4, 0, 0, 1542337001, 1542337001);
INSERT INTO `ks_question` VALUES (1000, '图中左侧白色轿车，在这种情况下为了保证安全，应适当降低车速。', '限速标志指示该路段限速60公里/小时，而速度仪表显示当前时速已在60公里/小时，为了避免超速，所以应该适当减速。', 'http://file.open.jiakaobaodian.com/tiku/res/1162100.jpg', 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 4, 0, 0, 1542337002, 1542337002);
INSERT INTO `ks_question` VALUES (1001, '以下哪个指示灯亮时，表示发动机机油压力过低？', '图1是机油指示灯，表示发动机机油压力过低；图2表示前雾灯显示；图3是ABS指示灯；图4表示水温指示灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1162200.jpg', 1, '[\"A、图2\",\"B、图1\",\"C、图3\",\"D、图4\"]', 1, '1', 1, 1, 4, 0, 0, 1542337003, 1542337003);
INSERT INTO `ks_question` VALUES (1002, '机油压力报警灯持续亮，可边行驶，边观察，等待报警灯自行熄灭。', '机油报警灯亮起，如果继续行驶，容易造成发动机损坏，影响行车安全。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542337004, 1542337004);
INSERT INTO `ks_question` VALUES (1003, '以下哪个指示灯亮时，表示防抱死制动系统出现故障？', '图1表示机油指示灯；图2表示前雾灯显示；图3是ABS指示灯，ABS就是防抱死系统的简称；图4是水温指示灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1162400.jpg', 1, '[\"A、图1\",\"B、图2\",\"C、图3\",\"D、图4\"]', 1, '2', 1, 1, 4, 0, 0, 1542337005, 1542337005);
INSERT INTO `ks_question` VALUES (1004, '行车中下列哪个灯亮，提示驾驶人车辆制动系统出现异常？', '图1是燃油指示灯；图2是水温指示灯；图3是手刹指示灯；图4是发动机自检灯。车辆制动系统出现异常自然是与手刹有关啦。', 'http://file.open.jiakaobaodian.com/tiku/res/1162500.jpg', 1, '[\"A、图2\",\"B、图4\",\"C、图3\",\"D、图1\"]', 1, '2', 1, 1, 4, 0, 0, 1542337006, 1542337006);
INSERT INTO `ks_question` VALUES (1005, '行车中，制动报警灯亮，应试踩一下制动，只要有效可正常行车。', '应该立刻停车检查制动，否则可能影响行车安全。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '1', 1, 1, 0, 0, 0, 1542337007, 1542337007);
INSERT INTO `ks_question` VALUES (1006, '以下哪个指示灯亮时，表示油箱内燃油已到最低液面？', '图1表示发动机机油压力过低；图2表示前雾灯显示；图3是ABS指示灯；图4表示燃油指示灯，有个加油站里的加油机的标志。', 'http://file.open.jiakaobaodian.com/tiku/res/1162700.jpg', 1, '[\"A、图4\",\"B、图3\",\"C、图1\",\"D、图2\"]', 1, '0', 1, 1, 4, 0, 0, 1542337009, 1542337009);
INSERT INTO `ks_question` VALUES (1007, '行车中，燃油报警灯亮，应及时到附近加油站加油，以免造成车辆乘员滞留公路，发生交通事故。', '不及时加油，还可能造成汽油泵损坏。', NULL, 2, '[\"A、正确\",\"B、错误\"]', 1, '0', 1, 1, 0, 0, 0, 1542337010, 1542337010);
INSERT INTO `ks_question` VALUES (1008, '以下哪个指示灯亮时，表示发动机温度过高？', '图1表示机油指示灯；图2表示水温指示灯，此灯常亮说明温度过高；图3是ABS指示灯；图4是燃油指示灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1162900.jpg', 1, '[\"A、图1\",\"B、图3\",\"C、图2\",\"D、图4\"]', 1, '2', 1, 1, 4, 0, 0, 1542337011, 1542337011);
INSERT INTO `ks_question` VALUES (1009, '行车中水温报警灯亮，下列可能是其原因的是？', '冷却液过少才会导致发动机水温过高。', NULL, 1, '[\"A、冷却液过多\",\"B、缺少冷却液\",\"C、指示灯损坏\",\"D、缺少润滑油\"]', 1, '1', 1, 1, 0, 0, 0, 1542337012, 1542337012);
INSERT INTO `ks_question` VALUES (1010, '以下哪个指示灯亮时，提醒驾驶人安全带插头未插入锁扣？', '图1表示安全带插头未插入锁扣；图2是水温指示灯；图3是ABS指示灯；图4是燃油指示灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1163100.jpg', 1, '[\"A、图3\",\"B、图4\",\"C、图1\",\"D、图2\"]', 1, '2', 1, 1, 4, 0, 0, 1542337013, 1542337013);
INSERT INTO `ks_question` VALUES (1011, '车辆因故障等原因需被牵引时，以下说法正确的是什么？', '打开报警灯是必须的，而且被牵引的机动车除驾驶人外不得载人，不得拖带挂车。', 'http://file.open.jiakaobaodian.com/tiku/res/1163200.jpg', 1, '[\"A、前后车均应打开报警灯\",\"B、所有车辆都应让行\",\"C、两车尽量快速行驶\",\"D、不受交通信号限制\"]', 1, '0', 1, 1, 4, 0, 0, 1542337014, 1542337014);
INSERT INTO `ks_question` VALUES (1012, '车辆发生意外，要及时打开哪个灯?', '图1是示宽指示灯；图2是雾灯指示灯；图3是远光指示灯；图4是危险报警闪光灯按钮，发生意外时应该打开危险报警闪光灯。', 'http://file.open.jiakaobaodian.com/tiku/res/1163300.jpg', 1, '[\"A、图4\",\"B、图3\",\"C、图1\",\"D、图2\"]', 1, '0', 1, 1, 4, 0, 0, 1542337015, 1542337015);
COMMIT;

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
BEGIN;
INSERT INTO `ks_special` VALUES (1, 0, 0, '按知识点类型', 2, 1476173388, 1476174821);
INSERT INTO `ks_special` VALUES (2, 0, 0, '按内容类型', 1, 1476174815, 1476174815);
INSERT INTO `ks_special` VALUES (3, 0, 2, '文字题', 1, 1476174894, 1476179981);
INSERT INTO `ks_special` VALUES (4, 0, 2, '图片题', 2, 1476174917, 1476174917);
INSERT INTO `ks_special` VALUES (5, 0, 1, '时间题', 1, 1476174958, 1476175078);
INSERT INTO `ks_special` VALUES (6, 0, 1, '速度题', 2, 1476174996, 1476175072);
INSERT INTO `ks_special` VALUES (7, 0, 1, '距离题', 3, 1476175066, 1476175253);
INSERT INTO `ks_special` VALUES (8, 0, 0, '按答案类型', 3, 1476175277, 1476175277);
INSERT INTO `ks_special` VALUES (9, 0, 8, '正确题', 100, 1476175293, 1476175293);
INSERT INTO `ks_special` VALUES (10, 0, 2, '难题', 100, 1476519608, 1476519608);
COMMIT;

-- ----------------------------
-- Table structure for ks_subject
-- ----------------------------
DROP TABLE IF EXISTS `ks_subject`;
CREATE TABLE `ks_subject` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '科目ID',
  `car_id` smallint(4) unsigned NOT NULL COMMENT '车型ID ',
  `name` varchar(255) NOT NULL COMMENT '科目分类信息',
  `desc` text NOT NULL COMMENT '说明信息',
  `sort` tinyint(2) unsigned NOT NULL DEFAULT '100' COMMENT '排序',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态 (1 开启 0 关闭)',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `config` text NOT NULL COMMENT '配置信息',
  `image` varchar(100) NOT NULL COMMENT '图片信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='科目信息表(主分类)';

-- ----------------------------
-- Records of ks_subject
-- ----------------------------
BEGIN;
INSERT INTO `ks_subject` VALUES (1, 1, '科目一', '科目一，又称科目一理论考试、驾驶员理论考试，是机动车驾驶证考核的一部分 。根据《机动车驾驶证申领和使用规定》，考 试内容包括驾车理论基础、道路安全法律法规、地方性法规等相关知识。考试形式为上机考试，100道题，90分及以上过关。', 1, 1, 1492835463, '', '');
INSERT INTO `ks_subject` VALUES (2, 1, '科目四', '科目四，又称科目四理论考试、驾驶员理论考试，是机动车驾驶证考核的一部分。公安部123号令实施后，科目三考试分为两项内容，除了路考，增加了安全文明驾驶考试，俗称“科目四”，考量“车德”。因为这个考试在科目三之后进行，所以大家都习惯称之为科目四考试。实际的官方说法中没有科目四一说。', 2, 1, 1492835656, '{\"passingScore\":\"72\",\"time\":\"60\",\"judgmentNumber\":\"10\",\"selectNumber\":\"40\",\"multipleNumber\":\"30\",\"shortNumber\":\"5\",\"judgmentScore\":\"2\",\"selectScore\":\"2\",\"multipleScore\":\"3\",\"shortScore\":\"5\"}', '');
COMMIT;

-- ----------------------------
-- Table structure for ks_user
-- ----------------------------
DROP TABLE IF EXISTS `ks_user`;
CREATE TABLE `ks_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `phone` char(11) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名称',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `face` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `status` smallint(6) NOT NULL DEFAULT '10' COMMENT '状态',
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '自动登录密钥',
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '密码哈希值',
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '重新登录哈希值',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '修改时间',
  `last_time` int(11) NOT NULL DEFAULT '0' COMMENT '上一次登录时间',
  `last_ip` char(12) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '上一次登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `phone` (`phone`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for ks_user_collect
-- ----------------------------
DROP TABLE IF EXISTS `ks_user_collect`;
CREATE TABLE `ks_user_collect` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户ID',
  `qids` text,
  `subject_id` int(11) NOT NULL,
  UNIQUE KEY `uniqid` (`user_id`,`subject_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏记录表';

SET FOREIGN_KEY_CHECKS = 1;
