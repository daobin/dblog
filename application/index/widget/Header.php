<?php
namespace app\index\widget;

class Header extends Common {
    public function index(){
        $this->assign('cate_list', model('Category')->getByParentId(0, 1));
        return $this->fetch('widget/header');
    }
}