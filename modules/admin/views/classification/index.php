<?php

use jinxing\admin\widgets\MeTable;
use \yii\helpers\Json;

// 定义标题和面包屑信息
$this->title = '考试类型';
$this->params['breadcrumbs'][] = $this->title;
?>
<?= MeTable::widget() ?>
<?php $this->beginBlock('javascript') ?>
    <script type="text/javascript">
        var arrStatus = <?=Json::encode(Yii::$app->params['status'])?>;
        var m = mt({
            title: "考试类型",
            fileSelector: ["#icon-image"],
            table: {
                aoColumns: [
                    {
                        title: "ID",
                        data: "id",
                        edit: {type: "hidden"},
                        search: {type: "text"},
                        defaultOrder: "desc"
                    },
                    {
                        title: "名称",
                        data: "name",
                        sortable: false,
                        edit: {required: true, rangeLength: "[2, 255]"},
                        search: {type: "text"}
                    },
                    {
                        title: "说明",
                        data: "desc",
                        sortable: false,
                        isHide: true,
                        edit: {type: "textarea", required: true, rangeLength: "[2, 255]"}
                    },
                    {
                        title: "图标",
                        data: "image",
                        sortable: false,
                        edit: {
                            type: "file",
                            options: {
                                "id": "icon-image",
                                "name": "UploadForm[image]",
                                "input-type": "ace_file",
                                "input-name": "image"
                            }
                        }
                    },
                    {
                        title: "排序",
                        data: "sort",
                        edit: {required: true, number: true, value: 100}
                    },
                    {
                        data: "status",
                        title: "状态",
                        value: arrStatus,
                        sortable: false,
                        edit: {type: "radio", default: 1, required: 1, number: 1},
                        search: {type: "select"},
                        createdCell: mt.statusString
                    },
                    {
                        title: "创建时间",
                        data: "created_at",
                        createdCell: mt.dateTimeString
                    }
                ]
            }
        });

        var $image = null;
        mt.fn.extend({
            afterShow: function (data) {
                $image.ace_file_input("reset_input");

                // 修改复值
                if (this.action == "update" && !empty(data.image)) {
                    $image.ace_file_input("show_file_list", [data.image]);
                }

                return true;
            }
        });


        $(function () {
            m.init();
            $image = $("#icon-image")
        });
    </script>
<?php $this->endBlock(); ?>