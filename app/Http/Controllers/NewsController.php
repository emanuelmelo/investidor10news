<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\NewsModel;

class NewsController extends Controller
{
    public function index()
    {
        $news = NewsModel::all();

        if (!empty($news) && !is_null($news)) {
            foreach ($news as $n) {
                echo $n->ds_title;
                echo $n->ds_news;
            }
        } else {
            return "Não existem noticas cadastradas";
        }
    }
}
