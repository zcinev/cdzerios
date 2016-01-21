var coord;
var path;
var position = "null";
var brandId = "";
var url;
var demoPath;
var gpsPath;
function begain(obj) {
	path = obj;
	$.ajax({
		type : "GET",
		url : path + "pei/getUrl",
		async : false,
		dataType : "html",
		success : function(data) {
		},
		error : function() {
			alert("请求失败");
		}
	});
	function successback(data) {
		coord = data.addr;
	}
	function errorback() {
		alert("失败");
	}
	function ajaxRequestDogetJsonp(getUrl) {
		var obj = {
			"ip" : "113.246.86.58"
		};
		$.ajax({
			type : "get",
			url : getUrl,
			async : false,
			dataType : "json",
			data : obj,
			success : successback,
			error : errorback
		});
	}
	ajaxRequestDogetJsonp(path + "ajax/ip");
}
function nextFun1(url) {

	var legalName = document.getElementById("legalName").value;
	var legalTel = document.getElementById("legalTel").value;
	var legalAddress = document.getElementById("legalAddress").value;
	var idCard = document.getElementById("idCard").value;
	var idCardOverTime = document.getElementById("idCardOverTime").value;
	if (position == null || position == "null") {
		alert("请在地图上标注您的具体位置！");
	}
	if (legalName == null || legalName == "null") {
		alert("请填写法人名称！");
	}
	if (position != "null") {
		document.form1.action = path + "join/basicInfo?map=" + position;
		document.form1.submit();
	}
}

function jumpPartStore(url) {
	window.location.href = url + "join/jumpPartStore";
}
function nextFun2(url) {
	var provincebox = document.getElementById("province-box");
	var index1 = provincebox.selectedIndex; // 选中索引
	var province = provincebox.options[index1].text; // 选中文本
	var citybox = document.getElementById("city-box");
	var index2 = citybox.selectedIndex; // 选中索引
	var city = citybox.options[index2].text; // 选中文本
	var areabox = document.getElementById("area-box");
	var index3 = areabox.selectedIndex; // 选中索引
	var region = areabox.options[index3].text; // 选中文本
	document.form1.action = url + "join/detailInfo?province1=" + province
			+ "&city1=" + city + "&region1=" + region;
	document.form1.submit();
}
function jumpRepair(url) {
	window.location.href = url + "join/jumpRepair";
}
function getFacilities(url) {
	$.ajax({
		type : "GET",
		url : url + "join/getFacilities",
		async : false,
		dataType : "html",
		success : function(data) {
			$('#facility').html(data);
		},
		error : function() {
			alert("请求失败");
		}
	});
}
function getRepairItem(url) {
	$.ajax({
		type : "GET",
		url : url + "join/getRepairItem",
		async : false,
		dataType : "html",
		success : function(data) {
			$('#repairItem').html(data);
		},
		error : function() {
			alert("请求失败");
		}
	});
}
function selectBrand(url) {
	var newDiv = document.getElementById("newDiv");
	newDiv.style.display = "";
	$.ajax({
		type : "GET",
		url : url + "join/showBrand",
		async : false,
		dataType : "html",
		success : function(data) {
			$('#newDiv').html(data);
		},
		error : function() {
			alert("请求失败");
		}
	});
}
function getBrand() {
	var id1 = document.getElementsByName("brand");
	for ( var i = 0; i < id1.length; i++) {
		if (id1[i].checked) {
			brandId = brandId + "," + id1[i].value;
		}
	}
	var newDiv = document.getElementById("newDiv");
	newDiv.style.display = "none";
	// var show= document.getElementById("show");
	brandId = brandId.substring(1);
	$('#brand11').html(brandId);
}

function nextFun3(url) {
	var companyName = document.getElementById("companyName");
	var urgentUser = document.getElementById("urgentUser");
	var urgentTel = document.getElementById("urgentTel");
	var address = document.getElementById("address");
	
	var check = true;

	if (!validatelegalName('companyName')) {
		check = false;
	}
	if (!validatelegalName('urgentUser')) {
		check = false;
	}
	if (!validatelegalTel('urgentTel')) {
		check = false;
	}

	if (!validatelegalAddress('address')) {
		check = false;
	}

	if (check == false) {
		return;
	}
	

	document.form1.action = url + "join/repairInfo1";
	document.form1.submit();
}

