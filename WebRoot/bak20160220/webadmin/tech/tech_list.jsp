<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="/manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;

//======生成所有静态页===
if(Common.getFormatInt(request.getParameter("f_createAllHtml")).equals("1"))
{
TechToHtml techToHtml=new TechToHtml();
techToHtml.allHtml(request, pool,"700301");
}

//======生成首页静态页===
if(Common.getFormatInt(request.getParameter("f_indexHtml")).equals("1"))
{TechToHtml techToHtml=new TechToHtml();
techToHtml.indexNewHtml(request, pool,"700301");
}

//======生成完毕====

//=====页面属性====
String tablename="article_other";
String pageSubName="tech_opt.jsp";
//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where catalog_no=700301");
//得到参数
String findTitle=Common.getFormatStr(request.getParameter("findTitle"));
if(!findTitle.equals("")){
	query.append(" and title like '%"+findTitle+"%'");
}
String find_sort_num=Common.getFormatStr(request.getParameter("find_sort_num"));
if(!find_sort_num.equals("")){
	query.append(" and sort_num ='"+find_sort_num+"'");
}
query.append(" order by pub_date desc ");

String temp_sort_num="";
try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs =pagination.getQueryResult(query.toString(), request,conn,1);
 
String bar = pagination.paginationPrint();  //读取分页提示栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style>
<script>
function deleteData(id,tablename,zd_catalog_no,zd_sort_num){
	if(confirm("您确认要删除吗？")){
	var url="../manage/opt_delete.jsp?mypy="+encodeURIComponent(tablename)+"&myvalue="+encodeURIComponent(id);
		$.ajax({
			   url: url,
			   type: 'POST',
			   dataType: 'html',
			   timeout: 1000,
		       error: function(){
                 alert('执行错误!');
               },
              success: function(html){updateData('<%=tablename%>',zd_catalog_no,zd_sort_num);
			  //document.location.reload();
               //$(".flexme1").flexReload();
			   //alert('删除成功!');
				//document.location.reload();
              }
           });
  }
}

function updateData(mypy,zd_catalog_no,zd_sort_num){
var url="opt_save_update.jsp?myflag=2&mypy="+encodeURIComponent(mypy)+"&zd_catalog_no="+encodeURIComponent(zd_catalog_no)+"&zd_sort_num="+encodeURIComponent(zd_sort_num);
		$.ajax({
			   url: url,
			   type: 'POST',
			   dataType: 'html',
			   timeout: 1000,
		       error: function(){
                 alert('执行错误!');
               },
              success: function(html){
			 document.location.reload();
			 
               //$(".flexme1").flexReload();
			   //alert('删除成功!');
				//document.location.reload();
              }
           });

}
function createAllHtml(){
$("#f_createAllHtml").val("1");
document.theform.submit();

}
function createIndexHtml(){
$("#f_indexHtml").val("1");
document.theform.submit();

}

</script>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="1%" class="title_bar">&nbsp;</td>
        <td width="23%" class="p94b">&nbsp;</td>
        <td width="65%" align="center" nowrap="nowrap"><span class="title1">标题：
          <input name="findTitle" type="text" id="findTitle" value="<%=findTitle%>" />
          <span class="list_cell_bg">
          <select name="find_sort_num" id="find_sort_num">
            <option value="">--请选择类型--</option>
			<option value="0100" <%if(find_sort_num.equals("0100"))out.print("selected");%>>行业知识</option>
			<option value="0200" <%if(find_sort_num.equals("0200"))out.print("selected");%>>专家在线</option>
            <option value="0300" <%if(find_sort_num.equals("0300"))out.print("selected");%>>精彩文章</option>
            <option value="0400" <%if(find_sort_num.equals("0400"))out.print("selected");%>>技术前沿</option>
            <option value="0500" <%if(find_sort_num.equals("0500"))out.print("selected");%>>维修一线</option>
            <option value="0600" <%if(find_sort_num.equals("0600"))out.print("selected");%>>厂家专栏</option>
          </select>
          </span>
              <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit22" value="清空" onclick="javascript:clearForm()" />
              
          </span>
          <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />        </td><td width="18%" align="right" class="title_bar">&nbsp;</td>
      </tr>
    </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
              <input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,600)"/>
            </a>
            <label>
            <!--<input name="b_createAllHtml" type="button" id="b_createAllHtml" value="生成全部静态页" onclick="javascript:createAllHtml();" />
			<input type="hidden" name="f_createAllHtml" value="0" id="f_createAllHtml" />
			<input name="b_createIndexHtml" type="button" id="b_createIndexHtml" value="生成首页静态页" onclick="javascript:createIndexHtml();" />
			<input type="hidden" name="f_indexHtml" value="0" id="f_indexHtml" />-->
			<a href="http://www.21-sun.com/tech/tools/createIndex.jsp?f_createAllHtml=1" target="_blank">生成全部静态页</a> &nbsp;&nbsp;&nbsp;<a href="http://www.21-sun.com/tech/tools/createIndex.jsp?f_indexHtml=1" target="_blank">生成首页静态页</a> &nbsp;&nbsp;&nbsp;
            </label></td>
          </tr>
        </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="4%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="55%" bgcolor="e8f2ff"><strong>标题</strong></td>
            <td width="14%" bgcolor="e8f2ff"><div align="center"><strong>发布日期</strong></div></td>
            <td width="8%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>业务分类</strong></span></div></td>
            <td width="7%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否显示</strong></span></div></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
temp_sort_num=Common.getFormatStr(rs.getString("sort_num"));
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td><a href="javascript:;" onclick="openHtml('<%=Common.getFormatStr(rs.getString("html_filename")) %>')"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
            <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date"))%></td>
            <td align="center"><div align="center"><%if(temp_sort_num.equals("0300"))out.print("精彩文章");else if(temp_sort_num.equals("0100"))out.print("行业知识");else if(temp_sort_num.equals("0200"))out.print("专家在线");else if(temp_sort_num.equals("0500"))out.print("维修一线");else if(temp_sort_num.equals("0600"))out.print("厂家专栏");else if(temp_sort_num.equals("0400"))out.print("技术前沿");%></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub")).equals("1")?"显示":"不显示"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>','<%=Common.getFormatStr(rs.getString("catalog_no"))%>','<%=Common.getFormatStr(rs.getString("sort_num"))%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div></td>
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
<script type="text/javascript">
function openHtml(html){
	window.open("http://www.21-sun.com/tech/detail/"+html) ;
}
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
	temp_sort_num=null;
}%>
