<?php

namespace app\models;

use yii\db\ActiveRecord;
use jinxing\admin\models\traits\CreatedAtTrait;

/**
 * This is the model class for table "ks_cat_type".
 *
 * @property integer $id
 * @property string  $name
 * @property string  $desc
 * @property integer $sort
 * @property integer $created_at
 */
class CarType extends ActiveRecord
{
    use CreatedAtTrait;

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%car_type}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name', 'desc', 'sort'], 'required'],
            [['sort', 'status', 'sort'], 'integer'],
            [['name', 'desc', 'image'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id'         => 'ID',
            'name'       => 'Name',
            'desc'       => 'Desc',
            'sort'       => '排序',
            'status'     => '状态',
            'created_at' => 'Created At',
        ];
    }
}
