<?php
namespace app\index\widget;

use think\Controller;

class Common extends Controller {
    /**
     * @var 当前路由
     */
    public $route;

    /**
     * @var 当前设备
     */
    public $equipment;

    /**
     * 初始化方法
     */
    public function _initialize(){
        parent::_initialize();
        $this->view->engine->layout(false);
        $this->route = $this->request->module().'/'.$this->request->controller().'/'.$this->request->action();

        $this->equipment = 'pc';
        $agent = trim($_SERVER['HTTP_USER_AGENT']);
        if(stripos($agent, 'iphone') !== false
            || stripos($agent, 'ipad') !== false
            || stripos($agent, 'android') !== false){
            $this->equipment = 'mobile';
        }
    }
}