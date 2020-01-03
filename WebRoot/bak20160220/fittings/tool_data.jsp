<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
	<%@ include file ="/manage/config.jsp"%>
	<%
		pool = new PoolManager(9);
		String tableName = Common.getFormatStr(request.getParameter("tableName"));
		String year = Common.getFormatStr(request.getParameter("year"));
		String month = Common.getFormatStr(request.getParameter("month"));
		int theRow = Integer.parseInt(Common.getFormatInt(request.getParameter("theRow")));
		
		String []no = request.getParameterValues("no");
		String []part_type = request.getParameterValues("part_type");
		String []fittings_company = request.getParameterValues("fittings_company");
		String []fittings_agent_count = request.getParameterValues("fittings_agent_count");
		String []sale_china = request.getParameterValues("sale_china");
		String []sale_abroad = request.getParameterValues("sale_abroad");
		
		String insertSql = "";
		if(theRow>=0 && no!=null && theRow<no.length){
			insertSql = " insert into fittings_data_basic_sub (add_date,add_ip,parent_no,mem_no,year,month,part_type,sale_china,sale_abroad,fittings_company,fittings_agent_count,comp_name) values ('"+Common.getToday("yyyy-MM-dd HH:mm:ss",0)+"','"+request.getRemoteAddr()+"','"+no[theRow]+"','"+(String)adminInfo.get("mem_no")+"','"+year+"','"+month+"','"+part_type[theRow]+"','"+sale_china[theRow]+"','"+sale_abroad[theRow]+"','"+fittings_company[theRow]+"','"+fittings_agent_count[theRow]+"','"+(String)adminInfo.get("comp_name")+"') ";
				DataManager.dataOperation(pool,insertSql);
		}else{
			for(int i=0;no!=null && i<no.length;i++){
				if(sale_china!=null && sale_china[i]!=null && !sale_china[i].equals("")){
					insertSql = " insert into fittings_data_basic_sub (add_date,add_ip,parent_no,mem_no,year,month,part_type,sale_china,sale_abroad,fittings_company,fittings_agent_count,comp_name) values ('"+Common.getToday("yyyy-MM-dd HH:mm:ss",0)+"','"+request.getRemoteAddr()+"','"+no[i]+"','"+(String)adminInfo.get("mem_no")+"','"+year+"','"+month+"','"+part_type[i]+"','"+sale_china[i]+"','"+sale_abroad[i]+"','"+fittings_company[i]+"','"+fittings_agent_count[i]+"','"+(String)adminInfo.get("comp_name")+"') ";
					DataManager.dataOperation(pool,insertSql);
				}
			}	
		}	
	%>
	<script language="javascript" type="text/javascript">
		alert("数据信息提交成功！");
		history.back();
	</script>