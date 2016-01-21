<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../public/head3.jsp"%>

<div class="container-fluid">
	<div class="row">
		<%--<%@ include file="../public/memberSidebar.jsp"%>
		--%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default a_panel">
				<div class="panel-heading">
					<ol class="breadcrumb bottom-spacing-0">
						<li class="active">生产商管理</li>
						<li class="active">编辑生产商</li>
					</ol>
				</div>
				<form action="/b2bweb-demo/member/saveManufacturer"
					class="form-horizontal" role="form" method="post"
					style="margin-top:20px;">
					
					  <input id="provinceid" name="provinceid" type="hidden" value="${mkey['provinceId']}" />
                      <input id="cityid" name="cityid" type="hidden" value="${mkey['cityId']}" /> 
                      <input id="regionid" name="regionid" type="hidden" value="${mkey['regionId']}" />
                       
							 
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">厂商名称：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="name" id="name" value="${mkey.name}"
								class="form-control" placeholder="厂商名称" readonly /> <input
								type="text" name="id" value="${mkey.id }" hidden="hidden" />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">厂商地址：</label>
						<div class="col-sm-10 form-inline" style="padding-left:15px;">
							<select name="province" id="province-box" class="form-control" readonly> 
							    <option value="1">${mkey.provinceName}</option>
							</select> 
							<select name="city" id="city-box" class="form-control" readonly>
								<option value="2">${mkey.cityName}</option>
							</select> 
							<select name="area" id="area-box" class="form-control" readonly>
								<option value="3">${mkey.regionName}</option>
							</select> <%-- <input type="hidden" id="address" name="address" value="北京"
								class="form-control" placeholder="选择详细地理位置"> <input
								type="hidden" id="coord" name="coordinate"
								value="${mkey.coordinate }"> <a class="btn btn-info"
								id="detail-address">详细地理位置</a> --%>
								<input type="text" value="${mkey['address']}" id="address" name="address" class="form-control" placeholder="请输入详细地理位置" readonly />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">厂商介绍：</label>
						<div class="col-sm-8">
							<link rel="stylesheet"
								href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
							<textarea class="form-control" name="introduce" id="editor"
								rows="15">${mkey.introduce}</textarea>
						</div>
					    <div style="width:633px;height:314px;position:absolute;left:148px;top:166px;z-index:1;">	
                        	<img src="../html/img/lockedEditor.png" style="width:100%;height:100%">					
						</div>
						<label class="col-sm-2 control-label"></label>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">联系电话：</label>
						<div class="col-sm-4">
							<input type="text" name="telephone" class="form-control" placeholder="" value="${mkey.telephone}" readonly />
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">&nbsp;</label>
						<div class="col-sm-10">
							<p>
								<button type="button" class="btn btn-primary" onclick="window.location.href='/b2bweb-demo/member/producerList'">返回</button>
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
   // distSelect("<%=basePath%>");

   // detailAddress("<%=basePath%>");
//         var province=document.all('provinceid').value;
//         var city=document. all('cityid').value;
//         var region=document.all('regionid').value;
//         setDefaultValue("<%=basePath%>", province, city, region);
 	});
	
</script>