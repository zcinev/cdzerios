<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>

a{
color: #666;
}
.list-unstyled p{
font-weight: bold;color: #666;
}
.list-unstyled li{
line-height: 20px;
}
.info a{
	color: #333;
	text-decoration: none;
	}
	.info a:hover{
	color: #00a9ff;
	text-decoration: none;
	}
</style>
	<footer style="margin-top:10px;">
        <div class="container-fluid">
            <div class="row">
                <div class="media cdzer-help" style="margin-left:20px;">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_03.png" alt="消费者保障中心">
                    </a>
                    <div class="media-body">
                         <ul class="list-unstyled">
                        <li><p  style="font-weight: bold;color: #666;">服务指南</a>
	                         </li>
                             <li style="margin-top: 8px;"><a href="<%=basePath2%>index/question">常见问题</a>
	                         </li>
	                         <li><a href="<%=basePath2%>index/fapiao">发票制度</a>
	                         </li>
	                         <li><a href="<%=basePath2%>index/jiaoyi">交易条款</a>
	                         </li>
                        </ul>
                    </div>
                </div>
                <div class="media cdzer-help">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_05.png" alt="新手指引">
                    </a>
                    <div class="media-body">
                       <ul class="list-unstyled">
                         <li><p>特色服务</p>
                            </li>
                            <li><a href="<%=basePath2%>index/jifen">积分制度</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="media cdzer-help">
                     <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_07.png" alt="认证及保障">
                    </a>
                   <div class="media-body">
                        <ul class="list-unstyled">
                        <li ><p>售后服务</p>
                            </li>
                            <li style="margin-top: 6px;"><a href="<%=basePath2%>index/shouhou">服务承诺</a>
                            </li>
                            <li><a href="<%=basePath2%>index/kefu">联系客服</a>
                            </li>
                            <li><a href="<%=basePath2%>index/tuihuan">退换货流程</a>
                            </li>
                            <li><a href="<%=basePath2%>index/tuihuo">退换货政策</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="media cdzer-help">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_09.png" alt="交易服务">
                    </a>
                    <div class="media-body">
                       <ul class="list-unstyled">
                         <li><p>支付方式</p>
                            </li>
                            <li style="margin-top: 6px;"><a href="<%=basePath2%>index/online">在线支付</a>
                            </li>
                            <li><a href="<%=basePath2%>iindex/line">线下支付</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="media cdzer-help">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_11.png" alt="百城特色">
                    </a>
                    <div class="media-body">
                        <ul class="list-unstyled">
                         <li><p>配送方式</p>
                            </li>
                            <li style="margin-top: 6px;"><a href="<%=basePath2%>index/send">配送说明</a>
                            </li>
                            <li><a href="<%=basePath2%>index/logistics">配送状态查询</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- <div class="navbar navbar-default" rold="navigation">
            <div class="container-fluid">
                <div class="row">
                    <div class="navbar-header">
                        <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle nabigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <span class="navbar-brand">友情链接--</span>
                    </div>
                    <nav class="collapse navbar-collapse">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="http://glyphicons.com" class="text-uppercase">glyphicons</a>
                            </li>
                            <li><a href="#">底盘</a>
                            </li>
                            <li><a href="#">车身</a>
                            </li>
                            <li><a href="#">电子电器</a>
                            </li>
                            <li><a href="#">附件</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div> -->
        <div class="container-fluid" style="margin-top: 40px;">
            <div class="row">
                <div class="col-md-12 text-center">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="media">
                                <%-- <a class="pull-left" href="#">
                                    <img src="<%=basePath%>html/img/icons/bottom_08.png" alt="">
                                </a>
                                <a class="pull-left" href="#">
                                    <img src="<%=basePath%>html/img/icons/bottom_10.png" alt="">
                                </a> --%>
                                <div class="media-body pull-center">
                                    <p class="text-center">
                                    
                                     <div class="info ">
        	
								 <a href="/b2bweb-baike">车队长官网</a> @2014 Cdzer 用户协议 湘ICP备12014470号
								 <p>版权所有：车队长科技（湖南 ）有限公司</p>
								      
								  
								   
								</div>
                                    </p>
                                   <!--  <p class="text-center">客服电话：0731-88865777 E-mail：chen@cdzer.com</p> -->
                                </div>
                                <%-- <a class="pull-left" href="#">
                                    <img src="<%=basePath%>html/img/icons/bottom_03.png" alt="">
                                </a>
                                <a class="pull-left" href="#">
                                    <img src="<%=basePath%>html/img/icons/bottom_05.png" alt="">
                                </a> --%>
                            </div>
                        </div>
                    </div>
                    <%-- <div class="row">
                        <div class="col-md-12">
                            <div class="media">
                                <a href="#" class="pull-left">
                                    <img src="<%=basePath%>html/img/icons/bottom_20.png" alt="">
                                </a>
                                <a href="#" class="pull-left">
                                    <img src="<%=basePath%>html/img/icons/bottom_21.png" alt="">
                                </a>
                                <a href="#" class="pull-left">
                                    <img src="<%=basePath%>html/img/icons/bottom_22.png" alt="">
                                </a>
                                <a href="#" class="pull-left">
                                    <img src="<%=basePath%>html/img/icons/bottom_23.png" alt="">
                                </a>
                                <a href="#" class="pull-left">
                                    <img src="<%=basePath%>html/img/icons/bottom_24.png" alt="">
                                </a>
                                <a href="#" class="pull-left">
                                    <img src="<%=basePath%>html/img/icons/bottom_25.png" alt="">
                                </a>
                                <a href="#" class="pull-left">
                                    <img src="<%=basePath%>html/img/icons/bottom_26.png" alt="">
                                </a>
                                <a href="#" class="pull-left">
                                    <img src="<%=basePath%>html/img/icons/bottom_27.png" alt="">
                                </a>
                            </div>
                        </div>
                    </div> --%>
                </div>
            </div>
        </div>
    </footer>

</body>

</html>

<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script src="<%=basePath%>html/lib/dist/js/bootstrap.min.js"></script>
<script src="<%=basePath%>html/plugin/iCheck/icheck.min.js"></script>
<script src="<%=basePath%>html/plugin/HubSpot/js/messenger.min.js"></script>
<script>
(function () {
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    Messenger.options = {
        extraClasses: 'messenger-fixed messenger-on-bottom',
        theme: 'block'
    };
})();
</script>

<!--[if lte IE 6]>
<script type="text/javascript" src="<%=basePath%>html/bsie/js/bootstrap-ie.js"></script>
<![endif]-->
<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script type="text/javascript">
$(function() {
    $('.list-title .glyphicon').click(function() {
        if ($(this).hasClass('glyphicon-plus-sign')) {
            $(this).removeClass('glyphicon-plus-sign').addClass('glyphicon-minus-sign');
            $(this).closest('.child-list').find('.list-body').slideUp('slow');
        } else if ($(this).hasClass('glyphicon-minus-sign')) {
            $(this).removeClass('glyphicon-minus-sign').addClass('glyphicon-plus-sign');
            $(this).closest('.child-list').find('.list-body').slideDown('fast');
        }
    });
});
</script>