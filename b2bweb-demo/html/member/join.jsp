<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/header.jsp"%>
<style>
.main{
z-index:100000;
height: 402px;
width: auto;
background-image: url("<%=basePath%>html/img/jiameng_02.png");
background-repeat: no-repeat;
background-position:center;
margin-top: -60px;
}
.body{
height: 402px;

width: auto;
background-image: url("<%=basePath%>html/img/jiameng_17.png");
background-repeat: repeat;
padding-top:50px;
margin-top: 20px;
}
.row2{
padding-top: 20px;
}
.media-body{
font-size: 14px;font-weight: 500;
color:  #252a32;
}
h4 a{
color:#333;
cursor:pointer;
font: 24px/36px "Microsoft yahei";
}
h4 a:hover{
text-decoration:none;
color: rgb(0, 107, 255);
}
h3{
font: 24px/36px "Microsoft yahei";
}
#btn-5{
background-color: #f5fbef;
    background-image: linear-gradient(to top, #f5fbef 0px, #eaf6e2 100%);
    border: 1px solid #bfd6af;
    border-radius: 2px;
    color: #323333;
    display: inline-block;
    height:30px;
    line-height: 20px;
    padding: 4px 14px 3px;
   cursor: pointer;
    
}

#btn1-5{
	background-color: #f5fbef;
    background-image: linear-gradient(to top, #ccc 0px, #ccc 100%);
    border: 1px solid #bfd6af;
    border-radius: 2px;
    color: #323333;
    display: inline-block;
    height:30px;
    line-height: 20px;
    padding: 4px 14px 3px;
  	cursor: pointer;
    
}

#meida{
width: 50px;
height: 50px;

}
#media1{

display: block;}
#meidia2{
display: none;
}

#meida3{
width: 50px;
height: 50px;

}
#meidia4{

display: block;}
#meidia5{
display: none;
}
#meidia6{

display: block;}
#meidia7{
display: none;
}
#meida4{
width: 50px;
height: 50px;

}
#btn-5:hover{
color: #428bca;
}

.media .pull-left  img{
cursor: pointer;
}
</style>
 <div  class="main">
 
</div>
<div class="container">
 <div class="row row2" >
 <div class="col-md-4 col-md-offset-2">
 <div class="media" style="border:1px solid #DDD;padding:10px;">
   <a class="pull-left" onclick="jumpPartStore('<%=basePath%>');" id="meida">
      <img class="media-object" src="<%=basePath%>html/img/jiameng_05.png" alt="媒体对象" id="meidia1">
      <img class="media-object" src="<%=basePath%>html/img/jiameng_055.png" alt="媒体对象"  id="meidia2">
   </a>
   <div class="media-body">
      <h4><a onclick="jumpPartStore('<%=basePath%>');" style="border:1px solid #DDD;padding:5px;">入驻配件商</a></h4>
      <p style="text-indent:2em;">全新配件展示平台，坚决杜绝三无产品，专为消费者打造汽车配件高质、低价，是品牌配件的宣传阵地</p>
   	  <br/>
   </div>
</div>
 
 </div>
 <div class="col-md-4">
 <div class="media" style="border:1px solid #DDD;padding:10px;">
   <a class="pull-left"  onclick="jumpRepair('<%=basePath%>');" id="meida3">
      <img class="media-object" src="<%=basePath%>html/img/jiameng_07.png" alt="媒体对象" id="meidia4">
      <img class="media-object" src="<%=basePath%>html/img/jiameng_077.png" alt="媒体对象" id="meidia5">
   </a>
   <div class="media-body">
      <h4><a onclick="jumpRepair('<%=basePath%>');" style="border:1px solid #DDD;padding:5px;"> 入驻维修商</a></h4>
     <p style="text-indent:2em;">领先的汽车维修核算体系，完善的会员服务管理，平台提供全程的员工培训、考核服务</p>
     <br/>
   </div>
</div>
 
 </div>
 <div class="col-md-4">
 <div class="media" style="border:1px solid #DDD;padding:10px;">
   <a class="pull-left" href="#" id="meida4">
      <img class="media-object" src="<%=basePath%>html/img/jiameng_09.png" alt="媒体对象" id="meidia6">
       <img class="media-object" src="<%=basePath%>html/img/jiameng_099.png" alt="媒体对象" id="meidia7">
   </a>
   <div class="media-body">
      <h4><a onclick="jumpCarMannage('<%=basePath%>');" style="border:1px solid #DDD;padding:5px;">车务管家</a></h4>
  <p style="text-indent:2em;">集用车派车、用车监管、维修监管、预算管理于一体的车务管理系统。是监管单位车辆或集团监管下级单位用车的一把利剑</p>
   </div>
</div>
 
 </div>
