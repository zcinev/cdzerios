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
<div class="container-fluid">
	<div class="row">
		<%--<%@ include file="../public/memberSidebar.jsp"%>
		--%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default a_panel">
				<div class="panel-heading">
					<ol class="breadcrumb bottom-spacing-0">
						<li><a href="#">生产商管理</a></li>
						<li class="active">编辑生产商</li>
					</ol>
				</div>
				<form action=""
					class="form-horizontal" role="form" method="post"
					style="margin-top:20px;" name="form1">
					
					  <input id="provinceid" name="provinceid" type="hidden" value="${mkey['provinceId']}" />
                      <input id="cityid" name="cityid" type="hidden" value="${mkey['cityId']}" /> 
                      <input id="regionid" name="regionid" type="hidden" value="${mkey['regionId']}" />
                       
							 
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">厂商名称：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="name" id="name" value="${mkey.name}"
								class="form-control" placeholder="厂商名称" onblur="validatelegalName('name');" maxlength="32">
								<span class="message" >厂商名称不能为空[]</span>
                                                 <span class="messageShow" ></span>
								 <input type="text" name="id" value="${mkey.id }" hidden="hidden">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">厂商地址：</label>
						<div class="col-sm-10 form-inline" style="padding-left:15px;">
							<select name="province" id="province-box" class="form-control">
  
							</select> <select name="city" id="city-box" class="form-control">
							</select> <select name="area" id="area-box" class="form-control" onblur="validatelegalName2('area-box');">

							</select>
							<span class="message" >地址不能为空[]</span>
                   				         <span class="messageShow" ></span>
							
							 <%-- <input type="hidden" id="address" name="address" value="北京"
								class="form-control" placeholder="选择详细地理位置"> <input
								type="hidden" id="coord" name="coordinate"
								value="${mkey.coordinate }"> <a class="btn btn-info"
								id="detail-address">详细地理位置</a> --%>
								<input type="text" value="${mkey['address']}" id="address" name="address" class="form-control" placeholder="请输入详细地理位置" onblur="validatelegalName('address');" maxlength="100">
								 <span class="message" >详细地址不能为空[]</span>
                                                 <span class="messageShow" ></span>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">厂商介绍：</label>
						<div class="col-sm-8">
							<link rel="stylesheet"
								href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
							<textarea class="form-control" name="introduce" id="introduce"
								rows="15" onblur="validatelegalName('introduce');" maxlength="200">${mkey.introduce}</textarea>
								<span class="message" >厂商介绍不能为空[]</span>
                                                 <span class="messageShow" ></span>
						</div>
						<label class="col-sm-2 control-label"></label>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">联系电话：</label>
						<div class="col-sm-4">
							<input type="text" name="telephone" id="telephone" class="form-control" placeholder="" value="${mkey.telephone}" onblur="isPhone('telephone');"/>
							<span class="message" >手机号码格式不正确！[]</span>
                   								 <span class="messageShow" ></span>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">&nbsp;</label>
						<div class="col-sm-10">
							<p>
								<button type="button" class="btn btn-primary" onclick="addMeanFactory('<%=basePath%>');">确认</button>
								<button type="button" class="btn btn-default" onclick="window.location.href='/b2bweb-demo/member/producerList'">取消</button>
							</p>
						</div>
					</div>
				</form>
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

<%@ include file="../public/foot3.jsp"%>

<script charset="utf-8"
	src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8"
	src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>

//采用ajax异步上传，遵循js同源策略
KindEditor.ready(function (K) {
    var editor;
    editor = K.create('#editor', {
        resizeType: 1,
        allowPreviewEmoticons: true,
        allowImageUpload: true,
        allowFileManager : true,
        uploadJson: '/imgUpload/servlet/fileServlet',
        fileManagerJson: '/imgUpload/servlet/fileServlet',
        items: [
            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
            'insertunorderedlist', '|', 'emoticons', 'image', 'link']
    });
});
</script>
<script>
  function addMeanFactory(url){
         var check = true;
   	if (!validatelegalName('name')) {
 		check = false;
	}   
	if (!isPhone('telephone')) {
 		check = false;
	}
	if (!validatelegalName('introduce')) {
 		check = false;
	}
	if (!validatelegalName('address')) {
 		check = false;
	}
	if (!validatelegalName2('area-box')) {
		check = false;
	}
	if (check == false) {
   		return; 
	} 
	 
	document.form1.action = url + "member/saveManufacturer";
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
}
</script>

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

<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
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