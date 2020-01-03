<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
	
//String tablename="member_info";
String tablename="vi_member_info";

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

String find_state=Common.getFormatStr(request.getParameter("find_state"));
if(!find_state.equals("")){
	query.append(" and state ='"+find_state+"' ");
}

//===会员专卖店查询=====
String find_mem_flag=Common.getFormatStr(request.getParameter("find_mem_flag"));
if(!find_mem_flag.equals("")){
	query.append(" and mem_flag='"+find_mem_flag+"' ");
}



//====到期时间区间查询====
String find_mem_flag_enddate1=Common.getFormatStr(request.getParameter("find_mem_flag_enddate1"));
if(!find_mem_flag_enddate1.equals("")){
	query.append(" and convert(varchar(10),mem_flag_enddate,21) >=convert(varchar(10),'"+find_mem_flag_enddate1+"',21) ");
}

String find_mem_flag_enddate2=Common.getFormatStr(request.getParameter("find_mem_flag_enddate2"));
if(!find_mem_flag_enddate2.equals("")){
	query.append(" and convert(varchar(10),mem_flag_enddate,21) <=convert(varchar(10),'"+find_mem_flag_enddate2+"',21) ");
}
//============

String find_regi_date_start=Common.getFormatStr(request.getParameter("find_regi_date_start"));
if(!find_regi_date_start.equals("")){
	query.append(" and convert(varchar(10),regi_date,21) >=convert(varchar(10),'"+find_regi_date_start+"',21) ");
}
String find_regi_date_end=Common.getFormatStr(request.getParameter("find_regi_date_end"));
if(!find_regi_date_end.equals("")){
	query.append(" and convert(varchar(10),regi_date,21) <=convert(varchar(10),'"+find_regi_date_end+"',21) ");
}

//得到参数
String mem_no=Common.getFormatStr(request.getParameter("mem_no"));
if(!mem_no.equals("")){
	query.append(" and (mem_no like '%"+mem_no+"%' or mem_name like '%"+mem_no+"%' or comp_name like '%"+mem_no+"%' ) ");
}
//===查询省份时====
String per_province=Common.getFormatStr(request.getParameter("per_province"));
if(!per_province.equals("")){
	query.append(" and (per_province like '%"+per_province+"%' or per_city like '%"+per_province+"%' or comp_name like '%"+per_province+"%' ) ");
}


String find_parts_brand=Common.getFormatStr(request.getParameter("find_parts_brand"));
if(!find_parts_brand.equals("")){
	query.append(" and parts_brand like '%"+find_parts_brand+"%' ");
}

//====电话、传真===

String find_per_phone=Common.getFormatStr(request.getParameter("find_per_phone"));
if(!find_per_phone.equals("")){
	query.append(" and per_phone like '%"+find_per_phone+"%' ");
}

String find_comp_fax=Common.getFormatStr(request.getParameter("find_comp_fax"));
if(!find_comp_fax.equals("")){
	query.append(" and comp_fax like '%"+find_comp_fax+"%' ");
}

String find_fittings_iscomplib=Common.getFormatStr(request.getParameter("find_fittings_iscomplib"));
if(!find_fittings_iscomplib.equals("")){
	query.append(" and fittings_iscomplib like '%"+find_fittings_iscomplib+"%' ");
}

String find_fittings_ispubcomp=Common.getFormatStr(request.getParameter("find_fittings_ispubcomp"));
if(!find_fittings_ispubcomp.equals("")){
	query.append(" and fittings_ispubcomp like '%"+find_fittings_ispubcomp+"%' ");
}

