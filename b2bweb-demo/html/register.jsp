<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/header.jsp"%>
<style>
#agree-btn{
background: none repeat scroll 0 0 #f60;
    color: #fff;
     border: 0 none;
    font-family: "Microsoft Yahei";
    font-size: 16px;
    height: 34px;
    line-height: 34px;
    overflow: visible;
    padding: 0 25px;
    width: 220px;
    text-align: center;
}
#agree-btn a{
color:white;
}
#get-ucode{
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

    <div class="container-fluid">

        <div class="row">
         <div style="  background: none repeat scroll 0 0 #ffffff; border: 6px solid #e1e1e1; height:451px;border-radius:5px;">
            <div class="panel panel-primary" style="border-color: #C8E5FF ;border-width: 2px;">
            <div class="panel-heading" style="border: none;background: transparent;padding-left:20px;padding-top:15px;">
                <h3 class="panel-title" style="color: #353535;font-weight: bold;">会员注册</h3>
            </div>
               <div class="panel-body paddingLeft0 paddingRight0" style="margin-top:-12px;">
                    <div class="col-md-5 pull-left" style="margin-right:-3px;">
                        <div class="thumbnail" style="border:none;margin-bottom:0;padding-bottom:0;">
                            <div id="baidu-map">
                               <div id="centerMsg"><img alt="" src="<%=basePath%>html/img/login_user_03.png" ></div>
                        		<%-- <%@ include file="./public/baidu3.jsp"%> --%>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 pull-right">
                        <form class="form-horizontal" id="valid_form" name="form1"  method="post" >
                         <input type="hidden" value=<%=request.getParameter("wxsId") %> id="wxsId" name="wxsId">
                            <div class="form-group">
                                 <label for="telphone" class="col-sm-2 control-label" style="font-weight: normal;">手机号</label>
                                <div class="col-sm-5">
                                    <input type="tel" name="telphone" class="form-control" id="telphone" placeholder="手机号" onkeyup="telphoneExist();" onkeydown="telphoneExist();" onblur="isTelphone()">
                                </div>
                                <div class="col-sm-5 help-block"  >
                                    <p class="text-info" style="color: #00a9ff;" id="help-block-tel-id">请输入手机号码！</p>
                                </div>
                                <div   id="telphoneExist" style="padding-left: 20%;color: red;"></div>
                            </div>
                            <div class="form-group">
                              <label for="password" class="col-sm-2 control-label" style="font-weight: normal;text-align: center;padding-left:33px;">密&nbsp;&nbsp;&nbsp;码</label>
                                <div class="col-sm-5">
                                    <input type="password" name="password" onKeyUp="pwStrength(this.value)" onBlur="pwStrength(this.value)" onchange="isPasswordOk()" class="form-control" id="password" placeholder="密码">
                                    
                                    <div class="pw-strength" id="J_PwdStrength">
                                        <div class="pw-letter">
                                            <span class="tsl" id="strength_L">弱</span>
                                            <span class="tsl" id="strength_M">中</span>
                                            <span class="tsl" id="strength_H">强</span>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-sm-5 help-block">
                                    <p class="text-info" style="color: #00a9ff;">请输入不少于6位的密码！</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="confirm-Pwd" class="col-sm-2 control-label" style="font-weight: normal;">密码确认</label>
                                <div class="col-sm-5">
                                    <input type="password" name="confirmPwd" class="form-control" id="confirm-Pwd" placeholder="密码确认" onblur="comfirmPwd()">
                                </div>
                                <div class="col-sm-5 help-block">
                                   <p class="text-info" style="color: #00a9ff;">请再次输入密码！</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword3" class="col-sm-2 control-label" style="font-weight: normal;">校验码</label>
                               <div class="col-sm-5">
                                    <input type="text" name="checkcode" class="form-control" id="inputPassword3" placeholder="">
                                </div>
                                <div class="col-sm-3" style="padding-left:0;margin-left:15px;">
                                    <a href="javascript:;" class="btn btn-default" id="get-ucode">获取校验码</a>
                                </div>
                                <div class="col-sm-6 help-block" style="padding-left:0;">
                                    <p class="text-info" id="codeRemember" style="margin-left: 120px;"></p>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <input type="checkbox" name="agree" id="agree" value="1">
                                    <label for="agree" class="control-label" style="cursor: pointer;font-weight: normal;"><span id="agreement">《已阅读并同意用户协议》</span></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <!-- <div class="col-sm-offset-2 col-sm-10">
                                    <a href="javascript:;" class="btn btn-primary submit-btn">同意协议并注册</a>
                                </div> -->
                                <div class="col-sm-offset-2 col-sm-10" id="agree-btn">
                                    <a href="#" onclick="registerConfrim();">同意协议并注册</a>
                                </div>
                            </div>
                            <div class="form-group">
                            	<div class="col-sm-offset-2 col-sm-10">
                            		<span style="font-size: 12px;color: gray;font-weight: 500;">注册车队长,开启专属于您的汽车生活愉悦之旅！</span>
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