</div>
 
 </div>
 <div class="body">
 <div class="row" id="row">
   <div class="col-sm-6 col-md-3">
      <div class="thumbnail" id="thumbnail">
      	 <p style="margin:10px;color:#006BFF;font-size:18px;">专员</p>
         <img src="<%=basePath%>html/img/jiameng_19.png"  alt="通用的占位符缩略图" >
         <div id="content">
         <h3><center>e代赔</center></h3>
       
         <p style="text-indent:2em;width: 100%;margin-left: auto;margin-right: auto;color: #999">
        提供快捷保险理赔服务，协助核保、维修、验收质量，负责向保险公司递送资料，催收理赔款
         </p>
        <c:if test="${kindString.indexOf('1')<0 || kindString=='0'}">
         <center><a id="btn-5"  href="<%=basePath%>join/joinClaim?kind=1">我要加入</a></center>
         </c:if>
 	 
 	   <c:if test="${kindString.indexOf('1')>=0}">
  	 <center><a id="btn1-5"  href="javascript:void(0);" title="您已经是保险理赔专员">我要加入</a></center>
  	</c:if>
          </div>
      </div>
      
   </div>
   <div class="col-sm-6 col-md-3">
      <div class="thumbnail">
      	 <p style="margin:10px;color:#006BFF;font-size:18px;">专员</p>
         <img src="<%=basePath%>html/img/jiameng_22.png" 
         alt="通用的占位符缩略图">
         <h3><center>e代检</center> </h3>
       
         <p style="text-indent:2em;width: 100%;margin-left: auto;margin-right: auto;color: #999;">
       提供车辆年检、驾照换证、违章处理、保险送单、酒后代驾，维修验车，车辆抛锚救援等服务
         </p>
        
          <c:if test="${kindString.indexOf('2')<0 || kindString=='0'}">
         <center><a id="btn-5"  href="<%=basePath%>join/joinClaim?kind=2">我要加入</a></center>
         </c:if>
 	 
 	  	 <c:if test="${kindString.indexOf('2')>=0}">
  		 <center><a id="btn1-5"  href="javascript:void(0);" title="您已经是车管车务专员">我要加入</a></center>
  		</c:if>
  	
      </div>
      
   </div>
  
    <div class="col-sm-6 col-md-3">
      <div class="thumbnail">
        <p style="margin:10px;color:#006BFF;font-size:18px;">专业</p>
        <img src="<%=basePath%>html/img/jiameng_33.png"  alt="通用的占位符缩略图" >
        <h3><center>同城物流</center></h3>
        <p style="text-indent:2em;width:100%;margin-left: auto;margin-right: auto;color: #999;">
       提供同城快捷配件物流，更快更省心。
         </p>
         <br/>
           <c:if test="${kindString.indexOf('3')<0 || kindString=='0'}">
         <center><a id="btn-5"  href="<%=basePath%>join/joinClaim?kind=3">我要加入</a></center>
         </c:if>
 	 
 	  	 <c:if test="${kindString.indexOf('3')>=0 }">
  		 <center><a id="btn1-5"  href="javascript:void(0);" title="您已经是同城物流专员">我要加入</a></center>
  		</c:if>
  	
        
      </div>
      
   </div>
   <div class="col-sm-6 col-md-3">
      <div class="thumbnail">
        <p style="margin:10px;color:#006BFF;font-size:18px;">专员</p>
        <img src="<%=basePath%>html/img/jiameng_33.png"  alt="通用的占位符缩略图" >
        <h3><center>e代修</center></h3>
         <p style="text-indent:2em;width:100%;margin-left: auto;margin-right: auto;color: #999;">
      <!--  为会员提供专家免费诊断，判断车辆故障原因，降低小病大修的风险；提供第三方验车服务，降低维修质量风险；提供上门取车，维修完后送车上门的服务；也包括帮助会员回收遗留在维修商店的汽车可用旧配件。 -->
         	提供专家免费诊断，第三方验车服务，上门取车及送车上门服务，帮助会员回收遗留在维修店的可用旧配件。
         </p>
           <c:if test="${kindString.indexOf('4')<0|| kindString=='0'}">
         <center><a id="btn-5"  href="<%=basePath%>join/joinClaim?kind=4">我要加入</a></center>
         </c:if>
 	 
 	  	 <c:if test="${kindString.indexOf('4')>=0 }">
  		 <center><a id="btn1-5"  href="javascript:void(0);" title="您已经是e代修专员">我要加入</a></center>
  		</c:if>
  	
        
      </div>
      
   </div>
</div>
 </div>
 
<%@ include file="../public/logoutfoot.jsp"%>
<script>
$("#meida").hover(
function(){

  $("#meidia1").css("display","none");
   $("#meidia2").css("display","block");
},

function(){
$("#meidia2").css("display","none");
   $("#meidia1").css("display","block");
});
$("#meida3").hover(
function(){

  $("#meidia4").css("display","none");
   $("#meidia5").css("display","block");
},

function(){
$("#meidia5").css("display","none");
   $("#meidia4").css("display","block");
});


$("#meida4").hover(
function(){

  $("#meidia6").css("display","none");
   $("#meidia7").css("display","block");
},

function(){
$("#meidia7").css("display","none");
   $("#meidia6").css("display","block");
});
</script>
<script src="<%=basePath%>html/js/join.js"></script>
		     
	