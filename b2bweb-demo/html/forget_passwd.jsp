<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/header.jsp"%>
 <style>
 #newreg{
background-color:#ff9100;border-color: #ed8802;width: 80px;
} 

 #newreg:hover{
background-color:#EFA84C;
}
#quren{
 background-color: #ededed;
    background-image: linear-gradient(#fff, #e4e3e3);
    border: 1px solid #b1b1b1;
    color:#746D6D;
    font-family: "宋体";
    height:20px;
    height: auto;
    font-size:12px;
    line-height: 20px;
}
#valid_form label{
color:#6d6d6d;
}
 </style>
<script src="<%=basePath%>html/js/vaildateform.js" type="text/javascript"></script>
<script src="<%=basePath%>html/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/validate.js"></script>
<div class="container-fluid">
    <div class="row">
    <div style="  background: none repeat scroll 0 0 #ffffff; border: 6px solid #e1e1e1; height: 360px;border-radius:5px;">
        <div class="panel panel-primary" style="border-color: #C8E5FF ;border-width: 2px;">
            <div class="panel-heading" style="border: none;background: transparent;padding-left:20px;padding-top:15px;">
                <h3 class="panel-title" style="color: #353535;font-weight: bold;">修改密码</h3>
            </div>
            <div class="panel-body paddingLeft0 paddingRight0" style="margin-top:-12px;">
                <div class="col-md-5 pull-left" style="margin-right:-3px;">
                    <div class="thumbnail" style="border:none;margin-bottom:0;padding-bottom:0;">
                    	<div id="centerMsg"><img alt="" src="<%=basePath%>html/img/login_user_03.png" ></div>
                        <%-- <%@ include file="./public/baidu2.jsp"%> --%>
                    </div>
                </div>
                <div class="col-md-6 pull-right">
                    <form  onsubmit="return checkInput();" class="form-horizontal" id="valid_form" role="form" action="<%=basePath%>pei/forgetPasswd" method="post" >
                        <div class="form-group">
                            <label for="telphone" class="col-sm-2 control-label" style="font-weight: normal;">用户名</label>
                            <div class="col-sm-5">
                                <input type="tel" name="telphone"  maxlength="19" class="form-control" id="telphone" placeholder="手机号" onmouseout="isTelphoneOrEmail();" onmousemove="isTelphoneOrEmail();" >
                            </div>
                            <div class="col-sm-5 help-block" id="help-block-tel-id">
                                <p class="text-info" style="color: #00a9ff;">请输入手机号码(邮箱)！</p>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="inputPassword3" class="col-sm-2 control-label" style="font-weight: normal;" >验证码</label>
                            <div class="col-sm-5">
                                <input type="text" name="verifyCode" class="form-control" id="inputPassword3" placeholder="验证码" onblur="javascript:VerifyList();">
                            </div>
                            <div class="col-sm-5 help-block">
                              <button type="button" class="btn btn-default text-info" style="background-color:#428bca;width: 100px;" id="quren" onclick="javascript:confrimPassWord333(this);">获取验证码</button>
                            <span id="verifyCodeId"  style="color:#00a9ff; ">60秒之内有效!</span>
                            </div> 
                            </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label" style="font-weight: normal;">新密码</label>
                            <div class="col-sm-5">
                                <input type="password" name="password" onKeyUp="isPasswordOk()" onBlur="isPasswordOk()" class="form-control" id="password" placeholder="新密码">
                            </div>
                            <div class="col-sm-5 help-block">
                                <p class="text-info" style="color: #00a9ff;">请输入不少于6位的密码！</p>
                            </div>
                        </div> 
                       
                       
                       <div class="form-group">
                            <label for="confirm-Pwd" class="col-sm-2 control-label" style="font-weight: normal;">确认密码</label>
                            <div class="col-sm-5">
                                <input type="password" name="repassword" class="form-control" id="confirm-Pwd" placeholder="确认密码" onBlur="comfirmPwd()" >
                            </div>
                            <div class="col-sm-5 help-block">
                                <p class="text-info" style="color: #00a9ff;">请再次输入您的密码！</p>
                            </div>
                        </div>  
                         
                       
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10" id="main">
                                <button type="submit" class="btn btn-primary"  style="width: 80px;">确认</button>
                                <button type="button" class="btn btn-primary" id="newreg" onclick="javascript:window.location.href='<%=basePath%>html/login.jsp'">取消</button>
                             </div>
                        </div>
               </form>
                </div>
               
            </div>
        </div>
      </div>  
    </div>
</div>

<%@ include file="./public/logoutfoot.jsp"%>

