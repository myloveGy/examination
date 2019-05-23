<?php

namespace app\assets;

use yii\web\AssetBundle;

class AppAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl  = '@web';
    public $css      = [
        'css/bootstrap.min.css',
        'css/jquery-ui.min.css',
        'css/common.css',
    ];

    public $js = [
        'js/bootstrap.min.js',
        'js/jquery-ui.min.js',
        'js/jquery.validate.min.js',
        'js/validate.message.js',
        'js/layer/layer.js',
        'js/common.js'
    ];

    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapAsset',
    ];
}
