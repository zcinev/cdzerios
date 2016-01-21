<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
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
    <link href="<%=basePath%>html/css/join.css" rel="stylesheet">
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
/*.navbar .container-fluid .row .pull-left a{
	 padding-right:9px;
	 padding-left:9px;
 	 border-right: 1px solid #DFDFDF;
 	 }*/
.navbar .sep {
    margin: 0px 10px;
    color: #DFDFDF;
}
.sep {
    font-family: sans-serif;
}
.modal-title{
color:#222;font-size: 24px;margin-left: 14px;font-family: 'MicrosoftYahei','微软雅黑','Arial';
}
.text-center{
font-weight: normal;
}
.table tr td{
text-align: center;
color: #666;
}	
.close1{
float:right;
margin-top:-10px;
width:35px;
height:35px;
background: #00a9ff;
font-size: 21px;
font-weight: 700;
color:white;
}	

.table tr th {
    text-align: center;
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
        <!-- <div class="navbar navbar-inverse marginBottom0"> -->
        <div class="navbar navbar-default marginBottom0">
            <div class="container-fluid">
                <div class="row" id="row">
                    <div class="pull-left" style="padding-top:13px;">
	                    <a href="/b2bweb-baike" class="navbar-link">车队长首页</a>
                        <span class="sep">|</span><a href="<%=basePathpj%>maintain/index?userName=<%=session.getAttribute("userName")%>&id=<%=session.getAttribute("id")%>&typeId=<%=session.getAttribute("typeId")%>" class="navbar-link">我要修车</a>
                        <span class="sep">|</span><a href="<%=basePath%>pei/index" class="navbar-link">汽配超市</a>
                        <%--<span class="sep">|</span><a href="<%=basePathpj%>html/trafficindex.jsp" class="navbar-link">车务管家</a> --%>
                    	<%--   <img src='<%=basePath%>html/img/top_03.png' style="margin-top: -3px;margin-right:-10px;"> --%>
                        <span class="sep">|</span><a href="/b2bweb-demo/html/productShow.jsp" class="navbar-link">官网产品</a> 
                        <span class="sep">|</span><img src='<%=basePath%>html/img/top_05.png' style="margin-top: -3px;">
                        <a href="<%=basePath2%>gold/1.jsp" class="navbar-link">官网</a> 
                        <%-- <span class="sep">|</span><a href="<%=basePath%>carsaf/carSafeIndex" class="navbar-link">汽车维权</a> --%>
                	</div>
	                <div id="dlyzc" class="pull-right cdzer-navtop" style="padding-top:13px;">
		                <a href="<%=basePath%>/html/login.jsp" class="navbar-link" role="button">登录</a><a href="<%=basePath%>/html/register.jsp" class="navbar-link" role="button">注册</a>
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
        <div class="container-fluid">
            <div class="row">
                <span class="pull-left" style="margin-top:8px;">您现在的位置：</span>
                <ol class="breadcrumb pull-left marginBottom0" style="background-color:#fff;">
                    <li><a href="<%=basePath%>pei/index">首页</a></li>
                    <li class="active"><a href="<%=basePath%>purchase/showIndex">会员中心</a></li>
                </ol>
            </div>
        </div>
    </header>
    <div class="modal fade msg-box-modal" id="myMsg" tabindex="-1" role="dialog"
	aria-labelledby="myMsg" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close1" data-dismiss="modal" >
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h2 class="modal-title" id="myMsg_c">
					<span class="pull-left">消息中心</span>
					<h5 class="pull-left" style="margin-top:17px;margin-left:10px;">
						（共<span id="t_number" style="color:red;">${number}</span>条消息，其中<span style="color:#666;">未读消息</span><span id="t_amount" style="color:red;">${amount}</span>条）
					</h5>
				</h2>
				<div class="clearfix" ></div>
			</div>
			<div class="modal-body">
				<div id="t_contents">
					<ul class="nav nav-tabs" role="tablist">
						<li class="active"><a href="#t_remind" role="tab"
							data-toggle="tab">消息</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="t_remind">
							<form name="t_form1" method="post" action="">
								<table class="table table-striped">
									<tr class="warning">
										<td colspan="5">您有<span id="t_amount2" style="color:red;">${amount}</span>条未读信息
										</td>
									</tr>
									<tbody id="t_dpgltable"></tbody>
									<tr>
										<td colspan="5" ><a href="javascript:delMsg1();" class="btn btn-default">删除</a>
											<a href="#" class="btn btn-default btn-check">全选/反选</a> <a
											href="#" class="btn btn-default" onclick="readAllMsgs()">标记为已读</a> <a href="#"
											class="btn btn-default">转发</a> <a href="#"
											class="btn btn-default">举报</a></td>
									</tr>
									<tr>
										<td colspan="5">
											<div>
												<ul class="pager pull-right"
													style="margin-left:2px;margin-right:2px;">
													<li><a id="t_syy">上一页</a>
													</li>
													<li><a id="t_xyy">下一页</a>
													</li>
												</ul>
												<span class="label label-default pull-right label-page">共<span
													id="t_djy">20</span>页</span> <span
													class="label label-primary pull-right label-page">当前第<span
													id="t_dqdjy">5</span>页</span>
												<ul class="pagination pull-right">
													<li><a id="t_syyf">&laquo;</a>
													</li>
													<li class="active"><a id="t_dqdjyf">1</a>
													<li class=""><a id="t_dqdjyf1">1</a>
													<li class=""><a id="t_dqdjyf2">1</a>
													<li class=""><a id="t_dqdjyf3">1</a></li>
													<li><a id="t_xyyf">&raquo;</a>
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
				<div id="t_mytab" style="display: none;">
					<div class="remind">
						<div class="well">
							<span id="t_detail"></span>
							<p class="text-right">
								<a href="#" class="btn btn-primary" onclick="t_reBank()">返回</a>
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
		str = " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span><span style='color: red;'>"+cart+"</span></a>"+"  <a  href=\"<%=basePathpj%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+"</a><a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
	if(typeId=="2")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span><span style='color: red;'>"+cart+"</span></a>"+"   <a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a><a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="3")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span><span style='color: red;'>"+cart+"</span></a>"+
		"<a data-toggle='modal' data-target='#myMsg' onClick='internalMsg()'><img src='<%=basePathpj%>html/img/topmsg.png' style='margin-top: -3px;' > <span style='color: #777;'>消息</span><span id='t_unread' style='color: red;'>"+tnum+"</span></a>"+
		" <a  href=\"<%=basePathpj%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a><a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		
	if(typeId=="5")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span><span style='color: red;'>"+cart+"</span></a>"+
		"<a  data-toggle='modal' data-target='#myMsg' onClick='internalMsg()'><img src='<%=basePath%>html/img/topmsg.png' style='margin-top: -3px;' > <span style='color: #777;'>消息</span><span id='t_unread' style='color: red;'>"+tnum+"</span></a>"+
		" <a  href=\"<%=basePath%>purchase/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a><a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="4")
		str = " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span><span style='color: red;'>"+cart+"</span></a>"+ "   <a  href=\"<%=trafficPath%>manager/showIndex\">"+strName+" </a><a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		dlyzc.innerHTML = str;
	}


