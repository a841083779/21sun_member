<%@ page language="java" import="java.util.*,com.jerehnet.cmbol.database.*,java.sql.Connection,com.jerehnet.util.*,java.sql.PreparedStatement,java.sql.Statement" pageEncoding="UTF-8"%><%
	PoolManager usedPool = new PoolManager(4);
	Connection connection = null;
	PreparedStatement psmt = null;
	String sql = "";
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String rs = "fail";
	String url = request.getRequestURI();
	if (url.indexOf("webadmin") == -1 && DataManager.filterKeyWords(request)) {
		rs = "fail";
	}else{
		try{
			connection = usedPool.getConnection();
			connection.setAutoCommit(false);
			String uuid = Common.getFormatStr(request.getParameter("zd_uuid"));
			if("".equals(uuid)){
				sql = " INSERT INTO used_equipment ( ";
				sql += " add_user, add_date, add_ip, uuid, mem_no, mem_name, mem_company, ";
				sql += " recom, category, subcategory, brand, brandname, ";
				sql += " model, place, province, city, workingtime, factorydate, ";
				sql += " car_no, engine, tons, repairfile, ";
				sql += " cap_desc, elect_desc, power_desc, hyd_desc, vision_desc, detail, order_count, source, checkbook, ";
				sql += "logistics, price, is_sale, buyer_name, buyer_address, buyer_contact, sale_date, fromflag, from_id, ";
				sql += "linkman, linkman_phone, linkman_email , linkman_address, linkman_company, is_pub, clicked, category_id, brand_id, file_name, is_import";
				sql += ",img1_1";
				for(int i=1;i<32;i++){
					sql += ",img"+i;
				}
				sql += " ) ";
				sql += " VALUES ( ";
				sql += " ?, ?, ?, ?, ?, ?, ?, ";
				sql += " ?, ?, ?, ?, ?, ";
				sql += " ?, ?, ?, ?, ?, ?, ";
				sql += " ?, ?, ?, ?, ";
				sql += " ?, ?, ?, ?, ?, ?, ?, ?, ?, ";
				sql += "?, ?, ?, ?, ?, ?, ?, ?, ?, ";
				sql += "?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ? ";
				for(int i=0;i<32;i++){
					sql += " , ? ";
				}
				sql += " ) ";
				psmt = connection.prepareStatement(sql);
				List params = new ArrayList(0);
				params.add(Common.getFormatStr(memberInfo.get("mem_no")));//add_user
				params.add(Common.getToday("yyyy-MM-dd HH:mm:ss"));//add_date
				params.add(Common.getFormatStr(request.getRemoteAddr()));//add_ip
				params.add(Common.getFormatStr(UUID.randomUUID()));//uuid
				params.add(Common.getFormatStr(memberInfo.get("mem_no")));//mem_no
				params.add(Common.getFormatStr(memberInfo.get("mem_name")));//mem_name
				params.add(Common.getFormatStr(memberInfo.get("comp_name")));//mem_company
				params.add(0);//recom
				params.add("");//category
				params.add("");//subcategory
				params.add("");//brand
				params.add("");//brandname
				params.add(Common.getFormatStr(request.getParameter("zd_model")));//model
				params.add(Common.getFormatStr(request.getParameter("zd_place")));//place
				params.add(Common.getFormatStr(request.getParameter("zd_province")));//province
				params.add(Common.getFormatStr(request.getParameter("zd_city")));//city
				params.add(Common.getFormatStr(request.getParameter("zd_workingtime")));//workingtime
				params.add(Common.getFormatStr(request.getParameter("zd_factorydate")));//factorydate
				params.add(Common.getFormatStr(request.getParameter("zd_car_no")));//car_no
				params.add(Common.getFormatStr(request.getParameter("zd_engine")));//engine
				params.add(Common.getFormatStr(request.getParameter("zd_tons")));//tons
				params.add(Common.getFormatStr(request.getParameter("zd_repairfile")));//repairfile
				params.add(Common.getFormatStr(request.getParameter("zd_cap_desc")));//cap_desc
				params.add(Common.getFormatStr(request.getParameter("zd_elect_desc")));//elect_desc
				params.add(Common.getFormatStr(request.getParameter("zd_power_desc")));//power_desc
				params.add(Common.getFormatStr(request.getParameter("zd_hyd_desc")));//hyd_desc
				params.add(Common.getFormatStr(request.getParameter("zd_vision_desc")));//vision_desc
				params.add(Common.getFormatStr(request.getParameter("zd_detail")));//detail
				params.add(0);//order_count
				params.add(Common.getFormatStr(request.getParameter("zd_source")));//source
				params.add(Common.getFormatStr(request.getParameter("zd_checkbook")));//checkbook
				params.add(Common.getFormatStr(request.getParameter("zd_logistics")));//logistics
				params.add(Common.getFormatStr(request.getParameter("zd_price")));//price
				params.add(0);//is_sale
				params.add("");//buyer_name
				params.add("");//buyer_address
				params.add("");//buyer_contact
				params.add("");//sale_date
				params.add(0);//fromflag
				params.add(0);//from_id
				params.add(Common.getFormatStr(memberInfo.get("mem_name")));//linkman
				params.add(Common.getFormatStr(memberInfo.get("per_phone")));//linkman_phone
				params.add(Common.getFormatStr(memberInfo.get("per_email")));//linkman_email
				params.add(Common.getFormatStr(memberInfo.get("comp_address")));//linkman_address
				params.add(Common.getFormatStr(memberInfo.get("comp_name")));//linkman_company
				params.add(1);//is_pub
				params.add(0);//clicked
				params.add(Common.getFormatStr(request.getParameter("zd_category_id")));//category_id
				params.add(Common.getFormatStr(request.getParameter("zd_brand_id")));//brand_id
				params.add("");//file_name
				params.add(0);//is_import
				for(int i=0;i<32;i++){
					if(i==0){
						params.add(Common.getFormatStr(request.getParameter("img1")));
					}else{
						params.add(Common.getFormatStr(request.getParameter("img"+i)));
					}
				}
				for(int i=0;i<params.size();i++){
					psmt.setObject(i+1,params.get(i));
				}
				psmt.execute();
			}else{
				sql = " UPDATE used_equipment ";
				sql += " SET ";
				sql += " model = ? , ";
				sql += " place = ? , ";
				sql += " province = ? , ";
				sql += " city = ? , ";
				sql += " workingtime = ? , ";
				sql += " factorydate = ? ,";
				sql += " car_no = ? ,";
				sql += " engine = ? ,";
				sql += " tons = ? ,";
				sql += " repairfile = ? ,";
				sql += " cap_desc = ? ,";
				sql += " elect_desc = ? ,";
				sql += " power_desc = ? ,";
				sql += " hyd_desc = ? ,";
				sql += " vision_desc = ? ,";
				sql += " detail = ? ,";
				sql += " source =  ? ,";
				sql += " checkbook =  ? ,";
				sql += " logistics =  ? ,";
				sql += " price =  ? ,";
				sql += " category_id =  ? ,";
				sql += " brand_id = ? , ";
				sql += " img1_1 = ? ";
				for(int i=1;i<32;i++){
					sql += " , img"+i +" = ? ";
				}
				sql += " where uuid = ? ";
				psmt = connection.prepareStatement(sql);
				List params = new ArrayList(0);
				params.add(Common.getFormatStr(request.getParameter("zd_model")));//model
				params.add(Common.getFormatStr(request.getParameter("zd_place")));//place
				params.add(Common.getFormatStr(request.getParameter("zd_province")));//province
				params.add(Common.getFormatStr(request.getParameter("zd_city")));//city
				params.add(Common.getFormatStr(request.getParameter("zd_workingtime")));//workingtime
				params.add(Common.getFormatStr(request.getParameter("zd_factorydate")));//factorydate
				params.add(Common.getFormatStr(request.getParameter("zd_car_no")));//car_no
				params.add(Common.getFormatStr(request.getParameter("zd_engine")));//engine
				params.add(Common.getFormatStr(request.getParameter("zd_tons")));//tons
				params.add(Common.getFormatStr(request.getParameter("zd_repairfile")));//repairfile
				params.add(Common.getFormatStr(request.getParameter("zd_cap_desc")));//cap_desc
				params.add(Common.getFormatStr(request.getParameter("zd_elect_desc")));//elect_desc
				params.add(Common.getFormatStr(request.getParameter("zd_power_desc")));//power_desc
				params.add(Common.getFormatStr(request.getParameter("zd_hyd_desc")));//hyd_desc
				params.add(Common.getFormatStr(request.getParameter("zd_vision_desc")));//vision_desc
				params.add(Common.getFormatStr(request.getParameter("zd_detail")));//detail
				params.add(Common.getFormatStr(request.getParameter("zd_source")));//source
				params.add(Common.getFormatStr(request.getParameter("zd_checkbook")));//checkbook
				params.add(Common.getFormatStr(request.getParameter("zd_logistics")));//logistics
				params.add(Common.getFormatStr(request.getParameter("zd_price")));//price
				params.add(Common.getFormatStr(request.getParameter("zd_category_id")));//category_id
				params.add(Common.getFormatStr(request.getParameter("zd_brand_id")));//brand_id
				params.add(Common.getFormatStr(request.getParameter("img1")));//brand_id
				for(int i=1;i<32;i++){
					params.add(Common.getFormatStr(request.getParameter("img"+i)));
				}
				params.add(uuid);
				for(int i=0;i<params.size();i++){
					psmt.setObject(i+1,params.get(i));
				}
				psmt.execute();
			}
			connection.commit();
			rs = "ok";
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			usedPool.freeConnection(connection);
		}	
	}
	out.print(rs);
%>