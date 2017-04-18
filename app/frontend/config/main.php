<?php
$params = array_merge(
    require(__DIR__ . '/../../common/config/params.php'),
    require(__DIR__ . '/params.php')
);

return [
    'id' => 'app-frontend',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'controllerNamespace' => 'frontend\controllers',
    'language'   => 'zh-CN',
    'components' => [
        // 用户配置
        'user' => [
            'identityClass'   => 'common\models\User',
            'enableAutoLogin' => true,
        ],

        // 路由重写
        'urlManager' => [
            'rules' => [
                '<gameName:\w+>/<payType:\w+>/payment' => 'pay/payment', // 支付的路由
                'games/<gameName:\w+>/play'            => 'games/index', // 游戏选择
            ],
        ],

        // 资源加载
        // 资源管理修改
        'assetManager' => [
            'bundles' => [
                // 去掉自己加载的Jquery
                'yii\web\JqueryAsset' => [
                    'js' => ['/js/jquery.min.js'],
                ],
            ],
        ],
    ],

    'params' => $params,
];
