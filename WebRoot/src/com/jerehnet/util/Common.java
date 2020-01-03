package com.jerehnet.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import com.jerehnet.cmbol.action.ManageAction;
import com.jerehnet.cmbol.database.DataManager;
import com.jerehnet.cmbol.database.PoolManager;
import com.jerehnet.util.common.Async;
import com.jerehnet.util.common.CommonString;
import com.jerehnet.util.common.UTF8PostMethod;

/**
 * 
 * @author Ben
 * 
 *         一些通用方法封装的javaBean
 * 
 */

public class Common {
	/**
	 * 生成唯一字符串 创建日期：May 14, 2008 创建时间: 5:07:39 PM
	 * 
	 * @param count
	 *            需要长度
	 * @param flag
	 *            是否允许出现特殊字符 -- !@#$%^&*()
	 * @return
	 */

	public static String getUniqueString(int count, int flag) {
		return UniqueString.getUniqueString(count, flag).toLowerCase();
	}

	/**
	 * 根据传入的格式，返回当前日期
	 * 
	 * @param format
	 * @param flag
	 *            1:表示往后加一个月,2:往前加一个月
	 * @return
	 */
	public static String getToday(String format, int month) {
		String today = "";
		SimpleDateFormat sdf = null;
		Calendar calendar = null;
		try {
			sdf = new SimpleDateFormat(format);
			calendar = Calendar.getInstance();
			if (month != 0) {
				calendar.add(Calendar.MONTH, month);
			}

			today = sdf.format(calendar.getTime());
		} catch (RuntimeException e) {
			e.printStackTrace();
		} finally {
			sdf = null;
			calendar = null;
		}
		return today;

	}

	public static String getDate(String format, String flag, int num) {
		String date = "";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Calendar calendar = Calendar.getInstance();
		if (flag != null) {
			if ("d".equalsIgnoreCase(flag)) {
				calendar.add(Calendar.DATE, num);
			} else if ("m".equalsIgnoreCase(flag)) {
				calendar.add(Calendar.MONTH, num);
			} else if ("y".equalsIgnoreCase(flag)) {
				calendar.add(Calendar.YEAR, num);
			}
			date = sdf.format(calendar.getTime());
		}
		return date;
	}
	
	/**
	 * 格式化时间
	 * @param format 格式
	 * @param d 时间 (java.sql)
	 * @return
	 */
	public static String getFormatDate(String format, Object date) {
		if(date instanceof java.sql.Date){
			java.sql.Date d = (java.sql.Date)date;
			String today = "";
			try {
				SimpleDateFormat sdf = new SimpleDateFormat(format);
				Date now = new Date(d.getTime());
				today = sdf.format(now);
				sdf = null;
				now = null;
			} catch (Exception e) {
				
			}
			return today;
		}
		if(date instanceof java.util.Date){
			java.util.Date d = (java.util.Date)date;
			String today = "";
			try {
				SimpleDateFormat sdf = new SimpleDateFormat(format);
				Date now = new Date(d.getTime());
				today = sdf.format(now);
				sdf = null;
				now = null;
			} catch (Exception e) {
				
			}
			return today;
		}
		return "";
	}

	/**
	 * 返回格式化后的日期
	 * 
	 * @param format
	 * @param d
	 * @return
	 */
	public static String getFormatDate(String format, java.sql.Date d) {
		String today = "";
		Date now = null;
		SimpleDateFormat sdf = null;
		try {

			if (d != null) {
				now = new Date(d.getTime());
				sdf = new SimpleDateFormat(format);
				today = sdf.format(now);
			}
		} catch (Exception e) {
		} finally {
			now = null;
			sdf = null;
		}
		return today;
	}

	/**
	 * 把传入的字符串经过去除前后空格、NULL，重新返回
	 * 
	 * @param str
	 * @return
	 */
	public static String getFormatStr(String str) {
		String formatStr = "";
		if (str != null) {
			formatStr = str.replace("'", "").replace("\\", "").replace("null",
					"").replace("<!--", "").trim();
		}
		return formatStr;
	}

	/**
	 * 用于伪静态页面
	 * 
	 * @param str
	 * @return
	 */
	public static String getFormatFile(String str) {
		String formatStr = "";
		if (str != null) {
			formatStr = str.replace("'", "").replace(";", "").replace("?", "")
					.trim();
		}
		return formatStr;
	}

	/**
	 * 把传入的整数经过处理,返回.
	 * 
	 * @param str
	 * @return
	 */
	public static String getFormatInt(String str) {
		String formatStr = "0";
		try {
			if (str == null) {
				str = "";
			}
			if (str.indexOf(".") > -1) {
				str = str.substring(0, str.indexOf("."));
			}
			formatStr = String.valueOf(Integer.parseInt(str));

		} catch (Exception e) {
			;
		}
		return formatStr;
	}

	/**
	 * 把传入的字符经过处理,返回.四舍五入取后面两位小数
	 * 
	 * @param str
	 * @return
	 */
	public static double getFormatDouble(String str) {
		double formatStr = 0;
		try {
			if (str == null || str.trim().equals("")) {
				str = "0";
			}
			// =====java四舍五入有问题,便向处理了一下
			if (str.indexOf(".") > -1
					&& str.substring(str.indexOf(".") + 1).length() < 4) {
				str = str + "0001";
			}
			formatStr = Double.parseDouble(str);
			// ====格式化两位=====
			DecimalFormat df = new DecimalFormat("##.00");
			formatStr = Double.parseDouble(df.format(formatStr));

		} catch (Exception e) {
			;
		}
		return formatStr;
	}

	/**
	 * 用于格式化产品规格==
	 * 
	 * @param str
	 * @param flag
	 *            1:表示产品规格
	 * @return
	 */
	public static String getFormatStandard(String str, int flag, int paralength) {
		if (str == null)
			str = "";
		if (flag == 1) {
			str = (str.length() > paralength ? "("
					+ str.substring(0, paralength) + "..." + ")" : (str
					.length() > 0 ? "(" + str + ")" : ""));
		} else if (flag == 2) {
			str = (str.length() > paralength ? str.substring(0, paralength)
					+ "..." : str);
		} else if (flag == 3) {
			str = (str.length() > paralength ? str.substring(0, paralength)
					: str);
		}
		return str;
	}

