/**
 * Created by on 2016/10/17.
 */

// 图片放大
function imageBoost(selector) {
    $(selector).click(function(){
        var src = $(this).parent().prev('img').attr('src');
        layer.open({
            type: 1,
            title: '查看大图',
            area: ['auto', 'auto'],
            shade: 0.3,
            cancel: function(index){layer.close(index);},
            content: '<img src="'+src+'" style="margin:20px" />',
            btn: ['确定'],
            shadeClose: true
        });
    })
}

var aType = {
    "1": "单选题,请选择你认为正确的答案!",
    "2": "判断题,请判断对错!",
    "3": "多选题,请选择你认为正确的答案!",
    "4": "问答题，请填写答案"
};

var aTypeColor = {
    "1": "bg-info",
    "2": "bg-warning",
    "3": "bg-primary",
    "4": "bg-danger"
};

// 获取答案类型
function getAnswerTypeDesc(iType) {
    return aType[iType] ? aType[iType] : aType["3"];
}

var loginShow, registerShow, oLoading;

// 弹出窗口
function showDialog(selector, sTitle, params) {
    if ( ! params) params = {};
    params = $.extend({
        modal:      true,   // 是否模块化
        title:      sTitle, // 标题
        width:      400,    // 宽度
        resizable:  false   // 是否允许改变大小
    }, params);

    $(selector).find('label.error').remove();
    return $(selector).removeClass('hide').dialog(params);
}

// 弹出登录窗口
function showLogin()
{
    if (registerShow) registerShow.dialog('close');
    loginShow = showDialog('#login-dialog', '考试系统登录');
}

// 弹出注册窗口
function showRegister()
{
    if (loginShow) loginShow.dialog('close');
    registerShow = showDialog('#register-dialog', '考试系统注册');
}

// 用户登录操作
function userLogin(user) {
    // 关闭弹窗
    if (loginShow) loginShow.dialog('close');
    if (registerShow) registerShow.dialog('close');

    // 隐藏没有登录显示登录信息
    $('.no-login').hide();
    $('.user-login').removeClass('hide').show();
    $('#username').html(user.username ? user.username : (user.email ? user.emial : ''));
    $('.is-login').removeClass('login').unbind('click');
    if(user.face) $('#user-face').src(user.face);
}

$(window).ready(function(){
    // 设置高度
    var iWHeight = $(window).height() - 187, c = $("#content"), iCHeight = c.height();

    if (iWHeight < iCHeight) {
        iWHeight = iCHeight;
    }

    c.css('min-height', iWHeight + 'px');

    // 弹出登录窗口
    $('.login').click(function(evt){
        evt.preventDefault();
        showLogin();
    });

    // 弹出注册窗口
    $('.register').click(function(){
        showRegister();
    });

    // 用户登录
    $('.user-form').submit(function(e){
        e.preventDefault();
        // 验证数据
        if ($(this).validate().form()) {
            oLoading = layer.load();
            // ajax请求
            $.ajax({
                url:      $(this).attr('action'),
                type:     'POST',
                data:     $(this).serialize(),
                dateType: 'json'
            }).always(function(){
                layer.close(oLoading);
            }).done(function(json){
                if (json.errCode == 0) {
                    layer.msg(json.errMsg, {icon:6});
                    userLogin(json.data);
                } else {
                    if ($('.user-form').hasClass('register-form')) {
                        $('#captchaimg').trigger('click');
                    }
                    layer.msg(json.errMsg, {icon:5});
                }
            }).fail(function(error){
                console.info(error);
                layer.msg('服务器繁忙请稍候再试...');
            });
        }

        return false;
    })
});