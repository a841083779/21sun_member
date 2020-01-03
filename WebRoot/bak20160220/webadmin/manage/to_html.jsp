<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,jereh.web21sun.database.*,jereh.web21sun.util.*,jereh.web21sun.action.*"
	%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>更新静态页</title>
<script  src="scripts/prototype.js"  type="text/javascript"></script>

<script language="javascript">
function createHTML(flag){
//alert(flag);
if(flag=="9"){
	
	//var bl = window.confirm('此项操作需要很长的时间，您确认继续执行吗？');
	//if(!bl){
	//return;
	//}
}
	var myAjax = new Ajax.Request('all_to_html.jsp?flag='+flag,
			{
				method: 'post',
				onComplete: function(){} 
			}
   		);
}

var handle = {
	onCreate: function (){
		Element.show('tip');
	},
	onComplete: function(){
		 if (Ajax.activeRequestCount == 0) 
		 {
		 	 Element.hide('tip');
			 alert("已完成！");
		 }
	}
};
Ajax.Responders.register(handle);
</script>
</head>
<body >

<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr height="12">
    <td width="3%">&nbsp;</td>
    <td width="92%" background="../images/admin/oper_table_up_bg.gif" height="12"></td>
    <td width="5%"><img src="../images/admin/oper_table_up_right.gif" width="26" height="12"></td>
  </tr>
  <tr>
    <td colspan="3"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="5" background="../images/admin/oper_table_left_bg.gif"><img src="../images/admin/oper_table_left_bg.gif" width="5" height="2"></td>
          <td background="../images/admin/oper_table_bg.gif">
            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td nowrap class="title_bar">
                  <strong>手动更新静态页</strong></td>
              </tr>
              <tr height="4">
                <td height="4"></td>
              </tr>
            </table>
<div id="tip"  style='DISPLAY: none'>
  <table width="80%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="4%"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="30" height="30">
      <param name="movie" value="../images/loading_style.swf">
      <param name="quality" value="high">
      <param name=wmode value=transparent>
      <embed src="../images/loading_style.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="25" height="25"></embed>
    </object></td>
    <td width="96%"><span class="text_button2">请稍等，正在生成静态页.....</span></td>
  </tr>
</table>
</div>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_border_bg">
              <tr class="table_border_cell_bg">
                <td width="1%" height="26" >&nbsp;</td>
                <td height="22" colspan="2" >
				<a href="#" onClick="createHTML('8')">更新所有页面</a><a href="#" onClick="createHTML('10');"></a>				</td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td width="2%" height="22" >&nbsp;</td>
                <td width="97%" ><a href="#" onClick="createHTML('2')">更新产品图片</a></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td ><a href="#" onClick="createHTML('3')">更新机型推荐</a></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td ><a href="#" onClick="createHTML('4')">更新热点产品</a></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td ><a href="#" onClick="createHTML('5')">更新首页</a></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td ><a href="#" onClick="createHTML('9')">更新品牌大全</a></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td ><a href="#" onClick="createHTML('10')">更新产品大全</a></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td ><a href="#" onClick="createHTML('11')">更新左侧菜单</a></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td ><a href="#" onClick="createHTML('6')"></a> </td>
              </tr>			  
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td >
				<a href="#" onClick="createHTML('6')">更新所有厂商</a>				</td>
              </tr>				  
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td >
<a href="#" onClick="createHTML('7')">更新所有代理商</a>				</td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" >&nbsp;</td>
                <td ><a href="#" onClick="createHTML('1')">更新所有产品</a> </td>
              </tr>			  			  		  	  			  
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" colspan="2" ></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" colspan="2" ></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" colspan="2" ></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" colspan="2" ></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" colspan="2" ></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" colspan="2" ></td>
              </tr>
              <tr class="table_border_cell_bg">
                <td height="26" >&nbsp;</td>
                <td height="22" colspan="2" ></td>
              </tr>		  
            </table></td>
          <td width="5" background="../images/admin/oper_table_right_bg.gif"><img src="../images/admin/oper_table_right_bg.gif" width="5" height="2"></td>
        </tr>
      </table></td>
  </tr>
  <tr height="13">
    <td>&nbsp;</td>
    <td width="100%" height="13" background="../images/admin/oper_table_down_bg.gif"></td>
    <td align="right">&nbsp;</td>
  </tr>
</table>

</body>
</html>
