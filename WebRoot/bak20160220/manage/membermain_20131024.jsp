<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file="/manage/config.jsp"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache"%><%
	HashMap memberInfo = (HashMap) session.getAttribute("memberInfo");
	String sessionMemNo = ((String) memberInfo.get("mem_no")); //   获得用户的登陆id 
	String is_shop = Common.getFormatStr(memberInfo.get("is_shop"));

	String countsellandbuy_tj = "mem_no = '" + sessionMemNo + "'";
	String[][] countsellandbuy = null;
	String countsellandbuy_tablename = "sell_buy_market";
	PoolManager pool5 = new PoolManager(5);

	String addflag = Common.getFormatStr(request.getParameter("addflag")); //栏目的编号
	String tempAddFlag = addflag ;
	if (null != addflag && ("5".equals(addflag) || "6".equals(addflag))) {//如果是二手，跳转
		response.sendRedirect("/manage/used.jsp");
		return ;
	}
	String keyPar = sessionMemNo + "--"
			+ ((String) memberInfo.get("passw")) + "--"
			+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
	//====跳转至供求====
	String showFlag = "";
	showFlag = addflag;
	if ("61".equals(showFlag) || "0".equals(showFlag)) // 首页默认是我要卖
	{
		showFlag = "1";
	}
	// 1 - 我要卖 7 - 我要买 27-我的供求 在同一级目录下
	if (addflag.equals("0") || addflag.equals("")
			|| addflag.equals("1") || addflag.equals("7")
			|| addflag.equals("27") || addflag.equals("33") || addflag.equals("71") || addflag.equals("72")) {
		addflag = "61";
	}
	// 配件栏目
	if (addflag.equals("8") || addflag.equals("2")
			|| addflag.equals("3")) {
		// addflag = "64" ;
	}
	// 配件首页默认是发布供应
	if (addflag.equals("64")) {
		addflag = "2";
	}
	//二手
	if (addflag.equals("62")) {
		addflag = "28";
	}
	//租赁
	if (addflag.equals("63")) {
		addflag = "95";
	}
	//====如果是个人知道中心，直接跳转====
	if (addflag.equals("211"))
		response
				.sendRedirect("/manage/memberinfo_new.jsp?controlflag=2&addflag=0");
	//=====================
	String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
	String cacheName = "membermain_61_" + mem_flag; // 缓存名字
	// add_flag 1  61 跳到同一个页面
	//   --------------------------缓存--------------
	if (pool == null) {
		pool = new PoolManager();
	}
	Connection conn = null;
	try {
		countsellandbuy = DataManager.fetchFieldOneValue(pool5,
				countsellandbuy_tablename, "count(*)",
				countsellandbuy_tj); // 查询出会员发出卖买的数量
		ResultSet rs = null;
		String tempPurviewNum1 = ""; //编号
		String tempPurviewShowName = "";
		String tempSubPurviewNum1 = ""; //子编号
		String tempSiteFlag1 = ""; //站点编号
		String tempPurviewName1 = ""; //父栏目的名称 

		String[][] tempPurviewAddflag = null;

		if (!addflag.equals("")) { //
			tempPurviewAddflag = DataManager.fetchFieldValue(pool, 
					"member_purview_new",
					"purview_num,site_flag,purview_name", " add_flag='"
							+ addflag + "' and flag = 1 ");
			if (tempPurviewAddflag != null) { 
				tempPurviewNum1 = Common
						.getFormatInt(tempPurviewAddflag[0][0]); //编号
				tempPurviewName1 = Common
						.getFormatStr(tempPurviewAddflag[0][2]);

				if (tempPurviewNum1.length() > 4) {//当是子栏目时，需要查询出其对应的父栏目
					tempPurviewNum1 = Common.getFormatInt(
							tempPurviewAddflag[0][0]).substring(0, 4);
					tempSubPurviewNum1 = Common
							.getFormatInt(tempPurviewAddflag[0][0]);
				} else {
					tempPurviewName1 = Common
							.getFormatStr(tempPurviewAddflag[0][2]);
					tempPurviewShowName = Common
							.getFormatStr(tempPurviewAddflag[0][2]);
					if (!tempPurviewName1.equals("")) {
						tempPurviewName1 = Common
								.encryptionByDES(tempPurviewName1);
					}
				}
				tempSiteFlag1 = Common
						.getFormatInt(tempPurviewAddflag[0][1]);
			}
		}
		String helpPage = "";
		if (tempSiteFlag1.equals("22")) {
			helpPage = "usedhelp.jsp";
		} else if (tempSiteFlag1.equals("23")) {
			helpPage = "partshelp.jsp";
		} else if (tempSiteFlag1.equals("24")) {
			helpPage = "renthelp.jsp";
		} else if (tempSiteFlag1.equals("27")) {
			helpPage = "fittingshelp.jsp";
		}

		String[][] tempSubMemberPurview = null; //查询子栏目

		//=====左侧菜单子目录,增加租赁站点判断条件===
		String tempPurviewSearch = "and purview_num like '"
				+ tempPurviewNum1 + "%' ";
		if (tempPurviewNum1.equals("6003")
				|| tempPurviewNum1.equals("6008"))
			tempPurviewSearch = "and (purview_num like '6003%' or purview_num like '6008%') ";

		tempSubMemberPurview = DataManager
				.fetchFieldValue(
						pool,
						"member_purview_new",
						"purview_num,purview_name,purview_url,add_flag,site_flag",
						" site_flag='"
								+ tempSiteFlag1
								+ "'  and flag = 1  and len(purview_num)>4 "
								//+ "'  and len(purview_num)>4 "
								+ tempPurviewSearch
								+ " order by orderby asc");
		//======

		String iframeFilename = ""; //登录页面

		String[][] tempMemberFlagPurview = null;
		List<String> alMemberFlagPurview = new ArrayList<String>(); //查询当前用户的权限。

		tempMemberFlagPurview = DataManager.fetchFieldValue(pool,
				"member_role_purview_new", "purview_num", "role_num='"
						+ mem_flag + "'");
		if (tempMemberFlagPurview != null) {
			for (int i = 0; i < tempMemberFlagPurview.length; i++) {
				alMemberFlagPurview.add(Common
						.getFormatStr(tempMemberFlagPurview[i][0]));
			}
		}

	int num = (int)((Math.random()*9+1)*100000);
	if(Common.getFormatStr(memberInfo.get("randNum")).equals("")){
		memberInfo.put("randNum",num);
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的商贸网 - 中国工程机械商贸网</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="../style/style_new.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="cpfl-menu.js"></script>
<script src="../scripts/scripts.js" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox/Skins/Blue/jbox.css"/>  
<style type="text/css">
#winpop { width: 380px; height: 0px; position: absolute; right: 0; bottom: 0; border: 0px solid #666; margin: 0; padding: 1px; overflow: hidden; display: none; padding-right: 50px }
#winpop .title { width: 100%; height: 22px; line-height: 20px; background: #d1d1d1; font-weight: bold; text-align: center; font-size: 12px; }
#winpop .con { width: 100%; height: 350px; line-height: 80px; font-weight: bold; font-size: 12px; color: #FF0000; text-decoration: underline; text-align: center }
.close { position: absolute; right: 4px; top: -1px; color: #FFF; cursor: pointer }
</style>
<style type="text/css">
* { margin:0px; padding:0px;}
/*新公告*/
.t_ggBtn { position:fixed; right:0px; top:100px; z-index:999;display:none;}
.t_ggBtn img { cursor:pointer;}
.t_ggcoverbg { display:block; position:fixed; width:100%; height:100%; left:0px; top:0px; background-color:#000; filter:alpha(opacity=35); opacity:0.35; z-index:1000;}
.t_gglayer { display:block; position:fixed; width:750px; height:494px; left:50%; top:50%; margin-left:-375px; margin-top:-247px; background:url(/images/tz_layer.png) no-repeat; _background-image:url(/images/tz_layer.gif); z-index:1001; font-size:12px; cursor:default;}
.t_gglayer .t_title { width:100%; height:40px; line-height:38px; margin-bottom:12px; padding-top:7px;}
.t_gglayer .t_title h2 { width:auto; float:left; font-size:16px; font-weight:bold; padding-left:20px;}
.t_gglayer .t_title span.t_close { width:25px; height:23px; float:right; margin:9px 17px 0px 0px; _display:inline; cursor:pointer;}
.t_gglayer .t_content { width:100%; height:430px; overflow-x:hidden; overflow-y:auto; word-break:break-all; line-height:24px; color:#000; margin:0 auto; clear:both;}
.t_textInfo { width:700px; height:355px; margin:0px auto; font:100 14px/24px 微软雅黑; color:#5a5a5a; padding-top:20px;}
.t_textInfo p { margin-bottom:15px;}
.t_textInfo strong.t_red { font-size:18px; font-weight:bold; color:#d70004;}
.t_textInfo em { font-style:italic; text-decoration:underline; font-size:16px; font-weight:bold;}
.t_btns { text-align:center;}
.t_btns a { display:inline-block; width:180px; height:43px; padding-right:31px; background:url(/images/layerbtn.gif) no-repeat; font:700 20px/42px 微软雅黑; color:#fff!important; text-decoration:none; text-align:center; overflow:hidden; margin:0px 5px;}
/*ie6hack*/
* html,* html body { background-image:url(about:blank); background-attachment:fixed;}
* html .t_ggBtn { position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,10)||0)-(parseInt(this.currentStyle.marginRight,10)||0)); top:expression(eval(document.documentElement.scrollTop)+100);}
* html .t_ggcoverbg { position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop));}
* html .t_gglayer { position: absolute; margin-top: expression(0 - parseInt(this.offsetHeight / 2) + (TBWindowMargin = document.documentElement && document.documentElement.scrollTop || document.body.scrollTop) + 'px');}

* html html,* html body { min-height:100%; height:auto!important; height:100%;}
</style>
<script language=javascript>
function tabImg(img_src,img_title){
	var imgObj=document.getElementById("mainImg");
 	var charObj=document.getElementById("imgTitle");
	if(imgObj){imgObj.src="images/"+img_src;}
	if(charObj){charObj.innerHTML=img_title;}
 }
jQuery(function(){
    	if('<%=tempAddFlag%>'==61 || '<%=tempAddFlag%>'==1){
    		jQuery("#pubHelp").show() ;
    	}
    //  jQuery(".menu ul").find("li:eq(4)").addClass("selected")  ;
    jQuery(".helpContain ul li b")
    jQuery.each(jQuery(".helpContain ul li b"),function(){
    	jQuery(this).click(function(){
    	var _top = this.offsetTop ;
    	//	$(window).scrollTop(_top); 
    	}) ;
    })
   }) ;
function setIframe(){
	var iframe = document.getElementById("iframeright_1");
	var bHeight = iframe.contentWindow.document.body.scrollHeight;
	var dHeight = iframe.contentWindow.document.documentElement.scrollHeight+20;
	var height = bHeight>dHeight?bHeight:dHeight;
	iframe.height=800;
	iframe.height = height;
}
</script>
</head>
<body>
<%
	//检测用户是否完善了信息
	if ("1".equals(userInfoFlag)) {
%>

<%
	}else if(addflag.equals("61") && (is_shop.equals("") || is_shop.equals("2"))){%>
<!--提示-->
<!--[if (IE 6)]>
<link href="http://product.21-sun.com/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<style type="text/css">
body,html { position:relative; width:100%; height:100%;}
#friendTip_cover { width:100%; height:100%; position:fixed; left:0px; top:0px; background:#000; filter:alpha(opacity=40); opacity:0.4; z-index:10;}
* html #friendTip_cover {position:absolute;left:expression(eval(document.documentElement.scrollLeft));top:expression(eval(document.documentElement.scrollTop))}
.friendTip-con { width:950px; height:0px; position:absolute; left:50%; top:0px; margin-left:-475px; z-index:20;}
.friendTip { display:none; width:373px; height:246px; position:absolute; left:380px; top:120px;}
.friendTip a.fbtn { position:absolute; right:30px; top:140px;}
.friendTip a.nextbtn01,.friendTip a.nextbtn02 { top:130px;}
.friendTip a.nextbtn01 { right:160px;}
.friendTip a.nextbtn03,.friendTip a.nextbtn04 { top:160px;}
.friendTip a.nextbtn03 { right:150px;}
.friendTip a.nextbtn04 { right:23px;}
#step1 { display:block;}
.friendTip p { font:100 12px/20px 微软雅黑; color:#353535; width:235px; position:absolute; left:102px; top:55px;}
.friendTip font { color:#ff7200; font-size:12px;}
.friendTip p.text02,.friendTip p.text02 font { font-size:14px;}
.friendTip p.text02 { top:100px;}
#step1 { left:450px; top:120px;}
#step2 { left:350px; top:170px;}
#step3 { left:350px; top:170px;}
#step4 { left:350px; top:170px;}
</style>
<div id="friendTip_cover"></div>
<div class="friendTip-con">

<div class="friendTip" id="step1"><img src="/images/shop/gq1-1.gif" alt="供求市场免费店铺开张了，拥有专属店铺，让买家更易找到您、让信息收录更容易、让搜索引擎优化更简单" width="373" height="246" />
  <a href="javascript:void(0);" class="fbtn nextbtn"><img src="/images/shop/ft_btn01.gif" alt="下一步" width="98" height="40" /></a>
</div>
<%if(Common.getFormatStr(memberInfo.get("mem_flag")).equals("1003") || 1==1){%>
<div class="friendTip" id="step2"><img src="/images/shop/gq12.gif" alt="30秒完善资料，开通专属店铺" width="373" height="246" />
  <a href="javascript:void(0);" class="fbtn nextbtn"><img src="/images/shop/ft_btn02.gif" alt="开始体验吧" width="169" height="45" /></a>
</div>
<%}else{%>
<div class="friendTip" id="step2"><img src="/images/shop/gq12-1.gif" alt="30秒完善资料，开通专属店铺，还有机会获得优惠券呦" width="373" height="246" />
  <a href="javascript:void(0);" class="fbtn nextbtn"><img src="/images/shop/ft_btn02.gif" alt="开始体验吧" width="169" height="45" /></a>
</div>
<%}%>
<%if(Common.getFormatStr(memberInfo.get("mem_flag")).equals("1003") || 1==1){%>
<div class="friendTip" id="step3"><img src="/images/shop/gq2-2.gif" alt="恭喜您，店铺开通成功！" width="373" height="246" />
  <a target="_blank" href="http://<%=sessionMemNo%>.market.21-sun.com" class="fbtn nextbtn02"><img src="../images/shop/ft_btn04.gif" alt="查看店铺" width="111" height="35" /></a>
</div>
<%}else{%>
<div class="friendTip" id="step3"><img src="/images/shop/gq2-2.gif" alt="恭喜您，店铺开通成功！" width="373" height="246" />
  <a href="javascript:void(0);" class="fbtn nextbtn01"><img src="../images/shop/ft_btn03.gif" alt="试下手气" width="111" height="35" /></a>
  <a target="_blank" href="http://<%=sessionMemNo%>.market.21-sun.com" class="fbtn nextbtn02"><img src="../images/shop/ft_btn04.gif" alt="查看店铺" width="111" height="35" /></a>
</div>
<%}%>

<div class="friendTip" id="step4"><img src="/images/shop/gq2-01.gif" width="373" height="246" />
  <p class="text01">
  获得了价值<span style="font-weight:bold; font-style:italic; font-size:14px; color:#F00"> 2501元 </span>的店铺开张优惠券，
  优惠号码：<font><%=Common.getFormatStr(memberInfo.get("randNum"))%></font>(有效期一个月)
  </p>
  <p class="text02"><font>优惠券可以用来做什么？3500元的<br />A类会员，只需要<span style="font-weight:bold; font-style:italic; font-size:14px; color:#F00">999元</span></font></p>
  <a href="javascript:void(0);" class="fbtn nextbtn03"><img src="../images/shop/ft_btn05.gif" alt="申请成为A类会员" width="121" height="35" /></a>
  <a target="_blank" href="http://www.21-sun.com/service/huiyuan/member_a.htm" class="fbtn nextbtn04"><img src="../images/shop/ft_btn06.gif" alt="查看A类会员服务" width="121" height="35" /></a>
</div>

</div>
<script type="text/javascript">
jQuery(function(){
	jQuery("#step1 .nextbtn").click(function(){
		jQuery("#step1").css('display','none');
		jQuery("#step2").css('display','block');
	});
	jQuery("#step2 .nextbtn").click(function(){
		jQuery("#step2,#friendTip_cover").css('display','none');
		wanshan();
		//jQuery("#step3").css('display','block');
	});
	<%if(Common.getFormatStr(memberInfo.get("mem_flag")).equals("1003")||1==1){%>
	jQuery("#step3 .fbtn").click(function(){
		jQuery("#step3,#friendTip_cover").css('display','none');
		window.location.reload();
	});
	<%}else{%>
	jQuery("#step3 .nextbtn01").click(function(){
		jQuery("#step3").css('display','none');
		jQuery("#step4").css('display','block');
	});
	<%}%>
	jQuery("#step4 .nextbtn03").click(function(){
		jQuery("#step4,#friendTip_cover").css('display','none');
		apply();
	});
})
//开通店铺完善资料
function wanshan(){
	jQuery("#step2").css('display','none');
	jQuery.jBox("iframe:/include/wanshan.jsp", {
		title: "完善资料，开通店铺",
		width: 520,
		height: 200,
		buttons: {}
	});
}
//申请A类会员
function apply(){
	jQuery("#step4").css('display','none');
	jQuery.jBox("iframe:/include/apply_member.jsp", {
		title: "申请A类会员",
		width: 520,
		height: 300,
		buttons: {}
	});
}
function showStep3(){
	jQuery("#step3").css('display','block');	
	jQuery("#step3,#friendTip_cover").css('display','block');
}
</script>
<!--提示结束-->
<%}%>
<jsp:include page="top_new.jsp" />
<jsp:include page="subtop_new.jsp"></jsp:include>
<div class="memberMain contain950"> 
  <!--left-->
  <div class="member_left">
    <div class="memberPart">
      <%
						if ("64".equals(addflag) || "2".equals(addflag)
									|| "8".equals(addflag) || "3".equals(addflag)
									|| "40".equals(addflag) || "41".equals(addflag)
									|| "42".equals(addflag) || "43".equals(addflag)
									|| "44".equals(addflag) || "9".equals(addflag)
									|| "45".equals(addflag) || "46".equals(addflag)
									|| "10".equals(addflag) || "53".equals(addflag)) {
								tempPurviewShowName = "配件网空间站";
							}
							if ("62".equals(addflag) || "28".equals(addflag)
									|| "29".equals(addflag) || "6".equals(addflag)
									|| "5".equals(addflag) || "30".equals(addflag)
									|| "31".equals(addflag) || "32".equals(addflag)
									|| "34".equals(addflag) || "35".equals(addflag)
									|| "102".equals(addflag) || "36".equals(addflag)
									|| "210".equals(addflag)) {
								tempPurviewShowName = "我的二手";
							}
							if ("63".equals(addflag) || "95".equals(addflag)
									|| "96".equals(addflag) || "4".equals(addflag)
									|| "37".equals(addflag) || "38".equals(addflag)
									|| "39".equals(addflag) || "97".equals(addflag)
									|| "98".equals(addflag) || "99".equals(addflag)
									|| "100".equals(addflag) || "47".equals(addflag)
									|| "48".equals(addflag) || "49".equals(addflag)
									|| "50".equals(addflag) || "51".equals(addflag)
									|| "52".equals(addflag) || "101".equals(addflag)) {
								tempPurviewShowName = "我的租赁";
							}
					%>
      <h2><%=tempPurviewShowName%></h2>
      <ul>
        <%
							String tempSubPurviewNum = "", tempSubPurviewName = "", tempSubpurviewUrl = "", tempSubPurviewAddFlag = "", tempSubSiteFlag = "";
								String tempHelpPage = "";
								if (tempSubMemberPurview != null) { //循环左侧栏目
									for (int i = 0; i < tempSubMemberPurview.length; i++) {

										tempSubPurviewNum = Common
												.getFormatStr(tempSubMemberPurview[i][0]);
										tempSubPurviewName = Common
												.getFormatStr(tempSubMemberPurview[i][1]);
										tempSubpurviewUrl = Common
												.getFormatStr(tempSubMemberPurview[i][2]);
										tempSubPurviewAddFlag = Common
												.getFormatStr(tempSubMemberPurview[i][3]);
										tempSubSiteFlag = Common
												.getFormatStr(tempSubMemberPurview[i][4]);

										if (tempSubPurviewAddFlag.equals(showFlag)) // 二级栏目
										{
											out.println("<li class='selected'>");
										} else {
											out.println("<li>");
										}
										if (tempSubPurviewNum1.equals(tempSubPurviewNum)) {
											if (!addflag.equals("") && addflag.equals("8")) { //发布配件求购信息时不需要验证
												iframeFilename = tempSubpurviewUrl;
											} else {
												// 一级栏目
												if (!addflag.equals("")
														&& alMemberFlagPurview != null
														&& !alMemberFlagPurview
																.contains(tempSubPurviewNum)) {
													iframeFilename = helpPage + "?purviewName="
															+ tempSubPurviewName; //没有权限时，iframe为一个帮助页
												} else {
													iframeFilename = tempSubpurviewUrl; //有权限时，链接到对应的页面
												}
											}
										}
										if (tempSubPurviewAddFlag.equals("27")) {
						%>
        <a href="membermain.jsp?addflag=<%=tempSubPurviewAddFlag%>"><%=tempSubPurviewName%><strong>(<%=countsellandbuy[0][0]%>)</strong> </a>
        <%
							} else {
						%>
        <a href="membermain.jsp?addflag=<%=tempSubPurviewAddFlag%>"><%=tempSubPurviewName%></a>
        <%
							}
									}
								}

								//====供求市场===
								if (iframeFilename.equals("") && tempSiteFlag1.equals("19")
										&& showFlag.equals("1")) { // 我要卖
									iframeFilename = "/market/market_opt_freemaker.jsp?addflag="
											+ showFlag; // 根据传递的参数改变  我要卖
								} else if (iframeFilename.equals("")
										&& tempSiteFlag1.equals("19") && showFlag.equals("7")) { // 我要买
									iframeFilename = "/market/market_opt_freemaker.jsp?addflag="
											+ showFlag;
								} else if (iframeFilename.equals("")
										&& tempSiteFlag1.equals("19") && showFlag.equals("27")) // 我的供求
								{
									iframeFilename = "/market/market_list.jsp";
								} else if (iframeFilename.equals("")
										&& tempSiteFlag1.equals("19") && showFlag.equals("61")) // 主页
								{
									iframeFilename = "/market/market_opt_freemaker.jsp?addflag=1"; // 根据传递的参数改变  我要卖
								} else if (iframeFilename.equals("")
										&& tempSiteFlag1.equals("19") && showFlag.equals("33")) // 主页
								{
									iframeFilename = "/other/message_list.jsp"; // 根据传递的参数改变  我要卖
								}else if(iframeFilename.equals("") && tempSiteFlag1.equals("19") && showFlag.equals("71")){ //店铺美化
									iframeFilename = "/market/shop.jsp";
								}else if(iframeFilename.equals("") && tempSiteFlag1.equals("19") && showFlag.equals("72")){ //seo设置
									iframeFilename = "/market/seo.jsp";
								}
								//====二手====
								else if (iframeFilename.equals("")
										&& tempSiteFlag1.equals("22")) {
									iframeFilename = "membermain_used_iframe.jsp?site_flag="
											+ tempSiteFlag1 + "&purview_name="
											+ tempPurviewName1;
								}
								//====租赁====
								else if (iframeFilename.equals("")
										&& tempSiteFlag1.equals("24")) {
									iframeFilename = "membermain_rent_iframe.jsp?site_flag="
											+ tempSiteFlag1 + "&purview_name="
											+ tempPurviewName1;
								}

								//====配件====
								else if (iframeFilename.equals("")
										&& tempSiteFlag1.equals("23")) {
									iframeFilename = "membermain_part_iframe.jsp?site_flag="
											+ tempSiteFlag1 + "&purview_name="
											+ tempPurviewName1;
								}

								//====配套====
								else if (iframeFilename.equals("")
										&& tempSiteFlag1.equals("27")) {
									iframeFilename = "membermain_fittings_iframe.jsp?site_flag="
											+ tempSiteFlag1
											+ "&purview_name="
											+ tempPurviewName1;
								}
						%>
      </ul>
    </div>
    <%if(addflag.equals("61") && is_shop.equals("1")){%>
    <div class="Newmenu noMargin">
      <ul>
        <li> <a target="_blank"
								href="http://<%=Common.getFormatStr(memberInfo.get("mem_no"))%>.market.21-sun.com/"><strong style="color:red">进入我的店铺</strong></a> </li>
      </ul>
    </div>
    <%}%>
    <div class="Newmenu noMargin">
      <ul>
        <li> <a target="_blank"
								href="http://market.21-sun.com/buylistshow_1.htm">询价单</a> </li>
      </ul>
    </div>
    <div class="memberApplyPart">
      <h2> 推荐应用 </h2>
      <ul>
        <li> <a href="http://www.21-cmjob.com/" target="_blank"><img
									src="../images/ico_rcw.gif" /> </a>
          <div class="appIntro"> <span><a href="http://www.21-cmjob.com/" target="_blank">人才网</a> </span> </div>
        </li>
        <li> <a href="http://www.21part.com" target="_blank"><img
									src="../images/ico_jpw.gif" /> </a>
          <div class="appIntro"> <span><a href="http://www.21part.com" target="_blank">杰配网</a> </span> </div>
        </li>
        <li> <a href="membermain.jsp?addflag=20"><img
									src="../images/ico_ptw.gif" /> </a>
          <div class="appIntro"> <span><a href="membermain.jsp?addflag=20">配套网</a> </span> </div>
        </li>
        <li> <a href="http://www.jerehsoft.com/products/index.jsp"
								target="_blank"><img src="../images/erp_huiyuan.gif" /> </a>
          <div class="appIntro"> <span><a
									href="http://www.jerehsoft.com/products/index.jsp"
									target="_blank">工程机械行业管理解决方案</a> </span> </div>
        </li>
      </ul>
    </div>
    <div class="hotLine">
      <h3> 咨询热线 </h3>
      <div class="hottel"> <font color="white">0535-6792736</font> <br />
        <font color="black">0535-6727765</font> </div>
    </div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="member_right">
    <div class="memberRightContain">
      <iframe id="iframeright_1" name="iframeright_1" scrolling="no"
						frameborder="0" width="100%" height="660"
						src="<%=iframeFilename%>" allowtransparency="true"
						onload="Javascript:setIframe()"></iframe>
    </div>
  </div>
  <!--right end-->
  <div class="clear"></div>
</div>
<script type="text/javascript">
//name,url,width 850,heigth 680
function openDivWin(name,url,width,heigth){
 	var w =width; 
 	var h =heigth; 
 	lhgdialog.opendlg(name,url, w, h, true, true,'windiv'); 
}
function tabImg(img_src,img_title)
{
	var imgObj=document.getElementById("mainImg");
 	var charObj=document.getElementById("imgTitle");
	if(imgObj){imgObj.src="images/"+img_src;}
	if(charObj){charObj.innerHTML=img_title;}
 }
function changeClass(n){  //选中当前的导航条，将其它的设置成不选中
	$("#v"+n).addClass("v"+n+"hover");
	$("#v"+n).attr("style","color:#356794");	
	$("#nav li span a").each(function(i){
	     if(i!=n){		    
		   $("#v"+i).removeClass("v"+i+"hover");
		   $("#v"+i).attr("style","color:#ffffff");
		 }
	}); 

 }
</script> 
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<jsp:include page="foot_new.jsp" />
<!--发布助手-->
<div class="memberHelp_bar" id="pubHelp" style="display:none;">
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery(".helpBtn").click(function(){
		jQuery(this).hide();
	    jQuery(".helpCon").show();
	});
	jQuery(".helpTitle span.ico").click(function(){
		jQuery(".helpCon").hide();
	    jQuery(".helpBtn").show();
	});
	jQuery(".hp_t").click(function(){
		jQuery(this).next("li").toggle().siblings(".hp_c:visible").hide();
		jQuery(this).toggleClass("hp_cur");
		jQuery(this).siblings(".hp_cur").removeClass("hp_cur");
	});
});
</script>
  <div class="helpBtn"></div>
  <div class="helpCon">
    <div class="helpTitle">
      <strong class="n">发布助手</strong>
      <span class="ico"></span>
    </div>
    <div class="helpContain">
      <ul>
        <li class="hp_t">
          <b>信息标题</b>
          <span class="ico"></span>
        </li>
        <li class="hp_c">
    &#12288;&#12288;标题是信息内容核心浓缩表述清晰并且包含关键信息的标题能让用户更容易掌握产品具体情况，从而引起买家更多的兴趣。
	 <br/> &#12288;&#12288;标题也是买家搜索到您的重要因素。字数不应太多，要尽量准确、完整、简洁。
        </li>
        <li class="hp_t">
          <b>产品属性</b>
          <span class="ico"></span>
        </li>
        <li class="hp_c">
  &#12288;&#12288;产品属包括品牌和适用机型，是买家选择商品的重要依据，买家在搜索时会根据某些属性进行进一步的筛选，正确的填写产品属性可以提高信息在搜索时的命中率，大大提高曝光机率，也能够让买家在第一时间全面的了解产品。
        </li>
        <li class="hp_t">
          <b>产品描述</b>
          <span class="ico"></span>
        </li>
        <li class="hp_c">
  &#12288;&#12288;产品描述可以通过文字详细介绍产品的相关信息，并运用产品图片强有力的视觉吸引力，展现产品各个角度和细节的真实情况，彰显产品的专业品质和企业实力，让买家对产品更了解，对服务更放心。
        </li>
        <li class="hp_t">
          <b>产品图片</b>
          <span class="ico"></span>
        </li>
        <li class="hp_c">
 &#12288;&#12288; 图片质量的好坏直接影响到您的产品对买家的吸引力，好的图片拥有更多的曝光几率。图片最好满足280*210的像素。
        </li>
      </ul>
    </div>
  </div>
</div>
<!--发布助手 end-->

<!-- 配件通知 -->  
<%
if ("64".equals(addflag)||"2".equals(addflag)||"8".equals(addflag)||"3".equals(addflag)||"40".equals(addflag)||"41".equals(addflag)||"42".equals(addflag)||"43".equals(addflag)||"44".equals(addflag)||"9".equals(addflag)||"45".equals(addflag)||"46".equals(addflag)||"10".equals(addflag)||"53".equals(addflag)) {
%> 
<div class="t_ggBtn"><img src="/images/tz2.gif" alt="重要通知" width="70" height="282" /></div>
	<div class="t_ggcoverbg"></div>
	<div class="t_gglayer">
	  <div class="t_title">
	    <span class="t_close" title="关闭"></span>
	  </div>
	  <div class="t_content">
	    <div class="t_textInfo">
	      <p><strong style="font-size:18px; font-weight:bold;">尊敬的商贸网用户：</strong><br />
	      您好，欢迎来到中国工程机械配件网管理后台！</p>
	      <p>为了更好的提高您录入产品的品质，更好的被搜索引擎收录，更好的提升用户体验，我们技术人员经过深入的调研，制作完成了新版配件网，新版配件网从用户角度出发，后台布局更加的人性化，操作更加的简单便捷。</p>
	      <p>由于<strong class="t_red">新版配件网</strong>（<a href="http://part.21-sun.com" target="_blank">http://part.21-sun.com</a>）是一个全新的后台，所以<strong class="t_red">旧版配件网</strong>（<a href="http://www.21-part.com" target="_blank">http://www.21-part.com</a> ）中的信息不会移到新版配件网中，但现阶段新版配件网和旧版配件网是同时运行的，以前在旧版配件网中的信息不会影响在百度的收录，<strong class="t_red">旧版配件网与本后台会在<em style="font-size:24px;">2013年12月31日</em>停止使用</strong>，所以请广大客户在这段时间通过新后台发布信息，相信新的配件网会给您带来全新的感受和更大的惊喜。</p>
	      <p style="font-size:18px; font-weight:bold;">在此过程中给广大客户造成的不便，我们深表歉意，如您在使用过程中有任何疑问或困惑，请一定选择与我们交流，我们会给您一个满意的答复和解决方案。</p>
	      <p><strong class="t_red" style="font-size:14px;">如有疑问请咨询：<em style="font-size:20px;">0535-6792736</em></strong> </p>
	    </div>
	    <div class="t_btns">
	      <a href="javascript:void(0);" class="t_close">在老后台发布信息</a>
	      <a href="http://part.21-sun.com/" target="_blank">逛逛新版配件网</a>
	      <a href="/home/part/product/list.jsp" target="_blank">去新后台发布信息</a>
	    </div>
	  </div>
</div>
<script type="text/javascript">
jQuery(function(){
	jQuery(".t_ggBtn img").click(function(){
		jQuery(".t_ggcoverbg,.t_gglayer").css("display","block");
		$(".t_ggBtn").hide();
	});
	jQuery(".t_gglayer .t_close").click(function(){
		jQuery(".t_ggcoverbg,.t_gglayer").css("display","none");
		$(".t_ggBtn").show();
	});
})
</script>
<%} %>
<!-- 配件通知 -->

<!-- 供求通知 --> 
<% if ("61".equals(addflag)) {%>
<script type="text/javascript">
$.jBox.messager('尊敬的各位伙伴：<br />为给广大客户提供一个专业的信息平台，商贸网近期会对供求市场的信息进行整理，如您发现您发布的信息不存在或帐号不能登录，<span style="color:red">有可能是您的信息与我们行业不相关或不符合我们的要求，被删除或禁用。</span><br />感谢您对中国工程机械商贸网的关注，如给您造成不便，我们深表歉意！<br />如您有任何问题，请拨打：0535-6723231。', '重要通知',0);
</script>
<%} %>
<!-- 供求通知 -->
<%
	if ("61".equals(addflag)) {
%>
<script type="text/javascript">   
      jQuery(".menu ul").find("li:eq(1)").addClass("selected")  ;
</script>
<%
	}
	if ("64".equals(addflag) || "2".equals(addflag)
			|| "8".equals(addflag) || "3".equals(addflag)
			|| "40".equals(addflag) || "41".equals(addflag)
			|| "42".equals(addflag) || "43".equals(addflag)
			|| "44".equals(addflag) || "9".equals(addflag)
			|| "45".equals(addflag) || "46".equals(addflag)
			|| "10".equals(addflag) || "53".equals(addflag)) {
%>
<script type="text/javascript">   
    jQuery(".menu ul").find("li:eq(2)").addClass("selected")  ;
</script>
<%
	}
	if ("62".equals(addflag) || "28".equals(addflag)
			|| "29".equals(addflag) || "6".equals(addflag)
			|| "5".equals(addflag) || "30".equals(addflag)
			|| "31".equals(addflag) || "32".equals(addflag)
			|| "34".equals(addflag) || "35".equals(addflag)
			|| "36".equals(addflag) || "102".equals(addflag)
			|| "101".equals(addflag) || "210".equals(addflag)) {
%>
<script type="text/javascript">   
    jQuery(".menu ul").find("li:eq(3)").addClass("selected")  ;
</script>
<%
	}
	if ("63".equals(addflag) || "95".equals(addflag)
			|| "96".equals(addflag) || "4".equals(addflag)
			|| "37".equals(addflag) || "38".equals(addflag)
			|| "39".equals(addflag) || "97".equals(addflag)
			|| "98".equals(addflag) || "99".equals(addflag)
			|| "100".equals(addflag) || "47".equals(addflag)
			|| "48".equals(addflag) || "49".equals(addflag)
			|| "50".equals(addflag) || "51".equals(addflag)
			|| "52".equals(addflag)) {
%>
<%	} %>
</body>

<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(conn);
		pool5.freeConnection(conn);
	}
%>
</html>