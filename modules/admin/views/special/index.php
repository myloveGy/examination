<?php
// 定义标题和面包屑信息
$this->title = '专项分类';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--前面导航信息-->
<p id="me-table-buttons"></p>
<!--表格数据-->
<table class="table table-striped table-bordered table-hover" id="show-table"></table>

<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var aParents = <?=\yii\helpers\Json::encode($parents)?>,
        myTable  = meTables({
            title:"专项分类",
            table: {
                "aoColumns": [
                    {
                        "title": "id",
                        "data": "id",
                        "sName": "id",
                        "edit": {"type": "hidden"},
                        "search": {"type": "text"}
                    },
                    {
                        "title": "父类ID",
                        "data": "pid",
                        "sName": "pid",
                        "value": aParents,
                        "edit": {"type": "select", "options": {"required": true, "number": true, "id": "parent_id"}},
                        "search": {"type": "select"},
                        "bSortable": false,
                        "createdCell": function (td, data) {
                            $(td).html(aParents[data] ? aParents[data] : data);
                        }
                    },
                    {
                        "title": "专项分类名称",
                        "data": "name",
                        "sName": "name",
                        "edit": {"type": "text", "options": {"required": true, "rangelength": "[2, 255]"}},
                        "search": {"type": "text"},
                        "bSortable": false
                    },
                    {
                        "title": "排序",
                        "data": "sort",
                        "sName": "sort",
                        "value": 100,
                        "edit": {"type": "text", "options": {"required": true, "number": true}}
                    },
                    {"title": "添加时间", "data": "created_at", "sName": "created_at", "createdCell": mt.dateTimeString},
                    {"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell": mt.dateTimeString},
                ]
            }
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
             switch (this.action) {
                 case 'create':
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