<script>
	$(document).ready(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
        var _this = $(this);
        var dat="";
        $.ajax({
            type: "POST",
            url: "<%=basePath%>pei/getUrl",
            async:false,
            dataType: "html",
            success: function(data) {
            dat=data;
            },
            error: function() {
            _this.text('请求失败');
            }
        });
	      
		function successback(data){
			$.ajax({
				type: "POST",
				url: "<%=basePath%>pei/getPartCenter",
				data: {data:data},
				async:false,
				dataType: "html",
				success: function(dat) {
					var coord=dat.split("+")[1];
					getBaidu(coord);
					var centerMsgs=dat.split("+")[2];
					document.getElementById("centerMsg").innerHTML=centerMsgs;
				},
				error: function() {
				    _this.text('发送失败');
				}
			});	
		}
		    
		function errorback(){ 
			alert("失败");
		}  
		     });
		 
    
</script>

<script>
 var verify="";
 var telphone = document.getElementById("telphone");
 var password = document.getElementById("password");
 var repasswd=document.getElementById("confirm-Pwd");
 var yanzhengma= document.getElementById("inputPassword3");
 
 
/*  function isTelphone() {
    $('#telphone').blur(function() {
        if ($(this).val().search(/^(((1(3|5|8)[0-9]{1})|(15[0-9]{1}))+\d{8})$/) != -1) {
            $(this).closest('.form-group').find('.text-info').text('输入正确!').css({
                "color": "#00a9ff"
            });
            return true;
        } else {
            $(this).closest('.form-group').find('.text-info').text('请填写正确的手机号码!').css({
                "color": "#ff9100"
            });
            return false;
        }
    });
} */
 
function checkInput(){
var  message="";
var tel="";

if(verify==0){
	return false;
};
 $.ajax({
            type: "POST", 
            data:{telphone:telphone.value},
            url: "<%=basePath%>pei/vaTel",
            async:false,
            dataType: "html",
            success: function(data) {
              if(data=="账户不存在"){
                 alert(data);
              }else{
               tel=data;
              }
                
              },
            error: function() {
            alert('请求失败');
            }
        });	
        if(password.value!=repasswd.value){
 			    return false; 
		  }
		   if(telphone.value==""){
 			    return false; 
		  }
		   if(tel==""){
 			    return false; 
		  }
         
		  return true;
} 
 
  var time=0;
  
  
 function confrimPassWord333(thisEle){
       var telphoneNumber=document.getElementById("telphone").value;
       var TelTest=/^(((1(3|5|8)[0-9]{1})|(15[0-9]{1}))+\d{8})$/;
       var emialTest =/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
        if(time==0){
        if(TelTest.test(telphoneNumber)||emialTest.test(telphoneNumber)){//发送验证码先判断一下 
        var url="<%=basePath%>passWord/userPassWordMobile";
        if(telphoneNumber.indexOf("@qq.com")>=0){
        	url="<%=basePath%>passWord/checkNameId";
        }
      $.ajax({
            type: "POST",
            url: url,
            data: {mobile:telphone.value,flag:"2"},
            dataType: "html",
            success: function(data) {
            	
                  thisEle.innerHTML='60秒后重新发送';
                var wait = 60;
              thisEle.innerHTML=wait + '秒后重新发送';
                var interval = setInterval(function() {
                      time = --wait;
                    thisEle.innerHTML=time + '秒后重新发送';
                    if (time <= 0) {
                          thisEle.innerHTML='获取校验码';
                        clearInterval(interval);
                    };
                }, 1000);  
            },
            error: function() {
                _this.text('发送失败');
            }
        });
         }else{
         var telSTr="<p class='text-info' style='color: red;'>请输入正确的手机号码！</p>";
       document.getElementById("help-block-tel-id").innerHTML=telSTr;
        }
        }
   }
 
 function  VerifyList(){	
 var tdata=0;	
 
  if(yanzhengma.value=="" ){
  	verify=0;
	var TJ="请输入验证码";
	document.getElementById("verifyCodeId").innerHTML="<span id='verifyCodeId'  style='color:#ff9100; '>"+TJ+"</span>" ;
 	 return false;  
 	 }else{
 	 	$.ajax({
            type: "POST", 
            data:{code:yanzhengma.value},
            url: "<%=basePath%>passWord/isValidCode",
            async:false,
            dataType: "json",
            success: function(data) {
            	tdata=data.info;
              },
            error: function() {
            alert('请求失败');
            }
        });	
 	 	if(tdata==0){
 	 		verify=0;
 	 	 	 var Ts="验证码错误！"; 
		     document.getElementById("verifyCodeId").innerHTML="<span id='verifyCodeId'  style='color:#ff9100; '>"+Ts+"</span>" ;
		      return false;
 	 	}else{
 	 		verify=1;
 	 		 var TJ="输入正确！";
			 document.getElementById("verifyCodeId").innerHTML="<span id='verifyCodeId'  style='color:#00a9ff; '>"+TJ+"</span>" ;
 		    return true;  
 	 	}
 	 }
	
}
      

</script>
