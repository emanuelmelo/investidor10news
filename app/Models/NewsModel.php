<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class NewsModel extends Model
{
    protected $table = "news";

    protected $primaryKey = "id";

    protected $attributes = [
        'ds_title_news',
        'ds_content_news',
        'uuid',
        ];
}
