<?php

namespace app\controllers;

use jinxing\admin\helpers\Helper;
use jinxing\admin\traits\JsonTrait;
use Yii;
use yii\filters\AccessControl;
use app\models\forms\LoginForm;
use app\models\forms\RegisterForm;
use app\models\User;

/**
 * Site controller
 */
class SiteController extends Controller
{
    use JsonTrait;

    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only'  => ['logout', 'register', 'captcha'],
                'rules' => [
                    [
                        'actions' => ['register', 'captcha'],
                        'allow'   => true,
                        'roles'   => ['?'],
                    ],
                    [
                        'actions' => ['logout', 'captcha'],
                        'allow'   => true,
                        'roles'   => ['@'],
                    ],
                ],
            ],
        ];
    }

    /**
     * @inheritdoc
     */
    public function actions()
    {
        return [
            'error'   => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class'           => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
                'maxLength'       => 4,           // 最大显示个数
                'minLength'       => 4,           // 最少显示个数
                'padding'         => 5,           // 间距
                'height'          => 38,          // 高度
                'width'           => 130,         // 宽度
                'offset'          => 4,           // 设置字符偏移量 有效果
            ],
        ];
    }

    public function actionIndex()
    {
        return $this->render('index');
    }

    protected function login($message = 'login')
    {
        /* @var $user User */
        $user = Yii::$app->user->identity;
        return $this->success([
            'username' => $user->username,
            'email'    => $user->email,
            'face'     => $user->face,
        ], $message == 'login' ? '登录成功' : '注册成功');
    }

    /**
     * actionLogin() 用户登录
     *
     * @return mixed|string
     */
    public function actionLogin()
    {
        // 用户没有登录
        if (!Yii::$app->user->isGuest) {
            return $this->login();
        }

        $model = new LoginForm();
        if (!$model->load(Yii::$app->request->post(), '') || !$model->login()) {
            return $this->error(1, Helper::arrayToString($model->getErrors()));
        }

        return $this->login();
    }

    /**
     * actionLogout用户退出
     * @return \yii\web\Response
     */
    public function actionLogout()
    {
        // 退出之前修改登录信息
        if ($user = User::findOne(Yii::$app->user->id)) {
            $user->last_time = time();
            $user->last_ip   = Helper::getIpAddress();
            $user->save();
        }

        Yii::$app->user->logout();
        return $this->goHome();
    }

    /**
     * actionRegister() 用户注册
     *
     * @return string|\yii\web\Response
     */
    public function actionRegister()
    {
        // 已经登录
        if (!Yii::$app->user->isGuest) {
            return $this->login();
        }

        // 不是ajax 请求
        if (!Yii::$app->request->isAjax) {
            return $this->error();
        }

        $model = new RegisterForm();
        // 数据加载成功
        if (!$model->load(Yii::$app->request->post(), '')) {
            return $this->error();
        }

        if (!($user = $model->register()) || !Yii::$app->getUser()->login($user)) {
            return $this->error(2, Helper::arrayToString($model->getErrors()));
        }

        return $this->login('registerSuccess');
    }
}
