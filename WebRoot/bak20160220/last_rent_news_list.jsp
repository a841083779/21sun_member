<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,java.net.URLEncoder.*" errorPage=""%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<style type="text/css">
* { margin:0; padding:0;}
ul,li { list-style-type:none;}

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
.st {WIDTH: 290px; HEIGHT: 250px; font-size:14px;}
.st1{WIDTH: 290px; HEIGHT: 360px; font-size:14px;}
.st ul li { height:22px; line-height:22px;}

.list {	width:278px; height:250px; overflow:hidden;font-size:14px;}
.list ul li { height:22px; line-height:22px;font-size:14px;}

.list1 {	width:278px; height:360px; overflow:hidden;font-size:14px;}
.list1 ul li { height:22px; line-height:22px;font-size:14px;}



#biaoge_a ul li { font-family:"宋体"; font-size:12px; line-height:22px;}
#biaoge_b ul li { font-family:"宋体"; font-size:12px; line-height:22px;}
#biaoge_a ul li span { width:200px; line-height:22px; float:left; display:block;}
#biaoge_b ul li span { width:200px; line-height:22px; float:left; display:block;}
</style>

<%
  String hflag = Common.getFormatStr(request.getParameter("hflag"));
  String hr_temp="";
  if(hflag.equals("1")){
    out.print("<DIV id=biaoge class=\"list1\">");	
  }else{
    out.print("<DIV id=biaoge class=\"list\">");
  }
  String hrflag = Common.getFormatStr(request.getParameter("hrflag")); //链接
%>
  <DIV id=biaoge_a>
   <ul><cache:cache key="last_rent_news_list" time="1800"><%
	PoolManager pool3= new PoolManager(3);		
	Connection conn = pool3.getConnection();
	ResultSet rs =null;	
	String id="",province="",title="",buyer="",type="",pubdate="",type1="";
	StringBuffer tempTitle  = new StringBuffer();
	StringBuffer tempTitle1 = new StringBuffer();	

try{
    int numMarquee=0;
	String sql="select top 36 id,province,title,buyer,type,pubdate from rent_news where 1=1  and category='700704'  order by id desc ";
	rs=DataManager.executeQuery(conn,sql);
	
	String tempTitle2="";
	while(rs.next()){	
	    numMarquee++;
	    id        = Common.getFormatStr(rs.getString("id"));
		province  = Common.getFormatStr(rs.getString("province"));
		title     = Common.getFormatStr(rs.getString("title"));
		buyer     = Common.getFormatStr(rs.getString("buyer"));
		type      = Common.getFormatStr(rs.getString("type"));
		pubdate   = Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"));
		if(hrflag.equals("1")){
		   hr_temp="http://www.21-rent.com/news/newsdetail_for_"+id+".htm";
		}else{
		   hr_temp="http://www.21-rent.com/rent/viewlastnews.asp?findid="+id;
		}				
		if(type.equals("1")){
		
		  type="求租";
		  type1="求租";
		}else if(type.equals("2")){
          type="出租";
		  type1="出租";
		}
		tempTitle.delete(0,tempTitle.length());			
		tempTitle.append(province);
		tempTitle.append(buyer);
		tempTitle.append(type);
		tempTitle.append(title);
		
		tempTitle1.delete(0,tempTitle.length());
		tempTitle1.append(province);
		tempTitle1.append(buyer);
		tempTitle1.append(type1);
		tempTitle1.append(title);
		
		tempTitle2 ="";
		if(tempTitle!=null){
				if(tempTitle.length()>15){
					   tempTitle2 = tempTitle.toString().substring(0,14);
					   if(tempTitle2.indexOf("求租")!=-1){
						 tempTitle2 = tempTitle2.replaceAll("求租","<font color='green'>求租</font>");
					   }else if(tempTitle2.indexOf("出租")!=-1){
						 tempTitle2 = tempTitle2.replaceAll("出租","<font color='red'>出租</font>");
					   }
				}else{
					if(tempTitle.indexOf("求租")!=-1){
					    tempTitle2 = String.valueOf(tempTitle).replaceAll("求租","<font color='green'>求租</font>");					   
					}else if(tempTitle.indexOf("出租")!=-1){
					    tempTitle2 = String.valueOf(tempTitle).replaceAll("出租","<font color='red'>出租</font>");
					}
				}
			}		
		%>   
	 	<li><span>&middot;<a href="<%=hr_temp%>" title="<%=tempTitle1.toString()%>" target="_blank" >
		   <%=tempTitle2%></a></span>(<%=pubdate%>)</li>
	   <%
		   }rs.close();
		}catch(Exception e){
			Common.println(e);
		}finally{
			pool3.freeConnection(conn);
			conn =null;
		}
		%></cache:cache>
	</ul>
  </DIV>
  <DIV id=biaoge_b></DIV>
  </DIV>
  <SCRIPT> 
	<!--
	var speed=18; //数字越大速度越慢
	var tab=document.getElementById("biaoge");
	var tab1=document.getElementById("biaoge_a");
	var tab2=document.getElementById("biaoge_b");
	tab2.innerHTML=tab1.innerHTML; //克隆demo1为demo2
	function Marquee(){
	if(tab2.offsetTop-tab.scrollTop<=0)//当滚动至demo1与demo2交界时
	tab.scrollTop-=tab1.offsetHeight //demo跳到最顶端
	else{
	tab.scrollTop++
	}
	}
	var MyMar=setInterval(Marquee,speed);
	tab.onmouseover=function() {clearInterval(MyMar)};//鼠标移上时清除定时器达到滚动停止的目的
	tab.onmouseout=function() {MyMar=setInterval(Marquee,speed)};//鼠标移开时重设定时器
	-->
</SCRIPT>