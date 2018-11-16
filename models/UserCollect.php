<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\helpers\Json;

/**
 * This is the model class for table "{{%user_collect}}".
 *
 * @property integer      $user_id
 * @property integer      $subject_id
 * @property string|array $qids
 */
class UserCollect extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%user_collect}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['user_id', 'subject_id'], 'required'],
            [['user_id', 'subject_id'], 'integer'],
            [['qids'], 'string'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'user_id'    => '用户ID',
            'qids'       => '收藏问题',
            'subject_id' => '科目ID',
        ];
    }

    /**
     * hasCollect() 通过问题ID确定用户有没有收藏该问题
     *
     * @param  int  $id           问题ID
     * @param  int  $intSubjectId 科目ID
     * @param  null $intUserId
     *
     * @return bool
     */
    public static function hasCollect($id, $intSubjectId, $intUserId = null)
    {
        // 传递参数错误 或者 user_id 为空
        if (empty($id) || (!$intUserId = $intUserId ?: Yii::$app->user->id)) {
            return false;
        }

        // 没有查询到用户收藏记录
        if (!$collect = self::findOne(['user_id' => $intUserId, 'subject_id' => $intSubjectId])) {
            return false;
        }

        return in_array($id, $collect->qids);
    }

    /**
     * afterFind() 查询之后处理
     */
    public function afterFind()
    {
        $this->qids = empty($this->qids) ? [] : Json::decode($this->qids);
    }
}
