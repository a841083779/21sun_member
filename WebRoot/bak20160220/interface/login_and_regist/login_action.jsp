<%@ page language="java" import="java.sql.ResultSetMetaData,java.sql.Connection,java.util.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.ResultSet" pageEncoding="UTF-8"%><%
	PoolManager poolManager = new PoolManager();
	String mem_no = Common.getFormatStr(request.getParameter("mem_no"));
	String password = Common.getFormatStr(request.getParameter("password"));
	password = DesEncrypt.MD5(password);
	Connection connection = null;
	ResultSet rs = null;
	String keyPar = "";
	try {
		connection = poolManager.getConnection();
		String sql = " select top 1 * from vi_member_info where mem_no= '"+mem_no+"' and passw = '"+password+"' ";
		rs = DataManager.executeQuery(connection, sql);
		HashMap memberInfo = new HashMap();
		if(null!=rs&&rs.next()){
			ResultSetMetaData rsmd = rs.getMetaData();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
			   memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
			}
			session.setAttribute("memberInfo",memberInfo);
			String sessionMemNo=((String)memberInfo.get("mem_no"));
			keyPar = sessionMemNo+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
			keyPar = Common.encryptionByDES(keyPar);
		}
		out.print(keyPar);
	} catch (Exception e) {

	} finally {
		poolManager.freeConnection(connection);
	}
%>