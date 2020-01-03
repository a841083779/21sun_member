<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%@ include
	file="/manage/config.jsp"%>
<%
	PoolManager pool3 = new PoolManager(3);
	Connection conn = null;
	String tablename = "rent_info";
	
	String mem_no ="";
	HashMap memberInfo = new HashMap();
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
	}	
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(18);
	StringBuffer query = new StringBuffer("select * from " + tablename
			+ " where 1=1 and class=0 ");
	//得到参数
	String title = Common.getFormatStr(request.getParameter("title"));
	if (!title.equals("")) {
		query.append(" and title like '%" + title + "%'");
	}
	query.append(" and mem_no='" + mem_no + "' ");
	try {
		conn = pool3.getConnection();
		//SQL查询	
		ResultSet rs = pagination.getQueryResult(query.toString(),
				request, conn, 2);
		String bar = pagination.pagesPrint(10); //读取分页提
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<link href="/style/style.css" rel="stylesheet" type="text/css" />
		<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
		<script src="../scripts/jquery-1.4.1.min.js"></script>
		<script src="../scripts/common.js" type="text/javascript"></script>
		<script>
	     function modifyData(objstr1,objstr2){	
		   self.location="rent_opt.jsp?myvalue="+encodeURIComponent(objstr1)+"&zd_class="+encodeURIComponent(objstr2);
	    }
       </script>
	</head>
	<body>
		<form action="" method="get" name="theform" id="theform">
			<div class="loginlist_right">
				<div class="loginlist_right2">
					<span class="mainyh">我的求租信息</span>
				</div>
				<div class="loginlist_right1">
					<span class="title_bar">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="1%" class="title_bar">&nbsp;
									
								</td>
								<td width="23%" class="p94b">&nbsp;
									
								</td>
								<td width="65%" align="center" nowrap>
									标题：
									<input name="title" type="text" id="title" size="15"
										value="<%=title%>">
									<input type="submit" name="Submit" value=""
										style="width: 52px; height: 19px; border: none; background: url(../images/bottom06.gif) left top no-repeat; cursor: pointer;">
									<input type="button" name="Submit2" value=""
										style="width: 52px; height: 19px; border: none; background: url(../images/bottom07.gif) left top no-repeat; cursor: pointer;"
										onClick="javascript:clearForm()">
								</td>
								<td width="18%" align="right" class="title_bar">&nbsp;
									
								</td>
							</tr>
						</table> 
						</span>
						
						<span class="title_bar"> <input name="add_b" type="button"
								class="form_button" id="add_b" value=""
								style="width: 78px; height: 25px; border: none; background: url(../images/bottom03.gif) left top no-repeat; cursor: pointer;"
								onclick="window.location.href='rent_opt.jsp?zd_class=0'">
					</span>
						<table width="100%" border="0" class="list">
							<tr>
								<th width="4%">
									ID
								</th>
								<th>
									标题
								</th>
								<th width="15%">
									业务分类
								</th>
								<th width="10%">
									是否显示
								</th>
								<th width="15%">
									操作
								</th>
							</tr>
							<%
								int k = pagination.getCurrenPages()
											* pagination.getCountOfPage()
											- pagination.getCountOfPage();
									while (rs != null && rs.next()) {
										k = k + 1;
							%>
							<tr>
								<td ><%=k%></td>
								<td>
									<%=Common.getFormatStr(rs.getString("title"))%>
								</td>
								<td align="center">
									<div align="center">
										出租
									</div>
								</td>

								<td align="center">
									<div align="center">
										<span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub"))
									.equals("1") ? "已发布" : "未发布"%></span>
									</div>
								</td>
								<td align="center">
									<div align="center">
										<span class="p92j"><a
											href="javascript:otherDeleteData('../rent/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>
											&nbsp;&nbsp; <a
											href="javascript:modifyData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.getFormatInt(rs.getString("class"))%>');">修改</a>
										</span>
									</div>
								</td>
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
		pool3.freeConnection(conn);
	}
%>
