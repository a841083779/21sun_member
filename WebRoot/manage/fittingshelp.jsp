<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%><%
	String purviewName =Common.getFormatStr(request.getParameter("purviewName"));
	
	String session_mem_no="",session_mem_name="",session_comp_name="",session_per_email="",session_per_phone="";
	
	HashMap memberInfo = new HashMap();
	if (session.getAttribute("memberInfo") != null) {
		memberInfo = (HashMap) session.getAttribute("memberInfo"); 
		session_mem_no = String.valueOf(memberInfo.get("mem_no"));                         //登陆账号
		session_mem_name = String.valueOf(memberInfo.get("mem_name"));                     //姓名
		session_per_email = String.valueOf(memberInfo.get("per_email")); 
		session_per_phone = String.valueOf(memberInfo.get("per_phone")); 
		session_comp_name = String.valueOf(memberInfo.get("comp_name")); 
	}
	
	
	String flagvalue    =  Common.getFormatStr(request.getParameter("flagvalue"));
	String zd_mem_name  =  Common.getFormatStr(request.getParameter("zd_mem_name"));
	String zd_comp_name =  Common.getFormatStr(request.getParameter("zd_comp_name"));
	String zd_telephone =  Common.getFormatStr(request.getParameter("zd_telephone"));
	String zd_email     =  Common.getFormatStr(request.getParameter("zd_email"));
	String zd_content   =  Common.getFormatStr(request.getParameter("zd_content"));
	String sql="";
	int result=0;
	
	String pageName="fittingshelp.jsp?purviewName="+purviewName;
	String[][] tempInfo=null;
	try{
	if(flagvalue.equals("1")){  //=====插入留言===
	
		tempInfo=DataManager.fetchFieldValue(pool,"member_applyonline","id","mem_no='"+session_mem_no+"' and apply_mem_flag='1011'");
		if(tempInfo!=null){
		   out.print("<script>alert('提交失败！您已经提交申请，请耐心等待！我们将尽快与您取得联系！');window.location.href='"+pageName+"';</script>");
		}else{			
			 sql="insert into member_applyonline(mem_no,add_date,add_ip,mem_name,comp_name,telephone,email,content,apply_mem_flag,catalog_no)"+"values('"+session_mem_no+"',getdate(),'"+Common.getRemoteAddr(request,1)+"','"+zd_mem_name+"','"+zd_comp_name+"','"+zd_telephone+"','"+zd_email+"','"+zd_content+"','1011','fittings')";
			result=DataManager.dataOperation(pool,sql);
			if(result>0){
			   out.print("<script>alert('申请已提交成功,我们将尽快与您取得联系!');window.location.href='"+pageName+"';</script>");
			}else{
			   out.print("<script>window.location.href='"+pageName+"';</script>"); 
			}	
		}
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/help.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript"> 
function showsubmenu(sid)
{
    var whichEl = document.getElementById("submenu" + sid)||null, imgmenu = document.getElementById("imgmenu" + sid)||null;
    if (!whichEl || !imgmenu) return false;    
    whichEl.style.display = whichEl.style.display && true ? "" : "none";
    imgmenu.background = whichEl.style.display && true ? "../internet/images/nei_21.gif" : "../internet/images/nei_17.gif";
   // return false;
   f_iframeResize();
} 
 function dosubmit(){
      var zd_mem_name  = document.getElementById('zd_mem_name');
	  var zd_comp_name = document.getElementById('zd_comp_name');
	  var zd_telephone = document.getElementById('zd_telephone');
	  var zd_email     = document.getElementById('zd_email');
	  
  	  if(zd_mem_name.value==''){
	     alert("申请人不能为空！");
		 zd_mem_name.focus();
		 return false;
	  }else if(zd_comp_name.value==''){
	     alert("公司名称不能为空！");
		 zd_comp_name.focus();
		 return false;
	  }else if(zd_telephone.value==''){
	     alert("联系电话不能为空！");
		 zd_telephone.focus();
		 return false;
	  }else if(zd_email.value==''){
	     alert("E-mail不能为空！");
		 zd_email.focus();
		 return false;
	  }
	  document.theform1.submit();
  }
</script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color:#f7f7f7 ; border: 4px solid #eaf2fd">
  <tr>
    <td width="11%"><img src="sorry.jpg" width="133" height="80" /></td>
    <td width="89%" style="padding-left:15px" class="red18">很抱歉，您不是配套网正式会员，不能“<%=purviewName%>”<br />赶快<a class="jiaru" href="#shenqing">申请加入</a>吧！</td>
  </tr>
</table>
<!--发布二手设备信息 -->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">发布配套合作信息</div>
    <div class="parthelp_2_0">拥有发布配套合作信息的权限，能够让企业获得更多的配套合作机会。 </div>
    </div>
  <div class="clear"></div>
</div>
<!--接收二手设备订单 -->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">发布代理招商信息</div>
    <div class="parthelp_2_0">拥有发布代理招商信息的权限，扩大网络招商覆盖面，降低招商成本。</div>
    </div>
  <div class="clear"></div>
</div>
<!--加入二手商家目录-->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">发布产品信息</div>
    <div class="parthelp_2">拥有发布产品信息的权限，拥有企业自己的形象站，充分展示企业形象和产品，潜在提高企业宣传力度。</div>
    </div>
  <div class="clear"></div>
</div>
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">配套网正式会员服务</div>
    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="showsubmenu(1);" style="cursor:pointer">点击查看详情</span></div>
    <span id="submenu1" style="display:none;float:left;overflow:hidden">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td><b>一、信息互动服务</b><br>
		1、 
		发布商机栏目信息，包括：配套合作、代理招商、求购信息、供应信息等，无数量限制，免审核，拥有“在线交流”和“在线留言”互动功能，抢占市场先机；<br>
		2、 发布产品信息，无数量限制，免审核，拥有“在线交流”和“在线留言”互动功能，拥有更多展示位置，获得更多合作机会；<br>
		3、 查看配套网资讯、品牌、商机、产品、企业栏目所有信息，随时掌握行业动态、获取最新市场信息；<br>
		4、 可选择查看配套网“数据”栏目两种整机类型的“月度数据”和“月度报告”、配套件数据信息、海关进出口数据。<br>
		<br>
		<b>二、品牌推广服务</b><br>
		1、提供“企业特别活动专题”服务一次，并在配套网首页“企业专题”进行图片宣传3天，在中国工程机械商贸网“专题报道”栏目进行图片及文字新闻报道一周，价值8000元；<br>
		2、在配套网首页‘产品展示’版块对应类别处进行“图片产品展示”3个月，价值1500元；<br>
		3、在配套网首页‘企业推荐’处进行文字推荐3个月，价值1500元；<br>
		4、提供企业动态、最新产品等企业新闻发布服务，每月一篇，价值5000元；<br>
		5、提供“高层专访”服务一次，并在配套网“资讯”栏目首页进行‘图片专访’宣传3天，在中国工程机械商贸网“21-sun采写”栏目中进行及时专访报道，价值4500元；<br>
		7、自动加入“企业库”栏目，拥有企业“形象站”，获得优先显示机会，排名高于免费会员，价值3800元；<br>
		8、所发布的商机信息随时在配套网首页进行展示，并优先显示于免费会员所发布的商机和产品信息。<br>
		<br>
		<b>三、会员增值服务</b><br>
		1、每周2、5定期获取中国工程机械商贸网电子期刊；<br>
		2、随时登录查看访客的浏览量（包括所发布的商机、产品）、访客详细联系方式、点击量来源图表分析等，有效发挖潜在商机；<br>
		3、随时登录查看客户留言，及时回复、管理留言，并能即时接收到客户的留言邮件。<br>
		<br>
		<b>配套网正式会员服务费用：19800元/年</b></td>
	</tr>
</table>
    </span> </div>
  <div class="clear"></div>
</div>
<!--登录-->
<div class="parthelp" style="height:auto;overflow:hidden">
  <div class="parthelp_1">
  <div class="yaheij1_1">申请加入配套网正式会员<a name="shenqing" id="shenqing"></a></div>
    <form id="theform1" name="theform1" method="post" action="">
    <table width="98%" border="0" align="right" cellpadding="0" cellspacing="0">
      <tr>
        <td width="14%"><strong>
          申请人：  
        </strong></td>
        <td width="86%" style="padding-top:10px;">
          <label>
           <input type="text" name="zd_mem_name" id="zd_mem_name" value="<%=Common.getFormatStr(session_mem_name)%>"/>
          </label>
        </td>
      </tr>
      <tr>
        <td><strong>
          公司名称：  
        </strong></td>
        <td style="padding-top:10px;">          
          <label>
            <input type="text" name="zd_comp_name" id="zd_comp_name" value="<%=Common.getFormatStr(session_comp_name)%>"/>
          </label>
        </td>
      </tr>
      <tr>
        <td><strong>
          联系电话：  
        </strong></td>
        <td style="padding-top:10px;">
          <label>
            <input type="text" name="zd_telephone" id="zd_telephone" value="<%=Common.getFormatStr(session_per_phone)%>"/>
          </label>
        </td>
      </tr>
      <tr>
        <td><strong>
          Email：  
        </strong></td>
        <td style="padding-top:10px;">
          <label>
            <input type="text" name="zd_email" id="zd_email" value="<%=Common.getFormatStr(session_per_email)%>"/>
          </label>
        </td>
      </tr>
      <tr>
        <td><strong>
          说明：  
        </strong></td>
        <td style="padding-top:10px;">
          <label>
            <textarea name="zd_content" id="zd_content" cols="45" rows="5"></textarea>
          </label>
      </td>
      </tr>
      <tr><td colspan="2" style="padding:15px 120px;"><img src="tj.jpg" onclick="javascript:dosubmit();" style="cursor:pointer"/></td></tr>
    </table>
	<input name="flagvalue" id="flagvalue" value="1" type="hidden"/>
	</form>
  <div class="clear"></div>
  </div>
</div>
<script>
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
</script>
</body>
</html><%
}catch(Exception e){
	Common.println(e);
}
%>