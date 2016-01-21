<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ViewJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    哈希列表结构模板页面: <br>
    <c:forEach var="mkey" items="${lkey1}" >
	${mkey['id']} <br>
	${mkey['name']} <br>
	${mkey['letter']} <br>
	<img src="${mkey['imgurl']}" /> <br>	
	</c:forEach>
	----------------------------------------<br><br><br>
	<c:forEach var="mkey" items="${lkey2}" >
	${mkey['id']} <br>
	${mkey['name']} <br>
	${mkey['letter']} <br>
	<img src="${mkey['imgurl']}" /> <br>	
	</c:forEach>
  </body>
</html>
