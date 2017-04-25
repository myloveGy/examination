<?php
namespace app\controllers;

use Yii;
use app\common\models\CarType;
use app\common\models\Subject;
use app\common\models\Special;
use yii\web\HttpException;

class CarController extends Controller
{
    /**
     * actionIndex() 显示首页
     * @return string
     */
    public function actionIndex()
    {
        // 接收参数
        $intCarId = Yii::$app->request->get('id');   // 车型ID
        $intCarId = $intCarId ? $intCarId : 1; // 默认1

        // 查询车型信息
        $cars = CarType::findOne($intCarId);

        if ($cars) {
            // 查询科目
            $subject = Subject::findAll(['status' => $cars->id]);
            $special = Special::findOne(['name' => '难题']);
            return $this->render('index', [
                'special' => $special,
                'car' => $cars,
                'subject' => $subject
            ]);
        }

        // 有问题抛出错误
        throw new HttpException(401, '数据存在问题哦');
    }

    public function actionSubject($id)
    {
        $id = $id ? intval($id) : 1;
        // 查询平台信息
        $subject = Subject::findOne($id);
        if ($subject) {

            $cars = $subject->car;

            $special = Special::findOne(['name' => '难题']);

            return $this->render('subject', [
                'cars' => $cars,
                'subject' => $subject,
                'special' => $special
            ]);
        }

        // 有问题抛出错误
        throw new HttpException(401, '数据存在问题哦');
    }
}
