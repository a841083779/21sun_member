<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>

<%
  
    PoolManager pool1 = new PoolManager(1);
	//=====页面属性====
	String pagename="store_style.jsp";
	String mypy="member_info";
	
	//====得到参数====	
	String mem_no ="";
	HashMap memberInfo = new HashMap();
	if(session.getAttribute("memberInfo")!=null){   
		memberInfo = (HashMap) session.getAttribute("memberInfo");
		mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
	}	
    String tempInfo[][]=DataManager.fetchFieldValue(pool1, "member_info","top 1 id,rent_mode", "mem_no='"+mem_no+"'");
	String myvalue  = "";	
	String urlpath="../rent/store_style.jsp";
	String mode="";
	
	if(!myvalue.equals("")){
	   urlpath=urlpath+"?myvalue="+java.net.URLEncoder.encode(myvalue,"UTF-8");  
	   
	}
	
 try{
	if(tempInfo!=null){ 
	   myvalue=Common.encryptionByDES(tempInfo[0][0]);
	   mode   =Common.getFormatInt(tempInfo[0][1]);
	   urlpath=urlpath+"?myvalue="+myvalue;	  
	}
%>
<html>
<head>
<title>出租信息－中国工程机械租赁网,租赁,求租,出租,招租,</title>
<meta name="keywords" content="租赁,出租,求租,制造,供应,销售商,生产商,求租,行情,价格">
<meta name="description"
			content="中国工程机械租赁网,中国工程机械网,挖掘机,装载机,推土机,履带吊,汽车吊,平地机,压路机,搅拌站,摊铺机,塔吊,路面机械租赁,拌和站,砼搅拌,输送泵,混凝土机械,沥青机械,铣刨机,牵引车,发电机组,是最大的工程机械网站,门户网站,为您提供最多的市场租赁信息">
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>		
		function refresh(){
			document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
		}//为多选框赋值
		function submityn(){		 		
			document.theform.submit();
		}	
	</script>
<body topmargin="0" leftmargin="0">
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
  <div class="loginlist_right">
    <div class="loginlist_right2"><span class="mainyh">租赁店铺管理</span></div>
    <div class="loginlist_right1">    
      <div align="center">
        <center>
          <table border="0" cellpadding="0" cellspacing="0" width="90%" height="242">
		
         <tr>
		  <td align="left" height="75"><div align="center"><strong>店铺风格：</strong></div></td>		 	
           <td width="28%" align="center" height="196"><div align="center">
                  <table border="0" cellpadding="0" cellspacing="0"	width="95%">
                    <tr>
                      <td width="100%" align="center" class="p92"><img border="0" src="../images/mo-01.jpg"> </td>
                    </tr>
                    <tr>
                      <td width="100%" align="center" class="p92"><input type="radio" value="1" name="zd_rent_mode" <%=mode.equals("1")?"checked":""%>>
                        <nobr>蓝色调风格<%=mode.equals("1")?"(<font color=red>当前风格</font>)":""%></nobr></td>
                    </tr>
                  </table>
              </div></td>
              <td width="29%" align="center" height="196"><div align="center">
                  <table border="0" cellpadding="0" cellspacing="0"
														width="95%">
                    <tr>
                      <td width="100%" align="center" class="p92"><img border="0" src="../images/mo-02.jpg"> </td>
                    </tr>
                    <tr>
                      <td width="100%" align="center" class="p92"><input type="radio" value="0" name="zd_rent_mode" <%=mode.equals("0")?"checked":""%>>
                        <nobr>黄色调风格<%=mode.equals("0")?"(<font color=red>当前风格</font>)":""%></nobr></td>
                    </tr>
                  </table>
              </div></td>
              <td width="29%" align="center" height="196"><div align="center">
                  <table border="0" cellpadding="0" cellspacing="0" width="95%">
                    <tr>
                      <td width="100%" align="center" class="p92"><img border="0" src="../images/mo-03.jpg"> </td>
                    </tr>
                    <tr>
                      <td width="100%" align="center" class="p92"><input type="radio" value="2" name="zd_rent_mode" <%=mode.equals("2")?"checked":""%>>
                        <nobr>红色调风格<%=mode.equals("2")?"(<font color=red>当前风格</font>)":""%></nobr></td>
                    </tr>
                  </table>
              </div></td>
            </tr>
			<tr>
		     <td width="14%" height="75" align="left"><div align="center"><strong>店铺公告：</strong></div></td>
             <td align="left" height="75" colspan="3" valign="middle"> &nbsp;
               <textarea rows="6" name="zd_rent_bulletin" id="zd_rent_bulletin" cols="50" style="overflow-y:scroll;"></textarea>            </td>
          </tr>
            <tr>
              <td align="center" colspan="4" height="46">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="submitId" name="Submit" value="发 布" class="tijiao" style="cursor:pointer"  onClick="submityn()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            </tr>
          </table>
        </center>
      </div>
      <p> <b>·本网目前提供3种店铺显示风格<br>
        ·请根据自己的喜好设置自己的店铺显示风格。</b> <br>
        </td>
        </tr>
        </table>
    </div>
  </div>
  <input name="zd_id"       type="hidden" id="zd_id"       value="0">
  <input name="mypy"        type="hidden" id="mypy"        value="<%=Common.encryptionByDES(mypy)%>">
  <input name="myvalue"     type="hidden" id="myvalue"     value='<%=myvalue%>'>
  <input name="urlpath"     type="hidden" id="urlpath"     value="<%=urlpath%>">
  <input name="zd_mem_no"   type="hidden" id="zd_mem_no"   value="<%=mem_no%>">
</form>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
	function set_formxx(val){
		if(val!=null && val!=""){
		  $('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));	
		  }
		}
	<%
	  if(!myvalue.equals("")){
		out.print("set_formxx(\""+Common.decryptionByDES(myvalue)+"\");");
	  }
	%>
</script>
</body>
</html>
<%
		}catch(Exception e){e.printStackTrace();}
	  finally{
	      urlpath=null;
	  }
	%>
