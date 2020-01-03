<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}
	// String tag= request.getParameter("tag");
	 String tablename="index_21sun";
	
	 
	 String pageSubName = "index_21sun_edit_new.jsp";
	
	
	Connection conn = pool.getConnection();
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(17);
	try {
		String offset = request.getParameter("offset");
		if (offset == null || offset.equals("")) {
			offset = "0";
		}

		//搜索条件形成
		String searchStr = "where  1=1";
		String title= request.getParameter("title");
		if(title!=null&&!title.equals(""))
		{
			title=Common.getFormatStr(title);
			searchStr+=" and  title like  '%"+title+"%' ";
			
		}else
		{
			title="";
		}
		String sort_flag= request.getParameter("sort_flag");
		if(sort_flag!=null&&!sort_flag.equals(""))
		{
			sort_flag=Common.getFormatStr(sort_flag);
			searchStr+=" and  sort_flag = '" + sort_flag + "' ";
			
		}else
		{
			sort_flag="";
		}
		String query = "select * from index_21sun "+searchStr+" and sort_flag in(4,6,7,8,9,10,11,12,13,14,15,16,17) order by sort_flag,order_no";	
		
		ResultSet rs = pagination.getQueryResult(query, request, conn);
		String bar = pagination.paginationPrint(); //读取分页提示
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style>
</head>
<body>
<form action="" method="get" name="theform" id="theform">

  <table width="95%"  border="0"  cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="0%" class="title_bar">&nbsp;</td>
            <td width="21%" class="p94b">&nbsp;</td>
            <td width="70%"  ><span class="title1">标题：
              <input name="title" id="title" type="text" value="<%=title %>" class="xmlInput" style="width:150px"/>
			类型：<select name="sort_flag" id="sort_flag">
			 <option value="">全部类型</option>
			
          <option value="4" <%if(sort_flag.equals("4"))out.print("selected");%>>热点</option>
         
          <option value="6" <%if(sort_flag.equals("6"))out.print("selected");%>>案例营销</option>
          <option value="7" <%if(sort_flag.equals("7"))out.print("selected");%>>行业信息</option>
		   <option value="8" <%if(sort_flag.equals("8"))out.print("selected");%>>数据分析</option>
		 <option value="9" <%if(sort_flag.equals("9"))out.print("selected");%>>最新视频</option>
          <option value="10" <%if(sort_flag.equals("10"))out.print("selected");%>>本网热点</option>
           <option value="11" <%if(sort_flag.equals("11"))out.print("selected");%>>新版资讯</option>
            <option value="12" <%if(sort_flag.equals("12"))out.print("selected");%>>视频直播</option>
            <option value="13" <%if(sort_flag.equals("13"))out.print("selected");%>>排行榜</option>
            <option value="14" <%if(sort_flag.equals("14"))out.print("selected");%>>录入排行１</option>
            <option value="15" <%if(sort_flag.equals("15"))out.print("selected");%>>录入排行２</option>
			<option value="16" <%if(sort_flag.equals("16"))out.print("selected");%>>调用排行1</option>
            <option value="17" <%if(sort_flag.equals("17"))out.print("selected");%>>调用排行2</option>
        </select>
                <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit22" value="清空" onclick="javascript:clearForm()" />
              </span>
              
            </td>
            <td width="9%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
           
			<td height="15" width="9%">
           <a href="http://21-sun.com/tools/createLastNews.jsp" target="_blank">最新资讯</a>
            </td>
			<td height="15" width="10%">
           <a href="http://21-sun.com/tools/createHyReport.jsp" target="_blank">行业分析报告</a>            </td>
		
			<td height="15" width="4%">
           <a href="http://21-sun.com/tools/createHot.jsp" target="_blank">热点</a>
            </td>
			
			<td height="15" width="9%">
           <a href="http://21-sun.com/tools/createSel.jsp" target="_blank">案例营销</a>
            </td>
			<td height="15" width="8%">
           <a href="http://21-sun.com/tools/createHyMessage.jsp" target="_blank">行业信息</a>
            </td>
			<td height="15" width="8%">
           <a href="http://21-sun.com/tools/createDataAnalysis.jsp" target="_blank">数据分析</a>
            </td>
            <td height="15" width="8%">
           <a href="http://21-sun.com/tools/createNewVideo.jsp" target="_blank">最新视频</a>
            </td>
            <td height="15" width="8%">
           <a href="http://21-sun.com/tools/createNetHot.jsp" target="_blank">本网热点</a>
            </td>
            <td height="15" width="8%">
           <a href="http://21-sun.com/tools/createHyMessage_peitao.jsp" target="_blank">新版资讯</a>
            </td>
            <td height="15" width="8%">
           <a href="http://21-sun.com/tools/createVideoPlay.jsp" target="_blank">视频直播</a>
            </td>
            <td height="15" width="9%">
           <a href="http://21-sun.com/tools/createNewOrder.jsp" target="_blank">排行榜全部</a>
            </td>
			<td>
          <a href="http://21-sun.com/tools/createIndex.jsp" target="_blank"></a>
            </td>
			
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="4%" align="center"    bgcolor="e8f2ff"><strong>序</strong></td>
            <td width="25%" align="center"    bgcolor="e8f2ff"><div ><span class="p92z"><strong>标题</strong></span></div></td>
            <td width="19%" align="center"    bgcolor="e8f2ff"><strong>类型</strong></td>
            <td width="30%" align="center"    bgcolor="e8f2ff"><div ><span class="p92z"><strong>主链接</strong></span></div></td>
            <td width="11%" align="center"    bgcolor="e8f2ff"><div ><span class="p92z"><strong>发布时间</strong></span></div></td>
            <td width="11%" align="center"  bgcolor="e8f2ff"><div ><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="7"></td>
          </tr>
          <%
 int k=0;
 while (rs!=null && rs.next()){
   k=k+1;
   String type_flag = "";
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%> >
            <td    > <%=Common.getFormatInt(rs.getString("order_no")) %></td>
           <td    >
                                             <span class="link" > 
                                             <a href="#" onclick="openWin('<%=pageSubName%>?id=<%=rs.getString("id")%>&flag=1','win',800,600)">
                                           	  <%=Common.getFormatStr(rs.getString("title")) %>                                              </a></span>                                              </td>
                                               <td  >
											   <%
											   String type = "";
											   type_flag = Common.getFormatStr(rs.getString("sort_flag"));
											   if("1".equals(type_flag)){
											   		type = "最新资讯";
											   }else if("2".equals(type_flag)){
											   		type = "行业分析报告";
											   }else if("4".equals(type_flag)){
											   		type = "热点";
											   }else if("6".equals(type_flag)){
											   		type = "案例营销";
											   }else if("7".equals(type_flag)){
											   		type = "行业信息";
											   }else if("8".equals(type_flag)){
											   		type = "数据分析";
											   }else if("9".equals(type_flag)){
													type = "最新视频";
												}else if("10".equals(type_flag)){
													type = "本网热点";
												}else if("11".equals(type_flag)){
													type = "新版资讯";
												}else if("12".equals(type_flag)){
													type = "视频直播";
												}else if("13".equals(type_flag)){
													type = "排行榜";
												}else if("14".equals(type_flag)){
													type = "录入排行榜１";
												}else if("15".equals(type_flag)){
													type = "录入排行榜２";
												}else if("16".equals(type_flag)){
													type = "调用排行榜１";
												}else if("17".equals(type_flag)){
													type = "调用排行榜２";
												}
											   
											   %>
											   <%=type%>
											   </td>
                                               <td  >
                                              			<%=Common.getFormatStr(rs.getString("url")) %>                                              </td>
                                              <td  >
                                              			<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date")) %>                                              </td>
                                              <td  >
                                              <div >
                                              <span class="p92j">
                                          <%if(Integer.parseInt(Common.getFormatStr(rs.getString("sort_flag"))) > 12 && "0".equals(Common.getFormatStr(rs.getString("order_no")))){ %>    
								             <a href="#" onclick="openWin('<%=pageSubName%>?id=<%=rs.getString("id")%>&flag=1&tag=<%=type_flag%>','win',800,600)">修改排行榜头条</a>
								           <%}else{ %>
								           	 <a href="#" onclick="openWin('<%=pageSubName%>?id=<%=rs.getString("id")%>&flag=1&tag=<%=type_flag%>','win',800,600)">修改</a>
								           <%} %>
								             </span></div>								             </td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="7"><%=bar%></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
}%>
