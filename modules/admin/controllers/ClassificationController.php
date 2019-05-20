<?php

namespace app\modules\admin\controllers;

use jinxing\admin\controllers\Controller;

class ClassificationController extends Controller
{
    public $modelClass = 'app\models\CarType';

    public $uploadFromClass = 'app\models\UploadForm';

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
