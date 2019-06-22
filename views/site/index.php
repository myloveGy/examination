<?php

use yii\helpers\Url;

$this->title = '首页';
$this->registerCssFile('@web/css/index.css', ['depends' => ['app\assets\AppAsset']]);
?>
<div class="page-header">
    <div class="header">
        <h1>考试系统</h1>
    </div>
</div>

<div class="block-mnks jkbd-con-item bt4">
    <div class="head_nav">
        <h2>选择考试类型</h2>
    </div>
    <?php if (isset(Yii::$app->view->params['carTypes'])) : ?>
    <div class="content-wapper clc col-md-12">
        <?php foreach (Yii::$app->view->params['carTypes'] as $value) : ?>
        <div class="col-md-4">
            <a class="fl lianxi2-a li0 car-item"  href="<?=Url::toRoute(['classification/index', 'id' => $value->id])?>">
                <div class="text-center car-image">
                    <img src="<?=$value->image?>" class="img-responsive" alt="<?=$value->name?>" />
                </div>
                <div class="car-a">
                    <h4><?=$value->name;?></h4>
                </div>
            </a>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>
