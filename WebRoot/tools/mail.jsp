<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.*,com.jerehnet.util.*,java.net.*"%>     
<%@ page import="javax.activation.*"%>   
<%@ page import="javax.mail.internet.*"%>   
<%@ page import="java.util.*,java.io.*"%>   
<%@ page contentType="text/html;charset=utf-8"%>   
<%@page import="java.net.URL"%> 
<%@page import="com.jerehnet.util.GetSource;"%> 
<%
	String email = Common.getFormatStr(request.getParameter("email"));
	if(email.equals("")){
		email = "wanggq@21-sun.com";
	}
	String uid = Common.getFormatStr(request.getParameter("uid"));
	String password = Common.getFormatStr(request.getParameter("password"));
	String fullname = Common.getFormatStr(request.getParameter("fullname"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>中国工程机械商贸网</title>
  </head>
  
  <body>
    <%                 
                 InternetAddress[] address = null;   
                 //request.setCharacterEncoding("utf-8");   
                 String mailserver = "mail.21-sun.com";//发出邮箱的服务器   
                 String From = "中国工程机械商贸网";//发出的邮箱   
                 InternetAddress from = new InternetAddress();
                 from.setAddress("wanggq@21-sun.com");
                 from.setPersonal(MimeUtility.encodeText(From));
                 String to = email;//发到的邮箱   
                 String Subject = "会员帐号信息 - 来自中国工程机械商贸网";//标题   
                 
                 String type = "text/html";//发送邮件格式为html   
                 String messageText = new GetSource().getSource("http://member.21-sun.com/tools/email.jsp?uid="+URLEncoder.encode(uid,"utf-8")+"&password="+password+"&fullname="+URLEncoder.encode(fullname,"utf-8"));//写入你要发送的页面连接，将此页面读为String   
                 //messageText = URLEncoder.encode(messageText,"utf8");   
                    
                 boolean sessionDebug = false;   
  
                 try {   
  
                       // 设定所要用的Mail 服务器和所使用的传输协议    
                       java.util.Properties props = System.getProperties();   
                       props.put("mail.host", mailserver);   
                       props.put("mail.transport.protocol", "smtp");   
                       props.put("mail.smtp.auth", "true");//指定是否需要SMTP验证    
  
                       // 产生新的Session 服务    
                       javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props, null);   
                       mailSession.setDebug(sessionDebug);   
                       Message msg = new MimeMessage(mailSession);   
  
                        
  
                       // 设定收信人的信箱    
                       address = InternetAddress.parse(to, false);   
                       msg.setRecipients(Message.RecipientType.TO, address);   
  						 // 设定发邮件的人    
                       msg.setFrom(from);  
                       // 设定信中的主题    
                       msg.setSubject(Subject);   
  
                       // 设定送信的时间    
                       msg.setSentDate(new Date());   
  
                       Multipart mp = new MimeMultipart();   
                       MimeBodyPart mbp = new MimeBodyPart();   
  
                       // 设定邮件内容的类型为 text/plain 或 text/html    
                       mbp.setContent(messageText, type + ";charset=UTF-8");   
                       mp.addBodyPart(mbp);   
                       msg.setContent(mp);   
  
                       Transport transport = mailSession.getTransport("smtp");   
                       ////请填入你的邮箱用户名和密码   
                       transport.connect(mailserver, "wanggq", "aaaaa");//设发出邮箱的用户名、密码   
                       transport.sendMessage(msg, msg.getAllRecipients());   
                       transport.close();   
                       //Transport.send(msg);    
                       out.println("邮件已顺利发送");   
  
                 } catch (MessagingException mex) {   
                       mex.printStackTrace();   
                       out.println(mex);   
                 }   
                 try{   
                          //response.sendRedirect("index.jsp");//转向某页   
                       }catch (Exception e){   
                             e.printStackTrace();   
                 }   
           %> 
  </body>
</html>
