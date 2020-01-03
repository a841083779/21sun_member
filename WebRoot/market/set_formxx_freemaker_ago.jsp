<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
	<%
	 String prxStr = "zx";//字段前缀
	%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	
<script src="/scripts/jquery-1.7.2.min.js"></script>
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
if(name=='<%=prxStr+"_"%>part_flag' && value=='106'){
	parent.jQuery("#other_part_flag").show() ;
}
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

function setChecks(sorts,name){
if(name=='product_flag' && sorts=='0'){
	parent.jQuery("#otherCatalog").show() ;
}
if(name=='probrand' && sorts=='0'){
	parent.jQuery("#otherBrand").show() ;
}
var obj=parent.document.getElementsByName(name); 
for(var i=0;i<obj.length;i++) 
{ 
	if(fieldInFields(sorts,obj[i].value)) 
	{ 
		obj[i].checked=true; 
	} 
}
}
function setProBrand(val,name){
var obj = parent.document.getElementById("<%=prxStr+"_"%>"+name) ;
obj[0].innerHTML = val ; 
}
function setImg(val,name){
if(val=='')val="'javascript:void(0)'";
else
val="'"+val+"' target='_blank' ";
	 parent.document.getElementById('txt_<%=prxStr+"_"%>'+name).innerHTML = "<font color='red'><a href="+val+" ><font color='red'>点击此处查看图片</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:void(0)' onclick=\"reupload('<%=prxStr+"_"%>"+name+"');\"><font color='green'>点击此处重新上传</font></a></font>";
	parent.document.getElementById('ifr_<%=prxStr+"_"%>'+name).style.display='none';
	parent.document.getElementById('txt_<%=prxStr+"_"%>'+name).style.display='block';
}
</script>
<%
PoolManager pool4 = new PoolManager(13);
Connection conn=pool4.getConnection();
try{
  String mypy=request.getParameter("mypy");
  String paraValue=request.getParameter("paraValue");
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
  strSets = DataManager.getAllFieldNames(pool4, mypy); 
  String pageName=request.getParameter("pageName");
  if(pageName==null) pageName="";
  String fieldNameR="";
  //fieldNameR 设置成为只读
  if(pageName.equals("")){
	fieldNameR="";
  } 
if(rs.next()){
	String select_province = Common.getFormatStr(rs.getString("province")) ;
	String select_city = Common.getFormatStr(rs.getString("city")) ;
	if(!"".equals(select_province) || !"".equals(select_city))
	{
	out.println("<script>parent.document.getElementById('cond_search_form_work_location_show').innerHTML='"+select_province+select_city+"'</script>") ;
	}
	String fValue = "";
	for(int i=0;i<strSets.length;i++){
	   fValue=rs.getString(strSets[i]);
	if(fValue!=null){
		fValue=fValue.replace("\n", "\\n").replace("\r", "").replace("'", "\\\'").replace("\"", "\\\"").replace(" 00:00:00.0","").replace("<script>","").replace("</script>","");
	}else{
		fValue="";
	}
%>
<script>
<%
PoolManager pool = new PoolManager() ;
    //适用机型
	if(strSets[i].equals("product_flag")){
		out.println("setChecks('"+fValue+"','"+strSets[i]+"');");
	}
	if(strSets[i].equals("product_flag_name")){	
		out.println("parent.jQuery('#otherCatalog').val('"+fValue+"')") ;
	}
	// 品牌
	if(strSets[i].equals("probrand")){
		out.println("setChecks('"+fValue+"','"+strSets[i]+"');");
	}
	if(strSets[i].equals("probrandname")){	
		out.println("parent.jQuery('#otherBrand').val('"+fValue+"')") ;
	}
	// 配件
	if(strSets[i].equals("part_flag_name")){	
		out.println("parent.jQuery('#other_part_flag').val('"+fValue+"')") ;
	}
	if(strSets[i].equals("sort_num")){
		out.println("setChecks('"+fValue+"','"+strSets[i]+"');");
	}	
	if(Common.getFormatStr(strSets[i]).equals("pub_date")){ 
		if(!fValue.equals("") && fValue.indexOf(".")!=-1 && fValue.length()==21){
			fValue = fValue.substring(0,fValue.lastIndexOf(".")); //时间处理
		}	 
	}
%>

  var myform=parent.document.theform;
  var zhi="<%=fValue%>";
  var obj=parent.document.getElementById("<%=prxStr+"_"%><%=strSets[i]%>");
  if(obj!=null){
  	var objType="";
	objType=obj.type;
	if(objType=="radio"){	
	  setRadio("<%=prxStr+"_"%><%=strSets[i]%>",zhi);
	}else if(objType=="checkbox"){
	  setCheckbox("<%=prxStr+"_"%><%=strSets[i]%>",zhi);
	}else{
	     if(obj.name!='<%=prxStr+"_"%>company' && obj.name!='<%=prxStr+"_"%>mem_flag' && zhi != "" && obj.name!='<%=prxStr+"_"%>is_review'){
	   	     myform.<%=prxStr+"_"%><%=strSets[i]%>.value=zhi;	
	   	  //  alert('<%=strSets[i]%>'+zhi) ;
		}	 
	 }
  }
<%
if(strSets[i].equals("img1")){
	//out.println("setImg('"+fValue+"','"+strSets[i]+"');");
	out.println("parent.document.getElementById('my_equi_img').src=parent.document.getElementById('"+prxStr+"_"+"img1').value;");
}
	if(strSets[i].equals("province")){
		
	}
%>  
</script>
<%
	}
}
}catch(Exception e){
	e.printStackTrace();
}finally{
	pool4.freeConnection(conn);
}
%>
