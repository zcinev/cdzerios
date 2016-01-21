<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.session.*"%> 
<%@ include file="./public/header.jsp"%>
<%
SessionService sessionService = new BccSession();
%>
<script type="text/javascript">
	var userIdSer= "<%=sessionService.getAttribute(request, "id")%>";
	var userAgg = "<%=session.getAttribute("userName")%>";
	if(userAgg!="null"&&userAgg!=null&&userAgg!=""){
		if(userIdSer!="null"&&userIdSer!=null&&userIdSer!=""){
			window.location.href="/b2bweb-demo/pei/loginComplete";
		}		
	}
</script>
<script src="<%=basePath%>html/js/vaildateform.js" type="text/javascript"></script>
<script src="<%=basePath%>html/jquery.min.js"></script>
 <style>
#newreg{
background-color:#ff9100;border-color: #ed8802;width: 80px;
}
#main a{
color:white;
}
 #main a:hover{
background-color:#EFA84C;
}
#forget a{
color:Red;

}

.btn-primary:hover{
color: white;
background-color: #00A9FF;
border-color: #029ae8;
}
.btn-primary{
background-color: #428bca;
}
</style>

<div class="container-fluid">

    <div class="row">
 <div style="  background: none repeat scroll 0 0 #ffffff; border: 6px solid #e1e1e1; height: 352px;border-radius:5px;">
        <div class="panel panel-primary" style="border-color: #C8E5FF ;border-width: 2px;">
            <div class="panel-heading" style="border: none;background: transparent;padding-left:20px;padding-top:15px;">
                <h3 class="panel-title" style="color: #353535;font-weight: bold;">会员登录</h3>
            </div>
           
            <div class="panel-body paddingLeft0 paddingRight0" style="margin-top:-12px;">
                <div class="col-md-5 pull-left" style="margin-right:-3px;">
                    <div class="thumbnail" style="border:none;margin-bottom:0;padding-bottom:0;">
                    	<div id="centerMsg"><img alt="" src="<%=basePath%>html/img/login_user_03.png" ></div>
                       <%--  <%@ include file="./public/baidu2.jsp"%>  --%>
                    </div>
                </div>
                <div class="col-md-6 pull-right" style="margin-top:6px;">
                    <form  onsubmit="return checkInput();" class="form-horizontal" id="valid_form" role="form" action="<%=basePath%>pei/login" method="post" name=form1>
                       
                       <input type="hidden" value=<%=request.getParameter("wxsId") %> id="wxsId" name="wxsId">
                       <input type="hidden" value=<%=request.getParameter("phenomenon1") %> id="phenomenon1" name="phenomenon1">
                       <input type="hidden" value=<%=request.getParameter("part1") %> id="part1" name="part1">
                       
                          <input type="hidden" value=<%=request.getParameter("rid") %> id="tid" name="tid">
                          
                        <input type="hidden" value=<%=request.getParameter("url") %> id="url" name="url">
                        
                        
                        <input type="hidden" value=<%=request.getParameter("flag") %> id="edit_flag" name="edit_flag">
                        <input type="hidden" value=<%=request.getParameter("tid") %> id="edit_tid" name="edit_tid">
                        <input type="hidden" value=<%=request.getParameter("relateId") %> id="edit_relateId" name="edit_relateId">
                            <input type="hidden" value=<%=request.getParameter("imgurl") %> id="edit_imgurl" name="edit_imgurl">
                            <input type="hidden" value=<%=request.getParameter("stag") %> id="edit_stag" name="edit_stag">
                            
                         <div class="form-group">
                            <label for="telphone" class="col-sm-2 control-label" style="font-weight: normal;color:#6d6d6d;">账&nbsp;&nbsp;&nbsp;号</label>
                            <div class="col-sm-5">
                                <input type="tel" name="telphone"  maxlength="30" class="form-control" id="telphone" placeholder="手机号或QQ邮箱" onblur="isTelehoneCheck();">
                           <div id="TelAndPass" style="margin-top: 5px;color: red;" > </div>
                            </div>
                           
                            <div class="col-sm-5 help-block">
                                <p class="text-info" style="color: #00a9ff ;">请输入手机号码或邮箱！</p>
                            </div>
                        </div>
                        <div class="form-group" style="margin-top: -8px;">
                             <label for="password" class="col-sm-2 control-label" style="font-weight: normal;color:#6d6d6d;padding-left:34px;">密&nbsp;&nbsp;&nbsp;码</label>
                            <div class="col-sm-5">
                                <input type="password" name="password" class="form-control" id="password" placeholder="密码" onblur="isPassWordCheck();">
                                 <div id="password_check" style="margin-top: 5px;color: red;" > </div>
                            </div>
                            <div class="col-sm-5 help-block">
                                <p class="text-info" style="color: #00a9ff;">请输入不少于6位的密码！</p>
                            </div>
                        </div>
                        <div class="form-group" style="margin-top: -8px;">
                            <label for="inputPassword3" class="col-sm-2 control-label" style="font-weight: normal;color:#6d6d6d;">验证码</label>
                             <div class="col-sm-5">
                                <input type="text" name="verifyCode" class="form-control" id="inputPassword3" placeholder="验证码">
                               <div id="verify_code_check" style="margin-top: 5px;color: red;" > </div>
                                
                            </div>
                             <div class="col-sm-5 help-block">
                                <span id="verifyCodeId"  style="color: #00a9ff; ">不区分大小写!</span>
                            </div>
                            
                        </div> 
                         <div class="form-group">
                        <div class="col-sm-4" style="padding:0px;margin-left: 100px;" id="">
                                <img id="getCode" src="<%=basePath%>admin/verifyCode" onclick="this.src+='?'+Math.random()" style="cursor:pointer;padding-top:5px;" title="点击换一个" alt="验证码">
                               &nbsp;&nbsp;
                                	<span style="color: #767474 ">看不清？<a href="javascript:;" style="color:#36c;"onclick="document.getElementById('getCode').src+='?'+Math.random()">换一张</a></span>
                            </div>
                        </div>
                        <div class="form-group" >
                            <div class="col-sm-offset-2 col-sm-10" id="main">
                                <button type="submit" class="btn btn-primary" style="width: 80px;">登录</button>
                                <a href="<%=basePath%>html/register.jsp" class="btn btn-primary" role="button" id="newreg">注册</a>
                                &nbsp;&nbsp;<!-- <span id="TelAndPass"  style="color:#006699 "></span> -->
                                    <div style="position: absolute;left: 44%;top: 1px;cursor: pointer;" id="forget"><a onclick="javascript:passWord();"><h6>忘记登录密码?</h6></a></div><br>
                                <br> <div ><span style="font-size: 12px;color: gray;font-weight: 500;">注册车队长,开启专属于您的汽车生活愉悦之旅！</span></div>
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
<script   type="text/javascript">
$(function(){
 if ((navigator.userAgent.indexOf('MSIE') >= 0) 
&& (navigator.userAgent.indexOf('Opera') < 0)){
  //  alert("您目前使用的是IE浏览器,建议您使用火狐浏览器 效果可能好一些");
    //telphone password inputPassword3
}else if(navigator.userAgent.indexOf('Firefox') >= 0){
   // alert("您丫的用的是Firefox(火狐)浏览器!");
   }else   if (navigator.userAgent.indexOf('Opera') >= 0){
     //  alert("你是使用Opera");
      } var isChrome = window.navigator.userAgent.indexOf("Chrome") !== -1 ;
         if(isChrome==true){
       //  alert("您丫的用的是google Chrome(谷歌)浏览器!");
         } 
        
 });
