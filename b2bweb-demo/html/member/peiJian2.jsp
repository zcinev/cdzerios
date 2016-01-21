<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ include file="../public/mchead.jsp"%>
     <script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
h1{
font: normal 24px/36px 'Microsoft yahei';
}
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
<style>
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
	 margin-top:10px; 
	 height:auto;
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
 
   margin-left:20px;
}
#table{
  float:left;
 /*  background-color:red; */ 
 
}
#table1{
  width:100%;
 
}
#pic{
  width:35%;
  float:right;
}
#pic1{
  height:40%;
}
#pic2{
  margin-top:620px;
  margin-bottom:20px;
}
 
#button{
 /*  float:right; */
  margin-left:40%;
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
a{
 text-decoration:none;
 color:#000;
}
a:link{
  text-decoration:none;
  color:#000;
}
td{
 padding:2px 0px;
}
#table2{
  width:55%;
  float:left;
 /*  background-color:red; */ 
 
}
.idCarBox1{
float:left;
width:430px;
min-height:200px;
border:1px solid #ccc;
}
</style>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script src="<%=basePath%>html/js/join.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
<script type="text/javascript" src="<%=basePath%>html/My97DatePicker/WdatePicker.js"></script>
<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
    <div id="container-fluid">
	
	     <div class="row" id="con">
	        <div id="con-top">
	             <div id="c-left">
		         <h1>入驻配件商</h1>
		         </div>
		         <div id="c-right">
		         <img src="<%=basePath%>html/img/join/car_04.jpg">
		         </div>
	        </div>
	        <div id="con-blow">
	          <div id="con-title">
	          <p><strong>营业执照信息 （副本）</strong><font color="#ccc">[以下所需要上传电子版资质仅支持JPG、GIF、PNG格式的图片，大小不超过1M，且必须加盖企业彩色公章。]
              </font></p>
              </div>
                <form action="" method="post" name="form1">
                <input type="hidden" name="id" value="${key.id}">
                <input type="hidden" name="provinces2" id="provinces2" value="${key.province}">
                <input type="hidden" name="citys" id="citys" value="${key.city}">
              <div id="table">
              <div id="table1">
	        
	        	<table width="100%" border="0" cellspace="0" >
	        	<tr>
	        	  <td align="right">公司名称：</td>
	        	  <td>
	        	  	<input id="companyName" name="companyName" value="${key.companyName }" type="text"  class="form-control" onblur="validatelegalName('companyName');"/>
	        	  	  
	        	      <span class="message" >公司名称不能为空[]</span>
                      <span class="messageShow" ></span>
	        	  
	        	  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">营业执照注册号：</td>
	        	  <td> <input id="businessLicenceNo" name="businessLicenceNo" value="${key.businessLicenceNo }" type="text" class="form-control" onblur="validatelegalName('businessLicenceNo');"/>
	        	       <span class="message" >营业执照注册号不能为空[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	</tr>
	        	 <tr>
	        	  <td align="right">营业执照副本电子版：</td>
                   <td>
                    <div class="col-sm-10">
                    <a href="javascript:;" id="upload-full-img" class="btn btn-primary"><img alt="" src="<%=basePath %>html/img/moren-upload.png">请选择要上传的图像</a>
                    </div> 
	        	</td>
	        	</tr>
	        	
	        	<tr>
	        	<td  align="right">	</td>
	        	<td>
	     		   <div class="idCarBox1" >
	     		      <div class="col-sm-10" id="showImg1">
                        <img id="litpic5" style="width:150px;height:150px;" src="${key.businessLicence}" alt="">
                         </div>
	     		   </div>
	     		   </td>
	        	</tr>
	        	
	        	
	        	<tr>
	        	  <td align="right">营业执照详细地址：</td>
	        	 <td> <input id="licenceAddress" name="licenceAddress" type="text" value="${key.licenceAddress }" class="form-control" onblur="validatelegalName('licenceAddress');"/>
	        	    <span class="message" >详细地址不能为空[]</span>
                      <span class="messageShow"></span>
	        	 </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">成立日期：</td>
	        	  <td> <input id="buildDate" name="buildDate" value="${key.buildDate }" type="text" class="form-control" onclick="new Calendar().show(this);" onmousemove="validatelegalName('buildDate');"/>
	        	    <span class="message" >成立日期不能为空[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">营业时间：</td>
	        	  <td> <div class="form-inline">
	        	  <select name="week1" id="week1" class="form-control" style="width:90px;">
                        <option value="星期一">星期一</option>
                        <option value="星期二">星期二</option>
                        <option value="星期三">星期三</option>
                        <option value="星期四">星期四</option>
                        <option value="星期五">星期五</option>
                        <option value="星期六">星期六</option>
                        <option value="星期天">星期天</option>
                        </select>—
                   <select name="week2" id="week2" class="form-control" style="width:90px;">
                        <option value="星期一">星期一</option>
                        <option value="星期二">星期二</option>
                        <option value="星期三">星期三</option>
                        <option value="星期四">星期四</option>
                        <option value="星期五">星期五</option>
                        <option value="星期六">星期六</option>
                        <option value="星期天">星期天</option>
                                    </select>
                   <input type="text" class="form-control" name="time1" id="time1"style="width:90px;" placeholder="开门时间" onclick="WdatePicker({dateFmt:'HH:mm'});" onblur="validatelegalName('time1');" >
                   <span class="message" >开门时间不能为空[]</span>
                      <span class="messageShow"></span>
                        —
                    <input type="text" class="form-control"  name="time2" id="time2" style="width:90px;" placeholder="关门时间" onclick="WdatePicker({dateFmt:'HH:mm'});" onblur="validatelegalName('time2');">
                    <span class="message" >关门时间不能为空[]</span>
                      <span class="messageShow"></span>
                                    </div>
	        	</td>
	        	</tr>
	        	<tr>
	        	  <td align="right">注册资本（万）：</td>
	        	  <td> <input id="regCapital" name="regCapital" type="text" value="${key.regCapital }" class="form-control" onblur="validateMileage('regCapital');" placeholder="200（万）"/>
	        	         <span class="message" >请输入数字部门[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">经营范围：</td>
	        	  <td>
                  <textarea name="busScope" id="editor" class="form-control" style="width:100%;" rows="5" onblur="validatelegalName('editor');"
                     > ${key.busScope }</textarea>
					  <span class="message" >经营范围不能为空[]</span>
                      <span class="messageShow"></span>
				  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">公司所在地：</td>
	        	  <td>
				<div class="form-inline">
                     <select name="province" id="province-box" class="form-control" style="width: 138px;">
                          <option value="${key.province }">${key.provinceName }</option>
                     </select>
                     <select name="city" id="city-box" class="form-control" style="width: 138px;">
                          <option value="${key.city }">${key.cityName }</option>
                     </select>
                     <select name="region" id="area-box" class="form-control" style="width: 138px;">
                        <option value="${key.region }">${key.regionName }</option>
                     </select>
                 </div>
					 
				  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">公司详细地址：</td>
	        	  <td> <input  name="address2" id="address2" value="${key.address}" type="text" class="form-control" onblur="validatelegalName('address2');"/>
	        	   <span class="message" >详细地址不能为空[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	 
	        	</tr>
	        	<tr>
	        	  <td align="right">公司电话：</td>
	        	  <td> <input id="tel" name="tel" value="${key.tel }" type="text" class="form-control" />
	        	     <span class="message" >公司电话格式不正确[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">公司紧急联系人：</td>
	        	   <td> <input id="urgentUser" name="urgentUser" type="text"  value="${key.urgentUser }" class="form-control" onblur="validatelegalName('urgentUser');"/>
	        	          <span class="message" >紧急联系人不能为空[]</span>
                      <span class="messageShow"></span>
	        	   </td>
	        	   
	        	</tr>
	        	<tr>
	        	  <td align="right">公司紧急联系人手机：</td>
	        	  <td> <input id="urgentTel" name="urgentTel" type="text" value="${key.urgentTel }" class="form-control" />
	        	     <span class="message" >联系人手机格式不正确[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	</tr>
	        	<tr>
	        	<td align="right"><strong>组织机构代码证</strong></td>
	        	</tr>
	        	
	        	<tr>
	        	  <td align="right">组织机构代码：</td>
	        	  <td> <input id="organizationNo" name="organizationNo" value="${key.organizationNo }" type="text" class="form-control" onblur="validatelegalName('organizationNo');"/>
	        	     <span class="message" >组织机构代码不能为空[]</span>
                      <span class="messageShow"></span>
	        	  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">代码有效期限：</td>
	        	<td><input id="orgDeadline" name="orgDeadline" type="text" value="${key.orgDeadline }" class="form-control" onclick="new Calendar().show(this);" onmousemove="validatelegalName('orgDeadline');"/>
	        	   <span class="message" >代码有效期限不能为空[]</span>
                      <span class="messageShow"></span>
	        	 </td>
	        	</tr>
	      	
	        	<tr>
	        	  <td align="right">代码电子版：</td>
	        	  <td>
	        	   <div class="col-sm-10">
	        	        <a href="javascript:;" id="upload-full-img2" class="btn btn-primary"><img alt="" src="<%=basePath %>html/img/moren-upload.png">请选择要上传的图像</a>
	        	        </div>
	        	  </td>
	        	</tr>
	        	<tr>
	        	<td  align="right">	</td>
	        	<td>
	     		   <div class="idCarBox1" id="">
	     		    <div class="col-sm-10" id="showImg2">
                       <img id="litpic6" style="width:150px;height:150px;" src="${key.orgPicture }" alt="">
                         </div>
	     		   </div>
	     		   </td>
	        	</tr>
	        	
	        	</table>
	        
  				</div>
	        </div>
	   		<div id="card1"><input type="hidden" name="businessLicence" id="businessLicence" value=""></div>
  				<div id="card2"><input type="hidden" name="orgPicture" id="orgPicture" value=""></div>
  				
	        </form>
	        </div>
	        <div id="pic">
	          <div id="pic1"><img src="<%=basePath%>html/img/join/car_02.jpg"/></div>
	          <div id="pic2"><img src="<%=basePath%>html/img/join/car_03.jpg"/></div>
	          <div id="button">
		           <button id="lastButton" type="button" class="btn btn-warning" onclick="javascript:history.go(-1);">上一步</button>
		           <button id="nextButton" type="button" class="btn btn-primary" onclick="nextFun2('<%=basePath%>');" >下一步</button>
	       	    </div>
	        </div>
	    </div>
          <div id="line" style="color:#499ad9"> </div>
    </div>     
  <%@ include file="../public/foot.jsp"%>
   <script>
 function nextFun3(url) {
  var idCardfront = document.getElementById("businessLicence").value;
 	var idCardverso = document.getElementById("orgPicture").value;
	var check = true;
 	if (!validatelegalName('companyName')) {
		check = false;
	}
	
	if (!validatelegalName('businessLicenceNo')) {
		check = false;
	}

	if (!validatelegalName('licenceAddress')) {
		check = false;
	}

	if (!validatelegalName('buildDate')) {
		check = false;
	}
	if (!validatelegalName('time1')) {
		check = false;
	}
	if (!validatelegalName('time2')) {
		check = false;
	}
	if (!validatelegalName('regCapital')) {
		check = false;
	}
	if (!validatelegalName('editor')) {
		check = false;
	}
	if (!validatelegalName('address2')) {
		check = false;
	}
	/* if (!validatelegalTel('tel')) {
		check = false;
	} */
	if (!validatelegalName('urgentUser')) {
		check = false;
	}
	if (!validatelegalTel('urgentTel')) {
		check = false;
	}
	if (!validatelegalName('organizationNo')) {
		check = false;  
	}
	if (!validatelegalName('orgDeadline')) {
		check = false;
	}
 	if (idCardfront == "") {
		$('#showImg1').html("请上传图像！").css({"color":"red"});
		check = false;
	}
	if (idCardverso == "") {
		$('#showImg2').html("请上传图像！").css({"color":"red"});
		check = false;
	}
	if (check == false) {
 		return;
	}
 	document.form1.action = url + "join/detailInfo";
	document.form1.submit();
}
 </script> 
<script>
    var bufferdata1 = "";
    var bufferdata2 = "";
	var buffer = ""; 
     KindEditor.ready(function(K) {
      
        
     var editor1 = K.editor({
      	 uploadJson : '<%=uploadUrl%>?root=demo-basic-businessLicence',
         allowFileManager : true
    });
     var editor2 = K.editor({
      	 uploadJson : '<%=uploadUrl%>?root=demo-basic-orgPicture',
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
                       document.getElementById("businessLicence").value=bufferdata1;
                        
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
        editor2.loadPlugin('multiimage', function() {
            editor2.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata2=data.url;
                          document.getElementById("orgPicture").value=bufferdata2;
                       var objRow = document.getElementById("showImg2"); 
                           var  img="";
                             objRow.innerHTML=img;
                        $('#showImg2').append('<img id="litpic6" style="width:150px;height:150px;" src="' + data.url + '">');
                        var b = document.getElementById("litpic6").src; 
                     });
                     editor2.hideDialog();
                     
                  }
            });
        });
    });
 });
 distSelect("<%=basePath%>");
 var provinces=document.getElementById("provinces2").value;

 var service="${key.serviceTime}";
 var arr1=service.substring(0,3);
 var arr2=service.substring(4,7);
  var arr3=service.substring(8,13);
  var arr4=service.substring(15,20);
$("#province-box option[value='" + provinces + "'] ").attr("selected",
				true);
				
$("#week1 option[value='" + arr1 + "'] ").attr("selected",
				true);
$("#week2 option[value='" + arr2 + "'] ").attr("selected",
				true);
document.getElementById("time1").value=arr3;
document.getElementById("time2").value=arr4;
</script>