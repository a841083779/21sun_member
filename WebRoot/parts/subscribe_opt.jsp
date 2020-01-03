<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(7);


//=====页面属性====

String type = Common.getFormatStr(request.getParameter("type"));
String pagename="subscribe_opt.jsp?type="+type;
String mypy="parts_subscribe";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));

//System.out.println("type="+type);

String urlpath="../parts/subscribe_opt.jsp?type="+type;
if(!myvalue.equals("")){
    if(type.equals("1")){
	   urlpath="../parts/subscribe_supply_list.jsp";
	}else if(type.equals("0")){
	   urlpath="../parts/subscribe_buy_list.jsp";
	}
}
String today= Common.getToday("yyyy-MM-dd",0);
String[][] tempInfo = DataManager.fetchFieldValue(pool, "parts_subscribe","count(*)", " mem_no='"+usern+"' and type ='"+type+"'");
String pubCount   = "0";
if(tempInfo!=null) {
  pubCount=Common.getFormatInt(tempInfo[0][0]);
}
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
var subCategory = new Array();


//为多选框赋值
function submityn(){	
		var pubCount = '<%=pubCount%>';
		var zd_type = document.getElementsByName('zd_type');
		
       	if(pubCount>=5){
              alert("您今天已创建了"+pubCount+"条订阅信息，已经达到最大数！");   
              return false; 
		}
		 if(zd_type.length==2 && zd_type[0].checked==false && zd_type[1].checked==false){
		    alert("请选择类别！");
			zd_type[0].focus();
			return false;
		}else if(document.theform.zd_name.value==""){
			alert("请输入订阅器名称！");
			document.theform.zd_name.focus();
			return false;
		}else if(document.theform.zd_category.value==""){
			alert("请选择产品分类！");
			document.theform.zd_category.focus();
			return false;
		}		
		if(document.theform.zd_price_start.value!=""){
			var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
			if(!reg.test(document.theform.zd_price_start.value)){
				alert("开始价格只能为数字！");
				document.theform.zd_price_start.focus();
				return false;
			}
		}
		if(document.theform.zd_price_end.value!=""){
			var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
			if(!reg.test(document.theform.zd_price_end.value)){
				alert("结束价格只能为数字！");
				document.theform.zd_price_end.focus();
				return false;
			}
		}
		if(document.theform.zd_price_start.value!="" && document.theform.zd_price_end.value!=""){
		   if(parseInt(document.theform.zd_price_start.value) >= parseInt(document.theform.zd_price_end.value)){
			 alert("结束价格必须大于开始价格！");
			 document.theform.zd_price_start.focus();
			 return false;
			}
		}
		document.theform.submit();
}
function checkNum(obj,flag){
	if(obj.value!=""){
		var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
		if(!reg.test(obj.value)){
			if(flag==1){
				alert("价格只能为数字！");
				obj.value="";
			}
			obj.select();
			return false;
		}
	}
}
function showType(obj){
  var is_urgent_show      = document.getElementById('is_urgent_show');
  var delivery_type_show  = document.getElementById('delivery_type_show');
  var price_start_show    = document.getElementById('price_start_show');
  var price_end_show      = document.getElementById('price_end_show');
  var typeSpan            = document.getElementById('typeSpan');
  var urlpath             = document.getElementById('urlpath');
  var parts_mode_show     = document.getElementById('parts_mode_show');
  var parts_certify_show  = document.getElementById('parts_certify_show');
  
  if(obj==0){        //求购信息
    is_urgent_show.style.display='';
	delivery_type_show.style.display='none';
	price_start_show.style.display='none';
	price_end_show.style.display='none';
	parts_mode_show.style.display='none';
	parts_certify_show.style.display='none';
	
	typeSpan.innerHTML='';
	typeSpan.innerHTML='求购';
	urlpath.value="../parts/subscribe_buy_list.jsp";
	f_iframeResize();
  }else if(obj==1){ //供应信息
    is_urgent_show.style.display='none';
	delivery_type_show.style.display='';
	price_start_show.style.display='';
	price_end_show.style.display='';
	parts_mode_show.style.display='';
    parts_certify_show.style.display='';
	
	typeSpan.innerHTML='';
	typeSpan.innerHTML='供应';
	urlpath.value="../parts/subscribe_supply_list.jsp";
	f_iframeResize();
  }
 }
 
 function setCategoryname(obj){
   document.getElementById("zd_categoryname").value=obj.options[obj.selectedIndex].text;
 }
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh"><%if(!myvalue.equals("")){%>更新<%}else{ %>创建<%} %><span id="typeSpan"><%=type.equals("0")?"求购":(type.equals("1")?"供应":"")%></span>订阅器</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。<span class="red">*</span> 为必填项<br>
　　　　　 最多只可以创建<font color="red"><b>5</b></font>条订阅信息，您已经创建了<font color="green"><b><%=pubCount %></b></font>条。</td>
      </tr>
    </table>
    <form action="opt_save_update_parts.jsp" method="post" name="theform" id="theform">
    <table width="95%" border="0" align="center" class="tablezhuce">
		 <tr>
          <td width="13%" class="right" nowrap="nowrap"><span class="red">*</span><span class="grayb">类　　别：</span></td>
          <td width="87%" height="22" class="list_cell_bg"><input type="radio" id="zd_type" name="zd_type" value="1" onClick="showType('1');" <%=type.equals("1")?"Checked":""%>>供应信息<input type="radio" id="zd_type" name="zd_type" value="0" onClick="showType('0');" <%=type.equals("0")?"Checked":""%>>求购信息</td>
        </tr>
        <tr>
          <td width="13%" nowrap="nowrap"  class="right"><span class="grayb"><span class="red">*</span>订阅器名称：</span></td>
          <td width="87%" height="22" class="list_cell_bg"><input name="zd_name" type="text" id="zd_name" size="20" maxlength="200" class="moren"  style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"></td>
        </tr>
        <tr>
          <td height="33" nowrap="nowrap"  class="right"><span class="red">*</span><span class="grayb">产品分类：</span></td>
          <td ><select name="zd_category" id="zd_category"  style="width:100px;"  class="blue1" onchange="setCategoryname(this);">
          		<option value="">请选择分类</option>
          	   	<cache:cache key="include_category1" cron="0 0/30 6-23 * * ?">
          		<%=Common.option_str(pool,"parts_catalog","num,name","parentid=0","",0) %>
          		</cache:cache>
            </select></td>
        </tr>
		 <tr>
          <td  class="right" nowrap="nowrap"><span class="grayb">规格型号：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_model" name="zd_model" value="" size="20" maxlength="60" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr>
		 <tr>
          <td class="right" nowrap="nowrap"><span class="grayb">新旧要求：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_old" name="zd_old" value="1">全新<input type="radio" id="zd_old" name="zd_old" value="0">二手</td>
        </tr>
		 <tr>
          <td class="right" nowrap="nowrap"><span class="grayb">是否正厂：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_original" name="zd_is_original" value="1">正厂<input type="radio" id="zd_is_original" name="zd_is_original" value="0">副厂</td>
        </tr>
		<tr>
          <td class="right" nowrap="nowrap" ><span class="grayb">省　　市：</span></td>
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
              <option value="">选择城市</option>
            </select>
            </span></td>
        </tr>		
		 <tr id="is_urgent_show" style="display:<%=type.equals("0")?"":"none"%>">
          <td class="right" nowrap="nowrap"><span class="grayb">是否紧急：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_urgent" name="zd_is_urgent" value="1">是<input type="radio" id="zd_is_urgent" name="zd_is_urgent" value="0">否</td>
        </tr>
		 <tr id="delivery_type_show" style="display:<%=type.equals("1")?"":"none"%>">
          <td class="right" nowrap="nowrap"><span class="grayb">供货方式：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_delivery_type" name="zd_delivery_type" value="1">现货<input type="radio" id="zd_delivery_type" name="zd_delivery_type" value="2">期货</td>
        </tr>
		
		 <tr id="parts_mode_show" style="display:<%=type.equals("1")?"":"none"%>">
          <td class="right" nowrap="nowrap"><span class="grayb">经营模式：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_parts_mode" name="zd_parts_mode" value="1">生产加工<input type="radio" id="zd_parts_mode" name="zd_parts_mode" value="2">代理经销<input type="radio" id="zd_parts_mode" name="zd_parts_mode" value="3">招商合作<input type="radio" id="zd_parts_mode" name="zd_parts_mode" value="4">其它</td>
        </tr>
		 <tr id="parts_certify_show" style="display:<%=type.equals("1")?"":"none"%>">
          <td class="right" nowrap="nowrap"><span class="grayb">诚信认证：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="zd_parts_certify" name="zd_parts_certify" value="1">通过<input type="radio" id="zd_parts_certify" name="zd_parts_certify" value="2">未通过</td>
        </tr>		
		<tr id="price_start_show" style="display:<%=type.equals("1")?"":"none"%>">
          <td  class="right" nowrap="nowrap"><span class="grayb">开始价格：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_price_start" name="zd_price_start" value="" size="20" maxlength="60" onKeyUp="checkNum(this,1)" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr>
		 <tr id="price_end_show" style="display:<%=type.equals("1")?"":"none"%>">
          <td  class="right" nowrap="nowrap"><span class="grayb">结束价格：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="zd_price_end" name="zd_price_end" value="" size="20" maxlength="60" onKeyUp="checkNum(this,1)" class="moren" style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/></td>
        </tr> 
		<tr>
		<td  class="right" nowrap="nowrap"><span class="grayb">验 证 码：</span></td>
          <td height="22" class="list_cell_bg">
		  <input type="text" id="rand" name="rand" value="" size="20" maxlength="20"  class="moren"  style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"/>
            <img src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/>		  </td>
        <tr>
          <td nowrap="nowrap" class="right">&nbsp;</td>
          <td class="right"><input type="button" name="Submit" value="发 布" style="cursor:pointer" class="tijiao" onclick="submityn()"/></td>
        </tr>
			<input name="zd_id" type="hidden" id="zd_id" value="0" />
			<input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
			<input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=usern%>" />
			<input name="zd_mem_name" type="hidden" id="zd_mem_name" value="<%=realname%>" />
			<input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
			<input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
			<input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
			<input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
			<input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
			<input name="randflag" type="hidden" id="randflag" value="1" />
			<input name="zd_categoryname" type="hidden" id="zd_categoryname" />	
			<input name="zd_email" type="hidden" id="zd_email" value="<%=email1%>"/>
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
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>

</body>
</html>