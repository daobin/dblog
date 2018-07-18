<?php
namespace app\index\widget;

use app\index\common\constant\Route;

class Footer extends Common {
    public function index(){
        $this->assignJs();
        return $this->fetch('widget/footer');
    }

    private function assignJs(){
        $jsList = ['static/index/js/common.js'];

        switch($this->route){
            case Route::ARTICLE_DETAIL:
                $jsList[] = 'syntaxhighlighter/scripts/shCore.js';
                $jsList[] = 'syntaxhighlighter/scripts/shBrushXml.js';
                $jsList[] = 'syntaxhighlighter/scripts/shBrushCss.js';
                $jsList[] = 'syntaxhighlighter/scripts/shBrushJScript.js';
                $jsList[] = 'syntaxhighlighter/scripts/shBrushCpp.js';
                $jsList[] = 'syntaxhighlighter/scripts/shBrushPhp.js';
                $jsList[] = 'syntaxhighlighter/scripts/shBrushPython.js';
                $jsList[] = 'syntaxhighlighter/scripts/shBrushJava.js';
                $jsList[] = 'syntaxhighlighter/scripts/shBrushSql.js';
                $jsList[] = 'static/index/js/article.js';
                break;
        }

        $this->assign('js_list', $jsList);
    }
}