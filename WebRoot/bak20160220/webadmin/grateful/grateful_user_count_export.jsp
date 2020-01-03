<%@page contentType="text/html;charset=utf-8" import="com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.*,java.net.*"%> 
<%
String titlename="各类奖项获奖统计";	
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename="+new String((titlename).getBytes(),"iso8859-1")+".xls"); 
%>
<%
	PoolManager pool = (PoolManager)application.getAttribute("poolAPP");
	if(pool == null){
		pool = new PoolManager();
	}
	DataManager dataManager = new DataManager();
	Connection conn = null;

	try{
		conn = pool.getConnection();
		String count1 = "";
		String count2 = "";
		String count3 = "";
		String count4 = "";
		String count5 = "";
		String count6 = "";
		String count101 = "";
		String count102 = "";
		String count103 = "";
		String count104 = "";
		String count105 = "";

		//各奖项统计
		//1
		String countStr1 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,1,%' or jiang_chuli like'%,1,%')";
		ResultSet rs1 = dataManager.executeQuery(conn,countStr1);
		while(rs1.next()){
			count1=Common.getFormatStr(rs1.getString("count"));
		}
		//2
		String countStr2 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,2,%' or jiang_chuli like'%,2,%')";
		ResultSet rs2 = dataManager.executeQuery(conn,countStr2);
		while(rs2.next()){
			count2=Common.getFormatStr(rs2.getString("count"));
		}
		//3
		String countStr3 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,3,%' or jiang_chuli like'%,3,%')";
		ResultSet rs3 = dataManager.executeQuery(conn,countStr3);
		while(rs3.next()){
			count3=Common.getFormatStr(rs3.getString("count"));
		}
		//4
		String countStr4 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,4,%' or jiang_chuli like'%,4,%')";
		ResultSet rs4 = dataManager.executeQuery(conn,countStr4);
		while(rs4.next()){
			count4=Common.getFormatStr(rs4.getString("count"));
		}
		//5
		String countStr5 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,5,%' or jiang_chuli like'%,5,%')";
		ResultSet rs5 = dataManager.executeQuery(conn,countStr5);
		while(rs5.next()){
			count5=Common.getFormatStr(rs5.getString("count"));
		}
		//6
		String countStr6 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,6,%' or jiang_chuli like'%,6,%')";
		ResultSet rs6 = dataManager.executeQuery(conn,countStr6);
		while(rs6.next()){
			count6=Common.getFormatStr(rs6.getString("count"));
		}
		//101
		String countStr101 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,101,%' or jiang_chuli like'%,101,%')";
		ResultSet rs101 = dataManager.executeQuery(conn,countStr101);
		while(rs101.next()){
			count101=Common.getFormatStr(rs101.getString("count"));
		}
		//102
		String countStr102 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,102,%' or jiang_chuli like'%,102,%')";
		ResultSet rs102 = dataManager.executeQuery(conn,countStr102);
		while(rs102.next()){
			count102=Common.getFormatStr(rs102.getString("count"));
		}
		//103
		String countStr103 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,103,,%' or jiang_chuli like'%,103,%')";
		ResultSet rs103 = dataManager.executeQuery(conn,countStr103);
		while(rs103.next()){
			count103=Common.getFormatStr(rs103.getString("count"));
		}
		//104
		String countStr104 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,104,%' or jiang_chuli like'%,104,%')";
		ResultSet rs104 = dataManager.executeQuery(conn,countStr104);
		while(rs104.next()){
			count104=Common.getFormatStr(rs104.getString("count"));
		}
		//105
		String countStr105 = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null) and mem_name is not null and mem_name<>'' and (jiang like'%,105,%' or jiang_chuli like'%,105,%')";
		ResultSet rs105 = dataManager.executeQuery(conn,countStr105);
		while(rs105.next()){
			count105=Common.getFormatStr(rs105.getString("count"));
		}
%>
<HTML>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head><title>Test</title></head>
<body>
<table>
          <tr>
            <td>奖品</td>
            <td>数量</td>
          </tr>
          <tr>
            <td>套餐优惠券</td>
            <td><%=count1 %></td>
          </tr>
           <tr>
            <td>会员优惠券</td>
            <td><%=count2 %></td>
          </tr>
           <tr>
            <td>杰配网优惠券</td>
            <td><%=count3 %></td>
          </tr>
           <tr>
            <td>人才网优惠券</td>
            <td><%=count4 %></td>
          </tr>
           <tr>
            <td>21-sun卡盘</td>
            <td><%=count5 %></td>
          </tr>
           <tr>
            <td>21-sun阳光宝宝便签夹</td>
            <td><%=count6 %></td>
          </tr>
           <tr>
            <td>挖掘机报告券</td>
            <td><%=count101 %></td>
          </tr>
           <tr>
            <td>装载机报告券</td>
            <td><%=count102 %></td>
          </tr>
          <tr>
            <td>推土机报告券</td>
            <td><%=count103 %></td>
          </tr>
          <tr>
            <td>压路机报告券</td>
            <td><%=count104 %></td>
          </tr>
          <tr>
            <td>起重机报告券</td>
            <td><%=count105 %></td>
          </tr>
</table>
</body>
</HTML>
<%

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
	%>
