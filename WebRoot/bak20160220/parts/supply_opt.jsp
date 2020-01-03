<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(7);
	PoolManager pool1 = new PoolManager(1);
//=====页面属性====
String pagename="supply_opt.jsp";
String mypy="supply";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));

String urlpath="../parts/supply_opt.jsp";
if(!myvalue.equals("")){
	//urlpath="../parts/supply_list.jsp";
	urlpath=urlpath+"?myvalue="+java.net.URLEncoder.encode(myvalue,"UTF-8");  
}

HashMap userInfo = (HashMap)request.getSession().getAttribute("memberInfo");
//公司名称
String session_comp_name = Common.getFormatStr((String)userInfo.get("comp_name"));
String session_qq = Common.getFormatStr((String)userInfo.get("qq"));
String session_mem_flag = Common.getFormatStr((String)userInfo.get("mem_flag"));
String session_mem_no = Common.getFormatStr((String)userInfo.get("mem_no"));
String session_per_phone = Common.getFormatStr((String)userInfo.get("per_phone"));
String session_parts_storecategory = Common.getFormatStr((String)userInfo.get("parts_storecategory"));

if(session_comp_name.equals("-9999")) session_comp_name="";
if(session_qq.equals("-9999")) session_qq="";
if(session_mem_flag.equals("-9999")) session_mem_flag="";
if(session_mem_no.equals("-9999")) session_mem_no="";
if(session_per_phone.equals("-9999")) session_per_phone="";
if(session_parts_storecategory.equals("-9999"))session_parts_storecategory.equals("");


%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
 var pubCount=0;
 function onloadAjax(){
		$.ajax({
		type: "POST",
		url: "../manage/countpub.jsp",
		data: "tablename=supply&poolnum=7&mem_no=<%=session_mem_no%>",
		success: function(msg){ 
		      	pubCount = $.trim(msg);	
				document.getElementById("spanPubCount").innerText=pubCount;						
				if(pubCount>=5){
					///document.getElementById("submitId").disabled=true;				
					alert("您今天已发布了"+pubCount+"条配件供应信息，已经达到最大发布数,自动跳转至列表页！");
					window.location.href="../parts/supply_list.jsp";
				}
			} 
		}); 
 }
