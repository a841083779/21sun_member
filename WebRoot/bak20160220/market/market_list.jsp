<%@page contentType="text/html;charset=utf-8" import="java.net.URLEncoder,java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" %>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.CommonString"%><%@ include file ="/manage/config.jsp"%><%
    HashMap memberInfo = (HashMap) session.getAttribute("memberInfo");
	String mem_flag = CommonString.getFormatPara(memberInfo.get("mem_flag")) ;
	String state2 = CommonString.getFormatPara(memberInfo.get("state2")) ;//限定状态
	pool = new PoolManager(5);
	Connection conn =null;
	String tablename="sell_buy_market";
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(18);
	//分页中当前记录
	String offset=Common.getFormatStr(request.getParameter("offset"));
	if(offset.equals("")){ 
		offset="0";
	}
	String find_title    = Common.getFormatStr(request.getParameter("find_title"));   //标题
	StringBuffer query = new StringBuffer("select id,title,pub_date,view_count,business_flag,probrand,probrandname,is_review,reviewContent  from "+tablename+" where mem_no = '"+(String)adminInfo.get("mem_no")+"' ");
	if(!find_title.equals("")){
		query.append(" and title like '%"+find_title+"%'");
	}
	query.append(" order by rec_index desc, pub_date desc,id desc");
	//query.append(" order by rec_index desc,orderno desc");
	DBHelper dbHelper = DBHelper.getInstance() ;
	String rec_index_id = "" ;
	try{
	conn = pool.getConnection();  //SQL查询
		
	// 已推荐到首页的产品 id
	String rec_sql = "select top 1 id,title,pub_date,view_count,business_flag,probrand,probrandname,is_review,reviewContent  from "+tablename+" where mem_no = '"+(String)adminInfo.get("mem_no")+"' and rec_index=1" ;
	if(!find_title.equals("")){
		find_title += " and title like '%"+find_title+"%'";
	}
	rec_index_id = CommonString.getFormatPara(dbHelper.getMap(rec_sql,conn)==null?"":dbHelper.getMap(rec_sql,conn).get("id")) ;
	ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1); 
	String bar = pagination.paginationPrint();  //读取分页提示栏
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/tablestyle.css" rel="stylesheet" type="text/css" />
<link href="../style/style_new.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/scripts/jBox/Skins/Blue/jbox.css" type="text/css"></link>
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
  <div class="Tips"><strong>温馨提示：</strong>点击左侧的“我要买”或“我要卖”，可以免费发布供求信息。为了让客户更快捷地找到您，快速达成交易，请先完善您的“个人资料”。<strong><a href="/manage/memberinfo_new.jsp" target="_top">去完善</a></strong>。
