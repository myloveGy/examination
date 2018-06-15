SET FOREIGN_KEY_CHECKS=0;

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
INSERT INTO `ks_admin` VALUES ('1', 'super', 'super@admin.com', '', 'admin', '10', 'tGaaJtNH3SXtUEJtA6LIgNb0LQPEjste', '$2y$13$YxX4lUa.8Ju25k4voR1e0ugjV3riwouxczPr/xPbaCG5TT8gTkpOW', 'Coq2MudT_KvDZrYtli2pepgGNEEDsN9W_1529078268', '1528029973', '127.0.0.1', '湖南省,岳阳市,岳阳县', '1526831872', '1', '1529078268', '1');
INSERT INTO `ks_admin` VALUES ('2', 'admin', 'admin@admin.com', '', 'admin', '10', 'VWAHqZZOgjZuAovIMmH7gbiBpX76CLS0', '$2y$13$VVNMg4gYETT0YHIJI5VSNOE4O105eKXCA7EIMzyV2KMyUUTx6u7N2', 'GxH7TNQ9kRJAC2JuSGclMQnk0TYvZ2hw_1529078253', '1526831872', '127.0.0.1', '湖南省,岳阳市,岳阳县', '1526831872', '1', '1529078253', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='管理员操作日志记录信息表';

-- ----------------------------
-- Records of ks_admin_operate_logs
-- ----------------------------
INSERT INTO `ks_admin_operate_logs` VALUES ('1', '1', 'super', 'admin/admin/module/create', '', '{\"title\":\"辩论一\",\"table\":\"ks_admin_operate_logs\",\"primary_key\":\"\",\"html\":\"\",\"controller\":\"\",\"menu\":\"1\",\"menu_prefix\":\"\",\"auth\":\"1\",\"auth_prefix\":\"\",\"allow\":\"1\",\"agree\":\"on\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":\"<div class=\\\"alert alert-info\\\">\\r\\n    <button data-dismiss=\\\"alert\\\" class=\\\"close\\\" type=\\\"button\\\">×</button>\\r\\n    <strong>填写配置表格信息!</strong>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">id</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[id][title]\\\" value=\\\"日志ID\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[id][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[id][type]\\\">\\r\\n            <option value=\\\"hidden\\\" selected=\\\"selected\\\">hidden</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[id][options]\\\" value=\'\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[id][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[id][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[id][createdCell]\\\" value=\\\"\\\" /></label>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">admin_id</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[admin_id][title]\\\" value=\\\"操作管理员ID\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[admin_id][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[admin_id][type]\\\">\\r\\n            <option value=\\\"text\\\" selected=\\\"selected\\\">text</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[admin_id][options]\\\" value=\'\\\"required\\\": true,\\\"number\\\": true,\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[admin_id][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[admin_id][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[admin_id][createdCell]\\\" value=\\\"\\\" /></label>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">admin_name</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[admin_name][title]\\\" value=\\\"操作管理员名称\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[admin_name][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[admin_name][type]\\\">\\r\\n            <option value=\\\"text\\\" selected=\\\"selected\\\">text</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[admin_name][options]\\\" value=\'\\\"required\\\": true,\\\"rangelength\\\": \\\"[2, 20]\\\"\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[admin_name][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[admin_name][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[admin_name][createdCell]\\\" value=\\\"\\\" /></label>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">action</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[action][title]\\\" value=\\\"方法\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[action][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[action][type]\\\">\\r\\n            <option value=\\\"text\\\" selected=\\\"selected\\\">text</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[action][options]\\\" value=\'\\\"required\\\": true,\\\"rangelength\\\": \\\"[2, 64]\\\"\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[action][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[action][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[action][createdCell]\\\" value=\\\"\\\" /></label>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">index</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[index][title]\\\" value=\\\"数据标识\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[index][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[index][type]\\\">\\r\\n            <option value=\\\"text\\\" selected=\\\"selected\\\">text</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[index][options]\\\" value=\'\\\"required\\\": true,\\\"rangelength\\\": \\\"[2, 100]\\\"\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[index][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[index][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[index][createdCell]\\\" value=\\\"\\\" /></label>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">request</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[request][title]\\\" value=\\\"请求参数\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[request][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[request][type]\\\">\\r\\n            <option value=\\\"text\\\" selected=\\\"selected\\\">text</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[request][options]\\\" value=\'\\\"required\\\": true,\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[request][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[request][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[request][createdCell]\\\" value=\\\"\\\" /></label>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">response</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[response][title]\\\" value=\\\"响应数据\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[response][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[response][type]\\\">\\r\\n            <option value=\\\"text\\\" selected=\\\"selected\\\">text</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[response][options]\\\" value=\'\\\"required\\\": true,\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[response][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[response][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[response][createdCell]\\\" value=\\\"\\\" /></label>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">ip</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[ip][title]\\\" value=\\\"请求IP\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[ip][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[ip][type]\\\">\\r\\n            <option value=\\\"text\\\" selected=\\\"selected\\\">text</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[ip][options]\\\" value=\'\\\"required\\\": true,\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[ip][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[ip][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[ip][createdCell]\\\" value=\\\"\\\" /></label>\\r\\n</div><div class=\\\"alert alert-success me-alert-su\\\">\\r\\n    <span class=\\\"label label-success me-label-sp\\\">created_at</span>\\r\\n    <label class=\\\"me-label\\\">标题: <input type=\\\"text\\\" name=\\\"attr[created_at][title]\\\" value=\\\"创建时间\\\" required=\\\"required\\\" /></label>\\r\\n    <label class=\\\"me-label\\\">编辑：\\r\\n        <select class=\\\"is-hide\\\" name=\\\"attr[created_at][edit]\\\">\\r\\n            <option value=\\\"1\\\" selected=\\\"selected\\\">开启</option>\\r\\n            <option value=\\\"0\\\" >关闭</option>\\r\\n        </select>\\r\\n        <select name=\\\"attr[created_at][type]\\\">\\r\\n            <option value=\\\"text\\\" selected=\\\"selected\\\">text</option>\\r\\n            <option value=\\\"text\\\">text</option>\\r\\n            <option value=\\\"hidden\\\" >hidden</option>\\r\\n            <option value=\\\"select\\\">select</option>\\r\\n            <option value=\\\"radio\\\">radio</option>\\r\\n            <option value=\\\"password\\\">password</option>\\r\\n            <option value=\\\"textarea\\\">textarea</option>\\r\\n        </select>\\r\\n        <input type=\\\"text\\\" name=\\\"attr[created_at][options]\\\" value=\'\\\"required\\\": true,\\\"number\\\": true,\'/>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">搜索：\\r\\n        <select name=\\\"attr[created_at][search]\\\">\\r\\n            <option value=\\\"1\\\">开启</option>\\r\\n            <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n        </select>\\r\\n    </label>\\r\\n    <label class=\\\"me-label\\\">排序：<select name=\\\"attr[created_at][bSortable]\\\">\\r\\n        <option value=\\\"1\\\" >开启</option>\\r\\n        <option value=\\\"0\\\" selected=\\\"selected\\\">关闭</option>\\r\\n    </select></label>\\r\\n    <label class=\\\"me-label\\\">回调：<input type=\\\"text\\\" name=\\\"attr[created_at][createdCell]\\\" value=\\\"meTables.dateTimeString\\\" /></label>\\r\\n</div><input type=\\\"hidden\\\" name=\\\"pk\\\" value=\\\"id\\\">\"}', '127.0.0.1', '1529079459');
INSERT INTO `ks_admin_operate_logs` VALUES ('2', '1', 'super', 'admin/admin/module/update', '', '{\"title\":\"辩论一\",\"table\":\"ks_admin_operate_logs\",\"attr\":{\"id\":{\"title\":\"日志ID\",\"edit\":\"1\",\"type\":\"hidden\",\"options\":\"\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"\"},\"admin_id\":{\"title\":\"操作管理员ID\",\"edit\":\"1\",\"type\":\"text\",\"options\":\"\\\"required\\\": true,\\\"number\\\": true,\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"\"},\"admin_name\":{\"title\":\"操作管理员名称\",\"edit\":\"1\",\"type\":\"text\",\"options\":\"\\\"required\\\": true,\\\"rangelength\\\": \\\"[2, 20]\\\"\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"\"},\"action\":{\"title\":\"方法\",\"edit\":\"1\",\"type\":\"text\",\"options\":\"\\\"required\\\": true,\\\"rangelength\\\": \\\"[2, 64]\\\"\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"\"},\"index\":{\"title\":\"数据标识\",\"edit\":\"1\",\"type\":\"text\",\"options\":\"\\\"required\\\": true,\\\"rangelength\\\": \\\"[2, 100]\\\"\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"\"},\"request\":{\"title\":\"请求参数\",\"edit\":\"1\",\"type\":\"text\",\"options\":\"\\\"required\\\": true,\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"\"},\"response\":{\"title\":\"响应数据\",\"edit\":\"1\",\"type\":\"text\",\"options\":\"\\\"required\\\": true,\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"\"},\"ip\":{\"title\":\"请求IP\",\"edit\":\"1\",\"type\":\"text\",\"options\":\"\\\"required\\\": true,\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"\"},\"created_at\":{\"title\":\"创建时间\",\"edit\":\"1\",\"type\":\"text\",\"options\":\"\\\"required\\\": true,\\\"number\\\": true,\",\"search\":\"0\",\"bSortable\":\"0\",\"createdCell\":\"meTables.dateTimeString\"}},\"pk\":\"id\",\"primary_key\":\"\",\"html\":\"\",\"controller\":\"\",\"menu\":\"1\",\"menu_prefix\":\"\",\"auth\":\"1\",\"auth_prefix\":\"\",\"allow\":\"1\",\"agree\":\"on\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"html\":\"<code><span style=\\\"color: #000000\\\">\\n<span style=\\\"color: #0000BB\\\">&lt;?php\\r<br />\\r<br /></span><span style=\\\"color: #007700\\\">use&nbsp;</span><span style=\\\"color: #0000BB\\\">jinxing</span><span style=\\\"color: #007700\\\">\\\\</span><span style=\\\"color: #0000BB\\\">admin</span><span style=\\\"color: #007700\\\">\\\\</span><span style=\\\"color: #0000BB\\\">widgets</span><span style=\\\"color: #007700\\\">\\\\</span><span style=\\\"color: #0000BB\\\">MeTable</span><span style=\\\"color: #007700\\\">;\\r<br /></span><span style=\\\"color: #FF8000\\\">//&nbsp;定义标题和面包屑信息\\r<br /></span><span style=\\\"color: #0000BB\\\">$this</span><span style=\\\"color: #007700\\\">-&gt;</span><span style=\\\"color: #0000BB\\\">title&nbsp;</span><span style=\\\"color: #007700\\\">=&nbsp;</span><span style=\\\"color: #DD0000\\\">\'辩论一\'</span><span style=\\\"color: #007700\\\">;\\r<br /></span><span style=\\\"color: #0000BB\\\">?&gt;\\r<br />&lt;?=MeTable</span><span style=\\\"color: #007700\\\">::</span><span style=\\\"color: #0000BB\\\">widget</span><span style=\\\"color: #007700\\\">()</span><span style=\\\"color: #0000BB\\\">?&gt;\\r<br />&lt;?php&nbsp;$this</span><span style=\\\"color: #007700\\\">-&gt;</span><span style=\\\"color: #0000BB\\\">beginBlock</span><span style=\\\"color: #007700\\\">(</span><span style=\\\"color: #DD0000\\\">\'javascript\'</span><span style=\\\"color: #007700\\\">)&nbsp;</span><span style=\\\"color: #0000BB\\\">?&gt;\\r<br /></span>&lt;script&nbsp;type=\\\"text/javascript\\\"&gt;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;var&nbsp;m&nbsp;=&nbsp;meTables({\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;title:&nbsp;\\\"辩论一\\\",\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;table:&nbsp;{\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\\"aoColumns\\\":&nbsp;[\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"日志ID\\\",&nbsp;\\\"data\\\":&nbsp;\\\"id\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"hidden\\\",&nbsp;},&nbsp;\\\"bSortable\\\":&nbsp;false},&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"操作管理员ID\\\",&nbsp;\\\"data\\\":&nbsp;\\\"admin_id\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"text\\\",&nbsp;\\\"required\\\":&nbsp;true,\\\"number\\\":&nbsp;true},&nbsp;\\\"bSortable\\\":&nbsp;false},&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"操作管理员名称\\\",&nbsp;\\\"data\\\":&nbsp;\\\"admin_name\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"text\\\",&nbsp;\\\"required\\\":&nbsp;true,\\\"rangelength\\\":&nbsp;\\\"[2,&nbsp;20]\\\"},&nbsp;\\\"bSortable\\\":&nbsp;false},&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"方法\\\",&nbsp;\\\"data\\\":&nbsp;\\\"action\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"text\\\",&nbsp;\\\"required\\\":&nbsp;true,\\\"rangelength\\\":&nbsp;\\\"[2,&nbsp;64]\\\"},&nbsp;\\\"bSortable\\\":&nbsp;false},&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"数据标识\\\",&nbsp;\\\"data\\\":&nbsp;\\\"index\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"text\\\",&nbsp;\\\"required\\\":&nbsp;true,\\\"rangelength\\\":&nbsp;\\\"[2,&nbsp;100]\\\"},&nbsp;\\\"bSortable\\\":&nbsp;false},&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"请求参数\\\",&nbsp;\\\"data\\\":&nbsp;\\\"request\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"text\\\",&nbsp;\\\"required\\\":&nbsp;true},&nbsp;\\\"bSortable\\\":&nbsp;false},&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"响应数据\\\",&nbsp;\\\"data\\\":&nbsp;\\\"response\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"text\\\",&nbsp;\\\"required\\\":&nbsp;true},&nbsp;\\\"bSortable\\\":&nbsp;false},&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"请求IP\\\",&nbsp;\\\"data\\\":&nbsp;\\\"ip\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"text\\\",&nbsp;\\\"required\\\":&nbsp;true},&nbsp;\\\"bSortable\\\":&nbsp;false},&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{\\\"title\\\":&nbsp;\\\"创建时间\\\",&nbsp;\\\"data\\\":&nbsp;\\\"created_at\\\",&nbsp;\\\"edit\\\":&nbsp;{\\\"type\\\":&nbsp;\\\"text\\\",&nbsp;\\\"required\\\":&nbsp;true,\\\"number\\\":&nbsp;true},&nbsp;\\\"bSortable\\\":&nbsp;false,&nbsp;\\\"createdCell\\\"&nbsp;:&nbsp;meTables.dateTimeString},&nbsp;<br />\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;});\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;/**\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;meTables.fn.extend({\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;显示的前置和后置操作\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;beforeShow:&nbsp;function(data,&nbsp;child)&nbsp;{\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;true;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;},\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;afterShow:&nbsp;function(data,&nbsp;child)&nbsp;{\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;true;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;},\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;编辑的前置和后置操作\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;beforeSave:&nbsp;function(data,&nbsp;child)&nbsp;{\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;true;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;},\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;afterSave:&nbsp;function(data,&nbsp;child)&nbsp;{\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;true;\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;});\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;*/\\r<br />\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$(function(){\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;m.init();\\r<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;});\\r<br />&lt;/script&gt;\\r<br /><span style=\\\"color: #0000BB\\\">&lt;?php&nbsp;$this</span><span style=\\\"color: #007700\\\">-&gt;</span><span style=\\\"color: #0000BB\\\">endBlock</span><span style=\\\"color: #007700\\\">();&nbsp;</span><span style=\\\"color: #0000BB\\\">?&gt;</span>\\n</span>\\n</code>\",\"file\":[\"@app/modules/admin/views/admin-operate-logs/index.php\",false],\"controller\":[\"@app/modules/admin/controllers/AdminOperateLogsController.php\",false],\"primary_key\":\"id\",\"auth_name\":\"admin/admin-operate-logs\",\"menu_name\":\"admin/admin-operate-logs\"}}', '127.0.0.1', '1529079463');
INSERT INTO `ks_admin_operate_logs` VALUES ('3', '1', 'super', 'admin/admin/menu/delete', '16', '{\"id\":\"16\",\"pid\":\"0\",\"menu_name\":\"辩论一\",\"icons\":\"menu-icon fa fa-globe\",\"url\":\"admin/admin-operate-logs/index\",\"status\":\"1\",\"sort\":\"100\",\"created_at\":\"1529079470\",\"created_id\":\"1\",\"updated_at\":\"1529079470\",\"updated_id\":\"1\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"id\":16,\"pid\":\"0\",\"menu_name\":\"辩论一\",\"icons\":\"menu-icon fa fa-globe\",\"url\":\"admin/admin-operate-logs/index\",\"status\":1,\"sort\":100,\"created_at\":1529079470,\"created_id\":1,\"updated_at\":1529079470,\"updated_id\":1}}', '127.0.0.1', '1529079994');
INSERT INTO `ks_admin_operate_logs` VALUES ('4', '1', 'super', 'admin/admin/menu/create', '', '{\"id\":\"\",\"pid\":\"1\",\"menu_name\":\"后台权限\",\"icons\":\"menu-icon fa fa-globe\",\"url\":\"\",\"status\":\"1\",\"sort\":\"100\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"pid\":\"1\",\"menu_name\":\"后台权限\",\"icons\":\"menu-icon fa fa-globe\",\"url\":\"\",\"status\":\"1\",\"sort\":\"100\",\"created_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"updated_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"created_id\":1,\"updated_id\":1,\"id\":17}}', '127.0.0.1', '1529080278');
INSERT INTO `ks_admin_operate_logs` VALUES ('5', '1', 'super', 'admin/admin/menu/create', '', '{\"id\":\"\",\"pid\":\"17\",\"menu_name\":\"角色分配\",\"icons\":\"menu-icon fa fa-paper-plane\",\"url\":\"admin/admin/auth-assignment/index\",\"status\":\"1\",\"sort\":\"100\",\"auth\":[\"index\",\"search\",\"create\",\"update\",\"delete\",\"delete-all\",\"export\"]}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"pid\":\"17\",\"menu_name\":\"角色分配\",\"icons\":\"menu-icon fa fa-paper-plane\",\"url\":\"admin/admin/auth-assignment/index\",\"status\":\"1\",\"sort\":\"100\",\"created_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"updated_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"created_id\":1,\"updated_id\":1,\"id\":18}}', '127.0.0.1', '1529080405');
INSERT INTO `ks_admin_operate_logs` VALUES ('6', '1', 'super', 'admin/admin/menu/create', '', '{\"id\":\"\",\"pid\":\"1\",\"menu_name\":\"操作日志\",\"icons\":\"menu-icon fa fa-globe\",\"url\":\"admin/admin/admin-log/index\",\"status\":\"1\",\"sort\":\"30\",\"auth\":[\"index\",\"search\",\"create\",\"update\",\"delete\",\"delete-all\",\"export\"]}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"pid\":\"1\",\"menu_name\":\"操作日志\",\"icons\":\"menu-icon fa fa-globe\",\"url\":\"admin/admin/admin-log/index\",\"status\":\"1\",\"sort\":\"30\",\"created_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"updated_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"created_id\":1,\"updated_id\":1,\"id\":19}}', '127.0.0.1', '1529080459');
INSERT INTO `ks_admin_operate_logs` VALUES ('7', '1', 'super', 'admin/admin/menu/update', '6', '{\"id\":\"6\",\"pid\":\"17\",\"menu_name\":\"权限管理\",\"icons\":\"menu-icon fa fa-fire\",\"url\":\"admin/admin/authority/index\",\"status\":\"1\",\"sort\":\"20\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"id\":6,\"pid\":\"17\",\"menu_name\":\"权限管理\",\"icons\":\"menu-icon fa fa-fire\",\"url\":\"admin/admin/authority/index\",\"status\":\"1\",\"sort\":\"20\",\"created_at\":1468994819,\"created_id\":1,\"updated_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"updated_id\":1}}', '127.0.0.1', '1529080521');
INSERT INTO `ks_admin_operate_logs` VALUES ('8', '1', 'super', 'admin/admin/menu/update', '4', '{\"id\":\"4\",\"pid\":\"17\",\"menu_name\":\"角色管理\",\"icons\":\"\",\"url\":\"admin/admin/role/index\",\"status\":\"1\",\"sort\":\"10\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"id\":4,\"pid\":\"17\",\"menu_name\":\"角色管理\",\"icons\":\"\",\"url\":\"admin/admin/role/index\",\"status\":\"1\",\"sort\":\"10\",\"created_at\":1468994665,\"created_id\":1,\"updated_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"updated_id\":1}}', '127.0.0.1', '1529080578');
INSERT INTO `ks_admin_operate_logs` VALUES ('9', '1', 'super', 'admin/admin/menu/update', '4', '{\"id\":\"4\",\"pid\":\"17\",\"menu_name\":\"角色管理\",\"icons\":\"menu-icon fa fa-graduation-cap \",\"url\":\"admin/admin/role/index\",\"status\":\"1\",\"sort\":\"10\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"id\":4,\"pid\":\"17\",\"menu_name\":\"角色管理\",\"icons\":\"menu-icon fa fa-graduation-cap \",\"url\":\"admin/admin/role/index\",\"status\":\"1\",\"sort\":\"10\",\"created_at\":1468994665,\"created_id\":1,\"updated_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"updated_id\":1}}', '127.0.0.1', '1529080661');
INSERT INTO `ks_admin_operate_logs` VALUES ('10', '1', 'super', 'admin/admin/menu/update', '18', '{\"id\":\"18\",\"pid\":\"17\",\"menu_name\":\"角色分配\",\"icons\":\"menu-icon fa fa-paper-plane\",\"url\":\"admin/admin/auth-assignment/index\",\"status\":\"1\",\"sort\":\"20\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"id\":18,\"pid\":\"17\",\"menu_name\":\"角色分配\",\"icons\":\"menu-icon fa fa-paper-plane\",\"url\":\"admin/admin/auth-assignment/index\",\"status\":\"1\",\"sort\":\"20\",\"created_at\":1529080403,\"created_id\":1,\"updated_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"updated_id\":1}}', '127.0.0.1', '1529080684');
INSERT INTO `ks_admin_operate_logs` VALUES ('11', '1', 'super', 'admin/admin/menu/create', '', '{\"id\":\"\",\"pid\":\"17\",\"menu_name\":\"规则管理\",\"icons\":\"menu-icon fa fa-globe\",\"url\":\"admin/admin/auth-rule/index\",\"status\":\"1\",\"sort\":\"40\",\"auth\":[\"index\",\"search\",\"create\",\"update\",\"delete\",\"delete-all\",\"export\"]}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"pid\":\"17\",\"menu_name\":\"规则管理\",\"icons\":\"menu-icon fa fa-globe\",\"url\":\"admin/admin/auth-rule/index\",\"status\":\"1\",\"sort\":\"40\",\"created_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"updated_at\":{\"expression\":\"UNIX_TIMESTAMP()\",\"params\":[]},\"created_id\":1,\"updated_id\":1,\"id\":20}}', '127.0.0.1', '1529080727');
INSERT INTO `ks_admin_operate_logs` VALUES ('12', '1', 'super', 'admin/admin/auth-rule/create', '', '{\"name\":\"\",\"newName\":\"admin\",\"data\":\"jinxing\\\\admin\\\\rules\\\\AdminRule\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"data\":\"jinxing\\\\admin\\\\rules\\\\AdminRule\"}}', '127.0.0.1', '1529080802');
INSERT INTO `ks_admin_operate_logs` VALUES ('13', '1', 'super', 'admin/admin/auth-rule/create', '', '{\"name\":\"\",\"newName\":\"admin-delete\",\"data\":\"jinxing\\\\admin\\\\rules\\\\AdminDeleteRule\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"data\":\"jinxing\\\\admin\\\\rules\\\\AdminDeleteRule\"}}', '127.0.0.1', '1529080818');
INSERT INTO `ks_admin_operate_logs` VALUES ('14', '1', 'super', 'admin/admin/auth-rule/create', '', '{\"name\":\"\",\"newName\":\"auth-assignment\",\"data\":\"jinxing\\\\admin\\\\rules\\\\AuthAssignmentRule\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"data\":\"jinxing\\\\admin\\\\rules\\\\AuthAssignmentRule\"}}', '127.0.0.1', '1529080831');
INSERT INTO `ks_admin_operate_logs` VALUES ('15', '1', 'super', 'admin/admin/authority/update', 'admin/admin/admin/update', '{\"type\":\"2\",\"name\":\"admin/admin/admin/update\",\"newName\":\"admin/admin/admin/update\",\"description\":\"修改管理员信息\",\"rule_name\":\"admin\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"name\":\"admin/admin/admin/update\",\"type\":2,\"description\":\"修改管理员信息\",\"rule_name\":\"admin\",\"data\":null,\"created_at\":1476085130,\"updated_at\":1476085130}}', '127.0.0.1', '1529081037');
INSERT INTO `ks_admin_operate_logs` VALUES ('16', '1', 'super', 'admin/admin/authority/update', 'admin/admin/admin/delete', '{\"type\":\"2\",\"name\":\"admin/admin/admin/delete\",\"newName\":\"admin/admin/admin/delete\",\"description\":\"删除管理员信息\",\"rule_name\":\"admin-delete\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"name\":\"admin/admin/admin/delete\",\"type\":2,\"description\":\"删除管理员信息\",\"rule_name\":\"admin-delete\",\"data\":null,\"created_at\":1476085130,\"updated_at\":1476085130}}', '127.0.0.1', '1529081073');
INSERT INTO `ks_admin_operate_logs` VALUES ('17', '1', 'super', 'admin/admin/authority/update', 'admin/admin/auth-assignment/delete', '{\"type\":\"2\",\"name\":\"admin/admin/auth-assignment/delete\",\"newName\":\"admin/admin/auth-assignment/delete\",\"description\":\"角色分配-删除数据\",\"rule_name\":\"auth-assignment\"}', '{\"errCode\":0,\"errMsg\":\"操作成功\",\"data\":{\"name\":\"admin/admin/auth-assignment/delete\",\"type\":2,\"description\":\"角色分配-删除数据\",\"rule_name\":\"auth-assignment\",\"data\":null,\"created_at\":1529080404,\"updated_at\":1529080404}}', '127.0.0.1', '1529081128');

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
  KEY `rule_name` (`rule_name`) USING BTREE,
  KEY `idx-auth_item-type` (`type`) USING BTREE,
  CONSTRAINT `ks_auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `ks_auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ks_auth_item
-- ----------------------------
INSERT INTO `ks_auth_item` VALUES ('admin', '1', '管理员', null, null, '1476085137', '1476096200');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/create', '2', '操作日志-添加数据', null, null, '1529080458', '1529080458');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/delete', '2', '操作日志-删除数据', null, null, '1529080459', '1529080459');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/delete-all', '2', '操作日志-批量删除', null, null, '1529080459', '1529080459');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/export', '2', '操作日志-导出数据', null, null, '1529080459', '1529080459');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/index', '2', '操作日志-显示数据', null, null, '1529080458', '1529080458');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/search', '2', '操作日志-搜索数据', null, null, '1529080458', '1529080458');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin-log/update', '2', '操作日志-修改数据', null, null, '1529080459', '1529080459');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/address', '2', '管理员地址信息查询', null, null, '1476093015', '1476093015');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/create', '2', '创建管理员信息', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/delete', '2', '删除管理员信息', 'admin-delete', null, '1476085130', '1529081073');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/delete-all', '2', '批量删除管理员信息', null, null, '1476095763', '1476095763');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/editable', '2', '管理员信息行内编辑', null, null, '1476090733', '1476090733');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/index', '2', '显示管理员信息', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/search', '2', '搜索管理员信息', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/update', '2', '修改管理员信息', 'admin', null, '1476085130', '1529081037');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/admin/upload', '2', '上传管理员头像信息', null, null, '1476088424', '1476088424');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/create', '2', '角色分配-添加数据', null, null, '1529080404', '1529080404');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/delete', '2', '角色分配-删除数据', 'auth-assignment', null, '1529080404', '1529081128');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/delete-all', '2', '角色分配-批量删除', null, null, '1529080405', '1529080405');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/export', '2', '角色分配-导出数据', null, null, '1529080405', '1529080405');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/index', '2', '角色分配-显示数据', null, null, '1529080403', '1529080403');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/search', '2', '角色分配-搜索数据', null, null, '1529080403', '1529080403');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-assignment/update', '2', '角色分配-修改数据', null, null, '1529080404', '1529080404');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/create', '2', '规则管理-添加数据', null, null, '1529080726', '1529080726');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/delete', '2', '规则管理-删除数据', null, null, '1529080727', '1529080727');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/delete-all', '2', '规则管理-批量删除', null, null, '1529080727', '1529080727');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/export', '2', '规则管理-导出数据', null, null, '1529080727', '1529080727');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/index', '2', '规则管理-显示数据', null, null, '1529080726', '1529080726');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/search', '2', '规则管理-搜索数据', null, null, '1529080726', '1529080726');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/auth-rule/update', '2', '规则管理-修改数据', null, null, '1529080726', '1529080726');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/create', '2', '创建权限信息', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/delete', '2', '删除权限信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/delete-all', '2', '权限信息删除全部', null, null, '1492830288', '1492830288');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/export', '2', '权限信息导出', null, null, '1476090709', '1476090709');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/index', '2', '显示权限信息', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/search', '2', '搜索权限信息', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/authority/update', '2', '修改权限信息', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/create', '2', '创建导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/delete', '2', '删除导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/delete-all', '2', '批量删除导航栏目信息', null, null, '1476095845', '1476095845');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/index', '2', '显示导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/search', '2', '搜索导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/menu/update', '2', '修改导航栏目', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/module/create', '2', '创建模块生成', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/module/index', '2', '显示模块生成', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/module/produce', '2', '模块生成配置文件', null, null, '1476085133', '1476093990');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/module/update', '2', '修改模块生成', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/create', '2', '创建角色信息', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/delete', '2', '删除角色信息', null, null, '1476085134', '1476085134');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/edit', '2', '角色分配权限', null, null, '1476096038', '1476096038');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/index', '2', '显示角色信息', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/search', '2', '搜索角色信息', null, null, '1476085133', '1476085133');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/update', '2', '修改角色信息', null, null, '1476085134', '1476085134');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/role/view', '2', '角色权限查看', null, null, '1476096101', '1476096101');
INSERT INTO `ks_auth_item` VALUES ('admin/admin/view', '2', '查看管理员详情信息', null, null, '1476088536', '1476088536');
INSERT INTO `ks_auth_item` VALUES ('admin/answer/create', '2', '创建答案信息', null, null, '1476183355', '1476183355');
INSERT INTO `ks_auth_item` VALUES ('admin/answer/delete', '2', '删除答案信息', null, null, '1476183356', '1476183356');
INSERT INTO `ks_auth_item` VALUES ('admin/answer/export', '2', '导出答案信息', null, null, '1476183356', '1476183356');
INSERT INTO `ks_auth_item` VALUES ('admin/answer/index', '2', '显示答案信息', null, null, '1476183355', '1476183355');
INSERT INTO `ks_auth_item` VALUES ('admin/answer/search', '2', '搜索答案信息', null, null, '1476183355', '1476183355');
INSERT INTO `ks_auth_item` VALUES ('admin/answer/update', '2', '修改答案信息', null, null, '1476183355', '1476183355');
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/create', '2', '创建日程管理', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/delete', '2', '删除日程管理', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/delete-all', '2', '批量删除日程信息', null, null, '1476095790', '1476095790');
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/editable', '2', '日程管理行内编辑', null, null, '1476088444', '1476088444');
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/export', '2', '日程信息导出', null, null, '1476090884', '1476090884');
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/index', '2', '显示日程管理', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/search', '2', '搜索日程管理', null, null, '1476085130', '1476085130');
INSERT INTO `ks_auth_item` VALUES ('admin/arrange/update', '2', '修改日程管理', null, null, '1476085131', '1476085131');
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/create', '2', '创建章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/delete', '2', '删除章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/export', '2', '导出章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/index', '2', '显示章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/search', '2', '搜索章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('admin/chapter/update', '2', '修改章节信息', null, null, '1476172059', '1476172059');
INSERT INTO `ks_auth_item` VALUES ('admin/china/create', '2', '创建地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/china/delete', '2', '删除地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/china/index', '2', '显示地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/china/search', '2', '搜索地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/china/update', '2', '修改地址信息', null, null, '1476085132', '1476085132');
INSERT INTO `ks_auth_item` VALUES ('admin/classification/create', '2', '创建车型配置', null, null, '1492831806', '1492831806');
INSERT INTO `ks_auth_item` VALUES ('admin/classification/delete', '2', '删除车型配置', null, null, '1492831806', '1492831806');
INSERT INTO `ks_auth_item` VALUES ('admin/classification/delete-all', '2', '考试类型-批量删除', null, null, '1529075116', '1529075116');
INSERT INTO `ks_auth_item` VALUES ('admin/classification/export', '2', '导出车型配置', null, null, '1492831806', '1492831806');
INSERT INTO `ks_auth_item` VALUES ('admin/classification/index', '2', '车型配置显示', null, null, '1492830329', '1492830329');
INSERT INTO `ks_auth_item` VALUES ('admin/classification/search', '2', '搜索车型配置', null, null, '1492831805', '1492831805');
INSERT INTO `ks_auth_item` VALUES ('admin/classification/update', '2', '修改车型配置', null, null, '1492831806', '1492831806');
INSERT INTO `ks_auth_item` VALUES ('admin/classification/upload', '2', '上传车型配置图标', null, null, '1492870551', '1492870551');
INSERT INTO `ks_auth_item` VALUES ('admin/question/chapter', '2', '题库查询章节', null, null, '1527996561', '1527996561');
INSERT INTO `ks_auth_item` VALUES ('admin/question/child', '2', '查询问题答案', null, null, '1476454541', '1476454541');
INSERT INTO `ks_auth_item` VALUES ('admin/question/create', '2', '创建题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('admin/question/delete', '2', '删除题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('admin/question/export', '2', '导出题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('admin/question/index', '2', '显示题库信息', null, null, '1476175765', '1476175765');
INSERT INTO `ks_auth_item` VALUES ('admin/question/search', '2', '搜索题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('admin/question/subject', '2', '问题获取章节', null, null, '1528017028', '1528017028');
INSERT INTO `ks_auth_item` VALUES ('admin/question/update', '2', '修改题库信息', null, null, '1476175766', '1476175766');
INSERT INTO `ks_auth_item` VALUES ('admin/question/upload', '2', '上传题目图片', null, null, '1476695636', '1476695646');
INSERT INTO `ks_auth_item` VALUES ('admin/special/create', '2', '创建专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('admin/special/delete', '2', '删除专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('admin/special/export', '2', '导出专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('admin/special/index', '2', '显示专项分类', null, null, '1476172609', '1476172609');
INSERT INTO `ks_auth_item` VALUES ('admin/special/search', '2', '搜索专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('admin/special/update', '2', '修改专项分类', null, null, '1476172610', '1476172610');
INSERT INTO `ks_auth_item` VALUES ('admin/subject/create', '2', '创建科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('admin/subject/delete', '2', '删除科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('admin/subject/export', '2', '导出科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('admin/subject/index', '2', '显示科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('admin/subject/search', '2', '搜索科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('admin/subject/update', '2', '修改科目信息', null, null, '1476171765', '1476171765');
INSERT INTO `ks_auth_item` VALUES ('admin/subject/upload', '2', '章节配置-添加图片', null, null, '1528002698', '1528002698');
INSERT INTO `ks_auth_item` VALUES ('admin/user/create', '2', '创建用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('admin/user/delete', '2', '删除用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('admin/user/delete-all', '2', '批量删除用户信息', null, null, '1476096229', '1476096229');
INSERT INTO `ks_auth_item` VALUES ('admin/user/export', '2', '导出用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('admin/user/index', '2', '显示用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('admin/user/search', '2', '搜索用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('admin/user/update', '2', '修改用户信息', null, null, '1476095210', '1476095210');
INSERT INTO `ks_auth_item` VALUES ('admin/user/upload', '2', '上传用户头像信息', null, null, '1476149415', '1476149415');
INSERT INTO `ks_auth_item` VALUES ('administrator', '1', '超级管理员', null, null, '1476085134', '1476085134');
INSERT INTO `ks_auth_item` VALUES ('user', '1', '普通用户', null, null, '1476085137', '1476085137');

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
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/export');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/index');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/search');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/subject');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/update');
INSERT INTO `ks_auth_item_child` VALUES ('administrator', 'admin/question/upload');
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
INSERT INTO `ks_auth_rule` VALUES ('admin', 'O:29:\"jinxing\\admin\\rules\\AdminRule\":3:{s:4:\"name\";s:5:\"admin\";s:9:\"createdAt\";i:1529080802;s:9:\"updatedAt\";i:1529080802;}', '1529080802', '1529080802');
INSERT INTO `ks_auth_rule` VALUES ('admin-delete', 'O:35:\"jinxing\\admin\\rules\\AdminDeleteRule\":3:{s:4:\"name\";s:12:\"admin-delete\";s:9:\"createdAt\";i:1529080818;s:9:\"updatedAt\";i:1529080818;}', '1529080818', '1529080818');
INSERT INTO `ks_auth_rule` VALUES ('auth-assignment', 'O:38:\"jinxing\\admin\\rules\\AuthAssignmentRule\":3:{s:4:\"name\";s:15:\"auth-assignment\";s:9:\"createdAt\";i:1529080831;s:9:\"updatedAt\";i:1529080831;}', '1529080831', '1529080831');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='导航栏信息表';

-- ----------------------------
-- Records of ks_menu
-- ----------------------------
INSERT INTO `ks_menu` VALUES ('1', '0', '后台管理', 'menu-icon fa fa-cog', '', '1', '2', '1468985587', '1', '1474340768', '1');
INSERT INTO `ks_menu` VALUES ('2', '1', '导航栏目', '', 'admin/admin/menu/index', '1', '4', '1468987221', '1', '1468994846', '1');
INSERT INTO `ks_menu` VALUES ('3', '1', '模块生成', '', 'admin/admin/module/index', '1', '5', '1468994283', '1', '1468994860', '1');
INSERT INTO `ks_menu` VALUES ('4', '17', '角色管理', 'menu-icon fa fa-graduation-cap ', 'admin/admin/role/index', '1', '10', '1468994665', '1', '1529080660', '1');
INSERT INTO `ks_menu` VALUES ('5', '1', '管理员信息', '', 'admin/admin/admin/index', '1', '2', '1468994769', '1', '1474340722', '1');
INSERT INTO `ks_menu` VALUES ('6', '17', '权限管理', 'menu-icon fa fa-fire', 'admin/admin/authority/index', '1', '20', '1468994819', '1', '1529080521', '1');
INSERT INTO `ks_menu` VALUES ('9', '0', '用户信息', 'menu-icon fa fa-user', 'admin/user/index', '1', '5', '1476095210', '1', '1476176242', '1');
INSERT INTO `ks_menu` VALUES ('10', '14', '科目信息', 'menu-icon icon-cog', 'admin/subject/index', '1', '104', '1476171766', '1', '1476176338', '1');
INSERT INTO `ks_menu` VALUES ('11', '14', '章节信息', 'menu-icon icon-cog', 'admin/chapter/index', '1', '103', '1476172059', '1', '1476176326', '1');
INSERT INTO `ks_menu` VALUES ('12', '14', '专项分类', 'menu-icon icon-cog', 'admin/special/index', '1', '102', '1476172610', '1', '1476177469', '1');
INSERT INTO `ks_menu` VALUES ('13', '14', '题库信息', 'menu-icon icon-cog', 'admin/question/index', '1', '101', '1476175766', '1', '1476176304', '1');
INSERT INTO `ks_menu` VALUES ('14', '0', '题库管理', 'menu-icon fa fa-graduation-cap', '', '1', '6', '1476176095', '1', '1476176095', '1');
INSERT INTO `ks_menu` VALUES ('15', '0', '考试类型', 'menu-icon fa fa-list', 'admin/classification/index', '1', '100', '1492829715', '1', '1527996393', '1');
INSERT INTO `ks_menu` VALUES ('17', '1', '后台权限', 'menu-icon fa fa-globe', '', '1', '100', '1529080277', '1', '1529080277', '1');
INSERT INTO `ks_menu` VALUES ('18', '17', '角色分配', 'menu-icon fa fa-paper-plane', 'admin/admin/auth-assignment/index', '1', '20', '1529080403', '1', '1529080684', '1');
INSERT INTO `ks_menu` VALUES ('19', '1', '操作日志', 'menu-icon fa fa-globe', 'admin/admin/admin-log/index', '1', '30', '1529080457', '1', '1529080457', '1');
INSERT INTO `ks_menu` VALUES ('20', '17', '规则管理', 'menu-icon fa fa-globe', 'admin/admin/auth-rule/index', '1', '40', '1529080726', '1', '1529080726', '1');

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
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `subject_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属科目ID',
  `chapter_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属章节',
  `special_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '专项ID',
  `error_number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '错误人数',
  `do_number` int(11) NOT NULL DEFAULT '0' COMMENT '做了该题目人数',
  `answers` text NOT NULL COMMENT '问题信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1322 DEFAULT CHARSET=utf8 COMMENT='题库信息表';

-- ----------------------------
-- Records of ks_question
-- ----------------------------
INSERT INTO `ks_question` VALUES ('1318', '我的测试', '我的测试', '', '1', '1', '0', '1527996618', '1528030030', '1', '1', '3', '1', '7', '[\"A:正确\",\"B:错误\",\"C:还是正确\",\"D:你的错误\"]');
INSERT INTO `ks_question` VALUES ('1319', '我的测试', '我的测试', '/uploads/5b1375c4a171c.jpg', '2', '1', '0', '1528002030', '1528018675', '1', '1', '3', '2', '3', '[\"A:正确\",\"B:错误\"]');
INSERT INTO `ks_question` VALUES ('1320', '我的测试', '我的测试01', '/uploads/5b13b0be4c9d4.jpg', '4', '1', '0', '1528017090', '1528017090', '1', '1', '3', '0', '0', '[\"测试\"]');

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
  `desc` text NOT NULL COMMENT '说明信息',
  `sort` tinyint(2) unsigned NOT NULL DEFAULT '100' COMMENT '排序',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态 (1 开启 0 关闭)',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `config` text NOT NULL COMMENT '配置信息',
  `image` varchar(100) NOT NULL COMMENT '图片信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='科目信息表(主分类)';

-- ----------------------------
-- Records of ks_subject
-- ----------------------------
INSERT INTO `ks_subject` VALUES ('1', '1', '科目一', '科目一，又称科目一理论考试、驾驶员理论考试，是机动车驾驶证考核的一部分 。根据《机动车驾驶证申领和使用规定》，考 试内容包括驾车理论基础、道路安全法律法规、地方性法规等相关知识。考试形式为上机考试，100道题，90分及以上过关。', '1', '1', '1492835463', '', '');
INSERT INTO `ks_subject` VALUES ('2', '1', '科目四', '科目四，又称科目四理论考试、驾驶员理论考试，是机动车驾驶证考核的一部分。公安部123号令实施后，科目三考试分为两项内容，除了路考，增加了安全文明驾驶考试，俗称“科目四”，考量“车德”。因为这个考试在科目三之后进行，所以大家都习惯称之为科目四考试。实际的官方说法中没有科目四一说。', '2', '1', '1492835656', '{\"passingScore\":\"72\",\"time\":\"60\",\"judgmentNumber\":\"10\",\"selectNumber\":\"40\",\"multipleNumber\":\"30\",\"shortNumber\":\"5\",\"judgmentScore\":\"2\",\"selectScore\":\"2\",\"multipleScore\":\"3\",\"shortScore\":\"5\"}', '');

-- ----------------------------
-- Table structure for ks_user
-- ----------------------------
DROP TABLE IF EXISTS `ks_user`;
CREATE TABLE `ks_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `phone` char(11) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名称',
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
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `phone` (`phone`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ks_user
-- ----------------------------

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

-- ----------------------------
-- Records of ks_user_collect
-- ----------------------------
