<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/head.jsp"%>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<style>
#uldht li a{
/* color: #00a9ff; */

font-size: 14px;
}
.navbar-default .navbar-nav>li>a {
color: white;
}
#uldht li a:hover{
background-color: #195fa4;
color:white;
}

h4{
font-size: 14px;
color: #333;
margin-top: 10px;
}
#body a{
color: #0077FF;
background-color: #EFEFEF; 
width: 100%;
height: 30px;
padding: 3px;
}
#body a:hover{
color: white;
background-color: #0077FF; 
width: 100%;
height: 30px;
text-decoration:none;
padding: 3px;
}
#body{
padding-top: 10px;
}
#obj{
width: 100px;
height: 80px;
margin-bottom: 20px;
} 
#body .media-heading{
margin-top: -6px;
color: #333;
}
#body{
line-height: 22px;
}
element.style {
}

.navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.active>a:hover, .navbar-default .navbar-nav>.active>a:focus {
color: white;
background-color: #195fa4;
}
.selectCar{
color: #ff6100;
}
.banner ul li{
	border: 1px solid #CCC;
}
</style>
    <div class="container-fluid">
        <div class="row">
            <%@ include file="./public/sidebarLeft.jsp"%>
            <div class="col-md-9 paddingLeft0 paddingRight0 pull-left"><%--
                <div class="width-auto" id="imgauto">
                     <img src="<%=basePath%>html/img/test.png" class="img-responsive" alt="Responsive image" style="height: 338px;"> 
                </div>
                --%><div class="width-auto banner pull-left">
                    <ul class="paddingLeft0" id="banner_img">
                       <%--  <li><img width="100%" height="350" src="<%=basePath%>html/img/Engine.png"></li>
                        <li><img width="100%" height="350" src="<%=basePath%>html/img/undercoating.png"></li>
                        <li><img width="100%" height="350" src="<%=basePath%>html/img/bodyAccessories.png"></li>
                        <li><img width="100%" height="350" src="<%=basePath%>html/img/Electronic.png"></li>
                        <li><img width="100%" height="350" src="<%=basePath%>html/img/saveAccessories.png"></li> --%>
                    </ul>
                </div>
            </div>
                <div class="col-md-9 paddingLeft0 paddingRight0 pull-left">
				<c:forEach var="mkey" items="${lkey2}">
	                <div class="media border-bottom-1">
	                    <a class="pull-left" href="<%=basePath%>pei/listPart?id=${mkey['id']}">
	                        <img class="media-object" src="${mkey['imgurl']}" alt="交易服务" id="obj">
	                    </a>
	                    <div class="media-body" id="body">
	                        <h4 class="media-heading">
	                             ${mkey['name']}
	                        </h4>
	                        <c:forEach var="lmap" items="${mkey['lmap']}" varStatus="status">
	                        	<c:if test="${status.index<10}">
	                        	    <c:if test="${lmap['infoid']==''}">
	                        	    <a name="gdxh" href="${url2}?id=${lmap['id']}" >${lmap['name']}</a>&nbsp;&nbsp;
	                        	    </c:if>
	                        	     <c:if test="${lmap['infoid']!=''}">
	                        	    <a name="gdxh" href="${url2}?id=${lmap['infoid']}" >${lmap['name']}</a>&nbsp;&nbsp;
	                        	    </c:if>
	                        		
	                        	</c:if>
	                        </c:forEach><br/> 
	                   		<div style="display:none;">
	                   			<c:forEach var="lmap" items="${mkey['lmap']}" varStatus="status">
		                   			<c:if test="${status.index>=10}">
		                   			 <c:if test="${lmap['infoid']==''}">
	                        			<a name="gdxh" href="${url2}?id=${lmap['id']}" >${lmap['name']}</a>&nbsp;&nbsp;
	                        			</c:if>
	                        			<c:if test="${lmap['infoid']!=''}">
	                        			<a name="gdxh" href="${url2}?id=${lmap['infoid']}" >${lmap['name']}</a>&nbsp;&nbsp;
	                        			</c:if>
	                        		</c:if>
	                       		</c:forEach> 
	                        	<%-- <a name="gdxh" href="${url2}?id=${lmap['id']}" >${lmap['name']} </a> --%>
							</div>  
	                  		<a onclick="ckgd(this);" style="cursor: pointer;color: red;background-color: white;">更多</a>
	                    </div>
	                </div>
				</c:forEach>
            </div>
           
        </div>
    </div>
<%@ include file="./public/foot.jsp"%>
<script>


var tname1="${name}";

 $(function () {
 	if(tname1=="发动机"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/Engine.png'></li>";
 	}
 	if(tname1=="底盘"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/undercoating.png'></li>";
 	}
 	if(tname1=="车身及附件"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/bodyAccessories.png'></li>";
 	}
 	if(tname1=="电子、电器"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/Electronic.png'></li>";
 	}
 	if(tname1=="保养配件"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/saveAccessories.png'></li>";
 	}
});

 function ckgd(dq){
	 if(dq.previousElementSibling.style.display == "none"){
		 dq.previousElementSibling.style.display = "";	
		 dq.innerHTML="收起";
	 } 	 		
	 else{
		 dq.previousElementSibling.style.display = "none"; 
		 dq.innerHTML="更多";
	 }		 	 
 }

 var topol = document.getElementById("topol");
 topol.innerHTML = toparr;

$(function(){
	
	var top=$("#uldht li a");
	
	top.click(function(){
	
	$(this).addClass("color","white").siblings().removeClass("thisClass");
	})
	})
</script>
<SCRIPT>
var Id=sessionService.getAttribute(request, "Id");
var add = top.location;
add = add.toString();
var url=add.substring(add.indexOf("=")+1,add.length);
var pj="pj"+url+".png";
document.getElementById("imgauto").innerHTML="<img style='width:100%;height:338px;' src='<%=basePath%>html/img/Engine.png' />";
</SCRIPT>