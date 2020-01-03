<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%@ include file ="../manage/config.jsp"%>
<%
	PoolManager pool7 = new PoolManager(7);
	 Connection conn =null;
	pool = new PoolManager(1);
	
    
	HashMap userInfo = (HashMap)request.getSession().getAttribute("memberInfo");
	String session_comp_name = Common.getFormatStr((String)userInfo.get("comp_name")); //公司名称
	String session_per_phone = Common.getFormatStr((String)userInfo.get("per_phone")); //电话
	String session_mem_no    = Common.getFormatStr((String)userInfo.get("mem_no")); //用户名
	String session_mem_flag     = Common.getFormatStr((String)userInfo.get("mem_flag")); //会员角色

	int UPDATETOTAL=2;//总的更新次数
	if(!session_mem_flag.equals("-1"))
	UPDATETOTAL=6;
	
	int updateCount=0;
	
	String[][] tempInfo =null; //查询今天共更新了多少次 
	String description="";
	
	String []delValues = request.getParameterValues("checkdel");
	String tablename =  Common.decryptionByDES(Common.getFormatStr(request.getParameter("tablename")));

try{conn = pool7.getConnection();
    
	tempInfo=DataManager.fetchFieldValue(pool,"member_updateinfo","updatenums","mem_no='"+session_mem_no+"' and tablename='"+tablename+"' and datediff(d,getdate(),update_date)=0");
	if(tempInfo!=null){
	   updateCount = Integer.parseInt(Common.getFormatInt(tempInfo[0][0])); //今天共更新次数
	}

	
	String updateSql = "";
			
	if((UPDATETOTAL-updateCount)>0){
		for(int i = 0;delValues!=null && i < delValues.length; i++){
			   if(tablename.equals("supply")){
				     updateSql = " update "+tablename+" set pubdate=getdate(),comp_name='"+session_comp_name+"',telephone='"+session_per_phone+"'  where id = '"+delValues[i]+"' "; }else{
				     updateSql = " update "+tablename+" set pubdate=getdate(),telephone='"+session_per_phone+"' where id = '"+delValues[i]+"'";
				   }
		  DataManager.dataOperation(conn,updateSql);  
			}
		//====更新次数=====
			if(updateCount==0)
			{updateSql="insert into member_updateinfo(mem_no,tablename,update_date,updatenums)values('"+session_mem_no+"','"+tablename+"',getdate(),1)";
			}
			else
			{updateSql="update member_updateinfo set updatenums=updatenums+1 where mem_no='"+session_mem_no+"' and tablename='"+tablename+"' and datediff(d,getdate(),update_date)=0 ";}
			
		DataManager.dataOperation(pool,updateSql);
			
		description="批量更新信息成功！"; //更新成功XX条信息
		
 }
	else
		{description="已达到当日最多【"+UPDATETOTAL+"】次批量更新次数！"; }
		
}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
%>
<script language="javascript" type="text/javascript">
	alert('<%=description%>');
	window.parent.location.reload();
</script>