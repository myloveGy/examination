<?php

use yii\helpers\Json;
use yii\helpers\Url;
use common\models\Question;

$this->title = '全真模拟';
$this->registerCssFile('@web/css/imitate.css');
$array = range('A', 'z');
?>
<?=$this->render('_crumbs')?>
<div class="info-up clearfix row">
    <div class="infoup-left clearfix pull-left col-md-3">
        <fieldset class="kaochang-info">
            <legend>理论考试</legend>
            <span>第01考台</span>
        </fieldset>
        <fieldset class="kaosheng-info">
            <legend>考生信息</legend>
            <div>
                <div class="info-img">
                    <img src="/images/diandian.png">
                </div>
                <p class="name">
                    考生姓名：<span class="nickname ellipsis">我是车神</span>
                </p>
                <p>考试题数：100题</p>
                <p>考试时间：45分钟</p>
                <p>合格标准：满分100分</p>
                <p class="text-right">90及格</p>
            </div>
        </fieldset>
    </div>
    <div class="infoup-center pull-right col-md-9">
        <fieldset class="kaochang-main">
            <legend>考试题目</legend>
            <div class="timu-container">
                <div class="timu-item clearfix">
                    <div class="timu-content">
                        <div class="pull-left col-md-6">
                            <div class="timu-x">
                                <p class="timu-p"><span id="do-number">1</span>/<span>100</span>. <span id="question-title"><?=$question->question_title?></span></p>
                            </div>
                            <div id="answers">
                                <?php if ($answers) : ?>
                                <?php foreach ($answers as $value) : ?>
                                <p data-id="<?=$value->id?>"><?=$value->name?></p>
                                <?php endforeach;?>
                                <?php endif; ?>
                            </div>
                        </div>
                        <div id="show-img" class="pull-right col-md-6 text-right <?=$question->question_img ? '' : 'hide'?>">
                            <img class="clearfix" src="<?=$question->question_img?>" style="width:300px; max-height:120px;">
                            <p class="text-center">
                                <a href="javascript:;" class="see-img">查看大图</a>
                            </p>
                        </div>
                    </div>
                    <div class="result-container pull-right row">
                        <div class="result-info col-md-6">
                            <p id="question-desc" class="hide">
                                <span class="al is-dui dui"> 回答正确! </span>
                                <span class="al is-cuo cuo"> 回答错误! </span>
                                <span class="al2 is-cuo">您的答案：</span>
                                <span class="al3 is-cuo"><strong id="do-no"></strong></span>
                                <span class="al2">正确答案：</span>
                                <span class="al3"><strong id="do-yes"></strong></span>
                                <span class="al4"><a href="javascript:;" id="why">为什么？</a></span>
                            </p>
                        </div>
                        <div class="options-container col-md-6 text-left">
                            <label>请选择：</label>
                            <span id="select-answers">
                                <?php if ($answers) : ?>
                                <?php foreach ($answers as $key => $value) : ?>
                                <button type="button" class="btn btn-default" data-answer="<?=$value->id?>"><?=isset($array[$key]) ? $array[$key] : substr($value->name, 0, 1)?></button>
                                <?php endforeach; ?>
                                <?php endif; ?>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </div>
</div>
<div class="info-middle clearfix row">
    <div class="col-md-3">
        <fieldset class="time-info pull-left">
            <legend>剩余时间</legend>
            <span data-item="left-time"><span id="minute">45</span>:<span id="second">00</span></span>
        </fieldset>
    </div>
    <div class="col-md-6">
        <fieldset class="tip-container pull-left">
            <legend>提示信息</legend>
            <div id="answer-type" class="tip-content" data-item="tip-content"><?= Question::getAnswerTypeDesc($question->answer_type) ?></div>
        </fieldset>
    </div>
    <div class="fun-btns col-md-3">
        <button type="button" class="btn btn-info" id="prev">上一题</button>
        <button type="button" class="btn btn-info" id="next">下一题</button>
        <button type="button" class="btn btn-success pull-right" id="examination-submit">交卷</button>
    </div>
