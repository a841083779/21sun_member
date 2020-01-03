<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
ResultSetMetaData rsmd = null;
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");

String flagvalue = Common.getFormatInt(request.getParameter("flagvalue"));  //是否为修改
String zd_mem_no="",zd_mem_name="",zd_per_sex="",zd_per_province="",zd_per_city="",zd_per_email="",zd_per_phone="",zd_per_mobile_phone="";
String zd_qq="";
String sqlMemInfo="",sqlMemInfoSub="";
String per_mobile_phone="",mem_no_sub="";
int result=0;
try{
	conn = pool.getConnection();
	
	per_mobile_phone = Common.getFormatStr(memberInfo.get("per_mobile_phone"));
	mem_no_sub       = Common.getFormatStr(memberInfo.get("mem_no_sub"));	
	
	if(flagvalue.equals("1")){
	   zd_mem_no = Common.getFormatStr(request.getParameter("zd_mem_no"));
	   zd_mem_name = Common.getFormatStr(request.getParameter("zd_mem_name"));
	   zd_per_sex = Common.getFormatStr(request.getParameter("zd_per_sex"));
	   zd_per_province = Common.getFormatStr(request.getParameter("zd_per_province"));
	   zd_per_city = Common.getFormatStr(request.getParameter("zd_per_city"));
	   zd_per_email = Common.getFormatStr(request.getParameter("zd_per_email"));
	   zd_per_phone = Common.getFormatStr(request.getParameter("zd_per_phone"));
	   zd_per_mobile_phone = Common.getFormatStr(request.getParameter("zd_per_mobile_phone"));
   	   zd_qq = Common.getFormatStr(request.getParameter("zd_per_qq"));   
	   if(!zd_mem_no.equals("")){   
		 sqlMemInfo = "update member_info set mem_name='"+zd_mem_name+"',per_sex='"+zd_per_sex+"',per_province='"+zd_per_province+"',per_city='"+zd_per_city+"',per_email='"+zd_per_email+"',per_phone='"+zd_per_phone+"',per_qq='"+zd_qq+"' where mem_no='"+zd_mem_no+"'";
		
		 result = DataManager.dataOperation(pool,sqlMemInfo);
		 		
		 if(mem_no_sub.equals(zd_mem_no)){ //扩展表和主表的mem_no相同
		   sqlMemInfoSub = "update member_info_sub set per_mobile_phone='"+zd_per_mobile_phone+"' where mem_no ='"+zd_mem_no+"'";
		   
		   result=DataManager.dataOperation(pool,sqlMemInfoSub);
		 }else{
		    sqlMemInfoSub = "insert member_info_sub (mem_no,per_mobile_phone) values('"+zd_mem_no+"','"+zd_per_mobile_phone+"')";
			
		    result = DataManager.dataOperation(pool,sqlMemInfoSub);
		 }	 
	   }
	   
	   if(result>0){
		out.print("<script>alert('个人资料设置成功!');window.location.href='user_info_opt.jsp';</script>");
		}else{
		out.print("<script>window.location.href='user_info_opt.jsp';</script>"); 
		}	
	   
     }
	 	 	 
	String querySql = "select * from vi_member_info where mem_no=?";	
	pstmt = conn.prepareStatement(querySql);
	pstmt.setString(1, (String)memberInfo.get("mem_no"));	
	rs = pstmt.executeQuery();	
	if (rs != null && rs.next()) {
		rsmd = rs.getMetaData();
		for (int i = 1; i <= rsmd.getColumnCount(); i++) {
           memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
		}
		session.setAttribute("memberInfo",memberInfo);
	}
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>

<script type="text/javascript">
  function submityn(){
	document.theform.flagvalue.value="1";
	document.theform.submit();
  }  
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">个人资料设置</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。</td>
      </tr>
    </table>
    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" class="tablezhuce">
      <form method="post" name="theform" id="theform">
        <tr>
          <td  nowrap="nowrap"  class="right"><span class="grayb">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span></td>
          <td ><%=memberInfo.get("mem_no")%></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">真实姓名：</span></td> 
          <td height="22" ><input name="zd_mem_name" type="text" id="zd_mem_name" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("mem_name"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">性　　别：</span></td>
          <td height="22" ><input name="zd_per_sex" type="radio" value="男" <%=Common.getFormatStr(memberInfo.get("per_sex")).equals("男")?"checked='checked'":""%> style="border:0;"/>
            先生
            <input type="radio" name="zd_per_sex" value="女"  style="border:0;" <%=Common.getFormatStr(memberInfo.get("per_sex")).equals("女")?"checked='checked'":""%>/>
            女士			</td>
        </tr>
		 <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">省　　市：</span></td>
          <td height="22" ><select name="zd_per_province" id="zd_per_province" onchange="set_city(this,this.value,theform.zd_per_city,'');" style="width:100px;"  class="validate-selection">
              <option value="">选择省份</option>
              <option value="北京">北京</option>
              <option value="上海">上海</option>
              <option value="天津">天津</option>
              <option value="重庆">重庆</option>
              <option value="河北">河北</option>
              <option value="山西">山西</option>
              <option value="辽宁">辽宁</option>
              <option value="吉林">吉林</option>
              <option value="黑龙江">黑龙江</option>
              <option value="江苏">江苏</option>
              <option value="浙江">浙江</option>
              <option value="安徽">安徽</option>
              <option value="福建">福建</option>
              <option value="江西">江西</option>
              <option value="山东">山东</option>
              <option value="河南">河南</option>
              <option value="湖北">湖北</option>
              <option value="湖南">湖南</option>
              <option value="广东">广东</option>
              <option value="海南">海南</option>
              <option value="四川">四川</option>
              <option value="贵州">贵州</option>
              <option value="云南">云南</option>
              <option value="陕西">陕西</option>
              <option value="甘肃">甘肃</option>
              <option value="青海">青海</option>
              <option value="内蒙古">内蒙古</option>
              <option value="广西">广西</option>
              <option value="西藏">西藏</option>
              <option value="宁夏">宁夏</option>
              <option value="新疆">新疆</option>
              <option value="台湾">台湾</option>
              <option value="香港">香港</option>
              <option value="澳门">澳门</option>
            </select>
              <select  name="zd_per_city" id="zd_per_city"  style="width:100px;">
                <option>选择城市</option>
            </select></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">联系邮箱：</span></td>
          <td height="22" ><input name="zd_per_email" type="text" id="zd_per_email" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("per_email"))%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">联系电话：</span></td>
          <td height="22" ><input name="zd_per_phone" type="text" id="zd_per_phone" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("per_phone"))%>"  class="moren"/></td>
        </tr>
       
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">联系手机：</span></td>
          <td height="22" ><input name="zd_per_mobile_phone" type="text" id="zd_per_mobile_phone" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("per_mobile_phone"))%>"  class="moren"/></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">个人QQ：</span></td>
          <td height="22" ><input name="zd_per_qq" type="text" id="zd_per_qq" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("per_qq"))%>"  class="moren"/></td>
        </tr>
		
		 <tr>
          <td height="22"></td><td  align="center"  bgcolor="#FFFFFF"> <input type="button" id="submitId" name="Submit" value="保 存" class="tijiao" style="cursor:pointer"  onClick="submityn()"/></td>
        </tr>	
		<input name="flagvalue" type="hidden" id="flagvalue"  />
			   <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=memberInfo.get("mem_no")%>" />
      </form>
    </table>
  </div>
</div>
<script   language="javascript">

document.theform.zd_per_province.value="<%=Common.getFormatStr(memberInfo.get("per_province"))%>";
set_city(theform.zd_per_province,theform.zd_per_province.value,theform.zd_per_city,'');
document.theform.zd_per_city.value="<%=Common.getFormatStr(memberInfo.get("per_city"))%>";
</script>
<script type="text/javascript">
function f_frameStyleResize(targObj)   
{   
  var   targWin   =   targObj.parent.document.all[targObj.name]; 
  if(targWin   !=   null)   
  {   
  var   HeightValue   =   targObj.document.body.scrollHeight   
  if(HeightValue   <100){HeightValue   =490}   //不小于540  
   targWin.height   =   HeightValue;
  }   
}  
function   f_iframeResize()   
{
  f_frameStyleResize(self);
}  
window.onload=f_iframeResize;
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
