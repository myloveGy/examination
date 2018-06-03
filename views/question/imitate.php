<?php

use yii\helpers\Json;
use yii\helpers\Url;
use app\models\Question;
$this->title = '全真模拟';
$this->registerCssFile('@web/css/imitate.css');
$array = range('A', 'J');
?>
<?=$this->render('_crumbs')?>
<div class="info-up clearfix row">
    <div class="infoup-left clearfix pull-left col-md-3">
        <fieldset class="kaochang-info">
            <legend>科目考试</legend>
            <span>第01考台</span>
        </fieldset>
        <fieldset class="kaosheng-info">
            <legend>考生信息</legend>
            <div>
                <div class="info-img">
                    <img src="/images/diandian.png">
                </div>
                <p class="name">
                    考生姓名：<span class="nickname ellipsis">我是考霸</span>
                </p>
                <p>考试题数：<?=count($allIds)?>题</p>
                <p>考试时间：<?=$config['time']?>分钟</p>
                <p>合格标准：满分<?=$config['totalScore']?>分</p>
                <p class="text-right"><?=$config['passingScore']?>及格</p>
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
                                    <span id="do-number">1</span>/<span><?=count($allIds)?></span>.
                                    <span id="question-title"><?=$question->question_title?></span>
                                </p>
                            </div>
                            <div id="answers" class="<?=$question->answer_type == 4 ? 'hide' : ''?>">
                                <?php if ($answers) : ?>
                                <?php foreach ($answers as $key => $value) : ?>
                                <p data-id="<?=$key?>"><?=$value?></p>
                                <?php endforeach;?>
                                <?php endif; ?>
                            </div>
                            <div id="answer-text" class="<?=$question->answer_type == 4 ? '' : 'hide'?>">
                                <form id="submit-answer">
                                    <div class="form-group">
                                        <textarea id="question-answer-text" name="question-answer" class="form-control" required="true" rangelength="[2, 1000]" rows="3" placeholder="请填写答案"></textarea>
                                    </div>
                                    <div class="span4"></div>
                                    <button type="submit" class="btn btn-default">提交答案</button>
                                </form>
                                <div class="span4 text-answer hide" id="text-answer-div">
                                    <p>正确答案信息： </p>
                                    <p id="text-answer" class="text-success"></p>
                                </div>
                                <div class="span4"></div>
                                <form id="score-form" class="form-inline hide">
                                    <div class="form-group">
                                        <label for="me-score">分数</label>
                                        <input type="text" name="score" required="true" number="true" max="<?=$config['shortScore']?>" class="form-control" id="me-score" placeholder="请自己打分"/>
                                    </div>
                                    <button type="submit" class="btn btn-default">确定</button>
                                </form>
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
                                <span class="al2 dui-answer">正确答案：</span>
                                <span class="al3 dui-answer"><strong id="do-yes"></strong></span>
                                <span class="al4"><a href="javascript:;" id="why">为什么？</a></span>
                            </p>
                        </div>
                        <div class="options-container col-md-6 text-left <?=$question->answer_type == 4 ? 'hide' : ''?>" id="right-answer">
                            <label>请选择：</label>
                            <span id="select-answers">
                                <?php if ($answers) : ?>
                                <?php foreach ($answers as $key => $value) : ?>
                                <button type="button" class="btn btn-default" data-answer="<?=$key?>"><?=isset($array[$key]) ? $array[$key] : substr($value, 0, 1)?></button>
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
            <span data-item="left-time"><span id="minute"><?=$config['time']?></span>:<span id="second">00</span></span>
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
            minute: <?=$config['time'] - 1?>, // 分钟
            second: 59, // 秒数
            first: true,
            fraction: 0, // 分数
            score: {
                "1": <?=$config['judgmentScore']?>,
                "2": <?=$config['selectScore']?>,
                "3": <?=$config['multipleScore']?>,
                "4": <?=$config['shortScore']?>
            },

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
            yesRote: 0, // 正确率
            yesNumber: 0, // 做对题目
            noRote: 0, // 错误率
            noNumber: 0, // 做错题目
            request: {},
            answerLetter: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"],
            desc: "全真模拟考试下不能修改答案，每做一题，系统自动计算错误题数，及格标准为<?=$config['passingScore']?>分." +
            "判断题共<?=$config['judgmentNumber']?>题，每题<?=$config['judgmentScore']?>分;" +
            "单选题共<?=$config['selectNumber']?>题，每题<?=$config['selectScore']?>分;"+
            "多选题共<?=$config['multipleNumber']?>题，每题<?=$config['multipleScore']?>分,漏选1分;"+
            "问答题共<?=$config['shortNumber']?>题，每题<?=$config['shortScore']?>分;",

            getScore: function(answer_type) {
                return this.score[answer_type];
            },

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
            addComplete: function(pk, complete, answer, score) {
                if (!this.complete[pk]) {

                    this.complete[pk] = {
                        index: pk,
                        complete: complete,
                        answer: answer
                    };

                    this.doNumber ++;

                    // 计算得分和做对做错题目数
                    switch (complete) {
                        case "yes":
                            this.complete[pk]["score"] = parseInt(this.question.answer_type) === 4 ? score : this.getScore(this.question.answer_type);
                            this.yesNumber ++;
                            break;
                        case "missing":
                            this.complete[pk]["score"] = Math.floor(this.getScore(this.question.answer_type) / 2);

                            this.yesNumber ++;
                            break;
                        default:
                            this.complete[pk]["score"] = 0;
                            this.noNumber ++;
                    }

                    // 计算分数
                    this.fraction += this.complete[pk]["score"];

                    // 添加该题目Class
                    $('#select-question li[data-id=' + this.question.id + ']').addClass(complete == "no" ? "cuo": "dui");
                }
            },

            // 填空题显示正确答案
            setAnswerText: function() {
                // 显示正确答案信息
                $("#text-answer-div").removeClass("hide");
                var html = "";
                this.answer.forEach(function(v, k){
                    if (k == meBase.question.answer_id) {
                        html += v;
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
                if (type === "yes" || type === "missing") {
                    $q.find("span.is-dui").show();
                    $q.find("span.is-cuo").hide();
                } else {
                    $q.find("span.is-dui").hide();
                    $q.find("span.is-cuo").show();
                }
            },

            initAnswerText: function() {
                // 判断题目类型
                if (parseInt(this.question.answer_type) === 4) {
                    $("#question-desc").find(".dui-answer").hide();
                    $("#submit-answer").get(0).reset();
                    $("#answers").add("#right-answer").addClass("hide");
                    $("#answer-text").removeClass("hide");
                    $("#text-answer-div").addClass("hide");
                    $("#text-answer").html("");
                    $("#score-form").addClass("hide");
                    $("#me-score").val("");
                } else {
                    $("#question-desc").find(".dui-answer").show();
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
                        this.html += '<p data-id="' + i + '">' + this.answer[i] + '</p> ';
                        selector += '<button type="button" class="btn btn-default" data-answer="' + i + '"> ' + (this.answerLetter[i] ? this.answerLetter[i] : this.answer[i]) + ' </button> ';
                    }

                    $('#answers').html(this.html);
                    $('#select-answers').html(selector);
                } else {
                    $('#answers').html("");
                    $('#select-answers').html("");
                }

                // 判断是否已经存在
                $("#do-yes").html("");
                if (this.complete[this.question.id]) {
                    this.renderQuestionDesc(this.complete[this.question.id]["complete"]);
                    if (this.question.answer_type == 3) {
                        this.html = "";
                        this.current.correct.forEach(function(v, k) {
                            meBase.html += $("#select-answers").find("button[data-answer=" + v + "]").html();
                        });
                        $("#do-yes").html(this.html);
                    } else {
                        $("#do-yes").html($("#select-answers").find("button[data-answer=" + this.question.answer_id + "]").html());
                    }

                    // 确定选择
                    switch (this.question.answer_type) {
                        case 3: // 多选
                            if (typeof this.complete[this.pk].answer == "object") {
                                this.complete[this.pk].answer.forEach(function(v, k) {
                                    $("#select-answers").find("button[data-answer=" + v + "]").addClass("btn-success");
                                });
                            } else {
                                $("#select-answers").find("button[data-answer=" + this.complete[this.pk].answer + "]").addClass("btn-danger");
                            }
                            break;

                        case 4: // 填空
                                this.setAnswerText();
                                $("#question-answer-text").val(this.complete[this.pk].answer);
                                $("#me-score").val(this.complete[this.pk].score);
                                $("#score-form").removeClass("hide");
                            break;

                        default:
                            $("#select-answers")
                                .find("button[data-answer=" + this.complete[this.pk].answer + "]")
                                .addClass(this.complete[this.pk]["complete"] == "no" ? "btn-danger" : "btn-success");

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
                        if (meBase.index < this.allQuestions.length) {
                            meBase.index ++;
                        }
                        break;
                    case "prev":
                        if (meBase.index > 0) {
                            meBase.index --;
                        }
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
            },

            // 开始定时
            startInter: function() {
                this.inter = setInterval(function(){
                    if (meBase.first) {
                        $('#minute').html(meBase.minute);
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
        };

        meBase.initQuestion(<?=Json::encode($question)?>, <?=Json::encode($answers)?>);
        meBase.insertRequest();

    function examinationPerformance() {
        clearInterval(meBase.inter);
        meBase.yesRote = Math.round(meBase.yesNumber / meBase.allQuestions.length * 100, 2);
        meBase.noRote = Math.round(meBase.noNumber / meBase.allQuestions.length * 100, 2);

        meBase.html = '<div class="performance">\
        <p> 考试题数：' + meBase.allQuestions.length + '题 </p>\
        <p>\
            <span>做对 <strong class="yes"> ' + meBase.yesNumber + ' </strong> 题</span>\
            <span>占比 ' + meBase.yesRote.toFixed(2) + ' %</span>\
        </p>\
        <p>\
            <span>做错 <strong class="no"> ' + (meBase.noNumber) + ' </strong> 题</span>\
            <span>占比 ' + meBase.noRote.toFixed(2) + ' %</span>\
        </p>\
        <p> 有 <strong>' + (meBase.allQuestions.length - meBase.doNumber) + '</strong> 题没有做 </p>\
        <p>\
        分数： <strong class="fraction">' + meBase.fraction + '</strong>\
        </p>\
        </div>';
        layer.open({
            title : '模拟成绩',
            content: meBase.html,
            btn: ['重新开始', '继续做题'],

            yes: function() {
                window.location.reload();
            },

            btn2: function() {
                meBase.startInter();
            }
        });
    }

    $(window).ready(function(){
        // 加载完成
        layer.alert(meBase.desc, {title: '温馨提示', end: function(){
            // 定时时间
            meBase.startInter();
        }});

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
            evt.preventDefault();
            // 改题目已经做完
            if (meBase.complete[meBase.pk]) {
                return false;
            } else {
                $("#question-desc").find(".dui-answer").hide();
                $("#score-form").removeClass("hide");
                // 显示正确答案
                meBase.setAnswerText();
                meBase.renderQuestionDesc("yes");
            }
        });

        // 自己评分
        $("#score-form").submit(function(evt){
            evt.preventDefault();
            meBase.current.complete = true;
            if (meBase.complete[meBase.pk]) {
                return false;
            } else {
                if ($(this).validate().form()) {
                    // 添加回答完问题
                    meBase.addComplete(meBase.pk, "yes", $("#question-answer-text").val(), parseInt($("#me-score").val()));
                    $('#select-question li[data-id=' + meBase.question.id + ']').addClass("dui");

                    // 下一题目
                    meBase.handleQuestion('next');
                }
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
                        iAnswerId = meBase.current.answer;

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
            if (meBase.doNumber < meBase.allQuestions.length) {
                // 询问框
                layer.confirm('您还有' + (meBase.allQuestions.length - meBase.doNumber)+ '道题目没做, 确实需要交卷吗?', {
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
