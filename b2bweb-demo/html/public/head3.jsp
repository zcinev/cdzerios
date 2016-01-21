<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>
<%
String pathpj = "/b2bweb-repair";
String basePathpj = BccHost.getHost()+pathpj+"/";
%>
<%
String pathImg = "/imgUpload/uploads"; 
String basePathImg = BccHost.getHost()+pathImg+"/";
%>
<%
String path2 = "/b2bweb-gold";
String basePath2 = BccHost.getHost()+path2+"/";

String gpsPath = BccHost.getGpshost() +"/";

String uploadUrl= BccHost.getUploadUrl();
String trafficPath = BccHost.getTrafficurl()+"/";
SessionService sessionService = new BccSession();
sessionService.setAttribute(request, "url", basePath);
%>
 <%
String path3 = "/b2bweb-baike";
String basePath3 = BccHost.getHost()+path3+"/";
%>  
<%
String pathpjBrand = "/b2bweb-portal";
String basePathBrand = BccHost.getHost()+pathpjBrand+"/";
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
     <link rel="stylesheet" href="<%=basePath%>html/css/public.css">
    <link href="<%=basePath%>html/css/css.css" rel="stylesheet">
    <link href="<%=basePath%>html/css/public.css" rel="stylesheet">
    <!--[if lte IE 9]>
    <script src="<%=basePath%>html/plugin/Respond/respond.min.js"></script>
    <script src="<%=basePath%>html/plugin/html5/html5shiv.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="<%=basePath%>html/js/jquery.min.js"></script>
    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>html/bsie/bootstrap/css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>html/bsie/bootstrap/css/ie.css">
    <![endif]-->

    <link href="<%=basePath%>html/plugin/HubSpot/css/messenger.css" rel="stylesheet">
    <link href="<%=basePath%>html/plugin/HubSpot/css/messenger-theme-block.css" rel="stylesheet">
    <style type="text/css">
    
#row a{color:#767474;}
#row a:hover{
color:#428BCA;
}
 #dlyzc a{
 	 color: #00a9ff;
 	 }
