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
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Note there is no responsive meta tag here -->
    <link rel="icon" href="<%=basePath%>html/favicon.ico">

    <title>维修商</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=basePath%>html/lib/dist/css/boot.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="<%=basePath%>html/css/css.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="<%=basePath%>html/assets/js/ie8-responsive-file-warning.js"></script>
    <![endif]-->
    <script src="<%=basePath%>html/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="<%=basePath%>html/assets/js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="<%=basePath%>html/plugin/Html5/html5shiv.min.js"></script>
    <script src="<%=basePath%>html/plugin/Respond/respond.min.js"></script>
    <![endif]-->
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

<div class="header">
    <div class="navbar navbar-default marginBottom0">
        <div class="container-fluid">
            <div class="row">
                <div class="pull-left" style="padding-top:13px;">
                    <span class="glyphicon glyphicon-home cdzer-home"></span>
                    <a href="/b2bweb-baike" class="navbar-link">车队长首页 Hi!欢迎回到车队长</a>
                </div>
                <div class="pull-right cdzer-navtop">
                    <a href="<%=basePath%>html/login.jsp" class="btn btn-primary" role="button">登录</a>
                    <a href="<%=basePath%>html/register.jsp" class="btn btn-primary" role="button">注册</a>
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
    <div class="container-fluid">
        <div class="row">
            <span class="pull-left" style="margin-top:8px;">您现在的位置：</span>
            <ol class="breadcrumb pull-left marginBottom0" style="background-color:#fff;">
                <li><a href="<%=basePath%>person/showIndex">首页</a></li>
                <li><a href="#">个人中心</a></li>
                <li class="active">会员中心</li>
            </ol>
        </div>
    </div>
</div>