<script type="text/javascript" src="<%=basePath%>html/js/is_strong.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/validate.js"></script>
<script>
var userState="";
var tt="0";
$(document).ready(function () {
	$('input').iCheck('destroy');
   /*  $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });  */
    
   /*  isTelphone();
    isPasswordOk();
    comfirmPwd(); */
    
    var agreeCount = 0;
    
    function agreeClick(){
    	if(agreeCount==0){
     		window.open('<%=basePath%>html/agreement.html','','height=800,width=900,scrollbars=yes,status =yes');
    	}    	
    }

	var agreement = document.getElementById("agreement");
	
	agreement.onclick = agreeClick;

    document.getElementById("get-ucode").onclick = ucodeClick;
    
    function ucodeClick(){
           if(isTelphone() == false) {
            $.globalMessenger().post({
                message: '手机号码不正确',
                type: 'error',
                 hideAfter: 2,
                showCloseButton: true
            });
        }
        
        var _this = $(this);
        var telStr=$("#telphone").val();
         var TelTest=/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;

        if(TelTest.test(telStr) && userState!="1"){
         
        $.ajax({
            type: "POST",
            url: "<%=basePath%>mobile/ucode",
            data: {mobile:$("#telphone").val()},
            dataType: "json",
            success: function(dat) {
                   
            	document.getElementById("get-ucode").onclick = deleteClick;
                _this.text('60秒之后重新发送');
                var wait = 60;
                _this.text(wait + '秒之后重新发送');
                var interval = setInterval(function() { 
                               
                    _this.text(wait + '秒之后重新发送');
                    var time = --wait;
                    $('.smsCode').html(time + '秒之后重新发送');
                    if (time <= 0) {  
                    	document.getElementById("get-ucode").onclick = ucodeClick;                   
                        _this.text('获取校验码');                     
                        clearInterval(interval);
                    };
                }, 1000);
                
            },
            error: function() {

            }
        });
        }else{
         var telStr=" <p class='text-info' style='color: red;' id='help-block-tel-id'>请输入手机号码！</p>";
     document.getElementById("help-block-tel-id").innerHTML=telStr;
          
        }
    }
    
    function deleteClick(){    
    }

    $('#inputPassword3').click(function() {
    	document.getElementById("codeRemember").innerHTML="";
    });
    

$._messengerDefaults = {
	extraClasses: 'messenger-fixed messenger-theme-future messenger-on-top messenger-on-right'
};
    
});
</script>
<script>
var bufferData="";
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
	
	}  
		     
	var exist=0;
	 function telphoneExist(){
	 var telphone=$("#telphone").val();
	 $.ajax({
	   type:"POST",
	   url:"<%=basePath%>pei/telphoneExist",
	   data:{telphone:telphone},
	   async:false,
	   dataType:"html",
	   success:function(data){
	   
	     userState=data;
	     tt=data;
 	   var content="该号码已被注册！";
	      if(data=="1"){
	      exist=1;
	    document.getElementById("telphoneExist").innerHTML=content;
 	      }
 	      if(data=="0"){
 	      exist=0;
 	      document.getElementById("telphoneExist").innerHTML="";
 	      }
	   },
	   error:function(){
 	 
	   }
	   
	 });
	 }
	 function registerConfrim(){
	 var check=true;
	if(exist==1){
	 check=false;
	}
	 if(!isTelphone()){
	 check=false;
	 }
	 
	 if(!isPasswordOk()){
	 	check=false;
	 }
	
	 if(!comfirmPwd()){
	 	check=false;
	 } 
	//start
	    $(function(){
	    var verificationCode = $("#inputPassword3").val();
    	var checkResult = "";
	    	$.ajax({
		    type: "POST",
		    url: "<%=basePath%>pei/verificationCode",
		    data:{"checkcode":verificationCode},
		    async:false,
		    dataType: "html",
		    success: function(data) { 
			    checkResult = data;
		    },
		    error: function() {
		   		alert("验证失败");
		    }
		});
    	if(checkResult == "yes"){
   	        if($('#agree').is(":checked")) {
	           
	        } else {
	        
	            $.globalMessenger().post({
	                message: '请先阅读用户注册协议',
	                type: 'error',
	                 hideAfter: 2,
	                showCloseButton: true
	            });
	            check=false;
	        }    	
    	}else{
    		tt="1";
    		check=false;
    		document.getElementById("codeRemember").innerHTML="<font color='#ff9100' >请输入正确的验证码</font>";    		
    	}
	    });
     
	//end
	if(check==true){
 	$.ajax({
		    type: "POST",
		    url: "<%=basePath%>pei/register",
		    data:{"telphone":$("#telphone").val(),
		    		"password":$("#password").val(),
		    		"confirmPwd":$("#confirm-Pwd").val(),
		    		"checkcode":$("#inputPassword3").val(),
		    		"wxsId":$("#wxsId").val()
		    },
		    dataType: "html",
		    success: function(data) {
 			   $.globalMessenger().post({
                message: '注册成功,3秒后自动跳转到登陆页面',
                type: 'error',
                showCloseButton: true
            });
            bufferData=data;
            if(bufferData==null || bufferData==""){ 
            	 setTimeout(test,3000) ;
            }else{ 
            	 setTimeout(test1,3000) ;
            }
    		
		    },
		    error:function(){
		    }
		   });   
		 
		} 
	 }
	function test(){

	window.location.href="<%=basePath%>html/login.jsp";
	} 
	function test1(){

	window.location.href="<%=basePath%>html/login.jsp?wxsId="+bufferData;
	} 
	
</script>
<script>
/* function ajaxRequestDogetJsonp(getUrl){
		var obj={"ip":"113.246.86.58"}; 
        $.ajax({
			type: "get",
			url: getUrl,  
			async:false,           
			dataType: "json",
			data:obj,
            success: successback,
			error: errorback
		});         
	}
	ajaxRequestDogetJsonp("../ajax/ip");  */
</script>