<?php
/**
 * Created by PhpStorm.
 * Date: 17-5-25
 * Time: 下午11:16
 */



$this->title = '题目信息添加';
?>
<form class="form-horizontal" id="create-form" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 题目问题 </label>
        <div class="col-sm-9">
            <input type="text" id="form-field-1" placeholder="Username" class="col-xs-10 col-sm-5">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 题目题解 </label>
        <div class="col-sm-9">
            <input type="text" id="form-field-1" placeholder="Username" class="col-xs-10 col-sm-5">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所属科目 </label>
        <div class="col-sm-9">
            <input type="text" id="form-field-1" placeholder="Username" class="col-xs-10 col-sm-5">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所属章节 </label>
        <div class="col-sm-9">
            <input type="text" id="form-field-1" placeholder="Username" class="col-xs-10 col-sm-5">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 问题类型 </label>
        <div class="col-sm-9">
            <input type="text" id="form-field-1" placeholder="Username" class="col-xs-10 col-sm-5">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所以答案 </label>
        <div class="col-sm-9">
            <input type="text" id="form-field-1" placeholder="Username" class="col-xs-10 col-sm-5">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 正确答案 </label>
        <div class="col-sm-9">
            <input type="text" id="form-field-1" placeholder="Username" class="col-xs-10 col-sm-5">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 专项分类 </label>
        <div class="col-sm-9">
            <input type="text" id="form-field-1" placeholder="Username" class="col-xs-10 col-sm-5">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 问题图片 </label>
        <div class="col-sm-5">
            <input type="hidden" name="question_img">
            <input type="file" id="upload-image" name="UploadForm[question_img]" input-type="ace_file" input-name="question_img" />
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
            <button class="btn btn-warning" type="button">
                <i class="ace-icon fa fa-times bigger-110"></i>
                关闭
            </button>
        </div>
    </div>
</form>

<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    $(function(){
        aceFileUpload($("#upload-image"), "<?=\yii\helpers\Url::toRoute(['question/upload'])?>");
    });
</script>
<?php $this->endBlock(); ?>
