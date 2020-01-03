<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="../manage/config.jsp"%>
<%
String id = Common.getFormatStr(request.getParameter("id"));
String tablename= "supply_ad";
String urlpath = "supply_list.jsp";
 %>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>指定企业关键字排名</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/calendar.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script type="text/javascript">
function setVal(){
    	var val;
		val=window.showModalDialog("members.jsp","","dialogWidth:480px;dialogHeight:620px;Center:yes;Scroll:yes;Status:yes;Help:no")
		if (val!=null && val.length>0)
			{
				if(val[0]!='null'&&val[0]!=''){
					document.all["zd_corpname"].value=val[0];
				}
				if(val[1]!='null'&&val[1]!=''){
					document.all["zd_corpid"].value=val[1];
				}
				}
				}
</script>


</head>

<body>
<div align="center">
  <center>
<table border="0" cellpadding="0" cellspacing="0" width="95%" height="5">
  <tr>
    <td width="100%"><!----></td>
  </tr>
</table>
  </center>
</div>
<%

  %>
<form method="POST"   name="theform"  action="opt_save.jsp">
 <input type="hidden" name="zd_id" value="0"  >
 <input type="hidden" name="zd_pubdate" value="<%=Common.getToday("yyyy-MM-dd",0) %>"  >
 <input type="hidden" name="urlpath" value="<%=urlpath %>"  >
 <input type="hidden" name="tablename" value="<%=Common.encryptionByDES(tablename) %>"  >
    <center>
          <table border="1" cellpadding="0" cellspacing="0" width="100%" class="p92" bordercolorlight="#C0CCE0" bordercolordark="#FFFFFF" height="1">
            <tr>
             <td width="101%" align="center" height="1">
              <table border="1" cellpadding="0" cellspacing="0" width="100%" class="p92" bordercolorlight="#008080" bordercolordark="#FFFFFF" height="1">
                <tr>
                  <td width="100%" colspan="4" height="16" align="center" bgcolor="#E0E0E0">
                    <font color="#FF0000"><b>企业关键字广告修改</b></font> 
                    &nbsp;                     
                  </td>
                </tr>
                <tr>
                  <td width="100%" colspan="4" height="16" align="center"> 
                    <font color="#FF0000">
                     <br> 
                    </font>
                  </td>
                </tr>
             
                <tr>
                  <td width="100%" height="1" align="center" colspan="4">
                <table border="1" cellpadding="0" cellspacing="0" width="100%" bordercolorlight="#008000" bordercolordark="#FFFFFF" class="p92">
                     <tr>
                  <td width="13%" height="12" align="center">起始日期</td>
                  <td width="40%" height="12" align="left">
                      <input type="text" name="zd_startdate" size="20" value="" onFocus="calendar(event)">
                  </td>            
                  <td width="15%" height="12" align="center"> 截止日期</td>
                  <td width="32%" height="12" align="left">
         <input type="text" name="zd_enddate" size="20" onFocus="calendar(event)" > 
                  </td>
                </tr>
                     <tr>
                  <td width="13%" height="12" align="center">指定关键字</td>
                  <td width="40%" height="12" align="left">
                      <input type="text" name="zd_keyword" size="10" >空白为栏目首页
                  </td>            
                  <td width="15%" height="12" align="center"> 广告位置</td>
                  <td width="32%" height="12" align="left">
         <select size="1" name="zd_adcate">
            <option value="">所有位置</option>
            <option value="1"  >上方旗帜广告</option>
            <option value="2"  >右上文字连接</option>
            <option value="3"  >页中横幅广告</option>
            <option value="4"  >页中图标广告</option>
            <option value="5"  >推荐企业目录</option>
         </select>
                  </td>
                </tr>
                     <tr>
                  <td width="13%" height="12" align="center"> 显示排名</td>
                  <td width="40%" height="12" align="left"><input type="text" name="zd_orderid" size="4"  >请参考已有排名,修改时请确定，后台不再验证</td>            
                  <td width="15%" height="12" align="center">是否发布</td>
                  <td width="32%" height="12" align="left">
                    <input type="radio" value="1" name="zd_ispublished"    checked>现在发布   
                    <input type="radio" value="0" name="zd_ispublished"    >暂缓发布</td>
                </tr>
                     <tr>
                  <td width="13%" height="12" align="center">企业名称</td>
                  <td width="40%" height="12" align="left"><input type="text" name="zd_corpname" id="zd_corpname" onclick="setVal();" size="30"  readonly > 
                    &nbsp;</td>                              
                  <td width="15%" height="12" align="center">企业编号</td>
                  <td width="32%" height="12" align="left"><input type="text" name="zd_corpid" id="zd_corpid" size="10" readonly ></td>
                </tr>
                <tr>
                  <td width="13%" height="20" align="center">图像文件&nbsp;</td>
                  <td width="40%" height="20" align="left">
                  <input type="text" name="zd_imgfile" size="30" readonly onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=25&dir=main&fieldname=zd_imgfile','upload',480,150)" >&nbsp;&nbsp;</td>
                  <td width="14%" height="20" align="center"> 文件显示方式</td>
                  <td width="33%" height="20" align="left">
                    <input type="radio" value="0" name="zd_imgcate"   checked>图片方式  
                    <input type="radio" value="1" name="zd_imgcate"  >flash方式
                    <input type="radio" value="2" name="zd_imgcate"  >文字方式
                    
                    </td>
                </tr>
                <tr>
                  <td width="13%" height="17" align="center">点击连接</td>
                  <td width="87%" height="17" colspan="3" align="left">http://<input type="text" name="zd_linkurl" size="50"  > 
                    &nbsp;</td>                           
                </tr>
                     <tr>
                  <td width="13%" height="19" align="center">文字内容</td>
                  <td width="87%" colspan="3" height="19" align="left"><input type="text" name="zd_txtcontent" size="50"  > 
                    广告位置为文字连接时必须填写</td> 
                     </tr>
                     <tr>
                  <td width="13%" height="19" align="center">浏览方式</td>
                  <td width="87%" colspan="3" height="19" align="left">
                    <input type="radio" name="zd_islink" value="0" checked>访问企业网站&nbsp;            
                    <input type="radio" name="zd_islink" value="1"  >浏览静态页&nbsp;&nbsp;&nbsp;            
                    （*推荐目录位置广告设置有效）</td> 
                     </tr>
                <tr>
                  <td width="13%" height="19" align="center">备注说明：</td>
                  <td width="87%" colspan="3" height="19" align="left">
                    <font color="#FF0000">
                    <textarea rows="2" name="zd_detail" cols="50" style="color: #FF0000">  </textarea></font><font color="#FF0000">*备注说明，别超过150汉字</font></td> 
                </tr>
                <tr bgcolor="#C0CCE0" >
                  <td width="100%" colspan="4" height="25">
                    <p align="center"><input type="submit" value="保存" name="btnsubmit">&nbsp;&nbsp;<input type="button" value="关闭" name="B1" onclick="window.close()"></p>
                  </td>
                </tr> </table>
                 </td>
                </tr>
                     
              </table>
              
             </td>          
          </tr>
        </table>
</form>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#C0C0C0" height="5">
    <tr>
      <td width="100%"><!----></td>
    </tr>
  </table>
  </center>
</div>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=tablename%>')+"&paraName=id&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!id.equals("0")){
	out.print("set_formxx(\""+id+"\");");
}
%>
</script>
</body>
</html>
