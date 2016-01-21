function onsubmitlist02(){
      var type=true;
     if (!validatelegalCheck_02('complaint_type_02')) {
         $('#mesage_id_str01_02').html("请填写投诉分类");
		type = false;
	} else{
	 $('#mesage_id_str01_02').html("");
	}
	 if (!validatelegalCheck2_02('lawsuit_request')) {
	    $('#mesage_id_str02_02').html("请填写诉讼请求");
		type = false;
	} else{
	  $('#mesage_id_str02_02').html("");
	}
	if (!validatelegalTel('telephone_02')) {
 		type = false;
	}  
	if (!validatelegalName('car_name_02')) {
 		type = false;
	} 
	if (!validatelegalName('detail_content_02')) {
 		type = false;
	} 
	if (!validatelegalName('mileage_02')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_time_02')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_city_02')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_store_02')) {
 		type = false;
	} 
	if (!validatelegalName('title_02')) {
 		type = false;
	} 
	if (!validatelegalModle_02('complaint_object_02')) {
 		type = false;
	} 
	if (!validatelegalModle_02('car-modal-data_02')) {
 		type = false;
	} 
	if (!validatelegalcarNumber('car_number')) {
 		type = false;
	} 
	
    return type;

}   
//start
function validatelegalModle_02(thisEle) {
 	var _this=document.getElementById(thisEle);
  	if(!validateNullModel_02(_this)){
 		return false;
	} else{
  	return 	true;
 
	}
 
}

function validateNullModel_02(obj){
    	var message = $(obj).next().text();
	if($(obj).val()==null||$(obj).val().length==0 || $(obj).val()=="0" || $(obj).val()==0){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
//end
//start
function validatelegalCheck_02(thisEle) {
 var _this=document.getElementById("complaint_type_02");
  	if(!validateNullCheck_02(_this)){
 		return false;
	} else{
  	return 	true;
 
	}
 
}
function validateNullCheck_02(obj){
     	var message = $(obj).next().text();
    		var _this = document.getElementsByName("complaint_type");
    		var state=false;
  	   for(var i=0;i<_this.length;i++){
  	   if(_this[i].checked ){
   	      state= true;
  	   }
  	   }
	if(state==false){
 		$(obj).next().next().text(message.split('[]')[0]);
  		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
//end
//start
function validatelegalCheck2_02(thisEle) {
 var _this=document.getElementById("lawsuit_request_02");
  	if(!validateNullCheck2_02(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
 
}
function validateNullCheck2_02(obj){
    	var message = $(obj).next().text();
    		var _this = document.getElementsByName("lawsuit_request");
    		var state=false;
  	   for(var i=0;i<_this.length;i++){
  	   if(_this[i].checked ){
  	      state= true;
  	   }
  	   }
	if(state==false){
 		$('#mesage_id_str').next().text(message.split('[]')[0]);
   		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
//end
//start
function validateNullCheck2_03(obj){
     		var _this = document.getElementsByName("complaint_type");
    		var state=false;
  	   for(var i=0;i<_this.length;i++){
  	   if(_this[i].checked ){
  	      state= true;
  	   }
  	   }
 	if(state==false){
 		   $('#mesage_id_str01_02').html("请选择投诉分类");
   		return false;
	}else{
  		  $('#mesage_id_str01_02').html("");
  	}
	return true;
}
//end
//start
function validateNullCheck2_04(obj){
     		var _this = document.getElementsByName("lawsuit_request");
    		var state=false;
  	   for(var i=0;i<_this.length;i++){ 
  	   if(_this[i].checked ){
  	      state= true;
  	   }
  	   }
 	if(state==false){
 		   $('#mesage_id_str02_02').html("请选择诉讼请求");
   		return false;
	}else{
  		  $('#mesage_id_str02_02').html("");
  	}
	return true;
}
//end
//start
function validatelegalcarNumber(thisEle) {
   	var _this=document.getElementById(thisEle);
  	if(!validatecarNumber(_this)){
  		return false;
  		
	} else{
		
  	return 	true;
 
	}
 
}
function validatecarNumber(obj){
   	var message = $(obj).next().text();
   	var rules=/^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/;
  	if(!(rules.test($(obj).val()))){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}