<?php
// 定义标题和面包屑信息
$this->title = '车型配置';
$this->params['breadcrumbs'][] = $this->title;
?>
    <!-- 表格按钮 -->
    <p id="me-table-buttons"></p>
    <!-- 表格数据 -->
    <table class="table table-striped table-bordered table-hover" id="show-table"></table>

<?php $this->beginBlock('javascript') ?>
    <script type="text/javascript">
        var arrStatus = <?=\yii\helpers\Json::encode(Yii::$app->params['status'])?>;
        var m = mt({
            title: "车型配置",
            fileSelector: ["#image"],
            table: {
                "aoColumns": [
                    {"title": "ID", "data": "id", "sName": "id", "edit": {"type": "hidden", "required": true,"number": true}, "search": {"type": "text"}, "defaultOrder": "desc"},
                    {"title": "名称", "data": "name", "sName": "name", "edit": {"type": "text", "required": true,"rangelength": "[2, 255]"}, "search": {"type": "text"}},
                    {"title": "说明", "data": "desc", "sName": "desc", "bSortable": false,
                        "isHide": true,
                        "edit": {"type": "textarea", "required": true,"rangelength": "[2, 255]"}
                    },
                    {"title": "图标", "data": "image", "sName": "image", "bSortable": false,
                        "edit": {"type": "file", "rangelength": "[2, 255]",
                            "options": {"id": "icon-image", "name": "UploadForm[image]", "input-type": "ace_file", "input-name": "image"}
                        }
                    },
                    {"title": "排序", "data": "sort", "sName": "sort", "edit": {"type": "text", "required": true, "number": true}},
                    {"data": "status", "sName":"status","title": "状态", "value" : arrStatus, "edit":{"type":"radio", "default": 1, "required": 1, "number": 1},"search":{"type":"select"}, "createdCell": mt.statusString},
                    {"title": "创建时间", "data": "created_at", "sName": "created_at", "createdCell" : mt.dateTimeString}
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
            afterShow: function(data, child) {
                $image.ace_file_input("reset_input");

                // 修改复值
                if (this.action == "update" && ! empty(data.image)) {
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


        $(function(){
            m.init();
            $image = $("#icon-image")
        });
    </script>
<?php $this->endBlock(); ?>