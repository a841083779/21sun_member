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

public class MainUsedToHtml {

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

		// System.out.println("sortNum="+sortNum);

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
		infosArr = DataManager.fetchFieldValue(pool, "used_info",
				" top 10 id,title,img1,convert(varchar(10),pubdate,21)",
				" is_pub=1 and catalog_no='" + catalogNo + "' and class='"
						+ sortNum + "' order by  id desc");

		if (infosArr != null)
			for (int i = 0; i < infosArr.length; i++) {
				info = new Info();
				info.setTitle(Common.getFormatStr(infosArr[i][1]));
				info
						.setUrl("http://www.21-used.com/equipment/equipmentdetail_for_"
								+ Common.getFormatStr(infosArr[i][0]) + ".htm");
				info.setPic(Common.getFormatStr(infosArr[i][2]));
				info.setPubDate(Common.getFormatStr(infosArr[i][3]));
				infoLists.add(info);
				info = null;
			}
		root.put("infoLists", infoLists);
		infoLists = null;
		if (sortNum.equals("1")) {
			templateName = "/used/template/t_index_sell.htm";
			createFilename = websitePath + "/used/include/index_sell.htm";
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
	 * 生成首页所有包括静态页
	 * 
	 * @param request
	 * @param pool
	 * @param catalogNo
	 */

	public int indexAllHtml(HttpServletRequest request, PoolManager pool,
			String catalogNo) {
		int result = 0;
		try {// ====二手求购、出售====
			if (catalogNo.equals("700901")) {
				indexList(request, pool, "700901", "1");
			}
			result = 1;

		} catch (Exception e) {
			result = 0;
			Common.println(e);
		} finally {
			return result;
		}
	}

}
