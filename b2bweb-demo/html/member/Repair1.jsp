<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/mchead.jsp"%>
<script type="text/javascript" src="http://www.cdzer.com:8083/analytics/ip" charset="utf-8"></script>       <!--获取ip接口数据，注意 -->
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script src="<%=basePath%>html/js/join.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
<script>
begain('<%=basePath%>');
</script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
<!--   </head> 
  <body> -->
   <div id="container-fluid">
	    <div class="row" id="con">
	        <div id="con-top">
	               <h1>入驻维修商</h1>
	        </div>
	        <div id="con-blow">
            	<div class="formBox">
	            	<form action="" method="post" name="form1">
	            	
	        			<table width="100%" border="0" cellspace="0" >
	        	        	<tr>
				        	  <td align="right">公司名称：</td>
				        	  <td>
			                      <input id="companyName" name="companyName" value="${key.wxsName }" type="text"  class="form-control"onblur="validatelegalName('companyName');"placeholder="如：XXX有限公司"/>
				        	      <span class="message" >公司名称不能为空[]</span>
			                      <span class="messageShow" ></span>
				        	  </td>
				        	</tr>
				        	<tr>
				        	   <td align="right">联系人：</td>
				        	   <td>
				        	   	   <input id="urgentUser" name="urgentUser" type="text" value="${key.urgentUser }"
				        	       class="form-control"onblur="validatelegalName('urgentUser');" placeholder="如：张三"/>
				        	       <span class="message" >联系人不能为空[]</span>
			                       <span class="messageShow"></span>
			                   </td>
				        	</tr>
				        	<tr>
				        	    <td align="right">联系电话：</td>
				        	    <td>
				        	    	<input id="urgentTel" name="urgentTel" type="text" class="form-control" value="${key.urgentTel }"
 
				        	    	 onblur="validatelegalTel('urgentTel');"  placeholder="如：1557595****"/>
 
  
				        	        <span class="message" >联系电话不正确</span>
			                        <span class="messageShow"></span>
				        	    </td>
				        	</tr>
				        	<tr>
				        	    <td align="right">详细地址：</td>
				        	    <td>
				        	    	<input name="address" type="text" id="address" value="${key.address}" class="form-control" oninput="searchByStationName();" placeholder="如：XX省XX市XX区XX街道X号"/>
				        	        <span class="message" >详细地址不能为空[]</span>
			                        <span class="messageShow" ></span>
				        	    </td>
				        	</tr>
				        	<tr>
				        	    <td align="right"></td>
				        	    <td>
				        	        <input name="latlon" type="hidden" id="latlon" class="form-control"/>
				        	         <input name="wxsId" type="hidden" id="wxsId" value="${wxsId}" class="form-control"/>
		                        </td>
				        	</tr>	
  						</table>
		  				<div id="button" style="margin-left:250px;margin-top:20px;">
				           <button id="lastButton" type="button" class="btn btn-primary" onclick="javascript:history.go(-1);">返回</button>
				           <button id="nextButton" type="button" class="btn btn-warning" onclick="nextFun3('<%=basePath%>')">申请</button>
			       	    </div>
  					</form>

  					<div style="width:435px;float:right;color:#ccc;"><p>车队长温馨提示：您的申请我们将在24小时内联系您,任何疑问您可以联系<p style="text-indent: 2em;">您的专职汽车管家或致电0731-88865777</p></p></div>
  				</div>
  				<div class="mapBox">
  				<div ><h3>以下红色标注为当前城市已经加盟的商家</h3></div>
  				    <%@ include file="../public/map.jsp"%>
  				</div>
    		</div>
	    </div>
        <div id="line" style="color:#499ad9" > </div>
    </div>   

<%@ include file="../public/foot.jsp"%>
<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
   var latlon=$("#latlon").val();
  
 if(latlon.indexOf("|")<0){
 createMap();
 }
  
   var wxs_json;
  
	function queryNearStore(){
	 var cityId=$("#latlon").val();
                 $.ajax({
                type:"POST",
               data:{city:cityId},
               url:"<%=basePathpj%>ajax/wxsNameList",
               async:false,
               dataType:"JSON",
               success:function(data){
               wxs_json=data; 
                //wxsTelphone,serviceTime ,wxsName, address, userShopLogo
                   //根据  城市 id 获取对应的 维修商 加信息
               if(data.length>0){  
               shows();
               } 
               },
               error:function(){
                   
               }
                              });
           
   }         
</script>
<script>

var latlon=$("#latlon").val();
if(latlon!=""){
searchByStationName();
} 
     function shows(){
		var wxsMap= wxs_json[0].map; 
		var wxsTelphone= document.all['wxsTelphone'];
		var serviceTime= document.all['serviceTime'];
		var wxsName= document.all['wxsName'];
		var address= document.all['address3'];
		var userShopLogo= document.all['userShopLogo'];
		if(wxsMap==undefined ){//一条记录时执行 
 		//	var reference=wxsMap.split("|");
			//var longitude=reference[0];//经度
			//var latitude=reference[1];//纬度
			var point = new BMap.Point(112.945333,28.233971);//112.945333|28.233971
			addMarker(112.945333,28.233971,1,1,1,1,0);
		}else if(wxs_json.length>0){//多条记录时执行
		
			for(var i=0; i<wxs_json.length; i++){
				var reference=wxs_json[i].map.split("|");
				var longitude=reference[0];//经度
				var latitude=reference[1];//纬度
				var point = new BMap.Point(longitude,latitude);
				
				addMarker(longitude,latitude,wxs_json[i].wxsTelphone,wxs_json[i].serviceTime,wxs_json[i].wxsName,wxs_json[i].address,i);
			
				}
		}
	}
	
 </script>