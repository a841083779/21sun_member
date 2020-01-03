package com.jerehnet.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Choujiang {

	/**
	 * 抽奖处理
	 * 
	 * @param lottery
	 * @param phone
	 * @return
	 */
	public static String getJiangPin(String lottery,String phone) {
		String returnString = "";
		String flagString 	= ""; 
		//券
		if (lottery.equals("1")||lottery.equals("2")||lottery.equals("3")||lottery.equals("4")) {
			if (lottery.equals("1")) {
				flagString = "网站制作套餐优惠券";
			}else if (lottery.equals("2")) {
				flagString = "网站会员优惠券";
			}else if (lottery.equals("3")) {
				flagString = "杰配网优惠券";
			}else if (lottery.equals("4")) {
				flagString = "人才网优惠券";
			}
			
			returnString = "恭喜您，领奖成功!感谢您参与我们的活动，请在2012年10月31日之前及时使用。";
			String content = "21-sun恭喜您中得"+flagString+"，请在2012年10月31日前使用，电话：0535-6727765";
			//发短信
			if (!isMobile(phone).equals("")) {
				//System.out.println("send telephone:"+phone);
				String flag = sentMess(phone,content);
				if (flag.equals("ok")) {
					//System.out.println("right telephone:"+phone);
				}else{
					//System.out.println("error telephone:"+phone);
				}
			}
		}
		//报告
		if (lottery.equals("7")||lottery.equals("101")||lottery.equals("102")||lottery.equals("103")||lottery.equals("104")||lottery.equals("105")) {
			returnString = "恭喜您，领奖成功!感谢您参与我们的活动，请尽快完善您的信息，以方便我们以邮件的形式发送至您的邮箱。";
		}
		//实物
		if (lottery.equals("5")||lottery.equals("6")) {
			returnString = "恭喜您，领奖成功!感谢您参与我们的活动，请尽快完善您的信息，以方便奖品的邮寄。";
		}
		return returnString;

	}
	

	/**
	 * 发短信
	 * 
	 * @param phone
	 * @param content
	 * @return
	 */
	public static String sentMess(String phone,String content) {
		String flag = "no";
		//String keyword = "中国工程机械商贸网";
		try {
			content = java.net.URLEncoder.encode(content, "GBK");
			URL url = new URL("http://http.asp.sh.cn/MT.do?Username=gcjxw&Password=123456&Mobile="+phone+"&Content="+content+"&Keyword=");
			HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
			urlConn.connect();
			InputStream urlStream = urlConn.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(urlStream));
			String result = "";
			result = reader.readLine();
			urlStream.close();
			System.out.println("短信发送返回值："+result);
			if(result!=null&&"0".equals(result.trim())){
				flag = "ok";
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return flag;
	}
	
	/**
	 * 手机号码
	 */
	public static String isMobile(String mobile){      
	 
	//当前运营商号段分配          
	//中国移动号段 1340-1348 135 136 137 138 139 150 151 152 157 158 159 187 188 147          
	//中国联通号段 130 131 132 155 156 185 186 145          
	//中国电信号段 133 1349 153 180 189          
	 
	String regular = "1[3,4,5,8]{1}\\d{9}";          
	Pattern pattern = Pattern.compile(regular);
	boolean isMatched = false;         
	if( mobile != null ){                         
		Matcher matcher = pattern.matcher(mobile);              
		isMatched = matcher.matches();                    
	 }         
	if(!isMatched){
		mobile = "";
	}
		return mobile;
	}
	
	public static void main(String[] args){
		String content = "21-sun恭喜您中得网站制作套餐优惠券，请在2012年10月31日之前及时使用，电话：0535-6727765";
		String phoneString = "15053578946";
		//发短信
		String flagString = sentMess(phoneString,content);
		if (flagString.equals("ok")) {
			System.out.println("发送成功！");
		}else{
			System.out.println("发送失败！");
		}
	}
	
}
