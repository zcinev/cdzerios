<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
<%@ include file="./public/head.jsp"%>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<style>
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
.thisClass{
color:#222;
font-size: 14px;
}
#test1:hover .enter-step-btn{
	display:inline-block;
	cursor: pointer;
}
#test1:hover{
	box-shadow: 0px 0px 10px #DDD; 
}
.enter-step-btn {
    display: none;
    text-align: left;
    cursor: pointer;
    text-decoration: none;
}
.btn-primary {
	color: #fff;
	background-color: #ff4a00 ;
	border-color: #f47039 ;
}

.btn-primary:hover
	{
	color: #fff;
	background-color:#dd4406;
	border-color: #f47039 ;
}
</style>
    <div class="container-fluid">
        <div class="row">
            <%@ include file="./public/sidebarLeft1.jsp"%>
            <div class="col-md-9 paddingRight0 paddingLeft0 pull-left" style="margin-bottom:10px;">
                <div class="width-auto banner pull-left">
                    <ul class="paddingLeft0">
                        <li><img width="100%" height="350" src="<%=basePath%>html/images/indexslibe1.png"></li>
                        <li><img width="100%" height="350" src="<%=basePath%>html/images/indexslibe3.png"></li>
                        <li><img width="100%" height="350" src="<%=basePath%>html/images/indexslibe2.png"></li>
                    </ul>
                </div>
                <!-- <div id="centerMsg"></div> -->
                <%-- <div class="width-auto pull-left" style="margin-top:10px;">
                    <div id="baidu-map" class="pull-left">
                       <%@ include file="./public/baidu.jsp"%>
                    </div>
                    <div class="caigou-intro panel panel-primary pull-right" style=" margin-left:60px;width: 330px;">
                        <div class="panel-heading">采购中心简要介绍</div>
                        <div class="panel-body">
                            <p id="centerContent2">
                            </p>
                        </div>
                    </div>
                </div> --%>
            </div>
            <div class="col-md-12 paddingRight0 paddingLeft0 pull-left" style="margin-bottom:20px;">
	            <div class="panel-heading" style="height:49px;color:#333;background-color:#fff;border-bottom:1px solid #FFF">
					<span  style="height:49px;font-weight:bold;font-size:24px;/* font-family:微软雅黑; */ ">车队长推荐</span>
					<%--<span class="pull-right"><a href="<%=basePath%>pei/index" style="line-height:26px;color:#00A9FF">查看更多>></a></span>
				--%></div>
				<c:forEach var="mkey" items="${productStr}">
					<div id="test1" class="col-md-4 shadow" style="border:1px solid #ccc;width:319px;height:408px;padding:0px;margin:0px 10px 15px;background-color:f9f9f9;line-height:24px; ">
	 					<a href="<%=basePath%>pei/detail?id=${mkey['id']}">
	 					<img src="${mkey['img']}" style="width:317px;height:230px;"/></a>
						<div  style="padding:10px 10px;border-top:1px solid #ccc;font-size:12px;color:#666;">
							<span style="display:block;height:48px;width:302px;text-overflow:ellipsis;overflow:hidden;color:#0497e1;font-weight:bold;font-size:18px;">${mkey['name']}</span>
	 						<p>配件编号：${mkey['number']}</p>
							<p>采购中心：${mkey['centerIdName']}</p>
							<p style="margin-top:20px;">
								<span style="color:#f00808;font-size:18px;">￥</span><span style="color:#f00808;font-size:36px;font-weight:bold;">${mkey['memberprice']}</span> <span style="text-decoration: line-through;">￥${mkey['marketprice']}</span>
								<span class="enter-step-btn"><a class="btn btn-primary service-btn" id="cart" style="width:140px;height:42px;font-family:Adobe 黑体 Std;font-size:14px;line-height: 24px;margin-left:140px;margin-top:-55px;" href="<%=basePath%>pei/addCart?number=1&id=${mkey['id']}">加入购物车</a></span>
							</p>
					    </div>
				    </div>
				 </c:forEach>
			 </div>
        </div>
    </div>

    <%@ include file="./public/foot.jsp"%>
<script src="<%=basePath%>html/plugin/Unslider/unslider.js"></script>

<script type="text/javascript">
showCarModal2("<%=basePath%>");
	$(function() {
	    $('.banner').unslider({
	        speed: 500,               //  The speed to animate each slide (in milliseconds)
	        delay: 3000,              //  The delay between slide animations (in milliseconds)
	        complete: function() {},  //  A function that gets called after every slide animation
	        keys: true,               //  Enable keyboard (left, right) arrow shortcuts
	        dots: true,               //  Display dot navigation
	        fluid: false              //  Support responsive design. May break non-responsive designs
	    });
	});
	 
	
	/**
	 * 获取Cookie
	 * 
	 * @param c_name
	 * @returns
	 */
	function getCookie(name) {
		var cookies = document.cookie.split(";");
		for(var i=0;i<cookies.length;i++) {
			var cookie = cookies[i];
		    var cookieStr = cookie.split("=");
		    if(cookieStr && cookieStr[0].trim()==name) {
		    	return  decodeURI(cookieStr[1]);
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