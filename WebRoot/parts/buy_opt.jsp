<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%
	pool = new PoolManager(7);
	PoolManager pool1 = new PoolManager(1);
//=====页面属性====
String pagename="buy_opt.jsp";
String mypy="buy";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));

HashMap userInfo = (HashMap)request.getSession().getAttribute("memberInfo");
String session_mem_flag = Common.getFormatStr((String)userInfo.get("mem_flag"));
if(session_mem_flag.equals("-9999")) session_mem_flag="";

String session_per_phone = Common.getFormatStr((String)userInfo.get("per_phone"));
if(session_per_phone.equals("-9999")) session_per_phone="";

String urlpath="../parts/buy_opt.jsp";
if(!myvalue.equals("")){
	urlpath=urlpath+"?myvalue="+java.net.URLEncoder.encode(myvalue,"UTF-8");  
}
String today= Common.getToday("yyyy-MM-dd",0);
String content_temp="完整、详细的信息描述更能让您获得与高品质供应商的合作！";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>

var subCategory = new Array();
<cache:cache key="cache_subcategory1" cron="0 0/30 6-23 * * ?">
<%	
String[][] subCategory = DataManager.fetchFieldValue(pool, "parts_catalog","num,name,parentid", "parentid<>0");
if(subCategory!=null){
	for(int i=0;i<subCategory.length;i++){
%>
	subCategory[<%=i%>]=['<%=subCategory[i][0]%>','<%=subCategory[i][1]%>','<%=subCategory[i][2]%>']; 
<%
	 }
	}
%>
</cache:cache>
function set_subcategory(obj){
	document.getElementById("zd_categoryname").value=obj.options[obj.selectedIndex].text;
	var sub = document.getElementById("zd_subcategory");
	sub.length=0;
	sub.options[0]=new Option('选择子分类','');	
	for(var i=0,j=1;i<subCategory.length;i++){	   
		if(subCategory[i][0].length>3 && subCategory[i][0].substring(0,3)==obj.value){ //通过子类别的前3个字符找到对应父类下所有类别。父类别 101  子类别 101001
			sub.options[j]=new Option(subCategory[i][1],subCategory[i][0]);
			j++;
		}
	}
}
function set_subcategoryname(obj){
	document.getElementById("zd_subcategoryname").value=obj.options[obj.selectedIndex].text;
}

