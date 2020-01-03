<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>跨域代理-重要-不可删除</title>
  </head>  
  <body>
   	<script type="text/javascript">
   		<%
   			String beforeCallback = request.getParameter("beforeCallback");
   			String errorCallback = request.getParameter("errorCallback");
   		%>
   		var base_url = document.URL;
   		var begin = setInterval(function(){
   			var url = document.URL;
   			var beforeCallback = '<%=beforeCallback %>';
   			var errorCallback = '<%=errorCallback %>';
   			if(base_url!=url){
   				var sp_url = url.split("#")[1];
   				if(sp_url=='_begin'&&beforeCallback!=''){
   					<%
   						if(!"".equals(beforeCallback)){
   							%>window.parent.parent.<%=beforeCallback %>();<%
   						}
   					%>
   				}else if(sp_url=='_error'&&errorCallback!=''){
   					<%
   						if(!"".equals(errorCallback)){
   							%>window.parent.parent.<%=errorCallback %>();<%
   						}
   					%>
   				}else if(sp_url!='_begin'&&sp_url!='_error'){
   					window.parent.parent.<%=request.getParameter("callback") %>(sp_url);
   				}
   				base_url = url;
   			}
   		},10);
   	</script>
  </body>
</html>
