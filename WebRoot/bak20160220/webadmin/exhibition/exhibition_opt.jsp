<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="exhibition_opt.jsp";
String mypy="exhibition_industry";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));


String urlpath="../exhibition/exhibition_list.jsp";


try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>展会信息</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script src="scripts/calendar.js" type="text/javascript" charset="utf-8"></script>
	<LINK href="css/homestyle.css" rel=stylesheet>
<script>
function formCheck(){
   var tmpstr="";
   var tmpstr="";
     
      if (theform.zd_txtTitle.value==""){
        alert("展会名称不能为空！");
        theform.zd_txtTitle.focus();
        return false;
      }
      if (theform.zd_txtCity.value==""){
        alert("参展城市不能为空！");
        theform.zd_txtCity.focus();
        return false;
      }
      if (theform.zd_txtLocation.value==""){
        alert("参展地点不能为空！");
        theform.zd_txtLocation.focus();
        return false;
      }
      if (theform.zd_txtDetail.value==""){
        alert("展会内容不能为空！");
        theform.zd_txtDetail.focus();
        return false;
      }           
       if (theform.zd_txtCompany1.value==""){
        alert("主办单位不能为空！");
        theform.zd_txtCompany1.focus();
        return false;
      }
		if (theform.zd_txtCompany1.value.length > 200){
			alert("主办单位太长啦！");
			theform.zd_txtCompany1.focus();
			return false;
		}      
      if (theform.zd_txtFullName.value==""){
        alert("联系人不能为空！");
        theform.zd_txtFullName.focus();
        return false;
      }
      if (theform.zd_txtAddress.value==""){
        alert("联系地址不能为空！");
        theform.zd_txtAddress.focus();
        return false;
      }
      if (theform.zd_txtPostcode.value==""){
        alert("邮政编码不能为空！");
        theform.zd_txtPostcode.focus();
        return false;
      }
      
      if (theform.zd_txtTelephone.value==""){
        alert("联系电话不能为空！");
        theform.zd_txtTelephone.focus();
        return false;
      }
      if (theform.zd_txtEmail.value==""){
        alert("电子邮箱不能为空！");
        theform.zd_txtEmail.focus();
        return false;
      }
		if (theform.zd_txtEmail.value != "") {
			var objmatch=/(^(\w|\.|\-)+@((\w|\-)+\.)+(\w|\-)+)((; *|, *| +)(\w|\.|\-)+@((\w|\-)+\.)+(\w|\-)+)*$/i.exec(theform.zd_txtEmail.value);
			if (!objmatch){
				alert("你所填写的电子邮件地址未通过验证！");
				theform.zd_txtEmail.focus();
				return false;
			}
		}      
		theform.submit();
  }
</script>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15"><span class="p982"><span class="pblue1">红色</span><font color="#FF0000">*</font><span class="pblue1">为必填项</span></span></td>
    </tr>
