<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="./public/head.jsp"%>
<style>

<!--
#tabContainer ul {
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: -40px;
	padding: 0px;
}

#tabContainer li {
	display: inline;
	list-style-type: none;
	text-align: center;
	margin-left: 40px;
}

#tabContainer a.on {
	color: #333;
	font-weight: bold;
}

.vote-star {
	display: inline-block; /*内联元素转换成块元素，并不换行 weisay.com*/
	margin-right: 6px;
	width: 85px; /*5个星星的宽度 weisay.com*/
	height: 15px; /*1个星星的高度 weisay.com*/
	overflow: hidden;
	vertical-align: middle;
	background: url('<%=basePath%>html/images/star.gif') repeat-x 0 -1px;
}

.vote-star i {
	display: inline-block; /*内联元素转换成块元素，并不换行 weisay.com*/
	height: 15px; /*1个星星的高度 weisay.com*/
	background: url('<%=basePath%>html/images/star.gif') repeat-x 0 0;
}

.message {
	display: none;
}

.messageLabel {
	color: red;
}

.messageShow {
	font-size: 10px;
	color: red;
}
p{
	padding: 3px 0px;
}
-->
#uldht li a{
/* color: #00a9ff; */

font-size: 14px;

}
.navbar-default .navbar-nav>li>a {
color: white;
}
#uldht li a:hover{
background-color:#195fa4;
color:white;
}
.cdz-detail-span1{
color:#00a9ff;
}
.cdz-detail-span2{
background-color: #00a9ff;
color: white;
padding:3px;
}
#forms input{
text-align: center;
}
#forms input{
border-radius:0px;
background-color: #ddd;
height: 30px;
}
.detail-span1{
color: #666;
font-size: 14px;
}
.nav-tabs > li.active > a, .nav-tabs > li.active > a:hover, .nav-tabs > li.active > a:focus{
border-radius:0px;
border-top: 2px solid #00a9ff;
}

#con1 a:hover{
text-decoration: none;
}
 table tr td img{
width: 70px;
height: 70px;

border: 1px solid #ddd;
text-align: center;
vertical-align: middle;

color: #999;
}
 .media table {
background-color:#f5f5f5; 
}
/* #con1 .media table {
background-color:#f5f5f5; 
}
#con1 .media table {
background-color:#f5f5f5; 
}
#con1 .media table {
background-color:#f5f5f5; 
} */
</style>
<!--[if IE 7]>
    <link rel="stylesheet" href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome-ie7.min.css">
    <![endif]-->
<link rel="stylesheet"
	href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome.min.css">
<div class="container-fluid">
	<div class="row">
		<%-- <div class="col-md-12" style="font-family: arial,'microsoft yahei';">
			<c:forEach var="mkey" items="${key}">
				<span style="color:#222;font-size: 24px;font-family: 'MicrosoftYahei','微软雅黑','Arial'">${mkey['name']}</span>
			</c:forEach>
			<p>
				<span class="vote-star"> <i style="width:${allstar}"></i> </span>
			</p>
		</div> --%>
	</div>
	<div class="row " style="padding:10px 0;">
		<div class="col-md-5 pull-left">
			<link rel="stylesheet" href="<%=basePath%>html/plugin/Picswitch/switch.css">
			<div class="zoombox">
				<div class="zoompic">
					<img src="${plogo}" style="width: 382px;height: 325px;" class="img-responsive" alt="">
				</div>
				<div class="sliderbox">
					<div id="btn-left" class="arrow-btn dasabled">
						<span class="glyphicon glyphicon-chevron-left"></span>
					</div>
					<div class="slider" id="thumbnail">
						<ul class="list-unstyled" style="overflow:hidden;">
							<c:forEach var="mkey" items="${key}">
								<c:forEach var="lmap" items="${mkey['lmap']}">
									<li class="current" style="margin-left: 1px;"><a
										href="${lmap['image']}" target="_blank"> <img
											style="border: 0px;width: 72px;height:55px;" src="${lmap['image']}"  alt="" /> </a></li>
								</c:forEach>
							</c:forEach>
						</ul>
					</div>
					<div id="btn-right" class="arrow-btn">
						<span class="glyphicon glyphicon-chevron-right"></span>
					</div>
				</div>
			</div>
			<!--slider end-->
		</div>