</div>
<div class="info-down clearfix">
    <fieldset>
        <legend>答题信息</legend>
        <div class="datika-container" data-item="datika-container">
            <ul class="datika" id="select-question">
                <?php if ($allIds) : ?>
                <?php foreach ($allIds as $key => $value) : ?>
                <li class="row0 col0 <?=$key == 0 ? 'current' : ''?>" data-id="<?= $value ?>"><?= $key + 1 ?></li>
                <?php endforeach; ?>
                <?php endif; ?>
            </ul>
        </div>
    </fieldset>
</div>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    var minute = 44,
        second = 59,
        sInter = null,
        allIds = <?=Json::encode($allIds)?>,
        doQuestions = {},
        iQuestionId = <?=$question->id?>,
        iAnswerId = <?=$question->answer_id?>,
        oFirstQuestion = <?=Json::encode($question->toArray())?>,
        aAnswersSelect = <?=Json::encode($array)?>,
        oFirstAnswers = <?=Json::encode($answers)?>,
        iKey = 0,
        first = true;

        // 第一个问题已经处理
        oFirstQuestion["answers"] = oFirstAnswers;

    // 获取对象个数
    function count(obj, key, val) {
        var iTotal = 0;
        for (var i in obj) {
            if (key) {
                if (obj[i][key] == val) {
                    iTotal ++;
                }
            } else {
                iTotal ++;
            }
        }

        return iTotal;
    }

    // 开始设置时间
    function startInter() {
        return setInterval(function(){
            if (first) {
                $('#minute').html('44');
                first = false;
            }
            if (second == 0) {
                second = 59;
                $('#second').html('00');
                minute --;
                if (minute <= 0) {
                    $('#minute').html('00');
                    examinationPerformance();
                } else {
                    $('#minute').html((minute < 10 ? '0' : '') + minute);
                }
            } else {
                $('#second').html((second < 10 ? '0' : '') + second);
                second --;
            }
        }, 1000);
    }

    // 重新渲染问题信息
    function renderQuestion(question, answer) {
        $('#question-title').html(question.question_title);
        $("#answer-type").html(getAnswerTypeDesc(question.answer_type));
        if (question.question_img) {
            $('#show-img').removeClass('hide').find('img').attr('src', question.question_img);
        } else {
            $('#show-img').addClass('hide');
        }

        if (answer) {
            var html = '', selector = '';
            for (var i in answer) {
                html += '<p data-id="'+answer[i]["id"]+'">' + answer[i]["name"] + '</p> ';
                selector += '<button type="button" class="btn btn-default" data-answer="' + answer[i]["id"] + '"> ' + (aAnswersSelect[i] ? aAnswersSelect[i] : answer[i]["name"]) + ' </button> ';
            }

            $('#answers').html(html);
            $('#select-answers').html(selector);
        }

        // 判断是否已经存在
        if (doQuestions[question.id]) {
            var $q = $("#question-desc").removeClass("hide");
            if (doQuestions[question.id]["do"] == "yes") {
                $q.find("span.is-dui").show();
                $q.find("span.is-cuo").hide();
            } else {
                $("#do-no").html($("#select-answers").find("button[data-answer=" + doQuestions[question.id]["select_answer"] + "]").html());
                $q.find("span.is-dui").hide();
                $q.find("span.is-cuo").show();
            }

            $("#do-yes").html($("#select-answers").find("button[data-answer=" + doQuestions[question.id]["answer_id"] + "]").html());
        } else {
            $("#question-desc").addClass("hide");
        }

        // 重新赋值
        iQuestionId = question.id;
        iAnswerId = question.answer_id;
        oFirstQuestion = question;
        oFirstQuestion["answers"] = answer;
        $("#select-question").find("li:eq(" + iKey + ")").addClass("current").siblings("li").removeClass("current");
        $('#do-number').html(iKey + 1);
    }

    function getQuestion(type, iIndex) {
        // 判断是否已经处理过
        switch (type) {
            case "next":
                iKey ++;
                break;
            case "prev":
                iKey --;
                break;
            case "select":
                iKey = iIndex;
                break;
        }

        // 越界
        if (iKey < 0 || iKey > 99) {
            return layer.msg('没有题目了');
        }

        var iQid = allIds[iKey];
        if (doQuestions[iQid]) {
            renderQuestion(doQuestions[iQid], doQuestions[iQid]["answers"]);
        } else {
            var ol = layer.load();
            $.ajax({
                url: '<?=Url::toRoute(['question/get-question'])?>',
                type: 'POST',
                dataType: 'json',
                data: {qid: iQid}
            }).always(function(){
                layer.close(ol);
            }).done(function(json){
                if (json.errCode == 0) {
                    // 处理显示问题
                    if (json.data.question) {
                        renderQuestion(json.data.question, json.data.answers);
                    }
                } else {
                    layer.msg(json.errMsg, {icon: 2});
                }
            }).fail(function(error) {
                console.info(error);
                layer.msg('服务器繁忙, 请稍候再试...');
            });
        }
    }

    function examinationPerformance() {
        clearInterval(sInter);
        var
            dui = count(doQuestions, 'do', 'yes'),
            duiRote = Math.round(dui / 100 * 100, 2),
            cuoRote = 100 - duiRote;
        var p = '<div class="performance">\
        <p> 考试题数：100题 </p>\
        <p>\
            <span>做对 <strong class="yes"> ' + dui + ' </strong> 题</span>\
            <span>占比 ' + duiRote.toFixed(2) + ' %</span>\
        </p>\
        <p>\
            <span>做错 <strong class="no"> ' + (100 - dui) + ' </strong> 题</span>\
            <span>占比 ' + cuoRote.toFixed(2) + ' %</span>\
        </p>\
        <p>\
        分数： <strong class="fraction">' + dui+ '</strong>\
        </p>\
        </div>';
        layer.open({
            title : '模拟成绩',
            content: p,
            btn: ['重新开始', '取消'],
            yes: function(index, ly) {
                window.location.reload();
            },
            btn2: function(index, ly) {
                startInter();
            }
        });
    }

    $(window).ready(function(){
        // 加载完成
        layer.alert('按交管部门通知，科目一考试系统全面更新。全真模拟考试下不能修改答案，每做一题，系统自动计算错误题数，及格标准为90分。', {title: '温馨提示', end: function(){
            // 定时时间
            sInter = startInter();
        }});

        // 上一题和下一题
        $("#prev").add("#next").click(function(){
            return getQuestion($(this).attr('id'));
        });

        // 选择答案
        $(document).on('click', 'span#select-answers button', function() {
            if (doQuestions[iQuestionId]) {
                return false;
            } else {
                var iAId = $(this).attr('data-answer'), sClass = '';
                if (iAId == iAnswerId) {
                    oFirstQuestion["do"] = 'yes';
                    sClass = 'dui';
                } else {
                    oFirstQuestion["do"] = 'no';
                    sClass = 'cuo';
                }

                // 你的选择
                oFirstQuestion["select_answer"] = iAId;

                // 添加做完题目
                if ( ! doQuestions[oFirstQuestion.id]) {
                    doQuestions[oFirstQuestion.id] = oFirstQuestion;
                }

                // 题目对错
                $('#select-question li[data-id=' + iQuestionId + ']').addClass(sClass);
                getQuestion('next');
            }
        });

        // 自动选择
        $("#select-question li").click(function(){
            getQuestion('select', $(this).index("#select-question li"));
        });

        // 查看大图
        imageBoost('a.see-img');

        // 提交试卷
        $('#examination-submit').click(function(){
            var doNum = count(doQuestions);
            if (doNum < 100) {
                // 询问框
                layer.confirm('您还有' + (100 - doNum )+ '道题目没做, 确实需要交卷吗?', {
                    title: '温馨提醒',
                    btn: ['确定','取消'],
                    shift: 4,
                    icon: 0
                    // 确认删除
                }, function(){
                    examinationPerformance();
                    // 取消删除
                }, function(){layer.msg('请耐心作答哦！', {time:800, icon: 6});});
            } else {
                examinationPerformance();
            }
        });

        // 查询原因
        $("#why").click(function(){
            if (allIds[iKey]) {
                if (doQuestions[allIds[iKey]]) {
                    layer.alert(doQuestions[allIds[iKey]]["question_content"], {
                        title: '题目解析'
                    })
                } else {
                    layer.msg('你还没有完成该题目');
                }
            }
        });
    })
</script>
<?php $this->endBlock() ?>
