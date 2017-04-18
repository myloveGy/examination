<?php
// 定义标题和面包屑信息
$this->title = '答案信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--前面导航信息-->
<p>
    <button class="btn btn-white btn-success btn-bold me-table-insert">
        <i class="ace-icon fa fa-plus bigger-120 blue"></i>
        添加
    </button>
    <button class="btn btn-white btn-danger btn-bold me-table-delete">
        <i class="ace-icon fa fa-trash-o bigger-120 red"></i>
        删除
    </button>
    <button class="btn btn-white btn-info btn-bold me-hide">
        <i class="ace-icon fa  fa-external-link bigger-120 orange"></i>
        隐藏
    </button>
    <button class="btn btn-white btn-pink btn-bold  me-table-reload">
        <i class="ace-icon fa fa-refresh bigger-120 pink"></i>
        刷新
    </button>
    <button class="btn btn-white btn-warning btn-bold me-table-export">
        <i class="ace-icon glyphicon glyphicon-export bigger-120 orange2"></i>
        导出Excel
    </button>
</p>
<!--表格数据-->
<table class="table table-striped table-bordered table-hover" id="showTable"></table>

<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var myTable = new MeTable({sTitle:"答案信息"},{
        "aoColumns":[
			oCheckBox,
			{"title": "答案ID", "data": "id", "sName": "id", "edit": {"type": "hidden", "options": {}}, "bSortable": false}, 
			{"title": "问题ID", "data": "qid", "sName": "qid", "edit": {"type": "hidden", "options": {}}, "bSortable": false}, 
			{"title": "答案说明", "data": "name", "sName": "name", "edit": {"type": "text", "options": {"required":true, "minlength":  2}}, "bSortable": false}, 
			oOperate
        ]

        // 设置隐藏和排序信息
        // "order":[[0, "desc"]],
        // "columnDefs":[{"targets":[2,3], "visible":false}],
    });

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

     $(window).ready(function(){
         myTable.init();
     });
</script>
<?php $this->endBlock(); ?>