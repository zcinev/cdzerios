<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ include file="../public/mchead.jsp"%>

<style>
#box{
     width:100%;
	 height:60%;
	 margin:0 auto;
	 margin-left:0;
	 margin-right:0;
	
    }    
#top{
     margin-top:10px;
     width:100%;
     height:104px;
    /*  background-color:red; 
     border:1px solid black; */
    } 
#top-left{
     width:50%;
     margin-left:250px;
     text-align:left;
     float:left;
}  
#top-right{
     margin-top:10px;
     width:30%;
     float:right;
} 

#con{
	 margin-top:10px; 
	 height:90%;
	 border-top:2px solid #499ad9;
	 border-left:1px solid #ccc;
     border-right:1px solid #ccc;
     border-bottom:1px solid #ccc;
    /*  background-color:yellow; */
  }  
#c-left{
    float:left;
    margin-left:20px;  
 }
#c-right{
    float:right; 
    margin-right:20px;  
 }
#con-title{
   clear:both;
   margin-left:20px;
   margin-top:20px;
   margin-bottom:40px;
}
#con-blow{
   min-height:400px; 
} 
#button{
 /*  float:right; */
  margin-left:80%;
  margin-bottom:20px;
}
#line{
 width:80%;
 margin-left:100px;
 clear:both;
 margin-top:50px;
 border-bottom:1px solid #499ad9;
}   
#bottom{
  width:100%;
  clear:both;
  height:10%;
  margin-top:50px;
 
  text-align:center;
}

.formBox{
float:left;
width:50%;
}
.maplocal{
margin-left:20px;
float:left;
width:40%;

}
.idCarBox1{
float:left;
width:400px;
min-height:200px;
border:1px solid #ccc;
}
.idCarBox2{
float:left;
width:400px;
min-height:200px;
border:1px solid #ccc;
}
td{
 padding:2px 0px;
}
h1{
font: normal 24px/36px 'Microsoft yahei';
}
/* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}

#con-top {
    margin: 20px 0px 20px 150px;
}
</style>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<script src="<%=basePath%>html/js/jquery.min.js"></script>

<!--   </head> 
  <body> -->
   <div id="container-fluid">
	<%--     <div id="top" >
	            <div id="top-left">
	                <img src="<%=basePath%>html/img/join/business_01.jpg"/>
	            </div>
	            <div id="top-right">
	                 <img src="<%=basePath%>html/img/join/business_03.jpg"/>
	                <a href="#">帮助</a>  		
	            </div>  
	    </div> --%>
	    <div class="row" id="con">
	
	        <div id="con-top">
	        <c:if test="${kind=='1' }">
	         <h1>加入保险理赔</h1>
	        </c:if>
		     
		      <c:if test="${kind=='2' }">
	         <h1>加入车管车务</h1>
	        </c:if>
	        
	         <c:if test="${kind=='3' }">
	         <h1>加入同城物流</h1>
	        </c:if>  
	        
	         <c:if test="${kind=='4' }">
	         <h1>加入e代修</h1>
	        </c:if>   
	        </div>
	        <div id="con-blow">
               <div class="pull-left formBox">
	          <form action="" method="post" name="form3">
	         <input type="hidden" value="${kind}" name="kindStr">
	        	<table width="100%" border="0" cellspace="0" >
	        
	        	<tr>
	        	  <td align="right">联系人：</td>
	        	   <td> <input id="realName" name="realName" type="text"  value="${key.realName }" class="form-control" onblur="validatelegalName('urgentUser');"placeholder="如：张三"/>
	        	          <span class="message" >联系人不能为空[]</span>
                      <span class="messageShow"></span>
	        	   </td>
	        	   
	        	</tr>
	        	<tr>
	        	  <td align="right">联系电话：</td>
	        	  <td> <input id="telphone" name="telphone" value="${key.telphone }" type="text" class="form-control" onblur="validatelegalTel('urgentTel');" placeholder="如：13801088***"/>
	        	     <span class="message" >联系电话不正确[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	</tr>
	        	<tr>
	        	    <td align="right">详细地址：</td>
	        	    <td>
	        	    	<input name="address" type="text" id="address" value="${key.address }" class="form-control"  onblur="validatelegalName('address');"placeholder="如：XX省XX市XX区XX街道X号" />
	        	        <span class="message" >详细地址不能为空[]</span>
                        <span class="messageShow" ></span>
	        	    </td>
	        	</tr>
	        	
  				</table>
  				
  				
  				<div id="button" style="margin-left:160px;margin-top:20px;">
		           <button id="lastButton" type="button" class="btn btn-primary" onclick="javascript:history.go(-1);">返回</button>
		           <button id="nextButton" type="button" class="btn btn-warning" onclick="nextFun()">申请</button>
	       	    </div>
  				</form>
  				<div style="width:435px;float:right;color:#ccc;"><p>车队长温馨提示：您的申请我们将在24小时内联系您,任何疑问您可以联系<p style="text-indent: 2em;">您的专职汽车管家或致电0731-88865777</p></div>
  				</div>
  				<div class="maplocal">
	  				<c:if test="${kind=='1' }">
			         <img class="pull-left"src="<%=basePath%>html/images/111.png"></img>
			        </c:if>
				    <c:if test="${kind=='2' }">
			         <img class="pull-left"src="<%=basePath%>html/images/222.png"></img>
			        </c:if>
			        <c:if test="${kind=='3' }">
			         <img class="pull-left"src="<%=basePath%>html/images/333.png"></img>
			        </c:if>  
			         <c:if test="${kind=='4' }">
			         <img class="pull-left"src="<%=basePath%>html/images/333.png"></img>
			        </c:if>  
  				</div>
	       
	    </div>
	    </div>
          <div id="line" style="color:#499ad9" > </div>
    </div>   

<%@ include file="../public/foot.jsp"%>


<script>
function nextFun(){
	var realName=$("#realName").val();
	var telphone=$("#telphone").val();
	var address=$("#address").val();
	var kind="${kind}";
	var check=true;
	if(!validatelegalName('realName')){
		check=false;
	}
	if(!validatelegalTel('telphone')){
		check=false;
	}
	if(!validatelegalName('address')){
		check=false;
	}
	if(check==true){
		document.form3.method="post";
		document.form3.action="<%=basePath%>join/applyClaim";
		document.form3.submit();
		<%-- $.ajax({
			url:"<%=basePath%>join/applyClaim",
			type:"post",
			dataType:"json",
			data:{realName:realName,telphone:telphone,address:address,kindStr:kind},
			success:function(data){
				if(data.info=="0"){
					window.location.href="<%=basePath%>html/login.jsp";
				}else{
					window.location.href="<%=basePath%>html/member/success.jsp";
				}
			},
			error:function(){
			}
		}); --%>
	}
}
</script>
