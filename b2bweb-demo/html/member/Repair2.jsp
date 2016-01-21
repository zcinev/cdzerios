<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ include file="../public/mchead.jsp"%>
     <script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
<style>
#box{
     width:100%;
	 height:60%;
	 margin-left:0;
	 margin-right:0;
	
    }    
#top{
     margin-top:10px;
     width:100%;
     height:104px;
    /*  background-color:red; 
     border:1px solid black; */
    } 
#top-left{
     width:50%;
     margin-left:250px;
     text-align:left;
     float:left;
}  
#top-right{
     margin-top:10px;
     width:30%;
     float:right;
} 

#con{
	 margin-top:10px; 
	 height:auto;
	 border-top:2px solid #499ad9;
	 border-left:1px solid #ccc;
     border-right:1px solid #ccc;
     border-bottom:1px solid #ccc;
    /*  background-color:yellow; */
  }  
#c-left{
    float:left;
    margin-left:20px;  
 }
#c-right{
    float:right; 
    margin-right:20px;  
 }
#con-title{
   clear:both;
   margin-left:20px;
   margin-top:20px;
   margin-bottom:40px;
}
#con-blow{
 
   margin-left:20px;
}
#table{
  /* width:58%; */
  float:left;
 /*  background-color:red; */ 
 
}
#table1{
  width:100%;
 
}
#pic{
  width:35%;
  float:right;
}
#pic1{
  height:40%;
}
#pic2{
  margin-top:920px;
  margin-bottom:20px;
}
 
#button{
 /*  float:right; */
  margin-left:40%;
  margin-bottom:20px;
}
#line{
 width:80%;
 margin-left:100px;
 clear:both;
 margin-top:50px;
 border-bottom:1px solid #499ad9;
}   
#bottom{
  width:100%;
  clear:both;
  height:10%;
  margin-top:50px;
 
  text-align:center;
}
a{
 text-decoration:none;
 color:#000;
}
a:link{
  text-decoration:none;
  color:#000;
}
td{
 padding:2px 0px;
}
#table2{
  width:55%;
  float:left;
 /*  background-color:red; */ 
 
}
.idCarBox1{
float:left;
width:460px;
min-height:200px;
border:1px solid #ccc;
}
.sheshi{
border:1px solid #ccc;
width:460px;
min-height:150px
}
.sheshibox{
float:left;
margin-left:40px;
margin-top:10px;
width:150px;
}
.newDiv{
width:800px;
height:auto;
border:1px solid #ccc;
background:#f8f8f8;
}
.sureBox{
float:right;
margin-top:40px;
margin-right:20px;
}

.find-letter {
    color: #666666;
    height: 27px;
    line-height: 18px;
    padding: 5px 0px;
}

.fn-left {
    display: inline;
     float: left;
}
   
.find-letter-list {
    float: left;
}

.find-letter-list li {
    float: left;
    margin-right: 7px;
    list-style:none;
}


.find-letter-list li a {
    display: inline-block;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 14px;
    font-weight: bold;
    height: 18px;
    line-height: 18px;
    width: 16px;
}
</style>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script src="<%=basePath%>html/js/join.js"></script>
 <script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
  <script type="text/javascript" src="<%=basePath%>html/My97DatePicker/WdatePicker.js"></script>
    <script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>

      $(document).ready(function () { 
          $('input').iCheck('destroy');
       	 getFacilities("<%=basePath%>");
       	 getRepairItem("<%=basePath%>");
       	 
 var deliveryFacility="${key.deliveryFacility}";
var array=deliveryFacility.split(",");
var facilitiesStr1=document.getElementsByName("facilities");
for(var k=0;k<array.length;k++){
	for(var j=0;j<facilitiesStr1.length;j++){
	var s1=array[k];
	var s2=facilitiesStr1[j].value;
		if(s1==s2){
		facilitiesStr1[j].checked=true;
		}
	}
}


var Maintenance="${key.MaintenanceProjectId}";
var array1=Maintenance.split(",");
var MaintenanceProjectId1=document.getElementsByName("MaintenanceProjectId");
for(var k=0;k<array1.length;k++){
	for(var j=0;j<MaintenanceProjectId1.length;j++){
	var s1=array1[k];
	var s2=MaintenanceProjectId1[j].value;
		if(s1==s2){
		MaintenanceProjectId1[j].checked=true;
		}
	}
}


var repairitem1="${key.serviceItemId}";
var array2=repairitem1.split(",");
var repairitem2=document.getElementsByName("repairitem");
for(var k=0;k<array2.length;k++){
	for(var j=0;j<repairitem2.length;j++){
	var s1=array2[k];
	var s2=repairitem2[j].value;
		if(s1==s2){
		repairitem2[j].checked=true;
		}
	}
}

    });

