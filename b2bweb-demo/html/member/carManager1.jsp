<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/mchead.jsp"%>
  <script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<script src="<%=basePath%>html/js/md5.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
<script type="text/javascript" src="http://www.cdzer.com:8083/analytics/ip" charset="utf-8"></script>       <!--获取ip接口数据，注意 -->
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script src="<%=basePath%>html/js/join.js"></script>
 <script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
  <script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
<script>
begain('<%=basePath%>');
var position = "null";
</script>
<!--   </head> 
  <body> -->
   <div id="container-fluid">
	    <div class="row" id="con">
	    	<div id="con-top">
	        	<h1>商家申请</h1>
	        </div>
	        <div id="con-blow">
               <div class="formBox">
	          	 <form action="" method="post" name="form1">
	        		<table width="100%" border="0" cellspace="0" >
	      	        <tr>
		        	   <td align="right">公司名称：</td>
		        	   <td><input id="companyName" name="companyName" value="" type="text" class="form-control" onblur="validatelegalName('companyName');"/>
		        	      <span class="message" >公司名称不能为空[]</span>
	                      <span class="messageShow" ></span>
		        	  
		        	   </td>
		        	</tr>
		        	<tr>
		        	  <td align="right">联系人：</td>
		        	   <td> <input id="urgentUser" name="urgentUser" type="text"  value="" class="form-control" onblur="validatelegalName('urgentUser');"/>
		        	          <span class="message" >联系人不能为空[]</span>
	                      <span class="messageShow"></span>
		        	   </td>
		        	   
		        	</tr>
		        	<tr>
		        	  <td align="right">联系电话：</td>
		        	  <td> <input id="urgentTel" name="urgentTel"  value=""  type="text" class="form-control" />
		        	     <span class="message" >联系电话不正确[]</span>
	                      <span class="messageShow"></span>
		        	  </td>
		        	</tr>
		        	<tr>
		        	  <td align="right">详细地址：</td>
		        	  <td> <input  name="address" id="address" value="" type="text" class="form-control" oninput="searchByStationName();" onblur="validatelegalAddress('address');"placeholder="如：XX省XX市XX区XX街道X号""/>
		        	   <span class="message" >详细地址不能为空[]</span>
	                      <span class="messageShow"></span>
		        	  </td>
		        	 
		        	</tr>
		        	<tr>
		        	  <td align="right">渠道商：</td>
		        	  <td> <select class="form-control" id="agency">
		        	     
		        	  </select>
		        	  </td>
		        	</tr>
		        	<tr>
		        	    <td align="right"></td>
		        	    <td>
		        	        <input name="latlon" type="hidden" id="latlon" class="form-control"/>
		        	         <input name="wxsId" type="hidden" id="wxsId" class="form-control"/>
	                    </td>
		        	</tr>	
				</table>
  				<div id="button" style="margin-left:250px;margin-top:20px;">
		           <button id="lastButton" type="button" class="btn btn-primary" onclick="javascript:history.go(-1);">返回</button>
		           <button id="nextButton" type="button" class="btn btn-warning" onclick="nextFun6('<%=basePath%>','<%=gpsPath%>');">申请</button>
	       	    </div>
  				</form>
  				<div style="width:435px;float:right;color:#ccc;"><p>车队长温馨提示：您的申请我们将在24小时内联系您,任何疑问您可以联系<p style="text-indent: 2em;">您的专职汽车管家或致电0731-88865777</p></p></div>
  				</div>
  				<div class="mapBox">
  				以下红色标注为当前城市已经加盟的商家<img src="<%=basePath%>html/images/point.png"/>
  				   <%@ include file="../public/map.jsp"%>
  				</div>
	    	</div>
	    </div>
       
    </div>   
<div style="margin-top: 90px;"> <%@ include file="../public/foot.jsp"%></div>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
 
<link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
<script>
   var latlon=$("#latlon").val();
 if(latlon.indexOf("|")<0){
 	createMap();
 }else{
searchByStationName();
}


 var wxs_json;
  
	function queryNearStore(){
	 var cityId=$("#latlon").val();
                 $.ajax({
                type:"POST",
               data:{city:cityId},
               url:"<%=basePathpj%>ajax/cwNameList",
               async:false,
               dataType:"JSON",
               success:function(data){
               wxs_json=data; 
                //wxsTelphone,serviceTime ,wxsName, address, userShopLogo
                   //根据  城市 id 获取对应的 维修商 加信息
                   
               shows();
               },
               error:function(){
                      
               }
                              });
           
   }         
   
    function shows(){
		var wxsMap= wxs_json[0].map; 
		var companyName= document.all['companyName'];
		var urgentTel= document.all['urgentTel'];
		var address= document.all['address3'];
		if(wxsMap==undefined ){//一条记录时执行 
 		
			var point = new BMap.Point(112.945333,28.233971);//112.945333|28.233971
			addMarker(112.945333,28.233971,1,1,1,1,0);
		}else if(wxs_json.length>0){//多条记录时执行
		
			for(var i=0; i<wxs_json.length; i++){
				var reference=wxs_json[i].map.split("|");
				var longitude=reference[0];//经度
				var latitude=reference[1];//纬度
				var point = new BMap.Point(longitude,latitude);
				
				addMarker1(longitude,latitude,wxs_json[i].companyName,wxs_json[i].urgentTel,wxs_json[i].address,i);
			
				}
		}
	}
	
    var bufferdata1 = "";
    var bufferdata2 = "";
	var buffer = ""; 
     KindEditor.ready(function(K) {
      
        
     var editor1 = K.editor({
      uploadJson : '<%=uploadUrl%>?root=demo-basic-idCard',
    	//店铺全景图路径
         allowFileManager : true
    });
     K('#upload-full-img').click(function() {  
        editor1.loadPlugin('multiimage', function() {
            editor1.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata1=data.url;
                       document.getElementById("idCardfront").value=bufferdata1;
                        
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

 
 
  K('#upload-full-img2').click(function() {  
        editor1.loadPlugin('multiimage', function() {
            editor1.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata2=data.url;
                          document.getElementById("idCardverso").value=bufferdata2;
                       var objRow = document.getElementById("showImg2"); 
                           var  img="";
                             objRow.innerHTML=img;
                        $('#showImg2').append('<img id="litpic6" style="width:150px;height:150px;" src="' + data.url + '">');
                        var b = document.getElementById("litpic6").src; 
                     });
                     editor1.hideDialog();
                     
                  }
            });
        });
    });
 });
 
 
 
var name = "${admin}";
var pwd = "${code}";
//alert(name);
		function authShow(url) {
			name = $.trim(name);
			pwd = hex_md5(name + pwd);// 加密
			if (name == "") {
				alert('用户名不能为空！');
				return;
			}
			$.ajax({
				type : 'get',
				url : url + "login.do",
				async : false,
				data : {
					name : name,
					pwd : pwd,
				},
				dataType : "jsonp",
				success : function(result) {
					var status = result.msgCode;
					if ('0' == status) {
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
						alert("用户名和密码不一致！!!");
						return;
					}
				}
			});
		};
		authShow("<%=gpsPath%>"); 
 $.ajax({
			type : "GET",
			url : "<%=gpsPath%>operatorTwo/selChan.do",
			async : false,
			dataType : "jsonp",
			success : function(dat) {
			$("#agency").html("<option value='admin'>总渠道商</option>");
				for(var i=0;i<dat.length;i++){
				$("#agency").append("<option value='"+dat[i].code+"'>"+dat[i].name+"</option>");
				}
				
				
			},
			error : function() {
				alert("fail");

			}
		});
 
   
</script>