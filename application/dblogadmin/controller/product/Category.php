<?php
namespace app\dblogadmin\controller\product;

use app\dblogadmin\common\constant\Route;
use app\dblogadmin\controller\Common;

class Category extends Common {
    public function index(){
        $parentId = input('get.parent_id/d', 0);
        $parentInfo = model('Category')->get($parentId);
        //父级品类不存在，跳转至第一级品类列表
        if($parentId > 0 && empty($parentInfo)){
            $this->redirect(Route::CATEGORY_LIST);
        }
        $this->assign('parent_id', $parentId);
        $this->assign('parent_info', $parentInfo);

        $backLink = url(Route::CATEGORY_LIST);
        if(!empty($parentInfo) && (int)$parentInfo->parent_id > 0){
            $backLink .= '?parent_id='.(int)$parentInfo->parent_id;
        }
        $this->assign('back_link', $backLink);

        $this->assign('cate_list', model('Category')->getByParentId($parentId));

        return $this->fetch();
    }

    public function detail(){
        $parentId = input('get.parent_id/d', 0);
        $parentInfo = model('Category')->get($parentId);
        //父级品类不存在，跳转至第一级品类列表
        if($parentId > 0 && empty($parentInfo)){
            $this->redirect(Route::CATEGORY_LIST);
        }
        $this->assign('parent_id', $parentId);
        $this->assign('parent_info', $parentInfo);

        $cateId = input('get.category_id/d', 0);
        $cateInfo = model('Category')->get($cateId);
        $this->assign('cate_info', $cateInfo);

        $backLink = url(Route::CATEGORY_LIST);
        if($parentId > 0){
            $backLink .= '?parent_id='.$parentId;
        }
        $this->assign('back_link', $backLink);

        return $this->fetch();
    }
}

