<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%@ page import="com.bc.session.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
String uploadUrl= BccHost.getUploadUrl();
String trafficPath = BccHost.getTrafficurl()+"/";
String usedPath = BccHost.getUsedurl()+"/";
SessionService sessionService = new BccSession();
sessionService.setAttribute(request, "url", basePath);
%>
<%
String pathpj = "/b2bweb-repair";
String basePathRe = BccHost.getHost()+pathpj+"/";
%>
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
 	 .cdzer-navmid img{
 	 margin-left: 18px;
 	 margin-top: -12px;
 	 }
 	 
 	 #dlyzc a{
 	 color: #00a9ff;
 	 margin-left: 5px;
 	 }
.navbar .sep {
    margin: 0px 10px;
    color: #DFDFDF;
}
.sep {
    font-family: sans-serif;
}
 	 /* .navbar .container-fluid .row .pull-left a{
 padding-right:9px;
 padding-left:9px;
 	 border-right: 1px solid #DFDFDF;
 	 }*/
 	  .navbar1 .container-fluid {
 	 background-color: #00A9FF;
 	 }
 	 a{
 	 cursor: pointer;
 	 }
	.navbar{
		min-height: 30px;
	}
 	 </style>
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
        <div class="navbar navbar-default marginBottom0">
            <div class="container-fluid">
                <div class="row">
                    <div class="pull-left" style="padding-top:5px;">
                    	<%-- <a href="<%=BccHost.getHost()%>/b2bweb-baike" class="navbar-link">车队长首页</a>
                   		<span class="sep">|</span><a href="<%=basePathwx%>maintain/index?userName=<%=session.getAttribute("userName")%>&id=<%=session.getAttribute("id")%>&typeId=<%=session.getAttribute("typeId")%>" class="navbar-link">我要修车</a>
                   		<span class="sep">|</span><a href="<%=basePath%>pei/index" class="navbar-link">汽配超市</a> --%>
                       <%-- <span class="sep">|</span><a href="<%=basePathwx%>html/trafficindex.jsp" class="navbar-link">车务管家</a> --%>
                      <%--   <img src='<%=basePath%>html/img/top_03.png' style="margin-top: -3px;margin-right:-10px;"> 
                        <span class="sep">|</span>--%><a href="<%=basePath%>official/showProduct" class="navbar-link">官网产品</a> 
                        <span class="sep">|</span><img src='<%=basePath%>html/img/top_05.png' style="margin-top: -3px;">
                        <a href="<%=basePath2%>gold/1.jsp" class="navbar-link">官网</a> 
                        <%--<span class="sep">|</span><a href="<%=basePath%>carsaf/carSafeIndex" class="navbar-link">汽车维权</a> 
                    --%></div>
                    <div id="dlyzc" class="pull-right cdzer-navtop" style="padding-top:4px;">
                	    <a href="<%=basePath%>pei/showCart"><img src='<%=basePath%>html/img/top-cart.png' ><span style="color: #777;">购物车</span购物车><span style="color: red;">0</span></a>
                        <a href=""><img src='<%=basePath%>html/img/topmsg.png'style="margin-top: -3px;" > <span style="color: #777;">消息</span><span style="color: red;">0</span></a>
                        <a href="<%=basePath%>html/login.jsp" class="navbar-link" role="button" style="color:#00a9ff; ">登录</a>
                        <a href="<%=basePath%>html/register.jsp" class="navbar-link" role="button" style="color:#00a9ff; ">注册</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6 cdzer-navmid pull-left paddingLeft0">
                    <div class="navbar-brand pull-left" style="margin-top: 14px;">
                    	<a href="javascript:void()"><img src="<%=basePath%>html/img/demo-logo1.png"  alt="车队长" style="height: 96px;width: 288px;"></a>
                    </div>
                    <div class="pull-right">
                    </div>
                </div>
                <div class="col-md-2 pull-left">
                    <%-- <div class="navbar-brand cdzer-navmid" >
                        <div class="navbar-link" style="margin-top: 23px;width:260px;">
                          <div class="media" > 
	                          <a class="pull-left" href="#"> <img class="media-object"  style="margin-top: 1px;width: 40px;"  src="<%=basePath%>html/img/choiccar.png"   alt="媒体对象"></a>
	                          <div class="media-body" style="margin-left: 67px;">
		                          <h4 class="media-heading" style="margin-top: 4px;font-size: 14px;font-weight: bold;color: #666;">选择车型</h4>
		                          <span > <a class="navbar-text car-modal-btn" style="font: 12px/150% Arial,Verdana,'宋体';max-width:260px;max-height:20px;margin-left: 1px;margin-top: -4px;color:#999;" data-toggle="modal"  data-target="#car-model"> 按车型选产品，精准匹配！</a></span>
                          	  </div>
                          </div>
                    	</div>
                	</div> --%>
               	</div>
                <div class="col-md-4 pull-left" style="position:relative;">
                    <%-- <div class="navbar-brand cdzer-navmid " >
                        <div class="navbar-link" style="margin-top: 23px;width:260px;">
                          <div class="media" > 
                          	  <a class="pull-left" href="#"> <img class="media-object"  style="margin-top: -1px;width: 40px;"  src="<%=basePath%>html/img/choicepj.png"   alt="媒体对象" ></a>
	                          <div class="media-body" style="margin-left: 63px;">
		                          <h4 class="media-heading" style="margin-top: 4px;font-size: 14px;font-weight: bold;color: #666;">选择配件</h4>
		                          <span > <a  class="navbar-text pei-kind-btn" style="font: 12px/150% Arial,Verdana,'宋体';min-width: 80px;max-width:260px;max-height:20px;margin-top: -4px;margin-left: 1px;color:#999;"> 选择配件</a></span>
	                          </div>
                          </div>
                        </div>
                    </div> --%>
                    <div style="position:absolute;top: 14px;left:75px"><img src="<%=basePath%>html/img/111.jpg"  alt="车队长" style="height: 96px;width: 288px;"></div>
                </div>
            </div>
        </div>
        <div class="navbar navbar-default navbar1" rold="navigation" style="margin-top: 20px;">
            <div class="container-fluid">
                <div class="row">
                    <div class="navbar-header">
                        <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle nabigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <nav class="collapse navbar-collapse paddingLeft0">
                        <!-- <ul class="nav navbar-nav" id="uldht">                 
                        </ul> -->
                        <div class="searchbarnew">
						<%-- <div class="sarchbarin">
						<form action="<%=basePath%>pei/searchProduct" method="post" name="form3">
							<input id="searchType" type="hidden">
							<input value="" autocomplete="off" onblur="hideTS()" class="Ltxnew" id="searchText" name="searchText"  type="text" placeholder="直接输入配件名称搜索">
							<input onclick="searchFun()" class="Lbtnew" value="  搜索" type="submit">
						</form>	
							<div id="divTS" style="top: 40px; left: 1px; display: none;" class="tishi">
								<ul style="width:534px;">
							    	<li id="liTS">
							        </li>
							    </ul>
							</div>
						</div> --%>
					</div>
                    </nav>
                </div>
            </div>
        </div>
        <form action="" id="form2" name="form2" method="post">
        	<input hidden="hidden" type="text" name="category" id="category" value=""/>
			<input hidden="hidden" type="text" name="listPart" id="listPart" value=""/>
			<input hidden="hidden" type="text" name="product" id="product" value=""/>
			<input hidden="hidden" type="text" name="partModel" id="partModel" value=""/>
        </form>
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
		str = "<a href=\"<%=hostPath%>b2bweb-repair/person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+"！ </a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\" class=\"btn btn-default\" role=\"button\">注销</a>";
		else
		str = "<a>"+strName+"</a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\" class=\"btn btn-default\" role=\"button\">注销</a>";
		
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
	
<%-- 	if(typeId=="1")
		str = " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+"  <a  href=\"<%=basePathwx%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
	if(typeId=="2")
		str =  "<a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="3")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+" <a  href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
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
		str =  " <a  href=\"<%=basePath%>purchase/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="4")
		str = " <a  href=\"<%=trafficPath%>manager/showIndex\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		dlyzc.innerHTML = str;
	}

function searchFun(){
document.form3.action="<%=basePath%>pei/searchProduct";
document.form3.submit();
}


$(function(){
        $('#searchText').bind('keypress',function(event){
            if(event.keyCode == "13")    
            {
                searchFun();
            }
        });
    });
</script>