﻿<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@ include	file="/manage/config.jsp"%>
<%
	PoolManager pool3 = new PoolManager(3);
	Connection conn = null;
	String tablename = "equipment";	
	String mem_no ="",mem_flag="";
	String comp_id = "",rent_mode="";

	String find_rent_state  = Common.getFormatStr(request.getParameter("find_rent_state"));
    String find_category = Common.getFormatStr(request.getParameter("find_category"));
	String find_brand    = Common.getFormatStr(request.getParameter("find_brand"));
    String find_model    = Common.getFormatStr(request.getParameter("find_model"));

    String findOrderFlag = Common.getFormatStr(request.getParameter("findOrderFlag")); //获得排序方式
	String findOrderTag  = Common.getFormatStr(request.getParameter("findOrderTag")); //排序类别
	

	String orderStr ="";  //排序
	
	if(!findOrderFlag.equals("") && !findOrderTag.equals("")){  //排序
	    orderStr += " order by "+findOrderFlag+" "+findOrderTag;
	}else{
	    orderStr += " order by pubdate desc";
		findOrderFlag ="pubdate";
		findOrderTag  ="desc";
	}
		
	HashMap memberInfo = new HashMap();
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
		mem_flag= String.valueOf(memberInfo.get("mem_flag")); 

		//add by gaopeng at 20130418
		comp_id = Common.getFormatStr(memberInfo.get("id")) ;
		rent_mode = Common.getFormatStr(memberInfo.get("rent_mode"));
	}	
	Pagination pagination = new Pagination();                   //设置每页显示条数
	pagination.setCountOfPage(20);
	 
	StringBuffer query = new StringBuffer("select id,place,is_sale,category,brandname,model,img1,title,factorydate,workingtime,pubdate from " + tablename
			+ " where 1=1 ");   //得到参数		
   
	query.append(" and mem_no='" + mem_no + "'");		
	if(!find_rent_state.equals("")){query.append(" and rent_state='"+find_rent_state+"'");}
	if(!find_category.equals("")){query.append(" and category='"+find_category+"'");}
	if(!find_brand.equals("")){query.append(" and brand='"+find_brand+"'");}
	if(!find_model.equals("")){query.append(" and model like '%"+find_model+"%'");}
	
	query.append(orderStr);  //排序
	
	String place="",is_sale="",img1="";
	String title="",factorydate="",workingtime="";
	
	//System.out.println(query);
	try {
		conn = pool3.getConnection();  //SQL查询	
		ResultSet rs = pagination.getQueryResult(query.toString(),request, conn, 1);
		String bar   = pagination.pagesPrint(10); //读取分页提
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js" type="text/javascript"></script>
<script>

	function modifyData(objstr)
	{	
		  self.location="equipment_opt.jsp?myvalue="+encodeURIComponent(objstr);		
	}
	 
function submitSearch(obj1){	
	 document.theform.findOrderFlag.value=obj1;	 
	 var obj2 = document.getElementById("findOrderTag").value;	
	 if(obj2=="asc"){
	   document.getElementById(obj1).innerText="↓";
	   document.theform.findOrderTag.value="desc";
	 }else{
	   document.getElementById(obj1).innerText="↑";
	   document.theform.findOrderTag.value="asc";
	 }
	  document.theform.submit();		
	}
   function setFlag(flag){
			var checkdel = document.getElementsByName('checkdel');
			var checkedFlag=false;
				for(i=0;i<checkdel.length;i++){
					if(checkdel[i].checked){
					  checkedFlag = true;
					}
				}
				if(checkedFlag){
					if(confirm("确定这样操作吗？")){
						document.theform.action = "tool.jsp?flag="+flag;
						document.theform.target = "hiddenFrame";
						document.theform.method = "post";
						document.theform.submit();
					}
				}else{
				  alert("请选择要更新的信息！");
				}	
			}
</script>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
  <div class="loginlist_right">
    <div class="loginlist_right2"> <span class="mainyh" style="float:left;">管理租赁设备信息</span> <%if(mem_flag.equals("1005")){ %><div style="width:120px; float:right;line-height:35px; font-weight:bold;"><a href="http://www.21-rent.com/shop/shopdetail<%=rent_mode %>_for_<%=comp_id %>.htm" target="_blank">进入我的店铺&gt;&gt;</a><%} %></div>
    <div class="loginlist_right1">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>状态:&nbsp;
				          <select name="find_rent_state">
									 <option value="">请选择</option>
									 <option value="1" <%=find_rent_state.equals("1")?"Selected":""%>>待租</option>
									 <option value="2" <%=find_rent_state.equals("2")?"Selected":""%>>施工中</option>
						  </select>&nbsp;&nbsp;&nbsp;										
			      设备类别:&nbsp;
				<select name="find_category" id="find_category">
                    <option value=""> --请选择类别-- </option>
                    <option value="01" <%=find_category.equals("01")?"Selected":""%>>路面机械</option>
                    <option value="0101" <%=find_category.equals("0101")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;摊铺机</option>
                    <option value="0102" <%=find_category.equals("0102")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;压路机</option>
                    <option value="0103" <%=find_category.equals("0103")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;平地机</option>
                    <option value="0104" <%=find_category.equals("0104")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;铣刨机 </option>
                    <option value="0105" <%=find_category.equals("0105")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;推土机</option>
                    <option value="0106" <%=find_category.equals("0106")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;沥青搅拌站</option>
                    <option value="0107" <%=find_category.equals("0107")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
                    <option value="02" <%=find_category.equals("02")?"Selected":""%>>起重机系列</option>
					<option value="0201" <%=find_category.equals("0201")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;塔吊</option>
                    <option value="0202" <%=find_category.equals("0202")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;履带吊</option>
					<option value="0203" <%=find_category.equals("0203")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;汽车吊</option>
					<option value="0204" <%=find_category.equals("0204")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;龙门吊</option>
					<option value="0205" <%=find_category.equals("0205")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;高空作业车</option>
					<option value="0207" <%=find_category.equals("0207")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;叉车</option>
					<option value="0206" <%=find_category.equals("0206")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="03" <%=find_category.equals("03")?"Selected":""%>>混凝土系列</option>
					<option value="0301" <%=find_category.equals("0301")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;泵车</option>
                    <option value="0302" <%=find_category.equals("0302")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;搅拌运输车</option>
					<option value="0303" <%=find_category.equals("0303")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;搅拌站</option>
					<option value="0304" <%=find_category.equals("0304")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;搅拌车</option>
					<option value="0305" <%=find_category.equals("0305")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;拖泵</option>
					<option value="0306" <%=find_category.equals("0306")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="04" <%=find_category.equals("04")?"Selected":""%>>土石方系列</option>
					<option value="0401" <%=find_category.equals("0401")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;挖掘机</option>
                    <option value="0402" <%=find_category.equals("0402")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;推土机</option>
					<option value="0403" <%=find_category.equals("0403")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;定向钻机</option>
					<option value="0404" <%=find_category.equals("0404")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;装载机</option>
					<option value="0405" <%=find_category.equals("0405")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;自卸车</option>
					<option value="0406" <%=find_category.equals("0406")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;挖掘装载机</option>
					<option value="0407" <%=find_category.equals("0407")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="05" <%=find_category.equals("05")?"Selected":""%>>动力设备</option>
					<option value="0501" <%=find_category.equals("0501")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;发电机组</option>
                    <option value="0502" <%=find_category.equals("0502")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;发动机</option>
					<option value="0503" <%=find_category.equals("0503")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;空压机</option>
					<option value="0504" <%=find_category.equals("0504")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="06" <%=find_category.equals("06")?"Selected":""%>>市政机械</option>
					<option value="0601" <%=find_category.equals("0601")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;清扫机</option>
                    <option value="0602" <%=find_category.equals("0602")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;除雪机</option>
					<option value="0603" <%=find_category.equals("0603")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;排障车</option>
					<option value="0604" <%=find_category.equals("0604")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;洒水车</option>
					<option value="0605" <%=find_category.equals("0605")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="07" <%=find_category.equals("07")?"Selected":""%>>桩工桥梁机械</option>
					<option value="0701" <%=find_category.equals("0701")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;旋挖钻</option>
                    <option value="0702" <%=find_category.equals("0702")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;潜孔钻机</option>
					<option value="0703" <%=find_category.equals("0703")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;打桩机</option>
					<option value="0704" <%=find_category.equals("0704")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;水平定向钻</option>
					<option value="0705" <%=find_category.equals("0705")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;连续墙抓斗</option>
					<option value="0706" <%=find_category.equals("0706")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;架桥机</option>
					<option value="0707" <%=find_category.equals("0707")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="09" <%=find_category.equals("09")?"Selected":""%>>破碎设备</option>
					<option value="0901" <%=find_category.equals("0901")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;破碎锤</option>
                    <option value="0902" <%=find_category.equals("0902")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;液压剪</option>
					<option value="0903" <%=find_category.equals("0903")?"Selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="08" <%=find_category.equals("08")?"Selected":""%>>其它机械</option>
                  </select>
				&nbsp;
	
				<select name="find_brand" id="find_brand">
                    <option value=""> --请选择品牌-- </option>
					<option value="174" <%=find_brand.equals("174")?"Selected":""%>>卡特彼勒</option>
					<option value="175" <%=find_brand.equals("175")?"Selected":""%>>沃尔沃</option>
					<option value="182" <%=find_brand.equals("182")?"Selected":""%>>小松</option>
					<option value="214" <%=find_brand.equals("214")?"Selected":""%>>维特根</option>
					<option value="192" <%=find_brand.equals("192")?"Selected":""%>>斗山</option>
					<option value="209" <%=find_brand.equals("209")?"Selected":""%>>徐工</option>
					<option value="133" <%=find_brand.equals("133")?"Selected":""%>>三一</option>
					<option value="134" <%=find_brand.equals("134")?"Selected":""%>>中联</option>
					<option value="212" <%=find_brand.equals("212")?"Selected":""%>>戴纳派克</option>
					<option value="144" <%=find_brand.equals("144")?"Selected":""%>>山推</option>
					<option value="ygsl" <%=find_brand.equals("ygsl")?"Selected":""%>>英格索兰</option>
					<option value="137" <%=find_brand.equals("137")?"Selected":""%>>临工</option>
					<option value="139" <%=find_brand.equals("139")?"Selected":""%>>厦工</option>
					<option value="136" <%=find_brand.equals("136")?"Selected":""%>>柳工</option>
					<option value="184" <%=find_brand.equals("184")?"Selected":""%>>日立</option>
					<option value="183" <%=find_brand.equals("183")?"Selected":""%>>神钢</option>
					<option value="abg" <%=find_brand.equals("abg")?"Selected":""%>>ABG陕建</option>
					<option value="673" <%=find_brand.equals("673")?"Selected":""%>>洛阳路通</option>
					<option value="142" <%=find_brand.equals("142")?"Selected":""%>>山河智能</option>																																													
					<option value="other" <%=find_brand.equals("other")?"Selected":""%>>其它品牌</option>
                  </select>
					设备型号:&nbsp;
					<input name="find_model" type="text" id="find_model" value="<%=find_model%>" size="20" maxlength="28"/>
					&nbsp;		       <input type="submit" name="Submit" value=""
							style="width: 52px; height: 19px; border: none; background: url(../images/bottom06.gif) left top no-repeat; cursor: pointer;">&nbsp;&nbsp;		            								
							<input type="button" name="Submit2" value=""
							style="width: 52px; height: 19px; border: none; background: url(../images/bottom07.gif) left top no-repeat; cursor: pointer;"
							onClick="javascript:clearForm()">
						</td>					
					</tr>
				</table>
		<div style="width:100%;height:29px;padding:5px 0px;">
      <span class="title_bar">
	  <a href="javascript:setFlag('0');" style="width:80px;float:left" title="批量更新信息的发布时间，以便让信息在前面显示"><img src="../images/plgx.gif" border="0"/></a>
      <input name="add_b" type="button" class="form_button" id="add_b" value=""	style="width: 78px; height: 29px; border: none; background: url(../images/bottom03.gif) left top no-repeat; cursor: pointer;"
								onclick="window.location.href='equipment_opt.jsp'">
      </span>
      </div>
      <table width="100%" border="0" class="list">
        <tr>		  
		  <th width="2%" align="center"><input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" /></th>
          <th width="8%" ><div align="left">序号</div></th>
		  <th width="31%"><div align="left">标题</div></th> 
          <th width="9%"><div align="left"><a href="javascript:submitSearch('factorydate');">出厂年份<font <%if(findOrderFlag.equals("factorydate"))out.print("color='#20639A' size='3'");%>><span id="factorydate"><%if(findOrderFlag.equals("factorydate")){ out.print(findOrderTag.equals("desc")?"↓":"↑");}%></span></font></a></div></th>
          <th width="15%" ><div align="left"><a href="javascript:submitSearch('workingtime');">工作时间(小时)<font <%if(findOrderFlag.equals("workingtime"))out.print("color='#20639A' size='3'");%>><span id="workingtime"><%if(findOrderFlag.equals("workingtime")){ out.print(findOrderTag.equals("desc")?"↓":"↑");}%></span></font></a></div></th>
          <th width="11%" ><div align="left"><a href="javascript:submitSearch('pubdate');">发布日期<font <%if(findOrderFlag.equals("pubdate"))out.print("color='#20639A' size='3'");%>><span id="pubdate"><%if(findOrderFlag.equals("pubdate")){ out.print(findOrderTag.equals("desc")?"↓":"↑");}%></span></font></a></div></th>
          <th width="26%" ><div align="center">操作</div></th>
        </tr>
		<%
			int k = pagination.getCurrenPages()	* pagination.getCountOfPage()- pagination.getCountOfPage();			
			while (rs != null && rs.next()) {
			k = k + 1;			
			/*place   = Common.getFormatInt(rs.getString("place"));
			is_sale  = Common.getFormatInt(rs.getString("is_sale"));
			//out.println(rs.getString("id"));
			img1     = Common.getFormatStr(rs.getString("img1"));
			if(!img1.equals("")){
				if(img1.indexOf("/")!=-1){
				    img1 = img1.substring(img1.lastIndexOf("/")+1,img1.length());
				}
			}*/
			
			title        = Common.getFormatStr(rs.getString("title"));
			factorydate  = Common.getFormatStr(rs.getString("factorydate"));
			workingtime  = Common.getFormatStr(rs.getString("workingtime"));			
		%>
        <tr>
			<td height="30" align="center">
	       <input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" /></td>
            <td><div align="left"><%=k%></div></td>		
			<td><div align="left"><a href="javascript:modifyData('<%=Common.encryptionByDES(rs.getString("id"))%>');"><%=Common.getFormatStr(rs.getString("title"))%></a></div></td>
			<td><div align="left"><%=Common.getFormatStr(rs.getString("factorydate"))%></div></td>
			<td><div align="left"><%=Common.getFormatStr(rs.getString("workingtime"))%></div></td>
			<td><div align="left"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></div></td>
          <td><div align="center"><span class="p92j"><!--<a href="javascript:otherDeleteData('../usedmarket/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>-->&nbsp;&nbsp; <a href="javascript:modifyData('<%=Common.encryptionByDES(rs.getString("id"))%>');">修改</a>&nbsp;&nbsp;<a href="update_pubdate.jsp?mypy=<%=Common.encryptionByDES(tablename)%>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>&urlpath=equipment_list.jsp&mem_flag=<%=mem_flag%>">更新</a>&nbsp;&nbsp;<a href="http://www.21-rent.com/equipment/detail_for_<%=Common.getFormatStr(rs.getString("id")) %>.htm" target="_blank">预览</a>
		 
		  </span></div>
		   </td>
        </tr>
		<%
			}
		%>
      </table>
      <table width="100%" border="0" class="list">
        <tr>
          <td align="left"><%=bar%></td>
        </tr>
      </table>
    </div>
  </div>
<input type="hidden" name="findOrderFlag" id="findOrderFlag" />
<input type="hidden" name="findOrderTag"  id="findOrderTag"  value="<%=findOrderTag%>" >
<input name="tablename" id="tablename"  type="hidden" value="<%=Common.encryptionByDES(tablename)%>"/>
</form>
<iframe name="hiddenFrame" style="display:none"></iframe>
</body>
</html>

<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool3.freeConnection(conn);
	}
%>


