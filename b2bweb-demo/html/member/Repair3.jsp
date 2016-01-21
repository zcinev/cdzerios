<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/mchead.jsp"%>
   <div id="container-fluid">
	
	     <div class="row" id="con3">
	        <div id="con-top3">
		         <h1>入驻维修商</h1>
	        </div>
	        <div id="con-blow">
	          <div id="tuwen">
	          <div id=pic></div>
	          <div id="con-title3">
	             <p><img src="<%=basePath%>html/img/join/car_06.png"> 恭喜您！亲爱的${userName}会员，您的申请已经提交成功，车队长将在24小时内联系您</p>
	             <p>有任何疑问，您可以联系您的专职汽车管家或致电0731-88865777。</p>
              </div>
              </div>
	          <div id="button">
		           <button id="returnButton" type="button" class="btn btn-primary" onclick="returnIndex('<%=basePath%>');">返回首页</button>
	       	  </div>
	        </div>
	       
	    </div>
          <div id="line" style="color:#499ad9"> </div>
    </div>     
<%@ include file="../public/foot.jsp"%>
<script>
function returnIndex(url){
	window.location.href=url+"join/jumpJoin";
}
</script>