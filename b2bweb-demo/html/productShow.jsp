<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
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
                    <div class="navbar-brand pull-left" style="margin-top: 14px;height:96px;">
                    	<a href="javascript:void();"><img src="<%=basePath%>html/img/demo-logo.png"  alt="车队长" style="height: 96px;width: 288px;"></a>
                    	<%-- <a href="<%=basePath%>pei/index"><img src="<%=basePath%>html/img/demo-logo.png"  alt="车队长" style="height: 96px;width: 288px;"></a> --%>
                    </div>
                    <div class="pull-right">
                    </div>
                </div>
                <div class="col-md-6 pull-left" style="margin-top: 34px;">
                	<div class="searchbarnew">
							<div class="sarchbarin">
								<form action="" method="post" name="formp">
									<input id="searchType" type="hidden">
									<input value="" autocomplete="off" onblur="hideTS()" class="Ltxnew" id="searchText" name="searchText"  type="text" placeholder="直接官网产品名称搜索">
									<input onclick="searchFun()" class="Lbtnew" value="  搜索" type="submit">
								</form>	
								<div id="divTS" style="top: 40px; left: 1px; display: none;" class="tishi">
									<ul style="width:534px;">
								    	<li id="liTS">
								        </li>
								    </ul>
								</div>
							</div>
						</div>
                </div>
            </div>
        </div>
    </header>
    <div class="container-fluid">
        <div class="row">
        	<div class="col-md-12 paddingRight0 paddingLeft0 pull-left" style="margin-top:10px;">
            		<img alt="" src="<%=basePath%>html/img/gold_banner22.jpg">
            	</div>
            <div class="col-md-12 paddingRight0 paddingLeft0 pull-left" style="margin-bottom:20px;">
	            <div class="panel-heading" style="height:49px;color:#333;background-color:#fff;border-bottom:1px solid #FFF">
					<span  style="height:49px;font-weight:bold;font-size:24px;/* font-family:微软雅黑; */ ">车队长产品</span>
				</div>
				<c:forEach var="mkey" items="${key}">
				<div id="test1" class="col-md-4 shadow" style="border:1px solid #ccc;width:319px;height:378px;padding:0px;margin:0px 10px 15px;background-color:f9f9f9;line-height:24px; ">
 					<a href="<%=basePath%>pei/detail?id=${mkey.id}">
 					<img src="${mkey.img}" style="width:317px;height:230px;"/></a>
					<div  style="padding:10px 10px;border-top:1px solid #ccc;font-size:12px;color:#666;">
						<span style="display:block;height:30px;width:302px;text-overflow:ellipsis;overflow:hidden;color:#0497e1;font-weight:bold;font-size:18px;"> ${mkey.name}</span>
 						<p>配件编号： ${mkey.number} </p>
						<p style="margin-top:20px;">
							<span style="color:#f00808;font-size:18px;">￥</span><span style="color:#f00808;font-size:36px;font-weight:bold;">${mkey.memberprice}</span> <span style="text-decoration: line-through;">￥${mkey.marketprice}</span>
							
							
							<c:if test="${mkey.id=='14111920565139086686' || mkey.id=='14111921035347226464'}">
							<c:if test="${typeId=='1'  || typeId=='' }">
							<span class="enter-step-btn" ><a class="btn btn-primary service-btn" id="cart" style="width:140px;height:42px;font-family:Adobe 黑体 Std;font-size:14px;line-height: 24px;margin-left:160px;margin-top:-65px;" href="<%=basePath2%>lineUp.jsp">立即预约</a></span> 
						</c:if>
						</c:if>
						
							<c:if test="${mkey.id=='14111920565139086686' || mkey.id=='14111921035347226464'}">
						<c:if test="${typeId!='1' && typeId!='' }">
							<span class="enter-step-btn" title="注册个人会员即可预约GPS"><span class="unclick" style="margin-top:65px;" >立即预约</span></span>
							</c:if>
							</c:if>
							
						
						<c:if test="${mkey.id!='14111920565139086686' && mkey.id!='14111921035347226464'}">
						<c:if test="${typeId=='1' || typeId=='3' || typeId=='' }">
							<span class="enter-step-btn" ><a class="btn btn-primary service-btn" id="cart" style="width:140px;height:42px;font-family:Adobe 黑体 Std;font-size:14px;line-height: 24px;margin-left:160px;margin-top:-65px;" href="<%=basePath%>pei/addCart?number=1&id=${mkey['id']}">加入购物车</a></span> 
						</c:if>
						
							</c:if>
							
							
							
							<c:if test="${mkey.id!='14111920565139086686' && mkey.id!='14111921035347226464'}">
								<c:if test="${typeId!='1' && typeId!='3' && typeId!=''}">
							<span class="enter-step-btn" title="注册个人会员或者加盟维修商即可购买配件"><span class="unclick" style="margin-top:65px;" >加入购物车</span></span>
							</c:if>
							</c:if>
				
					
						</p>
				    </div>
			    </div>
			    </c:forEach>
			 </div>
        </div>
    </div>

    <%@ include file="./public/foot.jsp"%>
<script>



$(function(){
        $('#searchText').bind('keypress',function(event){
            if(event.keyCode == "13")    
            {
                searchFun();
            }
        });
    });
    

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

     </script>   
