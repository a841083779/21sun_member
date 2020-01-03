<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%>

<%

PoolManager pool = new PoolManager(2);
PoolManager poolms = new PoolManager();

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

sql ="select id,mid,title,detail,pubdate,pubdays,ispublished,direction,cast(detail as varchar(1000)) as detail from WEBMARKET FETCH   FIRST   405   ROWS   ONLY";
rs = DataManager.executeQueryDB2(conn,sql);
String busi="";
String ca="";
while(rs.next()){

	String catas=",";
	rs2 = DataManager.executeQueryDB2(conn,"select id1 from MARKET01 where id0="+rs.getString("id")+" ");
	
	while(rs2.next()){
		ca=rs2.getString("id1");
		
		if(ca.equals("1")){//挖掘机械
			catas+="101001,";//
		}else if(ca.equals("2")){//装载机械
			catas+="101002,";//
		}else if(ca.equals("3")){//起重机械
			catas+="102,";//
		}else if(ca.equals("4")){//推土机械
			catas+="101003,";//
		}else if(ca.equals("5")){//平地压实机械
			catas+="101005,";//
		}else if(ca.equals("6")){//筑路机械
			catas+="104,";//
		}else if(ca.equals("8")){//凿岩掘进机械
			catas+="108,";//
		}else if(ca.equals("17")){//混凝土机械
			catas+="103,";//
		}else if(ca.equals("21")){//矿山设备
			catas+="110,";//
		}else if(ca.equals("23")){//桩工机械
			catas+="105,";//
		}	
	}
	
	busi=rs.getString("direction");
	if(busi.equals("买")){
		busi="11";//求购
	}else if(busi.equals("卖")){
		busi="10";//出售
	}else if(busi.equals("合")){
		busi="13";//寻求项目
	}else if(busi.equals("代")){
		if(Integer.parseInt(rs.getString("id"))%2==1){
			busi="12";//代理招商
		}else{
			busi="14";//技术转让
		}		
	}
	
	insSql = "insert into sell_buy_market(mem_no,title,pub_date,valid_day,is_show,business_flag,db2id,descr,product_flag,market_flag) values('"+rs.getString("mid")+"','"+rs.getString("title")+"','"+rs.getString("pubdate")+"','"+rs.getString("pubdays")+"','"+rs.getString("ispublished")+"','"+busi+"','"+rs.getString("id")+"','"+rs.getString("detail")+"','"+catas+"',11)";
	//insSql = insSql.replace("\"","");
	int intinsert = DataManager.dataOperation(connms,insSql);

%>

  <tr>
    <td>&nbsp;<%=rs.getString("detail")+"--"+insSql%></td>

  </tr>

<%
}
%>
</table>
<br />


<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	poolms.freeConnection(connms);
}


%>

