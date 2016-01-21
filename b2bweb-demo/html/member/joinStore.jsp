<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ include file="../public/mchead.jsp"%>
<style>
/* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
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
		         <h1>入驻配件商</h1>
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
  				
  				<div id="button" style="margin-left:250px;margin-top:20px;">
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
 if(latlon.indexOf("|")<0){
 	createMap();
 }else{
searchByStationName();
}
  
  
   var wxs_json;
  
	function queryNearStore(){
	 var cityId=$("#latlon").val();
                 $.ajax({
                type:"POST",
               data:{city:cityId},
               url:"<%=basePathpj%>ajax/pjsNameList",
               async:false,
               dataType:"JSON",
               success:function(data){
               wxs_json=data; 
                //wxsTelphone,serviceTime ,wxsName, address, userShopLogo
                   //根据  城市 id 获取对应的 维修商 加信息
                   
               shows();
               },
               error:function(){
                      
               }
                              });
           
   }         
</script>

 <script>


			
 function shows(){
		var wxsMap= wxs_json[0].map; 
		var companyName= document.all['companyName'];
		var urgentTel= document.all['urgentTel'];
		var address= document.all['address3'];
		if(wxsMap==undefined ){//一条记录时执行 
 		
			var point = new BMap.Point(112.945333,28.233971);//112.945333|28.233971
			addMarker(112.945333,28.233971,1,1,1,1,0);
		}else if(wxs_json.length>0){//多条记录时执行
		
			for(var i=0; i<wxs_json.length; i++){
				var reference=wxs_json[i].map.split("|");
				var longitude=reference[0];//经度
				var latitude=reference[1];//纬度
				var point = new BMap.Point(longitude,latitude);
				
				addMarker1(longitude,latitude,wxs_json[i].companyName,wxs_json[i].urgentTel,wxs_json[i].address,i);
			
				}
		}
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