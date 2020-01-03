<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(9);

//=====页面属性====
String pagename="product_opt.jsp";
String mypy="fittings_products";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));


String urlpath="../fittings/product_list.jsp";

try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>配套合作</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

//为多选框赋值
function submityn(){
	    //if(pubCount>=30){
		//  alert("您今天已发布了"+pubCount+"条配套合作信息，已经达到最大发布数！");   
		//  return false; 
		//}	
		var obj2 = document.getElementsByName("product_flag");
		var productFlagValue = ",";
		for(var i=0;i<obj2.length;i++){
			if(obj2[i].checked){
				productFlagValue += obj2[i].value+",";
			}
		}
		if(productFlagValue==",") productFlagValue="";
		theform.zd_product_flag.value = productFlagValue;
			
		if(theform.zd_product_name.value==""){
			alert("请输入品名！");
			theform.zd_product_name.focus();
			return false;
		}else if(theform.zd_province.value==""){
			alert("请选择省份！");
			theform.zd_province.focus();
			return false;
		}else if(theform.zd_city.value==""){
			alert("请选择城市！");
			theform.zd_city.focus();
			return false;
		}else if(theform.zd_product_flag.value==""){
			alert("请选择机型！");
			return false;
		}else if(returnRadio("zd_part_sort")==false){
			alert("请选择所属类别！");
			return false;			
		}else if(theform.zd_describ.value==""){
			alert("请输入详情，内容控制在300个汉字以内！");
			theform.zd_describ.focus();
			return false;
		}else if(theform.zd_mem_no.value==""){
			alert("请输入会员帐号！");
			theform.zd_mem_no.focus();
			return false;
		}
			
		theform.submit();
}
</script>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15"><span class="p982"><span class="pblue1"></span><font color="#FF0000">*</font><span class="pblue1">号为必填项</span></span></td>
    </tr>
