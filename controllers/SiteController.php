<?php
namespace app\controllers;

use app\common\models\CarType;
use Yii;
use yii\filters\VerbFilter;
use yii\filters\AccessControl;
use app\models\LoginForm;
use app\models\RegisterForm;
use app\common\helpers\Helper;
use app\common\models\Special;
use app\common\models\Subject;
use app\common\models\User;

/**
 * Site controller
 */
class SiteController extends Controller
{
    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout', 'register', 'captcha'],
                'rules' => [
                    [
                        'actions' => ['register', 'captcha'],
                        'allow' => true,
                        'roles' => ['?'],
                    ],
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    //'logout' => ['post'],
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
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
//                'backColor' => 0x000000,    // 背景颜色
                'maxLength' => 6,           // 最大显示个数
                'minLength' => 6,           // 最少显示个数
                'padding'   => 5,           // 间距
                'height'    => 38,          // 高度
                'width'     => 130,         // 宽度
//                'foreColor' => 0xffffff,     // 字体颜色
                'offset'    => 4,           // 设置字符偏移量 有效果
//                'controller' => 'register',    // 拥有这个动作的controller
            ],
        ];
    }

    public function actionIndex()
    {
        return $this->render('index');
    }

    /**
     * 用户重复登陆设置返回信息
     * @return bool
     */
    protected function loginRepeat()
    {
        $this->arrJson = [
            'errCode' => 0,
            'errMsg'  => Yii::t('app', 'loginRepeat'),
            'data'    => [
                'username' => Yii::$app->user->identity->username,
                'email'    => Yii::$app->user->identity->email,
                'face'     => Yii::$app->user->identity->face,
            ],
        ];

        return true;
    }

    /**
     * login() 用户登录和注册成功返回
     * @param string $message
     * @return bool
     */
    protected function login($message = 'login')
    {
        $this->arrJson = [
            'errCode' => 0,
            'errMsg' => $message == 'login' ? '登录成功' : '注册成功',
            'data'    => [
                'username' => Yii::$app->user->identity->username,
                'email'    => Yii::$app->user->identity->email,
                'face'     => Yii::$app->user->identity->face,
            ],
        ];

        return true;
    }

    /**
     * actionLogin() 用户登录
     * @return mixed|string
     */
    public function actionLogin()
    {
        // 用户没有登录
        if (Yii::$app->user->isGuest) {
            $model = new LoginForm();
            if ($model->load(['params' => Yii::$app->request->post()], 'params') && $model->login()) {
                $this->login();
            } else {
                $this->arrJson['errCode'] = 1;
                $this->arrJson['errMsg'] = $model->getErrorString();
            }
        } else {
            $this->loginRepeat();
        }

        return $this->returnJson();
    }

    /**
     * actionLogout用户退出
     * @return \yii\web\Response
     */
    public function actionLogout()
    {
        // 退出之前修改登录信息
        $user = User::findOne(Yii::$app->user->id);
        if ($user) {
            $user->last_time = time();
            $user->last_ip = Helper::getIpAddress();
            $user->save();
        }
        Yii::$app->user->logout();
        return $this->goHome();
    }

    /**
     * actionRegister() 用户注册
     * @return string|\yii\web\Response
     */
    public function actionRegister()
    {
        if (Yii::$app->user->isGuest) {
            if (Yii::$app->request->isAjax) {
                $model = new RegisterForm();
                // 数据加载成功
                if ($model->load(['params' => Yii::$app->request->post()], 'params')) {
                    if ($user = $model->register()) {
                        if (Yii::$app->getUser()->login($user)) {
                            $this->login('registerSuccess');
                        }
                    } else {
                        $this->arrJson['errCode'] = 2;
                        $this->arrJson['errMsg']  = $model->getErrorString();
                    }
                }
            }
        } else {
            $this->loginRepeat();
        }

        return $this->returnJson();
    }
}
