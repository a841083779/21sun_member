package com.jerehnet.cmbol.database;

import java.sql.Connection;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * 
 * @author jereh
 * 
 * 连接池的连接释放操作
 * 
 */

public class PoolManager {

	DataSource ds = null;

	private static PoolManager instance;

	/**
	 * 返回惟一实例,如果是第一次调用些方法,则创建该实例
	 * 
	 * @return
	 */
	public static synchronized PoolManager getInstance() {
		if (instance == null) {
			instance = new PoolManager();
		}
		return instance;
	}

	/**
	 * 构造函数实现类的初始化 功能：注册驱动程序，根据最小连接数生成连接
	 * 
	 */
	public PoolManager() {
		try {
			InitialContext ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/web21sun107");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 新建构造函数1:表示调用121上的SQLserver主数据库,2:表示调用115上的db2数据库,3:租赁库,4:调二手库(web21sun_used),5:调论坛,6:数据分析
	// 7:配件,8:供求,9:配套网,10:会员商务室,11:杰配网,12:新配件网
	public PoolManager(int flag) {
		try {
			InitialContext ctx = new InitialContext();
			if (flag == 1) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun107");
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			if (flag == 2) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun115");
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			if (flag == 3) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_rent");
				} catch (Exception e) {
					// TODO: handle exception
				}
				
			} else if (flag == 4) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_used");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else if (flag == 5) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_market");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else if (flag == 6) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web_21sun_report");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else if (flag == 7) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_part");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else if (flag == 8) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_bbs");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else if (flag == 9) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_fittings");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else if (flag == 10) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_zhidao");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else if (flag == 11) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_partshop");
				} catch (Exception e) {
					// TODO: handle exception
				}
			} else if (flag == 12) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21part2013");
				} catch (Exception e) {
					// TODO: handle exception
				}
			}else if (flag == 13) {
				try {
					ds = (DataSource) ctx.lookup("java:comp/env/web21sun_market_ago");
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 从连接池获得一个可用连接,如没有空闲的连接且当前连接数小于最大连接数 限制,则创建新的连接
	 * 
	 * @return Connection 返回一个连接
	 */
	public Connection getConnection() {
		Connection conn = null;
		try {
			conn = ds.getConnection();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return conn;
	}

	/**
	 * 将不再使用的连接返回给连接池
	 * 
	 * @param conn
	 */
	public void freeConnection(Connection conn) {
		try {
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}