</script>
<script type="text/javascript">
 var newWindow=document.getElementById("passWordWindow");
function passWord(){
 newWindow.style.display="";
 };
 function confrimPassWord(){
 var nameTelphone=document.getElementById("nameTelphone").value;
 var nameIdentity=document.getElementById("nameIdentity").value;
 alert(nameTelphone);
 alert(nameIdentity);
 document.form2.action="<%=basePath%>pei/userPassWordList?nameTelphone=nameTelphone&nameIdentity=nameIdentity";
 document.form2.submit();
 newWindow.style.display="none";
};
function removePassWord(){
  newWindow.style.display="none";
};
</script>
<script>
function confrimPassWord333(){
 var nameTelphone=document.getElementById("nameTelphone").value;
 var nameIdentity=document.getElementById("nameIdentity").value;
var tel=/^(((1(3|5|8)[0-9]{1})|(15[0-9]{1}))+\d{8})$/;
var validator=/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
      if(!tel.test(nameTelphone)){
        alert("手机号或身份证号码格式不正确");
        return false;
      } else{
         if(!validator.test(nameIdentity)){
             alert("手机号或身份证号码格式不正确");
        return false;
         }else{
      }
     
   $.ajax({
            type: "POST",
            url: "<%=basePath%>passWord/userPassWordMobile",
            data: {mobile:$("#nameTelphone").val(),Telphone:nameTelphone,Identity:nameIdentity},
            dataType: "json",
            success: function(data) {
             newWindow.style.display="none";
            alert("密码已发送至您手机，请查收");
                _this.text('30秒之后重新发送');
                var wait = 30;
                _this.text(wait + '秒之后重新发送');
                var interval = setInterval(function() {
                    var time = --wait;
                    $('.smsCode').html(time + '秒之后重新发送');
                    if (time <= 0) {
                        $.post('<%=basePath%>passWord/userPassWordMobile',{mobile:$("#telphone").val()},function() {
                            _this.text('获取校验码');
                        },"json");
                        clearInterval(interval);
                    };
                }, 30000);
            },
            error: function() {
                   alert("手机号或身份证号码错误");
                _this.text('发送失败');
            }
        });
   }}
	  
 newWindow.style.display="none";
