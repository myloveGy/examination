<?php

use yii\helpers\Url;
use jinxing\admin\widgets\MeTable;

// 定义标题和面包屑信息
$this->title                   = '题库信息';
$this->params['breadcrumbs'][] = $this->title;
?>
<?= MeTable::widget() ?>
    <div class="col-xs-12 hidden">
        <table id="child-table" class="table table-striped table-bordered table-hover"></table>
    </div>

    <div class="modal fade" id="upload-modal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">导入题目信息</h4>
                </div>
                <div class="modal-body">
                    <form id="upload-form" action="" method="POST">
                        <div class="form-group">
                            <label for="upload-subject">选择科目</label>
                            <?php $arrSubject[0] = '请选择'; ?>
                            <?= \yii\helpers\Html::dropDownList('subject_id', 0, $arrSubject, [
                                'class'    => 'form-control',
                                'id'       => 'upload-subject-id',
                                'required' => true,
                                'number'   => true,
                            ]) ?>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">选择章节</label>
                            <?= \yii\helpers\Html::dropDownList('chapter_id', 0, $arrChapter, [
                                'class'    => 'form-control',
                                'id'       => 'upload-chapter-id',
                                'required' => true,
                                'number'   => true,
                            ]) ?>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">选择专项类型</label>
                            <?= \yii\helpers\Html::dropDownList('special_id', 0, $arrSpecial, [
                                'class'  => 'form-control',
                                'number' => true,
                            ]) ?>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputFile">题目文件</label>
                            <input type="hidden" name="upload_file">

                            <input type="file" id="upload-xls" name="UploadForm[upload_file]" input-type="ace_file"
                                   input-name="upload_file" allowExt="xls,xlsx">
                            <p class="help-block">请上传.xls或者.xlsx文件</p>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="submit-upload">上传</button>
                </div>
            </div>
        </div>
    </div>
