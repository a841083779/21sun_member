$(document).ready(function(){
	$('.pngfix').pngFix();
	$.ajaxSetup({
        type: "POST",
        dataType: "json",
        cache: false,
        timeout: 5000
	});
	$('#userinfo').click(function(){
		var _parametersStr = "{title: '用户资料管理窗口', width: 550, modal: true}";
		var _buttonsStr = "{'关 闭': function(){hideDialog();}, '更 新': function(){submitForm('updateInfo-form');}}";
		var _functionsStr = "{open: function(){$('#dialog-content').html('<div id=\"loading-msg\"><img src=\"images/ajax-loader.gif\" />加载中...</div>').load('userinfo!findUserByID.action', function(){onloadFun('updateInfo-form');});}, close: function(){}}";
		showDialog(eval('(' + _parametersStr+ ')'), eval('(' + _buttonsStr+ ')'), eval('(' + _functionsStr+ ')'));
		//alert("只是做演示，还不是我正式登场的时候，请别拼命点我！");
	});
	$('#userpwd').click(function(){
		var _parametersStr = "{title: '用户密码修改窗口', width: 320, modal: true}";
		var _buttonsStr = "{'关 闭': function(){hideDialog();}, '更 新': function(){submitForm('updatePwd-form');}}";
		var _functionsStr = "{open: function(){$('#dialog-content').html('<div id=\"loading-msg\"><img src=\"images/ajax-loader.gif\" />加载中...</div>').load('updatePwd.jsp', function(){onloadFun('updatePwd-form');});}, close: function(){}}";
		showDialog(eval('(' + _parametersStr+ ')'), eval('(' + _buttonsStr+ ')'), eval('(' + _functionsStr+ ')'));
		//alert("只是做演示，还不是我正式登场的时候，请别拼命点我！");
	});
	$('#logout').click(function(){
		$.ajax({
			url: 'users!logout.action',
			success: function(jsonData, status){
			    if(null != jsonData){
			    	if(jsonData.flag){
			    		location.href="login.jsp";
			    	}
			    }
		    }
		});
		//alert("只是做演示，还不是我正式登场的时候，请别拼命点我！");
	});
	$('.input').livequery(function(){
		$(this).niceTitle({zIndex: 9999, x: 0, y: 0, maxWidth: 140});
	});
	$('input[type="checkbox"], input[type="radio"]').livequery(function(){
		$(this).prettyCheckboxes({display: 'inline'});
	});
	$(".stripeMe tr").livequery(function(){
		$(this).mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
	});
	$(".stripeMe tr:even").livequery(function(){
		$(this).addClass("alt");
	});
});
function loadMenu(){
	$('.ui-layout-west > .content').load("menu.html", function(){
		$('.menu a').click(function(){
			//var _param = $(this).attr('params');
			//menuLink(eval('(' + _param + ')'), 1, '');
			if($(this).attr('id') == "imTest"){
				$('#data-div').html('<div id=\"loading-msg\"><img src=\"images/ajax-loader.gif\" />加载中...</div>')
				  			  .load("imTest.html", function(){
								  $('#location').text("-->我是测试例子");
				});
			}else{
				alert("抱歉！这里只是做演示，我的功能不能在此展示，请您点击“我是测试链接”查看测试例子！");
			}
		}).niceTitle();
	});
}
function showAlert(){
	alert("只是做演示，还不是我正式登场的时候，请别拼命点我！");
}