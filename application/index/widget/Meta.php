<?php
namespace app\index\widget;

use app\index\common\constant\Route;

class Meta extends Common {
    public function index(){
        if($this->equipment == 'mobile'){
            $this->assignCssOfMobile();
        }else{
            $this->assignCss();
        }

        $this->assignTKD();
        return $this->fetch('widget/meta');
    }

    private function assignCssOfMobile(){
        $cssList = ['static/index/css/m_common.css'];

        switch($this->route){
            case Route::ARTICLE_LIST:
                $cssList[] = 'static/index/css/m_article_list.css';
                break;
            case Route::ARTICLE_DETAIL:
                $cssList[] = 'syntaxhighlighter/styles/shCore.css';
                $cssList[] = 'syntaxhighlighter/styles/shCoreDefault.css';
                $cssList[] = 'static/index/css/m_article_detail.css';
                break;
        }

        $this->assign('css_list', $cssList);
    }

    private function assignCss(){
        $cssList = ['static/index/css/common.css'];

        switch($this->route){
            case Route::ARTICLE_LIST:
                $cssList[] = 'static/index/css/article_list.css';
                break;
            case Route::ARTICLE_DETAIL:
                $cssList[] = 'syntaxhighlighter/styles/shCore.css';
                $cssList[] = 'syntaxhighlighter/styles/shCoreDefault.css';
                $cssList[] = 'static/index/css/article_detail.css';
                break;
        }

        $this->assign('css_list', $cssList);
    }

    private function assignTKD(){
        $title = '赖道斌的个人博客';
        $keywords = '赖道斌,PHP,WEB开发';
        $description = '赖道斌，一个WEB开发工作者，主要涉及的程序语言是PHP，同时还有涉及C/C++、Python、Java。';
        $description .= '赖道斌的个人博客，主要作为一个备忘录，记录工作学习过程中遇到的相关知识与问题。';

        switch($this->route){
            case Route::ARTICLE_LIST:
                $cateId = (int)$this->request->param()['id'];
                $cateInfo = model('Category')->get($cateId);
                if(!empty($cateInfo)){
                    $title = trim($cateInfo->title).' - '.$title;
                    $description = trim($cateInfo->description);
                }
                break;
            case Route::ARTICLE_DETAIL:
                $prodId = (int)$this->request->param()['id'];
                $prodInfo = model('Product')->get($prodId);
                if(!empty($prodInfo)){
                    $title = trim($prodInfo->title).' - '.$title;
                    $cateId = (int)$prodInfo->category_id;
                    $cateInfo = model('Category')->get($cateId);
                    $description = '';
                    if(!empty($cateInfo)){
                        $description = trim($cateInfo->title).' | ';
                    }
                    $description .= trim($prodInfo->title);
                }
                break;
        }

        $this->assign('meta', [
            'title' => $title,
            'keywords' => $keywords,
            'description' => $description
        ]);
    }
}