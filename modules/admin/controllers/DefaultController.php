<?php

namespace app\modules\admin\controllers;

use yii;
use yii\web\UnauthorizedHttpException;
use app\modules\admin\filters\AccessControl;
use yii\filters\VerbFilter;
use app\common\helpers\Helper;
use app\modules\admin\models\Menu;
use app\modules\admin\models\Admin;
use app\modules\admin\models\AdminForm;

/**
 * Default controller for the `admin` module
 */
class DefaultController extends \yii\web\Controller
{
    public $layout = false;

    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'rules' => [
                    [
                        'actions' => ['login', 'error'],
                        'allow'   => true,
                    ],
                    [
                        'actions' => ['logout', 'index', 'system'],
                        'allow'   => true,
                        'roles'   => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
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
            'error' => ['class' => 'yii\web\ErrorAction',],
        ];
    }

    /**
     * actionIndex() 管理员登录欢迎页
     * @return string
     * @throws UnauthorizedHttpException
     */
    public function actionIndex()
    {
        $this->layout = false;

        // 获取用户导航栏信息
        $menus = Menu::getUserMenus(Yii::$app->admin->id);
        if ($menus) {
            Yii::$app->view->params['user']  = Yii::$app->admin->identity;
            Yii::$app->view->params['menus'] = $menus;
            // 加载视图
            return $this->render('index');
        } else {
            throw new UnauthorizedHttpException('对不起，您还没获得显示导航栏目权限!');
        }
    }

    /**
     * actionSystem
     */
    public function actionSystem()
    {
        $this->layout = 'main';
        // 用户信息
        Yii::$app->view->params['user']  = Yii::$app->admin->identity;

        // 系统信息
        $system = explode(' ', php_uname());
        $system = $system[0] .'&nbsp;' . ('/' == DIRECTORY_SEPARATOR ? $system[2] : $system[1]);

        // MySql版本
        $version = Yii::$app->db->createCommand('SELECT VERSION() AS `version`')->queryOne();

        return $this->render('system', [
            'system' => $system,                                        // 系统信息
            'yii'    => 'Yii '. Yii::getVersion(),                      // Yii 版本
            'php'    => 'PHP '. PHP_VERSION,                            // PHP 版本
            'server' => $_SERVER['SERVER_SOFTWARE'],                    // 服务器信息
            'mysql'  => 'MySQL '.($version ? $version['version'] : ''), // Mysql版本
            'upload' => ini_get('upload_max_filesize'),                 // 上传文件大小
        ]);
    }

    public function actionLogin()
    {
        $this->layout = false;
        // 已经登录
        if (!Yii::$app->admin->isGuest) {
            return $this->redirect(['index']);
        }

        $model = new AdminForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {
            return $this->redirect(['index']);
        } else {
            return $this->render('login', [
                'model' => $model,
            ]);
        }
    }

    /**
     * actionLogout() 后台管理员退出
     * @return \yii\web\Response
     */
    public function actionLogout()
    {
        // 用户退出修改登录时间
        $admin = Admin::findOne(Yii::$app->admin->id);
        if ($admin) {
            $admin->last_time = time();
            $admin->last_ip   = Helper::getIpAddress();
            $admin->save();
        }

        Yii::$app->admin->logout();
        return $this->goHome();
    }
}
