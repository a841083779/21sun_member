<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.util.Map.Entry"
	%><%@ include file ="../manage/config.jsp"%><%
pool = new PoolManager(5);
Connection conn =null;
String tablename="question";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录

String mem_flag="";
HashMap<String,String> memFlaghp = new HashMap<String,String>();
memFlaghp.put("-1","普通会员");
memFlaghp.put("1001","VIP会员");
memFlaghp.put("1002","B类会员");
memFlaghp.put("1003","A类会员");
memFlaghp.put("1004","证券咨询类会员");
memFlaghp.put("1005","租赁通(3500)");
memFlaghp.put("1006","人才网会员");
memFlaghp.put("1007","普通二手会员");
memFlaghp.put("1008","高级二手会员");
memFlaghp.put("1009","租赁站长");
memFlaghp.put("1010","配件网备备通");
memFlaghp.put("1011","配件网专卖店");
memFlaghp.put("1012","配套网会员");

String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1  ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}
 String find_mem_no=Common.getFormatStr(request.getParameter("find_mem_no"));
if(!find_mem_no.equals("")){
	query.append(" and mem_no like'%"+find_mem_no+"%'");
}


String find_date_start=Common.getFormatStr(request.getParameter("find_date_start"));
if(!find_date_start.equals("")){
	query.append(" and CONVERT(varchar(12) ,add_date, 23 ) >='"+find_date_start+"' ");
}
String find_date_end=Common.getFormatStr(request.getParameter("find_date_end"));
if(!find_date_end.equals("")){
	query.append(" and CONVERT(varchar(12) ,add_date, 23 )<='"+find_date_end+"' ");
}

String find_category = Common.getFormatStr(request.getParameter("find_category"));

String find_company =  Common.getFormatStr(request.getParameter("find_company"));
if(!find_company.equals("")){
   query.append(" and company like '%"+find_company+"%' ");
}
query.append(" order by id desc ");
try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
String bar = pagination.pagesPrint(10); //读取分页提栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function setFlag(flag){
		if(confirm("确定这样操作吗？")){
			document.theform.action = "question_tool.jsp?flag="+flag;
			document.theform.target = "hiddenFrame";
			document.theform.method = "post";
			document.theform.submit();
		}
	}
</script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style></head>
<body>
<form action="" method="get" name="theform" id="theform">
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td class="p94b"> <span class="title1">添加人：
                <input name="find_mem_no" type="text" id="find_mem_no" value="<%=find_mem_no%>" size="15" maxlength="15" />
			
			  添加时间从
	          <input name="find_date_start" type="text" id="find_date_start" size="12" value="<%=find_date_start%>" onfocus="calendar(event)"/>
          ~
          <input name="find_date_end" type="text" id="find_date_end" size="12" value="<%=find_date_end%>" onfocus="calendar(event)"/>
               &nbsp;&nbsp; <input type="submit" name="Submit" value="搜索"  />
                <input type="button" name="Submit2" value="清空"  onclick="javascript:clearForm()" />             </td>
          </tr>
        </table>
          <table width="100%"  border="0" cellpadding="0" cellspacing="0">
			<tr style="padding-top:10px">
				<td>
					<input type="button" id="hot" name="hot" value="批量删除" onclick="setFlag(0);"/>
				</td>
			</tr>
          </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
            <tr>
			  <td width="1%" height="30" align="center" bgcolor="e8f2ff">
			  	<input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			  </td>
              <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
			  <td width="8%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>添加时间</strong></span></div></td>
                <td width="8%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>添加者</strong></span></div></td>
               <td width="8%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>电话</strong></span></div></td>
              <td width="14%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
            </tr>
            <tr>
              <td height="6" colspan="5"></td>
            </tr>
            <%
			 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
			 while (rs!=null && rs.next()){
			   k=k+1;
				String businessFlag = Common.getFormatStr(rs.getString("catalog_no"));
				String businessFlagStr = "";
				
				if(businessFlag.equals("10")){
					businessFlagStr = "产品供应";
				}
				if(businessFlag.equals("11")){
					businessFlagStr = "产品求购";
				}
				if(businessFlag.equals("12")){
					businessFlagStr = "代理招商";
				}
				if(businessFlag.equals("13")){
					businessFlagStr = "寻求项目";
				}
				if(businessFlag.equals("14")){
					businessFlagStr = "技术转让";
				}
			%>
            <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
			  <td height="30" align="center">
			  	<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
			  </td>
              <td height="30" align="center"><%=k%></td>
			  <td align="center"><%=Common.getFormatStr(rs.getString("add_date")).split(" ")[0]%></td>
			  <td align="center"><%=Common.getFormatStr(rs.getString("mem_name"))%></td>
              <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("tel"))%></span></div></td>
              <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../market/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('question_opt.jsp?myvalue=<%=rs.getString("id")%>','',650,420)">查看</a></span></div></td>
            </tr>
            <%
}
%>
            <tr >
            <td height="30" colspan="5"><%=bar%></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<iframe name="hiddenFrame" style="display:none"></iframe>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
