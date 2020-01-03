<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%@ include file ="../manage/config.jsp"%>
<%
	PoolManager pool3 = new PoolManager(3);
    Connection conn =null;
	pool = new PoolManager(1);
	
	String mem_no ="",mem_flag="";
	HashMap memberInfo = new HashMap();
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(Common.getFormatStr(memberInfo.get("mem_no")));    //登陆账号
		mem_flag     = String.valueOf(Common.getFormatStr(memberInfo.get("mem_flag")));    //会员角色
	}
	//不限制次数的会员
	List noList = new ArrayList(0);
	noList.add("zoomchi123");
	noList.add("zoomchi");
	int UPDATETOTAL=10;//租赁通或者租赁站长会员只能更新10条信息
	if(!mem_flag.equals("1005")&&!mem_flag.equals("1009"))
	UPDATETOTAL=5;
	if(null!=mem_no&&noList.contains(mem_no.trim().toLowerCase())){
		UPDATETOTAL = 2147483647;//int的最大值
	}
	
	int updateCount=0;
	int tempupdateCount=0;
	String[][] tempInfo =null; //查询今天共更新了多少条 
	String description="";
 try{
	conn = pool3.getConnection();
	String []delValues = request.getParameterValues("checkdel");
	String tablename =  Common.decryptionByDES(Common.getFormatStr(request.getParameter("tablename")));
	
	tempInfo=DataManager.fetchFieldValue(pool,"member_updateinfo","updatenums","mem_no='"+mem_no+"' and tablename='"+tablename+"' and datediff(d,getdate(),update_date)=0");
	
	if(tempInfo!=null){
	   updateCount = Integer.parseInt(Common.getFormatInt(tempInfo[0][0])); //今天共更新次数
	  
	}	
	
	String updateSql = "";
	if((UPDATETOTAL-updateCount)>0){
		for(int i = 0;delValues!=null && i < delValues.length&&i<(UPDATETOTAL-updateCount); i++){
		    updateSql = " update "+tablename+" set pubdate='"+Common.getToday("yyyy-MM-dd HH:mm:ss.SSS",0)+"',orderno='"+Common.create21SUNOrderNo(1,mem_flag,0)+Common.generateDateRandom()+"',orderno1='"+Common.create21SUNOrderNo(1,mem_flag,1)+"'  where id = '"+delValues[i]+"' "; 
			DataManager.dataOperation(conn,updateSql);
			tempupdateCount=tempupdateCount+1;
			}
			
		//====更新次数=====
			if(updateCount==0)
			{updateSql="insert into member_updateinfo(mem_no,tablename,update_date,updatenums)values('"+mem_no+"','"+tablename+"',getdate(),"+tempupdateCount+")";
			}
			else
			{updateSql="update member_updateinfo set updatenums=updatenums+"+tempupdateCount+" where mem_no='"+mem_no+"' and tablename='"+tablename+"' and datediff(d,getdate(),update_date)=0 ";}
			
		DataManager.dataOperation(pool,updateSql);
			
		description="批量更新信息成功！"; //更新成功XX条信息
		
		}
		else
		{description="已达到当日最多【"+UPDATETOTAL+"】条批量更新条数！"; }
				
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