<?php
namespace app\index\widget;

class RightContent extends Common {
    public function index($page = ''){
        $page = trim($page);
        switch($page){
            case 'article_list':
                break;
            case 'article_detail':
                break;
            default:
                $page = 'index';
                break;
        }

        $this->assign('page', $page);

        return $this->fetch('widget/right_content');
    }
}