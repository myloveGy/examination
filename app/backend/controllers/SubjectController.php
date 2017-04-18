<?php
/**
 * file: SubjectController.php
 * desc: 科目信息 执行操作控制器
 * date: 2016-10-11 15:42:46
 */

namespace backend\controllers;

use common\models\Subject;

class SubjectController extends Controller
{
    /**
     * where() 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
            'id' => '=',
			'name' => 'like',
        ];
    }

    /**
     * getModel() 返回model
     * @return Subject
     */
    public function getModel()
    {
        return new Subject();
    }
}
