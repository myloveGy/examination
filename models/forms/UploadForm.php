<?php

namespace app\models\forms;

use \yii\base\Model;

/**
 * Class UploadForm 上传文件处理类
 *
 * @package app\models\forms
 */
class UploadForm extends Model
{
    // 定义字段
    public $avatar;       // 管理员个人页面上传头像
    public $face;         // 管理员信息页面上传头像
    public $question_img; // 问题图片上传
    public $image;        // 车型配置图标
    public $upload_file;        // 车型配置图标

    // 设置应用场景
    public function scenarios()
    {
        return [
            'avatar'       => ['avatar'],
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
            [['avatar'], 'image', 'extensions' => ['png', 'jpg', 'gif', 'jpeg'], 'on' => 'avatar'],
            [['face'], 'image', 'extensions' => ['png', 'jpg', 'gif', 'jpeg'], 'on' => 'face'],
            [['question_img'], 'image', 'extensions' => ['png', 'jpg', 'gif', 'jpeg'], 'on' => 'question_img'],
            [['image'], 'image', 'extensions' => ['png', 'jpg', 'gif', 'jpeg'], 'on' => 'image'],
            [['upload_file'], 'file', 'extensions' => ['xls', 'xlsx'], 'checkExtensionByMimeType' => false, 'on' => 'upload_file'],
        ];
    }
}