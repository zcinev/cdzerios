<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="./public/payorder.jsp"%>
<style>

.panel-heading strong{
color: #3B5998;
font-weight: bold;
font-size: 14px;
}
</style>
    <div class="container-fluid" >
        <div class="row">
            <div class="col-md-12 paddingLeft0 paddingRight0">
                <form action="<%=basePath%>pei/wayofPay" id="myform" method="post" target= "_blank">
                    <div class="panel panel-default" style="border:none;">
                        <!-- Default panel contents -->
                        <div class="panel-heading" style="background-color:#fff;border-bottom:2px solid #428bca;">
                            <strong>选择支付方式并付款</strong>
                        </div>
                        <div class="panel-body">
                            <ul class="nav nav-tabs" role="tablist" id="myTab">
                                <li class="active"><a href="#home" role="tab" data-toggle="tab">支付宝</a>
                                </li>
                               
                                <li id="daohuo"></li>
                            </ul>

                            <div class="tab-content">
                                <div class="tab-pane active" id="home">
                                   
                                    	<br>
                                    	<img alt="" src="<%=basePath%>html/img/apay.jpg" onclick="sub()" style="height: 90px;width:120px;cursor: pointer;">
                                 </div>
                           
                                <div class="tab-pane" id="delivery">
                                   
                                    <br>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <input type="hidden" name="orderId" id="orderId" value="${orderId }"/>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="./public/foot.jsp"%>
<script>
    $(function () {
    	//alert("5g");
        $('#myTab a:first').tab('show');
    });
    $(document).ready(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>

<script type="text/javascript">
	function sub(){
		var myform = document.getElementById("myform");
		myform.method="post";
		myform.action="<%=basePath%>pei/wayofPay";
		myform.submit();
		setTimeout(topayWait, 2000);
	}
	function topayWait(){
		var orderId=document.getElementById("orderId").value;
		window.location.href="<%=basePath%>pei/topayWait?orderId="+orderId;
	}
	/* function getQueryString(name) {//获取地址栏字段
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		var r = window.location.search.substr(1).match(reg);
		if (r != null) return unescape(r[2]); return null;
	} */
	
	$('#orderId').val("${orderId}");
 	if("${isSelect}"=="0" && "${total_fee}"!="610.0" && "${total_fee}"!="620.0" && "${total_fee}"!="910.0" && "${total_fee}"!="920.0"){
 		if("${isGpsOrder}"=="yes"){
	 		document.getElementById("daohuo").innerHTML="<a href='#delivery' role='tab' data-toggle='tab'>货到付款</a>";
	 		document.getElementById("delivery").innerHTML="<a class='btn btn-warning' href='<%=basePath%>pei/finished?tofinished=0' >订单完成</a>";
 		}		
 	}
</script>