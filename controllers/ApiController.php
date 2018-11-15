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

use app\models\Question;
use jinxing\admin\helpers\Helper;
use jinxing\admin\traits\JsonTrait;
use Yii;

/**
 * Class ApiController API 处理
 *
 * @package app\controllers
 */
class ApiController extends Controller
{
    use JsonTrait;

    /**
     * 添加问题
     *
     * @return mixed|string
     */
    public function actionCreateQuestion()
    {
        $request = Yii::$app->request;
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        if (Question::findOne(['question_title' => $request->get('question_title')])) {
            return $this->error(405, '题目已经存在');
        }

        $model = new Question();
        if (!$model->load($request->get(), '') || !$model->save()) {
            return $this->error(201, Helper::arrayToString($model->getErrors()));
        }

        return $this->success($model);
    }
}