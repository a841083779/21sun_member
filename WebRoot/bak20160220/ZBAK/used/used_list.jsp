<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool4 = new PoolManager(4);
Connection conn =null;

//======生成首页求、出租信息静态页===
if(Common.getFormatInt(request.getParameter("f_indexHtml")).equals("1")){
   UsedToHtml usedToHtml=new UsedToHtml();
   usedToHtml.indexAllHtml(request, pool4,"700901");
}  

//======生成主站首页求、出租信息静态页===
if(Common.getFormatInt(request.getParameter("f_mainIndexHtml")).equals("1")){
   MainUsedToHtml usedToHtml=new MainUsedToHtml();
   usedToHtml.indexAllHtml(request, pool4,"700901");
}
//======生成完毕====

//=====页面属性====
String tablename="used_info";
String pageSubName="used_opt.jsp";
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
//得到参数
String findTitle=Common.getFormatStr(request.getParameter("findTitle"));
if(!findTitle.equals("")){
	query.append(" and title like '%"+findTitle+"%'");
}

String fidn_class=Common.getFormatStr(request.getParameter("fidn_class"));
if(!fidn_class.equals("")){
	query.append(" and class ='"+fidn_class+"'");
}

try{
conn = pool4.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
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
<script>
	function createIndexHtml(){ 
	   $("#f_indexHtml").val("1");
	   document.theform.submit();
   }
   function createMainIndexHtml(){
	   $("#f_mainIndexHtml").val("1");
	   document.theform.submit();
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
            <td width="65%" align="center" nowrap="nowrap"><span class="title1">标题：
              <input name="findTitle" type="text" id="findTitle" value="<%=findTitle%>" />
              <span class="list_cell_bg">
              <select name="fidn_class" id="fidn_class">
                <option value="">--请选择性质--</option>
				<option value="1" <%if(fidn_class.equals("1"))out.print("selected");%>>出租</option>
                <option value="0" <%if(fidn_class.equals("0"))out.print("selected");%>>求租</option>
		       </select>
              </span>
              <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit22" value="清空" onclick="javascript:clearForm()" />
              </span>
              <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
				<input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,600)"/>					
				<input name="b_createIndexHtml" type="button" id="b_createIndexHtml" value="生成二手首页静态页" onclick="javascript:createIndexHtml();" />
				<input type="hidden" name="f_indexHtml" value="0" id="f_indexHtml" />
				<input name="b_createMainIndexHtml" type="button" id="b_createMainIndexHtml" value="生成主站二手首页静态页" onclick="javascript:createMainIndexHtml();" /> 
				<input type="hidden" name="f_mainIndexHtml" value="0" id="f_mainIndexHtml" />	  		  
			  </td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="56%" bgcolor="e8f2ff"><strong>标题</strong></td>
            <td width="14%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>日期</strong></span></div></td>
            <td width="11%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否发布</strong></span></div></td>
            <td width="14%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="5"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td><%=Common.getFormatStr(rs.getString("title"))%></td>
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub")).equals("1")?"显示":"不显示"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../used/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div></td>
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
	pool4.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
