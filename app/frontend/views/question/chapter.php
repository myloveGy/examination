<?php

use yii\helpers\Url;

$this->title = '章节选择';
$this->registerCssFile('@web/css/chapter.css');
$this->params['breadcrumbs'] = [
    [
        'label' => '科目一',
        'url' => Url::toRoute(['/', 'subject' => 1])
    ],
    $this->title
];
?>
<?=$this->render('_crumbs')?>
<div class="lx-main jkbd-width wid-auto">
    <h1 class="lx-title text-center">小车科目一 章节练习</h1>
    <p class="text-center">按照法规章节逐步分类</p>
    <div class="mt-15"></div>
    <?php if ($chapter) : ?>
    <?php foreach ($chapter as $value) : ?>
    <div class="clearfix">
        <div class="categroy-hd ">
            <h3 class="pull-left">
                <a class="go-to" num="<?=isset($counts[$value['id']]) ? $counts[$value['id']] : 0?>" href="<?=Url::toRoute(['question/index', 'type' => 'chapter', 'cid' => $value['id'], 'style' => 'sequence'])?>">
                    <?=$value['name']?>
                </a>
            </h3>
            <span class="pull-left">（<?=isset($counts[$value['id']]) ? $counts[$value['id']] : 0?>题）</span>
        </div>
        <div class="categroy-bd">
            <ul>
                <li>
                    <a class="go-to" num="<?=isset($counts[$value['id']]) ? $counts[$value['id']] : 0?>" href="<?=Url::toRoute(['question/index', 'type' => 'chapter', 'cid' => $value['id'], 'style' => 'sequence'])?>" >顺序答题</a>
                </li>
                <li>
                    <a class="go-to" num="<?=isset($counts[$value['id']]) ? $counts[$value['id']] : 0?>" href="<?=Url::toRoute(['question/index', 'type' => 'chapter', 'cid' => $value['id'], 'style' => 'random'])?>" >随机答题</a>
                </li>
            </ul>
        </div>
    </div>
    <?php endforeach; ?>
    <?php endif; ?>
</div>
<?php $this->beginBlock('javascript') ?>
<script type="text/javascript">
    $('a.go-to').click(function(evt) {
        if ( ! parseInt($(this).attr('num'))) evt.preventDefault();
    })
</script>
<?php $this->endBlock() ?>
