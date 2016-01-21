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
                        <li class="active">添加生产商</li>
                    </ol>
                </div>
                <form action="/b2bweb-demo/member/addManufacturer" class="form-horizontal" role="form" method="post" style="margin-top:20px;">

                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">厂商名称：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <input type="text" name="name" id="name" class="form-control" placeholder="厂商名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">厂商地址：</label>
                        <div class="col-sm-10 form-inline" style="padding-left:15px;">
                            <select name="province" id="province-box" class="form-control">
                                <option value="0">-请选择-</option>
                            </select>
                            <select name="city" id="city-box" class="form-control">
                                <option value="0">-请选择-</option>
                            </select>
                            <select name="area" id="area-box" class="form-control">
                                <option value="0">-请选择-</option>
                            </select>
                            <input type="hidden" id="address" name="address" value="北京" class="form-control" placeholder="选择详细地理位置">
                            <input type="hidden" id="coord" name="map" value="">
                            <a class="btn btn-info" id="detail-address">详细地理位置</a>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">厂商介绍：</label>
                        <div class="col-sm-8">
                            <link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
                            <textarea class="form-control" name="introduce" id="editor" rows="15"></textarea>
                        </div>
                        <label class="col-sm-2 control-label"></label>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">排序号：</label>
                        <div class="col-sm-4">
                            <input type="" class="form-control" placeholder="0">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">&nbsp;</label>
                        <div class="col-sm-10">
                            <p>
                                <button type="submit" class="btn btn-primary">确认</button>
                                <button type="button" class="btn btn-default">取消</button>
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

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/measure.min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/mark.min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/searchInRectangle_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/SearchControl_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/map.js"></script>

<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script>
    $(function () {
        distSelect("<%=basePath%>");

        detailAddress("<%=basePath%>");
    });
</script>