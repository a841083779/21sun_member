<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%@ include
	file="/manage/config.jsp"%>
<%
	PoolManager pool3 = new PoolManager(3);
	Connection conn = null;
	try {
		conn = pool3.getConnection(); //SQL查询	
		Pagination pagination = new Pagination();
		//设置每页显示条数
		pagination.setCountOfPage(15);
		
		String mem_no ="",rent_webmaster_region  ="";//负责的省份
		HashMap memberInfo = new HashMap();
		String mem_flag="";
		if(session.getAttribute("memberInfo")!=null){   
			memberInfo = (HashMap) session.getAttribute("memberInfo");
			mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
			mem_flag   = String.valueOf(memberInfo.get("mem_flag"));  //权限
			rent_webmaster_region = "";  //权限
		}	
		String searchStr = "";
		ResultSet rsRentMaster = DataManager.executeQuery(conn," select province from rent_master where mem_no = '"+mem_no+"' ");
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
		
		String comp_name = Common.getFormatStr(request
				.getParameter("comp_name"));    //标题
		if (!comp_name.equals("")) {
			searchStr = " and comp_name like '%" + comp_name + "%'";
		}
		String query = "select * from rent_company_info where ( rent_company_type= 1 or rent_company_type = 2 ) " + searchStr
				+ " order by comp_recom desc , (select count(*) from equipment where mem_no = rent_company_info.mem_no) desc , len(convert(varchar(8000),comp_intro)) desc , id desc";
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
		    self.location="enterprise_view.jsp?myvalue="+encodeURIComponent(objstr);
		  }
		</script>
	</head>
	<body>
		<form action="" method="get" name="theform" id="theform">

			<div class="loginlist_right">
				<div class="loginlist_right2">
					<span class="mainyh">租赁企业管理</span>
				</div>
				<div class="loginlist_right1">
					
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="1%" class="title_bar">&nbsp;
									
								</td>
								<td width="23%" class="p94b">&nbsp;
									
								</td>
								<td width="65%" align="center" nowrap>
									标题：
									<input name="comp_name" type="text" id="comp_name"
										size="15" value="<%=comp_name%>">

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


						<table width="100%" border="0" class="list">
							<tr>
								<th width="4%">
									ID
								</th>
								<th>
									公司名称
								</th>
								<th width="15%">
									联系人
								</th>
								<th width="10%">
									企业类型
								</th>
								<th width="10%">
									操作
								</th>
							</tr>
							<%
								int k = pagination.getCurrenPages()
											* pagination.getCountOfPage()
											- pagination.getCountOfPage();
							String is_recom = "";
									while (rs != null && rs.next()) {
										k++;
										is_recom = Common.getFormatStr(rs.getString("comp_recom"));
							%>
							<tr <%=(k % 2) == 0 ? "bgcolor='#F9F9F9'" : ""%>>
								<td><%=k%></td>
								<td>
									<a
										href="javascript:viewList('<%=Common.encryptionByDES(rs.getString("id"))%>')"><%=Common.getFormatStr(rs.getString("comp_name"))%></a>
								</td>
								<td>
									<%=Common.getFormatStr(rs.getString("mem_name"))%>
								</td>
								<td>
									<%
										String rent_company_type = Common.getFormatStr(rs.getString("rent_company_type"));
										if("1".equals(rent_company_type)){
											out.print("<span style='color:red;'>租赁企业</span>");
										}else{
											out.print("施工企业");
										}
									%>
								</td>
								<td>
								<%
					          	if(is_recom.equals("1")){
					          		%><a style="color:blue;" href="javascript:void(0);" onclick="setTuiJian('<%=rs.getString("id") %>',0);">取消推荐</a><%
					          	}else{
					          		%><a style="color:blue;" href="javascript:void(0);" onclick="setTuiJian('<%=rs.getString("id") %>',1);">推荐</a><%
					          	}
					          	%>
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
<script type="text/javascript">
function setTuiJian(id,is_recom){
	$.post("action.jsp",{
		flag : 'tuijian_qiye',
		id : id ,
		is_recom : is_recom
	},function(){
		window.location.reload();
	});
}
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool3.freeConnection(conn);
	}
%>
