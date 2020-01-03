<%@page contentType="text/html;charset=utf-8" import="com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.*,java.net.*"%> 
<%
String titlename="获奖用户信息";	
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename="+new String((titlename).getBytes(),"iso8859-1")+".xls"); 
%>
<%
	PoolManager pool = (PoolManager)application.getAttribute("poolAPP");
	if(pool == null){
		pool = new PoolManager();
	}
	DataManager dataManager = new DataManager();
	Connection conn = null;

	try{
		conn = pool.getConnection();

		//各奖项统计
		//1
		String countStr1 = "SELECT a.id,a.mem_no,a.mem_name,a.per_phone,b.comp_mobile_phone,b.comp_phone,a.per_province,a.per_city,b.comp_mode,a.jiang,a.jiang_chuli,a.per_email,ISNULL(a.login_last_date,a.add_date) as login_last_date FROM member_info a LEFT JOIN member_info_sub b ON a.mem_no=b.mem_no   WHERE (jiang<>'' AND jiang is not null) or (jiang_chuli<>'' AND jiang_chuli is not null) order by a.login_last_date desc,a.add_date desc";
		ResultSet rs = dataManager.executeQuery(conn,countStr1);
		
%>
<HTML>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head><title>Test</title></head>
<body>
<table width="100%" border="1" cellpadding="4" cellspacing="1" bgcolor="#000000" class="table_border_bg">
	<tr>
            <td  bgcolor="#0000FF" class="title1">ID</td>
            <td  bgcolor="#0000FF" class="title1">用户各</td>
            <td  bgcolor="#0000FF" class="title1">姓名</td>
            <td  bgcolor="#0000FF" class="title1">电话1</td>
            <td  bgcolor="#0000FF" class="title1">电话2</td>
            <td  bgcolor="#0000FF" class="title1">电话3</td>
            <td  bgcolor="#0000FF" class="title1">邮箱</td>
            <td  bgcolor="#0000FF" class="title1">省</td>
            <td  bgcolor="#0000FF" class="title1">市</td>
            <td  bgcolor="#0000FF" class="title1">行业</td>
            <td  bgcolor="#0000FF" class="title1">未处理中奖</td>
            <td  bgcolor="#0000FF" class="title1">已处理中奖</td>
            <td  bgcolor="#0000FF" class="title1">中奖时间</td>
          </tr>
<%
while(rs.next()){
	String id=Common.getFormatStr(rs.getString("id"));
	String mem_no=Common.getFormatStr(rs.getString("mem_no"));
	String mem_name=Common.getFormatStr(rs.getString("mem_name"));
	String per_phone=Common.getFormatStr(rs.getString("per_phone"));
	String comp_mobile_phone=Common.getFormatStr(rs.getString("comp_mobile_phone"));
	String comp_phone=Common.getFormatStr(rs.getString("comp_phone"));
	String per_email=Common.getFormatStr(rs.getString("per_email"));
	String per_province=Common.getFormatStr(rs.getString("per_province"));
	String per_city=Common.getFormatStr(rs.getString("per_city"));
	String login_last_date=Common.getFormatStr(rs.getString("login_last_date"));
	String login_last_date_str = "";
	if(login_last_date != null && !"".equals(login_last_date)){
		login_last_date_str = login_last_date.substring(0,10);
	}
	//行业
	String comp_mode=Common.getFormatStr(rs.getString("comp_mode"));
	String comp_mode_str = "";
	if(comp_mode!=null && !comp_mode.equals("")){
		String[] modeArr = comp_mode.split(",");
		for(int i=0;i<modeArr.length;i++){
			if(modeArr[i]!=null && !modeArr[i].equals("")&& !modeArr[i].equals("null")){
				if(modeArr[i].equals("1")){
					comp_mode_str += "整机生产,";
				}else if(modeArr[i].equals("2")){
					comp_mode_str += "整机销售,";
				}else if(modeArr[i].equals("3")){
					comp_mode_str += "租赁企业,";
				}else if(modeArr[i].equals("4")){
					comp_mode_str += "二手机销售,";
				}else if(modeArr[i].equals("5")){
					comp_mode_str += "维修,";
				}else if(modeArr[i].equals("6")){
					comp_mode_str += "配套,";
				}else if(modeArr[i].equals("7")){
					comp_mode_str += "其他,";
				}else if(modeArr[i].equals("8")){
					comp_mode_str += "配件生产,";
				}else if(modeArr[i].equals("9")){
					comp_mode_str += "配件销售,";
				}else if(modeArr[i].equals("10")){
					comp_mode_str += "施工单位,";
				}
			}
		}
		
	}
	
	//奖品
	String jiang=Common.getFormatStr(rs.getString("jiang"));
	String jiang_str = "";
	if(jiang!=null && !jiang.equals("")){
		String[] jiangArr = jiang.split(",");
		for(int i=0;i<jiangArr.length;i++){
			if(jiangArr[i]!=null && !jiangArr[i].equals("")&& !jiangArr[i].equals("null")){
				if(jiangArr[i].equals("1")){
					jiang_str += "套餐优惠券,";
				}else if(jiangArr[i].equals("2")){
					jiang_str += "会员优惠券,";
				}else if(jiangArr[i].equals("3")){
					jiang_str += "杰配网优惠券,";
				}else if(jiangArr[i].equals("4")){
					jiang_str += "人才网优惠券,";
				}else if(jiangArr[i].equals("5")){
					jiang_str += "21-sun卡盘,";
				}else if(jiangArr[i].equals("6")){
					jiang_str += "21-sun阳光宝宝便签夹,";
				}else if(jiangArr[i].equals("101")){
					jiang_str += "挖掘机报告券,";
				}else if(jiangArr[i].equals("102")){
					jiang_str += "装载机报告券,";
				}else if(jiangArr[i].equals("103")){
					jiang_str += "推土机报告券,";
				}else if(jiangArr[i].equals("104")){
					jiang_str += "压路机报告券,";
				}else if(jiangArr[i].equals("105")){
					jiang_str += "起重机报告券,";
				}
			}
		}
		
	}
	
	//已发放奖品
	String jiang_chuli=Common.getFormatStr(rs.getString("jiang_chuli"));
	String jiang_chuli_str = "";
	if(jiang_chuli!=null && !jiang_chuli.equals("")){
		String[] jiangChuliArr = jiang_chuli.split(",");
		for(int i=0;i<jiangChuliArr.length;i++){
			if(jiangChuliArr[i]!=null && !jiangChuliArr[i].equals("")&& !jiangChuliArr[i].equals("null")){
				if(jiangChuliArr[i].equals("1")){
					jiang_chuli_str += "套餐优惠券,";
				}else if(jiangChuliArr[i].equals("2")){
					jiang_chuli_str += "会员优惠券,";
				}else if(jiangChuliArr[i].equals("3")){
					jiang_chuli_str += "杰配网优惠券,";
				}else if(jiangChuliArr[i].equals("4")){
					jiang_chuli_str += "人才网优惠券,";
				}else if(jiangChuliArr[i].equals("5")){
					jiang_chuli_str += "21-sun卡盘,";
				}else if(jiangChuliArr[i].equals("6")){
					jiang_chuli_str += "21-sun阳光宝宝便签夹,";
				}else if(jiangChuliArr[i].equals("101")){
					jiang_chuli_str += "挖掘机报告券,";
				}else if(jiangChuliArr[i].equals("102")){
					jiang_chuli_str += "装载机报告券,";
				}else if(jiangChuliArr[i].equals("103")){
					jiang_chuli_str += "推土机报告券,";
				}else if(jiangChuliArr[i].equals("104")){
					jiang_chuli_str += "压路机报告券,";
				}else if(jiangChuliArr[i].equals("105")){
					jiang_chuli_str += "起重机报告券,";
				}
			}
		}
		
	}
%>

          <tr>
            <td bgcolor="#FFFFFF"><%=id %></td>
            <td bgcolor="#FFFFFF"><%=mem_no %></td>
            <td bgcolor="#FFFFFF"><%=mem_name %></td>
            <td bgcolor="#FFFFFF"><%=per_phone %></td>
            <td bgcolor="#FFFFFF"><%=comp_mobile_phone %></td>
            <td bgcolor="#FFFFFF"><%=comp_phone %></td>
            <td bgcolor="#FFFFFF"><%=per_email %></td>
            <td bgcolor="#FFFFFF"><%=per_province %></td>
            <td bgcolor="#FFFFFF"><%=per_city %></td>
            <td bgcolor="#FFFFFF"><%=comp_mode_str %></td>
            <td bgcolor="#FFFFFF"><%=jiang_str %></td>
            <td bgcolor="#FFFFFF"><%=jiang_chuli_str %></td>
            <td bgcolor="#FFFFFF"><%=login_last_date_str %></td>
          </tr>
<%
}
%>
</table>
</body>
</HTML>
<%

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
	%>
