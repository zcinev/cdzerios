<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/head3.jsp"%>
     <script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 

.form-group label{
font-weight: normal;
}
.btn-primary{
background-color:#FF7400;border-color: #ed8802;width: 60px;
}
.btn-primary:hover{
color: white;
background-color:#ed8802 ;
border: #FF7400;
height: 34px;
}
#upload-full-img{
width: 160px;
border-radius:3px;

background-color: #ededed;
    background-image: linear-gradient(#fff, #e4e3e3);
    border: 1px solid #b1b1b1;
    color:#746D6D;
    font-family: "宋体";
    height:27px;
   
    font-size:12px;
    line-height: 15px;
    text-align: center;
}
</style>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        <!--[if lte IE 9]>
    <style type="text/css">
        #front-img {
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
        }
    </style>
    <![endif]-->
        <div class="container-fluid">
            <div class="row">
                <%@ include file="../public/memberSidebar.jsp" %>
                    <div class="col-xs-10 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                             <ol class="breadcrumb bottom-spacing-0">
                        <li>身份认证
                        </li>
                       
                    </ol>
                            </div>
                            <div class="panel-body">
                            
                                <form class="form-horizontal"  action="" method="post" enctype="multipart/form-data" role="form" onsubmit="return fun1()">
                                    <div class="form-group" style="padding-left: 10%">
                                        <label class="col-sm-4 control-label">身份证号码</label>
                                        <div class="col-sm-8 form-inline"> 
                                            <input type="text" class="form-control" name="identityCode" value="${key.identityCardNumber}" placeholder="请输入身份证号码" id="identityCode"   onblur="validateidCard('identityCode');">
                                              <span class="message" >身份证格式不正确[]</span>
                                                 <span class="messageShow" ></span>
                                        </div>
                                    </div>
                                    <link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
                                    
                                   <div class="form-group" style="padding-left: 10%">
                                        <label for="" class="col-sm-4 control-label">身份证正面照</label>
                                        <div class="col-sm-8">
                                            <a href="javascript:;" id="upload-full-img" class="btn btn-primary"><img alt="默认上传" src="<%=basePath %>html/img/moren-upload.png">&nbsp;请选择要上传的图片</a>
                                        </div>
                                    </div>
                                   <div style="padding-left:300px;margin-top: -12px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>  
                                   <div class="form-group">
                                        <label class="col-sm-5 control-label"></label>
                                        <div class="col-sm-7" id="showImg1">
                                          <c:if test="${key.identityCardImg!=null}">
                            
                                            <img id="faceImgId1" src="/b2bweb-demo/html/img/upimg2.png"  alt="请上传图片!">
                                           
                                             </c:if>
                                             <c:if test="${key.identityCardImg!=null}">
                           
                                             <img id="faceImgId" src="${key.identityCardImg}" width="150" height="150" alt="">
                                            
                                             </c:if>
                                        </div>
                                    </div> 
                                    <div class="form-group">
                                        <div class="col-sm-offset-4 col-sm-7">
                                            <button type="button" class="btn btn-warning" onclick="return updateIdentityList();">确认修改</button>
                                        </div>
                                    </div>
                                </form>
                               
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <%@ include file="../public/footer.jsp" %>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
            <script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
            <script>
    var bufferdata = "";
	var buffer = ""; 
     KindEditor.ready(function(K) {
      
        
     var editor1 = K.editor({
      	uploadJson : '<%=hostPath%>imgUpload/servlet/fileServlet',
    	//店铺全景图路径
         allowFileManager : true
    });
     K('#upload-full-img').click(function() {  
        editor1.loadPlugin('multiimage', function() {
            editor1.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                 /*    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                    });
                    editor1.hideDialog(); */
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata=bufferdata+","+data.url;
                         var objRow = document.getElementById("showImg1"); 
                           var  img="";
                             objRow.innerHTML=img;
                        $('#showImg1').append('<img id="litpic5" style="width:150px;height:150px;" src="' + data.url + '">');
                        var a = document.getElementById("litpic5").src;
                            
                     });
                     editor1.hideDialog();
                     
                  }
            });
        });
    });
 });
 
</script>
<script type="text/javascript">
function  updateIdentityList(){
//确定修改 身份证信息() 
 
   var  CardImg="";
    var list=document.getElementById("litpic5");
        
      if(list != null){
          CardImg = document.getElementById("litpic5").src;
         
      } else{
          CardImg=document.getElementById("faceImgId").src;
           
      }
       var check = true;
 	if (!validateidCard('identityCode')) {
 		check = false;
	} 
	if(check==true){    
   $.ajax({
            type: "GET", 
            data:{identityCardNumber:$('#identityCode').val(),identityCardImg:CardImg},
            url: "<%=basePath%>member/updateidentityCardNumberTest",
            async:false,
            dataType: "html",
            success: function(data) {
               alert("保存成功！");
             },
            error: function() {
            _this.text('请求失败');
            }
        });
        }
}

