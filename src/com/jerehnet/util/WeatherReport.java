package com.jerehnet.util;

public class WeatherReport {

	/**
	 * 使用 google 查询天气<br/> 上海:
	 * http://www.google.com/ig/api?hl=zh_cn&weather=shanghai
	 * 
	 * @param city
	 *            城市拼音, 如 北京: beijing
	 */
	public static String getweather(String city) {
		city = PinYinUtil.getPinYin(city);
		StringBuilder sbd = new StringBuilder();
		try {
			String ur = "http://www.google.com/ig/api?hl=zh_cn&weather=";
			java.net.URL url = new java.net.URL(ur + city);
			java.io.InputStream in = url.openStream();

			String st = "";
			// 将流转换为 文本. 此一过程是为了解决乱码问题
			java.io.ByteArrayOutputStream bos = new java.io.ByteArrayOutputStream();
			int i = -1;
			while ((i = in.read()) != -1)
				bos.write(i);

			// 转换编码为 GB18030, 否则会乱码
			st = bos.toString().replace("<?xml version=\"1.0\"?>", "<?xml version=\"1.0\" encoding=\"GB18030\"?>");

			// 将文本转换成流
			java.io.InputStream inp = new java.io.ByteArrayInputStream(st.getBytes());

			// 读取流
			org.w3c.dom.Document doc = javax.xml.parsers.DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inp);

			// 日期
			org.w3c.dom.NodeList n1 = doc.getElementsByTagName("forecast_information").item(0).getChildNodes();
			// 城市:
			// sbd.append(n1.item(4).getAttributes().item(0).getNodeValue()).append("
			// ").append(city).append(" : ");

			// 天气, 最高气温 最低气温
			org.w3c.dom.NodeList n2 = doc.getElementsByTagName("forecast_conditions").item(0).getChildNodes();
			sbd.append(n2.item(4).getAttributes().item(0).getNodeValue()).append(",").append(
					n2.item(1).getAttributes().item(0).getNodeValue()).append(",")
					.append(n2.item(2).getAttributes().item(0).getNodeValue()).append(",");
			sbd.append(n2.item(3).getAttributes().item(0).getNodeValue());

			// sbd.append(n2.item(3).getAttributes().item(1).getNodeValue());

		} catch (Exception e) {
			sbd.append("获取天气失败或不存在此城市");
		}
		return sbd.toString();
	}

	public static void main(String[] args) {
		System.out.println("烟台天气: " + WeatherReport.getweather("yantai"));
		System.out.println(PinYinUtil.getPinYin("烟台"));
	}
}