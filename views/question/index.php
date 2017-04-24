<?php

use yii\helpers\Url;
use \yii\helpers\Json;
use app\common\models\Question;

$this->title = '顺序练习';
$this->params['menu'] = [
    'title' => $cars->name,
    'link' => Url::toRoute(['car/index', 'id' => $cars->id])
];
$this->registerCssFile('@web/css/question.css', ['depends' => ['app\assets\AppAsset']]);
?>
<?=$this->render('_crumbs')?>
<div class="jkbd-page-lianxi inner jkbd-width wid-auto cl lianxi-type-sequence">
    <div class="lianxi-container news-left">
        <div data-item="shiti-container" class="shiti-container">
            <div class="shiti-item cl">
                <div class="clearfix">
                    <p class="shiti-content pull-left">
                        <span id="o-number">1</span>/<?=$total?>.  <span id="question-title"><?=$question->question_title?></span>
                    </p>
                    <span id="user-collect" class="btn btn-default pull-right user-login favor-tag <?=$hasCollect ? 'on' : ''?><?=Yii::$app->user->isGuest ? 'hide' : ''?>">收藏</span>
                </div>
                <div class="col-md-12">

                    <?php if ($answer) : ?>
                    <div class="shiti-wapper  pull-left col-md-8 <?php if ($question->answer_type == 4) : ?>hide<?php endif; ?>" id="question-answer">
                        <div  class="options-container" id="answers">
                            <?php foreach ($answer as $value) : ?>
                                <p answer="<?=$value->id?>"><i></i><span><?=$value->name?></span></p>
                            <?php endforeach; ?>
                        </div>
                    </div>
                    <?php endif; ?>
                    <div class="shiti-wapper question-text col-md-8 pull-left <?php if ($question->answer_type != 4) : ?>hide<?php endif; ?>" id="question-text">
                        <form id="question-form">
                            <textarea id="question-answer-text" name="question-answer" class="form-control" required="true" rangelength="[2, 1000]" rows="3" placeholder="请填写答案"></textarea>
                            <div class="span4"></div>
                            <button type="submit" class="btn btn-default">提交答案</button>
                            <div class="span4 text-answer hide" id="text-answer-div">
                                <p>正确答案信息： </p>
                                <p id="text-answer"></p>
                            </div>
                        </form>
                    </div>

                    <div id="show-img" class="pull-right col-md-4 <?=$question->question_img ? '' : 'hide'?>">
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
            <p class="me-answer-type" >
                <span class="" id="answer-type"><?= Question::getAnswerTypeDesc($question->answer_type) ?></span>
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

        // 页面公共信息
        objBase = {
            pk: "0",
            doNumber: 0,    // 做了多少题目
            yesNumber: 0,   // 做对多少题目
            noNumber: 0,     // 做错多少题目
            correctRote: 100, // 正确率
            error: "", // 错误信息
            loading: null, // layer.load() 加载对象
            progress: 1,    // 进度
            request: {},    // 请求信息

            // 完成题目信息
            complete: {},

            // 题目信息
            question: <?=Json::encode($question)?>,

            // 问题信息
            answer: <?=Json::encode($answer)?>,
            answerHtml: "",

            // 当前问题信息
            currentQuestion: {
                index: 0,       // 当前题目位置
                complete: 'no', // 完成情况,
                correct: [],    // 正确答案信息,
                answers: [],     // 回答信息，
                hasCollect: false, // 是否已经收藏
                errorRate: 0,       // 问题的错误率
                doComplete: false // 是否已经做完
            },

            initData: function(question, answer) {
                this.question = question;
                this.answer = answer;
                this.initCorrect();
            },

            renderAnswer: function(o) {
                if (!o) o = this.answer;
                this.answerHtml = "";

                if (o) {
                    for(var i in o) {
                        this.answerHtml += '<p answer="'+ o[i]["id"] +'"><i></i><span>'+ o[i]["name"] +'</span></p>';
                    }
                }

                // 执行渲染页面
                $('#answer-type').html(getAnswerTypeDesc(this.question.answer_type)).removeClass("default bg-danger bg-info bg-primary bg-warning").addClass(aTypeColor[this.question.answer_type]);
                $('#answers').html(this.answerHtml);
            },

            renderOther: function() {
                // 更新进度
                $('#o-number').html(objBase.currentQuestion.index + 1);
            },

            // 渲染问题信息
            renderQuestion: function(){
                // 渲染其他信息
                this.renderOther();

                if (this.question.answer_type == 4) {
                    $("#question-answer").addClass("hide");
                    $("#question-text").removeClass("hide");
                } else {
                    // 隐藏填空题目信息
                    objBase.initAnswerText();
                    $("#question-answer").removeClass("hide");
                    $("#question-text").addClass("hide");
                }

                // 处理显示
                $('.do-answer').addClass('hide');
                $('#question-title').html(this.question.question_title);
                $('#question-content').html(this.question.question_content);
                $('#do-number').html(this.question.error_number);

                // 收藏是否显示
                this.currentQuestion.hasCollect ? $('#user-collect').addClass('on') : $('#user-collect').removeClass('on');

                // 计算该题目的错误率
                this.currentQuestion.errorRate = this.question.do_number ? this.question.error_number / this.question.do_number * 100 : 0;
                $('#do-error-rate').html(this.currentQuestion.errorRate.toFixed(2) + '%');

                // 判断是否有图片
                if (this.question.question_img) {
                    $('#show-img').removeClass('hide').find('img').attr('src', this.question.question_img);
                } else {
                    $('#show-img').addClass('hide');
                }

                // 渲染答案信息
                this.renderAnswer();
            },

            // 完成题目自增
            doIncr: function() {
                this.doNumber ++;
                $("#do-finish").html(this.doNumber);
            },

            // 正确自己增加
            yesIncr: function() {
                this.doIncr();
                this.yesNumber ++;
                $("#do-yes").html(this.yesNumber);
            },

            // 错误增加
            noIncr: function() {
                this.doIncr();
                this.noNumber ++;
                $("#do-no").html(this.noNumber);
            },

            // 计算正确率
            handleCorrectRate: function() {
                this.correctRote = this.doNumber > 0 ? this.yesNumber / this.doNumber * 100 : 0;
                $('#do-accuracy').html(this.correctRote.toFixed(2) + '%');
            },

            // 获取问题信息
            getAnswer: function(o) {
                if (!o) o = this.question;
                return o ? (o.answer_type == 3 ? $.parseJSON(o.answer_id): o.answer_id) : null;
            },

            // 设置问题信息
            setAnswerText: function() {
                // 显示正确答案信息
                $("#text-answer-div").removeClass("hide");
                var html = "";
                this.answer.forEach(function(v, k){
                    if (v.id == objBase.question.answer_id) {
                        html += v.name;
                    }
                });

                $("#text-answer").html(html);
            },

            // 初始化填空题目
            initAnswerText: function() {
                $("#question-answer-text").val("");
                $("#text-answer-div").addClass("hide");
                $("#text-answer").html("");
            },

            // 初始化多选问题信息
            initCorrect: function(o, collect) {
                this.currentQuestion.correct = [];
                this.currentQuestion.complete = 'no';
                this.currentQuestion.answers = [];
                this.currentQuestion.hasCollect = collect;
                if (!o) o = this.question;
                // 初始化多选问题信息
                if (o.answer_type == 3) {
                    this.currentQuestion.correct = objBase.getAnswer(o);
                }
            },

            // 判断多选是否正确
            isCorrect: function(value) {
                return $.inArray(value, this.currentQuestion.correct) !== -1;
            },

            // 添加回答信息
            insertAnswer: function(value) {
                if ($.inArray(value, this.currentQuestion.answers)) {
                    this.currentQuestion.answers.push(value);
                }
            },

            // 判断相等
            equalCorrect: function() {
                return this.currentQuestion.correct.length == this.currentQuestion.answers.length;
            },

            // 初始化第一个请求问题信息
            initRequest: function(question, answer, collect) {
                if (!question) question = this.question;
                if (!answer) answer = this.answer;
                if (collect == undefined) collect = this.currentQuestion.hasCollect;
                this.request[question.id] = {
                    question: question,
                    answer: answer,
                    hasCollect: collect
                };
            }
        };

        objBase.initCorrect();
        objBase.initRequest();

    // 获取题目信息
    function getQuestion(type) {
        switch (type) {
            case 'next':
                objBase.error = '没有下一题了';
                objBase.currentQuestion.index ++;
                break;
            case 'prev':
                objBase.error = '没有上一题了';
                objBase.currentQuestion.index --;
                break;
            default:
                objBase.error = '你的选择错误';
        }

        // 判断题目是否存在(index) 是否越界
        if (objBase.currentQuestion.index < 0 || objBase.currentQuestion.index > allIds.length || !allIds[objBase.currentQuestion.index]) {
            return layer.msg(objBase.error ? objBase.error : '没有题目了咯', {icon:2})
        }

        // 处理查看详情
        $('#info').addClass('hide');
        $('#see-info').html('查看详情');

        objBase.pk = String(allIds[objBase.currentQuestion.index]);

        // 判断该题目是否已经请求过
        if (objBase.request[objBase.pk]) {
            // 更新问题信息, 重新配置当前问题信息
            objBase.initData(objBase.request[objBase.pk].question, objBase.request[objBase.pk].answer, objBase.request[objBase.pk].hasCollect);
            objBase.renderQuestion();
        } else {
            objBase.loading = layer.load();
            $.ajax({
                url: '<?=Url::toRoute(['question/get-question'])?>',
                type: 'POST',
                dataType: 'json',
                data: {
                    qid: allIds[objBase.currentQuestion.index]
                }
            }).always(function(){
                layer.close(objBase.loading);
            }).done(function(json){
                if (json.errCode == 0) {

                    // 处理显示问题
                    if (json.data.question) {
                        // 更新问题信息, 重新配置当前问题信息
                        objBase.initData(json.data.question, json.data.answers, json.data.hasCollect);
                        objBase.initRequest();
                        objBase.renderQuestion();
                    }
                } else {
                    layer.msg(json.errMsg, {icon: 2});
                }
            }).fail(function(error) {
                layer.msg('服务器繁忙, 请稍候再试...');
            });
        }
    }

    $(window).ready(function(){
        // 选择答案
        $(document).on('click', '#answers p', function() {
            // 转字符串
            var key = String(objBase.question.id), // 标识KEY
                selfAnswer = parseInt($(this).attr("answer")); // 问题答案

            // 判断该题目是否已经做过
            if (objBase.question.answer_type == 4 || objBase.complete[key]) {
                // 做过
                return false;
            } else {

                // 已经点击过
                if ($(this).hasClass("do-complete")) {
                    return false;
                }

                // 标识已经点击
                $(this).addClass("do-complete");

                // 多选
                if (objBase.question.answer_type == 3) {
                    // 选择正确没有问题
                    if (objBase.isCorrect(selfAnswer)) {

                        $(this).addClass("dui");

                        // 添加选择正确的答案到答案信息中
                        objBase.insertAnswer(selfAnswer);

                        // 判断是否回答正确
                        if (!objBase.equalCorrect()) {
                            return false;
                        }

                        // 全部正确
                        objBase.yesIncr();
                        objBase.currentQuestion.complete = 'yes';
                        $("#do-yes-answer").removeClass('hide');
                    } else {
                        // 选择错误，该题目已经做错
                        $(this).addClass("xuan");

                        // 正确答案显示出来
                        var yesHtml = "";
                        objBase.currentQuestion.correct.forEach(function(v, k) {
                            yesHtml += $("#answers p[answer=" + v + "]").addClass("dui").text()  + " ";
                        });

                        // 显示正确答案和错题目累加
                        $('#do-no-answer').removeClass('hide').find('#answer-yes').html(yesHtml);
                        objBase.noIncr();
                        objBase.currentQuestion.complete = 'no';
                    }
                } else {
                    // 判断对错
                    if ($(this).attr('answer') == objBase.question.answer_id) {
                        // 正确
                        $(this).addClass('dui');
                        objBase.yesIncr();
                        objBase.currentQuestion.complete = 'yes';
                        $("#do-yes-answer").removeClass('hide');
                    } else {
                        // 错误
                        $(this).addClass('xuan');
                        var doYes = $('#answers p[answer=' + objBase.question.answer_id + ']').addClass('dui');
                        $('#do-no-answer').removeClass('hide').find('#answer-yes').html(doYes.text());
                        objBase.noIncr();
                        objBase.currentQuestion.complete = 'no';
                    }
                }

                // 保存已经做完问题信息
                objBase.complete[key] = {
                    index: objBase.question.id,
                    userAnswer: objBase.currentQuestion, // 用户回答信息
                    userText: null, // 只有在是填空题时候添加
                    complete: objBase.currentQuestion.complete // 完成情况
                };

                // 计算正确率
                objBase.handleCorrectRate();

                // 请求记录信息
                $.ajax({
                    url: '<?=Url::toRoute(['question/record'])?>',
                    data: {
                        qid: objBase.complete[key]["index"],
                        sType: objBase.complete[key]["complete"]
                    },
                    type: 'POST',
                    dataType: 'json'
                }).done(function(json) {
                    // 选择正确自动下一题目、响应正常、回答正确
                    if (json.errCode == 0 && $('#isAutoNext').is(':checked') && objBase.complete[key]["complete"] == 'yes') {
                        getQuestion('next');
                    }
                });
            }
        });

        // 上一题 下一题
        $('#prev').add('#next').click(function(){
            getQuestion($(this).attr('id'));
        });

        // 收藏问题
        $('#user-collect').click(function(){
            var self = $(this), hasCollect = self.hasClass('on');
            if (objBase.question.id > 0) {
                $.ajax({
                    url: '<?=Url::toRoute(['user/create-collect'])?>',
                    data: {
                        qid: objBase.question.id,
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
            if (objBase.complete[objBase.question.id]) {
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

    // 表单提交
    $("#question-form").submit(function(evt) {
        evt.preventDefault();

        // 验证通过
        if ($(this).validate().form()) {
            var key = String(objBase.question.id); // 标识KEY
            if (objBase.question.answer_type != 4 || objBase.complete[key]) {
                return false;
            } else {
                // 获取正确答案信息
                objBase.setAnswerText();

                // 默认认为做正确
                objBase.yesIncr();

                // 保存已经做完问题信息
                objBase.complete[key] = {
                    index: objBase.question.id,
                    userAnswer: objBase.currentQuestion, // 用户回答信息
                    userText: $("#question-answer-text").val(), // 只有在是填空题时候添加
                    complete: objBase.currentQuestion.complete // 完成情况
                };
            }
        }
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