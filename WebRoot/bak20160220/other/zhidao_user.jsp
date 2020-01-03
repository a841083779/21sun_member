<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%>

<%
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String uid = memberInfo.get("mem_no").toString();
//===调租赁库====
PoolManager pool3 = new PoolManager(10);
Connection conn =null;
DataManager dm = new DataManager();
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}


String site_flag="8";

StringBuffer query =new StringBuffer("select * from zhidao_exp where mem_no = '"+uid+"'");

try{
conn = pool3.getConnection();
//SQL查询	
ResultSet jf = dm.executeQuery(conn,query.toString());
int zjf = 0;
int zje = 0;
int addf = 0;
int minf = 0;
if(jf!=null&&jf.next()){
	zjf = Integer.parseInt(Common.getFormatInt(jf.getString("point")));
	zje = Integer.parseInt(Common.getFormatInt(jf.getString("golds")));
	addf = Integer.parseInt(Common.getFormatInt(jf.getString("add_golds")));
	minf = Integer.parseInt(Common.getFormatInt(jf.getString("min_golds")));
}
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>知道个人中心</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	* { margin:0; padding:0;}
	body { font-size:12px; font-family:Arial; background:#fff;}
	td,th { line-height:22px; font-size:12px;}
	.title { background:url(../images/25dexian.gif) top repeat-x; height:25px; line-height:25px; padding-left:10px; border:#B8CFE0 1px solid; overflow:hidden; margin-bottom:0px; }
	.title h5 { height:25px; line-height:25px; color:#666666;} 
	.table01 { background:#B8CFE0; margin-bottom:10px;}
	.table01 th { background:#eee; font-size:12px; color:#333; padding:2px 5px;}
	.table01 td { background:#fff; padding:2px 5px; font-size:12px; text-align:center; font-family:Arial;}
	.table00 { background:#B8CFE0; margin-bottom:10px;}
	.table00 td { background:#fff; padding:2px 5px; font-size:12px; text-align:left; font-family:Arial;}
	</style>
  </head>
  
  <body>
  <div class="title">
  <h5 >基本资料:</h5>
  </div>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table00">
  <tr>
  <td style="font-size:13px; color:#666666">总积分：<%=zjf %></td>
  </tr>
  <tr>
  <%
  String type = "";
  int need = 0;
  	int num = zjf;
  	if(num<80){
  		type = "书童";
  		need = 80 - num;
  	}else if(num>=80&&num<400){
  		type = "书生";
  		need = 400 - num;
  	}
  	else if(num>=400&&num<800){
  		type = "秀才";
  		need = 800 - num;
  	}else if(num>=800&&num<2000){
  		type = "举人";
  		need = 2000 - num;
  	}else if(num>=2000&&num<4000){
  		type = "解元";
  		need = 4000 - num;
  	}else if(num>=4000&&num<7000){
  		type = "贡士";
  		need = 7000 - num;
  	}else if(num>=7000&&num<10000){
  		type = "会元";
  		need = 10000 - num;
  	}else if(num>=10000&&num<14000){
  		type = "同进士出身";
  		need = 14000 - num;
  	}else if(num>=14000&&num<18000){
  		type = "大学士";
  		need = 18000 - num;
  	}else if(num>=18000&&num<22000){
  		type = "探花";
  		need = 22000 - num;
  	}else if(num>=22000&&num<32000){
  		type = "榜眼";
  		need = 32000 - num;
  	}else if(num>=32000&&num<45000){
  		type = "状元";
  		need = 45000 - num;
  	}else if(num>=45000&&num<60000){
  		type = "偏修";
  		need = 60000 - num;
  	}else if(num>=60000&&num<100000){
  		type = "府丞";
  		need = 100000 - num;
  	}else if(num>=100000&&num<150000){
  		type = "翰林学士";
  		need = 150000 - num;
  	}else if(num>=150000&&num<250000){
  		type = "御史中丞";
  		need = 250000 - num;
  	}else if(num>=250000&&num<400000){
  		type = "詹士";
  		need = 400000 - num;
  	}else if(num>=400000&&num<700000){
  		type = "侍郎";
  		need = 700000 - num;
  	}else if(num>=700000&&num<1000000){
  		type = "大学士";
  		need = 1000000 - num;
  	}else if(num>=1000000){
  		type = "文曲星";
  		need = 9999999;
  	}
   %>
  <td style="font-size:13px; color:#666666">当前等级：<%=type %></td>
  </tr>
  <tr>
  <td style="font-size:13px; color:#666666">下一级还需积分：<%=need %></td>
  </tr>
  </table>
  <div class="title">
  <h5 >积分统计:</h5>
  </div>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table01">
  <tr>
  <th>总分</th>
  <th>总金币</th>
  <th>悬赏得分</th>
  <th>悬赏扣分</th>
  </tr>
  <tr>
  <td><%=zjf %></td>
  <td><%=zje %></td>
  <td><%=addf %></td>
  <td><%=minf %></td></tr>
  </table>
  <div class="title">
  <h5>知道明细:</h5>
  </div>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table01">
  <tr>
  <th>回答数</th>
  <th>采纳率</th>
  <th>提问数</th></tr>
  <tr>
  <%
  ResultSet hds = dm.executeQuery(conn,"select count(id) as num from zhidao_ans where mem_no = '"+uid+"'");
   hds.next();
   %>
  <td><%=Common.getFormatInt(hds.getString("num")) %></td>
  <%
  ResultSet cnl = dm.executeQuery(conn,"select count(id) as num from zhidao_ans where mem_no = '"+uid+"' and best = 1");
  cnl.next();
  int n = 0;
  if(Integer.parseInt(Common.getFormatInt(hds.getString("num")))>0){
  	n = Integer.parseInt(Common.getFormatInt(cnl.getString("num")))/Integer.parseInt(Common.getFormatInt(hds.getString("num")));
  }
   %>
  <td><%=n %></td>
  <%
  ResultSet tws = dm.executeQuery(conn,"select count(id) as num from zhidao_post where mem_no = '"+uid+"'");
   tws.next();
   %>
  <td><%=Common.getFormatInt(tws.getString("num")) %></td>
  </tr>
  </table>
  <a href="http://zhidao.21-sun.com" target="_blank"><font style="background-color:#FFFFFF; border-style:none;color:#FF0000; font-weight:bold; font-size:15px;">前往铁臂知道</font></a>
    </body>
  
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool3.freeConnection(conn);
	
	conn =null;
	offset=null;
	query=null;
}%>