<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}
	 String tablename="aboutus_resume";
	 String pageSubName = "zhaopin_edit.jsp";
	Connection conn = pool.getConnection();
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(17);
	try {
		String offset = request.getParameter("offset");
		if (offset == null || offset.equals("")) {
			offset = "0";
		}

		//搜索条件形成
		String searchStr = "where  1=1";
		String title= request.getParameter("title");
		if(title!=null&&!title.equals(""))
		{
			title=Common.getFormatStr(title);
			searchStr+=" and  position like  '%"+title+"%' ";
			
		}else
		{
			title="";
		}
		String gw = Common.getFormatStr(request.getParameter("gw"));
		if(!"".equals(gw)){
			searchStr+=" and  gw_id=   '"+gw+"' ";
		}
	String[][] zgs = DataManager.fetchFieldValue(pool, "aboutus_gw_list",
					"id,name", "1=1 order by name");
		String query = "select * from "+tablename+" "+searchStr+" order by id desc";
		ResultSet rs = pagination.getQueryResult(query, request, conn);
		String bar = pagination.paginationPrint(); //读取分页提示
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript">
function clearF(){
	document.getElementById("gw").value='';
	document.getElementById("title").value='';
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
            <td width="65%" align="center" nowrap="nowrap">
            <span class="p92z"><strong>职位名称</strong></span><span class="title1">：<input type="text" name="title" id="title" value="<%=title %>" class="xmlInput" style="width: 150px;" />      
                                         <input type="submit" name="Submit" value="查询" /> 
              </span>
              <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
            </td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td   align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>求职者姓名</strong></span></div></td>
            <td   align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>年龄</strong></span></div></td>
            <td   align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>应聘职位</strong></span></div></td>
            <td   align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>性别</strong></span></div></td>
            <td   align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>求职日期</strong></span></div></td>
            <td   align="center" bgcolor="e8f2ff" nowrap="nowrap"><div align="center"><span class="p92z"><strong>学历</strong></span></div></td>
            <td width="14%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="5"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
   String gw_id = "" ;
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%> align="center">
           <td  style='text-align: left; ' nowrap="nowrap" align="center">
                                             <span class="link" > 
                                             <a href="#" onclick="openWin('<%=pageSubName%>?id=<%=rs.getString("id")%>','win',800,600)">
                                              	<%=Common.getFormatStr(rs.getString("username")) %>
                                              </a></span>
                                              </td>
                                               <td style='text-align: center; ' nowrap="nowrap">
                                              		<%=Common.getFormatStr(rs.getString("age")) %>
                                              </td>
                                              <td style='text-align: center; ' nowrap="nowrap">
                                              			<%=Common.getFormatStr(rs.getString("position")) %>
                                              </td>
                                              <td style='text-align: center; ' nowrap="nowrap">
                                              			<%=Common.getFormatStr(rs.getString("sex"))  %>
                                              </td>
                                              <td style='text-align: center; ' nowrap="nowrap">
                                              	<%=Common.getFormatStr(rs.getString("add_date")).length()<=10?"-":Common.getFormatStr(rs.getString("add_date")).substring(0,10) %>
                                              </td>
                                              <td style='text-align: center; ' nowrap="nowrap">
                                              	<%=Common.getFormatStr(rs.getString("education")) %>
                                              </td>
                                              <td align="center" nowrap="nowrap">
                                              <div align="center">
                                              <span class="p92j">
                                              <a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp;
								             <a href="#" onclick="openWin('<%=pageSubName%>?id=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div>
								             </td>
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
}%>
