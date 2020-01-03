<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
 PoolManager pool3 = new PoolManager(3);
 PoolManager pool1 = new PoolManager(1);
 

//=====页面属性====
String myvalue  = request.getParameter("myvalue");

if (!myvalue.equals("")){  
   myvalue=Common.decryptionByDES(myvalue);
}

String title="",content="",brand="",model="",price="",mem_no="",mem_name=""; 
   //标题、详细内容、品牌、型号、价格、点击次数
//传真、地址、email、网、is_store=1表示已注册的商家店铺、点击次数
String province="",city="",img="",pubdate="",end_date="",classId="",clicked=""; //省份、市、图片、发布日期、有效期
String comp_name="",per_phone="",comp_fax="",per_email="",comp_url="",comp_address="",comp_logo="";

try{//====标题的名称====
  
String tempInfo[][]= DataManager.fetchFieldValue(pool3, "rent_info","top 1 id, title, content, brand, model, price,mem_no,mem_name, class, clicked,province,city,img,CONVERT(varchar(10), pubdate, 21) AS pubdate,CONVERT(varchar(10), DATEADD(dd, pubdays, pubdate), 21) AS end_date", "id='"+myvalue+"'");

String tempInfo2[][]=null;
if(tempInfo!=null){
    title        = Common.getFormatStr(tempInfo[0][1]);
	content      = Common.getFormatStr(tempInfo[0][2]);
	brand        = Common.getFormatStr(tempInfo[0][3]);
	model        = Common.getFormatStr(tempInfo[0][4]);
	price        = Common.getFormatStr(tempInfo[0][5]);
	mem_no       = Common.getFormatStr(tempInfo[0][6]);
	mem_name     = Common.getFormatStr(tempInfo[0][7]);
	classId      = Common.getFormatStr(tempInfo[0][8]);
	clicked      = Common.getFormatInt(tempInfo[0][9]); 
	province     = Common.getFormatStr(tempInfo[0][10]);
	city         = Common.getFormatStr(tempInfo[0][11]);
	img          = Common.getFormatStr(tempInfo[0][12]);
	pubdate      = Common.getFormatStr(tempInfo[0][13]);
	end_date     = Common.getFormatStr(tempInfo[0][14]);
	
	
  tempInfo2= DataManager.fetchFieldValue(pool1, "member_info","top 1 id, mem_no,comp_name, per_phone, comp_fax, per_email,comp_url, comp_address, comp_logo,mem_flag,mem_name"," mem_no='"+mem_no+"'");
	
	if(tempInfo2!=null){
		comp_name    = Common.getFormatStr(tempInfo2[0][2]);
		per_phone    = Common.getFormatStr(tempInfo2[0][3]);
		comp_fax     = Common.getFormatStr(tempInfo2[0][4]);
		per_email    = Common.getFormatStr(tempInfo2[0][5]);
		comp_url     = Common.getFormatStr(tempInfo2[0][6]);
		if(comp_url.indexOf("http://")<0)
		comp_url="http://"+comp_url;
		comp_address = Common.getFormatStr(tempInfo2[0][7]);
		comp_logo    = Common.getFormatStr(tempInfo2[0][8]);
	if(mem_name.equals("")){mem_name = Common.getFormatStr(tempInfo2[0][10]);}
		
	}
	
 }

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>市场租赁信息</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body>

<div class="loginlist_right">
  <div class="mainyh">市场租赁信息</div>
	<div class="loginlist_right1">
    <table width="95%" border="0" align="center" class="tablezhuce">
		<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
			<tr>
			  <td width="16%" align="right" nowrap class="list_left_title"><div align="center" class="grayb">标题</div></td>
			  <td width="84%" class="list_cell_bg"><%=title%>(<%=classId.equals("1")?"出租信息：":(classId.equals("0")?"求租信息：":"")%>)</td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center" class="grayb">品牌</div></td>
			  <td class="list_cell_bg"><%=brand%></td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center" class="grayb">型号</div></td>
			  <td class="list_cell_bg"><%=model%></td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center" class="grayb">价格</div></td>
			  <td class="list_cell_bg"><%=price%></td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center" class="grayb">省份/城市</div></td>
			  <td class="list_cell_bg"><%=province%>/<%=city%></td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center" class="grayb">发布日期</div></td>
			  <td class="list_cell_bg"><%=pubdate%></td>
			</tr>
			 <tr>
			  <td align="right" nowrap class="list_left_title"><div align="center" class="grayb">有效日期</div></td>
			  <td class="list_cell_bg"><%=end_date%></td>
			</tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title"><div align="center">点击</div></td>
			   <td class="list_cell_bg"><%=clicked%></td>
	      </tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title"><div align="center">内容</div></td>
			   <td class="list_cell_bg"><%=content%></td>
	      </tr>
			 <tr>
			   <td colspan="2" align="left" nowrap bgcolor="#6699FF" class="list_left_title"><span class="STYLE1">联系方式</span></td>
	      </tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title">商　家</td>
			   <td class="list_cell_bg"><%=!comp_name.equals("")?comp_name:"-"%></td>
	      </tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title">联系人</td>
			   <td class="list_cell_bg"><%=!mem_name.equals("")?mem_name:"-"%></td>
	      </tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title">电　话</td>
			   <td class="list_cell_bg"><%=!per_phone.equals("")?per_phone:"-"%></td>
	      </tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title">传　真</td>
			   <td class="list_cell_bg"><%=!comp_fax.equals("")?comp_fax:"-"%></td>
	      </tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title">地　址</td>
			   <td class="list_cell_bg"><%=!comp_address.equals("")?comp_address:"-"%></td>
	      </tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title">EMAIL</td>
			   <td class="list_cell_bg"> <%
		      if(!per_email.equals("")){
		   %>
			<a href="mailto:<%=per_email%>"><%=per_email%></a>
			<%}else{out.print("-");}%></td>
	      </tr>
			 <tr>
			   <td align="center" nowrap class="list_left_title">网　址</td>
			   <td class="list_cell_bg"><%
			  if(!comp_url.equals("")){
			%>
			 <a href="<%=comp_url%>" Target="_blank"><%=comp_url%></a>
			<%}else{out.print("-");}%></td>
	      </tr>    	
			<tr >
			  <td height="30px" class="list_left_title" align="left" colspan="2"><div align="center">
				  <input type="button" name="button1" onClick="javascrip:window.history.back(-1);" value="返回" style="cursor:hand">
			  </div></td>
			</tr>
		</form>	
    </table>
   </div>
</div>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{

}
%>
