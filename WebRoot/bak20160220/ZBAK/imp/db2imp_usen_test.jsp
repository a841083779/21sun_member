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
		
		if(flag.equals("1")){//查询db2数据库会员表
		//System.out.println("会员信息导入");
			String db2MemberSql = " select id,password,active,mrp,class,address,postcode,telephone,fullname,sex,birthday,comefrom,corporation,fax,email,www,certificate,certificateno,regdate,logdate,question,answer,score,logcount,recommand,autoemail,credits,crleft,mode,crexpdate,keywords,keywords_province,bbsscore,pid,regfrom,corplogo,gonggao,mobile from members where regdate>='2008-08-08' " ;//查询出金牌、B类、VIP会员 where regdate > '2010-08-24' FETCH   FIRST   10   ROWS   ONLY 
//===
			String insertMemberSql = "";
			//String db2MemberCountSql = " select count(*) from members ";//查询出金牌、B类、VIP会员
			db2Rs = DataManager.executeQueryDB2(db2Conn, db2MemberSql);
			int i = 0;
			while(db2Rs!=null && db2Rs.next()){//插入到sqlserver数据库
			//System.out.println("msg="+db2Rs.getString("fullname"));
			String level = "";
			//if(db2Rs.getString("class")!=null && (db2Rs.getString("class").equals("55") || db2Rs.getString("class").equals("75"))){
			//	level = "jobs02";
			//}	
					String sexs = db2Rs.getString("sex");
					if(sexs.equalsIgnoreCase("MA")){
					sexs="男";
					}else if(sexs.equalsIgnoreCase("FE")){
					sexs="女";
					}	
					
					String claa=db2Rs.getString("class");

				insertMemberSql = " insert into member_info_test (mem_no,mem_name,passw,per_sex,per_phone,per_email,per_province,per_city,comp_name,comp_address,comp_postcode,comp_fax,comp_url,comp_flag,comp_intro,regi_date,login_last_date,login_count,state,mem_flag,mem_flag_name,mem_flag_enddate,comp_logo,rent_mode,rent_bulletin,db2id) values ('"+db2Rs.getString("id")+"','"+Common.getFormatStr(db2Rs.getString("fullname")).replace("'", "\\\'").replace("\"", "\\\"")+"','"+db2Rs.getString("password")+"','"+sexs+"','"+db2Rs.getString("telephone")+"','"+db2Rs.getString("email")+"','"+db2Rs.getString("comefrom")+"','','"+Common.getFormatStr(db2Rs.getString("corporation")).replace("'", "\\\'").replace("\"", "\\\"")+"','"+Common.getFormatStr(db2Rs.getString("address"))+"','"+db2Rs.getString("postcode")+"','"+db2Rs.getString("fax")+"','"+db2Rs.getString("www")+"','"+db2Rs.getString("mrp")+"','','"+db2Rs.getString("regdate")+"','"+db2Rs.getString("logdate")+"','"+db2Rs.getString("logcount")+"','"+db2Rs.getString("Active")+"','"+db2Rs.getString("class")+"','','"+db2Rs.getString("CREXPDATE")+"','"+db2Rs.getString("CORPLOGO")+"','"+db2Rs.getString("mode")+"','"+db2Rs.getString("gonggao")+"','"+db2Rs.getString("pid")+"') ";
				insertMemberSql = insertMemberSql.replace("'null'","null");
//System.out.println("aaaa======="+db2Rs.getString("pid"));
				//System.out.println(insertMemberSql);
				try{
				DataManager.dataOperation(sqlConn,insertMemberSql);
				}catch(Exception eee){
				System.out.println(insertMemberSql);
				eee.printStackTrace();
				}
				//System.out.println(db2Rs.getString(1)); 
			}
		
		}
		
		if(flag.equals("0")){//查询db2数据库会员表，把企业介绍字段更新过来
	
			String db2MemberSql = " select pid,cast(introduction as varchar(4000)) as introduction from members  where id>199944";//查询出金牌、B类、VIP会员  where regdate > '2010-08-24'
			String updateMemberSql = "";
			//String db2MemberCountSql = " select count(*) from members ";//查询出金牌、B类、VIP会员
			db2Rs = DataManager.executeQueryDB2(db2Conn, db2MemberSql);
			int i = 0;
			while(db2Rs!=null && db2Rs.next()){//插入到sqlserver数据库

				updateMemberSql = " update member_info set comp_intro ='"+Common.getFormatStr(db2Rs.getString("introduction")).replace("'", "\\\'").replace("\"", "\\\"")+"' where db2id =  '"+db2Rs.getString("pid")+"'  ";
				//System.out.println(db2Rs.getString(1));
				//System.out.println(db2Rs.getString(2));
System.out.println(db2Rs.getString("pid"));
				DataManager.dataOperation(sqlConn,updateMemberSql);
				//System.out.println(db2Rs.getString(1));
			}
		}
		
