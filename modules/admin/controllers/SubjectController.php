<?php

namespace app\modules\admin\controllers;

use app\models\CarType;
use yii\helpers\ArrayHelper;

/**
 * Class SubjectController 科目信息
 *
 * @package app\modules\admin\controllers
 */
class SubjectController extends Controller
{
    public $modelClass = 'app\models\Subject';

    public $uploadFromClass = 'app\models\UploadForm';

    /**
     * where() 查询处理
     *
     * @return array 返回数组
     */
    public function where()
    {
        return [
            [['id', 'car_id', 'status'], '='],
            ['name', 'like'],
        ];
    }

    public function actionIndex()
    {
        // 查询类别信息
        $carType = CarType::findAll(['status' => 1]);
        $carType = ArrayHelper::map($carType, 'id', 'name');
        return $this->render('index', compact('carType'));
    }
}
