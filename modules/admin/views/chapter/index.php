<?php

use jinxing\admin\widgets\MeTable;
use \yii\helpers\Json;

// 定义标题和面包屑信息
$this->title                   = '章节信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<?= MeTable::widget() ?>
<?php $this->beginBlock('javascript') ?>
    <script type="text/javascript">
        var arrSubject = <?=Json::encode($subject)?>;
        var myTable = meTables({
            title: "章节信息",
            operations: {
                width: "auto",
                buttons: {
                    create: {
                        "className": "btn-success",
                        "cClass": "create-question",
                        "icon": "fa-plus-circle",
                        "sClass": "blue",
                        "button-title": "添加题目"
                    }
                }
            },
            table: {
                aoColumns: [
                    {
                        title: "章节分类ID",
                        data: "id",
                        defaultOrder: "desc",
                        edit: {type: "hidden"},
                        search: {type: "text"}
                    },
                    {
                        title: "所属科目",
                        data: "subject_id",
                        value: arrSubject,
                        edit: {type: "select", required: true, number: true},
                        search: {type: "select"},
                        createdCell: function (td, data) {
                            $(td).html(arrSubject[data] ? arrSubject[data] : data);
                        }
                    },
                    {
                        title: "章节分类名称",
                        data: "name",
                        edit: {required: true, rangeLength: "[2, 255]"},
                        search: {type: "text"},
                        sortable: false
                    },
                    {
                        title: "排序",
                        data: "sort",
                        edit: {value: 100, required: true, number: true}
                    },
                    {title: "添加时间", data: "created_at", createdCell: mt.dateTimeString},
                    {title: "修改时间", data: "updated_at", createdCell: mt.dateTimeString}
                ]
            }
        });

        var layerLoading = null;

        function closeLayer() {
            layer.close(layerLoading);
        }

        $(function () {
            myTable.init();

            // 添加题目
            $(document).on('click', '.create-question', function () {
                var i = $(this).attr("table-data");
                if (i) {
                    var data = myTable.table.data()[i];
                    if (data) {
                        layerLoading = layer.open({
                            title: "添加题目",
                            type: 2,
                            area: ["90%", "90%"],
                            maxmin: true,
                            content: "<?=\yii\helpers\Url::toRoute(['question/create'])?>?chapter_id=" + data["id"]
                        });

                        return false;
                    }
                }

                layer.msg("请确认操作");
            });
        });
    </script>
<?php $this->endBlock(); ?>