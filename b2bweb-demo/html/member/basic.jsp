<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/head3.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
<script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
/* 验证样式 */
.message {
	display: none;
}

.messageLabel {
	color: red;
}

.messageShow {
	font-size: 10px;
	color: red;
}
</style>
<!--[if lte IE 9]>
        <style type="text/css">
            #face-img {
                filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
            }
        </style>
        <![endif]-->
<style>
.form-group label {
	font-weight: normal;
	color: #454545;
}

.btn-primary:hover {
	color: white;
	background-color: #00A9FF;
	border-color: #029ae8;
}

.btn-primary {
	background-color: #428bca;
}

#upload-full-img {
	width: 160px;
	border-radius: 3px;
	background-color: #ededed;
	background-image: linear-gradient(#fff, #e4e3e3);
	border: 1px solid #b1b1b1;
	color: #746D6D;
	font-family: "宋体";
	height: 27px;
	font-size: 12px;
	line-height: 15px;
	text-align: center;
}

#btn-5{
	background-color:#3071A9;
	/* background-image: linear-gradient(to top, #f5fbef 0px, #eaf6e2 100%); */
	border: 1px solid #285E8E;
	border-radius: 2px;
	color: #fff;
	display: inline-block;
	height: 30px;
	line-height: 18px;
	padding: 2px 14px 3px;
}

