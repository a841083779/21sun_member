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

public class UsedToHtml {

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
		websitePath = Constants.USED_PATH;
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
			String catalogNo, String sortNum, String is_recom) {
		this.init(request);

		// System.out.println("sortNum="+sortNum);

		String templateName = "";// 模版页面名称
		String createFilename = "";// 页面文件名称
		String tempClass = "";// 类别
		Writer out = null;
		Template t = null;
		Info info = null;
		Map root = new HashMap();

		List infoLists = null;
		String infosArr[][] = null;

		// 置顶的10条
		infoLists = new ArrayList();

		sortNum = Common.getFormatStr(sortNum);
		is_recom = Common.getFormatStr(is_recom);

		String searchStr = "";
		int topnum = 15;

		if (!is_recom.equals("")) { // 查询推荐设备
			searchStr = " and is_recom='" + is_recom + "'  and is_sale=0 ";
			topnum = 4;
		}
		// ===如果是设备===
		if (catalogNo.equals("700901")) {
			infosArr = DataManager
					.fetchFieldValue(
							pool,
							"equipment",
							" top "
									+ topnum
									+ " id,title,factorydate,price,'',img1,brandname,category,model",
							" is_pub=1 " + searchStr + " order by  id desc");
		}
		// ====如果求购信息====
		else if (catalogNo.equals("700902")) {
			infosArr = DataManager.fetchFieldValue(pool, "buy", " top "
					+ topnum + " id,title,'','','','','',category,''",
					" is_pub=1  order by  id desc");
		}
		if (infosArr != null)
			for (int i = 0; i < infosArr.length; i++) {
				info = new Info();
				info.setTitle(Common.getFormatStr(infosArr[i][1]));
				if (is_recom.equals("")) {
					info.setPubDate(Common.getFormatStr(infosArr[i][2]));
				} else {
					if (!Common.getFormatStr(infosArr[i][2]).equals("")) {
						info
								.setPubDate((Common
										.getFormatStr(infosArr[i][2]) + "年产"));
					} else {
						info.setPubDate("");
					}
				}
				info.setPrice(Common.getFormatStr(infosArr[i][3]));
				// ====如果是设备====
				if (catalogNo.equals("700901")) {
					info.setUrl("/equipment/equipmentdetail_for_"
							+ Common.getFormatStr(infosArr[i][0]) + ".htm");
				} // ====如果求购信息====
				else if (catalogNo.equals("700902")) {
					info.setUrl("/buy/buydetail_for_"
							+ Common.getFormatStr(infosArr[i][0]) + ".htm");
				}
				if (Common.getFormatStr(infosArr[i][5]).equals("")) {
					info.setPic("/images/nopic.gif");
				} else {
					info.setPic(Common.getFormatStr(infosArr[i][5]));
				}
				info.setFactoryName(Common.getFormatStr(infosArr[i][6]));
				info.setCatalogName(Common.getCategory(infosArr[i][7]));
				info.setSource(Common.getFormatStr(infosArr[i][8]));
				infoLists.add(info);
				info = null;
			}
		root.put("infoLists", infoLists);
		infoLists = null;

		if (!is_recom.equals("")) {
			templateName = "/template/t_index_recommend.htm";
			createFilename = websitePath + "/include/index_recommend.htm";
		} else {
			// ====如果是设备====
			if (catalogNo.equals("700901")) {
				templateName = "/template/t_index_equipment.htm";
				createFilename = websitePath + "/include/index_equipment.htm";
			}// ====如果求购信息====
			else if (catalogNo.equals("700902")) {
				templateName = "/template/t_index_buy.htm";
				createFilename = websitePath + "/include/index_buy.htm";
			}
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
			tempClass = null;
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

			// ====二手设备====
			if (catalogNo.equals("700901")) {
				// System.out.println(catalogNo+":==="+catalogNo);
				indexList(request, pool, catalogNo, "1", "");
				indexList(request, pool, catalogNo, "1", "2"); // 首页推荐 设备产品
			} else if (catalogNo.equals("700902")) {
				// System.out.println(catalogNo+":==="+catalogNo);
				indexList(request, pool, catalogNo, "0", "");
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
