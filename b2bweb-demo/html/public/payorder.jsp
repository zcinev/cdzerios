<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ page import="com.bc.localhost.*"%>
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
    <meta name="description" content="">
    <link rel="icon" href="<%=basePath%>html/cdz.ico">
    <title>汽车配件－－搜索配件</title>
 
    <link href="<%=basePath%>html/lib/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath%>html/plugin/iCheck/skins/square/blue.css" rel="stylesheet">
    <link href="<%=basePath%>html/css/non-responsive.css" rel="stylesheet">
	<link href="<%=basePath%>html/css/style.css" rel="stylesheet">
	<link href="<%=basePath%>html/css/css.css" rel="stylesheet">
	<link href="<%=basePath%>html/css/public.css" rel="stylesheet">
	<!--[if lte IE 9]>
    <script src="<%=basePath%>html/plugin/Respond/respond.min.js"></script>
    <script src="<%=basePath%>html/plugin/html5/html5shiv.min.js"></script>
    <![endif]-->

    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>html/bsie/bootstrap/css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>html/bsie/bootstrap/css/ie.css">
    <![endif]-->

    <link href="<%=basePath%>html/plugin/HubSpot/css/messenger.css" rel="stylesheet">
    <link href="<%=basePath%>html/plugin/HubSpot/css/messenger-theme-block.css" rel="stylesheet">
    <script src="<%=basePath%>html/js/jquery.min.js"></script>
 		 <style>
	 .navbar .container-fluid .row .pull-left a{
 padding-right:9px;
 padding-left:9px;
 	 border-right: 1px solid #DFDFDF;
 	 }
 	  #dlyzc a{
 	 color: #00a9ff;
 	 margin-left: 5px;
 	 }
	</style> 
</head>
<%
String path1 = "/b2bweb-repair";
String basePathwx = BccHost.getHost()+path1+"/";
%>

<%
String path2 = "/b2bweb-gold";
String basePath2 = BccHost.getHost()+path2+"/";
%>
<%
String path3 = "/b2bweb-baike";
String basePath3 = BccHost.getHost()+path3+"/";
%>
<body>

	<header>
        <div class="navbar navbar-default marginBottom0">
            <div class="container-fluid">
                <div class="row">
                    <div class="pull-left" style="padding-top:13px;">
                                   <a href="<%=BccHost.getHost()%>/b2bweb-baike" class="navbar-link">车队长首页</a>
                   		<a href="<%=basePathwx%>maintain/index?userName=<%=session.getAttribute("userName")%>&id=<%=session.getAttribute("id")%>&typeId=<%=session.getAttribute("typeId")%>" class="navbar-link">我要修车</a>
                   		<a href="<%=basePath%>pei/index" class="navbar-link">汽配超市</a>
                        <a href="<%=basePathwx%>html/trafficindex.jsp" class="navbar-link">车务管家</a> 
                      <%--   <img src='<%=basePath%>html/img/top_03.png' style="margin-top: -3px;margin-right:-10px;"> --%>
                        <a href="/b2bweb-gold/gps.jsp" class="navbar-link">免费GPS</a> 
                        <img src='<%=basePath%>html/img/top_05.png' style="margin-top: -3px;margin-right:-10px;">
                        <a href="<%=basePath2%>gold/1.jsp" class="navbar-link">官网</a> 
                        <a href="<%=basePath%>carsaf/carSafeIndex" class="navbar-link">汽车维权</a> 
                         
                         <%--  <img src='<%=basePath%>html/img/gps.png'>
                          <a href="#" class="navbar-link"><strong>长沙</strong>[切换]</a>  --%>
                </div>
                <div id="dlyzc" class="pull-right cdzer-navtop" style="padding-top:13px;">
                	<%-- <img src='<%=basePath%>html/img/message0.png'>
                	<a href="#" class="navbar-link" role="button">消息</a> --%>
                	
                    <a href="<%=basePath%>/html/login.jsp" class="navbar-link" role="button">登录</a>
                  
                    <a href="<%=basePath%>/html/register.jsp" class="navbar-link" role="button">注册</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="navbar navbar-default marginBottom0">
	    	<div class="member-bg">
		        <div class="row">
		            <div class="pull-left">
		            	<a href="<%=basePath%>pei/index"><img src="<%=basePath%>html/img/newmember_logo.png"></a>
		            </div>
		            <div class="pull-right">
		            </div>
		        </div>
	        </div>
	    </div>
        
        
        <div class="container-fluid" >
            <div class="row" >
                <div class="paddingLeft0 col-md-7 pull-right" style="padding-top: 18px;">
                 <img src="<%=basePath%>html/img/neworder3.png" class="img-responsive" alt="Responsive image" style="width: 80%;height: 90%;float: right;margin-right: -16px;">
                   <%--  <img src="<%=basePath%>html/img/logo.png" class="img-responsive" alt="Responsive image"> --%>
                </div>
                <div class="paddingRight0 col-md-3 " >
                 <%--    <img src="<%=basePath%>html/img/order-2.png" class="img-responsive" alt="Responsive image"> --%>
               <div style="font: normal 24px/36px 'Microsoft yahei';height: 20px;margin-top: 30px;margin-left: -16px;">我的购物车</div>  
                </div>
            </div>
        </div>
    </header>
