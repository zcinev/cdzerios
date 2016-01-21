
function isTelphoneOrEmail() {
	var _this=document.getElementById("telphone");
	if(!judgeFun(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
}


function isTelphone() {
	var _this=document.getElementById("telphone");
	if(!fun1(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
}

function judgeFun(thisElem){
	var kvalue=$(thisElem).val();
	if(kvalue.indexOf("@qq.com")>=0){
 		var reg =/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
 		if(reg.test(kvalue)){
 			 $(thisElem).closest('.form-group').find('.text-info').text('输入正确').css({
		       	  "color": "#00a9ff"
		       });
 			return true;
 		} else {
		       $(thisElem).closest('.form-group').find('.text-info').text('请填写正确的手机号码').css({
			       	"color": "#ff9100"
			       });
			       return false;
			   }
	}else{
		  if ($(thisElem).val().search(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/) != -1) {
		       $(thisElem).closest('.form-group').find('.text-info').text('输入正确').css({
		       	  "color": "#00a9ff"
		       });
		       return true;
		       
		   } else {
		       $(thisElem).closest('.form-group').find('.text-info').text('请填写正确的手机号码').css({
		       	"color": "#ff9100"
		       });
		       return false;
		   }
	}
  
}

function fun1(thisElem){
         if ($(thisElem).val().search(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/) != -1) {
            $(thisElem).closest('.form-group').find('.text-info').text('输入正确').css({
            	  "color": "#00a9ff"
            });
            return true;
            
        } else {
            $(thisElem).closest('.form-group').find('.text-info').text('请填写正确的手机号码').css({
            	"color": "#ff9100"
            });
            return false;
        }
}


function isPasswordOk() {
	var _this=document.getElementById("password");
	if(!fun2(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
}


function fun2(thisElem){
        if($(thisElem).val().length < 6) {
            $(thisElem).closest('.form-group').find('.text-info').text('密码至少是6位').css({
            	 "color": "#ff9100"
            });
            return false;
        } else {
            $(thisElem).closest('.form-group').find('.text-info').text('输入正确').css({
            	 "color": "#00a9ff"
            });
            return true;
        }
}

function comfirmPwd() {
	var _this=document.getElementById("confirm-Pwd");
	if(!fun3(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
}


function fun3(thisElem){
        if($(thisElem).val() != $('#password').val()) {
            $(thisElem).closest('.form-group').find('.text-info').text('两次输入的密码不一致').css({
            	 "color": "#ff9100"
            });
            return false;
        } else if($(thisElem).val() == '') {
            $(thisElem).closest('.form-group').find('.text-info').text('密码确认不能为空').css({
            	 "color": "#ff9100"
            });
            return false;
        } else {
            $(thisElem).closest('.form-group').find('.text-info').text('输入正确').css({
                "color": "#00a9ff"
            });
            return true;
        }
}



function validatelegalAndZero(thisEle) {
 	var _this=document.getElementById(thisEle);
  	if(!validateNullAndZero(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
}

function validateAddress(thisEle){
	var obj=document.getElementById(thisEle);	
	var message = $('#info1').text();
	if($(obj).val()==null||$(obj).val().length==0 ||$(obj).val()=='0'){
 		$('#info2').text(message.split('[]')[0]);
 		return false;
	}else{
  		$('#info2').text("");
  	}
	return true;
}

function validatelegalName(thisEle) {
  	var _this=document.getElementById(thisEle);
  	if(!validateNull(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
 
}
function validatelegalTel(thisEle){
	var _this=document.getElementById(thisEle);
		if(!validateTel(_this)){
			return false;
		}
		else{
 
	return true;
		}
}

function validatelegalAddress(thisEle) {
	var _this=document.getElementById(thisEle);
 
	if(!validateNull(_this)){
		return false;
	}
 
	if(!validateNull(_this))
	return false;
	else{
		return	true;
		}
 
 	 
}


function validateidCard(thisEle){
	var _this=document.getElementById(thisEle);
	if(!validateCard(_this)){
		return false;
	}
	
	else{
		return	true;
		}
}
function validateidCardOverTime(thisEle){
	var _this=document.getElementById(thisEle);
	if(!validateNull(_this)){
		return false;
	}
	
	else{
 
		return	true;
	}
 
}

function validatelegalEmail(thisEle){
var _this=document.getElementById(thisEle);
if(!validateEmail(_this))
return false;
else{
	return	true;
	}
}

function validatelegalFax(thisEle){
	var _this=document.getElementById(thisEle);
  	if(!isTel(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
}



function isTel(obj)
{
//国家代码(2到3位)-区号(2到3位)-电话号码(7到8位)-分机号(3位)"

var message = $(obj).next().text();
 var pattern =/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
 //var pattern =/(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/; 
     if($(obj).val()!="" && $(obj).val().length>0 )
     {
         if(!pattern.exec($(obj).val()))
         {
        	 $(obj).next().next().text(message.split('[]')[0]);
        	 return false;
         }else{
       		$(obj).next().next().text("");
       		return true;
       	}
     } else{
    	 $(obj).next().next().text(message.split('[]')[0]);
    	 return false;
    	}
     return true;
}


function isPhone(obj1)
{
//国家代码(2到3位)-区号(2到3位)-电话号码(7到8位)-分机号(3位)"
var obj=document.getElementById(obj1);
var message = $(obj).next().text();
var pattern =/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
 //var pattern =/(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/; 
     if($(obj).val()!="" && $(obj).val().length>0 )
     {
         if(!pattern.exec($(obj).val()))
         {		
        	 if ($(obj).val().search(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/) != -1) {
        		 $(obj).next().next().text("");
            		return true;
        	 }else{
        		 $(obj).next().next().text(message.split('[]')[0]);
            	 return false;
        	 }
        	
         }else{
       		$(obj).next().next().text("");
       		return true;
       	}
     } else{
    	 $(obj).next().next().text(message.split('[]')[0]);
    	 return false;
    	}
     return true;
}

function validateMileage(thisEle){
var _this=document.getElementById(thisEle);
if(!validateMath(_this))
	return false;
	else{
		return	true;
		}
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
 * 验证是否为空
 */
function validateNull(obj){
   	var message = $(obj).next().text();
 	if($(obj).val()==null||$(obj).val().length==0){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}


/**
 * 验证是否为手机号码
 */
function validateTel(obj){

	  var aa=$(obj).val();
	  var message = $(obj).next().text();
	  if (aa.search(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/) != -1) {
		  $(obj).next().next().text("");
		  return true;
	  }else{
		  
		  $(obj).next().next().text(message.split('[]')[0]);
		  return false;  
	  }
		
}

/**
 * 验证是否为手机号码、座机、分机
 */
function validatePhone(obj){
	  var aa=$(obj).val();
	  var message = $(obj).next().text();
	  var re="((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$) ";
	  if(!(re.test(aa))){
		  $(obj).next().next().text(message.split('[]')[0]);
		  return false;  
	  }else{
	  		$(obj).next().next().text("");
	  	}
	  return true;
}


/**
 * 验证是否为身份证号码
 */
function validateCard(obj){
	  var aa=$(obj).val();
	  var message = $(obj).next().text();
	  if(!( /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(aa))){
		  $(obj).next().next().text(message.split('[]')[0]);
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

function validateEmail(obj){
	var message = $(obj).next().text();
		var intext = $(obj).val();
 		var reg =/^([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,4}$/;
		if(reg.test(intext)){
 			$(obj).next().next().text("");
			return true;
		}else{
			$(obj).next().next().text(message.split('[]')[0]);
 			return false;
		}
		
}
function validateRepasswd(thisEle){
 
	var _this=document.getElementById(thisEle);
	if(!validateRepass(_this))
	return false;
	else{
		return	true;
		}
	}
function validateRepass(obj){// 确认密码 是否一样
	var message = $(obj).next().text();
	var intext = $(obj).val();
 	var brotherNodes = $("#newPassword").val();
 	if(intext==brotherNodes){
		$(obj).next().next().text("");
	}else{
	$(obj).next().next().text(message.split('[]')[0]);
	return false;
	}
	return true;
}

function validateNullAndZero(obj){
   	var message = $(obj).next().text();
	if($(obj).val()==null||$(obj).val().length==0 || $(obj).val()=="0"){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}

