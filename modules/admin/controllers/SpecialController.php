<?php
/**
 * file: SpecialController.php
 * desc: 专项分类 执行操作控制器
 * date: 2016-10-11 15:56:50
 */

namespace app\modules\admin\controllers;

use app\models\Special;
use jinxing\admin\controllers\Controller;
use jinxing\admin\helpers\Helper;

class SpecialController extends Controller
{
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
