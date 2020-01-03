<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="member_opt_sub.jsp";
String mypy="member_info_sub";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));

String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id
String mem_no=Common.getFormatStr(request.getParameter("mem_no"));//会员编号

String memberId  = Common.getFormatStr(request.getParameter("memberId"));

String tempUserIno[][]=null;//会员临时信息

String tempUserIno1[][]=null;//会员临时信息
int result =0;
if(myvalue.equals(""))
{   
    tempUserIno=DataManager.fetchFieldValue(pool,mypy,"id","mem_no='"+mem_no+"'");	
    if(tempUserIno!=null){	  
   	   myvalue=Common.getFormatStr(tempUserIno[0][0]);
	}else{
	    String sqlMemberSub ="insert into member_info_sub(mem_no) values('"+mem_no+"')";
	    result = DataManager.dataOperation(pool,sqlMemberSub);
		
		tempUserIno1=DataManager.fetchFieldValue(pool,mypy,"id","mem_no='"+mem_no+"'");
		 if(tempUserIno1!=null&&tempUserIno1[0][0]!=null){
		     myvalue=Common.getFormatStr(tempUserIno1[0][0]);
		 }
	}
}
String urlpath="../member/member_opt_sub.jsp?myvalue="+myvalue+"&mem_no="+mem_no+"&memberId="+memberId;

