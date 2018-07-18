<?php
namespace app\index\controller;

use app\common\model\Category;
use app\index\common\constant\Route;

class Article extends Common {
    public function index($id){
        $id = (int)$id;

        //当前品类
        $cateInfo = model('Category')->get($id);
        if(empty($cateInfo)){
            $this->redirect(Route::INDEX);
        }
        $this->assign('cate_info', $cateInfo);

        //当前品类面包屑
        Category::getParentsByChildrenId($cateInfo->category_id);
        $this->assign('bread_crumbs', Category::$levels);

        //子级品类
        $this->assign('cate_list', model('Category')->getByParentId($id, 1));

        //文章列表
        $this->assign('article_list', model('Product')->getByCategoryId($id, 1));

        return $this->fetch();
    }

    public function detail($id){
        $id = (int)$id;

        //更新浏览量
        model('Product')->where('product_id', $id)->setInc('page_view');

        $prodInfo = model('Product')->get($id);
        if(empty($prodInfo)){
            $this->redirect(Route::INDEX);
        }
        $this->assign('prod_info', $prodInfo);

        //当前文章面包屑
        Category::getParentsByChildrenId($prodInfo->category_id);
        $this->assign('bread_crumbs', Category::$levels);

        return $this->fetch();
    }
}
