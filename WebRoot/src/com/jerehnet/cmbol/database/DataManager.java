package com.jerehnet.cmbol.database;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.jerehnet.util.Common;
import com.jerehnet.util.common.CommonString;

/**
 * 
 * 数据库数据操作
 * 
 * @author jereh
 * 
 */
public class DataManager {

	/**
	 * 数据插入、删除、修改,SQL直接执行模式
	 * 
	 * @param conn
	 * @param SQL
	 * @return int
	 */

	public static int dataOperation(Connection conn, String SQL) {
		int count = 0;
		Statement stmt = null;
		try {
			conn.setAutoCommit(true);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			count = stmt.executeUpdate(SQL);
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
				stmt = null;
			}
		}
		return count;
	}

	public static int dataOperation(PoolManager pool, String SQL) {
		int count = 0;
		Statement stmt = null;
		Connection conn = null;
		try {
			conn = pool.getConnection();  
			conn.setAutoCommit(true);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			count = stmt.executeUpdate(SQL);
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
				stmt = null;
			}
		}
		return count;
	}

	/**
	 * 根据sql语句返回数据集
	 * 
	 * @param conn
	 * @param sql
	 * @return ResultSet
	 * @throws SQLException
	 */
	public static ResultSet executeQuery(Connection conn, String sql) {
		ResultSet rs = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			stmt = null;
		}
		return rs;
	}

	/**
	 * 根据sql语句返回数据集
	 * 
	 * @param conn
	 * @param sql
	 * @return ResultSet
	 * @throws SQLException
	 */
	public static ResultSet executeQueryUsed(Connection conn, String sql) {
		ResultSet rs = null;
		PreparedStatement psmt = null;
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			psmt = null;
		}
		return rs;
	}

	/**
	 * 根据sql语句返回数据集
	 * 
	 * @param conn
	 * @param sql
	 * @return ResultSet
	 * @throws SQLException
	 */
	public static ResultSet executeQueryDB2(Connection conn, String sql) {
		ResultSet rs = null;
		Statement stmt = null;
		try {
			// stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
			// ResultSet.CONCUR_READ_ONLY);
			stmt = conn.createStatement();
			// stmt = conn.createStatement(
			// SQLServerResultSet.TYPE_SS_SERVER_CURSOR_FORWARD_ONLY,
			// ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			stmt = null;
		}
		return rs;
	}

	/**
	 * 返回一条数据集
	 * 
	 * @param conn
	 * @param tableName
	 * @param fieldN
	 * @param value
	 * @return
	 * @throws SQLException
	 */
	public static ResultSet getOneData(Connection conn, String tableName,
			String fieldN, String value) throws SQLException {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		try {

			String whereStr = "";
			if (fieldN != null) {
				String fieldName[] = fieldN.split(",");
				for (int i = 0; i < fieldName.length; i++) {
					whereStr += " and " + fieldName[i] + "=? ";
				}
			}
			if (!whereStr.equals("")) {
				whereStr = " where 1=1 " + whereStr;
			}
			if (!whereStr.equals("")) {
				sql.append("select * from " + tableName + whereStr);
				pstmt = conn.prepareStatement(sql.toString());
				String[] values = value.split(",");
				if (values != null) {
					for (int i = 0; i < values.length; i++) {
						pstmt.setString(i + 1, String.valueOf(values[i]));
					}
				}
				rs = pstmt.executeQuery();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			sql = null;
			pstmt = null;
		}
		return rs;
	}

	/**
	 * 根据传入的表名，需要现实的字段，条件，返回数据集合
	 * 
	 * @param pool
	 * @param tablename
	 * @param fieldname
	 * @param tj
	 * @return String[][]
	 */
	public static String[][] fetchFieldValue(PoolManager pool,
			String tablename, String fieldname, String tj) {
		String result[][] = null;
		StringBuffer strSQL = new StringBuffer();
		Connection conn = null;
		ResultSetMetaData rsmd = null;
		ResultSet rs = null;
		try {
			conn = pool.getConnection();
			if (tj.equals("")) {
				strSQL.append("select " + fieldname + " from " + tablename);
			} else {
				strSQL.append("select " + fieldname + " from " + tablename
						+ " where " + tj);
			}
			rs = DataManager.executeQuery(conn, strSQL.toString());
			if (rs != null && rs.next()) {
				rsmd = rs.getMetaData();
				rs.last(); 
				result = new String[rs.getRow()][rsmd.getColumnCount()];
				for (int i = 1; i <= result.length; i++) {
					rs.absolute(i);
					for (int k = 1; k <= rsmd.getColumnCount(); k++) {
						result[i - 1][k - 1] = rs.getString(k) != null ? rs
								.getString(k) : "";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
				rs = null;
			}

			strSQL = null;
			conn = null;
			rsmd = null;
			rs = null;

		}
		return result;
	}

	/**
	 * 根据传入的表名，需要现实的字段，条件，返回数据集合
	 * 
	 * @param pool
	 * @param tablename
	 * @param fieldname
	 * @param tj
	 * @return String[][]
	 */
	public static String[][] fetchFieldValueDB2(PoolManager pool,
			String tablename, String fieldname, String tj, int rows) {
		String result[][] = null;
		StringBuffer strSQL = new StringBuffer();
		String countSql = "";
		Connection conn = null;
		ResultSetMetaData rsmd = null;
		ResultSet rs = null;
		try {
			conn = pool.getConnection();
			if (tj.equals("")) {
				strSQL.append("select " + fieldname + " from " + tablename);
			} else {
				strSQL.append("select " + fieldname + " from " + tablename

				+ " where " + tj);
			}
			rs = DataManager.executeQueryDB2(conn, strSQL.toString());
			if (rs != null) {
				rsmd = rs.getMetaData();
				result = new String[rows][rsmd.getColumnCount()];
			}
			int i = 1;
			while (rs != null && rs.next() && i <= rows) {
				// rs.absolute(i);
				for (int k = 1; k <= rsmd.getColumnCount(); k++) {
					result[i - 1][k - 1] = rs.getString(k) != null ? rs
							.getString(k) : "";
				}
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
				rs = null;
			}

			strSQL = null;
			conn = null;
			rsmd = null;
			rs = null;

		}
		return result;
	}

	/**
	 * 从存贮过程中得到返回数组
	 * 
	 * @param pool
	 * @param strsql
	 * @return
	 */
	public static String[][] fetchFieldValueFromProcedure(PoolManager pool,
			String strsql) {
		String result[][] = null;
		Connection conn = null;
		ResultSetMetaData rsmd = null;
		ResultSet rs = null;
		List templist = new ArrayList();
		List tempsubList = null;
		int columncount = 0;
		try {
			conn = pool.getConnection();

			if (strsql == null) {
				strsql = "";
			}
			if (!strsql.equals("")) {
				rs = DataManager.executeProcedure(conn, strsql);
			}

			while (rs != null && rs.next()) {
				rsmd = rs.getMetaData();
				columncount = rsmd.getColumnCount();

				tempsubList = new ArrayList();
				for (int k = 1; k <= rsmd.getColumnCount(); k++) {
					tempsubList.add(rs.getString(k) != null ? rs.getString(k)
							: "");
				}
				templist.add(tempsubList);

				tempsubList = null;
			}

			// ===赋值给result,用于返回操作===
			if (templist.size() > 0)
				result = new String[templist.size()][columncount];

			for (int i = 0; i < templist.size(); i++) {
				for (int k = 0; k < ((ArrayList) templist.get(i)).size(); k++) {
					result[i][k] = (String) ((ArrayList) templist.get(i))
							.get(k);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
				rs = null;
			}

			conn = null;
			rsmd = null;
			rs = null;
			templist = null;
			tempsubList = null;
		}
		return result;
	}

	/**
	 * 根据表名，返回该表的所有字段
	 * 
	 * @param pool
	 * @param table
	 * @return
	 */
	public static String[] getAllFieldNames(PoolManager pool, String table) {
		DataManager datamanager = new DataManager();
		Connection conn = null;
		ResultSet rs = null;
		String[] result = null;
		StringBuffer tablestr = new StringBuffer("select * from " + table
				+ " where id=0");
		try {
			conn = pool.getConnection();
			rs = datamanager.executeQuery(conn, tablestr.toString());
			ResultSetMetaData rsmd = rs.getMetaData();
			result = new String[rsmd.getColumnCount()];
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
				result[i - 1] = rsmd.getColumnName(i);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			rs = null;
		}
		return result;
	}

	/**
	 * 根据页面的文本框名字来生成并执行INSERT，UPDATE事件
	 * 
	 * @param request
	 * @param pool
	 * @param mypy
	 *            表名
	 * @param sessionflag
	 *            1:普通会员,2:商贸网管理员
	 * @param subwebNo
	 *            如果为0,则表示不插入日志
	 * @return int
	 */
	public static int dataInsUpt(HttpServletRequest request, PoolManager pool,
			String mypy, int sessionflag, int subwebNo) {
		String url = request.getRequestURI();
		if (url.indexOf("webadmin") == -1 && filterKeyWords(request)) {
			return 0;
		}
		mypy = Common.decryptionByDES(mypy);
		int result = 0;
		java.util.Enumeration argNames = request.getParameterNames();
		String argName, preName, endName;
		String fieldNames = "id";
		String[] fieldV = null;
		while (argNames.hasMoreElements()) {
			argName = String.valueOf(argNames.nextElement());
			if (argName.length() < 3) {
				continue;
			}
			preName = argName.substring(0, 3);
			endName = argName.substring(3);
			if (preName.equalsIgnoreCase("zd_")) {
				if (endName.equals("id")) {
					continue;
				}
				fieldNames += "," + endName;
			}
		}
		String fieldNameArr[] = fieldNames.split(",");
		String[][] fieldValueArr = new String[fieldNameArr.length][];
		if (fieldValueArr != null) {
			for (int i = 0; i <= fieldValueArr.length - 1; i++) {
				fieldValueArr[i] = request.getParameterValues("zd_"
						+ fieldNameArr[i]);
			}
		}
		if (fieldValueArr != null) {
			for (int k = 0; fieldValueArr[0] != null
					&& k < fieldValueArr[0].length; k++) {
				fieldV = new String[fieldValueArr.length];
				for (int m = 0; m < fieldValueArr.length; m++) {
					if (fieldValueArr[m] != null && fieldValueArr[m][k] != null) {
						if (fieldValueArr[m][k] != null) {
							fieldValueArr[m][k] = fieldValueArr[m][k].trim();
						}
						// fieldV[m] = fieldValueArr[m][k];
						// ===增加过滤处理了==
						fieldV[m] = Common.keyWordsFilter(pool,
								fieldValueArr[m][k], 1);
					} else {
						fieldV[m] = null;
					}
				}
				if (fieldV[0].equals("0")) {
					result = DataManager.executeSQL(pool, 1, fieldV, mypy,
							fieldNames);
					// ===subwebNo等于0不做处理====
					if (subwebNo != 0) {
						//Common.saveLogs(pool, request, mypy, "0", "1",
						//		sessionflag, subwebNo);
					}
				} else {
					result = DataManager.executeSQL(pool, 2, fieldV, mypy,
							fieldNames);
					// ===subwebNo等于0不做处理
					if (subwebNo != 0) {
						//Common.saveLogs(pool, request, mypy, fieldV[0], "2",
						//		sessionflag, subwebNo);
					}
				}
			}
		}
		return result;
	}
	
	public static int dataInsUpt(HttpServletRequest request, PoolManager pool,
			String mypy, int sessionflag, int subwebNo,String prxStr) {
		String url = request.getRequestURI();
		if (url.indexOf("webadmin") == -1 && filterKeyWords(request)) {
			return 0;
		}
		mypy = Common.decryptionByDES(mypy);
		int result = 0;
		java.util.Enumeration argNames = request.getParameterNames();
		String argName, preName, endName;
		String fieldNames = "id";
		String[] fieldV = null;
		while (argNames.hasMoreElements()) {
			argName = String.valueOf(argNames.nextElement());
			if (argName.length() < 3) {
				continue;
			}
			preName = argName.substring(0, 3);
			endName = argName.substring(3);
			if (preName.equalsIgnoreCase(prxStr+"_")) {
				if (endName.equals("id")) {
					continue;
				}
				fieldNames += "," + endName;
			}
		}
		String fieldNameArr[] = fieldNames.split(",");
		String[][] fieldValueArr = new String[fieldNameArr.length][];
		if (fieldValueArr != null) {
			for (int i = 0; i <= fieldValueArr.length - 1; i++) {
				fieldValueArr[i] = request.getParameterValues(prxStr+"_"
						+ fieldNameArr[i]);
			}
		}
		if (fieldValueArr != null) {
			for (int k = 0; fieldValueArr[0] != null
					&& k < fieldValueArr[0].length; k++) {
				fieldV = new String[fieldValueArr.length];
				for (int m = 0; m < fieldValueArr.length; m++) {
					if (fieldValueArr[m] != null && fieldValueArr[m][k] != null) {
						if (fieldValueArr[m][k] != null) {
							fieldValueArr[m][k] = fieldValueArr[m][k].trim();
						}
						// fieldV[m] = fieldValueArr[m][k];
						// ===增加过滤处理了==
						fieldV[m] = Common.keyWordsFilter(pool,
								fieldValueArr[m][k], 1);
					} else {
						fieldV[m] = null;
					}
				}
				if (fieldV[0].equals("0")) {
					result = DataManager.executeSQL(pool, 1, fieldV, mypy,
							fieldNames);
					// ===subwebNo等于0不做处理====
					if (subwebNo != 0) {
						//Common.saveLogs(pool, request, mypy, "0", "1",
						//		sessionflag, subwebNo);
					}
				} else {
					result = DataManager.executeSQL(pool, 2, fieldV, mypy,
							fieldNames);
					// ===subwebNo等于0不做处理
					if (subwebNo != 0) {
						//Common.saveLogs(pool, request, mypy, fieldV[0], "2",
						//		sessionflag, subwebNo);
					}
				}
			}
		}
		return result;
	}

	/**
	 * 根据页面的文本框名字来生成并执行INSERT，UPDATE事件
	 * 
	 * @param request
	 * @param pool
	 * @param mypy
	 *            表名
	 * @param sessionflag
	 *            1:普通会员,2:商贸网管理员
	 * @param subwebNo
	 *            如果为0,则表示不插入日志
	 * @return int
	 */
	public static int change_dataInsUpt(HttpServletRequest request,
			PoolManager pool, String mypy, int sessionflag, int subwebNo) {
		if (filterKeyWords(request)) {
			return 0;
		}
		int result = 0;
		mypy = Common.decryptionByDES(mypy);
		java.util.Enumeration argNames = request.getParameterNames();
		String argName, preName, endName;
		String fieldNames = "id";
		String[] fieldV = null;
		while (argNames.hasMoreElements()) {
			argName = String.valueOf(argNames.nextElement());
			if (argName.length() < 3) {
				continue;
			}
			preName = argName.substring(0, 3);
			endName = argName.substring(3);
			if (preName.equalsIgnoreCase("zd_")) {
				if (endName.equals("id")) {
					continue;
				}
				fieldNames += "," + endName;
			}
		}
		String fieldNameArr[] = fieldNames.split(",");
		String[][] fieldValueArr = new String[fieldNameArr.length][];
		if (fieldValueArr != null) {
			for (int i = 0; i <= fieldValueArr.length - 1; i++) {
				fieldValueArr[i] = request.getParameterValues("zd_"
						+ fieldNameArr[i]);
			}
		}
		if (fieldValueArr != null) {
			for (int k = 0; fieldValueArr[0] != null
					&& k < fieldValueArr[0].length; k++) {
				fieldV = new String[fieldValueArr.length];
				for (int m = 0; m < fieldValueArr.length; m++) {
					if (fieldValueArr[m] != null && fieldValueArr[m][k] != null) {
						if (fieldValueArr[m][k] != null) {
							fieldValueArr[m][k] = fieldValueArr[m][k].trim();
							fieldV[m] = fieldValueArr[m][k];
						}
					} else {
						fieldV[m] = null;
					}
				}
				if (null != fieldV[0] && fieldV[0].equals("0")) {
					result = DataManager.executeSQL(pool, 1, fieldV, mypy,
							fieldNames);
					if (subwebNo != 0) {
						//Common.saveLogs(pool, request, mypy, "0", "1",
						//		sessionflag, subwebNo);
					}
				} else {
					result = DataManager.executeSQL(pool, 2, fieldV, mypy,
							fieldNames);
					if (subwebNo != 0) {
						//Common.saveLogs(pool, request, mypy, fieldV[0], "2",
						//		sessionflag, subwebNo);
					}
				}
			}
		}
		return result;
	}

	/**
	 * 辅助dataInsUpt，执行INSERT,UPDATE SQL语句
	 * 
	 * @param pool
	 * @param flag
	 *            1-insert // 2-update
	 * @param fieldValue
	 * @param tablename
	 * @param fieldNames
	 * @return int
	 */
	public static int executeSQL(PoolManager pool, int flag,
			String fieldValue[], String tablename, String fieldNames) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			conn = pool.getConnection();
			conn.setAutoCommit(false);
			switch (flag) {
			case 1: {
				sql = createSQL(tablename, "", 0, fieldNames);
				pstmt = conn.prepareStatement(sql,
						Statement.RETURN_GENERATED_KEYS);
				for (int i = 1; i < fieldValue.length; i++) {
					if (fieldValue[i] != null && fieldValue[i].equals("")) {
						fieldValue[i] = null;
					}
					pstmt.setString(i, fieldValue[i]);
				}
				break;
			}
			case 2: {
				sql = createSQL(tablename, fieldValue[0], 2, fieldNames);
				pstmt = conn.prepareStatement(sql,
						Statement.RETURN_GENERATED_KEYS);
				for (int i = 1; i < fieldValue.length; i++) {
					if (fieldValue[i] != null && fieldValue[i].equals("")) {
						fieldValue[i] = null;
					}
					pstmt.setString(i, fieldValue[i]);
				}
				break;
			}
			default: {
				break;
			}
			}
			result = pstmt.executeUpdate();
			if (result > 0) {
				ResultSet keyRs = pstmt.getGeneratedKeys();
				if (null != keyRs && keyRs.next()) {
					Long tempKey = keyRs.getLong(1);
					result = tempKey.intValue();
					keyRs.close();
				}
			}
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
				pstmt = null;
			}
		}
		return result;
	}

	/**
	 * 通过语句进行更新
	 * 
	 * @param pool
	 * @param sql
	 * @return
	 */
	public static int executeSQL(PoolManager pool, String sql) {
		int result = 0;
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = pool.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			if (stmt.executeUpdate(sql) > 0) {
				result = 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
				stmt = null;
			}
		}
		return result;
	}

	/**
	 * 根据传入的逗号分隔符字符串，分隔生成SQL语句
	 * 
	 * @param table
	 * @param id
	 * @param flag
	 * @param fieldNames
	 * @return
	 */
	public static String createSQL(String table, String id, int flag,
			String fieldNames) {
		String SQL = "";
		String[] fieldName = fieldNames.split(",");
		switch (flag) {
		case 0: {
			String nm = "";
			String va = "";
			for (int i = 1; i < fieldName.length; i++) {
				if (i == (fieldName.length - 1)) {
					va += "?";
					nm += fieldName[i];
				} else {
					va += "?,";
					nm += fieldName[i] + ",";
				}
			}
			SQL = " insert into " + table + "(" + nm + ") values(" + va + ")";
			break;
		}
		case 2: {
			SQL = " update " + table + " set ";
			for (int i = 1; i < fieldName.length; i++) {
				if (i == (fieldName.length - 1)) {
					SQL += fieldName[i] + "=?";
				} else {
					SQL += fieldName[i] + "=?,";
				}
			}
			SQL += " where id=" + id;
			break;
		}
		default:
			break;
		}
		return SQL;
	}

	/**
	 * 重载
	 * 
	 * @param pool
	 * @param table
	 * @param id
	 * @param flag
	 * @return
	 */
	public static String createSQL(PoolManager pool, String table, String id,
			int flag) {
		DataManager datamanager = new DataManager();
		Connection conn = null;
		StringBuffer str = new StringBuffer();
		StringBuffer tablestr = new StringBuffer("select * from " + table
				+ " where id=0");
		String fieldsname[] = null;
		ResultSetMetaData rsmd = null;
		try {
			conn = pool.getConnection();
			rsmd = datamanager.executeQuery(conn, tablestr.toString())
					.getMetaData();
			switch (flag) {
			case 0: {

				fieldsname = create_fields(pool, table, new String[] { "id" });
				str.append(" insert into " + table + "("
						+ Common.join(fieldsname, ",") + ") values(");
				for (int i = 2; i <= rsmd.getColumnCount(); i++) {
					if (i == rsmd.getColumnCount()) {
						str.append("?)");
					} else {
						str.append("?,");
					}
				}
				break;
			}
			case 2: {
				str.append(" update " + table + " set ");
				for (int i = 2; i <= rsmd.getColumnCount(); i++) {
					if (i == rsmd.getColumnCount()) {
						str.append(rsmd.getColumnName(i) + "=?");
					} else {
						str.append(rsmd.getColumnName(i) + "=?,");
					}
				}
				str.append(" where id=" + id);
				break;
			}
			default: {
				break;
			}
			}
			return str.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		} finally {
			pool.freeConnection(conn);
			if (conn != null)
				conn = null;
			datamanager = null;
			str = null;
			tablestr = null;
			fieldsname = null;
			rsmd = null;
		}
	}

	/**
	 * 通过字段生成局部字段通一修改、增加语句=============
	 * 
	 * @param table
	 * @param arr_str
	 * @param flag
	 *            0 :表示增加,2:表示修改
	 * @param fieldname
	 *            字段名称数组
	 * @return
	 */
	public static String jbcreate_sql(PoolManager pool, String table,
			String id, int flag, String fieldname[]) {
		DataManager datamanager = new DataManager();
		Connection conn = null;
		StringBuffer str = new StringBuffer();
		try {
			conn = pool.getConnection();
			switch (flag) {
			case 0: {
				str.append(" insert into " + table + " values(");
				for (int i = 0; i <= fieldname.length - 1; i++) {
					if (i == fieldname.length - 1) {
						str.append("?)");
					} else {
						str.append("?,");
					}
				}
				break;
			}
			case 2: {
				str.append(" update " + table + " set ");
				for (int i = 0; i <= fieldname.length - 1; i++) {
					if (i == fieldname.length - 1) {
						str.append(fieldname[i] + "=?");
					} else {
						str.append(fieldname[i] + "=?,");
					}
				}
				str.append(" where id=" + id);
				break;
			}
			default:
				break;
			}
			return str.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		} finally {
			pool.freeConnection(conn);
			datamanager = null;
			conn = null;
			str = null;
		}
	}

	/**
	 * 
	 * @param pool
	 * @param table
	 * @param id
	 * @param filter_fieldname
	 * @return
	 */
	public static String[] create_fields(PoolManager pool, String table,
			String filter_fieldname[]) {
		DataManager datamanager = new DataManager();
		Connection conn = null;
		StringBuffer str = new StringBuffer();
		StringBuffer tablestr = new StringBuffer("select * from " + table
				+ " where id=0");
		ResultSetMetaData rsmd = null;
		try {
			conn = pool.getConnection();
			rsmd = datamanager.executeQuery(conn, tablestr.toString())
					.getMetaData();
			for (int i = 2; i <= rsmd.getColumnCount(); i++) {
				if (!Common.check_sz(rsmd.getColumnName(i), filter_fieldname)) {
					if (str.length() == 0) {
						str.append(rsmd.getColumnName(i));
					} else {
						str.append("," + rsmd.getColumnName(i));
					}
				}
			}
			return str.toString().split(",");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			pool.freeConnection(conn);
			if (conn != null)
				conn = null;
			datamanager = null;
			str = null;
			tablestr = null;
			rsmd = null;
		}
	}

	/**
	 * 根据传入的request，获取id数组，然后删除id值对应的数据
	 * 
	 * @param request
	 * @param conn
	 * @param talbeName
	 * @param sessionflag
	 * @param subwebNo
	 * @return
	 */
	public static int deleteDatas(HttpServletRequest request, String tablename,
			int sessionflag, int subwebNo) {
		PoolManager pool = PoolManager.getInstance();
		int result = 0;
		String SQL = null;
		Connection conn = null;
		String[] id = null;
		try {
			conn = pool.getConnection();
			tablename = Common.decryptionByDES(tablename);
			// ==================
			id = request.getParameterValues("id");
			if (id != null && id.length > 0) {
				for (int i = 0; i < id.length; i++) {
					SQL = "delete from " + tablename + "  where  id=" + id[i];
					// ====保存日志====
					//Common.saveLogs(pool, request, tablename, id[i], "3",
					//		sessionflag, subwebNo);
					result += DataManager.dataOperation(conn, SQL);
				}
			}
		} catch (Exception e) {
		} finally {
			pool.freeConnection(conn);
			SQL = null;
			id = null;
		}
		return result;
	}

	/**
	 * 删除单条数据
	 * 
	 * @param request
	 * @param conn
	 * @param talbeName
	 * @return
	 */
	public static int deleteData(HttpServletRequest request, String tablename,
			String id, int sessionflag, int subwebNo) {
		PoolManager pool = PoolManager.getInstance();
		int result = 0;

		String sql = null;
		Connection conn = null;
		try {
			tablename = Common.decryptionByDES(tablename);
			sql = "delete from " + tablename + "  where  id='" + id + "'";
			conn = pool.getConnection();
			// ====保存日志====
			if (0 != subwebNo) {
				//Common.saveLogs(pool, request, tablename, id, "3", sessionflag,
				//		subwebNo);
			}
			result = DataManager.dataOperation(conn, sql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			sql = null;
			conn = null;
		}
		return result;
	}

	/**
	 * 根据传入的request，获取id数组，然后删除id值对应的数据
	 * 
	 * @param pool
	 * @param request
	 * @param tablename
	 * @param sessionflag
	 * @param subwebNo
	 * @return
	 */
	public static int deleteDatas(PoolManager pool, HttpServletRequest request,
			String tablename, int sessionflag, int subwebNo) {
		int result = 0;
		String SQL = null;
		Connection conn = null;
		String[] id = null;
		try {
			conn = pool.getConnection();
			tablename = Common.decryptionByDES(tablename);
			// ==================
			id = request.getParameterValues("id");
			if (id != null && id.length > 0) {
				for (int i = 0; i < id.length; i++) {
					SQL = "delete from " + tablename + "  where  id=" + id[i];

					// ====保存日志====
					//Common.saveLogs(pool, request, tablename, id[i], "3",
					//		sessionflag, subwebNo);
					result += DataManager.dataOperation(conn, SQL);

				}
			}
		} catch (Exception e) {
		} finally {
			pool.freeConnection(conn);
			SQL = null;

			id = null;

		}
		return result;
	}

	/**
	 * 删除单条数据
	 * 
	 * @param pool
	 * @param request
	 * @param tablename
	 * @param id
	 * @param sessionflag
	 * @param subwebNo
	 * @return
	 */
	public static int deleteData(PoolManager pool, HttpServletRequest request,
			String tablename, String id, int sessionflag, int subwebNo) {
		int result = 0;
		String sql = null;
		Connection conn = null;
		try {
			tablename = Common.decryptionByDES(tablename);
			sql = "delete from " + tablename + "  where  id='" + id + "'";
			conn = pool.getConnection();
			if (0 != subwebNo) {
				//Common.saveLogs(pool, request, tablename, id, "3", sessionflag,
				//		subwebNo);
			}
			result = DataManager.dataOperation(conn, sql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			sql = null;
			conn = null;
		}
		return result;
	}

	public boolean update_data(Connection conn, PreparedStatement p_stmt,
			int flag_pl) {
		PreparedStatement pstmt = null;
		boolean result = false;
		try {
			pstmt = p_stmt;
			conn.setAutoCommit(false);
			if (flag_pl == 1) {
				pstmt.executeBatch();
			} else {
				pstmt.executeUpdate();
			}
			conn.commit();
			result = true;
		} catch (Exception ex) {
			ex.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e) {
				e.printStackTrace();
			}
			result = false;
		}
		return result;
	}

	public static ResultSet executeProcedure(Connection conn, String sql) {
		ResultSet rs = null;
		CallableStatement callsta = null;
		try {
			callsta = conn.prepareCall(sql);
			// ===执行存贮过程===
			callsta.execute();
			rs = callsta.getResultSet();
			// =========
			// ResultSet rs = null;
			// Statement stmt = null;
			// try {
			// stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
			// ResultSet.CONCUR_READ_ONLY);
			// rs = stmt.executeQuery(sql);
			// } catch (SQLException e) {
			// e.printStackTrace();
			// }

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			callsta = null;
		}
		return rs;
	}

	/**
	 * 在线交流保存聊天记录
	 * 
	 * @param shopuser
	 *            //接受人
	 * @param shopFullName
	 *            //接受人全名
	 * @param fromuser
	 *            //发送人编号
	 * @param fromFullName
	 *            //发送人真实姓名
	 * @param msg
	 *            //消息
	 * @param ip
	 *            //发送IP
	 */
	public static void insertMessage(String toUser, String toUserFullName,
			String fromuser, String fromFullName, String msg, String ip,
			String sendFlag) {
		PreparedStatement prestmt = null;
		PoolManager pool = new PoolManager();
		Connection sqlConn = pool.getConnection();
		try {
			String sql = "";
			sql = "insert into part_talk_message(to_user, to_full_name, from_user, from_full_name,message, send_ip,send_flag) values(?,?,?,?,?,?,?)";
			prestmt = sqlConn.prepareStatement(sql);
			prestmt.setString(1, toUser);
			prestmt.setString(2, toUserFullName);
			prestmt.setString(3, fromuser);
			prestmt.setString(4, fromFullName);
			prestmt.setString(5, msg);
			prestmt.setString(6, ip);
			prestmt.setString(7, sendFlag);
			prestmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			pool.freeConnection(sqlConn);
			pool = null;
			try {
				prestmt.close();
			} catch (Exception e) {
			}
		}

	}

	public static String[][] fetchFieldOneValue(PoolManager pool,
			String tablename, String fieldname, String tj) {
		String result[][] = null;
		StringBuffer strSQL = new StringBuffer();
		Connection conn = pool.getConnection();
		DataManager dataManager = null;
		ResultSetMetaData rsmd = null;
		ResultSet rs = null;

		try {
			dataManager = new DataManager();
			if (tj.equals("")) {
				strSQL.append("select top 1 " + fieldname + " from "
						+ tablename);
			} else {
				strSQL.append("select top 1 " + fieldname + " from "
						+ tablename + " where " + tj);
			}
			rs = dataManager.executeQuery(conn, strSQL.toString());

			if (rs != null && rs.next()) {
				rsmd = rs.getMetaData();
				rs.last();
				result = new String[rs.getRow()][rsmd.getColumnCount()];
				for (int i = 1; i <= result.length; i++) {
					rs.absolute(i);
					for (int k = 1; k <= rsmd.getColumnCount(); k++) {
						result[i - 1][k - 1] = rs.getString(k) != null ? rs
								.getString(k) : "";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
				rs = null;
			}
		}
		return result;
	}

	/**
	 * 用于connection不自动提交,保证事务完整
	 * 
	 * @param request
	 * @param conn
	 *            传入的Connection可以自定义是否自动提交
	 * @param mypy
	 * @return
	 * @throws Exception
	 */
	public static int dataInsUpt(HashMap request, Connection conn, String mypy)
			throws Exception {
		int result = 0;
		java.util.Iterator argNames = request.keySet().iterator();
		String argName, preName, endName;
		String fieldNames = "id";
		while (argNames.hasNext()) {
			argName = String.valueOf(argNames.next());
			if (argName.length() < 3) {
				continue;
			}
			preName = argName.substring(0, 3);
			endName = argName.substring(3);
			if (preName.equalsIgnoreCase("zd_")) {
				if (endName.equals("id"))
					continue;
				fieldNames += "," + endName;
			}
		}
		// 根据页面得到数据库表的字段
		String fieldNameArr[] = fieldNames.split(",");
		String[][] fieldValueArr = new String[fieldNameArr.length][];
		// 根据表字段，得到表单相应的值
		if (fieldValueArr != null) {
			for (int i = 0; i <= fieldValueArr.length - 1; i++) {
				fieldValueArr[i] = (String[]) request.get("zd_"
						+ fieldNameArr[i]);
			}
		}
		if (fieldValueArr != null) {
			for (int k = 0; fieldValueArr[0] != null
					&& k < fieldValueArr[0].length; k++) {
				String[] fieldV = new String[fieldValueArr.length];
				for (int m = 0; m < fieldValueArr.length; m++) {
					if (fieldValueArr[m] != null && fieldValueArr[m][k] != null) {
						if (fieldValueArr[m][k] != null)
							fieldValueArr[m][k] = fieldValueArr[m][k].trim();
						fieldV[m] = fieldValueArr[m][k];
						// ===增加过滤处理了==
						// fieldV[m] = Common.keyWordsFilter(pool,
						// fieldValueArr[m][k], 1);

					} else
						fieldV[m] = null;
				}
				try {
					if (fieldV[0].equals("0")) {
						result = executeSQL(conn, 1, fieldV, mypy, fieldNames);
						// Common.saveLogs(pool, request, mypy, "0", "1");
					} else if (fieldV[0].equals("-1")) {
						// 忽略此条记录
						result = 1;
					} else {
						result = executeSQL(conn, 2, fieldV, mypy, fieldNames);
						// Common.saveLogs(pool, request, mypy, fieldV[0], "2");
					}
				} catch (Exception e) {
					e.printStackTrace();
					throw e;
				}
			}
		}
		return result;
	}

	/**
	 * 用于connection不自动提交,保证事务完整
	 * 
	 * @param conn
	 * @param flag
	 * @param fieldValue
	 * @param tablename
	 * @param fieldNames
	 * @return
	 * @throws Exception
	 */
	public static int executeSQL(Connection conn, int flag,
			String fieldValue[], String tablename, String fieldNames)
			throws Exception {
		int result = 0;
		PreparedStatement pstmt = null;
		try {
			switch (flag) {
			case 1: {
				pstmt = conn.prepareStatement(DataManager.createSQL(tablename,
						"", 0, fieldNames));
				for (int i = 1; i < fieldValue.length; i++) {
					if (fieldValue[i] != null && fieldValue[i].equals("")) {
						fieldValue[i] = null;
					}
					pstmt.setString(i, fieldValue[i]);
				}
				break;
			}
			case 2: {
				pstmt = conn.prepareStatement(DataManager.createSQL(tablename,
						fieldValue[0], 2, fieldNames));
				for (int i = 1; i < fieldValue.length; i++) {
					if (fieldValue[i] != null && fieldValue[i].equals("")) {
						fieldValue[i] = null;
					}
					pstmt.setString(i, fieldValue[i]);
				}
				break;
			}
			default:
				break;
			}
			if (pstmt.executeUpdate() > 0) {
				result = 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
			}
			pstmt = null;
		}
		return result;
	}

	/**
	 * 操作SQL，可以不自动提交
	 * 
	 * @param conn
	 * @param SQL
	 * @return
	 * @throws SQLException
	 */
	public static int dataOperationCustom(Connection conn, String SQL)
			throws SQLException {
		int count = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			count = stmt.executeUpdate(SQL);
		} catch (SQLException ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
				stmt = null;
			}
		}
		return count;
	}

	public static Boolean filterKeyWords(HttpServletRequest request) {
		Map userInfo = (HashMap) request.getSession().getAttribute("memberInfo");
		String mem_no = "";
		String add_ip = "";
		if (userInfo != null) {
			if (userInfo.get("mem_no") != null) {
				mem_no = (String) userInfo.get("mem_no");
			}
			if (userInfo.get("add_ip") != null)
				add_ip = (String) userInfo.get("add_ip");
			else {
				add_ip = request.getRemoteAddr();
			}
		}
		Boolean isFilter = Boolean.valueOf(false);
		PoolManager web21sun = new PoolManager();
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement preparedStatement = null;
		String realKeyWords = "";
		try {
			String filter_keywords = "";
			String sql = "";
			filter_keywords = CommonString.getFormatPara(request.getSession().getServletContext().getAttribute("filter_keywords"));
			String filter_keywords_feifaci = filter_keywords; //单独记录非法词
			if (!filter_keywords.equals("")) {
				//如果发布人不是A类会员，增加行业关键词
				if (!CommonString.getFormatPara(userInfo.get("mem_flag")).equals("1003")) {
					String filter_keywords_a = CommonString.getFormatPara(request.getSession().getServletContext().getAttribute("filter_keywords_a"));
					filter_keywords += "|" + filter_keywords_a;
				}
				filter_keywords = filter_keywords.replace("|", ")|(").replace("@@", "\\|");
				/* 此段代码用于查找关键词异常时的问题，仅调试使用
				String filePath = "c:\\kk.txt";
				File file = new File(filePath);
				if (!file.exists()) {
					file.createNewFile();
				}
				BufferedWriter bw = new BufferedWriter(new FileWriter(file));
				bw.write("(" + filter_keywords + ")");
				bw.close();
				*/
				Pattern filterKeywordsPatt = Pattern.compile("(" + filter_keywords + ")", Pattern.CASE_INSENSITIVE);
				Matcher filterKeywordsMat = null;
				
				//判断ip是否被封
				filterKeywordsMat = filterKeywordsPatt.matcher(add_ip);
				if (filterKeywordsMat.find()) {
					realKeyWords = filterKeywordsMat.group().trim();
					isFilter = true;
				}
				
				//如果没封ip，判断是否包含关键词
				if (!isFilter) {
					String keywords = "";
					Iterator iterator = request.getParameterMap().entrySet().iterator();
					
					while (iterator.hasNext()) {
						Map.Entry entry = (Map.Entry)iterator.next();
						if (CommonString.getFormatPara(entry.getKey()).equals("zx_mem_name") || CommonString.getFormatPara(entry.getKey()).equals("zx_company")) {
							continue;
						}
						if (entry.getValue() == null) {
							continue;
						}
						if ((entry.getValue() instanceof String[])) {
							keywords = ((String[]) entry.getValue())[0];
						}
						if ((entry.getValue() instanceof String)) {
							keywords = entry.getValue().toString();
						}
						keywords = keywords.replaceAll(" ", "");
						keywords = Common.getFormatStr(keywords);
						if (CommonString.getFormatPara(entry.getKey()).equals("zd_comp_intro")) { //当验证公司介绍时，只验证非法词
							filterKeywordsPatt = Pattern.compile("(" + filter_keywords_feifaci + ")", Pattern.CASE_INSENSITIVE);
						}
						filterKeywordsMat = filterKeywordsPatt.matcher(keywords);
						if (filterKeywordsMat.find()) { 
							realKeyWords = filterKeywordsMat.group().trim();
							request.getSession().setAttribute("_filter_keyword", realKeyWords) ;
							isFilter = true;
							break;
						}  
					}
				}
			}

			if (isFilter) {
				sql = " insert into comm_filter_records ( add_date , ip , mem_no , keywords ) ";
				sql = sql + " values ('"
						+ Common.getToday("yyyy-MM-dd HH:mm:ss") + "','"
						+ add_ip + "','" + mem_no + "','" + realKeyWords
						+ "') ";
				if (conn == null) {
					conn = web21sun.getConnection();
					conn.setAutoCommit(false);
				}
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.execute();
				// request.getSession().removeAttribute("memberInfo");
			}
			if (preparedStatement != null) {
				preparedStatement.close();
			}
			
			if (conn != null) {
				conn.commit();
			}
		} catch (Exception e) {
			/* 此段代码用于查找关键词异常时的问题，仅调试使用
			try {
				String filePath = "c:\\ll.txt";
				File file = new File(filePath);
				if (!file.exists()) {
					file.createNewFile();
				}
				BufferedWriter bw = new BufferedWriter(new FileWriter(file));
				bw.write(e.getMessage());
				bw.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			*/
			//System.out.println(e.getMessage());
			
			//e.printStackTrace();
		} finally {
			web21sun.freeConnection(conn);
		}
		return isFilter;
	}

}