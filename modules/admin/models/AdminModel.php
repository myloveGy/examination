<?php
/**
 * Created by PhpStorm.
 * User: liujinxing
 * Date: 17-4-20
 * Time: 下午11:01
 */

namespace app\modules\admin\models;

use yii\behaviors\TimestampBehavior;
use app\common\behaviors\UpdateBehavior;

class AdminModel extends \app\common\models\Model
{
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
            UpdateBehavior::className(),
        ];
    }
}