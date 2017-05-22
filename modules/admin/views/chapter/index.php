<?php
// 定义标题和面包屑信息
$this->title = '章节信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--前面导航信息-->
<p id="me-table-buttons"></p>
<!--表格数据-->
<table class="table table-striped table-bordered table-hover" id="show-table"></table>

<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var arrSubject = <?=\yii\helpers\Json::encode($subject)?>;
    var myTable = meTables({
        title:"章节信息",
        table: {
            "aoColumns":[
                {"title": "章节分类ID", "data": "id", "sName": "id", "defaultOrder": "desc", "edit": {"type": "hidden"}, "search": {"type": "text"}},
                {"title": "所属科目", "data": "subject_id", "sName": "subject_id", "value": arrSubject,
                    "edit": {"type": "select", "required": true, "number": true},
                    "search": {"type": "select"},
                    "createdCell": function(td, data) {
                        $(td).html(arrSubject[data] ? arrSubject[data] : data);
                    }
                },
                {"title": "章节分类名称", "data": "name", "sName": "name", "edit": {"type": "text", "required":true,"rangelength":"[2, 255]"}, "search": {"type": "text"}, "bSortable": false},
                {"title": "排序", "data": "sort", "sName": "sort", "value": 100, "edit": {"type": "text", "required":true, "number":true}},
                {"title": "添加时间", "data": "created_at", "sName": "created_at", "createdCell" : mt.dateTimeString},
                {"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell" : mt.dateTimeString}
            ]
        }
    });

     $(function(){
         myTable.init();
     });
</script>
<?php $this->endBlock(); ?>