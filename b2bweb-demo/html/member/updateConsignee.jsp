<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../public/head3.jsp"%>
<script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
<style>
.form-group label{
font-weight: normal;
color: #333;
}
.btn-primary{
background-color:#FF7400;border-color: #ed8802;width: 60px;
}
.btn-primary:hover{
color: white;
background-color:#ed8802 ;
border: #FF7400;
height: 34px;
}
/*#detailAddr{
margin-left: 36px;
margin-top:10px;
float: left;
}*/
</style>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<div class="container-fluid">
	<div class="row">
		<%--<%@ include file="../public/memberSidebar.jsp"%>
		--%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default">
				<div class="panel-heading"  style="background-color: #ecf9ff;border-color: #ddd;">
					<ol class="breadcrumb bottom-spacing-0">
						<li class="active">会员中心</li>
						<li class="active">编辑收货地址</li>
					</ol>
				</div>
				<div class="container-fluid" style="width:100%;margin-top:20px;">
					<h6 style=" color: #014d7f;font-weight: bold;margin:20px 60px;">收货地址</h6>
					<form class="form-horizontal" role="form" action="" name="form1">
						<c:forEach var="mkey" items="${key}">

							<input id="provinceid" name="provinceid" type="hidden"
								value="${mkey['provinceId']}" />
							<input id="cityid" name="cityid" type="hidden"
								value="${mkey['cityId']}" />
							<input id="regionid" name="regionid" type="hidden"
								value="${mkey['regionId']}" />
								<input id="id" name="id" type="hidden"
								value="${mkey['id']}" />
 
							<div class="form-group" style="margin-top: 20px;">
								<label for="inputEmail3" class="col-sm-2 control-label">联系人&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
								<div class="col-sm-10" style="margin-left: -18px;">
									<input type="text" class="form-control" placeholder="联系人" style="width: 200px;"
										name="contactor" id="contactor" value="${mkey['name']}" onblur="validatelegalName('contactor')" maxlength="32">
										<span class="message" >联系人不能为空[]</span>
                   				<span class="messageShow" ></span>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">联系电话&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
								<div class="col-sm-10" style="margin-left: -18px;">
									<input type="tel" class="form-control" placeholder="联系电话" style="width: 200px;"
										name="telphone" id="telphone" value="${mkey['tel']}" onblur="validatelegalTel('telphone');">
										<span class="message" >联系电话格式不正确[]</span>
                   				        <span class="messageShow" ></span>
								</div>
							</div>
							<div class="form-group" >
								<label for="inputPassword3" class="col-sm-2 control-label" style="margin-left: -33px;">选择区域</label>
								<div class="col-sm-10 form-group form-inline"
									style="margin-left: -20px;">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red;margin-left: -8px;">*</span>
									<select name="province" id="province-box" class="form-control" style="margin-left: 8px;" onchange="provinceList();">
									</select>  
									 <select name="city" id="city-box" class="form-control" onchange="cityList();">
									</select> 
									<select name="area" id="area-box" class="form-control" onblur="validatelegalName2('area-box');" onchange="areaList();">
									</select>
									<span class="message" >地址不能为空[]</span>
                   					<span class="messageShow" ></span>
									 <input type="text" value="${mkey['address']}" id="detailAddr" name="detailAddr" class="form-control"  onkeyup="detailAddrList();" onblur="validatelegalName('detailAddr')" maxlength="100">
									 <span class="message" >详细地址不能为空[]</span>
                   					 <span class="messageShow" ></span>
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button type="button" class="btn btn-primary" onclick="nextFunTest2();">保存</button>
								</div>
							</div>
						</c:forEach>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade detail-address">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">请在地图上标注您的地理位置</h4>
			</div>
			<div class="modal-body" id="baiduMap"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary save-coord">保存</button>
			</div>
		</div>
	</div>
</div>

<%@ include file="../public/foot.jsp"%>

<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script> 
<script>
    KindEditor.ready(function (K) {
        var editor;
        editor = K.create('#editor', {
            resizeType: 1,
            allowPreviewEmoticons: true,
            allowImageUpload: true,
            items: [
                'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'image', 'link']
        });
    });
</script>

<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/measure.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/mark.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/searchInRectangle_min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/SearchControl_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/map.js"></script>


<script>
 
 
 
    $(function () {
        distSelect("<%=basePath%>");
        detailAddress("<%=basePath%>");
 
        var province=document.all('provinceid').value;
        var city=document. all('cityid').value;
        var region=document.all('regionid').value;
        
        
        setDefaultValue("<%=basePath%>", province, city, region);
	});
</script>
<script>
 
   //跟新收货地址
function nextFunTest2() {  
 	var check = true;
 	if (!validatelegalName('contactor')) {
		check = false;
	}   
	if (!validatelegalTel('telphone')) {
		check = false;
	}
	if (!validatelegalName('detailAddr')) {
		check = false;
	}
	if (!validatelegalName2('area-box')) {
		check = false;
	}
	if (check == false) {
  		return ;
	}
 	document.form1.action = "<%=basePath%>member/updateConsigneeTest";
	document.form1.submit();
	 
}
</script>
<script>
/**
 * 验证是否为空
 */
function validateNull(obj){
    	var message = $(obj).next().text();
 	if($(obj).val()==null||$(obj).val().length==0 || $(obj).val()=="0"){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}</script>

<script>
function validatelegalName2(thisEle) {
 	var _this=document.getElementById(thisEle);
  	if(!validateNull(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
 
}
</script>
<script>
var provinceId="";
var cityId="";
var areaId="";
var regionName="";
var cityName="";
var areaName=""
  function provinceList(){
      provinceId=document.getElementById("province-box").value;
      $.ajax({
	     type : "POST",
	     url : "<%=basePath%>member/provinceTest",
	     dataType : "json",
		 async : true,
	     data : {'provinceId':provinceId},
	     success : function(data){
	     regionName=data[0].regionName;
	     	document.getElementById("detailAddr").value=data[0].regionName;
 	     },
	     error : function(){
 	     	alert('失败');
	     }
	 });
     }
    function cityList(){
      cityId=document.getElementById("city-box").value;
       $.ajax({
	     type : "POST",
	     url : "<%=basePath%>member/cityTest",
	     dataType : "json",
		 async : true,
	     data : {'cityId':cityId},
	     success : function(data){
	     cityName=data[0].regionName;
	     	document.getElementById("detailAddr").value=regionName+data[0].regionName;
 	     },
	     error : function(){
 	     	alert('失败');
	     }
	 });
     }
    function areaList(){
     areaId=document.getElementById("area-box").value;
      $.ajax({
	     type : "POST",
	     url : "<%=basePath%>member/areaTest",
	     dataType : "json",
		 async : true,
	     data : {'areaId':areaId},
	     success : function(data){
	    areaName=data[0].regionName;
	     	document.getElementById("detailAddr").value=regionName+cityName+data[0].regionName;
	     	 
	               
	     },
	     error : function(){
 	     	alert('失败');
	     }
	 });
    }
    function detailAddrList(){
       var deta=document.getElementById("detailAddr").value;
        detaStr=regionName+cityName+areaName;
           if(detaStr!=""){
           var city_name=deta.substring(0,9);
         if(deta.length<detaStr.length || city_name!=detaStr){
     document.getElementById("detailAddr").value=regionName+cityName+areaName;
        }
           }
          
    }
</script>