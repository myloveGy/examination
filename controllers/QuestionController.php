<?php

namespace app\controllers;

use app\models\Subject;
use app\models\UserCollect;
use jinxing\admin\traits\JsonTrait;
use Yii;
use app\models\Question;
use app\models\Chapter;
use app\models\Special;
use yii\helpers\ArrayHelper;
use yii\helpers\Json;
use yii\helpers\Url;

/**
 * Class QuestionController 题库信息
 *
 * @package app\controllers
 */
class QuestionController extends Controller
{
    use JsonTrait;

    /**
     * actionIndex() 显示首页
     */
    public function actionIndex()
    {
        // 接收参数
        $request = Yii::$app->request;
        $intSid  = (int)$request->get('subject', 1) ?: 1;       // 科目ID
        $sType   = $request->get('type', 'all');                // 类型 chapter and special and null
        $intCid  = (int)$request->get('cid');                   // 对应类型子类ID
        $sStyle  = $request->get('style', 'sequence');          // 答题类型 sequence 顺序 and random 随机

        // 查询科目, 有问题抛出错误
        if (!$subject = Subject::findOne($intSid)) {
            return $this->errorRedirect('科目信息不存在');
        }

        $cars   = $subject->car;
        $crumbs = [
            [
                'label' => $cars->name,
                'url'   => Url::toRoute(['classification/index', 'id' => $cars->id])
            ],
            [
                'label' => $subject->name,
                'url'   => Url::toRoute(['classification/subject', 'id' => $subject->id]),
            ]
        ];

        $where = [
            'status'     => Question::STATUS_KEY,
            'subject_id' => $subject->id
        ];

        // 全部题目
        $allTotal = Question::find()->where($where)->count(); // 全部题库

        // 根据类型查询数据
        switch ($sType) {
            case 'chapter':
                $where['chapter_id'] = $intCid;
                $chapter             = Chapter::findOne($intCid);
                $crumbs[]            = ['label' => $chapter ? $chapter->name : '', 'url' => Url::toRoute(['question/chapter'])];
                break;
            case 'special':
                $where['special_id'] = $intCid;
                $special             = Special::findOne($intCid);
                $crumbs[]            = ['label' => $special ? $special->name : '', 'url' => Url::toRoute(['question/special'])];
                break;
        }

        $crumbs[]                              = $sStyle == 'sequence' ? '顺序练习' : '随机练习';
        Yii::$app->view->params['breadcrumbs'] = $crumbs;

        // 查询一条数据
        if (!$question = Question::findOne($where)) {
            return $this->errorRedirect('问题不存在');
        }

        // 开始查询
        $total = Question::find()->where($where)->count();
        $ids   = Question::getAllIds($where);
        if ($sStyle == 'random') {
            shuffle($ids);
        }

        // 查询问题答案
        $answer = Json::decode($question->answers);
        return $this->render('index', [
            'cars'       => $cars, // 车型信息
            'subject'    => $subject,
            'allTotal'   => (int)$allTotal,
            'total'      => (int)$total,
            'hasCollect' => UserCollect::hasCollect($question->id, $subject->id),
            'allIds'     => Json::encode($ids),
            'question'   => $question,
            'answer'     => $answer,
            'style'      => $sStyle,
            'type'       => $sType
        ]);
    }

