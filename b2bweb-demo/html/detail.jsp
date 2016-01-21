<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/head.jsp"%>
<style>
<!--

.vote-star{
	display:inline-block;/*内联元素转换成块元素，并不换行 weisay.com*/
	margin-right:6px;
	width:85px;/*5个星星的宽度 weisay.com*/
	height:17px;/*1个星星的高度 weisay.com*/
	overflow:hidden;
	vertical-align:middle;
	background:url('<%=basePath%>html/images/star.gif') repeat-x 0 -17px;
	}
	
.vote-star i{
	display:inline-block;/*内联元素转换成块元素，并不换行 weisay.com*/
	height:17px;/*1个星星的高度 weisay.com*/
	background:url('<%=basePath%>html/images/star.gif') repeat-x 0 0;
	}
-->
</style>
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
#con1,#con2,#con3,#con4{
	margin-top:10px;
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
#peiDetail img{
 width:330px;
 height:225px;
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

.wl-info-active, .wl-info-active:hover {
    border: 1px solid #FF5002;
    background-color: #FF5002;
    color: #FFF;
}
.wl-addressinfo, .wl-servicetitle {
    cursor: pointer;
    border: 1px solid #FFF;
    background-color: #FFF;
    padding: 0px 3px;
    margin-right: 10px;
    color: #3C3C3C;
    display: inline-block;
    line-height: 18px;
}
.wl-info-active s, .wl-info-active:hover s {
    color: #FFF;
    transform: rotate(180deg);
    border-color: #606060 transparent transparent;
}
.wl-addressinfo s, .wl-servicetitle s, .wl-areatab-con s {
    display: inline-block;
    position: relative;
    width: 0px;
    height: 0px;
    overflow: hidden;
    border-color: #606060 transparent transparent;
    border-width: 4px 4px 0px;
    border-style: solid;
    margin: 3px;
}
.wl-addressinfo:hover,.wl-servicetitle:hover{
	border:1px solid #ff5002;
	background-color:#ffefe4;
	color:#ff5d13;
	text-decoration:none
}
.wl-addressinfo:hover s,.wl-servicetitle:hover s{
	color:#ff5002;
	border-color:#ff5002 transparent transparent
}
#sendAddress{
	position:absolute;
	left:128px;
    background-color: #FFF;
    padding: 10px;
    width: 414px;
    border: 1px solid #FF5002;
    z-index:1000;
    display:none;
}
.address-all-close {
    width: 14px;
    height: 14px;
    position: absolute;
    right: 10px;
    top: 10px;
    background: transparent url("http://img01.taobaocdn.com/tps/i1/T1U6rrXlNqXXaZ_F7_-126-41.png") no-repeat scroll -33px -26px;
}
.address-all-title-par {
    width: 100%;
    border-bottom: 1px solid #FF5002;
    height: 21px;
    margin-top: 10px;
}
#sendAddress .address-all-title-par .address-all-title-selected {
    color: #000;
    position: relative;
    height: 21px;
    border-right: 1px solid #FF5002;
    border-top: 1px solid #FF5002;
    border-left: 1px solid #FF5002;
}
.address-all-title-selected{
	color: #000;
    position: relative;
    height: 21px;
    border-right: 1px solid #FF5002;
    border-top: 1px solid #FF5002;
    border-left: 1px solid #FF5002;
}

