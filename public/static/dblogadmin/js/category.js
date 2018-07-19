var Category = window.Category || {};
(function(cate){
    //保存品类
    cate.submit = true;
    cate.save = function(){
        if(cate.submit == false){
            return false;
        }

        cate.submit = false;

        $('#J-edit-form').ajaxSubmit({
            type: 'post',
            url: '/dblogadmin/product.ajax/categorySave',
            dataType: 'json',
            success: function(resdata){
                alert(resdata.msg);

                if(resdata.status != 'success'){
                    cate.submit = true;
                    return false;
                }

                var href = '/dblogadmin/product.category/detail.html';
                href += '?category_id=' + resdata.category_id;
                href += '&parent_id=' + resdata.parent_id;
                window.location.href = href;
            }
        });

        return false;
    };

    //获取子级品类用于下拉框
    cate.childrenGet = true;
    cate.getChildrenToSelect = function(selectObj){
        if(cate.childrenGet != true){
            return false;
        }

        cate.childrenGet = false;
        if($('#J-loading').length > 0){
            $('#J-loading').show();
        }

        $.ajax({
            type: 'post',
            url: '/dblogadmin/product.ajax/getChildrenOfCategory',
            data: {parent_id: selectObj.val()},
            dataType: 'json',
            async: false,
            success: function(resdata){
                cate.childrenGet = true;
                if($('#J-loading').length > 0){
                    $('#J-loading').hide();
                }

                if(resdata.status != 'success'){
                    alert(resdata.msg);
                    return false;
                }

                selectObj.after(resdata.msg);
            }
        });
    };
})(Category);