<?php

namespace common\models;

/**
 * This is the model class for table "{{%answer}}".
 *
 * @property integer $id
 * @property integer $qid
 * @property string $name
 */
class Answer extends Model
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%answer}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['qid', 'name'], 'required'],
            [['qid'], 'integer'],
            [['name'], 'string'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => '答案ID',
            'qid' => '问题ID',
            'name' => '答案说明',
        ];
    }
}
