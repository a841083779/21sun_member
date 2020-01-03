<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%

    PoolManager pool3 = new PoolManager(3);
	
	PoolManager pool1 = new PoolManager(1);
	//=====页面属性====
	String pagename="base_info.jsp";
	String mypy="member_info";
	
	//====得到参数====	
	String mem_no ="",mem_name="";
	HashMap memberInfo = new HashMap();
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(memberInfo.get("mem_no"));    //登陆账号
		mem_name   = String.valueOf(memberInfo.get("mem_name"));  //姓名
	}	
    String tempInfo[][]=DataManager.fetchFieldValue(pool1, "member_info","top 1 id", "mem_no='"+mem_no+"'");
	String myvalue  = "";	
	String urlpath="../rent/base_info.jsp";	
 try{
	if(tempInfo!=null){ 
	   myvalue=Common.encryptionByDES(tempInfo[0][0]);
	   urlpath=urlpath+"?myvalue="+myvalue;
	}
  
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>供求发布</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

//为多选框赋值
 function submityn(){
	 if($("#zd_comp_name").val()==""){
	       alert("请输入您公司的名称！");
			$("#zd_per_email").focus();
			return false;	
	}	 
	document.theform.submit();
 }
 </script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">租赁基本资料</span></div>
	<div class="loginlist_right1">
    <table width="95%" border="0" align="center" class="tablezhuce">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
		<tr>
		    <td align="right" nowrap class="list_left_title"><strong>会员代号：</strong></td>
		    <td class="list_cell_bg">&nbsp;<%=mem_no%>&nbsp;&nbsp;&nbsp;(不可更改)</td>
		</tr>
	
		<tr>
		  	<td height="22" align="right" nowrap class="list_left_title">姓名：</td>
		 	<td height="22" class="list_cell_bg"><%=mem_name%></td>
		</tr>
		<tr>
		  <td height="22" align="right" nowrap class="list_left_title">公司名称：</td>
		  <td height="22" class="list_cell_bg"><input name="zd_comp_name" id="zd_comp_name" size="20" maxlength="20" value=""> <font color="#FF0000">*</font></td>
		</tr>
		<tr>
		  <td height="22" align="right" nowrap class="list_left_title">公司主页：</td>
		  <td height="22" class="list_cell_bg"><input name="zd_comp_url" id="zd_comp_url" size="20" maxlength="20" value=""></td>
		</tr>	
		<tr>
		  <td height="22" align="right" nowrap class="list_left_title">店铺LOGO：</td>
		  <td height="22" class="list_cell_bg"><input name="zd_rent_logo" type="text" id="zd_rent_logo"  size="50" maxlength="40">
        <input name="selectimg" type="button" style="background:#B6CFE8;border:1px solid #B8CFE0;" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=19&dir=sell_buy_market&fieldname=zd_rent_logo','upload',480,150)">
			</td>
		</tr>
		<tr>
		  <td height="22" align="right" nowrap class="list_left_title"><p>公司简介：</p>
		  <p>限500字以内</p></td>
		  <td height="22" class="list_cell_bg"><textarea name="zd_comp_intro" id="zd_comp_intro" cols="80" rows="15"  onKeyUp="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}" style="overflow-y:scroll;">
			<%//=introduction%>
		  </textarea>
		 </td>
		</tr>    	
		<tr>
		  <td height="30px" class="list_left_title" align="left" colspan="2">
		  <div align="center"><a href="#" onClick="submityn()"><img src="../images/bottom01.gif" width="91" height="38" border="0"></a>
				<input name="zd_id"       type="hidden" id="zd_id"       value="0">		
				<input name="mypy"        type="hidden" id="mypy"        value="<%=Common.encryptionByDES(mypy)%>">
				<input name="myvalue"     type="hidden" id="myvalue"     value='<%=myvalue%>'>		
				<input name="urlpath"     type="hidden" id="urlpath"     value="<%=urlpath%>">	
				<input name="zd_mem_no"   type="hidden"   id="zd_mem_no" >
			</div>		  </td>
		</tr>
     </form>	
   </table>
  </div>
</div>
<%
 
%>
  <iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
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
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
urlpath=null;
}
%>
