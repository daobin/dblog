<?php
namespace app\dblogadmin\widget;

use think\Controller;

class Common extends Controller{
    /**
     * @var当前路由
     */
    public $route;
    
    public function _initialize(){
        parent::_initialize();

        //当前路由地址
        $this->route = $this->request->module().'/'.$this->request->controller().'/'.$this->request->action();

        $this->view->engine->layout(false);
    }

}


