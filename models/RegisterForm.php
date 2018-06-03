<?php
namespace app\models;

use jinxing\admin\helpers\Helper;

class RegisterForm extends User
{
    public $username;
    public $phone;
    public $email;
    public $password;
    public $rePassword; // 重复密码
    public $verifyCode; // 验证码这个变量是必须建的，因为要储存验证码的值` /** * @return array the validation rules. */

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%user}}';
    }


    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['username', 'phone'], 'filter', 'filter' => 'trim'],
            [['username', 'phone', 'password', 'rePassword', 'verifyCode'], 'required'],
            [['username'], 'string', 'min' => 2, 'max' => 100],
            ['phone', 'match', 'pattern' => User::PHONE_PATTERN, 'message' => '手机号错误'],
            ['phone', 'string', 'min' => 11, 'max' => 11],
            ['password', 'string', 'min' => 6, 'max' => 50],
            ['rePassword', 'compare', 'compareAttribute' => 'password', 'operator' => '=='],
            ['verifyCode', 'captcha'],
            ['phone', 'validatePhone'],
            ['username', 'unique', 'message' => '该用户名已被注册'],
        ];
    }

    /**
     * validateEmail()
     * @param $attribute
     * @param $params
     */
    public function validatePhone($attribute, $params)
    {
        // 没有错误验证邮箱
        if (!$this->hasErrors()) {
            if (User::findOne(['phone' => $this->phone])) {
                $this->addError($attribute, '该手机号已经注册');
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
            $user->username = $this->username;
            $user->phone = $this->phone;
            $user->last_time = time();
            $user->last_ip = Helper::getIpAddress();
            $user->setPassword($this->password);
            $user->generateAuthKey();
            if ($user->save()) $mixReturn = $user;
        }

        return $mixReturn;
    }
}
