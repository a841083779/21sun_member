<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.net.URLEncoder"%><%@page contentType="text/html;charset=utf-8"	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.util.*"%>
<%@ include file ="/manage/config.jsp"%>
<%
pool = new PoolManager(13);
Connection conn =null;
//String tablename="sell_buy_market_ago";
String tablename = (String)adminInfo.get("mem_no");
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(18);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
String find_title    = Common.getFormatStr(request.getParameter("find_title"));   //标题

StringBuffer query = new StringBuffer("select id,title,pub_date,view_count,business_flag from ["+tablename+"] where mem_no = '"+(String)adminInfo.get("mem_no")+"' and is_show = 1 ");

if(!find_title.equals("")){query.append(" and title like '%"+find_title+"%'");}

query.append(" order by orderno desc");

try{
conn = pool.getConnection();  //SQL查询

//查询表是否存在-begin
String sql = "select name from sysobjects where xtype='u' and name='"+tablename+"'";
ResultSet rs2 = DataManager.executeQuery(conn, sql);
String isexist = "";
if(rs2!=null && rs2.next()){
	isexist = rs2.getString("name");
}
String queryString = query.toString();
if(isexist.equals("")){
	//如果不存在，设置个查询为空的sql语句，防止报错
	queryString = sql;
}
//查询表是否存在-end

/*gaopeng add at 20131205 begin --查询三个月内供求数量*/
//String[][] threeCountSellandBuy = DataManager.fetchFieldOneValue(pool,
//			"sell_buy_market", "count(*)",
//			" mem_no = '"+(String)adminInfo.get("mem_no")+"' and is_show=1 "); // 查询出会员3月前发出卖买的数量
/*gaopeng add at 20131205 end --查询三个月内供求数量*/


ResultSet rs = pagination.getQueryResult(queryString, request,conn,1);
String bar = pagination.paginationPrint();  //读取分页提示栏
HashMap memberInfo = (HashMap) session.getAttribute("memberInfo");
String mem_flag = CommonString.getFormatPara(memberInfo.get("mem_flag")) ; // 会员级别

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/tablestyle.css" rel="stylesheet" type="text/css" />
<link href="../style/style_new.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
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
				document.theform.action = "tool.jsp";
				document.theform.target = "hiddenFrame";
				document.theform.method = "post";
				document.theform.submit();
	    	}
	   }else{
		  alert("请选择要更新的信息！");
	   }	
	}
</script>
<script type="text/javascript">
function nTabsA(thisObj,Num){
if(thisObj.className == "activeA")return;
var tabObj = thisObj.parentNode.id;
var tabList = document.getElementById(tabObj).getElementsByTagName("li");
for(i=0; i <tabList.length; i++)
{
if (i == Num)
{
   thisObj.className = "activeA"; 
      document.getElementById(tabObj+"_ContentA"+i).style.display = "block";
}else{
   tabList[i].className = "normalA"; 
   document.getElementById(tabObj+"_ContentA"+i).style.display = "none";
}
} 
}
</script>
</head>
<body style="background-color:transparent;">
<form action="" method="get" name="theform" id="theform">
<div class="loginlist_right">
  <div class="Tips"><strong>温馨提示：</strong>点击左侧的“我要买”或“我要卖”，可以免费发布供求信息。为了让客户更快捷地找到您，快速达成交易，请先完善您的“个人资料”。<strong><a href="/manage/memberinfo_new.jsp" target="_top">去完善</a></strong>。</div>
  <div class="TabTitleA">
    <ul id="myTab2">
      <li class="normalA" onclick="window.location.href='market_list.jsp'"><% if(mem_flag.equals("1003")){ %>近期信息<%}else{ %>一个月内<%} %></li>
      <li class="activeA" ><% if(mem_flag.equals("1003")){ %>历史信息<%}else{ %>一个月前<%} %></li>
    </ul>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>标题:<input type="text" name="find_title" id="find_title" value="<%=find_title%>" />&nbsp;&nbsp;<input type="submit" name="Submit" value=""style="width: 52px; height: 19px; border: none; background: url(../images/bottom06.gif) left top no-repeat; cursor: pointer;">&nbsp;&nbsp;		            	<input type="button" name="Submit2" value=""style="width: 52px; height: 19px; border: none; background: url(../images/bottom07.gif) left top no-repeat; cursor: pointer;" onClick="javascript:clearForm()">
        </td>
      </tr>
    </table>
  </div>
  <div class="TabContentA">
    <div id="myTab2_ContentA0">
    
    </div>
    <div id="myTab2_ContentA1" class="none">
    
    </div>
  </div>
  <div class="loginlist_right1">
  <div class="title_bar" style="padding:10px 0px;"> 
    </div>
    <table width="100%" border="0" class="list">
      <tr>
	  	<th width="2%" align="center"><input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" /></th>
        <th width="4%">ID</th>
        <th>信息标题(点击预览)</th>
        <th width="15%">发布日期</th>
        <th width="15%"><div align="center">操作</div></th>
      </tr>
      <%
		 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
		 while (rs!=null && rs.next()){
		 	k=k+1;
	  %>
      <tr>
	  	<td height="30" align="center">
	    <input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" /></td>
        <td><%=k%></td>
        <td><a href="http://market.21-sun.com/viewSellBuy_for_<%=rs.getString("id")%>_<%=URLEncoder.encode(tablename) %>.htm" class="blue14" target="_blank" title="<%=Common.getFormatStr(rs.getString("title"))%>"><%=Common.getFormatStandard(rs.getString("title"),3,28)%></a></td>
        <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date"))%></td>
        <td><div align="center">
        <a href="market_opt_freemaker_ago.jsp?addflag=<%=Common.getFormatStr(rs.getString("business_flag")).equals("10")?"1":"7"%>&tablename=<%= tablename %>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>">修改</a></div>
        </td>
      </tr>
      <%
}
%>
    </table>
    <table width="100%" border="0" class="list">
      <tr>
        <td align="left"><%out.println(pagination.pagesPrint(8));%></td>
      </tr>
    </table>
  </div>
</div> <input name="tablename" id="tablename"  type="hidden" value="<%=Common.encryptionByDES(tablename)%>"/>
  </form>
   <iframe name="hiddenFrame" style="display:none"></iframe>
</body>
<script type="text/javascript">
  function updateAgoOrdersMore(){
   var _checkval = '' ;
  	jQuery("input[name='checkdel']:checked").each(function(){
  		_checkval += jQuery(this).val()+"," ;
  	}) ;
  	if(_checkval.length>0){
  		updateAgoOrder(_checkval) ;
  	}
  }
	function updateAgoOrder(oid){
		jQuery.ajax({
			type:'post',
			url:'/tools/ajax.jsp',
			data:{"flag":'updateAgoOrder',orderId:oid} ,
			success:function(msg){
			  if(jQuery.trim(msg)=='ok'){ 
			  	alert("更新成功！") ;
			  	window.location.reload() ;
			  }
			}
		}) ;
	}
</script>
</html>
<%
}catch(Exception e){
	e.printStackTrace();
}finally{
	pool.freeConnection(conn);
}
%>
