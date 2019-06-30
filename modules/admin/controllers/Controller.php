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
     * 使用上传文件处理表单类
     */
    public $uploadFromClass = 'app\models\forms\UploadForm';

    /**
     * 导出数据格式化处理
     *
     * @return array
     */
    public function getExportHandleParams()
    {
        $array           = parent::getExportHandleParams();
        $array['status'] = function ($value) {
            return $value == 1 ? '启用' : '停用';
        };

        return $array;
    }
}