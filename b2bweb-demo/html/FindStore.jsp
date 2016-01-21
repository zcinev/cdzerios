<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/head.jsp"%>
<%
String path4 = "/b2bweb-repair";
String basePath4 = BccHost.getHost()+path4+"/";
%>
<style type="text/css">
.dd {
	height: 50px;
	}
	.control-label{
font-weight: normal;
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
.form-control{
border-radius:0px;
}
#province-box,#city-box,#area-box{
width: 150px;
}
.btn{
border-radius:0px;
}
</style>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script type="text/javascript" src="http://www.cdzer.com:8083/analytics/ip" charset="utf-8"></script>       <!--获取ip接口数据，注意 -->
	<script type="text/javascript">
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
<div  class="row">
	<form action="<%=basePath%>pei/searchStore" method="post">
		<div style="float:right;width:400px;">
		  	请定位到您的具体位置：<img src="<%=basePath%>html/images/point.png">
		<div class="pull-left" >
			<%@ include file="./public/baidu1.jsp"%>
			</div>
		</div>
		<div style="width:600px; height:auto">
		    <div >
				<strong class="td-blue" style="color: #333;font:  24px/36px 'Microsoft yahei';">查找商店</strong><br>
			</div>
			<div class="dd">
				<label class="col-sm-2 control-label" style="margin-bottom: 0;padding-top: 7px;text-align: right;">店铺名称:</label>
				<div class="col-sm-10 form-inline">
					<input class="form-control" style="width:355px;border-radius:0px;" type="text" name="shopName" placeholder="请输入店铺名称"/>
				</div>
			</div>
			<div class="dd">
				<label class="col-sm-2 control-label" style="margin-bottom: 0;padding-top: 7px;text-align: right;">您的地址:</label>
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
				<label class="col-sm-2 control-label" style="margin-bottom: 0;padding-top: 7px;text-align: right;">详细地址:</label>
				<div class="col-sm-10 form-inline">
					<input type="text" class="form-control"  name="address" size="30" value="" placeholder="详细地址" style="width:355px;" />
				</div>
			</div>
			<div class="col-sm-offset-2 ">
				<div class="col-sm-5">
					<button type="submit" class="btn btn-primary btn-block">搜索</button>
					<input type="hidden" id="coor" name="coor">
				</div>
			</div>
		</div>
	</form>	
</div>
<div style="margin-top: 90px;"><%@ include file="./public/foot.jsp"%></div>
<script type="text/javascript">
distSelect("<%=basePath%>");
detailAddress("<%=basePath%>");
function ajaxRequestGetIpAddress(getUrl){//根据IP获取默认地理位置
var obj={"ip":cdzerip}; 
     $.ajax({
          type: "get",
          async:false,
          url: getUrl,             
          dataType: "json",
          data:obj,
          success: function(data){
          	if(data!=null){
          		setDefaultValue("<%=basePath%>", data.province, data.city, "");	//选中默认地址
     	}
     },
     error: function(){
     	alert("加载失败");
     }
 });         
}
ajaxRequestGetIpAddress("<%=basePath4%>ajax/cityGetip");
$(function(){
	
	var top=$("#uldht li a");
	top.click(function(){
	
	$(this).addClass("thisClass").siblings().removeClass("thisClass");
	});
	});
</script>
