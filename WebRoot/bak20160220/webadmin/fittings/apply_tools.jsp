<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(1);
	Connection conn =null;
	try{
		conn = pool.getConnection();
		String action=Common.getFormatStr(request.getParameter("action"));
		
		if(action.equals("batch")){
			String []delValues = request.getParameterValues("checkdel");
			String flag = Common.getFormatStr(request.getParameter("flag"));
			String tableName = Common.getFormatStr(request.getParameter("tableName"));
			String updateSql = "";
			if(delValues.length>0){
				String ids="";
				for(int i=0;i<delValues.length;i++){
					ids+=delValues[i]+",";
				}
				ids=ids.substring(0,ids.length()-1);
				
				if(flag.equals("0")){ //删除
					updateSql="delete from "+tableName+" where id in ("+ids+")";
				}else if(flag.equals("1")){ //更新为已审核
					updateSql="update "+tableName+" set status=1 where id in ("+ids+")";
				}else if(flag.equals("2")){ //更新为未审核
					updateSql="update "+tableName+" set status=0 where id in ("+ids+")";
				}
				DataManager.dataOperation(conn,updateSql);
%>
				<script language="javascript" type="text/javascript">
					window.parent.location.reload();
				</script>
<%
			}
		}else if(action.equals("del")){
			String tableName=Common.getFormatStr(request.getParameter("tableName"));
			String apply_id=Common.getFormatStr(request.getParameter("apply_id"));
			String sql="delete from "+tableName+" where id="+apply_id;
			DataManager.dataOperation(conn,sql);
%>
			<script language="javascript" type="text/javascript">
				window.parent.location.reload();
			</script>
<%
		}else if(action.equals("update")){
			String apply_id = Common.getFormatStr(request.getParameter("apply_id"));
			String memNo = Common.getFormatStr(request.getParameter("mem_no"));
			String memName = Common.getFormatStr(request.getParameter("mem_name"));
			String compName = Common.getFormatStr(request.getParameter("comp_name"));
			String compAddress = Common.getFormatStr(request.getParameter("comp_address"));
			String telephone = Common.getFormatStr(request.getParameter("per_phone"));
			String email = Common.getFormatStr(request.getParameter("per_email"));
			String content = Common.getFormatStr(request.getParameter("content")).replace("'", "''");
			String zhuying = Common.getFormatStr(request.getParameter("zhuying")).replace("'", "''");
			String province=Common.getFormatStr(request.getParameter("province"));
			String city=Common.getFormatStr(request.getParameter("city"));
			String status=Common.getFormatStr(request.getParameter("status"));
			
			//更新商贸网会员
			String memberSql = "update member_info set mem_name='"+memName+"',per_phone='"+telephone+"',per_email='"+email+"',comp_name='"+compName+"',comp_address='"+compAddress+"',comp_intro='"+content+"',per_province='"+province+"',per_city='"+city+"' where mem_no='"+memNo+"'";
			DataManager.executeSQL(pool, memberSql);
			String memberSubSql = "update member_info_sub set comp_mainbusiness='"+zhuying+"' where mem_no='"+memNo+"'";
			DataManager.executeSQL(pool, memberSubSql);

			//更新申请企业库表
			String applySql = " update member_applyonline set mem_name='"+memName+"',comp_name='"+compName+"',telephone='"+telephone+"',email='"+email+"',status="+status+" where id="+apply_id;
			DataManager.dataOperation(pool, applySql);
			
			out.print("1");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
%>