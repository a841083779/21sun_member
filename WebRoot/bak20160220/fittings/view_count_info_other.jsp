<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(9);
	Connection conn =null;	
	String tablename="fittings_business_info";
	//flag 1：浏览2：收藏
	String flag=Common.getFormatInt(request.getParameter("flag"));
	if(flag.equals("0")){
		flag = "1";
	}
	String no = Common.getFormatStr(request.getParameter("no"));
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(18);
	//分页中当前记录
	String offset=Common.getFormatStr(request.getParameter("offset"));
	if(offset.equals("")){
		offset="0";
	}

	String proStatSql = "select top 15 add_area,count(*) as count from fittings_collection_view_info where flag = '"+flag+"' and parent_no = '"+no+"' and (mem_no is null or mem_no = '') group by add_area order by count desc";
	String proStatAllSql = "select add_area,count(*) as count from fittings_collection_view_info where flag = '"+flag+"' and parent_no = '"+no+"' and (mem_no is null or mem_no = '') group by add_area order by count desc";
	try{
		conn = pool.getConnection();
		ResultSet rsStat = DataManager.executeQuery(conn,proStatSql);
		ResultSet rsStatAll = DataManager.executeQuery(conn,proStatAllSql);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="/scripts/FusionCharts/FusionCharts.js"></script>
<script language="JavaScript" src="/scripts/FusionCharts/FusionChartsExportComponent.js"></script>
</head>
<body>
<div>
  <div id="chartdiv1" align="center"></div>
  <div align="center">
  	<input type="radio" id="viewType1" name="viewType" value="" style="border:none" onclick="window.location.href='view_count_info.jsp?no=<%=no%>'"/>会员浏览量统计
	<input type="radio" id="viewType2" name="viewType" value="" style="border:none" onclick="window.location.href='view_count_info_other.jsp?no=<%=no%>'" checked="checked"/>非会员浏览量统计
  </div>
  <div id="chartdiv2" align="center"></div>
  <div>
    <script type="text/javascript">
		var myExportComponent = new FusionChartsExportObject("fcExporter1", "/scripts/FusionCharts/charts/FCExporter.swf");
		myExportComponent.componentAttributes.width = '400';
		myExportComponent.componentAttributes.height = '60';
		myExportComponent.componentAttributes.bgColor = 'ffffdd';
		myExportComponent.componentAttributes.borderThickness = '2';
		myExportComponent.componentAttributes.borderColor = '0372AB';
		myExportComponent.componentAttributes.fontFace = 'Arial';
		myExportComponent.componentAttributes.fontColor = '0372AB';
		myExportComponent.componentAttributes.fontSize = '12';
		myExportComponent.componentAttributes.showMessage = '1';
		//myExportComponent.componentAttributes.message = '在报表上右键导出,然后点此按钮保存图片';
		myExportComponent.componentAttributes.btnWidth = '200';
		myExportComponent.componentAttributes.btnHeight= '25';
		myExportComponent.componentAttributes.btnColor = 'E1f5ff';
		myExportComponent.componentAttributes.btnBorderColor = '0372AB';
		myExportComponent.componentAttributes.btnFontFace = 'Verdana';
		myExportComponent.componentAttributes.btnFontColor = '0372AB';
		myExportComponent.componentAttributes.btnFontSize = '15';
		//myExportComponent.componentAttributes.btnsavetitle = '图片已生成,点击保存'
		//myExportComponent.componentAttributes.btndisabledtitle = '报表上右键可以导出图片';
		//myExportComponent.Render("fcexpDiv");
	</script>
	<script type="text/javascript">
		var xmlData="<chart logoURL='images/new01-1.gif' logoPosition='CC' logoAlpha='10' logoScale='150'  caption='浏览量地区访问统计' exportEnabled='0' exportAtClient='1' exportHandler='fcExporter1' exportDialogMessage='正在导出，请稍候...' exportFileName='图表' exportFormats='JPG=导出JPG文件|PNG=导出PNG文件|PDF=导出PDF文件'  >";
	<%
	 while(rsStat.next()){
	%>
	   xmlData=xmlData+"<set name='<%=Common.getFormatStr(rsStat.getString("add_area"))%>' value='<%=Common.getFormatStr(rsStat.getString("count"))%>'  />";
	<%
	}
	%>
	   xmlData=xmlData+"</chart>";
	   var chart = new FusionCharts("/scripts/FusionCharts/charts/Line.swf", "ChartId", "95%", "300","0","1");
	   chart.setDataXML(xmlData);   
	   chart.render("chartdiv1");
	</script>
  </div>
  <!--<div id="fcexpDiv" align="center"></div>-->
  <div>
    <script type="text/javascript">
	var myExportComponent = new FusionChartsExportObject("fcExporter1", "/scripts/FusionCharts/charts/FCExporter.swf");
	myExportComponent.componentAttributes.width = '400';
	myExportComponent.componentAttributes.height = '60';
	myExportComponent.componentAttributes.bgColor = 'ffffdd';
	myExportComponent.componentAttributes.borderThickness = '2';
	myExportComponent.componentAttributes.borderColor = '0372AB';
	myExportComponent.componentAttributes.fontFace = 'Arial';
	myExportComponent.componentAttributes.fontColor = '0372AB';
	myExportComponent.componentAttributes.fontSize = '12';
	myExportComponent.componentAttributes.showMessage = '1';
	//myExportComponent.componentAttributes.message = '在报表上右键导出,然后点此按钮保存图片';
	myExportComponent.componentAttributes.btnWidth = '200';
	myExportComponent.componentAttributes.btnHeight= '25';
	myExportComponent.componentAttributes.btnColor = 'E1f5ff';
	myExportComponent.componentAttributes.btnBorderColor = '0372AB';
	myExportComponent.componentAttributes.btnFontFace = 'Verdana';
	myExportComponent.componentAttributes.btnFontColor = '0372AB';
	myExportComponent.componentAttributes.btnFontSize = '15';
	//myExportComponent.componentAttributes.btnsavetitle = '图片已生成,点击保存'
	//myExportComponent.componentAttributes.btndisabledtitle = '报表上右键可以导出图片';
	//myExportComponent.Render("fcexpDiv");
</script>
    <script type="text/javascript">
	var xmlData="<chart logoURL='images/new01-1.gif' logoPosition='CC' logoAlpha='10' logoScale='150'  caption='浏览量地区访问统计' exportEnabled='0' exportAtClient='1' exportHandler='fcExporter1' exportDialogMessage='正在导出，请稍候...' exportFileName='图表' exportFormats='JPG=导出JPG文件|PNG=导出PNG文件|PDF=导出PDF文件'  >";
<%
 while(rsStatAll.next()){
%>
   xmlData=xmlData+"<set name='<%=Common.getFormatStr(rsStatAll.getString("add_area"))%>' value='<%=Common.getFormatStr(rsStatAll.getString("count"))%>'  />";
<%
}
%>
   xmlData=xmlData+"</chart>";
   var chart = new FusionCharts("/scripts/FusionCharts/charts/SSGrid.swf", "ChartId", "95%", "500","0","1");
   chart.setDataXML(xmlData);   
   chart.render("chartdiv2");
</script>
  </div>
</div>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
