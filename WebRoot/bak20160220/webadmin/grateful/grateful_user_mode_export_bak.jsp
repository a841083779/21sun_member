<%@ page language="java" pageEncoding="UTF-8" import="com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.*" %>
<%@page import="jxl.Workbook"%>
<%@page import="java.io.*"%>
<%
	PoolManager pool = (PoolManager)application.getAttribute("poolAPP");
	if(pool == null){
		pool = new PoolManager();
	}
	DataManager dataManager = new DataManager();
	String targetFile = "d:/test.xls";
	
	Connection conn = null;

	try{
		conn = pool.getConnection();
		//地区
		String countPorStr = "SELECT per_province,COUNT(per_province) as count  from  member_info WHERE (jiang is not NULL or jiang_chuli is not null)  and mem_name is not null and mem_name<>'' and per_province is not null and per_province<>'' GROUP BY per_province ORDER BY count desc";
		ResultSet rsPor = dataManager.executeQuery(conn,countPorStr);
		
		
		// 构建 Workbook 对象 , 只读 Workbook 对象
		//Method 1：创建可写入的 Excel 工作薄
		//jxl.write.WritableWorkbook wwb = Workbook.createWorkbook(new File(targetFile));
		//Method 2：将 WritableWorkbook 直接写入到输出流
		OutputStream os = new FileOutputStream(targetFile);
		jxl.write.WritableWorkbook wwb = Workbook.createWorkbook(os);
		// 创建 Excel 工作表
		jxl.write.WritableSheet ws = wwb.createSheet("获奖用户区域人数统计", 0);
		//1. 添加 Label 对象
		jxl.write.Label labelC = new jxl.write.Label(0, 0, "地区");
		ws.addCell(labelC);
		jxl.write.Label labelN = new jxl.write.Label(1, 0, "数量");
		ws.addCell(labelN);
		int i =1;
		while(rsPor.next()){
			String	countPor=Common.getFormatStr(rsPor.getString("count"));
			String	per_province=Common.getFormatStr(rsPor.getString("per_province"));
			//1. 添加 Label 对象
			jxl.write.Label labelX = new jxl.write.Label(0, i, per_province);
			ws.addCell(labelX);
			//2. 添加 Number 对象
			jxl.write.Label labelY = new jxl.write.Label(1, i, countPor);
			ws.addCell(labelY);
			i++;
		}
		// 写入 Exel 工作表
		wwb.write();
		// 关闭 Excel 工作薄对象
		wwb.close();
		//下载文件
		response.reset(); // 非常重要
        response.setContentType("application/x-msdownload");
        response.setHeader("Content-Disposition",   "attachment;   filename="+new String(("excel.xls").getBytes(),"iso8859-1"));   
        OutputStream outputStream = response.getOutputStream();
        outputStream.close();
        out.clear();
        out = pageContext.pushBody();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript" src="../../scripts/funtionChart/JSClass/FusionCharts.js"></script>
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
            <td width="20%" align="center" bgcolor="e8f2ff"><input type="button" value="导出excel" onclick="openWin('grateful_user_mode_export.jsp','win',800,600)"/></td>
          </tr>
          <tr>
            <td width="30%" align="left"><strong>&nbsp;</strong></td>
            <td width="50%" align="center"><strong>&nbsp;</strong></td>
            <td width="20%" align="center"><strong>&nbsp;</strong></td>
          </tr>
          <tr>
            <td height="6" colspan="3">
				
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
