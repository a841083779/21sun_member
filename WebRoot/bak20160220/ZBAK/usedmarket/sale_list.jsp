<%@page contentType="text/html;charset=utf-8" import="com.jerehnet.cmbol.database.*,java.sql.*,java.util.*,com.jerehnet.util.*" %>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%
	PoolManager poolManager = new PoolManager(4);
	Pagination pagination = new Pagination();
	pagination.setCountOfPage(20);
	Connection connection = null;
	ResultSet she_bei_lei_bie = null;
	ResultSet she_bei_pin_pai = null;
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	ResultSet rs = null;
	try{
		connection = poolManager.getConnection();
		Map brandMap = new HashMap();
		Map categoryMap = new HashMap();
		String query = "";
		String find_category = "";
		String find_brand = "";
		String find_model = "";
		query = " select id,brand_name from used_brand ";
		rs = DataManager.executeQuery(connection,query);
		while(null!=rs&&rs.next()){
			brandMap.put(rs.getString("id"),rs.getString("brand_name"));
		}
		if(null!=rs){
			rs.close();
		}
		query = " select id,category_name from used_category ";
		rs = DataManager.executeQuery(connection,query);
		while(null!=rs&&rs.next()){
			categoryMap.put(rs.getString("id"),rs.getString("category_name"));
		}
		if(null!=rs){
			rs.close();
		}
		query = " select * from used_equipment ";
		query += " where mem_no = '"+memberInfo.get("mem_no")+"' ";
		find_category = Common.getFormatStr(request.getParameter("find_category"));
		if(!"".equals(find_category)){
			query += " and category_id = '"+find_category+"' ";
		}
		find_brand = Common.getFormatStr(request.getParameter("find_brand"));
		if(!"".equals(find_brand)){
			query += " and find_brand = '"+find_brand+"' ";
		}
		find_model = Common.getFormatStr(request.getParameter("find_model"));
		if(!"".equals(find_model)){
			query += " and find_model like '%"+find_model+"%' ";
		}
		query += "order by add_date desc ";
		rs = pagination.getQueryResult(query,request,connection);
		she_bei_lei_bie = DataManager.executeQuery(connection," select id,category_name from used_category ");
		she_bei_pin_pai = DataManager.executeQuery(connection," select id,(letter+' '+brand_name) as brand_name from used_brand order by letter ");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理二手设备</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
</head>
<body>
  <div class="loginlist_right">
    <div class="loginlist_right2"> <span class="mainyh">管理二手设备信息</span> </div>
    <div class="loginlist_right1">
    			<form action="" method="get">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							设备类型：
					      <select name="find_category"  id="find_category" style="width: 130px; height: 24px;">
			                  <option value="">--设备类型--</option>
			                  <%
			                  while(null!=she_bei_lei_bie&&she_bei_lei_bie.next()){
			                	  %>
			                <option value="<%=Common.getFormatStr(she_bei_lei_bie.getString("id")) %>"><%=Common.getFormatStr(she_bei_lei_bie.getString("category_name")) %></option>
			                	  <%
			                  }
			                  %>
			                </select>
			                设备品牌：
					      <select name="find_brand"  id="find_brand" style="width: 130px; height: 24px;">
			                  <option value="">--设备品牌--</option>
			                  <%
			                  while(null!=she_bei_pin_pai&&she_bei_pin_pai.next()){
			                	  %>
			                <option value="<%=Common.getFormatStr(she_bei_pin_pai.getString("id")) %>"><%=Common.getFormatStr(she_bei_pin_pai.getString("brand_name")) %></option>
			                	  <%
			                  }
			                  %>
			                </select>
			                设备型号：
			                <input type="text" style="width: 130px;height: 20px;" name="find_model" id="find_model" />
			                &nbsp;
							<input type="submit" style="background-image: url('/images/mem_btnbg_1.gif'); border:none;margin: 0;padding: 0; width: 60px; height: 24px;font-weight:bold;cursor: pointer;color: #000;" value="查 询" />
							<input type="reset" style="background-image: url('/images/mem_btnbg_1.gif'); border:none;margin: 0;padding: 0; width: 60px; height: 24px;font-weight:bold;cursor: pointer;color: #000;" value="清 空" />
						</td>					
					</tr>
				</table> 
				</form>
				<script type="text/javascript">
					jQuery("#find_category").val("<%=find_category %>");
					jQuery("#find_brand").val("<%=find_brand %>");
					jQuery("#find_model").val("<%=find_model %>");
				</script>
      <table width="100%" border="0" class="list" style="margin-top: 5px;">
        <tr>		  
          <th width="15%"><div align="center">设备品牌</div></th>
          <th width="15%"><div align="center">设备类型</div></th>
		  <th width="15%"><div align="center">设备型号</div></th>
          <th width="10%"><div align="center">出厂年份</div></th>
		  <th width="12%"><div align="center">发布日期</div></th>
          <th width="10%" ><div align="center">订购留言</div></th>
          <th width="10%" ><div align="center">操作</div></th>
        </tr>
		<%
			while(null!=rs&&rs.next()){
				%>
        <tr>
        	<td style="text-align: center;"><a href="sale_opt.jsp?uuid=<%=Common.getFormatStr(rs.getString("uuid")) %>"><%=Common.getFormatStr(brandMap.get(rs.getString("brand_id"))) %></a></td>
        	<td style="text-align: center;"><a href="sale_opt.jsp?uuid=<%=Common.getFormatStr(rs.getString("uuid")) %>"><%=Common.getFormatStr(categoryMap.get(rs.getString("category_id"))) %></a></td>
			<td><div align="left"><a href="sale_opt.jsp?uuid=<%=Common.getFormatStr(rs.getString("uuid")) %>"><%=Common.getFormatStr(rs.getString("model")) %></a></div></td>
			<td><div align="center"><%=Common.getFormatStr(rs.getInt("factorydate")) %>年</div></td>
			<td><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date")) %></div></td>
			<td><div align="center">(<b><%=Common.getFormatStr(rs.getString("order_count")) %></b>)【<a href="javascript:void(0);" onclick="seeMessage('<%=Common.getFormatStr(rs.getString("id")) %>');"><font color='green'>查看</font></a>】</div></td>
			</td>
			<td style="text-align: center;">
				<a href="sale_opt.jsp?uuid=<%=Common.getFormatStr(rs.getString("uuid")) %>">修改</a>
			</td>
        </tr>
				<%
			}
		if(null!=rs){
			rs.close();
		}
		%>
      </table>
      <table width="100%" border="0" class="list">
        <tr>
          <td align="left">
          	<%=pagination.paginationPrint() %>
          </td>
        </tr>
      </table>
    </div>
  </div>
	<input type="hidden" name="findOrderFlag" id="findOrderFlag" />
	<input type="hidden" name="findOrderTag"  id="findOrderTag"  value="desc" />
	<input name="tablename" id="tablename"  type="hidden" value="61358d80b3b94d2405660e2cee5aa7df09d17139cf87f819" />
</body>
</html>
<script type="text/javascript">
function seeMessage(infoid){
	var url = "message_list.jsp?infoid="+infoid+"&flag=1";
	window.location.href = url;
}
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		poolManager.freeConnection(connection);
	}
%>