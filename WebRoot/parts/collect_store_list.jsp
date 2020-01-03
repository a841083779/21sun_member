<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%

	pool = new PoolManager(7);

Connection conn =null;
	
String tablename="parts_collection";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(18);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");
query.append(" and flag='2' ");

HashMap<String,String> memflagHm = new HashMap<String,String>();
memflagHm.put("1001","VIP会员");
memflagHm.put("1002","B类会员");
memflagHm.put("1003","A类会员");
memflagHm.put("1005","租赁通(3500)");
memflagHm.put("-1","普通会员");
memflagHm.put("1004","证券咨询类会员");
memflagHm.put("1006","人才网会员");
memflagHm.put("1007","普通二手会员");
memflagHm.put("1008","高级二手会员");
memflagHm.put("1009","租赁站长");
memflagHm.put("1010","配件网备备通");
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
  <div class="loginlist_right2"><span class="mainyh">管理配件店铺收藏</span></div>
  <div class="loginlist_right1"><span class="title_bar">
<a href="collect_parts_list.jsp"><img src="../images/pjsc.gif" style="border:0px;height:27px"/> </a>

    <table width="100%" border="0" class="list">
      <tr>
        <th width="5%">序</th>
		<th width="17%">店铺名称</th>
        <th width="11%">联系人</th>
		<th width="11%">联系方式</th>
        <th width="11%">会员类型</th>
        <th width="9%">收藏地址</th>
        <th width="12%">收藏时间</th>
        <th width="11%" align="center">操作</th>
      </tr>
<%
 	int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
	
    String title_temp ="",store_no_temp="",store_name_temp="",remark_temp="",url_temp="",add_date_temp="",telephone_temp="",mem_flag_temp="";
	String type_temp ="",mem_name_temp="";
	
    while(rs!=null && rs.next()){
         k=k+1;
		 mem_name_temp      = Common.getFormatStr(rs.getString("mem_name"));
		 store_name_temp    = Common.getFormatStr(rs.getString("store_name"));
		 url_temp           = Common.getFormatStr(rs.getString("url"));
		 add_date_temp      = Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"));
		 telephone_temp     = Common.getFormatStr(rs.getString("telephone"));
		 mem_flag_temp      = Common.getFormatStr(rs.getString("mem_flag"));		 	   
%>		  
      <tr>
        <td><%=k%></td>
		<td><a href="<%=url_temp%>" target="_blank"><%=store_name_temp%></a></td>
        <td><%=mem_name_temp%></td>
		<td><%=telephone_temp%></td>
		<td><%=Common.getFormatStr(memflagHm.get(mem_flag_temp))%></td>     
		<td><a href="<%=url_temp%>" target="_blank">点击查看</a></td>
        <td><%=add_date_temp%></td>
        <td align="center"><a href="javascript:otherDeleteData('../parts/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');"> 删除</a></td>
      </tr>
<%
  }rs.close();
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