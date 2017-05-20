<?php
/**
 * file: QuestionController.php
 * desc: 题库信息 执行操作控制器
 * date: 2016-10-11 16:49:26
 */

namespace app\modules\admin\controllers;

use app\common\helpers\Helper;
use app\common\models\Answer;
use app\common\models\CarType;
use app\common\models\Chapter;
use app\common\models\Question;
use app\common\models\Special;
use app\common\models\Subject;
use yii\helpers\ArrayHelper;
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
            'answer_type' => '=',
            'subject_id' => '=',
            'chapter_id' => '=',
            'special_id' => '=',
        ];
    }

    /**
     * actionIndex() 首页显示
     * @return string
     */
    public function actionIndex()
    {
        // 获取数据
        $special = Special::find()->where(['!=', 'pid', 0])->orderBy('sort')->all();
        $chapter = Chapter::find()->orderBy('sort')->all();
        // 查询考试类型
        $cars = CarType::findAll(['status' => 1]);

        return $this->render('index', [
            'cars' => Json::encode(ArrayHelper::map($cars, 'id', 'name')), // 类型
            'subject' => Json::encode(Subject::getSubject()), // 科目
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
        $this->arrJson['errMsg'] = '没有添加问题';
        if ($answer) $this->handleJson($answer);
        return $this->returnJson();
    }

    /**
     * actionSubject() 获取科目
     * @return mixed|string
     */
    public function actionSubject()
    {
        $request = \Yii::$app->request;
        if ($request->isAjax) {
            $intCid = (int)$request->post('cid');
            if ($intCid) {
                $subject = Subject::findAll(['status' => 1, 'car_id' => $intCid]);
                $this->handleJson($subject);
            }
        }

        return $this->returnJson();
    }

    /**
     * actionChapter() 获取章节
     * @return mixed|string
     */
    public function actionChapter()
    {
        $request = \Yii::$app->request;
        if ($request->isAjax) {
            $intSid = (int)$request->post('sid');
            if ($intSid) {
                $subject = Chapter::findAll(['subject_id' => $intSid]);
                $this->handleJson($subject);
            }
        }

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
