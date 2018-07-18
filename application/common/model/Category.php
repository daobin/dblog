<?php
namespace app\common\model;

use think\Model;

class Category extends Model {
    /**
     * @var 品类层级
     */
    public static $levels;

    /**
     * 根据子级品类ID，获取所有父级品类
     */
    public static function getParentsByChildrenId($childrenId, $init=true){
        if($init === true || empty(self::$levels)){
            self::$levels = [];
        }

        $childrenId = (int)$childrenId;
        if($childrenId <= 0){
            return false;
        }

        $cateInfo = self::get($childrenId);
        if(empty($cateInfo)){
            return false;
        }


        array_unshift(self::$levels, $cateInfo->toArray());
        self::getParentsByChildrenId($cateInfo->parent_id, false);
    }

    /**
     * 根据父级品类ID，获取子级品类
     */
    public function getByParentId($parentId, $status = null){
        $fields = 'category_id, parent_id, title, status, sort, image_path_file, gmt_modify, operator';
        $where = ['parent_id' => (int)$parentId];
        if($status !== null){
            $where['status'] = (int)$status;
        }

        return $this->where($where)->order('`sort` asc, `category_id` asc')
            ->column($fields, 'category_id');
    }
}