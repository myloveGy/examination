<?php

namespace app\common\controllers;

use Yii;

class Controller extends \yii\web\Controller
{
    // 定义 AJAX 响应请求的返回数据
    public $arrJson = [
        'errCode' => 201,
        'errMsg'  => '',
        'data'    => [],
    ];

    /**
     * returnJson() 响应ajax 返回
     *
     * @param string $array
     *
     * @return mixed|string
     */
    protected function returnJson($array = null)
    {
        if ($array == null) $array = $this->arrJson;                    // 默认赋值

        // 没有错误信息使用code 确定错误信息
        if (!isset($array['errMsg']) || empty($array['errMsg'])) {
            $errCode         = Yii::t('app', 'errCode');
            $array['errMsg'] = $errCode[$array['errCode']];
        }

        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;   // json 返回
        return $array;
    }

    /**
     * handleJson() 处理返回数据
     *
     * @param mixed $data    返回数据
     * @param int   $errCode 返回状态码
     * @param null  $errMsg  提示信息
     */
    protected function handleJson($data, $errCode = 0, $errMsg = null)
    {
        $this->arrJson['errCode'] = $errCode;
        $this->arrJson['data']    = $data;
        if ($errMsg !== null) {
            $this->arrJson['errMsg'] = $errMsg;
        }
    }
}