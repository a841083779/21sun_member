package com.jerehnet.util;

import java.io.InputStream;
import java.util.Properties;

@SuppressWarnings("serial")
public final class Env extends Properties {
	private static Env env;
	
	public static Env getInstance(){
		if(env!=null){
			return env;
		}
		else{
			makeInstance();
			return env;
		}
	}
	
	private static synchronized void makeInstance(){
		if(env==null){
			env = new Env();
		}
	}

	private Env(){
		InputStream is = this.getClass().getResourceAsStream("/sys.properties");
		try {
			this.load(is);
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
