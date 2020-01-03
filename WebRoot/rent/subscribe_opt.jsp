<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(3);


//=====页面属性====

String type = Common.getFormatStr(request.getParameter("type"));
String pagename="subscribe_opt.jsp?type="+type;
String mypy="rent_subscribe";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));

//System.out.println("type="+type);

String urlpath="../rent/subscribe_opt.jsp?myvalue="+myvalue;
String today= Common.getToday("yyyy-MM-dd",0);
String[][] tempInfo = DataManager.fetchFieldValue(pool, "rent_subscribe","count(*)", " mem_no='"+usern+"' and type ='"+type+"'");
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
//为多选框赋值
function submityn(){	
		var pubCount = '<%=pubCount%>';
		var zd_type = document.getElementsByName('zd_type');
		
       	if(pubCount>=5){
              alert("您今天已创建了"+pubCount+"条订阅信息，已经达到最大数！");   
              return false; 
		}
		if(document.theform.zd_name.value==""){
			alert("请输入订阅器名称！");
			document.theform.zd_name.focus();
			return false;
		}
		$("#zd_categoryname").val($("select[name='zd_category'] option[selected]").text().replaceAll("\u00a0",""));
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

</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh"><%if(!myvalue.equals("")){%>更新<%}else{ %>创建<%} %>订阅器</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="mainyh"><a href="./subscribe_list.jsp">管理我的订阅</a></span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。<span class="red">*</span> 为必填项<br>
　　　　　 最多只可以创建<font color="red"><b>5</b></font>条订阅信息，您已经创建了<font color="green"><b><%=pubCount %></b></font>条。</td>
      </tr>
    </table>
    <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
    <table width="95%" border="0" align="center" class="tablezhuce">
        <tr>
          <td width="13%" nowrap="nowrap"  class="right"><span class="grayb"><span class="red">*</span>商机订阅器：</span></td>
          <td width="87%" height="22" class="list_cell_bg"><input name="zd_name" type="text" id="zd_name" size="20" maxlength="200" class="moren"  style="vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial"></td>
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
		<tr>
		  <td class="right" nowrap="nowrap" ><span class="grayb">类　　别：</span></td>
		  <td height="22" ><select name="zd_category" id="zd_category">
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
                  </select><input name="zd_categoryname" id="zd_categoryname" type="hidden" /></td>
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