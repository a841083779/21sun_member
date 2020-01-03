package com.jerehnet.cmbol.action;

//人员在系统里的状态
public class LoginUserInfo {
	private String usern;
	private String realname;
	private String talkState;// online,offline

	public String getUsern() {
		return usern;
	}

	public void setUsern(String usern) {
		this.usern = usern;
	}
	public String getRealname() {
		return realname;
	}

	public void setRealnameton(String realname) {
		this.realname = realname;
	}

	public String getTalkState() {
		return talkState;
	}

	public void setTalkState(String talkState) {
		this.talkState = talkState;
	}

}
