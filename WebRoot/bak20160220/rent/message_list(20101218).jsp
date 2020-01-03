<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%@ include
	file="/manage/config.jsp"%>
<%
    PoolManager pool1 = new PoolManager(1);
    Connection conn = null;
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(20);
	
	String rent_webmaster_region  ="";  //负责的省份
	String [] rent_webmaster_region_arr= null;
	String mem_flag ="";
	HashMap memberInfo = new HashMap();
	String mem_no="";
	
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(memberInfo.get("mem_no"));                            //登陆账号
		rent_webmaster_region = String.valueOf(memberInfo.get("rent_webmaster_region"));  //负责的省份
		mem_flag  = String.valueOf(memberInfo.get("mem_flag"));  //负责的省份
	}
    String searchStr="";
	
	if(mem_flag.equals("1009")){   //如果为租赁站长
		if(!rent_webmaster_region.equals("")){ 
			searchStr +=" and province in("; 
			if(rent_webmaster_region.indexOf(",")!=-1){//处理多省份的情况（多省份时用,隔开）
				rent_webmaster_region_arr = rent_webmaster_region.split(",");	 	    
				for(int k=0;k<rent_webmaster_region_arr.length;k++){
					searchStr += "'"+rent_webmaster_region_arr[k]+"'";
					if(k+1<rent_webmaster_region_arr.length) searchStr+=","; 
				}
			}else{
				searchStr +="'"+rent_webmaster_region+"'";
			}
			searchStr +=")";   
		}
	}else{
	   searchStr +=" and recipients_mem_no='"+mem_no+"'";
	} 
	String query = "select * from member_message where 1=1 "+searchStr+" order by pubdate desc";
	String tablename  ="member_message";
	try {
		conn = pool1.getConnection(); //SQL查询	
	    ResultSet rs = pagination.getQueryResult(query, request,conn);
	    String bar = pagination.pagesPrint(10);  //读取分页提
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<link href="../style/style.css" rel="stylesheet" type="text/css" />
		<script src="../scripts/jquery-1.4.1.min.js"></script>
		<script src="../scripts/common.js" type="text/javascript"></script>			
		<script>
		  function viewMessage(objstr){	
		   self.location="message_view.jsp?myvalue="+encodeURIComponent(objstr);
		  }
		</script>
	</head>
	<body>
		<form action="" method="get" name="theform" id="theform">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="15"></td>
				</tr>
			</table>
			<table width="95%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="3%" class="p982">
						<img src="../images/bibi11.gif" width="19" height="19" />
					</td>
					<td width="83%" class="p982">
						我的客户留言
					</td>
					<td width="14%" class="p982">&nbsp;						
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="15"></td>
				</tr>
			</table>
			<table width="99%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td colspan="3">
						<table width="95%" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td valign="top">
																		
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td height="15"></td>
										</tr>
									</table>
									<table width="98%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="9%" height="30" bgcolor="e8f2ff">
												<strong>ID</strong>
											</td>
											<td width="52%" bgcolor="e8f2ff">
												<strong>标题</strong>
											</td>	
											<td width="11%" align="center" bgcolor="e8f2ff">
												<div align="center">
													<span class="p92z">留言人</span>
												</div>
											</td>
											<td width="11%" align="center" bgcolor="e8f2ff">
												<div align="center">
													<span class="p92z">时间</span>
												</div>
											</td>										
											<td width="11%" align="center" bgcolor="e8f2ff">
												<div align="center">
													<span class="p92z">阅读次数</span>
												</div>
											</td>
											<td width="14%" align="center" bgcolor="e8f2ff">
												<div align="center">
													<span class="p92z">操作</span>
												</div>
											</td>
										</tr>
										<tr>
											<td height="6" colspan="5"></td>
										</tr>
										<%
											int k = 0;
												while (rs != null && rs.next()) {
												 k++;											 											                                                //out.print("id="+rs.getString("id"));
										%>
										<tr <%=(k % 2) == 0 ? "bgcolor='#F9F9F9'" : ""%>>
											<td height="30"><%=k%></td>
											<td>
										<a href="javascript:viewMessage('<%=Common.encryptionByDES(rs.getString("id"))%>')" ><%=Common.getFormatStr(rs.getString("title"))%></a>										
										   </td>																						
											<td align="center">
												<div align="center">
													<span class="p92j"><%=Common.getFormatStr(rs.getString("fullname"))%></span>
												</div>
											</td>
											<td align="center">
												<div align="center">
													<span class="p92j"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></span>
												</div>
											</td>
											<td align="center">
												<div align="center">
													<span class="p92j"><%=Common.getFormatInt(rs.getString("isread"))%></span>
												</div>
											</td>
											<td align="center">
												<div align="center">
													<span class="p92j">
													<a href="javascript:otherDeleteData('../rent/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>&nbsp;&nbsp;
													
													</span>
												</div>
											</td>
										</tr>

										<%
											}
										%>
										<tr>
											<td height="30" colspan="5">
												<%=bar%>
											</td>
										</tr>
									</table>
								</td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool1.freeConnection(conn);
	}
%>
