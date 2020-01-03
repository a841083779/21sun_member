<%@page contentType="text/html;charset=utf-8"  import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/manage/config.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>供求发布</title>
</head>
<body>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script>
	function submityn(){
	   if($("#zd_rent_bulletin").val()==""){
			alert("请输入公告信息！");
			$("#zd_rent_bulletin").focus();
			return false;
		}
		document.theform.submit();
	}
</script>
<%
       PoolManager pool3 = new PoolManager(3);
	   PoolManager pool1 = new PoolManager(1);
	   
		String mem_no ="";
		HashMap memberInfo = new HashMap();		
		if(session.getAttribute("memberInfo")!=null){   
			memberInfo = (HashMap) session.getAttribute("memberInfo");
			mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
		 }		 
		String tempInfo[][]=DataManager.fetchFieldValue(pool1,"member_info","id", "mem_no='"+mem_no+"'");		
		String mypy="member_info";
		String myvalue  = "";
		
		String urlpath="../rent/mybulletin.jsp";		
		
		if(tempInfo!=null){
			myvalue=Common.encryptionByDES(tempInfo[0][0]);
			urlpath=urlpath+"?myvalue="+java.net.URLEncoder.encode(myvalue,"UTF-8");
		}
      try{//====标题的名称====
	%>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
  <div class="loginlist_right">
    <div class="loginlist_right2"><span class="mainyh">店铺公告管理</span></div>
    <div class="loginlist_right1">
      <table width="95%" border="0" align="center" class="tablezhuce">
        <tr>
          <td width="100%" align="left" height="75">&nbsp;
            <textarea rows="15" name="zd_rent_bulletin" id="zd_rent_bulletin" cols="80" style="overflow-y:scroll;"></textarea>
          </td>
        </tr>
        <tr>
          <td width="100%" align="left" height="46">&nbsp;请用不超过300汉字发布您的店铺公告栏信息。 </td>
        </tr>
        <tr>
          <td width="100%" align="center" height="46"><input type="button"  onClick="submityn();"value="更改店铺公告" name="BTNCHG" style="cursor:hand">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
        </tr>
      </table>
      <input name="zd_id"       type="hidden" id="zd_id"       value="0">
      <input name="mypy"        type="hidden" id="mypy"        value="<%=Common.encryptionByDES(mypy)%>">
      <input name="myvalue"     type="hidden" id="myvalue"     value='<%=myvalue%>'>
      <input name="urlpath"     type="hidden" id="urlpath"     value="<%=urlpath%>">
	  <input name="zd_mem_no"   type="hidden" id="zd_mem_no"   value="<%=mem_no%>">
      </table>
    </div>
  </div>
</form>
</body>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
			function set_formxx(val){
			  if(val!=null && val!=""){
			    $('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));			
		     	}
			}
			<%		
			  	
			  if(!myvalue.equals("")){
			     out.print("set_formxx(\""+Common.decryptionByDES(myvalue)+"\");");				
			  }
			%>	
		</script>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{

urlpath=null;
}
%>
