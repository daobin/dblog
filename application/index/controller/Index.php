<?php
namespace app\index\controller;

use think\Image;

class Index extends Common {
    public function index(){
        //五篇最新文章
        $condition = ['status'=>1];
        $this->assign('newest_article_list', model('Product')->getByPage($condition, 5));

        return $this->fetch();
    }

    public function search(){

    }

    public function image(){
        $this->view->engine->layout(false);

        $pathname = input('get.pathname/s', '');
        $suffix = input('get.suffix/s', '');
        $width = input('get.w/d', 0);
        $height = input('get.h/d', 0);

        $imgFile = ROOT_PATH.$pathname.$suffix;
        if(!file_exists($imgFile)){
            return 'no file';
        }

        $newPath = ROOT_PATH.'runtime/'.$pathname;
        $newPath = dirname($newPath);
        if(!is_dir($newPath)){
            $dirMk = mkdir($newPath, 0755, true);
            if(empty($dirMk)){
                return 'image path mk error';
            }
        }

        $newImgFile = $newPath.'/'.basename($pathname).'_'.$width.'_'.$height.$suffix;
        if(!file_exists($newImgFile)){
            Image::open($imgFile)->thumb($width, $height, Image::THUMB_FILLED)->save($newImgFile);
        }

        if(file_exists($newImgFile)){
            $imagevariable = file_get_contents($newImgFile);
            switch($suffix){
                case '.png';
                    $image_contentType = 'x-png';
                    break;
                default:
                    $image_contentType = 'jpeg';
                    break;
            }
            header("Content-type: image/$image_contentType") ;
            header("Content-Length: ".strlen($imagevariable));
            echo $imagevariable;
            die;
        }

        return $newImgFile;
    }
}
