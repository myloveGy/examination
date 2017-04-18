<?php

use yii\helpers\Url;
use \common\models\Question;

$this->title = '顺序练习';
$this->registerCssFile('@web/css/question.css');
?>
<?=$this->render('_crumbs')?>
<div class="jkbd-page-lianxi inner jkbd-width wid-auto cl lianxi-type-sequence">
    <div class="lianxi-container news-left">
        <div data-item="shiti-container" class="shiti-container " style="">
            <div class="shiti-item cl">
                <div class="clearfix">
                    <p class="shiti-content pull-left">
                        <span id="o-number">1</span>/<?=$total?>.  <span id="question-title"><?=$question->question_title?></span>
                    </p>
                    <span id="user-collect" class="btn btn-default pull-right user-login favor-tag <?=$hasCollect ? 'on' : ''?><?=Yii::$app->user->isGuest ? 'hide' : ''?>">收藏</span>
                </div>

                <div>
                    <?php if ($answer) : ?>
                        <div class="shiti-wapper  pull-left">
                            <div  class="options-container" id="answers">
                                <?php foreach ($answer as $value) : ?>
                                    <p answer="<?=$value->id?>"><i></i><span><?=$value->name?></span></p>
                                <?php endforeach; ?>
                            </div>
                        </div>
                    <?php endif; ?>
                    <div id="show-img" class="pull-right <?=$question->question_img ? '' : 'hide'?>">
                        <img src="<?=$question->question_img?>" width="300px"/>
                        <p class="text-center">
                            <a href="javascript:;" class="see-img">点击放大</a>
                        </p>
                    </div>
                </div>

            </div>
        </div>
        <div class="tip-container">
            <p id="do-no-answer" class="dacuo do-answer hide">
                <label class="text-danger"> 回答错误！</label>
                正确答案：<strong id="answer-yes" class="text-success">A</strong>
            </p>
            <p id="do-yes-answer" class="dadui do-answer text-success hide"> <strong>回答正确</strong> </p>
            <p class="weizuo" id="answer-type">
                <?= Question::getAnswerTypeDesc($question->answer_type) ?>
            </p>
            <p>
                错误率 <strong id="do-error-rate"><?=$question->do_number != 0 ? (round($question->error_number / $question->do_number * 100, 2 ) . '%') : '0%'?></strong> 　
                做错人数 <strong id="do-number"><?=$question->error_number?></strong> 　
            </p>
        </div>
        <div class="static-container">
            <b class="tips"> 科目一题库共 <span class="text-success"><?=$allTotal?></span> 题，已完成 <span id="do-finish" class="text-info">0</span> 题 </b>
        </div>
        <div class="shiti-buttons clearfix mt-15">
            <button id="prev" type="button" class="btn btn-info pull-left ml-15">上一题</button>
            <button id="next" type="button" class="btn btn-info pull-left ml-15">下一题</button>
<!--            <button data-item="datika" type="button" class="btn btn-default pull-right ml-15">展开答题卡</button>-->
            <button id="see-info" type="button" class="btn btn-default pull-right ml-15">查看详解</button>
        </div>
        <div class="tongji-container clearfix mt-15">
            <label class="daduinext float-l"><input type="checkbox" id="isAutoNext" checked="checked"><span>答对自动下一题</span></label>
            <label class="x-dadui float-l">答对：<span> <strong id="do-yes" class="text-success">0</strong> 题</span></label>
            <label class="x-dacuo float-l">答错：<span> <strong id="do-no" class="text-danger">0</strong> 题</span></label>
            <label class="x-lv float-l">正确率：<span id="do-accuracy">100%</span></label>
            <label class="x-sync float-l login no-login <?=Yii::$app->user->isGuest ? '' : 'hide'?>">登录保存做题进度</label>
        </div>

        <div id="info" class="explain-container hide">
            <div class="title">
                <span class="name">试题详解</span>
            </div>
            <div class="ef-content">
                <p class="wapper" id="question-content"><?=$question->question_content?></p>
            </div>
        </div>
    </div>
