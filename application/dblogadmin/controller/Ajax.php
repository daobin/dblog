<?php
namespace app\dblogadmin\controller;

use think\Controller;

class Ajax extends Controller {
    /**
     * 初始化
     */
    public function _initialize(){
        parent::_initialize();

        if(!$this->request->isAjax()){
            $this->jsonPrint(['status'=>'fail', 'msg'=>'资源请求无效']);
        }

        $route = $this->request->module().'/'.$this->request->controller().'/'.$this->request->action();
        if($route != 'dblogadmin/Admin.ajax/loginprocess'){
            if(!$this->chkLoginStatus()){
                $this->jsonPrint(['status'=>'fail', 'msg'=>'登录过期，请刷新页面重新登录']);
            }
        }

        $this->view->engine->layout(false);
    }

    /**
     * 检测登录状态
     * @return boolean
     */
    private function chkLoginStatus(){
        $sctime = (int)cookie('sctime');
        if(time() - $sctime > 900){
            session('admin', null);
        }else{
            cookie('sctime', time());
        }

        return (int)session('admin.admin_id') > 0;
    }

    /**
     * 以JSON的格式输出
     */
    protected function jsonPrint($data){
        header('Content-Type: application/json');
        echo json_encode($data);
        exit;
    }
}

