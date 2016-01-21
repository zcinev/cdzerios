<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../public/head3.jsp" %>
<script>
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
	function jump(s) {
	    var index=document.all('index').value; 
		$("#pageNo").val(index);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
<style>
.form-control{
border-radius: 0px;
font-size: 13px;
    height: 30px;
}
</style>
        <div class="container-fluid">
        
	        <div class="container-fluid">
	        	<form id="myform" hidden="hidden">
					<input id="isSelect" name="isSelect"  hidden="hidden"/>
					<input id="orderId" name="orderId" hidden="hidden"/>
				</form>
	            <div class="row">
                	<%--<%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
                        <div class="panel panel-default" style="font-size: 13px;">
                            <div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
                             <ol class="breadcrumb bottom-spacing-0">
                        
                        <li class="active">订单列表</li>
                    </ol>
                            </div>
							<table class="table">
								<tr>
									<td colspan="6">
										<div style="float: left;width: 350px;">
											<a href="<%=basePath%>trade/tradeListNoNonPay" class="btn btn-default">未付款</a>
											<a href="<%=basePath%>trade/tradeListNoReap" class="btn btn-default">待确认收货</a>
											<a href="<%=basePath%>trade/tradeListNoEvaluate" class="btn btn-default">待评价</a>
											<a href="<%=basePath%>trade/tradeListNoYEvaluate" class="btn btn-default">已评价</a>
										</div>
											<form  class="form-inline" role="form" style="margin:10px;" id="searchForm" action="<%=basePath%>trade/tradeListNo">               
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />

			
										<div style="float: right;width: 450px;">
											<div style="float: right;">&nbsp;<button class="btn btn-primary">查询</button></div>
											<div style="float: right;"><input type="text" name="dingdan" id="" class="form-control" style="width: 150px;" placeholder="订单编号"/></div>
										</div>
										</form>
									</td>
								</tr>
								<tr class="active">
                                    <th class=" text-center">订单信息</th>
                                    <th class=" text-center">收货人</th>
                                    <th class=" text-center">订单总额</th>
                                    <th class=" text-center">
                                    	<select name="" id="">
											<option value="1" selected="selected">近三个月</option>
											<option value="2">今年</option>
											<option value="3">上一年</option>
										</select>
									</th>
                                    <th class=" text-center">订单状态</th>
                                	<th class=" text-center">操作</th>
                                </tr>
								
								
                            </table>        
                        </div>
                    </div>
	            </div>
			</div>
        </div>
        
        	<div id="dpgltable">
           	
           	</div>
        
            
            
            
	        <div class="page col-md-12 ">
	             	<table>
	                    <tr>
							<td colspan="9">
								<div>
									<form class="pager-form" role="form">
										<label>转到</label> <input id="zdid" type="text"
											class="form-control" onblur="zdfun();"> <label>页</label>
									</form>
									<ul class="pager pull-right"
										style="margin-left:2px;margin-right:2px;">
										<li><a id="syy">上一页</a>
										</li>
										<li><a id="xyy">下一页</a>
										</li>
									</ul>
									<span class="label label-default pull-right label-page">共<span
										id="djy">20</span>页</span> <span
										class="label label-primary pull-right label-page">当前第<span
										id="dqdjy">5</span>页</span>
									<ul class="pagination pull-right">
										<li><a id="syyf">&laquo;</a>
										</li>
										<li class="active"><a id="dqdjyf">1</a>
										<li class=""><a id="dqdjyf1">1</a>
										<li class=""><a id="dqdjyf2">1</a>
										<li class=""><a id="dqdjyf3">1</a></li>
										<li><a id="xyyf">&raquo;</a>
										</li>
									</ul>
								</div>
							</td>
						</tr>
					</table>
	             </div>
             </div>
        </div>
		<script type="text/javascript">
			function topay(orderId,isSelect){
				document.getElementById("orderId").value=orderId;
				document.getElementById("isSelect").value=isSelect;
				var myform=document.getElementById("myform");
				myform.method="post";
				myform.action="<%=basePath%>pei/topay";
				myform.submit();
			}
		</script>
		<script type="text/javascript">
function  delList(){
     var con=confirm("您确定要取消订单吗？");
    if(con==true){
       return true;
    }else{
    return false;
    }
}
function salesReturn(){
   var con=confirm("您确定要退货吗？");
    if(con==true){
       return true;
    }else{
    return false;
    }
}
function salesReturn2(){
   var con=confirm("请保证您已经收到货了，再确定收货！");
    if(con==true){
       return true;
    }else{
    return false;
    }
}

$(function(){
        $('#keyword').bind('keypress',function(event){
            if(event.keyCode == "13")    
            {
                ssfun();
                 return false;
            }
        });
    });
</script>
        <%@ include file="../public/foot.jsp" %>