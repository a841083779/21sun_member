<%@page contentType="text/html;charset=utf-8"import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%>
	<% 

PoolManager pool = new PoolManager();
String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));

    String zd_recipients_mem_no = Common.getFormatStr(request.getParameter("zd_recipients_mem_no"));  //接收人 账号
	String zd_site_flag         = Common.getFormatStr(request.getParameter("zd_site_flag"));          //站点 类型	
	//site_flag 1:租赁 2: 二手 3: 商贸网主站 4:配件 5.供求
	String zd_sort_flag         = Common.getFormatStr(request.getParameter("zd_sort_flag"));          //1：留言 2：询价	
	String zd_province          = Common.getFormatStr(request.getParameter("zd_province"));           //省份
	String zd_city              = Common.getFormatStr(request.getParameter("zd_city"));               //城市
	
	String zd_sender_mem_name   = Common.getFormatStr(request.getParameter("zd_sender_mem_name"));     //发送人姓名
	String zd_telephone         = Common.getFormatStr(request.getParameter("zd_telephone"));           //发送人电话
	String zd_info_id           = Common.getFormatStr(request.getParameter("zd_info_id"));             //来源地址
	String titlename            = Common.getFormatStr(request.getParameter("titlename"));              //标题
	String mem_email            ="";  //接收人信箱
	String subject="",content="";
    String tempInfo[][]= null;
    String mem_name ="",mem_flag="",per_email="";
    //获取当前时间
	java.util.Date dt = new java.util.Date();   	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");   
	String temp_str="";
	temp_str=sdf.format(dt);

    String psid = Common.getFormatInt(request.getParameter("psid"));   //配件供应（留言次数）
	String ptype = Common.getFormatStr(request.getParameter("ptype")); //配件类别（buy-->求购）
	PoolManager pool7 = null;
	if(!psid.equals("0")){
	    pool7 = new PoolManager(7);	  
		String sql2="";
		 if(ptype.equals("buy")){
		   sql2 ="update buy set message_count= isnull(message_count,0)+1 where id='"+psid+"'";			
		 }else {
           sql2 ="update supply set message_count= isnull(message_count,0)+1 where id='"+psid+"'";
		 }
		DataManager.dataOperation(pool7,sql2);
	}
int result = 0;
try{
   //if(Common.getFormatInt(request.getParameter("rand")).equals( Common.getFormatInt((String)session.getAttribute("loginRand")))){
      //System.out.print("zd_site_flag======="+zd_site_flag);
		if(zd_site_flag.equals("2") && zd_sort_flag.equals("2")){	// 当为 二手询价 时，客户留言后系统发送mail通知商家				
			//System.out.println("zd_recipients_mem_no==="+zd_recipients_mem_no);
			tempInfo = DataManager.fetchFieldValue(pool,"member_info", "top 1 mem_name,mem_flag,per_email", " mem_no='" + zd_recipients_mem_no+"'");	
			
			mem_name  = Common.getFormatStr(tempInfo[0][0]);
			mem_flag  = Common.getFormatStr(tempInfo[0][1]);
			per_email = Common.getFormatStr(tempInfo[0][2]);
		
			System.out.println("mem_flag====="+mem_flag);
			if(mem_flag.equals("1001") || mem_flag.equals("1002") || mem_flag.equals("1008")){ //VIP类会员 、B类会员、高级二手会员
				subject = "有客户通过中国工程机械二手机网向您询价!";		
				
				content  = "<table border='0' width='100%'><tr><td>"+mem_name+",您好:</td></tr><tr><td>"+temp_str+"</td></tr><tr><td heigth='30px'>&nbsp;</td></tr><tr><td>"+zd_province+zd_city+"的"+zd_sender_mem_name+"（电话："+zd_telephone+"）通过<a href='http://used.21-sun.com' target='_blank'>中国工程机械二手机网</a>向您咨询关于您发布的“<a href='"+zd_info_id+"' target='_blank'>"+titlename+"</a>”详情。</td></tr><tr><td>请及时登录中国工程机械二手机网关注。</td><tr><td heigth='30px'>&nbsp;</td></tr></tr><tr><td>祝您工作愉快！</tr><tr><td>中国工程机械二手机网</td></tr></table>";
					
				SendMail sendMail = new SendMail();
				sendMail.setMailServer("smtp.126.com");
				sendMail.setUserName("my_zlj");
				sendMail.setPassW("123456");
				sendMail.setFrom("my_zlj@126.com");
				sendMail.setSubject(subject);
				sendMail.setMessageText(content);
				sendMail.setTo(per_email);
				sendMail.setBcc("dangbo@21-sun.com");
				sendMail.setFromName("中国工程机械商贸网");	
				//System.out.print("per_email="+per_email);
				//sendMail.setCc("dangbo@21-sun.com");
				sendMail.sendMail();				
		  	}
	      }
        result =DataManager.dataInsUpt(request, pool, mypy,2,0);

	
	if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	window.document.location.href='<%=urlpath%>';
	//parent.location.reload();
	
	}catch(e){}	
	
	</script>
	<%}else{%>
	<script>
		alert("操作失败！");
	     history.back();
		//parent.location.reload();
	</script>
<%
	}	
}catch(Exception e){
	e.printStackTrace();
}finally{
	urlpath=null;
	mypy=null;
}	
%>