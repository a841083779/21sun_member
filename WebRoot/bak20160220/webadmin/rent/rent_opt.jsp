<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%
//=====页面属性====
String pagename="rent_opt.jsp";
String mypy="rent_info";
String titlename="求出租管理";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));

String urlpath="../rent/rent_opt.jsp";
if(!myvalue.equals("0"))
urlpath=urlpath+"?myvalue="+myvalue;

try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=titlename%></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

function submityn(){
	if($("#zd_title").val()==""){
			alert("请输入标题！");
			$("#zd_title").focus();
			return false;
	}else if($("#zd_category").val()==""){
			alert("请选择类型！");
			$("#zd_category").focus();
			return false;
		}			
		theform.submit();
}
//==类型===
var mainclass=new Array();
var subclass=new Array();

mainclass[0]=new Array("1","挖掘机械");
mainclass[1]=new Array("2","铲土运输机械");
mainclass[2]=new Array("3","工程起重机械");
mainclass[3]=new Array("4","机动工业车辆");
mainclass[4]=new Array("5","压实机械");
mainclass[5]=new Array("6","路面机械");
mainclass[6]=new Array("7","混凝土机械");
mainclass[7]=new Array("8","桩工机械");
mainclass[8]=new Array("9","钢筋加工机械");
mainclass[9]=new Array("10","凿岩机械");
mainclass[10]=new Array("11","市政机械");
mainclass[11]=new Array("12","装修机械");
mainclass[12]=new Array("13","动力机械");
mainclass[13]=new Array("14","桥梁、铁路设备");
mainclass[14]=new Array("15","养护机械");
mainclass[15]=new Array("16","养护材料");
 
subclass[0]=new Array("1","14","挖掘机");
subclass[1]=new Array("1","15","掘进机");
subclass[2]=new Array("1","16","挖掘装载机");
subclass[124]=new Array("1","137","挖沟机");
subclass[125]=new Array("1","138","定向钻机");
subclass[3]=new Array("1","129","其他");
 
subclass[4]=new Array("2","17","推土机");
subclass[5]=new Array("2","18","装载机");
subclass[6]=new Array("2","19","铲运机");
subclass[7]=new Array("2","20","自卸车");
subclass[8]=new Array("2","21","除荆\根机");
subclass[9]=new Array("2","128","其他");
 
subclass[10]=new Array("3","22","汽车吊");
subclass[11]=new Array("3","23","塔吊");
subclass[12]=new Array("3","24","缆索吊");
subclass[13]=new Array("3","25","桅杆吊");
subclass[14]=new Array("3","26","抓斗吊");
subclass[15]=new Array("3","27","高空作业车");
subclass[16]=new Array("3","28","顶升机");
subclass[17]=new Array("3","29","升降机");
subclass[18]=new Array("3","30","龙门吊");
subclass[19]=new Array("3","32","行走吊");
subclass[20]=new Array("3","127","其他");
 
subclass[21]=new Array("4","31","叉车");
subclass[22]=new Array("4","33","搬运车");
subclass[23]=new Array("4","34","拖车");
subclass[24]=new Array("4","126","其他");
 
subclass[25]=new Array("5","35","夯实机");
subclass[126]=new Array("5","139","压路机");
subclass[26]=new Array("5","36","其他");
 
subclass[27]=new Array("6","37","平地机");
subclass[28]=new Array("6","38","压路机");
subclass[29]=new Array("6","39","扫雪机");
subclass[30]=new Array("6","40","撒沙机");
subclass[31]=new Array("6","41","摊铺机");
subclass[32]=new Array("6","42","路面养护车");
subclass[33]=new Array("6","43","路面拉、凿毛机");
subclass[34]=new Array("6","44","路面铣刨机");
subclass[35]=new Array("6","45","边沟成型机");
subclass[36]=new Array("6","46","路缘成型机");
subclass[37]=new Array("6","47","路面抹光机");
subclass[38]=new Array("6","48","路面脱水机");
subclass[39]=new Array("6","49","路面切缝机");
subclass[40]=new Array("6","50","路面划线机");
subclass[41]=new Array("6","51","液态沥青运输车");
subclass[42]=new Array("6","52","联合碎石设备");
subclass[43]=new Array("6","53","石屑撒布机");
subclass[44]=new Array("6","54","沥青搅拌设备");
subclass[45]=new Array("6","55","沥青路面再生设备");
subclass[46]=new Array("6","56","沥青路面加热设备");
subclass[47]=new Array("6","57","沥青泵");
subclass[48]=new Array("6","58","沥青混合料再生设备");
subclass[49]=new Array("6","59","沥青稀浆封层机");
subclass[50]=new Array("6","60","沥青洒布机");
subclass[51]=new Array("6","61","沥青熔化加热设备");
subclass[52]=new Array("6","62","沥青乳化设备");
subclass[53]=new Array("6","63","沥青混凝土摊铺设备");
subclass[54]=new Array("6","64","沥青混凝土搅拌设备");
subclass[55]=new Array("6","65","稳定土拌和设备");
subclass[56]=new Array("6","66","道路翻松机");
subclass[57]=new Array("6","125","其他");
 
