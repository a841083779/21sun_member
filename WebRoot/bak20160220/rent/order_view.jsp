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
String sendder_mem_name="",telephone="",email="",pubdate="",title="",content="",equipment_id="";
try{  
  String tempInfo[][]=DataManager.fetchFieldValue(pool3, "equipment_bom ","top 1 order_mem_name,telephone,email,convert(varchar(10),add_date,21),title,content,equipment_id", " id='"+myvalue+"'");

if(tempInfo!=null){
    sendder_mem_name  = Common.getFormatStr(tempInfo[0][0]);
    telephone = Common.getFormatStr(tempInfo[0][1]); 
	email     = Common.getFormatStr(tempInfo[0][2]); 
	pubdate   = Common.getFormatStr(tempInfo[0][3]); 
	title     = Common.getFormatStr(tempInfo[0][4]);
	content   = Common.getFormatStr(tempInfo[0][5]);
	equipment_id= Common.getFormatStr(tempInfo[0][6]);
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>租赁设备订单</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
</head>
<body>

<div class="loginlist_right">
  <div class="loginlist_right2">
    <span class="mainyh">
      </span>
  </div>
	<div class="loginlist_right1">
   <table width="95%" border="0" align="center" class="tablezhuce">
	  <form action="../other/opt_save_update.jsp" method="post" name="theform" id="theform">
		<tr>
		  <td width="12%" align="right" nowrap class="list_left_title"><div align="left"><strong>订购人：</strong></div></td>
		  <td width="88%" class="list_cell_bg"><%=sendder_mem_name%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>电话：</strong></div></td>
		  <td class="list_cell_bg"><%=telephone%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>EMAIL：</strong></div></td>
		  <td class="list_cell_bg"><%=email%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>订购时间：</strong></div></td>
		  <td class="list_cell_bg"><%=pubdate%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>订购标题：</strong></div></td>
		  <td class="list_cell_bg"><%=title%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>订购内容：</strong></div></td>
		  <td class="list_cell_bg"><%=content%></td>
		</tr>
		 <tr>
		   <td align="right" nowrap class="list_left_title">&nbsp;</td>
		   <td class="list_cell_bg"><a href="http://www.21-rent.com/equipment/detail_for_<%=equipment_id%>.htm" target="_blank"><font color="#FF0000">租赁设备详情</font></a></td>
	    </tr>
		 <tr >
		  <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" id="button1" name="button1" value="返回" class="tijiao" style="cursor:pointer"  onClick="javascrip:window.history.back(-1);"/>
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
