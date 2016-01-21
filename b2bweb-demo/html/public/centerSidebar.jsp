<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.list-body {
    font-size: 12px;
    text-indent: 30px;
}
.list-title {
font-weight: 700;
color:#454545;
font-size: 13px;
}
.list-title a:hover{
color:#428BCA;
}
.glyphicon-plus-sign{
color:#8c9093;
width: 4px;
height: 4px;
cursor: pointer;
margin-right: 16px;
}
.glyphicon-minus-sign{color: #ff9721;cursor: pointer;margin-right: 10px;}
</style>
<div class="col-md-2 paddingLeft0 pull-left">
    <div class="panel panel-default">
        <div class="panel-heading" style="background-color: #D4F0FE;border-color: #ddd;">
            <h3 class="panel-title"><center>采购中心</center></h3>
        </div>
        <div class="panel-body">
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span> 会员中心</span></dt>
                <dd class="list-body"><a href="<%=basePath%>purchase/showBasic "id="centerInfo">基本信息</a></dd>
                <dd class="list-body"><a href="<%=basePath%>purchase/updatePassword ">修改密码</a></dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span> 店铺管理</span></dt>
                <dd class="list-body"><a href="<%=basePath%>purchase/storeList" id="centerStore">店铺列表</a></dd>
              <!--    <dd class="list-body"><a href="<%=basePath%>html/center/storeAdd.jsp">新增店铺</a></dd> 		-->
            </dl>
            
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span> 生产商管理</span></dt>
                  <dd class="list-body">
                    <a href="<%=basePath%>purchase/producerList" id="centerProducer">生产商列表</a>
                </dd>
              <!--  
               <dd class="list-body"><a href="<%=basePath%>html/center/producerAdd.jsp">添加生产商</a></dd>	
               -->		
            </dl>			
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span> 产品管理</span></dt>
                <dd class="list-body">
                    <a href="<%=basePath%>purchase/partsList" id="centerDemo">配件列表</a>
                </dd>
                <dd class="list-body">
                    <a href="<%=basePath%>purchase/equeryList" id="eParts">询价配件</a>
                </dd>
            </dl>
            <dl class="child-list">
               <!--  
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">交易管理</a></dt>
                <dd class="list-body"><a href="<%=basePath%>center/tradeOk">完成列表</a></dd>
                <dd class="list-body"><a href="<%=basePath%>purchase/tradeFail">退货列表</a></dd>
                -->
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span> 订单管理</span></dt>
                <!--<dd class="list-body"><a href="<%=basePath%>purchase/tradeOk">订单列表</a></dd>-->
                <dd class="list-body"><a href="<%=basePath%>purchase/tradeOk?id=${id}" id="centerOrder">订单列表</a></dd>
                <!--<dd class="list-body"><a href="<%=basePath%>purchase/tradeFail">退货列表</a></dd>-->
            </dl>
            <!--  -->
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span> 询价管理</span></dt>
                <dd class="list-body"><a href="<%=basePath%>purchase/askPrice" id="centerPrice">询价列表</a></dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span> 评论管理</span></dt>
               <%--  <dd class="list-body"><a href="<%=basePath%>comment/commentStore">评论店铺</a></dd> --%>
                <dd class="list-body"><a href="<%=basePath%>comment/commentParts" id="centerComment">评论列表</a></dd>
               <%--  <dd class="list-body"><a href="<%=basePath%>comment/peiCommentReply">配件回复</a></dd> --%>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span> 站内信息</span></dt>
                <dd class="list-body"><a href="<%=basePath%>purchase/receBox"id="centerRece">收件箱</a></dd>
                <dd class="list-body"><a href="<%=basePath%>purchase/sendBox" id="centerSend">发件箱</a></dd>
            </dl>
        </div>
    </div>
</div>