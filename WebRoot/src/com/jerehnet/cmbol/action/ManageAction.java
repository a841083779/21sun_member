package com.jerehnet.cmbol.action;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.SimpleDateFormat;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import com.jerehnet.cmbol.database.DataManager;
import com.jerehnet.cmbol.database.PoolManager;
import com.jerehnet.util.Common;

public class ManageAction {
	/**
	 * 管理员登陆后台
	 * 
	 * @param pool
	 * @param request
	 * @return
	 */
	public int adminLogon(PoolManager pool, HttpServletRequest request) {
		int isLogon = 0;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		HashMap userInfo = new HashMap();
		String usern = Common.getFormatStr(request.getParameter("usern"));
		if (usern.equals("")) {
			usern = Common.getFormatStr(request.getParameter("zd_usern"));
		}
		String passw = Common.getFormatStr(request.getParameter("passw"));
		if (passw.equals("")) {
			passw = Common.getFormatStr(request.getParameter("zd_passw"));
		}

		Connection conn = null;
		String sql = null;
		try {
			if (!usern.equals("") && !passw.equals("")) {
				conn = pool.getConnection();
				rs = DataManager.getOneData(conn, "admin_user", "usern,passw",
						usern + "," + passw);
				if (rs != null && rs.next()) {
					if (rs.getString("usern").equalsIgnoreCase(usern)
							&& rs.getString("passw").equalsIgnoreCase(passw)) {
						if (rs.getString("state").equals("1")) {
							rsmd = rs.getMetaData();
							for (int i = 1; i <= rsmd.getColumnCount(); i++) {
								userInfo.put(rsmd.getColumnName(i), rs
										.getString(rsmd.getColumnName(i)));
							}
							request.getSession().setAttribute("adminInfo",
									userInfo);
							isLogon = 1;
							sql = "update admin_user set last_ip='"
									+ Common.getRemoteAddr(request, 1)
									+ "',last_date='"
									+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)
									+ "' where usern='" + usern + "'";
							DataManager.dataOperation(conn, sql);
							// ====日志管理==
							Common.saveLogs(pool, request, "", "", "4", 2, 6);
						} else {
							isLogon = -1;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			rs = null;
			rsmd = null;
			userInfo = null;
			usern = null;
			passw = null;
			sql = null;
		}
		return isLogon;
	}

	/**
	 * 会员、代理商登陆
	 * 
	 * @param pool
	 * @param request
	 * @return
	 */
	public int memberAdminLogon(PoolManager pool, HttpServletRequest request) {
		int isLogon = 0;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		HashMap userInfo = new HashMap();
		String uid = Common.getFormatStr(request.getParameter("uid"));
		String password = Common.getFormatStr(request.getParameter("password"));
		String membertype = Common.getFormatStr(request
				.getParameter("membertype"));
		Connection conn = null;
		String sql = null;
		try {
			if (!uid.equals("") && !password.equals("")) {
				conn = pool.getConnection();
				rs = DataManager.getOneData(conn, "cmbol_member",
						"uid,password", uid + "," + password);
				if (rs != null && rs.next()) {
					if (rs.getString("uid").equalsIgnoreCase(uid)
							&& rs.getString("password").equalsIgnoreCase(
									password)) {
						if (rs.getString("active").equals("1")
								&& membertype.equals(rs.getString("type"))) {
							rsmd = rs.getMetaData();
							for (int i = 1; i <= rsmd.getColumnCount(); i++) {
								userInfo.put(rsmd.getColumnName(i), rs
										.getString(rsmd.getColumnName(i)));
							}
							request.getSession().setAttribute("memberInfo",
									userInfo);

							sql = "update cmbol_member set lastlogip='"
									+ Common.getRemoteAddr(request, 1)
									+ "',logdate='"
									+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)
									+ "',logcount=isnull(logcount,0)+1 where uid='"
									+ uid + "'";
							DataManager.dataOperation(conn, sql);
							// ====日志管理==
							Common.saveLogs(pool, request, "", "", "4", 1, 6);
							isLogon = 1;
						} else {
							isLogon = -1;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			rs = null;
			rsmd = null;
			userInfo = null;
			uid = null;
			sql = null;
		}
		return isLogon;
	}

	/**
	 * 会员、代理商登陆---开通状态
	 * 
	 * @param pool
	 * @param request
	 * @return
	 */
	public int memberAdminLogon2(PoolManager pool, HttpServletRequest request,
			String uid, String password, String membertype) {
		int isLogon = 0;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		HashMap userInfo = new HashMap();
		Connection conn = null;
		String sql = null;
		try {
			if (!uid.equals("") && !password.equals("")) {
				conn = pool.getConnection();
				rs = DataManager.getOneData(conn, "cmbol_member",
						"uid,password", uid + "," + password);
				if (rs != null && rs.next()) {
					if (rs.getString("uid").equalsIgnoreCase(uid)
							&& rs.getString("password").equalsIgnoreCase(
									password)) {
						if (rs.getString("active").equals("1")
								&& membertype.equals(rs.getString("type"))) {
							rsmd = rs.getMetaData();
							for (int i = 1; i <= rsmd.getColumnCount(); i++) {
								userInfo.put(rsmd.getColumnName(i), rs
										.getString(rsmd.getColumnName(i)));
							}
							/* 判断企业会员是否为免费或者过期 */
							boolean is_free = false;
							if ("2".equals(membertype)) {
								String crexpdate = Common.getFormatStr(userInfo
										.get("crexpdate"));
								String level = Common.getFormatStr(userInfo
										.get("level"));
								SimpleDateFormat sdf = new SimpleDateFormat();
								String now_date = Common.getToday("yyyy-MM-dd",
										0);
								if (!"".equals(crexpdate)) {
									if (now_date.compareTo(crexpdate) > 0) {
										is_free = true;
									}
								}
								if ("".equals(level)) {
									is_free = true;
								}
							}
						
							userInfo.put("is_free", new Boolean(is_free));
							/* 判断结束 */
							request.getSession().setAttribute("memberInfo",
									userInfo);
							sql = "update cmbol_member set lastlogip='"
									+ request.getRemoteAddr()
									+ "',logdate='"
									+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)
									+ "',logcount=isnull(logcount,0)+1 where uid='"
									+ uid + "'";
							DataManager.dataOperation(conn, sql);
							// ====日志管理==
							Common.saveLogs(pool, request, "", "", "4", 1, 6);
							isLogon = 1;
						} else if (!rs.getString("active").equals("1")) {
							isLogon = -2;
						} else {
							isLogon = -1;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			rs = null;
			rsmd = null;
			userInfo = null;
			uid = null;
			sql = null;
		}
		return isLogon;
	}

	/**
	 * 管理员登陆后台
	 * 
	 * @param pool
	 * @param request
	 * @return
	 */
	public int adminLogon2(PoolManager pool, HttpServletRequest request,
			String usern, String passw) {
		int isLogon = 0;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		HashMap userInfo = new HashMap();
		Connection conn = pool.getConnection();
		try {
			rs = DataManager.getOneData(conn, "parts_admin_user",
					"usern,passw", usern + "," + passw);
			if (rs != null && rs.next()) {
				if (rs.getString("usern").equalsIgnoreCase(usern)
						&& rs.getString("passw").equalsIgnoreCase(passw)) {
					if (rs.getString("state").equals("1")) {
						rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							userInfo.put(rsmd.getColumnName(i), rs
									.getString(rsmd.getColumnName(i)));
						}
						request.getSession()
								.setAttribute("adminInfo", userInfo);
						isLogon = 1;
						String sql = "update parts_admin_user set last_ip='"
								+ request.getRemoteAddr()
								+ "',last_date='"
								+ Common.getToday("yyyy-MM-dd HH:mm:ss")
								+ "',loginnums=isnull(loginnums,0)+1 where usern='"
								+ usern + "'";
						DataManager.dataOperation(conn, sql);
						// ====日志管理==
						// Common.saveLogs(pool, request, "", "", "", 4);
						//Common.saveLogs(pool, request, "", "", "4");
					} else {
						isLogon = -1;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
		}
		return isLogon;
	}

	/**
	 * 厂家，代理商登陆 flag-1厂家 2代理商
	 * 
	 * @param pool
	 * @param request
	 * @return
	 */
	public int agentAdminLogon(PoolManager pool, HttpServletRequest request) {
		int isLogon = 0;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		HashMap userInfo = new HashMap();
		String usern = Common.getFormatStr(request.getParameter("usern"));
		String passw = Common.getFormatStr(request.getParameter("passw"));
		String flag = Common.getFormatStr(request.getParameter("flag"));
		Connection conn = pool.getConnection();
		try {
			rs = DataManager.getOneData(conn, "parts_stores",
					"usern,passw,is_show,flag", usern + "," + passw + ",1"
							+ "," + flag);
			if (rs != null && rs.next()) {
				Common.println("usern:" + rs.getString("usern") + "passw:"
						+ rs.getString("passw"));
				if (rs.getString("usern").equalsIgnoreCase(usern)
						&& rs.getString("passw").equalsIgnoreCase(passw)) {
					if (rs.getString("is_show").equals("1")) {
						rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							userInfo.put(rsmd.getColumnName(i), rs
									.getString(rsmd.getColumnName(i)));
						}
						if (flag.equals("1")) {// 厂家
							request.getSession().setAttribute("facAdminInfo",
									userInfo);
						} else if (flag.equals("2")) {// 代理商
							request.getSession().setAttribute("agentAdminInfo",
									userInfo);
						}
						isLogon = 1;
						String sql = "update parts_stores set last_login_ip='"
								+ request.getRemoteAddr()
								+ "',last_login_date='"
								+ Common.getToday("yyyy-MM-dd HH:mm:ss")
								+ "',loginnums=isnull(loginnums,0)+1 where usern='"
								+ usern + "'";
						DataManager.dataOperation(conn, sql);
					} else {
						isLogon = -1;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
		}
		return isLogon;
	}

	/**
	 * 根据session里的用户信息，返回相应的字段值
	 * 
	 * @param request
	 * @param fieldName
	 * @return
	 */

	public static String getAdminInfo(HttpServletRequest request,
			String fieldName, String sessName) {
		String fieldValue = "";
		HashMap userInfo = null;
		try {
			userInfo = (HashMap) request.getSession().getAttribute(sessName);
			if (userInfo != null) {
				fieldValue = (String) userInfo.get(fieldName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			userInfo = null;
		}
		return fieldValue;
	}

	public int regAdminLogon(PoolManager pool, HttpServletRequest request,
			HashMap map) {
		int isLogon = 0;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		HashMap userInfo = new HashMap();
		String uid = Common.getFormatStr((String) map.get("uid"));
		String password = Common.getFormatStr((String) map.get("password"));
		Connection conn = null;
		String sql = null;
		try {
			if (!uid.equals("") && !password.equals("")) {
				conn = pool.getConnection();
				rs = DataManager.getOneData(conn, "cmbol_member",
						"uid,password", uid + "," + password);
				if (rs != null && rs.next()) {
					if (rs.getString("uid").equalsIgnoreCase(uid)
							&& rs.getString("password").equalsIgnoreCase(
									password)) {
						if (rs.getString("active").equals("1")) {
							rsmd = rs.getMetaData();
							for (int i = 1; i <= rsmd.getColumnCount(); i++) {
								userInfo.put(rsmd.getColumnName(i), rs
										.getString(rsmd.getColumnName(i)));
							}
							request.getSession().setAttribute("memberInfo",
									userInfo);
							sql = "update cmbol_member set lastlogip='"
									+ Common.getRemoteAddr(request, 1)
									+ "',logdate='"
									+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)
									+ "',logcount=isnull(logcount,0)+1 where uid='"
									+ uid + "'";
							DataManager.dataOperation(conn, sql);
							// ====日志管理==
							//Common.saveLogs(pool, request, "", "", "4", 1, 6);
							isLogon = 1;
						} else {
							isLogon = -1;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			rs = null;
			rsmd = null;
			userInfo = null;
			uid = null;
			sql = null;
		}
		return isLogon;
	}
}