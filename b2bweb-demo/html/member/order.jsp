<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../public/head3.jsp" %>
<script>
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		var mark=$("#tmark").val();
		$("#mmark").val(mark);
		$("#searchForm").submit();
		
		return false;
	}
	function jump(s) {
	    var index=document.all('index').value; 
		$("#pageNo").val(index);
		$("#pageSize").val(s);
		var mark=$("#tmark").val();
		$("#mmark").val(mark);
		$("#searchForm").submit();
		return false;
	}
	
	
	function queryByTime(){
		$("#pageNo").val(1);
		$("#pageSize").val(5);
		var mark=$("#tmark").val();
		$("#mmark").val(mark);
		$("#searchForm").submit();
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
										
										<c:if test="${count=='0' }">
											<form  class="form-inline" role="form" style="margin:10px;" id="searchForm" action="<%=basePath%>trade/tradeListNo">    
										          
									<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
										<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
										<input id="mmark" name="mark" type="hidden" value="${mark}" />
			
										<div style="float: right;width: 450px;">
											<div style="float: right;">&nbsp;<button class="btn btn-primary">查询</button></div>
											<div style="float: right;"><input type="text" name="dingdan" id="" class="form-control" style="width: 150px;" placeholder="订单编号"/></div>
										</div>
										</form>
										</c:if>
										
										<c:if test="${count=='1' }">
											<form  class="form-inline" role="form" style="margin:10px;" id="searchForm" action="<%=basePath%>trade/tradeListNoNonPay">    
										          
										<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
										<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />

										<input id="mmark" name="mark" type="hidden" value="${mark}" />
										
										<div style="float: right;width: 450px;">
											<div style="float: right;">&nbsp;<button class="btn btn-primary">查询</button></div>
											<div style="float: right;"><input type="text" name="dingdan" id="" class="form-control" style="width: 150px;" placeholder="订单编号"/></div>
										</div>
										</form>
										</c:if>
										
										<c:if test="${count=='2' }">
											<form  class="form-inline" role="form" style="margin:10px;" id="searchForm" action="<%=basePath%>trade/tradeListNoReap">    
										          
									<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
										<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
										<input id="mmark" name="mark" type="hidden" value="${mark}" />
			
										<div style="float: right;width: 450px;">
											<div style="float: right;">&nbsp;<button class="btn btn-primary">查询</button></div>
											<div style="float: right;"><input type="text" name="dingdan" id="" class="form-control" style="width: 150px;" placeholder="订单编号"/></div>
										</div>
										</form>
										</c:if>
										
										
										<c:if test="${count=='3' }">
											<form  class="form-inline" role="form" style="margin:10px;" id="searchForm" action="<%=basePath%>trade/tradeListNoEvaluate">    
										          
									<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
										<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />

											<input id="mmark" name="mark" type="hidden" value="${mark}" />
										<div style="float: right;width: 450px;">
											<div style="float: right;">&nbsp;<button class="btn btn-primary">查询</button></div>
											<div style="float: right;"><input type="text" name="dingdan" id="" class="form-control" style="width: 150px;" placeholder="订单编号"/></div>
										</div>
										</form>
										</c:if>
									
									
									
										<c:if test="${count=='4' }">
										<form  class="form-inline" role="form" style="margin:10px;" id="searchForm" action="<%=basePath%>trade/tradeListNoYEvaluate">    
										          
										<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
										<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />

										<input id="mmark" name="mark" type="hidden" value="${mark}" />
										<div style="float: right;width: 450px;">
											<div style="float: right;">&nbsp;<button class="btn btn-primary">查询</button></div>
											<div style="float: right;"><input type="text" name="dingdan" id="" class="form-control" style="width: 150px;" placeholder="订单编号"/></div>
										</div>
										</form>
										</c:if>
											
							<%-- 				<form  class="form-inline" role="form" style="margin:10px;" id="searchForm" action="<%=basePath%>trade/tradeListNo">               
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />

			
										<div style="float: right;width: 450px;">
											<div style="float: right;">&nbsp;<button class="btn btn-primary">查询</button></div>
											<div style="float: right;"><input type="text" name="dingdan" id="" class="form-control" style="width: 150px;" placeholder="订单编号"/></div>
										</div>
										</form> --%>
									</td>
								</tr>
								<tr class="active">
                                    <th class=" text-center">订单信息</th>
                                    <th class=" text-center">收货人</th>
                                    <th class=" text-center">订单总额</th>
                                    <th class=" text-center">
                                    	<select name="" id="tmark" onchange="queryByTime();">
                                    	<c:if test="${mark=='1' }">
											<option value="1" selected="selected">近三个月</option>
											<option value="2">今年</option>
											<option value="3">上一年</option>
										</c:if>
										
										<c:if test="${mark=='2' }">
											<option value="1" >近三个月</option>
											<option value="2" selected="selected">今年</option>
											<option value="3">上一年</option>
										</c:if>
										
										<c:if test="${mark=='3' }">
											<option value="1" >近三个月</option>
											<option value="2">今年</option>
											<option value="3" selected="selected">上一年</option>
										</c:if>
										</select>
									</th>
                                    <th class=" text-center">订单状态</th>
                                	<th class=" text-center">操作</th>
                                </tr>
								<c:forEach var="mkey" items="${key}">
									
	                                <tr>
	                                    <td colspan="6" style="text-align: left;">
                                            <div class="order-intro" style="width: 290px;float: left; margin: 0px;padding: 0px;">订单编号：${mkey['orderMainId']}</div>
                                            <div class="order-intro" style="width: 350px;float: left; margin: 0px;padding: 0px;">${mkey['shopnName']}</div>
	                                    </td>
									</tr>
		                                <tr>
		                                    <td class="text-left" style="border-right: 1px #f2f2f2 solid; text-alignleft; width: 300px;">
		                                    	<c:if test="${mkey['productType']=='配件'}">
			                                    	<c:forEach var="mkey2" items="${mkey['lmap']}">
			                                           	<a href="<%=basePath%>pei/detail?goodid=${mkey2['goodId']}" target="_blank">
			                                           		<img src="${mkey2['productImg']}" style="width: 50px;height: 50px;" title="${mkey2['goodname']}" alt="商品图片">
			                                           	</a>
		                                           	</c:forEach>
	                                           	</c:if>
	                                           	<c:if test="${mkey['productType']=='官方商品'}">
			                                    	<c:forEach var="mkey2" items="${mkey['lmap']}">
			                                           	<a href="<%=basePath2%>index/detail?gnumber=${mkey2['goodId']}" target="_blank">
			                                           		<img src="${mkey2['productImg']}" style="width: 50px;height: 50px;" title="${mkey2['goodname']}" alt="商品图片">
			                                           	</a>
		                                           	</c:forEach>
	                                           	</c:if>
		                                    </td>
		                                    <td class="text-center" style="border-right: 1px #f2f2f2 solid;width: 100px;">
		                                        <p>
		                                        	${mkey['nicheng']}
		                                        </p>
		                                    </td>
		                                    <td class="text-center" style="border-right: 1px #f2f2f2 solid;width: 100px;">
		                                        <p>
		                                        	￥${mkey['subPrices']}<br/>
		                                        	<span style="color:#999;">${mkey['wayto']}</span>
		                                        </p>
		                                    </td>
		                                    <td class="text-center" style="border-right: 1px #f2f2f2 solid;width: 100px;">
		                                        ${mkey['addTime']}
		                                    </td>
		                                    
		                                    <td class="text-center" style="border-right: 1px #f2f2f2 solid">
		                                        <!--订单完成状态（按顺序依次是）：
									                                        已付款
									                                        配货中
									                                        已发货
									                                        已完成
									                                        
									                                        订单退货状态：
									                                        申请退货中
									                                        已处理
									                                        退货完成
		                                        -->
	                                        	<p style="color:#f00">${mkey['stateName']}</p>
												 <c:if test="${mkey['stateName']=='5'}">
			                                        <c:if test="${mkey['regTag']=='0'}">
			                                        	<a href="<%=basePath%>pei/comment?mainId=${mkey['orderMainId']}"> <input type="button" value="评价"></a>
			                                        </c:if>
		                                        </c:if> 
											</td>
		                                    <td class="text-center" >
		                                    	<c:if test="${typeId=='2'}">
		                                    		<a href="<%=basePath%>trade/orderFollow?mainId=${mkey['orderMainId']}" title="订单跟踪" target="_blank">跟踪</a>&nbsp;|&nbsp;
	                                            	<a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情" target="_blank">查看</a>
		                                    	</c:if>
		                                    	<c:if test="${typeId!='2'}">
		                                    	<c:if test="${mkey['stateName']=='交易关闭'}">
		                                    	                          	<a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情" target="_blank">查看</a>&nbsp;|&nbsp;
													  <a href="<%=basePath%>trade/deleteOrder?mainId=${mkey['orderMainId']}" title="删除">删除</a><br/>	
		                                    		</c:if>
		                                    		
		                                    		<c:if test="${mkey['stateName']=='未付款'}">
		                                    			<a href="javascript:;" onclick="topay('${mkey['orderMainId']}','${mkey['isSelect']}')" title="继续支付">支付</a>&nbsp;|&nbsp;
		                                    			<a href="<%=basePath%>trade/orderFollow?mainId=${mkey['orderMainId']}" title="订单跟踪" target="_blank">跟踪</a><br/>
		                                            	<a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情" target="_blank">查看</a>&nbsp;|&nbsp;
		                                            	<a href="<%=basePath%>trade/delOrder?mainId=${mkey['orderMainId']}" title="删除" onclick="return delList();">取消订单</a>
		                                    		</c:if>
		                                    		<c:if test="${mkey['stateName']=='已付款' || mkey['stateName']=='货到付款'}">
		                                    			<a href="<%=basePath%>trade/orderFollow?mainId=${mkey['orderMainId']}" title="订单跟踪" target="_blank">跟踪</a>&nbsp;|&nbsp;
		                                            	<a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情" target="_blank">查看</a><br/>
		                                            	<a href="<%=basePath%>trade/delOrder?mainId=${mkey['orderMainId']}" title="删除" onclick="return delList();">取消订单</a>
		                                    		</c:if>
		                                    		<c:if test="${mkey['stateName']=='派送中'}">
		                                    			<a href="<%=basePath%>trade/orderFollow?mainId=${mkey['orderMainId']}" title="订单跟踪" target="_blank">跟踪</a>&nbsp;|&nbsp;
		                                            	<a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情" target="_blank">查看</a><br/>
		                                            	 <a href="<%=basePath%>trade/confirmReceipt?mainId=${mkey['orderMainId']}" title="确认收货" onclick="return salesReturn2();">确认收货</a>&nbsp;|&nbsp;
		                                            	<a href="<%=basePath%>trade/jumpOrderRetFm?mainId=${mkey['orderMainId']}" title="申请退货" onclick="return salesReturn();">退货</a>
		                                    		</c:if>
		                                    		<c:if test="${mkey['stateName']=='退货完成'}">
		                                    			<a href="<%=basePath%>trade/orderFollow?mainId=${mkey['orderMainId']}" title="订单跟踪" target="_blank">跟踪</a>&nbsp;|&nbsp;
		                                            	<a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情" target="_blank">查看</a><br/>
		                                            	 <a href="<%=basePath%>trade/confirmReturn?mainId=${mkey['orderMainId']}" title="确认">确认</a>&nbsp;&nbsp;
		                                    		</c:if>
		                                    		<c:if test="${mkey['stateName']=='拒绝退款'}">
		                                    			<a href="<%=basePath%>trade/orderFollow?mainId=${mkey['orderMainId']}" title="订单跟踪" target="_blank">跟踪</a>&nbsp;|&nbsp;
		                                            	<a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情" target="_blank">查看</a><br/>
		                                            	 <a href="<%=basePath%>trade/confirmReceipt?mainId=${mkey['orderMainId']}" title="确认收货" onclick="return salesReturn2();">确认收货</a>&nbsp;|&nbsp;
		                                    		</c:if>
		                                    			<c:if test="${mkey['stateName']=='订单完成' && mkey['regTag']=='0'}">
			                                            <a href="<%=basePath%>trade/orderFollow?mainId=${mkey['orderMainId']}" title="订单跟踪" target="_blank">跟踪</a>&nbsp;|&nbsp;
			                                            <a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情" target="_blank">查看</a><br/>
			                                            <c:if test="${mkey['productType']=='官方商品'}">
			                                            	<c:forEach var="mkey2" items="${mkey['lmap']}">
					                                           	<a href="<%=basePath2%>index/detail?gnumber=${mkey2['goodId']}&mainId=${mkey['orderMainId']}" title="评论" target="_blank">评论</a><!-- &nbsp;|&nbsp; -->
			                                           		</c:forEach>
			                                            </c:if>
			                                            <c:if test="${mkey['productType']=='配件'}">
			                                            	<a href="<%=basePath%>trade/jumpComment?mainId=${mkey['orderMainId']}" title="评论" target="_blank">评论</a><!-- &nbsp;|&nbsp; -->
			                                            </c:if>
		                                           		  <a href="<%=basePath%>trade/deleteOrder?mainId=${mkey['orderMainId']}" title="删除">删除</a><br/>	
		                                            </c:if>
		                                            
		                                            <c:if test="${mkey['stateName']=='订单完成' && mkey['regTag']=='1'}">
			                                             <a href="<%=basePath%>trade/orderFollow?mainId=${mkey['orderMainId']}" title="订单跟踪">跟踪</a>&nbsp;|&nbsp; 
			                                            <a href="<%=basePath%>trade/orderDetail?mainId=${mkey['orderMainId']}" title="订单详情">查看</a>&nbsp;|&nbsp;
		                                           		  <a href="<%=basePath%>trade/deleteOrder?mainId=${mkey['orderMainId']}" title="订单详情">删除</a><br/>
		                                            </c:if>
		                                            
	                                            </c:if>
		                                    </td>
		                                </tr>
                                	</c:forEach>  
								<tr class="text-center">
									<div>${page}</div>  
								</tr>
                            </table>        
                        </div>
                    </div>
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