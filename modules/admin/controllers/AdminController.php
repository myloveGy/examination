<?php

namespace app\modules\admin\controllers;

use Yii;
use app\modules\admin\models\AdminUser;

/**
 * file: AdminController.php
 * desc: 管理员操作控制器
 * user: liujinxing
 * date: 2016-0-21
 */
class AdminController extends Controller
{
    /**
     * where() 搜索配置
     * @param  array $params 查询参数
     * @return array
     */
    public function where($params)
    {
        $where  = [];
        $intUid = (int)Yii::$app->admin->id;
        if ($intUid != 1) {
            $where = [['or', ['id' => $intUid], ['created_id' => $intUid]]];
        }

        return [
            'id'       => '=',
            'username' => 'like',
            'email'    => 'like',
            'where'    => $where,
        ];
    }

    /**
     * actionIndex() 首页显示
     * @return string
     */
    public function actionIndex()
    {
        // 查询用户数据
        return $this->render('index', [
            'roles'  => AdminUser::getArrayRole(),      // 用户角色
            'status' => AdminUser::getArrayStatus(),    // 状态
            'statusColor' => AdminUser::getStatusColor(), // 状态对应颜色
        ]);
    }

    /**
     * getModel() 获取model
     * @return AdminUser
     */
    public function getModel()
    {
        return new AdminUser();
    }

    /**
     * afterUpload() 上传文件之后的处理
     * @param object $objFile
     * @param string $strFilePath
     * @param string $strField
     * @return bool
     */
    public function afterUpload($objFile, &$strFilePath, $strField)
    {
        // 上传头像信息
        if ($strField === 'avatar' || $strField === 'face') {
            // 删除之前的缩略图
            $strFace = Yii::$app->request->post('face');
            if ($strFace) {
                $strFace = dirname($strFace).'/thumb_'.basename($strFace);
                if (file_exists('.'.$strFace)) @unlink('.'.$strFace);
            }

            // 处理图片
            $strTmpPath = dirname($strFilePath).'/thumb_'.basename($strFilePath);
            $image = Yii::$app->image->load($strFilePath);
            $image->resize(180, 180, \yii\image\drivers\Image::CROP)->save($strTmpPath);
            $image->resize(48, 48, \yii\image\drivers\Image::CROP)->save();

            // 管理员页面修改头像
            $admin = AdminUser::findOne(Yii::$app->user->id);
            if ($admin && $strField === 'avatar') {
                // 删除之前的图像信息
                if ($admin->face && file_exists('.'.$admin->face)) {
                    @unlink('.'.$admin->face);
                    @unlink('.'.dirname($admin->face).'/thumb_'.basename($admin->face));
                }

                $admin->face = ltrim($strFilePath, '.');
                $admin->save();
                $strFilePath = $strTmpPath;
            }
        }

        return true;
    }
}
