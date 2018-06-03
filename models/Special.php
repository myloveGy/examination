<?php

namespace app\models;

/**
 * This is the model class for table "{{%special}}".
 *
 * @property integer $id
 * @property integer $pid
 * @property string $name
 * @property integer $sort
 * @property integer $created_at
 * @property integer $updated_at
 */
class Special extends TimeModel
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%special}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['pid', 'created_at', 'updated_at', 'sort'], 'integer'],
            [['name', 'pid'], 'required'],
            [['name'], 'string', 'max' => 255, 'min' => 2],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'pid' => '父类ID',
            'name' => '专项分类名称',
            'sort' => '排序',
            'created_at' => '添加时间',
            'updated_at' => '修改时间',
        ];
    }
}
