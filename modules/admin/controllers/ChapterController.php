<?php
/**
 * file: ChapterController.php
 * desc: 章节信息 执行操作控制器
 * date: 2016-10-11 15:47:39
 */

namespace app\modules\admin\controllers;

use app\models\Subject;
use jinxing\admin\controllers\Controller;

class ChapterController extends Controller
{
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
