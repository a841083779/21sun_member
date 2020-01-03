<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%@ include
	file="/manage/config.jsp"%>
<%
	PoolManager pool3 = new PoolManager(3);
	Connection conn = null;

	String tablename = "rent_info";

	String mem_no ="",mem_flag="";
	String comp_id="",rent_mode="";
	HashMap memberInfo = new HashMap();
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
		mem_flag= String.valueOf(memberInfo.get("mem_flag")); 

		//add by gaopeng at 20130418
		comp_id = Common.getFormatStr(memberInfo.get("id")) ;
		rent_mode = Common.getFormatStr(memberInfo.get("rent_mode"));
	}	  
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(18);
	StringBuffer query = new StringBuffer("select * from " + tablename
			+ " where 1=1 ");
	//得到参数
	String title = Common.getFormatStr(request.getParameter("title"));
	if (!title.equals("")) {
		query.append(" and title like '%" + title + "%'");
	}
	String find_class = Common.getFormatStr(request.getParameter("find_class"));
	if (!find_class.equals("")) {
		query.append(" and class like '%" + find_class + "%'");
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
		   self.location="rent_opt.jsp?myvalue="+encodeURIComponent(objstr1);
	     }
       </script>
		<script language="javascript" type="text/javascript">
			function setFlag(flag){
			<%if(!mem_flag.equals("1005")&&!mem_flag.equals("1009")){%>
			alert("只有租赁通会员才能批量更新!");
			return;
			<%}%>
			var checkdel = document.getElementsByName('checkdel');
			var checkedFlag=false;
				for(i=0;i<checkdel.length;i++){
					if(checkdel[i].checked){
					  checkedFlag = true;
					}
				}
				if(checkedFlag){
					if(confirm("确定这样操作吗？")){
						document.theform.action = "tool.jsp?flag="+flag;
						document.theform.target = "hiddenFrame";
						document.theform.method = "post";
						document.theform.submit();
					}
				}else{
				  alert("请选择要更新的信息！");
				}	
			}
		</script>
	</head>
	<body>
		<form action="" method="get" name="theform" id="theform">
			<div class="loginlist_right">
				<div class="loginlist_right2">
					<span class="mainyh" style="float:left;">管理租赁信息</span><%if(mem_flag.equals("1005")){ %><div style="width:120px; float:right;line-height:35px; font-weight:bold;"><a href="http://www.21-rent.com/shop/shopdetail<%=rent_mode %>_for_<%=comp_id %>.htm" target="_blank">进入我的店铺&gt;&gt;</a><%} %>
				</div>
				 <div class="loginlist_right2"><strong>"更新"</strong>操作将会使您的信息靠前显示;&nbsp;&nbsp;&nbsp;&nbsp; <a href="../rent/equipment_list.jsp">租赁设备管理</a></div>
				 <div class="loginlist_right1">			
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="9%">								
									租赁类型：
							    </td>
								<td width="8%" ><select size="1" name="find_class" id="find_class">
								            	<option value="">请选择</option>
												<option value="1" <%=find_class.equals("1")?"Selected":""%>>出租</option>
												<option value="0" <%=find_class.equals("0")?"Selected":""%>>求租</option>
									        </select>
							  </td>
								<td width="83%">
									标题：
										<input name="title" type="text" id="title" size="15"
										value="<%=title%>">&nbsp;
										<input type="submit" name="Submit" value=""
										style="width: 52px; height: 19px; border: none; background: url(../images/bottom06.gif) left top no-repeat; cursor: pointer;">
										<input type="button" name="Submit2" value=""
										style="width: 52px; height: 19px; border: none; background: url(../images/bottom07.gif) left top no-repeat; cursor: pointer;"
										onClick="javascript:clearForm()">
							  </td>
							
							</tr>
						</table>
						<div style="width:100%;height:29px;padding:5px 0px;">
						<span class="title_bar">
						<a href="javascript:setFlag('0');" style="width:80px;float:left" title="批量更新信息的发布时间，以便让信息在前面显示"><img src="../images/plgx.gif" border="0"/></a>							<span class="title_bar"> <input name="add_b" type="button"
								class="form_button" id="add_b" value=""
								style="width: 78px; height: 29px; border: none; background: url(../images/bottom03.gif) left top no-repeat; cursor: pointer;"
								onclick="window.location.href='rent_opt.jsp'">
						</span>
						</div>
						<table width="100%" border="0" class="list">
							<tr>
								<th width="2%" align="center"><input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" /></th>
								<th width="8%">
									<div align="center">ID</div>
							  </th>
								<th width="32%">
							  <div align="left">信息标题</div></th>
								<th width="15%">
									<div align="center">业务分类</div>
							  </th>
								<th width="15%">
									<div align="center">发布日期</div>
							  </th>
								<th width="12%">
									<div align="center">是否显示</div>
							  </th>
								<th width="18%">
									<div align="center">操作</div>
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
								<td height="30" align="center">
	    <input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" /></td>
								<td><div align="center"><%=k%></div></td>
								<td>
									<div align="left"><a
											href="javascript:modifyData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.getFormatInt(rs.getString("class"))%>');"><%=Common.getFormatStr(rs.getString("title"))%></a></div></td>
								<td align="left">
									<div align="center">
										<%
											if(Common.getFormatInt(rs.getString("class")).equals("1")){
												out.print("出租");
											}else{
												out.print("求租");
											}
										%></div>								
								</td>
								<td><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></div></td>
								<td align="center">
									<div align="center">
										<span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub"))
									.equals("1") ? "已发布" : "未发布"%></span>
									</div>
								</td>
								<td align="center">
									<div align="center">
										<span class="p92j"><!--<a
											href="javascript:otherDeleteData('../rent/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>
											&nbsp;&nbsp; --><a
											href="javascript:modifyData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.getFormatInt(rs.getString("class"))%>');">修改</a>&nbsp;&nbsp;<a href="update_pubdate.jsp?mypy=<%=Common.encryptionByDES(tablename)%>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>&urlpath=rent_list.jsp&mem_flag=<%=mem_flag%>">更新</a>&nbsp;&nbsp;<a href="http://www.21-rent.com/rent/rentdetail_for_<%=Common.getFormatStr(rs.getString("id")) %>.htm" target="_blank">预览</a>
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
			<input name="tablename" id="tablename"  type="hidden" value="<%=Common.encryptionByDES(tablename)%>"/>
		</form>
		 <iframe name="hiddenFrame" style="display:none"></iframe>
	</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool3.freeConnection(conn);
	}
%>
