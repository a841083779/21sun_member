<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Expires" CONTENT="0">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<title>会员注册</title>
<link href="style/style_si.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/common_si.js"></script>
<script type="text/javascript" src="scripts/vconf_si.js"></script>
<script type="text/javascript" src="scripts/validator_si.js"></script>
<script src="scripts/citys.js"  type="text/javascript"></script>
</head>
<body>
<div id="wrap">
  <div class="head">
    <div class="logo"></div>
    <div class="logotxt">- 注册</div>
    <div class="headlink" ><a href="#">商贸网首页</a> | <a href="#">帮助</a></div>
    <div class="clearit"></div>
  </div>
  <div class="main">
    <form method="post" id="thefrom" name="thefrom" action="member_reg_action.jsp">
      <div class="main_top">
        <ul class="step">
          <li class="step1"></li>
          <li class="steparrow"></li>
          <li class="step2_c"></li>
          <li class="steparrow"></li>
          <li class="step3"></li>
        </ul>
      </div>
      <div class="main_cen">
        <p class="title">设置安全信息<span class="title_sub orange">以下信息对保护您的帐号安全极为重要，请慎重填写并牢记</span></p>
        <ul class="maintable">
          <li>
            <div class="mt_l"><span class="red">*</span>用户名称：</div>
            <div class="mt_r" style="z-index:3;">
              <div class="inputbox"><span class="input"><cite>
                <input id="mem_no" name="mem_no" type="text" maxlength="17" alt="邮箱名:无内容/长度{4-16}/首尾不能是下划线/全部怪字符/全数字/下划线/有中文/有全角/有空格/有大写/邮箱注册排重/errArea{mem_notip}" />
                </cite></span></div>
              <span class="inputStxt" style="margin-top:1px;font-size:20px;font-weight:bold;color:red;">@21-sun.com</span>
              <input type="hidden" value="cn" name="mailType" id="mailTypeValue" />
              <span id="mem_notip"></span>
              <div class="inputtxt zi_9">4-16位之间，请用英文小写、数字、下划线，不能全部是数字或下划线。</div>
            </div>
          </li>
          <li>
            <div class="mt_l"><span class="red">*</span>登录密码：</div>
            <div class="mt_r">
              <div class="inputbox"><span class="input"><cite>
                <input id="passw" name="passw" type="password" alt="密码:无内容/有全角/有空格/怪字符pwd/长度{6-16}/下划线/有中文/判断强度/keyFn{判断强度}/focusFn{passwTip}/errArea{passwtip}" value="" />
                </cite></span></div>
              <span class="inputfloat" id="passW">
              <div class="passW" id="passW1"><span class="passW_w"></span><span class="passW_t">弱</span></div>
              <div class="passW" id="passW2"><span class="passW_w"></span><span class="passW_t">中</span></div>
              <div class="passW" id="passW3"><span class="passW_w"></span><span class="passW_t">强</span></div>
              </span> <span id="passwtip"></span>
              <div class="inputtxt zi_9">6-16位字符，可以是半角字母、数字、“.”、“-”、“?”和下划线（不能在最后）</div>
            </div>
          </li>
          <li>
            <div class="mt_l"><span class="red">*</span>再次输入密码：</div>
            <div class="mt_r">
              <div class="inputbox"><span class="input"><cite>
                <input id="passw2" name="passw2" type="password" alt="确认密码:无内容/有全角/有空格/怪字符pwd/长度{6-16}/下划线/相同{passw}/errArea{passw2tip}"  value="" />
                </cite></span></div>
              <span id="passw2tip"></span> </div>
          </li>
          <li>
            <div class="mt_l"><span class="red">*</span>密码查询问题：</div>
            <div class="mt_r">
              <div class="inputbox selectinput"> <span class="input" id="selectq"><cite> <span id="selectQtext">请选择密码查询问题</span><img src="images/arrow.gif" />
                <input id="passw_question" name="passw_question" type="hidden" alt="密码查询问题:无内容sel/errArepassw_questiontip}"  value="" />
                </cite></span> </div>
              <span id="passw_questiontip"></span> </div>
          </li>
          <li id="otherq" style="display:none;">
            <div class="mt_l"><span class="red">*</span>自定义密码查询问题：</div>
            <div class="mt_r">
              <div class="inputbox"><span class="input"><cite>
                <input id="otherQid" name="otherQid" type="text" alt="密码查询问题:无内容/长度{4-32}/全部怪字符/有全角/下划线/首尾不能是空格/数字字母中文空格下划线/errArea{otherQidtip}" value="" />
                </cite></span></div>
              <span id="otherQidtip"></span>
              <div class="inputtxt zi_9">4-32个字母（支持大小写）、数字、空格（不能在首尾）、下划线（不能在最后）或2-16个汉字</div>
            </div>
          </li>
          <li>
            <div class="mt_l"><span class="red">*</span>密码查询答案：</div>
            <div class="mt_r">
              <div class="inputbox"><span class="input"><cite>
                <input id="passw_answer" name="passw_answer" type="text" maxlength="80" alt="密码查询答案:无内容/长度{6-80}/全部怪字符/有全角/首尾不能是空格/下划线/数字字母中文空格下划线/errArepassw_answertip}" value="" />
                </cite></span></div>
              <span id="passw_answertip"></span>
              <div class="inputtxt zi_9">6-80个字符，不允许特殊字符和全角字符、空格不能在首尾、下划线不能在最后、汉字算两位</div>
            </div>
          </li>
        </ul>
        <p class="title">填写个人资料</p>
        <ul class="maintable">
          <li>
            <div class="mt_l"> <span class="red">*</span>真实姓名：</div>
            <div class="mt_r">
              <div class="inputbox"><span class="input"><cite>
                <input id="mem_name" name="mem_name" type="text" maxlength="20" alt="昵称:无内容//全数字/有全角/长度{4-20}/有大写/数字字母中文/errArea{mem_nametip}" value=""/>
                </cite></span></div>
              <span id="mem_nametip"></span>
              <div class="inputtxt zi_9">4-20位小写字母、数字或汉字（汉字算两位）组成</div>
            </div>
          </li>
		  
		  <li>
            <div class="mt_l"> <span class="red">*</span>联系邮箱：</div>
            <div class="mt_r">
              <div class="inputbox"><span class="input"><cite>
                <input id="mem_name" name="mem_name" type="text" maxlength="20" alt="昵称:无内容//全数字/有全角/长度{4-20}/有大写/数字字母中文/errArea{mem_nametip}" value=""/>
                </cite></span></div>
              <span id="mem_nametip"></span>
              <div class="inputtxt zi_9">4-20位小写字母、数字或汉字（汉字算两位）组成</div>
            </div>
          </li>
		  
		   <li>
            <div class="mt_l"> <span class="red">*</span>联系电话：</div>
            <div class="mt_r">
              <div class="inputbox"><span class="input"><cite>
                <input id="mem_name" name="mem_name" type="text" maxlength="20" alt="昵称:无内容//全数字/有全角/长度{4-20}/有大写/数字字母中文/errArea{mem_nametip}" value=""/>
                </cite></span></div>
              <span id="mem_nametip"></span>
              <div class="inputtxt zi_9">4-20位小写字母、数字或汉字（汉字算两位）组成</div>
            </div>
          </li>
		  
		  <li>
            <div class="mt_l"> <span class="red">*</span>省　市：</div>
            <div class="mt_r">
              <div class="inputbox">
                <select name="per_province" id="per_province" onchange="set_city(this,this.value,theform.per_city,'');" style="width:100px;"  class="validate-selection">
          <option value="">选择省份</option>
          <option value="北京">北京</option>
          <option value="上海">上海</option>
          <option value="天津">天津</option>
          <option value="重庆">重庆</option>
          <option value="河北">河北</option>
          <option value="山西">山西</option>
          <option value="辽宁">辽宁</option>
          <option value="吉林">吉林</option>
          <option value="黑龙江">黑龙江</option>
          <option value="江苏">江苏</option>
          <option value="浙江">浙江</option>
          <option value="安徽">安徽</option>
          <option value="福建">福建</option>
          <option value="江西">江西</option>
          <option value="山东">山东</option>
          <option value="河南">河南</option>
          <option value="湖北">湖北</option>
          <option value="湖南">湖南</option>
          <option value="广东">广东</option>
          <option value="海南">海南</option>
          <option value="四川">四川</option>
          <option value="贵州">贵州</option>
          <option value="云南">云南</option>
          <option value="陕西">陕西</option>
          <option value="甘肃">甘肃</option>
          <option value="青海">青海</option>
          <option value="内蒙古">内蒙古</option>
          <option value="广西">广西</option>
          <option value="西藏">西藏</option>
          <option value="宁夏">宁夏</option>
          <option value="新疆">新疆</option>
          <option value="台湾">台湾</option>
          <option value="香港">香港</option>
          <option value="澳门">澳门</option>
        </select>
        <select  name="per_city" id="per_city"  style="width:100px;">
          <option>选择城市</option>
        </select>
        
                </cite></span></div>
              <span id="mem_nametip"></span>
              <div class="inputtxt zi_9">4-20位小写字母、数字或汉字（汉字算两位）组成</div>
            </div>
          </li>
		  
        </ul>
        <p class="title">填写验证码</p>
        <ul class="maintable">
          <li>
            <div class="mt_l"><span class="red">*</span>验证码：</div>
            <div class="mt_r">
              <div class="inputbox"><span class="input"><cite>
                <input autocomplete="off" id="door" name="door" type="text" maxlength="10" alt="验证码:无内容/有空格/errArea{doortip}" value="" />
                </cite></span></div>
              <span id="door_img" style="display:none;"> <span><img id="check_img" src="" /></span> <span class="link"><a href="javascript:con_code();">看不清</a>？</span> </span> <span id="doortip"></span> </div>
          </li>
          <li>
            <div class="mt_l"></div>
            <div class="mt_r">
              <div class="inputacc">
                <input id="after" name="after" type="checkbox" alt="请确认您已看过并同意《中国工程机械商贸网服务条款详细内容》:条款/errArea{aftertip}" checked="checked" />
                &nbsp;我已经看过并同意《<a href="http://21-sun.com/member/registdoc.asp" target="_blank">中国工程机械商贸网服务条款详细内容</a>》</div>
              <span id="aftertip"></span> </div>
          </li>
          <li>
            <div class="mt_l"></div>
            <div class="mt_r">
              <input type="submit" class="btn_submit" value="提交" />
            </div>
          </li>
        </ul>
      </div>
      <div class="main_bottom"></div>
    </form>
  </div>
  <div class="Footer">
    <p>&nbsp;</p>
  </div>
