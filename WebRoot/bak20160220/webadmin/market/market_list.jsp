<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.util.Map.Entry"
	%><%@ include file ="../manage/config.jsp"%><%
pool = new PoolManager(5);
Connection conn =null;
String tablename="sell_buy_market";

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
	query.append(" and mem_no ='"+find_mem_no+"'");
}

 String find_mem_flag=Common.getFormatStr(request.getParameter("find_mem_flag"));
if(!find_mem_flag.equals("")){
	query.append(" and mem_flag ='"+find_mem_flag+"'");
}

String find_date_start=Common.getFormatStr(request.getParameter("find_date_start"));
if(!find_date_start.equals("")){
	query.append(" and CONVERT(varchar(12) ,pub_date, 23 ) >='"+find_date_start+"' ");
}
String find_date_end=Common.getFormatStr(request.getParameter("find_date_end"));
if(!find_date_end.equals("")){
	query.append(" and CONVERT(varchar(12) ,pub_date, 23 )<='"+find_date_end+"' ");
}

String find_category = Common.getFormatStr(request.getParameter("find_category"));
if(!find_category.equals("")){
   query.append(" and business_flag ='"+find_category+"' ");
}

String find_company =  Common.getFormatStr(request.getParameter("find_company"));
if(!find_company.equals("")){
   query.append(" and company like '%"+find_company+"%' ");
}
query.append(" order by id desc ");
//System.out.println(query);
try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
//ResultSet rs = pagination.getQueryResult(query.toString(), request,conn);
//String bar = pagination.paginationPrint();  //读取分页提示栏
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
<script  src="../scripts/calendar2.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function setFlag(flag){
		if(confirm("确定这样操作吗？")){
			document.theform.action = "tool.jsp?flag="+flag;
			document.theform.target = "hiddenFrame";
			document.theform.method = "post";
			document.theform.submit();
		}
	}
	function exportExcel(){
		if(confirm("确定导出吗？")){
			document.theform.action = "market_list_export.jsp";
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
            <td class="p94b"> <span class="title1">会员编号：
                <input name="find_mem_no" type="text" id="find_mem_no" value="<%=find_mem_no%>" size="15" maxlength="15" />
				公司名：
                <input name="find_company" type="text" id="find_company" value="<%=find_company%>" size="15" maxlength="15" />
            </span>标题：
              <input name="title" type="text" id="title" size="15" value="<%=title%>" />
			  类别：
			  <select name="find_category" id="find_category" >
			    <option value="">请选择类别</option><option value="10" <%=find_category.equals("10")?"selected":""%>>产品供应</option><option value="11" <%=find_category.equals("11")?"selected":""%>>产品求购</option><option value="12" <%=find_category.equals("12")?"selected":""%>>代理招商</option><option value="13" <%=find_category.equals("13")?"selected":""%>>寻求项目</option><option value="14" <%=find_category.equals("14")?"selected":""%>>技术转让</option>
		      </select>			 
			
			  发布时间从
	          <input name="find_date_start" type="text" id="find_date_start" size="16" value="<%=find_date_start%>" onfocus="calendarEx()"/>
          ~
          <input name="find_date_end" type="text" id="find_date_end" size="16" value="<%=find_date_end%>" onfocus="calendarEx()"/>
          <br />
          会员级别：
          <select name="find_mem_flag" id="find_mem_flag" >
            <option value="">请选择会员级别</option>
            <% for(Entry<String, String> e :  memFlaghp.entrySet()){%>
            <option value="<%=e.getKey()%>" <%=Common.getFormatStr(e.getKey()).equals(find_mem_flag)?"selected":""%>><%=e.getValue()%></option>
            <% } %>
          </select>
                <input type="submit" name="Submit" value="搜索"  />
                <input type="button" name="Submit2" value="清空"  onclick="javascript:clearForm()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" name="Submit2" value="求购信息导出"  onclick="exportExcel();" />        </td>
          </tr>
        </table>
          <table width="100%"  border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td height="15"><input type="button" name="b_add" value="增加" onclick="openWin('market_opt.jsp','sell',650,600)"/>
                <a href="http://market.21-sun.com/tools/createIndex.jsp" target="_blank">更新首页静态页数据</a>
			  </td>
            </tr>
			<tr style="padding-top:10px">
				<td>
					<input type="button" id="hot" name="hot" value="批量删除" onclick="setFlag(0);"/>
					<input type="button" id="hot" name="hot" value="设为热点" onclick="setFlag(1);"/>
					<input type="button" id="sell" name="sell" value="最新供应" onclick="setFlag(2);"/>
					<input type="button" id="buy" name="buy" value="最新求购" onclick="setFlag(3);"/>
				</td>
			</tr>
          </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
            <tr>
			  <td width="1%" height="30" align="center" bgcolor="e8f2ff">
			  	<input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			  </td>
              <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
			  <td width="8%" bgcolor="e8f2ff"><strong>类别</strong></td>
              <td width="30%" bgcolor="e8f2ff"><strong>标题</strong></td>
			  <td width="10%" bgcolor="e8f2ff"><strong>点击量</strong></td>
              <td width="10%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>发布人</strong></span></div></td>
			  <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>发布人帐号</strong></span></div></td>
			  <td width="8%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>发布时间</strong></span></div></td>
              <td width="6%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否显示</strong></span></div></td>
              <td width="14%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
            </tr>
            <tr>
              <td height="6" colspan="5"></td>
            </tr>
            <%
			 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
			 while (rs!=null && rs.next()){
			   k=k+1;
				String businessFlag = Common.getFormatStr(rs.getString("business_flag"));
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
				
				String indexFlag = Common.getFormatStr(rs.getString("posi"));
				String indexFlagStr = "无";
				if(indexFlag.equals("1")){
					indexFlagStr = "首页热点";
				}
				if(indexFlag.equals("2")){
					indexFlagStr = "最新供应";
				}
				if(indexFlag.equals("3")){
					indexFlagStr = "最新求购";
				}
				
				mem_flag = Common.getFormatStr(rs.getString("mem_flag"));
			%>
            <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
			  <td height="30" align="center">
			  	<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
			  </td>
              <td height="30" align="center"><%=k%></td>
			  <td title="点击预览"><a href="http://market.21-sun.com/viewSellBuy_for_<%=Common.getFormatStr(rs.getString("id"))%>.htm" target="_blank"><%=businessFlagStr%></a></td>
              <td title="<%=Common.getFormatStr(rs.getString("id"))%>"><a href="#" onclick="openWin('market_opt.jsp?myvalue=<%=rs.getString("id")%>','',650,600)"><%=Common.getFormatStr(rs.getString("title"))%></a><font color='#FF0000'><%if(!mem_flag.equals("-1")){out.print(Common.getFormatStr(memFlaghp.get(mem_flag)));}%></font></td>
			  <td><%=Common.getFormatStr(rs.getString("view_count")).equals("")?"0":Common.getFormatStr(rs.getString("view_count"))%></td>
			  <td><%=Common.getFormatStr(rs.getString("mem_name"))%></td>
			  <td><a href="../member/member_opt.jsp?mem_no=<%=Common.getFormatStr(rs.getString("mem_no"))%>" target="_blank" title="<%=Common.getFormatStr(rs.getString("company"))%>"><%=Common.getFormatStr(rs.getString("mem_no"))%></a></td>
			  <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date"))%></td>
              <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_show")).equals("1")?"显示":"不显示"%></span></div></td>
              <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../market/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('market_opt.jsp?myvalue=<%=rs.getString("id")%>','',650,600)">修改</a></span></div></td>
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