function nextFun4(url) {
	var selectBrand = document.getElementsByName("repair1");
	var majorBrand = "";
	for ( var i = 0; i < selectBrand.length; i++) {
		if (selectBrand[i].checked) {
			majorBrand = majorBrand + "," + selectBrand[i].value;
		}
	}
	majorBrand = majorBrand.substring(1);
	var repairItem = $('#repairItem').get(0).innerHTML;
	var facility = $('#facility').get(0).innerHTML;
	var provincebox = document.getElementById("province-box");
	var index1 = provincebox.selectedIndex; // 选中索引
	var province = provincebox.options[index1].text; // 选中文本
	var citybox = document.getElementById("city-box");
	var index2 = citybox.selectedIndex; // 选中索引
	var city = citybox.options[index2].text; // 选中文本
	var areabox = document.getElementById("area-box");
	var index3 = areabox.selectedIndex; // 选中索引
	var region = areabox.options[index3].text; // 选中文本
	if (majorBrand == "请选择") {
		alert(majorBrand + "服务品牌");
		return;
	}
	// alert(repairItem);
	if (repairItem == "") {
		alert(请勾选 + "维修项目");
		return;
	}
	// alert(facility);
	if (facility == "") {
		alert(请勾选 + "综合设施");
		return;
	}

	document.form1.action = url + "join/repairInfo2?province1=" + province
			+ "&city1=" + city + "&region1=" + region + "&majorBrand="
			+ majorBrand;
	document.form1.submit();
}
function jumpCarMannage(url) {
	window.location.href = url + "join/jumpCarMannage";
}
function nextFun5() {
	var check=true;
	if (!validatelegalName('latlon')) {
		check=false;
	}
	if (check==true) {
		document.form1.action = path + "join/carManageInfo1";
		document.form1.submit();
	}
}
function nextFun6(url1,url2) {
	demoPath=url1;
	gpsPath=url2;
	var provincebox = document.getElementById("province-box");
	var index1 = provincebox.selectedIndex; // 选中索引
	var province = provincebox.options[index1].text; // 选中文本
	
	var citybox = document.getElementById("city-box");
	var index2 = citybox.selectedIndex; // 选中索引
	var city = citybox.options[index2].text; // 选中文本
	
	var areabox = document.getElementById("area-box");
	var index3 = areabox.selectedIndex; // 选中索引
	var region = areabox.options[index3].text; // 选中文本

	var idCardfront = document.getElementById("showImg1").value;
	var idCardverso = document.getElementById("showImg2").value;
	if(idCardfront==""){
		idCardfront = document.getElementById("businessLicence").value;
	}
	if(idCardverso==""){
		idCardverso = document.getElementById("orgPicture").value;
	}
	
	var check = true;
	if (!validatelegalName('companyName')) {
		check = false;
	}
	if (!validatelegalName('businessLicenceNo')) {
		check = false;
	}
	
	if (!validatelegalName('licenceAddress')) {
		check = false;
	}
	if(!validateAddress('province-box')){
		check = false;
	}
	if(!validateAddress('city-box')){
		check = false;
	}
	if(!validateAddress('area-box')){
		check = false;
	}

	if (!validatelegalName('buildDate')) {
		check = false;
	}

	if (!validatelegalName('address')) {
		check = false;
	}
	if (!validatelegalFax('tel')) {
		check = false;
	}
	if (!validatelegalFax('fax')) {
		check = false;
	}
	if (!validatelegalName('urgentUser')) {
		check = false;
	}
	if (!validatelegalTel('urgentTel')) {
		check = false;
	}
	if (!validatelegalName('organizationNo')) {
		check = false;
	}
	if (!validatelegalName('orgDeadline')) {
		check = false;
	}
	if (idCardfront == "") {
		$('#showImg1').html("请上传图像！").css({
			"color" : "red"
		});
		check = false;
	}
	if (idCardverso == "") {
		$('#showImg2').html("请上传图像！").css({
			"color" : "red"
		});
		check = false;
	}
	
	if (check == false) {
		return;
	}
	var id = $('#cwid').val();
	var companyName = $('#companyName').val();
	var businessLicenceNo = $('#businessLicenceNo').val();
	var businessLicence = $('#businessLicence').val();
	var licenceAddress = $('#licenceAddress').val();
	var province1 = province;
	var province = provincebox.value;
	var city1 = city;
	var city = citybox.value;
	var region1 = region;
	var region = areabox.value;
	var address = $('#address').val();
	var tel = $('#tel').val();
	var fax = $('#fax').val();
	var urgentUser = $('#urgentUser').val();
	var urgentTel = $('#urgentTel').val();
	var organizationNo = $('#organizationNo').val();
	var orgDeadline = $('#orgDeadline').val();
	var orgPicture = $('#orgPicture').val();
	var buildDate = $('#buildDate').val();
	var agency=$("#agency").val();
	var agencyName=$("#agency option[value='"+agency+"']").text();
	
	$.ajax({
		type : "POST",
		url : url1 + "join/carManageInfo2",
		async : false,
		dataType : "json",
		data : {
			id : id,
			companyName : companyName,
			businessLicenceNo : businessLicenceNo,
			businessLicence : businessLicence,
			licenceAddress : licenceAddress,
			province1 : province1,
			province : province,
			city1 : city1,
			city : city,
			region1 : region1,
			region : region,
			address : address,
			tel : tel,
			fax : fax,
			urgentUser : urgentUser,
			urgentTel : urgentTel,
			organizationNo : organizationNo,
			orgDeadline : orgDeadline,
			orgPicture : orgPicture,
			buildDate:buildDate,
			agency:agency,
			agencyName:agencyName
		},
		success : successback,
		error : errorback
	});

	/*
	 * document.form1.action = url + "join/carManageInfo2?province1=" + province +
	 * "&city1=" + city + "&region1=" + region; document.form1.submit();
	 */
}


