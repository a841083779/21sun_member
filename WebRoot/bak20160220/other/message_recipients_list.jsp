<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%>
<script>
  function viewMessage(objstr,objstr1,objstr2){		    
	self.location="message_view.jsp?myvalue="+encodeURIComponent(objstr)+"&sort_flag="+encodeURIComponent(objstr1)+"&site_flag="+encodeURIComponent(objstr2);
  }
</script>
	<%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
	
String tablename="member_message";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录

String mem_no ="";
HashMap memberInfo = new HashMap();
if(session.getAttribute("memberInfo")!=null){   
	memberInfo = (HashMap) session.getAttribute("memberInfo");
	mem_no     = Common.getFormatStr(memberInfo.get("mem_no"));  //登陆账号
}
StringBuffer query =new StringBuffer("select id,title,sender_mem_name,sender_mem_no,recipients_mem_no,add_date,is_read,sort_flag ,site_flag,info_id from "+tablename+" where sort_flag=1  ");  //留言

if(!mem_no.equals("")){
	query.append(" and recipients_mem_no = '"+mem_no+"' ");
}else{
  query.append(" and recipients_mem_no='-1'");
}

String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}

//out.println(query.toString());
try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.paginationPrint();  //读取分页提示栏
String site_flag="",sort_flag="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form action="" method="get" name="theform" id="theform">
<div class="loginlist_right2">
	<span class="mainyh">
	  留言	</span>	</div>	
     <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0" class="list">
          <tr>
            <td valign="top">
			<table width="100%"  border="0" cellpadding="0" cellspacing="0"  class="list">
                <tr>
                  <td width="13%" class="title_bar">相关搜索：</td>
                <td width="87%" class="p94b">
                    标题：
                    <input name="title" type="text" id="title" size="15" value="<%=title%>">               
                    <input type="submit" name="Submit" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom06.gif) left top no-repeat;cursor: pointer;" >
                  <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onClick="javascript:clearForm()"></td>
                  
                 
                </tr>                
              </table>
              <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="15"></td>
                </tr>
              </table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="list">
                <tr>
                  <td width="5%"  height="30" bgcolor="e8f2ff"><div align="center"><strong>ID</strong></div></td>
                  <td width="25%" bgcolor="e8f2ff"><div align="center"><strong>标题(点击查看)</strong></div></td>
				  <td width="16%" bgcolor="e8f2ff"><div align="center"><strong>子站</strong></div></td>
                  <td width="17%" align="center" bgcolor="e8f2ff"><div align="center"><strong>发送时间</strong></div></td>
                  <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><strong>是否阅读</strong></div></td>
				  <!--<td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><strong>来源</strong></div></td>-->
				  <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><strong>查看联系方式</strong></div></td>				  
                  <td width="13%" align="center" bgcolor="e8f2ff"><div align="center"><strong>操作</strong></div></td>
                </tr>
                <tr>
                  <td height="6" colspan="8"></td>
                </tr>
<%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 
 String is_read="";
 while (rs!=null && rs.next()){
   k=k+1;
   
   site_flag =Common.getFormatStr(rs.getString("site_flag"));
   sort_flag =Common.getFormatStr(rs.getString("sort_flag"));
   is_read   = Common.getFormatStr(rs.getString("is_read"));

%>					
                <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
                  <td height="30"><div align="center"><%=k%></div></td>
                  <td align="center">
							<div align="center"><a href="javascript:viewMessage('<%=Common.encryptionByDES(rs.getString("id"))%>','0','0')" >
							 <%=Common.getFormatStr(rs.getString("title"))%>(<%if(sort_flag.equals("1"))out.print("留言");else if(sort_flag.equals("2"))out.print("<font color='red'>询价</font>");%>)
							</a></div>
				  </td>
				  <td align="center">
				      <div align="center"> 
						   <%
							  if(site_flag.equals("1")){
								out.println("租赁调剂");
							  }else if(site_flag.equals("2")){
								out.println("二手市场");
							  }else if(site_flag.equals("3")){
								out.println("首页留言");
							  }else if(site_flag.equals("4")){
								out.println("配件市场");
							  }else if(site_flag.equals("5")){
								out.println("供求市场");
							  }
						   %>	
				   	</div>		  	
				  </td> 			
                  <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></div></td>
                  <td align="center"><div align="center"><%=is_read.equals("0")?"<font color='red'>未阅读</font>":"已阅读"%></div></td>
				 <!--<td align="center"><div align="center">
				  <% if(!Common.getFormatStr(rs.getString("info_id")).equals("")){%>
				  <a href="<%=Common.getFormatStr(rs.getString("info_id"))%>" target="_blank">查看来源</a></div>
				  <%}else{out.print("-");}%></td>-->				  
				  <td align="center">
				    <div align="center"><a href="javascript:viewMessage('<%=Common.encryptionByDES(rs.getString("id"))%>','0','0')">点击查看</a></div>
				  </td>				  
                  <td align="center"><div align="center"><span class="p92j">
				  <a href="javascript:otherDeleteData('../other/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;</span></div></td>
                </tr>                
				 <%
					   }
				 %>
                 <tr>
                  <td height="30" colspan="8"><%=bar%></td>
                </tr>
              </table>
            </td>
            <td></td>
          </tr>
  </table>
</form>

</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