</script>
<script type='text/javascript'>
	
	var vcity = {
		11 : "北京",
		12 : "天津",
		13 : "河北",
		14 : "山西",
		15 : "内蒙古",
		21 : "辽宁",
		22 : "吉林",
		23 : "黑龙江",
		31 : "上海",
		32 : "江苏",
		33 : "浙江",
		34 : "安徽",
		35 : "福建",
		36 : "江西",
		37 : "山东",
		41 : "河南",
		42 : "湖北",
		43 : "湖南",
		44 : "广东",
		45 : "广西",
		46 : "海南",
		50 : "重庆",
		51 : "四川",
		52 : "贵州",
		53 : "云南",
		54 : "西藏",
		61 : "陕西",
		62 : "甘肃",
		63 : "青海",
		64 : "宁夏",
		65 : "新疆",
		71 : "台湾",
		81 : "香港",
		82 : "澳门",
		91 : "国外"
	};

	checktheform = function() {
		var card = document.getElementById('card_no').value;
		//是否为空
		if (card === '') {
		document.getElementById('hidden').innerHTML="请输入身份证号，身份证号不能为空";
			
			document.getElementById('card_no').focus;
			return false;
		}
		//校验长度，类型
		if (isCardNo(card) === false) {
			
			document.getElementById('hidden').innerHTML="您输入的身份证号码不正确，请重新输入";
			document.getElementById('card_no').focus;
			return false;
		}
		//检查省份
		if (checkProvince(card) === false) {
			
			document.getElementById('hidden').innerHTML="您输入的身份证号码不正确,请重新输入";
			document.getElementById('card_no').focus;
			return false;
		}
		//校验生日
		if (checkBirthday(card) === false) {
			
			document.getElementById('hidden').innerHTML="您输入的身份证号码生日不正确,请重新输入";
			document.getElementById('card_no').focus();
			return false;
		}
		//检验位的检测
		if (checkParity(card) === false) {
		
			document.getElementById('hidden').innerHTML="您的身份证校验位不正确,请重新输入";
			document.getElementById('card_no').focus();
			return false;
		}
		document.getElementById('hidden').innerHTML="正确的身份证号码";
		return true;
	};

	//检查号码是否符合规范，包括长度，类型
	isCardNo = function(card) {
		//身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
		var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/;
		if (reg.test(card) === false) {
			return false;
		}

		return true;
	};

	//取身份证前两位,校验省份
	checkProvince = function(card) {
		var province = card.substr(0, 2);
		if (vcity[province] == undefined) {
			return false;
		}
		return true;
	};

	//检查生日是否正确
	checkBirthday = function(card) {
		var len = card.length;
		//身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
		if (len == '15') {
			var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/;
			var arr_data = card.match(re_fifteen);
			var year = arr_data[2];
			var month = arr_data[3];
			var day = arr_data[4];
			var birthday = new Date('19' + year + '/' + month + '/' + day);
			return verifyBirthday('19' + year, month, day, birthday);
		}
		//身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
		if (len == '18') {
			var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/;
			var arr_data = card.match(re_eighteen);
			var year = arr_data[2];
			var month = arr_data[3];
			var day = arr_data[4];
			var birthday = new Date(year + '/' + month + '/' + day);
			return verifyBirthday(year, month, day, birthday);
		}
		return false;
	};

	//校验日期
	verifyBirthday = function(year, month, day, birthday) {
		var now = new Date();
		var now_year = now.getFullYear();
		//年月日是否合理
		if (birthday.getFullYear() == year
				&& (birthday.getMonth() + 1) == month
				&& birthday.getDate() == day) {
			//判断年份的范围（3岁到100岁之间)
			var time = now_year - year;
			if (time >= 3 && time <= 100) {
				return true;
			}
			return false;
		}
		return false;
	};

	//校验位的检测
	checkParity = function(card) {
		//15位转18位
		card = changeFivteenToEighteen(card);
		var len = card.length;
		if (len == '18') {
			var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5,
					8, 4, 2);
			var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4',
					'3', '2');
			var cardTemp = 0, i, valnum;
			for (i = 0; i < 17; i++) {
				cardTemp += card.substr(i, 1) * arrInt[i];
			}
			valnum = arrCh[cardTemp % 11];
			if (valnum == card.substr(17, 1)) {
				return true;
			}
			return false;
		}
		return false;
	};

	//15位转18位身份证号
	changeFivteenToEighteen = function(card) {
		if (card.length == '15') {
			var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5,
					8, 4, 2);
			var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4',
					'3', '2');
			var cardTemp = 0, i;
			card = card.substr(0, 6) + '19' + card.substr(6, card.length - 6);
			for (i = 0; i < 17; i++) {
				cardTemp += card.substr(i, 1) * arrInt[i];
			}
			card += arrCh[cardTemp % 11];
			return card;
		}
		return card;
	};
	var name2=document.getElementById("name");
	var identify=document.getElementById("card_no");
	function fun1(){
	/* var name2=document.getElementById("name");
	var identify=document.getElementById("card_no"); */
      if(identify.value==""){
    document.getElementById('hidden').innerHTML="请填写身份证信息";
      return false;
      }
	
	 ajaxRequestDogetJsonp("<%=basePath%>person/updatepersonal");
	
	}
	 function successback(data) {
		alert("修改成功");
		
		
    	}
    
        function errorback() {
		alert("失败");
    	} 
            
        function ajaxRequestDogetJsonp(getUrl){
      /*   alert(getUrl);
       
        alert(identify.value); */
 		 var obj={
 		 "typeId":"${typeId}",
 		 "identify":identify.value
 		};  
        $.ajax({
             type: "post",
             url: getUrl,  
             async:false,           
             dataType: "html",
             data:obj,
             success: successback,
             error: errorback
         });         
         } 
</script>

