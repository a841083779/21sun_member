<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%

PoolManager pool7 = new PoolManager(7);
PoolManager pool1 = new PoolManager(1);
//=====页面属性====

String mypy="buy";
String myvalue ="";
//====得到参数====

String urlpath="/partsbuy/buy.jsp";
String  zd_category = Common.getFormatStr(request.getParameter("zd_category"));
String  flag        = Common.getFormatStr(request.getParameter("flag"));

String zd_mem_no          = "";
String zd_mem_name        ="";
String zd_telephone       ="";
String zd_email           ="";
String zd_province        ="";
String zd_city            ="";
String zd_address         ="";
String zd_mem_flag        ="";

ArrayList userlist=Common.getMemberInfoList("mem_no,mem_name,per_phone,per_email,per_province,per_city,comp_address,mem_flag", pool1,request,"member_info", "mem_no","passw", "memberInfo");
//System.out.println("userlist.size():=="+userlist.size());

if(userlist!=null&&userlist.size()==8)
{zd_mem_no=Common.getFormatStr(userlist.get(0));
 zd_mem_name=Common.getFormatStr(userlist.get(1));
 zd_telephone=Common.getFormatStr(userlist.get(2));
 zd_email=Common.getFormatStr(userlist.get(3));
 zd_province=Common.getFormatStr(userlist.get(4));
 zd_city=Common.getFormatStr(userlist.get(5));
 zd_address=Common.getFormatStr(userlist.get(6));
 zd_mem_flag=Common.getFormatStr(userlist.get(7));
}

/*if(zd_mem_no.equals("-8888") || zd_mem_no.equals("-9999")){zd_mem_no="";}
if(zd_mem_name.equals("-8888") || zd_mem_name.equals("-9999")){zd_mem_name="";}
if(zd_telephone.equals("-8888") || zd_telephone.equals("-9999")){zd_telephone="";}
if(zd_email.equals("-8888") || zd_email.equals("-9999")){zd_email="";}
if(zd_province.equals("-8888") || zd_province.equals("-9999")){zd_province="";}
if(zd_city.equals("-8888") || zd_city.equals("-9999")){zd_city="";}
if(zd_address.equals("-8888") || zd_address.equals("-9999")){zd_address="";}
if(zd_mem_flag.equals("-8888") || zd_mem_flag.equals("-9999")){zd_mem_flag="";}
*/
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
<script type="text/javascript">
var subCategory = new Array();
<%	
String[][] subCategory = DataManager.fetchFieldValue(pool7, "parts_catalog","num,name,parentid", "parentid<>0");
if(subCategory!=null){
	for(int i=0;i<subCategory.length;i++){
%>
	subCategory[<%=i%>]=['<%=subCategory[i][0]%>','<%=subCategory[i][1]%>','<%=subCategory[i][2]%>']; 
<%
	 }
	}
