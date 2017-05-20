<?php
/**
 * Created by PhpStorm.
 * User: liujinxing
 * Date: 17-4-20
 * Time: 下午11:01
 */

namespace app\common\models;

use yii\behaviors\TimestampBehavior;

class TimeModel extends Model
{
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }
}