</div>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var allIds = <?=$allIds?>,                   // 全部问题
        answerYes = '<?=$question->answer_id?>', // 正确答案ID
        iQuestionId = <?=$question->id?>,        // 问题ID
        iDoFinish = 0,                           // 做了多少题目
        isDo = false,                            // 这题是否已经做了
        iDoYesNum = 0,                           // 做对了多少题
        iDoNoNum = 0,                            // 做错了多少题目
        sStyle = '<?=$style?>',                  // 风格
        sAnswerType = 'no',                      // 答案类型
        doIds = [];

    function getQuestion(type) {
        var errMsg = '';
        switch (type) {
            case 'next':
                if (allIds[0]) {
                    doIds.push(allIds.shift());
                } else {
                    errMsg = '没有下一题了';
                }
                break;
            case 'prev':
                if (doIds.length > 0) {
                    allIds.unshift(doIds.pop());
                } else {
                    errMsg = '没有上一题了';
                }
                break;
            default:
                errMsg = '你的选择错误';
        }

        if (errMsg) {
            return layer.msg(errMsg, {icon:2})
        }

//        console.info(allIds);
//        console.info(doIds);

        $('#info').addClass('hide');
        var ol = layer.load();
        $.ajax({
            url: '<?=Url::toRoute(['question/get-question'])?>',
            type: 'POST',
            dataType: 'json',
            data: {
                qid: allIds[0]
            }
        }).always(function(){
            layer.close(ol);
        }).done(function(json){
            if (json.errCode == 0) {

                // 处理显示问题
                if (json.data.question) {
                    var question = json.data.question, html = '';
                    sAnswerType  = 'no';
                    isCollect = false;
                    isDo = false;
                    answerYes = question.answer_id;
                    iQuestionId = question.id;
                    $('#o-number').html(doIds.length + 1);
                    $('.do-answer').addClass('hide');
                    $('#question-title').html(question.question_title);
                    $('#question-content').html(question.question_content);
                    $('#do-number').html(question.error_number);
                    json.data.hasCollect ? $('#user-collect').addClass('on') : $('#user-collect').removeClass('on');
                    var errorRate = question.do_number ? question.error_number/question.do_number * 100 : 0;
                    $('#do-error-rate').html(errorRate.toFixed(2) + '%');

                    // 详情处理
                    $('#see-info').html('查看详情');
                    $('#info').addClass('hide');

                    // 判断是否有图片
                    if (question.question_img) {
                        $('#show-img').removeClass('hide').find('img').attr('src', question.question_img);
                    } else {
                        $('#show-img').addClass('hide');
                    }
                    $('#answer-type').html(getAnswerTypeDesc(question.answer_type));
                    if (json.data.answers) {
                        for(var i in json.data.answers) {
                            html += '<p answer="'+ json.data.answers[i]["id"] +'"><i></i><span>'+ json.data.answers[i]["name"] +'</span></p>';
                        }
                    }

                    $('#answers').html(html);
                }
            } else {
                layer.msg(json.errMsg, {icon: 2});
            }
        }).fail(function(error) {
            layer.msg('服务器繁忙, 请稍候再试...');
        });
    }

    $(window).ready(function(){
        // 选择答案
        $(document).on('click', '#answers p', function() {
            if (isDo) return false;
            isDo = true;
            // 判断对错
            if ($(this).attr('answer') == answerYes) {
                // 正确
                $(this).addClass('dui');
                sAnswerType = 'yes';
                iDoYesNum ++;
                $('#do-yes').html(iDoYesNum);
                $("#do-yes-answer").removeClass('hide');
            } else {
                // 错误
                $(this).addClass('xuan');
                var doYes = $('#answers p[answer=' + answerYes + ']').addClass('dui');
                $('#do-no-answer').removeClass('hide').find('#answer-yes').html(doYes.text());
                iDoNoNum ++;
                $('#do-no').html(iDoNoNum);
            }

            // 请求记录信息
            $.ajax({
                url: '<?=Url::toRoute(['question/record'])?>',
                data: {
                    qid: iQuestionId,
                    sType: sAnswerType
                },
                type: 'POST',
                dataType: 'json'
            }).always(function(){
                iDoFinish ++;
                $('#do-finish').html(iDoFinish);
                var doAccuracy = iDoYesNum / iDoFinish * 100;
                $('#do-accuracy').html(doAccuracy.toFixed(2) + '%');
            }).done(function(json){
                if (json.errCode == 0 && $('#isAutoNext').is(':checked') && sAnswerType == 'yes') {
                    // 自动下一题
                    getQuestion('next');
                }
            });
        });

        // 上一题 下一题
        $('#prev').add('#next').click(function(){
            getQuestion($(this).attr('id'));
        });

        // 收藏问题
        $('#user-collect').click(function(){
            var self = $(this), hasCollect = self.hasClass('on');
            if (iQuestionId > 0) {
                $.ajax({
                    url: '<?=Url::toRoute(['user/create-collect'])?>',
                    data: {
                        qid: iQuestionId,
                        type: hasCollect ? 'remove' : 'create',
                        subject: '<?=$subject->id?>',
                    },
                    type: 'POST',
                    dataType: 'json'
                }).always(function(){
                    isCollect = true;
                }).done(function(json){
                    if (json.errCode == 0) {
                        layer.msg(hasCollect ? '你取消了收藏' : '收藏成功', {icon:6});
                        hasCollect ? self.removeClass('on') : self.addClass('on');
                    } else {
                        layer.msg(json.errMsg, {icon:5})
                    }
                });
            } else {
                layer.msg('请选择问题收藏');
            }
        });

        // 查询详情
        $('#see-info').click(function(){
            if (isDo) {
                if ($("#info").hasClass('hide')) {
                    $(this).html('收起详情');
                    $('#info').removeClass('hide');
                } else {
                    $(this).html('查看详情');
                    $('#info').addClass('hide');
                }
            } else {
                layer.msg('需要先完成问题,才能查看哦！');
            }
        });

        // 查看图片
        imageBoost('a.see-img');
    });

    /**
    function getItems()
    {
        // 获取内容信息
        var arr = [];
        $('.options-container p').each(function() {
            var iQid = parseInt($.trim($(this).attr("data-answer")));
            arr.push({"name": "items[" + iQid+ "]", "value": $.trim($(this).text())});
            if ($(this).hasClass("dui")) arr.push({"name": "answer", "value": iQid});
        });

        // 获取标题
        arr.push({"name": "title", "value": $.trim($(".shiti-content").text())});
        // 获取内容
        arr.push({"name": "content", "value": $.trim($(".wapper[data-item=explain-content]").text())});

        var sType = $('div.tip-container p.weizuo').html(), iType = null;
        switch (sType) {
            case "判断题，请判断对错！":
                iType = 2;
                break;
            default:
                iType = 1;
        }

        arr.push({"name": "answer_type", "value": iType});

        // 添加图片
        arr.push({"name": "question_img", "value": $(".media-container img").attr("src")});

        $.getJSON('http://yii.com/question/install', arr, function(json){
            alert('123');
        });

        $("button[data-item=next]").trigger("click");
    }
//    setInterval(function(){
//        getItems();
//    }, 1500);
    */
</script>
<?php $this->endBlock() ?>