<%
	String hostPath = BccHost.getHost() + "/";
	String typeId = request.getParameter("id");
	String typeImg = "14081316061576810303";
	if ((typeId!=null)  && !(typeId.equals(""))) {
		 typeImg = typeId;
	 }

%>    
<script type="text/javascript">
	var strName = "<%=session.getAttribute("userName")%>";	
	var strId = "<%=session.getAttribute("id")%>";	
	var typeId = "<%=session.getAttribute("typeId")%>";	
	var dlyzc = document.getElementById("dlyzc");
	var str = "";
	if((strName==null)||(strName=="null")||(strName==""));
	else {
	
		if(typeId=="1")
		str = "<a href=\"<%=hostPath%>b2bweb-repair/person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+"！ </a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\"  >注销</a>";
		else
		str = "<a>"+strName+"</a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\"  role=\"button\">注销</a>";
		
		dlyzc.innerHTML = str;
	}
</script>

<script>
	var headarray = [];
	var arr  =  "";
	var toparr  =  "";
</script>
<c:forEach var="mkey" items="${lkey1}">
	<script>
	    if("<%=typeImg%>"=="${mkey['id']}")
		{		 
	    arr  =  " <li class=\"active\"><a href=\"<%=basePath%>pei/category?id=${mkey['id']}\">${mkey['name']}</a> "
             +  " </li> ";
		toparr	= arr;
		}
  		else
	    arr  =  " <li ><a href=\"<%=basePath%>pei/category?id=${mkey['id']}\">${mkey['name']}</a> "
             +  " </li> ";
        
		headarray.push(arr);
	</script>
</c:forEach>

<script>
	var uldht = document.getElementById("uldht");
	var uldhtTemp="";
	for ( var i = 0; i < headarray.length; i++) {
		uldhtTemp = uldhtTemp + headarray[i];
	}
	uldht.innerHTML = uldhtTemp;
</script>
<script type="text/javascript">
	var strName = "<%=session.getAttribute("userName")%>";	
	var strId = "<%=session.getAttribute("id")%>";	
	var typeId = "<%=session.getAttribute("typeId")%>";	
	var dlyzc = document.getElementById("dlyzc");
	var str = "";
	if((strName==null)||(strName=="null")||(strName==""));
	else {
	
	if(typeId=="1")
		str = "  <a  href=\"<%=basePathwx%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
	if(typeId=="2")
		str = "   <a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="3")
		str = "  <a  href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		
	if(typeId=="5")
		str = " <a  href=\"<%=basePath%>purchase/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		dlyzc.innerHTML = str;
	}
</script>