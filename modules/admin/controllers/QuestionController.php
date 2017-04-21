<?php
/**
 * file: QuestionController.php
 * desc: 题库信息 执行操作控制器
 * date: 2016-10-11 16:49:26
 */

namespace backend\controllers;

use common\helpers\Helper;
use common\models\Answer;
use common\models\Chapter;
use common\models\Question;
use common\models\Special;
use common\models\Subject;
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
        return [];
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
    public function actionChild($id)
    {
        $answer = Answer::findAll(['qid' => $id]);
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

    /**
     * afterUpload() 上传文件之后的处理
     * @param object $objFile
     * @param string $strFilePath
     * @param string $strField
     * @return bool
     */
    public function afterUpload($objFile, &$strFilePath, $strField)
    {
        Helper::copy($strFilePath);
        return true;
    }
}
