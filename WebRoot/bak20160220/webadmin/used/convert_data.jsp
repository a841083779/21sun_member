<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%
	pool = new PoolManager(4);
//====得到参数====
String id=Common.getFormatInt(request.getParameter("id"));
String sql="";
try{//====标题的名称====
sql="insert into sell(mem_no,add_date,add_ip,mem_name,address,email,pubdate,extradate,pubdays,is_pub,clicked,title,category,subcategory,province,city,telephone,content,catalog_no,db2id,mem_flag)"
+"select mem_no,add_date,add_ip,mem_name,address,email,pubdate,extradate,pubdays,is_pub,clicked,title,category,subcategory,province,city,telephone,content,catalog_no,db2id,mem_flag from buy_new where id="+id;

int k=DataManager.dataOperation(pool,sql);
int n=0;
//===如何插入数据成功===,则删除原求购信息=====
if(k>0)
{sql="delete from buy_new where id="+id;
n=DataManager.dataOperation(pool,sql);
 }
 
 out.print(n);
}catch(Exception e){e.printStackTrace();}
finally{

}
%>
