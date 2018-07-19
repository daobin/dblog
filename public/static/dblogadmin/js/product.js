var Product = window.Product || {};
(function(prod){
    //保存产品
    prod.submit = true;
    prod.save = function(){
        if(prod.submit == false){
            return false;
        }

        prod.submit = false;

        $('#J-edit-form').ajaxSubmit({
            type: 'post',
            url: '/dblogadmin/product.ajax/productSave',
            dataType: 'json',
            success: function(resdata){
                alert(resdata.msg);

                if(resdata.status != 'success'){
                    prod.submit = true;
                    return false;
                }

                var href = '/dblogadmin/product.product/detail.html';
                href += '?product_id=' + resdata.product_id;
                window.location.href = href;
            }
        });

        return false;
    };
})(Product);