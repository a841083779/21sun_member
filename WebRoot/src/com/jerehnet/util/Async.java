package com.jerehnet.util;

import java.util.Map;

import javax.servlet.http.Cookie;

public class Async extends Thread {

	private String url;
	private Map params;
	private Cookie[] cookies = null;

	public Async(String url, Map params) {
		this.url = url;
		this.params = params;
	}

	public Async(String url, Map params, Cookie[] cookies) {
		this.url = url;
		this.params = params;
		this.cookies = cookies;
	}

	@Override
	public void run() {
		try {
			Common.doPost(url, params, cookies);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.interrupt();
		return;
	}

}
