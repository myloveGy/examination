<?php

namespace app\controllers;

use yii;
use app\models\CarType;

/**
 * Site controller
 */
class Controller extends yii\web\Controller
{
    /**
     * @param $action
     *
     * @return bool
     * @throws yii\web\BadRequestHttpException
     */
    public function beforeAction($action)
    {
        if (!Yii::$app->request->isAjax) {
            Yii::$app->view->params['carTypes'] = CarType::find()->where(['status' => 1])->orderBy(['sort' => SORT_ASC])->all();
        }

        return parent::beforeAction($action);
    }

    /**
     * 设置错误 flash 消息跳转
     *
     * @param string      $msg flash 消息
     * @param string|null $url 跳转地址，默认上一页
     *
     * @return mixed
     */
    public function errorRedirect($msg, $url = null)
    {
        Yii::$app->session->setFlash('error', $msg);
        return $this->redirect($url ? $url : Yii::$app->request->getReferrer());
    }
}
