<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/head.jsp"%>

<div class="container-fluid">
    <div class="row">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">错误title</h3>
            </div>
            <div class="panel-body">
                <p class="jump">
                    页面自动 <a id="href" href="#">跳转</a> 等待时间： <b id="wait">5</b>
                </p>
            </div>
        </div>
    </div>
</div>

<%@ include file="./public/foot.jsp"%>
<script type="text/javascript">
  (function() {
    var wait = document.getElementById('wait'),
         href = document.getElementById('href').href;
    var interval = setInterval(function() {
        var time = --wait.innerHTML;
         if (time <=0) {
            window.location.href ="<%=basePath%>html/login.jsp";
            clearInterval(interval);
        };
    }, 1000);
})();  
 
</script>