subclass[58]=new Array("7","67","搅拌机");
subclass[59]=new Array("7","68","配料站");
subclass[60]=new Array("7","69","水泥运输车");
subclass[61]=new Array("7","70","布料杆");
subclass[62]=new Array("7","71","混凝土振动机");
subclass[63]=new Array("7","72","浇注机");
subclass[64]=new Array("7","73","喷射机");
subclass[65]=new Array("7","74","混凝土泵");
subclass[66]=new Array("7","75","搅拌运输车");
subclass[67]=new Array("7","76","搅拌楼");
subclass[68]=new Array("7","124","其他");
 
subclass[69]=new Array("8","77","打桩锤");
subclass[70]=new Array("8","78","液压锤");
subclass[71]=new Array("8","79","打桩机");
subclass[72]=new Array("8","80","钻孔机");
subclass[73]=new Array("8","81","压桩机");
subclass[74]=new Array("8","82","沉拔桩架");
subclass[75]=new Array("8","83","打桩架");
subclass[76]=new Array("8","86","孔道成型机");
subclass[127]=new Array("8","140","软地基加固");
subclass[77]=new Array("8","123","其他");

 
subclass[78]=new Array("9","84","灌浆泵");
subclass[79]=new Array("9","85","穿束机");
subclass[80]=new Array("9","87","镦头器");
subclass[81]=new Array("9","88","张拉机");
subclass[82]=new Array("9","89","预应力液压泵");
subclass[83]=new Array("9","90","螺纹成型机");
subclass[84]=new Array("9","91","套筒挤压机");
subclass[85]=new Array("9","92","焊机");
subclass[86]=new Array("9","93","网成型机");
subclass[87]=new Array("9","94","弯箍机");
subclass[88]=new Array("9","95","弯曲机");
subclass[89]=new Array("9","96","切断机");
subclass[90]=new Array("9","97","轧扭机");
subclass[91]=new Array("9","98","冷拔机");
subclass[92]=new Array("9","122","其他");
 
subclass[93]=new Array("10","99","凿岩机");
subclass[94]=new Array("10","100","气动马达");
subclass[95]=new Array("10","101","气动工具");
subclass[96]=new Array("10","102","破碎机");
subclass[97]=new Array("10","103","辅助设备");
subclass[98]=new Array("10","104","钻机");
subclass[99]=new Array("10","121","其他");
 
subclass[100]=new Array("11","105","清扫机");
subclass[101]=new Array("11","106","除雪机");
subclass[102]=new Array("11","107","排障车");
subclass[103]=new Array("11","108","洒水车");
subclass[104]=new Array("11","120","其他");
 
subclass[105]=new Array("12","109","喷涂机");
subclass[106]=new Array("12","110","灰浆机");
subclass[107]=new Array("12","111","喷刷机");
subclass[108]=new Array("12","112","装修机具");
subclass[109]=new Array("12","113","擦窗机");
subclass[110]=new Array("12","114","高处作业吊蓝");
subclass[111]=new Array("12","115","地面修整机械");
subclass[112]=new Array("12","116","油漆制备及喷涂机械");
subclass[113]=new Array("12","117","其他");
 
subclass[114]=new Array("13","118","发电机(组)");
subclass[115]=new Array("13","119","发动机");
subclass[116]=new Array("13","122","空压机");
 
