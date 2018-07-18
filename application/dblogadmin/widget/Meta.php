<?php
namespace app\dblogadmin\widget;

class Meta extends Common {
    
    public function index(){
        $this->loadCss();
        return $this->fetch('widget/meta');
    }

    private function loadCss(){
        $cssList = [
            'bootstrap/css/bootstrap.min.css',
            'static/dblogadmin/css/global.css'
        ];

        $this->assign('css_list', $cssList);
    }
}


