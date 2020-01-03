<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
 PoolManager pool1 = new PoolManager(1);
 
 //=====页面属性====
 
String myvalue  = request.getParameter("myvalue");
Connection conn = pool1.getConnection();
if (!myvalue.equals("")){  
   myvalue=Common.decryptionByDES(myvalue);
}
String sort_flag = request.getParameter("sort_flag");
String site_flag = request.getParameter("site_flag");
if (!sort_flag.equals("")){ sort_flag=Common.decryptionByDES(sort_flag);}
if (!site_flag.equals("")){ site_flag=Common.decryptionByDES(site_flag);}

int flag= 0;
String sendder_mem_name="",telephone="",email="",pubdate="",title="",content="",province="",city="",info_id="";
try{//====标题的名称====
  String sql="update member_message set is_read= isnull(is_read,0)+1 where id = "+myvalue;
  flag = DataManager.dataOperation(conn,sql);
  
  String tempInfo[][]=DataManager.fetchFieldValue(pool1, "member_message ","top 1 sender_mem_name,telephone,email,convert(varchar(10),add_date,21),title,content,province,city,info_id", " id='"+myvalue+"'");

if(tempInfo!=null){
    sendder_mem_name  = Common.getFormatStr(tempInfo[0][0]);
    telephone = Common.getFormatStr(tempInfo[0][1]); 
	email     = Common.getFormatStr(tempInfo[0][2]); 
	pubdate   = Common.getFormatStr(tempInfo[0][3]); 
	title     = Common.getFormatStr(tempInfo[0][4]);
	content   = Common.getFormatStr(tempInfo[0][5]);
	province  = Common.getFormatStr(tempInfo[0][6]);
	city      = Common.getFormatStr(tempInfo[0][7]);	
	info_id   = Common.getFormatStr(tempInfo[0][8]);
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
</head>
<body>

<div class="loginlist_right">
  <div class="loginlist_right2">
    <span class="mainyh">
			        <%
						if(site_flag.equals("5")){
					%>
						供求询价单				 
					<%
						}else if(site_flag.equals("4")){				 
					%>
						配件询价单
					<%
						}else if(site_flag.equals("2")){				 
					%>
						二手询价单
					<%
						}else if(site_flag.equals("1") ){				 
					%>
						租赁询价单
					<%}else  if(site_flag.equals("-1")){%>	
					    询价留言
					<%}%>
      </span>
  </div>
	<div class="loginlist_right1">
   <table width="95%" border="0" align="center" class="tablezhuce">
	  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
		<tr>
		  <td width="12%" align="right" nowrap class="list_left_title"><div align="left"><strong>留言人：</strong></div></td>
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
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>所在地：</strong></div></td>
		  <td class="list_cell_bg"><%=province%>-<%=city%></td>
		</tr>
	     <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>来源：</strong></div></td>
		  <td class="list_cell_bg"><a href="<%=(!info_id.equals("") && info_id.indexOf("http://")!=-1)?info_id:""%>" target="_blank">点击查看</a></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>留言时间：</strong></div></td>
		  <td class="list_cell_bg"><%=pubdate%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>留言标题：</strong></div></td>
		  <td class="list_cell_bg"><%=title%></td>
		</tr>
		 <tr>
		  <td align="right" nowrap class="list_left_title"><div align="left"><strong>留言内容：</strong></div></td>
		  <td class="list_cell_bg"><%=content%></td>
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
pool1.freeConnection(conn);
}
%>
