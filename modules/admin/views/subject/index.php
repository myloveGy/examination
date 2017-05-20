<?php
// 定义标题和面包屑信息
$this->title = '科目信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--前面导航信息-->
<p id="me-table-buttons"></p>
<!--表格数据-->
<table class="table table-striped table-bordered table-hover" id="show-table"></table>

<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var arrCarType = <?=\yii\helpers\Json::encode($arrCarType)?>,
        arrStatus = <?=\yii\helpers\Json::encode(Yii::$app->params['status'])?>;
    var myTable = meTables({
        title: "科目信息",
        fileSelector: ["#icon-image"],
        table: {
            "aoColumns":[
                {"title": "id", "data": "id", "sName": "id", "edit": {"type": "hidden"}, "search": {"type": "text"}},
                {"title": "所属类型", "data": "car_id", "sName": "car_id", "value": arrCarType,
                    "edit": {"type": "select", "required": true, "number": true},
                    "search": {"type": "select"},
                    "createdCell": function(td, data) {
                        $(td).html(arrCarType[data] ? arrCarType[data] : data);
                    }
                },
                {"title": "科目名称", "data": "name", "sName": "name", "edit": {"type": "text", "required":true,"rangelength":"[2, 255]"}, "search": {"type": "text"}},
                {"title": "科目说明", "data": "desc", "sName": "desc", "edit": {"type": "text", "required":true,"rangelength":"[2, 1000]"}, "bSortable": false},
                {"title": "图标", "data": "image", "sName": "image", "bSortable": false,
                    "edit": {"type": "file", "rangelength": "[2, 255]",
                        "options": {"id": "icon-image", "name": "UploadForm[image]", "input-type": "ace_file", "input-name": "image"}
                    },
                    "isHide": true
                },
                {"title": "排序", "data": "sort", "sName": "sort", "edit": {"type": "text", "value": 100, "required":true, "number": true}},
                {"data": "status", "sName":"status","title": "状态", "value" : arrStatus, "edit":{"type":"radio", "default": 1, "required": 1, "number": 1},"search":{"type":"select"}, "createdCell": mt.statusString},
                {"title": "创建时间", "data": "created_at", "sName": "created_at", "createdCell": mt.dateTimeString}
            ]
        }
    });

    var $image = null;
    mt.fn.extend({
        afterShow: function(data, child) {
            $image.ace_file_input("reset_input");

            // 修改复值
            if (this.action == "update" && ! empty(data.image)) {
                $image.ace_file_input("show_file_list", [data.image]);
            }

            return true;
        }
    });

    $(function(){
        myTable.init();
        $image = $("#icon-image");
    });
</script>
<?php $this->endBlock(); ?>