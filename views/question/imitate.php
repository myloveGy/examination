<?php

use yii\helpers\Json;
use yii\helpers\Url;
use app\common\models\Question;
$this->title = '全真模拟';
$this->registerCssFile('@web/css/imitate.css');
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
                                <p class="timu-p">
                                    <span id="do-number">1</span>/<span>100</span>.
                                    <span id="question-title"><?=$question->question_title?></span>
                                </p>
                            </div>
                            <div id="answers" class="<?=$question->answer_type == 4 ? 'hide' : ''?>">
                                <?php if ($answers) : ?>
                                <?php foreach ($answers as $value) : ?>
                                <p data-id="<?=$value->id?>"><?=$value->name?></p>
                                <?php endforeach;?>
                                <?php endif; ?>
                            </div>
                            <div id="answer-text" class="<?=$question->answer_type == 4 ? '' : 'hide'?>">
                                <form id="submit-answer">
                                    <textarea id="question-answer-text" name="question-answer" class="form-control" required="true" rangelength="[2, 1000]" rows="3" placeholder="请填写答案"></textarea>
                                    <div class="span4"></div>
                                    <button type="submit" class="btn btn-default">提交答案</button>
                                </form>
                                <div class="span4 text-answer hide" id="text-answer-div">
                                    <p>正确答案信息： </p>
                                    <p id="text-answer" class="text-success"></p>
                                </div>
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
                        <div class="options-container col-md-6 text-left <?=$question->answer_type == 4 ? 'hide' : ''?>" id="right-answer">
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
        var meBase = {
            inter: null, // 开启定时
            allQuestions: <?=Json::encode($allIds)?>, // 所有问题信息
            pk: "<?=$question->id?>", // 主键ID
            index: 0, // 回答问题位置
            minute: 44, // 分钟
            second: 59, // 秒数
            first: true,
            fraction: 0, // 分数
            question: null,
            answer: null,
            current: {
                complete: false, // 是否已经做
                correct: [],
                answer: []
            },
            html: "",
            loading: null,
            complete: {}, // 完成题目
            doNumber: 0, // 已经完成的题目
            yesNumber: 0, // 做对题目
            noNumber: 0, // 做错题目
            request: {},
            answerLetter: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"],

            // 添加数据到请求数据里面
            insertRequest: function(question, answer) {
                if (!question) question = this.question;
                if (!answer) answer = this.answer;
                if (!this.request[question.id]) {
                    this.request[question.id] = {
                        question: question,
                        answer: answer
                    };
                }
            },

            // 添加完成问题信息
            addComplete: function(pk, complete, answer) {
                if (!this.complete[pk]) {

                    this.doNumber ++;

                    this.complete[pk] = {
                        index: pk,
                        complete: complete,
                        answer: answer
                    };

                    // 计算得分和做对做错题目数
                    switch (complete) {
                        case "yes":
                            this.fraction += 1;
                            this.yesNumber ++;
                            break;
                        case "all":
                            this.fraction += 1;
                            this.yesNumber ++;
                            break;
                        case "missing":
                            this.fraction += 0.5;
                            this.yesNumber ++;
                            break;
                        default:
                            this.noNumber ++;
                            return false;
                    }

                    // 添加该题目Class
                    $('#select-question li[data-id=' + meBase.question.id + ']').addClass(complete == "no" ? "cuo": "dui");
                }
            },

            // 填空题显示正确答案
            setAnswerText: function() {
                // 显示正确答案信息
                $("#text-answer-div").removeClass("hide");
                var html = "";
                this.answer.forEach(function(v, k){
                    if (v.id == meBase.question.answer_id) {
                        html += v.name;
                    }
                });

                $("#text-answer").html(html);
            },

            // 初始化问题信息
            initQuestion: function (question, answer) {
                this.question = question;
                this.answer = answer;
                this.pk = this.question.id;
                this.current.answer = [];
                this.current.correct = [];
                this.current.complete = false;
                if (this.question.answer_type == 3) {
                    this.current.correct = $.parseJSON(this.question.answer_id);
                    console.info(this.current)
                }
            },

            // 获取问题信息
            getQuestion: function(id, func) {
                this.loading = layer.load();
                $.ajax({
                    url: "<?=Url::toRoute(['question/get-question'])?>",
                    type: "POST",
                    dataType: "json",
                    data: {qid: id}
                }).always(function(){
                    layer.close(meBase.loading);
                }).done(function(json){
                    if (json.errCode == 0) {
                        // 处理显示问题
                        if (json.data.question) {
                            meBase.initQuestion(json.data.question, json.data.answers);
                            meBase.insertRequest(); // 添加请求数据到请求对象中
                            meBase.renderQuestion();
                            if (func) func(json.data);
                        }
                    } else {
                        layer.msg(json.errMsg, {icon: 2});
                    }
                }).fail(function() {
                    layer.msg('服务器繁忙, 请稍候再试...');
                });
            },

            renderQuestionDesc: function(type, func) {
                var $q = $("#question-desc").removeClass("hide");
                if (type == "yes") {
                    $q.find("span.is-dui").show();
                    $q.find("span.is-cuo").hide();
                } else {
                    $q.find("span.is-dui").hide();
                    $q.find("span.is-cuo").show();
                }
            },

            initAnswerText: function() {
                // 判断题目类型
                if (this.question.answer_type == 4) {
                    $("#answers").add("#right-answer").addClass("hide");
                    $("#answer-text").removeClass("hide");
                } else {
                    $("#answers").add("#right-answer").removeClass("hide");
                    $("#answer-text").addClass("hide");
                }
            },

            // 渲染问题
            renderQuestion: function() {

                // 处理标题
                $('#question-title').html(this.question.question_title);
                // 处理类型
                $("#answer-type").html(getAnswerTypeDesc(this.question.answer_type));

                this.initAnswerText();

                // 存在图片
                if (this.question.question_img) {
                    $('#show-img').removeClass('hide').find('img').attr('src', this.question.question_img);
                } else {
                    $('#show-img').addClass('hide');
                }

                // 处理问题信息
                if (this.answer) {
                    this.html = "";
                    var selector = '';
                    for (var i in this.answer) {
                        this.html += '<p data-id="' + this.answer[i]["id"] + '">' + this.answer[i]["name"] + '</p> ';
                        selector += '<button type="button" class="btn btn-default" data-answer="' + this.answer[i]["id"] + '"> ' + (this.answerLetter[i] ? this.answerLetter[i] : this.answer[i]["name"]) + ' </button> ';
                    }

                    $('#answers').html(this.html);
                    $('#select-answers').html(selector);
                }

                // 判断是否已经存在
                if (this.complete[this.question.id]) {
                    this.renderQuestionDesc(this.complete[this.question.id]["complete"]);
                    if (this.question.answer_type == 3) {
                        this.html = "";
                        this.current.correct.forEach(function(v, k) {
                            meBase.html += $("#select-answers").find("button[data-answer=" + v + "]").html();
                        });
                        $("#do-yes").html(this.html);
                    } else {
                        $("#do-yes").html($("#select-answers").find("button[data-answer=" + this.complete[this.question.id]["answer_id"] + "]").html());
                    }

                } else {
                    $("#question-desc").addClass("hide");
                }

                $("#select-question").find("li:eq(" + this.index + ")").addClass("current").siblings("li").removeClass("current");
                $('#do-number').html(this.index + 1);
            },

            // 处理问题
            handleQuestion: function(type, iIndex) {
                // 判断是否已经处理过
                switch (type) {
                    case "next":
                        meBase.index ++;
                        break;
                    case "prev":
                        meBase.index --;
                        break;
                    case "select":
                        meBase.index = iIndex;
                        break;
                }

                // 数组越界
                if (this.index < 0 || this.index > this.allQuestions.length) {
                    return layer.msg('没有题目了');
                }

                // 获取主键
                this.pk = this.allQuestions[this.index];

                if (this.request[this.pk]) {
                    this.initQuestion(this.request[this.pk]["question"], this.request[this.pk]["answer"]);
                    this.renderQuestion();
                } else {
                    this.getQuestion(this.pk);
                }
            }
        };

        meBase.initQuestion(<?=Json::encode($question)?>, <?=Json::encode($answers)?>);
        meBase.insertRequest();

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
            if (meBase.first) {
                $('#minute').html('44');
                meBase.first = false;
            }

            if (meBase.second == 0) {
                meBase.second = 59;
                $('#second').html('00');
                meBase.minute --;
                if (meBase.minute <= 0) {
                    $('#minute').html('00');
                    examinationPerformance();
                } else {
                    $('#minute').html((meBase.minute < 10 ? '0' : '') + meBase.minute);
                }
            } else {
                $('#second').html((meBase.second < 10 ? '0' : '') + meBase.second);
                meBase.second --;
            }
        }, 1000);
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

            yes: function() {
                window.location.reload();
            },

            btn2: function() {
                startInter();
            }
        });
    }

    $(window).ready(function(){
        // 加载完成
//        layer.alert('按交管部门通知，科目一考试系统全面更新。全真模拟考试下不能修改答案，每做一题，系统自动计算错误题数，及格标准为90分。多选，单选，填空题均为1分, 多选选错不计分,漏选0.5分', {title: '温馨提示', end: function(){
//            // 定时时间
//            sInter = startInter();
//        }});

        // 上一题和下一题
        $("#prev").add("#next").click(function(){
            if (meBase.current.complete && meBase.question.answer_type == 3) {
                // 添加做完题目
                meBase.addComplete(meBase.pk, "missing", meBase.current.answer);
            }
            return meBase.handleQuestion($(this).attr('id'));
        });

        // 提交答案
        $("#submit-answer").submit(function(evt){
            meBase.current.complete = true;
            evt.preventDefault();
            // 改题目已经做完
            if (meBase.complete[meBase.pk]) {
                return false;
            } else {
                // 显示正确答案
                meBase.setAnswerText();
                meBase.renderQuestionDesc("yes");
                // 添加回答完问题
                meBase.addComplete(meBase.pk, "yes", $("#question-answer-text").val());
                $('#select-question li[data-id=' + meBase.question.id + ']').addClass("dui");
            }
        });

        // 选择答案
        $(document).on('click', 'span#select-answers button', function() {
            if (meBase.complete[meBase.pk]) {
                return false;
            } else {
                meBase.current.complete = true; // 标识改题目已做
                var type = "no", iAnswerId = parseInt($(this).attr("data-answer"));
                if (meBase.question.answer_type == 3) {
                    if ($.inArray(iAnswerId, meBase.current.correct) !== -1) {
                        $(this).addClass("btn-success");
                        // 添加到正确选择中
                        if ($.inArray(iAnswerId, meBase.current.answer) === -1) meBase.current.answer.push(iAnswerId);
                        if (meBase.current.correct.length != meBase.current.answer.length) return false;
                        type = "yes";

                    } else {
                        type = "no";
                        $(this).addClass("btn-danger");
                    }
                } else {
                    if (meBase.question.answer_id == iAnswerId) {
                        type = 'yes';
                        $(this).addClass("btn-success");
                    } else {
                        type = "no";
                        $(this).addClass("btn-danger");
                    }
                }

                // 添加做完题目
                meBase.addComplete(meBase.pk, type, iAnswerId);
                meBase.handleQuestion('next');
            }
        });

        // 自动选择
        $("#select-question li").click(function(){
            if (meBase.current.complete && meBase.question.answer_type == 3) {
                // 添加做完题目
                meBase.addComplete(meBase.pk, "missing", meBase.current.answer);
            }

            meBase.handleQuestion('select', $(this).index("#select-question li"));
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
            if (meBase.question) {
                if (meBase.complete[meBase.question.id]) {
                    layer.alert(meBase.request[meBase.question.id]["question"]["question_content"], {
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
