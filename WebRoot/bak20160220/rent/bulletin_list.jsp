<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%
	PoolManager pool3 = new PoolManager(3);
    Connection conn =null;
try{
	conn = pool3.getConnection();
	String tablename="rent_news";	
	Pagination pagination = new Pagination();   //设置每页显示条数
	pagination.setCountOfPage(20);
	
	String mem_no ="";
	HashMap memberInfo = new HashMap();
	
	String rent_webmaster_region  ="";  //负责的省份
	String [] rent_webmaster_region_arr= null; 
	String mem_flag="";
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
		rent_webmaster_region = "";  //负责的省份
		mem_flag   = String.valueOf(memberInfo.get("mem_flag"));  //权限
	}	
	ResultSet rsRentMaster = DataManager.executeQuery(conn," select province from rent_master where mem_no = '"+mem_no+"' ");
	while(rsRentMaster.next()){
		rent_webmaster_region += "'"+rsRentMaster.getString("province")+"',";
	}
	if(rent_webmaster_region.length()>0){
		rent_webmaster_region = rent_webmaster_region.substring(0,rent_webmaster_region.length()-1);
	}
	String searchStr ="";
	if(mem_flag.equals("1009")){   //租赁站长
		 if(!rent_webmaster_region.equals("")){ 
		   searchStr +=" and url in ( "+ rent_webmaster_region + " ) "; 
		}
	}  
	String title=Common.getFormatStr(request.getParameter("title"));
	if(!title.equals("")){
		searchStr+= " and title like '%"+title+"%'";        
	}	
	StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 "+searchStr+" and  category='1002' "); //得到参数
	//SQL查询	
	ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
	String bar = pagination.pagesPrint(10);  //读取分页提
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
	function modifyData(objstr){	
		self.location="bulletin_opt.jsp?myvalue="+encodeURIComponent(objstr);
	}
</script>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
 	<div class="loginlist_right">
				<div class="loginlist_right2">
					<span class="mainyh">站内公告管理</span>
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
								onclick="window.location.href='bulletin_opt.jsp'">
					</span>
			
					<table width="100%" border="0" class="list">
							<tr>
								<th width="4%">
									ID
								</th>
								<th width="43%">
									标题								</th>
								<th width="18%">
									发布日期								</th>
								<th width="11%">
									是否发布								</th>
								<th width="10%">
									点击次数								</th
								>
								<th width="14%">
									操作								</th>
							</tr>					
           
				<%
				 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
				 while (rs!=null && rs.next()){
				   k=k+1;				
				%>					
                <tr>
                  <td ><%=k%></td>
                  <td><%=Common.getFormatStr(rs.getString("title"))%></td>
                  <td ><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></td>
                  <td ><%=Common.getFormatStr(rs.getString("is_pub")).equals("1")?"已发布":"未发布"%></td>
                  <td >
				     <%=Common.getFormatInt(rs.getString("clicked"))%>
				  </td>
				   <td >
				     
					  	<a href="javascript:otherDeleteData('../rent/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="javascript:modifyData('<%=Common.encryptionByDES(rs.getString("id"))%>');">修改</a>			
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
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool3.freeConnection(conn);
}
%>
