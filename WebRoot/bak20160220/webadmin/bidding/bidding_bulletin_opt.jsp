<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="bidding_bulletin_opt.jsp";
String mypy="bidding_bulletin";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id


String urlpath="../bidding/bidding_bulletin_list.jsp";


try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>招标发布</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script>
//为多选框赋值
function submityn(){
		
		var obj2 = document.getElementsByName("product_flag");
		var sortNumValue = ",";
		for(var i=0;i<obj2.length;i++){
			if(obj2[i].checked){
				sortNumValue += obj2[i].value+",";
			}
		}
		if(sortNumValue==",") sortNumValue="";
		theform.zd_product_flag.value = sortNumValue;	
		//alert(theform.zd_product_flag.value);
		
		if(theform.zd_title.value==""){
			alert("请输入标题！");
			theform.zd_title.focus();
			return false;
		}
			
		theform.submit();
}
function set_city(va1,va2,va3){}


</script>
</head>
<body>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="list_border_bg">
    <tr>
      <td width="14%" height="22" align="right" class="list_left_title">公告名称：</td>
      <td width="86%" height="22" class="list_cell_bg"><input name="zd_title" type="text" class="required" id="zd_title" size="60" maxlength="500"></td>
    </tr>
    <!-- <tr>
      <td height="22" align="right" class="list_left_title">公告编号：</td>
      <td height="22" class="list_cell_bg"><input name="zd_serial" type="text" id="zd_serial" size="30" maxlength="500"></td>
    </tr>-->
    <tr>
      <td height="80" align="right" class="list_left_title">公告类别：</td>
      <td height="22" class="list_cell_bg">&nbsp;
                  <input type="radio" name="zd_catalog_num" value="2000" >招标公告
                  <input type="radio" name="zd_catalog_num" value="5000" >
                  政府采购目录 <br>  
                  &nbsp;<input type="radio" name="zd_catalog_num" value="3000" >招标变更
                  &nbsp;
                  <input type="radio" name="zd_catalog_num" value="4000" >中标公告<br>
      &nbsp;
      <input type="radio" name="zd_catalog_num" value="1000" >
      招标预告（拟在建项目、招标预告）</td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">招标性质：</td>
      <td height="22" class="list_cell_bg"><input name="zd_flag" type="radio" class="form_radio" value="1000" >
项目招标
  <input name="zd_flag" type="radio" class="form_radio" value="2000" checked> 
  设备招标

  <input name="zd_flag" type="radio" class="form_radio" value="3000">
政府采购 </td>
    </tr>
	<tr>
      <td height="22" align="right" class="list_left_title">发布到配套网采购招标：</td>
	  <td>
  		<input name="zd_fittings_flag" type="radio" class="form_radio" value="2000">是
		<input name="zd_fittings_flag" type="radio" class="form_radio" value="0" checked>否
	  </td>
    </tr>
    <tr>
      <td height="80" align="right" class="list_left_title">设备招标类别：</td>
      <td height="22" class="list_cell_bg">
      <input type="checkbox" name="product_flag" value="10001" >挖掘机械
	  <input type="checkbox" name="product_flag" value="10002" >铲运机械
	  <input type="checkbox" name="product_flag" value="10003" >起重机械
	  <input type="checkbox" name="product_flag" value="10004"  >路面机械
	  <input type="checkbox" name="product_flag" value="10005" >混凝土机械<br>
	  <input type="checkbox" name="product_flag" value="10006" >动力机械
	  <input type="checkbox" name="product_flag" value="10007" >铁路机械
	  <input type="checkbox" name="product_flag" value="10008" >市政机　
	  <input type="checkbox" name="product_flag" value="10010" >桩、泵有关
	  <input type="checkbox" name="product_flag" value="10011" >钢加工机械<br>
	  <input type="checkbox" name="product_flag" value="10012" >其他工程机械
	  <input type="checkbox" name="product_flag" value="20000" >
	  <font color="#FF0000">非工程机械</font>	 
	  <input name="zd_product_flag" type="hidden" id="zd_product_flag" value="">	  
	  </td>
    </tr>
