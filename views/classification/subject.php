<?php

use yii\helpers\Url;

$this->title = $cars->name.','.$subject->name;
$this->registerCssFile('@web/css/index.css', ['depends' => ['app\assets\AppAsset']]);
$this->params['menu'] = [
    'title' => $cars->name,
    'link' => Url::toRoute(['classification/index', 'id' => $cars->id])
];
?>
<div class="page-header">
    <div class="header">
        <h1><?=$cars->name?> - <?=$subject->name?></h1>
        <h2><?=$subject->desc?></h2>
    </div>
</div>

<div class="block-mnks jkbd-con-item bt4">
    <div class="head_nav">
        <h2><?=$subject->name?></h2>
    </div>
    <div class="content-wapper clc col-md-12">
        <div class="col-md-3">
            <a class="fl lianxi2-a li0 lianxi0 col-md-3"  href="<?=Url::toRoute(['question/index', 'subject' => $subject->id, 'style' => 'sequence'])?>">
                <span class="name">顺序练习</span>
            </a>
        </div>
        <div class="col-md-3">
            <a class="fl lianxi2-a li1 lianxi3 col-md-3"  href="<?=Url::toRoute(['question/index', 'subject' => $subject->id, 'style' => 'random'])?>">
                <span class="name">随机练习</span>
            </a>
        </div>
        <div class="col-md-3">
            <a class="fl lianxi2-a li2 lianxichapter col-md-3"  href="<?=Url::toRoute(['question/chapter', 'subject' => $subject->id])?>">
                <span class="name">章节练习</span>
            </a>
        </div>
        <div class="col-md-3">
            <a class="fl lianxi2-a li3 lianxistrengthen col-md-3"  href="<?=Url::toRoute(['question/special', 'subject' => $subject->id,])?>">
                <span class="name">专项练习</span>
            </a>
        </div>
    </div>
    <div class="content-wapper clc col-md-12">
        <div class="col-md-3">
            <a class="fl lianxi2-a li0 lianxi8 col-md-3"  href="<?=Url::toRoute(['question/index', 'subject' => $subject->id, 'type' => 'special', 'cid' => $special ? $special->id : 1])?>">
                <span class="name">难题练习</span>
            </a>
        </div>
        <div class="col-md-3">
            <a class="fl lianxi2-a li1 lianxi5 col-md-3 <?=Yii::$app->user->isGuest ? "is-login login" : "" ?>"  href="<?=Url::toRoute(['user/collect', 'subject' => $subject->id])?>">
                <span class="name">我的收藏</span>
            </a>
        </div>
        <div class="col-md-3">
            <a class="fl lianxi2-a li2 lianxi4 col-md-3"  href="<?=Url::toRoute(['question/warning', 'subject' => $subject->id])?>">
                <span class="name">我的错题</span>
            </a>
        </div>
        <div class="col-md-3">
            <a class="fl lianxi2-a li3 lianxiexam col-md-3"  href="<?=Url::toRoute(['question/imitate', 'subject' => $subject->id])?>">
                <span class="name">全真模拟</span>
            </a>
        </div>
    </div>
</div>
