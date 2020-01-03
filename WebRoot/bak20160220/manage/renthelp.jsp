<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="org.apache.commons.httpclient.params.HttpMethodParams"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%><%
	String purviewName =Common.getFormatStr(request.getParameter("purviewName"));	
	String session_mem_no="",session_mem_name="",session_comp_name="",session_per_email="",session_per_phone="",session_mem_flag="";
	
	HashMap memberInfo = new HashMap();
	if (session.getAttribute("memberInfo") != null) {
		memberInfo = (HashMap) session.getAttribute("memberInfo"); 
		session_mem_no = String.valueOf(memberInfo.get("mem_no"));                         //登陆账号
		session_mem_name = String.valueOf(memberInfo.get("mem_name"));                     //姓名
		session_per_email = String.valueOf(memberInfo.get("per_email")); 
		session_per_phone = String.valueOf(memberInfo.get("per_phone")); 
		session_comp_name = String.valueOf(memberInfo.get("comp_name")); 
		session_mem_flag= String.valueOf(memberInfo.get("mem_flag")); //会员级别
	}	
	String flagvalue    =  Common.getFormatStr(request.getParameter("flagvalue"));
	String zd_mem_name  =  Common.getFormatStr(request.getParameter("zd_mem_name"));
	String zd_comp_name =  Common.getFormatStr(request.getParameter("zd_comp_name"));
	String zd_telephone =  Common.getFormatStr(request.getParameter("zd_telephone"));
	String zd_email     =  Common.getFormatStr(request.getParameter("zd_email"));
	String zd_content   =  Common.getFormatStr(request.getParameter("zd_content"));
	String sql="";
	int result=0;
	
	String pageName="renthelp.jsp?purviewName="+purviewName;
	String[][] tempInfo=null;
	try{
	if(flagvalue.equals("1")){  //=====插入留言===
	
		tempInfo=DataManager.fetchFieldValue(pool,"member_applyonline","id","mem_no='"+session_mem_no+"' and apply_mem_flag='1005'");
		if(tempInfo!=null){
		   out.print("<script>alert('提交失败！您已经提交申请，请耐心等待！我们将尽快与您取得联系！');window.location.href='"+pageName+"';</script>");
		}else{			
			 sql="insert into member_applyonline(mem_no,add_date,add_ip,mem_name,comp_name,telephone,email,content,apply_mem_flag,catalog_no)"+"values('"+session_mem_no+"',getdate(),'"+Common.getRemoteAddr(request,1)+"','"+zd_mem_name+"','"+zd_comp_name+"','"+zd_telephone+"','"+zd_email+"','"+zd_content+"','1005','rent')";
			result=DataManager.dataOperation(pool,sql);
			if(result>0){
				//sendEmail--add by gaopeng 20130408--begin
				try{				
					HttpClient client = new HttpClient();
					PostMethod method =new PostMethod("http://service.21-sun.com/http/utils/sendmail.jsp");
					method.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
					String fixed = "21sun";
					String mailto="zhangchen@21-sun.com";
					String mailcc="zhenghj@21-sun.com";
					String mailbcc="gaopeng@21-sun.com";
					String title="租赁通会员申请邮件";
					String content = "";
					
					//内容
					content = "<table cellpadding='5' cellspacing='5'>";
					content += "<tr><td colspan='2'><b>申请会员信息</b></td></tr>";
					content += "<tr>";
					content += "<td>申请会员类型：</td><td>租赁通</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td>申请人：</td><td>"+ zd_mem_name+"</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td>公司名称：</td><td>"+ zd_comp_name+"</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td>联系电话：</td><td>"+ zd_telephone+"</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td>Email：</td><td>"+ zd_email+"</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td>说明：</td><td>"+ zd_content+"</td>";
					content += "</tr>";
					content += "</table>";
					String fromName="来自21-sun";
					NameValuePair[] data ={ new NameValuePair("to",mailto),new NameValuePair("cc",mailcc),new NameValuePair("bcc",mailbcc),new NameValuePair("title",title),new NameValuePair("content",content),new NameValuePair("fromName",fromName),new NameValuePair("fixed",fixed)};
					method.setRequestBody(data);
					Object a = client.executeMethod(method);
					if(a!=null){
						String resultBack = a.toString();
						if(resultBack.equals("200")){
							//System.out.println("邮件发送成功！");
						}else{
							//System.out.println("邮件发送不成功！");
						}
					}else{
						//System.out.println("邮件发送不成功！");
					}
					// 释放连接
					method.releaseConnection();
				}catch (Exception e) { 
					e.printStackTrace();
				}
				//sendEmail--add by gaopeng 20130408--end
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
    //return false;
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
    <td width="89%" style="padding-left:15px" class="red18">很抱歉，您不是<%if(session_mem_flag.equals("1005"))out.print("租赁站长");else out.print("租赁通");%>用户,不能管理“<%=purviewName%>”<br />赶快<a class="jiaru" href="#shenqing">申请加入</a>吧！</td>
  </tr>
</table>
<!--发布二手设备信息 -->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">租赁通会员发布信息总是优先显示</div>
    <div class="parthelp_2_0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中国工程机械租赁调剂中心同类信息列表中，租赁通会员信息优先排名。 
优先享有租赁市场中大量最新租赁信息，随时通过电话、报价留言、E-mail等多种方式迅速联系买家，抢占先机。 
      <br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;不限量发布您的企业、商机、产品信息，更可进行产品图片上传展示。 </div>
    <span id="submenu1" style="display:none;">
    <table width="100%" border="0">
      <tr>
        <td colspan="2">
            <img src="part1.gif" width="760" height="181" />
        </td>
      </tr>
    </table>
    </span> </div>
  <div class="clear"></div>
</div>
<!--接收二手设备订单 -->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">租赁通会员信誉高，成交机会更高</div>
    <div class="parthelp_2_0"><span style="color:#ff6600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;各地站长组织租赁通会员开展联合租赁（多家租赁公司联合向需求量大的客户提供租赁），使中小型租赁企业形成合力，联合租赁，增强了竞争力。</span><br />
——分站、主站多级考核，让其它会员更放心；<br />
——租赁通会员的信息不但在本地区优先得到推广，而在租赁中心首页都会得到推荐；<br />
——租赁通会员会得到更高的资质认证，在网上具有更高信誉度。
99%的会员优先考虑跟租赁通会员做生意 。</div>
    <span id="submenu2" style="display:none;">
    <table width="100%" border="0">
      <tr>
        <td colspan="2">
            <img src="part2.gif" />
        </td>
      </tr>
    </table>
    </span> </div>
  <div class="clear"></div>
</div>
<!--加入二手商家目录-->
<div class="parthelp">
  <div class="parthelp_1">
    <div class="yaheij1_1">注册租赁通会员，三分钟拥有个性租赁店铺</div>
    <div class="parthelp_2">您将得到一个供客户查看的网上租赁商铺（即一个自己的网站页面）；<br />
独立的店铺风格及后台管理系统，随时定制自己的网站，全方位展示自己
；<br />
您还会得到一个会员管理助手，来管理您的商铺；<br />
3款商铺风格，随意选择搭配 。</div>
    <div class="parthelp_2_1"><span class="porangb" id="imgmenu3" onclick="showsubmenu(3);" style="cursor:pointer">点击查看详情</span></div>
    <span id="submenu3" style="display:none;float:left">
    <table width="100%" border="0">
      <tr>
        <td colspan="2">
            <img src="part6.jpg" />
        </td>
      </tr>
    </table>
    </span> </div>
  <div class="clear"></div>
</div>
<!--加入二手商家目录-->
<!--登录-->
<div class="parthelp">
  <div class="parthelp_1">
  <div class="yaheij1_1" name="shenqing" id="shenqing">申请加入<%if(session_mem_flag.equals("1005"))out.print("租赁站长");else out.print("租赁通");%>用户</div>
   <form id="theform1" name="theform1" method="post" action="">
    <table width="98%" border="0" align="right" cellpadding="0" cellspacing="0">
      <tr>
        <td width="14%"><strong>
          申请人：  
        </strong></td>
        <td width="86%" style="padding-top:10px;"><label>
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
<script type="text/javascript" src="../scripts/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
$(function(){
  $("a").each(function (){
    var link = $(this);
    var href = link.attr("href");
    if(href && href[0] == "#")
    {
      var name = href.substring(1);
      $(this).click(function() {
        var nameElement = $("[name='"+name+"']");
        var idElement = $("#"+name);
        var element = null;
        if(nameElement.length > 0) {
          element = nameElement;
        } else if(idElement.length > 0) {
          element = idElement;
        }
 
        if(element) {
          var offset = element.offset();
          window.parent.scrollTo(offset.left, offset.top);
        }
 
        return false;
      });
    }
  });
});
</script>
</html><%
}catch(Exception e){
	Common.println(e);
}
%>