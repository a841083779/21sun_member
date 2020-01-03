<%@ page language="java" pageEncoding="UTF-8" import="com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.*" %>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script language="JavaScript" src="/scripts/FusionCharts/FusionCharts.js"></script>
<script language="JavaScript" src="/scripts/FusionCharts/FusionChartsExportComponent.js"></script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap">&nbsp;</td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="30%" bgcolor="e8f2ff" align="left"><strong>各类奖项获奖人数统计</strong></td>
            <td width="50%" bgcolor="e8f2ff" align="center"><strong>&nbsp;</strong></td>
            <td width="20%" align="center" bgcolor="e8f2ff"><input type="button" value="导出excel" onclick="openWin('grateful_user_count_export.jsp','win',800,600)"/></td>
          </tr>
          <tr>
            <td height="6" colspan="6">
            <div id="chartdiv" align="center"></div>
	            <script type="text/javascript">
					var xmlData="<chart logoURL='images/new01-1.gif' logoPosition='CC' logoAlpha='10' logoScale='150'  caption='各类奖项获奖人数统计' exportEnabled='0' exportAtClient='1' exportHandler='fcExporter1' exportDialogMessage='正在导出，请稍候...' exportFileName='图表' exportFormats='JPG=导出JPG文件|PNG=导出PNG文件|PDF=导出PDF文件'  >";
				   	xmlData=xmlData+"<set name='套餐优惠券' value='<%=count1%>' />";
	               	xmlData=xmlData+"<set name='会员优惠券' value='<%=count2%>' />";
	               	xmlData=xmlData+"<set name='杰配网优惠券' value='<%=count3%>' />";
	               	xmlData=xmlData+"<set name='人才网优惠券' value='<%=count4%>' />";
	               	xmlData=xmlData+"<set name='21-sun卡盘' value='<%=count5%>' />";
	               	xmlData=xmlData+"<set name='21-sun阳光宝宝便签夹' value='<%=count6%>' />";
	               	xmlData=xmlData+"<set name='挖掘机报告券' value='<%=count101%>' />";
	               	xmlData=xmlData+"<set name='装载机报告券' value='<%=count102%>' />";
	               	xmlData=xmlData+"<set name='推土机报告券' value='<%=count103%>' />";
	               	xmlData=xmlData+"<set name='压路机报告券' value='<%=count104%>' />";
	               	xmlData=xmlData+"<set name='起重机报告券' value='<%=count105%>' />";
				   xmlData=xmlData+"</chart>";
				   var chart = new FusionCharts("/scripts/FusionCharts/charts/Pie3D.swf", "ChartId", "95%", "300","0","1");
				   chart.setDataXML(xmlData);   
				   chart.render("chartdiv");
				</script>
            </td>
          </tr>
        </table>
        </td>
    </tr>
</table>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
	%>
