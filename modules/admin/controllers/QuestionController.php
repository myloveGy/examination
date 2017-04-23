<?php
/**
 * file: QuestionController.php
 * desc: 题库信息 执行操作控制器
 * date: 2016-10-11 16:49:26
 */

namespace app\modules\admin\controllers;

use app\common\helpers\Helper;
use app\common\models\Answer;
use app\common\models\Chapter;
use app\common\models\Question;
use app\common\models\Special;
use app\common\models\Subject;
use yii\helpers\Json;

class QuestionController extends Controller
{
    /**
     * where() 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'status' => '=',
            'answer_type' => '='
        ];
    }

    /**
     * actionIndex() 首页显示
     * @return string
     */
    public function actionIndex()
    {
        // 获取数据
        $subject = Subject::find()->all();
        $special = Special::find()->where(['!=', 'pid', 0])->orderBy('sort')->all();
        $chapter = Chapter::find()->orderBy('sort')->all();

        return $this->render('index', [
            'subject' => Json::encode(Helper::map($subject, 'id', 'name')), // 科目
            'special' => Json::encode(Helper::map($special, 'id', 'name')), // 专项
            'chapter' => Json::encode(Helper::map($chapter, 'id', 'name')), // 章节
            'status'  => Json::encode(Question::getStatusDesc()),           // 状态
            'color'  => Json::encode(Question::getStatusColor()),           // 状态颜色
            'type'  => Json::encode(Question::getTypeDesc()),               // 答案类型
        ]);
    }

    /**
     * actionChild() 查询子类信息
     * @param $id
     */
    public function actionChild()
    {
        $answer = Answer::findAll(['qid' => \Yii::$app->request->get('id', 1)]);
        $this->arrJson['errCode'] = 223;
        if ($answer) $this->handleJson($answer);
        return $this->returnJson();
    }

    /**
     * getModel() 返回model
     * @return Question
     */
    public function getModel()
    {
        return new Question();
    }
}
