<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*" %><%@ include file ="/manage/config.jsp"%>
<% 
	PoolManager pool1 = new PoolManager(1);
	PoolManager pool3 = new PoolManager(3);
	String urlpath   = Common.getFormatStr(request.getParameter("urlpath"));
	String mypy      = Common.getFormatStr(request.getParameter("mypy"));
	String zd_mem_no = Common.getFormatStr(request.getParameter("zd_mem_no"));
	String zd_class  = Common.getFormatStr(request.getParameter("zd_class"));       //=====生成静态页的相关控制===
	String zd_catalog_no = Common.getFormatStr(request.getParameter("zd_catalog_no"));
	String randflag=Common.getFormatInt(request.getParameter("randflag"));
	int result = 0;
	RentToHtml rentToHtml=new RentToHtml();
	String sql="";
	Connection conn = null;
try{
         conn = pool1.getConnection();
		 
		if(randflag.equals("1")){
				if(Common.getFormatInt(request.getParameter("rand")).equals( Common.getFormatInt((String)session.getAttribute("loginRand")) )){
					if(Common.decryptionByDES(mypy).equals("member_info")){
							result =DataManager.dataInsUpt(request, pool1, mypy,2,7);
							//=====更新首页相关静态页====	 	 
					 }else{
								result =DataManager.dataInsUpt(request, pool3, mypy,2,7);
								//=====更新首页相关静态页====	 		
					}	
		        }else{
		      result = -1;
		        }
		}else{
				if(Common.decryptionByDES(mypy).equals("member_info")){
				result =DataManager.dataInsUpt(request, pool1, mypy,2,7);
				//=====更新首页相关静态页====	 	 
				}else{
				result =DataManager.dataInsUpt(request, pool3, mypy,2,7);
				//=====更新首页相关静态页====	 		
				}	
		}
	
		String  tempInfo1[][]= null;
		String  amount="0";
		 if(result>0){
				/*if(!zd_catalog_no.equals("")){
				  rentToHtml.indexAllHtml(request,pool3,zd_catalog_no);
				}*/
				 if(zd_class.equals("1")){				   
					tempInfo1=DataManager.fetchFieldValue(pool3,"rent_info","count(*)"," class=1 and mem_no='"+zd_mem_no+"'" );
					amount = Common.getFormatInt(tempInfo1[0][0]);
					
					sql="update member_info set rent_outcount='"+amount+"'  where  mem_no='"+zd_mem_no+"'";
					DataManager.dataOperation(conn,sql);
				}
		}
	
	if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{		
	    window.document.location.href='<%=urlpath%>';
	}catch(e){}		
	</script>
	<%
	}else if(result==-1){
	%>
	<script>
		alert("验证码输入不正确，请重新输入！");
		history.back();
	</script>
	<%}else{%>
	<%if(zd_mem_no.equals("zt11-2sgzx")){%>
		<script>
		alert("OK！操作成功！");
	try{		
	    window.document.location.href='<%=urlpath%>';
	}catch(e){}		
	</script>
	<%}else{%>
	<script>
		alert("操作失败！");
		history.back();
	</script>
	<%}%>
<%
	}	
}catch(Exception e){
	e.printStackTrace();
}finally{
    pool1.freeConnection(conn);
	urlpath=null;
	mypy=null;
}	
%>