<?php $this->beginBlock('javascript') ?>
    <script type="text/javascript">

        function showSpan(s, c, d) {
            return '<span class="label label-sm ' + (c[d] ? c[d] : d) + '">' + (s[d] ? s[d] : d) + '</span>'
        }

        MeTables.multipleCreate = function (params) {
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

        var aTypeColor = {"1": "label-success", "2": "label-info", "3": "label-pink", "4": "label-inverse"};

        var aSubject = <?=$subject?>,
            aSpecial = <?=$special?>,
            aChapter = <?=$chapter?>,
            aStatus = <?=$status?>,
            aColor = <?=$color?>,
            aType = <?=$type?>,
            aCars = <?=$cars?>,
            aCarSubject = <?=$car_subject?>;

        function getCarBySubject(intSubject) {
            for (var i in aCarSubject) {
                if (aCarSubject[i][intSubject]) {
                    return i;
                }
            }

            return 0;
        }

        aCars["0"] = "请选择";
        var myTable = meTables({
            title: "题库信息",
            fileSelector: ["#image-file", "#upload-xls"],
            number: false,
            buttons: {
                upload: {
                    text: "导入题目",
                    icon: "ace-icon fa fa-cloud-upload blue",
                    className: "btn btn-white btn-primary btn-bold",
                    "data-func": "upload"
                }
            },
            // 主表格
            table: {
                columns: [
                    {
                        title: "题目ID",
                        data: "id",
                        edit: {type: "hidden"},
                        isHide: true,
                        defaultOrder: "desc",
                        createdCell: function (td, data, rowArr, row, col) {
                            $(td).html(data + '<b class="arrow fa fa-angle-down pull-right"></b>');
                        }
                    },
                    {
                        title: "题目问题",
                        data: "question_title",
                        edit: {type: "textarea", required: true},
                        sortable: false
                    },
                    {
                        title: "题目说明",
                        data: "question_content",
                        edit: {type: "textarea"},
                        sortable: false,
                        isHide: true
                    },
                    {
                        title: "考试类型",
                        data: null,
                        value: aCars,
                        edit: {
                            type: "select",
                            name: "car_id",
                            default: 0,
                            id: "car-id",
                            required: true,
                            number: true
                        },
                        sortable: false,
                        isHide: true
                    },
                    {
                        title: "所属科目",
                        data: "subject_id",
                        value: aSubject,
                        edit: {type: "select", default: 1, id: "subject-id", required: true, number: true},
                        search: {type: "select"},
                        sortable: false,
                        createdCell: function (td, data) {
                            $(td).html(aSubject[data] ? aSubject[data] : data);
                        }
                    },
                    {
                        title: "所属章节",
                        data: "chapter_id",
                        value: aChapter,
                        search: {type: "select"},
                        edit: {type: "select", id: "chapter-id", number: true},
                        sortable: false,
                        createdCell: function (td, data) {
                            $(td).html(aChapter[data] ? aChapter[data] : data);
                        }
                    },
                    {
                        title: "问题答案",
                        data: "answers",
                        edit: {type: "multiple", number: 4},
                        sortable: false,
                        isHide: true
                    },
                    {
                        title: "答案类型",
                        data: "answer_type",
                        value: aType,
                        edit: {type: "select", id: "answer-type-select", required: true, number: true},
                        search: {type: "select"},
                        sortable: false,
                        createdCell: function (td, data) {
                            $(td).html(MeTables.valuesString(aType, aTypeColor, data));
                        }
                    },
                    {
                        title: "正确答案",
                        data: "answer_id",
                        sortable: false,
                        createdCell: function (td, data) {
                            $(td).html(data === "" ? '<span class="label label-sm label-warning">还没有设置答案</span>' : data)
                        },
                        value: {"-1": "请选择"},
                        edit: {type: "select", id: "input-answer-type", multiple: "multiple", required: true}
                    },
                    {
                        title: "专项分类",
                        data: "special_id",
                        value: aSpecial,
                        search: {type: "select"},
                        edit: {type: "select", required: true, number: true},
                        sortable: false,
                        createdCell: function (td, data) {
                            $(td).html(aSpecial[data] ? aSpecial[data] : data);
                        }
                    },
                    {
                        title: "题目图片",
                        data: "question_img",
                        edit: {
                            type: "file",
                            options: {
                                "id": "image-file",
                                "name": "UploadForm[question_img]",
                                "input-type": "ace_file",
                                "input-name": "question_img"
                            }
                        },
                        sortable: false,
                        isHide: true,
                        createdCell: function (td, data) {
                            var html = data ? "<img src=" + data + " style=\"width: 60px;margin-right: 10px;\" />" +
                                "<a href=\"javascript:;\" class=\"btn btn-xs btn-info btn-image\" data-img=" + data + ">查看大图</a>" : "";
                            $(td).html(html);
                        }
                    },
                    {
                        title: "状态",
                        data: "status",
                        value: aStatus,
                        edit: {type: "radio", default: 1, required: true, number: true},
                        sortable: false,
                        search: {type: "select"},
                        createdCell: function (td, data) {
                            $(td).html(showSpan(aStatus, aColor, data));
                        }
                    },
                    {title: "创建时间", data: "created_at", createdCell: MeTables.dateTimeString},
                    {title: "修改时间", data: "updated_at", createdCell: MeTables.dateTimeString},
                    {title: "错误人数", data: "error_number"}
                ]
            }
        });


        var $img = null, $select;

        myTable.beforeShow = function () {
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

        myTable.afterShow = function (data) {
            $img.ace_file_input("reset_input");
            // 不是编辑详情
            switch (this.action) {
                case 'create': // 新增
                    initAnswers("answers", ["", "", "", ""]);
                    // 问题类型
                    updateAnswerName(1);
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

                        // 问题类型
                        updateAnswerName(parseInt(data.answer_type));
                        // 问题处理
                        initAnswers("answers", arr);
                        // 选择答案
                        initAnswerId(arr, data.answer_id);
                        // 设置类型
                        $("#car-id").val(getCarBySubject(data.subject_id));
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

            if (typeof arrIds !== "object") arrIds = [arrIds];

            for (x in answer) {
                html += "<option value=\"" + x + "\" " + (MeTables.inArray(parseInt(x), arrIds) ? "selected=\"selected\"" : "") + ">" + answer[x] + "</option>";
            }

            $("#input-answer-type").html(html);
        }

        function renderAnswers() {
            var arr = [], x;
            $(".multiple-input").each(function () {
                x = $.trim($(this).val());
                if (x) arr.push(x);
            });

            if (arr.length > 0) {
                initAnswerId(arr, "");
            }
        }

        function updateAnswerName(strType) {
            $("#input-answer-type").prop("name", strType === 3 ? "answer_id[]" : "answer_id");
        }

        $.extend(myTable, {
            upload: function () {
                $("#upload-modal").modal({backdrop: "static"});   // 弹出信息
            }
        });

        $(function () {
            myTable.init();
            $img = $("#image-file");
            $select = $("#input-answer-type").after("<p id=\"input-desc\"> 按住 Ctrl + 鼠标选择可以选择多个答案; (<span style=\"color:red\">*</span>请只在多选的情况下选择多个答案 </p>");

            // 问题类型选择
            $("#answer-type-select").change(function () {
                updateAnswerName(parseInt($(this).val()));
            });

            // 添加答
            $(document).on("click", ".m-input-create", function (evt) {
                evt.preventDefault();
                var $input = $(".div-inputs");
                $input.append(createInput("answers", "", $input.find("input").length));
            });

            // 删除答案
            $(document).on("click", ".m-input-delete", function (evt) {
                evt.preventDefault();
                $(".div-inputs").find("div.col-sm-12:last").remove();
                renderAnswers();
            });

            // 添加答案
            $(document).on("blur", ".multiple-input", function () {
                renderAnswers();
            });

            // 查询大图
            $(document).on("click", ".btn-image", function () {
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
            $("#car-id").change(function () {
                var v = parseInt($(this).val()), html = '<option value="">请选择</option>';
                if (v) {
                    if (aCarSubject[v]) {
                        for (var x in aCarSubject[v]) {
                            html += '<option value="' + x + '"> ' + aCarSubject[v][x] + ' </option>';
                        }

                        $("#subject-id").html(html);
                    } else {
                        MeTables.ajax({
                            url: "<?=Url::toRoute(['subject'])?>",
                            data: {cid: v},
                            type: "POST",
                            dataType: "json"
                        }).done(function (json) {
                            if (json.code === 0) {
                                for (var x in json.data) {
                                    html += '<option value="' + json.data[x]["id"] + '"> ' + json.data[x]["name"] + ' </option>';
                                }

                                $("#subject-id").html(html);
                            } else {
                                layer.msg(json.msg);
                            }
                        });
                    }
                }
            });

            // 选择科目联动章节
            $("#subject-id").add("#upload-subject-id").change(function () {
                var v = parseInt($(this).val()), html = '<option value="">请选择</option>';
                if (v) {
                    MeTables.ajax({
                        url: "<?=Url::toRoute(['chapter'])?>",
                        data: {sid: v},
                        type: "POST",
                        dataType: "json"
                    }).done(function (json) {
                        if (json.code === 0) {
                            for (var x in json.data) {
                                html += '<option value="' + json.data[x]["id"] + '"> ' + json.data[x]["name"] + ' </option>';
                            }

                            $("#chapter-id").add("#upload-chapter-id").html(html);
                        } else {
                            layer.msg(json.msg);
                        }
                    });
                }
            });

            // 文件上传
            $("#submit-upload").click(function () {
                var $fm = $("#upload-form"), message = "数据存在问题";
                if ($fm.validate().form()) {
                    message = "请选择科目";
                    // 验证科目
                    if ($fm.find("select[name=subject_id]").val()) {
                        message = "请上传文件";
                        if ($fm.find("input[name=upload_file]").val()) {
                            MeTables.ajax({
                                url: "<?=Url::toRoute(['question/upload-question'])?>",
                                data: $fm.serialize(),
                                type: "POST",
                                dataType: "json"
                            }).done(function (json) {
                                if (json.code === 0) {
                                    layer.msg("上传成功");
                                    $("#upload-modal").modal("hide");
                                    myTable.search()
                                } else {
                                    layer.msg(json.msg, {icon: 5})
                                }
                            });

                            return false;
                        }
                    }
                }

                layer.msg(message, {icon: 5});
            });
        });
    </script>
<?php $this->endBlock(); ?>