    /**
     * actionChapter() 章节练习
     * @return string
     * @throws \yii\db\Exception
     */
    public function actionChapter()
    {
        // 查询科目信息
        if (!$subject = Subject::findOne(Yii::$app->request->get('subject', 1))) {
            return $this->errorRedirect('章节练习问题信息为空');
        }

        if (!$chapter = $subject->chapters) {
            return $this->errorRedirect('章节练习问题信息为空');
        }

        $chapterIds = ArrayHelper::getColumn($chapter, 'id');
        if ($counts = Yii::$app->db->createCommand('SELECT 
                  COUNT(*) AS `length`, 
                  `chapter_id` 
              FROM `ks_question` 
              WHERE `chapter_id` IN (' . implode(',', $chapterIds) . ') 
              GROUP BY `chapter_id`')->queryAll()) {
            $counts = ArrayHelper::map($counts, 'chapter_id', 'length');
        }

        $cars = $subject->car;
        return $this->render('chapter', compact('cars', 'subject', 'chapter', 'counts'));
    }

    /**
     * actionSpecial() 专项练习
     * @return string
     * @throws \yii\db\Exception
     */
    public function actionSpecial()
    {
        // 查询科目信息
        if (!$subject = Subject::findOne(Yii::$app->request->get('subject', 1))) {
            return $this->errorRedirect('专项练习问题不存在');
        }

        $all = $ids = $counts = [];
        if ($special = Special::find()->asArray()->all()) {
            foreach ($special as $value) {
                /* @var $value array */
                $intKid = $value['pid'] == 0 ? $value['id'] : $value['pid'];
                if (!isset($all[$intKid])) {
                    $all[$intKid] = ['child' => []];
                }

                // 父级处理
                if ($value['pid'] == 0) {
                    $all[$intKid] = array_merge($all[$intKid], $value);
                    continue;
                }

                // 字集处理
                $index                         = $value['sort'] . '-' . $value['id'];
                $ids[]                         = (int)$value['id'];
                $all[$intKid]['child'][$index] = $value;
            }

            // 没有数据默认查询
            $ids = $ids ?: [0];
            // 查询
            if ($counts = Yii::$app->db->createCommand('SELECT 
                    COUNT(*) AS `length`, 
                    `special_id` 
                    FROM `ks_question` 
                    WHERE `special_id` IN (' . implode(',', $ids) . ') AND `subject_id` = ' . intval($subject->id) . '  
                    GROUP BY `special_id`')->queryAll()) {
                $counts = ArrayHelper::map($counts, 'special_id', 'length');
            }

            $files = [];
            foreach ($all as $k => &$v) {
                $files[$k] = $v['sort'];
                ksort($v['child']);
            }

            array_multisort($files, SORT_ASC, $all);
        }

        return $this->render('special', [
            'subject' => $subject,
            'cars'    => $subject->car,
            'special' => $all,
            'counts'  => $counts,
        ]);
    }

    /**
     * actionRecord() 记录用户做题信息
     * @return mixed|string
     */
    public function actionRecord()
    {
        $request = Yii::$app->request;
        if (!$intQid = $request->post('qid')) {
            return $this->error();
        }

        $strType = $request->post('sType', 'no');
        if (!$question = Question::findOne($intQid)) {
            return $this->error(220, '没有题目');
        }

        if ($strType == 'no') {
            $cookie = $request->cookies;
            $values = $cookie->get($strType);
            if ($values == null) {
                $values = [$intQid];
            } else {
                $values = Json::decode($values->value, true);
                array_push($values, $intQid);
                $values = array_unique($values);
            }

            // 添加COOKIE
            Yii::$app->response->cookies->add(new \yii\web\Cookie([
                'name'   => $strType,
                'value'  => Json::encode($values),
                'expire' => time() + 86400,
            ]));

            $question->error_number++;
        }

        // 修改记录信息
        $question->do_number++;
        $question->save();
        return $this->success($question);
    }

    /**
     * actionGetQuestion() 获取问题和答案信息
     * @return mixed|string
     */
    public function actionGetQuestion()
    {
        if (!$id = (int)Yii::$app->request->post('qid')) {
            return $this->error(220, '没有题目了');
        }

        if (!$question = Question::findOne($id)) {
            return $this->error(220, '没有题目了');
        }

        return $this->success([
            'hasCollect' => UserCollect::hasCollect($question->id, $question->subject_id),
            'question'   => $question,
            'answers'    => Json::decode($question->answers)
        ]);

    }

    /**
     * actionImitate() 全真模拟考试
     *
     * @return string
     */
    public function actionImitate()
    {
        // 查询科目信息
        if (!$subject = Subject::findOne(Yii::$app->request->get('subject', 1))) {
            return $this->errorRedirect('全真模拟考试问题不存在');
        }

        // 解析配置信息
        $config = Json::decode($subject->config) ?: [];
        $config = array_merge([
            'passingScore'   => 72,
            'totalScore'     => 100,
            'time'           => 60,
            'judgmentScore'  => 2,
            'selectScore'    => 2,
            'multipleScore'  => 3,
            'shortScore'     => 5,
            'judgmentNumber' => 10,
            'selectNumber'   => 40,
            'multipleNumber' => 30,
            'shortNumber'    => 5,
        ], $config);

        // 处理总分
        $config['totalScore'] = $config['shortNumber'] * $config['shortScore'];
        $config['totalScore'] += $config['judgmentNumber'] * $config['judgmentScore'];
        $config['totalScore'] += $config['selectNumber'] * $config['selectScore'];
        $config['totalScore'] += $config['multipleNumber'] * $config['multipleScore'];

        // 默认必须查询条件
        $where = ['subject_id' => $subject->id];

        // 查询所有判断题目
        $where['answer_type'] = Question::ANSWER_TYPE_ONE;
        $arrJudgment          = Question::getAllIds($where);
        $intStart             = mt_rand(0, max(0, count($arrJudgment) - $config['judgmentNumber']));
        $arrJudgment          = array_slice($arrJudgment, $intStart, $config['judgmentNumber']);

        // 查询所以单选题目
        $where['answer_type'] = Question::ANSWER_TYPE_JUDGE;
        $arrSelect            = Question::getAllIds($where);
        $intStart             = mt_rand(0, max(0, count($arrSelect) - $config['selectNumber']));
        $arrSelect            = array_slice($arrSelect, $intStart, $config['selectNumber']);

        // 查询所以多选题目multipleNumber
        $where['answer_type'] = Question::ANSWER_TYPE_MULTI;
        $arrMultiple          = Question::getAllIds($where);
        $intStart             = mt_rand(0, max(0, count($arrMultiple) - $config['multipleNumber']));
        $arrMultiple          = array_slice($arrMultiple, $intStart, $config['multipleNumber']);

        // 查询所以问答题目shortNumber
        $where['answer_type'] = Question::ANSWER_TYPE_TEXT;
        $arrShort             = Question::getAllIds($where);
        $intStart             = mt_rand(0, max(0, count($arrShort) - $config['shortNumber']));
        // 合并所以题目
        $arrShort = array_slice($arrShort, $intStart, $config['shortNumber']);
        if (!$ids = array_merge($arrJudgment, $arrSelect, $arrMultiple, $arrShort)) {
            return $this->errorRedirect('全真模拟考试问题不存在');
        }

        $allIds = array_unique($ids);
        shuffle($allIds);
        if (!$question = Question::findOne($allIds[0])) {
            return $this->errorRedirect('全真模拟考试问题不存在');
        }

        $cars    = $subject->car;
        $answers = Json::decode($question->answers);
        return $this->render('imitate', compact('config', 'cars', 'question', 'answers', 'allIds'));
    }

    /**
     * actionWarning() 我的错题
     * @return string|\yii\web\Response
     */
    public function actionWarning()
    {
        // 查询科目
        if (!$subject = Subject::findOne(Yii::$app->request->get('subject', 1))) {
            return $this->errorRedirect('我的错题信息为空');
        }

        $cookie = Yii::$app->request->cookies;
        $objIds = $cookie->get('no');
        if (empty($objIds) || empty($objIds->value)) {
            return $this->errorRedirect('我的错题信息为空');
        }

        $arrIds = Json::decode($objIds->value, true);
        // 全部题目
        $allTotal = Question::find()->where([
            'status'     => Question::STATUS_KEY,
            'subject_id' => $subject->id
        ])->count(); // 全部题库

        $cars                                  = $subject->car;
        Yii::$app->view->params['breadcrumbs'] = [
            [
                'label' => $cars->name,
                'url'   => Url::toRoute(['classification/index', 'id' => $cars->id])
            ],
            [
                'label' => $subject->name,
                'url'   => Url::toRoute(['/', 'subject' => $subject->id]),
            ],
            '我的错题',
        ];

        // 开始查询 // 查询一条数据
        if (!$question = Question::findOne($arrIds[0])) {
            return $this->errorRedirect('我的错题信息为空');
        }

        // 查询问题答案
        $answer = Json::decode($question->answers);
        return $this->render('index', [
            'cars'       => $cars,
            'subject'    => $subject,
            'allTotal'   => (int)$allTotal,
            'total'      => count($arrIds),
            'hasCollect' => UserCollect::hasCollect($question->id, $subject->id),
            'allIds'     => Json::encode($arrIds),
            'question'   => $question,
            'answer'     => $answer,
            'style'      => 'sequence',
        ]);
    }
}
