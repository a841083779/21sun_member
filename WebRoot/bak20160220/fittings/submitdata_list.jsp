<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(9);
	Connection conn =null;	
	String tablename="fittings_data_basic";
	
	java.util.Date nowDate = new java.util.Date();
	SimpleDateFormat sfYear = new SimpleDateFormat("yyyy");
	SimpleDateFormat sfMonth = new SimpleDateFormat("MM");
	int intYear = Integer.parseInt(sfYear.format(nowDate)!=null && !sfYear.format(nowDate).equals("")?sfYear.format(nowDate):"2011");
	int intMonth = Integer.parseInt(sfMonth.format(nowDate)!=null && !sfMonth.format(nowDate).equals("")?sfMonth.format(nowDate):"1");
		
	StringBuffer query =new StringBuffer("select id,no,fittings_machine_sort,fittings_machine_model,part_sort,fittings_company,fittings_agent_count from "+tablename+" where mem_no = '"+(String)adminInfo.get("mem_no")+"' order by add_date asc");
	try{
		conn = pool.getConnection();
		//SQL查询	
		ResultSet rs = DataManager.executeQuery(conn,query.toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function dataSubmitAll(){
		if(document.theform.year.value==""){
			alert("请选择年份！");
			document.theform.year.focus();
			return false;
		}else if(document.theform.month.value==""){
			alert("请选择月份！");
			document.theform.month.focus();
			return false;
		}
		var saleChina = document.getElementsByName("sale_china");
		var saleAbroad = document.getElementsByName("sale_abroad");
		for(var i=0;saleChina!=null && i<saleChina.length;i++){
			if(saleChina[i].value=="" || isNaN(saleChina[i].value)){
				alert("国内销量不能为空且必须为数字！");
				saleChina[i].focus();
				return false;
			}else if(saleAbroad[i].value=="" || isNaN(saleAbroad[i].value)){
				alert("出口量不能为空且必须为数字！");
				saleAbroad[i].focus();
				return false;
			}
		}
		if(confirm('确定提交以下数据吗？')){
			document.theform.submit();
		}
	}
	
	function dataSubmit(k){
		if(document.theform.year.value==""){
			alert("请选择年份！");
			document.theform.year.focus();
			return false;
		}else if(document.theform.month.value==""){
			alert("请选择月份！");
			document.theform.month.focus();
			return false;
		}
		var saleChina = document.getElementsByName("sale_china");
		var saleAbroad = document.getElementsByName("sale_abroad");
		if(saleChina!=null && saleChina[k].value=="" || isNaN(saleChina[k].value)){
			alert("国内销量不能为空且必须为数字！");
			saleChina[k].focus();
			return false;
		}else if(saleAbroad!=null && saleAbroad[k].value=="" || isNaN(saleAbroad[k].value)){
			alert("出口量不能为空且必须为数字！");
			saleAbroad[k].focus();
			return false;
		}
			
		if(confirm('确定提交该条数据吗？')){
			document.theform.action = "tool_data.jsp?theRow="+k;
			document.theform.submit();
		}
	}
</script>
</head>
<body>
<form id="theform" name="theform" action="tool_data.jsp" method="post">
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">配套件数据信息提交</span></div>
  <div class="loginlist_right1"><span class="title_bar">
    <select id="year" name="year">
		<option value="">-请选择年份-</option>
		<%
			for(int i=2005;i<=2014;i++){
		%>
		<option value="<%=i%>" <%if(i==intYear){%> selected="selected"<%}%>><%=i%>年</option>
		<%
			}
		%>
	</select>
	<select id="month" name="month">
		<option value="">-请选择月份-</option>
		<%
			for(int i=1;i<=12;i++){
		%>
		<option value="<%=i%>" <%if(i==intMonth){%> selected="selected"<%}%>><%=i%>月</option>
		<%
			}
		%>
	</select>&nbsp;&nbsp;<strong onclick="dataSubmitAll();" style="cursor:pointer"> >>提交数据</strong>
	&nbsp;&nbsp;<strong style="cursor:pointer"> <a href="/fittings/baseinfo_list.jsp">>>基本信息录入</a></strong>
    </span>
    <table width="100%" border="0" class="list">
      <tr>
        <th width="8%"><div align="center">序号</div></th>
        <th width="56%">配件类型</th>
        <th width="12%"><div align="center">国内销量</div></th>
        <th width="12%"><div align="center">出口量</div></th>
        <th width="12%"><div align="center">操作</div></th>
      </tr>
      <%
	  	int k = 0;
		 while (rs!=null && rs.next()){
		 k++;
	  %>
      <tr>
		<input type="hidden" id="no" name="no" value="<%=Common.getFormatStr(rs.getString("no"))%>" />
		<input type="hidden" id="part_type" name="part_type" value="<%=Common.getFormatStr(rs.getString("fittings_machine_model"))%>-<%=Common.getFormatStr(rs.getString("fittings_machine_sort"))%>-<%=Common.getFormatStr(rs.getString("part_sort"))%>" />
		<input type="hidden" id="fittings_company" name="fittings_company" value="<%=Common.getFormatStr(rs.getString("fittings_company"))%>" />
		<input type="hidden" id="fittings_agent_count" name="fittings_agent_count" value="<%=Common.getFormatStr(rs.getString("fittings_agent_count"))%>" />
	  	<td><div align="center"><%=k%></div></td>
        <td><%=Common.getFormatStr(rs.getString("fittings_machine_model"))%>-<%=Common.getFormatStr(rs.getString("fittings_machine_sort"))%>-<%=Common.getFormatStr(rs.getString("part_sort"))%></td>
        <td><input type="text" id="sale_china" name="sale_china" size="10" maxlength="9" /><span class="red">*</span></td>
        <td><input type="text" id="sale_abroad" name="sale_abroad" size="10" maxlength="9" /><span class="red">*</span></td>
        <td><div align="center" onclick="dataSubmit('<%=k-1%>');" style="cursor:pointer">提交</div></td>
      </tr>
      <%
}
%>
    </table>
  </div>
</div>
</form>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
