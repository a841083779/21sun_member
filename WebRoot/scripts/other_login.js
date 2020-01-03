function oauthLogin(id)
{
	//以下为按钮点击事件的逻辑。注意这里要重新打开窗口，窗口的大小需要固定
	//否则后面跳转到QQ登录，授权页面时会直接缩小当前浏览器的窗口，而不是打开新窗口
	var left,top;
	if(id==2){var w=650;h=360;left=50;top=100;} // sina 
	if(id==4){var w=570;h=460;left=10;top=50;}  // qq
	var A=window.open("http://member.21-sun.com/openplatform/?to="+id+"&do=login&go=http://member.21-sun.com/","WinLogin",
	"width="+w+",height="+h+",left="+parseInt((screen.availWidth -  w)/2-left)+",top="+parseInt((screen.availHeight - h)/2-top)+",menubar=0,scrollbars=0,resizable=1,status=0,titlebar=0,toolbar=0,location=0");
}
jQuery(function(){
	jQuery("#loginOther").hover(function(){
		jQuery(this).toggleClass("bit_hover");
	},function(){
		jQuery(this).removeClass("bit_hover");
	});
})