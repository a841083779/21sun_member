<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
 PoolManager pool3 = new PoolManager(3);

//=====页面属性====

String myvalue  = request.getParameter("myvalue");
Connection conn = pool3.getConnection();
if (!myvalue.equals("")){  
   myvalue=Common.decryptionByDES(myvalue);
}

String corporation="",mem_name="",telephone="",fax="",address="",email="",www="",information="",detail="",brand="",achievement="",pubdate="",title="",content="";
try{//====标题的名称====
  
String tempInfo[][]=DataManager.fetchFieldValue(pool3, "rent_company_info","top 1          comp_name,mem_name,per_phone,comp_fax,comp_address,per_email,comp_url,comp_intro", "id='"+myvalue+"'");

if(tempInfo!=null){
    corporation  = Common.getFormatStr(tempInfo[0][0]);
    mem_name     = Common.getFormatStr(tempInfo[0][1]);
    telephone    = Common.getFormatStr(tempInfo[0][2]); 
	fax          = Common.getFormatStr(tempInfo[0][3]); 
	address      = Common.getFormatStr(tempInfo[0][4]); 
	email        = Common.getFormatStr(tempInfo[0][5]);
	www          = Common.getFormatStr(tempInfo[0][6]); 
    information  = Common.getFormatStr(tempInfo[0][7]); 
	
 }

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>施工企业管理</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>


</head>
<body>

<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">施工企业管理</span></div>
	<div class="loginlist_right1">
    <table width="95%" border="0" align="center" class="tablezhuce">
	<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
		<tr>
		  <td width="16%" align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">公司名</span>称</div></td>
		  <td width="84%" class="list_cell_bg"><%=corporation%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">联系人</span></div></td>
		  <td class="list_cell_bg"><%=mem_name%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">电话</span></div></td>
		  <td class="list_cell_bg"><%=telephone%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">传真</span></div></td>
		  <td class="list_cell_bg"><%=fax%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">地址</span></div></td>
		  <td class="list_cell_bg"><%=address%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">EMAIL</span></div></td>
		  <td class="list_cell_bg"><%=email%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">网址</span></div></td>
		  <td class="list_cell_bg"><%=www%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="center"><span class="grayb">企业介绍</span></div></td>
		  <td class="list_cell_bg"><%=information%></td>
		</tr>
			
		<tr >
		  <td height="30px" class="list_left_title" align="left" colspan="2"><div align="center">
			  <input type="button" name="button1" onClick="javascrip:window.history.back(-1);" value="返回" style="cursor:hand">
		  </div></td>
		</tr>
	 </form>	
	</table>
   </div>
</div>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
pool3.freeConnection(conn);
}
%>
