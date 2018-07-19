//头部导航下拉效果
$('#header .nav-bar>ul>li').hover(
	function(){
		$(this).children('a').css('background', '#333');
		$(this).children('ul').show();
	},
	function(){
		$(this).children('a').css('background', '');
		$(this).children('ul').hide();
	}
);

//只允许数字，不包括点号
$(document).on('keyup', '.dv_int', function() {
	$(this).val($(this).val().replace(/[^\d]+/g, ''));
});
