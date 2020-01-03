<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%>
<%
 
  String siteid= Common.getFormatInt(request.getParameter("siteid"));   //站点编号
  
  String iframeFilename  = Common.getFormatStr(request.getParameter("iframeFilename")); 
  String cssName         = Common.getFormatStr(request.getParameter("css_name"));  
   if(iframeFilename.equals("")){
     iframeFilename ="/other/comp_info_opt.jsp";
  }
  iframeFilename = iframeFilename+"?siteid="+siteid;  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="kjz.js"></script>
</head>
<body>
<div class="jianyitext">为了增加您的在线贸易机会，建议您认真完善公司资料，您的公司资料完整、准确，便会自动加入商贸网企业名录，获得更多展示机会！</div>
<div class="nTab">
    
    <div class="TabTitle">
      <ul id="myTab1">
        <li class="<%=cssName.equals("")||cssName.equals("0")?"active":"normal"%>" onclick="nTabs(this,0,'/other/comp_info_opt.jsp','<%=siteid%>');" style="margin-left:10px">公司资料</li>
        <li class="<%=!cssName.equals("") && cssName.equals("1")?"active":"normal"%>" onclick="nTabs(this,1,'/other/user_info_opt.jsp','<%=siteid%>');">个人资料</li>
        <li class="<%=!cssName.equals("")&& cssName.equals("2")?"active":"normal"%>" onclick="nTabs(this,2,'/other/indiv_info_opt.jsp','<%=siteid%>');">个性化设置</li>
        </ul>
    </div>    
    <div class="TabContent">
      <div id="myTab1_Content0"  > <iframe id="iframeright_a" name="iframeright_a"  scrolling="no" frameborder="0" width="100%" height="900" src="<%=iframeFilename%>"></iframe></div>
      <div id="myTab1_Content1" class="none" > <iframe id="iframeright_b" name="iframeright_b"  scrolling="no" frameborder="0" width="100%" height="490" src="<%=iframeFilename%>"></iframe>  </div>
      <div id="myTab1_Content2" class="none" > <iframe id="iframeright_c" name="iframeright_c" scrolling="no" frameborder="0" width="100%" height="490" src="<%=iframeFilename%>"></iframe>  </div>
      </div>
    
</div><form name="theform" action="memberinfo_iframe.jsp" method="post">
  <input name="css_name"  id="css_name" type="hidden" />
  <input name="iframeFilename" id="iframeFilename" type="hidden" />
  <input name="siteid" id="siteid" type="hidden" />
</form>
</body>
</html>