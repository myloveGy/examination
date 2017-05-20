<?php

use yii\helpers\Url;

$this->title = $car->name.',类型信息';
$this->params['menu'] = [
    'title' => $car->name,
    'link' => Url::toRoute(['index', 'id' => $car->id])
];
$this->registerCssFile('@web/css/index.css', ['depends' => ['app\assets\AppAsset']]);
?>
<div class="page-header">
    <div class="header">
        <h1><?=$car->name?></h1>
        <small>(<?=$car->desc?>)</small>
    </div>
</div>
<?php if ($subject) : ?>
    <div class="block-mnks jkbd-con-item bt4 clearfix">
        <div class="head_nav">
            <h2> 考试科目信息 </h2>
        </div>
        <div class="content-wapper clc col-md-12">
            <?php foreach ($subject as $value): ?>
                <div class="col-md-4">
                    <a class="fl lianxi2-a li0 car-item"  href="<?=Url::toRoute(['classification/subject', 'id' => $value->id])?>">
                        <div class="text-center car-image">
                            <img src="<?=$value->image?>" class="img-circle" alt="<?=$value->name?>" />
                        </div>
                        <div class="car-a">
                            <h4><?=$value->name;?></h4>
                        </div>
                    </a>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
<?php endif; ?>