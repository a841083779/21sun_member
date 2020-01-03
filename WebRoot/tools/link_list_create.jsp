<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,java.io.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<jsp:useBean id="pool" scope="application"
	class="com.jerehnet.cmbol.database.PoolManager" />
<%
	String websiteId = Common.getFormatStr(request.getParameter("website_id"));
	int poolTag = Integer.parseInt(Common.getFormatInt(request.getParameter("pool_tag")));

	String base = application.getRealPath("");

	if (pool == null) {
		if (poolTag != 0) {
			pool = new PoolManager(poolTag);
		} else {
			pool = new PoolManager();
		}
	}
	int i = 0;
	Connection conn = null;
	try {
		conn = pool.getConnection();
		String sql = "select link_name,link_addr from link_list where website_id='" + websiteId + "'";

		ResultSet rs = DataManager.executeQuery(conn, sql);
		String fileOutPutSteam = "<link href=\"friendly_link.css\" rel=\"stylesheet\" type=\"text/css\" />"
				+ "\n"
				+ "<div class=\"friend_link clearfix\"><ul class=\"link_left\"><li><a href=\"#\">友情链接：</a></li></ul><ul class=\"link_right\">"
				+ "\n";

		while (rs != null && rs.next()) {
			fileOutPutSteam += "<li class=\"m1\"><a href=\""
					+ Common.getFormatStr(rs.getString("link_addr"))
					+ "\" target=\"_blank\">"
					+ Common.getFormatStr(rs.getString("link_name"))
					+ "</a></li>" + "\n";
		}
		fileOutPutSteam += "</ul></div>";
		string2File(fileOutPutSteam, base + "\\tools\\" + "friendly_link.htm");
		i = 1;
	} catch (Exception e) {
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
			ex.printStackTrace();
		} finally {
			try {
				bwriter.flush();
				bwriter.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}%>