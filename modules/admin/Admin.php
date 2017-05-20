<?php

namespace app\modules\admin;

use yii;

/**
 * admin module definition class
 */
class Admin extends \yii\base\Module
{
    /**
     * @inheritdoc
     */
    public $controllerNamespace = 'app\modules\admin\controllers';

    public $layout = 'main';

    /**
     * @inheritdoc
     */
    public function init()
    {
        parent::init();
    }


    public function beforeAction($action)
    {
        $isReturn = false;
        if (parent::beforeAction($action)) {
            // 登录直接跳转到登录
            if ($action->controller->id == 'default' && $action->id == 'login') {
                $isReturn = true;
            } else {
                // 验证用户是否已经登录
                if (Yii::$app->admin->isGuest) {
                    $isReturn = Yii::$app->response->redirect(yii\helpers\Url::toRoute(['default/login']));
                } else {
                    $isReturn = true;
                }
            }
        }

        return $isReturn;
    }
}
