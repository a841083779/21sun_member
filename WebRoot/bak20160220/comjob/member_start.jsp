<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.net.*,com.jerehnet.cmbol.action.*"
	%>
	<%HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
	String key = Common.getFormatStr(request.getParameter("key"));
	key = Common.decryptionByDES(key);
	String userno = "";
	String password = "";
	if(key==null||"".equals(key)||key.indexOf("--")==-1){
		userno = Common.getFormatStr(Common.decryptionByDES(Common.getFormatStr(memberInfo.get("mem_no"))));
		password = Common.getFormatStr(Common.decryptionByDES(Common.getFormatStr(memberInfo.get("passw"))));
	}else{	
		String[] userpassword = key.split("--");
		userno = userpassword[0];
		password = userpassword[1];	
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员开通</title>
</head>
<script src="/scripts/common.js" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<script language="javascript" type="text/javascript">
	function formSubmit(){
		var obj = document.getElementsByName("membertype");
		if(!obj[0].checked && !obj[1].checked){
			alert("请先选择会员类型，再确认开通");
			return false;
		}
		document.theform.submit();
		lhgdialog.closdlg(parent.window,parent.frameElement._dlgargs.win.lhgdialog.gcover());
	}
</script>
<body>
<div align="center">
<form id="theform" name="theform" action="member_start_deal.jsp" method="post" target="_blank">
<input type="hidden" id="uid" name="uid" value="<%=Common.encryptionByDES(userno)%>"/>
<input type="hidden" id="password" name="password" value="<%=Common.encryptionByDES(password)%>"/>
  <div style="width:220px;border-bottom:1px dashed #ddd;height:25px;margin-bottom:10px;"><span style="font-size:14px;font-weight:bold;">请您选择人才网会员类型</span></div>
   <input name="membertype" type="radio" style="border: 0px solid #C0C0C0" value="1" checked/>
  <span style="font-size:12px;">个人会员</span> 
  <input type="radio" name="membertype" value="2" style="border: 0px solid #C0C0C0 " />
  <span style="font-size:12px;">企业会员</span>
  <br /><br />
  <input type="button" onclick="formSubmit();" id="theSubmit" name="theSubmit" value="确认开通" style="border:1px solid #ddd;background:#eee;font-size:12px;line-height:20px;"/>
</form></div>
</body>
</html>
