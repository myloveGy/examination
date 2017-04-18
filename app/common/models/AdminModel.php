<?php

namespace common\models;

use common\behaviors\TimestampBehavior;
use common\behaviors\UpdateBehavior;

/**
 * Class AdminModel
 * @package common\models
 * @description 后台使用的Model 自动填充 created_at、updated_at、created_id、updated_id
 */
class AdminModel extends Model
{
    /**
     * behaviors() 定义行为
     * @return array
     */
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
            UpdateBehavior::className()
        ];
    }
}
