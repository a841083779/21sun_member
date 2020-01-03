<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
//=====页面属性====
String pagename="rent_opt.jsp";
String mypy="rent_info";
String titlename="";

//===发布总数===
int PUBNUMS=30;
if(usern.equals("CATRENTALWH")||usern.equals("CATRENTALNB")||usern.equals("CATRENTALYT")||usern.equals("CATRENTALNJ")||usern.equals("CATRENTALKS")||usern.equals("CATRENTALSH"))
PUBNUMS=80;


//============
//====得到参数====
String myvalue  = Common.getFormatStr(request.getParameter("myvalue"));
String urlpath="../rent/rent_opt.jsp";

if(!myvalue.equals("")){ 
    urlpath=urlpath+"?myvalue="+java.net.URLEncoder.encode(myvalue,"UTF-8");  
   //需要编码 才能将加密后产生的特殊字符 例如：将 +  转码成 %2B
}
String mem_no ="",comp_name="",mem_flag="",mem_name="",rent_mode="",shopid="",per_qq="",per_phone="",comp_id="";
HashMap memberInfo = new HashMap();
if(session.getAttribute("memberInfo")!=null){   
   memberInfo     = (HashMap) session.getAttribute("memberInfo");
   mem_no         = Common.getFormatStr(String.valueOf(memberInfo.get("mem_no")));  //登陆账号
   comp_name      = Common.getFormatStr(String.valueOf(memberInfo.get("comp_name")));
   mem_name       = Common.getFormatStr(String.valueOf(memberInfo.get("mem_name")));
   mem_flag       = Common.getFormatInt(String.valueOf(memberInfo.get("mem_flag")));
   rent_mode      = Common.getFormatInt(String.valueOf(memberInfo.get("rent_mode")));
   shopid      = Common.getFormatInt(String.valueOf(memberInfo.get("id")));
   per_qq     = Common.getFormatStr(String.valueOf(memberInfo.get("per_qq")));
   per_phone     = Common.getFormatStr(String.valueOf(memberInfo.get("per_phone")));
   
 	//add by gaopeng at 20130418
	comp_id = Common.getFormatStr(memberInfo.get("id")) ;
}

//gaopeng add at 20140226-begin
if(mem_flag.equals("1005")){
	PUBNUMS=80;	
}
//gaopeng add at 20140226-end

