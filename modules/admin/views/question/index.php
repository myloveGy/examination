<?php

use yii\helpers\Url;

// 定义标题和面包屑信息
$this->title = '题库信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--前面导航信息-->
<p id="me-table-buttons"></p>
<p><span class="text-danger"> 说明： 先添加问题, 然后添加对应问题的答案！最后在编辑中选择一个答案作为正确答案 </span></p>
<!--表格数据-->
<table class="table table-striped table-bordered table-hover" id="show-table"></table>
<div class="col-xs-12 hidden">
    <table id="child-table" class="table table-striped table-bordered table-hover"></table>
</div>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">

    function showSpan(s, c, d) {
        return '<span class="label label-sm ' + (c[d] ? c[d] : d ) + '">' + (s[d] ? s[d]: d) + '</span>'
    }

    var aSubject = <?=$subject?>,
        sUpload = '<?=Url::toRoute(['question/upload', 'sField' => 'question_img'])?>',
        aSpecial = <?=$special?>,
        aChapter = <?=$chapter?>,
        aStatus  = <?=$status?>,
        aColor   = <?=$color?>,
        aType    = <?=$type?>,
        myTable = meTables({
            sTitle:"题库信息",
            operations: {
                width: "200px",
                buttons: {
                    "other": {
                        "title": "添加答案",
                        "button-title": "添加答案",
                        "className": "btn-warning",
                        "cClass":"role-edit",
                        "icon":"fa-pencil-square-o",
                        "sClass":"yellow"
                    }
                }
            },

            // 主表格
            table: {
                "aoColumns": [
                    {
                        "title": "题目ID",
                        "data": "id",
                        "sName": "id",
                        "class": "child-control",
                        "edit": {"type": "hidden"},
                        "bSortable": false,
                        "defaultOrder": "desc",
                        "createdCell": function (td, data, rowArr, row, col) {
                            $(td).html(data + '<b class="arrow fa fa-angle-down pull-right"></b>');
                        }
                    },
                    {
                        "title": "题目问题",
                        "data": "question_title",
                        "sName": "question_title",
                        "edit": {"type": "textarea", "required": true},
                        "bSortable": false
                    },
                    {
                        "title": "题目说明",
                        "data": "question_content",
                        "sName": "question_content",
                        "edit": {"type": "textarea"},
                        "bSortable": false,
                        "isHide": true
                    },
                    {
                        "title": "题目图片",
                        "data": "question_img",
                        "sName": "question_img",
                        "edit": {"type": "file", options: {"id": "myfile", "type": "ace_input"}},
                        "bSortable": false,
                        "isHide": true,
                        "createdCell": function (td, data) {
                            var html = data ? "<img src=" + data + " style=\"width: 60px;margin-right: 10px;\" />" +
                                "<a href=\"javascript:;\" class=\"btn btn-xs btn-info btn-image\" data-img=" + data + ">查看大图</a>" : "";
                            $(td).html(html);
                        }
                    },
                    {
                        "title": "答案类型",
                        "data": "answer_type",
                        "sName": "answer_type",
                        "value": aType,
                        "edit": {"type": "select", "required": true, "number": true},
                        "search": {"type": "select"},
                        "bSortable": false,
                        "createdCell": function (td, data) {
                            $(td).html(aType[data] ? aType[data] : data);
                        }
                    },
                    {
                        "title": "状态",
                        "data": "status",
                        "sName": "status",
                        "value": aStatus,
                        "edit": {"type": "radio", "default": 1, "required": true, "number": true},
                        "bSortable": false,
                        "search": {"type": "select"},
                        "createdCell": function (td, data) {
                            $(td).html(showSpan(aStatus, aColor, data));
                        }
                    },
                    {
                        "title": "正确答案",
                        "data": "answer_id",
                        "sName": "answer_id",
                        "bSortable": false,
                        "createdCell": function (td, data) {
                            $(td).html(data == 0 ? '<span class="label label-sm label-warning">还没有设置答案</span>' : data)
                        },
                        "value": {"0": "请选择"},
                        "edit": {"type": "select"}
                    },
                    {"title": "创建时间", "data": "created_at", "sName": "created_at", "createdCell": mt.dateTimeString},
                    {"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell": mt.dateTimeString},
                    {
                        "title": "所属科目",
                        "data": "subject_id",
                        "sName": "subject_id",
                        "value": aSubject,
                        "edit": {"type": "select", "default": 1, "required": true, "number": true},
                        "bSortable": false
                    },
                    {
                        "title": "所属章节",
                        "data": "chapter_id",
                        "sName": "chapter_id",
                        "value": aChapter,
                        "edit": {"type": "select", "required": true, "number": true},
                        "bSortable": false
                    },
                    {
                        "title": "所属专项分类",
                        "data": "special_id",
                        "sName": "special_id",
                        "value": aSpecial,
                        "edit": {"type": "select", "required": true, "number": true},
                        "bSortable": false
                    },
                    {"title": "错误人数", "data": "error_number", "sName": "error_number"}
                ]
            },

            // 子表格
            bChildTables: true,
            childTables: {
                url: {
                    "search": "/admin/answer/search",
                    "create": "/admin/answer/create",
                    "update": "/admin/answer/update",
                    "delete": "/admin/answer/delete"
                },
                table: {
                    aoColumns: [
                        {title: "ID", "data": "id", "sName": "id", "edit": {"type": "hidden"}},
                        {title: "答案", "data": "name", "sName": "name",
                            "edit": {"type": "text", "required": true, "rangelength": "[2, 1000]"}
                        },
                        mt.fn.options.childTables.operations
                    ]
                }
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

         // 查询大图
         $(document).on("click", ".btn-image", function(){
             var img = "<img src=" + $(this).attr("data-img") + ">";
             layer.open({
                 type: 1,
                 title: false,
                 closeBtn: 0,
                 area: '516px',
                 skin: 'layui-layer-nobg', //没有背景色
                 shadeClose: true,
                 content: img
             });
         });
     });
</script>
<?php $this->endBlock(); ?>