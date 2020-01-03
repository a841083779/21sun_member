<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(4);
Connection conn =null;
try{
	conn = pool.getConnection();
	String []delValues = request.getParameterValues("checkdel");
	String flag = Common.getFormatStr(request.getParameter("flag"));
	String updateSql = "";
	
	 if(flag.equals("0")){//删除
		for(int i = 0;delValues!=null && i < delValues.length; i++){		
			updateSql = " delete from buy_new where id = '"+delValues[i]+"' ";		
			DataManager.dataOperation(conn,updateSql);
		}
	  }else if(flag.equals("1")){//删除
		for(int i = 0;delValues!=null && i < delValues.length; i++){		
			updateSql = " delete from sell_new where id = '"+delValues[i]+"' ";		
			DataManager.dataOperation(conn,updateSql);
		}
	  }else if(flag.equals("2")){//将求购导入至供应中
		String sql="";		
			for(int i = 0;delValues!=null && i < delValues.length; i++){
				sql="insert into sell(mem_no,add_date,add_ip,mem_name,address,email,pubdate,extradate,pubdays,is_pub,clicked,title,category,subcategory,province,city,telephone,content,catalog_no,db2id,mem_flag)"
				+"select mem_no,add_date,add_ip,mem_name,address,email,pubdate,extradate,pubdays,is_pub,clicked,title,category,subcategory,province,city,telephone,content,catalog_no,db2id,mem_flag from buy_new where id="+delValues[i];
			
			int k=DataManager.dataOperation(pool,sql);
			int n=0;
			//===如何插入数据成功===,则删除原求购信息=====
			if(k>0)
			{   sql="delete from buy_new where id="+delValues[i];
			    n=DataManager.dataOperation(pool,sql);
			}
		 }
	  }else if(flag.equals("2")){//将求购导入至供应中
		String sql="";		
			for(int i = 0;delValues!=null && i < delValues.length; i++){
				sql="insert into sell(mem_no,add_date,add_ip,mem_name,address,email,pubdate,extradate,pubdays,is_pub,clicked,title,category,subcategory,province,city,telephone,content,catalog_no,db2id,mem_flag)"
				+"select mem_no,add_date,add_ip,mem_name,address,email,pubdate,extradate,pubdays,is_pub,clicked,title,category,subcategory,province,city,telephone,content,catalog_no,db2id,mem_flag from buy_new where id="+delValues[i];
			
			int k=DataManager.dataOperation(pool,sql);
			int n=0;
			//===如何插入数据成功===,则删除原求购信息=====
			if(k>0)
			{   sql="delete from buy_new where id="+delValues[i];
			    n=DataManager.dataOperation(pool,sql);
			}
		 }
	  }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
			pool.freeConnection(conn);
	}
%>
<script language="javascript" type="text/javascript">
	alert("操作成功！")
	window.parent.location.reload();
</script>