.address-all-title-par .address-all-title {
    height: 20px;
    line-height: 20px;
    color: #3C3C3C;
    font-size: 12px;
    padding: 0px 2px 0px 5px;
    border-right: 1px solid #E5E5E5;
    border-top: 1px solid #E5E5E5;
    border-left: 1px solid #E5E5E5;
    margin-right: 5px;
    float: left;
    cursor: pointer;
    background-color: #FFF;
}
.address-all-con-par {
    width: 100%;
}
.wl-list-add-con {
    margin: 5px 0px 0px;
    padding: 0px;
    display: block;
    width: 100%;
}
.wl-list-add-con .wl-list-item {
    margin: 5px;
    float: left;
    border: 1px solid #FFF;
    padding: 0px 10px;
    color: #333;
}
.wl-list-item {
    cursor: pointer;
    line-height: 18px;
    font-size: 12px;
    color: #333;
    list-style: outside none none;
    margin: 0px;
    padding: 4px 10px;
    overflow: hidden;
    position: relative;
}
.wl-list-item s{
	position:absolute;
	font-family:wlroute-iconfont;
	text-decoration:none;
	display:none;
	width:0;
	height:0;
	font-size:12px;
	bottom:0;
	right:0;
	border:7px solid #ff5002;
	border-top-color:#ffefe4;
	border-left-color:#ffefe4;
	color:#fff;
	font-size:12px;
	line-height:2px;
	*line-height:5px;
	line-height:7px\9\0
}

