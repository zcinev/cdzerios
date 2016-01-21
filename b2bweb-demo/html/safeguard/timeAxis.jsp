<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%@ page import="com.bc.session.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<!DOCTYPE HTML>
<html lang="zh-cn">
  <head>
    <base href="<%=basePath%>">
    
    <title>维权时光轴</title>
    <link rel="icon" href="<%=basePath%>html/cdz.ico">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<%=basePath%>html/lib/dist/css/bootstrap.min.css" rel="stylesheet">
  
	
	<link rel="stylesheet" type="text/css" href="styles.css">

<style type="text/css">
body{
	margin:0px;
	}
.t_header{
	min-height:80px;
	background-color:#0F2137;
	margin:0px;
	padding:0px;
	min-width:1020px;
	width:auto;
	color:#fff;
	box-sizing:border-box;
}	
.container-fluid {
    padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
}
.row {
    width: 1020px;
    margin: 0px auto;
    display: block;
}
.top_l{
	filter:alpha(opacity=85);  
	-moz-opacity:0.85;  
	-khtml-opacity: 0.85;  
	opacity: 0.85; 
}
.top_r{
	padding:15px;
	filter:alpha(opacity=85);  
	-moz-opacity:0.85;  
	-khtml-opacity: 0.85;  
	opacity: 0.85; 
}
.top_r ul{
	border-left:1px solid #fff;
	list-style-type: none;
	height:50px;
}
.top_r ul li{
	width:60px;
	float:left;
	text-align:center;
	line-height:50px;
	vertical-align: middle;
}
.t_body{
	min-height:965px;
	background:#444E63 url('<%=basePath%>html/img/safe/bg_body.png') no-repeat  scroll 0px 0px ;
}
.tody_l{
	float:left;
}
.tody_l ul{
	width:40px;
	height:140px;
	margin:0px;
	padding:0px;
	list-style: outside none none;
	
}
.tody_l ul li{
	text-align: right;
	padding-right:10px;
	border-right:2px solid #fff;
}

.tody_l ul li:hover{
	border-right:2px solid #97C8FF;
}
.tody_l ul li:active{
}
.tody_l ul li a:link{
	color:#fff;
	text-decoration: none;
}
.tody_l ul li a:visited{
	color:#fff;
	text-decoration: none;
}

.tody_l ul li a:hover{
	color:#97C8FF;
	text-decoration: none;
}

