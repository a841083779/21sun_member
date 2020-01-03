<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool3 = new PoolManager(3);
PoolManager pool1 = new PoolManager(1);
Connection conn =null;

//======生成首页静态页===
if(Common.getFormatInt(request.getParameter("f_indexHtml")).equals("1")){
   RentToHtml rentToHtml=new RentToHtml();
   rentToHtml.indexAllHtml(request,pool3,"");
}

//======生成主站的租赁调剂首页静态页===
if(Common.getFormatInt(request.getParameter("f_mainIndexHtml")).equals("1")){
   MainRentToHtml mainRentToHtml = new MainRentToHtml();
    mainRentToHtml.indexAllHtml(request,pool3,"");
}


//生成名企名家首页静态页
if(Common.getFormatInt(request.getParameter("f_mqmjHtml")).equals("1")){
   RentToHtml rentToHtml=new RentToHtml();
   rentToHtml.indexList(request, pool3, "700702", "2004");
}

if(Common.getFormatInt(request.getParameter("f_zlswfgHtml")).equals("1")){
   RentToHtml rentToHtml=new RentToHtml();
   rentToHtml.indexList(request, pool3, "700702", "2001");  
   //后台已做处理 将租赁实务及租赁法规整合在一起
}
if(Common.getFormatInt(request.getParameter("f_zbxmHtml")).equals("1")){
   RentToHtml rentToHtml=new RentToHtml();
   rentToHtml.indexList(request, pool1, "bildding", "1000");  
}

if(Common.getFormatInt(request.getParameter("f_ggsdHtml")).equals("1")){
   RentToHtml rentToHtml=new RentToHtml();
   rentToHtml.indexList(request, pool3, "700702", "1002");  
}
if(Common.getFormatInt(request.getParameter("f_schqZlxwHtml")).equals("1")){
   RentToHtml rentToHtml=new RentToHtml();
   rentToHtml.indexList(request, pool3, "700702", "_price1001");  
}

if(Common.getFormatInt(request.getParameter("f_schqZlswHtml")).equals("1")){
   RentToHtml rentToHtml=new RentToHtml();

   rentToHtml.indexList(request, pool3, "700702", "_price2001");  
}
if(Common.getFormatInt(request.getParameter("f_schqMqmjHtml")).equals("1")){
   RentToHtml rentToHtml=new RentToHtml();
   rentToHtml.indexList(request, pool3, "700702", "_price2004");  
   
}
//======生成完毕====

//=====页面属性====
String tablename="rent_news";
String pageSubName="rent_news_opt.jsp";
//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where category<>'700704'");
//得到参数
String findTitle=Common.getFormatStr(request.getParameter("findTitle"));
if(!findTitle.equals("")){
	query.append(" and title like '%"+findTitle+"%'");
}
String find_category=Common.getFormatStr(request.getParameter("find_category"));
if(!find_category.equals("")){
	query.append(" and category ='"+find_category+"' ");
}
String findurl=Common.getFormatStr(request.getParameter("findurl"));
if(!findurl.equals("")){
	query.append(" and url ='"+findurl+"' ");
}



query.append(" order by pubdate desc ");

