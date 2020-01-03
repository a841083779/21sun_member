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

public class TechToHtml {

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

		String templateName = "";// 模版页面名称
		String createFilename = "";// 页面文件名称
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		List infoLists = null;
		String infosArr[][] = null;

		// 置顶的10条
		infoLists = new ArrayList();
		infosArr = DataManager
				.fetchFieldValue(
						pool,
						"article_other",
						" top 8 title,html_filename,catalog_no,sort_num,convert(varchar(10),pub_date,21) as pub_date",
						" is_pub=1 and catalog_no='" + catalogNo
								+ "' and sort_num='" + sortNum
								+ "' order by pub_date desc");
		if (infosArr != null)
			for (int i = 0; i < infosArr.length; i++) {
				info = new Info();
				info.setTitle(Common.getFormatStr(infosArr[i][0]));
				info.setUrl("/tech/detail/"
						+ Common.getFormatStr(infosArr[i][1]));
				info.setCatalogNo(Common.getFormatStr(infosArr[i][2]));
				info.setFactoryName(Common.getFormatStr(infosArr[i][3]));
				info.setPubDate(Common.getFormatStr(infosArr[i][4]));

				infoLists.add(info);
				info = null;
			}
		root.put("infoLists", infoLists);
		infoLists = null;

		templateName = "/tech/template/t_index" + sortNum + ".htm";
		createFilename = websitePath + "/tech/include/index" + sortNum + ".htm";

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
	 * 取资讯中心的两个栏目趋势分析、公司动态放在首页右边
	 * 
	 * @param request
	 * @param pool
	 * @param catalogNo
	 */
	public void indexListOther(HttpServletRequest request, PoolManager pool,
			String catalogNo) {

		this.init(request);

		String templateName = "";// 模版页面名称
		String createFilename = "";// 页面文件名称
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		List infoLists = null;
		String infosArr[][] = null;

		// 置顶的10条
		infoLists = new ArrayList();
		infosArr = DataManager
				.fetchFieldValue(
						pool,
						"article",
						" top 10  title,substring(html_filename,0,5) as yyyy,substring(html_filename,5,2) as mm,html_filename,left(convert(varchar(20),pub_date,20),10) as pub_date",
						" is_pub=1 and  sort_num like '%" + catalogNo
								+ "%' order by pub_date desc");
		if (infosArr != null)
			for (int i = 0; i < infosArr.length; i++) {
				info = new Info();
				info.setTitle(Common.getFormatStr(infosArr[i][0]));
				info.setUrl(Common.getFormatStr(infosArr[i][1]) + "/"
						+ Common.getFormatStr(infosArr[i][2]) + "/"
						+ Common.getFormatStr(infosArr[i][3]));
				infoLists.add(info);
				info = null;
			}
		root.put("infoLists", infoLists);
		infoLists = null;

		templateName = "/tech/template/t_index_other.htm";
		createFilename = websitePath + "/tech/include/index_other_" + catalogNo
				+ ".htm";

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
						"article_other ",
						"id,title,convert(varchar(10),pub_date,21) as pub_date,content,catalog_no,html_filename,view_count,source",
						" is_pub=1 and id=" + id);
		if (tempInfo != null && tempInfo[0][0] != null) {

			templateName = "/tech/template/t_detail.htm";
			createFilename = websitePath + "/tech/detail/"
					+ Common.getFormatStr(tempInfo[0][5]);

			info.setTitle(Common.getFormatStr(tempInfo[0][1]));
			info.setPubDate(Common.getFormatStr(tempInfo[0][2]));
			info.setRemark(Common.getFormatStr(tempInfo[0][3]));
			info.setId(id);
			info.setCount(Integer.parseInt(Common
					.getFormatInt((tempInfo[0][6] == null || tempInfo[0][6]
							.equals("")) ? "0" : tempInfo[0][6])));
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
	public int indexNewHtml(HttpServletRequest request, PoolManager pool,
			String catalogNo) {
		int result = 0;
		try {
			// ====更新首页所有模板===
			for (int i = 1; i <= 7; i++) {
				if (i <= 6)
					indexList(request, pool, catalogNo, "0" + i + "00");
				if (i == 7)
					indexList(request, pool, "700401", "0" + i + "00");

			}
			// 生成右边包括的趋势分析、公司动态
			indexListOther(request, pool, "19");
			indexListOther(request, pool, "22");
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
			indexNewHtml(request, pool, catalogNo);
			// ====生成所有的页面===
			tempInfo = DataManager.fetchFieldValue(pool, "article_other ",
					"id", " is_pub=1 and catalog_no='" + catalogNo + "'");
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
