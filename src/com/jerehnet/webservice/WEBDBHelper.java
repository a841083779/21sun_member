package com.jerehnet.webservice;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.codehaus.xfire.client.Client;
import org.json.JSONArray;
import org.json.JSONObject;

public class WEBDBHelper {
	@SuppressWarnings("unchecked")
	public static List<Map> getMapList(String sql, String wsdl)
			throws MalformedURLException, Exception {
		List<Map> maps = new ArrayList<Map>(0);
		Client client = new Client(new URL("http://service.21-sun.com:7351/services/"+ wsdl + "?wsdl"));
		Object[] results = client.invoke("getMapList", new Object[] { sql });
		JSONArray jsonArray = new JSONArray(results[0].toString());
		JSONObject jsonObject = null;
		Map m = null;
		Object key = null;
		for (int i = 0; i < jsonArray.length(); i++) {
			jsonObject = jsonArray.getJSONObject(i);
			m = new HashMap();
			for (Iterator jo = jsonObject.keys(); jo.hasNext();) {
				key = jo.next();
				m.put(key + "", jsonObject.get(key + ""));
			}
			maps.add(m);
		}
		return maps;
	}

	@SuppressWarnings("unchecked")
	public static Map getMap(String sql, String wsdl)
			throws MalformedURLException, Exception {
		Map m = new HashMap();
		Client client = new Client(new URL(
				"http://service.21-sun.com:7351/services/" + wsdl + "?wsdl"));
		Object[] results = client.invoke("getMap", new Object[] { sql });
		JSONObject jsonObject = new JSONObject(results[0].toString());
		Object key = null;
		for (Iterator jo = jsonObject.keys(); jo.hasNext();) {
			key = jo.next();
			m.put(key + "", jsonObject.get(key + ""));
		}
		return m;
	}
}
