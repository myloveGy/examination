<?php

namespace app\modules\admin\controllers;

use jinxing\admin\controllers\Controller;

class ClassificationController extends Controller
{
    /**
     * 使用的model
     */
    public $modelClass = 'app\models\CarType';

    /**
     * where() 查询处理
     *
     * @return array 返回数组
     */
    public function where()
    {
        return [
            ['id', '='],
            ['name', 'like'],
        ];
    }
}
