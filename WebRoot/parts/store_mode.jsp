<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}
String mypy="member_info";
//====得到参数====	
String mem_no ="";
HashMap memberInfo = new HashMap();
if(session.getAttribute("memberInfo")!=null){   
	memberInfo = (HashMap) session.getAttribute("memberInfo");
	mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
}
String parts_storemodel ="";
try{	

String tempInfo[][]=DataManager.fetchFieldValue(pool, "member_info","top 1 parts_storemodel", "mem_no='"+mem_no+"'");
if(tempInfo!=null){
   parts_storemodel =  Common.getFormatInt(tempInfo[0][0]);
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>

<script type="text/javascript" src="../scripts/highslide/highslide.js"></script>
<script type="text/javascript"> 
// remove the registerOverlay call to disable the controlbar
hs.registerOverlay(
	{
		thumbnailId: null,
		overlayId: 'controlbar',
		position: 'top right',
		hideOnMouseOut: true
	}
);
hs.graphicsDir = '../scripts/highslide/graphics/';
hs.outlineType = 'rounded-white';
// Tell Highslide to use the thumbnail's title for captions
hs.captionEval = 'this.thumb.title';
</script>
</head>

<body>
  <div class="loginlist_right" style="width:782px">
<div class="dpfengge">
<div class="dpfenggetop">店铺风格方案一</div>
 <div class="fanganmiddler">
 <div class="fanganpic">
 <div class="fanganpic1"><a id="thumb0"   class="highslide" onclick="return hs.expand(this)" href="../images/fangan3.3.jpg" title="" ><img src="../images/fa1.jpg" width="178" height="120"  style="border: 0px" /></a></div>
 <div class="fanganpic1" style="margin-left:40px;float:left"><a id="thumb0"   class="highslide" onclick="return hs.expand(this)"   href="../images/fangan3.jpg"><img src="../images/fa2.jpg" width="178" height="120"  style="border: 0px" /></a></div></div>
 <div class="fanganpic">
 <div class="fanganselect">【纯净安详型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("10")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>">我要这个</a>&nbsp;<%=(parts_storemodel.equals("0") || parts_storemodel.equals("10"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 <div class="fanganselect" style="margin-left:40px">【欢快活泼型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("11")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("11"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 </div>
 </div>
<div class="dpfenggeline"></div>
<div class="dpfenggetop" style="margin-top:1px">店铺风格方案二</div>
 <div class="fanganmiddler">
 <div class="fanganpic">
 <div class="fanganpic1"><a id="thumb0"   class="highslide" onclick="return hs.expand(this)"   href="../images/fangan2.jpg"><img src="../images/fa3.jpg" width="178" height="120"  style="border: 0px" /></a></div>
 <div class="fanganpic1" style="margin-left:40px;float:left"><a id="thumb0"   class="highslide" onclick="return hs.expand(this)"   href="../images/fangan2.2.jpg"><img src="../images/fa4.jpg" width="178" height="120"  style="border: 0px" /></a></div></div>
 <div class="fanganpic">
 <div class="fanganselect">【高贵华丽型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("20")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("20"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 <div class="fanganselect" style="margin-left:40px">【健康环保型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("21")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("21"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 </div>
 </div>
<div class="dpfenggeline"></div>
<div class="dpfenggetop" style="margin-top:1px">店铺风格方案三</div>
<div class="fanganmiddler">
 <div class="fanganpic">
 <div class="fanganpic1"><a id="thumb0"   class="highslide" onclick="return hs.expand(this)"   href="../images/fa1red.jpg"><img src="../images/fa5.jpg" width="178" height="120"  style="border: 0px" /></a></div>
 <div class="fanganpic1" style="margin-left:40px;float:left"><a id="thumb0" class="highslide" onclick="return hs.expand(this)"   href="../images/fa1zong.jpg"><img src="../images/fa6.jpg" width="178" height="120"  style="border: 0px" /></a></div></div>
 <div class="fanganpic">
 <div class="fanganselect">【热烈奔放型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("30")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("30"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 <div class="fanganselect" style="margin-left:40px">【睿智阳刚型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("31")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("31"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 </div>
 </div>
</div>
  </div>


</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
}
%>