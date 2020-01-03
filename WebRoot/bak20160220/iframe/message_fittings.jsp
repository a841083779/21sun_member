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

String store              = Common.getFormatInt(request.getParameter("store"));      //配件仓库（当为1时调用配件仓库的样式）
String is_pub ="1";
if(request.getParameter("is_pub")!=null){
	is_pub = Common.getFormatInt(request.getParameter("is_pub"));
}
String urlpath="";
urlpath="http://member.21-sun.com/iframe/message_fittings.jsp?recipients_mem_no="+java.net.URLEncoder.encode(recipients_mem_no,"UTF-8")+"&sort_flag="+sort_flag+"&site_flag="+site_flag+"&titlename="+URLEncoder.encode(String.valueOf(titlename),"utf-8")+"&store="+store;


//====得到会员的信息===
String zd_sender_mem_no   ="";
String zd_sender_mem_name ="";
String zd_telephone       ="";
String zd_email           ="";
String zd_province        ="";
String zd_city ="";
String zd_sender_comp_name="";

ArrayList userlist=Common.getMemberInfoList("mem_no,mem_name,per_phone,per_email,per_province,per_city,comp_name", pool1,request,"member_info", "mem_no","passw", "memberInfo");

if(userlist!=null&&userlist.size()==7)
{zd_sender_mem_no=Common.getFormatStr(userlist.get(0));
 zd_sender_mem_name=Common.getFormatStr(userlist.get(1));
 zd_telephone=Common.getFormatStr(userlist.get(2));
 zd_email=Common.getFormatStr(userlist.get(3));
 zd_province=Common.getFormatStr(userlist.get(4));
 zd_city=Common.getFormatStr(userlist.get(5));
 zd_sender_comp_name =Common.getFormatStr(userlist.get(6));
}
			
//System.out.println("zd_sender_mem_no:==="+zd_sender_mem_no);


String basePath = Common.getFormatStr(request.getParameter("basePath"));

//out.println("mem_no="+Common.decryptionByDES(recipients_mem_no)+"<br>");
//out.println("basePath="+Common.decryptionByDES(basePath)+"<br>");

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
<body>
<%
  if(!"".equals(titlename)){
%>
<div align="center">  
  <table border="0" cellpadding="0" cellspacing="0" width="95%" class="BIG" bgcolor="#F0F0F0">
    <tr>
      <td width="100%">&nbsp;<b><font color="#0080FF"><%=titlename.equals("")?"发送留言":titlename%></font></b></td>
    </tr>
  </table>  
</div>
<%}%>
 <form action="opt_save_update.jsp" method="post" name="theform" id="theform" onSubmit="return Validator.Validate(this,2)">
   <div align="center">
    <table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="p92 st1">
	 <tr>
	    <td width="24%" height="25" bgcolor="#FFFFFF" align="right">公司名称：<font color="#FF0000">*</font></td>
	    <td width="76%" height="25" bgcolor="#FFFFFF"><input name="zd_sender_comp_name" type="text" id="zd_sender_comp_name" value="<%=zd_sender_comp_name%>" size="30" maxlength=10 dataType="Require" msg="公司名称不能为空"></td>
      </tr>
	  <tr>
	    <td width="24%" height="25" bgcolor="#FFFFFF" align="right">联系人：<font color="#FF0000">*</font></td>
	    <td width="76%" height="25" bgcolor="#FFFFFF"><input name="zd_sender_mem_name" type="text" id="zd_sender_mem_name" value="<%=zd_sender_mem_name%>" size="30" maxlength=10 dataType="Require" msg="您的姓名不能为空">
  <input name="zd_recipients_mem_no" type="hidden" id="zd_recipients_mem_no" value="<%=recipients_mem_no%>"></td>
      </tr>
    <tr>
    <td width="24%" height="25" bgcolor="#F8F8F8" align="right">联系电话：<font color="#FF0000">*</font></td>                             
    <td width="76%" height="25" bgcolor="#F8F8F8"><input name="zd_telephone" type="text"  id="zd_telephone" value="<%=zd_telephone%>" size="30" maxlength=20 dataType="Require" msg="联系电话不能为空"></td>
    </tr>
	  <tr>
    <td width="24%" height="25" bgcolor="#F8F8F8" align="right">手机：<font color="#FF0000">*</font></td>                             
    <td width="76%" height="25" bgcolor="#F8F8F8"><input name="zd_mobile_phone" type="text"  id="zd_mobile_phone" value="" size="30" maxlength=20 dataType="Require" msg="手机不能为空"></td>
    </tr>
    <tr>
    <td width="24%" valign="top" height="25" bgcolor="#FFFFFF" align="right">邮箱地址：<font color="#FF0000">*</font></td>
    <td width="76%" height="25" bgcolor="#FFFFFF"><input name="zd_email" type="text" id="zd_email" value="<%=zd_email%>" size="30" maxlength=20 dataType="Require"  msg="邮箱地址不能为空"></td>
    </tr>
	 <tr>
    <td width="24%" valign="top" height="25" bgcolor="#FFFFFF" align="right">服务选择：<font color="#FF0000">*</font></td>
    <td width="76%" height="25" bgcolor="#FFFFFF"><input name="zd_fittings_order" type="radio" id="zd_fittings_order" value="1"><a href="http://www.21-sun.com/fittings_order/pptg.htm" target="_parent">品牌塑造解决方案</a> &nbsp;&nbsp;<input name="zd_fittings_order" type="radio" id="zd_fittings_order" value="2"><a href="http://www.21-sun.com/fittings_order/pptg.htm" target="_parent">品牌树立解决方案</a>&nbsp;&nbsp;<input name="zd_fittings_order" type="radio" id="zd_fittings_order" value="3"><a href="http://www.21-sun.com/fittings_order/pptg.htm" target="_parent">品牌提升解决方案</a>&nbsp;&nbsp;<input name="zd_fittings_order" type="radio" id="zd_fittings_order" value="4"  dataType="Group"  msg="必须选定一个服务类别" ><a href="http://www.21-sun.com/fittings_order/hyfw.htm" target="_parent">配套网会员</a></td>
    </tr>
    
    <tr>
    <td width="24%" height="27" bgcolor="#F8F8F8"></td>    
    <td width="76%" height="27" bgcolor="#F8F8F8" style="border:0;">
		<input type="submit" value="保存" name="btnok" class="p92 st2" style="cursor:pointer"> 
		<input type="reset" value="重写" name="btnclear" class="p92 st2" style="cursor:pointer">	   
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
    </tr>  
    </table>    
</div> </form>
   
	   
</body>
 <%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>