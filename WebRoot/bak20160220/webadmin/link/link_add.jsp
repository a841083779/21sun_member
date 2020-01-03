<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<% 
if(pool==null){
	pool = new PoolManager();
}
String id=Common.getFormatStr(request.getParameter("id"));
//表名
String tablename="link_list"; 

//String usern=ManageAction.getUserInfo(request,"usern");
//String deptnum=ManageAction.getUserInfo(request,"dept_num");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>友情链接管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/prototype.js"  type="text/javascript" charset="utf-8"></script>
<script src="../scripts/validation.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform" >
  <table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table1">
			<tr>
				<td height="5"></td>
			</tr>
		</table>
		<div align="center">
		<table width="97%" border="0" cellpadding="0" cellspacing="1" class="list_border_bg" style="background-color: #717EA2">
        <tr>
          <td width="23%" align="right" nowrap class="list_left_title" bgcolor="#E8EAF0"><strong class="list_border_bg">所属站点</strong>：</td>
          <td width="77%" class="list_cell_bg" bgcolor="#E8EAF0">
		  <select name="zd_website_id" id="zd_website_id">
                    <option value="">--选择所属站点--</option>
                    <%=Common.getOptions(pool,"website_list","id,name","1=1 and is_show=1","id",0) %>
          </select>
           </td>
        </tr>
        <tr>
          <td width="23%" align="right" nowrap class="list_left_title" bgcolor="#E8EAF0"><strong class="list_border_bg">友情链接名称</strong>：</td>
          <td width="77%" class="list_cell_bg" bgcolor="#E8EAF0">
		  <input name="zd_link_name" type="text" id="zd_link_name" size="40" maxlength="200" class="required"  >  </td>
        </tr>
        <tr>
          <td width="23%" align="right" nowrap class="list_left_title" bgcolor="#E8EAF0"><strong class="list_border_bg">友情链接地址</strong>：</td>
          <td width="77%" class="list_cell_bg" bgcolor="#E8EAF0">
		  <input name="zd_link_addr" type="text" id="zd_link_addr" size="40" maxlength="200" class="required" value="http://">
		  </td>
        </tr>
        <tr>
          <td width="23%" align="right" nowrap class="list_left_title" bgcolor="#E8EAF0"><strong class="list_border_bg">点击量</strong>：</td>
          <td width="77%" class="list_cell_bg" bgcolor="#E8EAF0">
		  <input name="zd_view_count" type="text" id="zd_view_count" size="40" maxlength="200" value="1">
		  </td>
        </tr>
        <tr>
          <td width="23%" align="right" nowrap class="list_left_title" bgcolor="#E8EAF0"><strong class="list_border_bg">排序</strong>：</td>
          <td width="77%" class="list_cell_bg" bgcolor="#E8EAF0">
		  <input name="zd_sort_num" type="text" id="zd_sort_num" size="20" maxlength="200" class="required" value="10">(数字大的在前面)
		  </td>
        </tr> 
        <tr>
          <td width="23%" align="right" nowrap class="list_left_title" bgcolor="#E8EAF0"><strong class="list_border_bg">发布日期</strong>：</td>
          <td width="77%" class="list_cell_bg" bgcolor="#E8EAF0">
		  <input name="zd_add_date" type="text" id="zd_add_date" onClick="WdatePicker()" value="<%= Common.getToday("yyyy-MM-dd",0)%>" size="20" maxlength="200"  ></td>
        </tr>
        <tr>
          <td width="23%" align="right" nowrap class="list_left_title" bgcolor="#E8EAF0"><strong class="list_border_bg">显示位置</strong>：</td>
          <td width="77%" class="list_cell_bg" bgcolor="#E8EAF0">
			<input type="radio" name="zd_is_show" value="1" checked/>首页  
			<input type="radio" name="zd_is_show" value="0"/>内页
		</td>
        </tr>
        <tr>
          <td height="22" align="center" bgcolor="#FFFFFF" >&nbsp;</td>
          <td height="22" bgcolor="#FFFFFF" ><input name="Submit" type="submit" class="form_button" value="保 存">
            <span class="list_cell_bg">
            <input name="Submit2" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
            <input name="zd_id" type="hidden" id="zd_id" value="0">
            <input name="tablename" type="hidden" id="tablename" value="<%=Common.encryptionByDES(tablename)%>">
            </span></td>
        </tr>
      </table></div>
		</td>
    </tr>
    </table>
</form>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
//验证

function set_formxx(val){

	if(val!=null && val!=""){
	document.getElementById('getxinxi').src="set_formxx.jsp?tablename=<%=tablename%>&paraName=id&paraValue="+val;
	}
}
<%
if(!id.equals("")){
	out.print("set_formxx("+id+");");
}
%>
  </script>
</body>
</html>