</script>
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
		     
	 
</script>

<script>
  
 var verify="";
  var  verifyStr="";

function  VerifyList(obj){
             
		   	  $.ajax({
            type: "POST", 
            data:{},
            url: "<%=basePath%>member/verifyRecord",
            async:false,
            dataType: "json",
            success: function(data) {
                  for(var i=0; i<data.length; i++){
		     		  verify=data[i].Verify;
		     		 
		     		 
		     	}
              },
            error: function() {
            _this.text('请求失败');
            }
        });	
       
            verifyStr=yanzhengma.value;
         if(verifyStr.toLowerCase() !=verify.toLowerCase() ){
                 $('#inputPassword3').css("border-color","red");
                 if(verifyStr!="" && verifyStr!=null){
                        $('#verify_code_check').text("验证码错误！");
                 }else{
                   $('#verify_code_check').text("请输入验证码！");
                  
                 }
 		    
		          return false;
		    }else{
		        
		     if(verifyStr.toLowerCase() == verify.toLowerCase()  ){
		       $('#inputPassword3').css("border-color","");
 		         $('#verify_code_check').text("");
 		    /*     var TJ="输入正确！";
		 document.getElementById("verifyCodeId").innerHTML="<span id='verifyCodeId'  style='color:#36c; '>"+TJ+"</span>" ; */
 		               }
		    }
}
</script>
<script>
     var wxsId=document.getElementById("wxsId").value;
	 var telphone = document.getElementById("telphone");
	 var password = document.getElementById("password");
	 var yanzhengma= document.getElementById("inputPassword3");
	  
	 function checkInput() {
	
	     var  message="";
	  $.ajax({
            type: "POST", 
            data:{},
            url: "<%=basePath%>member/verifyRecord",
            async:false,
            dataType: "json",
            success: function(data) {
           
                  for(var i=0; i<data.length; i++){
		     		  VerifyID=data[i].Verify;
  		     	}
              },
            error: function() {
            _this.text('请求失败');
            }
        });	 
 		  xinbie = $('input:radio[name="nan"]:checked').val();
 		  var  check_one=true;
 		  if(telphone.value==""){
 		        $('#telphone').css("border-color","red");
 		        $('#TelAndPass').text("请输入登陆账号！");
   			    check_one= false; 
 			   
		  }else{
		     $('#telphone').css("border-color","");
 		        $('#TelAndPass').text("");
		  }
		   if(yanzhengma.value==""){
 		         $('#inputPassword3').css("border-color","red");
 		          $('#verify_code_check').text("请输入验证码！");
 		          check_one= false; 
 		        }else{
 		          $('#inputPassword3').css("border-color","");
 		          $('#verify_code_check').text("");
 		        }
 		        if(yanzhengma.value==""){
 		        VerifyList("请输入验证码！");
 		        }else{
 		         VerifyList();
 		        }
 		        
 		         if(password.value==""){
 		          $('#password').css("border-color","red");
 		           $('#password_check').text("请输入密码！");
 		            check_one= false; 
 		        }else{
 		         $('#password').css("border-color","");
 		           $('#password_check').text("");
 		        }
 		        if(check_one==false ){
 		        return false;
 		        }
		   $.ajax({
            type: "POST",  
            data:{password:password.value,telphone:telphone.value},
            url: "<%=basePath%>member/passWordAndTelRecord",
            async:false,
            dataType: "json",
            success: function(data) {
                  for(var i=0; i<data.length; i++){
		     		  message=data[i].message;
  		     	}
              },
            error: function() {
            _this.text('请求失败');
            }
        });	
		  if(message=="密码错误0010"){
		         /*  var TP="账号或密码不正确，请重新输入！";
		          document.getElementById("TelAndPass").innerHTML="<span id='verifyCodeId'  style='color:#ff9100; '>"+TP+"</span>"; */
		            
 		        $('#TelAndPass').text("账户或密码不存在！");
 			    return false; 
		  }	
           if(verifyStr.toLowerCase() !=VerifyID.toLowerCase()){
  			    return false; 
		  } 
         return true;  //表单提交   
   }
