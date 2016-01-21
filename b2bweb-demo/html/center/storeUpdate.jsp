<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/mchead.jsp"%> 
<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
<div class="container-fluid">
     <div class="row">
        <%@ include file="../public/centerSidebar.jsp" %>
        <div class="col-md-10 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default a_panel">
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">店铺管理
                        </li>
                        <li class="active">编辑店铺</li>
                    </ol>
                </div>
                <form  class="form-horizontal" role="form" action="/b2bweb-demo/purchase/updateStore" method="post" style="margin-top:20px;" >
					<%--  <c:forEach var="mkey" items="${key}" >  --%>
					 <input type="hidden" name="id" value="${key['storeId']}"> 
					 <input id="provinceid" name="provinceid" type="hidden" value="${key['provinceName']}" />
                     <input id="cityid" name="cityid" type="hidden" value="${key['cityName']}" /> 
                     <input id="regionid" name="regionid" type="hidden" value="${key['regionName']}" />
                     <div class="form-group">
                        <label for="" class="col-sm-2 control-label">店铺名称：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <input type="text" name="companyName" id="name"  value="${key['companyName']}" class="form-control" placeholder="店铺名称" readonly="readonly">
                        </div>
                     </div>
                     <%--<div class="form-group">
                     <label class="col-sm-2 control-label">店铺LOGO：</label>
                     	<div class="col-sm-9 form-inline">
                        	<input type="file" class="" placeholder="请上传店铺LOGO" name="logo" value="${key['logo']}" disabled="disabled" onchange="previewImage(this,'logo','store-logo')">
                        </div>
                            </div>
                      --%><div class="form-group">
                      	<label class="col-sm-2 control-label">店铺LOGO：</label>
                                <div class=" col-sm-9">
                                    <div class="uploaded-img pull-left" id="store-logo"><img src="${key['logo']}" style="width: 210px;height: 210px;" alt="" ></div>
                                </div>
                            </div>
                      <div class="form-group">
                                <label class="col-sm-2 control-label">服务热线：</label>
                                <div class="col-sm-9 form-inline">
                                    <input type="text" class="form-control" placeholder="服务热线" name="tel" value="${key['contact']}" readonly="readonly"> 
                                </div>
                            </div>
                           
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">店铺地址：</label>
                        <div class="col-sm-10 form-inline" style="padding-left:15px;">
                           <select name="province" id="province-box" class="form-control" disabled="false">
                           <option value="${key['province']}">${key['provinceName']}</option>
                                </select>
                                <select name="city" id="city-box" class="form-control" disabled="false">
                                 <option value="${key['city']}">${key['cityName']}</option>
                                </select>
                                <select name="region" id="area-box" class="form-control" disabled="false">
                                 <option value="${key['region']}">${key['regionName']}</option>
                                </select>
                          <%--   <input type="hidden" id="address" name="address" value="${key['r2']}" class="form-control" placeholder="选择详细地理位置"> --%>
                            <input type="hidden" id="coord" name="map" value="${key['address']}">
                            <a class="btn btn-info" id="detail-address">详细地理位置</a>
                        </div>
                    </div>
                     <div class="form-group">
                                <label class="col-sm-2 control-label">采购中心：</label>
                                <div class="col-sm-9 form-inline">
                                    <select name="centerId" id="centerId-box" class="form-control" disabled="false">
                                   <%--  <c:forEach var="mkey2" items="${key2}"> --%>
                                        <option value="${key['centerId']}">${key['centerIdName']}</option>
                                        <%-- </c:forEach> --%>
                                    </select>
                                </div>
                            </div>
                         
                            <div class="form-group">
                                <label class="col-sm-2 control-label">店铺简介：</label>
                                <div class="col-sm-9">
                                    <textarea name="detail" id="editor" class="form-control" style="width:100%;display:block;" rows="10" unselectable="on">${key['detail']}</textarea>
                                </div>
                            </div><%--
                            <div class="form-group">
                                <label class="col-sm-2 control-label">经营许可证：</label>
                                <div class="col-sm-9 form-inline">
                                    <input type="file" name="businessLicence" value="${key['businessLicence']}" class="" disabled="disabled" placeholder="请上传经营许可证" onchange="previewImage(this,'business','store-licence')">
                                </div>
                            </div>
                            --%><div class="form-group">
                                <label class="col-sm-2 control-label">营业执照：</label>
                                <div class=" col-sm-9">
                                    <div class="uploaded-img pull-left" id="store-licence"><img src="${key['businessLicence']}" style="width: 210px;height: 210px;" alt=""></div>
                                    <div class="sample-img"><img src="<%=basePath%>html/images/licence.jpg" alt=""></div>
                                </div>
                            </div>
                         
                         <c:if test="${key['stateName']=='未审核' || key['stateName']=='审核不过'}">
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">审核：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <select name="status" class="form-control">
                          
                             <option value="1">通过</option>
                              <option value="2">不通过</option>
                            </select>
                        </div>
                    </div>
                
                   <div class="form-group">
                        <label for="" class="col-sm-2 control-label">&nbsp;</label>
                        <div class="col-sm-10">
                            <p>
                                <button type="submit" class="btn btn-primary">确认</button>
                                <button type="button" class="btn btn-default" onclick="javascript:history.go(-1)">取消</button>
                            </p>
                        </div>
                    </div>
			  </c:if> 
			  
			     <c:if test="${key['stateName']=='审核通过'}">
			      <div class="form-group">
                        <label for="" class="col-sm-2 control-label">&nbsp;</label>
                        <div class="col-sm-10">
                            <p>
                                <button type="button" class="btn btn-default" onclick="javascript:history.go(-1)">返回</button>
                            </p>
                        </div>
                    </div>
			     </c:if>  
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
        editor.readonly();
    });
</script>
<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
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
       <%--  distSelect("<%=basePath%>");
       

        var province=document.all('provinceid').value;
        var city=document. all('cityid').value;
        var region=document.all('regionid').value; --%>
         detailAddress1("<%=basePath%>","${key['map']}");
        setDefaultValue("<%=basePath%>",province,city,region);
    }); 
</script>
<script>