%>
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
</script>
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
			<p class="141"><b><font color="#0080FF" size="3">&nbsp;&nbsp;我要发布配件求购信息</font></b>&nbsp;&nbsp;带<font color="#FF0000">*</font>的必须填写</p>
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
    <td width="16%" height="25" bgcolor="#FFFFFF" align="right">标题：<font color="#FF0000">*</font></td>                             
    <td width="84%" height="25" bgcolor="#FFFFFF"><input name="zd_title" type="text"  id="zd_title" value="" size="40" maxlength=20 dataType="Require" msg="标题不能为空！"></td>
    </tr>
	 <tr>
    <td width="16%" valign="top" height="25" bgcolor="#F3FAFF" align="right">所在地：<font color="#FF0000">*</font><font color="#FF0000">&nbsp;</font></td>
    <td width="84%" height="25" bgcolor="#F3FAFF">
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
    <td width="16%" valign="top" height="25" bgcolor="#FFFFFF" align="right">产品类别：<font color="#FF0000">*</font></td>
    <td width="84%" height="25" bgcolor="#FFFFFF"><select name="zd_category" id="zd_category" onChange="set_subcategory(this);" style="width:100px;"  class="blue1"><option value="">请选择分类</option><cache:cache key="include_category1" cron="0 0/30 6-23 * * ?">
          		<%=Common.option_str(pool7,"parts_catalog","num,name","parentid=0","",0) %>          		</cache:cache>
            </select>
            <select  name="zd_subcategory" id="zd_subcategory"  style="width:100px;" class="blue1" onChange="set_subcategoryname(this);">
              <option>选择子分类</option>
            </select>
            <input type="hidden" name="zd_categoryname"     id="zd_categoryname"/>
			<input type="hidden" name="zd_subcategoryname"  id="zd_subcategoryname"/></td>
    </tr>
	 <tr>	
		<td width="16%" height="25" bgcolor="#F3FAFF" align="right">型号：<font color="#FF0000">*</font></td>
		<td width="84%" height="25" bgcolor="#F3FAFF"><input name="zd_model" type="text" id="zd_model" value="" size="40" maxlength=10 dataType="Require" msg="您的型号不能为空">
		</td>
	</tr>
	<tr>	
		<td width="16%" height="25" bgcolor="#FFFFFF" align="right">采购数量：<font color="#FF0000">*</font></td>
		<td width="84%" height="25" bgcolor="#FFFFFF"><input name="zd_amount" type="text" id="zd_amount" value="" size="40" maxlength=10>
		</td>
	</tr>
	<tr>
          <td  class="right" nowrap="nowrap" bgcolor="#F3FAFF" align="right"><span class="grayb">是否紧急：</span></td>
          <td height="22" class="list_cell_bg" bgcolor="#F3FAFF" ><input type="radio" id="zd_is_urgent" name="zd_is_urgent" value="1" />
            是
            <input name="zd_is_urgent" type="radio" id="zd_is_urgent" value="0" checked="checked";/>
            否 </td>
     </tr>
	  <tr>
          <td  class="right" nowrap="nowrap" bgcolor="#FFFFFF" align="right"><span class="grayb">是否正厂：</span></td>
          <td height="22" class="list_cell_bg" bgcolor="#FFFFFF" ><input type="radio" id="zd_is_original" name="zd_is_original" value="1" checked="checked" style="border:0";/>
            正厂
            <input type="radio" id="zd_is_original" name="zd_is_original" value="0" style="border:0";/>
            副厂 </td>
     </tr>
	  <tr>
          <td  class="right" nowrap="nowrap"  bgcolor="#F3FAFF" align="right"><span class="grayb">新旧程度：</span></td>
          <td height="22" class="list_cell_bg"  bgcolor="#F3FAFF"><input type="radio" id="zd_old" name="zd_old" value="1" checked="checked" style="border:0";/>
            全新
            <input type="radio" id="zd_old" name="zd_old" value="2" style="border:0";/>
            二手 </td>
    </tr>
	<tr>	
		<td width="16%" height="25" bgcolor="#FFFFFF" align="right">求购人：<font color="#FF0000">*</font></td>
		<td width="84%" height="25" bgcolor="#FFFFFF"><input name="zd_mem_name" type="text" id="zd_mem_name" value="<%=zd_mem_name%>" size="40" maxlength=10 dataType="Require" msg="您的姓名不能为空">
		</td>
	</tr>
	<tr>	
		<td width="16%" height="25" bgcolor="#F3FAFF" align="right">地址：<font color="#FF0000">*</font></td>
		<td width="84%" height="25" bgcolor="#F3FAFF"><input name="zd_address" type="text" id="zd_address" value="<%=zd_address%>" size="40" maxlength=10 dataType="Require" msg="您的姓名不能为空">
		</td>
	</tr>
	<tr>
		<td width="16%" height="25" bgcolor="#FFFFFF" align="right">电话：<font color="#FF0000">*</font></td>                             
		<td width="84%" height="25" bgcolor="#FFFFFF"><input name="zd_telephone" type="text"  id="zd_telephone" value="<%=zd_telephone%>" size="40" maxlength=20 dataType="Require" msg="联系电话不能为空"></td>
	</tr>
		<tr>	
		<td width="16%" height="25" bgcolor="#F3FAFF" align="right">邮箱：<font color="#FF0000">*</font></td>
		<td width="84%" height="25" bgcolor="#F3FAFF"><input name="zd_email" type="text" id="zd_email" value="<%=zd_email%>" size="40" maxlength=10 dataType="Require" msg="您的姓名不能为空">
		</td>
	</tr>
    <tr>
    <td width="16%" height="62" bgcolor="#FFFFFF">
      <p align="right">求购说明：<font color="#FFFFFF">*<br>
      </font></p>
    </td>      
    <td width="84%" height="62" bgcolor="#FFFFFF"><textarea name="zd_content" cols="60" rows="4" class="p92" id="zd_content" dataType="Require" msg="求购说明不能为空" onKeyUp="if((this.value).length&gt;300){ this.value=(this.value).substr(0,300);alert('内容已超出最大字数！');}"></textarea></td>
     </tr>	 
	 <tr>
	   <td width="16%" height="37" bgcolor="#F3FAFF">
	    <p align="right"><nobr>请输入数字验证码：</nobr></p></td>
		<td width="84%" height="37" bgcolor="#F3FAFF"><input type="text" id="rand" name="rand" value="" size="10" maxlength="20" class="moren" dataType="Require"  msg="验证码不能为空!"/>
		<img src="/webadmin/authImgServlet" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();" /></td>
	</tr> 
    <tr>
    <td width="16%" height="27" bgcolor="#FFFFFF"></td>    
    <td width="84%" height="27" bgcolor="#FFFFFF" style="border:0;">
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
		<input name="zd_mem_flag"  type="hidden" id="zd_mem_flag" value="<%=zd_mem_flag%>" /> 
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
