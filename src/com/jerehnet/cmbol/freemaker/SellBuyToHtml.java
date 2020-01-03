package com.jerehnet.cmbol.freemaker;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jerehnet.cmbol.action.Info;
import com.jerehnet.cmbol.database.DataManager;
import com.jerehnet.cmbol.database.PoolManager;
import com.jerehnet.util.Common;
import com.jerehnet.util.Constants;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class SellBuyToHtml {

	private static String websitePath = "";
	private Configuration cfg;

	public Configuration getCfg() {
		return cfg;
	}

	/**
	 * 初始化对象，设置模板路径
	 * 
	 */
	public void init(HttpServletRequest request) {
		websitePath = Constants.SELL_BUY_PATH;

		cfg = new Configuration();
		try {
			cfg.setDirectoryForTemplateLoading(new File(websitePath));
			cfg.setDefaultEncoding("utf-8");
		} catch (Exception e) {
			Common.println(e);
		}
	}

	/**
	 * 供求首页子页面生成：供求表
	 * 
	 * @param productFlag
	 *            ：产品类别
	 * @param businessFlag
	 *            ：交易目的类别
	 * @param indexFlag
	 *            ：首页显示位置类型
	 * @author wanggq
	 */
	public void subIndex(HttpServletRequest request, PoolManager pool,
			String productFlag, String businessFlag, String indexFlag,
			int rows, String tName, String cName) {
		String templateName = tName;// 模版页面名称
		String createFilename = Constants.SELL_BUY_PATH + cName;// 页面文件名称

		this.init(request);
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		try {
			// 取列表信息
			ArrayList listInfo = new ArrayList();
			String tj = " 1=1 and datediff(day,pub_date,getDate())>valid_day and is_show = 1 ";
			if (productFlag != null && !productFlag.equals("")) {
				tj += " and product_flag like '%" + productFlag + "%' ";
			}
			if (businessFlag != null && !businessFlag.equals("")) {
				tj += " and business_flag = '" + businessFlag + "' ";
			}
			if (indexFlag != null && !indexFlag.equals("")) {
				tj += " and posi = '" + indexFlag + "' ";
			}

			String tempInfo[][] = DataManager.fetchFieldValue(pool,
					"sell_buy_market", " top " + rows
							+ " business_flag,title,pub_date,id", tj
							+ " order by pub_date desc ");
			for (int i = 0; tempInfo != null && i < tempInfo.length; i++) {
				info = new Info();
				info.setCatalogNo(Common.getFormatStr(tempInfo[i][0]));
				info.setTitle(Common.getFormatStr(tempInfo[i][1]));
				info
						.setPubDate(Common.getFormatStr(tempInfo[i][2])
								.length() >= 10 ? Common.getFormatStr(
								tempInfo[i][2]).substring(0, 10) : Common
								.getFormatStr(tempInfo[i][2]));
				info.setId(Common.getFormatStr(tempInfo[i][3]));
				listInfo.add(info);
				info = null;
			}
			root.put("listInfo", listInfo);
			root.put("businessFlag", businessFlag);
			tempInfo = null;
			listInfo = null;

			t = this.getCfg().getTemplate(templateName);
			t.setEncoding("utf-8");
			out = new OutputStreamWriter(new FileOutputStream(createFilename),
					"utf-8");
			t.process(root, out);
		} catch (Exception e) {
			Common.println(e);
		} finally {
			try {
				out.close();
			} catch (Exception e) {
			}
			out = null;
			t = null;
			templateName = null;
			createFilename = null;
			root = null;
		}
	}

	/**
	 * 供求首页子页面生成：配件表
	 * 
	 * @param productFlag
	 *            ：配件类别
	 * @author wanggq
	 */
	public void subPartIndex(HttpServletRequest request, PoolManager pool,
			String productFlag, int rows, String tName, String cName) {
		String templateName = tName;// 模版页面名称
		String createFilename = Constants.SELL_BUY_PATH + cName;// 页面文件名称

		this.init(request);
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		try {
			// 取列表信息
			ArrayList listInfo = new ArrayList();
			String tj = " 1=1 and price_buy is not null ";
			if (productFlag != null && !productFlag.equals("")) {
				tj += " and parent_catalognum = '" + productFlag + "' ";
			}

			String tempInfo[][] = DataManager.fetchFieldValue(pool,
					"parts_products", " top " + rows
							+ " parts_name,price_buy,id,is_vip", tj
							+ " order by add_date desc ");
			for (int i = 0; tempInfo != null && i < tempInfo.length; i++) {
				info = new Info();
				info.setTitle(Common.getFormatStr(tempInfo[i][0]));
				info.setPrice(Common.getFormatStr(tempInfo[i][1]));
				info.setId(Common.getFormatStr(tempInfo[i][2]));
				info.setUrl("http://21part.com");
				if (Common.getFormatStr(tempInfo[i][3]).equals("1")) {
					info.setUrl("http://21part.com/shop/"
							+ Common.getFormatStr(tempInfo[i][2])
							+ "_detail_detail.shtm");
				} else {
					info.setUrl("http://21part.com/viphouse/ytxiongdi_"
							+ Common.getFormatStr(tempInfo[i][2])
							+ "_products.shtm");
				}
				listInfo.add(info);
				info = null;
			}
			root.put("listInfo", listInfo);
			tempInfo = null;
			listInfo = null;

			t = this.getCfg().getTemplate(templateName);
			t.setEncoding("utf-8");
			out = new OutputStreamWriter(new FileOutputStream(createFilename),
					"utf-8");
			t.process(root, out);
		} catch (Exception e) {
			Common.println(e);
		} finally {
			try {
				out.close();
			} catch (Exception e) {
			}
			out = null;
			t = null;
			templateName = null;
			createFilename = null;
			root = null;
		}
	}

	/**
	 * 供求首页子页面生成：资讯中心表
	 * 
	 * @param productFlag
	 *            ：配件类别
	 * @author wanggq
	 */
	public void subNewsIndex(HttpServletRequest request, PoolManager pool,
			String keyword, int rows, String tName, String cName) {
		String templateName = tName;// 模版页面名称
		String createFilename = Constants.SELL_BUY_PATH + cName;// 页面文件名称

		this.init(request);
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		try {
			// 取列表信息
			ArrayList listInfo = new ArrayList();
			String tj = " 1=1 and is_pub = 1 ";
			if (keyword != null && !keyword.equals("")) {
				tj += " and (title like '%" + keyword + "%' or content like '%"
						+ keyword + "%') ";
			}

			String tempInfo[][] = DataManager.fetchFieldValue(pool, "article",
					" top " + rows + " title,pub_date,html_filename ", tj
							+ " order by pub_date desc ");
			for (int i = 0; tempInfo != null && i < tempInfo.length; i++) {
				info = new Info();
				info.setTitle(Common.getFormatStr(tempInfo[i][0]));
				info
						.setPubDate(Common.getFormatStr(tempInfo[i][1])
								.length() >= 10 ? Common.getFormatStr(
								tempInfo[i][1]).substring(0, 10) : Common
								.getFormatStr(tempInfo[i][1]));
				info.setUrl("http://news.21-sun.com");
				if (Common.getFormatStr(tempInfo[i][2]).length() >= 6) {
					info.setUrl("http://news.21-sun.com/detail/"
							+ Common.getFormatStr(tempInfo[i][2]).substring(0,
									4)
							+ "/"
							+ Common.getFormatStr(tempInfo[i][2]).substring(4,
									6) + "/"
							+ Common.getFormatStr(tempInfo[i][2]));
				}
				listInfo.add(info);
				info = null;
			}
			root.put("listInfo", listInfo);
			tempInfo = null;
			listInfo = null;

			t = this.getCfg().getTemplate(templateName);
			t.setEncoding("utf-8");
			out = new OutputStreamWriter(new FileOutputStream(createFilename),
					"utf-8");
			t.process(root, out);
		} catch (Exception e) {
			Common.println(e);
		} finally {
			try {
				out.close();
			} catch (Exception e) {
			}
			out = null;
			t = null;
			templateName = null;
			createFilename = null;
			root = null;
		}
	}

	/**
	 * 供求首面信息列表右侧生成
	 * 
	 * @param request
	 * @param catalogNo
	 */
	public void indexListRight(HttpServletRequest request, PoolManager pool,
			String productFlag, String businessFlag) {
		String templateName = "";// 模版页面名称
		String createFilename = "";// 页面文件名称

		this.init(request);
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		List infoLists = null;
		String topInfosArr[][] = null;

		// 置顶的10条
		infoLists = new ArrayList();
		topInfosArr = DataManager.fetchFieldValue(pool, "sell_buy_market",
				"title,mem_no,business_flag,add_date",
				"posi=1 and is_show=1 order by id desc");
		root.put("topInfos", infoLists);
		infoLists = null;

		// 供应信息
		infoLists = new ArrayList();
		topInfosArr = DataManager.fetchFieldValue(pool, "sell_buy_market",
				"title,mem_no,business_flag,add_date",
				"posi=2 and business_flag=10 and is_show=1 order by id desc");
		root.put("sellInfos", infoLists);
		infoLists = null;

		// 求购信息
		infoLists = new ArrayList();
		topInfosArr = DataManager.fetchFieldValue(pool, "sell_buy_market",
				"title,mem_no,business_flag,add_date",
				"posi=3 and business_flag=11 and is_show=1 order by id desc");
		root.put("buyInfos", infoLists);
		infoLists = null;

		// 杰配网相关信息
		infoLists = new ArrayList();
		topInfosArr = DataManager.fetchFieldValue(pool, "", "", "");
		root.put("part21Infos", infoLists);
		infoLists = null;

		try {
			t = this.getCfg().getTemplate(templateName);
			t.setEncoding("utf-8");
			out = new OutputStreamWriter(new FileOutputStream(createFilename),
					"utf-8");
			t.process(root, out);
		} catch (Exception e) {
			Common.println(e);
		} finally {
			try {
				out.close();
			} catch (Exception e) {
			}
			out = null;
			t = null;
			templateName = null;
			createFilename = null;
			root = null;
		}
	}
}