</script>
<style>
h1{
font: normal 24px/36px 'Microsoft yahei';
}
</style>
    <div id="container-fluid">
	
	     <div class="row" id="con">
	        <div id="con-top">
	             <div id="c-left">
		         <h1>入驻维修商</h1>
		         </div>
		         <div id="c-right">
		         <img src="<%=basePath%>html/img/join/car_04.jpg">
		         </div>
	        </div>
	        <div id="con-blow">
	          <div id="con-title">
	          <p><strong>营业执照信息 （副本）</strong><font color="#ccc">[以下所需要上传电子版资质仅支持JPG、GIF、PNG格式的图片，大小不超过1M，且必须加盖企业彩色公章。]
              </font></p>
              </div>
                <form action="" method="post" name="form1">
                <input type="hidden" name="id" value="${key.id}">
                <input type="hidden" name="provinces2" id="provinces2" value="${key.userProvince}">
                <input type="hidden" name="citys" id="citys" value="${key.userCity}">
                
                <input type="hidden" name="userKindId1" id="userKindId1" value="${key.userKindId}">
                 <input type="hidden" name="service" id="service" value="${key.serviceTime}">
                 
              <div id="table">
             <!--  <div id="table1"> -->
	        
	        	<table width="100%" border="0" cellspace="0" >
	        	<tr>
	        	  <td align="right">公司名称：</td>
	        	  <td> 
					  
        	  		  <input id="companyName" name="companyName" value="${key.wxsName }" type="text"  class="form-control"onblur="validatelegalName('companyName');"/>
        	  		  
	        	      <span class="message" >公司名称不能为空[]</span>
                      <span class="messageShow" ></span></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">商家类型：</td>
	        	  <td> <select id="userKindId" name="userKindId" class="form-control">
	        	  	</select>
	        	  	<input type="hidden" id="userKindName" name="userKindName" />
	        	  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">营业执照注册号：</td>
	        	  <td> <input id="businessLicenceNo" name="businessLicenceNo" type="text" class="form-control"
	        	  value="${key.businessLicenceNo }"
	        	  onblur="validatelegalName('businessLicenceNo');"/>
	        	       <span class="message" >营业执照注册号不能为空[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	
	      	   <tr>
	        	  <td align="right">营业执照副本电子版：</td>
                   <td>
                    <div class="col-sm-10">
                    <a href="javascript:;" id="upload-full-img" class="btn btn-primary"><img alt="" src="<%=basePath %>html/img/moren-upload.png">请选择要上传的图像</a>
                    </div> 
	        	</td>
	        	</tr>
	        	
	        	<tr>
	        	<td  align="right">	</td>
	        	<td>
	     		   <div class="idCarBox1" >
	     		      <div class="col-sm-10" id="showImg1">
                        <img id="litpic5" style="width:150px;height:150px;" src="${key.businessLicence }" alt="">
                         </div>
	     		   </div>
	     		   </td>
	        	</tr>
	        
	        	<tr>
	        	  <td align="right">营业执照详细地址：</td>
	        	 <td> <input id="licenceAddress" name="licenceAddress" type="text" class="form-control"
	        	  value="${key.address }"
	        	 onblur="validatelegalName('licenceAddress');"/>
	        	    <span class="message" >详细地址不能为空[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">成立日期：</td>
	        	  <td> <input id="buildDate" name="buildDate" type="text"
	        	   value="${key.addtime }"
	        	   class="form-control" onclick="new Calendar().show(this);" onmousemove="validatelegalName('buildDate');"/>
	        	    <span class="message" >成立日期不能为空[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">营业时间：</td>
	        	  <td> <div class="form-inline">
	        	  <select name="week1" id="week1" class="form-control" style="width:90px;">
                        <option value="星期一">星期一</option>
                        <option value="星期二">星期二</option>
                        <option value="星期三">星期三</option>
                        <option value="星期四">星期四</option>
                        <option value="星期五">星期五</option>
                        <option value="星期六">星期六</option>
                        <option value="星期天">星期天</option>
                        </select>—
                   <select name="week2" id="week2" class="form-control" style="width:90px;">
                        <option value="星期一">星期一</option>
                        <option value="星期二">星期二</option>
                        <option value="星期三">星期三</option>
                        <option value="星期四">星期四</option>
                        <option value="星期五">星期五</option>
                        <option value="星期六">星期六</option>
                        <option value="星期天">星期天</option>
                                    </select>
                   <input type="text" class="form-control" name="time1" id="time1" style="width:90px;" placeholder="开门时间" onclick="WdatePicker({dateFmt:'HH:mm'});" onblur="validatelegalName('time1');" >
                   <span class="message" >开门时间不能为空[]</span>
                      <span class="messageShow"></span>
                        —
                    <input type="text" class="form-control"  name="time2" id="time2" style="width:90px;" placeholder="关门时间" onclick="WdatePicker({dateFmt:'HH:mm'});"onblur="validatelegalName('time2');">
                    <span class="message" >关门时间不能为空[]</span>
                      <span class="messageShow"></span>
                                    </div>
	        	</td>
	        	</tr>
	        	<tr>
	        	  <td align="right">注册资本（万）：</td>
	        	  <td> <input id="regCapital" name="regCapital" type="text"
	        	    value="${key.regCapital }" placeholder="200（万）"
	        	   class="form-control"onblur="validateMileage('regCapital');"/>
	        	         <span class="message" >请输入数字部门[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">综合设施：</td>
	        	  <td>
                 <div class="sheshi" id="facility">
                 <div class="sheshibox"><input type="checkbox" name="sheshi">设施一</div>
                  </div>
                 <div id="allBrandStr"></div>
				  </td>
	        	</tr>
	        	 
	        	<tr>
	        	  <td align="right">服务项目：</td>
 	        	  <td>
 	        	  <div id="MaintenanceProjectD">
                &nbsp;&nbsp;<input type="checkbox" name="MaintenanceProjectId" id="MaintenanceProjectId" value="1">常规保养项目&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" name="MaintenanceProjectId" id="MaintenanceProjectId" value="2">深度保养项目
                </div>
                <div id="ProjectDStr"></div>
				  </td>
	        	</tr>
	        	
	        	<tr>
	        	  <td align="right">维修项目：</td>
	        	  <td>
                  <div class="sheshi" id="repairItem">
                 <div class="sheshibox"><input type="checkbox" name="sheshi">设施一</div>
                 </div>
                 <div id="repairItemStr"></div>
				  </td>
	        	</tr>

						<tr>
							<td align="right">服务品牌：</td>
							<td>
								<div class="col-sm-10 form-inline" id="selectBrand" >
									    <c:forEach var="mkey" items="${skey}">
                                                    <label for="major1" class="control-label" >
                                                    <input value="${mkey['brandId']}" type="checkbox" class="form-control" name="repair1" checked='checked'  id="repair1" onclick="changeBrands2('${mkey['brandId']}')"> ${mkey['brandName']}
                                                     </label> 
                                                    </c:forEach>
								</div>
								
								</td>
						</tr>	
	<tr>
					<td align="right">&nbsp;</td>
<td>
								<!-- <div class="col-sm-10 form-inline">
									<div class="find-letter form-control"> -->
										<ul class="find-letter-list">
											<li><a href="javascript:showBrand('A');">A</a>
											</li>
											<li><a href="javascript:showBrand('B');">B</a>
											</li>
											<li><a href="javascript:showBrand('C');">C</a>
											</li>
											<li><a href="javascript:showBrand('D');">D</a>
											</li>
											<li><a href="javascript:showBrand('F');">F</a>
											</li>
											<li><a href="javascript:showBrand('G');">G</a>
											</li>
											<li><a href="javascript:showBrand('H');">H</a>
											</li>
											<li><a href="javascript:showBrand('J');">J</a>
											</li>
											<li><a href="javascript:showBrand('K');">K</a>
											</li>
											<li><a href="javascript:showBrand('L');">L</a>
											</li>
											<li><a href="javascript:showBrand('M');">M</a>
											</li>
											<li><a href="javascript:showBrand('N');">N</a>
											</li>
											<li><a href="javascript:showBrand('O');">O</a>
											</li>
											<li><a href="javascript:showBrand('Q');">Q</a>
											</li>
											<li><a href="javascript:showBrand('R');">R</a>
											</li>
											<li><a href="javascript:showBrand('S');">S</a>
											</li>
											<li><a href="javascript:showBrand('T');">T</a>
											</li>
											<li><a href="javascript:showBrand('W');">W</a>
											</li>
											<li><a href="javascript:showBrand('X');">X</a>
											</li>
											<li><a href="javascript:showBrand('Y');">Y</a>
											</li>
											<li><a href="javascript:showBrand('Z');">Z</a>
											</li>

										</ul>
									
									</td>
									</tr>
									<tr>
									<td></td>
									<td>
									
									<div id="allBrand">
                                         <c:forEach var="mkey" items="${key3}">
                                          <label for="major1" class="control-label"  ></label>
                                           <li style="margin-left:5px;display:inline;" onclick="changeBrands('${mkey['id']}')">${mkey['name']}</li>
                                         
                                  </c:forEach>
                                          </div>
                                          <div id="selectBrandStr"></div>
									</td>
									</tr>
									
									<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
						<tr>
					
	        	  <td align="right">公司所在地：</td>
	        	  <td>
				<div class="form-inline">
                                    <select name="province" id="province-box" class="form-control" style="width: 138px;">
                                        <option value="${key.userProvince }">${key.userProvinceName }</option>
                                    </select>
                                    <select name="city" id="city-box" class="form-control" style="width: 138px;">
                                       <option value="${key.userCity }">${key.userCityName }</option>
                                    </select>
                                    <select name="region" id="area-box" class="form-control" style="width: 138px;" onblur="validatelegalName2('area-box');">
                                        <option value="${key.userRegion }">${key.userRegionName }</option>
                                    </select>
 	        	         <span class="message" >公司地址不能为空[]</span>
                      <span class="messageShow"></span>
                                </div>
					 
				  </td>
	        	</tr>
	        	<tr>
	        	  <td align="right">公司详细地址：</td>
	        	  <td> <input  name="address" type="text" id="address2" value="${key.address}" class="form-control"onblur="validatelegalName('address2');"/>
	        	   <span class="message" >详细地址不能为空[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">公司电话：</td>
	        	  <td> <input id="tel" name="tel" type="text" value="${key.wxsTelphone }" class="form-control"/>
	        	     <span class="message" >公司电话格式不正确[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">公司紧急联系人：</td>
	        	   <td> <input id="urgentUser" name="urgentUser" type="text" 
	        	   value="${key.urgentUser }"
	        	   class="form-control"onblur="validatelegalName('urgentUser');"/>
	        	          <span class="message" >紧急联系人不能为空[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">公司紧急联系人手机：</td> 
	        	  <td> <input id="urgentTel" name="urgentTel"
	        	   value="${key.urgentTel }"
	        	   type="text" class="form-control"onblur="validatelegalTel('urgentTel');"/>
	        	     <span class="message" >联系人手机格式不正确[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	<tr>
	        	<td><strong>组织机构代码证</strong></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">组织机构代码：</td>
	        	  <td> <input id="organizationNo" name="organizationNo"
	        	    value="${key.organizationNo }"
	        	   type="text" class="form-control"onblur="validatelegalName('organizationNo');"/>
	        	     <span class="message" >组织机构代码不能为空[]</span>
                      <span class="messageShow"></span></td>
	        	</tr>
	        	<tr>
	        	  <td align="right">代码有效期限：</td>
	        	<td><input id="orgDeadline" name="orgDeadline" 
	        	 value="${key.orgDeadline }"
	        	type="text" class="form-control" onclick="new Calendar().show(this);" onmousemove="validatelegalName('orgDeadline');"/>
	        	   <span class="message" >代码有效期限不能为空[]</span>
                      <span class="messageShow"></span> </td>
	        	</tr>
	        	
	        	<tr>
	        	  <td align="right">代码电子版：</td>
	        	  <td>
	        	   <div class="col-sm-10">
	        	        <a href="javascript:;" id="upload-full-img2" class="btn btn-primary"><img alt="" src="<%=basePath %>html/img/moren-upload.png">请选择要上传的图像</a>
	        	        </div>
	        	  </td>
	        	</tr>
	        	<tr>
	        	<td  align="right">	</td>
	        	<td>
	     		   <div class="idCarBox1" id="">
	     		    <div class="col-sm-10" id="showImg2">
                       <img id="litpic6" style="width:150px;height:150px;" src="${key.orgPicture }" alt="">
                         </div>
	     		   </div>
	     		   </td>
	        	</tr>
	        	</table>
	        
  				<!-- </div> -->
	        </div>
	   		
	 <div class="newDiv" id="newDiv" style="position:absolute;left:20%;top:600px;z-index:2;display:none;">
    
     <div class="sheshibox"><input type="checkbox" name="sheshi">设施一</div>
    
          <div class="sureBox"><input type="button" value="确定"></div>
	</div>
	
	<div id="card1"><input type="hidden" name="businessLicence" id="businessLicence" value=""></div>
  	<div id="card2"><input type="hidden" name="orgPicture" id="orgPicture" value=""></div>
  				
	        </form>
	        </div>
	        <div id="pic">
	          <div id="pic1"><img src="<%=basePath%>html/img/join/car_02.jpg"/></div>
	          <div id="pic2"><img src="<%=basePath%>html/img/join/car_03.jpg"/></div>
	          <div id="button">
		           <button id="lastButton" type="button" class="btn btn-warning" onclick="javascript:history.go(-1);">上一步</button>
		           <button id="nextButton" type="button" class="btn btn-primary" onclick="nextFun4('<%=basePath%>');" >下一步</button>
	       	    </div>
	        </div>
	    </div>
          <div id="line" style="color:#499ad9"> </div>
    </div>     
    
  
    
  <%@ include file="../public/foot.jsp"%>
  <script>
   
  </script>
   
   <script>
  var repair="";
 function Repair2(url) {
      var facilitiesStr=document.getElementsByName("facilities");
                     
                  for(var i=0;i<facilitiesStr.length;i++){
                      if(facilitiesStr[i].checked){
                        repair+=facilitiesStr[i].value+",";
                      }
                  }
                   
                   var MaintenanceD=document.getElementsByName("MaintenanceProjectId");
                     var ProjectD="";
                  for(var i=0;i<MaintenanceD.length;i++){
                      if(MaintenanceD[i].checked){
                        ProjectD+=MaintenanceD[i].value+",";
                      }
                  }
                  
                    var repairItem=document.getElementsByName("repairitem");
                     var repairItemDT="";
                  for(var i=0;i<repairItem.length;i++){
                      if(repairItem[i].checked){
                        repairItemDT+=repairItem[i].value+",";
                      }
                  } 
                  var repairBrands=document.getElementsByName("repair1");
                     var repairBB="";
                  for(var i=0;i<repairBrands.length;i++){
                      if(repairBrands[i].checked){
                        repairBB+=repairBrands[i].value+",";
                      }
                  }
   var idCardfront = document.getElementById("businessLicence").value;
 	var idCardverso = document.getElementById("orgPicture").value;
	var check = true;
 	if (!validatelegalName('companyName')) {
		check = false;
	}
	alert(check+"1");
	if (!validatelegalName('businessLicenceNo')) {
		check = false;
	}
   alert(check+"2");
    
	if (!validatelegalName('licenceAddress')) {
		check = false;
	}
alert(check+"3");
	if (!validatelegalName('buildDate')) {
		check = false;
	}
	alert(check+"4");
	if (!validatelegalName('time1')) {
		check = false;
	}
	alert(check+"5");
	if (!validatelegalName('time2')) {
		check = false;
	}
	alert(check+"6");
	if (!validateMileage('regCapital')) {
		check = false;
	}
	alert(check+"7");
	if (!validatelegalName('editor')) {
		check = false;
	}
	 alert(check+"8");     
          
	if (!validatelegalName('address2')) {
		check = false;
	}alert(check+"9");
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
	if (!validatelegalName2('area-box')) {
		check = false;
	}
 	if (idCardfront == "") {
		$('#showImg1').html("请上传图像！").css({"color":"red"});
		check = false;
	}
	if (idCardverso == "") {
		$('#showImg2').html("请上传图像！").css({"color":"red"});
		check = false;
	}
	   
	 if (validatelegalName3()) {
  		check = false;
 	} 
 	  
 	 if (ProjectD=="") {
 	 
 	 $('#ProjectDStr').html("请选择服务项目！").css({"color":"red"});
		check = false;
 	}else{
 	    $('#ProjectDStr').html("");
 	}
 	 if (repairItemDT=="") {
 	 
 	 $('#repairItemStr').html("请选择维修项目！").css({"color":"red"});
		check = false;
 	} else{
 	$('#repairItemStr').html("");
 	}
 	if (repairBB=="") {
  
 	 $('#selectBrandStr').html("请选择服务品牌！").css({"color":"red"});
		check = false;
		}else{
		$('#selectBrandStr').html("");
		}
		
	if (check == false) {
 		return;
	}
 	document.form1.action = url + "join/repairInfo2?province1=" + province
			+ "&city1=" + city + "&region1=" + region + "&majorBrand="
			+ majorBrand;
	document.form1.submit();
}


 </script> 
  <script>
/**
 * 验证是否为空
 */
function validateNull(obj){
    	var message = $(obj).next().text();
 	if($(obj).val()==null||$(obj).val().length==0 || $(obj).val()=="0"){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
function validateCheck(obj){
  	if(repair==""){
   		 $('#allBrandStr').html("请选择综合设施！").css({"color":"red"});
  		return false;
	}else{
  		$('#allBrandStr').html("");
  		return true;
  	}
	return true;
}
</script>

<script>
function validatelegalName2(thisEle) {
 	var _this=document.getElementById(thisEle);
  	if(!validateNull(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
 
}
function validatelegalName3() {
 	var _this=repair;
  	if(!validateCheck(_this)){
  		return false;
	} else{
		
 	return 	true;
 
	}
 
}
</script>
  <script>
pass('<%=basePath%>');
showBrand('A');

  </script>
<script>
    var bufferdata1 = "";
    var bufferdata2 = "";
	var buffer = ""; 
     KindEditor.ready(function(K) {
      
        
     var editor1 = K.editor({
      	 uploadJson : '<%=uploadUrl%>?root=demo-basic-businessLicence',
         allowFileManager : true
    });
    var editor2 = K.editor({
      	 uploadJson : '<%=uploadUrl%>?root=demo-basic-orgPicture',
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
                       document.getElementById("businessLicence").value=bufferdata1;
                        
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
        editor2.loadPlugin('multiimage', function() {
            editor2.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata2=data.url;
                          document.getElementById("orgPicture").value=bufferdata2;
                       var objRow = document.getElementById("showImg2"); 
                           var  img="";
                             objRow.innerHTML=img;
                        $('#showImg2').append('<img id="litpic6" style="width:150px;height:150px;" src="' + data.url + '">');
                        var b = document.getElementById("litpic6").src; 
                     });
                     editor2.hideDialog();
                     
                  }
            });
        });
    });
 });
</script>
<script>
	//维修商类型
      ajaxGetData('#userKindId',"<%=basePath%>member/userKind");
      
      $('#userKindId').change(function() {
  		$('#userKindName').val($(this).children(':selected').text());
   });
    distSelect("<%=basePath%>");
 var provinces=document.getElementById("provinces2").value;
 var userKindId1=document.getElementById("userKindId1").value;
 var service=document.getElementById("service").value;
 var arr1=service.substring(0,3);
 var arr2=service.substring(4,7);
  var arr3=service.substring(8,13);
  var arr4=service.substring(15,20);
$("#province-box option[value='" + provinces + "'] ").attr("selected",
				true);
$("#userKindId option[value='" + userKindId1 + "'] ").attr("selected",
				true);
$("#week1 option[value='" + arr1 + "'] ").attr("selected",
				true);
$("#week2 option[value='" + arr2 + "'] ").attr("selected",
				true);
document.getElementById("time1").value=arr3;
document.getElementById("time2").value=arr4;	


	
</script>