//====原会员级别====
String find_old_mem_flag=Common.getFormatStr(request.getParameter("find_old_mem_flag"));
if(!find_old_mem_flag.equals("")){
	query.append(" and old_mem_flag = '"+find_old_mem_flag+"' ");
}
//====原会员到期日期===
String find_old_mem_flag_enddate1=Common.getFormatStr(request.getParameter("find_old_mem_flag_enddate1"));
if(!find_old_mem_flag_enddate1.equals("")){
	query.append(" and convert(varchar(10),old_mem_flag_enddate,21) >=convert(varchar(10),'"+find_old_mem_flag_enddate1+"',21) ");
}
String find_old_mem_flag_enddate2=Common.getFormatStr(request.getParameter("find_old_mem_flag_enddate2"));
if(!find_old_mem_flag_enddate2.equals("")){
	query.append(" and convert(varchar(10),old_mem_flag_enddate,21)<=convert(varchar(10),'"+find_old_mem_flag_enddate2+"',21) ");
}
//====登录次数===
String find_login_count=Common.getFormatInt(request.getParameter("find_login_count"));
if(!find_login_count.equals("0"))
query.append(" and login_count>="+find_login_count);
%>
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
<title>会员管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<!--<%=query.toString()+" order by id desc" %>-->
<script language="javascript" type="text/javascript">
	function setFlag(flag){
		if(confirm("确定这样操作吗？")){
			document.theform.action = "tool.jsp?flag="+flag;
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
<body><%//=query.toString()+" order by id desc"%>
<form action="" method="get" name="theform" id="theform">
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="1%" class="title_bar">&nbsp;</td>
        <td width="89%" class="p94b"> 会员名(公司名称)：
          <input name="mem_no" type="text" id="mem_no" size="12" value="<%=mem_no%>" />
省份
<input name="per_province" type="text" id="per_province" size="10" value="<%=per_province%>" />
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
<input name="find_mem_flag_enddate1" type="text" id="find_mem_flag_enddate1" size="6" value="<%=find_mem_flag_enddate1%>" onFocus="calendar(event)"/>
~
<input name="find_mem_flag_enddate2" type="text" id="find_mem_flag_enddate2" size="6" value="<%=find_mem_flag_enddate2%>" onFocus="calendar(event)"/>
 电话： <input name="find_per_phone" type="text" id="find_per_phone" size="8" value="<%=find_per_phone%>" /></td>
        <td width="10%" rowspan="3" class="p94b"><input type="submit" name="Submit" value="搜索" />
          <input type="button" name="Submit2" value="清除" onClick="javascript:clearForm()" /></td>
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
          <input name="find_regi_date_start" type="text" id="find_regi_date_start" size="6" value="<%=find_regi_date_start%>" onFocus="calendar(event)"/>
          ~
          <input name="find_regi_date_end" type="text" id="find_regi_date_end" size="6" value="<%=find_regi_date_end%>" onFocus="calendar(event)"/>
		  传真：  <input name="find_comp_fax" type="text" id="find_comp_fax" size="8" value="<%=find_comp_fax%>" />
         
		 配套网企业库:<select name="find_fittings_iscomplib" id="find_fittings_iscomplib"><option value="">请选择</option><option value="1" <%=find_fittings_iscomplib.equals("1")?"selected":""%>>是</option><option value="0" <%=find_fittings_iscomplib.equals("0")?"selected":""%>>否</option></select>
		  配套网品牌宣传企业:<select name="find_fittings_ispubcomp" id="find_fittings_ispubcomp"><option value="">请选择</option><option value="1" <%=find_fittings_ispubcomp.equals("1")?"selected":""%>>是</option><option value="0" <%=find_fittings_ispubcomp.equals("0")?"selected":""%>>否</option></select>		  </td>
        </tr>
      <tr>
        <td class="title_bar">&nbsp;</td>
        <td class="p94b"><select name="find_old_mem_flag" id="find_old_mem_flag">
          <option value="">--原会员级别--</option>
			  <%=Common.option_str(pool, "member_role","role_num,role_name"," 1=1 order by role_num", find_old_mem_flag,0)%>
			</select>
          原会员到期日期
          <input name="find_old_mem_flag_enddate1" type="text" id="find_old_mem_flag_enddate1" size="6" value="<%=find_old_mem_flag_enddate1%>" onFocus="calendar(event)"/>
~
<input name="find_old_mem_flag_enddate2" type="text" id="find_old_mem_flag_enddate2" size="6" value="<%=find_old_mem_flag_enddate2%>" onFocus="calendar(event)"/> 　
登录次数大于等于　
<input name="find_login_count" type="text" id="find_login_count" size="8" value="<%=find_login_count%>" /></td>
        </tr>
    </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
              <%if(!admin_mem_flag.equals("1007")&&!admin_mem_flag.equals("1005")){%>
              <input type="button" name="b_add" value="增加" onClick="openWin('member_opt.jsp','sell',750,650)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="button" name="b_add" value="批量禁用" onClick="setFlag(0);"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="button" name="b_add" value="批量开通" onClick="setFlag(1);"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  <input type="button" name="b_add" value="批量删除" onClick="setFlag(2);"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  <%}%>
           </td>
          </tr>
        </table>
       <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td width="1%" height="30" align="center" bgcolor="e8f2ff">
			  	<input type="checkbox" id="checkall" name="checkall" onClick="CheckAll();" />
			</td>
            <td width="5%" height="30" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="10%" nowrap="nowrap" bgcolor="e8f2ff"><strong>会员名</strong></td>
            <td width="10%" nowrap="nowrap" bgcolor="e8f2ff"><strong>密码</strong></td>
			 <td width="10%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>公司名称</strong></td>
            <td width="18%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>注册日期/到期日期</strong></td>
           
            <td width="10%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>会员类别</strong></td>
            <td width="5%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>状态</strong></td>
            <td width="12%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>最后登录时间</strong></td>
            <td width="5%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>次数</strong></td>
            <td width="16%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          
			<%
			
				String old_mem_flag="";
				int k=0;
				while (rs!=null && rs.next()){
					k=k+1;
					old_mem_flag = Common.getFormatStr(rs.getString("old_mem_flag")); //原始级别
			%>
            <tr <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center">
			  	<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
			</td>
            <td height="30" align="center" nowrap="nowrap"><%=k%></td>
            <td nowrap="nowrap">&nbsp;<a href="#" onClick="openWin('member_opt.jsp?myvalue=<%=rs.getString("id")%>','',750,600)"><%=Common.getFormatStr(rs.getString("mem_name"))%> ( <%=Common.getFormatStr(rs.getString("mem_no"))%> )</a></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("passw"))%></td>
			<td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("comp_name"))%></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("regi_date"))%>/<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("mem_flag_enddate"))%></td>
            <td align="center" nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("mem_flag_name"))%><%=!old_mem_flag.equals("")?"▲":""%></td>
            <td align="center" nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("state")).equals("1")?"正常":"<font color='red'>禁用</font>"%></td>
            <td align="center" nowrap="nowrap">&nbsp;<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("login_last_date"))%></td>
            <td align="center" nowrap="nowrap">&nbsp;<%=Common.getFormatInt(rs.getString("login_count"))%></td>
            <td align="right" nowrap="nowrap"><div align="center"><span class="p92j"><%if(!admin_mem_flag.equals("1007")&&!admin_mem_flag.equals("1005")){%><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a><%}%>&nbsp;&nbsp; <a href="#" onClick="openWin('member_opt.jsp?myvalue=<%=rs.getString("id")%>','',750,600)"><%=(admin_mem_flag.equals("1007")||admin_mem_flag.equals("1005"))?"查看":"修改"%></a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="11"><%=bar%></td>
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
