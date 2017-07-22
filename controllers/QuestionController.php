<?php
namespace app\controllers;

use app\common\models\Subject;
use app\models\UserCollect;
use Yii;
use app\common\models\Answer;
use app\common\models\Question;
use app\common\models\Chapter;
use app\common\models\Special;
use yii\helpers\ArrayHelper;
use yii\helpers\Json;
use yii\helpers\Url;
use yii\web\HttpException;


class QuestionController extends Controller
{
    /**
     * actionIndex() 显示首页
     */
    public function actionIndex()
    {
        // 接收参数
        $request = Yii::$app->request;
        $intSid = (int)$request->get('subject');      // 科目ID
        $intSid = $intSid > 0 ? $intSid : 1;
        $sType = $request->get('type', 'all');       // 类型 chapter and special and null
        $intCid = (int)$request->get('cid');          // 对应类型子类ID
        $sStyle = $request->get('style', 'sequence'); // 答题类型 sequence 顺序 and random 随机
        $errMsg = '科目信息不存在';

        // 查询科目
        $subject = Subject::findOne($intSid);
        if ($subject) {
            $cars = $subject->car;
            $crumbs = [
                [
                    'label' => $cars->name,
                    'url' => Url::toRoute(['classification/index', 'id' => $cars->id])
                ],
                [
                    'label' => $subject->name,
                    'url' => Url::toRoute(['classification/subject', 'id' => $subject->id]),
                ]
            ];

            $where = [
                'status' => Question::STATUS_KEY,
                'subject_id' => $subject->id
            ];

            // 全部题目
            $allTotal = Question::find()->where($where)->count(); // 全部题库

            // 根据类型查询数据
            switch ($sType) {
                case 'chapter':
                    $where['chapter_id'] = $intCid;
                    $chapter = Chapter::findOne($intCid);
                    $crumbs[] = ['label' => $chapter ? $chapter->name : '', 'url' => Url::toRoute(['question/chapter'])];
                    break;
                case 'special':
                    $where['special_id'] = $intCid;
                    $special = Special::findOne($intCid);
                    $crumbs[] = ['label' => $special ? $special->name: '', 'url' => Url::toRoute(['question/special'])];
                    break;
            }

            $crumbs[] = $sStyle == 'sequence' ? '顺序练习' : '随机练习';
            Yii::$app->view->params['breadcrumbs'] = $crumbs;

            // 开始查询
            $total = Question::find()->where($where)->count();
            $ids = Question::getAllIds($where);
            $question = Question::findOne($where); // 查询一条数据
            $errMsg = '问题不存在';
            if ($question) {
                // 查询问题答案
                $answer = Json::decode($question->answers);
                return $this->render('index', [
                    'cars' => $cars, // 车型信息
                    'subject' => $subject,
                    'allTotal' => (int)$allTotal,
                    'total' => (int)$total,
                    'hasCollect' => UserCollect::hasCollect($question->id, $subject->id),
                    'allIds' => Json::encode($ids),
                    'question' => $question,
                    'answer' => $answer,
                    'style' => $sStyle,
                    'type' => $sType
                ]);
            }
        }

        // 有问题抛出错误
        Yii::$app->session->setFlash('error', $errMsg);
        return $this->redirect(Yii::$app->request->getReferrer());
    }

    /**
     * actionChapter() 章节练习
     * @return string
     */
    public function actionChapter()
    {
        // 查询科目信息
        $subject = Subject::findOne(Yii::$app->request->get('subject', 1));
        if ($subject) {
            $cars = $subject->car;
            $chapter = $subject->chapters;
            if ($chapter) {
                $chapterIds = [];
                foreach ($chapter as $value) $chapterIds[] = (int)$value['id'];
                $counts = Yii::$app->db->createCommand('SELECT COUNT(*) AS `length`, `chapter_id` FROM `ks_question` WHERE `chapter_id` IN ('.implode(',', $chapterIds).') GROUP BY `chapter_id`')->queryAll();
                if ($counts) $counts = ArrayHelper::map($counts, 'chapter_id', 'length');
                return $this->render('chapter', [
                    'cars' => $cars,       // 车型信息
                    'subject' => $subject, // 科目信息
                    'chapter' => $chapter, // 章节
                    'counts'  => $counts,  // 章节对应题目数
                ]);
            }

        }

        // 有问题抛出错误
        Yii::$app->session->setFlash('error', '章节练习问题信息为空');
        return $this->redirect(Yii::$app->request->getReferrer());
    }

