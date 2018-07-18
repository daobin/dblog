<?php
namespace app\dblogadmin\controller\product;

use app\dblogadmin\controller\Common;

class Product extends Common {
    public function index(){
        $this->assign('prod_list', model('Product')->getByPage());
        return $this->fetch();
    }

    public function detail(){
        $prodId = input('get.product_id/d', 0);
        $prodInfo = model('Product')->get($prodId);
        $this->assign('prod_info', $prodInfo);

        $cateNamePath = '';
        $cateList = [];
        if(!empty($prodInfo)){
            \app\common\model\Category::getParentsByChildrenId($prodInfo->category_id);
            $cateLevels = \app\common\model\Category::$levels;
            if(!empty($cateLevels)){
                $cateNamePath = [];
                foreach($cateLevels as $cate){
                    $cateNamePath[] = trim($cate['title']);
                }
                $cateNamePath = implode(' >> ', $cateNamePath);
            }
        }else{
            $cateList = model('Category')->getByParentId(0);
        }
        $this->assign('cate_name_path', $cateNamePath);
        $this->assign('cate_list', $cateList);

        return $this->fetch();
    }
}

