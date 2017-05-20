<?php
/**
 * Created by PhpStorm.
 * Date: 2016/10/16
 * Time: 12:51
 */
use yii\widgets\Breadcrumbs;
?>
<ol class="breadcrumb">
    <?= Breadcrumbs::widget([
        'homeLink' => [
            'label' => '首页',
            'url' => ['/']
        ],
        'encodeLabels' => false,
        'tag' => 'ol',
        'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
    ]) ?>
</ol>
