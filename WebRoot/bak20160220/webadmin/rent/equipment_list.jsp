<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool3 = new PoolManager(3);
Connection conn =null;
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

//======生成首页求、出租信息静态页===
if(Common.getFormatInt(request.getParameter("f_indexHtml")).equals("1")){
   UsedToHtml usedToHtml=new UsedToHtml();
   usedToHtml.indexAllHtml(request, pool3,"700901");
} 

//======生成主站首页求、出租信息静态页===
if(Common.getFormatInt(request.getParameter("f_mainIndexHtml")).equals("1")){
   MainUsedToHtml usedToHtml=new MainUsedToHtml();
   usedToHtml.indexAllHtml(request, pool3,"700901");
}
//======生成完毕====  

//=====页面属性====
String tablename="equipment";
String pageSubName="equipment_opt.jsp";

//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

String is_recom = Common.getFormatStr(request.getParameter("is_recom"));


StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");
//得到参数 测试
String findTitle=Common.getFormatStr(request.getParameter("findTitle"));
if(!findTitle.equals("")){
	query.append(" and title like '%"+findTitle+"%'");
}

if(!is_recom.equals("")){
    query.append(" and is_recom ='"+is_recom+"' ");
}
String find_mem_no=Common.getFormatStr(request.getParameter("find_mem_no"));
if(!find_mem_no.equals("")){
	query.append(" and mem_no ='"+find_mem_no+"'");
}
 
try{
conn = pool3.getConnection();
//SQL查询
//System.out.print(query);
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
	   theform.submit();
   }
   function createMainIndexHtml(){
	   $("#f_mainIndexHtml").val("1");
	   theform.submit();
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
            <td width="65%" align="center" nowrap="nowrap"><span class="title1">会员账号：
                <input name="find_mem_no" type="text" id="find_mem_no" value="<%=find_mem_no%>" size="5" maxlength="15" />标题：
              <input name="findTitle" type="text" id="findTitle" value="<%=findTitle%>" />&nbsp;&nbsp;&nbsp;
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
				<!--<input name="b_createIndexHtml" type="button" id="b_createIndexHtml" value="生成二手首页设备静态页" onclick="javascript:createIndexHtml();" />
				<input type="hidden" name="f_indexHtml" value="0" id="f_indexHtml" />
				<input name="b_createMainIndexHtml" type="button" id="b_createMainIndexHtml" value="生成主站二手首页设备静态页" onclick="javascript:createMainIndexHtml();" />
				<input type="hidden" name="f_mainIndexHtml" value="0" id="f_mainIndexHtml" />-->		  
		    </td>
			  
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="34%" bgcolor="e8f2ff"><strong>标题</strong></td>
            <td width="15%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>日期</strong></span></div></td>
            <td width="11%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>型号</strong></span></div></td>
            <!--<td width="8%" align="center" bgcolor="e8f2ff"><strong>是否竞拍</strong></td>-->
            <td width="9%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否发布</strong></span></div></td>
            <td width="20%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 String is_recom1 ="",model="";
 while (rs!=null && rs.next()){
   k=k+1;
   is_recom1        = Common.getFormatStr(rs.getString("is_recom"));
   mem_flag = Common.getFormatStr(rs.getString("mem_flag"));
   model = Common.getFormatStr(rs.getString("model"));
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td title="<%=Common.getFormatStr(rs.getString("id"))%>"><a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','',800,600)"><%=Common.getFormatStr(rs.getString("title"))%></a><font color='#FF0000'><%if(!mem_flag.equals("-1")){out.print(Common.getFormatStr(memFlaghp.get(mem_flag)));}%></font></td>
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></div></td>
			<td align="center"><div align="center"><%=model%></div></td>
           <!-- <td align="center"><%=""%></td>-->
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub")).equals("1")?"显示":"不显示"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../rent/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','',800,600)">修改</a></span> &nbsp;&nbsp;<!-- <a href="#" onclick="openWin('equipment_auction_list.jsp?find_equipment_id=<%=rs.getString("id")%>','win',800,600)">竞拍过程</a>--></div></td>
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
