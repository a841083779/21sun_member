<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%
PoolManager pool = new PoolManager();

String tempMemberInfo[][]=DataManager.fetchFieldValue(pool,"member_info","top 100 mem_no,mem_flag,mem_flag_name,mem_flag_enddate","mem_flag not in('-1','1011','1006') and "+" DATEDIFF(d,getdate(),mem_flag_enddate)<0");
String sql1="";
String sql2="";

if(tempMemberInfo!=null)
{for(int i=0;i<tempMemberInfo.length;i++)
{//===更新member_info的数据===
sql1="update member_info set mem_flag='-1',mem_flag_name='普通会员',mem_flag_enddate=null where mem_no='"+Common.getFormatStr(tempMemberInfo[i][0])+"'";
 DataManager.dataOperation(pool,sql1);
//===更新member_info_sub的数据===
sql2="if exists(select mem_no from member_info_sub where mem_no='"+Common.getFormatStr(tempMemberInfo[i][0])+"')"
 +" update member_info_sub set old_mem_flag='"+Common.getFormatStr(tempMemberInfo[i][1])+"',old_mem_flag_enddate=getdate() where mem_no='"+Common.getFormatStr(tempMemberInfo[i][0])+"' else insert into member_info_sub(mem_no,old_mem_flag,old_mem_flag_enddate)values('"+Common.getFormatStr(tempMemberInfo[i][0])+"','"+Common.getFormatStr(tempMemberInfo[i][1])+"',getdate())";
DataManager.dataOperation(pool,sql2); 
 }
}
%>
