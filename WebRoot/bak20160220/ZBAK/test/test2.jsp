<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,jereh.web21sun.database.*,jereh.web21sun.util.*,java.net.*"
	%><%
/*
   String userinfo ="存储用户登录的相关信息，如：用户名,地址,联系方式......";
   Cookie domain = new Cookie("userinfo", URLEncoder.encode(userinfo,"utf-8"));
   domain.setDomain("product.21-sun.com");
   domain.setMaxAge(3600);
   domain.setValue(URLEncoder.encode(userinfo,"UTF-8"));
   domain.setPath("/");
   response.addCookie(domain);
*/
	%><html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

</head>
<body>
<p>
  <%


   Cookie[] cookies = request.getCookies();
   Cookie cookie = null;
    boolean ifLogin = false;
    for(int i =0; i<cookies.length;i++)
     {
          cookie = cookies[i];
          if(cookie.getName().equals("userinfo"))
           {
              String corpid = URLDecoder.decode( cookie.getValue(), "utf-8" ).split( "," )[0];
             // TbCorpInfo tbCorpInfo = new CompanyDAO().selectCompanyById( Integer.parseIn( corpid ) );
            //  ValueStack stack = invocation.getStack();
            //  stack.setValue( "company", tbCorpInfo );
            //  ifLogin = true;
			out.println(corpid+"--aaaaaaaaaaaaaaaaa<br>");
             }else{
			 out.println("bbbbbbbbbbbbbbbbb<br>");
			 }
       }



  Cookie domain = new Cookie( "userinfo", "" );
  domain.setDomain( "product.21-sun.com" );
  domain.setMaxAge( 0 );
  domain.setValue("" );
  domain.setPath( "/" );;
  response.addCookie( domain );
%>
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><a href="http://product.21-sun.com/test/test2.jsp">test2</a></p>
</body>
</html>
