<?php

namespace app\modules\admin;

use jinxing\admin\Module;
use Yii;

/**
 * admin module definition class
 */
class Admin extends Module
{
    /**
     * {@inheritdoc}
     */
    public $controllerNamespace = 'app\modules\admin\controllers';


    /**
     * {@inheritdoc}
     */
    public function init()
    {
        parent::init();
        Yii::$app->errorHandler->errorAction = $this->getUniqueId() . '/admin/default/error';
    }
}
