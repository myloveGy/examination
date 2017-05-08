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

    var aTypeColor = {"1": "label-success", "2": "label-info", "3": "label-pink", "4": "label-inverse"};

    var aSubject = <?=$subject?>,
        sUpload = '<?=Url::toRoute(['question/upload', 'sField' => 'question_img'])?>',
        aSpecial = <?=$special?>,
        aChapter = <?=$chapter?>,
        aStatus  = <?=$status?>,
        aColor   = <?=$color?>,
        aType    = <?=$type?>,
        myTable = meTables({
            sTitle:"题库信息",
            fileSelector: ["#image-file"],
            operations: {
                width: "200px",
                buttons: {
                    "other": {
                        "title": "添加答案",
                        "button-title": "添加答案",
                        "className": "btn-warning",
                        "cClass":"me-table-child-create",
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
                        "title": "所属科目",
                        "data": "subject_id",
                        "sName": "subject_id",
                        "value": aSubject,
                        "edit": {"type": "select", "default": 1, "required": true, "number": true},
                        "search": {"type": "select"},
                        "bSortable": false,
                        "createdCell": function(td, data) {
                            $(td).html(aSubject[data] ? aSubject[data] : data);
                        }
                    },
                    {
                        "title": "所属章节",
                        "data": "chapter_id",
                        "sName": "chapter_id",
                        "value": aChapter,
                        "search": {"type": "select"},
                        "edit": {"type": "select", "required": true, "number": true},
                        "bSortable": false,
                        "createdCell": function(td, data) {
                            $(td).html(aChapter[data] ? aChapter[data] : data);
                        }
                    },
                    {
                        "title": "所属专项分类",
                        "data": "special_id",
                        "sName": "special_id",
                        "value": aSpecial,
                        "search": {"type": "select"},
                        "edit": {"type": "select", "required": true, "number": true},
                        "bSortable": false,
                        "createdCell": function(td, data) {
                            $(td).html(aChapter[data] ? aChapter[data] : data);
                        }
                    },
                    {
                        "title": "题目图片",
                        "data": "question_img",
                        "sName": "question_img",
                        "edit": {"type": "file",
                            options: {
                                "id": "image-file",
                                "name": "UploadForm[question_img]",
                                "input-type": "ace_file",
                                "input-name": "question_img"
                            }
                        },
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
                            $(td).html(mt.valuesString(aType, aTypeColor, data));
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
                        "edit": {"type": "select", "id": "input-answer-type"}
                    },
                    {"title": "创建时间", "data": "created_at", "sName": "created_at", "createdCell": mt.dateTimeString},
                    {"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell": mt.dateTimeString},
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
                        {title: "问题ID", "data": "qid", "sName": "qid", "edit": {"type": "hidden"}, "isHide": true},
                        {title: "答案", "data": "name", "sName": "name",
                            "edit": {"type": "text", "required": true, "rangelength": "[2, 1000]"}
                        },
                        mt.fn.options.childTables.operations
                    ]
                }
            }
        });


        var $img = null, $select;

    /**
     * 显示的前置和后置操作
     * myTable.beforeShow(object data, bool child, object clickObject) return true 前置
     * myTable.afterShow(object data, bool child, object clickObject)  return true 后置
     */
    myTable.afterShow = function(data, child, clickObject) {
        if (child) {
            // 详情处理
            if (this.action == "create") {
                var childArray = this.table.data()[clickObject.attr('table-data')];
                if (childArray) {
                    $('#child-form').find('input[name=qid]').val(childArray['id']);
                } else {
                    layer.msg('数据不存在');
                    return false;
                }
            }
        } else {
            $img.ace_file_input("reset_input");
            // 不是编辑详情
            switch (this.action) {
                case 'create': // 新增
                    $select.html('<option value="0">请选择</option>');
                    break;
                case 'update': // 编辑
                    if (data) {
                        if (data.question_img) $img.ace_file_input("show_file_list", [data.question_img]);
                        mt.ajax({
                            "url": '<?=Url::toRoute(['question/child'])?>',
                            "type": "GET",
                            "dataType": "json",
                            "data": {"id": data["id"]}
                        }).done(function(json) {
                            if (json.errCode == 0 && json.data.length >= 1) {
                                var html = "";
                                if (data.answer_type == 3) {
                                    var answers = $.parseJSON(data.answer_id);
                                    for (var i in json.data) {
                                        html += '<option value="' + json.data[i]["id"] + '" ' + (mt.inArray(json.data[i]["id"], answers) ? " selected=\"selected\"" : "") + '> ' + json.data[i]["name"] + '</option>';
                                    }

                                    $select.prop({"multiple": "multiple", "name": "answer_id[]"});
                                } else {
                                    for (var i in json.data) {
                                        html += '<option value="' + json.data[i]["id"] + '" ' + (data.answer_id == json.data[i]["id"] ? " selected=\"selected\"" : "") + '> ' + json.data[i]["name"] + '</option>';
                                    }

                                    $select.removeProp("multiple").prop("name", "answer_id");
                                }

                                $select.html(html);
                            } else {
                                layer.msg(json.errMsg);
                            }
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
         $img = $("#image-file");
         $select = $("#input-answer-type").after("<p id=\"input-desc\"> 按住 Ctrl + 鼠标选择可以选择多个答案 </p>");
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