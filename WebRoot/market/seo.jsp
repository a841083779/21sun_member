<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
ResultSetMetaData rsmd = null;

String seo_title_session="",seo_keywords_session="",seo_description_session="";
String mem_no_session="";

String zd_mem_no="";
String zd_seo_title="",zd_seo_keywords="",zd_seo_description="";

String flagvalue = Common.getFormatInt(request.getParameter("flagvalue"));  //是否为修改
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
String sqlMemInfo="";

String querySql="";

try{
	conn = pool.getConnection();	
	mem_no_session = Common.getFormatStr(memberInfo.get("mem_no"));
	
	seo_title_session = Common.getFormatStr(memberInfo.get("seo_title"));
	seo_keywords_session = Common.getFormatStr(memberInfo.get("seo_keywords"));
	seo_description_session = Common.getFormatStr(memberInfo.get("seo_description"));
	
 
   int result=0;
   if(flagvalue.equals("1")){
	   zd_mem_no = Common.getFormatStr(request.getParameter("zd_mem_no"));
	   zd_seo_title = Common.getFormatStr(request.getParameter("zd_seo_title"));
	   zd_seo_keywords = Common.getFormatStr(request.getParameter("zd_seo_keywords"));
	   zd_seo_description = Common.getFormatStr(request.getParameter("zd_seo_description"));
	
	  if(!zd_mem_no.equals("")){   
		 sqlMemInfo = "update member_info set seo_title='"+zd_seo_title+"',seo_keywords='"+zd_seo_keywords+"',seo_description='"+zd_seo_description+"' where mem_no='"+zd_mem_no+"'  ";
		 result = DataManager.dataOperation(pool,sqlMemInfo);
		 		 
		if(result>0){
			memberInfo.put("seo_title",zd_seo_title);
			memberInfo.put("seo_keywords",zd_seo_keywords);
			memberInfo.put("seo_description",zd_seo_description);
			out.print("<script>alert('seo设置成功!');window.location.href='/market/seo.jsp';</script>");
		}else{
			out.print("<script>alert('网络异常，请稍后重试!');</script>");
		}
	   }
     }	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>seo设置 - 中国工程机械商贸网</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<link href="../style/style_new.css" rel="stylesheet" type="text/css" />
<script src="/scripts/jquery-1.4.1.min.js"></script>
<script src="/scripts/jquery.form.js"></script>
<script src="/scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/regmoreyanzheng.js"  type="text/javascript"></script>
<style type="text/css">
	.parthelp_1 td {
		vertical-align:middle;
		padding:10px 0;
	}
	
	.parthelp_1 input {
		margin: 0;
		font-size: 12px;
		color: #676767;
		line-height: 22px;
		height:22px;
	}
</style>
<script type="text/javascript">
	function memberApply(){
      var zd_mem_name  = document.getElementById('zd_mem_name');
	  var zd_comp_name = document.getElementById('zd_comp_name');
	  var zd_telephone = document.getElementById('zd_telephone');
	  var zd_email     = document.getElementById('zd_email');
	  
  	  if(zd_mem_name.value==''){
	     alert("申请人不能为空！");
		 zd_mem_name.focus();
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
	  
	  jQuery("#theform1").ajaxSubmit({
		type : "POST",
		async : false ,
		success : function(data) {
			var rs = parseInt(jQuery.trim(data), 10);
			if (rs == 0 ) {
				alert("网络异常，请稍后重试");
			}else if (rs == 2){
				alert('您已经提交过申请，请耐心等待！我们将尽快与您取得联系！');
			}else{
				alert('申请已提交成功,我们将尽快与您取得联系!');
			}
		}
	  });
	}
</script>
</head>
<body style="background-color:transparent;">
  <%
  	if(!mem_flag.equals("1003")){
  %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color:#f7f7f7 ; border: 4px solid #eaf2fd">
	  <tr>
	    <td width="11%"><img src="/manage/sorry.jpg" width="133" height="80" /></td>
	    <td width="89%" style="padding-left:15px" class="red18">很抱歉，您不是A类会员，不能进行seo设置。<br />赶快申请加入吧！<a href="http://www.21-sun.com/service/huiyuan/member_a.htm" target="_blank" style="text-decoration:underline">查看A类会员服务</a>　　联系电话：0535-6727799</td>
	  </tr>
  </table>
  <div class="parthelp" style="margin-left:20px; margin-top:20px;">
	  <div class="parthelp_1">
	  <div class="yaheij1_1">申请加入A类会员</div>
	  <form id="theform1" name="theform1" method="post" action="member_apply.jsp">
	    <table width="98%" border="0" align="right" cellpadding="0" cellspacing="0">
	      <tr>
	        <td width="14%"><strong>
	          联系人：  
	        </strong></td>
	        <td width="86%">
	          <label>
	            <input type="text" name="zd_mem_name" id="zd_mem_name" value="<%=Common.getFormatStr(memberInfo.get("mem_name")) %>" />
	          </label></td>
	      </tr>
	      <tr>
	        <td><strong>
	          联系电话：  
	        </strong></td>
	        <td>
	          <label>
	            <input type="text" name="zd_telephone" id="zd_telephone" style="width:150px;" value="<%=Common.getFormatStr(memberInfo.get("per_phone")) %>" />
	          </label>
	        </td>
	      </tr>
	      <tr>
	        <td><strong>
	          Email：  
	        </strong></td>
	        <td>
	          <label>
	            <input type="text" name="zd_email" id="zd_email" style="width:200px;" value="<%=Common.getFormatStr(memberInfo.get("per_email")) %>" />
	          </label>       
	        </td>
	      </tr>
	      <tr>
	        <td><strong>
	          留言：  
	        </strong></td>
	        <td>
	          <label>
	            <textarea name="zd_content" id="zd_content" cols="45" rows="5"></textarea>
	          </label>
	        </td>
	      </tr>
	      <tr>
	      	<td></td>
	      	<td><img src="/manage/tj.jpg" onclick="memberApply();" style="cursor:pointer;"/></td>
	      </tr>
	    </table>
	    <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=mem_no_session%>" />
        <input name="zd_comp_name" type="hidden" id="zd_comp_name" value="<%=Common.getFormatStr(memberInfo.get("comp_name"))%>" />
		</form>
	  <div class="clear"></div>
	  </div>
	</div>
  <%
  	}else{
  %>
  <div class="moreInfo">
  <div class="registTitle">seo设置 <span>合理的seo设置有利于获得更多的访问机会！</span></div>
  <form method="post" name="theform" id="theform" onsubmit="return submityz2();">
      <table width="950" border="0" cellspacing="0" cellpadding="0" class="registMore">
        <tr>
          <th width="130px"><font>*</font>首页title：</th>
          <td>
          	<input name="zd_seo_title" type="text" style="width:480px;" class="ri" id="zd_seo_title" onblur="formyanzheng('zd_seo_title')" value="<%=seo_title_session.equals("") ? Common.getFormatStr(memberInfo.get("comp_name"))+" - 中国工程机械商贸网" : seo_title_session %>" onfocus="showText('zd_seo_title')"/>
          	<div style="display:none;" id="zd_seo_title_dui" class="diu"></div>
            <div style="display:none;" id="zd_seo_title_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_seo_title_cuo_info" class="cuo1"></div>	
          </td>
        </tr>
        <tr>
          <th><font>*</font>企业keywords：</th>
          <td style="padding-bottom:0;">
          	<input name="zd_seo_keywords" type="text" style="width:480px;" class="ri" id="zd_seo_keywords" onblur="formyanzheng('zd_seo_keywords')" value="<%=seo_keywords_session.equals("") ? Common.getFormatStr(memberInfo.get("comp_name"))+"产品,"+Common.getFormatStr(memberInfo.get("comp_name"))+"介绍" : seo_keywords_session %>" onfocus="showText('zd_seo_keywords')"/>
          	<div style="display:none;" id="zd_seo_keywords_dui" class="diu"></div>
            <div style="display:none;" id="zd_seo_keywords_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_seo_keywords_cuo_info" class="cuo1"></div>
          </td>
        </tr>
        <tr>
        	<th></th>
        	<td style="padding:0 0 10px 0;"><div style="color:#848484; float:none;">keywords之间请用“,”分隔</div></td>
        </tr>
        <tr>
          <th><font>*</font>首页description：</th>
          <td style="padding-bottom:0;">
          	<textarea class="ri" style="width:480px; height:100px;" id="zd_seo_description" name="zd_seo_description" onblur="formyanzheng('zd_seo_description')" onfocus="showText('zd_seo_description')"><%=seo_description_session.equals("")?Common.substringByte(Common.getFormatStr(memberInfo.get("comp_intro")),200):seo_description_session %></textarea>
          	<div style="display:none;" id="zd_seo_description_dui" class="diu"></div>
            <div style="display:none;" id="zd_seo_description_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_seo_description_cuo_info" class="cuo1"></div>	
          </td>
        </tr>
        <tr>
        	<th></th>
        	<td style="padding:0 0 10px 0;"><div style="color:#848484; float:none;">请控制字数在200字以内</div></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><input type="submit" name="button" id="button" value="提交" class="registBtn" /></td>
        </tr>
      </table>
      	<input name="flagvalue" type="hidden" id="flagvalue"  value="1"/>
		<input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=mem_no_session%>" />
    </form>
  <%	
  	}
  %>
    </div>

<script type="text/javascript">

	//根据传入的字段，返回是否在字符串中
	function fieldInFields(fields,field){
		result=false;
		if(fields!=null && field!=null){
			tp=fields.split(",");
			for(i=0;i<tp.length;i++){
				if(field==(tp[i])){
					result=true;
					break;
				}
			}	
		}
		return result;
	}

	function submityz2(){
		var seo_title = jQuery("#zd_seo_title").val() ;
		var seo_keywords = jQuery("#zd_seo_keywords").val() ;
		var seo_description = jQuery("#zd_seo_description").val() ;
		var info = (seo_title+seo_keywords+seo_description).replace(/\s+/g,"") ;	
		var cango = '' ;
		jQuery.ajax({
			url:'/tools/ajax.jsp' ,
			type:'POST',
			async:false,
			data:{info:info,flag:'checkInputInfo'},
			success:function(msg){
			 if(jQuery.trim(msg)=='so'){
			     alert("您所填的信息中含有敏感词，请重新填写") ;
			     cango = 1 ;
			     return false ;
			 }
			}
		}) ;
		if(cango==1){
		 	return false ;
		}else{
			return true ;
		}
	}
</script>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