.navbar .container-fluid .row .pull-left a{
	 padding-right:9px;
	 padding-left:9px;
 	 border-right: 1px solid #DFDFDF;
 	 }
 	 .bgclass{
    color: #FFF;
	text-decoration: none;
	background-color: #1873D5;
	padding: 16px;
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
    <header>
        <div class="navbar-default marginBottom0">
	    	<div class="top-bg">
		        <div class="row">
		            <div class="pull-left ">
		            	<div id="top_logo">
		            		<span><img src="<%=sessionService.getAttribute(request, "pjs_logo")%>" width="220" height="75"></img></span>
		            	</div>
			            	<span class="pull-left f_left">
			            	<c:if test="${typeId=='2'}">
			            	<h1>配件商后台管理系统</h1></c:if>
			            	<c:if test="${typeId=='5'}">
			            	<h1>采购中心后台管理系统</h1></c:if></span>
			            	<span class="pull-left ren">&nbsp;<img src="<%=basePath%>html/images/ren.png"></img></span>
			            	<span class="pull-left f_left">&nbsp;您好！${sessionScope.userName}  &nbsp;&nbsp;上次登录时间：<%=sessionService.getAttribute(request, "loginTime")%></span>
		            </div>
		            <div class="pull-right top_cancel">
		            	<%-- <a href="<%=basePath%>pei/showCart">购物车</a> 
		                <a href="<%=basePath%>pei/showCart"><img src="<%=basePath%>html/images/shopping.png" style="width:17px;height:15px;"></img></a>&nbsp;&nbsp;                        --%>
		            	<a href="javascript:void(0);" data-toggle='modal' data-target='#myPeiMsg' onclick="readTheNews();"><img src="<%=basePath%>html/images/msg.png" style=""></img></a> 
		            	<a href="javascript:void(0);" data-toggle='modal' data-target='#myPeiMsg' onclick="readTheNews();">消息<font color="#FF0000" id="notReadNews">(100)</font></a> 
		                <a href="<%=basePath%>pei/logout"><img src="<%=basePath%>html/images/cancel.png" style="width:17px;height:15px;"></img></a>                         
		            	<a href="<%=basePath%>pei/logout">退出</a> 
		            </div>
		        </div>
		        <div class="row">
                    <div class="pull-left menu_left">
                		<ul>
                			<li class="info">
	                			<img src="<%=basePath%>html/images/menu_1.png"></img>
	                			<span class="menu_font">基本信息</span>
                			</li>
                			<li class="store">
	                			<img src="<%=basePath%>html/images/menu_1.png"></img>
	                			<span class="menu_font">店铺管理</span>
                			</li>
                			<li class="producer">
                				<img src="<%=basePath%>html/images/menu_2.png"></img>
	                			<span class="menu_font">生产商管理</span>
                			</li>
                			<li class="product">
                				<img src="<%=basePath%>html/images/menu_3.png"></img>
	                			<span class="menu_font">产品管理</span>
                			</li>
                			<li class="order">
                				<img src="<%=basePath%>html/images/menu_4.png"></img>
	                			<span class="menu_font">订单管理</span>
                			</li>
                			<li class="comment">
                				<img src="<%=basePath%>html/images/menu_5.png"></img>
	                			<span class="menu_font">评论管理</span>
                			</li>
                			<li class="messages">
                				<img src="<%=basePath%>html/images/menu_6.png"></img>
	                			<span class="menu_font">站内信息</span>
                			</li>
                		</ul>
                	</div>
	                <div class="pull-right menu_right">
		                <img src="<%=basePath%>html/images/menu_add.png"></img>
	                	<span class="menu_font">菜单</span>
                    </div>
                </div>
	        </div>
	    </div>
        
        <div class="sub_menu info1">
            <div class="container-fluid">
                <div class="row sub">
               		<ul id="demoul">
               			<li><a href="<%=basePath%>member/userBasicInformationTest">个人资料</a></li>
               			<li><a href="<%=basePath%>member/userTimeAndPalce">密码安全</a></li>
               			<li><a href="<%=basePath%>member/consigneeAddressList">收货地址列表</a>	</li>
               		</ul>
                </div>
            </div>
        </div>  
        <div class="container-fluid">
            <div class="row">
                <span class="pull-left" style="margin-top:8px;">您现在的位置：</span>
                <ol class="breadcrumb pull-left marginBottom0" style="background-color:#fff;">
                    <li><a href="<%=basePath%>">首页</a></li>
                    <%-- <li><a href="<%=basePathpj%>person/showIndex">个人中心</a></li> --%>
                    <li class="active"><a href="<%=basePath%>member/memberCenter?typeId=${typeId}">会员中心</a></li>
                </ol>
            </div>
        </div>
    </header>
<div class="modal fade" id="myPeiMsg" tabindex="-1" role="dialog"
	aria-labelledby="myPeiMsg" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="border-bottom:none;">
				<button type="button" class="close" data-dismiss="modal" >
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h2 class="modal-title">
					<span class="pull-left">消息中心</span>
					<h5 class="pull-left" style="margin-top:17px;margin-left:10px;">
						（共<span id="number" style="color:red;">${number}</span>条消息，其中<span style="color:#666;">未读消息</span><span id="count" style="color:red;">${amount}</span>条）
					</h5>
				</h2>
				<div class="clearfix" ></div>
			</div>
			<div class="modal-body">
				<div id="pei_contents">
					<ul class="nav nav-tabs" role="tablist">
						<li class="active"><a href="#pei_remain" role="tab"data-toggle="tab">消息</a></li>
					</ul>
					<div class="tab-content">
						<div class="active" id="pei_remain">
							<form name="form1" method="post" action="">
								<table class="table table-striped">
									<tr class="warning">
										<td align="center"colspan="7">您有<span id="count2" style="color:red;">${amount}</span>条未读信息
										</td>
									</tr>
									<tbody id="peitable">
									
									
									</tbody>
									<tr>
										<td colspan="5" ><a href="javascript:delMessage1();" class="btn btn-default">删除</a>
											<a href="#" class="btn btn-default btn-check">全选/反选</a> 
											<a href="#" class="btn btn-default" onclick="readAllMessages()">标记为已读</a> 
											<!-- <a href="#" class="btn btn-default">转发</a> 
											<a href="#" class="btn btn-default">举报</a> -->
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<div>
												<ul class="pager pull-right"
													style="margin-left:2px;margin-right:2px;">
													<li><a id="syy99">上一页</a>
													</li>
													<li><a id="xyy99">下一页</a>
													</li>
												</ul>
												<span class="label label-default pull-right label-page">共<span
													id="djy99">20</span>页</span> <span
													class="label label-primary pull-right label-page">当前第<span
													id="dqdjy99">5</span>页</span>
												<ul class="pagination pull-right">
													<li><a id="syyf99">&laquo;</a>
													</li>
													<li class="active"><a id="dqdjyf99">1</a>
													<li class=""><a id="dqdjyf199">1</a>
													<li class=""><a id="dqdjyf299">1</a>
													<li class=""><a id="dqdjyf399">1</a></li>
													<li><a id="xyyf99">&raquo;</a>
													</li>
												</ul>
											</div>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
				<div id="mypeitab" style="display: none;">
					<div class="remind">
						<div class="well">
							<span id="pei_detail"></span>
							<p class="text-right">
								<a href="#" class="btn btn-primary" onclick="peiBack()">返回</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>   
    <%
	String hostPath = BccHost.getHost() + "/";
%>
<script>
$(function(){
    var logo_img=$('#top_logo').find('img').attr('src');
      if(logo_img=="" || logo_img==null || logo_img=="null"){
     var src_img="<%=basePath%>html/images/Store_LOGO.png";
     $('#top_logo').find('img').attr('src',src_img);
     }
});
</script>
    <script type="text/javascript">
    var strName = "<%=session.getAttribute("userName")%>";	
	var strId = "<%=session.getAttribute("id")%>";	
	var typeId = "<%=session.getAttribute("typeId")%>";	
	var dlyzc = document.getElementById("dlyzc");
	var str = "";
	var cart="";
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
              },
            error: function() {
            alert('请求失败');
            }
        });	
	
	if(typeId=="1")
		str = " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span><span style='color: red;'>"+cart+"</span></a>"+"  <a  href=\"<%=basePathpj%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
	if(typeId=="2")
	
		str =  "  <a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="3")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span><span style='color: red;'>"+cart+"</span></a>"+" <a  href=\"<%=basePathpj%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		
	if(typeId=="5")
		str =  " <a  href=\"<%=basePath%>purchase/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="4")
		str = "<a  href=\"<%=trafficPath%>manager/showIndex\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		dlyzc.innerHTML = str;
	}


