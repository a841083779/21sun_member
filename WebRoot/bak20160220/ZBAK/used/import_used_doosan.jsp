<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库,4:表示调用二手的数据
	PoolManager pool1 = new PoolManager(1);
	PoolManager pool4 = new PoolManager(4);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	Connection conn4=pool4.getConnection();
	
	String sql1="";
	String sql4="select id,agent_no,company_address,email,domain,telphone from doosan_used_agents where agent_no in('ahtd','bthy','cdwt','fjds','gsdy','hebly','hnqlm','jlfl','lnds','sdyh','cdds','sxds','syds','whqlm')";
	ResultSet rs=DataManager.executeQuery(conn4, sql4);
int k=0;
String comp_address="",per_email="",comp_url="",per_phone="",mem_no="";
while(rs.next())
{
		comp_address = Common.getFormatStr(rs.getString("company_address"));
		per_email = Common.getFormatStr(rs.getString("email"));
		comp_url = Common.getFormatStr(rs.getString("domain"));
		per_phone = Common.getFormatStr(rs.getString("telphone"));
		mem_no = Common.getFormatStr(rs.getString("agent_no"));
 k=k+1;
sql1="update member_info set comp_address='"+comp_address+"',per_email='"+per_email+"',comp_url='"+comp_url+"',per_phone='"+per_phone+"' where mem_no ='"+mem_no+"'";
dataManager1.dataOperation(conn1, sql1);
}rs.close();

System.out.println("k="+k);

pool1.freeConnection(conn1);
pool4.freeConnection(conn4);
out.println("导入成功!");
%>