<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="member_opt.jsp";
String mypy="member_info";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));

String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id
String mem_no=Common.getFormatStr(request.getParameter("mem_no"));//会员编号

String memberSubId ="";
String comp_mode = "";

String tempUserIno[][]=null;//会员临时信息
if(myvalue.equals(""))
{
	tempUserIno=DataManager.fetchFieldValue(pool,"vi_member_info","id,sub_id,comp_mode","state=1 and mem_no<>'' and mem_no='"+mem_no+"'");
	if(tempUserIno!=null&&tempUserIno[0][0]!=null){
	   myvalue     = Common.getFormatStr(tempUserIno[0][0]);
	   memberSubId = Common.getFormatStr(tempUserIno[0][1]);
	   comp_mode = Common.getFormatStr(tempUserIno[0][2]);
	   }
}else{
   tempUserIno=DataManager.fetchFieldValue(pool,"vi_member_info","sub_id,mem_no,comp_mode","state=1 and  id='"+myvalue+"'"); //查询子表的ID
	if(tempUserIno!=null&&tempUserIno[0][0]!=null){
	   memberSubId = Common.getFormatStr(tempUserIno[0][0]);
	   mem_no      = Common.getFormatStr(tempUserIno[0][1]);
	   comp_mode = Common.getFormatStr(tempUserIno[0][2]);
	 }
}

