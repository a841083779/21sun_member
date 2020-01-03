<%@ page language="java" import="java.util.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.Connection" pageEncoding="UTF-8"%><%
	PoolManager usedPool = new PoolManager(4);
	Connection connection = null;
	String rs = "fail";
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String uuid = Common.getFormatStr(request.getParameter("zd_uuid"));
	String sql = "";
	if("".equals(uuid)){
		uuid = UUID.randomUUID().toString();
		sql = " INSERT INTO used_sell (add_user, add_date, add_ip, uuid, mem_no, mem_name, mem_phone, mem_company, mem_address, mem_email, title, model , factorydate , other_brand , brand_id , other_category , category_id, province, city, img1, detail, pub_date, is_pub, clicked, file_name, is_import, order_count)  ";
		sql += " VALUES ('"+Common.getFormatStr(memberInfo.get("mem_no"))+"', '"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"', ";
		sql += " '"+Common.getFormatStr(request.getRemoteAddr())+"' , '"+uuid+"' , '"+Common.getFormatStr(memberInfo.get("mem_no"))+"' , '"+Common.getFormatStr(memberInfo.get("mem_name"))+"' , ";
		sql += " '"+Common.getFormatStr(memberInfo.get("per_phone"))+"' , '"+Common.getFormatStr(memberInfo.get("comp_name"))+"' , '"+Common.getFormatStr(memberInfo.get("comp_address"))+"' , ";
		sql += " '"+Common.getFormatStr(memberInfo.get("per_email"))+"' , '"+Common.getFormatStr(request.getParameter("zd_title"))+"', ";
		sql += " '"+Common.getFormatStr(request.getParameter("zd_model"))+"' , '"+Common.getFormatStr(request.getParameter("zd_factorydate"))+"' , ";
		sql += " '"+Common.getFormatStr(request.getParameter("zd_other_brand"))+"' , '"+Common.getFormatStr(request.getParameter("zd_brand_id"))+"' , ";
		sql += " '"+Common.getFormatStr(request.getParameter("zd_other_category"))+"' , '"+Common.getFormatStr(request.getParameter("zd_category_id"))+"' , ";
		sql += " '"+Common.getFormatStr(request.getParameter("zd_province"))+"' , '"+Common.getFormatStr(request.getParameter("zd_city"))+"' , ";
		sql += " '"+Common.getFormatStr(request.getParameter("zd_img1"))+"' , '"+Common.getFormatStr(request.getParameter("zd_detail"))+"' , '"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"' , ";
		sql += " '1' , '0' , '' , '1' , '0' ) ";
	}else{
		sql = "UPDATE used_sell SET ";
		sql += " title = '"+Common.getFormatStr(request.getParameter("zd_title"))+"' , ";
		sql += " model = '"+Common.getFormatStr(request.getParameter("zd_model"))+"' , ";
		sql += " factorydate = '"+Common.getFormatStr(request.getParameter("zd_factorydate"))+"', ";
		sql += " brand_id = '"+Common.getFormatStr(request.getParameter("zd_brand_id"))+"', ";
		sql += " category_id = '"+Common.getFormatStr(request.getParameter("zd_category_id"))+"', ";
		sql += " province = '"+Common.getFormatStr(request.getParameter("zd_province"))+"', ";
		sql += " city = '"+Common.getFormatStr(request.getParameter("zd_city"))+"', ";
		sql += " img1 = '"+Common.getFormatStr(request.getParameter("zd_img1"))+"', ";
		sql += " detail = '"+Common.getFormatStr(request.getParameter("zd_detail"))+"' , ";
		sql += " is_pub = 1 ";
		sql += " where uuid = '"+uuid+"' ";
	}
	String url = request.getRequestURI();
	if (url.indexOf("webadmin") == -1 && DataManager.filterKeyWords(request)) {
		rs = "fail";
	}else{
		try{
			connection = usedPool.getConnection();
			if(DataManager.dataOperation(connection,sql)>0){
				rs = "ok";
			}
		}catch(Exception e){
			
		}finally{
			usedPool.freeConnection(connection);		
		}
	}
	out.print(rs);
%>