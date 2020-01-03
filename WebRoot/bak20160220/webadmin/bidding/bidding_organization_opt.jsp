<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="bidding_organization_opt.jsp";
String mypy="bidding_organization";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id


String urlpath="../bidding/bidding_organization_list.jsp";


try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>机构发布</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script>
//为多选框赋值
function submityn(){
		
		if(theform.zd_name.value==""){
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
      <td width="16%" height="22" align="right" class="list_left_title">机构名称：</td>
      <td width="84%" height="22" class="list_cell_bg"><input name="zd_name" type="text" class="required" id="zd_name" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">构购编号：</td>
      <td height="22" class="list_cell_bg"><input name="zd_org_no" type="text" id="zd_org_no" size="30" maxlength="500"></td>
    </tr>
    <tr>
      <td height="26" align="right" class="list_left_title">结构性质：</td>
      <td height="35" class="list_cell_bg">&nbsp;
                  <input type="radio" name="zd_flag" value="1" >
                  政府机构
                  <input type="radio" name="zd_flag" value="2" >
      代理机构 </td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">资质等级：</td>
      <td height="35" class="list_cell_bg"><input name="zd_class" type="radio" class="form_radio" value="1" >
甲级
  <input name="zd_class" type="radio" class="form_radio" value="2" checked> 
  乙级

  <input name="zd_class" type="radio" class="form_radio" value="0">
  待定</td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">进出口权：</td>
      <td height="35" class="list_cell_bg">
<input name="zd_imp_exp" type="radio" class="form_radio" value="1" >
        有
        <input name="zd_imp_exp" type="radio" class="form_radio" value="0" checked>
        无	  </td>
    </tr>
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
      <td height="22" align="right" nowrap class="list_left_title">法人代表：</td>
      <td height="22" class="list_cell_bg"><input name="zd_contact" type="text" class="required" id="zd_contact" maxlength="50"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">地址：</td>
      <td height="22" class="list_cell_bg"><input name="zd_address" type="text" class="required" id="zd_address" size="60" maxlength="60"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">邮编：</td>
      <td height="22" class="list_cell_bg"><input name="zd_postcode" type="text" id="zd_postcode" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">电话：</td>
      <td height="22" class="list_cell_bg"><input name="zd_tel" type="text" id="zd_tel" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">传真：</td>
      <td height="22" class="list_cell_bg"><input name="zd_fax" type="text" id="zd_fax" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">邮箱：</td>
      <td height="22" class="list_cell_bg"><input name="zd_email" type="text" id="zd_email" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">网址：</td>
      <td height="22" class="list_cell_bg"><input name="zd_url" type="text" id="zd_url" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">加入时间：</td>
      <td height="22" class="list_cell_bg"><input name="zd_in_date" type="text" id="zd_in_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">结构价绍：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_intro" cols="60" rows="12" id="zd_intro"></textarea></td>
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