	/**
	 * 用于格式化产品名称、产品规格==
	 * 
	 * @param str
	 * @param flag
	 *            1:带括号,省略号;2:去括号,省略号;3:不带省略号
	 * @return
	 */
	public static String getFormatPartsname(String partname, String standard,
			int flag, int paralength) {
		String result = "";
		if (partname == null) {
			partname = "";
		}
		int partnameLens = partname.length();
		if (standard == null) {
			standard = "";
		}
		int standardLens = standard.length();

		if (flag == 1) {
			if (partnameLens > paralength) {
				result = partname.substring(0, paralength) + "...";
			} else {
				result = partname.substring(0, partnameLens)

						+ "("
						+ (standardLens > (paralength - partnameLens) ? standard
								.substring(0, paralength - partnameLens)
								: standard.substring(0, standardLens)) + "...)";
			}
		} else if (flag == 2) {
			if (partnameLens > paralength) {
				result = partname.substring(0, paralength) + "...";
			} else {
				result = partname.substring(0, partnameLens)

						+ (standardLens > (paralength - partnameLens) ? standard
								.substring(0, paralength - partnameLens)
								: standard.substring(0, standardLens)) + "...";
			}

		} else if (flag == 3) {
			if (partnameLens > paralength) {
				result = partname.substring(0, paralength);

			} else {
				result = partname.substring(0, partnameLens)

						+ (standardLens > (paralength - partnameLens) ? standard
								.substring(0, paralength - partnameLens)
								: standard.substring(0, standardLens));
			}
		}
		return result;
	}

	/**
	 * 用于格式化输出产品价格,包括一口价,价格区间==
	 * 
	 * @param str
	 * @param flag
	 *            1:表示产品规格
	 * @return
	 */
	public static String getFormatPartsPrices(String onePrice,
			String startPrice, String endPrice) {
		String formatstr = "";
		if (Common.getFormatDouble(onePrice) > 0) {
			formatstr = onePrice;
		}

		else if (Common.getFormatDouble(startPrice) > 0) {
			if (formatstr.equals("")) {
				formatstr = startPrice;
			} else {
				formatstr += "&nbsp;" + startPrice;

			}

		} else if (Common.getFormatDouble(endPrice) > 0) {
			if (formatstr.equals("")) {
				formatstr = endPrice;

			} else {
				formatstr += "&nbsp;~" + endPrice;

			}
		}

		return formatstr;
	}

	/**
	 * 配件商场图片处理
	 * 
	 * @param onePrice
	 * @return
	 */
	public static String getFormatPic(String pic) {
		// String formatpic = "no_small.gif";
		String formatpic = "/images/nopic.gif";
		if (pic == null) {
			pic = "";

		}
		if (pic != null && !pic.trim().equals("") && !pic.trim().equals("null")) {
			formatpic = pic;

		}
		return formatpic;
	}

	/**
	 * 格式化供货、正副厂
	 * 
	 * @param onePrice
	 * @param flag
	 *            1:表示供货,2:表示正副厂
	 * @return
	 */
	public static String getFormatTinyint(String str, String strflag) {
		if (str == null)
			str = "";
		String formatstr = "";
		int intflag = Integer.parseInt(getFormatInt(strflag));
		if (intflag == 1) {
			if (str.equals("1")) {
				formatstr = "现货";

			} else if (str.equals("2")) {
				formatstr = "期货";

			}
		}

		else if (intflag == 2) {
			if (str.equals("1")) {
				formatstr = "正厂";

			} else if (str.equals("2")) {
				formatstr = "副厂";

			} else if (str.equals("3")) {
				formatstr = "两种";

			}
		}
		return formatstr;
	}

	/**
	 * 详细打印出错信息
	 * 
	 * @param e
	 */
	public static void println(Exception e) {
		e.printStackTrace();
	}

	/**
	 * 打印传入的字符串
	 * 
	 * @param printStr
	 */
	public static void println(String printStr) {
		//System.out.println(printStr);
	}

	/**
	 * 返回下拉菜单的option，如果flag为1则下拉树状显示value
	 * 
	 * @param pool
	 * @param tablename
	 * @param fieldname
	 * @param tj
	 * @param selValue
	 * @param flag
	 * @return
	 */
	public static String getOptions(PoolManager pool, String tablename,
			String fieldname, String whereStr, String selValue, int flag) {
		StringBuffer result = new StringBuffer();

		String options[][] = null;
		String selStr = "";
		try {
			options = DataManager.fetchFieldValue(pool, tablename, fieldname,
					whereStr);
			if (options != null)
				for (int i = 0; i < options.length; i++) {
					if (options[i][0].equals(selValue)) {
						selStr = "' selected>";

					}

					else {
						selStr = "'>";

					}
					// ====下拉树状显示====
					if (flag == 1) {
						result
								.append("<option value='"
										+ options[i][0]
										+ selStr
										+ (createSpaces(options[i][0].length()) + options[i][1])
										+ "</option>");
					} else {
						result.append("<option value='" + options[i][0]
								+ selStr + options[i][1] + "</option>");
					}

				}
		} catch (Exception e) {
			Common.println(e);
		} finally {
			options = null;
			selStr = null;
		}
		return result.toString();
	}

	/**
	 * 创建一个Cookie
	 * 
	 * @param response
	 * @param key索引键值
	 * @param value存储值
	 * @param time有效时间
	 *            ，这里是秒
	 */
	public static void createCookie(HttpServletResponse response, String key,
			String value, int time) {
		Cookie cookie = null;
		try {
			value = java.net.URLEncoder.encode(value);
			cookie = new Cookie(key, value);
			cookie.setMaxAge(time);
			cookie.setPath("/");
			response.addCookie(cookie);
		} catch (Exception e) {
		} finally {
			cookie = null;
		}
	}

	/**
	 * 读取一个Cookie
	 * 
	 * @param request
	 * @param key索引键值
	 * @return value存储值
	 */
	public static String getCookies(HttpServletRequest request, String key) {
		Cookie cookies[] = null;
		String r = null;

		try {
			cookies = request.getCookies();
			for (int i = 0; cookies != null && i < cookies.length; i++) {
				if (cookies[i].getName().equals(key)) {
					r = java.net.URLDecoder.decode(cookies[i].getValue());
					break;
				}
			}
		} catch (Exception e) {
		} finally {
			cookies = null;
		}
		return r;
	}

	/**
	 * 给所有关键词加上链接
	 * 
	 * @param source
	 * @param oldstring
	 * @param linkStr
	 * @return
	 */
	public static String ignoreCaseReplace(String source, String oldstring,
			String linkStr) {
		String str = "";
		Pattern p = null;
		Matcher m = null;

		try {
			p = Pattern.compile(oldstring, Pattern.CASE_INSENSITIVE);
			m = p.matcher(source);
			str = m.replaceAll("<font color='#FF0000'>$0</font>");
		} catch (Exception e) {
		} finally {
			p = null;
			m = null;
		}
		return str;
	}

