<?php
namespace app\dblogadmin\controller\product;

use app\common\helper\DataVerify;

class Ajax extends \app\dblogadmin\controller\Ajax {
    /**
     * 获取子级品类
     */
    public function getChildrenOfCategory(){
        $parentId = input('post.parent_id/d', 0);
        $cateList = model('Category')->getByParentId($parentId);
        if(empty($cateList)){
            $this->jsonPrint([
                'status' => 'success',
                'msg' => ''
            ]);
        }

        $this->assign('cate_list', $cateList);
        $this->jsonPrint([
            'status' => 'success',
            'msg' => $this->fetch('get_children_of_category')
        ]);
    }

    /**
     * 品类保存
     */
    public function categorySave(){
        $cateModel = model('Category');

        $dateTime = date('Y-m-d H:i:s');
        $parentId = input('post.parent_id/d', 0);

        $title = input('post.title/s', '');
        $dataVerify = DataVerify::CategoryDataVerify($title, 'title');
        if($dataVerify['status'] != 'success'){
            $this->jsonPrint([
                'status' => 'fail',
                'msg' => trim($dataVerify['msg'])
            ]);
        }

        $imagePathFile = '';
        if(!empty($_FILES['image_path_file'])){
            $imagePathFile = DataVerify::ImageUploadDataVerify($_FILES['image_path_file'], 'category');
            if($imagePathFile['status'] != 'success'){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => trim($imagePathFile['msg'])
                ]);
            }
            $imagePathFile = trim($imagePathFile['image_src']);
        }

        $saveData = [
            'parent_id' => $parentId,
            'title' => $title,
            'description' => input('post.description/s', ''),
            'status' => input('post.status/d', 0),
            'sort' => input('post.sort/d', 0),
            'image_path_file' => $imagePathFile,
            'gmt_create' => $dateTime,
            'gmt_modify' => $dateTime,
            'operator' => trim(session('admin.account'))
        ];
        if(empty($imagePathFile)){
            unset($saveData['image_path_file']);
        }

        $cateId = input('post.category_id/d', 0);
        $idInfo = $cateModel->get($cateId);

        $titleInfo = $cateModel->getByTitle($title);
        if(!empty($idInfo)){
            if(!empty($titleInfo) && $titleInfo->category_id != $idInfo->category_id){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => '品类标题已存在，不允许重复'
                ]);
            }

            unset($saveData['gmt_create']);
        }else{
            if(!empty($titleInfo)){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => '品类标题已存在，不允许重复'
                ]);
            }
        }

        $save = false;
        if(!empty($idInfo)){
            $save = $cateModel->where('category_id', $cateId)->update($saveData);
        }else{
            $save = $cateModel->insertGetId($saveData);
            $cateId = (int)$save;
        }

        if($save){
            $this->jsonPrint([
                'status' => 'success',
                'msg' => '品类保存成功',
                'category_id' => $cateId,
                'parent_id' => $parentId
            ]);
        }

        $this->jsonPrint([
            'status' => 'fail',
            'msg' => '品类保存失败'
        ]);
    }

    /**
     * 产品保存
     */
    public function productSave(){
        $prodModel = model('Product');

        $dateTime = date('Y-m-d H:i:s');

        $title = input('post.title/s', '');
        $dataVerify = DataVerify::ProductDataVerify($title, 'title');
        if($dataVerify['status'] != 'success'){
            $this->jsonPrint([
                'status' => 'fail',
                'msg' => trim($dataVerify['msg'])
            ]);
        }

        $categoryIds = input('post.category_id/a', []);
        if(empty($categoryIds)){
            $this->jsonPrint([
                'status' => 'fail',
                'msg' => '请选择品类'
            ]);
        }

        $categoryId = 0;
        foreach($categoryIds as $cateId){
            $cateId = (int)$cateId;
            if($cateId > 0){
                $categoryId = $cateId;
            }
        }
        if($categoryId <= 0){
            $this->jsonPrint([
                'status' => 'fail',
                'msg' => '请选择品类'
            ]);
        }

        $description = input('post.description/s', '');
        $dataVerify = DataVerify::ProductDataVerify($description, 'description');
        if($dataVerify['status'] != 'success'){
            $this->jsonPrint([
                'status' => 'fail',
                'msg' => trim($dataVerify['msg'])
            ]);
        }

        $imagePathFile = '';
        if(!empty($_FILES['image_path_file'])){
            $imagePathFile = DataVerify::ImageUploadDataVerify($_FILES['image_path_file'], 'product');
            if($imagePathFile['status'] != 'success'){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => trim($imagePathFile['msg'])
                ]);
            }
            $imagePathFile = trim($imagePathFile['image_src']);
        }

        $saveData = [
            'title' => $title,
            'description' => $description,
            'category_id' => $categoryId,
            'status' => input('post.status/d', 0),
            'sort' => input('post.sort/d', 0),
            'image_path_file' => $imagePathFile,
            'gmt_create' => $dateTime,
            'gmt_modify' => $dateTime,
            'operator' => trim(session('admin.account'))
        ];
        if(empty($imagePathFile)){
            unset($saveData['image_path_file']);
        }

        $prodId = input('post.product_id/d', 0);
        $idInfo = $prodModel->get($prodId);

        $titleInfo = $prodModel->getByTitle($title);
        if(!empty($idInfo)){
            if(!empty($titleInfo) && $titleInfo->product_id != $idInfo->product_id){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => '产品标题已存在，不允许重复'
                ]);
            }

            unset($saveData['gmt_create']);
        }else{
            if(!empty($titleInfo)){
                $this->jsonPrint([
                    'status' => 'fail',
                    'msg' => '产品标题已存在，不允许重复'
                ]);
            }
        }

        $save = false;
        if(!empty($idInfo)){
            $save = $prodModel->where('product_id', $prodId)->update($saveData);
        }else{
            $save = $prodModel->insertGetId($saveData);
            $prodId = (int)$save;
        }

        if($save){
            $this->jsonPrint([
                'status' => 'success',
                'msg' => '产品保存成功',
                'product_id' => $prodId
            ]);
        }

        $this->jsonPrint([
            'status' => 'fail',
            'msg' => '产品保存失败'
        ]);
    }
}