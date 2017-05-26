<?php
/**
 * file: SubjectController.php
 * desc: 科目信息 执行操作控制器
 * date: 2016-10-11 15:42:46
 */

namespace app\modules\admin\controllers;

use app\common\models\CarType;
use app\common\models\Subject;
use yii\helpers\ArrayHelper;

class SubjectController extends Controller
{
    /**
     * where() 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'id' => '=',
			'name' => 'like',
            'car_id' => '=',
            'status' => '=',
        ];
    }

    public function actionIndex()
    {
        // 查询类别信息
        $carType = CarType::findAll(['status' => 1]);
        $carType = ArrayHelper::map($carType, 'id', 'name');
        return $this->render('index', [
            'arrCarType' => $carType
        ]);
    }

    /**
     * getModel() 返回model
     * @return Subject
     */
    public function getModel()
    {
        return new Subject();
    }
}
