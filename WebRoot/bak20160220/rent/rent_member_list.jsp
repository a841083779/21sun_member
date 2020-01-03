<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%@ include
	file="/manage/config.jsp"%>
<%
	PoolManager pool1 = new PoolManager(1);
	Connection conn = null;
	PoolManager pool3 = new PoolManager(3);
	Connection conn3 = null;
	try {
		conn = pool1.getConnection(); //SQL查询
		conn3 = pool3.getConnection();
		Pagination pagination = new Pagination();
		//设置每页显示条数
		pagination.setCountOfPage(20);
		String mem_no ="";
		HashMap memberInfo = new HashMap();
			
		String rent_webmaster_region  ="";  //负责的省份
		String [] rent_webmaster_region_arr= null;	
		String mem_flag="";
		if(session.getAttribute("memberInfo")!=null){   
			memberInfo = (HashMap) session.getAttribute("memberInfo");
			mem_no     = String.valueOf(memberInfo.get("mem_no"));    //登陆账号
			rent_webmaster_region = "";  //负责的省份
			mem_flag   = String.valueOf(memberInfo.get("mem_flag"));  //权限
		}
		
		String searchStr = "";
		String comp_name = "";
		ResultSet rsRentMaster = DataManager.executeQuery(conn3," select province from rent_master where mem_no = '"+mem_no+"' ");
		while(rsRentMaster.next()){
			rent_webmaster_region += "'"+rsRentMaster.getString("province")+"',";
		}
		if(rent_webmaster_region.length()>0){
			rent_webmaster_region = rent_webmaster_region.substring(0,rent_webmaster_region.length()-1);
		}
		if(mem_flag.equals("1009")){   //租赁站长
		 if(!rent_webmaster_region.equals("")){ 
		   searchStr +=" and per_province in ( "+rent_webmaster_region+" ) ";
		  }
		}
	    searchStr += " and mem_flag <> '-1' ";
		String query = "select * from member_info where 1=1 "+searchStr+" order by regi_date desc , id desc ";
		ResultSet rs = pagination.getQueryResult(query, request, conn);
		String bar = pagination.pagesPrint(10); //读取分页提
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<link href="/style/style.css" rel="stylesheet" type="text/css" />
		<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
		<script src="../scripts/jquery-1.4.1.min.js"></script>
		<script src="../scripts/common.js" type="text/javascript"></script>
		<script>
		  function viewList(objstr){	
		     self.location="register_view.jsp?myvalue="+encodeURIComponent(objstr);
		  }
		</script>
	</head>
	<body>

		<div class="loginlist_right">
			<div class="loginlist_right2">
				<span class="mainyh">站内注册会员</span>
			</div>
			<div class="loginlist_right1">
				<table width="100%" border="0" class="list">
					<tr>
						<th width="5%">ID</th>
						<th width="65%">公司名称</th>
						<th width="10%">注册时间</th>
						<th width="10%">联系人</th>
						<th width="10%">操作</th>
					</tr>
					<%
						int k = 0;
							while (rs != null && rs.next()) {
								k++; //out.print("id="+rs.getString("id"));
								comp_name = Common.getFormatStr(rs
										.getString("comp_name"));
								mem_flag = Common.getFormatInt(rs.getString("mem_flag"));
					%>
					<tr <%=(k % 2) == 0 ? "bgcolor='#F9F9F9'" : ""%>>
						<td height="30"><%=k%></td>
						<td><a href="javascript:viewList('<%=Common.encryptionByDES(rs.getString("id"))%>')">
								<% if(!comp_name.equals(""))out.print(comp_name);
								else out.print("个人");%></a></td>
						<td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("regi_date"))%></td>
						<td align="center"><div align="left"><span class="p92j"><%=Common.getFormatStr(rs.getString("mem_name"))%></span></div></td>
						<td><a href="rent_member_view.jsp?myvalue=<%=Common.getFormatStr(rs.getString("id"))%>">修改</a></td>
					</tr>

					<%
						}
					%>
				</table>
				<table width="100%" border="0" class="list">

					<tr>
						<td align="left"><%=bar%></td>
					</tr>
				</table>
			</div>
		</div>
		</form>
	</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool1.freeConnection(conn);
		pool3.freeConnection(conn3);
	}
%>