    /**
     * actionSpecial() 专项练习
     * @return string
     */
    public function actionSpecial()
    {
        // 查询科目信息
        $subject = Subject::findOne(Yii::$app->request->get('subject', 1));
        if ($subject) {
            $special = Special::find()->asArray()->all();
            $all = $ids = $counts = [];
            if ($special) {
                foreach ($special as $value) {
                    $intKid = $value['pid'] == 0 ? $value['id'] : $value['pid'];
                    if ($value['pid'] == 0) {
                        if (isset($all[$intKid])) {
                            $all[$intKid] = array_merge($all[$intKid], $value);
                        } else {
                            $all[$intKid] = array_merge($value, ['child' => []]);
                        }
                    } else {
                        $ids[] = (int)$value['id'];
                        if (isset($all[$intKid])) {
                            $all[$intKid]['child'][$value['sort'].'-'.$value['id']] = $value;
                        } else {
                            $all[$intKid] = [
                                'child' => [$value['sort'].'-'.$value['id'] => $value],
                            ];
                        }
                    }
                }

                // 查询
                $counts = Yii::$app->db->createCommand('SELECT COUNT(*) AS `length`, `special_id` FROM `ks_question` WHERE `special_id` IN ('.implode(',', $ids).') AND `subject_id` = '.$subject->id.'  GROUP BY `special_id`')->queryAll();
                if ($counts) $counts = ArrayHelper::map($counts, 'special_id', 'length');
                $files = [];
                foreach ($all as $k => &$v) {
                    $files[$k] = $v['sort'];
                    ksort($v['child']);
                }

                array_multisort($files, SORT_ASC, $all);
            }

            return $this->render('special', [
                'subject' => $subject,
                'cars' => $subject->car,
                'special' => $all,
                'counts'  => $counts,
            ]);
        }

        // 有问题抛出错误
        Yii::$app->session->setFlash('error', '专项练习问题不存在');
        return $this->redirect(Yii::$app->request->getReferrer());
    }

