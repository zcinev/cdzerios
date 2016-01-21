<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../public/head3.jsp"%>

<!--[if lte IE 9]>
<style type="text/css">
    #face {
        filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
    }
</style>
<![endif]-->
<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/memberSidebar.jsp"%>
          <div class="col-md-10 pull-right paddingRight0 paddingLeft0"> 
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li><a href="#">信息中心</a></li>
                        <li class="active">信息详情</li>
                    </ol>
                </div>

                <div class="container-fluid" style="width:80%;margin-top:20px;">
                    <form class="form-horizontal" role="form" action="/b2bweb-demo/member/basicInfo" method="post">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">标题</label>
                            <div class="col-sm-10 form-inline">
                                <input  class="form-control" placeholder="" name="userName" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="10" name="content"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-primary">更新</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
<%@ include file="../public/foot.jsp"%>