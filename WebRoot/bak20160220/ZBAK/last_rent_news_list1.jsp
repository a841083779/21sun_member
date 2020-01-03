<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,java.net.URLEncoder.*" errorPage=""%>
<style TYPE="text/css">
<!--
a:link {color:#090980;text-decoration: underline}
a:hover	{color:#FF8000;	text-decoration: underline}
a:visited {color:#090980;text-decoration:underline}
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
-->
</style>
<%
	PoolManager pool3= new PoolManager(3);
		
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(15);
	
	Connection conn = pool3.getConnection();
	
	String id="",province="",title="",buyer="",type="",pubdate="";
	StringBuffer tempTitle = new StringBuffer();
 try{
	  String query="select id,province,title,buyer,type,pubdate from rent_news where 1=1 and category='700704' order by id desc ";
	
	  ResultSet rs = pagination.getQueryResult(query, request,conn);
      String bar = pagination.pagesPrint(10); //读取分页提栏栏
	  
	  
	while(rs.next()){
	    id        = Common.getFormatStr(rs.getString("id"));
		province  = Common.getFormatStr(rs.getString("province"));
		title     = Common.getFormatStr(rs.getString("title"));
		buyer     = Common.getFormatStr(rs.getString("buyer"));
		type      = Common.getFormatStr(rs.getString("type"));
		pubdate   = Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"));
		
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
	<div align="center">
	  <table border="0" cellspacing="0" width="95%" class="p92" cellpadding="2">
		<tr>
		  <td width="56%">·<a href="http://www.21-rent.com/rent/viewlastnews.asp?findid=<%=id%>" target="_blank" >
		  <%
			if(tempTitle!=null){
				if(tempTitle.length()>57){
					out.print(tempTitle.substring(0,56)+"...");
				}else{
					out.print(tempTitle);
				}
			}
		  %></a>&nbsp;</td>   
		  <td width="25%"> [<font color="#0080FF"><%=pubdate%></font>]</td>   
		</tr>
		<tr>
		  <td width="100%" bgcolor="#D1D1D1" height="1" colspan="2"><!----></td>
		</tr>
	  </table> 
	</div>	
	<% 
	}rs.close(); %><br />
	<div align="center">
	<table border="0" cellspacing="0" width="95%" class="p92" cellpadding="2">
		<tr>
		<td align="right"><%=bar%></td>
		</tr>
	</table>
	</div>
<%
}catch(Exception e){
	Common.println(e);
}finally{
	pool3.freeConnection(conn);
	conn =null;
}
%>