</style>
<div class="container-fluid">
	<div class="row">
		<%--<%@ include file="../public/memberSidebar.jsp"%>
		--%><div class="col-xs-12 paddingLeft0 paddingRight0">
			<div class="panel panel-default">
				<div class="panel-heading"
					style="background-color: #ecf9ff;border-color: #ddd;">
					<!-- <a href="#">个人资料</a> -->
					<ol class="breadcrumb bottom-spacing-0">
						<li class="active">个人资料</li>
					</ol>
				</div>
				<div class="panel-body">
					<ul class="nav nav-tabs" role="tablist">
						<li class="active"><a href="#basic" role="tab"
							data-toggle="tab">基本资料</a></li>
						<!--   
						<li><a href="#profile" role="tab" data-toggle="tab">扩展资料</a>
						</li>
					 
						<li><a href="#contact" role="tab" data-toggle="tab">联系信息</a>
						</li>
						-->
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="basic">
							<div style="margin-top:10px;">
							</div>
							<form action="" class="form-horizontal" method="post" role="form">
								<c:forEach var="mkey" items="${key}">
									<div class="form-group">
										<label for="" class="col-sm-2 control-label">头像</label>
										<div class="col-sm-10">
											<a href="javascript:;" id="upload-full-img"
												class="btn btn-primary"><img alt=""
												src="<%=basePath%>html/img/moren-upload.png">请选择要上传的头像</a>
										</div>

									</div>
									<div style="padding-left:140px;margin-top: -5px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>
									<div class="form-group" style="margin-top: 5px;">
										<label class="col-sm-2 control-label"></label>
										<div class="col-sm-10" id="showImg1">
											<c:if test="${mkey['faceImg']!=''}">
												<img id="faceImgId" src="${mkey['faceImg']}" width="150"
													height="150" alt="请上传头像!">
											</c:if>
											<c:if test="${mkey['faceImg']==''}">
												<img id="faceImgId" src="<%=basePathpj%>html/img/1.jpg"
													width="150" height="150" alt="请上传头像!">
											</c:if>
										</div>
									</div>
									<div class="form-group">

										<input id="provinceid" name="provinceid" type="hidden"
											value="${mkey['province']}" /> <input id="cityid"
											name="cityid" type="hidden" value="${mkey['city']}" /> <input
											id="regionid" name="regionid" type="hidden"
											value="${mkey['region']}" /> <input id="id" name="id"
											type="hidden" value="${mkey['id']}" /> <label
											class="col-sm-2 control-label"><span
											style="color: red;">*&nbsp;</span>真实姓名</label>
										<div class="col-sm-10 form-inline">
											<input type="text" class="form-control" name="name" id="name"
												value="${mkey['name']}" placeholder="真实姓名"
												onblur="validatelegalName('name')" maxlength="32"> <span
												class="message">真实姓名不能为空[]</span> <span class="messageShow"></span>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><span
											style="color: red;">*&nbsp;</span>性别</label>
										<div class="col-sm-10 form-inline">
											<c:if test="${mkey['sex']=='1'}">
												<label for="sex1" class="control-label"> <input
													type="radio" name="sex" id="sex" value="1" checked>
													男
												</label>
												<label for="sex2" class="control-label"> <input
													type="radio" name="sex" id="sex" value="0"> 女
												</label>
											</c:if>
											<c:if test="${mkey['sex']=='0'}">
												<label for="sex1" class="control-label"> <input
													type="radio" name="sex" id="sex" value="1"> 男
												</label>
												<label for="sex2" class="control-label"> <input
													type="radio" name="sex" id="sex" value="0" checked>
													女
												</label>
											</c:if>
											<c:if test="${mkey['sex']==''}">
												<label for="sex1" class="control-label"> <input
													type="radio" name="sex" id="sex" value="1"> 男
												</label>
												<label for="sex2" class="control-label"> <input
													type="radio" name="sex" id="sex" value="0"> 女
												</label>
											</c:if>
											<c:if test="${mkey['sex']=='null'}">
												<label for="sex1" class="control-label"> <input
													type="radio" name="sex" id="sex" value="1"> 男
												</label>
												<label for="sex2" class="control-label"> <input
													type="radio" name="sex" id="sex" value="0"> 女
												</label>
											</c:if>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><span
											style="color: red;">*&nbsp;</span>出生日期</label>
										<div class="col-sm-10 form-inline">
											<input type="text" class="form-control" name="birthday"
												value="${mkey['birthday']}" placeholder="点击选择"
												onclick="new Calendar().show(this);" id="birthday"
												placeholder="出生日期" onmousemove="validatelegalName('birthday');" maxlength="32">
											<span class="message">出生日期不能为空[]</span> <span
												class="messageShow"></span>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><span
											style="color: red;">*&nbsp;</span>手机号码</label>
										<div class="col-sm-10 form-inline">
											<c:if test="${mkey['tel']!=''}">
												<input type="tel" class="form-control"
													value="${mkey['tel']}" name="telphone" id="telphone"
													placeholder="手机号码" readonly="readonly"
													onblur="validatelegalTel('telphone');">
												<span class="message">手机号码格式不正确！[]</span>
												<span class="messageShow"></span>
											</c:if>
											<c:if test="${mkey['tel']==''}">
												<input type="tel" class="form-control" value=""
													name="telphone" id="telphone" placeholder="手机号码"
													onblur="validatelegalTel('telphone');">
												<span class="message">手机号码格式不正确！[]</span>
												<span class="messageShow"></span>
											</c:if>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">QQ号码</label>
										<div class="col-sm-10 form-inline">
											<input type="tel" class="form-control" name="QQ" id="QQ"
												value="${mkey['qq']}" placeholder="QQ号码"
												onblur="validatelegalName('QQ');" maxlength="16"> <span
												class="message">QQ号码不能为空！[]</span> <span
												class="messageShow"></span>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">Email</label>
										<div class="col-sm-10 form-inline">
											<input type="email" class="form-control" name="Email"
												id="Email" value="${mkey['email']}" placeholder="Email"
												onblur="validatelegalEmail('Email');" maxlength="32"> <span
												class="message">邮箱格式不正确[]</span> <span class="messageShow"></span>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><span
											style="color: red;">*&nbsp;</span>居住地</label>
										<div class="col-sm-10 form-inline">
											<select name="province" id="province-box"
												class="form-control">
											</select> <select name="city" id="city-box" class="form-control">
											</select> <select name="area" id="area-box" class="form-control">
											</select> <input class="form-control" type="text"
												value="${mkey['address']}" id="addressId" name="addressId"
												placeholder="请输入详细地址"
												onblur="validatelegalName('addressId');" maxlength="100"> <span
												class="message">详细地址不能为空[]</span> <span class="messageShow"></span>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">其他信息</label>
										<div class="col-sm-6">
											<textarea name="remarkTest" id="remarkTest"
												class="form-control" rows="10" placeholder="其他信息" maxlength="200">${mkey['backup']}</textarea>
										</div>
									</div>

									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-10">
											<button type="button" class="btn btn-warning"
												onclick="javascript:ImgTestList();" id="btn-5">保存</button>

										</div>
									</div>
									<div id="card1">
										<input type="hidden" name="faceImg" id="faceImg"
											value="${mkey['faceImg']}">
									</div>
								</c:forEach>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
