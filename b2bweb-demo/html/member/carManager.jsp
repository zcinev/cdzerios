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
.mapBox{
margin-left:20px;
float:left;
width:48%;

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
<script type="text/javascript" src="http://www.cdzer.com:8083/analytics/ip" charset="utf-8"></script>       <!--获取ip接口数据，注意 -->
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script src="<%=basePath%>html/js/join.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
 
<link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
<script>
begain('<%=basePath%>');
 var position = "null";
</script>
<!--   </head> 
  <body> -->
   <div id="container-fluid">
	    <div class="row" id="con">
	        <div id="con-top">
		         <h1>加入车管车务</h1>
	        </div>
	        <div id="con-blow">
               <div class="formBox">
	          <form action="" method="post" name="form1">
	         
	        	<table width="100%" border="0" cellspace="0" >
	        	<tr>
	        	  <td align="right">公司名称：</td>
	        	  <td>
	        	  	<input id="companyName" name="companyName" value="${key.companyName }" type="text"  class="form-control" onblur="validatelegalName('companyName');"placeholder="如：XXX有限公司"/>
	        	  	  
	        	      <span class="message" >公司名称不能为空[]</span>
                      <span class="messageShow" ></span>
	        	  
	        	  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">联系人：</td>
	        	   <td> <input id="urgentUser" name="urgentUser" type="text"  value="${key.urgentUser }" class="form-control" onblur="validatelegalName('urgentUser');"placeholder="如：张三"/>
	        	          <span class="message" >联系人不能为空[]</span>
                      <span class="messageShow"></span>
	        	   </td>
	        	   
	        	</tr>
	        	<tr>
	        	  <td align="right">联系电话：</td>
	        	  <td> <input id="urgentTel" name="urgentTel" value="${key.urgentTel }" type="text" class="form-control" onblur="validatelegalTel('urgentTel');" placeholder="如：13801088***"/>
	        	     <span class="message" >联系电话不正确[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	</tr>
	        	<tr>
	        	    <td align="right">详细地址：</td>
	        	    <td>
	        	    	<input name="address" type="text" id="address" value="${key.address }" class="form-control" oninput="searchByStationName();" onblur="validatelegalAddress('legalAddress');"placeholder="如：XX省XX市XX区XX街道X号" />
	        	        <span class="message" >详细地址不能为空[]</span>
                        <span class="messageShow" ></span>
	        	    </td>
	        	</tr>
	        	<tr>
	        	    <td align="right"></td>
	        	    <td>
	        	        <input name="latlon" type="hidden" value="${key.map }" id="latlon" class="form-control"/>
                       </td>
	        	</tr>	
  				</table>
  				<div id="card1"><input type="hidden" name="idCardfront" id="idCardfront" value=""></div>
  				<div id="card2"><input type="hidden" name="idCardverso" id="idCardverso" value=""></div>
  				
  				<div id="button" style="margin-left:160px;margin-top:20px;">
		           <button id="lastButton" type="button" class="btn btn-primary" onclick="javascript:history.go(-1);">返回</button>
		           <button id="nextButton" type="button" class="btn btn-warning" onclick="nextFun13('<%=basePath%>')">申请</button>
	       	    </div>
  				</form>
  				<div style="width:435px;float:right;color:#ccc;"><p>车队长温馨提示：您的申请我们将在24小时内联系您,任何疑问您可以联系<p style="text-indent: 2em;">您的专职汽车管家或致电0731-88865777</p></p></div>
  				</div>
  				<div class="mapBox">
  				  <%@ include file="../public/map.jsp"%>
  				</div>
	       
	    </div>
	    </div>
          <div id="line" style="color:#499ad9" > </div>
    </div>   

<%@ include file="../public/foot.jsp"%>
 <script>
 var latlon=$("#latlon").val();
if(latlon!=""){
searchByStationName();
}

 function nextFun13(url) {
	var companyName = document.getElementById("companyName");
	var urgentUser = document.getElementById("urgentUser");
	var urgentTel = document.getElementById("urgentTel");
	var address = document.getElementById("address");
	
	var check = true;

	if (!validatelegalName('companyName')) {
		check = false;
	}
	if (!validatelegalName('urgentUser')) {
		check = false;
	}
	if (!validatelegalTel('urgentTel')) {
		check = false;
	}

	if (!validatelegalAddress('address')) {
		check = false;
	}

	if (check == false) {
		return;
	}
	

	document.form1.action = url + "join/basicInfo";
	document.form1.submit();
	
	
}
 </script> 
<script>
	$.ajax({
		type : "get",
		url : "<%=basePath%>join/getPartCenter",
		async : false,
		dataType : "html",
		success: function(dat) { 
	       $('#center').html(dat);
	    },
	    error: function() {
	      alert('发送失败');
	    }
	  });
</script>

<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
    var bufferdata1 = "";
    var bufferdata2 = "";
	var buffer = ""; 
     KindEditor.ready(function(K) {
      
        
     var editor1 = K.editor({
      uploadJson : '<%=uploadUrl%>?root=demo-basic-idCard',
    	//店铺全景图路径
         allowFileManager : true
    });
     K('#upload-full-img').click(function() {  
        editor1.loadPlugin('multiimage', function() {
            editor1.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata1=data.url;
                       document.getElementById("idCardfront").value=bufferdata1;
                        
                         var objRow = document.getElementById("showImg1"); 
                           var  img="";
                             objRow.innerHTML=img;
                        $('#showImg1').append('<img id="litpic5" style="width:150px;height:150px;" src="' + data.url + '">');
                        var a = document.getElementById("litpic5").src;
                     });
                     editor1.hideDialog();
                     
                  }
            });
        });
    });

 
 
  K('#upload-full-img2').click(function() {  
        editor1.loadPlugin('multiimage', function() {
            editor1.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata2=data.url;
                          document.getElementById("idCardverso").value=bufferdata2;
                       var objRow = document.getElementById("showImg2"); 
                           var  img="";
                             objRow.innerHTML=img;
                        $('#showImg2').append('<img id="litpic6" style="width:150px;height:150px;" src="' + data.url + '">');
                        var b = document.getElementById("litpic6").src; 
                     });
                     editor1.hideDialog();
                     
                  }
            });
        });
    });
 });
</script>