</script>
<script>
function setDemoCookie(name,value) { 
    var exp = new Date(); 
    exp.setTime(exp.getTime() + 1576800000000); 
    document.cookie =name+"="+escape(value)+";expires="+exp.toGMTString()+";path=/"; 
}
function getCookie(name){
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");		 
    if(arr=document.cookie.match(reg))		 
        return unescape(arr[2]);
    else
        return null;
} 

	$(".menu_right").click(function(){
		$(".menu_left").toggle();
	});
	$(".info").click(function(){
		 setDemoCookie("menu","class1");
	     document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst1\"><a href=\"<%=basePath%>member/userBasicInformationTest\">个人资料</a></li>"+
  			"<li id=\"dst2\"><a href=\"<%=basePath%>member/userTimeAndPalce\">密码安全</a></li>"+
  			"<li id=\"dst3\"><a href=\"<%=basePath%>member/consigneeAddressList\">收货地址列表</a></li>";
  		  $('#dst1').click(function(){
			  setDemoCookie("list","style1");
		  });
		  $('#dst2').click(function(){
			  setDemoCookie("list","style2");		  
		  });
		  $('#dst3').click(function(){
			  setDemoCookie("list","style3");		  
		  });
	});
	if((getCookie("menu"))=="class1"){
		 document.getElementById("demoul").innerHTML="";
			document.getElementById("demoul").innerHTML+="<li id=\"dst1\"><a href=\"<%=basePath%>member/userBasicInformationTest\">个人资料</a></li>"+
			"<li id=\"dst2\"><a href=\"<%=basePath%>member/userTimeAndPalce\">密码安全</a></li>"+
			"<li id=\"dst3\"><a href=\"<%=basePath%>member/consigneeAddressList\">收货地址列表</a></li>";
		  
			if((getCookie("list"))=="style1"){
			  $('#dst1').find("a").attr("class", "bgclass");
		  	}
		  	if((getCookie("list"))=="style2"){
			   $('#dst2').find("a").attr("class", "bgclass");
		   	}
		  	if((getCookie("list"))=="style3"){
			   $('#dst3').find("a").attr("class", "bgclass");
		   	}

	  }
	$(".store").click(function(){
		 setDemoCookie("menu","class2");
	     document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst4\"><a href=\"<%=basePath%>member/storeInfo\">基本信息</a></li>"+
		 "<li id=\"dst5\"><a href=\"<%=basePath%>member/uploadImgLookTest\">图片上传</a></li>";
 		  $('#dst4').click(function(){
			  setDemoCookie("list","style4");
		  });
		  $('#dst5').click(function(){
			  setDemoCookie("list","style5");		  
		  });
	});
	if((getCookie("menu"))=="class2"){
		 document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst4\"><a href=\"<%=basePath%>member/storeInfo\">基本信息</a></li>"+
		 "<li id=\"dst5\"><a href=\"<%=basePath%>member/uploadImgLookTest\">图片上传</a></li>";
		  
			if((getCookie("list"))=="style4"){
			  $('#dst4').find("a").attr("class", "bgclass");
		  	}
		  	if((getCookie("list"))=="style5"){
			   $('#dst5').find("a").attr("class", "bgclass");
		   	}
	  }
	$(".producer").click(function(){
		setDemoCookie("menu","class3");
	     document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst6\"><a href=\"<%=basePath%>member/producerList\">生产商列表</a></li>";
		  $('#dst6').click(function(){
			  setDemoCookie("list","style6");
		  });
	});
	if((getCookie("menu"))=="class3"){
		 document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst6\"><a href=\"<%=basePath%>member/producerList\">生产商列表</a></li>";
			if((getCookie("list"))=="style6"){
			  $('#dst6').find("a").attr("class", "bgclass");
		  	}
	  }
	$(".product").click(function(){
		setDemoCookie("menu","class4");
	     document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst7\"><a href=\"<%=basePath%>member/productsLookTest\">配件列表</a></li>";
		 $('#dst7').click(function(){
			  setDemoCookie("list","style7");
		  });
	});
	if((getCookie("menu"))=="class4"){
		 document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst7\"><a href=\"<%=basePath%>member/productsLookTest\">配件列表</a></li>";
		 if((getCookie("list"))=="style7"){
			  $('#dst7').find("a").attr("class", "bgclass");
		  	}
	  }
	$(".order").click(function(){
		setDemoCookie("menu","class5");
	     document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst8\"><a href=\"<%=basePath%>trade/tradeListNo\">订单列表</a></li>";
		  $('#dst8').click(function(){
			  setDemoCookie("list","style8");
		  });
	});
	if((getCookie("menu"))=="class5"){
		document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst8\"><a href=\"<%=basePath%>trade/tradeListNo\">订单列表</a></li>";
		 if((getCookie("list"))=="style8"){
			  $('#dst8').find("a").attr("class", "bgclass");
		  	}
	  }
	$(".comment").click(function(){
		setDemoCookie("menu","class6");
	     document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst9\"><a href=\"<%=basePath%>member/commentPeiJIanUserList\">客户评论</a></li>";
		  $('#dst9').click(function(){
			  setDemoCookie("list","style9");
		  });
	});
	if((getCookie("menu"))=="class6"){
		 document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst9\"><a href=\"<%=basePath%>member/commentPeiJIanUserList\">客户评论</a></li>";
		 if((getCookie("list"))=="style9"){
			  $('#dst9').find("a").attr("class", "bgclass");
		  	}
	  }
	$(".messages").click(function(){
		setDemoCookie("menu","class7");
	     document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst10\"><a href=\"<%=basePath%>member/receiveBoxTest\">收件箱</a></li>"+
			"<li id=\"dst11\"><a href=\"<%=basePath%>member/sendBoxLookTest\">发件箱</a></li>";
		  $('#dst9').click(function(){
			  setDemoCookie("list","style10");
		  });
		  $('#dst11').click(function(){
			  setDemoCookie("list","style11");		  
		  });
	});
	if((getCookie("menu"))=="class7"){
		document.getElementById("demoul").innerHTML="";
		 document.getElementById("demoul").innerHTML+="<li id=\"dst10\"><a href=\"<%=basePath%>member/receiveBoxTest\">收件箱</a></li>"+
		 "<li id=\"dst11\"><a href=\"<%=basePath%>member/sendBoxLookTest\">发件箱</a></li>";
		 if((getCookie("list"))=="style10"){
			  $('#dst10').find("a").attr("class", "bgclass");
		  	}
		 if((getCookie("list"))=="style11"){
			  $('#dst11').find("a").attr("class", "bgclass");
		  	}
	  }
	$('#dst1').click(function(){
		setDemoCookie("list","style1");
	});
	$('#dst2').click(function(){
		setDemoCookie("list","style2");		  
	});
	$('#dst3').click(function(){
		setDemoCookie("list","style3");		  
	});
	$('#dst4').click(function(){
		setDemoCookie("list","style4");		  
	});
	$('#dst5').click(function(){
		setDemoCookie("list","style5");
	});
	
	$('#dst10').click(function(){
		setDemoCookie("list","style10");		  
	});
	$('#dst11').click(function(){
		setDemoCookie("list","style11");		  
	});
