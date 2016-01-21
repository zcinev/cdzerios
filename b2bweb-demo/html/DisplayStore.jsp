<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="./public/head.jsp"%>
<script>
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#myform").submit();
		return false;
	}
	function jump(s) {
	    var index=document.all('index').value; 
		$("#pageNo").val(index);
		$("#pageSize").val(s);
		$("#myform").submit();
		return false;
	}
</script>
<%
String path4 = "/b2bweb-repair";
String basePath4 = BccHost.getHost()+path4+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<style type="text/css">
.dd {
	height: 50px;
	}
.vote-star{
	display:inline-block;/*内联元素转换成块元素，并不换行 weisay.com*/
	margin-right:6px;
	width:85px;/*5个星星的宽度 weisay.com*/
	height:15px;/*1个星星的高度 weisay.com*/
	overflow:hidden;
	vertical-align:middle;
	background:url('<%=basePath%>html/images/star.gif') repeat-x 0 0px;
	}
	
.vote-star i{
	display:inline-block;/*内联元素转换成块元素，并不换行 weisay.com*/
	height:15px;/*1个星星的高度 weisay.com*/
	background:url('<%=basePath%>html/images/star.gif') repeat-x 0 0;
	}
.theme-popover-mask {
	z-index: 9998;
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:#000;
	opacity:0.4;
	filter:alpha(opacity=40);
	display:none
}
.theme-popover {
	z-index:9999;
	position:fixed;
	top:40%;
	left:50%;
	width:680px;
	height:400px;
	margin:-180px 0 0 -330px;
	border-radius:5px;
	border:solid 1px #fff;
	background-color:#fff;
	display:none;
	box-shadow: 0 0 10px #666;
}
.theme-poptit {
	border-bottom:1px solid #ddd;
	padding:15px;
	position: relative;
}

.theme-popbom {
	padding:15px;
	background-color:#f6f6f6;
	border-top:1px solid #ddd;
	border-radius:0 0 5px 5px;
	color:#666
}
.theme-popbom a {
	margin-left:8px;
	text-decoration:none;
}
.theme-poptit .close {
	float:right;
	color:#222;
	padding:0px 3px 5px 0px;
	margin:-2px -5px -5px;
	font:bold 15px/15px simsun;
	text-shadow:0 1px 0 #ddd;
	text-decoration:none;
}
.theme-poptit .close:hover {
	color:#555;
	text-decoration:none;
}
#companyNames{
	float: left;
	color:#222;
	margin-top:-5px;
	margin-bottom:-5px;
	font:18px/18px Arial,Verdana,'华文楷体';
}
.control-label{
font-weight: normal;
}

#tab th{
font-size:14px;
color: #3B5998;
font-weight: 700;
border-top: 2px solid #00a9ff;  
background-color: #f2f5f8;
}
.td-blue a{
color: #00a9ff;
font-size: 16px;
font-family: "微软雅黑";

}
/* #dd:hover{
background-color: #fffbe2;
border: 1px solid #ffb138;
} */
.form-control{
border-radius: 0px;

}
#index{
	width: 50px;
}
.btn{
border-radius:0px;
}
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
</style>
</head>
  
