<?php

namespace common\models;

/**
 * This is the model class for table "{{%subject}}".
 *
 * @property integer $id
 * @property string $name
 */
class Subject extends Model
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%subject}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => '科目分类信息',
        ];
    }
}
