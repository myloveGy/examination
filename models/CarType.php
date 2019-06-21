<?php

namespace app\models;

use yii\behaviors\TimestampBehavior;
use yii\db\ActiveRecord;
use yii\db\BaseActiveRecord;
use yii\db\Expression;

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
    /**
     * 定义行为，处理新增时间的写入
     *
     * @return array
     */
    public function behaviors()
    {
        return [
            // 处理新增时间
            'created_at' => [
                'class'      => TimestampBehavior::className(),
                'value'      => new Expression('UNIX_TIMESTAMP()'),
                'attributes' => [
                    BaseActiveRecord::EVENT_BEFORE_INSERT => ['created_at'],
                ],
            ],
        ];
    }

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
