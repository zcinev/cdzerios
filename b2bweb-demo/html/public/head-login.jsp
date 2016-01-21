<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh_CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
    <meta name="description" content="">
    <link rel="icon" href="<%=basePath%>html/cdz.ico">
    <title>汽车配件－－搜索配件</title>

    <link rel="stylesheet" href="<%=basePath%>html/lib/dist/css/bootstrap.min.css">
    <link href="<%=basePath%>html/plugin/iCheck/skins/minimal/blue.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath%>html/css/non-responsive.css">
    <link rel="stylesheet" href="<%=basePath%>html/css/style.css">
    <link href="<%=basePath%>html/css/css.css" rel="stylesheet">
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
    <script>
		var _hmt = _hmt || [];
		(function() {
		  var hm = document.createElement("script");
		  hm.src = "//hm.baidu.com/hm.js?9fc39eb7ef29bb92138cb096493e191f";
		  var s = document.getElementsByTagName("script")[0]; 
		  s.parentNode.insertBefore(hm, s);
		})();
	</script>
</head>

<body>
    <header>
        <!-- <div class="navbar navbar-inverse marginBottom0"> -->
        <div class="navbar navbar-default marginBottom0">
            <div class="container-fluid">
                <div class="row">
                    <div class="pull-left" style="padding-top:13px;">
                        <span class="glyphicon glyphicon-home cdzer-home"></span> 
                        <a href="/b2bweb-baike" class="navbar-link">车队长首页 Hi!欢迎回到车队长</a>
                    </div>
                    <div id="dlyzc" class="pull-right cdzer-navtop">
	                        <a href="<%=basePath%>html/login.jsp" class="btn btn-default" role="button">登录</a>
	                        <a href="<%=basePath%>html/register.jsp" class="btn btn-default" role="button">注册</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="navbar navbar-default marginBottom0" style="margin-bottom: 20px;">
	    	<div class="member-bg">
		        <div class="row">
		            <div class="pull-left">
		            	<a href="<%=basePath%>pei/index"><img src="<%=basePath%>html/img/newmember_logo.png"></a>
		            </div>
		            <div class="pull-right">
		               <!--  <form action="" class="navbar-form cdzer-navmid" role="search">
		                    <div class="form-group">
		                        <input type="text" class="form-control" placeholder="Search">
		                    </div>
		                    <button type="submit" class="btn btn-default">搜索</button>
		                </form>
		                <dl class="navbar-form search-hot cdzer-navmid">
		                    <dt><h6>热门搜索：</h6></dt>
		                    <dd><a href="#" class="member-hot-text">进气系统</a></dd>
		                    <dd><a href="#" class="member-hot-text">进气系统</a></dd>
		                    <dd><a href="#" class="member-hot-text">进气系统</a></dd>
		                    <dd><a href="#" class="member-hot-text">进气系统</a></dd>
		                </dl> -->
		            </div>
		        </div>
	        </div>
	    </div>
    </header>
    <%
	String hostPath = BccHost.getHost() + "/";
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
		str = "<a href=\"<%=hostPath%>b2bweb-repair/person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">亲爱的用户:"+strName+"，您已登陆！ </a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\" class=\"btn btn-default\" role=\"button\">注销</a>";
		else
		str = "<a>亲爱的用户:"+strName+"，您已登陆！ </a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\" class=\"btn btn-default\" role=\"button\">注销</a>";
		
		dlyzc.innerHTML = str;
	}
</script>