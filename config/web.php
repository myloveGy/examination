<?php

$params = require(__DIR__ . '/params.php');

$config = [
    'id' => 'basic',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'modules' => [
        'admin' => [
            'class' => 'app\modules\admin\Admin',
        ],
    ],
    'components' => [
        'request' => [
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
            'identityClass' => 'app\models\User',
            'enableAutoLogin' => true,
            'idParam'           => '_userId',
            'identityCookie'    => ['name' => '_user','httpOnly' => true],
        ],

        'admin' => [
            'class' => '\yii\web\User',
            'identityClass' => 'app\modules\admin\models\Admin',
            'enableAutoLogin' => true,
            'loginUrl' => ['/admin/default/login'],
            'idParam' => '_adminId',
            'identityCookie' => ['name' => '_admin','httpOnly' => true],
        ],

        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            // send all mails to a file by default. You have to set
            // 'useFileTransport' to false and configure a transport
            // for the mailer to send real emails.
            'useFileTransport' => true,
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db' => require(__DIR__ . '/db.php'),
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [
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
                'yii\web\JqueryAsset' => [
                    'sourcePath' => null,
                    'js' => [],
                ],
            ],
        ],

        // 多语言配置
        'i18n' => [
            'translations' => [
                'app' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'basePath' => '@app/modules/admin/messages',
                    'fileMap' => [
                        'app' => 'app.php',
                        'error' => 'error.php',
                    ],
                ],
            ],
        ],

        // 图片处理
        'image' => [
            'class'  => 'yii\image\ImageDriver',
            'driver' => 'GD'
        ],
    ],
    'params' => $params,
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
    ];
}

return $config;
