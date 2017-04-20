<?php
/**
 * Created by PhpStorm.
 * User: liujinxing
 * Date: 17-4-20
 * Time: 下午11:35
 */

namespace app\modules\admin\filters;


class AccessControl extends \yii\filters\AccessControl
{
    public $user = 'admin';

}