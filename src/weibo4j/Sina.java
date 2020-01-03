package weibo4j;

import javax.servlet.http.HttpServletRequest;
import com.jerehnet.util.Common;

import weibo4j.Oauth;
import weibo4j.Users;
import weibo4j.Weibo;
import weibo4j.http.AccessToken;
import weibo4j.model.User;
import weibo4j.model.WeiboException;
public class Sina {
	/**
	 * 获取用户信息
	 * @param request
	 * @return
	 */
	public static User getUserInfo(HttpServletRequest request) {
		User user = null;
		Oauth oauth = new Oauth();
		String code = Common.getFormatStr(request.getParameter("code"));
		try {
			AccessToken token = oauth.getAccessTokenByCode(code);
			String access_token = token.getAccessToken();
			String uid = token.getUid();
			Users um = new Users();
			um.client.setToken(access_token);
			try {
				user = um.showUserById(uid);
			} catch (WeiboException e) {
				e.printStackTrace();
			}
		} catch (WeiboException e) {
			if (401 == e.getStatusCode()) {
				System.out.println("Unable to get the access token.");
			} else {
				e.printStackTrace();
			}
		}

		return user;

	}

}
