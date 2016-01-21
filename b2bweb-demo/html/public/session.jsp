<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <script src="<%=basePath%>html/js/jquery.min.js"></script>  
  </head>  
  <body>
    ${sessionString}
  </body>
</html>
