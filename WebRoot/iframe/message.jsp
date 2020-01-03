<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%
PoolManager pool1 = new PoolManager(1);
//=====页面属性====
	
String pagename="message.jsp";
String mypy="member_message";
//====得到参数====
String recipients_mem_no  = Common.decryptionByDES(Common.getFormatStr(request.getParameter("recipients_mem_no")));
String sort_flag          = Common.getFormatStr(request.getParameter("sort_flag"));
String site_flag          = Common.getFormatStr(request.getParameter("site_flag"));
String titlename          = Common.getFormatStr(request.getParameter("titlename"));
String psid               = Common.getFormatInt(request.getParameter("psid"));      //配件供应（留言次数）
String ptype              = Common.getFormatStr(request.getParameter("ptype"));     //配件类别 buy-->求购
String zd_content = Common.getFormatStr(request.getParameter("zd_content"));
String store              = Common.getFormatInt(request.getParameter("store"));      //配件仓库（当为1时调用配件仓库的样式）
String is_pub ="1";
if(request.getParameter("is_pub")!=null){
	is_pub = Common.getFormatInt(request.getParameter("is_pub"));
}
String urlpath="";
urlpath="http://member.21-sun.com/iframe/message.jsp?recipients_mem_no="+java.net.URLEncoder.encode(recipients_mem_no,"UTF-8")+"&sort_flag="+sort_flag+"&site_flag="+site_flag+"&titlename="+URLEncoder.encode(String.valueOf(titlename),"utf-8")+"&store="+store;


//====得到会员的信息===
String zd_sender_mem_no   ="";
String zd_sender_mem_name ="";
String zd_telephone       ="";
String zd_email           ="";
String zd_province        ="";
String zd_city ="";
String is_close = Common.getFormatStr(request.getParameter("is_close"));
if("true".equals(is_close)){
	is_close = request.getHeader("Referer");
}

ArrayList userlist=Common.getMemberInfoList("mem_no,mem_name,per_phone,per_email,per_province,per_city", pool1,request,"member_info", "mem_no","passw", "memberInfo");

if(userlist!=null&&userlist.size()==6)
{zd_sender_mem_no=Common.getFormatStr(userlist.get(0));
 zd_sender_mem_name=Common.getFormatStr(userlist.get(1));
 zd_telephone=Common.getFormatStr(userlist.get(2));
 zd_email=Common.getFormatStr(userlist.get(3));
 zd_province=Common.getFormatStr(userlist.get(4));
 zd_city=Common.getFormatStr(userlist.get(5));
}
			
//System.out.println("zd_sender_mem_no:==="+zd_sender_mem_no);
String basePath = Common.getFormatStr(request.getParameter("basePath"));

//out.println("mem_no="+Common.decryptionByDES(recipients_mem_no)+"<br>");
//out.println("basePath="+Common.decryptionByDES(basePath)+"<br>");

String ip = request.getHeader("x-forwarded-for");  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("Proxy-Client-IP");  
}  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("WL-Proxy-Client-IP");  
}  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getRemoteAddr();  
}

