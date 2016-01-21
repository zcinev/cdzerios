<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/mchead.jsp"%>
<style>
body{
    color:#000;
	font-size:12px;
	margin:auto;
	width:100%;
	line-height:24px;
	word-spacing:2px;
   
    }
#box{
     width:100%;
	 height:60%;
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
     width:60%;
	 margin-top:10px; 
	 margin-left:250px;
	 height:400px;
	 border-top:2px solid #499ad9;
	 border-left:1px solid #ccc;
     border-right:1px solid #ccc;
     border-bottom:1px solid #ccc;
     background-image: url("<%=basePath%>html/img/success_bg.png"); 
  }  
#c-left{
    float:left;
    margin-left:20px;  
 }
#c-right{
    float:right; 
    margin-right:20px;  
 } 
/* #pic{
    width:57px;
    height:51px;
    margin-top:140px;
    margin-left:80px;
   
    } */
#con-title{
   clear:both;
   width:610px;
    margin-left:auto;
    margin-right:auto;
    margin-top:140px;
   margin-bottom:100px;  
    text-align:center; 
  /*  margin-left:150px; */
  
}
#con-blow{
 
   margin-left:50px;
} 
#button{
 /*  float:right; */
  margin-left:80%;
  margin-top:50px;
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
a{
 text-decoration:none;
 color:#000;
}
a:link{
  text-decoration:none;
  color:#000;
}



</style>

   <div id="container-fluid">
	
	     <div class="row" id="con">
	        <div id="con-top">
	             <div id="c-left">
		         <h1>入驻车务管家</h1>
		         </div>
		         <div id="c-right">
		          <img src="<%=basePath%>html/img/join/car_05.jpg">
		         </div>
	        </div>
	        <div id="con-blow">
	          <div id="tuwen">
	          <div id=pic></div>
	          <div id="con-title">
	             <p><img src="<%=basePath%>html/img/join/car_06.png"> 恭喜您！亲爱的${userName}会员，您的申请已经提交成功，车队长将在24小时内联系您任何疑问，您可以联系您的专职汽车管家或致电0731-88865777。</p>
              </div>
              </div>
	          <div id="button">
		           <button id="returnButton" type="button" class="btn btn-danger" onclick="returnIndex('<%=basePath%>');">返回首页</button>
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