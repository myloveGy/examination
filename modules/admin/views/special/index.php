<?php

use jinxing\admin\widgets\MeTable;
use yii\helpers\Json;

// 定义标题和面包屑信息
$this->title                   = '专项分类';
$this->params['breadcrumbs'][] = $this->title;
?>
<?= MeTable::widget() ?>
<?php $this->beginBlock('javascript') ?>
    <script type="text/javascript">
        var aParents = <?=Json::encode($parents)?>,
            myTable = meTables({
                title: "专项分类",
                table: {
                    aoColumns: [
                        {
                            title: "id",
                            data: "id",
                            edit: {type: "hidden"},
                            search: {type: "text"},
                            defaultOrder: "desc"
                        },
                        {
                            title: "父类ID",
                            data: "pid",
                            value: aParents,
                            edit: {type: "select", required: true, number: true, id: "parent_id"},
                            search: {type: "select"},
                            sortable: false,
                            createdCell: function (td, data) {
                                $(td).html(aParents[data] ? aParents[data] : data);
                            }
                        },
                        {
                            title: "专项分类名称",
                            data: "name",
                            edit: {required: true, rangeLength: "[2, 255]"},
                            search: {type: "text"},
                            sortable: false
                        },
                        {
                            title: "排序",
                            data: "sort",
                            edit: {required: true, number: true, value: 100}
                        },
                        {
                            title: "添加时间",
                            data: "created_at",
                            createdCell: mt.dateTimeString
                        },
                        {
                            title: "修改时间",
                            data: "updated_at",
                            createdCell: mt.dateTimeString
                        }
                    ]
                }
            });

        myTable.afterSave = function (data) {
            if (data.pid == 0) {
                switch (this.action) {
                    case 'create':
                        $('#parent_id').append('<option value="' + data.id + '">' + data.name + '</option>');
                        aParents[data.id] = data.name;
                        break;
                    case 'delete':
                        $('#parent_id').find('option[value=' + data.id + ']').remove();
                        delete aParents[data.id];
                        break;
                    case 'deleteAll':
                        window.location.reload();
                        break;
                }
            }

            return true;
        };

        $(function () {
            myTable.init();
        });
    </script>
<?php $this->endBlock(); ?>