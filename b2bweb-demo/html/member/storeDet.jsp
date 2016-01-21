<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/head3.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/memberSidebar.jsp" %>
        <div class="col-md-10 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li><a href="#">店铺管理</a>
                        </li>
                        <li class="active">店铺详情</li>
                    </ol>
                </div>

                <div class="container-fluid" style="width:80%;margin-top:20px;">
                    <h3>店铺详情</h3>
                    <form class="form-horizontal" role="form"  action="/b2bweb-demo/member/updateStoreDetail"  method="post">
                        <div class="form-group">
                            <label for="" class="col-sm-2 control-label">详细介绍</label>
                            <div class="col-sm-10">
                                <textarea name="intro" style="width:100%;" id="editor" class="form-control" rows="20"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-primary">修改</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../public/foot3.jsp"%>

<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
    KindEditor.ready(function (K) {
        var editor;
        editor = K.create('#editor', {
            resizeType: 1,
            allowPreviewEmoticons: true,
            allowImageUpload: true,
            items : [
                'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
                'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 
                'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
                'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'pagebreak',
                'anchor', 'link', 'unlink', '|', 'fullscreen']
        });
    });
</script>

<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script>
    $(function () {
        showSelectData('#province-box',"<%=basePath%>member/getSelectValue?id=1");

        $('#province-box').change(function() {
            var _this = $(this);
            showSelectData('#city-box',"<%=basePath%>member/getSelectValue?id="+_this.children(':selected').val());
        });

        $('#city-box').change(function() {
            var _this = $(this);
            showSelectData('#area-box',"<%=basePath%>member/getSelectValue?id="+_this.children(':selected').val());
        });
    });
</script>