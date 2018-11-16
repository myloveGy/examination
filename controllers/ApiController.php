<?php
/**
 *
 * ApiController.php
 *
 * Author: jinxing.liu@verystar.cn
 * Create: 2018/11/15 15:34
 * Editor: created by PhpStorm
 */

namespace app\controllers;

use Yii;
use app\models\Question;
use jinxing\admin\helpers\Helper;

/**
 * Class ApiController API 处理
 *
 * @package app\controllers
 */
class ApiController extends Controller
{
    /**
     * 添加问题
     *
     * @return mixed|string
     */
    public function actionCreateQuestion()
    {
        if (!YII_DEBUG) {
            return $this->asJson(['code' => 400, 'msg' => 'server error']);
        }

        $request = Yii::$app->request;
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        if (Question::findOne(['question_title' => $request->get('question_title')])) {
            return $this->asJson(['code' => 401, 'msg' => '题目已经存在']);
        }

        $model = new Question();
        if (!$model->load($request->get(), '') || !$model->save()) {
            return $this->asJson(['code' => 402, 'msg' => Helper::arrayToString($model->getErrors())]);
        }

        return $this->asJson(['code' => 200, 'msg' => 'success', 'data' => $model]);
    }
}