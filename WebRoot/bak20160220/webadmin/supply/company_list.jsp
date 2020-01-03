<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool4 = new PoolManager(1);
Connection conn =null;


//=====页面属性====
String tablename="webypage";
String pageSubName="company_add_sup.jsp";

//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
 
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");
//得到参数 测试
String corporation=Common.getFormatStr(request.getParameter("corporation"));
if(!corporation.equals("")){
	query.append(" and corporation like '%"+corporation+"%'");
}
String mid=Common.getFormatStr(request.getParameter("mid"));
if(!mid.equals("")){
    query.append(" and mid = '"+mid+"' ");
}
String mem_flag = Common.getFormatStr(request.getParameter("mem_flag"));
if(!mem_flag.equals("")){
    query.append(" and mem_flag = '"+mem_flag+"' ");
}
try{
conn = pool4.getConnection();
//SQL查询
//System.out.print(query);
ResultSet rs = pagination.getQueryResult(query.toString()+" order by id desc", request,conn,1);

//pagination.getQueryResult(query.toString(), request,conn);;//pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.paginationPrint();//读取分页提栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script>
   function sub(){
	   theform.submit();
   }
</script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->

</style>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap"><span class="title1">企业名称：
              <input name="corporation" type="text" id="corporation" value="<%=corporation%>" />&nbsp;&nbsp;&nbsp;
             用户名:
			  <input name="mid" type="text" id="mid" value="<%=mid%>" />&nbsp;&nbsp;&nbsp;
			会员级别:
			  <select name="mem_flag" id="mem_flag">
			  <option value="">--所有--</option>
          <%=Common.option_str(pool, "member_role","role_num,role_name"," 1=1 order by role_num", "",0)%>
        </select>&nbsp;&nbsp;&nbsp;
              <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit22" value="清空" onclick="javascript:clearForm()" />
              </span>
              <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td   bgcolor="e8f2ff" nowrap="nowrap" align="center"><strong>企业名称</strong></td>
            <td   bgcolor="e8f2ff" nowrap="nowrap" align="center"><strong>用户名</strong></td>
            <td   align="center" bgcolor="e8f2ff" nowrap="nowrap"><div align="center">联系人</div></td>
            <td   align="center" bgcolor="e8f2ff" nowrap="nowrap">电话</td>
            <td   align="center" bgcolor="e8f2ff" nowrap="nowrap">邮箱</td>
            <td    align="center" bgcolor="e8f2ff" nowrap="nowrap">会员级别</td>
            <td width="9%" align="center" bgcolor="e8f2ff" nowrap="nowrap"><div align="center"><span class="p92z"><strong>是否发布</strong></span></div></td>
            <td width="10%" align="center" bgcolor="e8f2ff" nowrap="nowrap"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
   String is_recom1 = Common.getFormatStr(rs.getString("mem_flag"));
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td nowrap="nowrap">
            <a href="#" onclick="openWin('<%=pageSubName%>?id=<%=rs.getString("id")%>','winsucom',800,500)">
            <%=Common.getFormatStr(rs.getString("corporation"))%>
            </a>
            </td>
            <td align="center" nowrap="nowrap"><div align="center"><a href="#" onclick="openWin('../member/member_opt.jsp?mem_no=<%=Common.getFormatStr(rs.getString("mid"))%>','',750,600)"><%=Common.getFormatStr(rs.getString("mid"))%></div></td>
            <td align="center" nowrap="nowrap"><div align="center"><%=Common.getFormatStr(rs.getString("fullname"))%></div></td>
			<td align="center" nowrap="nowrap"><div align="center">
			<%=Common.getFormatStr(rs.getString("telephone"))%>
			</div></td>
            <td align="center" nowrap="nowrap">
            <%=Common.getFormatStr(rs.getString("email"))%>
            </td>
            <td align="center"><div align="center"><span class="p92j">
            <%
			 if(is_recom1.equals("-1")){
			    out.print("普通会员");
			  }else if(is_recom1.equals("1001")){
			     out.println("VIP会员");
			  }else if(is_recom1.equals("1002")){
			    out.println("B类会员");
			  }else if(is_recom1.equals("1003")){
			    out.println("A类会员");
			  }else if(is_recom1.equals("1004")){
			    out.println("证券咨询类会员");
			  }else if(is_recom1.equals("1005")){
			    out.println("租赁通");
			  }else if(is_recom1.equals("1006")){
			    out.println("人才网会员");
			  }else if(is_recom1.equals("1007")){
			    out.println("普通二手会员");
			  }else if(is_recom1.equals("1008")){
			    out.println("高级二手会员");
			  }else if(is_recom1.equals("1009")){
			    out.println("租赁站长");
			  }else if(is_recom1.equals("1010")){
			    out.println("配件网备备通");
			  }
			  
			  
			%>
            
            </span></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("ispublished")).equals("1")?"发布":"暂缓发布"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; 
            <a href="#" onclick="openWin('<%=pageSubName%>?id=<%=rs.getString("id")%>','winsucom',800,500)">修改</a></span> &nbsp;&nbsp; </div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="6"><%=bar%></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool4.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