.wl-list-item:hover,.wl-list-active{
	background-color:#ffefe4
}
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
					
					<div style="width:400px;float:left">
					<c:if test="${mkey['autopartinfoName']!='null' && mkey['autopartinfoName']!=''}">
						<p>配件名称：<span class="cdz-detail-span1">${mkey['autopartinfoName']}</span></p>
					</c:if>
					
					<c:if test="${mkey['productType']=='官方商品'}">
						<p>配件名称：<span class="cdz-detail-span1">${mkey['name']}</span></p>
					</c:if>
					
						<p>产品编号：${number}</p>
						<c:if test="${mkey['centerIdName']!='null' && mkey['centerIdName']!=''}">
						<p>配件超市：${mkey['centerIdName']}</p>
						</c:if>
						
						<c:if test="${mkey['factoryName']!='null' && mkey['factoryName']!=''}">	
						<p>生产商：${mkey['factoryName']}(${mkey['factoryAddress']})</p>
						</c:if>
						
							<c:if test="${mkey['productType']!='官方商品'}">	
						<p>经销商：${mkey['storeIdName']}</p>
						</c:if>
						
						<c:if test="${mkey['productType']=='官方商品'}">	
						<p>经销商：车队长（湖南）科技有限公司</p>
						</c:if>
						
						<p style="padding: 5px 0px;">
						<c:if test="${mkey['psjId']}!=null && ${mkey['psjId']}!=''">
							<a href="<%=basePath%>pei/business?id=${mkey['psjId']}" class="cdz-detail-span2">进入店铺</a>
						
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:if>
							<a onclick="colGoods('${number}');" class="cdz-detail-span2">收藏商品</a>
						</p>
					</div>	
					<div style="float:left;width:150px;">
					<c:if test="${pkey!=''}">
					<p>在线咨询：</p>
					</c:if>
					<c:forEach var="mkey1" items="${pkey}">
					<span style="float:left:width:120px;margin-right:20px;">
					<a target=blank 
					href="http://wpa.qq.com/msgrd?v=1&uin=${mkey1.serviceQQ }&site= www.ltfx88.com&Menu=no">
					<img border="0" style="height:17px;" SRC="<%=basePath%>html/img/pa.gif"  alt="点击发送消息给对方">客服
					</a>
					</span>
					
					<c:if test="${mkey1.index=='1'}">
					<p>&nbsp;</p>
					</c:if>
				</c:forEach>
					</div>
						<div style="border-top: 1px dotted #ddd; padding: 5px;"></div>
						<div class="pull-left">
							<p>
								<span>平台价：</span><span
									style="font-weight: bolder;color: #FA5E19; font-weight: bold; font-size: 28px; font-family: "Microsoft YaHei";">￥${mkey['memberprice']}&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;
								<span style="">官方价：</span><span
									style="font: 12px/150% Arial,Verdana,'宋体';text-decoration:line-through;">￥${mkey['marketprice']}</span>
							</p>
							<!-- <p>
								<span style="background-color:#f60;color:#fff;">&nbsp;促销&nbsp;</span>&nbsp;店铺VIP&nbsp;&nbsp;<a
									href="javascript:;">登录</a>后可以查看此优惠
							</p> -->
							<p>
								<span style="background-color:#f60;color:#fff;">&nbsp;配送&nbsp;</span>&nbsp;${address }&nbsp;至<span id="J-To">
								<span class="wl-addressinfo wl-info-active" id="J_WlAddressInfo"
								 title="湖南长沙岳麓区" style="diaplay:none;">
								湖南长沙岳麓区 </span></span><span>快递  ￥<lable id="sendcost">10.00</lable> </span>
							</p>
						<%-- 	<input type="hidden" value="${mkey['sendcost']}" name="sencost"> --%>
							<div id="sendAddress">
								<a href="#" id="J-PopupClose" class="address-all-close"></a>
								<div id="J-AddressAllTitle" class="address-all-title-par clearfix">
									<div class="address-all-title J-AddressTitle" data-title="Province" id="J-AddressAllTitle-province">湖南省</div>
									<input type="hidden" value="14" id="provinceId">
									<input type="hidden" value="197" id="cityId">
									<input type="hidden" value="1647" id="regionId">
									
									<div class="address-all-title J-AddressTitle" data-title="City" id="J-AddressAllTitle-city">长沙市</div>
									<div class="address-all-title J-AddressTitle address-all-title-selected" data-title="Area" id="J-AddressAllTitle-area">岳麓区</div>
								</div>
								<div id="J-AddressAllCon" class="data_title_Area address-all-con-par clearfix address-all-con-selected">
									<ul class="wl-list-add-con clearfix" id="type3">
									</ul>
									</div>
								<div id="J-AddressAllCon" class="data_title_City address-all-con-par clearfix address-all-con-selected" style="display:none;">
								<ul class="wl-list-add-con clearfix" id="type2">
									</ul>
								</div>
								<div id="J-AddressAllCon" class="data_title_Province address-all-con-par clearfix address-all-con-selected" style="display:none;">
									<ul class="wl-list-add-con clearfix" id="type1">
									</ul>
								</div>
							</div>
							<div>
							<dl class="pull-left text-center"
								style="padding-top:10px;">
								<%-- <dt style="color:#005aa0;">${leng}</dt> --%>
								<dd><img alt="" src="<%=basePath%>html/images/detail-succ.png">&nbsp;&nbsp;${leng}&nbsp;交易成功</dd>
							</dl>
							<dl class="text-center" style="padding-top: 10px;">
								<%-- <dt style="color:#005aa0;">${len}</dt> --%>
								<dd><img alt="" src="<%=basePath%>html/images/detail-pingjia.png">&nbsp;&nbsp;${len}&nbsp;累计评价</dd>
							</dl>
							<br>
						</div>
						</div>
						<div class="clearfix"></div>
						<div style="border-top: 1px dotted #ddd; padding: 5px;"></div>
						<form id="forms" name="forms" classs="forms">
							<p id="tdiv1">
								购买数量： <input type="button" value="-"
									onclick="opera('val', false);" class="btn btn-default"
									style="margin-top: -3px;"> <input type="text"
									name="number"
									style="background-color: #fff;background-image: none;border: 1px solid #ccc;color: #555;height: 30px;padding: 6px 12px;"
									size="5" value="1" id="val"
									onkeyup="detailNumber(this);" onblur="detailNumber(this);" onpaste="return false"
									  />
								<input type="button" value="+" onclick="opera('val', true);"
									class="btn btn-default" style="margin-top: -3px;"> <span
									class="message">请输入正确的数量[]</span> <span class="messageShow"></span>
								<input type="hidden" name="id" value="${mkey['id']}">库存(${mkey['stocknum']})件
								<input type="hidden" name="stocknum" value="${mkey['stocknum']}" id="stocknum">
							</p>
							<p>
								<button type="button" class="btn btn-primary" id="img1" 
									style="width:166px;height: 40px;font-size: 14px;margin-top:20px;float:left;" onclick="javascript:add();">
									<img alt="" src="<%=basePath%>html/images/addcart.png">
									加入购物车
								</button>
									<img id="img2"  alt="" title="注册个人会员或者加盟维修商即可购买配件" src="<%=basePath%>html/images/addCart1.png" style="width:166px;height: 40px;font-size: 14px;margin-top:20px;float:left;display:none">
									
									
								<button type="button" class="btn btn-primary" id="img3" 
									style="width:166px;height: 40px;font-size: 14px;margin-top:20px;float:left;display: none" onclick="javascript:add1();">
									
									立即预约
								</button>
								
								<button type="button" class="btn" id="img4" title="注册个人会员即可预约GPS" 
									style="width:166px;height: 40px;font-size: 14px;margin-top:20px;float:left;background-color: #ccc;color: white;display: none">
									立即预约
								</button>
									
								<input hidden="hidden" type="text" id="toShopping" name="toShopping" value="<%=basePath%>pei/detail?id=${mkey['id']}"/>
							
							</p>
							
							<p style="color: red;font-size: 12px;float:left;margin-top: 70px;margin-left: -165px;">温馨提示：本商品属于专属用途产品，请谨慎购买！</p>
						</form>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="row" style="margin-top:40px;">
		<div class="col-md-12">
			<ul class="nav nav-tabs" role="tablist" id="myTab">
				<li class="active"><a href="#profile" role="tab" data-toggle="tab">配件详情</a></li>
				<li class=""><a href="#comments" role="tab" data-toggle="tab">客户评论</a></li>
			</ul>

			<div class="tab-content" style="font: 12px/150% Arial,Verdana,'宋体';">
				<div class="tab-pane active" id="profile">
					<b></b> 如果您发现商品信息不准确， <a target="_blank" href="javascript:;" style="color: #00a9ff;text-decoration: underline;">欢迎纠错</a>
					<div id="peiDetail">
					 <c:forEach var="mkey" items="${deKey}">
					 	<img src="${mkey['img']}" style='width:100%;height:100%;'>
					 </c:forEach>
					
					</div>
				</div>
				<div class="tab-pane" id="comments">
					<div id="tabContainer">
						<ul>
							<li id="tab1"><a href="#" class="on"
								onclick="switchTab('tab1','con1');this.blur();return false;">
									全部(${all}) </a>
							</li>
							<li id="tab2"><a href="#"
								onclick="switchTab('tab2','con2');this.blur();return false;">
									好评(${good}) </a>
							</li>
							<li id="tab3"><a href="#"
								onclick="switchTab('tab3','con3');this.blur();return false;">
									中评(${mid})</a>
							</li>
							<li id="tab4"><a href="#"
								onclick="switchTab('tab4','con4');this.blur();return false;">
									差评(${bad})</a>
							</li>
						</ul>
						<div style="clear: both"></div>
						<hr>
						<div id="con1" >
							<c:forEach var="mkey" items="${ckey}">
								<div class="media" style="border-bottom:1px solid #D4D4D4;">
									<a class="pull-left" href="#"> <img class="media-object"
										src="${mkey['faceImg']}" width="70"
										height="70" alt="..."><span style="color:red;">${mkey['userName']}</span></a>
									<div class="media-body">
									<table style="height: 100px;background-color: #ffffff;">
									
									<tr style="margin-top: 80px;">
									<td colspan="3" style="height:30px;"><p style="margin-left: 10px;font-size: 15px;">${mkey['content']}</p></td>
									</tr>
									<c:if test="${mkey['repplyContent'] !=''}">
									<tr>
									<td colspan="3"><p style="margin-left: 10px;color:red;font-size: 15px;">商家回复：${mkey['repplyContent']}</p></td>
									
									</tr>
									</c:if>
									<tr>
									<td style="width: 320px;"><span class="detail-span1" style="font-size:12px;">&nbsp;&nbsp;产品分类：${mkey['productName']}</span></td>
									<td style="width: 320px;"><span class="vote-star"> <i style="width:${mkey['star']}"></i></span></td>
									<td style="width: 320px;text-align: center;font-size: 12px;color:#999;">${mkey['createTime']}</td>
									</tr>
									</table>
									
									
									
										<%-- <p>
											<span class="detail-span1">配件名称：${mkey['autopartName']}</span>
										</p>
										<P>
											评分：<span class="vote-star"> <i
												style="width:${mkey['star']}"></i> </span>
										</P>
										<p>评价：${mkey['content']}</p>
										<p style="color: #999;font-size: 12px;">${mkey['createTime']}</p> --%>
									</div>
								</div>
								
							</c:forEach>
						</div>
						<div id="con2" style="display: none">
							<c:forEach var="mkey" items="${goodkey}">
								<div class="media" style="border-bottom:1px solid #D4D4D4;">
									<a class="pull-left" href="#"> <img class="media-object"
										src="${mkey['faceImg']}" width="70"
										height="70" alt="...">${mkey['userName']}</a>
									<div class="media-body">
										<%-- <p>
											<span>配件名称：${mkey['autopartName']}</span>
										</p>
										<P>
											<span class="vote-star"> <i
												style="width:${mkey['star']}"></i> </span>
										</P>
										<p>${mkey['content']}</p>
										<p>${mkey['createTime']}</p> --%>
										<table style="background-color: #ffffff;height: 100px;">
									
									<tr style="margin-top: 80px;">
									<td colspan="3" style="height:30px;"><p style="margin-left: 10px;font-size: 15px;">${mkey['content']}</p></td>
									</tr>
									<c:if test="${mkey['repplyContent'] !=''}">
									<tr>
									<td colspan="3"><p style="margin-left: 10px;color:red;font-size: 15px;">商家回复：${mkey['repplyContent']}</p></td>
									
									</tr>
									</c:if>
									<tr>
									<td style="width: 320px;"><span class="detail-span1" style="font-size:12px;">&nbsp;&nbsp;产品分类：${mkey['productName']}</span></td>
									<td style="width: 320px;"><span class="vote-star"> <i style="width:${mkey['star']}"></i></span></td>
									<td style="width: 320px;text-align: center;font-size: 12px;color:#999;">${mkey['createTime']}</td>
									</tr>
									</table>
									</div>
								</div>
								
							</c:forEach>
						</div>
						<div id="con3" style="display: none">
							<c:forEach var="mkey" items="${midkey}">
								<div class="media" style="border-bottom:1px solid #D4D4D4;">
									<a class="pull-left" href="#"> <img class="media-object"
										src="${mkey['faceImg']}" width="70"
										height="70" alt="...">${mkey['userName']}</a>
									<div class="media-body">
										<%-- <p>
											<span>配件名称：${mkey['autopartName']}</span>
										</p>
										<P>
											<span class="vote-star"> <i
												style="width:${mkey['star']}"></i> </span>
										</P>
										<p>${mkey['content']}</p>
										<p>${mkey['createTime']}</p> --%>
										<table style="background-color: #ffffff;height: 100px;">
									
									<tr style="margin-top: 80px;">
									<td colspan="3" style="height:30px;"><p style="margin-left: 10px;font-size: 15px;">${mkey['content']}</p></td>
									</tr>
									<c:if test="${mkey['repplyContent'] !=''}">
									<tr>
									<td colspan="3"><p style="margin-left: 10px;color:red;font-size: 15px;">商家回复：${mkey['repplyContent']}</p></td>
									
									</tr>
									</c:if>
									<tr>
									<td style="width: 320px;"><span class="detail-span1" style="font-size:12px;">&nbsp;&nbsp;产品分类：${mkey['productName']}</span></td>
									<td style="width: 320px;"><span class="vote-star"> <i style="width:${mkey['star']}"></i></span></td>
									<td style="width: 320px;text-align: center;font-size: 12px;color:#999;">${mkey['createTime']}</td>
									</tr>
									</table>
									</div>
								</div>
								
							</c:forEach>
						</div>
						<div id="con4" style="display: none">
							<c:forEach var="mkey" items="${badkey}">
								<div class="media" style="border-bottom:1px solid #D4D4D4;">
									<a class="pull-left" href="#"> <img class="media-object"
										src="${mkey['faceImg']}" width="70"
										height="70" alt="...">${mkey['userName']}</a>
									<div class="media-body">
									<%-- 	<p>
											<span>配件名称：${mkey['autopartName']}</span>
										</p>
										<P>
											<span class="vote-star"> <i
												style="width:${mkey['star']}"></i> </span>
										</P>
										<p>${mkey['content']}</p>
										<p>${mkey['createTime']}</p> --%>
										<table style="background-color: #ffffff;height: 100px;">
									
									<tr style="margin-top: 80px;">
									<td colspan="3" style="height:30px;"><p style="margin-left: 10px;font-size: 15px;">${mkey['content']}</p></td>
									</tr>
									<c:if test="${mkey['repplyContent'] !=''}">
									<tr>
									<td colspan="3"><p style="margin-left: 10px;color:red;font-size: 15px;">商家回复：${mkey['repplyContent']}</p></td>
									
									</tr>
									</c:if>
									<tr>
									<td style="width: 320px;"><span class="detail-span1" style="font-size:12px;">&nbsp;&nbsp;产品分类：${mkey['productName']}</span></td>
									<td style="width: 320px;"><span class="vote-star"> <i style="width:${mkey['star']}"></i></span></td>
									<td style="width: 320px;text-align: center;font-size: 12px;color:#999;">${mkey['createTime']}</td>
									</tr>
									</table>
									</div>
								</div>
								
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
var typeId="${typeId}";
var img1=document.getElementById("img1");
var img2=document.getElementById("img2");
var img3=document.getElementById("img3");
var img4=document.getElementById("img4");
var tdiv1=document.getElementById("tdiv1");

