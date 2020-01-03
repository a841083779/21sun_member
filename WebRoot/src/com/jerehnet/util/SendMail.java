package com.jerehnet.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import com.jerehnet.cmbol.database.DataManager;
import com.jerehnet.cmbol.database.PoolManager;
import com.jerehnet.util.GetSource;

public final class SendMail
{
  private String mailServer = "";
  private String userName = "";
  private String passW = "";
  private String from = "";
  private String to = "";
  private String cc = "";
  private String bcc = "";
  private String subject = "";
  private String messageText = "";
  private String fromName = "";

  public static void main(String[] args) throws Exception
  {
    SendMail sendMail = new SendMail();
//  sendMail.setMailServer("smtp.126.com");
//	sendMail.setUserName("my_zlj");
//	sendMail.setPassW("123456");
//	sendMail.setFrom("my_zlj@126.com");
//	sendMail.setTo("wanggq@21-sun.com");
    
    sendMail.setMailServer("mail.21-sun.com");
	sendMail.setUserName("wanggq");
	sendMail.setPassW("aaaaa");
	sendMail.setFrom("wanggq@21-sun.com");

    sendMail.setSubject("21-sun电子期刊—本期关注：制造业竞争力中国居全球第一");
    sendMail.setFromName("中国工程机械商贸网");
    sendMail.setCc("");
    sendMail.setBcc("");
    //sendMail.setMessageText(new GetSource().getSource("http://www.21-cmjob.com/tools/delivery_post.jsp?companyNo=20100511144515209285"));
    sendMail.setMessageText(new GetSource().getSource("http://news.21-sun.com:8081/qikan/dianziqikan.jsp?id=38"));
	sendMail.setTo("wanggq@21-sun.com");
	sendMail.sendMail();
  }

  public boolean sendMail() {
    boolean result = false;
    try
    {
      if (this.messageText == null) {
        this.messageText = "";
      }

      String[] tempToArr = this.to.split(",");
      InternetAddress[] mailTo = new InternetAddress[tempToArr.length];
      if (tempToArr != null) {
        for (int i = 0; i < tempToArr.length; ++i) {
          mailTo[i] = new InternetAddress(tempToArr[i]);
        }

      }

      InternetAddress[] mailCc = (InternetAddress[])null;
      if ((this.cc != null) && (this.cc.length() > 0)) {
        String[] tempCcArr = this.cc.split(",");
        mailCc = new InternetAddress[tempCcArr.length];
        if ((tempCcArr != null) && (tempCcArr.length > 0)) {
          for (int i = 0; i < tempCcArr.length; ++i)
            mailCc[i] = new InternetAddress(tempCcArr[i]);

        }

      }

      InternetAddress[] mailBcc = (InternetAddress[])null;
      if ((this.bcc != null) && (this.bcc.length() > 0)) {
        String[] tempBccArr = this.bcc.split(",");
        mailBcc = new InternetAddress[tempBccArr.length];
        if ((tempBccArr != null) && (tempBccArr.length > 0))
          for (int i = 0; i < tempBccArr.length; ++i)
            mailBcc[i] = new InternetAddress(tempBccArr[i]);


      }

      String type = "text/html";
      boolean sessionDebug = false;

      Properties props = System.getProperties();
      props.put("mail.host", this.mailServer);
      props.put("mail.transport.protocol", "smtp");
      props.put("mail.smtp.auth", "true");

      Session mailSession = Session.getDefaultInstance(props, null);
      mailSession.setDebug(sessionDebug);
      Message msg = new MimeMessage(mailSession);

      InternetAddress allFrom = new InternetAddress();
      allFrom.setAddress(this.from);
      allFrom.setPersonal(MimeUtility.encodeText(this.fromName));
      msg.setFrom(allFrom);

      msg.setRecipients(Message.RecipientType.TO, mailTo);

      msg.setRecipients(Message.RecipientType.CC, mailCc);

      msg.setRecipients(Message.RecipientType.BCC, mailBcc);

      msg.setSubject(this.subject);

      msg.setSentDate(new Date());

      Multipart mp = new MimeMultipart();
      MimeBodyPart mbp = new MimeBodyPart();

      mbp.setContent(this.messageText, type + ";charset=utf-8");
      mp.addBodyPart(mbp);
      msg.setContent(mp);

      Transport transport = mailSession.getTransport("smtp");
      transport.connect(this.mailServer, this.userName, this.passW);
      transport.sendMessage(msg, msg.getAllRecipients());
      transport.close();
      result = true;
    } catch (Exception e) {
      result = false;
      e.printStackTrace();
    }
    return result;
  }

  public String getBcc()
  {
    return this.bcc;
  }

  public void setBcc(String bcc) {
    this.bcc = bcc;
  }

  public String getCc() {
    return this.cc;
  }

  public void setCc(String cc) {
    this.cc = cc;
  }

  public String getFrom() {
    return this.from;
  }

  public void setFrom(String from) {
    this.from = from;
  }

  public String getMailServer() {
    return this.mailServer;
  }

  public void setMailServer(String mailServer) {
    this.mailServer = mailServer;
  }

  public String getMessageText() {
    return this.messageText;
  }

  public void setMessageText(String messageText) {
    this.messageText = messageText;
  }

  public String getPassW() {
    return this.passW;
  }

  public void setPassW(String passW) {
    this.passW = passW;
  }

  public String getSubject() {
    return this.subject;
  }

  public void setSubject(String subject) {
    this.subject = subject;
  }

  public String getTo() {
    return this.to;
  }

  public void setTo(String to) {
    this.to = to;
  }

  public String getUserName() {
    return this.userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

public String getFromName() {
	return fromName;
}

public void setFromName(String fromName) {
	this.fromName = fromName;
}
  
}