String urlpath="../member/member_opt.jsp?myvalue="+myvalue;
try{//====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会员管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
/*add20121009*/
#mrm_select { width:85px; height:25px; cursor:pointer; float:left;}
#mrm_select span.t { display:block; width:69px; height:25px; line-height:24px; background:url(../images/mrm_select.gif) no-repeat; padding-left:16px;}
.scur#mrm_select { position:relative; z-index:1;}
.scur#mrm_select span.t { background-position:0px -25px; position:absolute; left:0px; top:0px; z-index:3;}
.selectContain { display:none; width:570px; height:auto; padding:10px; float:left; position:absolute; left:0px; top:24px; z-index:2; border:#e2e2e2 1px solid; background:#fff;}
.scur#mrm_select .selectContain { display:block;}
ul.selist { width:100%; float:left;}
ul.selist li { width:100%; float:left; padding:2px 0px;}
ul.selist li strong { display:block; width:75px; float:left; text-align:right;}
ul.selist li div.sc { width:495px; float:right;}
ul.selist li div.sc span { display:inline-block; white-space:nowrap; margin-right:2px;}
ul.selist li div.sc span input { vertical-align:-3px;}
/*add20121009 end*/
</style>
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<script>
//为多选框赋值
function submityn(){
	//主营业务
	var len = jQuery("input[type='checkbox']:checked").length ;
	var comp_mode = "," ;
//	if(len==0)
//	{
//		alert("请至少选择一项主营业务！") ;
//		return false ;
//	}
	jQuery("input[type='checkbox']:checked").each(function(){
	//  alert(jQuery(this).val()) ;
		comp_mode += jQuery(this).val() +",";
	}) ;
	jQuery("#zd_comp_mode").val(comp_mode);
	//主营业务结束
$("#zd_mem_flag_name").val($("select[name='zd_mem_flag'] option[selected]").text());
document.theform.submit();
}

function changememname()
{
$("#zd_mem_flag_name").val($("select[name='zd_mem_flag'] option[selected]").text());
}

//===删除会员====
function dodelete()
{if(confirm('是否要删除该会员?'))
 {$.get("delete_member.jsp", { id: "<%=myvalue%>"},
  function(data){
  if(data==1)
    alert("删除成功!");
	window.close();
  }); 
  }
}

</script>

<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
  <input type="hidden" name="mem_no" id="mem_no" value="<%=mem_no%>">
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="list_border_bg">
  <tr>
      <td height="22" align="right" nowrap class="list_left_title">用户类型：</td>
      <td height="22" class="list_cell_bg">
        <input name="zd_mem_type" type="radio" value="1" />
        企业
        <input type="radio" name="zd_mem_type" value="2" />
        个人</td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">用 户 名：</td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" size="18"  >
        <span class="list_left_title">密码：
        <input name="zd_passw" type="text" id="zd_passw" size="18" >
        </span>&nbsp;&nbsp;&nbsp;<a href="member_opt_sub.jsp?myvalue=<%=memberSubId%>&mem_no=<%=mem_no%>&memberId=<%=myvalue%>"><font color="#FF0000">会员更多信息(New)</font></a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">会员级别：</td>
      <td height="22" class="list_cell_bg"><select name="zd_mem_flag" id="zd_mem_flag" onChange="javascript:changememname()">
          <option value=""></option>
          <%=Common.option_str(pool, "member_role","role_num,role_name"," 1=1 order by role_num", "",0)%>
        </select>
        <input name="zd_mem_flag_name" type="hidden" id="zd_mem_flag_name">
        登录次数：
        <input name="zd_login_count" type="text" id="zd_login_count" size="10"  >
        最后登录日期：
        <input name="zd_login_last_date" type="text" id="zd_login_last_date" size="15"  ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">会员状态：</td>
      <td height="22" class="list_cell_bg"><input name="zd_state" type="radio" value="1" checked />
        正常
        <input name="zd_state" type="radio" value="0" />
        禁用 到期日期：
        <input name="zd_mem_flag_enddate" type="text" id="zd_mem_flag_enddate" size="15"  onfocus="calendar(event)">
        注册来源：
        <select name="zd_reg_source" id="zd_reg_source">
          <option value="0">--请选择--</option>
          <option value="27">配套网</option>
          <option value="25">主站</option>
          <option value="22">二手网</option>
          <option value="23">配件网</option>
          <option value="24">租赁</option>
          <option value="14">人才网</option>
          <option value="19">供求市场</option>
        </select>
        </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">真实姓名：</td>
      <td height="22" class="list_cell_bg"><input name="zd_mem_name" type="text" id="zd_mem_name" size="20" >
        <input name="zd_per_sex" type="radio" value="男" />
        先生
        <input type="radio" name="zd_per_sex" value="女" />
        女士</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">联系邮箱：</td>
      <td height="22" class="list_cell_bg"><input name="zd_per_email" type="text" id="zd_per_email" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">手　　机：</td>
      <td height="22" class="list_cell_bg"><input name="zd_per_phone" type="text" id="zd_per_phone" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">省　　市：</td>
      <td height="22" class="list_cell_bg"><input name="zd_per_province" type="text" id="zd_per_province" size="5" >
        <input name="zd_per_city" type="text" id="zd_per_city" size="5" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title ">公司名称：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_name" type="text" id="zd_comp_name" size="50" ></td>
    </tr>
 <!--   
    <tr>
      <td height="22" align="right" nowrap class="list_left_title ">公司简称：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_simple" type="text" id="zd_comp_simple" size="28" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司地址：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_address" type="text" id="zd_comp_address" size="50" ></td>
    </tr>
 -->
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">邮　　编：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_postcode" type="text" id="zd_comp_postcode" size="15" >
        企业推荐：
        <input name="zd_comp_recom" type="radio" id="zd_comp_recom" value="0" checked />
        否
        <input name="zd_comp_recom" id="zd_comp_recom" type="radio" value="1" />
        是</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">传　　真：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_fax" type="text" id="zd_comp_fax" size="15" >
        网址：
        <input name="zd_comp_url" type="text" id="zd_comp_url" size="22" ></td>
    </tr>
		<tr>
      <td height="22" align="right" nowrap class="list_left_title">QQ：</td>
      <td height="22" class="list_cell_bg"><input name="zd_per_qq" type="text" id="zd_per_qq" size="40" ></td>
    </tr>
<!--
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司注册号：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_register_no" type="text" id="zd_comp_register_no" size="40" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">法人代表：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_legal" type="text" id="zd_comp_legal" size="20" >
        <span class="list_left_title">注册资本：
        <input name="zd_comp_capital" type="text" id="zd_comp_capital" size="10" >
        </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">企业类型：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_flag" type="text" id="zd_comp_flag" size="20" >
        <span class="list_left_title">成立日期：
        <input name="zd_comp_founddate" type="text" id="zd_comp_founddate" size="10" >
        </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">登记机关：</td>
      <td height="22" class="list_cell_bg"><span class="list_left_title">
        <input name="zd_comp_register_auth" type="text" id="zd_comp_register_auth" size="20" >
        年检日期：
        <input name="zd_comp_inspectiondate" type="text" id="zd_comp_inspectiondate" size="10" >
        </span></td>
    </tr>
-->
	<tr>
      <td height="22" align="right" nowrap  class="list_left_title">主营业务：</td>
      <td height="22" class="list_cell_bg">
      <input name="zd_comp_mode" type="hidden" id="zd_comp_mode" value=""/>
      <div id="mrm_select" onMouseOver="document.getElementById('mrm_select').className='scur'" onMouseOut="document.getElementById('mrm_select').className=''">
            <span class="t">请选择</span>
            <div class="selectContain">
              <ul class="selist">
                <li>
                  <strong>整机生产：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101001" <%=comp_mode.equals("101001")?"checked":""%>/>  挖掘机</span>
            	    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101002" <%=comp_mode.equals("101002")?"checked":""%>/> 装载机</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101003" <%=comp_mode.equals("101003")?"checked":""%>/> 起重机 </span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101004" <%=comp_mode.equals("101004")?"checked":""%>/> 推土机</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101005" <%=comp_mode.equals("101005")?"checked":""%>/>  路面机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101006" <%=comp_mode.equals("101006")?"checked":""%>/> 混凝土机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101007" <%=comp_mode.equals("101007")?"checked":""%>/> 桩工机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101008" <%=comp_mode.equals("101008")?"checked":""%>/> 破碎设备</span> 
            		<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101009" <%=comp_mode.equals("101009")?"checked":""%>/> 矿山机械</span>
            		<span><input name="cd_comp_mode" id="cd_comp_mode" type="checkbox" value="101010" <%=comp_mode.equals("101010")?"checked":""%>/>其他</span>
                  </div>
                </li>
                <li>
                  <strong>整机销售：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102001" <%=comp_mode.equals("102001")?"checked":""%>/>   挖掘机</span>
            	    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102002" <%=comp_mode.equals("102002")?"checked":""%>/> 装载机</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102003" <%=comp_mode.equals("102003")?"checked":""%>/> 起重机 </span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102004" <%=comp_mode.equals("102004")?"checked":""%>/>  推土机</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102005" <%=comp_mode.equals("102005")?"checked":""%>/> 路面机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102006" <%=comp_mode.equals("102006")?"checked":""%>/>混凝土机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102007" <%=comp_mode.equals("102007")?"checked":""%>/>桩工机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102008" <%=comp_mode.equals("102008")?"checked":""%>/>破碎设备</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102009" <%=comp_mode.equals("102009")?"checked":""%>/>矿山机械</span>
            		<span><input name="cd_comp_mode" id="cd_comp_mode" type="checkbox" value="102010" <%=comp_mode.equals("102010")?"checked":""%>/>其他</span>
                  </div>
                </li>
                <li>
                  <strong>配件：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="103001" <%=comp_mode.equals("103001")?"checked":""%>/>  配套件</span>
            	    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="103002" <%=comp_mode.equals("103002")?"checked":""%>/> 配件零售</span>
            		<span><input name="cd_comp_mode" id="cd_comp_mode" type="checkbox" value="103003" <%=comp_mode.equals("103003")?"checked":""%>/>其他</span>
                  </div>
                </li>
                <li>
                  <strong>代理商：</strong>
                  <div class="sc">
                   <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="104001" <%=comp_mode.equals("104001")?"checked":""%>/>  代理商</span>
                  </div>
                </li>
                <li>
                  <strong>终端用户：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="105001" <%=comp_mode.equals("105001")?"checked":""%>/>  施工单位</span>
            	    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="105002" <%=comp_mode.equals("105002")?"checked":""%>/> 承包商</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="105003" <%=comp_mode.equals("105003")?"checked":""%>/> 其他</span>
                  </div>
                </li>
                <li>
                  <strong>租赁企业：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="106001" <%=comp_mode.equals("106001")?"checked":""%>/> 租赁企业</span>
                  </div>
                </li>
                <li>
                  <strong>二手机：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="107001" <%=comp_mode.equals("107001")?"checked":""%>/>  上游</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="107002" <%=comp_mode.equals("107002")?"checked":""%>/> 其他 </span>
                  </div>
                </li>
              </ul>
            </div>
          </div>
          <span style="float:left; line-height:24px; padding-left:10px; color:#aaa">【可多选】</span>
      </td>
	    <tr>
      <td height="22" align="right" nowrap  class="list_left_title">租赁店铺推荐：</td>
      <td height="22" class="list_cell_bg"><select name="zd_rentshop_isrecom" id="zd_rentshop_isrecom">
        <option value="0">否</option>
        <option value="1">是</option>
      </select>
      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title ">公司Logo(专卖店广告)：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_logo" type="text" id="zd_comp_logo" size="50" maxlength="40">
        <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_logo','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_logo').val(),'winpic',400,300);">预览 
</a>排序：
        <input name="zd_orderno" type="text" id="zd_orderno" size="3" onKeyPress="javascript:onlyNum();"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">营业执照(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_license" type="text" id="zd_comp_license" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_license','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_license').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">经营许可(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_requires" type="text" id="zd_comp_requires" size="50" maxlength="40">
        <input name="selectimg2" type="button" class="form_button" id="selectimg2" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_requires','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_requires').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">证书1(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_certificate1" type="text" id="zd_comp_certificate1" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_certificate1','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_certificate1').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">证书2(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_certificate2" type="text" id="zd_comp_certificate2" size="50" maxlength="40">
        <input name="selectimg2" type="button" class="form_button" id="selectimg2" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_comp_certificate2','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_certificate2').val(),'winpic',400,300);">预览</a></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">经营类别(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><select name="zd_comp_category" id="zd_comp_category" style="width:100px;"  class="blue1">
          <option value="" >请选择分类</option>
          <option value="101">挖掘机配件</option>
          <option value="102">装载机配件</option>
          <option value="103">路面设备配件</option>
          <option value="104">混凝土机械配件</option>
          <option value="105">破碎锤配件</option>
          <option value="106">其他配件</option>
          <option value="107">原料加工设备</option>
        </select>
      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title ">所属品牌(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_parts_brand" type="text" id="zd_parts_brand" size="50" onClick="openWin('brand_list.jsp?brandId='+this.value,'',500,400)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">配件公告(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><textarea name="zd_comp_bulletin" cols="60" rows="3" id="zd_comp_bulletin"></textarea></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">经营范围(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_scope" type="text" id="zd_comp_scope" size="50"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">经营模式(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_parts_mode" type="radio" id="zd_parts_mode" value="1" />
        生产加工
        <input name="zd_parts_mode" id="zd_parts_mode" type="radio" value="2" />
        代理经销
        <input name="zd_parts_mode" type="radio" id="zd_parts_mode" value="3" />
        招商合作
        <input name="zd_parts_mode" id="zd_parts_mode" type="radio" value="4" />
        其他</td>
    </tr>
   <!-- <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">诚信认证(配件网)：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_parts_certify" type="radio" id="zd_parts_certify" value="0" checked />
        否
        <input name="zd_parts_certify" id="zd_parts_certify" type="radio" value="1" />
        是</td>
    </tr>-->
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FFFF66" class="list_left_title ">租赁站长管理区域：</td>
      <td height="22" bgcolor="#FFFF66" class="list_cell_bg"><input name="zd_rent_webmaster_region" type="text" id="zd_rent_webmaster_region" size="40">
        (比如山东,吉林)</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#6666FF" class="list_left_title">保证金(二手网)：</td>
      <td height="22" bgcolor="#6666FF" class="list_cell_bg"><input name="zd_margin" type="text" id="zd_margin" size="10" onKeyDown="javascript:onlyNum();" onBlur="$('#zd_auction_amount').val(this.value*50);">
        万元 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap bgcolor="#6666FF" class="list_left_title">竞拍额度(二手网)：</td>
      <td height="22" bgcolor="#6666FF" class="list_cell_bg"><input name="zd_auction_amount" type="text" id="zd_auction_amount" size="10" >
        万元 (<span class="list_left_title STYLE1">竞拍额度</span>:保证金*50) </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司介绍：</td>
      <td height="22" class="list_cell_bg"><FCK:editor instanceName="zd_comp_intro" toolbarSet="simple" width="93%" height="280">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor></td>
    </tr>
	<cache:cache cron="* */1 * * *">
    <%if(!myvalue.equals("")){
	//===企业大全====
String tempCompanyInfo[][]=DataManager.fetchFieldValue(pool," member_info A left outer join (select count(mid) as countnums,mid from  webypage group by mid)B on A.mem_No=B.mid ", "isnull(B.countnums,0),A.mem_no"," A.id='"+myvalue+"' ");
String tempMem_no="";
int tempCompanyNums=0;
if(tempCompanyInfo!=null)
{tempMem_no=(tempCompanyInfo!=null&&tempCompanyInfo[0][1]!=null?Common.getFormatStr(tempCompanyInfo[0][1]):"");
tempCompanyNums=(tempCompanyInfo!=null&&tempCompanyInfo[0][0]!=null?Integer.parseInt(Common.getFormatInt(tempCompanyInfo[0][0])):0);

}

PoolManager poolRent = new PoolManager(3);//租赁
PoolManager poolused = new PoolManager(4);//二手
PoolManager poolMarket = new PoolManager(5);//供求
PoolManager poolPart = new PoolManager(7);//配件

String rents[][] = DataManager.fetchFieldValue(poolRent,"rent_info","count(*)"," mem_no<>'' and mem_no='"+tempMem_no+"' and (class=1 or class=0)");
String usedsBuy[][] = DataManager.fetchFieldValue(poolused,"buy","count(*)"," mem_no<>'' and mem_no='"+tempMem_no+"' ");
String usedsSell[][] = DataManager.fetchFieldValue(poolused,"sell","count(*)"," mem_no<>'' and mem_no='"+tempMem_no+"' ");
String markets[][] = DataManager.fetchFieldValue(poolMarket,"sell_buy_market","count(*)"," mem_no<>'' and  mem_no='"+tempMem_no+"' "); //and (business_flag='10' or business_flag='11')
String partsSupply[][] = DataManager.fetchFieldValue(poolPart,"supply","count(*)"," mem_no<>'' and  mem_no='"+tempMem_no+"' ");
String partsBuy[][] = DataManager.fetchFieldValue(poolPart,"buy","count(*)"," mem_no<>'' and mem_no='"+tempMem_no+"' ");
%>
    <tr>
      <td height="22" colspan="2" align="right" nowrap class="list_left_title"><div align="center" class="STYLE1"><strong>其他关联信息</strong></div></td>
    </tr>
    <tr>
      <td height="22" colspan="2" class="list_left_title"><%if(tempCompanyNums>0){%>
        <font color='red'><b>已开通企业大全</b></font>
        <%}%>
        &nbsp;&nbsp;<a href="/webadmin/supply/company_add.jsp?mem_no=<%=tempMem_no%>" target="_blank">开通企业大全</a>&nbsp;&nbsp;&nbsp;|
        <%if(rents!=null){%>
        <a href="/webadmin/rent/rent_list.jsp?find_mem_no=<%=tempMem_no%>" target="_blank">租赁信息(<%=Common.getFormatInt(rents[0][0])%>)</a>
        <%}%>
        |&nbsp;&nbsp;
        <%if(usedsBuy!=null){%>
        <a href="/webadmin/used/buy_list.jsp?find_mem_no=<%=tempMem_no%>" target="_blank">二手求购信息(<%=Common.getFormatInt(usedsBuy[0][0])%>)</a>
        <%}%>
		 |&nbsp;&nbsp;
        <%if(usedsSell!=null){%>
        <a href="/webadmin/used/sell_list.jsp?find_mem_no=<%=tempMem_no%>" target="_blank">二手出售信息(<%=Common.getFormatInt(usedsSell[0][0])%>)</a>
        <%}%>
        |&nbsp;&nbsp;
        <%if(markets!=null){%>
        <a href="/webadmin/market/market_list.jsp?find_mem_no=<%=tempMem_no%>" target="_blank">供求信息(<%=Common.getFormatInt(markets[0][0])%>)</a>
        <%}%>
        |&nbsp;&nbsp;
        <%if(partsSupply!=null){%>
        <a href="/webadmin/parts/supply_list.jsp?find_mem_no=<%=tempMem_no%>" target="_blank">配件供应(<%=Common.getFormatInt(partsSupply[0][0])%>)</a>
        <%}%>
        |&nbsp;&nbsp;
        <%if(partsBuy!=null){%>
        <a href="/webadmin/parts/buy_list.jsp?find_mem_no=<%=tempMem_no%>" target="_blank">配件求购(<%=Common.getFormatInt(partsBuy[0][0])%>)</a>
        <%}%></td>
    </tr>
    <%}%>
</cache:cache>
    <tr>
      <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" ><%if(!admin_mem_flag.equals("1007")&&!admin_mem_flag.equals("1005")){%>
	  <input type="button" name="Submit" value="保存" onClick="submityn()">
        <span class="right">
        <input type="button" name="mit2" value="删除会员" style="cursor:pointer" class="tijiao" onClick="javascript:dodelete();" />
        </span>
		<%}%>
        <input name="zd_id" type="hidden" id="zd_id" value="0">
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>">
        <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
      </td>
    </tr>
  </table>
</form>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","../manage/set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));	
	}
}
<%
if(!myvalue.equals("")){
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
<script   language="javascript">
function compModeHidden()
{
	//var cuoObj = document.getElementById("zdCompModeValue_cuo");
	//var cuoInfoObj = document.getElementById("zdCompModeValue_cuo_info");
	//cuoObj.style.display = "none";
	//cuoInfoObj.style.display = "none";
}

//根据传入的字段，返回是否在字符串中
function fieldInFields(fields,field){
result=false;
if(fields!=null && field!=null){
	tp=fields.split(",");
	for(i=0;i<tp.length;i++){
		if(field==(tp[i])){
			result=true;
			break;
		}
	}	
}
return result;
}

function setChecks(sorts,name){
var obj=document.getElementsByName(name); 

for(var i=0;i<obj.length;i++){ 
	if(fieldInFields(sorts,obj[i].value)) 
	{ 
		obj[i].checked=true; 
	} 
}
}
setChecks('<%=comp_mode %>','cd_comp_mode');

</script>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
tempUserIno=null;
}
%>
