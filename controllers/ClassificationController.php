<?php
namespace app\controllers;

use Yii;
use app\common\models\CarType;
use app\common\models\Subject;
use app\common\models\Special;
use yii\web\HttpException;

class ClassificationController extends Controller
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
            $subject = Subject::findAll(['status' => 1, 'car_id' => $cars->id]);
            $special = Special::findOne(['name' => '难题']);
            return $this->render('index', [
                'special' => $special,
                'car' => $cars,
                'subject' => $subject
            ]);
        }

        // 没有数据直接返回
        Yii::$app->session->setFlash('error', '分类信息不存在');
        return $this->redirect(Yii::$app->request->getReferrer());
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

        // 没有数据直接返回
        Yii::$app->session->setFlash('error', '章节信息不存在');
        return $this->redirect(Yii::$app->request->getReferrer());
    }
}