</script>
<script>
var subCategory = new Array();
<cache:cache key="cache_subcategory" cron="0 0/30 6-23 * * ?">
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
		if(subCategory[i][0].length>3 && subCategory[i][0].substring(0,3)==obj.value){
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
		var mem_flag='<%=session_mem_flag%>';     
		if(mem_flag==-1 && pubCount>=5){
              alert("您今天已发布了"+pubCount+"条租赁信息，已经达到最大发布数！");   
              return false; 
		}
		if(document.theform.zd_brand.value==""){
			alert("请选择品牌！");
			document.theform.zd_brand.focus();
			return false;
		}else if(document.theform.zd_parts_no.value==""){
			alert("请输入配件编号！");
			document.theform.zd_parts_no.focus();
			return false;
		}else if(document.theform.zd_parts_name.value==""){
			alert("请输入配件名称！");
			document.theform.zd_parts_name.focus();
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
		}else if(document.theform.zd_model.value==""){
			alert("请填写规格型号！");
			document.theform.zd_model.focus();
			return false;
		}else if($("#zd_img1").val()==""){
			alert("请上传配件图片！");
			$("#zd_img1").focus();
			return false;				
		}
		if(document.theform.zd_price.value!=""){
			var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
			if(!reg.test(document.theform.zd_price.value)){
				alert("价格只能为数字！");
				return false;
			}
		}
		if(document.theform.zd_amount.value!=""){
			var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
			if(!reg.test(document.theform.zd_amount.value)){
				alert("数量只能为数字！");
				return false;
			}
		}
		
		var zd_brandname    = document.theform.zd_brandname.value;
		var zd_categoryname = document.theform.zd_categoryname.value;
		var zd_subcategory  = document.getElementById("zd_subcategory").options[window.document.getElementById("zd_subcategory").selectedIndex].text;
		var zd_parts_name   = document.theform.zd_parts_name.value;
		var zd_model = document.theform.zd_model.value;				
		document.theform.zd_title.value=zd_brandname+zd_categoryname+zd_subcategory+zd_model+zd_parts_name;	
		
		if(obj=='submit'){
		 document.theform.action="opt_save_update_parts.jsp";
		 document.theform.target='_self';
		 document.theform.submit();
		}else if(obj=='preview'){
		  return 'preview';
		}
}
function checkNum(obj,flag){
	if(obj.value!=""){
		var reg = /^[-+]?[0-9]*\.?[0-9]+$/;    //只能为整数
        var reg1= /^(\+|\-)?(\d)+(\.)?(\d)*$/; //可以为小数
		if(flag==1){			
			if(!reg1.test(obj.value)){
				obj.value="";
				obj.select();
				return false;
			 }
		}else{
		     if(!reg.test(obj.value)){
				obj.value="";
				obj.select();
				return false;
			 }
		}			
	}
}
function brandChange(obj){
	document.getElementById("zd_brandname").value=obj.options[obj.selectedIndex].text;
}
function setLetter(obj){
	$.ajax({
		url:"setLetter.jsp?letter="+encodeURIComponent(obj.value),
		type:"get",
		success:function(mess){
			document.getElementById("zd_letters").value=mess;
		},
		error:function(){
			alert("发生错误！");
		}
	});
}
function preview(){
  if(submityn('preview')=='preview'){   
 
 //document.theform.action="http://192.168.20.167:9123/supply/supplypreview.jsp";
  document.theform.action="http://www.21-part.com/sale/supplypreview.jsp";
 
  document.theform.target="_blank";
  document.theform.submit();   
  }
}
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh"><%if(!myvalue.equals("")){%>更新<%}else{ %>发布<%} %>配件供应</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机，<span class="red">*</span> 为必填项。<br>
		信息发布后，系统需审核，15分钟左右发布。<%if(session_mem_flag.equals("-1")){%> 您现在是免费会员，每天最多可发布5条供应信息，您今天已经发布了<font color="green"><b><span id="spanPubCount"></span></b></font>条。您可以<a href="http://www.21-sun.com/service/huiyuan/index.htm" target="_blank"><font color="#FF0000">升级会员</font></a>，获得更多服务<%}%></td>
      </tr>
    </table>
    <form action="opt_save_update_parts.jsp" method="post" name="theform" id="theform">
    <table width="95%" border="0" align="center" class="tablezhuce">
        <tr>
          <td width="18%" nowrap="nowrap"  class="right"><span class="grayb"><span class="red">*</span> 品　　牌：</span></td>
          <td width="82%" height="22" class="list_cell_bg">
          	<select name="zd_brand" id="zd_brand" onchange="brandChange(this)" class="blue1" style="width:133px">
          		<option value="">请选择品牌</option>
				<option value="630">CVPK</option>
				<option value="618">DCF</option>
				<option value="584">FAG</option>
				<option value="616">HOLSET</option>
				<option value="617">IHI</option>
				<option value="585">IKO</option>
				<option value="177">JCB</option>
				<option value="619">KMP</option>
				<option value="542">KOYO</option>
				<option value="583">NSK日本精工</option>
				<option value="541">NTN</option>
				<option value="540">OEM</option>
				<option value="586">SKF</option>
				<option value="482">阿特拉斯·科普柯</option>
				<option value="402">艾迪</option>
				<option value="604">艾里逊</option>
				<option value="565">爱德特</option>
				<option value="600">博世力士乐</option>
				<option value="148">常林股份</option>
				<option value="581">川崎</option>
				<option value="171">大信重工</option>
				<option value="551">大宇</option>
				<option value="212">戴纳派克</option>
				<option value="607">丹尼逊</option>
				<option value="611">道依茨</option>
				<option value="151">德工</option>
				<option value="213">德玛格</option>
				<option value="554">第一油压</option>
				<option value="140">鼎盛</option>
				<option value="549">东风日产</option>
				<option value="405">东空</option>
				<option value="553">东明国际</option>
				<option value="621">东洋</option>
				<option value="163">东岳重工</option>
				<option value="192">斗山</option>
				<option value="671">方圆集团</option>
				<option value="628">弗列加</option>
				<option value="570">福格勒</option>
				<option value="141">福田雷沃</option>
				<option value="164">抚挖</option>
				<option value="615">盖瑞特</option>
				<option value="620">古河</option>
				<option value="160">广西开元</option>
				<option value="625">海兰德</option>
				<option value="560">韩国斗源</option>
				<option value="559">韩国元映</option>
				<option value="613">韩国正品</option>
				<option value="568">韩泰克</option>
				<option value="535">汉力士</option>
				<option value="158">合力</option>
				<option value="202">鸿得利</option>
				<option value="206">华力重工</option>
				<option value="189">加藤</option>
				<option value="622">建华</option>
				<option value="601">杰克赛尔</option>
				<option value="172">晋工</option>
				<option value="187">久保田</option>
				<option value="197">酒井</option>
				<option value="550">卡特</option>
				<option value="174">卡特彼勒</option>
				<option value="610">凯捷</option>
				<option value="455">凯斯</option>
				<option value="538">康明斯</option>
				<option value="594">雷沃</option>
				<option value="412">力博士</option>
				<option value="157">力士德</option>
				<option value="626">立丰</option>
				<option value="179">利勃海尔</option>
				<option value="203">辽宁海诺</option>
				<option value="137">临工</option>
				<option value="136">柳工</option>
				<option value="135">龙工</option>
				<option value="207">陆德筑机</option>
				<option value="543">律奥</option>
				<option value="556">洛建</option>
				<option value="616">洛阳一拖</option>
				<option value="612">曼牌</option>
				<option value="8889">马勒MAHLE</option>
				<option value="200">南方路机</option>
				<option value="629">珀金斯</option>
				<option value="627">派克</option>
				<option value="199">普茨迈斯特</option>
				<option value="198">全进重工</option>
				<option value="184">日立</option>
				<option value="548">日野</option>
				<option value="624">锐泰</option>
				<option value="609">瑞恩</option>
				<option value="558">赛地</option>
				<option value="547">三菱</option>
				<option value="133">三一</option>
				<option value="138">山工</option>
				<option value="142">山河智能</option>
				<option value="591">山猫</option>
				<option value="144">山推</option>
				<option value="999">山特维克</option>
				<option value="152">山重建机</option>
				<option value="596">神刚</option>
				<option value="183">神钢</option>
				<option value="211">施维英</option>
				<option value="190">石川岛</option>
				<option value="606">史丹利</option>
				<option value="404">泰戈</option>
				<option value="406">泰科</option>
				<option value="603">汤姆洛克</option>
				<option value="602">唐纳森</option>
				<option value="176">特雷克斯</option>
				<option value="608">铁姆肯</option>
				<option value="210">拓能重机</option>
				<option value="614">万邦重科</option>
				<option value="214">维特根</option>
				<option value="588">潍柴</option>
				<option value="149">沃得重工</option>
				<option value="175">沃尔沃</option>
				<option value="546">五十铃</option>
				<option value="139">厦工</option>
				<option value="552">先进重工</option>
				<option value="193">现代</option>
				<option value="182">小松</option>
				<option value="209">徐工</option>
				<option value="154">宣工</option>
				<option value="191">洋马</option>
				<option value="161">移山</option>
				<option value="1079">英格索兰</option>
				<option value="143">宇通重工</option>
				<option value="146">玉柴</option>
				<option value="195">詹阳动力</option>
				<option value="134">中联</option>
				<option value="188">竹内</option>
				<option value="185">住友</option>
				<option value="haite">海特</option>
				<option value="FNM">FNM</option>
				<option value="other">其它品牌</option>
			</select>
       	  <input type="hidden" name="zd_brandname" id="zd_brandname"/>          </td>
        </tr>
        <tr>
          <td height="33" nowrap="nowrap"  class="right"><span class="red">*</span> <span class="grayb">配件编号：</span></td>
          <td ><input name="zd_parts_no" type="text" id="zd_parts_no" size="20" maxlength="200" class="moren"  style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"></td>
        </tr>
        <tr>
          <td  class="right" nowrap="nowrap"><span class="red">*</span> <span class="grayb">配件名称：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_parts_name" name="zd_parts_name" value="" size="20" maxlength="60" class="moren" onblur="setLetter(this)" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr> 
		<tr>
          <td class="right" nowrap="nowrap" ><span class="red">*</span> <span class="grayb">省　　市：</span></td>
          <td height="22" ><select name="zd_province" id="zd_province" onchange="set_city(this,this.value,document.theform.zd_city,'');" style="width:100px;" class="blue1">
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
            <select  name="zd_subcategory" id="zd_subcategory" style="width:100px;" class="blue1" onchange="set_subcategoryname(this);">
              <option>选择子分类</option>
            </select>
            <input type="hidden" name="zd_categoryname"    id="zd_categoryname"/>
   		    <input type="hidden" name="zd_subcategoryname" id="zd_subcategoryname"/>			
            </span></td>
        </tr>	
		<%
		     String[] parts_storecategory_arr = null;
			 String parts_storecategory_temp="";
			if(session_mem_flag.equals("1010") && !session_parts_storecategory.equals("") && !session_parts_storecategory.equals("|;|;|;|;|;")){
		%>		
		 <tr>
          <td  class="right" nowrap="nowrap"><span class="grayb">专卖店产品分类：</span></td>
          <td height="22" class="list_cell_bg"><select name="zd_parts_storecategory" id="zd_parts_storecategory" style="width:100px;" class="blue1"><option>选择分类</option>
		  <%
		  				
			  parts_storecategory_arr = session_parts_storecategory.split(";");
			  for(int i=0;i<parts_storecategory_arr.length;i++){
			   parts_storecategory_temp = Common.getFormatStr(parts_storecategory_arr[i]);
			   if(!parts_storecategory_temp.equals("") && !parts_storecategory_temp.equals("|")){
		  %>
			<option value="<%=parts_storecategory_temp%>"><%=parts_storecategory_temp%></option>
		  <%
		          }
			    }			 
		  %>
		  </select>（将在专卖店中显示）</td>
        </tr>
		<%}%>
        <tr>
          <td  class="right" nowrap="nowrap"><span class="red">*</span><span class="grayb">规格型号：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_model" name="zd_model" value="" size="20" maxlength="60" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr>
        <tr>
          <td  class="right" nowrap="nowrap"><span class="grayb">适用机型：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_scope" name="zd_scope" value="" size="20" maxlength="60" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr>
        <tr>
          <td  class="right" nowrap="nowrap"><span class="grayb">价　　格：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_price" name="zd_price" value="" size="20" maxlength="60" onKeyUp="checkNum(this,1)" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr>
		<tr>
          <td  class="right" nowrap="nowrap"><span class="grayb">数　　量：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_amount" name="zd_amount" value="" size="20" maxlength="60" onKeyUp="checkNum(this,2)" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr>        
        <tr>
          <td class="right" nowrap="nowrap" ><span class="red">*</span><span class="grayb">图　　片：</span></td>
          <td >
          	<input name="zd_img1" id="zd_img1" type="hidden" value="" /><input name="zd_img1_1" id="zd_img1_1" type="hidden" value="" />
		<span id="txt_zd_img1"></span><span id="ifr_zd_img1">
		<iframe id="ifr2_zd_img1" scrolling="no" frameborder="0" width="100%" height="28"src="http://resource.21-sun.com/web_upload_files_for_smallpic.jsp?nurl=<%=request.getServerName() + ":"
		+ request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_img1&smallpic=zd_img1_1"></iframe>
		</span><br />
		带有图片的供应信息将获得配件网首页推荐,建议上传80～180K左右的图片</td>
        </tr>
		   <tr>
          <td class="right" nowrap="nowrap"><span class="grayb">产　　地：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_place1" name="zd_place" value="0">国内<input type="radio" id="zd_place1" name="zd_place" value="1">国外</td>
        </tr>
		  <tr>
          <td  class="right" nowrap="nowrap" ><span class="grayb">供货方式：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_delivery_type" name="zd_delivery_type" value="1" checked="checked" style="border:0";/>
            现货
            <input type="radio" id="zd_delivery_type" name="zd_delivery_type" value="2" style="border:0";/>
            期货 </td>
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
          <td class="right" nowrap="nowrap"><span class="grayb">有效日期：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_pubdays" name="zd_pubdays" value="7" style="border:0";/>
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
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_show1" name="zd_is_pub" value="1" checked="checked" style="border:0";/>
            是
            <input type="radio" id="zd_is_show2" name="zd_is_pub" value="2" style="border:0";/>
            否 </td>
        </tr>
		-->
        <tr>
          <td  class="right" nowrap="nowrap"><span class="grayb">联系电话：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_telephone" name="zd_telephone" value="<%=session_per_phone%>" size="20" maxlength="60" class="moren"  style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr>
        <tr>
          <td class="right" nowrap="nowrap" ><span class="grayb">描　　述：</span></td>
          <td height="22" class="list_cell_bg"><textarea name="zd_content" cols="60" rows="6" id="zd_content" onKeyUp="if((this.value).length&gt;300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}" style="overflow-y:scroll;"></textarea></td>
        </tr>
		<tr>
		<td  class="right" nowrap="nowrap"><span class="grayb">验 证 码：</span></td>
          <td height="22" class="list_cell_bg">
		  <input type="text" id="rand" name="rand" value="" size="20" maxlength="20"  class="moren"  style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/>
            <img src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/>		  </td>
        <tr>
          <td nowrap="nowrap" class="right">&nbsp;</td>
          <td class="right"><input type="button" name="Submit" value="发 布" style="cursor:pointer;margin-right:15px" class="tijiao" onclick="submityn('submit')"/><input type="button" name="mit" value="预 览" style="cursor:pointer" class="tijiao" onclick="preview();"/></td>
        </tr>
		<input name="zd_id" type="hidden" id="zd_id" value="0" />
            <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
            <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=usern %>" />
			<input name="zd_pubdate" type="hidden" id="zd_pubdate"  value="<%=Common.getToday("yyyy-MM-dd",0)%>" />
			<input name="zd_add_date" type="hidden" id="zd_add_date"  value="<%=Common.getToday("yyyy-MM-dd",0)%>" />
            <input name="zd_mem_name" type="hidden" id="zd_mem_name" value="<%=realname %>" />
			<input name="zd_qq" type="hidden" id="zd_qq" value="<%=session_qq%>" />			
            <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
            <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
            <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
            <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
            <input name="randflag" type="hidden" id="randflag" value="1" />
            <input name="zd_letters" type="hidden" id="zd_letters" value="" />
			<input name="zd_parts_mode" type="hidden" id="zd_parts_mode" value="<%=Common.getFormatStr((String)adminInfo.get("parts_mode"))%>" />
	        <input name="zd_parts_certify" type="hidden" id="zd_parts_certify" value="<%=Common.getFormatStr((String)adminInfo.get("parts_certify"))%>" />
			<input name="zd_comp_name" type="hidden" id="zd_comp_name" value="<%=session_comp_name%>" />
			<input name="zd_title" type="hidden" id="zd_title" value=""/>
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
var session_mem_flag = '<%=session_mem_flag%>';
if(session_mem_flag==-1){ 
  onloadAjax();
}
 </script>
</body>
</html>