<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
ResultSetMetaData rsmd = null;

String mem_no_session="";
String figure_banner_session = "";

String zd_mem_no="";
String zd_figure_banner = "";
String zd_shop_css = "";

String flagvalue = Common.getFormatInt(request.getParameter("flagvalue"));  //是否为修改
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
String shop_css = Common.getFormatStr(memberInfo.get("shop_css"));
String sqlMemInfo="";

String querySql="";
try{
	conn = pool.getConnection();	
	mem_no_session = Common.getFormatStr(memberInfo.get("mem_no"));
	figure_banner_session = Common.getFormatStr(memberInfo.get("figure_banner"));
 
   int result=0;
   if(flagvalue.equals("1")){
	   zd_mem_no = Common.getFormatStr(request.getParameter("zd_mem_no"));
	   zd_figure_banner = Common.getFormatStr(request.getParameter("zd_figure_banner"));
	   zd_shop_css = Common.getFormatStr(request.getParameter("zd_shop_css"));
	  if(!zd_mem_no.equals("")){   
		 sqlMemInfo = "update member_info set figure_banner='"+zd_figure_banner+"',shop_css = '"+zd_shop_css+"'  where mem_no='"+zd_mem_no+"'";
		 result = DataManager.dataOperation(pool,sqlMemInfo);
		 		 
		if(result>0){
		
			memberInfo.put("figure_banner",zd_figure_banner);
			memberInfo.put("shop_css",zd_shop_css);
			out.print("<script>alert('店铺美化设置成功!');window.location.href='/market/shop.jsp';</script>");
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
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>店铺美化 - 中国工程机械商贸网</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<link href="../style/style_new.css" rel="stylesheet" type="text/css" />
<script src="/scripts/jquery-1.4.1.min.js"></script>
<script src="/scripts/jquery.form.js"></script>
<script src="/scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript" src="/scripts/regmoreyanzheng.js"  type="text/javascript"></script>
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
</head>
<body style="background-color:transparent;">

 
  <%
  	if(!mem_flag.equals("1003")){
  %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color:#f7f7f7 ; border: 4px solid #eaf2fd">
	  <tr>
	    <td width="11%"><img src="/manage/sorry.jpg" width="133" height="80" /></td>
	    <td width="89%" style="padding-left:15px" class="red18">很抱歉，您不是A类会员，不能进行店铺美化。<br />赶快申请加入吧！<a href="http://www.21-sun.com/service/huiyuan/member_a.htm" target="_blank" style="text-decoration:underline">查看A类会员服务</a>　　联系电话：0535-6727799</td>
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
  <div class="registTitle">店铺美化 <span>通过美化店铺，提高用户粘性，增加用户忠诚度！</span></div>
  <form method="post" name="theform" id="theform" onsubmit="return submityz2();">
  <style type="text/css">
  table.meihua { width:98%; margin:0 auto; clear:both;}
  th,table.meihua td { line-height:22px; padding:5px; text-align:left;}
  table.meihua th { font-size:14px; font-family:微软雅黑; border-bottom:#d1def0 1px solid; color:#333; font-weight:normal; padding-top:10px;}
  table.meihua td .shopStyleImgs td { text-align:center;}
  table.meihua td .shopStyleImgs td input { vertical-align:-2px;} 
  table.meihua td .shopStyleImgs td img { margin-bottom:3px; border:#ccc 1px solid; padding:2px;}
  table.meihua td .shopStyleImgs td a { color:#014099!important;}
  table.meihua td .shopStyleImgs td a:hover { color:#ff6600!important; text-decoration:underline;}
  </style>
      <table border="0" cellspacing="0" cellpadding="0" class="meihua">
        <tr>
          <th>店铺形象图：</th>
        </tr>
        <tr>  
          <td>
          	<input type="hidden" name="zd_figure_banner" id="zd_figure_banner" value="<%=Common.getFormatStr(memberInfo.get("figure_banner"))%>" />
          	<div style="margin-top:5px;">
          		<span style="display:block;"></span>
                <span id="logo_img" style="width:40px;height:20px; float:left; margin-right:5px; vertical-align:middle;border:#ccc 1px solid;"></span>形象图尺寸（940*92）
          	</div>
          </td>
        </tr>
        <tr>
        	<td align="center" style="padding-top:10px;">
        		<img id="my_logo_img" onerror="this.src='/manage/gq01.jpg'" src="<%=Common.getFormatStr(memberInfo.get("figure_banner")).equals("") ? "/manage/gq01.jpg" : Common.getFormatStr(memberInfo.get("figure_banner")) %>" style="width: 700px;height: 68px;" />
        	</td>
        </tr>
        <tr>
          <th>店铺风格：</th>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="shopStyleImgs">
              <tr>
                <td><img src="../images/style001.jpg" width="200" height="138" /><br />
                <input name="zd_shop_css" type="radio" id="zd_shop_css" value="01" <%if(shop_css.equals("01")||shop_css.equals("")){%> checked="checked" <%}%>/>
                默认 &nbsp;<a target="_blank" href="http://<%=mem_no_session%>.market.21-sun.com/01/">预览</a></td>
                <td><img src="../images/style002.jpg" width="200" height="138" /><br />
                  <input type="radio" name="zd_shop_css" id="zd_shop_css" value="02" <%if(shop_css.equals("02")){%> checked="checked" <%}%>/>
风格1 &nbsp;<a target="_blank" href="http://<%=mem_no_session%>.market.21-sun.com/02/">预览</a></td>
                <td><img src="../images/style003.jpg" width="200" height="138" /><br />
                  <input type="radio" name="zd_shop_css" id="zd_shop_css" value="03" <%if(shop_css.equals("03")){%> checked="checked" <%}%>/>
风格2 &nbsp;<a target="_blank" href="http://<%=mem_no_session%>.market.21-sun.com/03/">预览</a></td>
              </tr>
          </table>
          </td>
        </tr>
        <tr>
          <td colspan="2" style="text-align:center;"><input type="submit" name="button" id="button" value="提交" class="registBtn" /></td>
        </tr>
      </table>
      	<input name="flagvalue" type="hidden" id="flagvalue"  value="1"/>
		<input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=mem_no_session%>" />
    </form>
  <%
  	}
  %>
    </div>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript">
jQuery("#logo_img").JrUpload({
	remotUrl : "http://resource.21-sun.com/upload.jsp",
	folder : "member" ,
	buttonImg:'http://member.21-sun.com/images/upload.gif',
	watermark:false,
	callback : "setLogoImg"
});

function setLogoImg(data){
	jQuery("#my_logo_img").attr("src","http://resource.21-sun.com"+data);
	jQuery("#zd_figure_banner").val("http://resource.21-sun.com"+data);
}

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
	return true;
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
