<?php
namespace app\dblogadmin\widget;

use app\dblogadmin\common\constant\Route;

class Header extends Common {
    
    public function index(){
        $this->assign('account', session('admin.account'));
        $this->assign('nav_bars', $this->getNavBars());

        return $this->fetch('widget/header');
    }

    /**
     * 获取导航
     */
    private function getNavBars(){
        $navBars = [
            [
                'text' => '后台首页',
                'url' => url(Route::INDEX),
                'class' => ($this->route == Route::INDEX) ? 'active' : ''
            ],
        ];

        //产品系统
        $navBars[] = $this->getProdSysNavBars();

        //管理员系统
        $navBars[] = $this->getAdminSysNavBars();

        return $navBars;
    }

    /**
     * 获取产品系统导航
     */
    private function getProdSysNavBars(){
        return [
            'text' => '品类 & 产品',
            'url' => 'javascript:void(0);',
            'class' => (stripos($this->route, 'blogadmin/product' ) !== false) ? 'active' : '',
            'sub_navs' => [
                [
                    'text' => '品类列表',
                    'url' => url(Route::CATEGORY_LIST),
                    'class' => ''
                ],
                [
                    'text' => '产品列表',
                    'url' => url(Route::PRODUCT_LIST),
                    'class' => ''
                ]
            ]
        ];
    }

    /**
     * 获取管理员系统导航
     */
    private function getAdminSysNavBars(){
        return [
            'text' => '管理员系统',
            'url' => 'javascript:void(0);',
            'class' => (stripos($this->route, 'blogadmin/admin' ) !== false) ? 'active' : '',
            'sub_navs' => [
                [
                    'text' => '管理员',
                    'url' => url(Route::ADMIN_LIST),
                    'class' => ''
                ]
            ]
        ];
    }
}


