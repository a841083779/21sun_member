<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" %>
<%@ include file ="include/config.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员注册 - 中国工程机械商贸网</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/tablestyle.css" rel="stylesheet" type="text/css" /> 
<link href="style/style_new.css" rel="stylesheet" type="text/css" />
<style>
 .code-ajax { 
    background: url("/images/code-loader.gif") no-repeat scroll 50% 50% transparent; 
    border: 1px solid #555555; 
    height: 30px; 
    margin-bottom: 16px;
    width: 297px;
}
.code-sent {
    border: 1px solid #555555;
    color: #555555;
    line-height: 20px;
    margin-bottom: -4px;
    padding: 5px 10px;
    width: 260px;
}
</style>
<script src="scripts/jquery-1.4.1.min.js"  type="text/javascript"></script>
<script src="scripts/scripts.js" type="text/javascript"></script>
<script language="Javascript" type="text/javascript"  src="scripts/quick2.js" charset="utf-8"></script>
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
function setFocus()
{
	document.getElementById('mem_no').focus();
}
function showPwd()
{
	if($("#showPwdFlag").attr("checked")==true)
	{
		 $("#passw").hide();
		 $("#passw_show").show();
	}else{
		 $("#passw").show();
		 $("#passw_show").hide();
	}
	
}
function pwd_syc(val)
{
	$("#passw").val(val);
	$("#passw_show").val(val);
}
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
</script>
<style type="text/css">
.registBg { position:relative;}
</style>
</head>
<body onload="setFocus();">
<jsp:include page="manage/top_new.jsp" />
<div class="New_registTop contain950">
  <h1><a href="http://www.21-sun.com/" target="_blank"><img src="images/new_logo.gif" alt="中国工程机械商贸网" /></a></h1>
  <h2>用户注册</h2>
