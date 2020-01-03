<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(7);
	Connection conn =null;	
	//flag 1：浏览2：收藏 3：留言
	
	String viewFlag=Common.getFormatInt(request.getParameter("viewFlag"));
	if(viewFlag.equals("0")){
		viewFlag = "1";
	}
	String flagStr="";  //
	if(viewFlag.equals("1")){
	   flagStr="浏览";
	}else if(viewFlag.equals("2")){
	   flagStr="收藏";
	}else if(viewFlag.equals("3")){
	   flagStr="留言";
	}
		
	String siteFlag = Common.getFormatStr(request.getParameter("siteFlag"));
	String no = Common.getFormatStr(request.getParameter("no"));
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(20);
	//分页中当前记录
	String offset=Common.getFormatStr(request.getParameter("offset"));
	if(offset.equals("")){
		offset="0";
	}
	
	StringBuffer query =new StringBuffer("select add_date,mem_name,province,city,telephone,email,company from parts_collection_view_info where flag = '"+viewFlag+"' and parent_no = '"+no+"' and site_flag = '"+siteFlag+"' and mem_no is not null and mem_no != '' order by add_date desc");

	String proStatSql = "select top 15 province,count(*) as count from parts_collection_view_info where flag = '"+viewFlag+"' and parent_no = '"+no+"' and site_flag = '"+siteFlag+"' and mem_no is not null and mem_no != '' group by province order by count desc";
	try{
		conn = pool.getConnection();
		//SQL查询	
		ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
		String bar = pagination.paginationPrint();  //读取分页提示栏
		ResultSet rsStat = DataManager.executeQuery(conn,proStatSql);
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
		var xmlData="<chart logoURL='images/new01-1.gif' logoPosition='CC' logoAlpha='10' logoScale='150'  caption='<%=flagStr%>量地区访问统计' exportEnabled='0' exportAtClient='1' exportHandler='fcExporter1' exportDialogMessage='正在导出，请稍候...' exportFileName='图表' exportFormats='JPG=导出JPG文件|PNG=导出PNG文件|PDF=导出PDF文件'  >";
	<%
	 while(rsStat.next()){
	%>
	   xmlData=xmlData+"<set name='<%=Common.getFormatStr(rsStat.getString("province"))%>' value='<%=Common.getFormatStr(rsStat.getString("count"))%>'  />";
	<%
	}
	%>
	   xmlData=xmlData+"</chart>";
	   var chart = new FusionCharts("/scripts/FusionCharts/charts/Line.swf", "ChartId", "95%", "300","0","1");
	   chart.setDataXML(xmlData);   
	   chart.render("chartdiv1");
	</script>
  </div>
  <div align="center">
  	<input type="radio" id="viewType1" name="viewType" value="" style="border:none" onclick="window.location.href='view_count_info.jsp?no=<%=no%>&viewFlag=<%=viewFlag%>&siteFlag=<%=siteFlag%>'" checked="checked"/>会员<%=flagStr%>量统计
	<input type="radio" id="viewType2" name="viewType" value="" style="border:none" onclick="window.location.href='view_count_info_other.jsp?no=<%=no%>&viewFlag=<%=viewFlag%>&siteFlag=<%=siteFlag%>'"/>非会员<%=flagStr%>量统计
  </div>
  <div class="loginlist_right1">
    <table width="100%" border="0" class="list">
      <tr>
        <th width="22%"><div align="center">公司名称</div></th>
        <th width="12%"><div align="center">姓名</div></th>
        <th width="22%"><div align="center">联系方式</div></th>
        <th width="16%"><div align="center">所在地</div></th>
        <th width="12%"><div align="center">浏览日期</div></th>
      </tr>
      <%
		 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
		 while (rs!=null && rs.next()){
		 	k=k+1;
	  %>
      <tr>
        <td><div align="center"><%=Common.getFormatStr(rs.getString("company"))%></div></td>
        <td><div align="center"><%=Common.getFormatStr(rs.getString("mem_name"))%></div></td>
        <td><div align="center"><%=Common.getFormatStr(rs.getString("telephone"))%></div></td>
        <td><div align="center"><%=Common.getFormatStr(rs.getString("province"))%>-<%=Common.getFormatStr(rs.getString("city"))%></div></td>
        <td><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></div></td>
      </tr>
      <%
}
%>
    </table>
    <table width="100%" border="0" class="list">
      <tr>
        <td align="left"><%out.println(pagination.pagesPrint(8));%></td>
      </tr>
    </table>
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
