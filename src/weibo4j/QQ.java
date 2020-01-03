package weibo4j;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.codehaus.jackson.map.ObjectMapper;
import com.jerehnet.util.Common;
import weibo4j.qq.model.User;

public class QQ {

	/**
	 * 获取登陆后的QQ信息
	 * @param appID
	 * @param appKEY
	 * @param redirectURI
	 * @param request
	 * @return
	 * @throws IOException
	 */
	public static User getUserInfo(String appID,String appKEY,String redirectURI,HttpServletRequest request) throws IOException {
		ObjectMapper mapper = new ObjectMapper(); 
		QQ qq = new QQ();
		
		//获取accessToken
		String accessToken = "";
		String code = request.getParameter("code");
		String accessTokenURL="https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id="+appID+"&client_secret="+appKEY+"&code="+code+"&state=test&redirect_uri="+redirectURI;
		
		accessToken = qq.getReturnStr(accessTokenURL);
		if(accessToken==null || accessToken.indexOf("error")!=-1){
			return null;
		}
		accessToken = accessToken.replace("access_token=", "");
		accessToken = accessToken.substring(0, accessToken.indexOf("&expires_in"));
		
		//获取openid
		String openidURL = "https://graph.qq.com/oauth2.0/me?access_token="+accessToken;
		String openidStr = qq.getReturnStr(openidURL);
		if(openidStr==null || openidStr.indexOf("error")!=-1){
			return null;
		}
		openidStr = openidStr.replace("callback( ", "").replace(" );", "");
		Map<String, String> tokenMap = mapper.readValue(openidStr, Map.class); 
		
		//获取登陆后的会员信息
		String userinfoURL = "https://graph.qq.com/user/get_user_info?access_token="+accessToken+"&oauth_consumer_key="+appID+"&openid="+tokenMap.get("openid");
		String userinfoStr = qq.getReturnStr(userinfoURL);					 
	    User user = mapper.readValue(userinfoStr, User.class);
	    //user.setOpenID(tokenMap.get("openid"));
	   
		return user;
	}

	/**
	 * 采用httpClient模拟get请求
	 * @param strURL
	 * @return
	 */
	public String getReturnStr(String strURL){
		String returnStr = "";
		HttpClient httpclient = new HttpClient();
		  GetMethod httpget = new GetMethod(strURL); 
		  httpget.getParams().setContentCharset("UTF-8");  
		  try { 
		    httpclient.executeMethod(httpget);
		    //--
			//--
			InputStream inputStream = httpget.getResponseBodyAsStream();  
	        BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));  
	        StringBuffer stringBuffer = new StringBuffer();  
	        String str= "";  
	        while((str = br.readLine()) != null){   
	            stringBuffer .append(str );  
	        }  
	        returnStr = new String(stringBuffer.toString()); 
		   // returnStr = new String(httpget.getResponseBodyAsString());
		    Common.println(returnStr);
		  }catch(Exception e){
			  e.printStackTrace();
		  } finally {
		    httpget.releaseConnection();
		  }
		  
		  return returnStr;
	}
}
