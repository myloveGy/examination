<?php
namespace frontend\models;

use common\helpers\Helper;
use common\models\Model;
use common\models\User;

class RegisterForm extends Model
{
    public $username;
    public $email;
    public $password;
    public $rePassword; // 重复密码
    public $verifyCode; // 验证码这个变量是必须建的，因为要储存验证码的值` /** * @return array the validation rules. */


    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['username', 'email'], 'filter', 'filter' => 'trim'],
            [['username', 'email', 'password', 'rePassword', 'verifyCode'], 'required'],
            [['username', 'email'], 'string', 'min' => 2, 'max' => 100],
            ['email', 'email'],
            ['password', 'string', 'min' => 6, 'max' => 50],
            ['rePassword', 'compare', 'compareAttribute' => 'password', 'operator' => '=='],
            ['verifyCode', 'captcha'],
            ['email', 'validateEmail'],
        ];
    }

    /**
     * validateEmail()
     * @param $attribute
     * @param $params
     */
    public function validateEmail($attribute, $params)
    {
        // 没有错误验证邮箱
        if ( ! $this->hasErrors()) {
            if (User::findOne(['email' => $this->email])) {
                $this->addError($attribute, \Yii::t('error', 'emailExists'));
            }
        }
    }

    /**
     * Signs user up.
     *
     * @return User|null the saved model or null if saving fails
     */
    public function register()
    {
        $mixReturn = null;
        if ($this->validate()) {
            $user = new User();
            $user->username  = $this->username;
            $user->email     = $this->email;
            $user->last_time = time();
            $user->last_ip   = Helper::getIpAddress();
            $user->setPassword($this->password);
            $user->generateAuthKey();
            if ($user->save()) $mixReturn = $user;
        }

        return $mixReturn;
    }
}
