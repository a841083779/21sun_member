<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="include/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}

String province="";
String city="";
String addr = "";

try{

//String ip=Common.getRemoteAddr(request,1);
String ip=Common.getRemoteAddr(request,1);
//out.println("ip:===="+ip);
//ip="221.0.90.164";
//String []ips = ip.split("\\.");
//String ipStr = df.format(Double.parseDouble(ips[0]) * 256 * 256 * 256 + Double.parseDouble(ips[1]) * 256 * 256 + Double.parseDouble(ips[2]) * 256 + Double.parseDouble(ips[3]) - 1);
//String [][]addrs = DataManager.fetchFieldValue(pool,"ip","top 1 ip3,ip4","ip1<="+ipStr+" and ip2>="+ipStr+"");
//addr = addrs!=null?addrs[0][0]:"";
//System.out.println(addrs[0][0]+"--"+addrs[0][1]);
addr = Common.getAddressForIp(request,ip,1);

String [][]provinces = (String[][])application.getAttribute("provinces");
String [][]citys = (String[][])application.getAttribute("citys");

for(int i=0;provinces!=null && i<provinces.length;i++){
	//System.out.println(provinces[i][0]);
	if(addr.indexOf(provinces[i][0])!=-1){
		province=provinces[i][0];
	}
}

for(int i=0;citys!=null && i<citys.length;i++){
	//System.out.println(provinces[i][0]);
	if(addr.indexOf(citys[i][0])!=-1){
		city=citys[i][0];
	}
}

//out.println("==:"+province+"--city--:"+city);

}catch(Exception e){e.printStackTrace();}
finally{
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员注册 - 中国工程机械商贸网</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="scripts/jquery-1.4.1.min.js"  type="text/javascript"></script>
<script language="Javascript" src="scripts/citys.js"  type="text/javascript"></script>
<script language="Javascript" type="text/javascript"  src="scripts/quick2.js" charset="utf-8"></script>

<script src="scripts/zhucheyanzheng.js"  type="text/javascript"></script>
<script language="javascript">
function KeyDown()
{
    if (event.keyCode == 13)
    {
        event.returnValue=false;
        event.cancel = true;
        document.theform.regid.click();
    }
}
</script>
</head>
<body>
<jsp:include page="manage/top.jsp" />
<div class="weizhi">
  <div class="weizhi_1">您的位置 >> 我的商贸网</div>
</div>
<div class="center">
  <div class="zhuce">
    <ul class="step">
      <li class="step1_c"></li>
      <li class="steparrow"></li>
      <li class="step3"></li>
    </ul>
  </div>
  <a name="regs"></a>
  <div class="zhuce1">
  <div id="floater2" style="width:98px;height:125px;margin-left:740px;display:inline;position:absolute;z-index:100;"><img src="/images/baobao.gif" width="98" height="125" /></div>
    <div class="zhuce2">免费注册会员，一次注册可以在中国工程机械商贸网旗下所有网站登陆；<font color="#ff6600">如果您已经注册，</font><a href="/" ><font color="#ff6600">点击此处登陆</font></a>。</div>
    <form id="theform" name="theform" method="post" action="member_reg_action.jsp"  onsubmit="return regYanzheng();" >
      <table width="95%" align="center" border="0" class="tablezhuce">
        <tr>
          <td width="13%" class="right"><span class="red">*</span> <span class="grayb">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span></td>
          <td width="87%"><input name="mem_no" type="text" class="moren" id="mem_no" style="width:180px" onblur="formyanzheng('mem_no')" onclick="this.className='dianji'" maxlength="50"/>
            <div class="diu" id="mem_no_dui" style="display:none"></div>
            <div class="cuo" id="mem_no_cuo" style="display:none"></div>
            <div class="cuo1" id="mem_no_cuo_info" style="display:none"></div></td>
        </tr>
        <tr>
          <td class="right">&nbsp;</td>
          <td >- 用户名长度为4-18位之间<br />
            - 请用英文字母、数字、下划线或中横线，并且结尾不能以标点符号结束</td>
        </tr>
        <tr>
          <td class="right"><span class="red">*</span> <span class="grayb">密　　码：</span></td>
          <td colspan="2" ><input name="passw" type="password" class="moren" id="passw" style="width:180px"  onblur="formyanzheng('passw')"  onkeyup="pwStrength(this.value)" maxlength="50"/>
            <div class="qr">
              <ul>
                <li id="strength_L">弱</li>
                <li id="strength_M">中</li>
                <li id="strength_H">强</li>
              </ul>
            </div>
            <div class="diu" id="passw_dui" style="display:none"></div>
            <div class="cuo" id="passw_cuo" style="display:none"></div>
            <div class="cuo1" id="passw_cuo_info" style="display:none"></div></td>
        </tr>
        <tr>
          <td class="right">&nbsp;</td>
          <td >- 密码长度为4-18位之间，并且中间不能含有空格<br />
            - 请尽量采用字母＋数字＋标点符号的方式设置密码，提高密码安全性</td>
        </tr>
        <tr>
          <td class="right"><span class="red">*</span> <span class="grayb">确认密码：</span></td>
          <td ><input name="passw2" type="password" class="moren" id="passw2" style="width:180px" onblur="formyanzheng('passw2')" maxlength="50"/>
            <div class="diu" id="passw2_dui" style="display:none"></div>
            <div class="cuo" id="passw2_cuo" style="display:none"></div>
            <div class="cuo1" id="passw2_cuo_info" style="display:none"></div></td>
        </tr>
        <tr>
          <td class="right"><span class="red">*</span> <span class="grayb">真实姓名：</span></td>
          <td colspan="2"><div style="float:left;">
              <input name="mem_name" type="text" id="mem_name"  class="moren" style="width:180px" onblur="formyanzheng('mem_name')" maxlength="50"/>
              &nbsp;&nbsp;
              <input name="per_sex" type="radio" value="男" checked="checked" style="border:0;"/>
              先生
              <input type="radio" name="per_sex" value="女"  style="border:0;"/>
              女士</div>
            <div class="diu" id="mem_name_dui" style="display:none"></div>
            <div class="cuo" id="mem_name_cuo" style="display:none"></div>
            <div class="cuo1" id="mem_name_cuo_info" style="display:none"></div></td>
        </tr>
        <tr>
          <td class="right">&nbsp;</td>
          <td >- 4-20位小写字母、数字或汉字（汉字算两位）组成</td>
        </tr>
        <tr>
          <td class="right"valign="top"><span class="red">*</span> <span class="grayb">邮　　箱：</span></td>
          <td colspan="2"><input name="per_email" type="text" class="moren" id="per_email" style="width:180px" onblur="formyanzheng('per_email')" maxlength="100"/>
            <div class="diu" id="per_email_dui" style="display:none"></div>
            <div class="cuo" id="per_email_cuo" style="display:none"></div>
            <div class="cuo1" id="per_email_cuo_info" style="display:none"></div></td>
        </tr>
        <tr>
          <td class="right">&nbsp;</td>
          <td >- 请确保电子邮箱没有错误，例如webmaster@21-sun.com<br />
            - 您当前的电子邮箱将接收商贸网所有通知及相关新闻期刊</td>
        </tr>
        <tr>
          <td class="right"><span class="red">*</span> <span class="grayb">联系电话：</span></td>
          <td colspan="2"><input name="per_phone" type="text" class="moren" id="per_phone" style="width:180px" onblur="formyanzheng('per_phone')" maxlength="50"/>
            <div class="diu" id="per_phone_dui" style="display:none"></div>
            <div class="cuo" id="per_phone_cuo" style="display:none"></div>
            <div class="cuo1" id="per_phone_cuo_info" style="display:none"></div></td>
        </tr>
        <tr>
          <td class="right">&nbsp;</td>
          <td >- 正确格式例如：13888888888，0535-6727765，05356727765</td>
        </tr>
        <tr>
          <td class="right"><span class="grayb">省　　市：</span></td>
          <td colspan="2"><span class="list_cell_bg">
            <select name="per_province" id="per_province" onchange="set_city(this,this.value,document.theform.per_city,'');" style="width:100px;"  class="blue1" >
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
            <select  name="per_city" id="per_city"  style="width:100px;" class="blue1">
              <option>选择城市</option>
            </select>
            </span></td>
        </tr>
        <tr>
          <td class="right">&nbsp;</td>
          <td >- 选择正确的省市，在您注册成功后会获取更加准确的信息 </td>
        </tr>
        <tr>
          <td class="right"><span class="red">*</span> <span class="grayb">公司名称：</span></td>
          <td colspan="2"><input name="comp_name" type="text"  class="moren" id="comp_name" style="width:300px" onblur="formyanzheng('comp_name')" maxlength="50"/>
            &nbsp;
            <div class="diu" id="comp_name_dui" style="display:none"></div>
            <div class="cuo" id="comp_name_cuo" style="display:none"></div>
			<div class="cuo1" id="comp_name_cuo_info" style="display:none"></div>
			</td>
        </tr>
        <tr>
          <td class="right"><span class="red">*</span> <span class="grayb">公司地址：</span></td>
          <td colspan="2"><input name="comp_address" type="text"  class="moren" id="comp_address" style="width:300px" onblur="formyanzheng('comp_address')" size="50" maxlength="200"/>
            &nbsp;
            <div class="diu" id="comp_address_dui" style="display:none"></div>
            <div class="cuo" id="comp_address_cuo" style="display:none"></div>
			<div class="cuo1" id="comp_address_cuo_info" style="display:none"></div>
			</td>
        </tr>
        <tr>
          <td class="right">&nbsp;</td>
          <td >- 请填写正确的公司地址 </td>
        </tr>
        <tr>
          <td class="right"><span class="red">*</span> <span class="grayb">公司简介：</span></td>
          <td colspan="2"><textarea name="comp_intro" rows="5" class="moren" id="comp_intro" style="width:300px;overflow-y:scroll;" onblur="formyanzheng('comp_intro')" onkeyup="if((this.value).length>1150){ this.value=(this.value).substr(0,1150);alert('描述请控制在1150个汉字以内。');}"></textarea>
            &nbsp;
            <div class="diu" id="comp_intro_dui" style="display:none"></div>
            <div class="cuo" id="comp_intro_cuo" style="display:none"></div>
			<div class="cuo1" id="comp_intro_cuo_info" style="display:none"></div>
			</td>
        </tr>
        <tr>
          <td align="right" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="10px"></td>
              </tr>
              <tr>
                <td align="right"><div align="right"><span class="right"> <span class="grayb">验&nbsp;&nbsp;证&nbsp;&nbsp;码：</span></span></div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table></td>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50%"><table   width="450"  style="height:40px;background:url('/auth/authImg2Servlet?now=<%=new java.util.Date()%>') no-repeat" id="authImg" class="tablezhuce2">
                    <tr>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="48" width="48"  onclick="__showBox(0)"><span id="__box0" name="__box0" style="display:none"><img src="images/reg/checkbox.jpg" name="__box0" id="__box0"></span></td>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="48" width="48"  onclick="__showBox(1)"><span id="__box1" name="__box1" style="display:none"><img src="images/reg/checkbox.jpg" name="__box1" id="__box1" /></span></td>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="50" width="50"  onclick="__showBox(2)"><span id="__box2" name="__box2" style="display:none"><img src="images/reg/checkbox.jpg" name="__box2" id="__box2" /></span></td>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="50" width="50"  onclick="__showBox(3)"><span id="__box3" name="__box3" style="display:none"><img src="images/reg/checkbox.jpg" name="__box3" id="__box3" /></span></td>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="50" width="50"  onclick="__showBox(4)"><span id="__box4" name="__box4" style="display:none"><img src="images/reg/checkbox.jpg" name="__box4" id="__box4" /></span></td>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="50" width="50"  onclick="__showBox(5)"><span id="__box5" name="__box5" style="display:none"><img src="images/reg/checkbox.jpg" name="__box5" id="__box5" /></span></td>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="50" width="50"  onclick="__showBox(6)"><span id="__box6" name="__box6" style="display:none"><img src="images/reg/checkbox.jpg" name="__box6" id="__box6" /></span></td>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="50" width="50"  onclick="__showBox(7)"><span id="__box7" name="__box7" style="display:none"><img src="images/reg/checkbox.jpg" name="__box7" id="__box7" /></span></td>
                      <td onmouseover="this.style.cursor='hand'"  align="left" valign="top" height="50" width="51"  onclick="__showBox(8)"><span id="__box8" name="__box8" style="display:none"><img src="images/reg/checkbox.jpg" name="__box8" id="__box8" /></span></td>
                    </tr>
                  </table></td>
                <td><div class="diu" id="imgstring_dui" style="display:none"></div>
                  <div class="cuo" id="imgstring_cuo" style="display:none"></div>
                  <div class="cuo1" id="imgstring_cuo_info" style="display:none"></div></td>
              </tr>
            </table>
            <span id="__box9" name="__box9" style="display:none"><img src="images/reg/checkbox.jpg" name=""></span>
            <div align="center">
              <table width="100%" border="0" align="left" cellspacing="1" class="p92" id="table3">
                <tr>
                  <td nowrap="nowrap">- 请用鼠标点选上图中所显示的“<font color="#000080"><b>3个挖掘机图案</b></font>” <br />
                    - 如无法点选图片请改用IE或者360浏览器、腾讯TT浏览器访问
                    <input type="hidden"  name="imgstring" id="imgstring" value=""/>
                    <input type="hidden"  name="regCity" id="regCity" value="<%=addr%>"/>
                  </td>
                </tr>
              </table>
            </div></td>
        </tr>
        <tr>
          <td height="30" align="right">&nbsp;</td>
          <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="40%" nowrap="nowrap"><input type="checkbox" id="is_accept" name="is_accept" value="1" checked="checked"  min="1" max="3" onclick="formyanzheng('is_accept')"/>
                  我接受中国工程机械商贸网的<a href="member_reg_fwtk.jsp" target="_blank" class="blue14">服务条款</a></td>
                <td width="60%"><div class="diu" id="is_accept_dui" style="display:none"></div>
                  <div class="cuo" id="is_accept_cuo" style="display:none"></div>
                  <div class="cuo1" id="is_accept_cuo_info" style="display:none"></div></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="30" align="right">&nbsp;</td>
          <td><input type="submit" name="regid" id="regid" value="注 册" class="tijiao" style="cursor:pointer" /></td>
        </tr>
      </table>
    </form>
  </div>
</div>
<div class="top2">
  <div class="centertext_1">
    <div class="renarrow">会员介绍</div>
  </div>
  <div class="centertext">
    <div class="centertext1">
      <div class="centertext2"> <a href="http://main.21-sun.com/service/huiyuan/member_vip.htm" class="b14" target="_blank">VIP会员</a><br/>
        ·市场调研服务<br/>
        ·新闻采访服务<br/>
        ·市场支持服务<br/>
        ·品牌宣传服务</div>
      <div class="centertext3" ><a href="http://main.21-sun.com/service/huiyuan/member_vip.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://main.21-sun.com/service/huiyuan/member_b.htm" class="b14" target="_blank">B类会员</a> <br/>
        ·数据信息支持服务<br/>
        ·新闻采集、报道、采访<br/>
        ·市场信息支持服务<br/>
        ·广告服务支持</div>
      <div class="centertext3" ><a href="http://main.21-sun.com/service/huiyuan/member_b.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://main.21-sun.com/service/huiyuan/member_a.htm" class="b14" target="_blank">A类会员</a> <br/>
        ·网站制作服务<br/>
        ·信息支持服务<br/>
        ·广告服务支持<br/>
        <br/>
      </div>
      <div class="centertext3" ><a href="http://main.21-sun.com/service/huiyuan/member_a.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/rent/gg/huiyuan.htm" class="b14" target="_blank">租赁通会员</a> <br/>
        ·租赁信息排名靠前<br/>
        ·获得网上租赁店铺<br/>
        ·查看客户的留言回馈<br/>
        ·超值广告服务</div>
      <div class="centertext3" ><a href="http://www.21-sun.com/rent/gg/huiyuan.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1_1">
      <div class="centertext2"> <a href="http://www.21-cmjob.com/member/service/index.shtm" class="b14" target="_blank">人才网会员</a> <br/>
        ·金伯乐会员<br/>
        ·超级银伯乐会员<br/>
        ·银伯乐会员<br/>
        ·季度会员</div>
      <div class="centertext3" ><a href="http://www.21-cmjob.com/member/service/index.shtm" target="_blank">查看详情</a></div>
    </div>
  </div>
</div>
<jsp:include page="manage/foot.jsp" />
<script language="javascript">
function setDefaultCity(){
	document.theform.per_province.value="<%=province%>";
	//alert(document.theform.per_province.value);
	set_city(document.theform.per_province,document.theform.per_province.value,document.theform.per_city,'');
	document.theform.per_city.value="<%=city%>";
}
setDefaultCity();
//--<%=Common.getAddressForIp(request,Common.getRemoteAddr(request,1),1)%>==<%=province%>--<%=city%>
</script>
</body>
</html>
