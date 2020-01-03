<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="/webadmin/manage/config.jsp"%>
<%
//===调租赁库====
if(pool == null){
	pool = new PoolManager();
}
Connection conn =null;

//=====页面属性====
String tablename="stock_pool";
String pageSubName="stock_opt.jsp";

//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(10);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
 
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");
//代码
String find_code=Common.getFormatStr(request.getParameter("find_code"));
if(!find_code.equals("")){
	query.append(" and code= '"+find_code+"'");
}
/*名称*/ 
String find_name=Common.getFormatStr(request.getParameter("find_name"));
if(!find_name.equals("")){
	query.append(" and name like '%"+find_name+"%'");
}
/*行业*/
String find_field=Common.getFormatStr(request.getParameter("find_field"));
if(!find_field.equals("")){
	query.append(" and field= "+find_field+"");
}
/*市场*/
String find_market=Common.getFormatStr(request.getParameter("find_market"));
if(!find_market.equals("")){
	query.append(" and market= "+find_market+"");
}
query.append(" order by code");
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
<link href="/webadmin/style/style.css" rel="stylesheet" type="text/css" />
<script src="/webadmin/scripts/jquery-1.4.1.min.js"></script>
<script  src="/webadmin/scripts/common.js"  type="text/javascript"></script>
<script  src="/webadmin/scripts/calendar.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function batchDelete(){
		if(confirm("确定这样操作吗？")){
			document.theform.action = "tool.jsp";
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
select {/*解决样式冲突*/
	float:none;
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
            <td width="65%" align="center" nowrap="nowrap">
            	股票代码：
                <input name="find_code" type="text" id="find_code" value="<%=find_code%>" size="15" maxlength="8" />
                股票名称：
                <input name="find_name" type="text" id="find_name" value="<%=find_name%>" maxlength="8"/>
			  所属行业：<span>
			  <select name="find_field" id="find_field">
			  	<option value=""></option>
			  	<option value="0" <%if("0".equals(find_field)){%>selected<%}%>>工程机械行业</option>
				<option value="1" <%if("1".equals(find_field)){%>selected<%}%>>钢铁上游行业</option>
				<option value="2" <%if("2".equals(find_field)){%>selected<%}%>>发动机上游行业</option>
				<option value="-1" <%if("-1".equals(find_field)){%>selected<%}%>>建筑下游行业</option>
				<option value="-2" <%if("-2".equals(find_field)){%>selected<%}%>>矿山下游行业</option>
			  </select>
			  </span>
			  所属市场：
			  <span>
			  <select name="find_market" id="find_market">
			  	<option value=""></option>
			  	<option value="0" <%if("0".equals(find_market)){%>selected<%}%>>沪市</option>
				<option value="1" <%if("1".equals(find_market)){%>selected<%}%>>深市</option>
			  </select>
			  </span>
			  <input type="submit" name="Submit" value="查询" />
			  <input type="button" name="Submit2" value="清空" onclick="javascript:clearForm()" />
              <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
			    <input type="button" id="hot" name="hot" value="批量删除" onclick="batchDelete();"/>
				<input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',600,300)"/>						  
		    </td>
			  
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
		    <td width="2%" height="30" align="center" bgcolor="e8f2ff">
			  <input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			</td>
            <td width="2%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="15%" align="center" bgcolor="e8f2ff"><strong>股票代码</strong></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><strong>股票名称</strong></td>
            <td width="18%" align="center" bgcolor="e8f2ff"><div align="center"><strong>所属行业</strong></div></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>所属市场</strong></span></div></td>
			<td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否重点</strong></span></div></td>
			<td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否热点</strong></span></div></td>
            <td width="39%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
		    <td height="30" align="center">
				<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
			</td>
            <td height="30" align="center"><%=k%></td>
            <td align="center"><%=Common.getFormatStr(rs.getString("code"))%></td>
            <td align="center"><%=Common.getFormatStr(rs.getString("name"))%></td>
            <td align="center"><div align="center"><%if("0".equals(Common.getFormatInt(rs.getString("field")))){out.print("工程机械行业");}else if("1".equals(Common.getFormatInt(rs.getString("field")))){out.print("上游行业");}else{out.print("下游行业");}%></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=("0".equals(Common.getFormatInt(rs.getString("market"))))?"沪市":"深市"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=("0".equals(Common.getFormatInt(rs.getString("is_hot"))))?"否":"是"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=("0".equals(Common.getFormatInt(rs.getString("is_importance"))))?"否":"是"%></span></div></td>			
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','win',600,300)">修改</a></span></div></td>
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
<iframe name="hiddenFrame" style="display:none"></iframe>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
