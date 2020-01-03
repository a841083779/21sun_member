<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%
pool = new PoolManager(9);
//=====页面属性====
String pagename="subscribe_opt.jsp";
String mypy="fittings_subscribe";
String titlename="";
//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));
String urlpath="subscribe_opt.jsp";

if(!myvalue.equals("")){
    urlpath=urlpath+"?myvalue="+java.net.URLEncoder.encode(myvalue,"UTF-8");  
   //需要编码 才能将加密后产生的特殊字符 例如：将 +  转码成 %2B
}

String  mem_no ="";
HashMap memberInfo = new HashMap();
if(session.getAttribute("memberInfo")!=null){   
   memberInfo = (HashMap) session.getAttribute("memberInfo");
   mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号   
}
String[][] tempInfo = DataManager.fetchFieldValue(pool, mypy,"count(*)", " mem_no='"+usern+"' ");
String pubCount   = "0";
if(tempInfo!=null) {
  pubCount=Common.getFormatInt(tempInfo[0][0]);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<style type="text/css">
	input.moren{vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial;float:left;margin:0;border:1px solid #B8CFE0;color:#676767;background:#F7FBFF;}
</style>
<script>
 var pubCount=0;
 function onloadAjax(){
		$.ajax({
		type: "POST",
		url: "../manage/countpub.jsp",
		data: "tablename=<%=mypy%>&poolnum=9&mem_no=<%=mem_no%>",
		success: function(msg){ 
		      	pubCount = $.trim(msg);	
				document.getElementById("spanPubCount").innerText=pubCount;
				if(pubCount>=5){	
					document.getElementById("submitId").disabled=true;				
					alert("您今天已发布了"+pubCount+"条配套件代理招商信息，已经达到最大发布数,自动跳转至列表页！");
					window.location.href="subscribe_list.jsp";
				}
			} 
		}); 
	}
//为多选框赋值
function submityn(){	
	var pubCount = "<%=pubCount%>";	
	if(pubCount>=5){
	  alert("很抱歉，您已创建了"+pubCount+"个订阅器，已经达到最大数！");   
	  return false; 
	}	
	if(document.theform.zd_email.value==""){
		alert("请输入邮箱接收地址！");
		document.theform.zd_email.focus();
		return false;
	}	
	document.theform.submit();
}
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">创建订阅器</span>&nbsp;&nbsp;<strong style="cursor:pointer;"> <a href="subscribe_list.jsp">>>返回</a></strong></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b><strong>"创建订阅器"</strong>后可及时收到系统发送的符合订阅条件的求购信息的邮件;共可创建<strong><font color="#FF0000">5</font></strong>个订阅器，您已经创建了<strong><font color="#FF0000"><%=pubCount%></font></strong>个;
          <!--每天发布信息量最多只可以发布<font color="red"><b>30</b></font>条，-->
          <!--您今天已经发布了<font color="green"><b><span id="spanPubCount"></span></b></font>条。--></td>
      </tr>
    </table>
    <table width="95%" border="0" align="center" class="tablezhuce">
      <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
        <tr>
          <td nowrap="nowrap"  class="right"> <span class="grayb">订阅关键词：</span></td>
          <td ><input name="zd_keyword" type="text" id="zd_keyword" maxlength="50" size="75" class="moren"></td>
        </tr>
		<tr>
          <td  class="right" nowrap="nowrap" > <span class="grayb">信息类型：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="info_type1" name="zd_info_type" value="配套件" style="border:0"; onclick="showTr();"/>
            配套件
            <input type="radio" id="info_type2" name="zd_info_type" value="原料" style="border:0"; onclick="showTr();"/>
            原料
            <input type="radio" id="info_type3" name="zd_info_type" value="加工设备" style="border:0"; onclick="showTr();" />
            加工设备
            <input type="radio" id="info_type4" name="zd_info_type" value="其它" style="border:0"; onclick="showTr();" />
            其它 </td>
        </tr>
		<tr>
          <td  class="right"nowrap="nowrap"> <span class="grayb">所属类别：</span></td>
          <td height="22" class="list_cell_bg">
		  	<input type="radio" id="part_sort1" name="zd_part_sort" value="10" /style="border:0";>
            结构件
            <input type="radio" id="part_sort2" name="zd_part_sort" value="11" style="border:0";/>
            液压系统
            <input type="radio" id="part_sort3" name="zd_part_sort" value="12" style="border:0";/>
            传动系统
            <input type="radio" id="part_sort4" name="zd_part_sort" value="13" style="border:0";/>
            动力系统
            <input type="radio" id="part_sort5" name="zd_part_sort" value="14" style="border:0";/>
            电气系统<br />
			<input type="radio" id="part_sort6" name="zd_part_sort" value="15" style="border:0";/>
            覆盖件（钣金件）
			<input type="radio" id="part_sort7" name="zd_part_sort" value="16" style="border:0";/>
            精加工件
			<input type="radio" id="part_sort8" name="zd_part_sort" value="17" style="border:0";/>
            特殊工作装置
			<input type="radio" id="part_sort9" name="zd_part_sort" value="18" style="border:0";/>
            辅料及其他
		  </td>
        </tr>
        <tr>
          <td class="right" nowrap="nowrap" > <span class="grayb">省　　市：</span></td>
          <td height="22" ><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:100px;"  class="blue1">
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
            <select  name="zd_city" id="zd_city"  style="width:100px;" class="blue1">
              <option>选择城市</option>
            </select>
          </td>
        </tr>
        <tr>
          <td nowrap="nowrap"  class="right"><span class="red">*</span> <span class="grayb">邮箱接收地址：</span></td>
          <td ><input name="zd_email" type="text" id="zd_email" maxlength="100" size="75" class="moren"></td>
        </tr>
        <tr>
          <td  class="right" nowrap="nowrap" ><span class="grayb">订阅状态：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_show1" name="zd_is_show" value="1" checked="checked" style="border:0";/>
            订阅
            <input type="radio" id="zd_is_show2" name="zd_is_show" value="0" style="border:0";/>
            暂不订阅 </td>
        </tr>
		<!--
        <tr>
          <td  class="right" nowrap="nowrap"><span class="grayb">验 证 码：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="rand" name="rand" value="" size="20" maxlength="10"/>
            &nbsp;<img height="19px" src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/> </td>
        </tr>
		-->
        <tr>
          <td nowrap="nowrap" class="right">&nbsp;</td>
          <td class="right"><input id="submitId" type="button" name="Submit" value="发 布" class="tijiao" style="cursor:pointer"  onClick="submityn()"/></td>
        </tr>
        <input name="zd_id" type="hidden" id="zd_id" value="0" />
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
        <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
        <input name="randflag" type="hidden" id="randflag" value="1" />
		<input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
        <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=Common.getFormatStr((String)adminInfo.get("mem_no"))%>" />
	 </form>
    </table>
  </div>
</div>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script language="javascript">
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
//refresh();

function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!myvalue.equals("")){
	out.print("set_formxx(\""+Common.decryptionByDES(myvalue)+"\");");
}
%>
</script>
<script  language="javascript">
function f_frameStyleResize(targObj)   
{   
  var   targWin   =   targObj.parent.document.all[targObj.name]; 
  if(targWin   !=   null)   
  {   
  var   HeightValue   =   targObj.document.body.scrollHeight   
  if(HeightValue   <100){HeightValue   =490}   //不小于540  
   targWin.height   =   HeightValue;
  }   
}  
function   f_iframeResize()   
{
  f_frameStyleResize(self);
}  
window.onload=f_iframeResize;
//onloadAjax();
 </script>
</body>
</html>
