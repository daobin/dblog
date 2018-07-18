<?php
namespace app\dblogadmin\controller;

use app\dblogadmin\common\constant\Route;
use think\Controller;

class Common extends Controller {
    /**
     * 初始化
     */
    public function _initialize(){
        parent::_initialize();

        $route = $this->request->module().'/'.$this->request->controller().'/'.$this->request->action();
        $route = strtolower($route);
        if(in_array($route, [Route::ADMIN_LOGIN, Route::ADMIN_LOGOUT])){
            $this->view->engine->layout(false);
        }else{
            $sctime = (int)cookie('sctime');
            if(time() - $sctime > 900){
                session('admin', null);
            }else{
                cookie('sctime', time());
            }

            if((int)session('admin.admin_id') <= 0){
                session('admin', null);
                $this->redirect(Route::ADMIN_LOGIN);
            }
        }

        if($route == Route::ADMIN_LOGIN && (int)session('admin.admin_id') > 0){
            $this->redirect(Route::INDEX);
        }
    }
}