</script>

<script>
 	$.ajax({
            type: "POST",  
            url: "<%=basePath%>member/getMessages",
            async:false,
            dataType: "json",
            success: function(data) {
           			$("#notReadNews").get(0).innerHTML="("+data.num+")";
           			$("#number").get(0).innerHTML=data.count;
           			$("#count").get(0).innerHTML=data.num;
           			$("#count2").get(0).innerHTML=+data.num;
              },
            error: function() {
           
            }
        });	
        
   function readTheNews(){
  document.getElementById("mypeitab").style.display="none";
document.getElementById("pei_contents").style.display="block";
	    		
   		$.ajax({
            type: "POST",  
            url: "<%=basePath%>member/queryMessages",
            async:false,
            dataType: "json",
            success: function(data) {
           		if(data[0].info=="0"){
           			window.location.href="<%=basePath%>pei/logout";
           		}else{
           			
           		var len=data.length;
           		var selectcont = 0;
				var databuffer = [];//数据缓存	
			
			
				dqdjyf = document.getElementById("dqdjyf99");
				dqdjyf1 = document.getElementById("dqdjyf199");
				dqdjyf2 = document.getElementById("dqdjyf299");
				dqdjyf3 = document.getElementById("dqdjyf399");
				dqdjyf1.parentNode.style.display = 'none';
				dqdjyf2.parentNode.style.display = 'none';
				dqdjyf3.parentNode.style.display = 'none';
				var peitable = document.getElementById("peitable");
				var buffercount = 0;
				peitable.innerHTML = "";
				for ( var i = 1; i < len; i++) {
				
					var trHtml = document.createElement("tr");
					var redNO="<img src='<%=basePath%>html/img/no_read.png' class='img-read' alt='未读'>";
					var redYES="<img src='<%=basePath%>html/img/yes_read.png' class='img-read' alt='未读'>";
					var res="";
					if(data[i].stateName=='未读'){
						res=redNO;
					}else{
						res=redYES;
					}
					$(trHtml).html("<td class='text-center'> <input type='checkbox' name='checkid' id='checkid' value='"+data[i].id+"'></td><td class='text-center mess-icon'>"
								+res+"</td><td class='text-center' style='max-width:500px;white-space: nowrap; text-overflow:ellipsis; overflow:hidden;text-align:left;'> <a title='\""+data[i].content+"\"' href='javascript:readMessages(\""+data[i].id+"\");' class='i-want-read'>"+data[i].content+"</a> </td><td class='text-center'>" 
								+ data[i].stateName+"</td><td class='text-center'>"
								+ data[i].createTime + "</td>");
					databuffer.push(trHtml.innerHTML);//存入数据到缓存
					if (buffercount < 10)
						peitable.appendChild(trHtml);
					buffercount++;
				}
			
				var bufferlength = databuffer.length;
				var pagecount = 0;
				if (bufferlength % 10 == 0)
					pagecount = parseInt(bufferlength / 10);
				else
					pagecount = parseInt(bufferlength / 10) + 1;
			
				var djy = document.getElementById("djy99");
				var dqdjy = document.getElementById("dqdjy99");
				djy.innerHTML = pagecount;
				dqdjy.innerHTML = 1;
				dqdjyf.innerHTML = 1;
				dqdjyf1.innerHTML = 1;
				dqdjyf1.innerHTML = 1;
				dqdjyf1.innerHTML = 1;
				if (dqdjyf.innerHTML < pagecount) {
					dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
					dqdjyf1.parentNode.style.display = '';
				}
				if ((parseInt(dqdjyf.innerHTML) + 1) < pagecount) {
					dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
					dqdjyf2.parentNode.style.display = '';
				}
				if ((parseInt(dqdjyf.innerHTML) + 2) < pagecount) {
					dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
					dqdjyf3.parentNode.style.display = '';
				}
			
				function zuoyifun() {
					if (parseInt(dqdjyf.innerHTML) - 4 > 0) {
						dqdjyf.parentNode.setAttribute("class", "");
						dqdjyf1.parentNode.setAttribute("class", "");
						dqdjyf2.parentNode.setAttribute("class", "");
						dqdjyf3.parentNode.setAttribute("class", "");
						dqdjyf.innerHTML = parseInt(dqdjyf.innerHTML) - 4;
						dqdjyf.parentNode.setAttribute("class", "active");
						zdymfun(dqdjyf.innerHTML);
						dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
						dqdjyf1.parentNode.style.display = '';
						dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
						dqdjyf2.parentNode.style.display = '';
						dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
						dqdjyf3.parentNode.style.display = '';
					}
				}
				
				
				function youyifun() {
					if (parseInt(dqdjyf.innerHTML) + 4 <= pagecount) {
						dqdjyf.parentNode.setAttribute("class", "");
						dqdjyf1.parentNode.setAttribute("class", "");
						dqdjyf2.parentNode.setAttribute("class", "");
						dqdjyf3.parentNode.setAttribute("class", "");
						dqdjyf.innerHTML = parseInt(dqdjyf.innerHTML) + 4;
						dqdjyf.parentNode.setAttribute("class", "active");
						zdymfun(dqdjyf.innerHTML);
						dqdjyf1.parentNode.style.display = 'none';
						dqdjyf2.parentNode.style.display = 'none';
						dqdjyf3.parentNode.style.display = 'none';
						if (dqdjyf.innerHTML < pagecount) {
							dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
							dqdjyf1.parentNode.style.display = '';
						}
						if ((parseInt(dqdjyf.innerHTML) + 1) < pagecount) {
							dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
							dqdjyf2.parentNode.style.display = '';
						}
						if ((parseInt(dqdjyf.innerHTML) + 2) < pagecount) {
							dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
							dqdjyf3.parentNode.style.display = '';
						}
			
					}
				}
			
				dqdjyf.onclick = function() {
 					dqdjyf.parentNode.setAttribute("class", "active");
					dqdjyf1.parentNode.setAttribute("class", "");
					dqdjyf2.parentNode.setAttribute("class", "");
					dqdjyf3.parentNode.setAttribute("class", "");
					zdymfun(dqdjyf.innerHTML);
				};
			
				dqdjyf1.onclick = function() {
 					dqdjyf.parentNode.setAttribute("class", "");
					dqdjyf1.parentNode.setAttribute("class", "active");
					dqdjyf2.parentNode.setAttribute("class", "");
					dqdjyf3.parentNode.setAttribute("class", "");
					zdymfun(dqdjyf1.innerHTML);
				};
			
				dqdjyf2.onclick = function() {
 					dqdjyf.parentNode.setAttribute("class", "");
					dqdjyf1.parentNode.setAttribute("class", "");
					dqdjyf2.parentNode.setAttribute("class", "active");
					dqdjyf3.parentNode.setAttribute("class", "");
					zdymfun(dqdjyf2.innerHTML);
				};
			
				dqdjyf3.onclick = function() {
 					dqdjyf.parentNode.setAttribute("class", "");
					dqdjyf1.parentNode.setAttribute("class", "");
					dqdjyf2.parentNode.setAttribute("class", "");
					dqdjyf3.parentNode.setAttribute("class", "active");
					zdymfun(dqdjyf3.innerHTML);
				};
				
				
				
				syy = document.getElementById("syy99");
				syyf = document.getElementById("syyf99");
				xyy = document.getElementById("xyy99");
				xyyf = document.getElementById("xyyf99");
				syy.onclick = function() {
					syyfun();
				};
			
				syyf.onclick = function() {
					zuoyifun();
				};
			
				function syyfun() {
					dqdjyf.parentNode.setAttribute("class", "");
					dqdjyf1.parentNode.setAttribute("class", "");
					dqdjyf2.parentNode.setAttribute("class", "");
					dqdjyf3.parentNode.setAttribute("class", "");
 					var peitable = document.getElementById("peitable");
					var syycount = dqdjy.innerHTML;
					if (syycount == 1) {
						alert("已经是第一页");
					} else {
						syycount--;
						zdymfun(syycount);
					}
				}
			
				xyy.onclick = function() {
					xyyfun();
				};
			
				xyyf.onclick = function() {
					youyifun();
				};
			
				function xyyfun() {
				
 					dqdjyf.parentNode.setAttribute("class", "");
					dqdjyf1.parentNode.setAttribute("class", "");
					dqdjyf2.parentNode.setAttribute("class", "");
					dqdjyf3.parentNode.setAttribute("class", "");
 					var peitable = document.getElementById("peitable");
 					var syycount = dqdjy.innerHTML;
					var djycount = djy.innerHTML;
 					if (syycount == djycount) {
						alert("已经是最后一页");
					} else {
 						syycount++;
						zdymfun(syycount);
					}
				}
			
				function zdymfun(syycount) {
				
 					dqdjy.innerHTML = syycount;
					var xhcount = 0;
					peitable.innerHTML = "";
					for ( var i = (syycount - 1) * 10; i < databuffer.length; i++) {
						if (xhcount == 10)
							break;
						var trHtml ="<tr>"+databuffer[i]+"</tr>";
						$(peitable).append(trHtml);
						xhcount++;
					}
				}
			
				function zdfun() {
 					var djycount = djy.innerHTML;
					if ((zdvalue <= djycount) && (zdvalue >= 1)) {
						zdymfun(zdvalue);
					} else {
						alert("页面输入超出范围");
					}
			
				}
			
           		}	
              },
            error: function() {
           
            }
        });	
   }
   
   
   
   function readMessages(obj){

	$.ajax({
		type: "POST",
		data:{id:obj},
		url: "<%=basePathpj%>person/readMessages",
	    dataType: "json",
	    success: function(data){ 
	    	for(var i=0;i<data.length;i++){
	    	
	    		document.getElementById("count").innerHTML="";
	    		document.getElementById("count2").innerHTML="";
	    		document.getElementById("count").innerHTML=data[i].amount;
	    		document.getElementById("count2").innerHTML=data[i].amount;
	    		document.getElementById("pei_detail").innerHTML="";
	    		document.getElementById("pei_detail").innerHTML=data[i].content;
	    		document.getElementById("notReadNews").innerHTML=data[i].amount;
	    		
	    		readTheNews();
	    		document.getElementById("mypeitab").style.display="block";
	    		document.getElementById("pei_contents").style.display="none";
	    	}
	    },
	    error: function() {
	        alert("发送失败");
	    }
	});	
} 


