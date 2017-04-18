<?php

namespace common\models;

use Yii;
use yii\helpers\Json;

/**
 * This is the model class for table "{{%user_collect}}".
 *
 * @property integer $user_id
 * @property integer $subject_id
 * @property string  $qids
 */
class UserCollect extends \common\models\Model
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
            'user_id' => '用户ID',
            'qids' => '收藏问题',
            'subject_id' => '科目ID',
        ];
    }

    /**
     * hasCollect() 通过问题ID确定用户有没有收藏该问题
     * @param  int $id           问题ID
     * @param  int $intSubjectId 科目ID
     * @param  null $intUserId
     * @return bool
     */
    public static function hasCollect($id, $intSubjectId, $intUserId = null)
    {
        $isReturn = false;
        if ($intUserId || ! Yii::$app->user->isGuest) {
            $collect = self::findOne([
                'user_id' => $intUserId ? $intUserId : Yii::$app->user->id,
                'subject_id' => $intSubjectId
            ]);
            if ($collect && in_array($id, $collect->qids)) $isReturn = true;
        }

        return $isReturn;
    }

    /**
     * afterFind() 查询之后处理
     */
    public function afterFind()
    {
        if (empty($this->qids)) {
            $this->qids = [];
        } else {
            $this->qids = Json::decode($this->qids, true);
        }
    }
}
