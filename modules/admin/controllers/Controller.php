<?php


namespace app\modules\admin\controllers;

use jinxing\admin\controllers\Controller as BaseController;

/**
 * Class Controller 基础控制器
 *
 * @package app\modules\admin\controllers
 */
class Controller extends BaseController
{
    /**
     * 导出数据格式化处理
     *
     * @return array
     */
    public function getExportHandleParams()
    {
        $array['created_at'] = $array['updated_at'] = function ($value) {
            return date('Y-m-d H:i:s', $value);
        };

        $array['status'] = function ($value) {
            return $value == 1 ? '启用' : '停用';
        };

        return $array;
    }
}