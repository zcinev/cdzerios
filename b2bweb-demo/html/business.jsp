<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="public/header.jsp" %>
<style>
<!--
#honours{width:50%;height:50%;}
#honours1{width:50%;height:50%;}
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
#tabContainer ul{
	margin-left: -80px;
	margin-top: 20px;
}

#tabContainer li {
	display:inline;
	list-style-type:none;
	text-align: center;
	margin-left: 40px;
}
#tabContainer a.on {
	color: orange;
}
-->
.media .media-body  h4{
color:#222;font-size: 24px;font-family: 'MicrosoftYahei','微软雅黑','Arial';
}
.media .media-body  p {
color: #666;
}
.media .media-body  p  a{

background-color: #00a9ff;
color: white;
padding:3px;
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
#home img{
	width:100%;
	height:100%;
}
</style>
    <!--[if IE 7]>
    <link rel="stylesheet" href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome-ie7.min.css">
    <![endif]-->
    <link rel="stylesheet" href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=basePath%>html/plugin/Picswitch/switch.css">
    <div class="container-fluid" style="font: 13px/150% Arial,Verdana,'宋体';">
        <div class="row " style="padding-bottom:10px;">
       <form name="form1">
            <div class="col-md-5 pull-left">
                <input type="hidden" id="userName" value="${sessionScope.userName}">
                <input type="hidden" id="storeId" name="storeId" value="${storeId}">
                <input type="hidden" id="pjsId" name="pjsId" value="${pjsId}">
                <div class="zoombox">
                    <div class="zoompic">
                    <c:if test="${banner!=''}">
                     <img src="${banner}" style="width: 382px;height: 265px;border: 0px;" class="img-responsive" alt="">
                    </c:if>
                    <c:if test="${banner==''}">
                        <img src="<%=basePath%>html/img/upimg2.png" style="width: 382px;height: 265px;border: 0px;" class="img-responsive" alt="">
                    </c:if>
                    </div>

                    <div class="sliderbox">
                        <div id="btn-left" class="arrow-btn dasabled"><span class="glyphicon glyphicon-chevron-left"></span>
                        </div>
                        <div class="slider" id="thumbnail">
                            <ul class="list-unstyled">
                            <c:forEach var="mkey" items="${mkey}" > 
                                <li class="current">
                                    <a href="${mkey['img']}" target="_blank">
                                        <img src="${mkey['img']}" width="100%" height="50" style="border: 0px;" alt="" />
                                    </a>
                                </li>
                             </c:forEach>
                            </ul>
                        </div>
                        <div id="btn-right" class="arrow-btn"><span class="glyphicon glyphicon-chevron-right"></span>
                        </div>
                    </div>
                </div>
                <!--slider end-->
            </div>
         
            <div class="col-md-7 pull-left">
                <div class="media">
                    <div class="media-body">
                  
                    	<span>&nbsp;</span>
                        <p><h4 class="media-heading">${list.name}</h4></p>
                          <div style="width:350px;float:left">
                        <p>客户评价：
                        	<span class="vote-star">
                        	<c:if test="${star1=='NaN' || star1=='0'}">
                        	<i style="width:100%"></i>
                        	</c:if>
                        	<c:if test="${star1!='NaN' && star1!='0'}">
                        	<i style="width:${width1}"></i>
                        	</c:if>
                        	 </span>
							<span style="color:#F40;"><c:if test="${star1=='NaN' || star1=='0'}">5</c:if><c:if test="${star1!='NaN' && star1!='0'}">${star1}</c:if></span>分</p>
                        <p>采购中心评价：
                        	<span class="vote-star">
                           <c:if test="${star=='NaN' || star=='0'}">
                        	<i style="width:100%"></i>
                        	</c:if>
                        	<c:if test="${star!='NaN' && star!='0'}">
                        	<i style="width:${width}"></i>
                        	</c:if>
                        </span>
                        	<span style="color:#F40;"><c:if test="${star=='NaN' || star=='0'}">5</c:if><c:if test="${star!='NaN' && star!='0'}">${star}</c:if></span>分</p>
                        <p>采购中心名称：${list.centerIdName}</p>
                        <p>联系方式：${list.contact}</p>
                        <p>商家地址：${list.address}</p>
                        <p>主营产品：
                        	${majorProduct}
                        </p>
                        </div>
                        <div style="float:left;width:150px;">
                        <c:if test="${pkey11!=''}">
					<p>在线咨询：</p>
					</c:if>
					<c:forEach var="mkey" items="${pkey11}">
					<span style="float:left:width:120px;margin-right:20px;">
					<a target=blank 
					href="http://wpa.qq.com/msgrd?v=1&uin=${mkey.serviceQQ }&site= www.ltfx88.com&Menu=no">
					<img border="0" style="height:17px;" SRC="<%=basePath%>html/img/pa.gif"  alt="点击发送消息给对方">客服
					</a>
					</span>
					
					<c:if test="${mkey.index=='1'}">
					<p>&nbsp;</p>
					</c:if>
				</c:forEach>
					</div>
					<div style="width:600px;float:left">
                        <p>主营配件品牌：
                        
                        <c:forEach var="mkey" items="${listProductBrandName}">
						<img alt="${mkey['name']}" src="${mkey['imgurl']}" width="50" height="50">${mkey['name']}
						
						</c:forEach>
                        </p>
                        <p>主营汽车品牌：
                          <c:forEach var="mkey" items="${listMajorBrandName}">
						<img alt="${mkey['name']}" src="${mkey['imgurl']}" width="50" height="50">${mkey['name']}
						</c:forEach>
                        
                        </p>
                        <%--<p>车队长科技支持</p>
                        --%>
                        <br/>
                        <p>
                        	<img alt="收藏店铺" src="<%=basePath%>html/images/shoucang.png">
                        	<a href="javascript:colStore();">收藏店铺</a>
                        	<c:if test="${list.stateName=='未认领'}">
                        	<span style="margin-left: 50px;">
                        		<img alt="认领店铺" src="<%=basePath%>html/images/renling.png">
								<a href="javascript:joinStore();">认领店铺</a>
							</span>
							</c:if>
                        </p>
                        <p style="color:red;">${pjsMsg }</p>
                        <!-- <p> <button type="button" class="btn btn-primary" id="store">收藏店铺</button></p> -->
                    </div>
                    </div>
                </div>
            </div>
            </form>   
        </div>
        
        <div class="row" style="margin-top:10px;">
            <div class="col-md-12">
                <ul class="nav nav-tabs" role="tablist" id="myTab">
                    <li class="active"><a href="#home" role="tab" data-toggle="tab">配件店简介</a>
                    </li>
                    <li><a href="#profile" role="tab" data-toggle="tab">客户评论</a>
                    </li>
                   <!--  <li><a href="#messages" role="tab" data-toggle="tab">采购中心评论</a>
                    </li> -->
                    <li><a href="#honor" role="tab" data-toggle="tab">荣誉证书</a>
                    </li>
                    <li><a href="#certify" role="tab" data-toggle="tab">认证详情</a>
                    </li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active" id="home">
                        <div class="col-sm-12">
                           <%-- ${storeDetail} --%>
                           ${list.intro}
                        </div>
                        <%-- <div class="col-sm-4">
                            <div id="baidu-map">
                                <img src="<%=basePath%>html/img/map.png" class="img-responsive" alt="Responsive image">
                            </div>
                        </div> --%>
                    </div>
                    <div class="tab-pane" id="profile">
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
					        <div style="clear: both">
					        </div>
					        <hr>
					        <div id="con1">
					         <c:forEach var="mkey" items="${skey}">
									<div class="media">
										<a class="pull-left" href="#"> <img class="media-object"
											src="${mkey['faceImg']}" width="70"
											height="70" alt="头像">${mkey['userName']}</a>
										<div class="media-body">
											<p><span>配件名称：${mkey['productName']}</span></p>
											<P>
												<span class="vote-star">
													<i style="width:${mkey['star']}"></i>
												</span>
											</P>
											<p>${mkey['content']}</p>
											<c:if test="${mkey['repplyContent'] !=''}">
											<p style="color:red">回复：${mkey['repplyContent']}</p>
											</c:if>
											<p>${mkey['createTime']}</p>
										</div>
									</div>
									<hr>
								</c:forEach>
								<%-- <c:forEach var="mkey" items="${skey}" > 
				                    <div class="media">
				                        <a class="pull-left" href="#">
				                            <img class="media-object" src="${mkey['faceImg']}" width="70" height="70" alt="头像">
				                            ${mkey['userName']}
				                        </a>
				                        <div class="media-body">
				                        	<p>配件名称：${mkey['autopartName']}</p>
				                        	<p>
				                        		<span class="vote-star">
													<i style="width:${mkey['star']}"></i>
												</span>
				                        	</p>
				                            <p>${mkey['content']}</p>
				                            <p>${mkey['createTime']}</p>
				                            <table style="border: 1px solid #ddd;height: 100px;">
									
									<tr style="margin-top: 80px;">
									<td style="width: 320px;height:70px;"><span class="detail-span1">${mkey['autopartName']}</span></td>
									<td style="width: 320px;"><span class="vote-star"> <i style="width:${mkey['star']}"></i></td>
									<td style="width: 320px;text-align: center;font-size: 12px;color:#999;">${mkey['createTime']}</td>
									</tr>
									<tr>
									<td colspan="3" ><p style="margin-left: 20px;height:50px;">评价：${mkey['content']}</p></td>
									</tr>
									<c:if test="${mkey['repplyContent'] !=''}">
									<tr>
									<td colspan="3"><p style="margin-left: 20px;color:red">回复：${mkey['repplyContent']}</p></td>
								
									</tr>
									</c:if>
									</table>
				                        </div>
				                    </div>
				                    <hr>   
								</c:forEach> --%>
					        </div>
					        <div id="con2" style="display: none">
					            <c:forEach var="mkey" items="${goodkey}">
									<div class="media">
										<a class="pull-left" href="#"> <img class="media-object"
											src="${mkey['faceImg']}" width="70"
											height="70" alt="头像">${mkey['userName']}</a>
										<div class="media-body">
											<p><span>配件名称：${mkey['productName']}</span></p>
											<P>
												<span class="vote-star">
													<i style="width:${mkey['star']}"></i>
												</span>
											</P>
											<p>${mkey['content']}</p>
											<c:if test="${mkey['repplyContent'] !=''}">
											<p style="color:red">回复：${mkey['repplyContent']}</p>
											</c:if>
											<p>${mkey['createTime']}</p>
										</div>
									</div>
									<hr>
								</c:forEach>
					        </div>
					        <div id="con3" style="display: none">
					        	<c:forEach var="mkey" items="${midkey}">
									<div class="media">
										<a class="pull-left" href="#"> <img class="media-object"
											src="${mkey['faceImg']}" width="70"
											height="70" alt="头像">${mkey['userName']}</a>
										<div class="media-body">
											<p><span>配件名称：${mkey['productName']}</span></p>
											<P>
												<span class="vote-star">
													<i style="width:${mkey['star']}"></i>
												</span>
											</P>
											<p>${mkey['content']}</p>
											<c:if test="${mkey['repplyContent'] !=''}">
											<p style="color:red">回复：${mkey['repplyContent']}</p>
											</c:if>
											<p>${mkey['createTime']}</p>
										</div>
									</div>
									<hr>
								</c:forEach>
					        </div>
					        <div id="con4" style="display: none">
					        	<c:forEach var="mkey" items="${badkey}">
									<div class="media">
										<a class="pull-left" href="#"> <img class="media-object"
											src="${mkey['faceImg']}" width="70"
											height="70" alt="头像">${mkey['userName']}</a>
										<div class="media-body">
											<p><span>配件名称：${mkey['productName']}</span></p>
											<P>
												<span class="vote-star">
													<i style="width:${mkey['star']}"></i>
												</span>
											</P>
											<p>${mkey['content']}</p>
											<c:if test="${mkey['repplyContent'] !=''}">
											<p style="color:red">回复：${mkey['repplyContent']}</p>
											</c:if>
											<p>${mkey['createTime']}</p>
										</div>
									</div>
									<hr>
								</c:forEach>
					        </div>
					    </div>
					</div>
                    <%-- <div class="tab-pane" id="messages">
                    	<c:forEach var="mkey" items="${ckey}" > 
					<div class="media">
                                <a class="pull-left" href="#">
                                    <img class="media-object" src="${mkey['faceImg']}" width="70" height="70" alt="头像">
                                </a>
                                <div class="media-body">
                                    <h4 class="media-heading">
                                        <span class="glyphicon glyphicon-star"></span>
                                        <span class="glyphicon glyphicon-star"></span>
                                        <span class="glyphicon glyphicon-star"></span>
                                        <span class="glyphicon glyphicon-star-empty"></span>
                                        <span class="glyphicon glyphicon-star-empty"></span>
                                    </h4>
                                    <p>${mkey['content']}</p>
                                    <p>${mkey['createTime']}</p>
                                </div>
                            </div>
                            <hr>   
                            </c:forEach>
					</div> --%>
                    <div class="tab-pane" id="honor">
						<c:forEach var="mkey" items="${mslit2}" > 
                        	<img src="${mkey['certificateOfHonor']}" style="width:400px;height:500px;" alt="" />
                        </c:forEach>
			
                       <%--  <img src="<%=basePath%>html/img/2.png" class="img-responsive" alt="Responsive image">
                        <img src="<%=basePath%>html/img/22222.jpg" class="img-responsive" alt="Responsive image">
                        <img src="<%=basePath%>html/img/iq.png" class="img-responsive" alt="Responsive image"> --%>
                    </div>
                    <div class="tab-pane" id="certify">
                        <img src="${certificate }" class="img-responsive" alt="${certificate }" style="width:400px;height:500px;">
                    </div>
                    
                </div>

                <script>
                    $(function () {
                        $('#myTab a:first').tab('show');
                    });
                </script>
            </div>
        </div>
    </div>

    <%@ include file="public/foot.jsp"%>

<script src="<%=basePath%>html/plugin/Picswitch/switch.js"></script>
<script>
function colStore () {

	var userName=document.getElementById("userName");
	var user=userName.value;
	if(user==null||user.length==0){
		 document.form1.method="post";
		 document.form1.action="<%=basePath%>pei/isLogin";
 		 document.form1.submit();	
	}
	else{
	 $.ajax({
            type: "post",
            data:{id:$('#storeId').val()},
            url: "<%=basePath%>pei/colStore",
            async:false,
            dataType: "text",
            success: function(data) {
            alert(data);
            },
            error: function() {
            alert("请求失败！");
            }
        });
	}
}

function joinStore () {
	document.form1.method="post";
	document.form1.action="<%=basePath%>pei/joinStore";
	document.form1.submit();	
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
	};
</script>


