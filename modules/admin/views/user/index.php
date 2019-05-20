<?php

use yii\helpers\Json;
use jinxing\admin\widgets\MeTable;

// 定义标题和面包屑信息
$this->title                   = '用户信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<?= MeTable::widget() ?>
<?php $this->beginBlock('javascript') ?>
    <script type="text/javascript">
        var arrStatus = <?=Json::encode($status)?>,
            aStatusColor = <?=Json::encode($statusColor)?>,
            myTable = meTables({
                title: "用户信息",
                fileSelector: ["#ace-file"],
                table: {
                    aoColumns: [
                        {
                            title: "用户ID",
                            data: "id",
                            edit: {type: "hidden"},
                            search: {type: "text"},
                            defaultOrder: "desc"
                        },
                        {
                            title: "用户昵称",
                            data: "username",
                            edit: {required: true, rangeLength: "[2, 255]"},
                            search: {type: "text"},
                            sortable: false
                        },
                        {
                            title: "邮箱",
                            data: "email",
                            edit: {required: true, rangeLength: "[2, 255]"},
                            search: {type: "text"},
                            sortable: false
                        },
                        {
                            title: "手机号",
                            data: "phone",
                            search: {type: "text"},
                            edit: {required: true, rangeLength: "[2, 255]"},
                            sortable: false
                        },
                        {
                            title: "密码",
                            data: "password",
                            edit: {type: "password", rangeLength: "[2, 20]"},
                            sortable: false,
                            defaultContent: "",
                            bViews: false,
                            isHide: true
                        },
                        {
                            title: "确认密码",
                            data: "repassword",
                            edit: {
                                type: "password",
                                rangeLength: "[2, 20]",
                                equalTo: "input[name=password]:first"
                            },
                            sortable: false,
                            defaultContent: "",
                            bViews: false,
                            isHide: true
                        },
                        {
                            title: "头像",
                            data: "face",
                            edit: {
                                type: "file",
                                options: {
                                    "id": "ace-file",
                                    "name": "UploadForm[face]",
                                    "input-type": "ace_file",
                                    "input-name": "face"
                                }
                            }
                        },
                        {
                            title: "状态",
                            data: "status",
                            value: arrStatus,
                            edit: {type: "radio", default: 10, required: true, number: true},
                            sortable: false,
                            search: {type: "select"},
                            createdCell: function (td, data) {
                                $(td).html(mt.valuesString(arrStatus, aStatusColor, data));
                            }
                        },
                        {
                            title: "创建时间",
                            data: "created_at",
                            createdCell: mt.dateTimeString
                        },
                        {
                            title: "修改时间",
                            data: "updated_at",
                            createdCell: mt.dateTimeString
                        },
                        {
                            title: "上一次登录时间",
                            data: "last_time",
                            createdCell: mt.dateTimeString
                        },
                        {
                            title: "上一次登录IP",
                            data: "last_ip",
                            sortable: false
                        }
                    ],
                }
            });

        var $img = null;

        // 显示之前的处理
        myTable.beforeShow = function (data) {
            // 新增
            $img.ace_file_input("reset_input");
            // 修改复值
            if (this.action == 'update' && !empty(data.face)) {
                $img.ace_file_input("show_file_list", [data.face]);
            }
            return true;
        };

        $(function () {
            myTable.init();
            $img = $("#ace-file");
        });
    </script>
<?php $this->endBlock(); ?>