<?php

namespace app\modules\admin\controllers;

use app\models\Special;
use jinxing\admin\helpers\Helper;

/**
 * Class SpecialController 专项分类
 *
 * @package app\modules\admin\controllers
 */
class SpecialController extends Controller
{
    /**
     * @var string 定义使用的 model
     */
    public $modelClass = 'app\models\Special';

    /**
     * where() 查询处理
     *
     * @return array 返回数组
     */
    public function where()
    {
        return [
            'id'   => '=',
            'name' => 'like',
        ];
    }

    /**
     * actionIndex() 首页显示
     * @return string
     */
    public function actionIndex()
    {
        $arrParent = Special::find()->where(['pid' => 0])->orderBy('sort')->all();
        return $this->render('index', ['parents' => Helper::map($arrParent, 'id', 'name', ['顶级分类'])]);
    }
}
