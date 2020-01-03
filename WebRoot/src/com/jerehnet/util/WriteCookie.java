package com.jerehnet.util;

import java.io.IOException;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;


public class WriteCookie {

	public static void doWriteCookie(String memNo,String passw) {
		memNo="qinhy";
		passw="jereh123";
		String keyPar=memNo+"--"+passw+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
		keyPar=Common.encryptionByDES(keyPar);
		System.out.println("keyPar:===="+keyPar);
		HttpMethod method1 = new GetMethod(
				"http://data.21-sun.com/sso/sso_exit.jsp?key=" + keyPar);
		HttpMethod method2 = new GetMethod(
				"http://market.21-sun.com/sso/sso.jsp?key=" + keyPar);
		HttpMethod method3 = new GetMethod(
				"http://www.21-part.com/sso/sso.jsp?key=" + keyPar);
		HttpMethod method4 = new GetMethod(
				"http://www.21-used.com/sso/sso.jsp?key=" + keyPar);
/*		HttpMethod method3 = new GetMethod(
				"http://www.21-part.com/sso/sso.jsp?key=" + keyPar);
		HttpMethod method3 = new GetMethod(
				"http://www.21-part.com/sso/sso.jsp?key=" + keyPar);
		HttpMethod method3 = new GetMethod(
				"http://www.21-part.com/sso/sso.jsp?key=" + keyPar);
		HttpMethod method3 = new GetMethod(
				"http://www.21-part.com/sso/sso.jsp?key=" + keyPar);
		HttpMethod method3 = new GetMethod(
				"http://www.21-part.com/sso/sso.jsp?key=" + keyPar);
		HttpMethod method3 = new GetMethod(
				"http://www.21-part.com/sso/sso.jsp?key=" + keyPar);
		HttpMethod method3 = new GetMethod(
				"http://www.21-part.com/sso/sso.jsp?key=" + keyPar);*/
		HttpClient client = new HttpClient();

		try {
			int i = client.executeMethod(method1);
			System.out.println("===="+i);
			client.executeMethod(method2);
			client.executeMethod(method3);
			client.executeMethod(method4); 
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	public static void main(String[] args) {
		doWriteCookie("qinhy","jereh123");
	}
}
