<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	PoolManager poolManager = new PoolManager(4);
	Connection connection = null;
	ResultSet rs = null;
	try{
		connection = poolManager.getConnection();
		Integer equi_count = 0;
		Integer sell_count = 0;
		Integer buy_count = 0;
		Integer sbxj_count = 0;
		Integer sbxj_wei_du_count = 0;
		Integer csly_count = 0;
		Integer csly_wei_du_count = 0;
		Integer bjly_count = 0;
		Integer bjly_wei_du_count = 0;
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_equipment where mem_no = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			equi_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_sell where mem_no = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			sell_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_buy where mem_no = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			buy_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_buy where mem_no = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			buy_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		/*消息*/
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_message where flag = 1 and rev_user = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			sbxj_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_message where flag = 1 and is_read = 0 and rev_user = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			sbxj_wei_du_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_message where flag = 3 and rev_user = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			csly_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_message where flag = 3 and is_read = 0 and rev_user = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			csly_wei_du_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_message where flag = 4 and rev_user = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			bjly_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		rs = DataManager.executeQuery(connection," select count(id) as counts from used_message where flag = 4 and is_read = 0 and rev_user = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs&&rs.next()){
			bjly_wei_du_count = rs.getInt("counts");
		}
		if(null!=rs){
			rs.close();
		}
		/*消息*/
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>主页</title>
	<link href="/style/style.css" rel="stylesheet" type="text/css" />
	<link href="/style/help.css" rel="stylesheet" type="text/css" />
</head>
<body style="text-align: left;">

	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color:#f7f7f7 ; border: 4px solid #eaf2fd">
	  <tr>
	    <td width="11%"><img src="/images/baobao.gif" style="width: 68px; height: 87px;" /></td>
	    <td width="89%" class="red18">
	    	<div>
	    		<span style="color:red;"><%=memberInfo.get("mem_name") %></span>，您好！今天是<%=Common.getToday("yyyy年MM月dd日") %>，欢迎您来到<a href="http://www.21-used.com/" target="_blank" style="text-decoration: underline;">中国工程机械二手网</a>会员商务室！
	    	</div>
	    </td>
	  </tr>
	</table>
	<%
		if(sbxj_wei_du_count>0||csly_wei_du_count>0||bjly_wei_du_count>0){
			%>
	<div class="parthelp" style="width: 100%; margin: 0 auto; margin-top: 10px; border-left: none;">
	  <div class="parthelp_1">
	  <%
	  	if(sbxj_wei_du_count>0){
	  		%>
	    <div class="parthelp_2" style="height: 28px;">
	    	您有<span style="color:red;"><%=sbxj_wei_du_count %></span>条设备询价未进行阅读，请您注意查看！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/message_list.jsp?flag=1'" style="cursor:pointer">点击查看</span></div>
	  		<%
	  	}
	  	if(csly_wei_du_count>0){
	  		%>
	    <div class="parthelp_2" style="height: 28px;">
	    	您有<span style="color:red;"><%=csly_wei_du_count %></span>条出售留言未进行阅读，请您注意查看！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/message_list.jsp?flag=3'" style="cursor:pointer">点击查看</span></div>
	  		<%
	  	}
	  	if(bjly_wei_du_count>0){
	  		%>
	    <div class="parthelp_2" style="height: 28px;">
	    	您有<span style="color:red;"><%=bjly_wei_du_count %></span>条求购报价未进行阅读，请您注意查看！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/message_list.jsp?flag=4'" style="cursor:pointer">点击查看</span></div>
	  		<%
	  	}
	  %>
	  </div>
	  <div class="clear"></div>
	</div>
			<%
		}
	%>
	
	<div class="parthelp" style="width: 100%; margin: 0 auto; margin-top: 10px; border-left: none;">
	  <div class="parthelp_1">
	    <div class="yaheij1_1"><span onclick="window.location.href='/usedmarket/sale_opt.jsp'" style="cursor: pointer;">发布二手设备信息</span></div>
	    <div class="parthelp_2">
	    	您共计发布了<span style="color:red;"><%=equi_count %></span>条二手设备信息！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/sale_list.jsp'" style="cursor: pointer;">点击查看</span></div>
	  </div>
	  <div class="clear"></div>
	</div>
	
	<div class="parthelp" style="width: 100%; margin: 0 auto;margin-top: 10px; border-left: none;">
	  <div class="parthelp_1">
	    <div class="yaheij1_1"><span onclick="window.location.href='/usedmarket/sell_opt.jsp'" style="cursor: pointer;">发布出售商机信息</span></div>
	    <div class="parthelp_2">
	    	您共计发布了<span style="color:red;"><%=sell_count %></span>条出售商机信息！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/sell_list.jsp'" style="cursor: pointer;">点击查看</span></div>
	  </div>
	  <div class="clear"></div>
	</div>

	<div class="parthelp" style="width: 100%; margin: 0 auto;margin-top: 10px; border-left: none;">
	  <div class="parthelp_1">
	    <div class="yaheij1_1"><span onclick="window.location.href='/usedmarket/buy_opt.jsp'" style="cursor: pointer;">发布二手求购信息</span></div>
	    <div class="parthelp_2">
	  	  您共计发布了<span style="color:red;"><%=buy_count %></span>条二手求购信息！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/buy_list.jsp'" style="cursor: pointer;">点击查看</span></div>
	  </div>
	  <div class="clear"></div>
	</div>
	
	<div class="parthelp" style="width: 100%; margin: 0 auto;margin-top: 10px; border-left: none;">
	  <div class="parthelp_1">
	    <div class="yaheij1_1"><span onclick="window.location.href='/usedmarket/message_list.jsp?flag=1'" style="cursor: pointer;">查看设备询价信息</span></div>
	    <div class="parthelp_2">
	    	您共有<span style="color:red;"><%=sbxj_count %></span>条设备询价信息，其中有<span style="color:red;"><%=sbxj_wei_du_count %></span>条未读信息！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/message_list.jsp?flag=1'" style="cursor: pointer;">点击查看</span></div>
	  </div>
	  <div class="clear"></div>
	</div>
	
	<div class="parthelp" style="width: 100%; margin: 0 auto;margin-top: 10px; border-left: none;">
	  <div class="parthelp_1">
	    <div class="yaheij1_1"><span onclick="window.location.href='/usedmarket/message_list.jsp?flag=3'" style="cursor: pointer;">查看出售留言信息</span></div>
	    <div class="parthelp_2">
	    	您共有<span style="color:red;"><%=csly_count %></span>条设备询价信息，其中有<span style="color:red;"><%=csly_wei_du_count %></span>条未读信息！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/message_list.jsp?flag=3'" style="cursor: pointer;">点击查看</span></div>
	  </div>
	  <div class="clear"></div>
	</div>
	
	<div class="parthelp" style="width: 100%; margin: 0 auto;margin-top: 10px; border-left: none;">
	  <div class="parthelp_1">
	    <div class="yaheij1_1"><span onclick="window.location.href='/usedmarket/message_list.jsp?flag=4'" style="cursor: pointer;">查看求购报价信息</span></div>
	    <div class="parthelp_2">
	    	您共有<span style="color:red;"><%=bjly_count %></span>条设备询价信息，其中有<span style="color:red;"><%=bjly_wei_du_count %></span>条未读信息！
	    </div>
	    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="window.location.href='/usedmarket/message_list.jsp?flag=4'" style="cursor: pointer;">点击查看</span></div>
	  </div>
	  <div class="clear"></div>
	</div>
	
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		poolManager.freeConnection(connection);
	}
%>