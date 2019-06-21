<?php

namespace app\models;

use yii\db\Query;
use yii\helpers\Json;
use yii\db\ActiveRecord;
use jinxing\admin\models\traits\TimestampTrait;

/**
 * This is the model class for table "{{%question}}".
 *
 * @property integer $id
 * @property string  $question_title
 * @property string  $question_content
 * @property string  $question_img
 * @property string  $answers
 * @property integer $answer_type
 * @property integer $status
 * @property integer $answer_id
 * @property integer $created_at
 * @property integer $updated_at
 * @property integer $subject_id
 * @property integer $chapter_id
 * @property integer $special_id
 * @property integer $error_number
 * @property integer $do_number
 */
class Question extends ActiveRecord
{
    use TimestampTrait;

    // 状态
    const STATUS_NO  = 0; // 停用
    const STATUS_KEY = 1; // 启用

    // 答案类型
    const ANSWER_TYPE_ONE   = 1;   // 单选
    const ANSWER_TYPE_JUDGE = 2;   // 判断
    const ANSWER_TYPE_MULTI = 3;   // 多选
    const ANSWER_TYPE_TEXT  = 4; // 填空

    /**
     * getStatusDesc() 获取状态说明信息
     *
     * @param null $intStatus
     *
     * @return array|mixed
     */
    public static function getStatusDesc($intStatus = null)
    {
        $array = [
            self::STATUS_NO  => '停用',
            self::STATUS_KEY => '启用',
        ];

        if ($intStatus !== null && isset($array[$intStatus])) $array = $array[$intStatus];
        return $array;
    }

    /**
     * getStatusColor() 获取状态对应颜色信息
     *
     * @param null $intStatus
     *
     * @return array|mixed
     */
    public static function getStatusColor($intStatus = null)
    {
        $array = [
            self::STATUS_NO  => 'label-danger',
            self::STATUS_KEY => 'label-success',
        ];

        if ($intStatus !== null && isset($array[$intStatus])) $array = $array[$intStatus];
        return $array;
    }

    /**
     * getTypeDesc() 获取问题类型说明信息
     *
     * @param null $intStatus
     *
     * @return array|mixed
     */
    public static function getTypeDesc($intStatus = null)
    {
        $array = [
            self::ANSWER_TYPE_ONE   => '单选',
            self::ANSWER_TYPE_JUDGE => '判断',
            self::ANSWER_TYPE_MULTI => '多选',
            self::ANSWER_TYPE_TEXT  => '问答',
        ];

        if ($intStatus !== null && isset($array[$intStatus])) $array = $array[$intStatus];
        return $array;
    }

    /**
     * getAnswerTypeDesc() 获取问题类型说明信息
     *
     * @param null $intType
     *
     * @return array|mixed
     */
    public static function getAnswerTypeDesc($intType = null)
    {
        $array = [
            self::ANSWER_TYPE_ONE   => '单选题,请选择你认为正确的答案!',
            self::ANSWER_TYPE_JUDGE => '判断题,请判断对错!',
            self::ANSWER_TYPE_MULTI => '多选题,请选择你认为正确的答案!',
            self::ANSWER_TYPE_TEXT  => '问答题，请填写你的答案',
        ];

        if ($intType !== null && isset($array[$intType])) $array = $array[$intType];
        return $array;
    }

    /**
     * getAllIds() 获取题目ID
     *
     * @param array $where  查询条件
     * @param array $params 查询数据条数
     *
     * @return array
     */
    public static function getAllIds($where, $params = [])
    {
        $query = (new Query())->select('id')->from(self::tableName())->where($where)->indexBy('id');
        // 判断查询数据条数
        if (isset($params['offset'])) $query = $query->offset($params['offset']);
        if (isset($params['limit']) && !empty($params['limit'])) $query = $query->limit($params['limit']);
        $array = $query->all();
        return empty($array) ? [] : array_keys($array);
    }

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%question}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['question_title', 'answer_type'], 'required'],
            [['question_title', 'question_content', 'question_img', 'answer_id', 'answers'], 'string'],
            [[
                'answer_type', 'status', 'created_at', 'updated_at',
                'subject_id', 'chapter_id', 'special_id',
                'error_number', 'do_number',
            ], 'integer'],
        ];
    }

    public function beforeValidate()
    {
        if (is_array($this->answer_id)) {
            $answers = [];
            foreach ($this->answer_id as $value) {
                $intAnswerId = intval($value);
                if ($intAnswerId >= 0) $answers[] = $intAnswerId;
            }

            $this->answer_id = Json::encode($answers);
        } else {
            $this->answer_id = $this->answer_id == -1 ? "" : $this->answer_id;
        }

        if (is_array($this->answers)) {
            $answers = [];
            foreach ($this->answers as $value) {
                if ($value) $answers[] = $value;
            }

            $this->answers = Json::encode($answers);
        }

        return parent::beforeValidate();
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id'               => '题目ID',
            'question_title'   => '题目问题',
            'question_content' => '题目说明',
            'question_img'     => '问题图片',
            'answer_type'      => '答案类型(1 单选 2 多选 3 判断)',
            'status'           => '状态(1 启用 0 停用)',
            'answer_id'        => '正确答案ID',
            'created_at'       => '创建时间',
            'updated_at'       => '修改时间',
            'subject_id'       => '所属科目ID',
            'chapter_id'       => '所属章节',
            'special_id'       => '专项ID',
            'error_number'     => '错误人数',
            'do_number'        => '做过该题人数',
        ];
    }
}
