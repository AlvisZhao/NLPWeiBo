$(function(){
	
	init();
	$(window).resize(function(){
		init();
	});
	
	//菜单
	$(".menuFA").click(function(){
		menuFAClick($(this));
	});
	$(".menuFA").mouseenter(function(){
		menuFAMouseenter($(this));
	});
	$(".menuFA").mouseleave(function(){
		menuFAMouseleave($(this));
	});
	
})

function menuFAMouseenter(_this){
	_this.animate({
	    borderWidth:'7px'
	},200);
}

function menuFAMouseleave(_this){
	_this.animate({
	    borderWidth:'0px'
	},200);
}

function menuFAClick(_this){
	var dl = _this.siblings("dl");
	var bgColor = "#FFF";
	if(dl.length > 0){
		if(dl.css("display") == "none"){    
			dl.show();
			_this.find(".right").attr("class","iconfont icon-arrow-down right");
			bgColor = "#FFF";  /*选中背景色*/
		}else{
			dl.hide();
			_this.find(".right").attr("class","iconfont icon-dajiantouyou right");
			bgColor = "transparent";
		}
	}
	_this.css("background-color",bgColor);
	_this.parent().siblings().find("dl").hide();
	_this.parent().siblings().find("a.menuFA").css("background-color","transparent"); /*选中时，其他背景色*/
}

//二级菜单点击后的处理方法
function menuCAClick(url,_this){
	
	//处理frameMain url地址
	$("#mainIframe").attr("src",url);
	
	//处理frameMain title名称变化
	if($(_this).find("i").attr("class") == "iconfont icon-yonghu1"){
		$("#frameMainTitle span").html('<i class="iconfont icon-xianshiqi"></i>个人资料');
		return;
	}
	if($(_this).text() == "修改密码"){
		$("#frameMainTitle span").html('<i class="iconfont icon-xianshiqi"></i>'+$(_this).text());
		return;
	}
	if($(_this).attr("class") == "menuFA"){
		$("#frameMainTitle span").html('<i class="iconfont icon-xianshiqi"></i>'+$(_this).text());
	}else{
		//显示父菜单
//		$("#frameMainTitle span").html('<i class="iconfont icon-xianshiqi"></i>'+$(_this).parent().parent().siblings(".menuFA").text());
		//显示子菜单
		$("#frameMainTitle span").html('<i class="iconfont icon-xianshiqi"></i>'+$(_this).text());
	}
	
	//处理菜单样式变化
	
	$(_this).css("cssText", "background-color:#5A7CC1 !important;").css("color","#000000");  /*选中背景色*/
	$(_this).parent().parent().siblings().find("a").css("cssText", "background-color:#F7F7F7").css("color","#000000");   /*子目录文字颜色*/
	$(_this).parent().siblings().find("a").css("cssText", "background-color:transparent").css("color","#000000");
	$(_this).parent().parent().parent().siblings().find("dl dt a").css("cssText", "background-color:transparent").css("color","#000000")  /*子目录2*/
	
}

//初始化页面
function init(){
	var win_h = $(window).height();
	var win_w = $(window).width();
	var frameMenuW = $(".frameMenu").width();
	var logoH = 110;
	var frameTopH = $(".frameTop").height();
	
	$(".frameMenu").height(win_h);
	$(".frameMenu .menu").height(win_h - logoH);
	$(".main").width(win_w - frameMenuW).height(win_h);
	$(".frameMain").height(win_h - frameTopH);
	$(".frameMain .con").height(win_h - frameTopH - 40);
	$(".frameMain .con iframe").height(win_h - frameTopH - 40);
	
	//自定义滚动条
	$(".menu").mCustomScrollbar();
}