</table>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
    <tr>
      <td align="right" nowrap class="list_left_title"><font color="#FF0000">*</font>品　　名：</td>
      <td class="list_cell_bg"><input name="zd_product_name" type="text" id="zd_product_name" size="60" maxlength="40" ></td>
    </tr>
	<tr>
	  <td nowrap="nowrap"  class="right"><div align="right"><font color="#FF0000">*</font><span class="grayb">产品型号：</span></div></td>
	  <td ><input name="zd_product_model" type="text" id="zd_product_model" maxlength="25" size="60" class="moren"></td>
	</tr>
	<tr>
	  <td nowrap="nowrap"  class="right"><div align="right"><font color="#FF0000">*</font><span class="grayb">品　　牌：</span></div></td>
	  <td ><input name="zd_product_brand" type="text" id="zd_product_brand" maxlength="25" size="60" class="moren"></td>
	</tr>
    <tr>
          <td  class="right"nowrap="nowrap"><div align="right"><font color="#FF0000">*</font><span class="grayb">所属类别：</span></div></td>
          <td height="22" class="list_cell_bg">
		    <input type="radio" id="part_sort1" name="zd_part_sort" value="10" /style="border:0";>
            结构件
            <input type="radio" id="part_sort2" name="zd_part_sort" value="11" style="border:0";/>
            液压系统
            <input type="radio" id="part_sort3" name="zd_part_sort" value="12" style="border:0";/>
            传动系统
            <input type="radio" id="part_sort4" name="zd_part_sort" value="13" style="border:0";/>
            动力系统
            <input type="radio" id="part_sort5" name="zd_part_sort" value="14" style="border:0";/>
            电气系统<br />
			<input type="radio" id="part_sort6" name="zd_part_sort" value="15" style="border:0";/>
            覆盖件（钣金件）
			<input type="radio" id="part_sort7" name="zd_part_sort" value="16" style="border:0";/>
            精加工件
			<input type="radio" id="part_sort8" name="zd_part_sort" value="17" style="border:0";/>
            特殊工作装置
			<input type="radio" id="part_sort9" name="zd_part_sort" value="18" style="border:0";/>
            辅料及其他</td>
        </tr>
    <tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><font color="#FF0000">*</font>配套机种：</td>
      <td height="22" class="list_cell_bg"><table width="500" border="0" cellspacing="0" cellpadding="0">
          <tr>
                <td><input type="checkbox" id="product_flag" name="product_flag" value="101001" style="border:0";/>
                  挖掘机</td>
                <td><input type="checkbox" id="product_flag" name="product_flag" value="101002" style="border:0";/>
                  装载机</td>
                <td><input type="checkbox" id="product_flag" name="product_flag" value="101003" style="border:0";/>
                  推土机</td>
              </tr>
              <tr>
                <td><input type="checkbox" id="product_flag" name="product_flag" value="101005" style="border:0";/>
                  平地机</td>
				<td><input type="checkbox" id="product_flag" name="product_flag" value="104" style="border:0";/>
                  路面机械</td>
                <td><input type="checkbox" id="product_flag" name="product_flag" value="105" style="border:0";/>
                  桩工机械</td>
              </tr>
              <tr>
                <td><input type="checkbox" id="product_flag" name="product_flag" value="103" style="border:0";/>
                  混凝土机械</td>
                <td><input type="checkbox" id="product_flag" name="product_flag" value="102" style="border:0";/>
                  起重机械</td>
                <td><input type="checkbox" id="product_flag" name="product_flag" value="999" style="border:0";/>
                  其它机械
                  <input type="hidden" id="zd_product_flag" name="zd_product_flag" value="" style="border:0";/ ></td>
              </tr>
        </table></td>
    </tr>
	<tr>
          <td nowrap="nowrap"  class="right"><div align="right"><font color="#FF0000">*</font><span class="grayb">配套品牌：</span></div></td>
          <td ><select name="zd_fittings_machine_brand" size="1" id="zd_fittings_machine_brand">
              <option value="">--请选择品牌--</option>
              <option value="DB">DB</option>
              <option value="IGS(意德力)">IGS(意德力)</option>
              <option value="JCB">JCB</option>
              <option value="阿特拉斯">阿特拉斯</option>
              <option value="阿特拉斯·科普柯">阿特拉斯·科普柯</option>
              <option value="艾迪">艾迪</option>
              <option value="艾思博">艾思博</option>
              <option value="八达">八达</option>
              <option value="八达重工">八达重工</option>
              <option value="百财机械">百财机械</option>
              <option value="百灵">百灵</option>
              <option value="邦立重机">邦立重机</option>
              <option value="宝马格">宝马格</option>
              <option value="北方交通">北方交通</option>
              <option value="北起多田野">北起多田野</option>
              <option value="贝力特">贝力特</option>
              <option value="长沙天为">长沙天为</option>
              <option value="常林股份">常林股份</option>
              <option value="朝工">朝工</option>
              <option value="成工">成工</option>
              <option value="大地">大地</option>
              <option value="大信重工">大信重工</option>
              <option value="戴纳派克">戴纳派克</option>
              <option value="德工">德工</option>
              <option value="德国宝峨">德国宝峨</option>
              <option value="德基">德基</option>
              <option value="德玛格">德玛格</option>
              <option value="鼎盛天工">鼎盛天工</option>
              <option value="东方红">东方红</option>
              <option value="东空">东空</option>
              <option value="东元">东元</option>
              <option value="东岳重工">东岳重工</option>
              <option value="斗山">斗山</option>
              <option value="方圆集团">方圆集团</option>
              <option value="福格勒">福格勒</option>
              <option value="福田雷沃">福田雷沃</option>
              <option value="抚顺起重机">抚顺起重机</option>
              <option value="抚挖">抚挖</option>
              <option value="高马科">高马科</option>
              <option value="高远路业">高远路业</option>
              <option value="格瑞德">格瑞德</option>
              <option value="工兵">工兵</option>
              <option value="古河">古河</option>
              <option value="广林">广林</option>
              <option value="广西开元">广西开元</option>
              <option value="海州机械">海州机械</option>
              <option value="韩川">韩川</option>
              <option value="韩泰克">韩泰克</option>
              <option value="韩宇">韩宇</option>
              <option value="悍马">悍马</option>
              <option value="悍狮">悍狮</option>
              <option value="杭州永林">杭州永林</option>
              <option value="合肥振宇">合肥振宇</option>
              <option value="合力">合力</option>
              <option value="恒特">恒特</option>
              <option value="弘德">弘德</option>
              <option value="鸿得利">鸿得利</option>
              <option value="虎霸集团">虎霸集团</option>
              <option value="华力重工">华力重工</option>
              <option value="华威桩工">华威桩工</option>
              <option value="浣熊">浣熊</option>
              <option value="吉公">吉公</option>
              <option value="加藤">加藤</option>
              <option value="甲南">甲南</option>
              <option value="江淮重工">江淮重工</option>
              <option value="江麓机电">江麓机电</option>
              <option value="江苏上騏">江苏上騏</option>
              <option value="江阴艾肯">江阴艾肯</option>
              <option value="金拓液压">金拓液压</option>
              <option value="晋工">晋工</option>
              <option value="京城重工">京城重工</option>
              <option value="惊天液压">惊天液压</option>
              <option value="久保田">久保田</option>
              <option value="酒井">酒井</option>
              <option value="卡特彼勒">卡特彼勒</option>
              <option value="卡特重工">卡特重工</option>
              <option value="凯莫尔">凯莫尔</option>
              <option value="凯斯">凯斯</option>
              <option value="雷奥科技">雷奥科技</option>
              <option value="力博士">力博士</option>
              <option value="力士德">力士德</option>
              <option value="利勃海尔">利勃海尔</option>
              <option value="连云港工兵">连云港工兵</option>
              <option value="辽宁海诺">辽宁海诺</option>
              <option value="辽筑">辽筑</option>
              <option value="临工">临工</option>
              <option value="柳工">柳工</option>
              <option value="龙工">龙工</option>
              <option value="陆德筑机">陆德筑机</option>
              <option value="绿地重工">绿地重工</option>
              <option value="洛建">洛建</option>
              <option value="洛阳路通">洛阳路通</option>
              <option value="洛阳一拖">洛阳一拖</option>
              <option value="玛连尼">玛连尼</option>
              <option value="麦恩">麦恩</option>
              <option value="猛士">猛士</option>
              <option value="南方路机">南方路机</option>
              <option value="南特">南特</option>
              <option value="普茨迈斯特">普茨迈斯特</option>
              <option value="普什重机">普什重机</option>
              <option value="全进重工">全进重工</option>
              <option value="日立建机">日立建机</option>
              <option value="熔安重工">熔安重工</option>
              <option value="锐马">锐马</option>
              <option value="瑞工">瑞工</option>
              <option value="三一">三一</option>
              <option value="森田重机">森田重机</option>
              <option value="山东常林">山东常林</option>
              <option value="山东福临">山东福临</option>
              <option value="山东鸿达">山东鸿达</option>
              <option value="山工">山工</option>
              <option value="山河智能">山河智能</option>
              <option value="山猫">山猫</option>
              <option value="山推">山推</option>
              <option value="山重建机">山重建机</option>
              <option value="陕建机械">陕建机械</option>
              <option value="上海金泰">上海金泰</option>
              <option value="上海彭浦">上海彭浦</option>
              <option value="神钢">神钢</option>
              <option value="神钢进口">神钢进口</option>
              <option value="盛隆">盛隆</option>
              <option value="施维英">施维英</option>
              <option value="石川岛">石川岛</option>
              <option value="石煤">石煤</option>
              <option value="世运">世运</option>
              <option value="水山">水山</option>
              <option value="四川长起">四川长起</option>
              <option value="太腾机械">太腾机械</option>
              <option value="泰安鲁岳">泰安鲁岳</option>
              <option value="泰戈">泰戈</option>
              <option value="泰科">泰科</option>
              <option value="特雷克斯">特雷克斯</option>
              <option value="天地重工">天地重工</option>
              <option value="铁兵">铁兵</option>
              <option value="铁拓机械">铁拓机械</option>
              <option value="拓能重机">拓能重机</option>
              <option value="万邦重科">万邦重科</option>
              <option value="威猛">威猛</option>
              <option value="维特根">维特根</option>
              <option value="沃得重工">沃得重工</option>
              <option value="沃尔华">沃尔华</option>
              <option value="沃尔沃">沃尔沃</option>
              <option value="无锡雪桃">无锡雪桃</option>
              <option value="西筑">西筑</option>
              <option value="厦工">厦工</option>
              <option value="厦门七天阳">厦门七天阳</option>
              <option value="先锋">先锋</option>
              <option value="现代(江苏)">现代(江苏)</option>
              <option value="现代京城">现代京城</option>
              <option value="小松">小松</option>
              <option value="鑫国重机">鑫国重机</option>
              <option value="星马汽车">星马汽车</option>
              <option value="徐工集团">徐工集团</option>
              <option value="徐挖">徐挖</option>
              <option value="徐威重科">徐威重科</option>
              <option value="徐重">徐重</option>
              <option value="宣工">宣工</option>
              <option value="烟工">烟工</option>
              <option value="烟台军恒">烟台军恒</option>
              <option value="烟台润弘">烟台润弘</option>
              <option value="洋马">洋马</option>
              <option value="一工机械">一工机械</option>
              <option value="一拖">一拖</option>
              <option value="宜工">宜工</option>
              <option value="宜兴巍宇">宜兴巍宇</option>
              <option value="移山">移山</option>
              <option value="永工">永工</option>
              <option value="友一">友一</option>
              <option value="宇通重工">宇通重工</option>
              <option value="玉柴">玉柴</option>
              <option value="詹阳动力">詹阳动力</option>
              <option value="浙江军联">浙江军联</option>
              <option value="郑州川岛">郑州川岛</option>
              <option value="中集凌宇">中集凌宇</option>
              <option value="中联重科">中联重科</option>
              <option value="中龙建机">中龙建机</option>
              <option value="重庆勤牛">重庆勤牛</option>
              <option value="竹内">竹内</option>
              <option value="住友">住友</option>
            </select>
          </td>
        </tr>
	<tr>
          <td nowrap="nowrap"  class="right"><div align="right"><font color="#FF0000">*</font><span class="grayb">配套机型：</span></div></td>
          <td ><input name="zd_fittings_mechine_model" type="text" id="zd_fittings_mechine_model" maxlength="25" size="60" class="moren"></td>
        </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><font color="#FF0000">*</font>省　　市：</td>
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
            <option>选择城市</option>
          </select>
          </span><font color="#FF0000">*</font></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">图　　片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img" type="text" id="zd_img" size="50" maxlength="40">
