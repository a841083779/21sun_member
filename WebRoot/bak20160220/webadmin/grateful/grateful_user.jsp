<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
PoolManager pool3 = new PoolManager(1);
DataManager dataManager = new DataManager();
Connection conn = null;


//=====页面属性====
String tablename="member_info";
String pageSubName="guestbook_opt.jsp";
//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(10);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}


StringBuffer query =new StringBuffer("select id,mem_no,mem_name,isnull(jiang,'') as jiang,isnull(jiang_chuli,'') as jiang_chuli from "+tablename+" where jiang is not NULL and mem_name is not null and mem_name<>'' order by login_last_date desc");
//得到参数

try{
conn = pool3.getConnection();
//获奖总人数
String count = "";
String selQuery = "select count(id) as count from member_info where (jiang is not NULL or jiang_chuli is not null)";
ResultSet rsCount = dataManager.executeQuery(conn,selQuery);
while(rsCount.next()){
	count=Common.getFormatStr(rsCount.getString("count"));
}
//if(!"".equals(Common.getFormatStr(request.getParameter("ids")))){
//	String sql = " delete from "+tablename+" where id in ("+Common.getFormatStr(request.getParameter("ids"))+")";
//	DataManager.dataOperation(pool3,sql);
//}
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
String bar = pagination.pagesPrint(10); //读取分页提栏
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
         <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
            	获奖总人数统计 :  ( <%=count %> )人&nbsp;&nbsp;
	            <input type="button" value="各类奖项统计" onclick="openWin('grateful_user_count.jsp','win',800,600)"/>&nbsp;&nbsp;
	            <input type="button" value="获奖用户区域统计" onclick="openWin('grateful_user_pro.jsp','win',800,600)"/>&nbsp;&nbsp;
	            <input type="button" value="获奖用户行业统计" onclick="openWin('grateful_user_mode.jsp','win',800,600)"/>&nbsp;&nbsp;
	            <input type="button" value="获奖用户导出" onclick="openWin('grateful_user_export.jsp','win',800,600)"/>&nbsp;&nbsp;
            </td>
          </tr>
          <tr>
            <td height="15">&nbsp;</td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="10%" bgcolor="e8f2ff" align="center"><strong>姓名</strong></td>
            <td width="70%" bgcolor="e8f2ff" align="center"><strong>未处理奖品</strong></td>
            <td width="20%" align="center" bgcolor="e8f2ff"><strong>已处理奖品</strong></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
          </tr>
          <%
String temp_sort_flag="";
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
   //中奖
   String jiang = rs.getString("jiang");
   String id = rs.getString("id");
   String jiangString = "";
   if(jiang!=null && !jiang.equals("")){
		String[] jiangArr = jiang.split(",");
		for(int i=0;i<jiangArr.length;i++){
			if(jiangArr[i].equals("1")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','1')\">套餐优惠券</a><br />";
			}else if(jiangArr[i].equals("2")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','2')\">会员优惠券</a><br />";
			}else if(jiangArr[i].equals("3")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','3')\">杰配网优惠券</a><br />";
			}else if(jiangArr[i].equals("4")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','4')\">人才网优惠券</a><br />";
			}else if(jiangArr[i].equals("5")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','5')\">21-sun卡盘</a><br />";
			}else if(jiangArr[i].equals("6")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','6')\">21-sun阳光宝宝便签夹</a><br />";
			}else if(jiangArr[i].equals("7")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','7')\">数据报告券</a><br />";
			}else if(jiangArr[i].equals("101")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','101')\">挖掘机报告券</a><br />";
			}else if(jiangArr[i].equals("102")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','102')\">装载机报告券</a><br />";
			}else if(jiangArr[i].equals("103")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','103')\">推土机报告券</a><br />";
			}else if(jiangArr[i].equals("104")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','104')\">压路机报告券</a><br />";
			}else if(jiangArr[i].equals("105")){
				jiangString += "<a href=\"javascript:chuLi('"+id+"','105')\">起重机报告券</a><br />";
			}
		}
   }
   //处理
   String jiang_chuli = rs.getString("jiang_chuli");
   String jiangChuliString = "";
   if(jiang_chuli!=null && !jiang_chuli.equals("")){
		String[] jiangChuliArr = jiang_chuli.split(",");
		for(int i=0;i<jiangChuliArr.length;i++){
			if(jiangChuliArr[i].equals("1")){
				jiangChuliString += "套餐优惠券<br />";
			}else if(jiangChuliArr[i].equals("2")){
				jiangChuliString += "会员优惠券<br />";
			}else if(jiangChuliArr[i].equals("3")){
				jiangChuliString += "杰配网优惠券<br />";
			}else if(jiangChuliArr[i].equals("4")){
				jiangChuliString += "人才网优惠券<br />";
			}else if(jiangChuliArr[i].equals("5")){
				jiangChuliString += "21-sun卡盘<br />";
			}else if(jiangChuliArr[i].equals("6")){
				jiangChuliString += "21-sun阳光宝宝便签夹<br />";
			}else if(jiangChuliArr[i].equals("7")){
				jiangChuliString += "数据报告券<br />";
			}else if(jiangChuliArr[i].equals("101")){
				jiangChuliString += "挖掘机报告券<br />";
			}else if(jiangChuliArr[i].equals("102")){
				jiangChuliString += "装载机报告券<br />";
			}else if(jiangChuliArr[i].equals("103")){
				jiangChuliString += "推土机报告券<br />";
			}else if(jiangChuliArr[i].equals("104")){
				jiangChuliString += "压路机报告券<br />";
			}else if(jiangChuliArr[i].equals("105")){
				jiangChuliString += "起重机报告券<br />";
			}
		}
   }
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F999'":""%>>
            <td align="center"><div align="center"><%=rs.getString("mem_name")%></div></td>
            <td align="center"><div align="center"><%=jiangString %></div></td>
            <td align="center"><div align="center"><%=jiangChuliString%></div></td>
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
<script type="text/javascript">
function chuLi(id,flag){
	var rs = confirm("确定要处理选中项吗？");
	if(rs){
		$.ajax({
			type:"post",
			url:"chuli.jsp",
			data:"id="+id+"&flag="+flag,
			success:function(msg){
				//alert(msg);
				if($.trim(msg)=='ok'){
					alert("处理成功！");
				}else{
					alert("处理失败！");
				}
				window.location.href=window.location.href;
			}
		});
	}
}
function doDelAll(){
	var rs = confirm("确定要删除选中项吗？");
	if(rs){
		var idStr = "";
		jQuery.each(jQuery(".ids:checked"),function(index,data){
			idStr += this.value+",";
		});
		if(idStr.indexOf(",")!=-1){
			idStr = idStr.substring(0,idStr.length-1);
		}
	}
	window.location.href="/webadmin/grateful/grateful_guestbook.jsp?ids="+idStr;
}
jQuery("#allChecked").click(function(){
	if(this.checked){
		jQuery(".ids").attr("checked","checked");
	}else{
		jQuery(".ids").removeAttr("checked");
	}
});
</script>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool3.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
