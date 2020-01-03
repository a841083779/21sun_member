<%@ page language="java" import="java.util.*,com.jerehnet.cmbol.database.PoolManager,java.sql.Connection" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.cmbol.database.DataManager"%>
<%@page import="java.sql.ResultSet"%>
<%
	//首先得到二手网库的所有会员名
	PoolManager pool4   = new PoolManager(4);
	PoolManager pool = new PoolManager();
	String fields = "mem_no";
	String sql = " select "+fields+" from member_ext_used ";
	Connection connectionUsed = null;
	Connection connectionSun = null;
	ResultSet rs = null;
	Map model = null;
	try{
		connectionUsed = pool4.getConnection();
		connectionSun = pool.getConnection();
		rs = DataManager.executeQuery(connectionUsed,sql);
		String memNos = "";
		while(null!=rs&&rs.next()){
			memNos += "'"+rs.getString("mem_no")+"',";
		}
		if(null!=rs){
			rs.close();
		}
		if(null!=memNos&&memNos.endsWith(",")){
			memNos = memNos.substring(0,memNos.length()-1);
		}
		//查询出商贸网库中所有符合条件的会员
		fields = "mem_no,mem_name,per_province,per_city,comp_name,mem_flag";
		sql = " select "+fields+" from member_info where mem_no not in ("+memNos+") and mem_flag in ('1007','1008','1014') ";
		List users = new ArrayList(0);
		rs = DataManager.executeQuery(connectionSun,sql);
		while(null!=rs&&rs.next()){
			model = new HashMap();
			model.put("mem_no",rs.getString("mem_no"));
			model.put("mem_name",rs.getString("mem_name"));
			model.put("per_province",rs.getString("per_province"));
			model.put("per_city",rs.getString("per_city"));
			model.put("comp_name",rs.getString("comp_name"));
			model.put("mem_flag",rs.getString("mem_flag"));
			users.add(model);
		}
		if(null!=rs){
			rs.close();
		}
		if(null!=users&&users.size()>0){
			for(int i=0;i<users.size();i++){
				model = (Map)users.get(i);
				sql = "INSERT INTO dbo.member_ext_used (mem_no, mem_name, company, area_id, remark, validity_date, intro, longitude, latitude, zoom, link_url, ico_id,is_show)";
				sql += "VALUES ('"+model.get("mem_no")+"', '"+model.get("mem_name")+"',";
				sql += " '"+model.get("comp_name")+"','1','','','','0','0','0','','1',1 ) ";
				DataManager.dataOperation(connectionUsed,sql);
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool4.freeConnection(connectionUsed);
		pool.freeConnection(connectionSun);
	}
%>