<?php

namespace app\modules\admin\controllers;

/**
 * Class ClassificationController 考试类型
 *
 * @package app\modules\admin\controllers
 */
class ClassificationController extends Controller
{
    /**
     * 使用的model
     */
    public $modelClass = 'app\models\CarType';

    /**
     * where() 查询处理
     *
     * @return array 返回数组
     */
    public function where()
    {
        return [
            ['id', '='],
            ['name', 'like'],
        ];
    }
}
