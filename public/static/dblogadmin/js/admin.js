var Admin = window.Admin || {};
(function(adm){
    //管理员编辑弹窗
    adm.adminEditBox = function(admin_id){
        $.ajax({
            type: 'post',
            url: '/dblogadmin/admin.ajax/adminEditBox',
            data: {admin_id: admin_id},
            dataType: 'json',
            success: function(resdata){
                if(resdata.status != 'success'){
                    alert(resdata.msg);
                    return false;
                }

                var dg = new Dialog();
                dg.Modal = true;
                dg.Title = '管理员编辑 -- 账号保存后不得更改';
                dg.width = 500;
                dg.Height = 200;
                dg.Top = '20%';
                dg.InnerHtml = resdata.msg;
                dg.show();
            }
        });
    };
    //管理员编辑保存
    adm.adminSubmit = true;
    adm.adminEditSave = function(){
        if(adm.adminSubmit == false){
            return false;
        }

        adm.adminSubmit = false;

        $('#J-edit-form').ajaxSubmit({
            type: 'post',
            url: '/dblogadmin/admin.ajax/adminEditSave',
            dataType: 'json',
            success: function(resdata){
                alert(resdata.msg);

                if(resdata.status != 'success'){
                    adm.adminSubmit = true;
                    return false;
                }

                window.location.reload(true);
            }
        });

        return false;
    };
    //管理员删除
    adm.adminDelete = function(admin_id){
        if(!confirm('确定要删除该管理员？')){
            return false;
        }

        $.ajax({
            type: 'post',
            url: '/dblogadmin/admin.ajax/adminDelete',
            data: {admin_id: admin_id},
            dataType: 'json',
            success: function(resdata){
                alert(resdata.msg);

                if(resdata.status != 'success'){
                    return false;
                }

                window.location.reload(true);
            }
        });
    };
})(Admin);