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
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库据库
	String flag = request.getParameter("flag");
	if(flag==null || flag.equals("")){
		flag = "";
	}
	flag="1";
	PoolManager db2Pool = new PoolManager(2);
	PoolManager sqlPool = new PoolManager(3);
	Connection db2Conn = null;
	Connection sqlConn = null;
	ResultSet db2Rs = null;
	ResultSet sqlRs = null;
	try{
		db2Conn = db2Pool.getConnection();
		sqlConn = sqlPool.getConnection();
		
		if(flag.equals("1")){//查询db2数据库会员表
	
String db2MemberSql = " select id,password,active,class,address,postcode,telephone,fullname,sex,birthday,corporation,fax,email,www,regdate,logdate,logcount,recommand,autoemail,credits,crleft,mode,crexpdate,keywords,keywords_province,bbsscore,pid,regfrom,corplogo,gonggao,mobile,cast(INTRODUCTION as varchar(4000)) from members where 1=1 order by pid asc ";//查询出金牌、B类、VIP会员
			String insertMemberSql = "";
			//String db2MemberCountSql = " select count(*) from members ";//查询出金牌、B类、VIP会员
			db2Rs = DataManager.executeQueryDB2(db2Conn, db2MemberSql);
			int i = 0;
			while(db2Rs!=null && db2Rs.next()){//插入到sqlserver数据库
			insertMemberSql = " insert into rent_members (mem_no,password,active,class,address,postcode,telephone,mem_name,sex,birthday,corporation,fax,email,www,regdate,logdate,introduction,logcount,credits,pid,regfrom,corplogo,gonggao,mobile,INTRODUCTION,mode) values ('"+db2Rs.getString("id")+"','"+db2Rs.getString("password")+"','"+db2Rs.getString("active")+"','"+db2Rs.getString("class")+"','"+db2Rs.getString("address")+"','"+db2Rs.getString("postcode")+"','"+db2Rs.getString("telephone")+"','"+db2Rs.getString("fullname")+"','"+db2Rs.getString("sex")+"','"+db2Rs.getString("birthday")+"','"+db2Rs.getString("corporation")+"','"+db2Rs.getString("fax")+"','"+db2Rs.getString("email")+"','"+db2Rs.getString("www")+"','"+db2Rs.getString("regdate")+"','"+db2Rs.getString("logdate")+"','"+db2Rs.getString("introduction")+"','"+db2Rs.getString("logcount")+"','"+db2Rs.getString("credits")+"','"+db2Rs.getString("pid")+"','"+db2Rs.getString("regfrom")+"','"+db2Rs.getString("corplogo")+"','"+db2Rs.getString("gonggao")+"','"+db2Rs.getString("mobile")+"','"+db2Rs.getString(32).replace("\r\n","<br>")+"','"+db2Rs.getString("mode")+"') ";
				//System.out.println(insertMemberSql);
				DataManager.dataOperation(sqlConn,insertMemberSql);
				//System.out.println(db2Rs.getString(1));
			}
		}
		
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
