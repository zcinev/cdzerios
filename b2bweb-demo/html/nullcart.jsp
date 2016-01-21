<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="public/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <style>
  .btn-danger{
  background-color:#ff9100;border-color: #ed8802;width: 80px;
  }
  .btn-danger:hover{
color: white;
background-color:#FAB04E;
border-color: #FAB04E;
}
#null{
text-align: center;
margin-top: -20px;
}
  </style> 
  
    <div class="container-fluid" >
    
        <div class="row">
         
            <div class="col-md-12 paddingLeft0 paddingRight0">
            <div class="col-md-12 ">首页</div>
               <div class="col-md-12 " id="null">
              <a href="<%=basePath%>"> <img alt="" src="<%=basePath%>html/img/nullcart.png" style="width:400px;"></a>
               
               </div>
              
            </div>
        </div>
    </div>
 
 
<div style="margin-top: 30px;">
<%@ include file="public/foot.jsp"%>
</div>

<script type="text/javascript">
	var strName = "<%=session.getAttribute("userName")%>";	
	var strId = "<%=session.getAttribute("id")%>";	
	var typeId = "<%=session.getAttribute("typeId")%>";	
	var dlyzc = document.getElementById("dlyzc");
	var str = "";
	if((strName==null)||(strName=="null")||(strName==""));
	else {
	
		if(typeId=="1")
		str = "<a href=\"<%=hostPath%>b2bweb-repair/person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">亲爱的用户:"+strName+"，您已登陆！ </a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\" class=\"btn btn-default\" role=\"button\">注销</a>";
		else
		str = "<a>亲爱的用户:"+strName+"，您已登陆！ </a><a href=\"<%=hostPath%>b2bweb-demo/pei/logout\" class=\"btn btn-default\" role=\"button\">注销</a>";
		
		dlyzc.innerHTML = str;
	}

</script>


	