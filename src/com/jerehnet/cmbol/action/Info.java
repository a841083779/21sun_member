package com.jerehnet.cmbol.action;

import java.util.ArrayList;

public class Info {

	private String id;// ID
	private String name;// 名称
	private String catalogNo;// 类别编号
	private String catalogName;// 类别名称
	private String pic;// 图片
	private String logo;// 标志
	private String price;// 价格
	private String pubDate;// 发布日期
	private String filename;// 文件名
	private String url;// 链接地址
	private String remark;// 备注
	private ArrayList subInfo;// 子集合
	private ArrayList subInfo2;// 子集合
	private String title;// 标题
	private String summary;
	private String subdirection;//
	private int count;// 点击率
	private String factoryName;// 厂商名称
	private String source;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getPubDate() {
		return pubDate;
	}

	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public ArrayList getSubInfo() {
		return subInfo;
	}

	public void setSubInfo(ArrayList subInfo) {
		this.subInfo = subInfo;
	}

	public ArrayList getSubInfo2() {
		return subInfo2;
	}

	public void setSubInfo2(ArrayList subInfo2) {
		this.subInfo2 = subInfo2;
	}

	public String getCatalogNo() {
		return catalogNo;
	}

	public void setCatalogNo(String catalogNo) {
		this.catalogNo = catalogNo;
	}

	public String getCatalogName() {
		return catalogName;
	}

	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubdirection() {
		return subdirection;
	}

	public void setSubdirection(String subdirection) {
		this.subdirection = subdirection;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getFactoryName() {
		return factoryName;
	}

	public void setFactoryName(String factoryName) {
		this.factoryName = factoryName;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

}
