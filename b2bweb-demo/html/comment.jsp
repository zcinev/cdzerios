<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/head.jsp"%>
    
<!--[if IE 7]>
<link rel="stylesheet" href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome-ie7.min.css">
<![endif]-->
<link rel="stylesheet" href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome.min.css">
<div class="container-fluid">
        <div class="row" style="padding:10px 0;">
            <div class="col-md-12">
                <ol class="breadcrumb" style="background-color:#fff;">
                    <li><a href="#">Home</a>
                    </li>
                    <li><a href="#">Library</a>
                    </li>
                    <li class="active">Data</li>
                </ol>
                <c:forEach var="mkey" items="${key}" >
                <h2>${mkey['name']}</h2>
                </c:forEach>
                <p>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star-empty"></span>
                    <span>${len }</span>
                </p>
            </div>
        </div>
        <div class="row border-bottom-1 border-top-1" style="padding:10px 0;">
            <div class="col-md-5 pull-left">
                <link rel="stylesheet" href="<%=basePath%>html/plugin/Picswitch/switch.css">
                <div class="zoombox">
                    <div class="zoompic">
                        <img src="<%=basePath%>html/plugin/Picswitch/images/3427.jpg" class="img-responsive" alt="">
                    </div>
                    <div class="sliderbox">
                        <div id="btn-left" class="arrow-btn dasabled"><span class="glyphicon glyphicon-chevron-left"></span>
                        </div>
                        <div class="slider" id="thumbnail">
                            <ul class="list-unstyled" style="overflow:hidden;"> 
                               <c:forEach var="mkey" items="${key}" >
                                <li class="current">
                                     <a href="<%=basePath%>html/plugin/Picswitch/images/${mkey['image0']}" target="_blank">
                                        <img src="<%=basePath%>html/plugin/Picswitch/images/${mkey['img0']}" width="100%" height="50" alt="" />
                                    </a>
                                </li>
                                
                                <li class="current">
                                     <a href="<%=basePath%>html/plugin/Picswitch/images/${mkey['image1']}" target="_blank">
                                        <img src="<%=basePath%>html/plugin/Picswitch/images/${mkey['img1']}" width="100%" height="50" alt="" />
                                    </a>
                                </li>
                                  <li class="current">
                                     <a href="<%=basePath%>html/plugin/Picswitch/images/${mkey['image2']}" target="_blank">
                                        <img src="<%=basePath%>html/plugin/Picswitch/images/${mkey['img2']}" width="100%" height="50" alt="" />
                                    </a>
                                </li>
                                  <li class="current">
                                     <a href="<%=basePath%>html/plugin/Picswitch/images/${mkey['image3']}" target="_blank">
                                        <img src="<%=basePath%>html/plugin/Picswitch/images/${mkey['img4']}" width="100%" height="50" alt="" />
                                    </a>
                                </li>
                                  <li class="current">
                                     <a href="<%=basePath%>html/plugin/Picswitch/images/${mkey['image4']}" target="_blank">
                                        <img src="<%=basePath%>html/plugin/Picswitch/images/${mkey['img4']}" width="100%" height="50" alt="" />
                                    </a>
                                </li>
                                  <li class="current">
                                     <a href="<%=basePath%>html/plugin/Picswitch/images/${mkey['image5']}" target="_blank">
                                        <img src="<%=basePath%>html/plugin/Picswitch/images/${mkey['img5']}" width="100%" height="50" alt="" />
                                    </a>
                                </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div id="btn-right" class="arrow-btn"><span class="glyphicon glyphicon-chevron-right"></span>
                        </div>
                    </div>
                </div>
                <!--slider end-->
            </div>
           
            <c:forEach var="mkey" items="${key}" >
            <div class="col-md-7 pull-left">
                <div class="media">
                    <div class="media-body">
                        <h4 class="media-heading">${mkey['autopartinfo']} ${mkey['number']}</h4>
                        <p>${mkey['factory']}</p>
                        <hr>
                        <p>
                            <div class="pull-left">
                                <p>
                                    <label for="">平台价</label>${mkey['memberprice']}
                                     <label for="" style="">官方价</label>${mkey['marketprice']}
                                    </p>
                                <p>
                                    <label for="">促销</label>店铺VIP 登录后可以查看此优惠</p>
                                <p>
                                    <label for="">配送</label>上海浦东 至 湖南长沙 快递：${mkey['sendcost']}</p>
                                    
                                    <input type="hidden" value="${mkey['sendcost']}" name="sencost">
                            </div>
                            <div class="pull-right">
                                <dl class="pull-left text-center" style="margin-right:10px;padding-right:10px;border-right:1px solid #999;">
                                    <dt> ${leng} </dt>
                                    <dd>交易成功</dd>
                                </dl>
                                <dl class="pull-right text-center">
                                    <dt> ${len} </dt>
                                    <dd>累计评价</dd>
                                </dl>
                            </div>
                            <div class="clearfix"></div>
                        </p>
                        <hr>
                        <form id="form">
                        <p>
                            购买数量：
                            <span class="glyphicon glyphicon-plus"></span>
                            <input type="text" name="number" size="5">
                            <span class="glyphicon glyphicon-minus"></span>
                            <input type="hidden" name="id" value="${mkey['id']}">
                        </p>
                        <p>
                            <button type="button" class="btn btn-primary" id="buy" >立即购买</button>
                        <a href="javascript:add();" > <button type="button" class="btn btn-warning">
                        	<span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button></a>
                        </p>
                        <p>百城科技支持</p>
                        </form>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    <div class="row" style="margin-top:10px;">
        <div class="col-md-12">
            <div class="well well-sm">
                <form class="form-horizontal" role="form" action="<%=basePath%>pei/subComment">
                <input type="hidden" name="parts" value="${productId}">
                 <input type="hidden" name="orderId" value="${orderId}">
                <input type="hidden" name="orderMainId" value="${orderMainId}">
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-6 control-label" style="text-align:left;">
                            ${userName}
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">星级</label>
                        <div class="col-sm-6 control-label comment-star" style="text-align:left;">
                            <link href="<%=basePath%>html/plugin/jRate/jquery/jRating.jquery.css" rel="stylesheet" />
                            <link href="<%=basePath%>html/plugin/jRate/css/style.css" rel="stylesheet" />
                            <div class="basic" id="12_1"></div>
                        </div>  
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">评论内容</label>
                        <div class="col-sm-6">
                            <textarea id="editor" name="content" rows="10"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">验证码</label>
                        <div class="col-sm-6">
                            <input class="form-control pull-left" name="code"
                             style="width:100px;margin-right:15px;">
                            <img class="pull-left" src="<%=basePath%>admin/verifyCode" onclick="this.src+='?'+Math.random()" 
                            style="cursor:pointer;padding-top:5px;" title="点击换一个" alt="验证码">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-6">
                            <button type="submit" class="btn btn-primary">提交评论</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
    
<%@ include file="./public/foot.jsp"%>
<script src="<%=basePath%>html/plugin/Picswitch/switch.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
KindEditor.ready(function (K) {
    var editor;
    editor = K.create('#editor', {
    	uploadJson : '<%=uploadUrl%>?root=demo-comment-icon',
        resizeType: 1,
        allowPreviewEmoticons: true,
        allowImageUpload: true,
        items: [
            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
            'insertunorderedlist', '|', 'emoticons', 'image', 'link']
    });
});

var basePathValue = "<%=basePath%>html/";
</script>
<script type="text/javascript" src="<%=basePath%>html/plugin/jRate/jquery/jRating.jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/jRate/jquery/jRate.js"></script>