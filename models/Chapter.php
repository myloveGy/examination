<?php

namespace common\models;

/**
 * This is the model class for table "{{%chapter}}".
 *
 * @property integer $id
 * @property string $name
 * @property integer $sort
 * @property integer $created_at
 * @property integer $updated_at
 */
class Chapter extends TimestampModel
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%chapter}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name', 'sort'], 'required'],
            [['sort', 'created_at', 'updated_at'], 'integer'],
            [['name'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => '章节分类ID',
            'name' => '章节分类名称',
            'sort' => '排序',
            'created_at' => '添加时间',
            'updated_at' => '修改时间',
        ];
    }
}
