<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="bidding_news_opt.jsp";
String mypy="article_other";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id


String urlpath="../bidding/bidding_news_list.jsp";


try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>招标资讯发布</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script>
//为多选框赋值
function submityn(){
		
		var obj2 = document.getElementsByName("sort_num");
		var sortNumValue = ",";
		for(var i=0;i<obj2.length;i++){
			if(obj2[i].checked){
				sortNumValue += obj2[i].value+",";
			}
		}
		if(sortNumValue==",") sortNumValue="";
		theform.zd_sort_num.value = sortNumValue;	
		
		if(theform.zd_title.value==""){
			alert("请输入标题！");
			theform.zd_title.focus();
			return false;
		}
			
		theform.submit();
}
</script>
</head>
<body>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="list_border_bg">
    <tr>
      <td width="14%" height="22" align="right" class="list_left_title">所属栏目：</td>
      <td width="86%" height="22" class="list_cell_bg">
<font color="#0080FF">法规中心</font>（1000）<br>
      <input type="checkbox" name="sort_num" value="10001" >综合法规&nbsp;      
              <input type="checkbox" name="sort_num" value="10002" >设备招标犯规&nbsp;      
              <input type="checkbox" name="sort_num" value="10003" >工程招标法规&nbsp;      
              <input type="checkbox" name="sort_num" value="10004" >政府采购法规&nbsp;<br>
      <input type="checkbox" name="sort_num" value="2000" ><font color="#0080FF">案例分析</font>（2000）<br>
              <font color="#0080FF">实务指南</font>（3000）<br>
      <input type="checkbox" name="sort_num" value="30001" >实务知识&nbsp;      
              <input type="checkbox" name="sort_num" value="30002" >招标流程&nbsp;      
              <input type="checkbox" name="sort_num" value="30003" >办事指南       
      <input type="checkbox" name="sort_num" value="30004" >标书范本<br>
           
	   <input name="zd_sort_num" type=hidden id="zd_sort_num" value="">      </td>
  </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">标题：</td>
      <td height="22" class="list_cell_bg"><input name="zd_title" type="text" class="required" id="zd_title" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">首页标题：</td>
      <td height="22" class="list_cell_bg"><input name="zd_index_title" type="text" id="zd_index_title" size="60" maxlength="500"></td>
    </tr>
    <tr align="center">
      <td height="22" colspan="2" class="list_left_title"><div align="center">文章内容</div></td>
    </tr>
    <tr>
      <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" ><FCK:editor instanceName="zd_content" toolbarSet="simple" width="100%" height="300">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor>      </td>
    </tr>
    <tr >
      <td height="22" align="right" nowrap class="list_left_title">摘要：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_summary"  style="width:96% " rows="4" class="form_input" id="zd_summary"></textarea>      </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>录入时间：</strong></td>
      <td class="list_cell_bg"><input name="zd_pub_date" type="text" class="required" id="zd_pub_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" maxlength="50">
          <span class="text_remark">时间格式为“年-月-日 时:分:秒”，如：2003-5-12 12:32:47</span></td>
    </tr>
    <tr >
      <td height="22" align="right" nowrap class="list_left_title">是否发布：</td>
      <td height="22" class="list_cell_bg"><input name="zd_is_pub" type="radio" class="form_radio" value="1" checked>
        立即发布
        <input name="zd_is_pub" type="radio" class="form_radio" value="0">
        暂不发布        </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">点击数初始值：</td>
      <td height="22" class="list_cell_bg"><input name="zd_view_count" type="text" id="zd_view_count" value="0" size="5" maxlength="100"></td>
    </tr>
    <tr>
      <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" ><input type="button" name="Submit" value="保存" onClick="submityn()">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_user" type="hidden" id="zd_add_user" value="">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>">
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
          <input name="zd_catalog_no" type="hidden" id="zd_catalog_no" value="700202"></td>
    </tr>
  </table>
  </form>
  <iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
  <script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","../manage/set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));	
	}
}
<%
if(!myvalue.equals("")){
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
