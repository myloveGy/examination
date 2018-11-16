/**
 * 用来获取驾考宝典科目考试题目，需要在浏览器拷贝到浏览器运行
 * 使用说明
 *
 * 1. 浏览器打开驾考宝典，科目一顺序考试(http://www.jiakaobaodian.com/mnks/exercise/0-car-kemu1-beijing.html)
 * 2. 浏览器开启开发者模式，将下面js 复制到 console 命令行里面 执行
 * 3. console 命名行
 *  var ks = examination();
 *  ks.init({url: "你本地或者服务地址/api/create-question"}).go();
 * 4. 不需要执行了 ks.nextHandle = false;
 */
(function () {
    var examination = function (options) {
        // 加载jquery
        this.load = function () {
            var script = document.createElement("script");
            script.type = "text/javascript";
            script.src = "http://libs.baidu.com/jquery/2.0.0/jquery.min.js";
            document.body.appendChild(script);
        };

        // 获取题目信息
        this.getQuestion = function (defaultObject) {
            var question = {};
            $("button[ref=xiangqing]").trigger("click");
            question.question_title = $(".timu-text").text().split("、").pop();
            var answers = [],
                $answer = $("div.answer-w");
            $("div.answer-w").find("p:first").trigger("click");
            $("div.answer-w").find("p").each(function () {
                answers.push($(this).text());
            });
            question.answers = JSON.stringify(answers);
            question.answer_id = $("div.answer-w").find("p.success").index();
            question.question_img = $("div.answer-w").find("img").prop("src");
            question.question_content = $(".xiangjie").find(".content").text();
            var type = $(".option-type-msg").text();
            if (/^单选题/.test(type)) {
                question.answer_type = 1;
            } else if (/^判断题/.test(type)) {
                question.answer_type = 2;
            }

            question.subject_id = 1;
            question.chapter_id = 1;

            if (question.question_img) {
                question.special_id = 4;
            } else {
                delete question.question_img;
            }

            for (var i in defaultObject) {
                question[i] = defaultObject[i]
            }

            return question;
        };

        this.sendRequestion = function (data) {
            var self = this;
            $.getJSON(this.options.url, data, function (json) {
                $("button.left[ref=next]").trigger("click");
                setTimeout(function () {
                    self.go();
                }, 500)
            });
        };

        this.go = function () {
            var self = this;
            $("div.answer-w").find("p:first").trigger("click");
            $("button[ref=xiangqing]").trigger("click");
            if (self.nextHandle) {
                setTimeout(function () {
                    self.sendRequestion(self.getQuestion(self.options.default));
                }, 500);
            }
            return this;
        };

        this.init = function(options) {
            $(".checkbox-next").prop("checked", false);
            this.options = window.jQuery.extend(true, {}, {url: "http://examination.com/api/create-question"}, options);
            return this;
        };

        // 没有加载jQuery 那么自动加载
        if (!window.jQuery) {
            this.load();
        }


        // 继续处理
        this.nextHandle = true;
        return this;
    };

    window.examination = function () {
        return new examination();
    }
})(window);