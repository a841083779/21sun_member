<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%
pool = new PoolManager(9);
//=====页面属性====
String pagename="supply_opt.jsp";
String mypy="fittings_business_info";
String titlename="";
//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
//flag 1:配套合作;2:代理招商;3:求购信息;4:供应信息
String flag=Common.getFormatInt(request.getParameter("flag"));
if(flag.equals("0")){
	flag = "4";
}
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));
String urlpath="supply_opt.jsp";

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
				if(pubCount>=30){	
					document.getElementById("submitId").disabled=true;				
					alert("您今天已发布了"+pubCount+"条供应信息，已经达到最大发布数,自动跳转至列表页！");
					window.location.href="agent_list.jsp";
				}
			} 
		}); 
	}
//为多选框赋值
function submityn(){
	    //if(pubCount>=30){
		//  alert("您今天已发布了"+pubCount+"条配套合作信息，已经达到最大发布数！");   
		//  return false; 
		//}	
			
		if(theform.zd_title.value==""){
			alert("请输入标题！");
			theform.zd_title.focus();
			return false;
		}else if(theform.zd_province.value==""){
			alert("请选择省份！");
			theform.zd_province.focus();
			return false;
		}else if(theform.zd_city.value==""){
			alert("请选择城市！");
			theform.zd_city.focus();
			return false;
		}else if(returnRadio("zd_info_type")==false){
			alert("请选择信息类别！");
			return false;			
		}else if(theform.zd_describ.value==""){
			alert("请输入详情，内容控制在300个汉字以内！");
			theform.zd_describ.focus();
			return false;
		}//else if(theform.rand.value==""){
			//alert("验证码不能为空！");
			//theform.rand.focus();
			//return false;
		//}
			
		document.theform.submit();
}
function showTr(){
	var obj = document.getElementsByName("zd_info_type");
	if(document.getElementById("partSortTr")!=null){
		if(obj!=null && obj[0]!=null && obj[0].checked){
			document.getElementById("partSortTr").style.display = "block";
		}else{
			document.getElementById("partSortTr").style.display = "none";
		}
	}
}
</script>
</head>
<body>
<div class="loginlist_right" style="height:520px">
  <div class="loginlist_right2"><span class="mainyh">发布配套件供应信息</span>&nbsp;&nbsp;<strong style="cursor:pointer;"> <a href="supply_list.jsp">>>返回</a></strong></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。<span class="red">*</span> 为必填项<br />
          <!--每天发布信息量最多只可以发布<font color="red"><b>30</b></font>条，-->
          <!--您今天已经发布了<font color="green"><b><span id="spanPubCount"></span></b></font>条。--></td>
      </tr>
    </table>
    <table width="95%" border="0" align="center" class="tablezhuce">
      <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
        <tr>
          <td nowrap="nowrap"  class="right"><span class="red">*</span> <span class="grayb">标　　题：</span></td>
          <td ><input name="zd_title" type="text" id="zd_title" maxlength="100" size="75" class="moren"></td>
        </tr>
        <tr>
          <td nowrap="nowrap"  class="right"><span class="grayb">销售价格：</span></td>
          <td ><input name="zd_price" type="text" id="zd_price" maxlength="50" size="25" class="moren"></td>
        </tr>
        <tr>
          <td class="right" nowrap="nowrap" ><span class="red">*</span> <span class="grayb">发 货 地：</span></td>
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
          <td  class="right" nowrap="nowrap" ><span class="red">*</span> <span class="grayb">信息类型：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="info_type1" name="zd_info_type" value="配套件" style="border:0"; onclick="showTr();"/>
            配套件
            <input type="radio" id="info_type2" name="zd_info_type" value="原料" style="border:0"; onclick="showTr();"/>
            原料
            <input type="radio" id="info_type3" name="zd_info_type" value="加工设备" style="border:0"; onclick="showTr();" />
            加工设备
            <input type="radio" id="info_type4" name="zd_info_type" value="其它" style="border:0"; onclick="showTr();" />
            其它 </td>
        </tr>
        <tr id="partSortTr">
          <td  class="right"nowrap="nowrap"><span class="red">*</span> <span class="grayb">所属类别：</span></td>
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
          <td class="right" nowrap="nowrap" ><span class="grayb">图　　片：</span></td>
          <td ><input name="zd_img" id="zd_img" type="hidden" value="" />
            <span id="txt_zd_img"></span><span  id="ifr_zd_img">
            <iframe id="ifr2_zd_img" scrolling="no" frameborder="0" width="100%" height="28" src="http://resource.21-sun.com/web_upload_files_for_sigle.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=27&dir=fittings&fieldname=zd_img" ></iframe>
            </span><br />
            注：图片最大不超过200K </td>
        </tr>
        <tr>
          <td  class="right" nowrap="nowrap" ><span class="grayb">是否发布：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_show1" name="zd_is_show" value="1" checked="checked" style="border:0";/>
            发布
            <input type="radio" id="zd_is_show2" name="zd_is_show" value="0" style="border:0";/>
            暂停 </td>
        </tr>
        <tr>
          <td class="right" nowrap="nowrap" ><span class="red">*</span> <span class="grayb">详　　情：</span></td>
          <td height="22" class="list_cell_bg"><textarea name="zd_describ" cols="60" rows="6" id="zd_describ" onKeyUp="if((this.value).length&gt;300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}" style="overflow-y:scroll;"
></textarea></td>
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
        <input name="zd_update_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
        <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
        <input name="randflag" type="hidden" id="randflag" value="1" />
        <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=Common.getFormatStr((String)adminInfo.get("mem_no"))%>" />
        <input name="zd_flag" type="hidden" id="zd_flag" value="<%=flag%>" />
        <input name="zd_no" type="hidden" id="zd_no" value="<%=Common.generateDateRandom()%>" />
		<input name="zd_qq" type="hidden" id="zd_qq" value="<%=Common.getFormatStr((String)adminInfo.get("per_qq"))%>" />
		<input name="zd_company" type="hidden" id="zd_company" value="<%=Common.getFormatStr((String)adminInfo.get("comp_name"))%>" />
		<input name="zd_tel" type="hidden" id="zd_tel" value="<%=Common.getFormatStr((String)adminInfo.get("per_phone"))%>" />
		<input name="zd_url" type="hidden" id="zd_url" value="<%=Common.getFormatStr((String)adminInfo.get("comp_url"))%>" />
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