<?php

namespace app\modules\admin\controllers;

use app\models\Subject;

/**
 * Class ChapterController 章节信息
 *
 * @package app\modules\admin\controllers
 */
class ChapterController extends Controller
{
    /**
     * 使用的 model
     */
    public $modelClass = 'app\models\Chapter';

    /**
     * where() 查询处理
     *
     * @return array 返回数组
     */
    public function where()
    {
        return [
            [['id', 'subject_id'], '='],
            ['name', 'like'],
        ];
    }

    public function actionIndex()
    {
        $subject = Subject::getSubject();
        return $this->render('index', ['subject' => $subject['subject']]);
    }
}
