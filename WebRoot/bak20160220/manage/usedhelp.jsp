<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
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
	
	String pageName="usedhelp.jsp?purviewName="+purviewName;
	String[][] tempInfo=null;
	try{
	if(flagvalue.equals("1")){  //=====插入留言===
	
		tempInfo=DataManager.fetchFieldValue(pool,"member_applyonline","id","mem_no='"+session_mem_no+"' and apply_mem_flag='1008'");
		if(tempInfo!=null){
		   out.print("<script>alert('提交失败！您已经提交申请，请耐心等待！我们将尽快与您取得联系！');window.location.href='"+pageName+"';</script>");
		}else{			
			 sql="insert into member_applyonline(mem_no,add_date,add_ip,mem_name,comp_name,telephone,email,content,apply_mem_flag,catalog_no)"+"values('"+session_mem_no+"',getdate(),'"+Common.getRemoteAddr(request,1)+"','"+zd_mem_name+"','"+zd_comp_name+"','"+zd_telephone+"','"+zd_email+"','"+zd_content+"','1008','used')";
			result=DataManager.dataOperation(pool,sql);		
			if(result>0){
			   out.print("<script>alert('申请已提交成功,我们将尽快与您取得联系!');window.location.href='"+pageName+"';</script>");
			}else{
			   out.print("<script>window.location.href='"+pageName+"';</script>"); 
			}	
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/help.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript"> 
function showsubmenu(sid)
{   var whichEl = document.getElementById("submenu" + sid)||null, imgmenu = document.getElementById("imgmenu" + sid)||null;
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
    <td width="89%" style="padding-left:15px" class="red18">很抱歉，您不是高级二手用户,不能“<%=purviewName%>”<br />赶快<a class="jiaru" href="usedhelp.jsp?#shenqing">申请加入</a>吧！</td>
  </tr>
</table>
<!--发布二手设备信息 -->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">发布二手设备信息</div>
    <div class="parthelp_2">免费发布可信二手机设备信息，确保已发布的产品信息为真空有效，客户可放心询价、购买。</div>
    <div class="parthelp_2_1"><span class="porangb" id="imgmenu1" onclick="showsubmenu(1);" style="cursor:pointer">点击查看详情</span></div>
    <span id="submenu1" style="display:none;float:left">
    <table width="100%" border="0">
      <tr>
        <td colspan="2">
            <img src="part5.gif"/>
        </td>
      </tr>
    </table>
    </span> </div>
  <div class="clear"></div>
</div>
<!--接收二手设备订单 -->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">接收二手设备订单</div>
    <div class="parthelp_2">接收客户对已发布的设备信息订购信息,及时联系有购买意向的客户。</div>
    <div class="parthelp_2_1"><span class="porangb" id="imgmenu2" onclick="showsubmenu(2);" style="cursor:pointer">点击查看详情</span></div>
    <span id="submenu2" style="display:none;float:left">
    <table width="100%" border="0">
      <tr>
        <td colspan="2">
            <img src="part4.jpg" />
        </td>
      </tr>
    </table>
    </span> </div>
  <div class="clear"></div>
</div>
<!--加入二手商家目录-->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">发布二手新闻</div>
    <div class="parthelp_2">企业的最新新闻、动态信息在公司二级域名处独家显示，给用户提供专属发布信息的平台。</div>
    <div class="parthelp_2_1"><span class="porangb" id="imgmenu3" onclick="showsubmenu(3);" style="cursor:pointer">点击查看详情</span></div>
    <span id="submenu3" style="display:none;float:left">
    <table width="100%" border="0">
      <tr>
        <td colspan="2">
            <img src="part7.gif" />
        </td>
      </tr>
    </table>
    </span> </div>
  <div class="clear"></div>
</div>
<!--加入二手商家目录-->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">加入二手商家目录</div>
    <div class="parthelp_2">依托商贸网二手站拥二级域名独立展场，发布公司介绍、公司新闻动态、出售求购信息以及二手产品展示等。</div>
    <div class="parthelp_2_1"><span class="porangb" id="imgmenu4" onclick="showsubmenu(4);" style="cursor:pointer">点击查看详情</span></div>
    <span id="submenu4" style="display:none;float:left">
    <table width="100%" border="0">
      <tr>
        <td colspan="2">
            <img src="part5.jpg" />
        </td>
      </tr>
    </table>
    </span> </div>
  <div class="clear"></div>
</div>
<!--登录-->
<div class="parthelp">
  <div class="parthelp_1">
  <div class="yaheij1_1">申请加入高级二手会员 <a name="shenqing" id="shenqing"></a></div>
   <form id="theform1" name="theform1" method="post" action="">
    <table width="98%" border="0" align="right" cellpadding="0" cellspacing="0">
      <tr>
        <td width="14%"><strong>
          申请人：  
        </strong></td>
        <td width="86%" style="padding-top:10px;"><label>
           <input type="text" name="zd_mem_name" id="zd_mem_name" value="<%=Common.getFormatStr(session_mem_name)%>"/>
          </label></td>
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
        <td style="padding-top:10px;"><label>
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