<?php

use yii\helpers\Url;
use yii\helpers\Json;

// 定义标题和面包屑信息
$this->title = '用户信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--前面导航信息-->
<p id="me-table-buttons"></p>
<!--表格数据-->
<table class="table table-striped table-bordered table-hover" id="show-table"></table>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var sUpload = '<?=Url::toRoute(['user/upload', 'sField' => 'face'])?>',
        arrStatus = <?=Json::encode($status)?>,
        aStatusColor = <?=Json::encode($statusColor)?>,
        myTable = meTables({
        title: "用户信息",
        fileSelector: ["#ace-file"],
        table: {
            "aoColumns": [
                {"title": "用户ID", "data": "id", "sName": "id", "edit": {"type": "hidden"}, "defaultOrder": "desc"},
                {
                    "title": "用户昵称",
                    "data": "username",
                    "sName": "username",
                    "edit": {"type": "text", "required": true, "rangelength": "[2, 255]"},
                    "bSortable": false
                },
                {
                    "title": "邮箱",
                    "data": "email",
                    "sName": "email",
                    "edit": {"type": "text", "required": true, "rangelength": "[2, 255]"},
                    "bSortable": false
                },
                {
                    "title": "手机号",
                    "data": "phone",
                    "sName": "phone",
                    "edit": {"type": "text", "required": true, "rangelength": "[2, 255]"},
                    "bSortable": false
                },
                {
                    "title": "密码",
                    "data": "password",
                    "sName": "password",
                    "edit": {"type": "password", "rangelength": "[2, 20]"},
                    "bSortable": false,
                    "defaultContent": "",
                    "bViews": false,
                    "isHide": true
                },
                {
                    "title": "确认密码",
                    "data": "repassword",
                    "sName": "repassword",
                    "edit": {
                        "type": "password",
                        "rangelength": "[2, 20]",
                        "equalTo": "input[name=password]:first"
                    },
                    "bSortable": false,
                    "defaultContent": "",
                    "bViews": false,
                    "isHide": true
                },
                {
                    "title": "头像",
                    "data": "face",
                    "sName": "face",
                    "edit": {"type": "file", options: {"id": "ace-file", "name": "UploadForm[face]","input-type": "ace_file", "input-name": "face"}}
                },
                {
                    "title": "状态",
                    "data": "status",
                    "sName": "status",
                    "value": arrStatus,
                    "edit": {"type": "radio", "default": 10, "options": {"required": true, "number": true}},
                    "bSortable": false,
                    "createdCell": function(td, data) {
                        $(td).html(mt.valuesString(arrStatus, aStatusColor, data));
                    }
                },
                {"title": "创建时间", "data": "created_at", "sName": "created_at", "createdCell": mt.dateTimeString},
                {"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell": mt.dateTimeString},
                {"title": "上一次登录时间", "data": "last_time", "sName": "last_time", "createdCell": mt.dateTimeString},
                {"title": "上一次登录IP", "data": "last_ip", "sName": "last_ip", "bSortable": false}
            ],
        }
    });

    var $img = null;

    // 显示之前的处理
    myTable.beforeShow = function(data, isDetail) {
        // 新增
        $img.ace_file_input("reset_input");
        // 修改复值
        if (this.action == 'update' && ! empty(data.face)) $img.ace_file_input("show_file_list", [data.face]);
        return true;
    };

    /**
     * 显示的前置和后置操作
     * myTable.beforeShow(object data, bool isDetail) return true 前置
     * myTable.afterShow(object data, bool isDetail)  return true 后置
     */

     /**
      * 编辑的前置和后置操作
      * myTable.beforeSave(object data) return true 前置
      * myTable.afterSave(object data)  return true 后置
      */

     $(function(){
         myTable.init();
         $img = $("#ace-file");
     });
</script>
<?php $this->endBlock(); ?>