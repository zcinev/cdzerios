<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="./public/orderdone.jsp"%>
<%
SessionService sessionService = new BccSession();
String toShopping=sessionService.getAttribute(request, "toShopping");
%>
<style>
h2{
font: normal 24px/36px 'Microsoft yahei';height: 20px;margin-top: 30px;margin-left: -16px;
}
.succ {
margin-top: 20px;
color: red;
}
.succ a{
color: red;
}
p a{
color: #00a9ff;
text-decoration: none;
cursor: pointer;
}
</style>

    <div class="container-fluid" >
        <div class="row">
            <div class="col-md-12 paddingLeft0 paddingRight0" >
                <div class="panel panel-default" style="border:none;" >
                    <!-- Default panel contents -->
                    <div class="panel-heading" style="background-color:#fff;border-bottom:2px solid #428bca;">
                    
                    </div>
                    <div class="panel-body">
                       <c:if test="${topayWait==null}">
	                        <div class="media" style="width:40%;margin:0 auto;padding-top: 80px;color: #666;">
	                        <a class="pull-left" href="#"><img alt="" width="90" height="90" src="<%=basePath%>html/img/ordersucc.png"></a>
	                      
	                          
	                            <div class="media-body">
	                                <h2 class="media-heading">订单提交成功！</h2>
	                                <p class="succ"></p>
	                            </div>
	                             <p style="float:left;">您可以<a href="<%=toShopping%>">继续购物</a></p>
 	                            <c:if test="${typeId=='1'}">
	                            <p style="margin-left: 120px;float:left;">快来下载<a href="#">手机车队长客户端</a>随时随地<a href="<%=basePathwx%>trade/tradeListNo">查询订单</a>。</p>
	                            </c:if>
	                             <c:if test="${typeId=='3'}">
	                            <p style="margin-left: 120px;float:left;">快来下载<a href="#">手机车队长客户端</a>随时随地<a href="<%=basePathwx%>repair/tradeListNo">查询订单</a>。</p>
	                            </c:if>	                        </div>
                        </c:if> 
                      
                        <c:if test="${topayWait!=null}">
	                        <div class="media" style="width:40%;margin:0 auto;padding-top: 80px;color: #666;">
	                        <span id="showPay4"><a class="pull-left" href="#"><img alt="" width="90" height="90" src="<%=basePath%>html/img/working.gif"></a></span>
	                       
	                          
	                            <div class="media-body" style="margin-left: 30px;float:left;">
	                                <h2 id="showPay1" class="media-heading">订单等待支付……</h2>
	                               
	                                <p id="showPay2" style="display: none;" class="succ"><a href="<%=basePathwx%>trade/tradeListNo">您的订单已经成功生成！</a></p>
	                                <span id="showPay3" ><a href="<%=basePathwx%>trade/tradeListNoNonPay"  class="btn btn-warning" style="margin-top: 20px;float:left;">遇到问题</a><a href="<%=basePath%>trade/tradeListNo"  class="btn btn-primary" style="margin-top: 20px;float:left;margin-left: 20px;">完成支付</a></span>
	                            </div>
	                            <p style="margin-left:30px;float:left;">您可以<a href="<%=toShopping%>">继续购物</a></p>
	                            <c:if test="${typeId=='1'}">
	                            <p style="margin-left: 120px;float:left;">快来下载<a href="#">手机车队长客户端</a>随时随地<a href="<%=basePathwx%>trade/tradeListNo">查询订单</a>。</p>
	                            </c:if>
	                             <c:if test="${typeId=='3'}">
	                            <p style="margin-left: 120px;float:left;">快来下载<a href="#">手机车队长客户端</a>随时随地<a href="<%=basePathwx%>repair/tradeListNo">查询订单</a>。</p>
	                            </c:if>
	                        </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<%@ include file="./public/foot.jsp"%>
    
<script>
    $(document).ready(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
    
   <%--  function isPay(){
		obj="${orderId}";
		$.ajax({
            type: "POST",
            url: "<%=basePath%>pei/payWait",
            data: {orderId:obj},
            dataType:"html",
            success: function(msg) {
            	if(msg=="支付成功"){
            		document.getElementById("showPay1").innerHTML="";
            		document.getElementById("showPay1").innerHTML="订单支付成功！";
            		document.getElementById("showPay2").style.display="block";
            		document.getElementById("showPay3").innerHTML="";
            		document.getElementById("showPay4").innerHTML="<a class='pull-left' href='#'><img alt='' width='100' height='110' src='<%=basePath%>html/img/ordersucc.png'></a>";
            	}else if(msg=="未支付"){
            		document.getElementById("showPay1").innerHTML="";
            		document.getElementById("showPay1").innerHTML="订单未支付……";
            		document.getElementById("showPay2").style.display="block";
            		document.getElementById("showPay2").innerHTML="<a href='<%=basePath%>trade/tradeListNo'>您的订单已经成功生成！可以在订单管理中继续支付。</a>";
            		document.getElementById("showPay3").innerHTML="";
            		document.getElementById("showPay4").innerHTML="<a class='pull-left' href='#'><img alt='' width='100' height='110' src='<%=basePath%>html/img/orderFail.png'></a>";
            	}else if(msg=="支付失败"){
            		document.getElementById("showPay1").innerHTML="";
            		document.getElementById("showPay1").innerHTML="订单支付失败……";
            		document.getElementById("showPay2").style.display="block";
            		document.getElementById("showPay2").innerHTML="<a href='<%=basePath%>trade/tradeListNo'>您的订单已经成功生成！可以在订单管理中继续支付。</a>";
            		document.getElementById("showPay3").innerHTML="";
            		document.getElementById("showPay4").innerHTML="<a class='pull-left' href='#'><img alt='' width='100' height='110' src='<%=basePath%>html/img/orderFail.png'></a>";
            	}
            },
            error: function(msg) {
            	alert(msg);
            }
        });
	} --%>
</script>