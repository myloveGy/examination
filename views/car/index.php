<?php

use yii\helpers\Url;

$this->title = $car->name.',车型信息';
$this->params['menu'] = [
    'title' => $car->name,
    'link' => Url::toRoute(['index', 'id' => $car->id])
];
$this->registerCssFile('@web/css/index.css');
?>
<div class="page-header">
    <div class="header">
        <h1><?=$car->name?></h1>
        <small>(<?=$car->desc?>)</small>
    </div>
</div>
<?php if ($subject) : ?>
    <?php foreach ($subject as $value): ?>
    <div class="block-mnks jkbd-con-item bt4 clearfix">
        <div class="head_nav">
            <h2><?=$value->name?>练习及考试</h2>
        </div>
        <div class="content-wapper clc col-md-12">
            <div class="col-md-3">
                <a class="fl lianxi2-a li0 lianxi0 col-md-3"  href="<?=Url::toRoute(['question/index', 'subject' => 1, 'style' => 'sequence'])?>">
                    <span class="name">顺序练习</span>
                </a>
            </div>
            <div class="col-md-3">
                <a class="fl lianxi2-a li1 lianxi3 col-md-3"  href="<?=Url::toRoute(['question/index', 'subject' => 1, 'style' => 'random'])?>">
                    <span class="name">随机练习</span>
                </a>
            </div>
            <div class="col-md-3">
                <a class="fl lianxi2-a li2 lianxichapter col-md-3"  href="<?=Url::toRoute(['question/chapter', 'subject' => $car->id,])?>">
                    <span class="name">章节练习</span>
                </a>
            </div>
            <div class="col-md-3">
                <a class="fl lianxi2-a li3 lianxistrengthen col-md-3"  href="<?=Url::toRoute(['question/special', 'subject' => $car->id,])?>">
                    <span class="name">专项练习</span>
                </a>
            </div>
        </div>
        <div class="content-wapper clc col-md-12">
            <div class="col-md-3">
                <a class="fl lianxi2-a li0 lianxi8 col-md-3"  href="<?=Url::toRoute(['question/index', 'subject' => $car->id, 'type' => 'special', 'cid' => $car ? $car->id : 1])?>">
                    <span class="name">难题练习</span>
                </a>
            </div>
            <div class="col-md-3">
                <a class="fl lianxi2-a li1 lianxi5 col-md-3 <?=Yii::$app->user->isGuest ? "is-login login" : "" ?>"  href="<?=Url::toRoute(['user/collect', 'subject' => $car->id])?>">
                    <span class="name">我的收藏</span>
                </a>
            </div>
            <div class="col-md-3">
                <a class="fl lianxi2-a li2 lianxi4 col-md-3"  href="<?=Url::toRoute(['question/warning', 'subject' => $car->id])?>">
                    <span class="name">我的错题</span>
                </a>
            </div>
            <div class="col-md-3">
                <a class="fl lianxi2-a li3 lianxiexam col-md-3"  href="<?=Url::toRoute(['question/imitate', 'subject' => $car->id])?>">
                    <span class="name">全真模拟</span>
                </a>
            </div>
        </div>
    </div>
    <?php endforeach; ?>
<?php endif; ?>