function successback(data){
	var json=data[0].content;
	var code=data[0].agency;
	var password=data[0].pwd;
	
	$.ajax({
		type : "get",
		url : gpsPath+"exitJson.do",
		async : false,
		dataType : "jsonp",
		success : function(dat) {
			authShow2(gpsPath,code,password);
			 var url=gpsPath+"operatorThree/save.do";
			  $.ajax({
					type : "post",
					url : url,
					async : false,
					dataType : "jsonp",
					data:{content:json},
					success : function(dat) {
						window.location.href=demoPath+"html/member/carManager3.jsp";
					},
					error : function() {
						alert("fail");
					}
				});
		},
		error : function() {
			alert("fail");
		}
	});
	
	
	
	 
	  }
	  function errorback() {
			alert("失败");		
		}
	  
	  function authShow2(url,obj1,obj2) {
			var name = obj1;
			name = $.trim(name);
			var pwd = obj2;
			pwd = hex_md5(name + pwd);// 加密
			if (name == "") {
				alert('用户名不能为空！');
				return;
			}
			$.ajax({
				type : 'POST',
				url : url + "login.do",
				async : false,
				data : {
					name : name,
					pwd : pwd,
				},
				dataType : "json",
				success : function(result) {
					var status = result.msgCode;
					if ('0' == status) {
						// location.href = "http://192.168.1.203:8080/og/main.do"
						var gps = url + "main.do";
					} else if ('1' == status) {
						alert("服务器异常！");
						return;
					} else if ('2' == status) {
						alert("验证码失效！");
						return;
					} else if ('3' == status) {
						alert("验证码输入不正确！");
						return;
					} else if ('4' == status) {
						alert("用户名和密码不一致！");
						return;
					}
				}
			});
		};
		     

function pass(basePath) {
	url = basePath;
}
function showBrand(obj) {
	$.ajax({
		type : "GET",
		data : {
			letter : obj
		},
		url : url + "join/showBrands",
		async : false,
		dataType : "html",
		success : function(data) {
			$('#allBrand').html(data);
		},
		error : function() {
			alert("失败！");
			_this.text('请求失败');
		}
	});
}
function changeBrands(a) {
	var buffer11 = "";
	var buffer22 = "";
	var repair1 = document.getElementsByName("repair1");
	var len = repair1.length;
	if (len >= 5) {
		return;
	}
	for ( var i = 0; i < len; i++) {
		if (repair1[i].checked) {
			buffer11 = buffer11 + "," + repair1[i].value;
		}
	}
	buffer11 = buffer11.substring(1);
	var arr = buffer11.split(",");
	var j = 0;
	for (j = 0; j < arr.length; j++) {
		if (a == arr[j]) {
			break;
		}
	}
	if (j == arr.length) {
		buffer11 = buffer11 + "," + a;
	}
	$.ajax({
		type : "GET",
		data : {
			id : buffer11
		},
		url : url + "join/changeBrands",
		async : false,
		dataType : "html",
		success : function(data) {
			$('#selectBrand').html(data);
		},
		error : function() {
			alert("失败！");
		}
	});
}
function changeBrands2(obj) {
	var buffer = "";
	var repair1 = document.getElementsByName("repair1");
	var len = repair1.length;
	for ( var i = 0; i < len; i++) {
		if (repair1[i].checked) {
			repair1[i].checked = false;
			buffer = repair1[i].value + "," + buffer;
		}
	}
	$.ajax({
		type : "GET",
		data : {
			id : buffer
		},
		url : url + "join/changeBrands",
		async : false,
		dataType : "html",
		success : function(data) {
			$('#selectBrand').html(data);
		},
		error : function() {
			alert("失败！");
		}
	});
}