	/**
	 * 给关键词第一个加上连接
	 * 
	 * @param source
	 * @param oldstring
	 * @param linkStr
	 * @return
	 */
	public static String replaceKey(String source, String oldstring,
			String linkStr) {
		String str;
		str = source
				.replaceFirst(oldstring, "<a href=\"" + linkStr
						+ "\" class=\"link08\" target=\"_blank\">" + oldstring
						+ "</a>");
		return str;
	}

	/**
	 * 去掉所有html元素
	 * 
	 * @param input
	 * @return
	 */
	public static String filterHtmlString(String input) {
		if (input == null || input.trim().equals("")) {
			return "";
		}

		String str = input.replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll(
				"<[^>]*>", "");
		str = str.replaceAll("[(/>)<]", "");
		return str;
	}

	/**
	 * 获取内容中的所有图片
	 * 
	 * @param str
	 * @return
	 */
	public static String getPicFromContent(String str) {
		String returnStr = "";
		String patt = "";
		Pattern p = null;
		Matcher m = null;
		boolean result = false;
		try {
			if (str == null || str.length() == 0) {
				returnStr = str;
			}
			patt = "<img(?:.*)src=(\"{1}|\'{1})([^\\[^>]+[gif|jpg|jpeg|bmp|bmp]*)(\"{1}|\'{1})(?:.*)>";
			p = Pattern.compile(patt);
			m = p.matcher(str);
			result = m.find();
			while (result) {
				returnStr += m.group(2) + ",";
				result = m.find();
			}
		} catch (Exception e) {
		} finally {
			patt = null;
			p = null;
			m = null;
		}
		return returnStr;
	}

	/**
	 * 获取内容中的一张图片
	 * 
	 * @param str
	 * @return
	 */
	public static String getOnePicFromContent(String str) {
		String returnStr = "";
		String patt = null;
		Pattern p = null;
		Matcher m = null;
		boolean result = false;
		try {
			if (str == null || str.length() == 0) {
				returnStr = str;
			}
			patt = "<img(?:.*)src=(\"{1}|\'{1})([^\\[^>]+[gif|jpg|jpeg|bmp|bmp]*)(\"{1}|\'{1})(?:.*)>";
			p = Pattern.compile(patt);
			m = p.matcher(str);

			result = m.find();
			if (result) {
				returnStr = m.group(2);
			}
		} catch (Exception e) {
		} finally {
			patt = null;
			p = null;
			m = null;
		}
		return returnStr;
	}

	/**
	 * 截取字符串，以半角字符来截取
	 * 
	 * @param str
	 * @param length
	 * @return
	 */
	public static String substringByte(String str, int length) {
		int reInt = 0;
		String reStr = "";
		char[] tempChar = null;
		String s1 = "";
		byte[] b = null;
		try {
			if (str == null) {
				reStr = "";
			}
			tempChar = str.toCharArray();
			for (int kk = 0; (kk < tempChar.length && length > reInt); kk++) {
				s1 = str.valueOf(tempChar[kk]);
				b = s1.getBytes();
				reInt += b.length;
				reStr += tempChar[kk];
			}
			if (length == reInt || (length == reInt - 1)) {
				reStr += "...";

			}
		} catch (Exception e) {
		} finally {
			tempChar = null;
			s1 = null;
			b = null;
		}
		return reStr;
	}

	public static String substringByte2(String str, int length) {
		int reInt = 0;
		String reStr = "";
		char[] tempChar = null;
		String s1 = null;
		byte[] b = null;
		try {
			if (str == null) {
				reStr = "";
			}
			tempChar = str.toCharArray();
			for (int kk = 0; (kk < tempChar.length && length > reInt); kk++) {
				s1 = str.valueOf(tempChar[kk]);
				b = s1.getBytes();
				reInt += b.length;
				reStr += tempChar[kk];
			}
			if (length == reInt || (length == reInt - 1)) {
				reStr += "...";

			}
		} catch (Exception e) {
		} finally {
			tempChar = null;
			s1 = null;
			b = null;
		}
		return reStr;
	}

	/**
	 * 返回一个时间+随机码的字符串
	 * 
	 * @return
	 */
	public static String generateDateRandom() {
		String formatDate = new SimpleDateFormat("yyMMddHHmmss")
				.format(new Date());
		int random = new Random().nextInt(100);
		return formatDate + random;
	}

	/**
	 * 生成订单编号
	 * 
	 * @return
	 */
	public static String createOrderNo(String systemno) {
		String formatDate = new SimpleDateFormat("yyyyMMddhhmmssSSS")
				.format(new Date());
		int random = new Random().nextInt(1000);
		formatDate = formatDate + "_" + random;
		formatDate += "_" + systemno;
		return formatDate;
	}

	/**
	 * 生成21sun中的排序字段号====
	 * 
	 * @param flag
	 *            1:租赁网
	 *@controlParam 控制参数
	 * @param subflag
	 * @return
	 */
	public static String create21SUNOrderNo(int flag, String controlParam,
			int subflag) {
		
		String result = "";
		
		if (flag == 1) {
			if (!controlParam.equals("1005") && !controlParam.equals("1009"))
				controlParam = "0";
			// result = controlParam
			// + new SimpleDateFormat("yyyyMMddhhmmssSSS")
			// .format(new Date());
			if (subflag == 0) {
				result = new SimpleDateFormat("yyyyMMdd").format(new Date())
						+ controlParam;
			} else if (subflag == 1) {
				result = new SimpleDateFormat("yyyyMMddhhmmssSSS")
						.format(new Date())
						+ controlParam;
			}
		}

		return result;
	}
	/**
	 * 生成指定长度的不同随机数字
	 * @param len
	 * @return
	 */
public static String getRandom(int len){
	len = (len<=0?4:len) ;
	StringBuffer randStr = new StringBuffer("") ;
	 Random ran = new Random();
	 int i=0 ;
     while(i < len){
         int t = ran.nextInt(9);
         if(randStr.indexOf(String.valueOf(t)) == -1){
        	 randStr.append(t);
            i++;
         }
      }
	return randStr.toString() ;
}
	/**
	 * 传入汉字，返回全拼
	 * 
	 * @param str
	 * @return
	 */
	public static String getFullSpell(String str) {
		str = getFormatStr(str);
		str = CnToFullSpell.getFullSpell(str);
		return str;
	}