    /**
     * actionRecord() 记录用户做题信息
     * @return mixed|string
     */
    public function actionRecord()
    {
        $request = Yii::$app->request;
        $intQid  = $request->post('qid');
        $strType = $request->post('sType', 'no');
        if ($intQid) {
            $question = Question::findOne($intQid);
            $this->arrJson['errCode'] = 220;
            if ($question) {
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
                        'name' => $strType,
                        'value' => Json::encode($values),
                        'expire' => time() + 86400,
                    ]));
                }

                // 修改记录信息
                if ($strType == 'no') $question->error_number ++;
                $question->do_number ++;
                $question->save();
                $this->handleJson($question);

            }
        }

        return $this->returnJson();
    }

    /**
     * actionGetQuestion() 获取问题和答案信息
     * @return mixed|string
     */
    public function actionGetQuestion()
    {
        $id = (int)Yii::$app->request->post('qid');
        if ($id) {
            $this->arrJson['errCode'] = 220;
            $question = Question::findOne($id);
            if ($question) {
                $answers = Json::decode($question->answers);
                $this->handleJson([
                    'hasCollect' => UserCollect::hasCollect($question->id, $question->subject_id),
                    'question' => $question,
                    'answers' => $answers
                ]);
            }
        }

        return $this->returnJson();
    }

    /**
     * actionImitate() 全真模拟考试
     * @return string
     * @throws HttpException
     */
    public function actionImitate()
    {
        // 查询科目信息
        $subject = Subject::findOne(Yii::$app->request->get('subject', 1));
        if ($subject) {
            // 解析配置信息
            $config = Json::decode($subject->config);

            // 默认配置
            if (!$config) $config = [];
            if (!isset($config['passingScore'])) $config['passingScore'] = 72;
            if (!isset($config['totalScore'])) $config['totalScore'] = 100;
            if (!isset($config['time'])) $config['time'] = 60;
            if (!isset($config['judgmentScore'])) $config['judgmentScore'] = 2;
            if (!isset($config['selectScore'])) $config['selectScore'] = 2;
            if (!isset($config['multipleScore'])) $config['multipleScore'] =  3;
            if (!isset($config['shortScore'])) $config['shortScore'] = 5;
            if (!isset($config['judgmentNumber'])) $config['judgmentNumber'] = 10;
            if (!isset($config['selectNumber'])) $config['selectNumber'] = 40;
            if (!isset($config['multipleNumber'])) $config['multipleNumber'] = 30;
            if (!isset($config['shortNumber'])) $config['shortNumber'] = 5;

            // 处理总分
            $config['totalScore'] = $config['shortNumber'] * $config['shortScore'];
            $config['totalScore'] += $config['judgmentNumber'] * $config['judgmentScore'];
            $config['totalScore'] += $config['selectNumber'] * $config['selectScore'];
            $config['totalScore'] += $config['multipleNumber'] * $config['multipleScore'];

            // 默认必须查询条件
            $where = ['subject_id' => $subject->id];

            // 查询所有判断题目
            $where['answer_type'] = Question::ANSWER_TYPE_ONE;
            $arrJudgment = Question::getAllIds($where);
            $intStart = mt_rand(0, max(0,count($arrJudgment) - $config['judgmentNumber']));
            $arrJudgment = array_slice($arrJudgment, $intStart, $config['judgmentNumber']);

            // 查询所以单选题目
            $where['answer_type'] = Question::ANSWER_TYPE_JUDGE;
            $arrSelect = Question::getAllIds($where);
            $intStart = mt_rand(0, max(0,count($arrSelect) - $config['selectNumber']));
            $arrSelect = array_slice($arrSelect, $intStart, $config['selectNumber']);

            // 查询所以多选题目multipleNumber
            $where['answer_type'] = Question::ANSWER_TYPE_MULTI;
            $arrMultiple = Question::getAllIds($where);
            $intStart = mt_rand(0, max(0,count($arrMultiple) - $config['multipleNumber']));
            $arrMultiple = array_slice($arrMultiple, $intStart, $config['multipleNumber']);

            // 查询所以问答题目shortNumber
            $where['answer_type'] = Question::ANSWER_TYPE_TEXT;
            $arrShort = Question::getAllIds($where);
            $intStart = mt_rand(0, max(0,count($arrShort) - $config['shortNumber']));
            // 合并所以题目
            $arrShort = array_slice($arrShort, $intStart, $config['shortNumber']);
            $ids = array_merge($arrJudgment, $arrSelect, $arrMultiple, $arrShort);
            if ($ids) {
                $ids = array_unique($ids);
                shuffle($ids);
                $question = Question::findOne($ids[0]);
                if ($question) {
                    $answers = Json::decode($question->answers);
                    return $this->render('imitate', [
                        'config' => $config,
                        'cars' => $subject->car,
                        'question' => $question,
                        'answers' => $answers,
                        'allIds' => $ids
                    ]);
                }
            }
        }

        // 有问题抛出错误
        Yii::$app->session->setFlash('error', '全真模拟考试问题不存在');
        return $this->redirect(Yii::$app->request->getReferrer());
    }

    /**
     * actionWarning() 我的错题
     * @return string|\yii\web\Response
     */
    public function actionWarning()
    {
        // 查询科目
        $subject = Subject::findOne(Yii::$app->request->get('subject', 1));
        if ($subject) {
            $cookie = Yii::$app->request->cookies;
            $objIds = $cookie->get('no');
            if ($objIds && $objIds->value) {
                $arrIds = Json::decode($objIds->value, true);
                // 全部题目
                $allTotal = Question::find()->where([
                    'status' => Question::STATUS_KEY,
                    'subject_id' => $subject->id
                ])->count(); // 全部题库

                $cars = $subject->car;

                Yii::$app->view->params['breadcrumbs'] = [
                    [
                        'label' => $cars->name,
                        'url' => Url::toRoute(['classification/index', 'id' => $cars->id])
                    ],
                    [
                        'label' => $subject->name,
                        'url' => Url::toRoute(['/', 'subject' => $subject->id]),
                    ],
                    '我的错题',
                ];

                // 开始查询
                $question = Question::findOne($arrIds[0]); // 查询一条数据
                if ($question) {
                    // 查询问题答案
                    $answer = Json::decode($question->answers);
                    return $this->render('index', [
                        'cars' => $cars,
                        'subject' => $subject,
                        'allTotal' => (int)$allTotal,
                        'total' => count($arrIds),
                        'hasCollect' => UserCollect::hasCollect($question->id, $subject->id),
                        'allIds' => Json::encode($arrIds),
                        'question' => $question,
                        'answer' => $answer,
                        'style' => 'sequence',
                    ]);
                }
            }
        }

        // 没有数据直接返回
        Yii::$app->session->setFlash('error', '我的错题信息为空');
        return $this->redirect(Yii::$app->request->getReferrer());
    }
}