</script>
<script>
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
function internalMsg(){
	$.ajax({
      type: "POST",
      url: "<%=basePathpj%>person/getMessages1",
      dataType: "json",
      success: function(data){ 
     		var len=data.length;
     		var selectcont = 0;
			var databuffer = [];//数据缓存	
			if(data.length>0){
				$("#t_number").get(0).innerHTML=data[0].number;
				$("#t_amount").get(0).innerHTML=data[0].amount;
				$("#t_amount2").get(0).innerHTML=data[0].amount;
			}
			
			dqdjyf = document.getElementById("t_dqdjyf");
			dqdjyf1 = document.getElementById("t_dqdjyf1");
			dqdjyf2 = document.getElementById("t_dqdjyf2");
			dqdjyf3 = document.getElementById("t_dqdjyf3");
			dqdjyf1.parentNode.style.display = 'none';
			dqdjyf2.parentNode.style.display = 'none';
			dqdjyf3.parentNode.style.display = 'none';
			var t_dpgltable = document.getElementById("t_dpgltable");
			var buffercount = 0;
			t_dpgltable.innerHTML = "";
			for ( var i = 0; i < len; i++) {
				var trHtml = document.createElement("tr");
				var redNO="<img src='<%=basePathpj%>html/img/no_read.png' class='img-read' alt='未读'>";
				var redYES="<img src='<%=basePathpj%>html/img/yes_read.png' class='img-read' alt='未读'>";
				var res="";
				if(data[i].stateName=='未读'){
					res=redNO;
				}else{
					res=redYES;
				}
				var cont1=data[i].content;
				if(cont1.length>30){
					cont1=cont1.substring(0,30)+"……";
				}
				var trbuffer = "<tr><td class='text-center'> <input type='checkbox' name='t_checkid' id='t_checkid' value='"+data[i].id+"'></td><td class='text-center mess-icon'>"
							+res+"</td><td class='text-center' > <a title='\""+data[i].content+"\"' href='javascript:t_readMessages(\""+data[i].id+"\");' class='i-want-read'>"+cont1+"</a> </td><td class='text-center'>" 
							+ data[i].stateName+"</td><td class='text-center'>"
							+ data[i].createTime + "</td></tr>";
				databuffer.push(trbuffer);//存入数据到缓存
				if (buffercount < 10)
					$("#t_dpgltable").append(trbuffer);
				buffercount++;
			}
		
			var bufferlength = databuffer.length;
			var pagecount = 0;
			if (bufferlength % 10 == 0)
				pagecount = parseInt(bufferlength / 10);
			else
				pagecount = parseInt(bufferlength / 10) + 1;
		
			var djy = document.getElementById("t_djy");
			var dqdjy = document.getElementById("t_dqdjy");
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
		
			syy = document.getElementById("t_syy");
			syyf = document.getElementById("t_syyf");
			xyy = document.getElementById("t_xyy");
			xyyf = document.getElementById("t_xyyf");
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
				var t_dpgltable = document.getElementById("t_dpgltable");
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
				var t_dpgltable = document.getElementById("t_dpgltable");
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
				t_dpgltable.innerHTML = "";
				for ( var i = (syycount - 1) * 10; i < databuffer.length; i++) {
					if (xhcount == 10)
						break;
					
					$("#t_dpgltable").append(databuffer[i]);
					
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
		
			function chg() {
				if (document.getElementById("sel").value == "txt") {
					selectcont = 0;
				}
				if (document.getElementById("sel").value == "btn") {
					selectcont = 1;
				}
			}
      },
      error: function() {
          alert("发送失败");
      }
  });	
} 
function t_readMessages(obj){
	$.ajax({
		type: "POST",
		data:{id:obj},
		url: "<%=basePathpj%>person/readMessages",
	    dataType: "json",
	    success: function(data){ 
	    	for(var i=0;i<data.length;i++){
	    		document.getElementById("t_amount").innerHTML="";
	    		document.getElementById("t_amount2").innerHTML="";
	    		document.getElementById("t_amount").innerHTML=data[i].amount;
	    		document.getElementById("t_amount2").innerHTML=data[i].amount;
	    		document.getElementById("t_detail").innerHTML="";
	    		document.getElementById("t_detail").innerHTML="<span onclick=\"enterDetail('"+obj+"','"+data[i].tag+"','"+data[i].relatedId+"');\">"+data[i].content+"</span>";
	    		
	    		document.getElementById("t_unread").innerHTML=data[i].amount;
	    		
	    		internalMsg();
	    		document.getElementById("t_mytab").style.display="block"; 
	    		document.getElementById("t_contents").style.display="none";
	    	}
	    },
	    error: function() {
	        alert("发送失败");
	    }
	});	
} 

function readAllMsgs(){
	if($("[name='t_checkid']").is(":checked")==true){
		var check=document.getElementsByName("t_checkid");
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
		    		document.getElementById("t_amount").innerHTML="";
		    		document.getElementById("t_amount2").innerHTML="";
		    		document.getElementById("t_amount").innerHTML=data[i].amount;
		    		document.getElementById("t_amount2").innerHTML=data[i].amount;
		    		document.getElementById("t_unread").innerHTML=data[i].amount;
		    		document.getElementById("t_number").innerHTML=data[i].num;
		    		//document.getElementById("t_detail").innerHTML="";
		    		//document.getElementById("t_detail").innerHTML=data[i].content;
		    		internalMsg();
		    		//document.getElementById("t_mytab").style.display="block";
		    		//document.getElementById("t_contents").style.display="none";
		    	}
		    },
		    error: function() {
		        alert("发送失败");
		    }
		});	
	}
}

function t_reBank(){
	document.getElementById("t_mytab").style.display="none";
	document.getElementById("t_contents").style.display="block";
}

 function delMsg1(){
	if($("[name='t_checkid']").is(":checked")==true){
		document.t_form1.action="<%=basePath%>person/delMessages1";
  		document.t_form1.submit();
	}
  	
} 
 function delMsg2(){
  document.form2.action="<%=basePath%>person/delMessages1";
  document.form2.submit();	
}
 function enterDetail(obj,tag,relatedId){
		
		if(tag=="system"||tag=="join"||tag=="register"){
			return;
		}
		if(tag=="order"){
			window.location.href="<%=basePath%>message/queryOrder?id="+relatedId;
		}
		if(tag=="comment"){
			window.location.href="<%=basePath%>comment/commentParts";
		}
		if(tag=="askPrice"){
			window.location.href="<%=basePath%>message/queryAskPrice?id="+relatedId;
		}
		}
</script>