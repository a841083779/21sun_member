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

public class BiddingToHtml {

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
		websitePath = Constants.MAINSITEPATH;

		cfg = new Configuration();
		try {
			cfg.setDirectoryForTemplateLoading(new File(websitePath));
			cfg.setDefaultEncoding("utf-8");
		} catch (Exception e) {
			Common.println(e);
		}
	}

	/**
	 * 最新招标
	 * 
	 * @param request
	 * @param catalogNo
	 */
	public void indexNewBidding(HttpServletRequest request, PoolManager pool,
			String lines) {
		String templateName = "/bidding/tempate/new_bidding.htm";// 模版页面名称
		String createFilename = Constants.MAINSITEPATH
				+ "/bidding/include/index_new_bidding.htm";// 页面文件名称

		this.init(request);
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		List infoLists = null;
		String infosArr[][] = null;

		// 最新招标
		infoLists = new ArrayList();
		infosArr = DataManager.fetchFieldValue(pool, "bidding_bulletin", "top "
				+ lines + "  title,pub_date,id ", "is_show=1 order by id desc");
		String pubDate = "";
		for (int i = 0; infosArr != null && i < infosArr.length; i++) {
			info = new Info();
			info.setId(Common.getFormatStr(infosArr[i][2]));
			info.setTitle(Common.getFormatStr(infosArr[i][0]));
			pubDate = Common.getFormatStr(infosArr[i][1]);
			if (pubDate.length() > 10) {
				pubDate = pubDate.substring(0, 10);
			}
			info.setPubDate(pubDate);
			infoLists.add(info);
			info = null;
		}
		root.put("infoLists", infoLists);
		infoLists = null;

		try {
			t = this.getCfg().getTemplate(templateName);
			t.setEncoding("utf-8");
			// System.out.println(createFilename);
			// System.out.println(websitePath);
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
	 * 招标信息分类
	 * 
	 * @param request
	 * @param catalogNo
	 */
	public void indexBiddingSort(HttpServletRequest request, PoolManager pool,
			String lines, String sort) {
		String templateName = "/bidding/tempate/index_bidding.htm";// 模版页面名称
		String createFilename = Constants.MAINSITEPATH
				+ "/bidding/include/index_bidding_sort_" + sort + ".htm";// 页面文件名称

		this.init(request);
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		List infoLists = null;
		String infosArr[][] = null;

		// 招标信息分类
		infoLists = new ArrayList();
		infosArr = DataManager.fetchFieldValue(pool, "bidding_bulletin", "top "
				+ lines + "  title,pub_date,id,catalog_num",
				"is_show=1 and catalog_num='" + sort + "' order by id desc");
		String pubDate = "";
		for (int i = 0; infosArr != null && i < infosArr.length; i++) {
			info = new Info();
			info.setId(Common.getFormatStr(infosArr[i][2]));
			info.setTitle(Common.getFormatStr(infosArr[i][0]));
			pubDate = Common.getFormatStr(infosArr[i][1]);

			if (pubDate.length() > 10) {
				pubDate = pubDate.substring(0, 10);
			}
			info.setPubDate(pubDate);
			info.setCatalogNo(Common.getFormatStr(infosArr[i][3]));
			infoLists.add(info);
			info = null;
		}
		root.put("infoLists", infoLists);
		infoLists = null;

		try {
			t = this.getCfg().getTemplate(templateName);
			t.setEncoding("utf-8");
			// System.out.println(createFilename);
			// System.out.println(websitePath);
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
	 * 招标资讯
	 * 
	 * @param request
	 * @param catalogNo
	 */
	public void indexBiddingNews(HttpServletRequest request, PoolManager pool,
			String lines) {
		String templateName = "/bidding/tempate/index_bidding_news.htm";// 模版页面名称
		String createFilename = Constants.MAINSITEPATH
				+ "/bidding/include/index_bidding_news.htm";// 页面文件名称

		this.init(request);
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		List infoLists = null;
		String infosArr[][] = null;

		// 最新招标资讯
		infoLists = new ArrayList();
		infosArr = DataManager.fetchFieldValue(pool, "article_other", "top "
				+ lines + "  title,pub_date,id",
				"is_pub=1 and catalog_no='700202' order by id desc");
		String pubDate = "";
		for (int i = 0; infosArr != null && i < infosArr.length; i++) {
			info = new Info();
			info.setId(Common.getFormatStr(infosArr[i][2]));
			info.setTitle(Common.getFormatStr(infosArr[i][0]));
			pubDate = Common.getFormatStr(infosArr[i][1]);
			if (pubDate.length() > 10) {
				pubDate = pubDate.substring(0, 10);
			}
			info.setPubDate(pubDate);
			infoLists.add(info);
			info = null;
		}
		root.put("infoLists", infoLists);
		infoLists = null;

		try {
			t = this.getCfg().getTemplate(templateName);
			t.setEncoding("utf-8");
			// System.out.println(createFilename);
			// System.out.println(websitePath);
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
