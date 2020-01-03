<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" errorPage=""%><%
PoolManager pool7= new PoolManager(7);
String tablename="";
String id="";
String sql="";
String urlpath="";
String type="";
String description ="";
String imgflag="";
HashMap userInfo = (HashMap)request.getSession().getAttribute("memberInfo");

String session_comp_name = Common.getFormatStr((String)userInfo.get("comp_name")); //公司名称
String session_per_phone = Common.getFormatStr((String)userInfo.get("per_phone")); //电话




try{
    type= Common.getFormatStr(request.getParameter("type"));
	tablename=Common.decryptionByDES(Common.getFormatStr(request.getParameter("mypy")));
	id=Common.decryptionByDES(Common.getFormatStr(request.getParameter("myvalue")));
	urlpath = Common.getFormatStr(request.getParameter("urlpath"));
	imgflag = Common.getFormatStr(request.getParameter("imgflag"));
	 
		if(type.equals("pause")){
			sql="update "+tablename+" set is_pause=1 where id='"+id+"'";
			DataManager.dataOperation(pool7,sql);
			description="成功暂停1条信息！";
		}else if(type.equals("continue")){
			sql="update "+tablename+" set is_pause=0,pubdate=getdate() where id='"+id+"'";
			DataManager.dataOperation(pool7,sql);
			description="成功重新发布1条信息！";
		}else{	
			
			   		if(urlpath.equals("supply_list.jsp")){
						if(imgflag.equals("1")){
							sql="update "+tablename+" set pubdate=getdate(),comp_name='"+session_comp_name+"',telephone='"+session_per_phone+"' where id='"+id+"'";
							//System.out.println(sql);
							DataManager.dataOperation(pool7,sql);
							description="成功更新信息！";
						}
					}else{sql="update "+tablename+" set pubdate=getdate(),telephone='"+session_per_phone+"' where id='"+id+"'";
							DataManager.dataOperation(pool7,sql);
							description="成功更新信息！";
					}
				
		   }
%>
	<script>
		alert('<%=description%>');
	try{
	  window.document.location.href='<%=urlpath%>';
	}catch(e){}	
	</script>
<%
 
}catch(Exception ex)
{;}
finally{
tablename=null;
id=null;
sql=null;
}
%>