<input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=19&dir=fittings&fieldname=zd_img','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">是否发布：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_show1" name="zd_is_show" value="1" checked="checked">
        发布
        <input type="radio" id="zd_is_show2" name="zd_is_show" value="0">
        暂停 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">详　　情：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_describ" cols="50" rows="8" id="zd_describ" onKeyUp="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}"></textarea>
      <font color="#FF0000">*</font></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">配套服务：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_fittings_service" cols="50" rows="4" id="zd_fittings_service" onKeyUp="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('配套服务请控制在300个汉字以内。');}"></textarea>
     </td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">招商政策：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_fittings_policy" cols="50" rows="4" id="zd_fittings_policy" onKeyUp="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('招商政策请控制在300个汉字以内。');}"></textarea>
     </td>
    </tr>	
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">发布人帐号：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_mem_no" name="zd_mem_no" size="20" maxlength="20"/></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">发布人qq：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_qq" name="zd_qq" size="20" maxlength="20"/></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">所属公司：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_company" name="zd_company" size="20" maxlength="200"/></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">联系电话：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_tel" name="zd_tel" size="20" maxlength="20"/></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">网　　址：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_url" name="zd_url" size="20" maxlength="20"/></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
        <input type="button" name="Submit" value="保存" onClick="submityn()">
        <input name="zd_id" type="hidden" id="zd_id" value="0" />
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
        <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
		<input name="zd_update_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
        <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
        <input name="randflag" type="hidden" id="randflag" value="1" />
		<input name="zd_no" type="hidden" id="zd_no" value="<%=Common.generateDateRandom()%>" />
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
if(!myvalue.equals("")){
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
