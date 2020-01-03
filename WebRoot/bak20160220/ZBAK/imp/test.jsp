<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.net.*,com.jerehnet.cmbol.action.*"
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>从db2数据库数据导入到sqlserver数据库（会员表、招聘表、简历表）</title>
</head>
<%
	//区分数据导入类别：1-企业会员；2-个人会员；3-个人简历最近3个月；4-职位表
	String flag = request.getParameter("flag");
	if(flag==null || flag.equals("")){
		flag = "";
	}
	flag="1";
	PoolManager db2Pool = new PoolManager(2);
	PoolManager sqlPool = new PoolManager(1);
	Connection db2Conn = null;
	Connection sqlConn = null;
	ResultSet db2Rs = null;
	ResultSet sqlRs = null;
	try{
		db2Conn = db2Pool.getConnection();
		sqlConn = sqlPool.getConnection();
		if(flag.equals("1")){//查询db2数据库会员表gcjx88888
		//System.out.println("会员信息导入");
			//===二手
	String db2MemberSql = " select  count(*) as count_nums  from usedmarket  where   INFOCLASS=1" ;//查询出金牌、B类、VIP会 mid='TONG1223' and ISPUBLISHED=1 员 where regdate > '2010-08-24' FETCH   FIRST   10   ROWS   ONLY 
//===租赁=====
//String db2MemberSql = " select  count(*) as count_nums  from WEBRENT  where MID='TONG1223' and ISPUBLISHED=1";
//====配件仓库====
//String db2MemberSql = " select  count(*) as count_nums  from market_parts02 ";
			String insertMemberSql = "";
			//String db2MemberCountSql = " select count(*) from members ";//查询出金牌、B类、VIP会员
			db2Rs = DataManager.executeQueryDB2(db2Conn, db2MemberSql);
			
			while(db2Rs!=null && db2Rs.next()){
			out.println("nums:====="+db2Rs.getString("count_nums"));
		
		}	
		}
		
	
//out.println("数据处理成功!");
}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		db2Pool.freeConnection(db2Conn);
		sqlPool.freeConnection(sqlConn);
	}
%>
<body>
</body>
</html>
