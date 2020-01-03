<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
	
String tablename="member_info";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" ");

query = query.append(" where 1=1 ");
//得到参数
String mem_no=Common.getFormatStr(request.getParameter("mem_no"));
if(!mem_no.equals("")){
	query.append(" and (mem_no like '"+mem_no+"%' or mem_name like '"+mem_no+"%' or comp_name like '"+mem_no+"%' ) ");
}

String db2id=Common.getFormatInt(request.getParameter("db2id"));
if(!db2id.equals("0")){
	query.append(" and db2id='"+db2id+"' ");
}
//===会员专卖店查询=====
String find_mem_flag=Common.getFormatStr(request.getParameter("find_mem_flag"));
if(!find_mem_flag.equals("")){
	query.append(" and mem_flag='"+find_mem_flag+"' ");
}

String find_state=Common.getFormatStr(request.getParameter("find_state"));
if(!find_state.equals("")){
	query.append(" and state ='"+find_state+"' ");
}


String find_parts_brand=Common.getFormatStr(request.getParameter("find_parts_brand"));
if(!find_parts_brand.equals("")){
	query.append(" and parts_brand like '%"+find_parts_brand+"%' ");
}

String find_mem_flag_enddate=Common.getFormatStr(request.getParameter("find_mem_flag_enddate"));
if(!find_mem_flag_enddate.equals("")){
	query.append(" and mem_flag_enddate <='"+find_mem_flag_enddate+"' ");
}

String find_regi_date_start=Common.getFormatStr(request.getParameter("find_regi_date_start"));
if(!find_regi_date_start.equals("")){
	query.append(" and regi_date >='"+find_regi_date_start+"' ");
}
String find_regi_date_end=Common.getFormatStr(request.getParameter("find_regi_date_end"));
if(!find_regi_date_end.equals("")){
	query.append(" and regi_date<='"+find_regi_date_end+"' ");
}
%>
<cache:cache cron="*/59 * * * *">
<%

try{
conn = pool.getConnection();
//SQL查询
ResultSet rs = pagination.getQueryResult(query.toString()+" order by id desc", request,conn,1);
String bar = pagination.paginationPrint();  //读取分页提示栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>市场人员会员管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>

<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style></head>
<body><%//=query.toString()+" order by id desc"%>
<form action="" method="get" name="theform" id="theform">
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="1%" class="title_bar">&nbsp;</td>
        <td width="81%" class="p94b"> 会员名(公司名称)：
          <input name="mem_no" type="text" id="mem_no" size="15" value="<%=mem_no%>" />
db2ID
<input name="db2id" type="text" id="db2id" size="10" value="<%=(!db2id.equals("0")?db2id:"")%>" />
品牌查询：
<select name="find_parts_brand" id="find_parts_brand">
  <option value="">--请选择--</option>
  <option value="recom" <%if(find_parts_brand.equals("recom"))out.print("selected");%>>特别推荐</option>
  <option value="other" <%if(find_parts_brand.equals("other"))out.print("selected");%>>其它品牌</option>
  <option value="sanling" <%if(find_parts_brand.equals("sanling"))out.print("selected");%>>三菱</option>
  <option value="pojinsi" <%if(find_parts_brand.equals("pojinsi"))out.print("selected");%>>珀金斯</option>
  <option value="kangmingsi" <%if(find_parts_brand.equals("kangmingsi"))out.print("selected");%>>康明斯</option>
<%=Common.option_str(pool, "vi_othercall_product","distinct factoryid,factoryname","", find_parts_brand,0)%>
</select>
到期日期
<input name="find_mem_flag_enddate" type="text" id="find_mem_flag_enddate" size="15" value="<%=find_mem_flag_enddate%>" onfocus="calendar(event)"/></td>
        <td width="18%" class="p94b"><input type="submit" name="Submit" value="搜索" />
          <input type="button" name="Submit2" value="清除" onclick="javascript:clearForm()" /></td>
      </tr>
      <tr>
        <td class="title_bar">&nbsp;</td>
        <td class="p94b"><select name="find_state" id="find_state">
          <option value="">--状态--</option>
          <option value="0" <%if(find_state.equals("0"))out.print("selected");%>>禁用</option>
          <option value="1" <%if(find_state.equals("1"))out.print("selected");%>>正常</option>
          </select>
          <select name="find_mem_flag" id="find_mem_flag">
            <option value="">--会员级别--</option>
            <%=Common.option_str(pool, "member_role","role_num,role_name"," 1=1 order by role_num", find_mem_flag,0)%>
           </select>
          注册时间：
          <input name="find_regi_date_start" type="text" id="find_regi_date_start" size="15" value="<%=find_regi_date_start%>" onfocus="calendar(event)"/>
          ~
          <input name="find_regi_date_end" type="text" id="find_regi_date_end" size="15" value="<%=find_regi_date_end%>" onfocus="calendar(event)"/></td>
        <td class="p94b">&nbsp;</td>
      </tr>
    </table>
        
       <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="4%" height="30" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="10%" nowrap="nowrap" bgcolor="e8f2ff"><strong>会员名</strong></td>
            <td width="11%" nowrap="nowrap" bgcolor="e8f2ff"><strong>密码</strong></td>
            <td width="19%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>注册日期/到期日期</strong></td>
            <td width="11%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>公司名称</strong></td>
            <td width="11%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>会员类别</strong></td>
            <td width="5%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>状态</strong></td>
            <td width="16%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>最后登录时间</strong></td>
            <td width="13%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          
          <%
 int k=0;
 while (rs!=null && rs.next()){
   k=k+1;

%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center" nowrap="nowrap"><%=k%></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("mem_name"))%> ( <%=Common.getFormatStr(rs.getString("mem_no"))%> )</td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("passw"))%></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("regi_date"))%>/<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("mem_flag_enddate"))%></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("comp_name"))%></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("mem_flag_name"))%></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("state")).equals("1")?"正常":"<font color='red'>禁用</font>"%></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatDate("yyyy-MM-dd hh:mm:ss",rs.getDate("login_last_date"))%></td>
            <td align="center" nowrap="nowrap"><div align="center"><span class="p92j"> <a href="#" onclick="openWin('market_member_opt.jsp?myvalue=<%=rs.getString("id")%>','member',750,600)">查看</a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="10"><%=bar%></td>
          </tr>
      </table></td>
  </tr>
</table>
</form>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%></cache:cache>