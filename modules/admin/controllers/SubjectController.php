<?php
/**
 * file: SubjectController.php
 * desc: 科目信息 执行操作控制器
 * date: 2016-10-11 15:42:46
 */

namespace app\modules\admin\controllers;

use app\models\CarType;
use jinxing\admin\controllers\Controller;
use yii\helpers\ArrayHelper;

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
