package com.jerehnet.filters;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionCount implements HttpSessionListener {
	private static int count = 0;
	private static int totalCount = 0;

	public void sessionCreated(HttpSessionEvent se) {
		count++;
		if(count>totalCount){
			totalCount=count;
		}

	}

	public static int getTotalCount() {
		return totalCount;
	}

	public void sessionDestroyed(HttpSessionEvent se) {
		count--;

	}

	public static int getCount() {
		return (count);
	}
}
