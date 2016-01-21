<%@ page language="java" import="java.util.*,java.io.PrintWriter" pageEncoding="UTF-8"%>
<%
String strCall = request.getParameter("callback");
String sessionBufferId = request.getParameter("sessionBufferId");
if( (sessionBufferId!=null) && !("".equals(sessionBufferId)) ){
Cookie cookie = new Cookie("sessionBufferId", sessionBufferId);
cookie.setPath("/");
cookie.setMaxAge(360000);
cookie.setValue(sessionBufferId);
response.addCookie(cookie);
}
if(strCall!=null)
out.println( strCall + "(" + "{}" + ")" );
else 
out.println("{}");
out.flush();
%>