try{//====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发布租赁信息</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
 var pubCount=0;
 function onloadAjax(){
		$.ajax({
		type: "POST",
		url: "../manage/countpub.jsp",
		data: "tablename=rent_info&poolnum=3&mem_no=<%=mem_no%>",
		success: function(msg){ 
		      	pubCount = $.trim(msg);	
				document.getElementById("spanPubCount").innerText=pubCount;	
				var zd_class_arr = document.theform.zd_class;
				if(pubCount>=<%=PUBNUMS%> && zd_class_arr[0].checked){//不做限制
				    //document.getElementById("warningId").color='red';	
					document.getElementById('submitId').disabled=true;							
					alert("您今天已发布了"+pubCount+"条租赁信息，已经达到最大发布数,自动跳转至列表页！");
					window.location.href="../rent/rent_list.jsp";			    		
				}
			} 
		}); 
	} 
  function submityn(){
  document.theform.zd_pubdate.value=document.getElementById("pub_date_temp").value;
  document.theform.zd_orderno.value="<%=Common.create21SUNOrderNo(1,mem_flag,0)%>";
  document.theform.zd_orderno1.value="<%=Common.create21SUNOrderNo(1,mem_flag,1)%>";
  var str_title=document.theform.zd_title.value;
if($("input[name='zd_class'][checked]").val()=="1")
document.theform.zd_title.value=str_title.replace("求租","出租");
else if($("input[name='zd_class'][checked]").val()=="0")
document.theform.zd_title.value=str_title.replace("出租","求租");

  var zd_class_arr = document.theform.zd_class;
   if(pubCount>=<%=PUBNUMS%> && zd_class_arr[0].checked){
			alert("您今天已发布了"+pubCount+"条租赁信息，已经达到最大发布数！");
			return false;
	}else if($("#zd_mem_name").val()==""){
			alert("请输入姓名！");
			$("#zd_mem_name").focus();
			return false;
	}else if($("#zd_telephone").val()==""){
			alert("请输入电话！");
			$("#zd_telephone").focus();
			return false;
	}else if($("#zd_title").val()==""){
			alert("请输入标题！");
			$("#zd_title").focus();
			return false;
	}else if(returnRadio("zd_class")==false){
			alert("请选择租赁类型！");
			return false;
	}else if($("#zd_category").val()==""){
			alert("请选择类型！");
			$("#zd_category").focus();
			return false;
	}else if($("#zd_province").val()==""){
	       alert("请选择省份！");
			$("#zd_province").focus();
			return false;	
	}else if($("#zd_city").val()==""){
	        alert("请选择城市！");
			$("#zd_city").focus();
			return false;	
	}
	
	$.post("/rent/tools/check_rent_content.jsp",{"zx_title":$("#zd_title").val(),"zx_descr":$("#zd_content").val()},function(data){
		if($.trim(data)==1){
			alert("您发布的信息含有非法词汇，请您重新发布！");
		   return false;	
		}else{
		   document.theform.submit();
		}
	});
	
	
 }

function checkradio(){
	var selected = $("input[name='zd_class']:checked").val();
	if(selected == null){
		alert("请选择租赁类型！");
		$("#zd_title").val("");
	}
}
function dochange(param)
{if(param==0)
{$("#id_price").hide();
$("#id_img").hide();
}
else if(param==1)
{$("#id_price").show();
$("#id_img").show();
}
}
</script>
</head>
<body>

  <div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh" style="float:left;">发布租赁信息</span><%if(mem_flag.equals("1005")){ %><div style="width:120px; float:right;line-height:35px; font-weight:bold;"><a href="http://www.21-rent.com/shop/shopdetail<%=rent_mode %>_for_<%=comp_id %>.htm" target="_blank">进入我的店铺&gt;&gt;</a><%} %></div>
  <div class="loginlist_right1">
  
	 <table width="95%" border="0" align="center" class="tablezhuce">
      <tr>
          <td>
		  <b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机，<span class="red">*</span> 为必填项。<br />
		  信息发布后，系统需审核，15分钟左右发布。<!--每天发布信息量最多只可以发布<font color="red"><b>30</b></font>条，-->您今天已经发布了<font color="green"><b><span id="spanPubCount"></span></b></font>条。<a href="../rent/equipment_opt.jsp">租赁设备管理</a></td>
      </tr>
    </table>
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
  <table width="95%" border="0" align="center" class="tablezhuce">
  	<tr>
      <td height="22" align="right" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>租赁类型：</strong></td>
      <td height="22" class="list_cell_bg">
	      <input type="radio" name="zd_class" value="1" onClick="javascript:dochange(1);"> 出租&nbsp;&nbsp;<input type="radio" name="zd_class" value="0" onClick="javascript:dochange(0);">
	      求租</td>
    </tr>
  	<tr>
  	  <td height="22" align="right" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>姓　　名：</strong></td>
  	  <td height="22" class="list_cell_bg"><input name="zd_mem_name" type="text" id="zd_mem_name" size="30" maxlength="30" class="required" value="<%=mem_name%>"></td>
	  </tr>
  	<tr>
  	  <td height="22" align="right" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>电　　话：</strong></td>
  	  <td height="22" class="list_cell_bg"><input name="zd_telephone" type="text" id="zd_telephone" size="30" maxlength="30" class="required" value="<%=per_phone%>"></td>
	  </tr>
    <tr>
       <td align="right" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>标　　题：</strong></td>	
       <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="25" class="required"  dataType="Require" msg="标题不能为空" >（标题请填写25字之内）</td>
    </tr>
 
	<tr>
		<td height="22" align="right" nowrap class="list_left_title"><strong>发布时间：</strong></td>
		<td height="22" class="list_cell_bg"><input type="text" id="zd_pubdate" name="zd_pubdate" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="20" maxlength="60"  readonly="true" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
	</tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><strong>有效期天数：</strong></td>
      <td height="22" class="list_cell_bg">
		   <input type="radio" name="zd_pubdays" checked="checked" value="7">
		   一个周&nbsp;&nbsp;
		   <input type="radio" name="zd_pubdays" value="30">
		   一个月&nbsp;&nbsp;
		   <input type="radio" name="zd_pubdays" value="90">
		   三个月&nbsp;&nbsp;
		   <input type="radio" name="zd_pubdays" value="180">半年&nbsp;&nbsp;<input type="radio" name="zd_pubdays" value="360">
		   长期有效&nbsp;&nbsp;		</td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>所属类型：</strong></td>
      <td class="list_cell_bg"><select name="zd_category" id="zd_category">
                    <option value=""> --请选择类别-- </option>
                    <option value="01">路面机械</option>
                    <option value="0101">&nbsp;&nbsp;&nbsp;&nbsp;摊铺机</option>
                    <option value="0102">&nbsp;&nbsp;&nbsp;&nbsp;压路机</option>
                    <option value="0103">&nbsp;&nbsp;&nbsp;&nbsp;平地机</option>
                    <option value="0104">&nbsp;&nbsp;&nbsp;&nbsp;铣刨机 </option>
                    <option value="0105">&nbsp;&nbsp;&nbsp;&nbsp;推土机</option>
                    <option value="0106">&nbsp;&nbsp;&nbsp;&nbsp;沥青搅拌站</option>
                    <option value="0107">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
                    <option value="02">起重机系列</option>
					<option value="0201">&nbsp;&nbsp;&nbsp;&nbsp;塔吊</option>
                    <option value="0202">&nbsp;&nbsp;&nbsp;&nbsp;履带吊</option>
					<option value="0203">&nbsp;&nbsp;&nbsp;&nbsp;汽车吊</option>
					<option value="0204">&nbsp;&nbsp;&nbsp;&nbsp;龙门吊</option>
					<option value="0205">&nbsp;&nbsp;&nbsp;&nbsp;高空作业车</option>
					<option value="0207">&nbsp;&nbsp;&nbsp;&nbsp;叉车</option>
					<option value="0206">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="03">混凝土系列</option>
					<option value="0301">&nbsp;&nbsp;&nbsp;&nbsp;泵车</option>
                    <option value="0302">&nbsp;&nbsp;&nbsp;&nbsp;搅拌运输车</option>
					<option value="0303">&nbsp;&nbsp;&nbsp;&nbsp;搅拌站</option>
					<option value="0304">&nbsp;&nbsp;&nbsp;&nbsp;搅拌车</option>
					<option value="0305">&nbsp;&nbsp;&nbsp;&nbsp;拖泵</option>
					<option value="0306">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="04">土石方系列</option>
					<option value="0401">&nbsp;&nbsp;&nbsp;&nbsp;挖掘机</option>
                    <option value="0402">&nbsp;&nbsp;&nbsp;&nbsp;推土机</option>
					<option value="0403">&nbsp;&nbsp;&nbsp;&nbsp;定向钻机</option>
					<option value="0404">&nbsp;&nbsp;&nbsp;&nbsp;装载机</option>
					<option value="0405">&nbsp;&nbsp;&nbsp;&nbsp;自卸车</option>
					<option value="0406">&nbsp;&nbsp;&nbsp;&nbsp;挖掘装载机</option>
					<option value="0407">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="05">动力设备</option>
					<option value="0501">&nbsp;&nbsp;&nbsp;&nbsp;发电机组</option>
                    <option value="0502">&nbsp;&nbsp;&nbsp;&nbsp;发动机</option>
					<option value="0503">&nbsp;&nbsp;&nbsp;&nbsp;空压机</option>
					<option value="0504">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="06">市政机械</option>
					<option value="0601">&nbsp;&nbsp;&nbsp;&nbsp;清扫机</option>
                    <option value="0602">&nbsp;&nbsp;&nbsp;&nbsp;除雪机</option>
					<option value="0603">&nbsp;&nbsp;&nbsp;&nbsp;排障车</option>
					<option value="0604">&nbsp;&nbsp;&nbsp;&nbsp;洒水车</option>
					<option value="0605">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="07">桩工桥梁机械</option>
					<option value="0701">&nbsp;&nbsp;&nbsp;&nbsp;旋挖钻</option>
                    <option value="0702">&nbsp;&nbsp;&nbsp;&nbsp;潜孔钻机</option>
					<option value="0703">&nbsp;&nbsp;&nbsp;&nbsp;打桩机</option>
					<option value="0704">&nbsp;&nbsp;&nbsp;&nbsp;水平定向钻</option>
					<option value="0705">&nbsp;&nbsp;&nbsp;&nbsp;连续墙抓斗</option>
					<option value="0706">&nbsp;&nbsp;&nbsp;&nbsp;架桥机</option>
					<option value="0707">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="09">破碎设备</option>
					<option value="0901">&nbsp;&nbsp;&nbsp;&nbsp;破碎锤</option>
                    <option value="0902">&nbsp;&nbsp;&nbsp;&nbsp;液压剪</option>
					<option value="0903">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="08">其它机械</option>
                  </select>				</td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title"><strong>设备品牌：</strong></td>
      <td height="22" class="list_cell_bg"><input name="zd_brand" type="text" id="zd_brand" size="30" maxlength="30" dataType="Require" msg="留言内容不能为空"></td>
	</tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><strong>设备型号：</strong></td>
      <td height="22" class="list_cell_bg"><input name="zd_model" type="text" id="zd_model" size="30" maxlength="30"></td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>所在地：</strong></td>
      <td height="22" class="list_cell_bg"><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:100px;"  class="validate-selection">
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
        <select  name="zd_city" id="zd_city"  style="width:100px;">
          <option value="">选择城市</option>
        </select></td>
	 </tr>
	 <tr id="id_price">
      <td height="22" align="right" nowrap class="list_left_title"><strong>租赁价格：</strong></td>
      <td height="22" class="list_cell_bg">
	  		<input name="zd_price" type="text" id="zd_price" size="20" maxlength="20">元 </td>
	 </tr>
    <tr id="id_img">
      <td height="22" align="right" nowrap class="list_left_title"><strong>设备图片：</strong></td>
      <td height="22" class="list_cell_bg">	  
		<input name="zd_img" id="zd_img" type="hidden" value="" /><span id="txt_zd_img"></span><span  id="ifr_zd_img"><iframe id="ifr2_zd_img" scrolling="no" frameborder="0" width="100%" height="28" src="http://resource.21-sun.com/web_upload_files_for_sigle.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=24&dir=rent&fieldname=zd_img" ></iframe></span><br />注：图片最大不超过200K		</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><strong>详细说明：</strong></td>
      <td height="22" class="list_cell_bg"><textarea name="zd_content" cols="50" rows="8" id="zd_content" onKeyUp="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}" style="overflow-y:scroll;"></textarea></td>
    </tr>
	
	<tr>
		<td  height="22" align="right" nowrap class="list_left_title"><strong>验 证 码：</strong></td>
		<td height="22" class="list_cell_bg">		  
		<input type="text" id="rand" name="rand" value="" size="20" maxlength="10"  class="moren"/>
		<img src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/>		 </td>
	</tr>
	<tr>
		<td nowrap="nowrap" class="right">&nbsp;</td>
		<td class="right"><input type="button" id="submitId" name="Submit" value="发 布" class="tijiao" style="cursor:pointer"  onClick="submityn()"/>		</td>
	</tr>   
	</table>
		<input name="zd_id"       type="hidden" id="zd_id"       value="0">
		<input name="mypy"        type="hidden" id="mypy"        value="<%=Common.encryptionByDES(mypy)%>">
		<input name="zd_mem_no"   type="hidden" id="zd_mem_no"   value="<%=mem_no%>">
		<input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
		<input name="zd_add_ip"   type="hidden" id="zd_add_ip"   value="<%=Common.getRemoteAddr(request,1)%>">		
		<input name="myvalue"     type="hidden" id="myvalue"     value='<%=myvalue%>'>		
		<input name="urlpath"     type="hidden" id="urlpath"     value="<%=urlpath%>">
		<input name="zd_is_pub"   type="hidden" id="zd_is_pub"   value="1">
		<input name="zd_isdone"   type="hidden" id="zd_isdone"   value="0">
		<input name="zd_catalog_no" type="hidden" id="zd_catalog_no"  value="700701">
		<input name="zd_clicked"    type="hidden" id="zd_clicked"  value="0">
		<input name="zd_comp_name"  type="hidden" id="zd_comp_name"  value="<%=comp_name%>">
		<input name="zd_mem_flag"  type="hidden" id="zd_mem_flag"  value="<%=mem_flag%>">
		<input name="zd_rent_mode" type="hidden" id="zd_rent_mode" value="<%=rent_mode%>">
		<input name="zd_shopid" type="hidden" id="zd_shopid" value="<%=shopid%>">		
		
	    <input name="zd_orderno" type="hidden" id="zd_orderno" />
		<input name="zd_orderno1" type="hidden" id="zd_orderno1" />
		<input name="pub_date_temp" type="hidden" id="pub_date_temp" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
		

		<input name="randflag" type="hidden" id="randflag" value="1" />     
</form>	 </div>
  </div>
</div>  
  <iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
refresh();

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
<script  language="javascript">
onloadAjax();
 </script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>

