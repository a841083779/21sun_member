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
  <div class="loginlist_right2"><span class="mainyh">企业认证信息修改</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。</td>
      </tr>
    </table>
    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" class="tablezhuce">
      <form action="../other/opt_save_update.jsp" method="post" name="theform" id="theform">
	       <tr>
          <td  nowrap="nowrap"  class="right"><span class="grayb">注&nbsp;&nbsp;册&nbsp;&nbsp;号：</span></td>
          <td ><%=memberInfo.get("mem_no")%></td>
        </tr>
	     <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">公司名称：</span></td>
          <td height="22" ><input name="zd_comp_name" type="text" id="zd_comp_name" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_name"))%>"  class="moren"/></td>
        </tr>
      
		  <tr>
          <td  nowrap="nowrap"  class="right"><span class="grayb">注册地址：</span></td>
          <td ><input name="zd_comp_address" type="text" id="zd_comp_address" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_address"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">法定代表人：</span></td> 
          <td height="22" ><input name="zd_comp_legal" type="text" id="zd_comp_legal" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_legal"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">注册资本：</span></td>
          <td height="22" ><input name="zd_comp_capital" type="text" id="zd_comp_capital" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_capital"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">企业类型：</span></td>
          <td height="22" ><input name="zd_comp_flag" type="text" id="zd_comp_flag" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_flag"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">成立日期：</span></td>
          <td height="22" ><input name="zd_comp_founddate" type="text" id="zd_comp_founddate" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_founddate"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">登记机关：</span></td>
          <td height="22" ><input name="zd_comp_register_auth" type="text" id="zd_comp_register_auth" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_register_auth"))%>"  class="moren"/></td>
        </tr>
     
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">经营范围：</span></td>
          <td height="22" ><input name="zd_comp_scope" type="text" id="zd_comp_scope" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_scope"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">年检时间：</span></td>
          <td height="22" ><input name="zd_comp_inspectiondate" type="text" id="zd_comp_inspectiondate" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_inspectiondate"))%>"  class="moren"/></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">营业执照：</span></td>
          <td height="22" >  <input name="zd_comp_license" id="zd_comp_license" type="hidden" value="<%=Common.getFormatStr(memberInfo.get("comp_license"))%>"/><span id="txt_zd_comp_license"></span><span  id="ifr_zd_comp_license"><iframe id="ifr2_zd_comp_license" scrolling="no" frameborder="0" width="100%" height="28" src="http://resource.21-sun.com/web_upload_files_for_sigle.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_license" ></iframe></span></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">经营许可：</span></td>
          <td height="22" >  <input name="zd_comp_requires" id="zd_comp_requires" type="hidden" value="<%=Common.getFormatStr(memberInfo.get("comp_requires"))%>"/><span id="txt_zd_comp_requires"></span><span  id="ifr_zd_comp_requires"><iframe id="ifr2_zd_comp_requires" scrolling="no" frameborder="0" width="100%" height="28" src="http://resource.21-sun.com/web_upload_files_for_sigle.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_requires" ></iframe></span></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">企业证书1：</span></td>
          <td height="22" >  <input name="zd_comp_certificate1" id="zd_comp_certificate1" type="hidden" value="<%=Common.getFormatStr(memberInfo.get("comp_certificate1"))%>"/><span id="txt_zd_comp_certificate1"></span><span  id="ifr_zd_comp_certificate1"><iframe id="ifr2_zd_comp_certificate1" scrolling="no" frameborder="0" width="100%" height="28" src="http://resource.21-sun.com/web_upload_files_for_sigle.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_certificate1" ></iframe></span></td>
        </tr>
		<tr>
		  <td height="22"  nowrap="nowrap" class="right"><span class="grayb">企业证书2：</span></td>
		  <td height="22" >  <input name="zd_comp_certificate2" id="zd_comp_certificate2" type="hidden" value="<%=Common.getFormatStr(memberInfo.get("comp_certificate2"))%>"/><span id="txt_zd_comp_certificate2"></span><span  id="ifr_zd_comp_certificate2"><iframe id="ifr2_zd_comp_certificate2" scrolling="no" frameborder="0" width="100%" height="28" src="http://resource.21-sun.com/web_upload_files_for_sigle.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_certificate2" ></iframe></span></td>
		</tr>       
        <tr>
          <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" ><a href="#" onclick="document.theform.submit();"><img src="../images/bottom01.gif" width="91" height="38" border="0" /></a>
              <input name="zd_id" type="hidden" id="zd_id"  value="<%=memberInfo.get("id")%>" />
              <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
              <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
              <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
              <input name="urlpath" type="hidden" id="urlpath" value="../parts/certification_opt.jsp" />          </td>
        </tr>
      </form>
    </table>
  </div>
</div>

<script  language="javascript">
//营业执照
var val1='<%=Common.getFormatStr(memberInfo.get("comp_license"))%>';
var name1='comp_license';

if(val1!='') setImg(val1,name1);

//经营许可
var val2='<%=Common.getFormatStr(memberInfo.get("comp_requires"))%>';
var name2='comp_requires';
if(val2!='') setImg(val2,name2);

//企业证1
var val3='<%=Common.getFormatStr(memberInfo.get("comp_certificate1"))%>';
var name3='comp_certificate1';
if(val3!='') setImg(val3,name3);

//企业证书2
var val4='<%=Common.getFormatStr(memberInfo.get("comp_certificate2"))%>';
var name4='comp_certificate2';
if(val4!='') setImg(val4,name4);

function setImg(val,name){
		document.getElementById('txt_zd_'+name).innerHTML = "<font color='red'><a href='"+val+"' target='_blank'><font color='red'>点击此处查看图片</font></a>，<a href='#' onclick=\"reupload('zd_"+name+"');\"><font color='red'>点击此处重新上传</font></a>。</font>";
		document.all('ifr_zd_'+name).style.display='none';
		document.all('txt_zd_'+name).style.display='block';
	}

function f_frameStyleResize(targObj){   
  var   targWin   =   targObj.parent.document.all[targObj.name]; 
  if(targWin   !=   null)   
  {   
  var   HeightValue   =   targObj.document.body.scrollHeight   
  if(HeightValue   <100){HeightValue   =490}   //不小于540  
   targWin.height   =   HeightValue;
  }   
}  
function f_iframeResize(){
  f_frameStyleResize(self);
}  
 window.onload=f_iframeResize; 

 </script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
