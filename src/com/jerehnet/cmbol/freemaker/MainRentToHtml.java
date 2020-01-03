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

public class MainRentToHtml {
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
		websitePath = request.getRealPath("/");

		System.out.println("websitePath====" + websitePath);
		cfg = new Configuration();
		try {
			cfg.setDirectoryForTemplateLoading(new File(websitePath));
			cfg.setDefaultEncoding("utf-8");
		} catch (Exception e) {
			Common.println(e);
		}
	}

	/**
	 * 首面信息列表生成
	 * 
	 * @param request
	 * @param pool
	 * @param catalogNo
	 * @param sortNum
	 */
	public void indexList(HttpServletRequest request, PoolManager pool,
			String catalogNo, String sortNum) {
		this.init(request);
		PoolManager pool1 = null;
		String templateName = "";// 模版页面名称
		String createFilename = "";// 页面文件名称
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		List infoLists = null;
		String infosArr[][] = null;
		String infosArr1[][] = null;

		// 置顶的10条
		infoLists = new ArrayList();
		// ===取租赁新闻=====
		if (catalogNo.equals("700702")) {
			// 租赁新闻category=1001
			// 、租赁名企名家category=2004、租赁实务category=2001、租赁法规category=2003
			// 租赁公告category=1002
			int topNum = 0;
			String newSearch = ""; // 租赁实务、法规在生成在一个页面。
			if (sortNum.equals("1001")) {
				topNum = 10;
			} else if (sortNum.equals("1002")) {
				topNum = 10;
			} else if (sortNum.equals("2004")) {
				topNum = 5;
			} else if (sortNum.equals("2001")) { // 首页租赁实务及法规
				topNum = 10; // 显示条数
				newSearch = "' and category in (" + sortNum + ",2003)";
			} else {
				topNum = 9;
			}
			infosArr = DataManager
					.fetchFieldValue(
							pool,
							"rent_news",
							" top "
									+ topNum
									+ " title,html_filename,catalog_no,category,convert(varchar(10),pubdate,21) as pub_date,id,substring(content,0,100) as content,image",
							" is_pub=1 and catalog_no='"
									+ catalogNo
									+ (!newSearch.equals("") ? newSearch
											: "' and category='" + sortNum
													+ "'")
									+ " order by  id desc");

			if (infosArr != null)
				for (int i = 0; i < infosArr.length; i++) {
					info = new Info();
					info.setTitle(Common.getFormatStr(infosArr[i][0]));

					if (sortNum.equals("1002"))
						info
								.setUrl("http://www.21-rent.com/news/bulletindetail_for_"
										+ Common.getFormatInt(infosArr[i][5])
										+ ".htm");
					else
						info
								.setUrl("http://www.21-rent.com/news/newsdetail_for_"
										+ Common.getFormatInt(infosArr[i][5])
										+ ".htm");

					info.setCatalogNo(Common.getFormatStr(infosArr[i][2]));
					info.setFactoryName(Common.getFormatStr(infosArr[i][3]));
					info.setPubDate(Common.getFormatStr(infosArr[i][4]));
					info.setId(Common.getFormatStr(infosArr[i][5]));
					info.setRemark(Common.filterHtmlString(Common
							.getFormatStr(infosArr[i][6])));

					if (Common.getFormatStr(infosArr[i][7]).equals("")) {
						info.setPic("images/nopic.gif");
					} else {
						info.setPic(Common.getFormatStr(infosArr[i][7]));
					}
					infoLists.add(info);
					info = null;
				}
			root.put("infoLists", infoLists);
			infoLists = null;

			templateName = "/rent/template/t_index_news" + sortNum + ".htm";
			createFilename = websitePath + "/rent/include/index_news" + sortNum
					+ ".htm";

			System.out.println(createFilename);
		}// 求出租信息
		else if (catalogNo.equals("700701")) {
			// 最新出租信息
			infosArr = DataManager
					.fetchFieldValue(
							pool,
							"rent_info",
							" top 12 title,'' as html_filename,catalog_no,category,convert(varchar(10),pubdate,21) as pub_date,id,img,isnull(mem_flag,0) as mem_flag,mem_no ",
							" is_pub=1 and catalog_no='" + catalogNo
									+ "' and class='" + sortNum
									+ "' order by id desc");

			if (infosArr != null)
				for (int i = 0; i < infosArr.length; i++) {
					info = new Info();
					info.setTitle(Common.getFormatStr(infosArr[i][0]));
					info.setUrl("http://www.21-rent.com/news/detail/"
							+ Common.getFormatStr(infosArr[i][1]));
					info.setCatalogNo(Common.getFormatStr(infosArr[i][2]));
					info.setFactoryName(Common.getFormatStr(infosArr[i][3]));
					info.setPubDate(Common.getFormatStr(infosArr[i][4]));
					info.setId(Common.getFormatStr(infosArr[i][5]));
					info.setPic(Common.getFormatStr(infosArr[i][6]));
					info.setSource(Common.getFormatStr(infosArr[i][7])); // is_store=1

					// 为收费会员
					infoLists.add(info);
					info = null;
				}
			root.put("infoLists", infoLists);
			infoLists = null;

			templateName = "/rent/template/t_index_info" + sortNum + ".htm";
			// 出租
			createFilename = websitePath + "/rent/include/index_info" + sortNum
					+ ".htm";
		}// 最新工程招标项目
		else if (catalogNo.equals("bildding")) {
			// 招投标
			// System.out.println("sortNum="+sortNum);
			infosArr = DataManager
					.fetchFieldValue(
							pool,
							"bidding_bulletin",
							" top 5 title,'' as html_filename,catalog_num,'' as category,convert(varchar(10),pub_date,21) as pub_date,id ",
							" is_show=1 order by id desc");
			if (infosArr != null)
				for (int i = 0; i < infosArr.length; i++) {
					info = new Info();
					info.setTitle(Common.getFormatStr(infosArr[i][0]));
					info.setUrl("http://www.21-rent.com/news/detail/"
							+ Common.getFormatStr(infosArr[i][1]));
					info.setCatalogNo(Common.getFormatStr(infosArr[i][2]));
					info.setFactoryName(Common.getFormatStr(infosArr[i][3]));
					info.setPubDate(Common.getFormatStr(infosArr[i][4]));
					info.setId(Common.getFormatStr(infosArr[i][5]));

					infoLists.add(info);
					info = null;
				}
			root.put("infoLists", infoLists);
			infoLists = null;

			templateName = "/rent/template/t_index_bildding" + sortNum + ".htm";
			// 出租
			createFilename = websitePath + "/rent/include/index_bildding"
					+ sortNum + ".htm";
		}

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
			infoLists = null;
		}
	}

	/**
	 * 详细页面
	 * 
	 * @param pool
	 * @param request
	 * @param catalogNo
	 * @param id
	 */
	public void singleToHtml(PoolManager pool, HttpServletRequest request,
			String catalogNo, String id) {
		String templateName = "";// 模版页面名称
		String createFilename = "";// 页面文件名称
		this.init(request);
		Writer out = null;
		Template t = null;
		Info info = new Info();
		Map root = new HashMap();

		// 1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库
		// =====取栏目信息,通过模板生成文件=====
		String tempInfo[][] = DataManager
				.fetchFieldValue(
						pool,
						"rent_news ",
						"id,title,convert(varchar(10),pubdate,21) as pubdate,content,catalog_no,html_filename,clicked,source",
						" is_pub=1 and id=" + id);

		if (tempInfo != null && tempInfo[0][0] != null) {
			templateName = "/template/t_newsdetail.htm";
			createFilename = websitePath + "/news/detail/"
					+ Common.getFormatStr(tempInfo[0][5]);

			info.setTitle(Common.getFormatStr(tempInfo[0][1]));
			info.setPubDate(Common.getFormatStr(tempInfo[0][2]));
			info.setRemark(Common.getFormatStr(tempInfo[0][3]));

			info.setId(id);
			info
					.setCount(Integer.parseInt(Common
							.getFormatInt(tempInfo[0][6])));
			info.setSource(Common.getFormatStr(tempInfo[0][7]));
		}
		root.put("info", info);
		// System.out.println(templateName);
		// ====取列表信息完毕====
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
			// obj = null;
			root = null;
			tempInfo = null;
			pool = null;
			tempInfo = null;
		}
	}

	/**
	 * 生成首页所有包括静态页
	 * 
	 * @param request
	 * @param pool
	 * @param catalogNo
	 */

	public int indexAllHtml(HttpServletRequest request, PoolManager pool,
			String catalogNo) {
		int result = 0;
		try {
			indexList(request, pool, "700702", "1001"); // ===最新资讯===
			indexList(request, pool, "700702", "2004"); // ===名企名家===
			indexList(request, pool, "700702", "2001"); // ===务实法归===
			indexList(request, pool, "700702", "1002"); // ===公告速递===
			indexList(request, pool, "700701", "0"); // ===求租信息===
			indexList(request, pool, "700701", "1"); // ===出租信息===

			PoolManager pool1 = new PoolManager(1);
			indexList(request, pool1, "bildding", "1000"); // ===招投标===

			result = 1;

		} catch (Exception e) {
			result = 0;
			Common.println(e);
		} finally {
			return result;
		}
	}

	/**
	 * 生成所有静态页
	 * 
	 * @param request
	 * @param pool
	 * @param catalogNo
	 */
	public int allHtml(HttpServletRequest request, PoolManager pool,
			String catalogNo) {
		String tempInfo[][] = null;
		int result = 0;
		try {
			// ====更新首页所有模板===
			indexAllHtml(request, pool, catalogNo);
			// ====生成所有的页面===
			tempInfo = DataManager.fetchFieldValue(pool, "rent_news", "id",
					" is_pub=1 and catalog_no='" + catalogNo + "'");
			if (tempInfo != null)
				for (int i = 0; i < tempInfo.length; i++)
					singleToHtml(pool, request, catalogNo, Common
							.getFormatInt(tempInfo[i][0]));
			result = 1;

		} catch (Exception e) {
			result = 0;
			Common.println(e);
		} finally {
			tempInfo = null;
			return result;

		}

	}

}
