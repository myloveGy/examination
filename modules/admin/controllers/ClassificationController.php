<?php

namespace app\modules\admin\controllers;

use jinxing\admin\controllers\Controller;

class ClassificationController extends Controller
{
    public $modelClass = 'app\common\models\CarType';

    public $uploadFromClass = 'app\common\models\UploadForm';

    /**
     * where() 查询处理
     *
     * @return array 返回数组
     */
    public function where()
    {
        return [
            'name' => 'like',
        ];
    }
}
