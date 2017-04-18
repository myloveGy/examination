<?php

namespace common\models;

use common\behaviors\TimestampBehavior;

/**
 * Class TimestampModel
 * @package common\models
 * @description 后台使用的Model 自动填充 created_at 和 updated_at
 */
class TimestampModel extends Model
{
    /**
     * behaviors() 定义行为
     * @return array
     */
    public function behaviors()
    {
        return [
            TimestampBehavior::className()
        ];
    }
}
