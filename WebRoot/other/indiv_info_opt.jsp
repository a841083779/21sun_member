<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
ResultSetMetaData rsmd = null;

HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String zd_mem_no="",zd_fittings_bulletin="",zd_fittings_service="",zd_fittings_businepolic="";
String sqlMemInfo="",sqlMemInfoSub="";
String flagvalue = Common.getFormatInt(request.getParameter("flagvalue"));  //是否为修改
String mem_no_sub ="";

String zd_parts_popkeywords="",zd_used_popkeywords="";
int result =0;
try{     
     mem_no_sub       = Common.getFormatStr(memberInfo.get("mem_no_sub"));
	  
	if(flagvalue.equals("1")){
	   zd_mem_no            = Common.getFormatStr(request.getParameter("zd_mem_no"));
	   zd_fittings_bulletin = Common.getFormatStr(request.getParameter("zd_fittings_bulletin"));
	   zd_fittings_service = Common.getFormatStr(request.getParameter("zd_fittings_service"));
	   zd_fittings_businepolic = Common.getFormatStr(request.getParameter("zd_fittings_businepolic"));
	   zd_parts_popkeywords = Common.getFormatStr(request.getParameter("zd_parts_popkeywords"));
	   zd_used_popkeywords = Common.getFormatStr(request.getParameter("zd_used_popkeywords"));
	   if(!zd_mem_no.equals("")){   
			 sqlMemInfo = "update member_info set parts_popkeywords='"+zd_parts_popkeywords+"',used_popkeywords='"+zd_used_popkeywords+"' where mem_no='"+zd_mem_no+"'";
			// System.out.println(sqlMemInfo);
			 result = DataManager.dataOperation(pool,sqlMemInfo);		
		if(mem_no_sub.equals(zd_mem_no)){ //扩展表和主表的mem_no相同
		   sqlMemInfoSub = "update member_info_sub set fittings_bulletin='"+zd_fittings_bulletin+"',fittings_service='"+zd_fittings_service+"',fittings_businepolic='"+zd_fittings_businepolic+"' where mem_no ='"+zd_mem_no+"'";
		   result = DataManager.dataOperation(pool,sqlMemInfoSub);
		 }else{
		   sqlMemInfoSub = "insert member_info_sub (mem_no,fittings_bulletin,fittings_service,fittings_businepolic) values('"+zd_mem_no+"','"+zd_fittings_bulletin+"','"+zd_fittings_service+"','"+zd_fittings_businepolic+"')";
		   result = DataManager.dataOperation(pool,sqlMemInfoSub);
		 }
	   }
	    if(result>0){
		out.print("<script>alert('个性化设置成功!');window.location.href='indiv_info_opt.jsp';</script>");
		}else{
		out.print("<script>window.location.href='indiv_info_opt.jsp';</script>"); 
		}	
     }
	conn = pool.getConnection();
	String querySql = "select * from vi_member_info where mem_no=?";	
	pstmt = conn.prepareStatement(querySql);
	pstmt.setString(1, (String)memberInfo.get("mem_no"));
	
	rs = pstmt.executeQuery();	
	if (rs != null && rs.next()) {
		rsmd = rs.getMetaData();
		for (int i = 1; i <= rsmd.getColumnCount(); i++) {
           memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
		}
		session.setAttribute("memberInfo",memberInfo);
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script type="text/javascript">
  function submityn(){
	document.theform.flagvalue.value="1";
	document.theform.submit();
  }  
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">个性化设置</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。</td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tablezhuce" style="margin:0 auto">
      <form method="post" name="theform" id="theform">
	<!--<tr>
		<td    class="right"><span class="grayb">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span></td>
		<td ><%=memberInfo.get("mem_no")%></td>
	</tr>-->
	<tr>
	  <td colspan="2" style="height:26px;background:#fefaee;border:1px #fceddc solid;overflow:hidden;padding:0px;margin:0px;text-indent:18px" ><span style="color:#ff6600">‘我的二手商务室’</span><a style="color:#000">个性化设置</a></td>
	  </tr>
	<tr>
          <td width="22%" height="22"   class="right" style="color:#000">二手企业推荐关键字：</td>
          <td width="78%" height="28" ><input name="zd_used_popkeywords" type="text" id="zd_used_popkeywords" size="66" value="<%=Common.getFormatStr(memberInfo.get("used_popkeywords"))%>"  class="moren" style="color:#cacaca;height:18px;line-height:18px"/></td>
    </tr>
	<tr>
	  <td height="22" colspan="2" style="background:#f6f6f6;color:#858686;padding:8px;"><a style="color:#FF0000">说明：</a>为店铺设置有效关键词，有利于您的商铺和发布的二手设备更容易被搜索引擎收录，可以设置多个关键词，两个关键词之间请用全角“，”隔开。例如：贵公司主要销售二手履带挖掘机、轮式挖掘机，可设置关键词为：二手履带挖掘机、轮式挖掘机。</td>
	  </tr>
	  <tr>
	  <td  colspan="2" style="height:20px"></td>
	  </tr>
	<tr>
	  <td height="22" colspan="2" style="height:26px;background:#fefaee;border:1px #fceddc solid;overflow:hidden;padding:0px;margin:0px;text-indent:18px" ><span style="color:#ff6600">‘配件网空间站’</span><a style="color:#000">个性化设置</a></td>
	  </tr>
	<tr>
          <td height="22"   class="right" style="color:#000">配件企业推荐关键字：</td>
          <td height="28" ><input name="zd_parts_popkeywords" type="text" id="zd_parts_popkeywords" size="66" value="<%=Common.getFormatStr(memberInfo.get("parts_popkeywords"))%>"  class="moren" style="color:#cacaca;height:18px;line-height:18px"/></td>
    </tr>
	<tr>
	  <td height="22" colspan="2" style="background:#f6f6f6;color:#858686;padding:8px;"><a style="color:#FF0000">说明：</a>为专卖店设置有效关键词，有利于您的专卖店和发布的供求信息更容易被搜索引擎收录，可以设置多个关键词，两个关键词之间请用全角“，”隔开。例如：贵公司主要销售斗山挖掘机配件，可设置关键词为：斗山挖掘机配件。</td>
	  </tr>
	  <tr>
	  <td  colspan="2" style="height:20px"></td>
	  </tr>

	<tr>
	  <td height="22" colspan="2"  style="height:26px;background:#fefaee;border:1px #fceddc solid;overflow:hidden;padding:0px;margin:0px;text-indent:18px" ><span style="color:#ff6600">‘配套网空间站’</span><a style="color:#000">个性化设置</a> </td>
	  </tr>
	<tr>
		<td height="22"   class="right" style="color:#000">品牌站（形象站）公告：</td>
		<td ><textarea name="zd_fittings_bulletin" cols="50" rows="3" id="zd_fittings_bulletin" style="overflow-y:scroll;height:60px" onkeyup="if((this.value).length&gt;300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}"><%=Common.filterHtmlString(Common.getFormatStr(memberInfo.get("fittings_bulletin")).replace("<br />","\r\n"))%></textarea></td>
	</tr>
	<tr>
	  <td height="22" colspan="2" style="background:#f6f6f6;padding:8px"><a style="color:#FF0000">说明：</a>此信息将在您的品牌站或形象站的企业公告处显示，可对企业最新产品、服务和优惠政策进行公告！</td>
	  </tr>
	<tr>
		<td height="22"   class="right" style="color:#000">企业配套服务：</td>
		<td height="60" ><textarea name="zd_fittings_service" cols="50" rows="3" id="zd_fittings_service" style="overflow-y:scroll;height:60px" onkeyup="if((this.value).length&gt;300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}"><%=Common.filterHtmlString(Common.getFormatStr(memberInfo.get("fittings_service")).replace("<br />","\r\n"))%></textarea></td>
	</tr>
	<tr>
	  <td height="22" colspan="2" style="background:#f6f6f6;padding:8px"><a style="color:#FF0000">说明：</a>贵企业目前不为整机企业提供配套服务，可以不填写此项内容！</td>
	  </tr>
	<tr>
		<td height="22"   class="right" style="color:#000">企业招商政策：</td>
		<td height="60" ><textarea name="zd_fittings_businepolic" cols="50" rows="3" id="zd_fittings_businepolic" style="overflow-y:scroll;height:60px" onkeyup="if((this.value).length&gt;300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}"><%=Common.filterHtmlString(Common.getFormatStr(memberInfo.get("fittings_businepolic")).replace("<br />","\r\n"))%></textarea></td>
	</tr>
	<tr>
	  <td height="22" colspan="2" style="background:#f6f6f6;padding:8px"><a style="color:#FF0000">说明：</a>此信息将在您发布的‘产品信息’中显示，以便更好的向配件代理商宣传企业的招商政策，促进合作。</td>
	  </tr>
	
	<tr>
		<td height="22"></td><td  align="center"  bgcolor="#FFFFFF"> <input type="button" id="submitId" name="Submit" value="保 存" class="tijiao" style="cursor:pointer"  onClick="submityn()"/></td>
	</tr>
		<input name="flagvalue" type="hidden" id="flagvalue"  />
		<input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=memberInfo.get("mem_no")%>" />
	</form>
    </table>
  </div>
</div>
<script type="text/javascript">
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
window.onload=f_iframeResize;
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>