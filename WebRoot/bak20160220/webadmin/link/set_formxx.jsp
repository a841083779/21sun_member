<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<% 
if(pool==null){
	pool = new PoolManager();
}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	
<script>
//根据传入的字段，返回是否在字符串中
function fieldInFields(fields,field){
result=false;
if(fields!=null && field!=null){
	tp=fields.split(",");
	for(i=0;i<tp.length;i++){
		if(field==(tp[i])){
			result=true;
			break;
		}
	}	
}
return result;
}

//为radio类型的赋值
function setRadio(name,value){
var obj=parent.document.getElementsByName(name); 
for(var i=0;i<obj.length;i++) 
{ 
	if(obj[i].value==value) 
	{ 
		obj[i].checked=true; 
		break; 
	} 
}

}

//为checkbox类型的赋值
function setCheckbox(name,value){
var obj=parent.document.getElementsByName(name); 
for(var i=0;i<obj.length;i++) 
{ 
	if(obj[i].value==value) 
	{ 
		obj[i].checked=true; 
		break; 
	} 
}

}

//根据文章栏目的值选中新闻栏目
function setSortCheck(sorts){
var obj=parent.document.getElementsByName("sort_num"); 
for(var i=0;i<obj.length;i++) 
{ 
	if(fieldInFields(sorts,obj[i].value)) 
	{ 
		obj[i].checked=true; 
	} 
}

}

//根据权限的值选中对应的用户权限
function setPurviewCheck(purviews){
var obj=parent.document.getElementsByName("user_purview"); 
for(var i=0;i<obj.length;i++) 
{ 
	if(fieldInFields(purviews,obj[i].value)) 
	{ 
		obj[i].checked=true; 
	} 
}

}

//根据文章栏目的值选中类型
function setSortCheck2(sorts){
var obj=parent.document.getElementsByName("arti_type"); 
for(var i=0;i<obj.length;i++) 
{ 
	if(fieldInFields(sorts,obj[i].value)) 
	{ 
		obj[i].checked=true; 
	} 
}

}
</script>
<%
Connection conn=pool.getConnection();
try{
 
  String tablename=request.getParameter("tablename");
  String paraValue=request.getParameter("paraValue");
  String paraName=request.getParameter("paraName");
  String whereStr="";
  
  StringBuffer strSQL=new StringBuffer();
  ResultSet rs=null; 
  strSQL.append("select * from "+tablename+" where "+whereStr+" "+paraName+"='"+paraValue+"'");
  
  rs=DataManager.executeQuery(conn,strSQL.toString());

  String strFields="";
  String [] strSets=null;
  strSets = DataManager.getAllFieldNames(pool, tablename); 

  String pageName=request.getParameter("pageName");
  if(pageName==null) pageName="";
  String fieldNameR="";
  //fieldNameR 设置成为只读
  if(pageName.equals("")){
	fieldNameR="";
  }
 
if(rs.next()){
	String fValue = "";
	for(int i=0;i<strSets.length;i++){
	fValue=rs.getString(strSets[i]);
	if(fValue!=null){
		//fValue=fValue.replace("\n", "\\n").replace("\r", "").replace("'", "").replace("\"", "").replace(" 00:00:00.0","");
		fValue=fValue.replace("\n", "\\n").replace("\r", "").replace("'", "\\\'").replace("\"", "\\\"").replace(" 00:00:00.0","");
	}else{
		fValue="";
	}
	//System.out.println(fValue);
%>
<script>
  var myform=parent.document.theform;
  var zhi="<%=fValue%>";
  //alert(zhi);
  var obj=parent.document.getElementById("zd_<%=strSets[i]%>");
  if(obj!=null){
  	var objType="";
	objType=obj.type;
	if(objType=="radio"){	
	  setRadio("zd_<%=strSets[i]%>",zhi);
	}else if(objType=="checkbox"){
	  setCheckbox("zd_<%=strSets[i]%>",zhi);
	}else{
	  myform.zd_<%=strSets[i]%>.value=zhi;
	}
  }
</script>
<%
	}
}

}catch(Exception e){
	e.printStackTrace();
}finally{
	pool.freeConnection(conn);
}
%>