function fucCheckTelPhone(v)
{
	// var telphone=$('#telephone').val();
	if (v == '') {
		alert('联系方式不能不填！'); 
		return false;
	}
	if (v.search(/^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/) != -1){
		redflag=0;
		return true;
	}
	else{
		alert("请填写中国境内的电话号码！");
		redflag=1;
		return false;
	}
}