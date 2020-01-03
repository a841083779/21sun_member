<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="market_member_opt.jsp";
String mypy="member_info";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id



String urlpath="../member/member_list.jsp";

try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会员管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<script>
//为多选框赋值
function submityn(){
document.theform.submit();
}

function changememname()
{
$("#zd_mem_flag_name").val($("select[name='zd_mem_flag'] option[selected]").text()); 

}

</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body>
<form action="" method="post" name="theform" id="theform">
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="list_border_bg">
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>用 户 名：</strong></td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" size="18"  >
      <span class="list_left_title">密码：
      <input name="zd_passw" type="text" id="zd_passw" size="18" >
      </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">会员级别：</td>
      <td height="22" class="list_cell_bg"><select name="zd_mem_flag" id="zd_mem_flag" onChange="javascript:changememname()">
	     <option value=""></option>
          <%=Common.option_str(pool, "member_role","role_num,role_name"," 1=1 order by role_num", "",0)%>
        </select>
        <input name="zd_mem_flag_name" type="hidden" id="zd_mem_flag_name">
登录次数：
<input name="zd_login_count" type="text" id="zd_login_count" size="10"  >
最后登录日期：
<input name="zd_login_last_date" type="text" id="zd_login_last_date" size="10"  ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">会员状态：</td>
      <td height="22" class="list_cell_bg"><input name="zd_state" type="radio" value="1" checked />
        正常
        <input name="zd_state" type="radio" value="0" />
        禁用 到期日期：
        <input name="zd_mem_flag_enddate" type="text" id="zd_mem_flag_enddate" size="12"  onfocus="calendar(event)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">真实姓名：</td>
      <td height="22" class="list_cell_bg"><input name="zd_mem_name" type="text" id="zd_mem_name" size="20" >
        <input name="zd_per_sex" type="radio" value="男" />
        先生
        <input type="radio" name="zd_per_sex" value="女" />
        女士</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">联系邮箱：</td>
      <td height="22" class="list_cell_bg"><input name="zd_per_email" type="text" id="zd_per_email" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">联系电话：</td>
      <td height="22" class="list_cell_bg"><input name="zd_per_phone" type="text" id="zd_per_phone" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">省　　市：</td>
      <td height="22" class="list_cell_bg"><input name="zd_per_province" type="text" id="zd_per_province" size="5" >
        <input name="zd_per_city" type="text" id="zd_per_city" size="5" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title ">公司名称：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_name" type="text" id="zd_comp_name" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title ">公司简称：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_simple" type="text" id="zd_comp_simple" size="28" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司地址：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_address" type="text" id="zd_comp_address" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">邮　　编：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_postcode" type="text" id="zd_comp_postcode" size="15" >
        企业推荐：
        <input name="zd_comp_recom" type="radio" id="zd_comp_recom" value="0" checked />
        否
        <input name="zd_comp_recom" id="zd_comp_recom" type="radio" value="1" />
        是</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">传　　真：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_fax" type="text" id="zd_comp_fax" size="15" >
        网址：
        <input name="zd_comp_url" type="text" id="zd_comp_url" size="22" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司注册号：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_register_no" type="text" id="zd_comp_register_no" size="40" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">法人代表：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_legal" type="text" id="zd_comp_legal" size="20" >
        <span class="list_left_title">注册资本：
        <input name="zd_comp_capital" type="text" id="zd_comp_capital" size="10" >
        </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">企业类型：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_flag" type="text" id="zd_comp_flag" size="20" >
        <span class="list_left_title">成立日期：
        <input name="zd_comp_founddate" type="text" id="zd_comp_founddate" size="10" >
        </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">登记机关：</td>
      <td height="22" class="list_cell_bg"><span class="list_left_title">
        <input name="zd_comp_register_auth" type="text" id="zd_comp_register_auth" size="20" >
        年检日期：
        <input name="zd_comp_inspectiondate" type="text" id="zd_comp_inspectiondate" size="10" >
        </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title ">公司Logo：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_logo" type="text" id="zd_comp_logo" size="50" maxlength="40">
        <a href="#" onClick="javascript:openWin($('#zd_comp_logo').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">营业执照(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_license" type="text" id="zd_comp_license" size="50" maxlength="40">
        <a href="#" onClick="javascript:openWin($('#zd_comp_license').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">经营许可(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_requires" type="text" id="zd_comp_requires" size="50" maxlength="40">
        <a href="#" onClick="javascript:openWin($('#zd_comp_requires').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">证书1(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_certificate1" type="text" id="zd_comp_certificate1" size="50" maxlength="40">
        <a href="#" onClick="javascript:openWin($('#zd_comp_certificate1').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">证书2(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_certificate2" type="text" id="zd_comp_certificate2" size="50" maxlength="40">
        <a href="#" onClick="javascript:openWin($('#zd_comp_certificate2').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">经营类别(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_category" type="text" id="zd_comp_category" size="30" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title ">所属品牌(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_parts_brand" type="text" id="zd_parts_brand" size="50" maxlength="50"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">配件公告(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><textarea name="zd_comp_bulletin" cols="60" rows="3" id="zd_comp_bulletin"></textarea></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">经营范围(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_scope" type="text" id="zd_comp_scope" size="50"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">经营模式(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_parts_mode" type="radio" id="zd_parts_mode" value="1" />
        生产加工
        <input name="zd_parts_mode" id="zd_parts_mode" type="radio" value="2" />
        代理经销
        <input name="zd_parts_mode" type="radio" id="zd_parts_mode" value="3" />
        招商合作
        <input name="zd_parts_mode" id="zd_parts_mode" type="radio" value="4" />
        其他</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">诚信认证(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_parts_certify" type="radio" id="zd_parts_certify" value="0" checked />
        否
        <input name="zd_parts_certify" id="zd_parts_certify" type="radio" value="1" />
        是</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FFFF66" class="list_left_title ">租赁站长管理区域：</td>
      <td height="22" bgcolor="#FFFF66" class="list_cell_bg"><input name="zd_rent_webmaster_region" type="text" id="zd_rent_webmaster_region" size="40">
        (比如山东,吉林)</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#6666FF" class="list_left_title">保证金(二手网)：</td>
      <td height="22" bgcolor="#6666FF" class="list_cell_bg"><input name="zd_margin" type="text" id="zd_margin" size="10" onKeyDown="javascript:onlyNum();" onBlur="$('#zd_auction_amount').val(this.value*50);">
        万元 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#6666FF" class="list_left_title">竞拍额度(二手网)：</td>
      <td height="22" bgcolor="#6666FF" class="list_cell_bg"><input name="zd_auction_amount" type="text" id="zd_auction_amount" size="10" >
        万元 (<span class="list_left_title STYLE1">竞拍额度</span>:保证金*50) </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司介绍：</td>
      <td height="22" class="list_cell_bg"><FCK:editor instanceName="zd_comp_intro" toolbarSet="simple" width="93%" height="280">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor></td>
    </tr>
    <tr>
      <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" ><input name="zd_id" type="hidden" id="zd_id" value="0">
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>">
        <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">      </td>
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
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
