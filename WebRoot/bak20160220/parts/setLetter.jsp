<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%
String letter = Common.getFormatStr(request.getParameter("letter"));
String returnPin = CnToFullSpell.getFirstSpell(letter);
if(!returnPin.equals(""))
returnPin = returnPin.substring(0,1);
response.setCharacterEncoding("UTF-8");
PrintWriter pw = response.getWriter();
pw.write(returnPin);
pw.close();
%>

