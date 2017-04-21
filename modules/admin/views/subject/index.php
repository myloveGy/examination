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
    var myTable = meTables({
        title: "科目信息",
        table: {
            "aoColumns":[
                {"title": "id", "data": "id", "sName": "id", "edit": {"type": "hidden"}, "search": {"type": "text"}},
                {"title": "科目分类信息", "data": "name", "sName": "name", "edit": {"type": "text", "required":true,"rangelength":"[2, 255]"}, "search": {"type": "text"}, "bSortable": false}
            ]
        }
    });

     $(function(){
         myTable.init();
     });
</script>
<?php $this->endBlock(); ?>