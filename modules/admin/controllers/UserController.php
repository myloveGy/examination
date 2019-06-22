<?php

namespace app\modules\admin\controllers;

use app\modules\admin\models\User;

/**
 * Class UserController 用户信息
 *
 * @package     backend\controllers
 * @description 用户信息
 */
class UserController extends Controller
{
    /**
     * @var string 定义使用的 model
     */
    public $modelClass = 'app\modules\admin\models\User';

    /**
     * where() 查询处理
     *
     * @return array 返回数组
     */
    public function where()
    {
        return [
            [['id', 'status'], '='],
            [['username', 'email', 'phone'], 'like'],
        ];
    }

    /**
     * actionIndex() 首页显示
     * @return string
     */
    public function actionIndex()
    {
        return $this->render('index', [
            'status'      => User::getArrayStatus(),
            'statusColor' => User::getStatusColor(),
        ]);
    }

    /**
     * 处理导出数据格式化
     *
     * @return array
     */
    public function getExportHandleParams()
    {
        $params           = parent::getExportHandleParams();
        $params['status'] = function ($value) {
            return $value == 10 ? '启用' : '停用';
        };

        // 最后登陆时间
        $params['last_time'] = function ($value) {
            return $value ? date('Y-m-d H:i:s', $value) : '';
        };

        // 手机号
        $params['phone'] = function ($value) {
            return "\t" . $value;
        };

        return $params;
    }
}
