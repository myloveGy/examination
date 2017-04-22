<?php
/**
 * file: ChapterController.php
 * desc: 章节信息 执行操作控制器
 * date: 2016-10-11 15:47:39
 */

namespace app\modules\admin\controllers;

use app\common\models\CarType;

class CarTypeController extends Controller
{
    /**
     * where() 查询处理
     * @param  array $params
     * @return array 返回数组
     */
    public function where($params)
    {
        return [
			'name' => 'like',
        ];
    }

    /**
     * getModel() 返回model
     * @return CarType
     */
    public function getModel()
    {
        return new CarType();
    }
}