</div>
<div id="selectQoption" class="select" style="display:none;">
  <ul>
    <li rel="我手机号码的后6位？"><a href="javascript:;" hidenfocus="true">我手机号码的后6位？</a></li>
    <li rel="我母亲的生日？"><a href="javascript:;" hidenfocus="true">我母亲的生日？</a></li>
    <li rel="我父亲的生日？"><a href="javascript:;" hidenfocus="true">我父亲的生日？</a></li>
    <li rel="我最好朋友的生日？"><a href="javascript:;" hidenfocus="true">我最好朋友的生日？</a></li>
    <li rel="我儿时居住地的地址？"><a href="javascript:;" hidenfocus="true">我儿时居住地的地址？</a></li>
    <li rel="我小学校名全称？"><a href="javascript:;" hidenfocus="true">我小学校名全称？</a></li>
    <li rel="我中学校名全称？"><a href="javascript:;" hidenfocus="true">我中学校名全称？</a></li>
    <li rel="离我家最近的医院全称？"><a href="javascript:;" hidenfocus="true">离我家最近的医院全称？</a></li>
    <li rel="离我家最近的公园全称？"><a href="javascript:;" hidenfocus="true">离我家最近的公园全称？</a></li>
    <li rel="我的座右铭是？"><a href="javascript:;" hidenfocus="true">我的座右铭是？</a></li>
    <li rel="我最喜爱的电影？"><a href="javascript:;" hidenfocus="true">我最喜爱的电影？</a></li>
    <li rel="我最喜爱的歌曲？"><a href="javascript:;" hidenfocus="true">我最喜爱的歌曲？</a></li>
    <li rel="我最喜爱的食物？"><a href="javascript:;" hidenfocus="true">我最喜爱的食物？</a></li>
    <li rel="我最大的爱好？"><a href="javascript:;" hidenfocus="true">我最大的爱好？</a></li>
    <li rel="我最喜欢的小说？"><a href="javascript:;" hidenfocus="true">我最喜欢的小说？</a></li>
    <li rel="我最喜欢的运动队？"><a href="javascript:;" hidenfocus="true">我最喜欢的运动队？</a></li>
    <li rel="其他"><a href="javascript:;" hidenfocus="true">其他</a></li>
  </ul>
  <div class="selebottom"></div>
