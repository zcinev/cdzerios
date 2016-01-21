<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="col-xs-2 paddingLeft0">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
            	会员中心
            </h3>
        </div>
        <div class="panel-body"> 
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="<%=basePath%>/member/memberCenter">基本信息</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/basic.jsp">个人资料</a>
                </dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/private.jsp">隐私设置</a>
                </dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/pwdStrong.jsp">密码安全</a>
                </dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/distList.jsp">收货地址列表</a>
                </dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/distAdd.jsp">新增收货地址</a>
                </dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">订单管理</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/order.jsp">完成列表</a></dd>
<!--                <dd class="list-body"><a href="<%=basePath%>html/member/orderReturn.jsp">退货列表</a></dd>-->
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">维修管理</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/mtDgList.jsp">维修诊断单</a></dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/mtTsList.jsp">维修委托书</a></dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/mtFaList.jsp">维修结算单</a></dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">保险</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/insuranceList.jsp">保险列表</a></dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/recordsList.jsp">赔付记录</a></dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">车辆管理</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/carList.jsp">车辆列表</a></dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/carAdd.jsp">添加车辆</a></dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">评论管理</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/comments.jsp">评论列表</a></dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">我的收藏</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/productList.jsp">商品列表</a></dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/sendBox">店铺列表</a></dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">我的问答</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/ask.jsp">我的提问</a></dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/ans.jsp">我的回答</a></dd>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">站内信息</a></dt>
                <dd class="list-body"><a href="<%=basePath%>html/member/receBox.jsp">收件箱</a></dd>
                <dd class="list-body"><a href="<%=basePath%>html/member/sendBox.jsp">发件箱</a></dd>
            </dl>
        </div>
    </div>
</div>