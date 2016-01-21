<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>汽车配件－－搜索配件</title>
    
    <link href="<%=basePath%>html/lib/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!--[if IE 7]>
    <link href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome-ie7.min.css" rel="stylesheet">
    <![endif]-->
    <link href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=basePath%>html/plugin/iCheck/skins/square/blue.css" rel="stylesheet">
    
    <link href="<%=basePath%>html/css/non-responsive.css" rel="stylesheet">
	<link href="<%=basePath%>html/css/style.css" rel="stylesheet">
    
    <!--[if lte IE 9]>
    <script src="<%=basePath%>html/plugin/Respond/dest/respond.min.js"></script>
    <script src="<%=basePath%>html/plugin/html5/dist/html5shiv.min.js"></script>
    <![endif]-->

    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>html/bsie/bootstrap/css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>html/bsie/bootstrap/css/ie.css">
    <![endif]-->

    <!--[if lte IE 9]>
    <style type="text/css">
        #logo,#business,#front-img,#back-img {
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
        }
    </style>
    <![endif]-->
</head>
<body>

    <header>
        <div class=" ">
            <div class="container-fluid">
                <div class="row">
                    <div class="pull-left" style="padding-top:13px;">
                        <span class="glyphicon glyphicon-home cdzer-home"></span> 
                        <a href="<%=basePath%>pei/index" class="navbar-link">车队长首页 Hi!欢迎回到车队长</a>
                    </div>
                    <div id="dlyzc" class="pull-right cdzer-navtop">
                        <a href="<%=basePath%>html/login.jsp" class="btn btn-default" role="button">登录</a>
                        <a href="<%=basePath%>html/register.jsp" class="btn btn-default" role="button">注册</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 pull-left">
                    <img src="<%=basePath%>html/img/logo.png" alt="Responsive image">
                </div>
                <div class="col-md-9 pull-right">
                    <img src="<%=basePath%>html/img/iq.png" alt="Responsive image">
                </div>
            </div>
        </div>
    </header>

    <div class="container-fluid" style="margin-top:30px;">
        <div class="row">
            <div class="col-md-12" style="border:1px solid #ccc;">
                <div class="panel panel-default" style="border:none;">
                    <!-- Default panel contents -->
                    <div class="panel-heading" style="background-color:#fff;border-bottom:2px solid #428bca;">
                        <h3 class="text-center">请填写以下资料</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal" action="<%=basePath%>member/join" role="form" enctype="multipart/form-data" style="width:60%;margin:0 auto;">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">店铺名称</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" placeholder="店铺名称" name="name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">店铺LOGO</label>
                                <div class="col-sm-9">
                                    <input type="file" class="form-control" placeholder="请上传店铺LOGO" name="logo"
                                     onchange="previewImage(this,'logo','store-logo')">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <div class="uploaded-img pull-left" id="store-logo"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">服务热线</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" placeholder="服务热线" name="tel"> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">联系QQ</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" placeholder="联系QQ" name="qq">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">所在地</label>
                                <div class="col-sm-9 form-inline">
                                    <select name="province" id="province-box" class="form-control">
                                        <option value="0">-请选择-</option>
                                    </select>
                                    <select name="city" id="city-box" class="form-control">
                                        <option value="0">-请选择-</option>
                                    </select>
                                    <select name="region" id="area-box" class="form-control">
                                        <option value="0">-请选择-</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-9 form-inline">
                                    <input type="hidden" id="address" name="address" value="北京" class="form-control" placeholder="选择详细地理位置">
                                    <input type="hidden" id="detailAddr" name="detailAddr" value="">
                                    <input type="hidden" id="coord" name="map" value="">
                                    <a class="btn btn-info" id="detail-address">详细地理位置</a>
                                </div>
                            </div>
                          
                            <div class="form-group">
                                <label class="col-sm-3 control-label">采购中心</label>
                                <div class="col-sm-9 form-inline">
                                    <select name="centerId" id="centerId-box" class="form-control">
                                        <option value="0">-请选择-</option>
                                    </select>
                                </div>
                            </div>
                         
                            <div class="form-group">
                                <label class="col-sm-3 control-label">店铺简介</label>
                                <div class="col-sm-9">
                                    <textarea name="detail" id="editor" class="form-control" style="width:100%;" rows="10"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">经营许可证</label>
                                <div class="col-sm-9">
                                    <input type="file" name="businessLicence" class="form-control" placeholder="请上传经营许可证" onchange="previewImage(this,'business','store-licence')">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <div class="uploaded-img pull-left" id="store-licence"></div>
                                    <div class="sample-img"><img src="<%=basePath%>html/images/licence.jpg" alt=""></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">身份证号码</label>
                                <div class="col-sm-9">
                                    <input type="text" name="IdCard" class="form-control" placeholder="请输入自己的身份证号码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">身份证过期时间</label>
                                <div class="col-sm-9">
                                    <input type="text" name="IdCardOverTime" class="form-control" placeholder="请输入自己的身份证过期时间">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">身份证正面照片</label>
                                <div class="col-sm-9">
                                    <input type="file" name="positive_photo" class="form-control" placeholder="请上传身份证正面照片" onchange="previewImage(this,'front-img','identity-front-card')">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <div class="uploaded-img pull-left" id="identity-front-card"></div>
                                    <div class="sample-img"><img src="<%=basePath%>html/images/identity_front_img.jpg" alt=""></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">身份证反面照片</label>
                                <div class="col-sm-9">
                                    <input type="file" name="negative_photo" class="form-control" placeholder="请上传身份证反面照片" onchange="previewImage(this,'back-img','identity-back-card')">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <div class="uploaded-img pull-left" id="identity-back-card"></div>
                                    <div class="sample-img"><img src="<%=basePath%>html/images/identity_back_img.jpg" alt=""></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <button type="submit" class="btn btn-primary">提交信息</button>
                                </div>
                            </div>
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

    <%@ include file="./public/foot.jsp"%>

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
                'insertunorderedlist', '|', 'emoticons', 'image']
        });
    });
</script>

<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
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

        // js图片缩放
        // $('.sample-img').each(function(i) {
        //     var src = $(this).children('img')[0].src;
        //     var image = new Image();
        //     image.src = src;

        //     var param = clacImgZoomParam(200,200,image.width,image.height);
        //     $(this).children('img').css({
        //         "width":param.width,
        //         "height":param.height,
        //         "top":param.top,
        //         "left":param.left
        //     });
        // });
    });
</script>
<%
	String hostPath = BccHost.getHost() + "/";
%>
<script type="text/javascript">
	var strName = "<%=session.getAttribute("userName")%>";	
	var strId = "<%=session.getAttribute("id")%>";	
	var typeId = "<%=session.getAttribute("typeId")%>";	
	var dlyzc = document.getElementById("dlyzc");
	var str = "";
	if((strName==null)||(strName=="null")||(strName==""));
	else {
	
		if(typeId=="1")
		str = "<a href=\"<%=hostPath%>b2bweb-repair/person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">亲爱的用户:"+strName+"，您已登陆！ </a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\" class=\"btn btn-default\" role=\"button\">注销</a>";
		else
		str = "<a>亲爱的用户:"+strName+"，您已登陆！ </a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\" class=\"btn btn-default\" role=\"button\">注销</a>";
		
		dlyzc.innerHTML = str;
	}
</script>