</table>
<FORM name=theform        action="opt_save_update.jsp" method=post>
  <TABLE class=pblack12 cellSpacing=0 cellPadding=0 width="95%" 
                  border=0>
                    <TBODY>
                    <TR>
                      <TD class=pblack12 align=right width="100%" 
                      bgColor=#cccccc colSpan=2 height=1>
                        <P align=left><FONT color=#ff0000 
                        size=4></FONT></P></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40 nowrap="nowrap"><FONT color=#dd0000>*</FONT>展会名称：</TD>
                      <TD class=pblack12 width="77%" 
                      background=images/back-02.gif 
                      bgColor=#ffffff height=40><INPUT size=67 
                      name=zd_txtTitle></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="100%" bgColor=#cccccc 
                      colSpan=2 height=1>
                        <P align=left></P></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38><FONT color=#dd0000>*</FONT>参展时间：</TD>
                      <TD class=pblack12 width="77%" 
                      background=images/back-03.gif 
                      bgColor=#ffffff height=38><FONT size=2>
                      <input name="zd_bgtim" onFocus="calendar(event)" value="<%=Common.getToday("yyyy-MM-dd",0)%>">--
                      <input name="zd_endtim" onFocus="calendar(event)" value="<%=Common.getToday("yyyy-MM-dd",0)%>">
                      </FONT>
                      </TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38><FONT color=#dd0000>*</FONT>参展城市：</TD>
                      <TD class=pblack12 width="77%" 
                      background=images/back-04.gif 
                      bgColor=#ffffff height=38><INPUT size=60 
                        name=zd_txtCity></TD></TR>
                        <TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38><FONT color=#dd0000>*</FONT>参展地点：</TD>
                      <TD class=pblack12 width="77%" 
                      background=images/back-04.gif 
                      bgColor=#ffffff height=38><INPUT size=60 
                        name=zd_txtLocation></TD></TR>
                        <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38><FONT color=#dd0000>*</FONT>参展类型：</TD>
                      <TD class=pblack12 width="77%" 
                      background=images/back-04.gif 
                      bgColor=#ffffff height=38>
						<select name="zd_outid">
							<option value=1>国内展会</option>
							<option value=0>国际展会</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						展会方式：<input type=radio name="zd_flagshowcontact" value="1" checked>合作展会<input type=radio name="zd_flagshowcontact" value="0">其它展会
					</TD>
					
					</TR>
					<tr>
					  <td height="22" align="right" class="list_left_title">发布到配套网展会信息：</td>
					  <td>
						<input name="zd_fittings_flag" type="radio" class="form_radio" value="1">是
						<input name="zd_fittings_flag" type="radio" class="form_radio" value="0" checked>否
					  </td>
					</tr>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38>展馆名称：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=38><INPUT size=60 name=zd_txtRoom></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38><FONT color=#dd0000>*</FONT>展会内容：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff height=38>
                      <TEXTAREA name="zd_txtDetail" rows=10 cols=50></TEXTAREA> 
                      </TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38><FONT color=#dd0000>*</FONT>主办单位：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff height=38><TEXTAREA name=zd_txtCompany1 rows=3 cols=50></TEXTAREA> 
                      </TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38>支持单位：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff height=38><TEXTAREA name=zd_txtCompany2 rows=3 cols=50></TEXTAREA> 
                      </TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38>承办单位：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff height=38><TEXTAREA name=zd_txtCompany3 rows=3 cols=50></TEXTAREA> 
                      </TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=38>协办单位：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff height=38><TEXTAREA name=zd_txtCompany4 rows=3 cols=50></TEXTAREA> 
                      </TD></TR>
                    <CENTER>
                    <TR>
                      <TD class=pblack12 align=right width="100%" 
                      bgColor=#cccccc colSpan=2 height=1>
                        <P align=left></P></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40><FONT color=#dd0000>*</FONT>联系人：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40><INPUT size=41 name=zd_txtFullName></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40><FONT color=#dd0000>*</FONT>联系地址：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40><INPUT size=66 name=zd_txtAddress></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40><FONT color=#dd0000>*</FONT>邮政编码：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40><INPUT maxLength=6 size=12 
                    name=zd_txtPostcode></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40><FONT color=#dd0000>*</FONT>联系电话：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40><INPUT size=41 name=zd_txtTelephone></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40>传真：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40><INPUT size=41 name=zd_txtFax></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40><FONT color=#dd0000>*</FONT>电子邮件：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40><INPUT size=41 name=zd_txtEmail></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40>网址：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40><INPUT size=41 value=http:// 
                    name=zd_txtWWW></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40>广告链接其他网址：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40><INPUT size=41 value=http:// 
                    name=zd_txtOtherWWW></TD></TR>
                    <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=25>相关内容：</TD>
                      <TD class=pblack12 vAlign=top align=left width="77%" 
                      bgColor=#ffffff height=70>
                      <TEXTAREA name=zd_txtDetail_other rows=10 cols=50></TEXTAREA> 
                      
                      <input type=hidden name="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
                      <input type=hidden name="mypy" value="<%=Common.encryptionByDES(mypy) %>">
                      <input type=hidden name="urlpath" value="webadd.jsp">
                      <input type=hidden name="zd_id" value="0">  
                      </TD></TR>
                      <TR>
                      <TD class=p92 align=right width="23%" bgColor=#ffffff 
                      height=40>IP：</TD>
                      <TD class=pblack12 width="77%" bgColor=#ffffff 
                        height=40>
					<input type=text name="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" readonly>
					</TD></TR>
                    <tr>
					  <td height="22" align="right" class="list_left_title">LOGO上传：</td>
					  <td>
						<input name="zd_txtImg" type="text" id="zd_txtImg" size="50">
<input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=30&dir=exhibition&fieldname=zd_txtImg','upload',480,150)">
					  </td>
					</tr>
                    <tr>
					  <td height="22" align="right" class="list_left_title">前台推荐位置：</td>
					  <td>
						<input name="zd_txtPosition" type="radio" class="form_radio" value="0" checked>不推荐
						<input name="zd_txtPosition" type="radio" class="form_radio" value="1">首页展会推荐
                        <input name="zd_txtPosition" type="radio" class="form_radio" value="2">首页重点展会推荐
                        <input name="zd_txtPosition" type="radio" class="form_radio" value="3">列表页展会推荐
					  </td>
					</tr>
					<tr>
					  <td height="22" align="right" class="list_left_title">推荐展会排序：</td>
					  <td>
						<select name="zd_postionOrder">
							<option>-</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
						</select>
					  </td>
					</tr>
                    <tr>
					  <td height="22" align="right" class="list_left_title">发布：</td>
					  <td>
						<input name="zd_showid" type="radio" class="form_radio" value="0" checked>不发布
						<input name="zd_showid" type="radio" class="form_radio" value="1">立即发布
					  </td>
					</tr>
                    <TR>
                      <TD class=pblack12 align=right width="23%" bgColor=#ffffff 
                      height=25>　</TD>
                      <TD class=pblack12 vAlign=bottom width="77%" 
                      bgColor=#ffffff height=35>&nbsp;
                      <INPUT style="BORDER-RIGHT: #666666 1px solid; BORDER-TOP: #666666 1px solid; BORDER-LEFT: #666666 1px solid; COLOR: #ffffff; BORDER-BOTTOM: #666666 1px solid; FONT-FAMILY: ?)????; BACKGROUND-COLOR: #8e8e8e" type=button value=确定提交表单 name=btnsubmit onClick="formCheck();">
                      </TD></TR></TBODY></TABLE>
                      </FORM>
  <table width="98%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="10"></td>
    </tr>
  </table>
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
