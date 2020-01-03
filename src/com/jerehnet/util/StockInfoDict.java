package com.jerehnet.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;

import com.jerehnet.cmbol.database.DataManager;
import com.jerehnet.cmbol.database.PoolManager;

public class StockInfoDict {
	
	static HashMap stockInfoCatalogMap = new HashMap();
	static HashMap stockInfoMap = new HashMap();
	/**
	 * 根据编码得到类别名称
	 * @param code
	 * @return
	 */
	public static String getCatalogName(Object code){
		if(code == null){
			return "";
		}
		if(stockInfoCatalogMap.get(code)!=null){
			return (String)stockInfoCatalogMap.get(code);
		}
		PoolManager upool = new PoolManager();
		
		Connection con = null;
		ResultSet rs = null;
		String sql = "select code,name from stock_dict where catalog='stock_info'";
		try{
		con = upool.getConnection();
		rs = DataManager.executeQuery(con,sql);
		while(rs!=null&&rs.next()){
			stockInfoCatalogMap.put(rs.getString("code"),rs.getString("name"));
		}

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
			rs.close();
			upool.freeConnection(con);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	
		return (String)stockInfoCatalogMap.get(code);
	}
	
	public static String getStockName(Object code){
		if(code == null){
			return "";
		}
		if(stockInfoMap.get(code)!=null){
			return (String)stockInfoMap.get(code);
		}
		PoolManager upool = new PoolManager();
		
		Connection con = null;
		ResultSet rs = null;
		String sql = "select code,name from stock_pool";
		try{
		con = upool.getConnection();
		rs = DataManager.executeQuery(con,sql);
		while(rs!=null&&rs.next()){
			stockInfoMap.put(rs.getString("code"),rs.getString("name"));
		}

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
			rs.close();
			upool.freeConnection(con);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	
		return (String)stockInfoMap.get(code);
	}
}