var sid="${p_id}";
if(sid=='14111920565139086686' || sid=='14111921035347226464'){
	img1.style.display="none";
	img2.style.display="none";
	tdiv1.style.display="none";
	if(typeId=='1' || typeId==''){
		img3.style.display="";
		img4.style.display="none";
	}else{
		img3.style.display="none";
		img4.style.display="";
	}
}else{
	tdiv1.style.display="";
	img3.style.display="none";
	img4.style.display="none";
	if(typeId=='1' || typeId=='3' || typeId==''){
	img1.style.display="";
	img2.style.display="none";
}else{
	img2.style.display="";
	img1.style.display="none";
}
}

	    $(function () {
	        $('#myTab a:frist').tab('show');
	    });
	 	function add(){
	 		var stocknumStr=document.getElementById("stocknum").value;
	 	    var stocknum= parseInt(stocknumStr);
	 	    if (stocknum>0) {
	 	    	var sub= document.getElementById("forms");
		 		sub.method="get";
				sub.action = "<%=basePath%>pei/addCart?id=${mkey['id']}";
			    sub.submit();
			}else{
				alert("库存不足无法购买！");
			}
	}

function add1(){
	 		var stocknumStr=document.getElementById("stocknum").value;
	 	    var stocknum= parseInt(stocknumStr);
	 	    if (stocknum>0) {
	 	    	window.location.href="<%=basePath2%>lineUp.jsp";
			}else{
				alert("库存不足无法预约！");
			}
	}
	
	function opera(x, y) {
	  var stocknumStr=document.getElementById("stocknum").value;
 	       var stocknum= parseInt(stocknumStr);
 		var rs = new Number(document.getElementById(x).value);
		if (isNaN(rs) || rs < 0) {
			alert('请输入数字或正数');
		}
		if (y) {
			if (document.getElementById(x).value > stocknum-1) {
				document.getElementById(x).value = 1;
			} else {
				document.getElementById(x).value = rs + 1;
			}
		} else {
			if (document.getElementById(x).value == 1
					|| document.getElementById(x).value == 0
					|| document.getElementById(x).value < 0) {
				document.getElementById(x).value = rs - 0;
			} else {
				document.getElementById(x).value = rs - 1;
			}
		}
	}
	function switchTab(ProTag, ProBox) {
		for (i = 1; i < 5; i++) {
			if ("tab" + i == ProTag) {
				document.getElementById(ProTag).getElementsByTagName("a")[0].className = "on";
			} else {
				document.getElementById("tab" + i).getElementsByTagName("a")[0].className = "";
			}
			if ("con" + i == ProBox) {
				document.getElementById(ProBox).style.display = "";
			} else {
				document.getElementById("con" + i).style.display = "none";
			}
		}
	}
 	$(function(){
	
	var top=$("#uldht li a");
	top.click(function(){
	
	$(this).addClass("color","white").siblings().removeClass("thisClass");
	});
	});
	 

 
