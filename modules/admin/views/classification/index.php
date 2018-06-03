<?php

use jinxing\admin\widgets\MeTable;

// 定义标题和面包屑信息
$this->title = '考试类型';
$this->params['breadcrumbs'][] = $this->title;
?>
<?= MeTable::widget() ?>
<?php $this->beginBlock('javascript') ?>
    <script type="text/javascript">
        var arrStatus = <?=\yii\helpers\Json::encode(Yii::$app->params['status'])?>;
        var m = mt({
            title: "考试类型",
            fileSelector: ["#icon-image"],
            table: {
                "aoColumns": [
                    {
                        "title": "ID",
                        "data": "id",
                        "edit": {"type": "hidden", "required": true, "number": true},
                        "search": {"type": "text"},
                        "defaultOrder": "desc"
                    },
                    {
                        "title": "名称",
                        "data": "name",
                        "edit": {"type": "text", "required": true, "rangelength": "[2, 255]"},
                        "search": {"type": "text"}
                    },
                    {
                        "title": "说明",
                        "data": "desc",
                        "bSortable": false,
                        "isHide": true,
                        "edit": {"type": "textarea", "required": true, "rangelength": "[2, 255]"}
                    },
                    {
                        "title": "图标",
                        "data": "image",
                        "bSortable": false,
                        "edit": {
                            "type": "file", "rangelength": "[2, 255]",
                            "options": {
                                "id": "icon-image",
                                "name": "UploadForm[image]",
                                "input-type": "ace_file",
                                "input-name": "image"
                            }
                        }
                    },
                    {
                        "title": "排序",
                        "data": "sort",
                        "edit": {"type": "text", "required": true, "number": true, "value": 100}
                    },
                    {
                        "data": "status",
                        "title": "状态",
                        "value": arrStatus,
                        "edit": {"type": "radio", "default": 1, "required": 1, "number": 1},
                        "search": {"type": "select"},
                        "createdCell": mt.statusString
                    },
                    {"title": "创建时间", "data": "created_at", "createdCell": mt.dateTimeString}
                ]
            }
        });

        var $image = null;
        mt.fn.extend({
            // 显示的前置和后置操作
//            beforeShow: function(data, child) {
//
//                return true;
//            },
            afterShow: function (data, child) {
                $image.ace_file_input("reset_input");

                // 修改复值
                if (this.action == "update" && !empty(data.image)) {
                    $image.ace_file_input("show_file_list", [data.image]);
                }

                return true;
            }

//            // 编辑的前置和后置操作
//            beforeSave: function(data, child) {
//                return true;
//            },
//            afterSave: function(data, child) {
//                return true;
//            }
        });


        $(function () {
            m.init();
            $image = $("#icon-image")
        });
    </script>
<?php $this->endBlock(); ?>