try{
conn = pool3.getConnection();
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
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
.p922 {color: black; font-size: 12px; line-height: 18px }
-->
</style>
<script>
function createIndexHtml(){
$("#f_indexHtml").val("1");
document.theform.submit();
}
function createMainIndexHtml(){
$("#f_mainIndexHtml").val("1");
document.theform.submit();
}
function createMqmjIndexHtml(){
$("#f_mqmjHtml").val("1");
document.theform.submit();
}
function createZlswfgIndexHtml(){
$("#f_zlswfgHtml").val("1");
document.theform.submit();
}
function createZbxmIndexHtml(){
$("#f_zbxmHtml").val("1");
document.theform.submit();
}
function createGgsdIndexHtml(){
$("#f_ggsdHtml").val("1");
document.theform.submit();
}
function createSchqZlxwIndexHtml(){
$("#f_schqZlxwHtml").val("1");
document.theform.submit();
}
function createSchqZlswIndexHtml(){
$("#f_schqZlswHtml").val("1");
document.theform.submit();
}
function createSchqMqmjIndexHtml(){
$("#f_schqMqmjHtml").val("1");
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
			  <span class="p922">
			  <select name="findurl" size="1" id="findurl">
			   <option value="">--请选择所属--</option>
                <option value="系统公告" <%if(findurl.equals("系统公告"))out.print("selected");%>>系统公告</option>
                <option value="北京" <%if(findurl.equals("北京"))out.print("selected");%>>北京站</option>
                <option value="上海" <%if(findurl.equals("上海"))out.print("selected");%>>上海站</option>
                <option value="天津" <%if(findurl.equals("天津"))out.print("selected");%>>天津站</option>
                <option value="重庆" <%if(findurl.equals("重庆"))out.print("selected");%>>重庆站</option>
                <option value="河北" <%if(findurl.equals("河北"))out.print("selected");%>>河北站</option>
                <option value="山西" <%if(findurl.equals("山西"))out.print("selected");%>>山西站</option>
                <option value="辽宁" <%if(findurl.equals("辽宁"))out.print("selected");%>>辽宁站</option>
                <option value="吉林" <%if(findurl.equals("吉林"))out.print("selected");%>>吉林站</option>
                <option value="黑龙江" <%if(findurl.equals("黑龙江"))out.print("selected");%>>黑龙江站</option>
                <option value="江苏" <%if(findurl.equals("江苏"))out.print("selected");%>>江苏站</option>
                <option value="浙江" <%if(findurl.equals("浙江"))out.print("selected");%>>浙江站</option>
                <option value="安徽" <%if(findurl.equals("安徽"))out.print("selected");%>>安徽站</option>
                <option value="福建" <%if(findurl.equals("福建"))out.print("selected");%>>福建站</option>
                <option value="江西" <%if(findurl.equals("江西"))out.print("selected");%>>江西站</option>
                <option value="山东" <%if(findurl.equals("山东"))out.print("selected");%>>山东站</option>
                <option value="河南" <%if(findurl.equals("河南"))out.print("selected");%>>河南站</option>
                <option value="湖北" <%if(findurl.equals("湖北"))out.print("selected");%>>湖北站</option>
                <option value="湖南" <%if(findurl.equals("湖南"))out.print("selected");%>>湖南站</option>
                <option value="广东" <%if(findurl.equals("广东"))out.print("selected");%>>广东站</option>
                <option value="海南" <%if(findurl.equals("海南"))out.print("selected");%>>海南站</option>
                <option value="四川" <%if(findurl.equals("四川"))out.print("selected");%>>四川站</option>
                <option value="贵州" <%if(findurl.equals("贵州"))out.print("selected");%>>贵州站</option>
                <option value="云南" <%if(findurl.equals("云南"))out.print("selected");%>>云南站</option>
                <option value="陕西" <%if(findurl.equals("陕西"))out.print("selected");%>>陕西站</option>
                <option value="甘肃" <%if(findurl.equals("甘肃"))out.print("selected");%>>甘肃站</option>
                <option value="青海" <%if(findurl.equals("青海"))out.print("selected");%>>青海</option>
                <option value="内蒙古" <%if(findurl.equals("内蒙古"))out.print("selected");%>>内蒙古站</option>
                <option value="广西" <%if(findurl.equals("广西"))out.print("selected");%>>广西站</option>
                <option value="西藏" <%if(findurl.equals("西藏"))out.print("selected");%>>西藏站</option>
                <option value="宁夏" <%if(findurl.equals("宁夏"))out.print("selected");%>>宁夏站</option>
                <option value="新疆" <%if(findurl.equals("新疆"))out.print("selected");%>>新疆站</option>
                <option value="台湾" <%if(findurl.equals("台湾"))out.print("selected");%>>台湾站</option>
                <option value="香港" <%if(findurl.equals("香港"))out.print("selected");%>>香港站</option>
                <option value="澳门" <%if(findurl.equals("澳门"))out.print("selected");%>>澳门站</option>
              </select>
			  </span>
			  <select name="find_category" id="find_category">
          <option value="">--请选择类别--</option>
		  <option value="1001" <%if(find_category.equals("1001"))out.print("selected");%>>租赁行情</option>
		  <option value="1002" <%if(find_category.equals("1002"))out.print("selected");%>>系统公告</option>
          <!--<option value="2001" <%if(find_category.equals("2001"))out.print("selected");%>>租赁实务</option>
          <option value="2002" <%if(find_category.equals("2002"))out.print("selected");%>>租赁行情</option>
          <option value="2003" <%if(find_category.equals("2003"))out.print("selected");%>>租赁法规</option>
          <option value="2004" <%if(find_category.equals("2004"))out.print("selected");%>>名企名家</option>-->
        </select>
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
            <td height="15"><input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,600)"/>
             <!--<input name="b_createIndexHtml" type="button" id="b_createIndexHtml" value="生成首页静态页" onclick="javascript:createIndexHtml();" />
			 <input type="hidden" name="f_indexHtml" value="0" id="f_indexHtml" />
			
			 <input name="b_createMainIndexHtml" type="button" id ="b_createMainIndexHtml" value="生成主站首页静态页" onclick="javascriot:createMainIndexHtml();" />
			 <input type="hidden" name="f_mainIndexHtml" value="0" id="f_mainIndexHtml" />-->
		
			
			  <div style="display:none;">
              
			  <input name="b_createMqmjHtml" type="button" id="b_createMqmjHtml" value="生成名企名家静态页" onclick="javascript:createMqmjIndexHtml();" />
			    <input type="hidden" name="f_mqmjHtml" value="0" id="f_mqmjHtml" />
			   <input name="b_createZlswfgHtml" type="button" id="b_createZlswfgHtml" value="生成租赁实务、法规静态页" onclick="javascript:createZlswfgIndexHtml();" />
			    <input type="hidden" name="f_zlswfgHtml" value="0" id="f_zlswfgHtml" />
				<input name="b_createZbxmHtml" type="button" id="b_createZbxmHtml" value="生成最新工程招标静态页" onclick="javascript:createZbxmIndexHtml();" />
			    <input type="hidden" name="f_zbxmHtml" value="0" id="f_zbxmHtml" />
				<input name="b_createGgsdHtml" type="button" id="b_createGgsdHtml" value="生成租赁公告静态页" onclick="javascript:createGgsdIndexHtml();" />
			    <input type="hidden" name="f_ggsdHtml" value="0" id="f_ggsdHtml" />
				<input name="b_createSchqZlxwHtml" type="button" id="b_createSchqZlxwHtml" value="生成市场行情租赁新闻" onclick="javascript:createSchqZlxwIndexHtml();" />
			    <input type="hidden" name="f_schqZlxwHtml" value="0" id="f_schqZlxwHtml" />
				<input name="b_createSchqZlswHtml" type="button" id="b_createSchqZlswHtml" value="生成市场行情租赁实务" onclick="javascript:createSchqZlswIndexHtml();" />
			    <input type="hidden" name="f_schqZlswHtml" value="0" id="f_schqZlswHtml" />
				<input name="b_createSchqMqmjHtml" type="button" id="b_createSchqMqmjHtml" value="生成市场行情名企名家" onclick="javascript:createSchqMqmjIndexHtml();" />
			    <input type="hidden" name="f_schqMqmjHtml" value="0" id="f_schqMqmjHtml" />
			  </div>
            </td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="56%" bgcolor="e8f2ff"><strong>标题</strong></td>
            <td width="14%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>日期</strong></span></div></td>
            <td width="11%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否显示</strong></span></div></td>
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
            <td><a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','win',800,600)"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub")).equals("1")?"显示":"不显示"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../rent/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div></td>
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
	pool3.freeConnection(conn);	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
