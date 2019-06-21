<?php
/**
 *
 * TimeTrait.php
 *
 * Author: jinxing.liu
 * Create: 2019-06-21 14:46
 * Editor: created by PhpStorm
 */

namespace app\models\traits;

use yii\db\Expression;
use yii\behaviors\TimestampBehavior;

/**
 * Trait TimeTrait 定义处理时间的方法
 *
 * @package app\models\traits
 */
trait TimeTrait
{
    /**
     * 定义行为处理时间
     *
     * @return array
     */
    public function behaviors()
    {
        return [
            'time' => [
                'class' => TimestampBehavior::className(),
                'value' => new Expression('UNIX_TIMESTAMP()'),
            ],
        ];
    }
}