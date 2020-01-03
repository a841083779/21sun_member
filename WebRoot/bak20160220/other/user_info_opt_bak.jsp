<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
ResultSetMetaData rsmd = null;


String mypy="member_info";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));

HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");

try{

	conn = pool.getConnection();
	String querySql = "select * from member_info where id=?";	
	pstmt = conn.prepareStatement(querySql);
	pstmt.setString(1, (String)memberInfo.get("id"));
	
	rs = pstmt.executeQuery();
	
	if (rs != null && rs.next()) {
		rsmd = rs.getMetaData();
		for (int i = 1; i <= rsmd.getColumnCount(); i++) {
           memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
		}
		session.setAttribute("memberInfo",memberInfo);
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">个人信息修改</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。</td>
      </tr>
    </table>
    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" class="tablezhuce">
      <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
        <tr>
          <td  nowrap="nowrap"  class="right"><span class="grayb">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span></td>
          <td ><%=memberInfo.get("mem_no")%></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">真实姓名：</span></td> 
          <td height="22" ><input name="zd_mem_name" type="text" id="zd_mem_name" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("mem_name"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">性　　别：</span></td>
          <td height="22" ><input name="zd_per_sex" type="radio" value="男" <%=Common.getFormatStr(memberInfo.get("per_sex")).equals("男")?"checked='checked'":""%> style="border:0;"/>
            先生
            <input type="radio" name="zd_per_sex" value="女"  style="border:0;" <%=Common.getFormatStr(memberInfo.get("per_sex")).equals("女")?"checked='checked'":""%>/>
            女士			</td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">联系邮箱：</span></td>
          <td height="22" ><input name="zd_per_email" type="text" id="zd_per_email" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("per_email"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">联系电话：</span></td>
          <td height="22" ><input name="zd_per_phone" type="text" id="zd_per_phone" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("per_phone"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">省　　市：</span></td>
          <td height="22" ><select name="zd_per_province" id="zd_per_province" onchange="set_city(this,this.value,theform.zd_per_city,'');" style="width:100px;"  class="validate-selection">
              <option value="">选择省份</option>
              <option value="北京">北京</option>
              <option value="上海">上海</option>
              <option value="天津">天津</option>
              <option value="重庆">重庆</option>
              <option value="河北">河北</option>
              <option value="山西">山西</option>
              <option value="辽宁">辽宁</option>
              <option value="吉林">吉林</option>
              <option value="黑龙江">黑龙江</option>
              <option value="江苏">江苏</option>
              <option value="浙江">浙江</option>
              <option value="安徽">安徽</option>
              <option value="福建">福建</option>
              <option value="江西">江西</option>
              <option value="山东">山东</option>
              <option value="河南">河南</option>
              <option value="湖北">湖北</option>
              <option value="湖南">湖南</option>
              <option value="广东">广东</option>
              <option value="海南">海南</option>
              <option value="四川">四川</option>
              <option value="贵州">贵州</option>
              <option value="云南">云南</option>
              <option value="陕西">陕西</option>
              <option value="甘肃">甘肃</option>
              <option value="青海">青海</option>
              <option value="内蒙古">内蒙古</option>
              <option value="广西">广西</option>
              <option value="西藏">西藏</option>
              <option value="宁夏">宁夏</option>
              <option value="新疆">新疆</option>
              <option value="台湾">台湾</option>
              <option value="香港">香港</option>
              <option value="澳门">澳门</option>
            </select>
              <select  name="zd_per_city" id="zd_per_city"  style="width:100px;">
                <option>选择城市</option>
            </select></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">公司名称：</span></td>
          <td height="22" ><input name="zd_comp_name" type="text" id="zd_comp_name" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_name"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">公司简称：</span></td>
          <td height="22" ><input name="zd_comp_simple" type="text" id="zd_comp_simple" size="48" maxlength="48" value="<%=Common.getFormatStr(memberInfo.get("comp_simple"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">公司地址：</span></td>
          <td height="22" ><input name="zd_comp_address" type="text" id="zd_comp_address" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_address"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">邮　　编：</span></td>
          <td height="22" ><input name="zd_comp_postcode" type="text" id="zd_comp_postcode" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_postcode"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">传　　真：</span></td>
          <td height="22" ><input name="zd_comp_fax" type="text" id="zd_comp_fax" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_fax"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">网站网址：</span></td>
          <td height="22" ><input name="zd_comp_url" type="text" id="zd_comp_url" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_url"))%>"  class="moren"/></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">二手企业推荐关键字：</span></td>
          <td height="22" ><input name="zd_used_popkeywords" type="text" id="zd_used_popkeywords" size="66" value="<%=Common.getFormatStr(memberInfo.get("used_popkeywords"))%>"  class="moren"/></td>
        </tr>
       <!--
	    <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">企业类别：</span></td>
          <td height="22" ><input name="zd_comp_flag" type="text" id="zd_comp_flag" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_flag"))%>"  class="moren" style="display:none"/><br />

		  
<input type="checkbox" name="mrp" value="厂家"
      checked>厂家 <input
      type="checkbox" name="cbxKeyWords" value="商家"
      checked>商家 <input
      type="checkbox" name="cbxKeyWords" value="整机"
      >整机 <input
      type="checkbox" name="cbxKeyWords" value="配件"
      >配件 <input
      type="checkbox" name="cbxKeyWords" value="进口"
      >进口 <input
      type="checkbox" name="cbxKeyWords" value="出口"
      >出口 <input
      type="checkbox" name="cbxKeyWords" value="国内"
      checked>国内 <br>
      <input type="checkbox" name="cbxKeyWords" value="国外"
      >国外 <input
      type="checkbox" name="cbxKeyWords" value="经销"
      >经销 <input
      type="checkbox" name="cbxKeyWords" value="租赁"
      >租赁 <input
      type="checkbox" name="cbxKeyWords" value="维修"
      >维修 <input
      type="checkbox" name="cbxKeyWords" value="技术"
      >技术 <input
      type="checkbox" name="cbxKeyWords" value="服务"
      >服务 <input
      type="checkbox" name="cbxKeyWords" value="其它"
      >其它		  
		  </td>
        </tr>
	   -->
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">公司介绍：</span></td>
          <td height="22" ><textarea name="zd_comp_intro" cols="66" rows="8" id="zd_comp_intro"><%=Common.filterHtmlString(Common.getFormatStr(memberInfo.get("comp_intro")).replace("<br />","\r\n"))%></textarea></td>
        </tr>
       
        <tr>
          <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" ><a href="#" onclick="theform.submit();"><img src="../images/bottom01.gif" width="91" height="38" border="0" /></a>
              <input name="zd_id" type="hidden" id="zd_id"  value="<%=memberInfo.get("id")%>" />
              <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
              <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
              <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
              <input name="urlpath" type="hidden" id="urlpath" value="user_info_opt.jsp" />          </td>
        </tr>
      </form>
    </table>
  </div>
</div>
<script   language="javascript">

document.theform.zd_per_province.value="<%=Common.getFormatStr(memberInfo.get("per_province"))%>";
set_city(theform.zd_per_province,theform.zd_per_province.value,theform.zd_per_city,'');
document.theform.zd_per_city.value="<%=Common.getFormatStr(memberInfo.get("per_city"))%>";
</script>

</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