</script>
<script>
function isTelphone() {
    $('#telphone').blur(function() {
        if ($(this).val().search(/^(((1(3|5|8)[0-9]{1})|(15[0-9]{1}))+\d{8})$/) != -1) {
            $(this).closest('.form-group').find('.text-info').text('输入正确!').css({
                "color": "#00a9ff;"
            });
            return true;
        } else {
            $(this).closest('.form-group').find('.text-info').text('请填写正确的手机号码!').css({
               "color": "#ff9100"
            });
            return false;
        }
    });
}
function passWord(){
window.location.href="<%=basePath%>html/forget_passwd.jsp";
}
/* $(function(){
        $('#inputPassword3').bind('keypress',function(event){
            if(event.keyCode == "13"){
            VerifyList();
             var sign_id=checkInput();
            if(sign_id==true){
           document.form1.submit();
           }
 	
            }
        });
    }); */
    function isTelehoneCheck(){
       var  tel=$('#telphone').val();
        if (tel.search(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/) != -1 && tel!="") {
             $('#telphone').css("border-color","");
 		        $('#TelAndPass').text("");
        } else{
         if(tel==""){
            $('#telphone').css("border-color","red");
 		        $('#TelAndPass').text("请输入登陆账号！");
         }
    }
    }
     function isPassWordCheck(){
       var  pass=$('#password').val();
        if (pass!="") {
            $('#password').css("border-color","");
 		           $('#password_check').text("");
        } else{
         if(pass==""){
            $('#password').css("border-color","red");
 		           $('#password_check').text("请输入密码！");
         }
    }
    }
    //整个区域敲击回车都做响应
    $(function(){
        document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0]; 
         if(e && e.keyCode==13){ 
             VerifyList();
             var sign_id=checkInput();
            if(sign_id==true){
           document.form1.submit();
           }
 	
            
        } 
    }; 
    });
    
    $.ajax({
    	url:"<%=basePath%>pei/logOutSession",
    	type:"post",
    	dataType:"json",
    	success:function(data){
    		
    	},
    	error:function(){
    	}
    });
</script>
