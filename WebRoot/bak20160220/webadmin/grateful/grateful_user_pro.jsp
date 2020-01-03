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
		//地区
		String countPorStr = "SELECT per_province,COUNT(per_province) as count  from  member_info WHERE (jiang is not NULL or jiang_chuli is not null)  and mem_name is not null and mem_name<>'' and per_province is not null and per_province<>'' GROUP BY per_province";
		ResultSet rsPor = dataManager.executeQuery(conn,countPorStr);
		
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
            <td width="30%" bgcolor="e8f2ff" align="left"><strong>获奖用户区域人数统计</strong></td>
            <td width="50%" bgcolor="e8f2ff" align="center"><strong>&nbsp;</strong></td>
            <td width="20%" align="center" bgcolor="e8f2ff"><input type="button" value="导出excel" onclick="openWin('grateful_user_pro_export.jsp','win',800,600)"/></td>
          </tr>
          <tr>
            <td width="30%" align="left"><strong>&nbsp;</strong></td>
            <td width="50%" align="center"><strong>&nbsp;</strong></td>
            <td width="20%" align="center"><strong>&nbsp;</strong></td>
          </tr>
          <tr>
            <td height="6" colspan="3">
            <div id="chartdiv" align="center"></div>
            	<script type="text/javascript">
					var xmlData="<chart logoURL='images/new01-1.gif' logoPosition='CC' logoAlpha='10' logoScale='150'  caption='各类奖项获奖人数统计' exportEnabled='0' exportAtClient='1' exportHandler='fcExporter1' exportDialogMessage='正在导出，请稍候...' exportFileName='图表' exportFormats='JPG=导出JPG文件|PNG=导出PNG文件|PDF=导出PDF文件'  >";
				   	<%
			  		while(rsPor.next()){
						String	countPor=Common.getFormatStr(rsPor.getString("count"));
						String	per_province=Common.getFormatStr(rsPor.getString("per_province"));
			  		%>
			  		xmlData=xmlData+"<set name='<%=per_province%>' value='<%=countPor%>' />";
	               	<%}%>
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