function readAllMessages(){
	if($("[name='checkid']").is(":checked")==true){
		var check=document.getElementsByName("checkid");
		var checks="";
		for ( var i = 0; i < check.length; i++) {
			if(check[i].checked){
				checks+=check[i].value+",";
			}
		}
		$.ajax({
			type: "POST",
			data:{id:checks},
			url: "<%=basePathpj%>person/readAllMessages",
		    dataType: "json",
		    success: function(data){ 
		    	for(var i=0;i<data.length;i++){
		    		document.getElementById("count").innerHTML="";
		    		document.getElementById("count2").innerHTML="";
		    		document.getElementById("count").innerHTML=data[i].amount;
		    		document.getElementById("count2").innerHTML=data[i].amount;
		    		document.getElementById("notReadNews").innerHTML=data[i].amount;
		    		readTheNews();
		    	}
		    },
		    error: function() {
		       
		    }
		});	
	}
}


 function delMessage1(){
	
	if($("[name='checkid']").is(":checked")==true){
		var check=document.getElementsByName("checkid");
		var checks="";
		for ( var i = 0; i < check.length; i++) {
			if(check[i].checked){
				checks+=check[i].value+",";
			}
		}
		$.ajax({
			type: "POST",
			data:{id:checks},
			url: "<%=basePath%>member/delMessages",
		    dataType: "json",
		    success: function(data){ 
		    	for(var i=0;i<data.length;i++){
		    		document.getElementById("count").innerHTML="";
		    		document.getElementById("count2").innerHTML="";
		    		document.getElementById("count").innerHTML=data[i].amount;
		    		document.getElementById("count2").innerHTML=data[i].amount;
		    		document.getElementById("notReadNews").innerHTML=data[i].amount;
		    		document.getElementById("number").innerHTML=data[i].num;
		    		readTheNews();
		    	}
		    },
		    error: function() {
		       
		    }
		});	
	}
  	
} 

$(function() {
    $('.btn-check').click(function() {
        $(this).closest('.table').find(':checkbox').each(function() {
            if ($(this).is(':checked')) {
                $(this).iCheck('uncheck');
            } else if ($(this).not(':checked')) {
                $(this).iCheck('check');
            }
        });
    });
});



function peiBack(){
document.getElementById("mypeitab").style.display="none";
document.getElementById("pei_contents").style.display="block";

}
</script>