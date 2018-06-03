<?php
/**
 * Created by PhpStorm.
 * User: liujinxing
 * Date: 17-4-20
 * Time: 下午11:01
 */

namespace app\models;

use yii\behaviors\TimestampBehavior;
use yii\db\ActiveRecord;

class TimeModel extends ActiveRecord
{
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }
}