<%@page contentType="text/html;charset=utf-8" import="com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.*,java.net.*"%> 
<%
String titlename="获奖用户行业统计";	
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
		String count7 = "";
		String count8 = "";
		String count9 = "";
		String count10 = "";

		//各奖项统计
		//1
		String countStr1 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,1,%'";
		ResultSet rs1 = dataManager.executeQuery(conn,countStr1);
		while(rs1.next()){
			count1=Common.getFormatStr(rs1.getString("count"));
		}
		//2
		String countStr2 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,2,%'";
		ResultSet rs2 = dataManager.executeQuery(conn,countStr2);
		while(rs2.next()){
			count2=Common.getFormatStr(rs2.getString("count"));
		}
		//3
		String countStr3 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,3,%'";
		ResultSet rs3 = dataManager.executeQuery(conn,countStr3);
		while(rs3.next()){
			count3=Common.getFormatStr(rs3.getString("count"));
		}
		//4
		String countStr4 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,4,%'";
		ResultSet rs4 = dataManager.executeQuery(conn,countStr4);
		while(rs4.next()){
			count4=Common.getFormatStr(rs4.getString("count"));
		}
		//5
		String countStr5 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,5,%'";
		ResultSet rs5 = dataManager.executeQuery(conn,countStr5);
		while(rs5.next()){
			count5=Common.getFormatStr(rs5.getString("count"));
		}
		//6
		String countStr6 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,6,%'";
		ResultSet rs6 = dataManager.executeQuery(conn,countStr6);
		while(rs6.next()){
			count6=Common.getFormatStr(rs6.getString("count"));
		}
		//7
		String countStr7 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,7,%'";
		ResultSet rs7 = dataManager.executeQuery(conn,countStr7);
		while(rs7.next()){
			count7=Common.getFormatStr(rs7.getString("count"));
		}
		//8
		String countStr8 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,8,%'";
		ResultSet rs8 = dataManager.executeQuery(conn,countStr8);
		while(rs8.next()){
			count8=Common.getFormatStr(rs8.getString("count"));
		}
		//9
		String countStr9 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,9,%'";
		ResultSet rs9 = dataManager.executeQuery(conn,countStr9);
		while(rs9.next()){
			count9=Common.getFormatStr(rs9.getString("count"));
		}
		//10
		String countStr10 = "select count(b.comp_mode) as count from member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no  where a.jiang is not NULL and a.mem_name is not null and a.mem_name<>'' and b.comp_mode like '%,10,%'";
		ResultSet rs10 = dataManager.executeQuery(conn,countStr10);
		while(rs10.next()){
			count10=Common.getFormatStr(rs10.getString("count"));
		}
%>
<HTML>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head><title>Test</title></head>
<body>
<table>
          <tr>
            <td>行业</td>
            <td>数量</td>
          </tr>
          <tr>
            <td>整机生产</td>
            <td><%=count1 %></td>
          </tr>
           <tr>
            <td>整机销售</td>
            <td><%=count2 %></td>
          </tr>
           <tr>
            <td>租赁企业</td>
            <td><%=count3 %></td>
          </tr>
           <tr>
            <td>二手机销售</td>
            <td><%=count4 %></td>
          </tr>
           <tr>
            <td>维修</td>
            <td><%=count5 %></td>
          </tr>
           <tr>
            <td>配套</td>
            <td><%=count6 %></td>
          </tr>
           <tr>
            <td>其他</td>
            <td><%=count7 %></td>
          </tr>
           <tr>
            <td>配件生产</td>
            <td><%=count8 %></td>
          </tr>
          <tr>
            <td>配件销售</td>
            <td><%=count9 %></td>
          </tr>
          <tr>
            <td>施工单位</td>
            <td><%=count10 %></td>
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
