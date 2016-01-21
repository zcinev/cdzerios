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
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li><a href="#">询价管理</a></li>
                        <li class="active">询价列表</li>
                    </ol>
                </div>

                <form id="searchForm" class="form-inline" role="form"
					style="margin:10px;" action="<%=basePath%>member/receiveBox">
				    <div class="form-group">
                        <label class="sr-only" for="keyword">关键词</label>
                        <input type="text" class="form-control" id="keyword" placeholder="请输入你要搜索的内容">
                    </div>
                    <button type="submit" class="btn btn-primary">搜索</button>
                </form>

                <table class="table table-striped">
                    <tr></tr>
                    <tr>
                        <th>#</th>
                        <th>询价者</th>
                        <th>联系电话</th>
                        <th>询价时间</th>
                        <th>操作</th>
                    </tr>
                    <tr>
                       <td><input type="checkbox" value=""></td>
                        <td>张三</td>
                        <td>18600387087</td>
                        <td>2014-09-10</td>
                        <td>
                           <a href="<%=basePath%>member/delReceiveList?id=${mkey['id']}">删除</a>
                        </td>
                    </tr>
                    <tr class="text-center">
                        <div>${page}</div>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../public/foot.jsp"%>