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
	<link href="<%=basePath%>html/css/save.css" rel="stylesheet">
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
    <script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
    <style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
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
 	.navbar_lg .container-fluid {
    background-color: #0579E4;
	}
	.navbar{
	min-height: 30px;
	}
	.s_add{
	width:120px;
	height:40px;
	line-height:40px;
	background-color:#fff;
	margin-top:15px;
	vertical-align: middle;
	text-align:center;
	padding-bottom:20px;
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
                    <div class="pull-left" style="padding-top:5px;">
                    	<a href="<%=BccHost.getHost()%>/b2bweb-baike" class="navbar-link">车队长首页</a>
                   		<span class="sep">|</span><a href="<%=basePathwx%>maintain/index?userName=<%=session.getAttribute("userName")%>&id=<%=session.getAttribute("id")%>&typeId=<%=session.getAttribute("typeId")%>" class="navbar-link">我要修车</a>
                   		<span class="sep">|</span><a href="<%=basePath%>pei/index" class="navbar-link">汽配超市</a>
                      <%-- <span class="sep">|</span><a href="<%=basePathwx%>html/trafficindex.jsp" class="navbar-link">车务管家</a> --%>
                      <%--   <img src='<%=basePath%>html/img/top_03.png' style="margin-top: -3px;margin-right:-10px;"> --%>
                        <span class="sep">|</span><a href="/b2bweb-gold/gps.jsp" class="navbar-link">免费GPS</a> 
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
        <div class="navbar navbar-default navbar_lg" rold="navigation" >
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
                    <nav class="collapse navbar-collapse paddingLeft0" style="height:60px;line-height:60px;color:#fff;'">
                    	<div class="pull-left"><font size="5">车队长爱车维权</font></div>
                    	<div class="s_add pull-right"><img style="width:13px;height:13px;" src="<%=basePath%>html/img/safe/save_add.png"></img>&nbsp;&nbsp;<font size="2" color="#333"><a onclick="loginUser();" data-toggle="modal"  data-target="#save-model">我要维权</a></font></div>  
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
    <div class="modal fade save-model" style="margin-left: -200px;" id="save-model">
        <div class="modal-dialog">
            <div class="modal-content" id="model1" >
                <div class="modal-header">
                    <h6 class="modal-title" >在线维权 </h6>
                    <%--<div class="modal-title pull-right" style="padding-right:10px;font-size:18px;">在线查询，及时反馈</div>
                --%>
                </div>
                <div class="modal-body">
                	爱车维权，强调的是车队长采用的是法律武器维权，可重新发表投诉，以便我们再次跟进协调，使消费者自身利益得到维护！
                	<div class="step_menu">
                		<ul>
                			<li>1、注册会员</li>
                			<li class="active">2、发表投诉</li>
                			<li>3、专业审核</li>
                			<li>4、企业处理</li>
                			<li>5、结果审核</li>
                			<li>6、处理完毕</li>
                		</ul>
                	</div>
                	<script type="text/javascript" src="<%=basePath%>html/js/validate.js"></script> 
                <div class="panel current" style="box-shadow: 0px rgba(0, 0, 0, 0.05);clear:both;">                                                   
                        	<form class="form0" target="_self" method="post" action="<%=basePath%>carsaf/complaintApply" onsubmit="javascript:return onsubmitlist();">
                            	<div class="group group0">
                                    <br>
                                    <span style="color: red;">温馨提示：你所投诉的问题必须累计超过三十个用户，我们才会帮您申请投诉！</span><br><br>
                                    <p><em>*</em>车主姓名：<input name="car_name" id="car_name" maxlength="5" class="textbox" style="width:115px;" type="text" onblur="validatelegalName('car_name')">
                   <span class="message" >车主姓名不能为空[]</span>
                   				<span class="messageShow" ></span>                 
                                    　<em>*</em>联系电话：<input name="telephone" id="telephone" class="textbox" maxlength="20" style="width:115px;" type="text" onblur="validatelegalTel('telephone');">
                                      <span class="message" >联系电话格式不正确[]</span>
                   				<span class="messageShow" ></span>    
                                    <br><br><em>*</em>具体车型：<select name="brand"  id="car-brand-data">
                                    <option value="0">-请选择品牌-</option>
                                </select>
                                <select name="factory"  id="car-factory-data">
                                    <option value="0">-请选择厂商-</option>
                                </select>
                                <select name="fct"  id="car-series-data">
                                    <option value="0">-请选择车系-</option>
                                </select>
                                 <select name="speci"  id="car-modal-data" onblur="validatelegalModle('car-modal-data');">
                                    <option value="0">-请选择车型-</option>
                                </select>
                                <span class="message" >请选择车型[]</span>
                   				<span class="messageShow" ></span> 
									</p>
									<br>
									<p><em>*</em>行驶里程：<input name="mileage" id="mileage" maxlength="5" class="textbox" style="width:115px;" type="text" onblur="validatelegalName('mileage')">
									<span class="message" >行驶里程不能为空[]</span>
                   				<span class="messageShow" ></span>       
									      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购车日期：<input name="buy_car_time" id="buy_car_time" class="textbox" maxlength="20" style="width:115px;" type="text" onclick="new Calendar().show(this);" onblur="validatelegalName('buy_car_time')" onmousemove="validatelegalName('buy_car_time')">
									      <span class="message" >购车日期不能为空[]</span>
                   				<span class="messageShow" ></span>  
									      </p>
									<br><p><em>*</em>购车城市：<select name="car_province"  id="car-province-data">
                                    <option value="0">-请选择省-</option>
                                </select>
                                <select name="car_city"  id="car-city-data" onblur="validatelegalName('buy_car_city')">
                                    <option value="0">-请选择市-</option>
                                </select>
                                <input name="buy_car_city" id="buy_car_city" maxlength="5" class="textbox" style="width:115px;" type="text" hidden>
									 <span class="message" >购车城市不能为空[]</span>
                   				<span class="messageShow" ></span>  
									    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购车店面：<input name="buy_car_store" id="buy_car_store" class="textbox" maxlength="20" style="width:115px;" type="text" onblur="validatelegalName('buy_car_store')">
									     <span class="message" >购车店面不能为空[]</span>
                   				<span class="messageShow" ></span>  
									    </p> 
 									<br>
                                    <p><em>*</em>投诉对象：<select id="complaint_object" name="complaint_object" class="s3" style="width:207px;" onblur="validatelegalModle('complaint_object');" onchange="complaintObjectList02();">
                                            <option value="0">-请选择-</option>
											<option value="1">整车维权</option>
											<option value="2">4S店维权</option>
											<option value="3">保险维权</option>
											<option value="4">其他维权</option>
										</select>
										 <span class="message" >投诉对象不能为空[]</span>
                   				<span class="messageShow" ></span>  
									</p><br>
									<div style="display:none;" id="inline-block-id-02"><span id="block_id_02">店铺名称：</span><input type="text" value="" name="store_complanint" id="store_complanint_02"></div>
									<br><span id="complaint_id_all_02"></span><br>
									<p><em>*</em>标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：<input name="title" id="title" maxlength="10" class="textbox" style="width:200px;" type="text" onblur="validatelegalName('title')" placeholder="最多输入十个字符">
									<span class="message" >标题不能为空[]</span>
                   				<span class="messageShow" ></span><span style="color: gray;">如：一汽大众漏油</span>
									</p><br>
									<p><em>*</em>车牌号码：<select name="recruitment_02_id"  id="recruitment_02_id"    onchange="carNumberAllShow_02();"><option value="0">-请选择-</option> 
									<c:forEach var="mkeycar" items="${keycar}">
									<option value="${mkeycar['id']}">${mkeycar['name']}</option>
									</c:forEach></select><select name="letter_02"  id="letter_02"  onchange="carNumberLatter_02();"><option>-请选择-</option></select><input name="car_number" id="car_number_02" maxlength="32" class="textbox" style="width:112px;height: 30px;" type="text" onblur="validatelegalcarNumber_02('car_number_02')"> <span class="message" >车牌号码格式不正确[]</span>
                   				<span class="messageShow" ></span>  <br><br>  
									<div class="box0" onmouseover="validateNullCheck2_08();">
									 <h4><em>*</em>投诉分类：</h4>
									<c:forEach var="mkey01" items="${keyOneTypeAll}">
 									<h5>${mkey01['name']}</h5> 
 									<c:forEach var="mkey03" items="${mkey01['keytwo']}">
									 <ul class="clearfix">
												<li><label for="chk0"><input id="complaint_type" name="complaint_type" value="${mkey03['id']}" type="checkbox" >&nbsp;<span>${mkey03['name']}</span></label></li>
                                             </ul>
									
									</c:forEach>
                    				 
									</c:forEach>
                                    <span id="mesage_id_str01" style="color: red"></span>
									</div><br>
									<div class="box1" onmouseover="validateNullCheck2_09();">                                     
										<em>*</em>诉讼请求： 
                                         <ul class="clearfix">
                                             <c:forEach var="mkey02" items="${sqkey}">
	                                        <li><label for="chk60"><input id="lawsuit_request" name="lawsuit_request" value="${mkey02['id']}" type="checkbox">&nbsp;<span>${mkey02['name']}</span></label></li>
	                                        </c:forEach><br><br>
	                                        <span id="mesage_id_str02" style="color: red"></span>
	                                         
	                                    </ul>
                                    </div><br>
									<p>请填写详细内容/您希望如何解决<font color="red">（在线维权添加提示：为确保您的信息能正确发布，请确保维权信息完整，信息内容真实!）</font></p>
                                	<p><textarea id="detail_content" name="detail_content" cols="123" rows="10" onblur="validatelegalName('detail_content')"></textarea>
                                	 <span class="message" >详细情况不能为空[]</span>
                   				<span class="messageShow" ></span>  
                                	</p>
                                	<p style="float:right;"><button class="btn sbt"   type="submit">提交投诉信息</button></p>
                                </div>
                            </form>
                        </div>
                </div>
            </div>
            
           
        </div>
    </div>
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
function complaintObjectList02(){
  var comp= $('#complaint_object').val();
   if(comp=="1"){
      var factory=$("#car-factory-data").find("option:selected").text();
      var factory_id=$("#car-factory-data").val();
       if(factory_id!="0"){
        $('#inline-block-id-02').css("display","none");
      $('#complaint_id_all_02').text("商家："+factory);
      } else{
     /*   $('#inline-block-id').css("display","none");
      $('#complaint_id_all').text("请选择具体车型");
      $('#complaint_id_all').css("color","red"); */
      }
   
   }
   if(comp=="2"){
    $('#block_id_02').text("店铺名称：");
    $('#inline-block-id-02').css("display","inline-block");
    $('#complaint_id_all_02').text("");
   }
   if(comp=="3"){
   $('#block_id_02').text("保险公司：");
   $('#inline-block-id-02').css("display","inline-block");
   $('#complaint_id_all_02').text("");
   }
   if(comp=="4"){
   $('#block_id_02').text("其他详情：");
   $('#inline-block-id-02').css("display","inline-block");
   $('#complaint_id_all_02').text("");
   }

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
function onsubmitlist(){
      var type=true;
     if (!validatelegalCheck('complaint_type')) {
         $('#mesage_id_str01').html("请填写投诉分类");
		type = false;
	} else{
	$('#mesage_id_str01').html("");
	}
	 if (!validatelegalCheck2('lawsuit_request')) {
	    $('#mesage_id_str02').html("请填写诉讼请求");
		type = false;
	}else{
	    $('#mesage_id_str02').html("");
	} 
	if (!validatelegalTel('telephone')) {
 		type = false;
	} 
	if (!validatelegalName('car_name')) {
 		type = false;
	} 
	if (!validatelegalName('mileage')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_time')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_city')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_store')) {
 		type = false;
	} 
	if (!validatelegalName('title')) {
 		type = false;
	} 
	if (!validatelegalName('detail_content')) {
 		type = false;
	} 
	if (!validatelegalModle('complaint_object')) {
 		type = false;
	} 
	if (!validatelegalModle('car-modal-data')) {
 		type = false;
	} 
	if (!validatelegalcarNumber_02('car_number_02')) {
 		type = false;
	} 
    return type;
 
}   
//start
function validatelegalModle(thisEle) {
 	var _this=document.getElementById(thisEle);
  	if(!validateNullModel(_this)){
 		return false;
	} else{
  	return 	true;
 
	}
 
}

function validateNullModel(obj){
    	var message = $(obj).next().text();
	if($(obj).val()==null||$(obj).val().length==0 || $(obj).val()=="0" || $(obj).val()==0){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
//end
//start
function validatelegalCheck(thisEle) {
 var _this=document.getElementById("complaint_type");
  	if(!validateNullCheck(_this)){
 		return false;
	} else{
  	return 	true;
 
	}
 
}
function validateNullCheck(obj){
    	var message = $(obj).next().text();
    		var _this = document.getElementsByName("complaint_type");
    		var state=false;
  	   for(var i=0;i<_this.length;i++){
  	   if(_this[i].checked ){
  	      state= true;
  	   }
  	   }
	if(state==false){
 		$(obj).next().next().text(message.split('[]')[0]);
  		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
//end
//start
function validatelegalCheck2(thisEle) {
 var _this=document.getElementById("lawsuit_request");
  	if(!validateNullCheck2(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
 
}
function validateNullCheck2(obj){
    	var message = $(obj).next().text();
    		var _this = document.getElementsByName("lawsuit_request");
    		var state=false;
  	   for(var i=0;i<_this.length;i++){
  	   if(_this[i].checked ){
  	      state= true;
  	   }
  	   }
	if(state==false){
 		$('#mesage_id_str').next().text(message.split('[]')[0]);
   		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
//end
//start
function validateNullCheck2_08(obj){
     		var _this = document.getElementsByName("complaint_type");
    		var state=false;
  	   for(var i=0;i<_this.length;i++){
  	   if(_this[i].checked ){
  	      state= true;
  	   }
  	   }
  	if(state==false){
 		   $('#mesage_id_str01').html("请选择投诉分类");
   		return false;
	}else{
  		  $('#mesage_id_str01').html("");
  	}
	return true;
}
//end
//start
function validateNullCheck2_09(obj){
     		var _this = document.getElementsByName("lawsuit_request");
    		var state=false;
  	   for(var i=0;i<_this.length;i++){ 
  	   if(_this[i].checked ){
  	      state= true;
  	   }
  	   }
 	if(state==false){
 		   $('#mesage_id_str02').html("请选择诉讼请求");
   		return false;
	}else{
  		  $('#mesage_id_str02').html("");
  	}
	return true;
}
//end
</script>
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
		str = " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+"  <a  href=\"<%=basePathwx%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
	if(typeId=="2")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+"   <a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="3")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+" <a  href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		
	if(typeId=="5")
		str =  " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+" <a  href=\"<%=basePath%>purchase/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="4")
		str = " <a href='<%=basePath%>pei/showCart'><img src='<%=basePath%>html/img/top-cart.png' ><span style='color: #777;'>购物车</span购物车><span style='color: red;'>"+cart+"</span></a>"+ "   <a  href=\"<%=trafficPath%>manager/showIndex\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
		dlyzc.innerHTML = str;
	}

function searchFun(){
document.form1.action="<%=basePath%>pei/searchProduct";
document.form1.submit();
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
<script>
function loginUser(){
var userName = "<%=session.getAttribute("userName")%>";	
  if(userName==null ||userName =="" ||userName=="null"){
    alert("请先登录，否则填写的信息无效！");
    
  }

}
 
</script>
<script>
var car_url_02="<%=basePathRe%>";
var recruitmentText_02="";
	 var letter_02="";
	function carNumberAllShow_02(){
 	var recruitment_02=$('#recruitment_02_id').val();
   recruitmentText_02=$("#recruitment_02_id").find("option:selected").text();     
 	 $.ajax({
		    type:"POST",
		    data:{id:recruitment_02},
		    url:car_url_02+"member/addCarNumberTwo",
		    async:false,
		    dataType:"html",
		    success:function(str){
		      $('#letter_02').html(str);
		      $('#car_number_02').val(recruitmentText_02);
		    },
		    error:function(){
		      alert("请求失败!");
		    }
		   }); 
  
};
function carNumberLatter_02(){
      letter_02=$("#letter_02").find("option:selected").text(); 
         $('#car_number_02').val(recruitmentText_02+letter_02);
}
//start
function validatelegalcarNumber_02(thisEle) {
   	var _this=document.getElementById(thisEle);
  	if(!validatecarNumber_02(_this)){
  		return false;
  		
	} else{
		
  	return 	true;
 
	}
 
}
function validatecarNumber_02(obj){
   	var message = $(obj).next().text();
   	var rules=/^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/;
  	if(!(rules.test($(obj).val()))){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
</script>
