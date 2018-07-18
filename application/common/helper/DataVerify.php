<?php
namespace app\common\helper;

/**
 * 数据验证帮助类
 * User: Daobin.Lai
 * Date: 2017/7/18
 * Time: 10:59
 */

class DataVerify {
    /**
     * 上传图片数据验证
     */
    public static function ImageUploadDataVerify($uploadImage, $dataType){;
        $dataType = trim($dataType);
        if(empty($uploadImage) || empty($dataType)){
            return [
                'status' => 'fail',
                'msg' => '上传图片数据无效'
                ];
        }

        $imageUploadPath = ROOT_PATH.'upload/'.$dataType.'/'.date('Ymd').'/';
        if(!is_dir($imageUploadPath)){
            $dirMk = mkdir($imageUploadPath, 0755, true);
            if(empty($dirMk)){
                return [
                    'status' => 'fail',
                    'msg' => '没有图片上传路径权限'
                ];
            }
        }

        if(preg_replace('/[\w\.\-_]+/', '', $uploadImage['name']) != ''){
            return [
                'status' => 'fail',
                'msg' => '为确保图片能被正确访问，图片名称只允许字母、数字、中横线、下划线'
            ];
        }

        if(!in_array(strtolower($uploadImage['type']), ['image/jpeg', 'image/png'])){
            return [
                'status' => 'fail',
                'msg' => '图片文件[ '.$uploadImage['name'].' ]格式错误，只允许".jpg", ".jpeg", ".png"'
            ];
        }
        if($uploadImage['size'] > 1024*1024*5){
            return [
                'status' => 'fail',
                'msg' => '图片文件[ '.$uploadImage['name'].' ]过大'
            ];
        }
        if($uploadImage['error'] > 0){
            return [
                'status' => 'fail',
                'msg' => '图片文件[ '.$uploadImage['name'].' ]上传错误'.$uploadImage['error']
            ];
        }

        $move = move_uploaded_file($uploadImage['tmp_name'], $imageUploadPath.$uploadImage['name']);
        if(empty($move)){
            return [
                'status' => 'fail',
                'msg' => '图片文件[ '.$uploadImage['name'].' ]上传失败'
            ];
        }

        return [
            'status' => 'success',
            'image_src' => str_replace(ROOT_PATH, '/', $imageUploadPath.$uploadImage['name'])
        ];
    }

    /**
     * 管理员数据验证
     */
    public static function AdminDataVerify($value, $type){
        $value = trim($value);
        $type = trim($type);

        $errMsg = '';
        switch($type){
            case 'account':
                if($value == ''){
                    $errMsg = '账号不能为空';
                    break;
                }
                if(preg_replace('/[\x{4E00}-\x{9FA5}]+/u', '', $value) != ''){
                    $errMsg = '账号只允许为中文';
                    break;
                }

                if(mb_strlen($value, 'UTF-8') > 10){
                    $errMsg = '账号长度最大允许10个字符';
                    break;
                }

                break;
            case 'password':
                if($value == ''){
                    $errMsg = '密码不能为空';
                    break;
                }

                if(mb_strlen($value, 'UTF-8') < 6 || mb_strlen($value, 'UTF-8') > 30){
                    $errMsg = '密码长度只允许6-30个字符';
                    break;
                }

                //密码强度
                $strong = 0;
                if(preg_match('/[0-9]+/', $value)){
                    $strong++;
                }
                if(preg_match('/[a-z]+/', $value)){
                    if(strpos($value, '_') !== false){
                        $strong++;
                    }
                    $strong++;
                }
                if(preg_match('/[A-Z]+/', $value)){
                    if(strpos($value, '_') !== false){
                        $strong++;
                    }
                    $strong++;
                }
                if(preg_match('/[^0-9a-zA-z]+/', $value)){
                    $strong++;
                }
                if($strong < 3){
                    $errMsg = '密码至少要包含大写字母、小写字母、数字、符号中的三种';
                    $errMsg .= '，并且同种字符不允许连续出现超过三个长度';
                }

                if(preg_match('/[0-9]{4}/', $value) || preg_match('/[a-z]{4}/', $value)
                || preg_match('/[A-Z]{4}/', $value) || preg_match('/[^0-9a-zA-z]{4}/', $value)){
                    $errMsg = '密码至少要包含大写字母、小写字母、数字、符号中的三种';
                    $errMsg .= '，并且同种字符不允许连续出现超过三个长度';
                }

                break;
            default:
                break;
        }

        if(empty($errMsg)){
            return ['status'=>'success', 'msg'=>''];
        }

        return [
            'status' => 'fail',
            'msg' => $errMsg
        ];
    }

    /**
     * 品类数据验证
     */
    public static function CategoryDataVerify($value, $type){
        $value = trim($value);
        $type = trim($type);

        $errMsg = '';
        switch($type){
            case 'title':
                if($value == ''){
                    $errMsg = '品类标题不能为空';
                    break;
                }
                break;
            default:
                break;
        }

        if(empty($errMsg)){
            return ['status'=>'success', 'msg'=>''];
        }

        return [
            'status' => 'fail',
            'msg' => $errMsg
        ];
    }

    /**
     * 产品数据验证
     */
    public static function ProductDataVerify($value, $type){
        $value = trim($value);
        $type = trim($type);

        $errMsg = '';
        switch($type){
            case 'title':
                if($value == ''){
                    $errMsg = '产品标题不能为空';
                    break;
                }
                break;
            case 'description':
                if($value == ''){
                    $errMsg = '产品描述不能为空';
                    break;
                }
                break;
            default:
                break;
        }

        if(empty($errMsg)){
            return ['status'=>'success', 'msg'=>''];
        }

        return [
            'status' => 'fail',
            'msg' => $errMsg
        ];
    }
}

