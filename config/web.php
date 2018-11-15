<?php

$params = require(__DIR__ . '/params.php');

$config = [
    'id'         => 'basic',
    'basePath'   => dirname(__DIR__),
    'name'       => '考试系统',
    'bootstrap'  => ['log'],
    'language'   => 'zh-CN',
    'modules'    => [
        'admin' => [
            'class'   => 'app\modules\admin\Admin',
            'modules' => [
                'admin' => [
                    'class'          => 'jinxing\admin\Module',
                    'user'           => 'admin',
                    'leftTopButtons' => [],
                    'userLinks'      => []
                ]
            ],
            'layout'  => '@jinxing/admin/views/layouts/main'
        ],
    ],
    'components' => [
        'request'     => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey' => 'RG8j2YozSEWqgqQQhjnEjXkm1yCP77U1',
        ],

        // 权限管理
        'authManager' => [
            'class' => 'yii\rbac\DbManager',
        ],

        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],

        'user' => [
            'identityClass'   => 'app\models\User',
            'enableAutoLogin' => true,
            'idParam'         => '_userId',
            'loginUrl'        => ['/'],
            'identityCookie'  => ['name' => '_user', 'httpOnly' => true],
        ],

        'admin' => [
            'class'           => 'yii\web\User',
            'identityClass'   => 'jinxing\admin\models\Admin',
            'enableAutoLogin' => true,
            'loginUrl'        => ['/admin/admin/default/login'],
            'idParam'         => '_adminId',
            'identityCookie'  => ['name' => '_admin', 'httpOnly' => true],
        ],

        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'mailer'       => [
            'class'            => 'yii\swiftmailer\Mailer',
            // send all mails to a file by default. You have to set
            // 'useFileTransport' to false and configure a transport
            // for the mailer to send real emails.
            'useFileTransport' => true,
        ],
        'log'          => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets'    => [
                [
                    'class'  => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db'           => require(__DIR__ . '/db.php'),
        'urlManager'   => [
            'enablePrettyUrl' => true,
            'showScriptName'  => false,
            'rules'           => [
                'classification/<id:\d+>'                                 => 'classification/index',
                'classification/subject/<id:\d+>'                         => 'classification/subject',
                'question/warning/<subject:\d+>'                          => 'question/warning',
                'question/imitate/<subject:\d+>'                          => 'question/imitate',
                'question/chapter/<subject:\d+>'                          => 'question/chapter',
                'question/special/<subject:\d+>'                          => 'question/special',
                'question/<subject:\d+>/<style:\w+>/<type:\w+>/<cid:\d+>' => 'question/index',
                'question/index/<type:\w+>/<subject:\d+>/<cid:\d+>'       => 'question/index',
                'question/<style:\w+>-<subject:\d+>'                      => 'question/index',
                'user/collect/<subject:\d+>'                              => 'user/collect',
            ],
        ],

        // 资源管理修改
        'assetManager' => [
            'bundles' => [
                // 去掉自己的bootstrap 资源
                'yii\bootstrap\BootstrapAsset' => [
                    'css' => []
                ],

                // 去掉自己加载的Jquery
                'yii\web\JqueryAsset'          => [
                    'sourcePath' => null,
                    'js'         => [],
                ],
            ],
        ],
    ],
    'params'     => $params,
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][]      = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
    ];

    $config['bootstrap'][]    = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
    ];
}

return $config;