try{//====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会员管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<script>

var comOwnSubCategory = new Array();
<cache:cache key="cache_subcategory11111" cron="0 0/30 6-23 * * ?">
<%	
String[][]comOwnSubCategory = DataManager.fetchFieldValue(pool, "member_catalog_info","num,name,parentid", "parentid<>1");
if(comOwnSubCategory!=null){
	for(int i=0;i<comOwnSubCategory.length;i++){
%>
	comOwnSubCategory[<%=i%>]=['<%=comOwnSubCategory[i][0]%>','<%=comOwnSubCategory[i][1]%>','<%=comOwnSubCategory[i][2]%>']; 
<%
	   }
	}
%>
</cache:cache>
function set_comp_ownsubcategory(obj){
	
	var sub = document.getElementById("zd_comp_ownsubcategory");
	sub.length=0;
	sub.options[0]=new Option('选择子分类','');
	for(var i=0,j=1;i<comOwnSubCategory.length;i++){
		if(comOwnSubCategory[i][0].length>3 && comOwnSubCategory[i][0].substring(0,3)==obj){
			sub.options[j]=new Option(comOwnSubCategory[i][1],comOwnSubCategory[i][0]);
			j++;
		}
	}
}
//为多选框赋值
function submityn(){

var obj2 = document.getElementsByName("fittings_pubcomp_catalog");
var fittingsPubcompCatalogValue = ",";
for(var i=0;i<obj2.length;i++){
	if(obj2[i].checked){
		fittingsPubcompCatalogValue += obj2[i].value+",";
	}
}
if(fittingsPubcompCatalogValue==",") fittingsPubcompCatalogValue="";
document.theform.zd_fittings_pubcomp_catalog.value = fittingsPubcompCatalogValue;	

$("#zd_mem_flag_name").val($("select[name='zd_mem_flag'] option[selected]").text());
document.theform.submit();
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
      <td align="right" nowrap class="list_left_title"><strong>用 户 名：</strong></td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" size="18" value="<%=mem_no%>" >
	  <a href="member_opt.jsp?myvalue=<%=memberId%>&mem_no=<%=mem_no%>"><font color="#FF0000">会员基本信息(New)</font>      </td>
    </tr>
	 <tr>
      <td align="right" nowrap class="list_left_title"><strong>会员收费：</strong></td>
      <td class="list_cell_bg"><input name="zd_per_paymoney" type="text" id="zd_per_paymoney" size="18"  >      </td>
    </tr>
	<tr>
		  <td align="right" nowrap class="list_left_title"><strong>原会员级别：</strong></td>
		  <td class="list_cell_bg"><select name="zd_old_mem_flag" id="zd_old_mem_flag">
			  <option value="">请选择原级别</option>
			  <%=Common.option_str(pool, "member_role","role_num,role_name"," 1=1 order by role_num", "",0)%>
			</select>
			原级别到期时间：
			<input type="text" name="zd_old_mem_flag_enddate" id="zd_old_mem_flag_enddate" onFocus="calendar(event)"/>		  </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司性质：</td>
      <td height="22" class="list_cell_bg"><select name="zd_comp_prop" id="zd_comp_prop">
			  <option value=""></option>
			  <option value="1">私营</option>
			  <option value="2">集体</option>
			  <option value="3">联营</option>
			  <option value="4">股份</option>
			  <option value="5">中外合作</option>
			  <option value="6">中外合资</option>
			  <option value="7">外资</option>
			  <option value="8">国有</option>
        </select>      </td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap class="list_left_title">经营模式：</td>
      <td height="22" class="list_cell_bg"><select name="zd_comp_mode" id="zd_comp_mode">
			  <option value=""></option>
			  <option value="1">生产销售</option>
			  <option value="2">代理销售</option>
			  <option value="3">租赁</option>
			  <option value="4">二手改装/销售</option>
			  <option value="5">检测维修</option>
			  <option value="6">配套</option>
			  <option value="7">其他</option>
        </select>      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">所属类别：</td>
      <td height="22" class="list_cell_bg"><select name="zd_comp_owncategory" id="zd_comp_owncategory" onChange="set_comp_ownsubcategory(this.value);" style="width:100px;"  class="blue1"><option value="">请选择分类</option><cache:cache key="member_catalog_info11" cron="0 0/30 6-23 * * ?">
          		<%=Common.option_str(pool,"member_catalog_info","num,name","parentid=1","",0) %></cache:cache>
            </select>
			<select  name="zd_comp_ownsubcategory" id="zd_comp_ownsubcategory" style="width:100px;" class="blue1">
			<option value="">选择子分类</option>
			</select>	</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">主营业务：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_mainbusiness" type="text" id="zd_comp_mainbusiness" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">个人手机：</td>
      <td height="22" class="list_cell_bg"><input name="zd_per_mobile_phone" type="text" id="zd_per_mobile_phone" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title ">公司联系人MSN：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_msn" type="text" id="zd_comp_msn" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title ">所在部门：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_depart" type="text" id="zd_comp_depart" size="28" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">职务信息：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_posi" type="text" id="zd_comp_posi" size="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司联系人手机：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_mobile_phone" type="text" id="zd_comp_postcode" size="15"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司联系人QQ：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_qq" type="text" id="zd_comp_qq" size="15"></td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司联系人Email：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_email" type="text" id="zd_comp_email" size="15"></td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司联系人电话：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_phone" type="text" id="zd_comp_phone" size="15"></td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">企业动画展示小图：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_cartoonimg" type="text" id="zd_comp_cartoonimg" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=27&dir=fittings&fieldname=zd_comp_cartoonimg','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_cartoonimg').val(),'winpic',400,300);">预览</a></td>
    </tr>
	
	 <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">企业动画展示flash：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_cartoonflash" type="text" id="zd_comp_cartoonflash" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=27&dir=fittings&fieldname=zd_comp_cartoonflash','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_cartoonflash').val(),'winpic',400,300);">预览</a></td>
    </tr>	
    <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">企业宣传片：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_trailer" type="text" id="zd_comp_trailer" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=27&dir=fittings&fieldname=zd_comp_trailer','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_trailer').val(),'winpic',400,300);">预览</a></td>
    </tr>
	  <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">企业形象flash：</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_flash" type="text" id="zd_comp_flash" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=27&dir=fittings&fieldname=zd_comp_flash','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_flash').val(),'winpic',400,300);">预览</a></td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">企业形象图片:</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_image" type="text" id="zd_comp_image" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=27&dir=fittings&fieldname=zd_comp_image','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_image').val(),'winpic',400,300);">预览</a></td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap bgcolor="#FF9966" class="list_left_title">企业介绍小图片:</td>
      <td height="22" bgcolor="#FF9966" class="list_cell_bg"><input name="zd_comp_intro_image" type="text" id="zd_comp_intro_image" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=27&dir=fittings&fieldname=zd_comp_intro_image','upload',480,150)">
        <a href="#" onClick="javascript:openWin($('#zd_comp_intro_image').val(),'winpic',400,300);">预览</a></td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap class="list_left_title">是否加入配套网企业库:</td>
      <td height="22" class="list_cell_bg">
        <input name="zd_fittings_iscomplib" type="radio" id="zd_fittings_iscomplib" value="0" checked />
        否
        <input name="zd_fittings_iscomplib" id="zd_fittings_iscomplib" type="radio" value="1" />
        是</td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap class="list_left_title">是否为配套网品牌宣传企业:</td>
      <td height="22" class="list_cell_bg">
        <input name="zd_fittings_ispubcomp" type="radio" id="zd_fittings_ispubcomp" value="0" checked />
        否
        <input name="zd_fittings_ispubcomp" id="zd_fittings_ispubcomp" type="radio" value="1" />
        是</td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">配套网品牌宣传企业栏目:</td>
      <td height="22" class="list_cell_bg">
         <input type="checkbox" id="fittings_pubcomp_catalog" name="fittings_pubcomp_catalog" value="1" style="border:0";/>公司介绍&nbsp;&nbsp;
		 <input type="checkbox" id="fittings_pubcomp_catalog" name="fittings_pubcomp_catalog" value="2" style="border:0";/>产品展示&nbsp;&nbsp;
		 <input type="checkbox" id="fittings_pubcomp_catalog" name="fittings_pubcomp_catalog" value="3" style="border:0";/>企业专题&nbsp;&nbsp;
		 <input type="checkbox" id="fittings_pubcomp_catalog" name="fittings_pubcomp_catalog" value="4" style="border:0";/>企业宣传片&nbsp;&nbsp; <br />
		 <input type="checkbox" id="fittings_pubcomp_catalog" name="fittings_pubcomp_catalog" value="5" style="border:0";/>服务案例&nbsp;&nbsp;
		 <input type="checkbox" id="fittings_pubcomp_catalog" name="fittings_pubcomp_catalog" value="6" style="border:0";/>视频专访&nbsp;&nbsp;
		 <input type="checkbox" id="fittings_pubcomp_catalog" name="fittings_pubcomp_catalog" value="7" style="border:0";/>招商合作&nbsp;&nbsp;
		 <input type="checkbox" id="fittings_pubcomp_catalog" name="fittings_pubcomp_catalog" value="8" style="border:0";/>联系我们&nbsp;&nbsp;	   </td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap  class="list_left_title">配套网公告：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_fittings_bulletin" cols="60" rows="3" id="zd_fittings_bulletin"></textarea></td>
    </tr>
	 <tr>
      <td height="22" align="right" nowrap class="list_left_title">配套网服务：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_fittings_service" cols="60" rows="3" id="zd_fittings_service"></textarea></td>
    </tr>
     <tr>
      <td height="22" align="right" nowrap class="list_left_title">招商政策：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_fittings_businepolic" cols="60" rows="3" id="zd_fittings_businepolic"></textarea></td>
    </tr>
     <tr>
       <td height="22" align="right" nowrap class="list_left_title">会员申请：</td>
       <td height="22" class="list_cell_bg"><input name="zd_member_type_apply" type="text" id="zd_member_type_apply" size="50"></td>
     </tr>
	
	 
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
		<input type="hidden" id="zd_fittings_pubcomp_catalog" name="zd_fittings_pubcomp_catalog" style="border:0";/ >      </td>
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
