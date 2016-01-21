<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="col-md-3 paddingRight0 pull-right">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">最新交易记录</h3>
        </div>
        <div class="list-group">
			<c:forEach var="mkey" items="${skey}" >
				<a href="<%=basePath%>pei/detail?id=${mkey['goodId'] }" class="list-group-item">
					<span class="glyphicon glyphicon-bullhorn"></span>
					<span style="color:#000;">${mkey['goodname'] }</span><br />
					<span class="list-group-item-text">
						订单号：  ${mkey['orderMainId']} <br/>
						${mkey['buy']} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span style="font-size:20px; font-weight: bold; color:#e4393c;">¥${mkey['goodsSumPrice']}</span><br/>
						${mkey['addTime']}
                	</span>
				</a>
			</c:forEach>
        </div>
    </div>
</div>