out.println("数据处理成功!");
}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		db2Pool.freeConnection(db2Conn);
		sqlPool.freeConnection(sqlConn);
	}
%>
<!--
--更新member_info表中的省份----
update member_info set per_province='' where per_province='-1'
update member_info set per_province='北京' where per_province='01'
update member_info set per_province='上海' where per_province='02'
update member_info set per_province='天津' where per_province='03'
update member_info set per_province='重庆' where per_province='04'
update member_info set per_province='河北' where per_province='34'
update member_info set per_province='山西' where per_province='36'
update member_info set per_province='内蒙古' where per_province='14'
update member_info set per_province='辽宁' where per_province='32'
update member_info set per_province='吉林' where per_province='33'
update member_info set per_province='黑龙江' where per_province='31'
update member_info set per_province='江苏' where per_province='48'
update member_info set per_province='浙江' where per_province='49'
update member_info set per_province='安徽' where per_province='47'
update member_info set per_province='福建' where per_province='53'
update member_info set per_province='江西' where per_province='52'
update member_info set per_province='山东' where per_province='46'
update member_info set per_province='河南' where per_province='45'
update member_info set per_province='湖北' where per_province='44'
update member_info set per_province='湖南' where per_province='43'
update member_info set per_province='广东' where per_province='51'
update member_info set per_province='广西' where per_province='15'
update member_info set per_province='海南' where per_province='54'
update member_info set per_province='四川' where per_province='39'
update member_info set per_province='贵州' where per_province='42'
update member_info set per_province='云南' where per_province='41'
update member_info set per_province='西藏' where per_province='12'
update member_info set per_province='陕西' where per_province='35'
update member_info set per_province='甘肃' where per_province='37'
update member_info set per_province='宁夏' where per_province='13'
update member_info set per_province='青海' where per_province='38'
update member_info set per_province='新疆' where per_province='11'
update member_info set per_province='台湾' where per_province='55'
update member_info set per_province='香港' where per_province='21'
update member_info set per_province='澳门' where per_province='22'


--更新member_info表中的会员级别----
update member_info set mem_flag_name='超级用户' where mem_flag='-1'
update member_info set mem_flag_name='免费用户' where mem_flag='0'
update member_info set mem_flag_name='试用期已过' where mem_flag='20'
update member_info set mem_flag_name='A类会员到期' where mem_flag='21'
update member_info set mem_flag_name='B类会员到期' where mem_flag='22'
update member_info set mem_flag_name='认证会员' where mem_flag='25'
update member_info set mem_flag_name='二手机会员' where mem_flag='26'
update member_info set mem_flag_name='A类试用会员' where mem_flag='30'
update member_info set mem_flag_name='B类试用会员' where mem_flag='40'
update member_info set mem_flag_name='A类正式会员' where mem_flag='50'
update member_info set mem_flag_name='B类正式会员' where mem_flag='60'
update member_info set mem_flag_name='VIP会员' where mem_flag='55'
update member_info set mem_flag_name='VIP会员到期' where mem_flag='54'
update member_info set mem_flag_name='租赁通（2200）会员' where mem_flag='70'
update member_info set mem_flag_name='租赁通（2200）会员到期' where mem_flag='64'
update member_info set mem_flag_name='租赁通（800）' where mem_flag='65'
update member_info set mem_flag_name='租赁通会员（800）到期' where mem_flag='63'
update member_info set mem_flag_name='金牌会员' where mem_flag='75'
update member_info set mem_flag_name='金牌会员到期' where mem_flag='74'
update member_info set mem_flag_name='证券咨询类会员' where mem_flag='90'
update member_info set mem_flag_name='证券咨询类会员到期' where mem_flag='95'
update member_info set mem_flag_name='C类会员' where mem_flag='80'
update member_info set mem_flag_name='e点通会员（技术支持）' where mem_flag='15'
update member_info set mem_flag_name='e点通会员(配件手册)' where mem_flag='35'
update member_info set mem_flag_name='e点通会员（技术支持）到期' where mem_flag='14'
update member_info set mem_flag_name='e点通会员(配件手册)到期' where mem_flag='34'
-->
<body>
</body>
</html>
