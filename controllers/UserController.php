<?php
/**
 * Created by PhpStorm.
 * Date: 2016/10/14
 * Time: 12:00
 */

namespace frontend\controllers;

use Yii;
use yii\helpers\Json;
use yii\helpers\Url;
use common\models\Question;
use common\models\Subject;
use common\models\UserCollect;
use common\models\Answer;

/**
 * Class UserController
 * @package frontend\controllers
 */
class UserController extends \common\controllers\UserController
{
    /**
     * actionCollect 用户收藏的问题
     * @return string|\yii\web\Response
     */
    public function actionCollect()
    {
        // 查询科目
        $subject = Subject::findOne(Yii::$app->request->get('subject', 1));
        if ($subject) {
            $collect = UserCollect::findOne([
                'user_id' => Yii::$app->user->id,
                'subject_id' => $subject->id,
            ]);

            // 有收藏
            if ($collect && $collect->qids) {
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
                        'label' => '我的收藏',
                        'url' => Url::toRoute(['user/collect', 'subject' => $subject->id])
                    ],
                    '顺序练习',
                ];

                // 开始查询
                $question = Question::findOne($collect->qids[0]); // 查询一条数据
                if ($question) {
                    // 查询问题答案
                    $answer = Answer::findAll(['qid' => $question->id]);
                    return $this->render('/question/index', [
                        'subject' => $subject,
                        'allTotal' => (int)$allTotal,
                        'total' => count($collect->qids),
                        'hasCollect' => UserCollect::hasCollect($question->id, $subject->id),
                        'allIds' => Json::encode($collect->qids),
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

    /**
     * actionCreateCollect() 添加用户收藏信息
     * @return array 返回json字符串
     */
    public function actionCreateCollect()
    {
        $request = Yii::$app->request;
        $intQid = (int)$request->post('qid');
        $strType = $request->post('type');
        $intSubject = (int)$request->post('subject', 1);

        // 判断数据的有效性
        if ($intQid && $strType && in_array($strType, ['create', 'remove'])) {
            // 查询对象
            $model = UserCollect::findOne([
                'user_id' => Yii::$app->user->id,
                'subject_id' => $intSubject
            ]);
            if ( ! $model) {
                $model = new UserCollect();
                $model->user_id = Yii::$app->user->id;
                $model->subject_id = $intSubject;
                $model->qids = [];
            }

            $array = $model->qids;
            $isTrue = false;
            if ($strType == 'create') {
                // 获取之前的收藏信息
                $this->arrJson['errCode'] = 222;
                if (! in_array($intQid, $array) || empty($array)) {
                    array_push($array, $intQid);
                    $array = array_unique($array);
                    $isTrue = true;
                }
            } else {
                // 删除收藏
                $this->arrJson['errCode'] = 224;
                if (in_array($intQid, $array)) {
                    $intKey = array_search($intQid, $array);
                    if ($intKey !== false) unset($array[$intKey]);
                    sort($array);
                    $isTrue = true;
                }
            }

            if ($isTrue) {
                $model->qids = Json::encode($array);
                if ($model->save()) $this->handleJson($model);
            }
        }

        return $this->returnJson();
    }
}