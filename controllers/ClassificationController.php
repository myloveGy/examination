<?php

namespace app\controllers;

use Yii;
use app\models\CarType;
use app\models\Subject;
use app\models\Special;

class ClassificationController extends Controller
{
    /**
     * actionIndex() 显示首页
     * @return string
     */
    public function actionIndex()
    {
        // 接收参数
        $intCarId = Yii::$app->request->get('id', 1) ?: 1;   // 车型ID

        // 查询车型信息
        if (!$car = CarType::findOne($intCarId)) {
            // 没有数据直接返回
            return $this->errorRedirect('分类信息不存在');
        }

        // 查询科目
        $subject = Subject::findAll(['status' => 1, 'car_id' => $car->id]);
        $special = Special::findOne(['name' => '难题']);
        return $this->render('index', compact('special', 'subject', 'car'));
    }

    public function actionSubject($id)
    {
        $id = $id ? intval($id) : 1;
        // 查询平台信息
        if (!$subject = Subject::findOne($id)) {
            // 没有数据直接返回
            return $this->errorRedirect('章节信息不存在');
        }

        $cars    = $subject->car;
        $special = Special::findOne(['name' => '难题']);
        return $this->render('subject', compact('cars', 'subject', 'special'));
    }
}
