<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
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
//alert(obj.length);
for(var i=0;i<obj.length;i++) 
{ 
	if(obj[i].value==value) 
	{ 
		obj[i].checked=true; 
		break; 
	} 
}

}

function setChecks(sorts,name){
var obj=parent.document.getElementsByName(name); 
for(var i=0;i<obj.length;i++){ 
	if(fieldInFields(sorts,obj[i].value)){ 
		obj[i].checked=true; 
	 } 
   }
}
function setImg(val,name){
   parent.document.getElementById('txt_zd_'+name).innerHTML = "<font color='red'><a href='"+val+"' target='_blank'><font color='red'>点击此处查看图片</font></a>，<a href='#' onclick=\"reupload('zd_"+name+"');\"><font color='red'>点击此处重新上传</font></a>。</font>";
    parent.document.all('ifr_zd_'+name).style.display='none';
    parent.document.all('txt_zd_'+name).style.display='block';
}
</script>
<%
 String mypy=request.getParameter("mypy");
  PoolManager pool3 =null;
  if(mypy.equals("member_info")){
    pool3  = new PoolManager(1);
  }else{
    pool3  = new PoolManager(3);
  }
 Connection conn=pool3.getConnection();
try{
 //====加密处理======
  
//=================
 
   
  String paraValue=request.getParameter("paraValue");
  //paraValue=Common.decryptionByDES(paraValue);

  String paraName=Common.dofilter(request.getParameter("paraName"));
  if(paraName.equals("myvalue"))
  paraName="id";
  String whereStr="";
  
  StringBuffer strSQL=new StringBuffer();
  ResultSet rs=null; 
  strSQL.append("select * from "+mypy+" where "+whereStr+" "+paraName+"='"+paraValue+"'");
  
  rs=DataManager.executeQuery(conn,strSQL.toString());

  String strFields="";
  String [] strSets=null;
  strSets = DataManager.getAllFieldNames(pool3, mypy); 

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
		fValue=fValue.replace("\n", "\\n").replace("\r", "").replace("'", "\\\'").replace("\"", "\\\"").replace(" 00:00:00.0","").replace("<script>","").replace("</script>","");
	}else{
		fValue="";
	}	
%>
<script>
<%
	if(strSets[i].equals("product_flag")){
		out.println("setChecks('"+fValue+"','"+strSets[i]+"');");
	}
	if(strSets[i].equals("sort_num")){
		out.println("setChecks('"+fValue+"','"+strSets[i]+"');");
	}
	if(Common.getFormatStr(strSets[i]).equals("pubdate")){	
		if(!fValue.equals("") && fValue.indexOf(".")!=-1 && fValue.length()==21){
			fValue = fValue.substring(0,fValue.lastIndexOf(".")); //时间处理
		}	 
	}
%>

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
  
<%
     if(mypy.equals("rent_info")||mypy.equals("equipment")||mypy.equals("rent_subscribe")){
		if(strSets[i].equals("img")){
		   if(!fValue.equals("")){
		     out.println("setImg('"+fValue+"','"+strSets[i]+"');");
		   }
		} 
		if(strSets[i].equals("province")){
			out.println("parent.set_city(parent.document.getElementsByName('zd_province'),zhi,parent.theform.zd_city,'');");
		}		
		/*if(strSets[i].equals("category")){
			out.println("parent.listclass(parent.theform.zd_subcategory,zhi);");
		}*/
	}
	
%>  
</script>
<%
	}
  }
}catch(Exception e){
	e.printStackTrace();
}finally{
	pool3.freeConnection(conn);
}
%>
<script type="text/javascript">
if(typeof(parent.afterForm)!='undefined'){
	parent.afterForm();
}
</script>