<?php

use yii\helpers\Url;

// 定义标题和面包屑信息
$this->title = '题库信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--前面导航信息-->
<p id="me-table-buttons"></p>
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

    mt.extend({
        multipleCreate: function(params) {
            var n = params.number ? params.number : 4, html = "<div class=\"div-inputs\">";
            for (x = 0; x < n; x++) {
                html += createInput(params.name, "", x);
            }

            html += "</div>" +
                "<div class=\"div-buttons clearfix\">" +
                    "<button type=\"button\" class=\"btn btn-sm btn-info m-input-create\">添加答案</button> " +
                    " <button type=\"button\" class=\"btn btn-warning btn-sm m-input-delete\">删除上一个答案</button></div>";
            return html;
        }
    });

    var aTypeColor = {"1": "label-success", "2": "label-info", "3": "label-pink", "4": "label-inverse"};

    var aSubject = <?=$subject?>,
        sUpload = '<?=Url::toRoute(['question/upload', 'sField' => 'question_img'])?>',
        aSpecial = <?=$special?>,
        aChapter = <?=$chapter?>,
        aStatus  = <?=$status?>,
        aColor   = <?=$color?>,
        aType    = <?=$type?>,
        aCars = <?=$cars?>;

        aCars["0"] = "请选择";
        var myTable = meTables({
            sTitle:"题库信息",
            fileSelector: ["#image-file"],
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
                        "title": "考试类型",
                        "data": null,
                        "sName": "car_id",
                        "value": aCars,
                        "edit": {"type": "select", "default": 0, "id": "car-id", "required": true, "number": true},
                        "search": {"type": "select"},
                        "bSortable": false,
                        "isHide": true
                    },
                    {
                        "title": "所属科目",
                        "data": "subject_id",
                        "sName": "subject_id",
                        "value": aSubject,
                        "edit": {"type": "select", "default": 1, "id": "subject-id", "required": true, "number": true},
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
                        "edit": {"type": "select", "required": true, "id": "chapter-id", "number": true},
                        "bSortable": false,
                        "createdCell": function(td, data) {
                            $(td).html(aChapter[data] ? aChapter[data] : data);
                        }
                    },
                    {
                        "title": "问题答案",
                        "data": "answers",
                        "sName": "answers",
                        "edit": {"type": "multiple", "number": 4},
                        "bSortable": false,
                        "isHide": true
                    },
                    {
                        "title": "答案类型",
                        "data": "answer_type",
                        "sName": "answer_type",
                        "value": aType,
                        "edit": {"type": "select", "id": "answer-type-select", "required": true, "number": true},
                        "search": {"type": "select"},
                        "bSortable": false,
                        "createdCell": function (td, data) {
                            $(td).html(mt.valuesString(aType, aTypeColor, data));
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
                        "value": {"-1":"请选择"},
                        "edit": {"type": "select", "id": "input-answer-type", "multiple": "multiple", "required": true}
                    },
                    {
                        "title": "专项分类",
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
                    {"title": "创建时间", "data": "created_at", "sName": "created_at", "createdCell": mt.dateTimeString},
                    {"title": "修改时间", "data": "updated_at", "sName": "updated_at", "createdCell": mt.dateTimeString},
                    {"title": "错误人数", "data": "error_number", "sName": "error_number"}
                ]
            }
        });


        var $img = null, $select;

    /**
     * 显示的前置和后置操作
     * myTable.beforeShow(object data, bool child, object clickObject) return true 前置
     * myTable.afterShow(object data, bool child, object clickObject)  return true 后置
     */
    myTable.beforeShow = function(data, child, chickObject) {
        if (this.action != "delete") {
            var html = '<option value=""> -- 请选择 -- </option>', sHtml = html, x;
            for (x in aSubject) {
                html += '<option value="' + x + '">' + aSubject[x] + '</option>';
            }

            for (x in aChapter) {
                sHtml += '<option value="' + x + '">' + aChapter[x] + '</option>';
            }

            $("#subject-id").html(html);
            $("#chapter-id").html(sHtml);
        }

        return true;
    };

    myTable.afterShow = function(data, child, clickObject) {
        $img.ace_file_input("reset_input");
        // 不是编辑详情
        switch (this.action) {
            case 'create': // 新增
                initAnswers("answers", ["", "", "", ""]);
                break;
            case 'update': // 编辑
                if (data) {
                    if (data.question_img) $img.ace_file_input("show_file_list", [data.question_img]);
                    var arr = [];

                    if (data.answers) {
                        try {
                            arr = $.parseJSON(data.answers);
                        } catch (e) {
                            arr = [];
                        }
                    }

                    // 问题处理
                    initAnswers("answers", arr);
                    // 选择答案
                    initAnswerId(arr, data.answer_id);
                }
                break;
        }

        return true;
    };

    function createInput(name, defaultVal, num) {
        if (!defaultVal) defaultVal = "";
        return '<div class="col-sm-12">' +
            '<div class="form-group">' +
                '<input name="' + name + '[]" value="' + defaultVal + '" type="text" class="form-control multiple-input" placeholder="答案' + num + '">' +
            '</div>' +
        '</div>';
    }

    function initAnswers(name, data) {
        var html = "", x;
        for (x in data) {
            html += createInput(name, data[x], x);
        }

        $(".div-inputs").html(html);
    }

    function initAnswerId(answer, answerId) {
        var html = "", x, arrIds = [];
        if (answerId) {
            try {
                arrIds = $.parseJSON(answerId);
            } catch (e) {
                arrIds = [];
            }
        }

        console.info(arrIds);

        for (x in answer) {
            console.info(x);
            html += "<option value=\"" + x + "\" " + (mt.inArray(parseInt(x), arrIds) ? "selected=\"selected\"" : "") + ">" + answer[x] + "</option>";
        }

        $("#input-answer-type").html(html);
    }

     /**
      * 编辑的前置和后置操作
      * myTable.beforeSave(object data) return true 前置
      * myTable.afterSave(object data)  return true 后置
      */
     $(function(){
         myTable.init();
         $img = $("#image-file");
         $select = $("#input-answer-type").prop("name", "answer_id[]").after("<p id=\"input-desc\"> 按住 Ctrl + 鼠标选择可以选择多个答案; (<span style=\"color:red\">*</span>请只在多选的情况下选择多个答案 </p>");

         // 添加答案
         $(document).on("click", ".m-input-create", function(evt){
             evt.preventDefault();
             var $input = $(".div-inputs");
             $input.append(createInput("answers", "", $input.find("input").length));
         });

         // 删除答案
         $(document).on("click", ".m-input-delete", function(evt){
             evt.preventDefault();
             $(".div-inputs").find("div.col-sm-12:last").remove();
         });

         // 添加答案
         $(document).on("blur", ".multiple-input", function(){
             var arr = [], x;
             $(".multiple-input").each(function(){
                 x = $.trim($(this).val());
                 if (x) arr.push(x);
             });

             if (arr.length > 0) {
                 initAnswerId(arr, "");
             }
         });

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

         // 选择车型联动科目
         $("#car-id").change(function(){
             var v = parseInt($(this).val()), html = '<option value="">请选择</option>';
             if (v) {
                mt.ajax({
                    url: "<?=Url::toRoute(['subject'])?>",
                    data: {cid: v},
                    type: "POST",
                    dataType:"json"
                }).done(function(json) {
                    if (json.errCode === 0) {
                        for (var x in json.data) {
                            html += '<option value="' + json.data[x]["id"] + '"> ' + json.data[x]["name"] + ' </option>';
                        }

                        $("#subject-id").html(html);
                    } else {
                        layer.msg(json.errMsg);
                    }
                });
             }
         });

         // 选择科目联动章节
         $("#subject-id").change(function(){
             var v = parseInt($(this).val()), html = '<option value="">请选择</option>';
             if (v) {
                 mt.ajax({
                     url: "<?=Url::toRoute(['chapter'])?>",
                     data: {sid: v},
                     type: "POST",
                     dataType:"json"
                 }).done(function(json) {
                     if (json.errCode === 0) {
                         for (var x in json.data) {
                             html += '<option value="' + json.data[x]["id"] + '"> ' + json.data[x]["name"] + ' </option>';
                         }

                         $("#chapter-id").html(html);
                     } else {
                         layer.msg(json.errMsg);
                     }
                 });
             }
         });
     });
</script>
<?php $this->endBlock(); ?>