subclass[117]=new Array("14","130","卸渣机");
subclass[128]=new Array("14","141","捣固机");
subclass[129]=new Array("14","142","架桥机");
subclass[130]=new Array("14","143","运梁车");
subclass[131]=new Array("14","144","铺轨机");
subclass[132]=new Array("14","145","轨道车");
subclass[133]=new Array("14","146","其他");
 
subclass[118]=new Array("16","131","养护材料");
 
subclass[119]=new Array("15","132","养路王");
subclass[120]=new Array("15","133","开槽机");
subclass[121]=new Array("15","134","铣刨机");
subclass[122]=new Array("15","135","划线车");
subclass[123]=new Array("15","136","切缝机");
 
 
function clear(o)
{
l=o.length;
for (i = 0; i< l; i++)
 {o.options[1]=null;}
}
 
function listclass(Obj_,Idx_)
{
 clear(Obj_);
 if(Idx_!="")
 {
 for(var j=0;j<subclass.length;j++)
  {
   if(mainclass[Idx_][0]==subclass[j][0]&subclass[j][2]!="")
   {
    Obj_.add(new Option(subclass[j][2],j));
   }
  }
 } 
}
</script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="15"><span class="p982"><span class="pblue1">红色</span><font color="#FF0000">*</font><span class="pblue1">为必填项</span></span></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform" >
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>标　　题：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><span class="STYLE1">会员编号：</span></td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" size="20" value="<%if(adminInfo != null&&adminInfo.get("usern")!=null)out.print(adminInfo.get("usern"));%>" >
      <span class="list_left_title">会员编号：
      <input name="zd_mem_name" type="text" id="zd_mem_name" size="20" value="<%if(adminInfo != null&&adminInfo.get("realname")!=null)out.print(adminInfo.get("realname"));%>" >
      </span></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">性质：</td>
      <td class="list_cell_bg">
      <select name="zd_class" id="zd_class">
          <option value="1">出租</option>
          <option value="0">求租</option>
        </select>
        <span class="list_left_title" style="margin-left: 100px;">联系方式：
	      <input name="zd_telephone" type="text" id="zd_telephone" size="20" value="" >
	     </span>
        </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">类别：</td>
      <td class="list_cell_bg"><select name="zd_category" id="zd_category" onclick="javascript:listclass(document.theform.zd_subcategory,this.value)">
          <option value="">--请选择类别--</option>
          <script language=javascript>
         for(var i=0;i<mainclass.length;i++)
         {document.write ("<option value="+i+">"+mainclass[i][1]+"</option>");}
        </script>
        </select>
        <select name="zd_subcategory" id="zd_subcategory">
          <option value="">--下属类别--</option>
        </select></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">品牌：</td>
      <td class="list_cell_bg"><input name="zd_brand" type="text" id="zd_brand" size="30" maxlength="30"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">型号：</td>
      <td class="list_cell_bg"><input name="zd_model" type="text" id="zd_model" size="30" maxlength="30"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">所在地：</td>
      <td class="list_cell_bg"><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:100px;"  class="validate-selection">
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
          <option>选择城市</option>
        </select></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">价格：</td>
      <td class="list_cell_bg"><input name="zd_price" type="text" id="zd_price" size="20" maxlength="20"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">有效期：</td>
      <td class="list_cell_bg"><select size="1" name="zd_pubdays" id="zd_pubdays">
          <option value="7" selected>一个周</option>
          <option value="30">一个月</option>
          <option value="90">三个月</option>
          <option value="180">半年</option>
	     <option value="360">长期有效</option>
        </select></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图　　片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img" type="text" id="zd_img" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=19&dir=sell_buy_market&fieldname=zd_img','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布日期：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_pubdate" name="zd_pubdate" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="20" maxlength="20"  readonly="true" /></td>
      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布状态：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="0">
        否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">成交状态：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_pub" name="zd_isdone" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_isdone" value="0">
        否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">内　　容：</td>
      <td height="22" class="list_cell_bg"><FCK:editor instanceName="zd_content" toolbarSet="simple" width="93%" height="380">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor>
        <font color="#FF0000">*</font></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
		  <input name="zd_catalog_no" type="hidden" id="zd_catalog_no" value="700701">
		  </div></td>
    </tr>
  </form>
</table>
<table width="98%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="10"></td>
  </tr>
</table>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!myvalue.equals("0")){
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
