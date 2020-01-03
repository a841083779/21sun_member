<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%
	String mem_no = CommonString.getFormatPara(request.getParameter("mem_no")) ;
	Connection conn = null ;
	try{
	DBHelper dbHelper = DBHelper.getInstance() ;
	conn = dbHelper.getConnection("web21sun_market") ;
 	String sel_sql = "select top 100 id from sell_buy_market_ago where mem_no=? and is_show=1" ;
	List<Map> idsList = null ;
	idsList = dbHelper.getMapList(sel_sql,new Object[]{mem_no},conn) ;
	String orderIds = "" ;
	Map orderMap = null ;
	Object[] objs = null ;
	String upt_sql = "" ;
	if(null!=idsList && idsList.size()>0){
		for(Map oneMap:idsList){
			orderIds += CommonString.getFormatPara(oneMap.get("id"))+"," ;
		}
	}
	System.out.println(orderIds) ;
	  // 批量更新
	String[] _orderIds = orderIds.split(",") ;
	if(_orderIds.length>0){
		for(int i=0;i<_orderIds.length;i++){
			orderMap = dbHelper.getMap(sel_sql,new Object[]{_orderIds[i]},conn) ;
			String fields = "" ;
			String tokens = "" ;
			if(null!=orderMap){
		        Set<String> key = orderMap.keySet();
		        objs = new Object[key.size()-1] ;
		        int j = 0 ;
		        label1: for (Iterator it = key.iterator(); it.hasNext();) {
		            String s = (String) it.next();
		            if(s.equals("id")){
		            	continue label1 ;
		            }
		            fields += s+"," ;
		            tokens += "?," ;
		            if(s.equals("add_date") || s.equals("pub_date")){
		            	objs[j] =CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
		            }else{
		            objs[j] = CommonString.getFormatPara(orderMap.get(s)) ;
		            }
		            j++ ;
		        }
		        if(fields.length()>0){
		        	fields = fields.substring(0,fields.length()-1) ;
		        	tokens = tokens.substring(0,tokens.length()-1) ;
		        }
		        String ins_sql = "insert into sell_buy_market("+fields+") values("+tokens+")" ;
		        upt_sql = "update sell_buy_market_ago set is_show=0 where id=?" ;
		        System.out.println(_orderIds[i]) ;
		      //  dbHelper.execute(ins_sql,objs,conn) ;  // 更新到新表
		      //  dbHelper.execute(upt_sql,new Object[]{_orderIds[i]},conn) ; // 原订单设为不显示 
			}
		}
		  out.println("ok") ;
	}

	}catch(Exception e){
		e.printStackTrace() ;
	}
%>

