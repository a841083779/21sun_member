<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="com.jerehnet.util.DesEncrypt"%>
<%@page import="com.jerehnet.util.Common"%>
<%@page import="com.jerehnet.cmbol.database.DataManager"%>
<%@page import="com.jerehnet.cmbol.database.PoolManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="com.jerehnet.util.common.UTF8PostMethod"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.*"%>
<%@page import="java.lang.reflect.Array"%>
<%
	String flag = Common.getFormatStr(request.getParameter("flag")); //
	DataManager dataManager = new DataManager();
	PoolManager poolManager = new PoolManager();
	DBHelper dbHelper = DBHelper.getInstance() ;
	Connection conn = null;
	ResultSet rs = null;
	String sel_sql = null;
	String upt_sql = null ;
	ResultSetMetaData rsmd = null;
	Map memberInfo = new HashMap() ;
	try {
		if ("checkValue".equals(flag)) {
			String field = Common.getFormatStr(request.getParameter("field"));
			String value = Common.getFormatStr(request.getParameter("value"));
			if (!"".equals(field) && !"".equals(value)) {
				sel_sql = " select count(*) from member_info where mem_no=?";
				conn = poolManager.getConnection();
				rs = DataManager.getOneData(conn, "member_info", "mem_no", value);
				if (null != rs && rs.next()) {
					out.println("ok");
				} else {
					out.println("fail");
				}
			}
		}

		// 检测用户信息是否存在
		if ("canBinding".equals(flag)) {
			String mem_no = Common.getFormatStr(request.getParameter("mem_no")); // 用户名
			String passw = Common.getFormatStr(request.getParameter("passw")); // 密码
			if (!"".equals(mem_no) && !"".equals(passw)) {
				passw = DesEncrypt.MD5(passw);
				conn = poolManager.getConnection();
				rs = DataManager.getOneData(conn, "member_info", "mem_no,passw", mem_no + "," + passw);
				if (null != rs && rs.next()) {
					rsmd = rs.getMetaData();
					String mid="-1";
					for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					   memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
					   if(rsmd.getColumnName(i).equalsIgnoreCase("id")){
					   		mid = rs.getString(rsmd.getColumnName(i));
					   }
					}
					session.setAttribute("memberInfo",memberInfo);
					
					  int id = rs.getInt("id") ;
					  String sina_id = Common.getFormatStr(request.getParameter("sina_id")).trim() ;
					  String qq_id = Common.getFormatStr(request.getParameter("qq_id")).trim() ;
					  if(id>0 && (!"".equals(sina_id)||!"".equals(qq_id))){
						    if(!"".equals(sina_id)){
						    	upt_sql = " update member_info set sina_id='"+sina_id+"' where id="+id  ;
						    }else
						    if(!"".equals(qq_id)){
						    	upt_sql = " update member_info set qq_id='"+qq_id+"' where id="+id ;
						    }
						     DataManager.executeQuery(conn,upt_sql) ;
							 out.println("ok");
					  }
				} else {
					out.println("fail");
				}
			}
		}
		if("checkInputInfo".equals(flag)){
		
			String info = Common.getFormatStr(request.getParameter("info")) ;
			out.print("info="+info+"</br>");
			Map filterMap = (Map) application.getAttribute("filterkeywords_a");
            if(filterMap!=null){
			    filterMap.put("磨簧机", "1");
				filterMap.put("卷簧机", "1");
				Iterator it = filterMap.keySet().iterator();  
                while (it.hasNext()){  
                String key;  
                key=(String)it.next();
				out.print("key="+key+"</br>");
				    if(info.indexOf(key)>=0&&!key.equals("")){
				     out.println("so") ;
					  break ;
				    }
				}

			}
	
			
		}
		//资料完善 - 会员信息 - 主营产品+详细地址
		if("updMem".equals(flag)){
			conn = poolManager.getConnection();
			String mem_no = Common.getFormatStr(request.getParameter("mem_no")); 
			String passw = Common.getFormatStr(request.getParameter("passw"));
			String zd_main_product = Common.getFormatStr(request.getParameter("zd_main_product")); 
			String zd_comp_address = Common.getFormatStr(request.getParameter("zd_comp_address")); 
			String zd_is_shop = Common.getFormatStr(request.getParameter("zd_is_shop")); 
			DataManager.dataOperation(conn," update member_info set main_product = '"+zd_main_product+"',comp_address = '"+zd_comp_address+"',is_shop = '"+zd_is_shop+"' where mem_no = '"+mem_no+"' and passw = '"+passw+"' ") ;
			((HashMap)session.getAttribute("memberInfo")).put("main_product",zd_main_product);
			((HashMap)session.getAttribute("memberInfo")).put("comp_address",zd_comp_address);
			((HashMap)session.getAttribute("memberInfo")).put("is_shop",zd_is_shop);
			if(zd_is_shop.equals("1")){//开通
				out.println("1");
			}else if(zd_is_shop.equals("1")){//不开通
				out.println("0");
			}
		}
		//取消手机
		if("——getRand_bak".equals(flag)){ 
			String tel = Common.getFormatStr(request.getParameter("tel")) ; // 用户输入的电话号码 
			String ip = Common.getIp(request,1) ;
			String sql = "select count(*) total from service_sms_record" ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and referer like 'www.member.21-sun.com%'") ;
			whereStr.append(" and convert(varchar,send_date,23)='"+CommonDate.getToday("yyyy-MM-dd")+"'") ;
			if(!"".equals(tel)){
				whereStr.append(" and phone='"+tel+"'") ;
			}
			// 同一天发送 
			String whereStr2 = " where convert(varchar,send_date,23)='"+CommonDate.getToday("yyyy-MM-dd")+"' and referer like 'www.member.21-sun.com%'" ;
			// 同一ip 发送
			String whereStr3 = " where convert(varchar,send_date,23)='"+CommonDate.getToday("yyyy-MM-dd")+"' and referer like '%"+ip+"' and referer like 'www.member.21-sun.com%'" ;
			conn = dbHelper.getConnection("web21log") ;
			int total = Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sql+whereStr.toString(),conn).get("total"))) ;
			int total_all = Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sql+whereStr2,conn).get("total"))) ;
			int total_ip = Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sql+whereStr3,conn).get("total"))) ;
			//  每个手机号一天发送数限制：3条 
			// 一天最大发送数限制：2000条 
			// 同一IP一天发送数限制：5条
			if(total<3 && total_all<2000 && total_ip<5){ 
			String rand = Common.getRandom(4) ;
			session.setAttribute("loginRand",rand) ;
			String str = "" ;
			Cookie[] cookies = request.getCookies() ;
			StringBuffer url = new StringBuffer("http://service.21-sun.com/http/utils/sms.jsp") ;
			Map params = new HashMap() ;
			params.put("phone",tel) ;
			params.put("content","中国工程机械商贸网提醒您:您注册的手机号码的验证码为:"+rand+",请在注册页面填写验证码完成注册") ;
			if(!"".equals(tel)){ 
				HttpClient httpClient = new HttpClient();
				String result = "fail";
				PostMethod postMethod = new UTF8PostMethod(url.toString());
				String cookieStr = "";
				if (null != cookies) {
					for (Cookie cookie : cookies) {
						cookieStr += cookie.getName() + "=" + cookie.getValue() + ";";
					}
				}
				postMethod.addRequestHeader("Referer","www.member.21-sun.com"+ip);
				if (null != params && params.size() > 0) {
					Object value = null;
					for (Object key : params.keySet()) {
						value = params.get(key);
						if (null == value) { 
							continue;
						}
						if (value instanceof String[]) {
							value = ((String[]) value)[0];
						} else if (value instanceof String) {
							value = (String) value;
						}
						postMethod.addParameter(new NameValuePair(Common.getFormatStr(key), Common.getFormatStr(value)));
					}
				}
				if (!"".equals(cookieStr)) {
					postMethod.setRequestHeader("cookie", cookieStr);

				}
				postMethod.addParameter("source","195001");
				int statusCode = httpClient.executeMethod(postMethod);
				if (statusCode == HttpStatus.SC_MOVED_PERMANENTLY || statusCode == HttpStatus.SC_MOVED_TEMPORARILY) {
					result = "ok";
				}
			}
			out.println("1") ;
		}else if(total>=3){
			out.println("3") ; 
			return ;
		}else if(total_all>=2000){
			out.println("2000") ; 
			return ;
		}else if(total_ip>=5){
			out.println("5") ;
			return ;
		}
			return ;
		}
		//推荐到供求首页
		if("recToIndex".equals(flag)){
			conn = dbHelper.getConnection("web21sun_market") ;
			String rid = CommonString.getFormatPara(request.getParameter("rid")) ;
			String value = CommonString.getFormatPara(request.getParameter("value")) ;
			upt_sql = "update sell_buy_market set rec_index=? where id=?" ;
			int result = dbHelper.execute(upt_sql,new Object[]{value,rid},conn) ;
			out.print(result) ;
			return ;
		}
		// 更新三个月前的订单
		if("updateAgoOrder".equals(flag)){
			Object[] objs = null;
			conn = dbHelper.getConnection("web21sun_market") ;
			String orderId = CommonString.getFormatPara(request.getParameter("orderId")) ; // 订单 id
			// 
			sel_sql = " select top 1 * from sell_buy_market_ago where id=?" ;
			Map orderMap = null ;
			if(!"".equals(orderId) && orderId.indexOf(",")<0){
				orderMap = dbHelper.getMap(sel_sql,new Object[]{orderId},conn) ;
				String fields = "" ;
				String tokens = "" ;
				if(null!=orderMap){
			        Set<String> key = orderMap.keySet();
			        objs = new Object[key.size()-3] ;
			        int i = 0 ;
			        label1: for (Iterator it = key.iterator(); it.hasNext();) {
			            String s = (String) it.next();
			            if(s.equals("id")){
			            	continue label1 ;
			            }
			            if(s.equals("uuid")){
			            	continue label1 ;
			            }
			            if(s.equals("channel_uuid")){
			            	continue label1 ;
			            }
			            fields += s+"," ;
			            tokens += "?," ;
			            if(s.equals("add_date") || s.equals("pub_date")){
			            	objs[i] =CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
			            }else{
			            objs[i] = CommonString.getFormatPara(orderMap.get(s)) ;
			            }
			            i++ ;
			            
			        }
			        if(fields.length()>0){
			        	fields = fields.substring(0,fields.length()-1) ;
			        	tokens = tokens.substring(0,tokens.length()-1) ;
			        }
			        String ins_sql = "insert into sell_buy_market("+fields+") values("+tokens+")" ;
			        upt_sql = "update sell_buy_market_ago set is_show=0 where id=?" ;
			        conn.setAutoCommit(false);
			        dbHelper.execute(ins_sql,objs,conn) ;  // 更新到新表
			        dbHelper.execute(upt_sql,new Object[]{orderId},conn) ; // 原订单设为不显示 
			        conn.commit();
			        out.println("ok") ;
			        return ;
				}
			}else{  // 批量更新
				String orderIds = CommonString.getFormatPara(request.getParameter("orderId")) ; // 订单 id
				String[] _orderIds = orderIds.split(",") ;
				if(_orderIds.length>0){
					for(int i=0;i<_orderIds.length;i++){
						orderMap = dbHelper.getMap(sel_sql,new Object[]{_orderIds[i]},conn) ;
						String fields = "" ;
						String tokens = "" ;
						if(null!=orderMap){
					        Set<String> key = orderMap.keySet();
					        objs = new Object[key.size()-3] ;
					        int j = 0 ;
					        label1: for (Iterator it = key.iterator(); it.hasNext();) {
					            String s = (String) it.next();
					            if(s.equals("id")){
					            	continue label1 ;
					            }
					            if(s.equals("uuid")){
					            	continue label1 ;
					            }
					            if(s.equals("channel_uuid")){
					            	continue label1 ;
					            }
					            fields += s+"," ;
					            tokens += "?," ;
					            if(s.equals("add_date") || s.equals("pub_date")){
					            	objs[j] =CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
					            }else{
					            objs[j] = CommonString.getFormatPara(orderMap.get(s)) ;
					            }
					            j++ ;
					        }
					        if(fields.length()>0){
					        	fields = fields.substring(0,fields.length()-1) ;
					        	tokens = tokens.substring(0,tokens.length()-1) ;
					        }
					        String ins_sql = "insert into sell_buy_market("+fields+") values("+tokens+")" ;
					        upt_sql = "update sell_buy_market_ago set is_show=0 where id=?" ;
					        System.out.println(_orderIds[i]) ;
					        conn.setAutoCommit(false);
					        dbHelper.execute(ins_sql,objs,conn) ;  // 更新到新表
					        dbHelper.execute(upt_sql,new Object[]{_orderIds[i]},conn) ; // 原订单设为不显示 
					        conn.commit();
						}
					}
					  out.println("ok") ;
				      return ;
				}
			}
		}
		//推荐到供求首页
		if("updateSellData".equals(flag)){
			conn = dbHelper.getConnection("web21sun_market") ;
			String ids = CommonString.getFormatPara(request.getParameter("ids")) ;
			if(!"".equals(ids) && ids.indexOf(",")<0){ // 单条更新
				//更新索引文件
				String luceneUrl = "http://sowa.21-sun.com/writer/market.21-sun.com/sell_create_one.jsp?id="+ids;
				HttpMethod method = new GetMethod(luceneUrl); 
				HttpClient client = new HttpClient();
				int result = client.executeMethod(method);
			}else{ // 批量更新
				String[] idsArr = ids.split(",") ;
				if(idsArr.length>0){
					for(int i=0;i<idsArr.length;i++){
						//更新索引文件
						String luceneUrl = "http://sowa.21-sun.com/writer/market.21-sun.com/sell_create_one.jsp?id="+idsArr[i];
						HttpMethod method = new GetMethod(luceneUrl); 
						HttpClient client = new HttpClient();
						int result = client.executeMethod(method);
					}
				}
			}
			out.println("1");
			return ;
		}
	} catch (Exception e) {  
		if(!conn.getAutoCommit()){
			conn.rollback();
		}
		e.printStackTrace();
	} finally {
		poolManager.freeConnection(conn);
	}
%>

