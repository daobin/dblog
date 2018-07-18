<?php
namespace app\dblogadmin\controller\admin;

use app\dblogadmin\common\constant\Route;
use app\dblogadmin\controller\Common;

class Admin extends Common {
    public function index(){
        $adminList = model('Admin')->all();
        $this->assign('admin_list', $adminList);
        return $this->fetch();
    }

    /**
     * 登录页
     */
    public function login(){
        return $this->fetch();
    }

    /**
     * 登出
     */
    public function logout(){
        session('admin', null);
        $this->redirect(Route::ADMIN_LOGIN);
    }
}

