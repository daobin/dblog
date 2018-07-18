<?php
namespace app\common\model;

use think\Model;

class Product extends Model {
    /**
     * 分页获取商品列表
     */
    public function getByPage($condition=[], $limit=20, $order=''){
        $where = [];
        if(!empty($condition)){
            foreach($condition as $key=>$val){
                switch($key){
                    case 'status':
                        $where['status'] = (int)$val;
                        break;
                }
            }
        }

        $limit = (int)$limit;
        $order = trim($order);
        if(empty($order)){
            $order = '`product_id` desc';
        }
        $fields = 'product_id, category_id, title, description, status, image_path_file, 
        page_view, gmt_create, gmt_modify, operator';

        return $this->where($where)->field($fields)->order($order)->paginate($limit);
    }

    /**
     * 根据品类ID获取产品列表
     */
    public function getByCategoryId($categoryId, $status = null){
        $categoryId = (int)$categoryId;
        if($categoryId <= 0){
            return fasle;
        }

        $where = ['category_id' => $categoryId];
        if($status !== null){
            $where['status'] = (int)$status;
        }

        $fields = 'product_id, category_id, title, description, status, image_path_file, 
        page_view, gmt_create, gmt_modify, operator';

        return $this->where($where)->order('`sort` asc, `product_id` desc')->column($fields, 'product_id');
    }
}