<body id="main">
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script type="text/javascript" src="http://www.cdzer.com:8083/analytics/ip" charset="utf-8"></script>       <!--获取ip接口数据，注意 -->
<div  class="row">
	<script>
		var coord; 
		//var _this = $(this);
		var dat="";
		$.ajax({
		    type: "GET",
		    url: "<%=basePath4%>store/getUrl",
		    async:false,
		    dataType: "html",
		    success: function(data) {
		    	dat=data;
		    },
		    error: function() {
		    	_this.text('请求失败');
		    }
		});
		function successback(data){
	    	coord=data.addr;
		}
		    
		function errorback(){ 
	    	alert("失败");
	    }  
		function ajaxRequestDogetJsonp(getUrl){
	 		var obj={"ip":cdzerip}; 
	        $.ajax({
	             type: "get",
	             async:false,
	             url: getUrl,             
	             dataType: "json",
	             data:obj,
	             success: successback,
	             error: errorback
			});         
		}
		ajaxRequestDogetJsonp("../ajax/ip");  
	</script>
  	<form class="form-horizontal" role="form" action="<%=basePath%>pei/searchStore" method="post" id="myform" name="myform">
		<div style="float:right;width:350px;">
			<div class="pull-left" id="fixed" style="width:350px; height:300px;text-align:center; top:0px;">
				<%@ include file="./public/baidupjs.jsp"%>
			</div>
		</div>
  		<div style="width:650px; height:auto">
  			<input type="text" hidden="hidden" name="serviceItemId" id="serviceItemId" value="${serviceItem}"/>
  			
  			<input type="text" hidden="hidden" name="provinceid" id="provinceid" value="${province}"/>
  			<input type="text" hidden="hidden" name="cityid" id="cityid" value="${city}"/>
  			<input type="text" hidden="hidden" name="regionid" id="regionid" value="${region}"/>
	 		<div >
				<span class="td-blue" style="color: #333;font:  24px/36px 'Microsoft yahei';">查找商店</span><br>
			</div>
			<div class="dd">
				<label class="col-sm-2 control-label">店铺名称:</label>
				<div class="col-sm-10 form-inline">
					<input class="form-control" style="width:350px;" value="${shopName}" type="text" name="shopName" placeholder="请输入店铺名称"/>
				</div>
			</div>
			<div class="dd">
				<label class="col-sm-2 control-label">您的地址:</label>
				<div class="col-sm-10 form-inline">
					<select name="province" class="form-control" id="province-box">
						<option value="0">-请选择省-</option>
					</select> <select name="city" class="form-control" id="city-box">
						<option value="0">-请选择市-</option>
					</select> <select class="form-control" id="area-box" name="region">
						<option value="0">-请选择区-</option>
					</select>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="dd">
				<label class="col-sm-2 control-label">详细地址:</label>
				<div class="col-sm-10 form-inline">
					<input type="text" class="form-control" id="suggestId" name="address" size="30" value="${address}" placeholder="详细地址" style="width:350px;" />
				</div>
				<%-- <%@ include file="./public/baiduSearch.jsp"%>
				<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div> --%>
			</div>
			
			<div class="col-sm-offset-2 ">
				<div class="col-sm-5">
				<input hidden="hidden" type="text" id="coor" name="coor">
					<button type="submit" class="btn btn-primary btn-block">搜索</button>
					<input type="hidden" id="coor" name="coor">
				</div>
			</div>
			<br><br><br>
			<table class="table" style="border-top: 1px solid #ccc; margin-top: 1%;" id="tab">
				<tr class="text-center">
					<th style="width:13%;background-color: #00a9ff;font-weight: normal;color: white;"><span style="margin-left: 20%;">配件商</span></th>
					<th style="width:75%;text-align:right;">
						<div id="sortby" style="float: right;">
							<a id="showsort" style="width:15px;" href="javascript:;" onclick="subSort(1)"><span class="glyphicon glyphicon-arrow-down"></span></a>
						</div>
					</th>
					<th>
						<div style="float: right; padding-right: 10px;">
							<c:if test="${isTrue!='' }">
								<input type="checkbox" id="isTrue" name="isTrue" checked="checked" >认证
							</c:if>
							<c:if test="${isTrue=='' }">
								<input type="checkbox" id="isTrue" name="isTrue" >认证
							</c:if>
						</div>
					</th>
				</tr>
				<c:forEach var="mkey" items="${key}" varStatus="state">
					<tr id="hover_tr">
						<td colspan="3">
							<div id='shows${state.index}' style='cursor: pointer;'>
				         		<div class='dd' id='dd' style='height: 120px;padding: 1%;'>
									<div style='float:left;width:18%;'>
										<a href="<%=basePath%>pei/business?id=${mkey['id']}">
											<img alt="${mkey['companyName']}" src="${mkey['banner']}" width='100' height='100'/>
										</a><br>
									</div>
									<div class='td-blue' style='float:left;width:40%; margin-top: -1%;'>
										<b style='font:20px/150% Arial,Verdana,"华文楷体";'><a href="<%=basePath%>pei/business?id=${mkey['id']}">${mkey['companyName']}</a>
											<%-- <c:if test="${mkey['stateName']=='未认领'}">
												<img src='<%=basePath%>html/images/renling.png' style='width:22px;height:22px;'/>
											</c:if> --%>
											<c:if test="${mkey['stateName']=='审核通过'}">
												<img src='<%=basePath%>html/images/renzheng.png' style='width:22px;height:22px;'/>
											</c:if>
										</b><br>
										<span style='color:#797979;'>${mkey['address']}</span>
										<input id='pjsMap' hidden='hidden'  value="${mkey['map']}"/>
										<input id='tel' hidden='hidden' value="${mkey['tel']}"/>
										<input id='companyName' hidden='hidden' value="${mkey['companyName']}"/>
										<input id='address3' hidden='hidden' value="${mkey['address']}"/>
										<input id='banner' hidden='hidden' value="${mkey['banner']}"/>
									</div>
									<div  style='float:left;width:25%;padding-top: 4%;color: #FF6100;'>
										信誉等级<br>
										<span class='vote-star'>
										<i style="width:${mkey['star']}"></i></span>
									</div>
									<div style='float:left;width:17%; padding-left:4%;padding-top: 4%; color: #FF6100;'>
										<a href='javascript:;' onClick="getWxsinfo('${mkey['id']}')" style='text-decoration :none;'>
											<img src="<%=basePath%>html/images/point.png"><br>
										</a>
										<span style='color:#3B5998;'>${mkey['distance']}公里</span>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</c:forEach>
				<tr class="text-left">
					<div>${page}</div>  
				</tr>
			</table>
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		</div> 
	</form>