//为多选框赋值
function submityn(obj){
        var content_temp='<%=content_temp%>';
		if(document.theform.zd_title.value==""){
			alert("请输入标题！");
			document.theform.zd_title.focus();
			return false;
		}else if(document.theform.zd_province.value==""){
			alert("请选择省份！");
			document.theform.zd_province.focus();
			return false;
		}else if(document.theform.zd_city.value==""){
			alert("请选择城市！");
			document.theform.zd_city.focus();
			return false;
		}else if(document.theform.zd_category.value==""){
			alert("请输入配件类别！");
			document.theform.zd_category.focus();
			return false;
		}else if(document.theform.zd_subcategory.value==""){
			alert("请输入配件子类别！");
			document.theform.zd_subcategory.focus();
			return false;
		}else if(document.theform.zd_content.value=="" || document.theform.zd_content.value==content_temp){
			alert("请输入描述，内容控制在300个汉字以内！");
			document.theform.zd_content.focus();
			return false;
		}
		
		if(obj=='submit'){
		 document.theform.action="opt_save_update_parts.jsp";
		 document.theform.target='_self';
		 document.theform.submit();
		}else if(obj=='preview'){
		  return 'preview';
		}
}
function initSubCategory(){
	if(document.getElementById("zd_category").value!=""){
		var ss = document.getElementById("zd_subcategory").selectedIndex;
		set_subcategory(document.getElementById("zd_category"));
		document.getElementById("zd_subcategory").selectedIndex=ss;
	}
}
function isNumeric(strNumber) { 
	var objRegExp="";
	 objRegExp  = /^(\+|-)?(0|[1-9]\d*)(\.\d*[1-9])?$/; //不可以为小数	
	if(!objRegExp.test(strNumber.value)){
	    strNumber.value="";
	}
}
function preview(){
   if(submityn('preview')=='preview'){    
	//document.theform.action="http://192.168.20.167:9123/buy/buypreview.jsp";
	document.theform.action="http://part.21-sun.com/buy/buypreview.jsp";
	document.theform.target="_blank";
	document.theform.submit();   
  }
  
}
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh"><%if(!myvalue.equals("")){%>更新<%}else{ %>发布<%} %>配件求购</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机，<span class="red">*</span> 为必填项。<br />
		信息发布后，系统需审核，15分钟左右发布。</td>
      </tr>
    </table>
    <form action="opt_save_update_parts.jsp" method="post" name="theform" id="theform">
    <table width="95%" border="0" align="center" class="tablezhuce">
      
        <tr>
          <td nowrap="nowrap"  class="right"><span class="red">*</span> <span class="grayb">标　　题：</span></td>
          <td ><input name="zd_title" type="text" id="zd_title" size="75" maxlength="200" class="moren"></td>
        </tr>
        <tr>
          <td class="right" nowrap="nowrap" ><span class="red">*</span> <span class="grayb">省　　市：</span></td>
          <td height="22" ><select name="zd_province" id="zd_province" onchange="set_city(this,this.value,document.theform.zd_city,'');" style="width:100px;"  class="blue1">
              <option value="">选择省份</option>
              <option value="北京">北京</option>
              <option value="上海">上海</option>
              <option value="天津">天津</option>
              <option value="重庆">重庆</option>
              <option value="河北">河北</option>
              <option value="山西">山西</option>
              <option value="辽宁">辽宁</option>
              <option value="吉林">吉林</option>
              <option value="黑龙江">黑龙江</option>
              <option value="江苏">江苏</option>
              <option value="浙江">浙江</option>
              <option value="安徽">安徽</option>
              <option value="福建">福建</option>
              <option value="江西">江西</option>
              <option value="山东">山东</option>
              <option value="河南">河南</option>
              <option value="湖北">湖北</option>
              <option value="湖南">湖南</option>
              <option value="广东">广东</option>
              <option value="海南">海南</option>
              <option value="四川">四川</option>
              <option value="贵州">贵州</option>
              <option value="云南">云南</option>
              <option value="陕西">陕西</option>
              <option value="甘肃">甘肃</option>
              <option value="青海">青海</option>
              <option value="内蒙古">内蒙古</option>
              <option value="广西">广西</option>
              <option value="西藏">西藏</option>
              <option value="宁夏">宁夏</option>
              <option value="新疆">新疆</option>
              <option value="台湾">台湾</option>
              <option value="香港">香港</option>
              <option value="澳门">澳门</option>
            </select>
            <select  name="zd_city" id="zd_city"  style="width:100px;" class="blue1">
              <option>选择城市</option>
            </select>
            </span></td>
        </tr>        
        <tr>
          <td  class="right" nowrap="nowrap" ><span class="red">*</span><span class="grayb">配件类别：</span></td>
          <td height="22" >
          	<select name="zd_category" id="zd_category" onchange="set_subcategory(this);" style="width:100px;"  class="blue1">
          		<option value="">请选择分类</option>
          	   	<cache:cache key="include_category" cron="0 0/30 6-23 * * ?">
          		<%=Common.option_str(pool,"parts_catalog","num,name","parentid=0","",0) %>          		</cache:cache>
            </select>
            <select  name="zd_subcategory" id="zd_subcategory"  style="width:100px;" class="blue1" onchange="set_subcategoryname(this);">
              <option>选择子分类</option>
            </select>
            <input type="hidden" name="zd_categoryname"     id="zd_categoryname"/>
			<input type="hidden" name="zd_subcategoryname"  id="zd_subcategoryname"/>
            </span></td>
        </tr>
		 <tr>
          <td class="right" nowrap="nowrap"><span class="grayb">型号：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_model" name="zd_model" value="" size="20" maxlength="60" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr>
		 <tr>
          <td class="right" nowrap="nowrap"><span class="grayb">采购数量：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_amount" name="zd_amount" value="" size="20" maxlength="60" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial" onKeyUp="isNumeric(this);"/></td>
        </tr>
        <tr>
          <td class="right" nowrap="nowrap"><span class="grayb">有效日期：</span></td>
          <td height="22" class="list_cell_bg">
          <input type="radio" id="zd_pubdays" name="zd_pubdays" value="7" style="border:0";/>
            一个周
            <input type="radio" id="zd_pubdays" name="zd_pubdays" value="30" checked="checked" style="border:0";/>
            一个月
            <input type="radio" id="zd_pubdays" name="zd_pubdays" value="90" style="border:0";/>
            三个月
            <input type="radio" id="zd_pubdays" name="zd_pubdays" value="180" style="border:0";/>
            半年
            <input type="radio" id="zd_pubdays" name="zd_pubdays" value="360" style="border:0";/>
            长期有效 </td>
        </tr>
		<input type="hidden" name="zd_is_pub" id="zd_is_pub" value="1" />
		<!--
        <tr>
          <td  class="right" nowrap="nowrap" ><span class="grayb">是否显示：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked" />
            是
            <input type="radio" id="zd_is_pub" name="zd_is_pub" value="0" />
            否 </td>
        </tr>
		-->
        <tr>
          <td  class="right" nowrap="nowrap" ><span class="grayb">是否紧急：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_urgent" name="zd_is_urgent" value="1" />
            是
            <input name="zd_is_urgent" type="radio" id="zd_is_urgent" value="0" checked="checked";/>
            否 </td>
        </tr>
		<tr>
          <td  class="right" nowrap="nowrap" ><span class="grayb">是否正厂：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_original" name="zd_is_original" value="1" checked="checked" style="border:0";/>
            正厂
            <input type="radio" id="zd_is_original" name="zd_is_original" value="0" style="border:0";/>
            副厂 </td>
        </tr>
		 <tr>
          <td  class="right" nowrap="nowrap" ><span class="grayb">新旧程度：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_old" name="zd_old" value="1" checked="checked" style="border:0";/>
            全新
            <input type="radio" id="zd_old" name="zd_old" value="2" style="border:0";/>
            二手 </td>
        </tr>
        <tr>
          <td class="right" nowrap="nowrap" ><span class="red">*</span><span class="grayb">描　　述：</span></td>
          <td height="22" class="list_cell_bg"><textarea name="zd_content" cols="60" rows="6" id="zd_content" onkeyup="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="overflow-y:scroll;"><%=content_temp%></textarea></td>
        </tr>
        <tr>
          <td class="right" nowrap="nowrap" ><span class="grayb">电　　话：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" name="zd_telephone" id="zd_telephone" value="<%=session_per_phone%>" maxlength="20" class="moren">&nbsp;请留下您常用、正确的联系电话</td>
        </tr>
		<tr>
		<td  class="right" nowrap="nowrap"><span class="grayb">验 证 码：</span></td>
          <td height="22" class="list_cell_bg">		  
		  <input type="text" id="rand" name="rand" value="" size="20" maxlength="20"  class="moren"/>
            <img src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/>		  </td>
        <tr>
	

          <td nowrap="nowrap" class="right">&nbsp;</td>
          <td class="right"><input type="button" name="mit" value="发 布" style="cursor:pointer;margin-right:15px" class="tijiao" onclick="submityn('submit')"/><input type="button" name="mit" value="预 览" style="cursor:pointer;" class="tijiao" onclick="preview()"/></td>
        </tr>
		<input name="zd_id" type="hidden" id="zd_id" value="0" />
            <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
            <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=usern %>" />
            <input name="zd_mem_name" type="hidden" id="zd_mem_name" value="<%=realname %>" />
			<input name="zd_qq" type="hidden" id="zd_qq" value="<%=qq%>"/>
			<input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd",0)%>" />
			<input name="zd_pubdate" type="hidden" id="zd_pubdate" value="<%=Common.getToday("yyyy-MM-dd",0)%>" />
            <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
            <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
            <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
            <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
            <input name="randflag" type="hidden" id="randflag" value="1" />
			<input name="zd_mem_flag" type="hidden" id="zd_mem_flag" value="<%=session_mem_flag%>"/>
    </table>
    </form>	
  </div>
</div>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script language="javascript">
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
refresh();
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val)+"&pool=7");
	}
}
<%
if(!myvalue.equals("")){
	out.print("set_formxx(\""+Common.decryptionByDES(myvalue)+"\");");
}
%>
</script>

</body>
</html>