<?php

namespace app\modules\admin\controllers;

use yii\web\Controller;

/**
 * Class DefaultController
 * @package app\modules\admin\controllers
 */
class DefaultController extends Controller
{
    public function actionIndex()
    {
        return $this->redirect('/admin/admin');
    }
}
