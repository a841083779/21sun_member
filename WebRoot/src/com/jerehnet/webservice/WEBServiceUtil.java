package com.jerehnet.webservice;

import java.net.MalformedURLException;
import java.net.URL;
import org.codehaus.xfire.client.Client;
import com.jerehnet.util.Env;

public class WEBServiceUtil {

	public static Object[] executeDynamic(String wsdl, String method,
			Object[] param) throws MalformedURLException, Exception {
		Client client = new Client(new URL(Env.getInstance().getProperty(
				"webservice_url")
				+ wsdl + "?wsdl"));
		return client.invoke(method, param);
	}

}
