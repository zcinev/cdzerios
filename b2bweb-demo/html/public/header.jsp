<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>
<%
String path1 = "/b2bweb-repair";
String basePathwx = BccHost.getHost()+path1+"/";
%>
<%
	String hostPath = BccHost.getHost() + "/";
	String usedPath = BccHost.getUsedurl()+"/";
%>
<%
String path2 = "/b2bweb-gold";
String basePath2 = BccHost.getHost()+path2+"/";
String uploadUrl= BccHost.getUploadUrl();
String trafficPath = BccHost.getTrafficurl()+"/";
String usedUrl=BccHost.getUsedurl()+"/";
%>
 <%
String path3 = "/b2bweb-baike";
String basePath3 = BccHost.getHost()+path3+"/";
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
    <link href="<%=basePath%>html/plugin/HubSpot/css/messenger.css" rel="stylesheet">
    <link href="<%=basePath%>html/plugin/HubSpot/css/messenger-theme-block.css" rel="stylesheet">
    <script src="<%=basePath%>html/js/jquery.min.js"></script>
    <style type="text/css">
    a{color:#767474;}
a:hover{
color:#428BCA;
}
 #dlyzc a{
 	 color: #00a9ff;
 	 margin-left: 5px;
 	 }
 	  /*.header .navbar .container-fluid .row .pull-left a{
 padding-right:9px;
 padding-left:9px;
 	 border-right: 1px solid #DFDFDF;
 	 }*/
.navbar{
min-height: 30px;
}
.navbar .sep {
    margin: 0px 10px;
    color: #DFDFDF;
}
.sep {
    font-family: sans-serif;
}
    </style>
</head>
 	<script>
		var _hmt = _hmt || [];
		(function() {
		  var hm = document.createElement("script");
		  hm.src = "//hm.baidu.com/hm.js?9fc39eb7ef29bb92138cb096493e191f";
		  var s = document.getElementsByTagName("script")[0]; 
		  s.parentNode.insertBefore(hm, s);
		})();
	</script>
<body>
<div class="header">
    <div class="navbar navbar-default marginBottom0">
        <div class="container-fluid">
            <div class="row">
                <div class="pull-left" style="padding-top:5px;">
                 <%--  <a href="/b2bweb-baike" class="navbar-link">车队长首页</a>
                 
                     <span class="sep">|</span><a href="<%=basePathwx%>maintain/index?userName=<%=session.getAttribute("userName")%>&id=<%=session.getAttribute("id")%>&typeId=<%=session.getAttribute("typeId")%>" class="navbar-link">我要修车</a>
                  
                     <span class="sep">|</span><a href="<%=basePath%>pei/index" class="navbar-link">汽配超市</a> --%>
                     
                     <%--<span class="sep">|</span><a href="<%=basePathwx%>html/trafficindex.jsp" class="navbar-link">车务管家</a> --%> 
                      
                   	<%--   <img src='<%=basePath%>html/img/top_03.png' style="margin-top: -3px;margin-right:-10px;"> 
                       <span class="sep">|</span>--%><a href="/b2bweb-demo/official/showProduct" class="navbar-link">官网产品</a> 
                     
                        <span class="sep">|</span><img src='<%=basePath%>html/img/top_05.png' style="margin-top: -3px;">
                         <a href="<%=basePath2%>gold/1.jsp" class="navbar-link">官网</a> 
                          <%--<span class="sep">|</span><a href="<%=basePath%>carsaf/carSafeIndex" class="navbar-link">汽车维权</a> 
                        
                --%></div>
                <div id="dlyzc" class="pull-right cdzer-navtop" style="padding-top:4px;">  
                	<a href="<%=basePath%>pei/showCart"><img src='<%=basePath%>html/img/top-cart.png' ><span style="color: #777;">购物车</span><span style="color: red;">0</span></a>             	 
                     <a href="<%=basePath%>html/login.jsp" class="navbar-link" role="button" style="color:#00a9ff; ">登录</a>
                     
                    <a href="<%=basePath%>html/register.jsp" class="navbar-link" role="button" style="color:#00a9ff; ">注册</a>
                </div>
            </div>
        </div>
    </div>
    <div class="navbar navbar-default marginBottom0">
    	<div class="member-bg">
	        <div class="row">
	            <div class="pull-left">
	            	<img src="<%=basePath%>html/img/newmember_logo.png">
	            </div>
	            <div class="pull-right">
	            </div>
	        </div>
        </div>
    </div>
   	<div  style="margin-top:60px;">        
        <div class="container-fluid">
            <div class="row">
                <nav class="collapse navbar-collapse paddingLeft0">
                    <ul class="nav navbar-nav" id="uldht">                 
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
	var strName = "<%=session.getAttribute("userName")%>";	
	var strId = "<%=session.getAttribute("id")%>";	
	var typeId = "<%=session.getAttribute("typeId")%>";	
	var dlyzc = document.getElementById("dlyzc");
	var str = "";
	var cart="";
	var tnum="0";
	if((strName==null)||(strName=="null")||(strName==""));
	else {

	  $.ajax({
            type: "POST",  
            data:{userName:strName},
            url: "<%=basePath%>pei/cartNumber",
            async:false,
            dataType: "json",
            success: function(data) {
            cart=data[0].len;
             tnum=data[0].num;
              },
            error: function() {
            alert('请求失败');
            }
        });	
	<%-- if(typeId=="1")
		str = "<a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a> "+"<a href=\"<%=basePathwx%>/person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
	if(typeId=="2")
		str = "<a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="3")
		str = " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+"   <a  href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		 --%>
		 
	if(typeId=="1")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+
		"<a href=\"<%=basePathwx%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\" target='_black'><img src='<%=basePath%>html/img/topmsg.png' style='margin-top: -3px;' > <span style='color: #777;'>消息</span><span style='color: red;'>"+tnum+"</span></a>"+
		"  <a  href=\"<%=basePathwx%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
	if(typeId=="2")
		str = " <a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a>"+
		"<a href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\" target='_black'><img src='<%=basePath%>html/img/topmsg.png' style='margin-top: -3px;' > <span style='color: #777;'>消息</span><span style='color: red;'>"+tnum+"</span></a>"+
		" <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="3")
		str = " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+
		"<a href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\" target='_black'><img src='<%=basePath%>html/img/topmsg.png' style='margin-top: -3px;' > <span style='color: #777;'>消息</span><span style='color: red;'>"+tnum+"</span></a>"+
		"   <a  href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		
	if(typeId=="5")
		str = " <a  href=\"<%=basePath%>purchase/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="4")
		str = " <a  href=\"<%=trafficPath%>manager/showIndex\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	dlyzc.innerHTML = str;
	}




</script>