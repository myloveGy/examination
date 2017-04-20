<?php
// 定义标题和面包屑信息
$this->title = '专项分类';
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
    var aParents = <?=\yii\helpers\Json::encode($parents)?>,
        myTable  = new MeTable({sTitle:"专项分类"},{
        "aoColumns":[
			oCheckBox,
			{"title": "id", "data": "id", "sName": "id", "edit": {"type": "hidden"}, "search": {"type": "text"}},
			{"title": "父类ID", "data": "pid", "sName": "pid", "value": aParents, "edit": {"type": "select", "options": {"required":true,"number":true, "id": "parent_id"}}, "search": {"type": "select"}, "bSortable": false, "createdCell": function(td, data) {
			    $(td).html(aParents[data] ? aParents[data] : data);
            }},
			{"title": "专项分类名称", "data": "name", "sName": "name", "edit": {"type": "text", "options": {"required":true,"rangelength":"[2, 255]"}}, "search": {"type": "text"}, "bSortable": false}, 
			{"title": "排序", "data": "sort", "sName": "sort", "value": 100, "edit": {"type": "text", "options": {"required":true,"number":true}}},
			{"title": "添加时间", "data": "created_at", "sName": "created_at", "createdCell" : dateTimeString},
			{"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell" : dateTimeString},
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
     myTable.afterSave = function(data) {
         if (data.pid == 0) {
             switch (this.actionType) {
                 case 'insert':
                     $('#parent_id').append('<option value="' + data.id + '">' + data.name + '</option>');
                     aParents[data.id] = data.name;
                     break;
                 case 'delete':
                     $('#parent_id').find('option[value='+data.id+']').remove();
                     delete aParents[data.id];
                     break;
                 case 'deleteAll':
                     window.location.reload();
                     break;
             }
         }

         return true;
     };

    $(function(){
        myTable.init();
    });
</script>
<?php $this->endBlock(); ?>