<!-- 
    <tr>
      <td height="22" align="right" class="list_left_title">地域范围：</td>
      <td height="22" class="list_cell_bg">
<input name="zd_is_inner" type="radio" class="form_radio" value="1" >
        国际采购
        <input name="zd_is_inner" type="radio" class="form_radio" value="2" checked>
        国内招标	  </td>
    </tr>-->
    <tr>
      <td height="80" align="right" class="list_left_title">所在省份：</td>
      <td height="22" class="list_cell_bg">
	  
	  
	  <input type="radio" name="zd_province" Value=北京>北京<input type="radio" name="zd_province" Value=上海>上海<input type="radio" name="zd_province" Value=天津>天津<input type="radio" name="zd_province" Value=重庆>重庆<input type="radio" name="zd_province" Value=吉林>吉林<input type="radio" name="zd_province" Value=辽宁>辽宁<input type="radio" name="zd_province" Value=河北>河北<input type="radio" name="zd_province" Value=内蒙>内蒙<input type="radio" name="zd_province" Value=陕西>陕西<input type="radio" name="zd_province" Value=山西>山西
	  <input type="radio" name="zd_province" Value=黑龙江>
	  黑龙江<br>
	  <input type="radio" name="zd_province" Value=甘肃>甘肃<input type="radio" name="zd_province" Value=青海>青海<input type="radio" name="zd_province" Value=宁夏>宁夏<input type="radio" name="zd_province" Value=新疆>新疆<input type="radio" name="zd_province" Value=山东>山东<input type="radio" name="zd_province" Value=江苏>江苏<input type="radio" name="zd_province" Value=江西>江西<input type="radio" name="zd_province" Value=浙江 >浙江<input type="radio" name="zd_province" Value=福建>福建<input type="radio" name="zd_province" Value=广东>广东<input type="radio" name="zd_province" Value=湖北>湖北<br>
	  <input type="radio" name="zd_province" Value=湖南>湖南<input type="radio" name="zd_province" Value=安徽>安徽<input type="radio" name="zd_province" Value=河南>河南<input type="radio" name="zd_province" Value=广西>广西<input type="radio" name="zd_province" Value=云南>云南<input type="radio" name="zd_province" Value=贵州>贵州<input type="radio" name="zd_province" Value=四川>四川<input type="radio" name="zd_province" Value=海南>海南<input type="radio" name="zd_province" Value=港澳>港澳	  </td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">发布日期：</td>
      <td height="22" class="list_cell_bg"><input name="zd_pub_date" type="text" class="required" id="zd_pub_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" maxlength="50"></td>
    </tr>
 <!--    
    <tr>
      <td height="22" align="right" class="list_left_title">截止日期：</td>
      <td height="22" class="list_cell_bg"><input name="zd_end_date" type="text" class="required" id="zd_end_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" maxlength="50"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">主办机构：</td>
      <td height="22" class="list_cell_bg"><input name="zd_organizer" type="text" id="zd_organizer" size="60" maxlength="500"></td>
    </tr>-->
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">上传资料：</td>
      <td height="22" class="list_cell_bg"><input name="zd_resources" type="text" id="zd_resources" size="60" maxlength="100">
      <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://main.21-sun.com/upload/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_resources','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">公告内容：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_content" cols="60" rows="12" id="zd_content"></textarea></td>
    </tr>
    <tr >
      <td height="22" align="right" nowrap class="list_left_title">是否发布：</td>
      <td height="22" class="list_cell_bg"><input name="zd_is_show" type="radio" class="form_radio" value="1" checked>
        立即发布
        <input name="zd_is_show" type="radio" class="form_radio" value="0">
        暂不发布        </td>
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
          <input name="catalog_no" type="hidden" id="zd_catalog_no" value="700202"></td>
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
