<?php
/**
 * file: SpecialController.php
 * desc: 专项分类 执行操作控制器
 * date: 2016-10-11 15:56:50
 */

namespace backend\controllers;

use common\helpers\Helper;
use common\models\Special;

class SpecialController extends Controller
{
    /**
     * where() 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
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

    /**
     * getModel() 返回model
     * @return Special
     */
    public function getModel()
    {
        return new Special();
    }
}
