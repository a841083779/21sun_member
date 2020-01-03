<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%

PoolManager pool1 = new PoolManager(1);
//=====页面属性====

String mypy="buy";
String myvalue ="";
//====得到参数====

String urlpath="/usedbuy/buy.jsp";


String  zd_category = Common.getFormatStr(request.getParameter("zd_category"));
String  flag        = Common.getFormatStr(request.getParameter("flag"));


String zd_mem_no   ="";
String zd_mem_name ="";
String zd_telephone="";
String zd_email    ="";
String zd_province ="";
String zd_city     ="";
String zd_address  ="";

ArrayList userlist=Common.getMemberInfoList("mem_no,mem_name,per_phone,per_email,per_province,per_city,comp_address", pool1,request,"member_info", "mem_no","passw", "memberInfo");

if(userlist!=null&&userlist.size()==7)
{zd_mem_no=Common.getFormatStr(userlist.get(0));
 zd_mem_name=Common.getFormatStr(userlist.get(1));
 zd_telephone=Common.getFormatStr(userlist.get(2));
 zd_email=Common.getFormatStr(userlist.get(3));
 zd_province=Common.getFormatStr(userlist.get(4));
 zd_city=Common.getFormatStr(userlist.get(5));
 zd_address=Common.getFormatStr(userlist.get(6));
}

