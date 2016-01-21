<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/head3.jsp" %>
<style>
#detail{
color:#333;
background-color: #e5f5ff;
border: 1px solid #40b3ff;
padding-left: 20px;
padding-top: 8px;
padding-bottom: 8px;
}
</style>
        <div class="container-fluid">
            <div class="row">
                <%--<%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-xs-12 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
                            <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">订单详情
                        </li>
                        </ol>
                            <!-- <strong><a href="#">订单详情</a></strong> --></div>
                            <div class="panel-body" style="font-size: 13px;">
                                <table class="table" style="width:100%;margin:20px auto; margin-top:0px;border:1px solid #ccc;">
                                	<caption class="text-left">
                                        <span class="td-blue" style="color: #00a9ff;">订单信息</span>
                                    </caption>
                                    <tr class="active">
                                        <th class="text-center">订单号</th>
                                        <th class="text-center">下单时间</th>
                                        <th class="text-center">订购人</th>
                                        <th class="text-center">状态</th>
                                    </tr>
                                    <tr>
                                        <td class="text-center">${key['mainOrderId']}</td>
                                        <td class="text-center">${key['createTime']}</td>
                                        <td class="text-center">${key['userName']}</td>
                                        <td class="text-center">${key['stateName']}</td>
                                    </tr>
                                </table>
                                <c:if test=" ${key['stateName'].equals('申请退货中')}">
                                    <dl class="order-detail">
	                                    <dt class="td-blue"><h4>温馨提示</h4></dt>
	                                    <dd>商家正在处理，请耐心等待！</dd>
	                                </dl>
                               	</c:if>
                                    
                                <c:if test="${key['stateName'].equals('等待退款')}">
                                    <dl class="order-detail">
	                                    <dt class="td-blue"><h4>温馨提示</h4></dt>
	                                    <dd>退款金额：${key2['backNum']}(${key2['orgNote']})————${key2['orgRedate']}</dd>
	                                </dl>
                                </c:if>
                                 <c:if test="${key['stateName'].equals('拒绝退款')}">
                                    <dl class="order-detail">
	                                    <dt class="td-blue"><h4>温馨提示</h4></dt>
	                                    <dd>商家拒绝退款，如有疑问，请联系车队长！</dd>
	                                </dl>
                                </c:if>
                                <div id="detail">
                                	<span class="td-blue" style="color: #00a9ff;">收货信息</span><br/>
                                   	收货人：&nbsp;&nbsp;${name}<br/>
                                   	联系电话：${tel}<br/>
                                   	收货地址：${provinceIdName}&nbsp;${cityIdName}&nbsp;${regionIdName}&nbsp;${address}<br/>
                                   	付款方式：<%-- ${key['paytypeName']} --%> ${ str } <br/>
                                   	留言信息：${key['remarks']}<br/>
                                   	<c:if test="${key['mailNo']!=''}">
                                   		物流公司：${key['sendWayName']} <br/>  
                                   		快递单号：${key['mailNo']} <br/> 
                                   	</c:if> 
                                   	<hr>
                                   	<span class="td-blue" style="color: #00a9ff;">卖家信息</span><br/>
                               	配件中心：${ckey['name']} <br/>
                               	联系方式：${ckey['tel']} <br/>
                               	所在城市：${ckey['provinceName']}${ckey['cityName']} <br/>
                                </div>
                                <table class="table" style="width:100%;margin:20px auto;border:1px solid #ccc;">
                                    <caption class="text-left">
                                        <span class="td-blue" style="color: #00a9ff;">商品明细</span>
                                    </caption>
                                    <tr class="active">
                                        <th class="text-center">商品编号</th>
                                        <th class="text-center">商品图片</th>
                                        <th class="text-center">商品名称</th>
                                        <th class="text-center">数量</th>
                                        <th class="text-center">单价</th>
                                        <th class="text-center">优惠</th>
                                        <th class="text-center">小计</th>
                                    </tr>
                                    
                                      <c:forEach var="mkey" items="${mkey}">
                                    <tr>
                                        <td class="text-center" style="width: 150px;vertical-align: middle;border-right: 1px #f2f2f2 solid;">
                                        	${mkey['goodId']}
                                        </td>
                                        <td class="text-center" style="width: 80px;vertical-align: middle;border-right: 1px #f2f2f2 solid;">
                                           <img src="${mkey['productImg']}" style="width: 50px;height: 50px;" >
                                        </td>
                                        <td class="text-center" style="width: 240px;vertical-align: middle;border-right: 1px #f2f2f2 solid;">
                                         <c:if test="${mkey['productType'].equals('配件')}">
                                           <a href="<%=basePath%>pei/detail?goodid=${mkey['goodId']}" target="_blank">${mkey['goodname']}</a>
                                          </c:if> 
                                          <c:if test="${mkey['productType']=='官方商品'}">
                                           <a href="<%=basePath2%>index/detail?gnumber=${mkey['goodId']}" target="_blank">${mkey['goodname']}</a>
                                          </c:if> 
                                        </td>
                                        <td class="text-center" style="width: 80px;vertical-align: middle;border-right: 1px #f2f2f2 solid;">
                                           ${mkey['quantity']}
                                        </td>
                                        <td class="text-center" style="width: 80px;vertical-align: middle;border-right: 1px #f2f2f2 solid;">
                                           	<span style="color:#F00;">￥${mkey['price']}</span>
                                        </td>
                                        <td class="text-center" style="width: 120px;vertical-align: middle;border-right: 1px #f2f2f2 solid;">
                                            -
                                        </td>
                                        <td class="text-center" style="width: 80px;vertical-align: middle;">
                                           	<span style="color:#F00;">￥${mkey['goodsPrice']}</span>
                                        </td>
                                    </tr>
                                   </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <%@ include file="../public/foot.jsp" %>