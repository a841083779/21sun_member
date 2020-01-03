package com.jerehnet.webservice;

import java.net.MalformedURLException;
import java.net.URL;
import org.codehaus.xfire.client.Client;

public class WEBEmail {

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMail(String to, String title, String content)
			throws MalformedURLException, Exception {
		return sendMail(to, null, title, content);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param cc
	 *            抄送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMail(String to, String cc, String title,
			String content) throws MalformedURLException, Exception {
		return sendMail(to, cc, null, title, content);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param cc
	 *            抄送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMailByUrl(String to, String cc, String bcc,
			String title, String url, String encoding)
			throws MalformedURLException, Exception {
		String method = "sendMailByUrl";
		Object[] param = new Object[] { to, cc, bcc, title, url, encoding };
		Client client = new Client(new URL(
				"http://service.21-sun.com/services/" + "SendMail?wsdl"));
		Object[] results = client.invoke(method, param);
		return (Boolean) results[0];
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMailByUrl(String to, String title, String url,
			String encoding) throws MalformedURLException, Exception {
		return sendMailByUrl(to, null, null, title, url, encoding);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param 抄送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMailByUrl(String to, String cc, String title,
			String url, String encoding) throws MalformedURLException,
			Exception {
		return sendMailByUrl(to, cc, null, title, url, encoding);
	}

	/**
	 * 发送邮件
	 * 
	 * @param to
	 *            接收人
	 * @param cc
	 *            抄送人
	 * @param bcc
	 *            暗送人
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Boolean sendMail(String to, String cc, String bcc,
			String title, String content) throws MalformedURLException,
			Exception {
		String method = "";
		Object[] param = null;
		if (null != cc && null != bcc && !"".equals(cc) && !"".equals(bcc)) {// 如果有抄送人和暗送人
			method = "sendMail2";
			param = new Object[] { to, cc, bcc, title, content };
		} else if (null != cc && !"".equals(cc)
				&& (null == bcc || "".equals(bcc))) {
			method = "sendMail1";
			param = new Object[] { to, cc, title, content };
		} else {
			method = "sendMail";
			param = new Object[] { to, title, content };
		}
		Client client = new Client(new URL(
				"http://service.21-sun.com:7351/services/" + "SendMail?wsdl"));
		Object[] results = client.invoke(method, param);
		return (Boolean) results[0];
	}
}
