<?php
namespace frontend\controllers;

use common\models\Subject;
use common\models\UserCollect;
use Yii;
use common\models\Answer;
use common\models\Question;
use common\models\Chapter;
use common\models\Special;
use common\controllers\Controller;
use yii\helpers\ArrayHelper;
use yii\helpers\Json;
use yii\helpers\Url;
use yii\web\HttpException;


class QuestionController extends Controller
{
    /**
     * actionIndex() 显示首页
     * @return string
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
            $crumbs = [[
                'label' => $subject->name,
                'url' => Url::toRoute(['/', 'subject' => $subject->id]),
            ]];

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
            $total    = Question::find()->where($where)->count();
            $ids = Question::getAllIds($where);
            $question = Question::findOne($where); // 查询一条数据
            $errMsg = '问题不存在';
            if ($question) {
                // 查询问题答案
                $answer = Answer::findAll(['qid' => $question->id]);
                return $this->render('index', [
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
        throw new HttpException(401, $errMsg);
    }

    /**
     * actionChapter() 章节练习
     * @return string
     */
    public function actionChapter()
    {
        $chapter = Chapter::find()->orderBy('sort')->asArray()->all();
        $counts  = [];
        if ($chapter) {
            $chapterIds = [];
            foreach ($chapter as $value) $chapterIds[] = (int)$value['id'];
            $counts = Yii::$app->db->createCommand('SELECT COUNT(*) AS `length`, `chapter_id` FROM `ks_question` WHERE `chapter_id` IN ('.implode(',', $chapterIds).') GROUP BY `chapter_id`')->queryAll();
            if ($counts) $counts = ArrayHelper::map($counts, 'chapter_id', 'length');
        }

        return $this->render('chapter', [
            'chapter' => $chapter, // 章节
            'counts'  => $counts,  // 章节对应题目数
        ]);
    }

    /**
     * actionSpecial() 专项练习
     * @return string
     */
    public function actionSpecial()
    {
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
            $counts = Yii::$app->db->createCommand('SELECT COUNT(*) AS `length`, `special_id` FROM `ks_question` WHERE `special_id` IN ('.implode(',', $ids).') GROUP BY `special_id`')->queryAll();
            if ($counts) $counts = ArrayHelper::map($counts, 'special_id', 'length');
            $files = [];
            foreach ($all as $k => &$v) {
                $files[$k] = $v['sort'];
                ksort($v['child']);
            }

            array_multisort($files, SORT_ASC, $all);
        }

        return $this->render('special', [
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
                $answers = Answer::findAll(['qid' => $question->id]);
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
     * actionInstall() 获取数据新增
     * @return mixed|string
     */
    public function actionInstall()
    {
        $request = Yii::$app->request;
        $title = trim($request->get('title'));
        $items = $request->get('items');
        $answer = $request->get('answer');
        $content = trim($request->get('content'));
        $img = trim($request->get('question_img'));
        $answer_type = (int)$request->get('answer_type');
        if ($title && $items) {
            $model = new Question();
            $model->answer_type = $answer_type;
            $model->question_title = $title;
            $model->question_content = $content;
            $model->status = 1;
            $model->subject_id = 1;
            $model->chapter_id = 1;
            if ($img) {
                $model->question_img = $this->download($img, 'http://file.open.jiakaobaodian.com/');
            }
            if ($model->save()) {
                foreach ($items as $key => $val) {
                    $tmp = new Answer();
                    $tmp->name = $val;
                    $tmp->qid  = $model->id;
                    if ($tmp->save() && $key == $answer) {
                        $model->answer_id = $tmp->id;
                        $model->save(false);
                    }
                }
            }
        }

        return $this->returnJson();
    }

    /**
     * download() 盗取图片
     * @param  string $imgPath 图片地址
     * @param  string $replace 替换地址
     * @param  string $dir     保存目录
     * @return bool|mixed
     */
    protected function download($imgPath, $replace, $dir = './upload/')
    {
        $mixReturn = false;
        $strImg = file_get_contents($imgPath);
        if ($strImg) {
            $dirPath = str_replace($replace, $dir, $imgPath);
            $dir = dirname($dirPath);
            if (!file_exists($dir)) mkdir($dir, 0777, true);
            if (file_put_contents($dirPath, $strImg)) {
                $mixReturn = $dirPath;
            }
        }

        return $mixReturn;
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
            $where = ['subject_id' => $subject->id];
            $total = Question::find()->where($where)->count();
            $params = ['limit' => 300];
            $params['offset'] = mt_rand(0, max(0, $total- $params['limit']));
            $ids = Question::getAllIds($where, $params);
            if ($ids) {
                shuffle($ids);
                $ids = array_slice($ids, 0, $params['limit'] / 3);
                $question = Question::findOne($ids[0]);
                if ($question) {
                    $answers = Answer::findAll(['qid' => $question->id]);
                    return $this->render('imitate', [
                        'question' => $question,
                        'answers' => $answers,
                        'allIds' => $ids
                    ]);
                }
            }
        }

        throw  new HttpException(404, '数据不存在');
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

                Yii::$app->view->params['breadcrumbs'] = [
                    [
                        'label' => $subject->name,
                        'url' => Url::toRoute(['/', 'subject' => $subject->id]),
                    ],
                    [
                        'label' => '我的错题',
                        'url' => Url::toRoute(['question/warning', 'subject' => $subject->id])
                    ],
                    '顺序练习',
                ];

                // 开始查询
                $question = Question::findOne($arrIds[0]); // 查询一条数据
                if ($question) {
                    // 查询问题答案
                    $answer = Answer::findAll(['qid' => $question->id]);
                    return $this->render('index', [
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
        return $this->redirect(['/', 'subject' => 1]);
    }
}
