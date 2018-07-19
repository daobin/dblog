var Banner = window.Banner || {};
(function(banner){
    //新增广告Banner图片
    banner.bannerImageAdd = function(){
        $.ajax({
            type: 'post',
            url: '/dblogadmin/admin.ajax/bannerImageEditBox',
            dataType: 'json',
            success: function(resdata){
                if(resdata.status != 'success'){
                    alert(resdata.msg);
                    banner.submit = true;
                    return false;
                }

                $('#J-banner-image-table').append(resdata.msg);
            }
        });

    };

    //保存广告Banner
    banner.submit = true;
    banner.bannerSave = function(){
        if(banner.submit == false){
            return false;
        }

        banner.submit = false;

        $('#J-edit-form').ajaxSubmit({
            type: 'post',
            url: '/dblogadmin/admin.ajax/bannerSave',
            dataType: 'json',
            success: function(resdata){
                alert(resdata.msg);

                if(resdata.status != 'success'){
                    banner.submit = true;
                    return false;
                }

                window.location.reload(true);
            }
        });

        return false;
    };
})(Banner);