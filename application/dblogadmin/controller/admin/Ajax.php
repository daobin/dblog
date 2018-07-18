<?php
namespace app\dblogadmin\controller\admin;

use app\common\helper\DataVerify;

class Ajax extends \app\dblogadmin\controller\Ajax {
    /**
     * 登录处理
     */
    public function loginProcess(){
        $account = input('post.account/s', '');
        $password = input('post.password/s', '');
        $captcha = input('post.captcha/s', '');

        if($account == ''){
            $this->jsonPrint(['status'=>'fail', 'msg'=>'请输入登录账号']);
        }

        if($password == ''){
            $this->jsonPrint(['status'=>'fail', 'msg'=>'请输入登录密码']);
        }

        if($captcha == ''){
            $this->jsonPrint(['status'=>'fail', 'msg'=>'请输入验证编码']);
        }

        $adminInfo = model('Admin')->getByAccount($account);
        if(empty($adminInfo)){
            $this->jsonPrint(['status'=>'fail', 'msg'=>'登录账号密码不匹配']);
        }

        if(!password_verify($password, $adminInfo->password)){
            $this->jsonPrint(['status'=>'fail', 'msg'=>'登录账号密码不匹配']);
        }

        if(!captcha_check($captcha)){
            $this->jsonPrint(['status'=>'fail', 'msg'=>'验证编码错误']);
        }

        session('admin.admin_id', $adminInfo->admin_id);
        session('admin.account', $adminInfo->account);

        cookie('sctime', time());

        $this->jsonPrint(['status'=>'success', 'msg'=>'登录成功']);
    }

    /**
     * 管理员编辑弹窗
     */
    public function adminEditBox(){
        $adminId = input('post.admin_id/d', 0);
        $this->assign('admin_info', model('Admin')->get($adminId));
        $this->jsonPrint([
            'status' => 'success',
            'msg' => $this->fetch('admin_edit_box')
        ]);
    }

    /**
     * 管理员编辑保存
     */
    public function adminEditSave(){
        $save = false;
        $dateTime = date('Y-m-d H:i:s');

        $adminId = input('post.admin_id/d', 0);
        $password = input('post.password/s', '');

        $idInfo = model('Admin')->get($adminId);
        if(empty($idInfo)){
            $account = input('post.account/s', '');
            $dataVerify = DataVerify::AdminDataVerify($account, 'account');
            if($dataVerify['status'] != 'success'){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => trim($dataVerify['msg'])
                ]);
            }

            $accountInfo = model('Admin')->getByAccount($account);
            if(!empty($accountInfo)){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => '账号已经存在，不允许重复'
                ]);
            }

            $dataVerify = DataVerify::AdminDataVerify($password, 'password');
            if($dataVerify['status'] != 'success'){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => trim($dataVerify['msg'])
                ]);
            }

            $save = model('Admin')->insert([
                'account' => $account,
                'password' => password_hash($password, PASSWORD_DEFAULT),
                'gmt_create' => $dateTime,
                'gmt_modify' => $dateTime,
                'operator' => trim(session('admin.account'))
            ]);
        }else{
            $data = [
                'gmt_modify' => $dateTime,
                'operator' => trim(session('admin.account'))
            ];
            if($password != ''){
                $dataVerify = DataVerify::AdminDataVerify($password, 'password');
                if($dataVerify['status'] != 'success'){
                    $this->jsonPrint([
                        'status' => 'fail',
                        'msg' => trim($dataVerify['msg'])
                    ]);
                }

                $data['password'] = password_hash($password, PASSWORD_DEFAULT);
            }
            $save = model('Admin')->save($data, [
                'admin_id' => $adminId
            ]);
        }

        if(!empty($save)){
            $this->jsonPrint([
                'status' => 'success',
                'msg' => '管理员编辑成功'
            ]);
        }

        $this->jsonPrint([
            'status' => 'fail',
            'msg' => '管理员编辑失败'
        ]);
    }

    /**
     * 管理员删除
     */
    public function adminDelete(){
        $adminId = input('post.admin_id/d', 0);
        if(in_array($adminId, [1, 2])){
            $this->jsonPrint([
                'status' => 'fail',
                'msg' => '该管理员不允许删除'
            ]);
        }

        $delete = model('Admin')->where('admin_id', $adminId)->delete();
        if(!empty($delete)){
            $this->jsonPrint([
                'status' => 'success',
                'msg' => '管理员删除成功'
            ]);
        }

        $this->jsonPrint([
            'status' => 'fail',
            'msg' => '管理员删除失败'
        ]);
    }
}