<div  style="">
			<c:forEach var="mkey" items="${key}">
				<span style="color:#222;font-size: 24px;margin-left: 14px;font-family: 'MicrosoftYahei','微软雅黑','Arial'">${mkey['name']}</span>
			</c:forEach>
			<p>
				<span class="vote-star" style="margin-left: 14px;"> <i style="width:${allstar}"></i> </span>
			</p>
		</div>
		<c:forEach var="mkey" items="${key}">
			<div class="col-md-7 pull-left">
				<div class="media"
					style="color: #666;font: 13px/150% Arial,Verdana,'宋体';">
					<div class="media-body">
						<p>配件名称：<span class="cdz-detail-span1">${mkey['autopartinfoName']}</span></p>
						<p>产品编号：${number}</p>
						<p>生厂商：${mkey['factoryName']}(${mkey['factoryAddress']})</p>
						<p style="padding: 5px 0px;">
							<a href="<%=basePath%>pei/business?id=${mkey['psjId']}" class="cdz-detail-span2">进入店铺</a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a onclick="colGoods('${number}');" class="cdz-detail-span2">收藏商品</a>
						</p>
						<div style="border-top: 1px dotted #ddd; padding: 5px;"></div>
						<div class="pull-left">
							<p>
								<span>平台价：</span><span
									style="font-weight: bolder;color: #FA5E19; font-weight: bold; font-size: 28px; font-family: "Microsoft YaHei";">￥${mkey['memberprice']}&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;
								<span style="">官方价：</span><span
									style="font: 12px/150% Arial,Verdana,'宋体';text-decoration:line-through;">￥${mkey['marketprice']}</span>
							</p>
							<p>
								<span style="background-color:#f60;color:#fff;">&nbsp;促销&nbsp;</span>&nbsp;店铺VIP&nbsp;&nbsp;<!-- <a
									href="javascript:;">登录</a>后可以查看此优惠 -->
							</p>
							<p>
								<span style="background-color:#f60;color:#fff;">&nbsp;配送&nbsp;</span>&nbsp;湖南省内配送
							</p>
							<input type="hidden" value="${mkey['sendcost']}" name="sencost">
						</div>
						<div class="pull-right" >
							<dl class="pull-left text-center"
								style="padding-top:20px;">
								<%-- <dt style="color:#005aa0;">${leng}</dt> --%>
								<dd><img alt="" src="<%=basePath%>html/images/detail-succ.png">&nbsp;&nbsp;${leng}&nbsp;交易成功</dd>
							</dl>
							<dl class="pull-right text-center" style="padding-top: 20px;margin-left: 20px;">
								<%-- <dt style="color:#005aa0;">${len}</dt> --%>
								<dd><img alt="" src="<%=basePath%>html/images/detail-pingjia.png">&nbsp;&nbsp;${len}&nbsp;累计评价</dd>
							</dl>
						</div>
						<div class="clearfix"></div>
						<div style="border-top: 1px dotted #ddd; padding: 5px;"></div>
						<form id="forms" name="forms" classs="forms">
							<p>
								购买数量： <input type="button" value="-"
									onclick="opera('val', false);" class="btn btn-default"
									style="margin-top: -3px;"> <input type="text"
									name="number"
									style="background-color: #fff;background-image: none;border: 1px solid #ccc;color: #555;height: 30px;padding: 6px 12px;"
									size="5" value="1" id="val"
									onkeyup="detailNumber(this);"  
									  />
								<input type="button" value="+" onclick="opera('val', true);"
									class="btn btn-default" style="margin-top: -3px;"> <span
									class="message">请输入正确的数量[]</span> <span class="messageShow"></span>
								<input type="hidden" name="id" value="${mkey['id']}">库存(${mkey['stocknum']})件
								<input type="hidden" name="stocknum" value="${mkey['stocknum']}" id="stocknum">
							</p>
							<p>
								<!-- <button type="button" class="btn btn-primary" id="buy" >立即购买</button> -->
								<button type="button" class="btn btn-primary"
									style="width:166px;height: 40px;font-size: 14px;margin-top:20px;float:left;" onclick="javascript:add();">
									<img alt="" src="<%=basePath%>html/images/addcart.png">
									加入购物车
								</button>
								<%-- <img alt="" src="<%=basePath%>html/img/shoucang.png" style="margin-left: 20px;float: left;margin-top:22px;width: 80px;height:37px;"> --%>
							
							</p>
							
							<p style="color: red;font-size: 12px;float:left;margin-top: 70px;margin-left: -165px;">温馨提示：本商品需与您的车型匹配&nbsp;车队长科技支持</p>
						</form>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
    <div class="row" style="margin-top:10px;">
        <div class="col-md-12">
            <div class="well well-sm">
                <form  onsubmit="return checkInput();" class="form-horizontal" role="form" action="<%=basePath%>trade/subComment">
                <input type="hidden" name="productId" value="${productId}">
                <input type="hidden" name="mainId" value="${mainId}">
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-6 control-label" style="text-align:left;">
                            ${userName}
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">星级</label>
                        <div class="col-sm-6 control-label comment-star" style="text-align:left;">
                             <link href="<%=basePath%>html/plugin/jRate/jquery/jRating.jquery.css" rel="stylesheet" />
                            <link href="<%=basePath%>html/plugin/jRate/css/style.css" rel="stylesheet" />
                            <div class="basic" id="12_1"></div>
                        </div>  
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">评论内容</label>
                        <div class="col-sm-6">
                            <textarea id="editor" name="content" rows="10"></textarea>
                        </div>
                    </div>
                    <div id="message" style="display:none;color:red"></div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-6">
                            <button type="submit" class="btn btn-primary" >提交评论</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
    
<%@ include file="./public/foot.jsp"%>
<script src="<%=basePath%>html/plugin/Picswitch/switch.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
KindEditor.ready(function (K) {
    var editor;
    editor = K.create('#editor', {
    	uploadJson : '<%=uploadUrl%>?root=demo-comment-icon',
        resizeType: 1,
        allowPreviewEmoticons: true,
        allowImageUpload: true,
        items: [
            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
            'insertunorderedlist', '|', 'emoticons', 'image', 'link']
    });
});

var basePathValue = "<%=basePath%>html/";


function checkInput(){
var rate = "<%=session.getAttribute("rate")%>";
var message=document.getElementById("message");	
if(rate=="null" || rate==null || rate==""){
	message.style.display="";
	message.innerHTML="请评分！";
	return false;
}
 return true;
}
</script>

<script type="text/javascript" src="<%=basePath%>html/plugin/jRate/jquery/jRating.jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/jRate/jquery/jRate.js"></script>