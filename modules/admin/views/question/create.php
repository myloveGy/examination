<?php
/**
 * Created by PhpStorm.
 * Date: 17-5-25
 * Time: 下午11:16
 */

use yii\helpers\Url;
use yii\helpers\Html;
use jinxing\admin\web\TableAsset;
TableAsset::register($this);
$this->title = '题目信息添加';
?>
<form class="form-horizontal" id="create-form" method="post" enctype="multipart/form-data">
    <input type="hidden" name="status" value="1"/>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 题目问题 </label>
        <div class="col-sm-9">
            <textarea name="question_title" required="required" rangelength="[1, 2000]" class="col-xs-12 col-sm-8"
                      cols="30" rows="6"></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 题目题解 </label>
        <div class="col-sm-9">
            <textarea name="question_content" required="required" rangelength="[1, 2000]" class="col-xs-12 col-sm-8"
                      cols="30" rows="6"></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所属科目 </label>
        <div class="col-sm-9">
            <?= Html::dropDownList('subject_id', $subject_id, $subject, [
                'class'    => 'col-xs-10 col-sm-5',
                'id'       => 'subject-id',
                'number'   => 'true',
                'required' => 'true',
                'min'      => 1,
            ]) ?>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所属章节 </label>
        <div class="col-sm-9">
            <?= Html::dropDownList('chapter_id', $chapter_id, $chapter, [
                'class'    => 'col-xs-10 col-sm-5',
                'id'       => 'chapter-id',
                'number'   => 'true',
                'required' => 'true',
                'min'      => 1,
            ]) ?>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 问题类型 </label>
        <div class="col-sm-9">
            <?= Html::dropDownList('answer_type', 1, $types, [
                'class'    => 'col-xs-10 col-sm-5',
                'id'       => 'answer-type-select',
                'number'   => 'true',
                'required' => 'true',
                'min'      => 1,
            ]) ?>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所以答案 </label>
        <div class="col-sm-9">
            <div class="div-inputs">

            </div>
            <div class="div-buttons clearfix">
                <button type="button" class="btn btn-sm btn-info m-input-create">添加答案</button>
                <button type="button" class="btn btn-warning btn-sm m-input-delete">删除上一个答案</button>
            </div>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 正确答案 </label>
        <div class="col-sm-9">
            <select type="select" id="input-answer-type" multiple="multiple" required="true" name="answer_id"
                    class="col-xs-10 col-sm-5">
                <option value="-1">请选择</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 专项分类 </label>
        <div class="col-sm-9">
            <?= Html::dropDownList('special_id', 1, $special, ['class' => 'col-xs-10 col-sm-5']) ?>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 问题图片 </label>
        <div class="col-sm-9">
            <div class="col-sm-5">
                <input type="hidden" name="question_img">
                <input type="file" id="upload-image" name="UploadForm[question_img]" input-type="ace_input"
                       input-name="question_img"/>
            </div>
        </div>
    </div>
    <div class="clearfix form-actions">
        <div class="col-md-offset-3 col-md-9">
            <button class="btn btn-info" type="submit">
                <i class="ace-icon fa fa-check bigger-110"></i>
                提交
            </button>
            &nbsp; &nbsp; &nbsp;
            <button class="btn" type="reset">
                <i class="ace-icon fa fa-undo bigger-110"></i>
                重置
            </button>
            &nbsp; &nbsp; &nbsp;
            <button class="btn btn-warning" type="button" id="close-layer">
                <i class="ace-icon fa fa-times bigger-110"></i>
                关闭
            </button>
        </div>
    </div>
</form>

<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var intSubject = <?=$subject_id?>,
        intChapter = <?=$chapter_id?>;

    function createInput(name, defaultVal, num) {
        if (!defaultVal) defaultVal = "";
        return '<div class="col-sm-12">' +
            '<div class="form-group">' +
            '<input name="' + name + '[]" value="' + defaultVal + '" type="text" class="col-xs-10 col-sm-5 multiple-input" placeholder="答案' + num + '">' +
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

    function getChapter(v) {
        var html = '<option value="">请选择</option>';
        ajax("<?=Url::toRoute(['chapter'])?>", {sid: v}, function (data) {
            for (var x in data) {
                html += '<option value="' + data[x]["id"] + '"> ' + data[x]["name"] + ' </option>';
            }

            $("#chapter-id").add("#upload-chapter-id").html(html);
        });
    }

    $(function () {

        initAnswers("answers", ["", "", "", ""]);

        // 默认请求获取章节信息
        if (intSubject > 0 && intChapter === 0) {
            getChapter(intSubject);
        }

        // 上传图片
        aceFileUpload($("#upload-image"), "<?=Url::toRoute(['question/upload', 'id' => 1])?>");

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

        // 选择科目联动章节
        $("#subject-id").change(function () {
            var v = parseInt($(this).val());
            if (v) {
                getChapter(v);
            }
        });

        // 表单提交
        $("#create-form").submit(function (evt) {
            evt.preventDefault();
            var $fm = $(this);
            if ($fm.validate().form()) {
                ajax("<?=Url::toRoute(['question/create'])?>", $fm.serialize(), function () {
                    layer.msg('添加成功', {
                        icon: 6, time: 1000, end: function () {
                            parent.closeLayer();
                        }
                    })
                });
            }
        });

        // 关闭
        $("#close-layer").click(function () {
            parent.closeLayer();
        });
    });
</script>
<?php $this->endBlock(); ?>
