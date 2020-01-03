<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%><jsp:useBean id="pool" scope="application" class="com.jerehnet.cmbol.database.PoolManager"/><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
boolean isOK = false;


String flag = Common.getFormatStr(request.getParameter("flag"));

if(flag.equals("1")){

	String querySql = "select * from member_info where mem_no=?";
	String memNo = Common.getFormatStr(request.getParameter("mem_no"));	
	//System.out.println(querySql+"-"+memNo+"--");
		
	try{
		conn = pool.getConnection();
		pstmt = conn.prepareStatement(querySql);
		pstmt.setString(1, memNo);		
		rs = pstmt.executeQuery();
		if(rs.next()){
			isOK = true;
		}
		
	}catch(Exception e){e.printStackTrace();}
	finally{
		pool.freeConnection(conn);
	}

}else if(flag.equals("2")){
	String yanzhengStr = Common.getFormatStr(request.getParameter("yanzhengStr"));
	String randSession = Common.getFormatStr((String)session.getAttribute("regRand"));
	
	char []randArr=randSession.toCharArray();
	int jj=0;
	 
	if(yanzhengStr.length()==randArr.length){
		for(int i=0;randArr!=null&&i<randArr.length;i++){
			if(yanzhengStr.indexOf(String.valueOf(randArr[i]))>=0){
				jj=jj+1;
			}
		}
	}
	
	if(jj==3){
		isOK = true;
	}
	//System.out.println("||"+yanzhengStr+"-"+randSession+"--"+isOK);
}else if(flag.equals("3")){
	//新验证码
	String random = Common.getFormatStr(request.getParameter("random"));
	String randSession = Common.getFormatStr((String)session.getAttribute("loginRand"));
	
	if(random.equals(randSession)){
		isOK = true;
	}
	System.out.println("||"+random+"-"+randSession+"--"+isOK);
}

if(isOK){
	out.print("succ");
}else{
	out.print("error");
}

%>