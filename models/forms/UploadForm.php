<?php

namespace app\models\forms;

use \yii\base\Model;
use yii\web\UploadedFile;

/**
 * Class UploadForm 上传文件处理类
 *
 * @package app\models\forms
 */
class UploadForm extends Model
{
    /**
     * @var UploadedFile 用户信息上传头像
     */
    public $face;

    /**
     * @var UploadedFile 问题图片上传
     */
    public $question_img;

    /**
     * @var UploadedFile 车型配置图标
     */
    public $image;

    /**
     * @var UploadedFile 题目上传
     */
    public $upload_file;

    // 设置应用场景
    public function scenarios()
    {
        return [
            'face'         => ['face'],
            'question_img' => ['question_img'],
            'image'        => ['image'],
            'upload_file'  => ['upload_file'],
        ];
    }

    // 验证规则
    public function rules()
    {
        return [
            [['face'], 'image', 'extensions' => ['png', 'jpg', 'gif', 'jpeg'], 'on' => 'face'],
            [['question_img'], 'image', 'extensions' => ['png', 'jpg', 'gif', 'jpeg'], 'on' => 'question_img'],
            [['image'], 'image', 'extensions' => ['png', 'jpg', 'gif', 'jpeg'], 'on' => 'image'],
            [
                ['upload_file'],
                'file',
                'extensions'               => ['xls', 'xlsx'],
                'checkExtensionByMimeType' => false,
                'on'                       => 'upload_file',
            ],
        ];
    }
}