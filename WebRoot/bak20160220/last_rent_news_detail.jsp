<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,java.net.URLEncoder.*" errorPage=""%>
<style>
a:link {color:#090980;text-decoration: underline;font-size: 12px;}
a:hover	{color:#FF8000;	text-decoration: underline;font-size: 12px;}
a:visited {color:#090980;text-decoration:underline;font-size: 12px;}
a.black:link {color:black;text-decoration: underline}
a.black:hover	{color:#FF8000;	text-decoration: underline}
a.black:visited {color:black;text-decoration:underline}
a.1:link {color:white;text-decoration: none}
a.1:hover{color:white;text-decoration:none}
a.1:visited {color:white;text-decoration:none}
a.b:link {color:black;text-decoration: none}
a.b:hover{color:black;text-decoration:none}
a.b:visited {color:black;text-decoration:none}

a.2:link     {font-size: 12px; color: #FF6600; line-height: 20px; text-decoration: none }
a.2:hover    {font-size: 12px; color: #FF6600; line-height: 20px; text-decoration: none }
a.2:visited  {font-size: 12px; color: #FF6600; line-height: 20px; text-decoration: none }

a.a        {text-decoration:underline}
a.a:link   {color:#ff0000;filter:progid:DXImageTransform.Microsoft.Glow(color=ffffff,strength=3);WIDTH:100%;}
a.a:hover  {color:#FF0000;text-decoration:none}
a.a:visited{color:#FF0000;filter:progid:DXImageTransform.Microsoft.Glow(color=ffffff,strength=3);WIDTH:100%;}

a.c        {text-decoration:underline}
a.c:link   {color:black;}
a.c:hover  {color:#FF0000;text-decoration:none}
a.c:visited{color:black;}


a.3:link     {font-size: 14px; color: #090980; line-height: 19px;  text-decoration: underline }
a.3:hover    {font-size: 14px; color: #FF8000; line-height: 19px;  text-decoration: underline }
a.3:visited  {font-size: 14px; color: #090980; line-height: 19px;  text-decoration: underline }

a.4:link     {font-size: 14px; color: #090980; line-height: 25px;  text-decoration: underline }
a.4:hover    {font-size: 14px; color: #FF8000; line-height: 25px;  text-decoration: underline }
a.4:visited  {font-size: 14px; color: #090980; line-height: 25px;  text-decoration: underline }

a.5:link     {font-size: 12px; color:black; line-height: 20px;  text-decoration: none }
a.5:hover    {font-size: 12px; color:red; line-height: 20px;  text-decoration: none }
a.5:visited  {font-size: 12px; color:black; line-height: 20px;  text-decoration: none }

a.6:link     {font-size: 12px; color: #FFFFFF; line-height: 25px;  text-decoration: none }
a.6:hover    {font-size: 12px; color: #303030; line-height: 25px;  text-decoration: none }
a.6:visited  {font-size: 12px; color: #FFFFFF; line-height: 25px;  text-decoration: none  }

.HEAD2{font:bold 14px;color:#FFF;filter:progid:DXImageTransform.Microsoft.Glow(color=000000,strength=2);WIDTH:90%;}
.HEAD1{font:bold 14px;color:#FFF;filter:progid:DXImageTransform.Microsoft.Glow(color=000000,strength=2);WIDTH:90%;}
.HEAD{font:bold 14px;color:#000;filter:progid:DXImageTransform.Microsoft.Glow(color=ffffff,strength=3);WIDTH:100%;}
.HEAD3{font:bold 14px;color:#000;filter:progid:DXImageTransform.Microsoft.Glow(color=ffffff,strength=3);line-height: 20px;WIDTH:100%;}
.HEAD4{font:bold 22px;color:#000;filter:progid:DXImageTransform.Microsoft.Glow(color=ffffff,strength=3);line-height: 24px;WIDTH:100%;}
.clubwd{filter:progid:DXImageTransform.Microsoft.Glow(color=FFFFFF,strength=2);WIDTH:100%;text-align:center;font:bold 9pt}
.clubwd1{filter:progid:DXImageTransform.Microsoft.Glow(color=FFFFFF,strength=2);WIDTH:100% text-align:center;font:bold 9pt}
.main {font-size: 15px; line-height: 18px}
.big {font-size: 14px; line-height: 27px}
.big11 {color:#090980; font-size: 14px; line-height: 28px}
.big22 {font-size: 14px; line-height: 22px}
.big14 {font-size: 14px; color:#FF8000; line-height: 23px}
.p9090980 {color:#090980; font-size: 12px; line-height: 20px}
.pbig {color:#090980;font-size: 12px; line-height: 22px}
.tbig {color:#090980;font-size: 22px; line-height: 36px}
.p9red {color:red;font-size: 12px; line-height: 18px}
.p92 {color:black;font-size: 12px; line-height:20px}
.p62 {color:black;font-size: 12px; line-height:60px}
.p93 {color:black;font-size: 14px; line-height:20px}
.p921    { color: black; font-size: 12px; line-height:17px }
.pwhite {color:white;font-size: 12px; line-height:17px}
.p9105 {color:#090980;font-size: 12px; line-height:21px}
.pyellow {color:#FD6B32;font-size: 12px; line-height: 15px;}
.p660066 {color:#660066;font-size: 12px; line-height:15px}
input {color:#090980;font-size: 12px; line-height: 16px;}
textarea {color:#090980;font-size: 12px; line-height: 16px;}
.psmall {color:white;font-size: 12px; line-height: 14px}
.A02F67      { color: #A02F67; font-size: 12px; line-height: 20px }
.969696      { color: #969696; font-size: 12px; line-height: 19px }

.r1{width:100px;height:280px;float:right;    
     position:fixed !important; top/**/:260px;    
     position:absolute; z-index:260; top:expression(offsetParent.scrollTop+300);right:10px;} 
.l1{width:100px;height:280px;float:right;    
     position:fixed !important; top/**/:260px;    
     position:absolute; z-index:260; top:expression(offsetParent.scrollTop+300);left:10px;} 
	
.bb{font-size: 12px;}
</style>
<script>
function chgFS(){
	 var cf=event.srcElement.id;
	 alert(cf);
	 window.CAREA.className=cf;
}
</script>

<table border="0" width="545" align='center'>
	<tr>
	  <td >		
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
			<td width="100%" height="10"><!----></td>
			</tr>
		</table>
	 </td>
	</tr>
	
   <%
	PoolManager pool3= new PoolManager(3);
		
	Connection conn = pool3.getConnection();
	ResultSet rs =null,rs1=null;	
	String id="",province="",title="",buyer="",type="",pubdate="",source="",clicked="0",image="",content="";
	String id1="",province1="",title1="",buyer1="",type1="",pubdate1="";
	StringBuffer tempTitle = new StringBuffer();
	StringBuffer tempTitle1 = new StringBuffer();
	
	String findid= Common.getFormatStr(request.getParameter("findid"));
 try{
    String sqlUpdate = "update rent_news set clicked=isnull(clicked,0)+1 where 1=1 and category='700704' and id='"+findid+"' ";
	DataManager.dataOperation(conn,sqlUpdate);	
	
	String sqlquery="select top 10 id,province,title,buyer,type,pubdate from rent_news where 1=1 and category='700704' order by id desc ";
	rs1=DataManager.executeQuery(conn,sqlquery);
 
	String sql="select id,province,title,buyer,type,pubdate,source,clicked,image,content from rent_news where 1=1 and category='700704' and id='"+findid+"'";
	rs=DataManager.executeQuery(conn,sql);
	if(rs.next()){
	    id        = Common.getFormatStr(rs.getString("id"));
		province  = Common.getFormatStr(rs.getString("province"));
		title     = Common.getFormatStr(rs.getString("title"));
		buyer     = Common.getFormatStr(rs.getString("buyer"));
		type      = Common.getFormatStr(rs.getString("type"));
		pubdate   = Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"));
		source    = Common.getFormatStr(rs.getString("source"));
    	clicked   = Common.getFormatInt(rs.getString("clicked"));
    	image     = Common.getFormatStr(rs.getString("image"));
      	content   = Common.getFormatStr(rs.getString("content"));
		
		if(type.equals("1")){
		  type="<font color='green'>求租</font>";
		}else if(type.equals("2")){
		  type="<font color='red'>出租</font>";
		}		
		tempTitle.delete(0,tempTitle.length());		
		tempTitle.append(province);
		tempTitle.append(buyer);
		tempTitle.append(type);
		tempTitle.append(title);
		//tempTitle.append("(");
		//tempTitle.append(pubdate);
		//tempTitle.append(")");
	%>
	<tr>
		<td>
			<table border="0" cellpadding="6" cellspacing="0" width="100%">
				<tr>
					<td width="100%" bgcolor="#C0C0C0" height="25" align="left" class="big">
					<b>[最新租赁信息]</b>
					</td>
				</tr>
				<tr>
					<td width="100%" class="main" bgcolor="#FF7300" align="center" height="45"><b><font color="#FFFFFF">&nbsp;<%=tempTitle.toString()%> 
					</font></b></td>
				</tr>
				<tr>
					<td width="100%" height="1" class="p92"><!----></td>
				</tr>
				<tr>
					<td width="100%" class="p92" align="center" bgcolor="#E9EFCB">			
					<b>[<%=pubdate%>] [人气：<%=clicked%>]</b> [源自]：<%=source%></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
		   <td>			
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td width="100%" height="8"><!----></td>
					</tr>
				</table>
			</td>
	     </tr>
         <tr>
		   <td>	
			<table border="0" cellpadding="0" cellspacing="0" width="92%" id="dtb">
				<tr>
					<td width="100%" class="p92" align="center" height="10">
						<!---->
						</td>
				</tr>
				<tr>
					<td width="100%" id="CAREA1" class="p92" align="right">
						<!--ggads start donot delete-->
							<script type="text/javascript"><!--
							google_ad_client = "pub-4543364268700278";
							/* 租赁新闻详细标题下468x60, 090910 */
							google_ad_slot = "7942663428";
							google_ad_width = 468;
							google_ad_height = 60;
							//-->
							</script>
							<script type="text/javascript"
							src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
							</script>
						<!--ggads end donot delete-->
					</td>
				</tr>
				<tr>
					<td width="100%" id="CAREA" class="p92">&nbsp;&nbsp;<%//=viewstr(Replace(StrDetail,vbcrlf,"<br>"),kwd)%>
					</td>
				</tr>
          </table>
		  </td>
		</tr>
      
		<%
		   if(!image.equals("")){
		%>
		<tr>
		  <td>
			  <table border="0" cellpadding="0" cellspacing="0" width="80%" class="p92">
					<tr>
						<td width="100%" align="center" height="5"><!----></td>
					</tr>
					<tr>
						<td width="100%" align="center"><img border="0" src="<%=image%>"></td>
					</tr>
					<!--
					<tr>
						<td width="100%" align="center"><%//=StrImgTitle(i)%></td>
					</tr>-->
					<tr>
						<td width="100%" align="center" height="5"><!----></td>	
					</tr>
				</table>
			</td>
		</tr>
		<%
		   }
		%>
		<tr>
		  <td>
				<table border="0" cellpadding="0" cellspacing="0" width="100%" class="p92" id="CAREA1">
						<tr>
							<td  height="15" width="511"><!----></td>
						</tr>
						<tr>
							<td  bgcolor="#F7F7F7" align="left" ><%=content%></td>					
						</tr>
						<tr>
							<td  height="5" width="511"><!----></td>
						</tr>
						<tr>
							<td  width="511">
							<p align="right"><!--【<a href="#" onClick="chgFS();"><font color="#FF7300" id="big">大</font></a>&nbsp; 
							<a href="#" onClick="chgFS();"><font color="#FF7300" id="p93">中</font></a>&nbsp; 
							<a href="#" onClick="chgFS();"><font color="#FF7300" id="p92">小</font></a>】-->【<a href="mailto:?subject=在中国工程机械商贸网的信息&body=http://www.21-sun.com/rent/viewlastnews.asp?findid=<%=id%>">推荐</a>】【<a href="#" onClick="window.print();">打印</a>】</td>
						</tr>
						<tr>
						<td  width="511">
							<p align="right"><!--ggads start donot delete-->
							<script type="text/javascript"><!--
							google_ad_client = "pub-4543364268700278";
							/* 租赁新闻详细下面468x15, 090910 */
							google_ad_slot = "5950283949";
							google_ad_width = 468;
							google_ad_height = 15;
							//-->
							</script>
							<script type="text/javascript"
							src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
							</script><!--ggads end donot delete--></td>
						</tr>
			</table>
		  </td>
		</tr>
		
		<%}rs.close(); %>
		
		  <tr>
		     <td>
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
					<td width="100%" height="15"><!----></td>
					</tr>
				</table>
			  </td>
			</tr>
		   <tr>
		     <td>
				<table border="0" cellpadding="0" cellspacing="0" width="92%" bgcolor="#C0C0C0">
				<tr>
				<td width="100%" height="2"><!----></td>
				</tr>
				</table>
			  </td>
			</tr>
		   <tr>
		     <td>
				<table border="0" cellpadding="0" cellspacing="0" width="92%" class="big">
				<tr>
				<td width="100%">·<a href="http://www.21-rent.com/rent/morelastnews.asp" target="_parent"><b>更多咨讯&gt;&gt;&gt;</b></a></td>
				</tr> 
				</table>
			  </td>
			</tr>
		   <tr>
		     <td>
				<table border="0" cellpadding="0" cellspacing="0" width="92%" class="P92">
				   <%
				     while(rs1.next()){
						id1        = Common.getFormatStr(rs1.getString("id"));
						province1  = Common.getFormatStr(rs1.getString("province"));
						title1     = Common.getFormatStr(rs1.getString("title"));
						buyer1     = Common.getFormatStr(rs1.getString("buyer"));
						type1      = Common.getFormatStr(rs1.getString("type"));
						pubdate1   = Common.getFormatDate("yyyy-MM-dd",rs1.getDate("pubdate"));
												
						if(type1.equals("1")){
							type1="求租";
						}else if(type.equals("2")){
							type1="出租";
						}
						tempTitle1.delete(0,tempTitle1.length());			
						tempTitle1.append(province1);
						tempTitle1.append(buyer1);
						tempTitle1.append(type1);
     					tempTitle1.append(title1);											
				   %>
					<tr>
					 <td width="100%" class="bb">
						 ·<a href="http://www.21-rent.com/rent/viewlastnews.asp?findid=<%=id1%>" target="_blank" title="<%=tempTitle1.toString()%>"><%=tempTitle1%></a> [<%=pubdate1%>]
					</td>
					</tr>				
				<%}rs1.close();%>
				</table>
	
	      </td>
		  </tr>
		  </table>
		<iframe id="iframeC" name="iframeC" src="" width="0" height="0" style="display:none;" ></iframe>		
		<script type="text/javascript"> 
		function sethash(){
			hashW = document.documentElement.scrollWidth;
			hashH = document.documentElement.scrollHeight;
			urlC = "http://www.21-rent.com/rent/agent.html"; 
			document.getElementById("iframeC").src=urlC+"#"+hashH+"#"+hashW; 
		}
		window.onload=sethash;
		</script>		
<% 
}catch(Exception e){
   Common.println(e);
}finally{
	pool3.freeConnection(conn); 
	conn =null;
}
%>

