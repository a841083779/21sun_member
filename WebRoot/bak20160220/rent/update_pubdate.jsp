<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" errorPage=""%>
<%@ include file ="../manage/config.jsp"%>
<%
PoolManager pool3= new PoolManager(3);

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
	UPDATETOTAL=5; //其它会员级别5条信息
	if(null!=mem_no&&noList.contains(mem_no.trim().toLowerCase())){
		UPDATETOTAL = 2147483647;//int的最大值
	}
int updateCount=0;
String[][] tempInfo =null; //查询今天共更新了多少条 
			
String tablename="";
String id="";
String sql="";
String urlpath="";
String type="";
String description ="";
try{tablename=Common.decryptionByDES(Common.getFormatStr(request.getParameter("mypy")));
	id=Common.decryptionByDES(Common.getFormatStr(request.getParameter("myvalue")));
	urlpath = Common.getFormatStr(request.getParameter("urlpath"));
	
tempInfo=DataManager.fetchFieldValue(pool,"member_updateinfo","updatenums","mem_no='"+mem_no+"' and tablename='"+tablename+"' and datediff(d,getdate(),update_date)=0");
if(tempInfo!=null){
	   updateCount = Integer.parseInt(Common.getFormatInt(tempInfo[0][0])); //今天共更新多少条
	}

String updateSql = "";
if((UPDATETOTAL-updateCount)>0){
 sql="update "+tablename+" set pubdate='"+Common.getToday("yyyy-MM-dd HH:mm:ss.SSS",0)+"',orderno='"+Common.create21SUNOrderNo(1,mem_flag,0)+Common.generateDateRandom()+"',orderno1='"+Common.create21SUNOrderNo(1,mem_flag,1)+"' where id='"+id+"'";
	 DataManager.dataOperation(pool3,sql);
	 description="成功更新信息！";
	 
//====更新条数=====
if(updateCount==0)
			{updateSql="insert into member_updateinfo(mem_no,tablename,update_date,updatenums)values('"+mem_no+"','"+tablename+"',getdate(),1)";
			}
			else
			{updateSql="update member_updateinfo set updatenums=isnull(updatenums,0)+1 where mem_no='"+mem_no+"' and tablename='"+tablename+"' and datediff(d,getdate(),update_date)=0 ";}
			
DataManager.dataOperation(pool,updateSql);
			 
}else{
description="今天已经达到"+UPDATETOTAL+"最大更新条数！";
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