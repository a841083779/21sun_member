var divSelectObjs = {};
var popDivObjs = {};
var valueChangeCallback = {};
valueChangeCallback['search_form'] = {};
var searchCondOptions = {
	'hot_location': [11, 31, 4401, 4403, 5101, 50],
	'tag': {},
	'auto': {
		"1": "\u6682\u672a\u8d2d\u8f66",
		"2": "\u5df2\u7ecf\u8d2d\u8f66"
	}
};
var searchCondDefaultValue = {};
searchCondDefaultValue['search_form'] = {
	'sex': 'f',
	'min_age': 0,
	'max_age': 0,
	'work_location': 0,
	'work_sublocation': 0,
	'avatar': 0,
	'min_height': 0,
	'max_height': 0,
	'house': 0,
	'income': 0,
	'income_more_than': 0,
	'education': 0,
	'edu_more_than': 0,
	'marriage': 0,
	'children': 0,
	'level': 0,
	'industry': 0,
	'company': 0,
	'auto': 0,
	'nation': 0,
	'belief': 0,
	'ques_love': 0,
	'bloodtype': 0,
	'home_location': 0,
	'home_sublocation': 0,
	'love_location': 0,
	'love_sublocation': 0,
	'tag': 0,
	'animal': 0,
	'astro': 0,
	'online': 0
};
function get_select_value(formId, name) {
	name = formId + '_' + name;
	var hiddenId = "cond_" + name + "_input";
	var value = JY.$(hiddenId).value;
	alert(value ? value: 0);
}
function set_location_value(formId, type, value, noShow) {
	if (typeof noShow == 'undefined') {
		noShow = false;
	}
	var name2 = formId + '_' + type;
	var oldValue = JY.$('cond_' + name2 + '_location_input').value;
	JY.$('cond_' + name2 + '_location_input').value = value;
	set_sublocation_value(formId, type, value * 100);
	hide_location_div(formId, type);
	if (!noShow && !popDivObjs[formId][type + '_location'].notShowSubLoc) {
		show_sublocation_div(formId, type);
	}
	create_sublocation_options(formId, type, value);
	show_location_cond(formId, type);
	if (typeof valueChangeCallback[formId][type + '_location_loc'] == 'function') {
		valueChangeCallback[formId][type + '_location_loc'](formId, type + '_location', LSK[value], value, oldValue);
	}
}
function set_sublocation_value(formId, type, value) {
	var name2 = formId + '_' + type;
	var oldValue = JY.$('cond_' + name2 + '_sublocation_input').value;
	JY.$('cond_' + name2 + '_sublocation_input').value = value;
	hide_location_div(formId, type);
	hide_sublocation_div(formId, type);
	show_location_cond(formId, type);
	if (typeof valueChangeCallback[formId][type + '_location_subloc'] == 'function') {
		valueChangeCallback[formId][type + '_location_subloc'](formId, type + '_location', '' + value + '', value, oldValue);
	}
}
function show_location_div(formId, type) {
	var name2 = formId + '_' + type;
	var jqDiv = JQ('#' + name2 + '_location_select_div');
	var jqPDiv = jqDiv.parent('div');
	if (jqPDiv.length > 0) {
		jqPDiv.css('zIndex', 10000);
	}
	jqDiv.fadeIn("fast");
	popDivObjs[formId][type + '_location'].isShow = true;
}
function hide_location_div(formId, type) {
	var name2 = formId + '_' + type;
	var jqDiv = JQ('#' + name2 + '_location_select_div');
	var jqPDiv = jqDiv.parent('div');
	if (jqPDiv.length > 0) {
		jqPDiv.css('zIndex', 0);
	}
	jqDiv.fadeOut("fast");
	popDivObjs[formId][type + '_location'].isShow = false;
}
function show_sublocation_div(formId, type) {
	var name2 = formId + '_' + type;
	var jqDiv = JQ('#' + name2 + '_sublocation_select_div');
	var jqPDiv = jqDiv.parent('div');
	if (jqPDiv.length > 0) {
		jqPDiv.css('zIndex', 10000);
	}
	jqDiv.fadeIn("slow");
	popDivObjs[formId][type + '_location'].isShow = true;
}
function hide_sublocation_div(formId, type) {
	var name2 = formId + '_' + type;
	var jqDiv = JQ('#' + name2 + '_sublocation_select_div');
	var jqPDiv = jqDiv.parent('div');
	if (jqPDiv.length > 0) {
		jqPDiv.css('zIndex', 0);
	}
	jqDiv.fadeOut("fast");
}
function create_sublocation_options(formId, type, value) {
	if (!LSK[value]) {
		hide_sublocation_div(formId, type);
		return;
	}
	if (LOK[value].length <= 2) {
		hide_sublocation_div(formId, type);
		return;
	}
	var name2 = formId + '_' + type;
	JY.$(name2 + '_sublocation_select_title').innerHTML = LSK[value];
	var options = [];
	for (var i in LOK[value]) {
		if (i % 100 == 0) continue;
		options.push('<a href="javascript:set_sublocation_value(\'' + formId + '\',\'' + type + '\',' + i + ')">' + LOK[value][i] + '</a>');
	}
	JY.$(name2 + '_sublocation_select_options').innerHTML = options.join('');
}
function switch_location_div_show(formId, type) {
	var name2 = formId + '_' + type;
	if (JY.$(name2 + '_sublocation_select_div').style.display != 'none') {
		hide_sublocation_div(type);
	}
	if (JY.$(name2 + '_location_select_div').style.display == 'none') {
		show_location_div(formId, type);
	} else {
		hide_location_div(formId, type);
	}
}
function show_location_cond(formId, type) {
	var name2 = formId + '_' + type;
	var loc = JY.$('cond_' + name2 + '_location_input').value;
	var subloc = JY.$('cond_' + name2 + '_sublocation_input').value,
	show;
	if (subloc != 0) {
		loc = Math.floor(subloc / 100);
	}
	if (loc == 0) {
		show = '';
	} else {
		show = LSK[loc];
		document.getElementById("zd_province").value = show;
	}
	if (subloc != 0 && subloc % 100 != 0) {
		show += LOK[loc][subloc];
		document.getElementById("zd_city").value = LOK[loc][subloc];
	}
	JY.$('cond_' + name2 + '_location_show').innerHTML = show;
}
function build_location_div(formId, type, hasHotCity) {
	var html = [],
	name2 = formId + '_' + type;
	html.push('<em id="cond_' + name2 + '_location_show" onclick="switch_location_div_show(\'' + formId + '\',\'' + type + '\')">不限</em>');
	html.push('<span class="select_img" onclick="switch_location_div_show(\'' + formId + '\',\'' + type + '\')"></span>');
	html.push('<div class="hov_box city_hov" style="width:310px;display:none;z-index:10000" id="' + name2 + '_location_select_div">');
	if (hasHotCity) {
		html.push(' <div class="cityclear"><span style="text-align:left">热门城市</span><a href="javascript:hide_location_div(\'' + formId + '\',\'' + type + '\')" class="close_btn"></a></div>');
		html.push(' <div class="s_city">');
		var hotCityHtml = [],
		no;
		for (var i in searchCondOptions['hot_location']) {
			no = searchCondOptions['hot_location'][i];
			if (no > 100) {
				html.push('<a href="javascript:set_sublocation_value(\'' + formId + '\',\'' + type + '\',' + no + ')">' + LOK[Math.floor(no / 100)][no] + '</a>');
			} else {
				html.push('<a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',' + no + ')">' + LSK[no] + '</a>');
			}
		}
		html.push(' </div>');
	} else {
		html.push(' <div class="cityclear"><span style="text-align:left"></span><a href="javascript:hide_location_div(\'' + formId + '\',\'' + type + '\')" class="close_btn"></a></div>');
	}
	html.push(' <div class="shengfen">');
	html.push('  <span style="text-align:left">选择省份</span><br />');
	//html.push('  <a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',0)"></a><br />');
	html.push('  <strong>A-	B-C-F-G</strong><br />');
	html.push('  <a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',34)">安徽</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',11)">北京</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',50)">重庆</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',35)">福建</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',62)">甘肃</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',44)">广东</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',45)">广西</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',52)">贵州</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',82)">澳门</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',99)">国外</a><br />');
	html.push('  <strong>H-J</strong><br />');
	html.push('  <a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',46)">海南</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',13)">河北</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',41)">河南</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',23)">黑龙江</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',42)">湖北</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',43)">湖南</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',22)">吉林</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',32)">江苏</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',36)">江西</a><br />');
	html.push('  <strong>L-N-Q-S</strong><br />');
	html.push('  <a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',21)">辽宁</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',15)">内蒙古</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',64)">宁夏</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',63)">青海</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',37)">山东</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',14)">山西</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',61)">陕西</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',31)">上海</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',51)">四川</a><br />');
	html.push('  <strong>T-X-Y-Z</strong><br />');
	html.push('  <a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',71)">台湾</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',12)">天津</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',54)">西藏</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',81)">香港</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',65)">新疆</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',53)">云南</a><a href="javascript:set_location_value(\'' + formId + '\',\'' + type + '\',33)">浙江</a>');
	html.push(' </div>');
	html.push(' <input type="hidden" name="' + type + '_location" id="cond_' + name2 + '_location_input" value=""/>');
	html.push('</div>');
	html.push('');
	html.push('<div class="hov_box city_hov" style="display:none;z-index:10000" id="' + name2 + '_sublocation_select_div">');
	html.push(' <div class="cityclear shengfen"><div class="f_l"><strong id="' + name2 + '_sublocation_select_title">北京</strong>&nbsp;<a href="javascript:hide_sublocation_div(\'' + formId + '\',\'' + type + '\');show_location_div(\'' + formId + '\',\'' + type + '\');" style="color:#0066cb;">返回其它省市</a></div><a href="javascript:hide_sublocation_div(\'' + formId + '\',\'' + type + '\')" class="close_btn"></a></div>');
	html.push(' <div class="shengfen" id="' + name2 + '_sublocation_select_options"></div>');
	html.push(' <input type="hidden" name="' + type + '_sublocation" id="cond_' + name2 + '_sublocation_input" value=""/>');
	html.push('</div>');
	document.write(html.join("\n"));
}
function LocationSelect(formId, type) {
	this.formId = formId;
	this.type = type;
	this.name = type + '_location';
	this.isShow = false;
	this.notShowSubLoc = false;
	this.hasHotCity = true;
	this.build = function() {
		build_location_div(this.formId, type, this.hasHotCity);
		if (typeof popDivObjs[this.formId] == 'undefined') {
			popDivObjs[this.formId] = {};
		}
		popDivObjs[this.formId][type + '_location'] = this;
		set_location_value(this.formId, type, searchCondDefaultValue[this.formId][type + '_location'], true);
		set_sublocation_value(this.formId, type, searchCondDefaultValue[this.formId][type + '_sublocation'], true);
	}
	this.show = function() {
		show_location_div(this.formId, this.type);
	}
	this.hide = function() {
		hide_location_div(this.formId, this.type);
		hide_sublocation_div(this.formId, this.type);
	}
	this.getLocationValue = function() {
		var name2 = formId + '_' + type;
		return JY.$('cond_' + name2 + '_location_input').value;
	}
	this.getSubLocationValue = function() {
		var name2 = formId + '_' + type;
		return JY.$('cond_' + name2 + '_sublocation_input').value;
	}
	this.onLocationChange = function(callback) {
		if (typeof callback == 'function') {
			if (typeof valueChangeCallback[this.formId] == 'undefined') {
				valueChangeCallback[this.formId] = {};
			}
			valueChangeCallback[this.formId][this.name + '_loc'] = callback;
		}
	}
	this.onSubLocationChange = function(callback) {
		if (typeof callback == 'function') {
			if (typeof valueChangeCallback[this.formId] == 'undefined') {
				valueChangeCallback[this.formId] = {};
			}
			valueChangeCallback[this.formId][this.name + '_subloc'] = callback;
		}
	}
}