</div>
<script type="text/javascript">
function con_code() {
	$("check_img").src = '/auth/authImgServlet?now=' + new Date();
}
function showPwdA(node) {
	var option = $("selectQoption");
	option.style.left = getLeft(node) + "px";
	option.style.top = getTop(node) + node.offsetHeight + "px";
	option.style.display = "";
}
function initSelect() {
	var selectq = $("selectq");
	selectq.onclick = function() {
		showPwdA(this);
	};
	var otherQid = $("otherQid");
	var selectQid = $("selectQid");
	var selectQtext = $("selectQtext");
	var selectQoption = $("selectQoption");
	var ops = selectQoption.getElementsByTagName("li");
	var n = ops.length;
	for (var i=0;i<n;i++) {
		var currNode = ops[i];
		currNode.onclick = function(e) {
			var rel = this.getAttribute("rel") + "";
			selectQid.value = rel;
			selectQtext.innerHTML = rel;
			selectQoption.style.display = "none";
			if (rel == "其他") {
				$show($("otherq"));
				otherQid.value = "";
				$("otherQidtip").innerHTML = "";
				try {
				//	v.setState(otherQid, 0);
				}catch (e) {}
			}else {
				$hide($("otherq"));
			}
			if (e) {
				e.stopPropagation();
			}else {
				window.event.cancelBubble = true;
			}
		};
	}
	$addEvent2(document, function(e){
		e = e || window.event;
		var source = e.target || e.srcElement;
		if (!selectq.contains(source)) selectQoption.style.display = "none";
	});
	selectQtext.innerHTML = (selectQid.value == "") ? "请选择密码查询问题" : selectQid.value;
	if (selectQtext.innerHTML == "其他") $show($("otherq"));
	else $hide($("otherq"));
}
onReady(function(){
	var conf = (typeof $vconf == 'undefined') ? {} : $vconf;
	var v = new Validator(conf);
	v.init('thefrom');
	initSelect();
	window["v"] = v;
});
</script>
</body>
</html>
