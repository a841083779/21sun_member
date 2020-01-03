<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
 PoolManager pool1 = new PoolManager(1);

//=====页面属性====
String myvalue  = request.getParameter("myvalue");
String urlpath="../rent/rent_member_view.jsp?myvalue="+myvalue;
String corporation="",mem_name="",telephone="",fax="",address="",email="",www="",regi_date="",comp_intro="";
try{//====标题的名称====
  
String tempInfo[][]=DataManager.fetchFieldValue(pool1, "member_info","top 1 comp_name,mem_name,per_phone,comp_fax,comp_address,per_email,comp_url,left(convert(varchar(20),regi_date,21),10),comp_intro ", "id='"+myvalue+"'");

if(tempInfo!=null){
    corporation  = Common.getFormatStr(tempInfo[0][0]);
    mem_name     = Common.getFormatStr(tempInfo[0][1]);
    telephone    = Common.getFormatStr(tempInfo[0][2]); 
	fax          = Common.getFormatStr(tempInfo[0][3]); 
	address      = Common.getFormatStr(tempInfo[0][4]); 
	email        = Common.getFormatStr(tempInfo[0][5]);
	www          = Common.getFormatStr(tempInfo[0][6]);
	regi_date    = Common.getFormatStr(tempInfo[0][7]);
	comp_intro = Common.getFormatStr(tempInfo[0][8]);
 }

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>站内注册会员</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>

</head>
<body>

<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">站内注册会员</span></div>
	<div class="loginlist_right1">
    <table width="95%" border="0" align="center" class="tablezhuce">
		<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
			<tr>
			  <td width="16%" align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">公司名称</span></div></td>
			  <td width="84%" class="list_cell_bg">
			  	<input type="text" name="zd_comp_name" id="zd_comp_name" value="<%=corporation%>" />
			  </td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">联系人</span></div></td>
			  <td class="list_cell_bg"><input type="text" name="zd_mem_name" id="zd_mem_name" value="<%=mem_name%>" /></td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">电话</span></div></td>
			  <td class="list_cell_bg"><input type="text" name="zd_per_phone" id="zd_per_phone" value="<%=telephone%>" /></td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">传真</span></div></td>
			  <td class="list_cell_bg">
			  	<input type="text" name="zd_comp_fax" id="zd_comp_fax" value="<%=fax%>" />
			  </td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">地址</span></div></td>
			  <td class="list_cell_bg">
			  	<input type="text" name="zd_comp_address" id="zd_comp_address" value="<%=address%>" />
			 </td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">EMAIL</span></div></td>
			  <td class="list_cell_bg">
			  	<input type="text" name="zd_per_email" id="zd_per_email" value="<%=email%>" />
			  </td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">网址</span></div></td>
			  <td class="list_cell_bg">
			  	<input type="text" name="zd_comp_url" id="zd_comp_url" value="<%=www%>" />
			  </td>
			</tr>    	
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">公司介绍</span></div></td>
			  <td class="list_cell_bg">
			  	<textarea name="zd_comp_intro" style="width: 300px; height: 100px;" id="zd_comp_intro"><%=comp_intro %></textarea>
			  </td>
			</tr>    	
			<tr >
			  <td height="30px" class="list_left_title" align="left" colspan="2">
			  <div align="center">
			  		<input type="submit" name="button2" value="提交" style="cursor:hand" />
				 	 <input type="button" name="button1" onClick="javascrip:window.history.back(-1);" value="返回" style="cursor:hand" />
			  </div>
			  </td>
			</tr>
		
    </table>
    <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES("member_info")%>">
    <input name="zd_id" type="hidden" id="zd_id" value="<%=myvalue %>">
    <input name="urlpath" type="hidden" id="urlpath"     value="<%=urlpath%>">
    </form>	
   </div>
</div>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{

}
%>
