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
            <td width="30%" bgcolor="e8f2ff" align="left"><strong>获奖用户行业人数统计</strong></td>
            <td width="50%" bgcolor="e8f2ff" align="center"><strong>&nbsp;</strong></td>
            <td width="20%" align="center" bgcolor="e8f2ff"><input type="button" value="导出excel" onclick="openWin('grateful_user_mode_export.jsp','win',800,600)"/></td>
          </tr>
          <tr>
            <td height="6" colspan="6">
            <div id="chartdiv" align="center"></div>
            	<script type="text/javascript">
					var xmlData="<chart logoURL='images/new01-1.gif' logoPosition='CC' logoAlpha='10' logoScale='150'  caption='各类奖项获奖人数统计' exportEnabled='0' exportAtClient='1' exportHandler='fcExporter1' exportDialogMessage='正在导出，请稍候...' exportFileName='图表' exportFormats='JPG=导出JPG文件|PNG=导出PNG文件|PDF=导出PDF文件'  >";
				   	xmlData=xmlData+"<set name='整机生产' value='<%=count1%>' />";
	               	xmlData=xmlData+"<set name='整机销售' value='<%=count2%>' />";
	               	xmlData=xmlData+"<set name='租赁企业' value='<%=count3%>' />";
	               	xmlData=xmlData+"<set name='二手机销售' value='<%=count4%>' />";
	               	xmlData=xmlData+"<set name='维修' value='<%=count5%>' />";
	               	xmlData=xmlData+"<set name='配套' value='<%=count6%>' />";
	               	xmlData=xmlData+"<set name='其他' value='<%=count7%>' />";
	               	xmlData=xmlData+"<set name='配件生产' value='<%=count8%>' />";
	               	xmlData=xmlData+"<set name='配件销售' value='<%=count9%>' />";
	               	xmlData=xmlData+"<set name='施工单位' value='<%=count10%>' />";
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
