<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%
	pool = new PoolManager(7);
//====得到参数====
String id=Common.getFormatInt(request.getParameter("id"));
String sql="";
try{//====标题的名称====
sql="insert into supply(mem_no,add_date,add_ip,mem_name,mem_flag,pubdate,pubdays,is_pub,clicked,title,category,categoryname,subcategory,subcategoryname,"
+"brand,brandname,province,city,telephone,content,is_original,old,model,delivery_type,parts_mode,parts_certify)"
+"select mem_no,add_date,add_ip,mem_name,mem_flag,pubdate,pubdays,is_pub,clicked,title,category,categoryname,subcategory,subcategoryname,"
+"brand,brandname,province,city,telephone,content,is_original,old,model,1,4,1 from buy where id="+id;
int k=DataManager.dataOperation(pool,sql);
int n=0;
//===如何插入数据成功===,则删除原求购信息=====
if(k>0)
{sql="delete from buy where id="+id;
n=DataManager.dataOperation(pool,sql);
 }
 
 out.print(n);
}catch(Exception e){e.printStackTrace();}
finally{

}
%>
