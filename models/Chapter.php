<?php

namespace app\models;

/**
 * This is the model class for table "{{%chapter}}".
 *
 * @property integer $id
 * @property string $name
 * @property integer $sort
 * @property integer $subject_id
 * @property integer $created_at
 * @property integer $updated_at
 */
class Chapter extends TimeModel
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
            [['name', 'sort', 'subject_id'], 'required'],
            [['sort', 'created_at', 'updated_at', 'subject_id'], 'integer'],
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
            'subject_id' => '所属科目',
            'created_at' => '添加时间',
            'updated_at' => '修改时间',
        ];
    }
}
