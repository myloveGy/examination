<?php

use yii\helpers\Url;

$this->title = '首页';
$this->registerCssFile('@web/css/index.css', ['depends' => ['app\assets\AppAsset']]);

?>
<div class="page-header">
    <div class="header">
        <h1>2016小车科目一考试</h1>
        <h2> 科目一，又称科目一理论考试、驾驶员理论考试，是机动车驾驶证考核的一部分 。根据《机动车驾驶证申领和使用规定》，考 试内容包括驾车理论基础、道路安全法律法规、地方性法规等相关知识。考试形式为上机考试，100道题，90分及以上过关。 </h2>
    </div>
</div>

<div class="block-mnks jkbd-con-item bt4">
    <div class="head_nav">
        <h2>选择车型</h2>
    </div>
    <?php if (isset(Yii::$app->view->params['carTypes'])) : ?>
    <div class="content-wapper clc col-md-12">
        <?php foreach (Yii::$app->view->params['carTypes'] as $value) : ?>
        <div class="col-md-3">
            <a class="fl lianxi2-a li0 lianxi0 col-md-3"  href="<?=Url::toRoute(['car/index', 'id' => $value->id])?>">
                <img src="<?=$value->image?>" class="img-circle" alt="<?=$value->name?>" style="max-width: 200px; max-height:100px;" />
                <span class="name"><?=$value->name;?></span>
            </a>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>
