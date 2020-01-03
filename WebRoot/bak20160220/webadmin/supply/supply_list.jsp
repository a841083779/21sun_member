<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool4 = new PoolManager(1);
Connection conn =null;


//=====页面属性====
String tablename="supply_ad";
String pageSubName="supply_add.jsp";

//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
 
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");
//得到参数 测试
String corpname=Common.getFormatStr(request.getParameter("corpname"));
if(!corpname.equals("")){
	query.append(" and corpname like '%"+corpname+"%'");
}
String keyword=Common.getFormatStr(request.getParameter("keyword"));
if(!keyword.equals("")){
    query.append(" and keyword = '"+keyword+"' ");
}
String imgfile=Common.getFormatStr(request.getParameter("imgfile"));
if(!imgfile.equals("")){
    query.append(" and imgfile like '%"+imgfile+"%' ");
}

String adcate = Common.getFormatStr(request.getParameter("adcate"));
if(!adcate.equals("")){
    query.append(" and adcate = '"+adcate+"' ");
}
try{
conn = pool4.getConnection();
//SQL查询
//System.out.print(query);
ResultSet rs = pagination.getQueryResult(query.toString()+" order by id desc", request,conn,1);

//pagination.getQueryResult(query.toString(), request,conn);;//pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.paginationPrint();//读取分页提栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script>
   function sub(){
	   theform.submit();
   }
   function keyw(kw){
   document.getElementById("keyword").value=kw;
   theform.submit();
   }
   function adc(kw){
   document.getElementById("adcate").value=kw;
   theform.submit();
   }
</script>
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
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td class="p94b"><span class="title1">企业名称：
              <input name="corpname" type="text" id="corpname" value="<%=corpname%>" />&nbsp;&nbsp;&nbsp;
              关键字:
			  <input name="keyword" type="text" id="keyword" value="<%=keyword%>" />&nbsp;&nbsp;&nbsp;图像文件:
			  <input name="imgfile" type="text" id="imgfile" value="<%=imgfile%>" />
			  广告位置:
			  <select size="1" name="adcate" id="adcate">
            <option value="" <%if("".equals(adcate)){ %> selected <%} %>>所有位置</option>
            <option value="1"  <%if("1".equals(adcate)){ %> selected <%} %>>上方旗帜广告</option>
            <option value="2"   <%if("2".equals(adcate)){ %> selected <%} %>>右上文字连接</option>
            <option value="3"   <%if("3".equals(adcate)){ %> selected <%} %>>页中横幅广告</option>
            <option value="4"   <%if("4".equals(adcate)){ %> selected <%} %>>页中图标广告</option>
            <option value="5"   <%if("5".equals(adcate)){ %> selected <%} %>>推荐企业目录</option>
         </select>&nbsp;&nbsp;&nbsp;
              <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit22" value="清空" onclick="javascript:clearForm()" />
              </span>
              <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />            </td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
				<input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,500)"/>					
		    </td>
			  
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="4%" bgcolor="e8f2ff"><strong>排名</strong></td>
            <td width="15%" align="center" bgcolor="e8f2ff"><div align="center">关键字</div></td>
            <td   align="center" bgcolor="e8f2ff"><div align="center">企业名称</div></td>
            <td   align="center" bgcolor="e8f2ff">广告位置</td>
            <td  width="10%" align="center" bgcolor="e8f2ff">开始时间</td>
            <td  width="10%" align="center" bgcolor="e8f2ff">结束时间</td>
            <td  width="10%" align="center" bgcolor="e8f2ff">发部时间</td>
            <td  width="10%" align="center" bgcolor="e8f2ff">搜索点击量</td>
            <td width="9%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否发布</strong></span></div></td>
            <td width="10%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
          </tr>
          <%
          ResultSet rsk =null;
          String sql ="";
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
   String is_recom1 = Common.getFormatStr(rs.getString("adcate"));
   String kwd = Common.getFormatStr(rs.getString("keyword"));
   String num = "0";
    sql = "select clicked from supply_ad_click where kwd = '"+kwd+"'";
    rsk = DataManager.executeQuery(conn,sql);
   while(rsk.next()){
   	num = rsk.getString("clicked");
   	
   }
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td><%=Common.getFormatStr(rs.getString("orderid"))%></td>
            <td align="center"><div align="center">
            <a href="#" onclick="keyw('<%=Common.getFormatStr(rs.getString("keyword"))%>')">
            <%=Common.getFormatStr(rs.getString("keyword"))%></a></div></td>
			<td align="center"><div align="center">
			<%=Common.getFormatStr(rs.getString("corpname"))%>
			</div></td>
            <td align="center" nowrap="nowrap">
            <a href="#" onclick="adc('<%=is_recom1 %>')">
            <%
			 if(is_recom1.equals("1")){
			    out.print("上方旗帜广告");
			  }else if(is_recom1.equals("2")){
			     out.println("右上文字连接");
			  }else if(is_recom1.equals("3")){
			    out.println("页中横幅广告");
			  }
			  else if(is_recom1.equals("4")){
			    out.println("页中图标广告");
			  }else if(is_recom1.equals("5")){
			    out.println("推荐企业目录");
			  }
			  
			%>
			</a>
            </td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("startdate"))%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("enddate"))%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("pubdate"))%></span></div></td>
             <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(num)%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("ispublished")).equals("1")?"发布":"暂缓发布"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; 
            <a href="#" onclick="openWin('<%=pageSubName%>?id=<%=rs.getString("id")%>','winsu',800,500)">修改</a></span> &nbsp;&nbsp; </div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="6"><%=bar%></td>
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
	pool4.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
