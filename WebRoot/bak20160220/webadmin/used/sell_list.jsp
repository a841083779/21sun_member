<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool4 = new PoolManager(4);
Connection conn =null;

String find_category = Common.getFormatStr(request.getParameter("find_category"));

//======生成首页求、出租信息静态页===
if(Common.getFormatInt(request.getParameter("f_indexHtml")).equals("1")){
   UsedToHtml usedToHtml=new UsedToHtml();
   usedToHtml.indexAllHtml(request, pool4,"700902");
} 

//======生成主站首页求、出租信息静态页===
if(Common.getFormatInt(request.getParameter("f_mainIndexHtml")).equals("1")){
   MainUsedToHtml usedToHtml=new MainUsedToHtml();
   usedToHtml.indexAllHtml(request, pool4,"700902");
}
//======生成完毕==== 
//=====页面属性====
String tablename="sell_new";
String pageSubName="sell_opt.jsp";

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

HashMap<String,String> categoryhp = new HashMap<String,String>();

categoryhp.put("1","挖掘机");
categoryhp.put("2","装载机");
categoryhp.put("3","起重机");
categoryhp.put("4","压路机");
categoryhp.put("5","推土机");
categoryhp.put("6","摊铺机");
categoryhp.put("7","平地机");
categoryhp.put("8","混凝土");
categoryhp.put("99","其它设备");
categoryhp.put("9","其它设备");
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
//得到参数 测试
String findTitle=Common.getFormatStr(request.getParameter("findTitle"));
if(!findTitle.equals("")){
	query.append(" and title like '%"+findTitle+"%'");
}
 
 String find_mem_no=Common.getFormatStr(request.getParameter("find_mem_no"));
if(!find_mem_no.equals("")){
	query.append(" and mem_no ='"+find_mem_no+"'");
}

String find_date_start=Common.getFormatStr(request.getParameter("find_date_start"));
if(!find_date_start.equals("")){
	query.append(" and CONVERT(varchar(12) ,add_date, 23 ) >='"+find_date_start+"' ");
}
String find_date_end=Common.getFormatStr(request.getParameter("find_date_end"));
if(!find_date_end.equals("")){
	query.append(" and CONVERT(varchar(12) ,add_date, 23 )<='"+find_date_end+"' ");
}
if(!find_category.equals("")){
   query.append(" and category ='"+find_category+"' ");
}

query.append(" order by add_date desc");
try{  
conn = pool4.getConnection();
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
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function setFlag(flag){
			var checkdel = document.getElementsByName('checkdel');
			var checkedFlag=false;
				for(i=0;i<checkdel.length;i++){
					if(checkdel[i].checked){
					  checkedFlag = true;
					}
				}
				if(checkedFlag){
					if(confirm("确定这样操作吗？")){
						theform.action = "tool.jsp?flag="+flag;
						theform.target = "hiddenFrame";
						theform.method = "post";
						theform.submit();
					}
				}else{
				  alert("请选择要更新的信息！");
				}	
	 }
</script>
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
            <td width="65%" align="center" nowrap="nowrap"><span class="title1">会员编号：
                <input name="find_mem_no" type="text" id="find_mem_no" value="<%=find_mem_no%>" size="15" maxlength="15" />
              标题：
            <input name="findTitle" type="text" id="findTitle" value="<%=findTitle%>" />
			类别：<select name="find_category" id="find_category" ><option value="">请选择类别</option><option value="1" <%=find_category.equals("1")?"selected":""%>>挖掘机</option><option value="2" <%=find_category.equals("2")?"selected":""%>>装载机</option><option value="3" <%=find_category.equals("3")?"selected":""%>>起重机</option><option value="4" <%=find_category.equals("4")?"selected":""%>>压路机</option><option value="5" <%=find_category.equals("5")?"selected":""%>>推土机</option><option value="6" <%=find_category.equals("6")?"selected":""%>>摊铺机</option><option value="7" <%=find_category.equals("7")?"selected":""%>>平地机</option><option value="8" <%=find_category.equals("8")?"selected":""%>>混凝土</option><option value="9" <%=(find_category.equals("9") || find_category.equals("other"))?"selected":""%>>其它设备</option></select>
			起止时间
			  <input name="find_date_start" type="text" id="find_date_start" size="15" value="<%=find_date_start%>" onfocus="calendar(event)"/>			  ~
			  <input name="find_date_end" type="text" id="find_date_end" size="15" value="<%=find_date_end%>" onfocus="calendar(event)"/>
			  <input type="submit" name="Submit" value="查询" />
			  <input type="button" name="Submit2" value="清空" onclick="javascript:clearForm()" />
              </span>
              <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
			    <input type="button" id="hot" name="hot" value="批量删除" onclick="setFlag(1);"/>
				<input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,600)"/>					
				<input name="b_createIndexHtml" type="button" id="b_createIndexHtml" value="生成二手首页求购静态页" onclick="javascript:createIndexHtml();" style="visibility:hidden;" />
				<input type="hidden" name="f_indexHtml" value="0" id="f_indexHtml" />
				<input name="b_createMainIndexHtml" type="button" id="b_createMainIndexHtml" value="生成主站二手首页求购静态页" onclick="javascript:createMainIndexHtml();" style="visibility:hidden;"/>
				<input type="hidden" name="f_mainIndexHtml" value="0" id="f_mainIndexHtml" />			  
		    </td>
			  
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
		     <td width="2%" height="30" align="center" bgcolor="e8f2ff">
			  <input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			</td>
            <td width="2%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="34%" bgcolor="e8f2ff"><strong>标题</strong></td>
            <td width="11%" bgcolor="e8f2ff">会员账号/名称</td>
			<td width="6%" bgcolor="e8f2ff"> <div align="center">类别</div></td>
            <td width="22%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>日期</strong></span></div></td>
            <td width="5%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否发布</strong></span></div></td>
            <td width="18%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
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
            <td title="<%=Common.getFormatStr(rs.getString("id"))%>"><a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','',800,600)"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
            <td><a href="#" onclick="openWin('../member/member_opt.jsp?mem_no=<%=Common.getFormatStr(rs.getString("mem_no"))%>','',750,600)"><%=Common.getFormatStr(rs.getString("mem_no"))%>/<%=Common.getFormatStr(rs.getString("mem_name"))%></a></td>
			<td align="center"><div align="center"><%=Common.getFormatStr(categoryhp.get(Common.getFormatStr(rs.getString("category"))))%></div></td>
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub")).equals("1")?"显示":"不显示"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../used/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','',800,600)">修改</a></span></div></td>
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
	pool4.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
