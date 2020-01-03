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
</head>
<body>
  <div class="loginlist_right" style="width:782px">
 <div class="fangantop"></div>
 <div class="fanganmiddle"><div class="fanganmiddlel"></div>
 <div class="fanganmiddler">
 <div class="fanganpic">
 <div class="fanganpic1" style="margin-left:15px"><img src="../images/fangan3.3.jpg" /></div>
 <div class="fanganpic1" style="margin-left:10px"><img src="../images/fangan3.jpg" /></div></div>
 <div class="fanganpic">
 <div class="fanganselect">【纯净安详型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("10")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>">我要这个</a>&nbsp;<%=(parts_storemodel.equals("0") || parts_storemodel.equals("10"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 <div class="fanganselect" style="margin-left:10px">【欢快活泼型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("11")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("11"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 </div>
 </div></div>
 <div class="fanganbottom"></div>
 
  <div class="fangantop" style="margin-top:15px"></div>
 <div class="fanganmiddle"><div class="fanganmiddlel" style="background:url('../images/fa2.gif') 20px 7px no-repeat"></div>
 <div class="fanganmiddler">
 <div class="fanganpic">
 <div class="fanganpic1" style="margin-left:15px"><img src="../images/fangan2.jpg" /></div>
 <div class="fanganpic1" style="margin-left:10px"><img src="../images/fangan2.2.jpg" /></div></div>
 <div class="fanganpic">
 <div class="fanganselect">【高贵华丽型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("20")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("20"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 <div class="fanganselect" style="margin-left:10px">【健康环保型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("21")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("21"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 </div>
 </div></div>
 <div class="fanganbottom"></div>

 <div class="fangantop" style="margin-top:15px"></div>
 <div class="fanganmiddle"><div class="fanganmiddlel" style="background:url('../images/fa3.gif') 20px 7px no-repeat"></div>
 <div class="fanganmiddler">
 <div class="fanganpic">
 <div class="fanganpic1" style="margin-left:15px"><img src="../images/fa1red.jpg" /></div>
 <div class="fanganpic1" style="margin-left:10px"><img src="../images/fa1zong.jpg" /></div></div>
 <div class="fanganpic">
 <div class="fanganselect">【热烈奔放型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("30")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("30"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 <div class="fanganselect" style="margin-left:10px">【睿智阳刚型】<a href="update_storemode.jsp?parts_storemodel=<%=Common.encryptionByDES("31")%>&mem_no=<%=Common.encryptionByDES(mem_no)%>&urlpath=update_storemode.jsp">我要这个</a>&nbsp;<%=(parts_storemodel.equals("31"))?"<font color='#FF0000'><b>当前店铺模版</b></font>":""%></div>
 </div>
 </div></div>
 <div class="fanganbottom"></div>

  </div>


</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
}
%>