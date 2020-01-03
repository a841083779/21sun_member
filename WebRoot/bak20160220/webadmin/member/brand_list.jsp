<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;

String brandId = Common.getFormatStr(request.getParameter("brandId"));

ArrayList<String> brandIdArrList = new ArrayList<String>();
String[] brandIdArr=null;
if(!brandId.equals("")){
  brandIdArr = brandId.split(",");
  if(brandIdArr!=null){
    for(int i=0;i<brandIdArr.length;i++){
	   brandIdArrList.add(Common.getFormatStr(brandIdArr[i]));
	}
  }
}


String tablename="vi_othercall_product";
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select distinct factoryid,factoryname from "+tablename+" where 1=1 ");

String find_factoryname=Common.getFormatStr(request.getParameter("find_factoryname"));
if(!find_factoryname.equals("")){
	query.append(" and factoryname like '%"+find_factoryname+"%' ");
}
query = query.append(" order by factoryid ");

try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs =DataManager.executeQuery(conn,query.toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>品牌选择</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script>
function doselect()
{var chs = new Array();
$("input[type=checkbox]:checked").each(function(){
chs.push($(this).val());
});


//alert(chs.toString());

window.opener.document.theform.zd_parts_brand.value=chs.toString();
window.close();
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
<%//=query.toString()+" order by id desc"%>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><form name="theform">
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td class="p94b">品牌名称：
              <input name="find_factoryname" type="text" id="find_factoryname" size="15" value="<%=find_factoryname%>" />
              <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit2" value="清除" onclick="javascript:clearForm()" />
              <input name="b_confirm" type="button" id="b_confirm" value="选择品牌" onclick="javascript:doselect();"></td>
          </tr>
        </table>
      </form>
      <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="13%" height="30" align="center"  bgcolor="e8f2ff"><strong>品牌ID</strong></td>
          <td width="87%"  bgcolor="e8f2ff"><strong>品牌名称</strong></td>
        </tr>
        <tr>
          <td height="30" align="center" >recom</td>
          <td ><input type="checkbox" name="checkbox" value="recom" <%=brandIdArrList.contains("recom")?"checked":""%>/>
            特别推荐&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td height="30" align="center" >other</td>
          <td ><input type="checkbox" name="checkbox" value="other" <%=brandIdArrList.contains("other")?"checked":""%>/>
            其它品牌&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td height="30" align="center" >sanling</td>
          <td ><input type="checkbox" name="checkbox" value="sanling" <%=brandIdArrList.contains("sanling")?"checked":""%> />
            三菱&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td height="30" align="center" >pojinsi</td>
          <td ><input type="checkbox" name="checkbox" value="pojinsi" <%=brandIdArrList.contains("pojinsi")?"checked":""%>/>
            珀金斯&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td height="30" align="center" >kangmingsi</td>
          <td ><input type="checkbox" name="checkbox" value="kangmingsi" <%=brandIdArrList.contains("kangmingsi")?"checked":""%>/>
            康明斯&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td height="30" align="center" >baomage</td>
          <td ><input type="checkbox" name="checkbox" value="baomage" <%=brandIdArrList.contains("baomage")?"checked":""%>/>
            宝马格&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td height="30" align="center" >193</td>
          <td ><input type="checkbox" name="checkbox" value="193" <%=brandIdArrList.contains("193")?"checked":""%> />
            现代&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <% int k=0;
 while (rs!=null && rs.next()){
k=k+1;
%>
        <tr <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
          <td height="30" align="center" ><%=Common.getFormatStr(rs.getString("factoryid"))%></td>
          <td ><input type="checkbox" name="checkbox" value="<%=Common.getFormatStr(rs.getString("factoryid"))%>" <%=brandIdArrList.contains(Common.getFormatStr(rs.getString("factoryid")))?"checked":""%>/>
            <%=Common.getFormatStr(rs.getString("factoryname"))%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <%
}
%>
      </table></td>
  </tr>
</table>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