</div>
<div class="registForm">
  <div class="registBg">
    <div class="registTop">
      <h3>注册新用户</h3>
      <span>我已经注册，现在就 <a href="/" class="blue">登录</a></span>
    </div>
    <div class="registTable">
      <form id="theform" name="theform" method="post" action="member_reg_action.jsp"  onsubmit="return regYanzheng();" >
      <input type="hidden" id="zd_province" name="zd_province"  />
      <input type="hidden" id="zd_city" name="zd_city"  />
        <table width="98%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <th width="37%"><font>*</font> 用户名：</th>
            <td width="63%"><input type="text" name="mem_no" id="mem_no" class="ri" onfocus="showText('mem_no')" onblur="formyanzheng('mem_no')" onkeyup="isSpecialChar('mem_no')"/>
		    <div class="diu" id="mem_no_dui" style="display:none"></div>
            <div class="cuo" id="mem_no_cuo" style="display:none"></div>
            <div class="cuo1" id="mem_no_cuo_info" style="display:none"></div>
	        <div id="mem_no_show_info" style="display:none; clear:both;">4-18个字母、数字、"-"或"_"，不支持中文和特殊符号。</div>
            </td>
          </tr>
          <tr>
            <th><font>*</font> 密码：</th>
            <td colspan="2" >
            <div style="clear:both"><input type="password" name="passw" id="passw" class="ri" onfocus="showText('passw')" onblur="formyanzheng('passw')" onkeyup="pwStrength(this.value)"/>
            <input type="text" id="passw_show" class="regi" onblur="formyanzheng('passw')" onkeyup="pwStrength(this.value)" style="display:none"/>
	    	<div class="qr">
              <ul>
                <li id="strength_L" class="">弱</li>
                <li id="strength_M" class="">中</li>
                <li id="strength_H" class="">强</li>
              </ul>
            </div>
            <div class="diu" id="passw_dui" style="display:none"></div>
            <div class="cuo" id="passw_cuo" style="display:none"></div>
            <div class="cuo1" id="passw_cuo_info" style="display:none"></div>
            </div>
            <div style="width:100%; float:left;">
              <div id="passw_show_info" style="display:none; width:100%; float:left;">6-16位字符，推荐使用字母、数字、"-"或"_"的组合</div>
              <div style="float:left;"><span style="float:left; padding:3px 3px 0px 0px;"><input type="checkbox" name="showPwdFlag" id="showPwdFlag" onclick="showPwd();"/></span> <span style="float:left; *line-height:26px;">显示密码字符</span></div>
            </div>
            </td>
          </tr> 
          <tr>
            <th><font>*</font> 确认密码：</th>
            <td><input type="password" name="passw2" id="passw2" class="ri" onfocus="this.className='regiHover'" onblur="formyanzheng('passw2')" />
		<div class="diu" id="passw2_dui" style="display:none"></div>
            <div class="cuo" id="passw2_cuo" style="display:none"></div>
            <div class="cuo1" id="passw2_cuo_info" style="display:none"></div>
            </td>
          </tr>
          <tr>
          	<th><font>*</font> 手机：</th>
          	<td colspan="2" style="padding-bottom:0px;"><input name="per_phone" style="width:160px;" type="text" class="ri" id="per_phone" onfocus="this.className='regiHover'" onblur="formyanzheng('per_phone')"/>
          	 <div style="width:auto; float:left; padding-left:8px; padding-top:0px; color:red;">
          	 <input style=" background:url(/images/phone_yzm.gif) no-repeat; width:105px; height:25px; color:#fff; font-size:14px; border:none; cursor:pointer;" type="button" onClick="getRand();" id="code-get" value="获取验证码"/></div>
            <div class="diu" id="per_phone_dui" style="display:none"></div>
            <div class="cuo" id="per_phone_cuo" style="display:none"></div>
            <div class="cuo1" id="per_phone_cuo_info" style="display:none"></div><br style="clear:both;" /><span style="color:red;">请输入手机号码，点击获取验证码</span></td>
          </tr>
          <tr style="display:none;" id="getRand">
          <th></th>
           <td>
             <div class="code-ajax"></div>
             </td>
          </tr>
          <tr id="getRandTxt" style="display:none;">
          	<th></th>
          	<td>
          	<div class="code-sent">验证码将发送到您的手机上<br/>若 <strong>90</strong> 秒后仍未收到验证码短信，请重新获取！</div>
          	</td>
          </tr>
          <tr>
            <th height="30"><font>*</font> 验证码：</th>
            <td colspan="2"><input type="text" name="rand" id="rand" class="ri" style="width:106px;" onkeyup="formyanzheng('rand')" maxlength="4"/>
	  	<div class="diu" id="rand_dui" style="display:none"></div>
        <div class="cuo" id="rand_cuo" style="display:none"></div>
        <div class="cuo1" id="rand_cuo_info" style="display:none"></div>
	    </td>
          </tr>
           <tr>
          	<th><font>*</font> 邮箱：</th>
          	<td colspan="2"><input name="per_email" type="text" class="ri" id="per_email" onfocus="this.className='regiHover'" onblur="formyanzheng('per_email')"/>
            <div class="diu" id="per_email_dui" style="display:none"></div>
            <div class="cuo" id="per_email_cuo" style="display:none"></div>
            <div class="cuo1" id="per_email_cuo_info" style="display:none"></div></td>
          </tr>
          <tr>
          	<th><font>*</font> 注册目的：</th>
          	<td colspan="2">
            <ul class="label">
            <li><span><input type="radio" name="purpose" id="purpose1" value="1" />&nbsp;<label for="1">我只想浏览、发布信息</label></span></li>
            <li><span><input type="radio" name="purpose" id="purpose2" value="2" />&nbsp;<label for="2">希望了解网站所有提供的服务</label></span></li>
            <li><span><input type="radio" name="purpose" id="purpose3" value="3" />&nbsp;<label for="3">人工指导我成为付费会员，查看收费项目信息</label></span></li>
            <li><span><input type="radio" name="purpose" id="purpose4" value="4" />&nbsp;<label for="4">我想了解网建、会员、邮局、3D展厅、管理软件等服务项目的价格</label></span>
			<div class="diu" id="purpose_dui" style="display:none"></div>
            <div class="cuo" id="purpose_cuo" style="display:none"></div>
            <div class="cuo1" id="purpose_cuo_info" style="display:none"></div>
            </li>
            </ul></td>
          </tr>
          <tr>
            <th height="30">&nbsp;</th>
            <td><input type="submit" name="regid" id="regid" value="同意以下协议，提交" class="registBtn" /></td>
          </tr>
        </table>
        <div class="xieyi">
          <div>
            <p>在以下条款中，&quot;用户&quot;是指向中国工程机械商贸网（以下称&quot;商贸网&quot;）申请注册成为商贸网会员的个人或者单位。<br />
              用户同意此在线注册条款之效力如同用户亲自签字、盖章的书面条款一样，对用户具有法律约束力。<br />
              用户进一步同意，用户进入商贸网会员注册程序即意味着用户同意了本注册条款的所有内容且只有用户完全同意所有服务条款并完成注册程序，才能成为商贸网的正式用户。本注册条款自用户注册成功之日起在用户与商贸网之间产生法律效力。</p>
            <p><strong>第一条  商贸网服务简介</strong><br />
              商贸网向其会员用户提供包括信息发布、信息浏览在内的互联网技术服务和网络服务，商贸网所提供的相关服务说明详见WWW.21-SUN.COM相关产品及服务介绍。</p>
            <p><strong>第二条	用户身份保证</strong><br />
              2-1用户承诺并保证自己是具有完全民事行为能力和完全民事权利能力的自然人、法人、实体和组织。用户在此保证所填写的用户信息是真实、准确、完整、及时的，并且没有任何引人误解或者虚假的陈述，且保证商贸网可以通过用户所填写的联系方式与用户取得联系。<br />
              2-2用户应根据商贸网对于相关服务的要求及时提供相应的身份证明等资料，否则商贸网有权拒绝向该会员或用户提供相关服务。<br />
              2-3用户承诺将及时更新其用户信息以维持该等信息的有效性。<br />
              2-4如果用户提供的资料或信息包含有不正确、不真实的信息，商贸网保留取消用户会员资格并随时结束为该用户提供服务的权利。<br />
              2-5以代理人身份代理其他自然人或者单位进行注册用户必须向商贸网提供代理人和被代理人的详细资料和信息及授权书面文件，未向商贸网提供上述资料信息及文件的，商贸网将视注册者为会员。</p>
            <p><strong>第三条  邮件通知</strong><br />
              用户充分理解商贸网将通过电子邮件的方式与注册会员保持联络及沟通，用户在此同意商贸网通过电子邮件方式向其发送包括会员信息、商贸网商品及服务信息在内的相关商业及非商业联络信息。</p>
            <p><strong>第四条	 会员身份确认</strong><br />
              4-1用户注册成功后将得到一个用户名和密码，用户凭用户名和密码享受商贸网向其会员用户提供的商品和服务。<br />
              4-2用户将对用户名和密码安全负全部责任，并且用户对以其用户名进行的所有活动和事件负全责。用户有权根据商贸网规定的程序修改密码。<br />
              4-3非经商贸网书面同意，用户名和密码不得擅自转让或者授权他人使用，否则用户应承担由此造成的一切后果。<br />
              4-4用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通告商贸网。<br />
              <br />
              <strong>第五条  服务条款的修改和服务体系修订</strong><br />
              商贸网有权在必要时修改服务条款，商贸网服务条款一旦发生变动，将会在重要页面上提示修改内容。如果不同意所改动的内容，用户可以主动取消获得的网络服  务。如果用户继续享用商贸网网络服务，则视为接受服务条款的变动。商贸网保留随时修改其服务体系和价格而不需通知用户的权利，商贸网修改其服务和价格体系  之前用户就具体服务与商贸网达成协议并已按照约定交纳费用的，商贸网将按照已达成的协议执行至已交纳费用的服务期期满。</p>
            <p><strong>第六条  用户的权利和义务</strong><br />
              6-1用户有权利拥有自己在商贸网的用户名和密码并有权利使用自己的用户名和密码随时登录商贸网网站的会员专区。<br />
              6-2用户有权利享受商贸网提供的互联网技术和信息服务，并有权利在接受商贸网提供的服务时获得商贸网的技术支持、咨询等服务，服务内容详见商贸网相关产品介绍。<br />
              6-3用户保证不会利用技术或其他手段破坏及扰乱商贸网网站以及商贸网其他客户的网站。<br />
              6-4用户应尊重商贸网及其他第三方的知识产权和其他合法权利，并保证在发生上述事件时尽力保护商贸网及其股东、雇员、合作伙伴等免于因该等事件受到影响或损失；商贸网保留用户侵犯商贸网知识产权时终止向该用户提供服务并不退还任何款项的权利。<br />
              6-5对由于用户向商贸网提供的联络方式有误以及用户用于接受商贸网邮件的电子邮箱安全性、稳定性不佳而导致的一切后果，用户应自行承担责任，包括但不限于因用户未能及时收到商贸网的相关通知而导致的后果和损失。<br />
              6-6用户保证其使用商贸网服务时将遵从国家、地方法律法规、行业惯例和社会公共道德，不会利用商贸网提供的服务进行存储、发布、传播如下信息和内容：违  反国家法律法规政策的任何内容（信息）；违反国家规定的政治宣传和/或新闻信息；涉及国家秘密和/或安全的信息；封建迷信和/或淫秽、色情、下流的信息或  教唆犯罪的信息；博彩有奖、赌博游戏；违反国家民族和宗教政策的信息；防碍互联网运行安全的信息；侵害他人合法权益的信息和/或其他有损于社会秩序、社会  治安、公共道德的信息或内容。用户同时承诺不得为他人发布上述不符合国家规定和/或本服务条款约定的信息内容提供任何便利，包括但不限于设置URL、  BANNER链接等。用户承认商贸网有权在用户违反上述时有权终止向用户提供服务并不予退还任何款项，因用户上述行为给商贸网造成损失的，用户应予赔偿。</p>
            <p><strong>第七条  商贸网的权利和义务</strong><br />
              7-1商贸网应根据用户选择的服务以及交纳款项的情况向用户提供合格的网络技术和信息服务。<br />
              7-2商贸网承诺对用户资料采取对外保密措施，不向第三方披露用户资料，不授权第三方使用用户资料，除非：<br />
              7-2-1依据本协议条款或者用户与商贸网之间其他服务协议、合同、在线条款等规定可以提供；<br />
              7-2-2依据法律法规的规定应当提供；<br />
              7-2-3行政、司法等有权部门要求商贸网提供；<br />
              7-2-4用户同意商贸网向第三方提供；<br />
              7-2-5商贸网解决举报事件、提起诉讼而提交的；<br />
              7-2-6商贸网为防止严重违法行为或涉嫌犯罪行为发生而采取必要合理行动所必须提交的；<br />
              7-2-7商贸网为向用户提供产品、服务、信息而向第三方提供的，包括商贸网通过第三方的技术及服务向用户提供产品、服务、信息的情况。<br />
              7-3商贸网有权使用用户资料。<br />
              7-4商贸网有权利对用户进行审查并决定是否接受用户成为商贸网会员或是否与用户进行某一交易。<br />
              7-5商贸网保留在用户违反国家、地方法律法规规定或违反本在线注册条款的情况下终止为用户提供服务并终止用户帐号的权利，并且在任何情况下，商贸网对任何间接、偶然、特殊及继起的损害不负责任。</p>
            <p><strong>第八条  服务的终止</strong><br />
              8-1用户有权随时申请终止其会员资格或其在商贸网申请的一项或多项服务，但已交纳款项不得要求退还。<br />
              8-2商贸网有权根据实际情况决定取消为用户提供的一项或多项服务，但应退还用户为该服务所交纳款项的剩余部分，除此之外商贸网不承担任何责任。<br />
              8-3   用户申请成为商贸网会员后应当遵守商贸网不时作出的关于反垃圾邮件的决议，用户承诺不会利用商贸网的服务进行任何涉及垃圾邮件的行为，包括但不限于用户利  用商贸网服务器发送垃圾邮件；用户发送垃圾邮件中包含商贸网服务器或IP地址的相关信息；用户发送的垃圾邮件中包含其在商贸网注册域名信息等可能使国内及  国际反垃圾邮件组织认为商贸网或商贸网用户与垃圾邮件事件有关的内容或信息。用户理解一旦发生垃圾邮件事件将对商贸网及其所有用户造成不可挽回的巨大损  失，因此商贸网发现用户有涉及垃圾邮件的行为将立即停止为该用户提供任何服务，无论用户在商贸网享有的服务是收费或者免费亦无论该服务是否直接与发送垃圾  邮件的行为相关，商贸网有权在用户涉及垃圾邮件事件时取消该用户的商贸网会员资格并保留对因用户涉及垃圾邮件给商贸网造成损失索赔的权利。</p>
            <p><strong>第九条  争议解决及法律适用</strong><br />
              9-1因本服务条款有关的一切争议，双方当事人应通过友好协商方式解决。如果协商未成，双方同意向烟台仲裁委员会提交仲裁并接受其仲裁规则。一方提请仲裁的时效为从争议发生之日起六个月。<br />
              9-2本注册条款的效力、解释、履行和争议的解决均适用中华人民共和国法律法规和计算机、互联网行业的规范。</p>
            <p><strong>第十条  不可抗力</strong><br />
              10-1因不可抗力或者其他意外事件，使得本条款履行不可能、不必要或者无意义的，遭受不可抗力、意外事件的一方不承担责任。<br />
              10-2不可抗力、意外事件是指不能预见、不能克服并不能避免且对一方或双方当事人造成重大影响的客观事件，包括但不限于自然灾害如洪水、地震、瘟疫流行和风暴等以及社会事件如战争、动乱、政府行为等。<br />
              10-3用户同意鉴于互联网的特殊性，黑客攻击、互联网连通中断或者系统故障等属于不可抗力，由此给用户或者第三方造成的损失不应由商贸网承担。</p>
            <p><strong>第十一条  附则</strong><br />
              11-1 本注册条款中有关条款若被权威机构认定为无效，不应影响其他条款的效力，也不影响本服务条款的解释、违约责任及争议解决的有关约定的效力。<br />
              11-2 一方变更通知、通讯地址或其他联系方式，应自变更之日起及时将变更后的地址、联系方式通知另一方，否则变更方应对此造成的一切后果承担责任。用户同意，商贸网的有关通知只需在商贸网有关网页上发布即视为送达用户。<br />
              11-3 因商贸网上市、被收购、与第三方合并、名称变更等事由，用户同意商贸网可以将其权利和/或义务转让给相应的商贸网权利/义务的承受者。</p>
            <p> 用户在此再次保证已经完全阅读并理解了上述会员注册条款并自愿正式进入商贸网会员在线注册程序，接受上述所有条款的约束。</p>
          </div>
        </div>
      </form>
       <input type="hidden" name="loginCity" id="loginCity"  />
    </div>
    <div style="position: absolute; top: 61px; left: 21px;"><a title="六月樱桃红，饮水思源，感恩客户" target="_blank" href="http://ad.21-sun.com/link_to.jsp?paras=0,0,100026&url=www.21taiyang.com/activity/dayingtao/index.jsp"><img width="182" height="477" alt="六月樱桃红，饮水思源，感恩客户" src="http://www.21-sun.com/homepic/21taiyang/dyt_huiyuan.jpg"></a></div>
  </div>
  <div class="clear"></div>
