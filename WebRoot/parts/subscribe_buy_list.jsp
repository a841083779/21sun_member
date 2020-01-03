<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%

	pool = new PoolManager(7);

Connection conn =null;
	
String tablename="parts_subscribe";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(18);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1  and mem_no= '").append(usern).append("' ");

query.append(" and type='0' ");
try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.paginationPrint();  //读取分页提示栏
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript">
	function jumpParts(type){
	 alert("type="+type);
	  if(type==0){
	     document.theform1.action="http://localhost:9123/buy/index.jsp";
	  }else if(type==1){
	     document.theform1.action="http://localhost:9123/supply/index.jsp";
	  }
       document.theform1.submit();
	}
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">管理配件求购订阅</span></div>
  <div class="loginlist_right1">
    <div style="width:100%;height:25px"><a href="javascript:window.location.href='subscribe_opt.jsp?type=0'" style="width:80px;float:left" ><img src="../images/cjdy.gif" border="0"/></a>
  <span class="title_bar st1"><input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:117px;height:27px;border:none;background:url(../images/gydy.gif) left top no-repeat;cursor: pointer;" onclick="window.location.href='subscribe_supply_list.jsp'" /></span></div>


    <table width="100%" border="0" class="list" style="margin-top:5px">
      <tr>
        <th width="3%">序</th>
        <th width="13%">订阅器名称</th>
        <th width="9%">产品类别</th>
        <th width="8%">型号</th>
       <!-- <th width="11%">新旧要求</th>-->
        <th width="8%">是否正厂</th>
		<th width="11%">是否紧急</th>
        <th width="11%">所在地</th>
        <th width="11%">订阅时间</th>
        <th width="15%" align="center">操作</th>
      </tr>
<%
 	int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
	
    String name_temp ="",category_temp="",model_temp="",old_temp="",is_original_temp="",is_urgent_temp="",province_temp="",city_temp="";
	String type_temp ="";
	
    while(rs!=null && rs.next()){
         k=k+1;
		 name_temp         = Common.getFormatStr(rs.getString("name"));
		 category_temp     = Common.getFormatStr(rs.getString("category"));
		 model_temp        = Common.getFormatStr(rs.getString("model"));
		 old_temp          = Common.getFormatStr(rs.getString("old"));
		 is_original_temp  = Common.getFormatStr(rs.getString("is_original"));
		 is_urgent_temp    = Common.getFormatStr(rs.getString("is_urgent"));
		 province_temp     = Common.getFormatStr(rs.getString("province"));
		 city_temp         = Common.getFormatStr(rs.getString("city"));
		 type_temp         = Common.getFormatStr(rs.getString("type"));

%>		  
      <tr>
        <td><%=k%></td>
        <td><a href="http://part.21-sun.com/buy/index.jsp?category=<%=java.net.URLEncoder.encode(category_temp,"utf-8")%>&model=<%=java.net.URLEncoder.encode(model_temp,"utf-8")%>&old=<%=old_temp%>&is_original=<%=is_original_temp%>&is_urgent=<%=is_urgent_temp%>&province=<%=java.net.URLEncoder.encode(province_temp,"utf-8")%>&city=<%=java.net.URLEncoder.encode(city_temp,"utf-8")%>" target="_blank"><%=name_temp%></a></td>
		<td><cache:cache key="subscribe_buy" cron="0 0/30 6-23 * * ?"><%=Common.fetchName(pool,category_temp,"1")%></cache:cache></td>
        <td><%=model_temp%></td>
        <!--<td><%//=old_temp.equals("1")?"全新":(old_temp.equals("2")?"二手":"")%></td>-->
		<td><%=is_original_temp.equals("1")?"正厂":(is_original_temp.equals("0")?"副厂":"")%></td>
		<td><%=is_urgent_temp.equals("1")?"是":(is_urgent_temp.equals("0")?"否":"")%></td>
        <td><%=province_temp%>-<%=city_temp%></td>
        <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></td>
        <td align="center"><a href="javascript:otherDeleteData('../parts/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');"> 删除</a> &nbsp;<a href="subscribe_opt.jsp?myvalue=<%=rs.getString("id")%>&type=0">修改</a></td>
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
  </div></div>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>