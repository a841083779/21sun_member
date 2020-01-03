<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%>

<%

PoolManager pool = new PoolManager(2);
PoolManager poolms = new PoolManager(7);

Connection conn =null;
Connection connms =null;
ResultSet rs = null;
ResultSet rs2 = null;

String sql ="";

String insSql="";

try{

conn = pool.getConnection();
connms = poolms.getConnection();
%>

分类：<br />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td nowrap="nowrap">&nbsp;sql</td>


  </tr>

<%
rs=DataManager.executeQuery(connms,"select max(sid) from supply_partstore ");
int db2id = 0;
if(rs.next()){
	db2id = rs.getInt(1);
}
System.out.println(">>>>>>>>>>>>>."+db2id);

sql ="select ID, MID, CATIDS, PRICEX, STORE, MODEL, Brand, MOUNT, Description,PUBDATE,enddate,ISPUBLISHED,level,TITLE,detail from WEBPARTS where id> "+db2id+" order by id";
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))

String busi="";
String is_urgent="";
int ii=1;
while(rs.next()){
	ii++;
	String store = Common.getFormatStr(rs.getString("store"));
	String prov = "";
	String city = "";
	if(!"".equals(store)&&!"------".equals(store)){
		if(store.indexOf("--")!=-1){
			prov = store.split("--")[0];
			if(store.split("--").length>1)
			city = store.split("--")[1];
		}
	}
	if(null==rs.getString("enddate")){
		insSql = "insert into supply_partstore(add_date,mem_no,pubdate,pubdays,title,content,parts_no,parts_name,clicked,"
			+"is_pub,province,city,category,categoryname,sid,brand,model,amount,price) values('"+rs.getString("pubdate")+"','"+rs.getString("mid")+"','"+rs.getString("pubdate")+"',360,'"+rs.getString("description")+"','"+rs.getString("Detail").replaceAll("\\n","<br>").replaceAll("'","''")+"','"+rs.getString("title")+"','"+rs.getString("description")+"',0,'"+rs.getString("ispublished")+"','"+prov+"','"+city+"',106,'其他配件',"+rs.getString("id")+",'"+rs.getString("brand")+"','"+rs.getString("model")+"','"+rs.getString("mount")+"',"+rs.getString("pricex")+")";
	}else{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(sdf.parse(rs.getString("enddate")));
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(sdf.parse(rs.getString("pubdate")));
		long days = cal2.getTimeInMillis();
		long daye = cal.getTimeInMillis();
		long sub = (daye-days)/24*3600;
		int pubdays = 360;
		if(sub<=7)
			pubdays = 7;
		else if(sub>7&&sub<=30)
			pubdays = 30;
		else if(sub>30&&sub<=90)
			pubdays = 90;
		else if(sub>90&&sub<=180)
			pubdays = 180;
		else if(sub>180)
			pubdays = 360;
		insSql = "insert into supply_partstore(add_date,mem_no,pubdate,pubdays,title,content,parts_no,parts_name,clicked,"
			+"is_pub,province,city,category,categoryname,sid,brand,model,amount,price) values('"+rs.getString("pubdate")+"','"+rs.getString("mid")+"','"+rs.getString("pubdate")+"',"+pubdays+",'"+rs.getString("description")+"','"+rs.getString("Detail").replaceAll("\\n","<br>").replaceAll("'","''")+"','"+rs.getString("title")+"','"+rs.getString("description")+"',0,'"+rs.getString("ispublished")+"','"+prov+"','"+city+"',106,'其他配件',"+rs.getString("id")+",'"+rs.getString("brand")+"','"+rs.getString("model")+"','"+rs.getString("mount")+"',"+rs.getString("pricex")+")";
	}
	//insSql = insSql.replace("\"","");
	//out.print(insSql+"<br>");
	int intinsert = DataManager.dataOperation(connms,insSql);

%>


<%
System.out.println("=="+ii+"----:");
}

DataManager.dataOperation(connms,"update supply_partstore set brandname=(select distinct name from part_lstbrand a where a.id=brand) where sid is not null");

%>
</table>
<br />


<%
out.print("==========total:"+ii);

}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	poolms.freeConnection(connms);
}


%>

