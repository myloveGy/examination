<?php
namespace app\controllers;

class ArticleController extends Controller
{
    public function actionDetail()
    {
        return $this->render('detail');
    }
}