<% if(!state2.equals("1")){ %>“批量更新”操作将使您的信息靠前显示，请及时更新。<%} %>
</div>
  <div class="TabTitleA">
    <ul id="myTab2">
      <li class="activeA" ><% if(mem_flag.equals("1003")){ %>近期信息<%}else{ %>一个月内<%} %></li>
      <li class="normalA" onclick="window.location.href='market_list_ago.jsp'"><% if(mem_flag.equals("1003")){ %>历史信息<%}else{ %>一个月前<%} %></li>
    </ul>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>标题:<input type="text" name="find_title" id="find_title" value="<%=find_title%>" />&nbsp;&nbsp;<input type="submit" name="Submit" value=""style="width: 52px; height: 19px; border: none; background: url(../images/bottom06.gif) left top no-repeat; cursor: pointer;">&nbsp;&nbsp;		            	<input type="button" name="Submit2" value=""style="width: 52px; height: 19px; border: none; background: url(../images/bottom07.gif) left top no-repeat; cursor: pointer;" onClick="javascript:clearForm()"></td>
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
  <% if(!state2.equals("1")){ %> 
  	<a href="javascript:setFlag('0');" style="width:80px;float:left" title="批量更新信息的发布时间，以便让信息在前面显示"><img src="../images/plgx.gif" border="0"/></a>
  <%} %>
    <input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:64px;height:29px;border:none;background:url(../images/bottom03.gif) left top no-repeat;cursor: pointer;" onclick="window.location.href='market_opt_freemaker.jsp?addflag=1'" />
     <%
   	if(mem_flag.equals("1003")){
   		%>
      &nbsp;<font color='red'>(  <b>A类会员</b> 只能推荐一条信息到供求首页，一般推荐15分钟后生效。)</font>
      <%
        	}
      %>
    </div>
    <table width="100%" border="0" class="list">
      <tr>
	  	<th width="5%" align="center"><input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" /></th>
        <th width="4%">ID</th>
        <th width="45%">信息标题<font color="#c90000">(点击预览信息)</font></th>
        <th width="12%">发布日期</th>
        <th width="9%">审核通过</th>
        <th width="25%"><div align="center">操作</div></th>
      </tr>
      <%
		 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
		 while (rs!=null && rs.next()){
		 	k=k+1;
			
			String is_review=Common.getFormatStr(rs.getString("is_review"));
			String shenhe="通过";
			String reviewContent=Common.getFormatStr(rs.getString("reviewContent"));
			
			if(is_review.equals("1")){
				shenhe="<span style='color:blue'>通过</span>";
			}else if(is_review.equals("-1")){
				shenhe="<span style='color:red'>未通过</span>";
			}else {
				shenhe="<span style='color:blue'>通过</span>";
			}
	  %>
      <tr>
	  	<td height="30" align="center">
	    <input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" /></td>
        <td><%=k%></td>
        <td><a href="http://market.21-sun.com/viewSellBuy_for_<%=rs.getString("id")%>.htm" class="blue14" target="_blank" title="<%=Common.getFormatStr(rs.getString("title"))%>"><%=Common.getFormatStandard(rs.getString("title"),3,28)%></a></td>
        <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date"))%></td>
        <td><%=shenhe%>&nbsp;<%if(is_review.equals("-1")){%><a href='javascript:void(0);' title="点击查看未审核未通过原因" onclick='showInfo("<%=reviewContent%>");'><img style='vertical-align:-3px;' src='http://member.21-sun.com/home/used/images/help.gif' /></a><%}%></td>
        <td><!--<a href="javascript:otherDeleteData('../market/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp;-->
        <div align="center">
	        <%
	        if(mem_flag.equals("1003")){
	        		String recommendString = "推荐到首页";
	        		if(!rec_index_id.equals("")){
	        			if(!rec_index_id.equals(rs.getString("id"))){
	        				recommendString = "";
	        			}else{
		        			recommendString = "<font color='red'>取消推荐到首页</font>";
		        		}
	        		}
	        %>
	        	<a href="javascript:;" rid='<%=rs.getString("id") %>' name="recToIndex" style="color:blue;"><%=recommendString %></a>
	        <%
	        }
	        %>
        <a href="market_opt_freemaker.jsp?addflag=<%=Common.getFormatStr(rs.getString("business_flag")).equals("10")?"1":"7"%>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>&probrand=<%=Common.getFormatStr(rs.getString("probrand")) %>&probrandname=<%= URLEncoder.encode(Common.getFormatStr(rs.getString("probrandname")),"utf-8")%>">修改</a>&nbsp;&nbsp;
        <% if(!state2.equals("1")){ %> 
        	<a href="update_pubdate.jsp?mypy=<%=Common.encryptionByDES(tablename)%>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>&urlpath=market_list.jsp">更新</a>
        <%} %>
                </div></td>
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
<script type="text/javascript" src="/scripts/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript">
	//jQuery(function(){
	//	jQuery.each(jQuery("a[name='recToIndex']"),function(){
	//		if(''!='<%=rec_index_id%>' && '<%=rec_index_id%>'!=jQuery(this).attr("rid")){
	//			jQuery(this).html("") ;
	//		}else if(''!='<%=rec_index_id%>' && '<%=rec_index_id%>'==jQuery(this).attr("rid")){
	//			jQuery(this).html("<font color='red'>\u53D6\u6D88\u63A8\u8350\u5230\u9996\u9875</font>") ;
	//		}
	//	}) ;
	//}) ;
	jQuery("a[name='recToIndex']").toggle(function(){
		var _rid = jQuery(this).attr("rid") ;
		var _html = jQuery(this).text() ;
		var _value = 1 ;
		if(_html=='\u53D6\u6D88\u63A8\u8350\u5230\u9996\u9875'){
			_value = 0 ;
		}
		jQuery.ajax({
			url:'/tools/ajax.jsp',
			data:{'rid':_rid,'flag':'recToIndex',value:_value},
			success:function(msg){
				if(jQuery.trim(msg)=='1'){
					if(_html=='\u53D6\u6D88\u63A8\u8350\u5230\u9996\u9875'){
					   jQuery("a[name='recToIndex']").html("\u63A8\u8350\u5230\u9996\u9875") ;
					}else{
					     jQuery("a[name='recToIndex']").html("") ;
					    jQuery("a[rid='"+_rid+"']").html("<font color='red'>\u53D6\u6D88\u63A8\u8350\u5230\u9996\u9875</font>") ;
				     } 
				}
			}
		}) ;
	},
	function(){
		var _rid = jQuery(this).attr("rid") ;
		var _value = 0 ;
		var _html = jQuery(this).text() ;
		if(_html=='\u63A8\u8350\u5230\u9996\u9875'){
			_value = 1 ;
		}
		jQuery.ajax({
			url:'/tools/ajax.jsp',
			data:{'rid':_rid,'flag':'recToIndex',value:_value},
			success:function(msg){
				if(jQuery.trim(msg)=='1'){
					if(_html=='\u53D6\u6D88\u63A8\u8350\u5230\u9996\u9875'){
					jQuery("a[name='recToIndex']").html("\u63A8\u8350\u5230\u9996\u9875") ;
					}else{
					    jQuery("a[name='recToIndex']").html("") ;
					    jQuery("a[rid='"+_rid+"']").html("<font color='red'>\u53D6\u6D88\u63A8\u8350\u5230\u9996\u9875</font>") ;
				     }
				}
			}
		}) ;
	}) ;
	
	
	function showInfo(str){
		$.jBox.info(str,"管理员回复",{
			top : "5%"
		});
	}
</script>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
