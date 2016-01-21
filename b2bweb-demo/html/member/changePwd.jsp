<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../public/head3.jsp" %>
<script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
<style>
.form-group label{
font-weight: normal;
}
.btn-primary{
background-color: #3071A9;
border-color: #285E8E;
width: 60px;
}
.btn-primary:hover{
color: white;
background-color: #00A9FF;
border-color: #029ae8;
height: 34px;
}
</style>
        <div class="container-fluid">
            <div class="row">
                <%--<%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-xs-12 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                             <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">修改密码
                        </li>
                       
                    </ol>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" method="post"  action="">
                                <div class="form-group">
                                         <label class="col-sm-4 control-label" style="margin-left: -20px;">登陆账号</label>
                                        <div class="col-sm-8 form-inline" >
                                            <input type="tel" class="form-control" name="userName" value="${userName}" disabled="disabled" id="userName" placeholder="请输入账号">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                         <label class="col-sm-4 control-label">旧密码&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
                                        <div class="col-sm-8 form-inline" style="margin-left: -20px;">
                                            <input type="password" class="form-control" name="oldPassword" value="" id="oldPassword" placeholder="请输入旧密码"onblur="validatelegalName('oldPassword');" onkeyup="passWordConfirm();" onpaste="return false">
                                 <span class="message" >旧密码不能为空！[]</span>
                   								 <span class="messageShow" ></span>
                   								 <div   id="passWordExist" style="padding-left: 20%;color: red;"></div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">新密码&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
                                        <div class="col-sm-8 form-inline" style="margin-left: -20px;">
                                            <input type="password" class="form-control" name="newPassword" value=""  id="newPassword" placeholder="请输入新密码"onblur="validatelegalName('newPassword');" maxlength="60">
                                 <span class="message" >新密码不能为空！[]</span>
                   								 <span class="messageShow" ></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">确认密码&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span></label>
                                        <div class="col-sm-8 form-inline" style="margin-left: -20px;">
                                            <input type="password" class="form-control" name="confirmPassword" value="" id="confirmPassword" placeholder="请再次输入新密码"onblur="validateRepasswd('confirmPassword');" maxlength="60">
                                 <span class="message" >确认密码与密码不一致！[]</span>
                   								 <span class="messageShow" ></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-4 col-sm-8">
                                            <button type="button" class="btn btn-primary" onclick="javascript:updatePassWordList();"> 修改</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <%@ include file="../public/footer.jsp" %>
        
<script type="text/javascript">
document.getElementById("oldPassword").value="";
 var passwordCheck=true;
 function updatePassWordList(){
 
    var userName=document.getElementById("userName").value;
    var oldPassword=document.getElementById("oldPassword").value;
    var newPassword=document.getElementById("newPassword").value;
    var confirmPassword=document.getElementById("confirmPassword").value;
         var check = true; 
     if (!validatelegalName('oldPassword')) {
		check = false;
	}
	 if (!validatelegalName('newPassword')) {
		check = false;
	}
	if (!validateRepasswd('confirmPassword')) {
		check = false;
	}
	if(passwordCheck==false){
	   check=false;
	}
      if(check==true){
  		 
    		$.ajax({
            type: "POST",
            data:{'userName':userName,'oldPassword':oldPassword,'newPassword':newPassword,'confirmPassword':confirmPassword},
            url: "<%=basePath%>member/updatePassWordList",
            dataType: "html",
            success: function(data){ 
             alert("密码修改成功，点击确定重新登陆");
              window.location.href="<%=basePath%>pei/logout";
             
            },
            error: function() {
                alert("发送失败");
            }
        });	
    

     } 

  		}
  		function passWordConfirm(){
   	 var userName2=document.getElementById("userName").value;
  	 var oldPassword2=document.getElementById("oldPassword").value;
  	 //alert("userName2:"+userName2);
  	 //alert("oldPassword2:"+oldPassword2);
     $.ajax({
            type: "POST",
            data:{'userName':userName2,'oldPassword':oldPassword2},
            url: "<%=basePath%>member/passwordExist",
            dataType: "html",
            success: function(data){ 
                var content="旧密码错误！";
	      		if(data=="1"){
			       document.getElementById("passWordExist").innerHTML=content;
			       passwordCheck=false;
		 	     }
		 	     if(data=="0"){
		 	       document.getElementById("passWordExist").innerHTML="";
		 	       passwordCheck=true;
		 	     }
             },
            error: function() {
                alert("发送失败");
            }
        });	
}
</script>        