try{   //====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=titlename%></title>
<link rel="stylesheet" href="../style/<%=store.equals("1")?"store.css":"homestyle.css"%>" type="text/css">
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/Validator.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>

<script>
	function submityn(){
		if($("#zd_title").val()==""){
				alert("请输入标题！");
				$("#zd_title").focus();
				return false;
		}	
		document.theform.submit();
	}
</script>
</head>
<body style="overflow: hidden;">
<%
  if(!"".equals(titlename)){
%>
<div align="center">  
  <table border="0" cellpadding="0" cellspacing="0" width="98%" class="BIG" bgcolor="#F0F0F0" style="margin:10px 10px">
    <tr>
      <td width="100%" align="left">&nbsp;<b><font color="#0080FF"><%=titlename.equals("")?"发送留言":titlename%></font></b></td>
    </tr>
  </table>  
</div>
<%}%>
 <form action="opt_save_update.jsp" method="post" name="theform" id="theform" onSubmit="return Validator.Validate(this,2)">
   <div align="center">
    <table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="p92 st1">
	  <tr>
	    <td width="24%" height="25" bgcolor="#FFFFFF" align="right">您的姓名：<font color="#FF0000">*</font></td>
	    <td width="76%" height="25" bgcolor="#FFFFFF" align="left"><input name="zd_sender_mem_name" type="text" id="zd_sender_mem_name" value="<%=zd_sender_mem_name%>" size="30" maxlength=10 dataType="Require" msg="您的姓名不能为空">
  <input name="zd_recipients_mem_no" type="hidden" id="zd_recipients_mem_no" value="<%=recipients_mem_no%>"></td>
      </tr>
    <tr>
    <td width="24%" height="25" bgcolor="#F8F8F8" align="right">联系电话：<font color="#FF0000">*</font></td>                             
    <td width="76%" height="25" bgcolor="#F8F8F8" align="left"><input name="zd_telephone" type="text"  id="zd_telephone" value="<%=zd_telephone%>" size="30" maxlength=20 dataType="Require" msg="联系电话不能为空">
    [网上不公开显示]</td>
    </tr>
    <tr>
    <td width="24%" valign="top" height="25" bgcolor="#FFFFFF" align="right">邮箱地址：&nbsp;</td>
    <td width="76%" height="25" bgcolor="#FFFFFF" align="left"><input name="zd_email" type="text" id="zd_email" value="<%=zd_email%>" size="30" maxlength=20 />
    [网上不公开显示]</td>
    </tr>
	  
	 <tr>
    <td width="24%" valign="top" height="25" bgcolor="#F8F8F8" align="right">所 在 地：<font color="#FF0000">*</font></td>
    <td width="76%" height="25" bgcolor="#F8F8F8" align="left">
		<select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:100px;"  class="validate-selection" dataType="Require"  msg="所在省份不能为空">
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
        <select  name="zd_city" id="zd_city"  style="width:100px;" dataType="Require"  msg="所在城市不能为空">
          <option value="">选择城市</option>
        </select>
	</td>
    </tr>
	
    <tr>
    <td width="24%" valign="top" height="13" bgcolor="#FFFFFF" align="right">留言主题：<font color="#FF0000">*</font></td>
    <td width="76%" height="13" bgcolor="#FFFFFF" align="left"><input name="zd_title" type="text" id="zd_title" value="" size="40" maxlength=30 dataType="Require" msg="留言主题不能为空"></td>
    </tr>
    <tr>
    <td width="24%" height="130" bgcolor="#F8F8F8">
      <p align="right">留言内容：<font color="#FF0000">*<br>
      </font><nobr>(不要超过200字)</nobr></p>
    </td>      
    <td width="76%" height="130" bgcolor="#F8F8F8" align="left"><textarea name="zd_content" cols="40" rows="6" class="p92" id="zd_content" maxlength=500 dataType="Require" msg="留言内容不能为空" onKeyUp="if((this.value).length&gt;300){ this.value=(this.value).substr(0,300);alert('留言内容已超出最大字数！');}"><%=zd_content %></textarea></td>
     </tr>	 
	<tr>
	   <td width="24%" height="37" bgcolor="#FFFFFF">
	    <p align="right">请输入验证码：</p></td>
		<td width="76%" height="37" bgcolor="#FFFFFF" align="left"><input type="text" id="rand" name="rand" value="" size="10" maxlength="20" class="moren" dataType="Require"  msg="验证码不能为空"/>
		<img src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</tr>
    <tr>
    <td width="24%" height="27" bgcolor="#F8F8F8" style="border-bottom: none;"></td>    
    <td width="76%" height="27" bgcolor="#F8F8F8" style="border:0;" align="left">
		<input type="submit" value="提交" name="btnok" class="p92 st2" style="cursor:pointer"> 
		<!-- <input type="reset" value="重写" name="btnclear" class="p92 st2" style="cursor:pointer"> -->	   
		<input name="zd_id" type="hidden" id="zd_id" value="0">
		<input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">	
		<input name="zd_sender_mem_no" type="hidden" id="zd_sender_mem_no" value="<%=zd_sender_mem_no%>">
		<input name="zd_add_user" type="hidden" id="zd_add_user" value="<%=zd_sender_mem_no%>">
		<input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">	
		<input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
		<input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
		<input name="zd_is_pub" type="hidden" id="zd_is_pub" value="<%=is_pub%>">
		<input name="zd_is_read" type="hidden" id="zd_is_read" value="0">
		<input name="zd_sort_flag" type="hidden"  id="zd_sort_flag" value="<%=sort_flag%>">
		<input name="zd_site_flag" type="hidden"  id="zd_site_flag" value="<%=site_flag%>">
		<input name="zd_info_id"   type="hidden"  id="zd_info_id"   value="<%=Common.decryptionByDES(basePath)%>">
		<input name="titlename" type="hidden"  id="titlename"   value="<%=titlename%>">
		<input name="psid"   type="hidden" id="psid" value="<%=psid%>">
		<input name="ptype"   type="hidden" id="ptype" value="<%=ptype%>">
		<input name="tip_success" type="hidden" value="您的留言已成功发送！" />
		<input name="is_close" type="hidden" value="<%=is_close %>" />
    </tr>  
    </table>    
</div> </form>
   
	<script language="javascript">		
		function refresh(){
		document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
		}
		refresh();
	    set_province(document.getElementById('zd_province'),'<%=zd_province%>');
		set_city(document.getElementById('zd_province'),'<%=zd_province%>',theform.zd_city,'<%=zd_city%>');	
		 function set_province(obj,objvalue){
		   obj.value=objvalue;				  
		 }	
	</script>
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/ecmascript"></script>
<script type="text/javascript">
	function getIpPlace() {
		document.getElementById("zd_province").value = remote_ip_info["province"];
		set_city(document.getElementById("zd_province"),document.getElementById("zd_province").value,document.theform.zd_city,'');
		for(var i=0;i<document.getElementById("zd_city").options.length;i++){
			var city=document.getElementById("zd_city").options[i].value;
			if(city.indexOf(remote_ip_info["city"])>-1){
				document.getElementById("zd_city").options[i].selected=true;
            	break;
			}
		}
	} 
	getIpPlace();
</script> 
	 
</body>
 <%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>