<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,java.io.*,jereh.web21sun.util.*,jereh.web21sun.database.*"%>
<%
	PoolManager pool = null;

	String websiteId = Common.getFormatStr(request.getParameter("website_id"));
	int poolTag = Integer.parseInt(Common.getFormatInt(request.getParameter("pool_tag")));

	String base = application.getRealPath("");

	if (pool == null) {
		//if (poolTag != 0) {
		//	pool = new PoolManager(poolTag);
		//} else {
			pool = new PoolManager();
		//}
	}
	int i = 0;
	Connection conn = null;
	
	try {
		conn = pool.getConnection();
		String sql = "select link_name,link_addr from link_list where website_id='" + websiteId + "' order by sort_num desc,id";
		ResultSet rs = DataManager.executeQuery(conn, sql);
		String fileOutPutSteam = "";

		while (rs != null && rs.next()) {
			fileOutPutSteam += "<li><a href=\""
					+ Common.getFormatStr(rs.getString("link_addr"))
					+ "\" target=\"_blank\" title=\""+ Common.getFormatStr(rs.getString("link_name"))+"\" >"
					+ Common.getFormatStr(rs.getString("link_name"))
					+ "</a> | </li>" + "\n";
		}
		fileOutPutSteam += "</ul></div>";
		string2File(fileOutPutSteam, base + "/tools/link/" + "friendly_link.htm");
		i = 1;
	} catch (Exception e) {
		errorSend("站点:" + websiteId + " ,错误：" + e.toString());
		e.printStackTrace();
		i = -1;
	} finally {
		pool.freeConnection(conn);
	}
	if (i == 1) {
%>
<script>
	alert("更新静态页成功！");
	try{
	  window.close();
	}catch(e){}
</script>
<%
	} else if (i == -1) {
%>
<script>
	alert("更新静态页失败！");
	try{
	  window.close();
	}catch(e){}	
</script>
<%
	}
%>
<%!private void string2File(String content, String file) {
		BufferedWriter bwriter = null;
		try {
			bwriter = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "UTF-8"));
			bwriter.write(content);
		} catch (IOException ex) {
			errorSend("io：" + ex.toString());
			ex.printStackTrace();
		} finally {
			try {
				bwriter.flush();
				bwriter.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}
	public static void errorSend(String error) {
		SendMail sendMail = new SendMail();
		sendMail.setMailServer("smtp.126.com");
		sendMail.setUserName("my_zlj");
		sendMail.setPassW("123456");
		sendMail.setFrom("my_zlj@126.com");
		sendMail.setSubject("友情链接报错发送");
		sendMail.setMessageText(error);
		sendMail.setTo("gaopeng@21-sun.com");
		sendMail.sendMail();
}	
%>