</div>
<!--  -->
<div class="theme-popover">
	<div class="theme-poptit">
		<span id="companyNames"></span><a href="javascript:;" title="关闭" class="close">×</a>
	</div>
	<div class="theme-popbod dform" style="float: left;">
		<input type="text" hidden="hidden" id="companyName2" />
		<input type="text" hidden="hidden" id="pjsMap2" />
		<input type="text" hidden='hidden' id="address2" />
		<input type="text" hidden="hidden" id="tel2" />
		<input type="text" hidden="hidden" id="banner2" />
		<%@ include file="./public/baiduapi2.jsp"%>      
	</div>
</div>
<div class="theme-popover-mask"></div>
<!--  -->
<%@ include file="./public/foot.jsp"%>
<script>
	function shows(){
		var pjsMap= document.all['pjsMap'];
		var tel= document.all['tel'];
		var companyName= document.all['companyName'];
		var address= document.all['address3'];
		var banner= document.all['banner'];
		if(pjsMap.length==undefined){//一条记录时执行
			var reference=document.getElementById("pjsMap").value.split("|");
			var longitude=reference[0];//经度
			var latitude=reference[1];//纬度
			var point = new BMap.Point(longitude,latitude);
			addMarker(point,document.getElementById("tel").value,document.getElementById("companyName").value,document.getElementById("address3").value,document.getElementById("banner").value,0,"shows0");
		}else if(pjsMap.length>1){//多条记录时执行
			for(var i=0; i<pjsMap.length; i++){
				var reference=pjsMap[i].value.split("|");
				var longitude=reference[0];//经度
				var latitude=reference[1];//纬度
				var point = new BMap.Point(longitude,latitude);
				addMarker(point,tel[i].value,companyName[i].value,address[i].value,banner[i].value,i,"shows"+i);
			}
		}
	}
