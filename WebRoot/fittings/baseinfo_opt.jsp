<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%
pool = new PoolManager(9);
//=====页面属性====
String pagename="baseinfo_opt.jsp";
String mypy="fittings_data_basic";
String titlename="";
//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));
String urlpath="baseinfo_opt.jsp";

if(!myvalue.equals("")){
    urlpath=urlpath+"?myvalue="+java.net.URLEncoder.encode(myvalue,"UTF-8");  
   //需要编码 才能将加密后产生的特殊字符 例如：将 +  转码成 %2B
}

String  mem_no ="";
HashMap memberInfo = new HashMap();
if(session.getAttribute("memberInfo")!=null){   
   memberInfo = (HashMap) session.getAttribute("memberInfo");
   mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号   
}
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
<style type="text/css">
	input.moren{vertical-align:middle;line-height:11px;padding:1px 1px; 0;font:12px arial;float:left;margin:0;border:1px solid #B8CFE0;color:#676767;background:#F7FBFF;}
</style>
<script>
 var pubCount=0;
 function onloadAjax(){
		$.ajax({
		type: "POST",
		url: "../manage/countpub.jsp",
		data: "tablename=<%=mypy%>&poolnum=9&mem_no=<%=mem_no%>",
		success: function(msg){ 
		      	pubCount = $.trim(msg);	
				document.getElementById("spanPubCount").innerText=pubCount;
				if(pubCount>=30){	
					document.getElementById("submitId").disabled=true;				
					alert("您今天已发布了"+pubCount+"条配套合作信息，已经达到最大发布数,自动跳转至列表页！");
					window.location.href="cooperation_list.jsp";
				}
			} 
		}); 
	}
//为多选框赋值
function submityn(){			
		if(returnRadio("zd_fittings_machine_sort")==false){
			alert("请选择配套整机类别！");
			return false;			
		}if(returnRadio("zd_fittings_machine_model")==false){
			alert("请选择配套机型！");
			return false;			
		}if(returnRadio("zd_part_sort")==false){
			alert("请选择配件类型！");
			return false;			
		}else if(theform.zd_fittings_company.value==""){
			alert("请输入配套厂家！");
			theform.zd_fittings_company.focus();
			return false;
		}else if(theform.zd_fittings_agent_count.value=="" || isNaN(theform.zd_fittings_agent_count.value)){
			alert("配套件销售代理商数量必须为数字类型！");
			theform.zd_fittings_agent_count.focus();
			return false;
		}//else if(theform.rand.value==""){
			//alert("验证码不能为空！");
			//theform.rand.focus();
			//return false;
		//}
			
		document.theform.submit();
}
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">发布配套件基本信息</span>
		  &nbsp;&nbsp;<strong style="cursor:pointer;"> <a href="/fittings/baseinfo_list.jsp">>>返回</a></strong></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>配套件基本信息是配套件数据提交的基础，请您详细、完整的填写以下表单。<span class="red">*</span> 为必填项<br />
          <!--每天发布信息量最多只可以发布<font color="red"><b>30</b></font>条，-->
          <!--您今天已经发布了<font color="green"><b><span id="spanPubCount"></span></b></font>条。--></td>
      </tr>
    </table>
    <table width="95%" border="0" align="center" class="tablezhuce">
      <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
		<tr>
          <td  class="right"nowrap="nowrap"><span class="red">*</span> <span class="grayb">配套整机类别：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="fittings_machine_sort1" name="zd_fittings_machine_sort" value="挖掘机" /style="border:0";>
            挖掘机
            <input type="radio" id="fittings_machine_sort2" name="zd_fittings_machine_sort" value="装载机" style="border:0";/>
            装载机
            <input type="radio" id="fittings_machine_sort3" name="zd_fittings_machine_sort" value="起重机" style="border:0";/>
            起重机</td>
        </tr>
		<tr>
          <td  class="right"nowrap="nowrap"><span class="red">*</span> <span class="grayb">配套机型：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="fittings_machine_model1" name="zd_fittings_machine_model" value="6T（含）以下" /style="border:0";>
            6T（含）以下
            <input type="radio" id="fittings_machine_mode2" name="zd_fittings_machine_model" value="6-13T（含）" style="border:0";/>
            6-13T（含）
            <input type="radio" id="fittings_machine_mode3" name="zd_fittings_machine_model" value="13-20T（不含）" style="border:0";/>
            13-20T（不含）
			<input type="radio" id="fittings_machine_mode4" name="zd_fittings_machine_model" value="20（含）-25T（含）" /style="border:0";>
            20（含）-25T（含）<br />
            <input type="radio" id="fittings_machine_mode5" name="zd_fittings_machine_model" value="25-30T（含）" style="border:0";/>
            25-30T（含）
            <input type="radio" id="fittings_machine_mode6" name="zd_fittings_machine_model" value="30T以上" style="border:0";/>
            30T以上</td>
        </tr>
		<tr>
          <td  class="right"nowrap="nowrap"><span class="red">*</span> <span class="grayb">配件类型：</span></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="part_sort1" name="zd_part_sort" value="主泵" /style="border:0";>
            主泵
            <input type="radio" id="part_sort2" name="zd_part_sort" value="主阀" style="border:0";/>
            主阀
            <input type="radio" id="part_sort3" name="zd_part_sort" value="回转装置" style="border:0";/>
            回转装置
			<input type="radio" id="part_sort4" name="zd_part_sort" value="行走装置" /style="border:0";>
            行走装置
            <input type="radio" id="part_sort5" name="zd_part_sort" value="油缸" style="border:0";/>
            油缸
            <input type="radio" id="part_sort6" name="zd_part_sort" value="发动机总成" style="border:0";/>
            发动机总成
			<input type="radio" id="part_sort7" name="zd_part_sort" value="驾驶室" style="border:0";/>
            驾驶室<br />
			<input type="radio" id="part_sort8" name="zd_part_sort" value="座椅" /style="border:0";>
            座椅
            <input type="radio" id="part_sort9" name="zd_part_sort" value="履带总成" style="border:0";/>
            履带总成
            <input type="radio" id="part_sort10" name="zd_part_sort" value="电器系统" style="border:0";/>
            电器系统</td>
        </tr>
        <tr>
          <td nowrap="nowrap"  class="right"><span class="red">*</span> <span class="grayb">配套厂家：</span></td>
          <td ><input name="zd_fittings_company" type="text" id="zd_fittings_company" maxlength="250" size="75" class="moren"><br />注：如有多个厂家时，请以英文逗号间隔“,”</td>
        </tr>
		<tr>
          <td nowrap="nowrap"  class="right"><span class="red">*</span> <span class="grayb">配套件销售代理商数量：</span></td>
          <td ><input name="zd_fittings_agent_count" type="text" id="zd_fittings_agent_count" maxlength="9" size="20" class="moren"></td>
        </tr>
		<!--
		<tr>
          <td  class="right" nowrap="nowrap"><span class="grayb">验 证 码：</span></td>
          <td height="22" class="list_cell_bg"><input type="text" id="rand" name="rand" value="" size="20" maxlength="10"/>
            &nbsp;<img height="19px" src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/> </td>
        </tr>
		-->
        <tr>
          <td nowrap="nowrap" class="right">&nbsp;</td>
          <td class="right"><input id="submitId" type="button" name="Submit" value="发 布" class="tijiao" style="cursor:pointer"  onClick="submityn()"/>
		  </td>
        </tr>
        <input name="zd_id" type="hidden" id="zd_id" value="0" />
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
        <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
        <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
        <input name="randflag" type="hidden" id="randflag" value="1" />
        <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=Common.getFormatStr((String)adminInfo.get("mem_no"))%>" />
		<input name="zd_no" type="hidden" id="zd_no" value="<%=Common.generateDateRandom()%>" />
	 </form>
    </table>
  </div>
</div>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script language="javascript">
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
//refresh();

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
function f_frameStyleResize(targObj)   
{   
  var   targWin   =   targObj.parent.document.all[targObj.name]; 
  if(targWin   !=   null)   
  {   
  var   HeightValue   =   targObj.document.body.scrollHeight   
  if(HeightValue   <100){HeightValue   =490}   //不小于540  
   targWin.height   =   HeightValue;
  }   
}  
function   f_iframeResize()   
{
  f_frameStyleResize(self);
}  
window.onload=f_iframeResize;
//onloadAjax();
 </script>
</body>
</html>
