<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*" errorPage="" %>
<%

   String tablename     = Common.getFormatStr(request.getParameter("tablename"));          //表名
   String poolnum       = Common.getFormatInt(request.getParameter("poolnum"));            //连接池类型 1=pool1、2=pool2、3= pool3
   String mem_no        = Common.getFormatStr(request.getParameter("mem_no"));             //登录账号
   String class_id      = Common.getFormatStr(request.getParameter("class_id"));             //类别
   
   String today= Common.getToday("yyyy-MM-dd",0);
   String[][] tempInfo  = null;
   
   String searchStr ="";
   
   if(!class_id.equals("")){
   		//searchStr+=" and class='"+class_id+"'";
   }   
   PoolManager pool     = null;
  
  try{
	   if(!poolnum.equals("0")){  //获得连接池
		  pool = new PoolManager(Integer.parseInt(poolnum));
	   }
	   if(pool!=null){ //查询共多少条记录
		tempInfo=DataManager.fetchFieldValue(pool,tablename,"count(*)", " mem_no='"+mem_no+"' and convert(varchar(10),add_date,21)='"+today+"'"+searchStr);
		}		        //返回给前台查询出的数据
		if(tempInfo!=null){
		  response.getWriter().print(Common.getFormatInt(tempInfo[0][0]));	  
		}	
   }catch(Exception e){
       e.printStackTrace();
   }finally{   	   
   }
%>