</script>

<script type="text/javascript">	
	$('input').iCheck('destroy');
	$(function () {
       	distSelect("<%=basePath%>");
		var province=document.getElementById('provinceid').value;
       	var city=document.getElementById('cityid').value;
       	var region=document.getElementById('regionid').value;
       	setDefaultValue("<%=basePath%>", province, city, region);
       	
       });
       
       /* 地图悬浮 */
       $(document).ready(function(e) {			
		t = $('#fixed').offset().top;
		mh = $('#main').height();
		fh = $('#fixed').height();
		$(window).scroll(function(e){
			s = $(document).scrollTop();	
			if(s > t - 10){
				$('#fixed').css('position','fixed');
				if(s + fh > mh){
					$('#fixed').css('top',mh-s-fh+'px');	
				}				
			}else{
				$('#fixed').css('position','');
			}
		});
	});
	/* 地图悬浮 */
	
	function subSort(obj){
		document.myform.method="post";
		document.myform.action="<%=basePath%>pei/searchStore?rank="+obj;
		document.myform.submit(); 
	}
	
	 $('#isTrue').click(function (){
		document.myform.method="post";
		document.myform.action="<%=basePath%>pei/searchStore?rank="+getQueryString("rank");
		document.myform.submit();
	}); 

	function getQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		var r = window.location.search.substr(1).match(reg);
		if (r != null) return unescape(r[2]); return null;
	}
	
	if(getQueryString("rank")==1){
		document.getElementById("sortby").innerHTML="";
		document.getElementById("sortby").innerHTML="<a id='closesort' style='width:15px;' href='javascript:;' onclick='subSort(\"\")'><span class='glyphicon glyphicon-arrow-up'></span></a>";
		//document.getElementById("closesort").style.display="block";
		//document.getElementById("showsort").style.display="none";
	}
	
	if(getQueryString("rank")==''){
		document.getElementById("sortby").innerHTML="";
		document.getElementById("sortby").innerHTML="<a id='showsort' style='width:15px;' href='javascript:;' onclick='subSort(\"1\")'><span class='glyphicon glyphicon-arrow-down'></span></a>";
		//document.getElementById("closesort").style.display="block";
		//document.getElementById("showsort").style.display="none";
	}
	
	shows();
	
	function getWxsinfo(obj){
		$('body').css('overflow-y','hidden');
		$('.theme-popover-mask').fadeIn(100);//弹出打开
		$('.theme-popover').slideDown(200);
		$.ajax({
		    type : "POST",
		    url : "<%=basePath%>pei/getPjsinfo",
		    dataType : "json",
			async : false,
		    data : {id:obj},
		    success : function(data){
				for(var i=0; i<data.length; i++){
					document.getElementById("companyNames").innerHTML="";
					document.getElementById("companyNames").innerHTML=data[i].companyName;
					document.getElementById("companyName2").value=data[i].companyName;
		    		document.getElementById("pjsMap2").value=data[i].pjsMap; 
		    		document.getElementById("address2").value=data[i].address;
		    		document.getElementById("tel2").value=data[i].tel;
		    		document.getElementById("banner2").value=data[i].banner;
		    		getmybaidu2();
		    	}
		    },
			error : function(){
				alert('失败');
			}
		});
	}
	$('.theme-poptit .close').click(function(){//弹出关闭
		$('body').css('overflow-y','auto');
		$('.theme-popover-mask').fadeOut(100);
		$('.theme-popover').slideUp(200);
	});
	
	$('.theme-popover-mask').click(function(){//弹出关闭
		$('body').css('overflow-y','auto');
		$('.theme-popover-mask').fadeOut(100);
		$('.theme-popover').slideUp(200);
	});
	$(function(){
	
	var top=$("#uldht li a");
	top.click(function(){
	
	$(this).addClass("thisClass").siblings().removeClass("thisClass");
	});
	});
</script>
</html>