try{   //====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link rel="stylesheet" href="../style/homestyle.css" type="text/css">
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/Validator.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>

</head>
<body>
 <form action="buy_action.jsp" method="post" name="theform" id="theform" onSubmit="return Validator.Validate(this,2)">
   <div align="center">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="p92 st1" >
		 <%
		   if(!flag.equals("no")){
		 %>
		 <tr>
			<td colspan="2" height="19" style="background:url(images/qg_01.jpg) repeat-x; height:26px; line-height:26px;">			
			<p class="141"><b><font color="#0080FF" size="3">&nbsp;&nbsp;我要发布二手设备求购信息</font></b>&nbsp;&nbsp;带<font color="#FF0000">*</font>的必须填写</p>
		  </td>
		</tr>
		<%}else{%>
			<tr>
				<td colspan="2" height="19" bgcolor="#F0F0F0">			
				<p align="right" class="141"></p>
			  </td>
			</tr>
		 <%}%>		
		 <tr>
    <td width="15%" height="25" bgcolor="#FFFFFF" align="right">标题：<font color="#FF0000">*</font></td>                             
    <td width="85%" height="25" bgcolor="#FFFFFF"><input name="zd_title" type="text"  id="zd_title" value="" size="40" maxlength=20 dataType="Require" msg="标题不能为空"></td>
    </tr>
	<tr>
    <td width="15%" valign="top" height="25" bgcolor="#F3FAFF" align="right">产品类别：<font color="#FF0000">*</font></td>
    <td width="85%" height="25" bgcolor="#F3FAFF"><select name="zd_category" id="zd_category" class="validate-selection" dataType="Require"  msg="产品类别不能为空">
				<option value="">--请选择类别--</option>
				<option value="1" <%=zd_category.equals("1")?"selected":""%>> 挖掘机 </option>
				<option value="2" <%=zd_category.equals("2")?"selected":""%>> 装载机 </option>
				<option value="3" <%=zd_category.equals("3")?"selected":""%>> 起重机 </option>
				<option value="4" <%=zd_category.equals("4")?"selected":""%>> 压路机 </option>
				<option value="5" <%=zd_category.equals("5")?"selected":""%>> 推土机 </option>
				<option value="6" <%=zd_category.equals("6")?"selected":""%>> 摊铺机 </option>
				<option value="7" <%=zd_category.equals("7")?"selected":""%>> 平地机 </option>
				<option value="8" <%=zd_category.equals("8")?"selected":""%>> 混凝土</option>
				<option value="9" <%=zd_category.equals("9")?"selected":""%>> 叉车 </option>         
				<option value="other" <%=zd_category.equals("other")?"selected":""%>> 其他设备 </option>				
		</select></td>
    </tr>
	 <tr>
    <td width="15%" valign="top" height="25" bgcolor="#FFFFFF" align="right">所在地：<font color="#FF0000">*</font><font color="#FF0000">&nbsp;</font></td>
    <td width="85%" height="25" bgcolor="#FFFFFF">
		<select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:100px;"  class="validate-selection" dataType="Require"  msg="所在省份不能为空">
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
        <select  name="zd_city" id="zd_city"  style="width:100px;" dataType="Require"  msg="所在城市不能为空">
          <option value="">选择城市</option>
        </select>
	</td>
    </tr>
	<tr>	
		<td width="15%" height="25" bgcolor="#F3FAFF" align="right">求购人：<font color="#FF0000">*</font></td>
		<td width="85%" height="25" bgcolor="#F3FAFF"><input name="zd_mem_name" type="text" id="zd_mem_name" value="<%=zd_mem_name%>" size="40" maxlength=10 dataType="Require" msg="求购人不能为空">
		</td>
	</tr>
		<tr>	
		<td width="15%" height="25" bgcolor="#FFFFFF" align="right">地址：<font color="#FF0000">*</font></td>
		<td width="85%" height="25" bgcolor="#FFFFFF"><input name="zd_address" type="text" id="zd_address" value="<%=zd_address%>" size="40" maxlength=10 dataType="Require" msg="地址不能为空">
		</td>
	</tr>
	<tr>
		<td width="15%" height="25" bgcolor="#F3FAFF" align="right">电话：<font color="#FF0000">*</font></td>                             
		<td width="85%" height="25" bgcolor="#F3FAFF"><input name="zd_telephone" type="text"  id="zd_telephone" value="<%=zd_telephone%>" size="40" maxlength=20 dataType="Require" msg="电话不能为空"></td>
	</tr>
		<tr>	
		<td width="15%" height="25" bgcolor="#FFFFFF" align="right">邮箱：<font color="#FF0000">*</font></td>
		<td width="85%" height="25" bgcolor="#FFFFFF"><input name="zd_email" type="text" id="zd_email" value="<%=zd_email%>" size="40" maxlength=10 dataType="Require" msg="邮箱不能为空">
		</td>
	</tr>
    <tr>
    <td width="15%" height="130" bgcolor="#F3FAFF">
      <p align="right">求购说明：<font color="#FF0000">*<br>
      </font></p>
    </td>      
    <td width="85%" height="130" bgcolor="#F3FAFF"><textarea name="zd_content" cols="60" rows="6" class="p92" id="zd_content" dataType="Require" msg="求购说明不能为空" onKeyUp="if((this.value).length&gt;300){ this.value=(this.value).substr(0,300);alert('内容已超出最大字数！');}" style="overflow-y:scroll;"></textarea></td>
     </tr>	 
	 <tr>
	   <td width="15%" height="37" bgcolor="#FFFFFF">
	    <p align="right">请输入数字验证码：<font color="#FF0000">*<br>
      </font></p></td>
		<td width="85%" height="37" bgcolor="#FFFFFF"><input type="text" id="rand" name="rand" value="" size="10" maxlength="20" class="moren" dataType="Require"  msg="验证码不能为空"/>
		<img src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</tr> 
    <tr>
    <td width="15%" height="27" bgcolor="#F3FAFF"></td>    
    <td width="85%" height="27" bgcolor="#F3FAFF" style="border:0;">
		<input type="submit" value="保存" name="btnok" class="p92 st2" style="cursor:pointer"> 
		<input type="reset"  value="重写" name="btnclear" class="p92 st2" style="cursor:pointer">	   
		<input name="zd_id"       type="hidden"  id="zd_id" value="0">
		<input name="mypy"        type="hidden"  id="mypy"  value="<%=Common.encryptionByDES(mypy)%>">
		<input name="zd_mem_no"   type="hidden"  id="zd_mem_no"  value="<%=zd_mem_no%>">
		<input name="zd_add_date" type="hidden"  id="zd_add_date"value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
		<input name="zd_add_ip"   type="hidden"  id="zd_add_ip"  value="<%=Common.getRemoteAddr(request,1)%>">		
			
		<input name="urlpath"     type="hidden"  id="urlpath"    value="<%=urlpath%>">		
		<input name="zd_pubdate"  type="hidden"  id="zd_pubdate"    value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>"/>
		<input name="zd_is_pub"    type="hidden"  id="zd_is_pub"     value="1">	
		<input name="zd_catalog_no"type="hidden" id="zd_catalog_no" value="700902">
		<input name="zd_clicked"   type="hidden" id="zd_clicked"    value="0">
		<input name="randflag"     type="hidden" id="randflag" value="1" />
    </tr>  
    </table>    
</div> </form>
   
	<script language="javascript">		
		function refresh(){
		document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
		}
		refresh();
	    set_province(document.getElementById('zd_province'),'<%=zd_province%>');
		set_city(document.getElementById('zd_province'),'<%=zd_province%>',theform.zd_city,'<%=zd_city%>');	
		 function set_province(obj,objvalue){
		   obj.value=objvalue;				  
		 }	
		 		 
</script>    
</body>
 <%
}catch(Exception e){e.printStackTrace();}
finally{
  urlpath=null;
}
%>