</div>
<jsp:include page="manage/foot_new.jsp" />
</body>
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/ecmascript"></script>
<script type="text/javascript">
	function getIpPlace() {
		document.getElementById("zd_province").value = remote_ip_info["province"];
		document.getElementById("zd_city").value = remote_ip_info["city"];
		document.getElementById("loginCity").value = remote_ip_info["province"]+remote_ip_info["city"];
		console.log(jQuery("#loginCity").val()) ;
	} 
	getIpPlace();
	var Time = 90, TimerID;
	function Timer(){
		var _1 = jQuery('div.code-sent');
		Time -= 1;
		_1.find('strong').text(Time);
		if( Time == 0 ){
		Time = 90;
		_1.hide().end().find('strong').text(Time);
		clearInterval(TimerID);
		jQuery('#code-get').removeAttr('disabled');
		}
	} 
	var per_phone = '' ;
	var _oldhtml = jQuery("#getRandTxt div").html() ;
	function getRand(){
	 per_phone = jQuery("#per_phone").val() ;
	  if(formyanzheng('per_phone')){
	 	jQuery.ajax({
	 	 url:'/tools/ajax.jsp',
	 	 type:'post',
	 	 data:{flag:'getRand',tel:jQuery("#per_phone").val()},
	 	 success:function(msg){ 
	 	    if(jQuery.trim(msg)==1){
	 	    	 jQuery("#getRandTxt").show() ;
	  			 jQuery('div.code-sent').show();
	 	         jQuery("#getRandTxt div").html(_oldhtml) ;
	 	         jQuery('#code-get').attr('disabled','disabled');
	 	    	 TimerID = setInterval('Timer()', 1000);
	 	    }else if(jQuery.trim(msg)==3){
	 	      	 jQuery("#getRandTxt").show() ;
	 	         jQuery("#getRandTxt div").html("<font color='red'>每个手机号一天最多获取3次</font>") ;
	 	    }else if(jQuery.trim(msg)==5){
	 	      	 jQuery("#getRandTxt").show() ;
	 	         jQuery("#getRandTxt div").html("<font color='red'>每个IP一天最多获取5次</font>") ;
	 	    }else if(jQuery.trim(msg)==2000){
	 	      	 jQuery("#getRandTxt").show() ;
	 	         jQuery("#getRandTxt div").html("<font color='red'>一天最多获取2000次</font>") ;
	 	    }
	 	 }
	 	}) ; 
	 }
	}
	jQuery("#per_phone").keyup(function(){
	  if(per_phone!=jQuery("#per_phone").val() && formyanzheng('per_phone')){
	  	jQuery('#code-get').removeAttr('disabled');
	  	 jQuery("#getRandTxt").hide() ;
	  	  clearInterval(TimerID);
	  	  Time = 90 ;
	  	  jQuery("#getRandTxt div").html(_oldhtml) ;
	  }
	}) ;
</script> 
<script src="scripts/zhucheyanzheng.js"  type="text/javascript"></script>
</html>
