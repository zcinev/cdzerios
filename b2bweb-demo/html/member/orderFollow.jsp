<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ include file="../public/head3.jsp" %>

        <div class="container-fluid">
            <div class="row">
                <%--<%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-xs-12 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                            <ol class="breadcrumb bottom-spacing-0">
						    <li class="active">订单状态</li>
						
					      </ol>
                          
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered" style="width:100%;margin:10px auto;border:1px solid #ccc;">
                                    <tr class="active">
                                        <th class="text-center">订单号</th>
                                        <th class="text-center">下单时间</th>
                                        <th class="text-center">联系人</th>
                                        <th class="text-center">联系电话</th>
                                        <th class="td-black text-center">状态</th>
                                    </tr>
                                   
                                    <tr>
                                        <td class="text-center">${mkey.orderId}</td>
                                        <td class="text-center">${mkey.createTime}</td>
                                        <td class="text-center">${mkey.contacts}</td>
                                        <td class="text-center">${mkey.tel}</td>
                                        <td class="text-center">${mkey.stateName}</td>
                                    </tr>
                                </table>
                                 <c:if test="${mailNo.equals('0')}">
                                 <dl class="order-detail">
                                    <dt style="color: red;"><h4>温馨提示</h4></dt>
                                    <dd>对不起，宝贝还未发货！</dd>
                                </dl>
                                 </c:if>
                                  <c:if test="${!mailNo.equals('0')}">
                                  <dl class="order-detail">
                                    <dt  style="color: red;"><h4>温馨提示</h4></dt>
                                    <dd>物流号：${mkey.mailNo}</dd>
                                   <dd>物流名称：${mkey.sendWayName}</dd>
                                </dl>
                                 </c:if>
                       <!--          <table class="table" style="width:90%;margin:20px auto;">
                                    <caption style="border-top:1px solid #FDA701;"></caption>
                                    <tr>
                                        <th class="td-black">处理时间</th>
                                        <th class="td-black">订单处理信息</th>
                                        <th class="td-black">备注</th>
                                        <th class="td-black">操作人</th>
                                    </tr>
                                    <tr>
                                        <td>2014-08-25 15:50:34</td>
                                        <td>
                                            您的订单已经发货
                                        </td>
                                        <td>
                                            xxxx
                                        </td>
                                        <td>
                                            会员
                                        </td>
                                    </tr>
                                </table> -->
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <%@ include file="../public/foot.jsp" %>