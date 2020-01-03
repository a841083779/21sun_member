package com.jerehnet.webservice;

import java.net.MalformedURLException;
import java.net.URL;
import org.codehaus.xfire.client.Client;

public class WEBSMS {
	/**
	 * 发送短信
	 * 
	 * @param phone
	 *            手机号，如果是多个用逗号隔开，最多不超过100个手机号
	 * @param content
	 *            发送内容
	 * @return
	 * @throws MalformedURLException
	 * @throws Exception
	 */
	public static Integer sendSMS(String phone, String content)
			throws MalformedURLException, Exception {
		Client client = new Client(new URL("http://service.21-sun.com:7351/services/"+ "SendSMS?wsdl"));
		String method = "sendSMS";
		Object[] param = new Object[] { phone, content };
		Object[] results = client.invoke(method, param);
		return (Integer) results[0];
	}
}
