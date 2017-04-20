<?php

use yii\helpers\Url;

// 定义标题和面包屑信息
$this->title = '题库信息';
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
<p>
    <span class="text-danger"> 说明： 先添加问题, 然后添加对应问题的答案！最后在编辑中选择一个答案作为正确答案 </span>
</p>
<!--表格数据-->
<table class="table table-striped table-bordered table-hover" id="showTable"></table>

<div class="col-xs-12 hidden">
    <table id="detailTable" class="table table-striped table-bordered table-hover"></table>
</div>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    // 设置表单信息
    function setOperate(td, data, rowArr, row, col)
    {
        $(td).html(createButtons([
            {"data":row, "title":"查看", "className":"btn-success", "cClass":"me-table-view",  "icon":"fa-search-plus",  "sClass":"blue"},
            {"data":row, "title":"编辑", "className":"btn-info", "cClass":"me-table-edit", "icon":"fa-pencil-square-o",  "sClass":"green"},
            {"data":row, "title":"添加答案", "className":"btn-warning", "cClass":"me-table-insert-detail", "icon":"fa-plus",  "sClass":"yellow", "text": "添加答案"},
            {"data":row, "title":"删除", "className":"btn-danger", "cClass":"me-table-del", "icon":"fa-trash-o",  "sClass":"red"}
        ]));
    }

    var aSubject = <?=$subject?>,
        sUpload = '<?=Url::toRoute(['question/upload', 'sField' => 'question_img'])?>',
        aSpecial = <?=$special?>,
        aChapter = <?=$chapter?>,
        aStatus  = <?=$status?>,
        aColor   = <?=$color?>,
        aType    = <?=$type?>,
        myTable = new MeTable({sTitle:"题库信息"},{
        "aoColumns":[
			oCheckBox,
			{"title": "题目ID", "data": "id", "sName": "id", "class":"details-control", "edit": {"type": "hidden", "options": {}}, "bSortable": false, "createdCell":function(td, data, rowArr, row, col){
                $(td).html(data + '<b class="arrow fa fa-angle-down pull-right"></b>');
            }},
			{"title": "题目问题", "data": "question_title", "sName": "question_title", "edit": {"type": "textarea", "options": {"required":true}}, "bSortable": false},
			{"title": "题目说明", "data": "question_content", "sName": "question_content", "edit": {"type": "textarea", "options": {}}, "bSortable": false},
			{"title": "题目图片", "data": "question_img", "sName": "question_img", "edit": {"type": "file", options:{"id":"myfile", "type":"ace_input"}}, "bSortable": false},
			{"title": "答案类型", "data": "answer_type", "sName": "answer_type", "value": aType, "edit": {"type": "select", "options": {"required":true,"number":true}}, "bSortable": false},
			{"title": "状态", "data": "status", "sName": "status", "value": aStatus, "edit": {"type": "radio", "default": 1, "options": {"required":true,"number":true}}, "bSortable": false, "createdCell": function(td, data) {
			    $(td).html(showSpan(aStatus, aColor, data));
            }},
			{"title": "正确答案", "data": "answer_id", "sName": "answer_id", "bSortable": false, "createdCell": function(td, data) {
			    $(td).html(data == 0 ? '<span class="label label-sm label-warning">还没有设置答案</span>' : data)
            }, "value": {"0": "请选择"}, "edit": {"type": "select"}},
			{"title": "创建时间", "data": "created_at", "sName": "created_at", "createdCell" : dateTimeString}, 
			{"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell" : dateTimeString}, 
			{"title": "所属科目", "data": "subject_id", "sName": "subject_id", "value": aSubject, "edit": {"type": "select", "default": 1, "options": {"required":true,"number":true}}, "bSortable": false},
			{"title": "所属章节", "data": "chapter_id", "sName": "chapter_id", "value": aChapter, "edit": {"type": "select", "options": {"required":true,"number":true}}, "bSortable": false},
			{"title": "所属专项分类", "data": "special_id", "sName": "special_id", "value": aSpecial, "edit": {"type": "select", "options": {"required":true,"number":true}}, "bSortable": false},
			{"title": "错误人数", "data": "error_number", "sName": "error_number"},
            {"data": null, "title":"操作", "bSortable":false, "width":"180px", "createdCell":setOperate}
        ],

        // 设置隐藏和排序信息
        // "order":[[0, "desc"]],
         "columnDefs":[{"targets":[4], "visible":false}]
    }, {
            "sBaseUrl": "/answer/",
            "oTableOptions": {
                "sAjaxSource": "<?=Url::toRoute(['answer/search'])?>",
                "aoColumns":[
                    {"title": "ID", "data": "id", "sName": "id", "edit":{"type":"hidden"}},
                    {"title": "答案说明", "data": "name", "sName": "name", "edit":{"type":"text", "options":{"required": true, "rangelength": "[2, 1000]"}}},
                    {"title": "对应问题", "data": "qid", "sName": "qid", "edit":{"type":"hidden"}},
                    oOperateDetails
                ],
                "columnDefs":[{"targets":[2], "visible":false}]
            }
    });

    /**
     * 显示的前置和后置操作
     * myTable.beforeShow(object data, bool isDetail) return true 前置
     * myTable.afterShow(object data, bool isDetail)  return true 后置
     */
    myTable.afterShow = function(aData, bDetail, obj) {
        if (bDetail) {
            // 详情处理
            if (this.actionType == "insert") {
                var data = this.table.data()[$(obj).attr('table-data')];
                if (data) {
                    $('#myDetailForm').find('input[name=qid]').val(data['id']);
                } else {
                    layer.msg('数据不存在');
                    return false;
                }
            }
        } else {
            // 不是编辑详情
            switch (this.actionType) {
                case 'insert': // 新增
                    $('#editForm').find('select[name=answer_id]').html('<option value="0">请选择</option>');
                    $("#ace_myfile").ace_file_input("reset_input");
                    break;
                case 'update': // 编辑
                    if (aData) {
                        if (aData.question_img) $("#ace_myfile").ace_file_input("show_file_list", [aData.question_img]);
                        // 获取答案选项
                        $.ajax({
                            "url": '<?=Url::toRoute(['question/child'])?>',
                            "type": "GET",
                            "dataType": "json",
                            "data": {"id": aData["id"]}
                        }).done(function(json) {
                            if (json.errCode == 0 && json.data.length >= 1) {
                                var html = '<option value="0">请选择</option>';
                                for (var i in json.data) {
                                    html += '<option value="' + json.data[i]["id"] + '" ' + (aData.answer_id == json.data[i]["id"] ? " checked=\"checked\"" : "") + '> ' + json.data[i]["name"] + '</option>';
                                }
                                $('#editForm').find('select[name=answer_id]').html(html);
                                $('#editForm').find('select[name=answer_id]').val(aData.answer_id)
                            } else {
                                layer.msg(json.errMsg);
                            }
                        }).fail(function(){
                            layer.msg('服务器繁忙, 请稍候再试...');
                        });
                    }
                    break;
            }
        }

        return true;
    };

     /**
      * 编辑的前置和后置操作
      * myTable.beforeSave(object data) return true 前置
      * myTable.afterSave(object data)  return true 后置
      */
     $(function(){
         myTable.init();

         // 文件上传
         aceFileInput('#ace_myfile', sUpload, false, {"before_remove":function(){
             if ($("#myfile").val()){ $.post(sUpload, {"face":$("#myfile").val()})}
             $("#myfile").val('');
             return true;
         }});
     });
</script>
<?php $this->endBlock(); ?>