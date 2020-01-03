package com.jerehnet.cmbol.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.jerehnet.util.Common;

/**
 * @author jereh
 * 
 *         mysql通用分页方法
 */
public class Pagination {

	int first, next, prev, last;

	/**
	 * 记录偏移当前记录位置
	 */
	int offset;

	/**
	 * 记录总数
	 */
	int total;

	/**
	 * 记录每页显示记录数
	 */
	int countOfPage;

	/**
	 * 总页数
	 */
	int totalPages;

	/**
	 * 当前页数
	 */
	int currentPages;

	/**
	 * 分页显示要传递的参数
	 */
	String PageQuery;

	/**
	 * query 语句
	 */
	String query;

	/**
	 * FROM 以后的 query 部分
	 */
	String queryPart;

	/**
	 * 页面网址路径
	 */
	String urlPath;

	/**
	 * 当前页的数据结果
	 */
	ResultSet rs;

	String queryStr = "";

	String[] pages = null;

	DataManager dm;

	public Pagination() {
		dm = new DataManager();
		countOfPage = 10;
	}

	/**
	 * 根据所给的条件从表中读取相应的记录
	 * 
	 * @param query
	 * @param req
	 * @return
	 * @throws SQLException
	 *             flag 1:按照传统方式查询,2:按照id倒序查询,3:产品列表查询
	 */
	public ResultSet getQueryResult(String query, HttpServletRequest req,
			Connection conn, int flag) {
		String sql = "", tempSQL = "";
		String tablename = "";
		String whereStr = "";
		String fields = "*";
		try {

			queryStr = Common.getFormatStr(req.getQueryString());
			// System.out.println("-------------:" + queryStr);
			if (queryStr.length() > 0) {
				if (queryStr.substring(0, 1).equals("?")) {
					queryStr = queryStr.substring(1);
				}
			}
			// System.out.println("-------------1111:" + queryStr);
			String offsetStr;
			int begin;
			// 截取FROM以后的 query 语句
			query = query.toLowerCase();
			begin = query.indexOf(" from ");
			queryPart = query.substring(begin, query.length()).trim();

			// 获取当前偏移记录位置
			offsetStr =Common.getFormatInt(req.getParameter("offset"));
			if (offsetStr == null) {
				offset = 0;
			} else {
				try {
					offset = Integer.parseInt(offsetStr);
				} catch (Exception e) {
					offset = 0;
				}
			}

			// 获取当前页面url路径
			urlPath = req.getRequestURI();

			// 计算总的记录条数

			// String sql = "select count(id) as total " + this.queryPart;
			sql = "select count(id) as total " + this.queryPart;

			if (sql.indexOf("order") != -1) {
				sql = sql.substring(0, sql.indexOf("order"));
			}
			// Common.println("SQL count(*):" + sql);
			rs = dm.executeQuery(conn, sql);
			if (rs.next()) {
				total = rs.getInt(1);
			}

			if (offset < 0) {
				offset = 0;
			}

			if (offset > total) {
				offset = total;
			}

			// pages[pages.length]

			// 设置当前页数和总页数
			totalPages = (int) Math
					.ceil((double) this.total / this.countOfPage);
			currentPages = (int) Math.floor((double) offset / this.countOfPage
					+ 1);

			//
			pages = new String[totalPages];
			for (int i = 0; i < totalPages; i++) {
				pages[i] = String.valueOf(i * countOfPage);
			}

			// 根据条件判断，取出所需记录
			if (total > 0) {

				fields = query.substring(query.indexOf("select") + 6, query
						.indexOf("from"));
				if (query.indexOf("where") != -1) {
					tablename = query.substring(query.indexOf("from") + 4,
							query.indexOf("where"));
					whereStr = query.substring(query.indexOf("where") + 5);
				} else if (query.indexOf("order") != -1) {
					tablename = query.substring(query.indexOf("from") + 4,
							query.indexOf("order"));
					whereStr = " 1=1 ";
				}
				if (flag == 1) {
					tempSQL = "select top #pagecount #fields from	 #tablename where id not in"
							+ "( select top #2pagecount id from #tablename where #where ) "
							+ " and #where";
				} else if (flag == 2) {
					tempSQL = "select top #pagecount #fields from  #tablename where (id <(select isnull(min(id),999999999) from (select top #2pagecount id  from #tablename where #where order by id desc )T)) and #where order by id desc";

				} else if (flag == 3) {
					tempSQL = "select top #pagecount #fields from  #tablename where (order_no <(select isnull(min(order_no),999999999999999999) from (select top #2pagecount order_no  from #tablename where #where order by order_no desc )T)) and #where order by order_no desc";
				}

				sql = tempSQL.replace("#fields", fields);
				sql = sql.replace("#tablename", tablename);

				sql = sql.replace("#where", whereStr);
				sql = sql.replace("#pagecount", String.valueOf(countOfPage));
				sql = sql.replace("#2pagecount", String.valueOf(countOfPage
						* (currentPages - 1)));
				// Common.println("分页SQL:" + sql);
				rs = dm.executeQuery(conn, sql);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			tempSQL = null;
			sql = null;
			tablename = null;
			whereStr = null;
			fields = null;
		}
		return rs;
	}

	/**
	 * 根据所给的条件从表中读取相应的记录
	 * 
	 * @param query
	 * @param req
	 * @return
	 * @throws SQLException
	 */
	public ResultSet getQueryResult(String query, HttpServletRequest req,Connection conn) {
		try {
			//Common.println(query.toString()) ;
			queryStr = Common.getFormatStr(req.getQueryString());
			if (queryStr.length() > 0) {
				if (queryStr.substring(0, 1).equals("?")) {
					queryStr = queryStr.substring(1);
				}
			}
			String offsetStr;
			int begin;
			// 截取FROM以后的 query 语句
			query = query.toLowerCase();
			begin = query.indexOf(" from ");

			queryPart = query.substring(begin, query.length()).trim();
			// System.out.println("from后的语句为:"+queryPart);
			// 获取当前偏移记录位置
			offsetStr =Common.getFormatInt(req.getParameter("offset"));
			if (offsetStr == null) {
				offset = 0;
			} else {
				try {
					offset = Integer.parseInt(offsetStr);
				} catch (Exception e) {
					offset = 0;
				}
			}

			// 获取当前页面url路径
			urlPath = req.getRequestURI();

			// 计算总的记录条数
			String sql = "select count(*) as total " + this.queryPart;
			if (sql.indexOf(" order ") != -1) // 为了使用Order表
			{
				sql = sql.substring(0, sql.indexOf(" order "));// 因为我们的表名叫order,所有注意在order前一定不能出现order
			}
			// Common.println("SQL count(*):" + sql);
			// System.out.println("记录数语句为:"+sql);
			rs = dm.executeQuery(conn, sql);
			if (rs.next()) {
				total = rs.getInt(1);
			}

			if (offset < 0) {
				offset = 0;
			}

			if (offset > total) {
				offset = total;
			}

			// pages[pages.length]

			// 设置当前页数和总页数
			totalPages = (int) Math
					.ceil((double) this.total / this.countOfPage);
			currentPages = (int) Math.floor((double) offset / this.countOfPage
					+ 1);

			//
			pages = new String[totalPages];
			for (int i = 0; i < totalPages; i++) {
				pages[i] = String.valueOf(i * countOfPage);
			}

			// 根据条件判断，取出所需记录
			if (total > 0) {
				String tablename = "";
				String whereStr = "";
				String fields = "*";
				fields = query.substring(query.indexOf("select") + 6, query
						.indexOf("from"));
				if (query.indexOf("where") != -1) {
					tablename = query.substring(query.indexOf("from") + 4,
							query.indexOf("where"));
					whereStr = query.substring(query.indexOf("where") + 5);
				} else if (query.indexOf("order") != -1) {
					tablename = query.substring(query.indexOf("from") + 4,
							query.indexOf("order"));
					whereStr = " 1=1 ";
				}
				String tempSQL = "select top #pagecount #fields from #tablename where id not in"
						+ "( select top #2pagecount id from #tablename where #where ) "
						+ " and #where";
				sql = tempSQL.replace("#fields", fields);
				sql = sql.replace("#tablename", tablename);

				sql = sql.replace("#where", whereStr);
				sql = sql.replace("#pagecount", String.valueOf(countOfPage));
				sql = sql.replace("#2pagecount", String.valueOf(countOfPage
						* (currentPages - 1)));
				// Common.println("SQL:" + sql);

				// System.out.println("最后的语句为:"+sql);
				rs = dm.executeQuery(conn, sql);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	/**
	 * 显示首页、下页、上页、尾页
	 * 
	 * @return
	 */
	public String paginationPrint() {
		if (queryStr.indexOf("offset=") != -1 && queryStr.indexOf("&") != -1) {
			queryStr = queryStr.substring(queryStr.indexOf("&") + 1);
		}
		if (queryStr.indexOf("offset=") != -1 && queryStr.indexOf("&") > -1) {
			queryStr = "";
		}
		if (!queryStr.equals("")) {
			queryStr = "&" + queryStr;
		}

		StringBuffer str = new StringBuffer();

		first = 0;
		next = offset + countOfPage;
		if (next > total) {
			next = total;
		}
		prev = offset - countOfPage;
		if (prev < 0) {
			prev = 0;
		}
		last = (this.totalPages - 1) * countOfPage;
		// 第1页/共28页
		str.append("总计" + total + "条" + " 第" + getCurrenPages() + "页/共"
				+ getTotalPages() + "页 <!--");
		str.append(countOfPage + "条/页--> ");

		if (offset >= countOfPage) {
			str.append(" <A href=\"?offset=" + first + "" + queryStr
					+ "\">首页</A> ");
		} else {
			str.append(" 首页 ");
		}
		if (prev >= 0) {
			str.append(" <A href=\"?offset=" + prev + "" + queryStr
					+ "\">上一页</A> ");
		} else {
			str.append(" 上一页 ");
		}
		if (next < total) {
			str.append(" <A href=\"?offset=" + next + "" + queryStr
					+ "\">下一页</A> ");
		} else {
			str.append(" 下一页 ");
		}
		if (totalPages != 0 && currentPages < totalPages) {
			str.append(" <A href=\"?offset=" + last + "" + queryStr
					+ "\">末页</A>");
		} else {
			str.append(" 末页 ");
		}
		return str.toString();
	}

	// 分页
	public String pagesPrint(int showpages) {

		first = 0;
		next = offset + countOfPage;
		if (next > total)
			next = total;
		prev = offset - countOfPage;
		if (prev < 0)
			prev = 0;
		last = (this.totalPages - 1) * countOfPage;

		if (queryStr.indexOf("offset=") != -1) {
			String temp = queryStr.substring(queryStr.indexOf("offset="));
			if (temp.indexOf("&") != -1) {
				temp = temp.substring(0, temp.indexOf("&") + 1);
			} else {

			}
			queryStr = queryStr.replace(temp, "").replace("&" + temp, "")
					.replace("?" + temp, "");
		}
		if (queryStr.indexOf("&") != 0) {
			queryStr = "&" + queryStr;
		}
		String str = "";
		str += " 共" + this.getTotal() + "条 ";
		str += " " + this.getCurrenPages() + "/" + this.getTotalPages() + "页 ";
		str += "第<a href=\"?offset=0" + queryStr
				+ "\" ><<</a> <a href=\"?offset=" + this.getPrev() + ""
				+ queryStr + "\" ><</a> ";

		// showpages = 6;
		String pages[] = this.getPages();
		int nowp = this.getCurrenPages();
		nowp = nowp - nowp % (showpages + 1);
		for (int i = nowp - 1; i < (nowp + showpages) && i < pages.length; i++) {
			if (i < 0)
				i = 0;
			if (this.getCurrenPages() == (i + 1)) {
				str += "<b>" + (i + 1) + "</b>";
			} else {
				str += " <a href=\"?offset=" + pages[i] + "" + queryStr
						+ "\" >" + (i + 1) + "</a> ";
			}
		}
		str += " <a href=\"?offset=" + this.getNext() + "" + queryStr
				+ "\" >></a> ";
		str += " <a href=\"?offset=" + this.getLast() + "" + queryStr
				+ "\" >>></a>页 ";
		/*
		 * str +=
		 * " <select name=\"offset\" onChange=\"window.location.href='?offset='+this.value+'"
		 * + queryStr + "'\">"; for (int i = 0; i < pages.length; i++) { str +=
		 * "<option value='" + pages[i] + "' " + (((i + 1) ==
		 * this.getCurrenPages()) ? "selected" : "") + ">" + (i + 1) +
		 * "</option>"; }
		 * 
		 * str += " </select>页";
		 */
		return str;
	}

	/**
	 * 总记录
	 * 
	 * @return
	 */
	public int getTotal() {
		return total;
	}

	/**
	 * 总页数
	 * 
	 * @return
	 */
	public int getTotalPages() {
		return totalPages;
	}

	/**
	 * 当前所在页数
	 * 
	 * @return
	 */
	public int getCurrenPages() {
		return currentPages;
	}

	/**
	 * 设置当前每页显示的记录条数
	 * 
	 * @param count
	 */
	public void setCountOfPage(int count) {
		this.countOfPage = count;
	}

	public int getCountOfPage() {
		return countOfPage;
	}

	public String[] getPages() {
		return pages;
	}

	public int getFirst() {
		return first;
	}

	public int getNext() {
		return next;
	}

	public int getLast() {
		return last;
	}

	public int getPrev() {
		return prev;
	}

}