<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../public/head3.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/centerSidebar.jsp" %>
        <div class="col-md-10 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default a_panel">
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">生产商管理
                        </li>
                        <li class="active">编辑生产商</li>
                    </ol>
                </div>
                <form action="/b2bweb-demo/purchase/checkProducer" class="form-horizontal" role="form" method="post" style="margin-top:20px;">
				 <input type="hidden" name="id" value="${key.id}" >
				  <input type="hidden" name="userid" value="${key.userid}" >
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">厂商名称：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <input type="text" name="name" id="name" class="form-control" placeholder="厂商名称" value="${key.name}" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">厂商地址：</label>
                        <div class="col-sm-10 form-inline" style="padding-left:15px;">
                            <select name="province" id="province-box" class="form-control" readonly>
                                <option value="${key.province}">${key.provinceName}</option>
                            </select>
                            <select name="city" id="city-box" class="form-control" readonly>
                                <option value="${key.city}">${key.cityName}</option>
                            </select>
                            <select name="area" id="area-box" class="form-control" readonly>
                                <option value="${key.region}">${key.regionName}</option>
                            </select>
                            <input type="hidden" id="address" name="address" value="${key.address}" class="form-control" placeholder="选择详细地理位置" >
                            <input type="hidden" id="coord" name="map" value="${key.coordinate}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">厂商介绍：</label>
                        <div class="col-sm-8" >                     
                            <link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
                            <textarea class="form-control" name="introduce" id="introduce" rows="15" disabled="disabled" readonly>${key.introduce}</textarea>
                        </div>
                        <div style="width:633px;height:314px;position:absolute;left:148px;top:166px;z-index:1;">	
                        	<img src="../html/img/lockedEditor.png" style="width:100%;height:100%">					
						</div>
                        <label class="col-sm-2 control-label"></label>
                    </div>
                    <div class="form-group">
						<label for="" class="col-sm-2 control-label">联系电话：</label>
						<div class="col-sm-4">
							<input type="text" name="telephone" class="form-control" placeholder="" value="${key.telephone}" readonly/>
						</div>
					</div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">审核：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <select name="status" class="form-control" id="status">
                             <option value="0">请选择</option>
                             <option value="14111810315435972459">通过</option>
                              <option value="14111918085389726019">不通过</option>
                            </select>
                        </div>
                    </div>
                     <div class="form-group">
                        <label for="" class="col-sm-2 control-label">反馈信息：</label>
                        <div class="col-sm-8">
                            <textarea class="form-control" name="message" rows="10" maxlength="200" ></textarea>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">&nbsp;</label>
                        <div class="col-sm-10">
                            <p>
                                <button type="submit" class="btn btn-primary" onclick="return statusTest();">确认</button>
                                <button type="button" class="btn btn-primary" onclick="javascript:history.go(-1);">取消</button>
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
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
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

<%@ include file="../public/foot3.jsp" %>

<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
    KindEditor.ready(function (K) {
        var editor;
        editor = K.create('#introduce', {
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

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/measure.min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/mark.min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/searchInRectangle_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/SearchControl_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/map.js"></script>

<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script>
   function statusTest(){
      var status=document.getElementById("status").value;
         if(status !='0'){
           return true;
        }else{
          alert("请选择是否通过！");
         return false;
        }
   }
</script>
