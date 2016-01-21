<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/memberSidebar.jsp" %>
        <div class="col-md-10 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li><a href="#">交易管理</a>
                        </li>
                        <li class="active">完成列表</li>
                    </ol>
                </div>

                <form class="form-inline" role="form" style="margin:10px;" id="searchForm" action="<%=basePath%>member/tradeOk">
                    <div class="form-group">
                        <label class="sr-only" for="keyword">关键词</label>
                        <input type="text" class="form-control" id="keyword" placeholder="请输入你要搜索的内容">
                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
                    </div>
                    <button type="submit" class="btn btn-primary">搜索</button>
                </form>

                <table class="table table-striped">
                    <tr></tr>
                    <tr>
                        <th>#</th>
                        <th>消费者</th>
                        <th>金额</th>
                        <th>成交时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    <c:set var="index" value="1" /> 
                    <c:forEach var="mkey" items="${key}" > 
                    <tr>
                        <td>${index}</td>
                        <td>${mkey['buyer']}</td>
                        <td>${mkey['goodsSumPrice']}</td>
                        <td>${mkey['addTime']}</td>
                        <td>xxx</td>
                        <td>
                            <a href="#">查看</a>
                  		<c:if test="${typeId ==1}">
                  	      <a href="<%=basePath%>pei/comment?orderMainId=${mkey['orderMainId']}">评论</a>
                  	      </c:if>
                           <a href="<%=basePath%>member/delTradeOkList?orderMainId=${mkey['orderMainId']} ">删除</a>
                        </td>
                    </tr>
                    <c:set var="index" value="${index+1}" />
                    </c:forEach>
                    <tr class="text-center">
                      <div>${page}</div>  
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../public/foot.jsp"%>