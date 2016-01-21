


$(function(){
	$(".validateNull").blur(function(){
		if(!validateNull(this))
			return false;
	});
	
	$(".validateIdCard").blur(function(){
		if(!validateIdCard(this))
			return false;
	});
	
	$(".validateMath").blur(function(){ //手机号码验证   必须是数字    
		if(!validateMath(this)){
			return false;
		}
	});
	$(".validatetel").click(function() {
		$(this).next().next().text("");
	});
	$(".validatetel").next().next().text($(".validatetel").attr("title"));
	$(".validatetel ").blur(function(){ //手机号码验证      长度必须是11位数字
		if(!validatetel(this)){
			return false;
		}
	});
	$(".idCarBox1").blur(function(){
		if(!validateNull(this))
			return false;
	});
	$(".idCarBox2").blur(function(){
		if(!validateNull(this))
			return false;
	});
	
/*	
	$(".validateNullSix").click(function(){
		$(this).next().next().text("");
	});
	$(".validateNullSix").next().next().text($(".validateNullSix").attr("title"));
	$(".validateNullSix").blur(function(){
		if(!validateNull(this)){
			return false;
		}	
		if(!validateLengthSix(this))
			return false;
	});
	
	$(".validateEmail").blur(function(){  //验证邮箱格式
		if(!validateNull(this))
			return false;
		if(!validateemail(this))
			return false;
	});	
	$(".validateEmail").click(function(){
		$(this).next().next().text("");
	});
	$(".validateEmail").next().next().text($(".validateEmail").attr("title"));
	
	$(".validateReferralId").blur(function(){	//	验证推荐人是否存在
		if(!validateReferralId(this)){
			return false;
		}
	});
	$(".validatePass").blur(function(){			//验证密码是否合格
		if(!validateNull(this))
			return false;
		if(!validateLength(this))
			return false;
		if(!validatePass(this))
			return false;
	});
	$(".validatePass").click(function(){
		$(this).next().next().text("");
	});
	$(".validatePass").next().next().text($(".validatePass").attr("title"));*/

});



/**
 * 验证是否为空
 */
function validateNull(obj){
	var message = $(obj).next().text();
	if($(obj).val()==null||$(obj).val().length==0){
		$(obj).next().next().text(message.split('[]')[0]);
		return false;
	}
	return true;
}

/**
 * 验证输入的字符长度是否是18位---身份证
 */
 function validateIdCard(obj){// 账号文本框不能为空的方法
		var message = $(obj).next().text();
		var textLength = $(obj).val().length;
		if(textLength!=18){
			$(obj).next().next().text(message.split('[]')[0]);
			return false;
		}else{
	  		$(obj).next().next().text("");
	  	}
		return true;
	}

 /**
  * 验证输入的字符长度是否是11位---电话号码
  */
  function validatetel(obj){// 账号文本框不能为空的方法
 		var message = $(obj).next().text();
 		var textLength = $(obj).val().length;
 		if(textLength!=11){
 			$(obj).next().next().text(message.split('[]')[1]);
 			return false;
 		}else{
 	  		$(obj).next().next().text("");
 	  	}
 		return true;
 	}

  /**
   * 验证是否都是数字
   */
   function validateMath(obj){
	 var aa=$(obj).val();
  	 var textFormat = isNaN($(obj).val());
  	if(textFormat || aa==""){//判断该字段是不是数字  如果是数字就返回false
  		var message = $(obj).next().text();
  		$(obj).next().next().text(message.split('[]')[0]);
  		return false;
  	}else{
  		$(obj).next().next().text("");
  	}
  	return true;
  }


 








/**
 * 验证长度大于6
 */
function validateLengthSix(obj){
	var message = $(obj).next().text();
	if($(obj).val().length<6){
		$(obj).next().next().text(message.split('[]')[1]);
		return false;
	}
	return true;
}


 /**
  * 验证邮箱是否合格
  */
  function validateemail(obj){
 		var message = $(obj).next().text();
 		var intext = $(obj).val();
 		var reg =/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
 		if(reg.test(intext)){
 			return true;
 		}
 		$(obj).next().next().text(message.split('[]')[1]);
 		return false;
 	}
  /**
   * 验证推荐人是否合格
   */ 
  function validateReferralId(obj){
		$.ajax({
		type: "POST", 
		url: "isReferralId.htm",  
		data:{referralid:$("#referralid").val()},
		dataType: "json",   
		success: function(data){
			if(data.success=="success"){
				return true;
			}else{
				var message = $(obj).next().text();
				$(obj).next().next().text(message.split('[]')[1]);
				return false;
			}
		}
	});	
	}    
/**
 * 验证密码长度是否合格
 */
function validateLength(obj){// 账号文本框不能为空的方法
	var message = $(obj).next().text();
	var textLength = $(obj).val().length;
	if(textLength<6||textLength>11){
		$(obj).next().next().text(message.split('[]')[2]);
		return false;
	}
	return true;
}
/**
 * 验证密码是否由数字或者字母组成
 */
function validatePass(obj){
	var textFormat = $(obj).val().match('^[A-Za-z0-9]+$');
	if(textFormat==null){
		var message = $(obj).next().text();
		$(obj).next().next().text(message.split('[]')[1]);
		return false;
	}
	return true;
}
 /**
 *验证输入的两次密码是否一样
 */
 function validateRepass(obj){// 账号文本框不能为空的方法
	var message = $(obj).next().text();
	var intext = $(obj).val();
	var brotherNodes = $(".validatePass");
	if(intext==$(brotherNodes[1]).val()){
		return true;
	}
	$(obj).next().next().text(message.split('[]')[1]);
	return false;
}