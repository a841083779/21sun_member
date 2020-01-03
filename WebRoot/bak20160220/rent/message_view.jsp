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
int flag= 0;
String fullname="",telephone="",email="",pubdate="",title="",content="";
try{//====标题的名称====
  String sql="update rent_message set isread= isread+1 where id = "+myvalue;

  flag = DataManager.dataOperation(conn,sql);
  
String tempInfo[][]=DataManager.fetchFieldValue(pool3, "rent_message","top 1 fullname,telephone,email,convert(varchar(10),pubdate,21),title,content ", " id='"+myvalue+"'");


if(tempInfo!=null){
    fullname  = Common.getFormatStr(tempInfo[0][0]);
    telephone = Common.getFormatStr(tempInfo[0][1]); 
	email     = Common.getFormatStr(tempInfo[0][2]); 
	pubdate   = Common.getFormatStr(tempInfo[0][3]); 
	title     = Common.getFormatStr(tempInfo[0][4]);
	content   = Common.getFormatStr(tempInfo[0][5]);
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>供求发布</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />


</head>
<body>

  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15"></td>
    </tr>
  </table>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="3%" class="p982"><img src="../images/bibi11.gif" width="19" height="19"></td>
      <td width="83%" class="p982">
	  		留言信息
	  </td>
      <td width="14%" class="p982"></td>
    </tr>
</table>
  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15"></td>
    </tr>
  </table>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
    <tr>
      <td width="12%" align="right" nowrap class="list_left_title"><div align="center">留言人</div></td>
      <td width="88%" class="list_cell_bg"><%=fullname%></td>
    </tr>
	 <tr>
      <td align="right" nowrap class="list_left_title"><div align="center">电话</div></td>
      <td class="list_cell_bg"><%=telephone%></td>
    </tr>
	 <tr>
      <td align="right" nowrap class="list_left_title"><div align="center">EMAIL</div></td>
      <td class="list_cell_bg"><%=email%></td>
    </tr>
	 <tr>
      <td align="right" nowrap class="list_left_title"><div align="center">留言时间</div></td>
      <td class="list_cell_bg"><%=pubdate%></td>
    </tr>
	 <tr>
      <td align="right" nowrap class="list_left_title"><div align="center">留言标题</div></td>
      <td class="list_cell_bg"><%=title%></td>
    </tr>
	 <tr>
      <td align="right" nowrap class="list_left_title"><div align="center">留言内容</div></td>
      <td class="list_cell_bg"><%=content%></td>
    </tr>
    	
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="center">
	      <input type="button" name="button1" onClick="javascrip:window.history.back(-1);" value="返回" style="cursor:hand">
      </div></td>
    </tr>
</form>	
</table>
  <table width="98%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="10"></td>
    </tr>
  </table>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
pool3.freeConnection(conn);
}
%>
