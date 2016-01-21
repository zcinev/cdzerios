<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../public/mchead.jsp"%>

<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 #detail-address{
 margin-top: 6px;
 }
 #address{
 margin-top: 5px;
 }
</style>
  <div class="container-fluid">
            <div class="row">
                <%@ include file="../public/centerSidebar.jsp" %>
                    <div class="col-xs-10 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading"><a href="#">修改密码</a>
                            </div>
                            <div class="panel-body">
                                <form  class="form-horizontal" method="post"  >
                                <div class="form-group">
                                         <label class="col-sm-4 control-label">登陆账号</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="tel" class="form-control" name="userName" value="${userName}"  id="userName" placeholder="请输入账号" readonly="readonly">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                         <label class="col-sm-4 control-label">旧密码</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="password" class="form-control" placeholder="旧密码" name="oldPassword" value="" id="oldPassword" onblur="validatePassword('oldPassword');">
                                 <span class="message" >旧密码不能为空！[]密码不正确</span>
                   								 <span class="messageShow" ></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">新密码</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="password" class="form-control" name="newPassword" value=""  id="newPassword" placeholder="请输入新密码"  onchange="isPasswordOk()">
                                 <span class="message" >密码长度不能小于6！[]</span>
                   								 <span class="messageShow" ></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">确认密码</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="password" class="form-control" name="confirmPassword" value="" id="confirmPassword" placeholder="请再次输入新密码" onBlur="comfirmPwd()">
                                 <span class="message" >密码不能为空！[]确认密码与密码不一致!</span>
                   								 <span class="messageShow" ></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-4 col-sm-8">
                                            <button type="button" class="btn btn-warning" onclick="updatePassWordList()">确认修改</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <%@ include file="../public/foot.jsp" %>
  
        
<script>
$('#oldPassword').val("");
  function updatePassWordList(){
     var userName=document.getElementById("userName").value;
     var oldPassword=document.getElementById("oldPassword").value;
     var newPassword=document.getElementById("newPassword").value;
    var check=true;
    var confirmPassword=document.getElementById("confirmPassword").value;
 
     if(validatePassword('oldPassword')==false){
     	check=false;
    }
    if(!isPasswordOk02()){ 
    	check=false;
    }
    if(!comfirmPwd()){ 
    	check=false;
    }
    if(check==false){
    	return;
    }
    if(check==true){
    $.ajax({
            type: "POST",
            data:{'userName':userName,'oldPassword':oldPassword,'newPassword':newPassword,'confirmPassword':confirmPassword},
            url: "<%=basePathpj%>person/updatePassWordList",
            dataType: "html",
            success: function(data){ 
              alert("密码修改成功，点击确定重新登陆");
             window.location.href="<%=basePath%>pei/logout";
             
            },
            error: function(data) {
            	
            }
        });	 
		   }

	}
	
	
	function isPasswordOk() {
	$("#confirmPassword").val("");
	var _this=document.getElementById("newPassword");
	
	if(!fun2(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
}
function isPasswordOk02() {
	 
	var _this=document.getElementById("newPassword");
	
	if(!fun2(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
}	
	
function fun2(thisElem){
		var message = $(thisElem).next().text();
        if($(thisElem).val().length < 6) {
            $(thisElem).next().next().text(message.split('[]')[0]);
            return false;
        } else {
           $(thisElem).next().next().text("");
            return true;
        }
}



function validatePassword(thisEle){
var  url="<%=basePathpj%>";
 	var _this=document.getElementById(thisEle);
 	var kvalue=$('#oldPassword').val();
 	var message = $(_this).next().text();
 	
 	if(kvalue==null||kvalue.length==0){
 		$(_this).next().next().text(message.split('[]')[0]);
 		return false;
	} else{
  	$.ajax({
        type: "POST",
        data:{'kvalue':kvalue},
        url: url+"person/validatePassword",
        dataType: "json",
        success: function(data){ 
        	if(data.info=="0"){
        	
        		$(_this).next().next().text(message.split('[]')[1]);
        		return false;
        	}else{ 
        		$(_this).next().next().text("");
        		return true;
        	}
        },
        error: function(data) {
        	$(_this).next().next().text(message.split('[]')[1]);
        	return false;
        }
    });
 	
	}	
}


function comfirmPwd() {
	var _this=document.getElementById("confirmPassword");
	if(!fun3(_this)){ 
 		return false;
	} else{
	 
 	return 	true;
 
	}
}


function fun3(thisElem){
	var message = $(thisElem).next().text();
        if($(thisElem).val() != $('#newPassword').val()) {
           	$(thisElem).next().next().text(message.split('[]')[1]); 
            return false;
        } else {
        if($(thisElem).val() == '') {
           	$(thisElem).next().next().text(message.split('[]')[0]); 
            return false;
        } else {
          	$(thisElem).next().next().text(""); 
            return true;
        }
        }
}


</script>        