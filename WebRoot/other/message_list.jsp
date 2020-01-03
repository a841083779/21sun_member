<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%@ include
	file="/manage/config.jsp"%>
<%
	PoolManager pool3 = new PoolManager(3);
	PoolManager pool1 = new PoolManager(1);
	
	Connection conn = null;
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(15);
	
	String mem_no ="",mem_flag="",rent_webmaster_region  ="";  //负责的省份
	HashMap memberInfo = new HashMap();
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
		mem_flag   = String.valueOf(memberInfo.get("mem_flag"));  //权限
		rent_webmaster_region = String.valueOf(memberInfo.get("rent_webmaster_region"));  //权限
	}
	
	String sort_flag= Common.getFormatInt(request.getParameter("sort_flag"));   //子类别  1为留言 2为询价
	String site_flag= Common.getFormatInt(request.getParameter("site_flag"));   //站点类别  1为租赁 2为二手

	
	String searchStr = "";
    String [] rent_webmaster_region_arr= null;
	
	if(site_flag.equals("1")){    //当为租赁调剂时，如果登陆人是否为站长显示本省下所有留言，否则显示自己的留言
		if(mem_flag.equals("1009")&&!rent_webmaster_region.equals(""))
		{
		searchStr +=" and province in("; 
			if(rent_webmaster_region.indexOf(",")!=-1){  //处理多省份的情况（多省份时用,隔开）
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
		 else {
			searchStr += " and recipients_mem_no ='" + mem_no + "' ";       //否则只显示本人收到的留言
		}
	}else{
	        if(!mem_no.equals("")){  
				searchStr += " and recipients_mem_no ='" + mem_no + "' ";
			}else{
			    searchStr += " and recipients_mem_no = '-1'";
			}
	}
	
	
	
	
		
	
	searchStr += " and sort_flag ='" + sort_flag + "' ";
	searchStr += " and site_flag ='" + site_flag + "' ";
	
	
	String title=Common.getFormatStr(request.getParameter("title"));
	if(!title.equals("")){
	   searchStr +=" and title like '%"+title+"%'";
	}
    	
	String query = "select id,title,sender_mem_name,add_date,is_read,info_id from member_message where 1=1 " + searchStr
			+ " order by id desc";			
	String tablename = "member_message";
	
	String sortFlagStr="";
	if(sort_flag.equals("1")){
	   sortFlagStr="留言";
	}else if(sort_flag.equals("2")){
	   sortFlagStr="询价单";
	}
//out.print("query:====="+query);	
	try {
		conn = pool1.getConnection(); //SQL查询	
		ResultSet rs = pagination.getQueryResult(query, request, conn);
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
		  function viewMessage(objstr,objstr1,objstr2){			    
		    self.location="message_view.jsp?myvalue="+encodeURIComponent(objstr)+"&sort_flag="+encodeURIComponent(objstr1)+"&site_flag="+encodeURIComponent(objstr2);
		  }
		</script>
	</head>
	<body>
	<form action="" method="get" name="theform" id="theform">
			<div class="loginlist_right2">
				<span class="mainyh">
					<%
						if(site_flag.equals("5")){
					%>
						供求<%=sortFlagStr%>	 
					<%
						}else if(site_flag.equals("4")){				 
					%>
						配件<%=sortFlagStr%>	 
					<%
						}else if(site_flag.equals("2")){				 
					%>
						二手<%=sortFlagStr%>	 
					<%
						}else if(site_flag.equals("1") ){				 
					%>
						租赁<%=sortFlagStr%>	 
					<%}%>				
				</span>
			</div>
			
	<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0" class="list">
          <tr>
            <td valign="top">
			<table width="100%"  border="0" cellpadding="0" cellspacing="0"  class="list">
                <tr>
                  <td width="1%" class="title_bar">&nbsp;</td>
                  <td width="23%" class="p94b">相关搜索：</td>
                  <td width="65%" align="center" nowrap> 标题：
                    <input name="title" type="text" id="title" size="15" value="<%=title%>">               
                    <input type="submit" name="Submit" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom06.gif) left top no-repeat;cursor: pointer;" >
                    <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onClick="javascript:clearForm()">
                  </td>
                  <td width="18%" align="right" class="title_bar">&nbsp;</td>
                </tr>                
              </table>
              <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="15"></td>
                </tr>
              </table>		
				<table width="100%" border="0" class="list">
					<tr>
						<th width="4%">
						<div align="center"><strong>ID</strong></div>
						</th>
						<th>
							<div align="center"><strong>标题(点击查看)</strong></div>
						</th>
						<th width="15%">
							<div align="center"><strong>询价人</strong></div>
						</th>
						<th width="10%">
							<div align="center"><strong>发送时间</strong></div>
						</th>
						<th width="15%">
							<div align="center"><strong>是否阅读</strong></div>
						</th>
						<!--
						<th width="12%">
							<div align="center"><strong>来源</strong></div>
						</th>-->
						<th width="12%">
							<div align="center"><strong>联系方式</strong></div>
						</th>
						<th width="15%">
							<div align="center"><strong>操作</strong></div>
						</th>
					</tr>

					<%
						int k = 0;
						String is_read="";
						while (rs != null && rs.next()) {
							k++;								
							is_read   = Common.getFormatStr(rs.getString("is_read"));
					%>
					<tr>
						<td><div align="center"><%=k%></div></td>
						<td><div align="center"><a href="javascript:viewMessage('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(sort_flag)%>','<%=Common.encryptionByDES(site_flag)%>')"><%=Common.getFormatStr(rs.getString("title"))%></a></div></td>
						<td><div align="center"><%=Common.getFormatStr(rs.getString("sender_mem_name"))%></div></td>
						<td><div align="center"> <%=Common.getFormatDate("yyyy-MM-dd", rs.getDate("add_date"))%></div></td>
						<td><div align="center"> <%=is_read.equals("0")?"<font color='red'>未阅读</font>":"已阅读"%></div></td>						
						<!--<td align="center"><div align="center">
						<% if(!Common.getFormatStr(rs.getString("info_id")).equals("")){%>
						<a href="<%=Common.getFormatStr(rs.getString("info_id"))%>" target="_blank">查看来源</a></div>
						<%}else{out.print("-");}%></td>-->
						<td align="center"><div align="center"><a href="javascript:viewMessage('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(sort_flag)%>','<%=Common.encryptionByDES(site_flag)%>')">点击查看</a></div></td>
						
						<td><div align="center"> <a href="javascript:otherDeleteData('opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>&nbsp;&nbsp;</div></td>
					</tr>
					<%
						}
					%>
				</table>
				<table width="100%" border="0" class="list">

					<tr>
						<td align="left">
							<%
								out.println(pagination.pagesPrint(8));
							%>
						</td>
					</tr>
				</table>
				</td>   
				<td></td>
			</tr>
		</table>
		<input type="hidden" name="sort_flag" value="<%=sort_flag%>" />
		<input type="hidden" name="site_flag" value="<%=site_flag%>" />
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
