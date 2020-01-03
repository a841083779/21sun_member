<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}

String roleNum=Common.getFormatStr(request.getParameter("role_num"));
String name=Common.getFormatStr(request.getParameter("name"));

String [][]rolePurviews = DataManager.fetchFieldValue(pool,"cmbol_columns_info","catalog_no,catalog_name,parent_id","subweb_no=7  and is_show=1 order by catalog_no");

String [][]purviews = DataManager.fetchFieldValue(pool,"manager_role_purview_new","purview_num","role_num='"+roleNum+"' order by purview_num");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会员级别权限设定 - <%=name%></title>

<script language="javaScript" src="/webadmin/scripts/MzTreeView12.js"></script>
<style>
body {
	font:normal 12px 宋体;
}
a.MzTreeview /* TreeView 链接的基本样式 */ { cursor: hand; color: #000080; margin-top: 5px; padding: 2 1 0 2; text-decoration: none; }
.MzTreeview a.select /* TreeView 链接被选中时的样式 */ { color: highlighttext; background-color: highlight; }
#kkk input {
vertical-align:middle;
}
.MzTreeViewRow {border:none;width:400px;padding:0px;margin:0px;border-collapse:collapse}
.MzTreeViewCell0 {border-bottom:1px solid #CCCCCC;padding:0px;margin:0px;}
.MzTreeViewCell1 {border-bottom:1px solid #CCCCCC;border-left:1px solid #CCCCCC;width:200px;padding:0px;margin:0px;}
</style></head>
<body>

<form id="theform" name="theform" method="post" action="manager_role_purview_opt_action.jsp" >

<table width="96%" border="0" align="center">
    <tr>
      <td width="2%">&nbsp;</td>
      <td width="98%" height="35"><strong><br />
      [<%=name%>] 会员级别权限设定：</strong></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
				<div id="divTree"></div>
	<script language="javascript" type="text/javascript">
	<!--
	
	var roles = "<%for(int i=0;purviews!=null&&i<purviews.length;i++){%><%=purviews[i][0]%>,<%}%>";
	
	window.tree = new MzTreeView("tree");
	tree.setIconPath("/webadmin/images/MzTreeView/"); //可用相对路径 
	
		tree.N["-1_0"] = "ctrl:sel;checked:1;T:权限资源;"		
		
<%for(int i=0;rolePurviews!=null && i<rolePurviews.length;i++){%>
		tree.N["<%=rolePurviews[i][2]%>_<%=rolePurviews[i][0]%>"] = "ctrl:sel;checked:0;T:<%=rolePurviews[i][1]%>;"
<%}%>	

	tree.setURL("#");
	tree.wordLine = false;
	tree.setTarget("main");
	document.getElementById("divTree").innerHTML=tree.toString();
	
	tree.expandAll();
	
	//alert(document.getElementsByTagName("head")[0].innerHTML);
	//alert(document.getElementById("kkk").innerHTML);
	
//为checkbox类型的赋值
	function setCheckbox(name,value){
	var obj=document.getElementsByName(name); 
	for(var i=0;i<obj.length;i++) 
	{ 
	//alert(obj.length);
	//alert(obj[i].value+"--"+value);
	
		if(obj[i].value==value) 
		{ 
			obj[i].checked=true; 
			break; 
		} 
	}
	
	}	
	

	
	function setCheckValues(){	
		var roleArr = roles.split(",");
		for(i=0;roleArr!=null && i<roleArr.length;i++){
			setCheckbox("sel",roleArr[i]);
		}
	}
	setCheckValues();	
	//setCheckbox("sel","6001");
	//-->
	</script>	</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td height="36">
<input name="提交" type="submit"  value='保存权限' />
<input name="roleNum" type="hidden" id="roleNum" value="<%=roleNum%>"/>
	 </td>
    </tr>
</table>
</form>

</body>
</html>