.tody_l ul li a:active{
	color:#97C8FF;
	text-decoration: none;
}
.tody_r{
	width:918px;
	padding:50px 20px;
	float:left;
}
.tody_r .tody_line{
	width:120px;
	height:auto;
	min-height:600px;
	float:left;
}
.yesterday{
    width:120px;
    height:40px;
    padding:3px 15px;
	background-color:#87A1C3;
	border:1px solid #5E7A9D;
	color:#fff;
	border-radius:4px;
	font-size:18px;
	text-align: center;
	font-weight:bold;
}
.line{
	width:2px;
	min-height:800px;
	padding-left:57px;
	border-right:2px solid #A0B8D4;
}
.tody_title{
	color:#fff;
	float:left;
	width:700px;
	margin-left:40px;
}
.tml_poster {
    width: 700px;
    color:#8D8D8D;
    z-index: 20;
    float:left;
    padding: 14px;
    margin-top:100px;
    margin-left:40px;
    background-color: #FFF;
    border-radius: 4px;
    box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3);
    transition: box-shadow 0.5s ease 0s;
}
.tml_poster1 {
    width: 700px;
    color:#8D8D8D;
    z-index: 20;
    float:left;
    padding: 14px;
    margin-top:30px;
    margin-left:40px;
    background-color: #FFF;
    border-radius: 4px;
    box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3);
    transition: box-shadow 0.5s ease 0s;
}
.tml_poster{
	padding-top:20px;
	padding-left: 25px;
	font-size:18px;
	line-height:30px;
}
.tml_poster1{
	padding:20px 25px;
	font-size:18px;
	line-height:30px;
}
.ricle_time{
	position: relative;
	width:80px;
	margin-top:-80px;
	margin-left:-180px;
	color:#fff;
	z-index:25px;
	display:inline;
}
.ricle_time:hover{

}
.header{
	position: relative;
	margin-top:-40px;
	margin-left:-110px;
	width:50px;
}
.time{
	margin-top:-40px;
	font-size:24px;
	color:#333;
}
.menu_left ul, .menu_right ul{
	list-style-type: none;
	margin:0px;
	padding:0px;
}
.menu_left {
	float:left;
	width:50%;
}
.t_footer{
	width:100%;
	text-align:center;
}
.info{
	margin:0 auto;
	text-align: center;
	padding-top: 20px;
	clear:both;
	color:#fff;
}
.info a:link{
	color:#fff;
}
</style>
  </head>
  
  <body>
	  <div class="t_header">
          <div class="container-fluid">
              <div class="row">
                  <div class="top_l pull-left">
                  	  <h2>车队长爱车维权</h2>
                  </div>
                  <div class="top_r pull-right">
                  	<ul>
                  		<li><span><img src="<%=basePath%>html/img/safe/note_num.png"></img>&nbsp;&nbsp;50</span></li>
                  		<li><span><a href="<%=basePath%>carsaf/complaintComment?id=${time_id}"><img src="<%=basePath%>html/img/safe/message_num.png"></img>&nbsp;&nbsp;${com_len}</a></span></li>
                  	</ul>
                  </div>
              </div>
          </div>
      </div> 
      <div class="t_body">
          <div class="container-fluid">
              <div class="row">
                  <div class="tody_l pull-left">
                  	  <ul>
                  	    <li class="active">&nbsp;</li>
                  	  	<li class="active"><a href="<%=basePath%>carsaf/timeAxisList?time=now_time&id=${time_id}&com_len=${com_len}">今天</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_12&id=${time_id}&com_len=${com_len}">12月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_11&id=${time_id}&com_len=${com_len}">11月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_10&id=${time_id}&com_len=${com_len}">10月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_09&id=${time_id}&com_len=${com_len}">9月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_08&id=${time_id}&com_len=${com_len}">8月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_07&id=${time_id}&com_len=${com_len}">7月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_06&id=${time_id}&com_len=${com_len}">6月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_05&id=${time_id}&com_len=${com_len}">5月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_04&id=${time_id}&com_len=${com_len}">4月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_03&id=${time_id}&com_len=${com_len}">3月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_02&id=${time_id}&com_len=${com_len}">2月</a></li>
                  	  	<li><a href="<%=basePath%>carsaf/timeAxisList?time=now_time_01&id=${time_id}&com_len=${com_len}">1月</a></li>
                  	  </ul>
                  </div>
                  <div class="tody_r pull-right">
                  	<div class="tody_line">
                  		<div class="yesterday"><a href="<%=basePath%>carsaf/timeAxisList?id=${time_id}&com_len=${com_len}"> 昨天</a> </div>
                  		<div class="line"></div>
                  	</div>
                  	<div class="tody_title">
                  		<span><font size="6">4S店维修</font>&nbsp;&nbsp;</span>
                  		<span>东风标志408存在失控隐患&nbsp;&nbsp;</span>
                  		<span>4S点将启动召回</span>
                  		<button onclick="javascript:history.go(-1)" style="width:120px;height:40px;float:right;background-color:#1973D4;border:none;border-radius:4px;">返回</button>
                  	</div>
                  	 <c:forEach var="mkey" items="${key}">
                  	<div class="tml_poster" id="post_area" style="">
                  		<div class="ricle_time">${mkey['time_last']}<img src="<%=basePath%>html/img/safe/time_line.png"></img></div>
                  		
                  		<div class="header"><img src="<%=basePath%>html/img/safe/tml_header.png"></img></div>
                  		<div class="time">现在时间：${now_time}</div>
                  		
                  		<div class="menu_left">
                  		  
                  			<ul>
                  				<li>发起人：${mkey['car_name']}</li>
                  				 <a href="<%=basePath%>carsaf/complaintComment?id=${mkey['id']}">
                  				<li>投诉单号：${mkey['complaint_number']}</li></a>
                  				<li>投诉车型：${mkey['speci_name']}</li>
                  			</ul>
                  			
                  		</div>
                  		
                  		<div class="menu_right">
                  		<div class="time" style="padding-left: 50%;padding-top: 7px;">诉讼时间：${mkey['time_frist']}</div>
                  			<ul style="padding-top: 6px;">
                  				<li>购买城市：${mkey['buy_car_city']}</li>
                  				<li>购买店面：${mkey['buy_car_store']}</li>
                  				<li>购买日期：${mkey['buy_car_time']}</li>
                  				<input id="time_id" name="time_id" type="hidden" value="${mkey['id']}">
                  			</ul>
                  		</div>
                  		
                  	</div>
  </c:forEach>
                  </div>
                  <div class="t_footer">
	                  <div class="info">
							<a href="/b2bweb-baike">车队长官网</a> @2014 Cdzer 用户协议 湘ICP备12014470号
							<p>版权所有：车队长科技（湖南 ）有限公司</p>
					  </div>
      			 </div>
              </div>
          </div>
      </div>
      
      
  </body>
</html>
