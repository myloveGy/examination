<?php

use yii\helpers\Url;

$this->title = '章节选择';
$this->registerCssFile('@web/css/chapter.css');
$this->params['breadcrumbs'] = [
    [
        'label' => '科目一',
        'url'   => '/',
    ],
    $this->title

];

?>
<?=$this->render('_crumbs')?>
<div class="lx-main jkbd-width wid-auto">
    <h1 class="lx-title text-center">小车科目一 专项练习</h1>
    <p class="text-center">按照专项类型分类</p>
    <div class="mt-15"></div>
    <?php if ($special) : ?>
        <?php foreach ($special as $value) : ?>
            <div class="clearfix">
                <div class="categroy-hd ">
                    <h3 class="pull-left">
                        <?=$value['name']?>
                    </h3>
                </div>
                <div class="categroy-bd">
                    <?php if ($value['child']) : ?>
                    <ul>
                        <?php foreach ($value['child'] as $val) : ?>
                        <li>
                            <a class="pull-left go-to" num="<?=isset($counts[$val['id']]) ? $counts[$val['id']] : 0?>" href="<?=Url::toRoute(['question/index', 'type' => 'special', 'cid' => $val['id'], 'style' => 'sequence'])?>" > <?=$val['name']?> </a>
                            <span class="pull-left">（<?=isset($counts[$val['id']]) ? $counts[$val['id']] : 0?>题）</span>
                        </li>
                        <?php endforeach; ?>
                    </ul>
                    <?php endif; ?>
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