<%@ include file="../public/foot.jsp"%>
<script charset="utf-8"
	src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8"
	src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script>
     $(function () {
        distSelect("<%=basePath%>");
        detailAddress("<%=basePath%>");
         var province=document.all('provinceid').value;
          
         var city=document. all('cityid').value;
        var region=document.all('regionid').value;
        
          setDefaultValue("<%=basePath%>", province, city, region);
	});
</script>
<script>
    var bufferdata = "";
	var buffer = ""; 
     KindEditor.ready(function(K) {
      
        
     var editor1 = K.editor({

     	uploadJson : '<%=uploadUrl%>?root=demo-basic-faceImg',
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
                        bufferdata=data.url;
                         document.getElementById("faceImg").value=bufferdata;
                         
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
 });
 
</script>
<script type="text/javascript">
$('input').iCheck('destroy');
function  ImgTestList(){
    
var faceImgId = document.getElementById("faceImg");

var name = document.getElementById("name");
var birthday = document.getElementById("birthday");
var telphone = document.getElementById("telphone");
var QQ = document.getElementById("QQ");
var Email = document.getElementById("Email");
var addressId = document.getElementById("addressId");
	       
	  
	 
   var  a="";
    var list=document.getElementById("litpic5");
        
      if(list != null){
          a = document.getElementById("litpic5").src;
         
      } else{
          a=document.getElementById("faceImgId").src;
           
      }
       var idCardfront = document.getElementById("faceImg").value;
     var check = true;
	if (!validatelegalName('name')) {
		check = false;
	}  
	if (!validatelegalName('birthday')) {
		check = false;
	}  
	if (!validatelegalTel('telphone')) {
		check = false;
	}   
	if (!validatelegalName('QQ')) {
		check = false;
	} 
	if (!validatelegalEmail('Email')) {
		check = false;
	}  
	if (!validatelegalName('addressId')) {
		check = false;
	}    
	  
	if (idCardfront == "" ) {
		$('#showImg1').html("请上传图像！").css({"color":"red"});
		check = false;
	}
	if (check == true) {
    $.ajax({
            type: "POST", 
            data:{remarkTest:$('#remarkTest').val(),addressId:$('#addressId').val(),id:$('#id').val(),regionid:$('#area-box').val(),cityid:$('#city-box').val(),provinceid:$('#province-box').val(),name:$('#name').val(),sex:$("input[name='sex']:checked").val(),birthday:$('#birthday').val(),telphone:$('#telphone').val(),faceImg:idCardfront,QQ:$('#QQ').val(),Email:$('#Email').val()},
            url: "<%=basePath%>member/updateUserBasicInformationTest",
            async:false,
            dataType: "html",
            success: function(data) {
              alert("修改成功!");
             
                 window.location.href="<%=basePath%>member/memberCenter";

				},
				error : function() {
					_this.text('请求失败');
				}
			});
		}
	}
</script>
<script>
	
</script>