</script>
<script>
function colGoods(id) {
  var strName = "<%=session.getAttribute("userName")%>";	
     if(strName!=null && strName!="null"&& strName!=""){
      
  	 $.ajax({
            type: "post",
            data:{id:id},
            url: "<%=basePath%>pei/colGoods",
            async:false,
            dataType: "html",
            success: function(data) {
            	  alert(data);
            },
            error: function() {
            alert("请求失败！");
            }
        });
        }else{
         alert("请先登录！");
          window.location.href="<%=basePath%>html/login.jsp";
        }
	}
	function detailNumber(obj){
 	 var maxNumberStr=document.getElementById("stocknum").value;
	  var maxNumber=parseInt(maxNumberStr);
	  if(obj.value.length==1){
	  obj.value=obj.value.replace(/[^1-9]/g,1);
	  }else {
	  obj.value=obj.value.replace(/\D/g,'');
	  }
	  if(obj.value>maxNumber){
	      obj.value=maxNumber;
	  }
	  if(obj.value==""){
 	    obj.value=1;
	  }
	}
</script>
 
<%@ include file="./public/foot.jsp"%>
<script src="<%=basePath%>html/plugin/Picswitch/switch.js"></script>
<script>
var provinceName1="${provinceName}";	
	$('#J-AddressAllTitle-province').click(function(){
		
		 $.ajax({
            type: "POST", 
            url: "<%=basePath%>member/getProvince",
            async:false,
            dataType: "json",
            data:{id:"1"},
            success: function(data) {
            	$("#type1").html("");
                  for(var i=0; i<data.length; i++){
		     		 $("#type1").append("<li class='J-WlListItem wl-list-item ' data-title='"+data[i].name+"' onclick=\"fun1('"+data[i].id+"',this)\">"+data[i].name+"</li>");	
		     	}
              },
            error: function() {
            
            }
        });	
        $('#J-AddressAllTitle-province').addClass('address-all-title-selected');
		$('#J-AddressAllTitle-city').removeClass('address-all-title-selected');
		$('#J-AddressAllTitle-area').removeClass('address-all-title-selected');
		document.getElementById("J-AddressAllTitle-province").innerHTML="请选择";
		$('.data_title_Province').css("display","block");
		$('.data_title_City').css("display","none");
		$('.data_title_Area').css("display","none");
		$('#J-AddressAllTitle-city').css("display","none");
		$('#J-AddressAllTitle-area').css("display","none");
	});
	
	
	$('#J-AddressAllTitle-city').click(function(){
	$('.data_title_Province').css("display","none");
	$('.data_title_City').css("display","block");
	$('.data_title_Area').css("display","none");
		var id=	$('#provinceId').val();
		 $.ajax({
            type: "POST", 
            url: "<%=basePath%>member/getProvince",
            async:false,
            dataType: "json",
            data:{id:id},
            success: function(data) {
            	$("#type2").html("");
                  for(var i=0; i<data.length; i++){
		     		 $("#type2").append("<li class='J-WlListItem wl-list-item ' data-title='"+data[i].name+"' onclick=\"fun2('"+data[i].id+"',this)\">"+data[i].name+"</li>");	
		     	}
              },
            error: function() {
            
            }
        });	
        
		$('#J-AddressAllTitle-province').removeClass('address-all-title-selected');
		$('#J-AddressAllTitle-city').addClass('address-all-title-selected');
		$('#J-AddressAllTitle-area').removeClass('address-all-title-selected');
		
	});
	
	
	$('#J-AddressAllTitle-area').click(function(){
	
	$('.data_title_Province').css("display","none");
	$('.data_title_City').css("display","none");
	$('.data_title_Area').css("display","block");
		var id=	$('#cityId').val();
		 $.ajax({
            type: "POST", 
            url: "<%=basePath%>member/getProvince",
            async:false,
            dataType: "json",
            data:{id:id},
            success: function(data) {
            	$("#type3").html("");
                  for(var i=0; i<data.length; i++){
		     		 $("#type3").append("<li class='J-WlListItem wl-list-item ' data-title='"+data[i].name+"' onclick=\"fun3('"+data[i].id+"',this)\">"+data[i].name+"</li>");	
		     	}
              },
            error: function() {
            
            }
        });	
        
		$('#J-AddressAllTitle-province').removeClass('address-all-title-selected');
		$('#J-AddressAllTitle-city').removeClass('address-all-title-selected');
		$('#J-AddressAllTitle-area').addClass('address-all-title-selected');
		
	});
	
	
	
	$('.address-all-close').click(function(){
		$('#sendAddress').css('display','none');
	});
	$('#J_WlAddressInfo').click(function(){
		
		$('#sendAddress').toggle();
	
	});
	
	
	function fun1(obj,thisElem){
		document.getElementById("provinceId").value=obj;
		var name1=$(thisElem).get(0).innerHTML;
		document.getElementById("J-AddressAllTitle-province").innerHTML=name1;
		$('#J-AddressAllTitle-city').css("display","block");
		document.getElementById("J-AddressAllTitle-city").innerHTML="请选择";
		$("#J-AddressAllTitle-city").click();
	}
	function fun2(obj,thisElem){
		document.getElementById("cityId").value=obj;
		var name2=$(thisElem).get(0).innerHTML;
		document.getElementById("J-AddressAllTitle-city").innerHTML=name2;
		$('#J-AddressAllTitle-area').css("display","block");
		document.getElementById("J-AddressAllTitle-area").innerHTML="请选择";
		$("#J-AddressAllTitle-area").click();
	}
	
	function fun3(obj,thisElem){
		document.getElementById("regionId").value=obj;
		var name3=$(thisElem).get(0).innerHTML;
		document.getElementById("J-AddressAllTitle-area").innerHTML=name3;
		$(thisElem).addClass('wl-list-add-active');
		var name1=document.getElementById("J-AddressAllTitle-province").innerHTML;
		var name2=document.getElementById("J-AddressAllTitle-city").innerHTML;
		$("#J_WlAddressInfo").get(0).innerHTML=name1+name2+name3;
		$('.address-all-close').click();
		if(name1==provinceName1){
			$("#sendcost").get(0).innerHTML="10.00";
		}else{
			$("#sendcost").get(0).innerHTML="20.00";
		}
	}
</script>
<script>
lastScrollY=0;
function heartBeat(){
var diffY;
if (document.documentElement && document.documentElement.scrollTop)
diffY = document.documentElement.scrollTop;
else if (document.body)
diffY = document.body.scrollTop;
else
{/*Netscape stuff*/}
percent=.1*(diffY-lastScrollY);
if(percent>0)percent=Math.ceil(percent);
else percent=Math.floor(percent);
document.getElementById("full").style.top=parseInt(document.getElementById("full").style.top)+percent+"px";
lastScrollY=lastScrollY+percent;
}
suspendcode="<div id=\"full\" style='right:1px;POSITION:absolute;TOP:600px;z-index:100'><a onclick='window.scrollTo(0,0);'>"+
"<img src='../html/img/backTop.gif' style='width:35px;height:48px;'></a><br></div>";
document.write(suspendcode);
window.setInterval("heartBeat()",1);
</script> 

