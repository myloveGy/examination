<?php
/**
 * file: AnswerController.php
 * desc: 答案信息 执行操作控制器
 * date: 2016-10-11 18:55:56
 */

namespace backend\controllers;

use Yii;
use common\models\Answer;

class AnswerController extends Controller
{
    /**
     * where() 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'where' => [['=', 'qid', (int)Yii::$app->request->post('id')]],
        ];
    }

    /**
     * getModel() 返回model
     * @return Answer
     */
    public function getModel()
    {
        return new Answer();
    }
}
