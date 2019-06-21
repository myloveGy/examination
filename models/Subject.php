<?php

namespace app\models;

use yii\db\ActiveRecord;
use yii\helpers\Json;
use jinxing\admin\models\traits\CreatedAtTrait;

/**
 * This is the model class for table "{{%subject}}".
 *
 * @property integer $id
 * @property integer $car_id
 * @property string  $name
 * @property string  $desc
 * @property string  $config
 * @property string  $images
 * @property integer $created_at
 * @property CarType $car
 * @property array   $chapters
 *
 */
class Subject extends ActiveRecord
{
    use CreatedAtTrait;

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
            [['name', 'car_id', 'config'], 'required'],
            [['car_id', 'status', 'sort'], 'integer'],
            [['name', 'image'], 'string', 'max' => 255, 'min' => 2],
            [['desc', 'config'], 'string', 'min' => 2, 'max' => 1000],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id'         => 'ID',
            'name'       => '科目分类信息',
            'car_id'     => '车型ID',
            'desc'       => '说明',
            'status'     => '状态',
            'image'      => '图片信息',
            'config'     => '配置信息',
            'created_at' => '创建时间',
        ];
    }

    public function beforeValidate()
    {
        if (is_array($this->config)) {
            foreach ($this->config as $key => $value) {
                if (empty($value)) {
                    unset($this->config[$key]);
                }
            }

            $this->config = Json::encode($this->config);
        }

        return parent::beforeValidate();
    }

    /**
     * 获取车型信息
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCar()
    {
        return $this->hasOne(CarType::className(), ['id' => 'car_id']);
    }

    /**
     * 获取章节信息
     *
     * @return \yii\db\ActiveQuery
     */
    public function getChapters()
    {
        return $this->hasMany(Chapter::className(), ['subject_id' => 'id']);
    }

    public static function getSubject($where = [])
    {
        $arrReturn = [
            'subject'     => [],
            'car_subject' => [],
        ];

        $where = array_merge(['status' => 1], $where);
        // 查询所有车型
        $cars = CarType::find()->indexBy('id')->all();
        // 查询所有的科目
        $subject = self::find()->where($where)->asArray()->all();
        if ($subject) {
            foreach ($subject as $value) {

                $strName = isset($cars[$value['car_id']]) ?
                    $cars[$value['car_id']]->name . '--' . $value['name'] :
                    $value['name'];


                $arrReturn['subject'][$value['id']] = $strName;
                if (empty($arrReturn['car_subject'][$value['car_id']])) {
                    $arrReturn['car_subject'][$value['car_id']] = [];
                }

                $arrReturn['car_subject'][$value['car_id']][$value['id']] = $strName;
            }
        }

        return $arrReturn;
    }
}