	/**
	 * 传入汉子，返回每个汉字的第一个字母
	 * 
	 * @param str
	 * @return
	 */
	public static String getSingleSpell(String str) {
		str = getFormatStr(str);
		str = CnToFullSpell.getFirstSpell(str);
		return str;
	}

	/**
	 * 生成指定大小的缩略图
	 * 
	 * @param bigImg
	 * @param smallPic
	 * @param width
	 * @param height
	 */
	public static void convToImg(String bigImg, String smallPic, int width,
			int height) {
		try {
			// 参数1(from),参数2(to),参数3(宽),参数4(高)
			ConvToImg.saveImageAsJpg(bigImg, smallPic, width, height);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 给图片加上图片水印
	 * 
	 * @param pressImg
	 * @param targetImg
	 * @param x
	 * @param y
	 */
	public static void waterMark(String pressImg, String targetImg, int x, int y) {
		try {
			WaterMark.pressImage(pressImg, targetImg, x, y);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 给图片加上文字
	 * 
	 * @param pressImg
	 * @param targetImg
	 * @param x
	 * @param y
	 */
	public static void pressText(String pressText, String targetImg,
			String fontName, int fontStyle, int color, int fontSize, int x,
			int y) {
		try {
			WaterMark.pressText(pressText, targetImg, fontName, fontStyle,
					color, fontSize, x, y);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据日期转换成目录,eg:yyyy/MM
	 * 
	 * @param date
	 * @return
	 */
	public static String dateToDirector(String date) {
		String result = "";
		String tp[] = null;
		try {
			tp = date.split("-");
			if (tp != null && tp.length >= 2) {
				result = tp[0] + "/" + tp[1] + "/";
			}
		} catch (Exception e) {
		} finally {
			tp = null;
		}
		return result;
	}

	/**
	 * 
	 * @param pool
	 * @param request
	 * @param tablename
	 * @param id
	 * @param strflag
	 *            1、增加 2、修改 3、删除 4、登陆,5、退出
	 * @param sessionflag
	 *            1:普通会员,2:商贸网管理员
	 * @param subwebNo
	 *            子站点的编号 5:商贸专栏;6:表示人才
	 */
	public static void saveLogs(PoolManager pool, HttpServletRequest request,
			String tablename, String id, String strflag, int sessionflag,
			int subwebNo) {
		String tempArrayInfo[][] = null;
		String tempCatalogInfo[][] = null;

		String usern = "";
		String realname = "";
		SimpleDateFormat dateformat = null;
		String add_date = null;
		StringBuffer sql = new StringBuffer();

		String content = "";
		String catalogNo = "";
		String catalogName = "", field = "";
		int flag = 0;
		try {
			flag = Integer.parseInt(strflag);
		} catch (Exception e) {
			flag = 0;
		}
		try {
			// 取catalogNo的信息
			if (flag == 1) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						" top 1 catalog_no ", " 1>0 order by id desc ");
				catalogNo = (tempArrayInfo != null ? tempArrayInfo[0][0] : "");

			} else if (flag == 2) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"catalog_no", " id=" + id);
				catalogNo = (tempArrayInfo != null ? tempArrayInfo[0][0] : "");
			} else if (flag == 3) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"catalog_no", " id=" + id);
				catalogNo = (tempArrayInfo != null ? tempArrayInfo[0][0] : "");
			}

			// ====得到catalog_name,field信息===
			tempCatalogInfo = createCatalogField(pool, tablename, catalogNo);
			if (tempCatalogInfo != null && tempCatalogInfo[0][0] != null) {
				catalogName = tempCatalogInfo[0][0];
			}
			if (tempCatalogInfo != null && tempCatalogInfo[0][1] != null) {
				field = tempCatalogInfo[0][1];
			}
			// ===得到session中的信息====
			if (sessionflag == 1) {
				usern = ManageAction.getAdminInfo(request, "uid", "memberInfo");
				realname = ManageAction.getAdminInfo(request, "fullname",
						"adminInfo");
			} else if (sessionflag == 2) {
				usern = ManageAction
						.getAdminInfo(request, "usern", "adminInfo");
				realname = ManageAction.getAdminInfo(request, "realname",
						"adminInfo");
			}
			// ========
			dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			add_date = dateformat.format(Calendar.getInstance().getTime());
			if (flag == 1 && !field.equals("")) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						" top 1 " + field, " 1>0 order by id desc ");
				content = "增加:==="
						+ (tempArrayInfo != null ? tempArrayInfo[0][0] : "");

			} else if (flag == 2 && !field.equals("")) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						field, " id=" + id);
				content = "修改:==="
						+ (tempArrayInfo != null ? tempArrayInfo[0][0] : "");
			} else if (flag == 3 && !field.equals("")) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						field, " id=" + id);
				content = "删除:==="
						+ (tempArrayInfo != null ? tempArrayInfo[0][0] : "");
			} else if (flag == 4) {
				catalogName = usern;
				content = "登录";
			} else if (flag == 5) {
				catalogName = usern;
				content = "退出";
			}

			// ====如果栏目和内容为空,则不提交到数据库中去。
			if (!catalogName.equals("") && !content.equals("")) {
				sql
						.append("insert into cmbol_logs(add_user,add_date,add_ip,catalog_name,content,subweb_no)values('"
								+ usern
								+ "','"
								+ add_date
								+ "','"
								+ request.getRemoteHost()
								+ "','"
								+ catalogName
								+ "','" + content + "'," + subwebNo + ")");
				DataManager.executeSQL(pool, sql.toString());
			}
		} catch (Exception e) {
			;
		} finally {
			usern = null;
			dateformat = null;
			add_date = null;
			tempArrayInfo = null;
			tempCatalogInfo = null;
			sql = null;
			content = null;
			catalogName = null;
			field = null;
			catalogNo = null;
		}
	}

	/**
	 * 取店铺id
	 * 
	 * @param pool
	 * @param tablename
	 * @param storeNo
	 * @param flag
	 *            1:表示ID,2:表示VIP,3:通过加密的ID得到vip
	 * @return
	 */
	public static String fetchStoreId(PoolManager pool, String tablename,
			String storeNo, int flag) {
		String result = "0";
		String tempArrayInfo[][] = null;
		DesEncrypt desEncrypt = DesEncrypt.init();
		try {
			if (flag == 1) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"id", " store_no='" + storeNo + "'");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			} else if (flag == 2) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"is_vip", " store_no='" + storeNo + "'");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			} else if (flag == 3) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"is_vip", " id='" + desEncrypt.getDesString(storeNo)
								+ "'");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			} else if (flag == 4) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"store_no", " id='" + desEncrypt.getDesString(storeNo)
								+ "'");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			} else if (flag == 5) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"id", " id='" + desEncrypt.getDesString(storeNo) + "'");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			} else if (flag == 6) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"name", " store_no='" + storeNo + "'");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			} else if (flag == 7) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, tablename,
						"max(id)", "");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			} else if (flag == 8) {
				tempArrayInfo = DataManager.fetchFieldValue(pool, desEncrypt
						.getDesString(tablename),
						"right(max(systemno)+1000001,6)", "");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			}

		} catch (Exception e) {
			;
		} finally {
			tempArrayInfo = null;
			desEncrypt = null;
		}
		return result;
	}

	/**
	 * 生成查询显示字符
	 * 
	 * @param pool
	 * @param catalogno
	 * @param factory
	 * @param find_value
	 * @param flag
	 *            1:表示配件信息
	 * @return
	 */
	public static String createDisplayFindstr(PoolManager pool,
			String catalogno, String factory, String find_value, int flag) {
		StringBuffer result = new StringBuffer("");
		try {
			if (flag == 1) {
				if (!catalogno.equals("") && catalogno.length() == 3) {
					result.append(Common.fetchName(pool, catalogno, "1"));
				}
				if (!factory.equals("0") && result.length() > 0) {
					result.append("," + Common.fetchName(pool, factory, "2"));

				} else if (!factory.equals("0") && result.length() == 0) {
					result.append(Common.fetchName(pool, factory, "2"));

				}
				if (!catalogno.equals("") && catalogno.length() == 6
						&& result.length() > 0) {
					result.append("," + Common.fetchName(pool, catalogno, "1"));

				} else if (!catalogno.equals("") && catalogno.length() == 6
						&& result.length() == 0) {
					result.append(Common.fetchName(pool, catalogno, "1"));

				}

				if (!find_value.equals("") && result.length() > 0) {
					result.append("," + find_value);

				} else if (!find_value.equals("") && result.length() == 0) {
					result.append(find_value);

				}
			}

		} catch (Exception e) {
			;
		} finally {
		}
		return result.toString();
	}

	/**
	 * 取类别名称id
	 * 
	 * @param pool
	 * @param tablename
	 * @param storeNo
	 * @return
	 */
	public static String fetchCatalogName(PoolManager pool, String code) {
		String result = "--全部配件--";
		String tempArrayInfo[][] = null;
		if (code != null || code == "0") {
			try {
				tempArrayInfo = DataManager.fetchFieldValue(pool,
						"parts_catalog", "name", " num='" + code + "'");
				if (tempArrayInfo != null && tempArrayInfo[0][0] != null) {
					result = tempArrayInfo[0][0];
				}
			} catch (Exception e) {
				;
			} finally {
				tempArrayInfo = null;
			}
		}
		return result;
	}

	/**
	 * 生成catalog_name,logs_field
	 * 
	 * @param pool
	 * @param tablename
	 * @return
	 */
	public static String[][] createCatalogField(PoolManager pool,
			String tablename, String catalogNo) {
		String tempArrayInfo[][] = null;
		try {
			tempArrayInfo = DataManager.fetchFieldValue(pool,
					"cmbol_columns_logs", " catalog_name,logs_field ",
					" logs_table='" + tablename + "' and catalog_no='"
							+ catalogNo + "'");
		} catch (Exception e) {
			;
		} finally {
			;
		}
		return tempArrayInfo;
	}

	/**
	 * 把数组用分隔符号关联起来、形成字符串
	 * 
	 * @param filter_fieldname
	 * @param fgf
	 * @return
	 */

	public static String join(String filter_fieldname[], String fgf) {
		StringBuffer result = new StringBuffer();
		try {
			if (filter_fieldname != null)
				for (int k = 0; k < filter_fieldname.length; k++)
					if (k == 0) {
						result.append(filter_fieldname[k]);

					} else {
						result.append(fgf + filter_fieldname[k]);

					}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			result = null;
		}
		return result.toString();
	}

	/**
	 * 判断字符串是否在数组中存在
	 * 
	 * @param field
	 * @param filter_fieldname
	 * @return
	 */
	public static boolean check_sz(String field, String filter_fieldname[]) {
		boolean result = false;
		if (filter_fieldname != null)
			for (int k = 0; k < filter_fieldname.length; k++)
				if (filter_fieldname[k].equals(field)) {
					result = true;
					break;
				}
		return result;
	}

	/**
	 * 主要用于字符串参数过滤处理
	 * 
	 * @param str
	 * @return
	 */
	public static String dofilter(String str) {
		String mystr = str;
		if (mystr == null) {
			mystr = "";

		}
		if (str != null) {
			if (str != null && str.indexOf("\"") >= 0) {
				mystr = str.replace("\"", "'");
				str = mystr;
			}
		}
		return mystr;
	}

	/**
	 * 生成下拉框的内容
	 * 
	 * @param pool
	 * @param tablename
	 * @param tj
	 * @param bs
	 * @param sel_value
	 * 
	 * @return �ַ�
	 */
	public static String option_str(PoolManager pool, String tablename,
			String filedname, String tj, String sel_value, int flag) {
		StringBuffer result = new StringBuffer();
		String arr_option[][] = null;
		String sel_str = "";
		try {
			arr_option = DataManager.fetchFieldValue(pool, tablename,
					filedname, tj);

			if (arr_option != null)
				for (int i = 0; i < arr_option.length; i++) {
					if (arr_option[i][0] != null
							&& arr_option[i][0].equals(sel_value)) {
						sel_str = "\" selected>";

					}

					else {
						sel_str = "\">";
					}
					// ====下拉树状显示====
					if (flag == 1) {
						result
								.append("<option value=\""
										+ arr_option[i][0]
										+ sel_str
										+ (createSpaces(arr_option[i][0]
												.length()) + arr_option[i][1])
										+ "</option>");
					}
					// ====专门控制配件类别下拉框的显示效果===
					else if (flag == 2) {
						result
								.append("<option value=\""
										+ arr_option[i][0]
										+ "\""
										+ (arr_option[i][0].length() == 3 ? " class=\"r1"
												: " class=\"r2") + sel_str
										+ arr_option[i][1] + "</option>");
					} else {
						result.append("<option value=\"" + arr_option[i][0]
								+ sel_str + arr_option[i][1] + "</option>");
					}

				}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			sel_str = null;
			arr_option = null;
		}
		return result.toString();
	}

	/**
	 * 生成空格
	 * 
	 * @param length
	 * @return
	 */
	public static String createSpaces(int length) {
		String result = "";
		for (int k = 0; k < length; k++)
			result = result + "&nbsp;&nbsp;";
		return result;

	}

	/**
	 * 根据编号取对应的名称
	 * 
	 * @param pool
	 * @param paraValue
	 * @param flag
	 *            1:取型号名称;2:品牌;3:地域;4:栏目名称
	 * 
	 * @return
	 */
	public static String fetchName(PoolManager pool, String paraValue,
			String flag) {
		String result = "";
		String tempArray[][] = null;
		try {
			paraValue = getFormatStr(paraValue);
			if (flag.equals("1")) {
				tempArray = DataManager.fetchFieldValue(pool, "parts_catalog",
						"name", " is_show=1 and num='" + paraValue + "'");
			} else if (flag.equals("2")) {
				tempArray = DataManager.fetchFieldValue(pool, "parts_factory",
						"name", " is_show=1 and id='" + paraValue + "'");
			} else if (flag.equals("3")) {
				tempArray = DataManager.fetchFieldValue(pool,
						"parts_datadictionary", "sort_name",
						" is_show=1 and flag=1 and id='" + paraValue + "'");
			} else if (flag.equals("4")) {
				tempArray = DataManager.fetchFieldValue(pool,
						"cmbol_columns_info", "catalog_name",
						" is_show=1 and catalog_no='" + paraValue + "'");
			}
			if (tempArray != null && tempArray[0][0] != null) {
				result = tempArray[0][0];

			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "";
		} finally {
			tempArray = null;
		}
		return result;
	}

	/**
	 * 算出信誉等级,是属于第几等。
	 * 
	 * @param pool
	 * @param paraValue
	 * @param flag
	 *            1:表示通用加星的评价,
	 * @return
	 */
	public static String creditValue(String paraValue, String flag) {
		String result = "0";
		double temp_paraValue = getFormatDouble(paraValue);
		try {
			if (flag.equals("1")) {
				if (temp_paraValue >= 10 && temp_paraValue <= 40) {
					result = "1";

				} else if (temp_paraValue >= 41 && temp_paraValue <= 150) {
					result = "2";

				} else if (temp_paraValue >= 151 && temp_paraValue <= 500) {
					result = "3";

				} else if (temp_paraValue >= 501 && temp_paraValue <= 1000) {
					result = "4";

				} else if (temp_paraValue >= 1001 && temp_paraValue <= 2000) {
					result = "5";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			;
		}
		return result;
	}

	/**
	 * 根据信誉等级,输出相应的等级表示物。
	 * 
	 * @param pool
	 * @param paraValue
	 * @param flag
	 *            1:表示通用加星的评价,
	 * @return
	 */
	public static String outCredit(String rank, int flag) {
		String result = "";
		double temp_rank = getFormatDouble(rank);
		try {
			if (flag == 1) {
				for (int i = 0; i < temp_rank; i++) {
					result += "<img src='/images/star.gif' border=0>";

				}
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			;
		}
		return result;
	}

	/**
	 * 关键词过滤处理
	 * 
	 * @param pool
	 * @param keywords
	 * @param flag
	 * @return
	 */
	public static String keyWordsFilter(PoolManager pool, String keywords,
			int flag) {
		keywords = getFormatStr(keywords);
		String result = keywords;
		String arrayKeyWords[][] = null;
		try {
			if (flag == 1) {
				arrayKeyWords = DataManager.fetchFieldValue(pool,
						"parts_words", "wordtext", " charindex(wordtext,'"
								+ keywords + "',0)>0");
				if (arrayKeyWords != null) {
					result = keywords.replace(
							getFormatStr(arrayKeyWords[0][0]), "");
				}

			}
		} catch (Exception e) {
		} finally {
			arrayKeyWords = null;
		}
		return result;
	}

	/**
	 * 把传入的字符对象经过去除前后空格、NULL，重新返回
	 * 
	 * @param str
	 * @return
	 */
	public static String getFormatStr(Object str) {
		String formatStr = "";
		if (str != null) {
			formatStr = str.toString().replace("'", "").replace("\\", "")
					.trim();
		}
		return formatStr;
	}

	/**
	 * 
	 * <p>
	 * 生成UUID编号
	 * </p>
	 * 
	 * @param tag
	 *            1:小写 2:大写 3:保持原样输出
	 * 
	 * @param style
	 *            1:去掉-符号 2:保持原样
	 * 
	 */

	public static String createUUID(int tag, int style) {
		String uuid = UUID.randomUUID().toString();
		if (uuid.length() > 0) {
			if (style == 1) {
				String uuidStr[] = uuid.split("-");
				uuid = "";
				for (int i = 0; i < uuidStr.length; i++) {
					uuid += uuidStr[i];
				}
			}
		}
		if (tag == 1) {
			return uuid;
		} else {
			return uuid.toUpperCase();
		}
	}

	/**
	 * 
	 * <p>
	 * 生成UUID编号
	 * </p>
	 * 
	 * @param tag
	 *            1:小写 2:大写
	 * 
	 */

	public static String createUUID(int tag) {
		String uuid = UUID.randomUUID().toString();
		if (uuid.length() > 0) {
			String uuidStr[] = uuid.split("-");
			uuid = "";
			for (int i = 0; i < uuidStr.length; i++) {
				uuid += uuidStr[i];
			}
		}
		if (tag == 1) {
			return uuid;
		} else {
			return uuid.toUpperCase();
		}
	}

	/***************************************************************************
	 * 
	 * <p>
	 * DES加密
	 * 
	 * @param expressly
	 * 
	 *            需要加密的字符
	 * 
	 * @return
	 * 
	 *         加密后的字符
	 * 
	 **************************************************************************/

	public static String encryptionByDES(String expressly) {
		try {
			JiaJieMi des = new JiaJieMi("21-sun");
			return des.encrypt(expressly);
		} catch (Exception e) {
			return "";
		}
	}

	/***************************************************************************
	 * 
	 * <p>
	 * DES解密
	 * 
	 * @param ciphertext
	 * 
	 *            已加密的字符
	 * 
	 * @return
	 * 
	 *         解密后的字符
	 * 
	 **************************************************************************/

	public static String decryptionByDES(String ciphertext) {
		try {
			JiaJieMi des = new JiaJieMi("21-sun");
			return des.decrypt(ciphertext);
		} catch (Exception e) {
			return "error";
		}
	}

	/**
	 * 单点登陆，获取会员信息
	 * 
	 * @param key
	 * @param pool
	 * @param request
	 * @return
	 */
	public static String getMemberInfo(String key, PoolManager pool,
			HttpServletRequest request, String tableStr, String memNoFiled,
			String passwFiled, String sessionName) {
		String valu = "";
		HashMap memberInfo = (HashMap) (request.getSession())
				.getAttribute(sessionName);
		if (memberInfo == null) {
			String memNo = Common.getFormatStr(Common.decryptionByDES(Common
					.getCookies(request, "cookieMemNo")));
			String passw = Common.getFormatStr(Common.decryptionByDES(Common
					.getCookies(request, "cookiePassw")));
			String crDate = Common.getFormatStr(Common.decryptionByDES(Common
					.getCookies(request, "cookieCreatTime")));
			if (!memNo.equals("") && !passw.equals("")) {
				String querySql = "select * from " + tableStr + " where "
						+ memNoFiled + "=? and " + passwFiled + "=?";
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				ResultSetMetaData rsmd = null;
				try {
					conn = pool.getConnection();
					pstmt = conn.prepareStatement(querySql);
					pstmt.setString(1, memNo);
					pstmt.setString(2, passw);
					rs = pstmt.executeQuery();
					if (rs != null && rs.next()) {
						memberInfo = new HashMap();
						rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							memberInfo.put(rsmd.getColumnName(i), rs
									.getString(rsmd.getColumnName(i)));
						}
						request.getSession().setAttribute(sessionName,
								memberInfo);
						valu = Common.getFormatStr(memberInfo.get(key));
					} else {
						valu = "-8888";
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(conn);
				}
			} else {
				valu = "-9999";
			}
		} else {
			valu = Common.getFormatStr(memberInfo.get(key));
		}
		return valu;
	}

	/**
	 * 单点登陆，获取会员多个信息list数据
	 * 
	 * @param key
	 * @param pool
	 * @param request
	 * @return
	 */
	public static ArrayList getMemberInfoList(String key, PoolManager pool,
			HttpServletRequest request, String tableStr, String memNoFiled,
			String passwFiled, String sessionName) {
		ArrayList valu = new ArrayList();

		String tempInfo[] = null;
		HashMap memberInfo = (HashMap) (request.getSession())
				.getAttribute(sessionName);

		if (memberInfo == null) {
			String memNo = Common.getFormatStr(Common.decryptionByDES(Common
					.getCookies(request, "cookieMemNo")));
			String passw = Common.getFormatStr(Common.decryptionByDES(Common
					.getCookies(request, "cookiePassw")));
			String crDate = Common.getFormatStr(Common.decryptionByDES(Common
					.getCookies(request, "cookieCreatTime")));
			if (!memNo.equals("") && !passw.equals("")) {
				String querySql = "select * from " + tableStr + " where "
						+ memNoFiled + "=? and " + passwFiled + "=?";

				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				ResultSetMetaData rsmd = null;
				try {
					conn = pool.getConnection();
					pstmt = conn.prepareStatement(querySql);
					pstmt.setString(1, memNo);
					pstmt.setString(2, passw);

					rs = pstmt.executeQuery();
					if (rs != null && rs.next()) {
						memberInfo = new HashMap();
						rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							memberInfo.put(rsmd.getColumnName(i), rs
									.getString(rsmd.getColumnName(i)));
						}
						request.getSession().setAttribute(sessionName,
								memberInfo);

						if (key != null) {
							tempInfo = key.split(",");
							for (int k = 0; tempInfo != null
									&& k < tempInfo.length; k++)
								valu.add(Common.getFormatStr(memberInfo
										.get(tempInfo[k])));

						}
						// valu = Common.getFormatStr(memberInfo.get(key));
					} else {
						valu.add("-8888");
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(conn);
				}
			} else {
				valu.add("-9999");
			}
		} else {
			if (key != null) {
				tempInfo = key.split(",");
				for (int k = 0; tempInfo != null && k < tempInfo.length; k++)
					valu.add(Common.getFormatStr(memberInfo.get(tempInfo[k])));
			}
		}
		return valu;
	}

	public static String getAddressForIp(HttpServletRequest request, String ip,
			int flag) {
		try {
			IPParser w = new IPParser(request.getRealPath("") + "/QQWry.Dat");
			w.seek(ip);
			String city = Common.getFormatStr(w.getCountry());
			String address = Common.getFormatStr(w.getLocal());
			if (flag == 1) {
				return city;
			} else {
				return address;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	public static String getCategory(String category_flag) {
		category_flag = Common.getFormatStr(category_flag);
		String category_str = "";
		if (category_flag.equals("1")) {
			category_str = "挖掘机";
		} else if (category_flag.equals("2")) {
			category_str = "装载机";
		} else if (category_flag.equals("3")) {
			category_str = "起重机";
		} else if (category_flag.equals("4")) {
			category_str = "压路机";
		} else if (category_flag.equals("5")) {
			category_str = "推土机";
		} else if (category_flag.equals("6")) {
			category_str = "摊铺机";
		} else if (category_flag.equals("7")) {
			category_str = "平地机";
		} else if (category_flag.equals("8")) {
			category_str = "混凝土";
		} else if (category_flag.equals("9")) {
			category_str = "叉车";
		} else if (category_flag.equals("other")) {
			category_str = "其他设备";
		}
		return category_str;
	}

	/**
	 * 
	 * @param request
	 * @param flag
	 *            0:表示apache或者其它做主服务器;1:表示nginx做主服务.
	 * @return
	 */
	public static String getRemoteAddr(HttpServletRequest request, int flag) {
		String result = "";
		int port = 80;
		try {
			port = request.getServerPort();
			if (flag == 1) {
				if (port == 80)
					result = request.getHeader("X-Real-IP");
				else
					result = request.getRemoteAddr();
			} else {
				result = request.getRemoteAddr();
			}

		} catch (Exception e) {
			;
		} finally {
			return result;
		}
	}

	/**
	 * 根据传入的格式，返回当前日期
	 * 
	 * @param format
	 * @return
	 */
	public static String getToday(String format) {
		String today = "";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date now = new Date();
		today = sdf.format(now);
		return today;
	}

	/**
	 * 执行POST请求(维持session)
	 * 
	 * @param url
	 *            要请求的地址
	 * @param params
	 *            参数
	 * @return 返回请求地址结果
	 * @throws HttpException
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public synchronized static String doPost(String url, Map params, Cookie[] cookies) throws Exception, IOException {
		HttpClient httpClient = new HttpClient();
		String result = "fail";
		PostMethod postMethod = new UTF8PostMethod(url);
		String cookieStr = "";
		if (null != cookies) {
			for (Cookie cookie : cookies) {
				cookieStr += cookie.getName() + "=" + cookie.getValue() + ";";
			}
		}
		if (null != params && params.size() > 0) {
			Object value = null;
			for (Object key : params.keySet()) {
				value = params.get(key);
				if (null == value) {
					continue;
				}
				if (value instanceof String[]) {
					value = ((String[]) value)[0];
				} else if (value instanceof String) {
					value = (String) value;
				}
				postMethod.addParameter(new NameValuePair(Common.getFormatStr(key), Common.getFormatStr(value)));
			}
		}
		if (!"".equals(cookieStr)) {
			postMethod.setRequestHeader("cookie", cookieStr);

		}
		int statusCode = httpClient.executeMethod(postMethod);
		if (statusCode == HttpStatus.SC_MOVED_PERMANENTLY || statusCode == HttpStatus.SC_MOVED_TEMPORARILY) {
			result = "ok";
		}
		result = new String(postMethod.getResponseBody(), "UTF-8");
		return result;
	}

	/**
	 * 执行POST请求
	 * 
	 * @param url
	 *            要请求的地址
	 * @param params
	 *            参数
	 * @return 返回请求地址结果
	 * @throws HttpException
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public synchronized static String doPost(String url, Map params) throws Exception, IOException {
		return doPost(url, params, null);
	}

	/**
	 * 异步 POST请求
	 * 
	 * @param url
	 *            要请求的地址
	 * @param params
	 *            参数
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void doPostHttpAsync(String url, Map params) throws Exception {
		doPostHttpAsync(url, params, null);
	}

	/**
	 * 异步 POST请求(维持session)
	 * 
	 * @param url
	 *            要请求的地址
	 * @param params
	 *            参数
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void doPostHttpAsync(String url, Map params, Cookie[] cookies) throws Exception {
		Async async = new Async(url, params, cookies);
		async.start();
	}
	public static String getIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 获取IP
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("finally")
	public static String getIp(HttpServletRequest request, int flag) {
		String result = "";
		int port = 80;
		try {
			port = request.getServerPort();
			if (flag == 1) {
				if (port == 80)
					result = request.getHeader("X-Real-IP");
				else
					result = request.getRemoteAddr();
			} else {
				result = request.getRemoteAddr();
			}

		} catch (Exception e) {
			;
		} finally {
			return result;
		}
	}
	public static void main(String[] args) {
		System.out.print(getRandom(4)+"--") ;
		// StringSpliter.fun1("我ABC", 4);
		// String title = "斗山-HBT60C-1413D3";
		// System.out.println(getSingleSpell(title));
		// System.out.println(getFullSpell(title));
		// String tp="现代ROB";
		// char[] test = tp.toCharArray();
		// System.out.println(test.length);
		//		
		// String str2= "啊啊啊abc";
		// byte b2[]=str2.getBytes();
		// System.out.println(b2.length);
		// System.out.println(Common.substringByte("中联重科ZLJ5294THB125-37", 20));
		// System.out.println(Common.substringByte(title, 20));
		// String test="<p>adfsadf</p>";
		// System.out.println(test.substring(3));
		// System.out.println(test.substring(0,3));
		// System.out.println(test.substring(test.length()-4, test.length()));
		// System.out.println(test.substring(0,test.length()-4));
		// String str=java.net.URLEncoder.encode("中华人民共和国");
		// str=java.net.URLDecoder.decode("%B2%BB%B6%FE%D4%BD%CF%B5%C1%D0");
		// System.out.println("str:==="+str);
		// System.out.println(Common.getFormatDouble("500.345"));
		// System.out.println(Common.getFormatDouble("500.333"));
		// Random rad = new Random();
		// for(int c=0;c<=4;c++)
		// System.out.println(Math.abs(rad.nextInt(20) + 1));
		// System.out.println(new Random().nextInt(1000));
		// System.out.println(getFormatInt("-1.2"));

		/*
		 * double a = Math.random()*10; a = Math.ceil(a); int randomNum = new
		 * Double(a).intValue(); System.out.println(randomNum);
		 */

	}
	
	/**
	 * 获取供求COOKIE
	 * 
	 * @param request
	 * @return
	 */
	public static int getMarketCookie(HttpServletRequest requst,String MemNo) {
		int returnInt = 0;
		Cookie cookies[] = requst.getCookies() ;
        Cookie c1 = null ;
        if(cookies != null){
            for(int i=0;i<cookies.length;i++){
              c1 = cookies[i] ;
               if(c1.getName().equals("userSellCount_"+MemNo)){
    			   String cStr =   c1.getValue();
    			   try {
    				   returnInt = Integer.parseInt(cStr);
					} catch (Exception e) {
						returnInt = 0;
					}        			   
            	   break;
               }
            }
        }
	return returnInt;
	}
	/**
	 * 更新供求COOKIE
	 * 
	 * @param id
	 * @param count
	 * @return
	 */
	public static String setMarketCookie(HttpServletResponse response,String memNo,int count) {
		String returnString = "ok";
		Cookie cookie = new Cookie("userSellCount_"+memNo, count+"");
		int cookieTime = 3600;//默认1小时
		//计算cookie失效日期-一天有效期（第二天0点0分0秒失效）
		SimpleDateFormat sf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sf2 = new SimpleDateFormat("yyyy-MM-dd");
		String  nowdatestr = sf1.format(new Date());
		String  todaydatestr = sf2.format(new Date());
		int c = 0;
		try {
			Date nowdate = sf1.parse(nowdatestr);
			Date todaydate = sf2.parse(todaydatestr);
			long a = nowdate.getTime();
			long b = todaydate.getTime();
			c = (int)((a - b) / 1000);
		} catch (Exception e) {
			// TODO: handle exception
		}
		//out.println("c:"+c);
		cookieTime = 86400-c;
		//System.out.println("userSellCount_"+memNo+":"+count);
		//System.out.println("cookieTime:"+cookieTime);
		cookie.setMaxAge(cookieTime);
		response.addCookie(cookie);
		return returnString;
	}
}
