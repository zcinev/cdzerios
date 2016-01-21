<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/orderconfirm.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
/* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}

.addr1 {
    display: inline-block;
    vertical-align: top;
    position: relative;
    width: 237px;
    height: 106px;
    margin: 0px 5px 5px 0px;
    color: #666;
    cursor: pointer;
    background-image: url('<%=basePath%>/html/img/addr1.png');
}

.addr2 {
    display: inline-block;
    vertical-align: top;
    position: relative;
    width: 237px;
    height: 106px;
    margin: 0px 5px 5px 0px;
    color: #666;
    cursor: pointer;
    background-image: url('<%=basePath%>/html/img/addr2.png');
}
.addr-hd {
    width: 100%;
    border-bottom: 1px solid #F2F2F2;
    padding: 5px 15px;
    margin-bottom: 5px;
    height: 30px;
    line-height: 18px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
.addr-bd {
	padding: 0px 15px;
    height: 50px;
    overflow: hidden;
    word-break: break-all;
    word-wrap: break-word;
}

 .addr-toolbar {
 padding: 0px 15px;
   display: none; 
}
 .addr-toolbar2 {
 padding: 0px 15px;
}
.box{
marin-top:10px;
}
.saddr{
width:300px;
margin-left:20px;
float:left;
}
.maddr{
width:100px;
margin-right:20px;
float:right;
}
.panel-heading strong{
color: #3B5998;
font-weight: bold;
font-size: 14px;
}
</style>

<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>

   <div class="container-fluid" >
        <div class="row">
          <form action="<%=basePath%>pei/confirmOrder" method="post" onsubmit="return addressList();" > 
          
            <div class="col-md-12 paddingLeft0 paddingRight0">
              			 <input type="hidden" name="maintain" id="maintain" value="${maintain}">
              			 
              			 
                	<input type="hidden" name="sumPrice"  id="sum" value="${sum}" />
                    <div class="panel panel-default" style="border:none;">
                        <!-- Default panel contents -->
                        <div class="panel-heading" style="background-color:#fff;border-bottom:2px solid #428bca;margin: auto;width: 990px;">
                            <strong>选择收货地址</strong>
                        </div>
                        <div class="panel-body">
                        
                         <div id="allAddr">
              <input type="hidden" name="AddressLength" id="AddressLength" value="${len}">
                         
                         <c:if test="${len!='0'}">
                         <c:forEach var="mkey" items="${key}" varStatus="status">
                        <c:if test="${status.index==0}">
                         <input type="hidden" name="addr"  id="dizhi" value="${mkey['id']}" />
                         
                            
                          <div class="addr1" onclick="getAddress(this,'${mkey['id']}')">
                          <div class="addr-hd ">
                          <span>${mkey['provinceIdName']} ${mkey['cityIdName']} ${mkey['regionIdName']}</span>
							</div>
                          <div class="addr-bd ">${mkey['address']} (${mkey['name']} 收)
                          <br>联系电话:${mkey['tel']}
                          </div>
                          <div class="addr-toolbar2" onclick="editAddr(this,'${mkey['id']}');">修改</div>
                          </div>
                          </c:if>
                        <c:if test="${status.index>0}">
                        <div class="addr2" onclick="getAddress(this,'${mkey['id']}')">
                          <div class="addr-hd ">
                          <span>${mkey['provinceIdName']} ${mkey['cityIdName']} ${mkey['regionIdName']}</span>
							</div>
                          <div class="addr-bd ">${mkey['address']} (${mkey['name']} 收)
                          <br>联系电话:${mkey['tel']}
                          </div>
                          <div class="addr-toolbar" onclick="editAddr(this,'${mkey['id']}');">修改</div>
                          </div>
                        </c:if>  
                          </c:forEach>
                          </c:if>
                           <c:if test="${len=='0'}">
                           <input type="hidden" name="addr"  id="dizhi" value="">
                           </c:if>
                          <div class="addr2" id="newAdd1" onclick="addAddr(this);">
                          <div class="addr-hd "><span></span></div>
                          <div class="addr-bd">添加新地址</div>
                          <div class="addr-toolbar" id="update1">修改</div>
                          </div>
                          
                         </div> 
                         
                         
                        <div class="box">
                        <div class="saddr">显示全部地址</div>
                        </div>
                    </div>
                    
                    <div class="panel-body" id="editAddr" style="display:none">
							<input type="text" class="form-control" id="nameNameId" name="nameNameId" onblur="validatelegalName('nameNameId');"
							placeholder="请输入姓名" style="width: 200px;float: left; margin-top: 5px; margin-left: 5px;" maxlength="20">
	   						    <span class="message" >请输入姓名[]</span>
                      <span class="messageShow" ></span>
                      
	   						<input type="text" class="form-control" id="tel"  placeholder="请输入电话"   onblur="validatelegalTel('tel');"
	   						style="width: 200px;float: left;margin-top: 5px;margin-left: 5px;" maxlength="16">
							
							  <span class="message" >请输入正确的联系方式</span>
			                        <span class="messageShow"></span>
			                 <br/><br/><br/>       
							<select style="width: 200px;float: left;margin-left: 5px;" class="form-control" name="province" id="province-box" >
								<option value="0">-请选择省份-</option>
							</select>
							<select style="width: 200px;float: left;margin-left: 5px;" class="form-control" name="city" id="city-box">
								<option value="0">-请选择地市-</option>
							</select>
							<select style="width: 200px;float: left;margin-left: 5px;"
							 class="form-control" name="region" id="area-box" onblur="validatelegalAndZero1('area-box')">
								<option value="0">-请选择区县-</option>
							</select>
							<span class="message" >请选择地址[]</span>
                      <span class="messageShow" ></span>
							
							<br/><br/><br/>
							<input type="hidden" id="provinceName" name="provinceName"/>
                            <input type="hidden" id="cityName" name="cityName"/>
                            <input type="hidden" id="areaName" name="areaName"/>
							<input type="text" class="form-control" id="address"  onblur="validatelegalName('address');"
							 placeholder="请输入具体的地址" style="width: 610px;float: left;margin-left: 5px;" maxlength="100">	
							
								  <span class="message" >请输入具体的地址[]</span>
                      <span class="messageShow" ></span>				                
							<button type="button" class="btn btn-primary" id="myButton4" style="width: 80px;float: left;margin-left: 10px;" onclick="fun()">确认</button>
						</div>
                    </div>
                    
                    
                    </div>
                    <div class="panel panel-default" style="border:none;">
                        <!-- Default panel contents -->
                        <div class="panel-heading" style="background-color:#fff;border-bottom:2px solid #428bca; margin: auto;width: 990px;">
                            <strong>确认订单信息</strong>
                        </div>
                        <div class="panel-body">
                            <table class="table">
                                <tr class="tr-body-border">
                                    <th>&nbsp;</th>
                                    <th style="text-align: left;">商品名称</th>
                                    <th style="text-align: center;">商品单价</th>
                                    <th style="text-align: center;">数量</th>
                                    <th style="text-align: center;">优惠方式</th>
                                    <th style="text-align: center;">商品合计</th>
                                </tr>
                                <tbody id="ctbody">
                                <c:forEach var="mkey" items="${key1}" >
                                
                                   <input type="hidden" name="provinceName11" value="${mkey['provinceName']}">
                                   
	                                <tr class="tr-body-border">
	                                    <td colspan="6" style="color:red"><div>${mkey['centerName']}</div></td>
	                                </tr>
	                                <c:set var="index" value="1"></c:set>
	                                	   <c:forEach var="tmkey" items="${mkey['listMap']}" >
	                                	   
	                                	   <input type="hidden" name="goodsId" value="${tmkey['productId']}">
	                                	   <c:if test="${index=='1' }">
	                                	    <input type="hidden" name="mailCost" value="${mkey['sendCost']}">
	                                	   </c:if>
	                                	     <c:if test="${index!='1' }">
	                                	    <input type="hidden" name="mailCost" value="0">
	                                	   </c:if>
	                                <tr class="tr-body-border">
	                                    <td style="width: 100px;text-align: center;vertical-align: middle;">
	                                        <img src="${tmkey['productImg']}" style="width: 50px;height: 50px;" />
	                                    </td>
	                                    
	                                    
	                                    <td style="width: 450px;text-align: left;vertical-align: middle;">${tmkey['productName']}
	                                    <c:if test="${typeId!=3 }"><br>车架号：
	                                    <input type="text" name="frameNo"  value="${frameNo }" maxlength="40"  placeholder="请输入车架号"> 
	                                     </c:if>
	                                       <c:if test="${typeId==3 }">
	                                        <input type="hidden"  name="frameNo" value="" />
	                                     <select  name="frameNum"  style="width:100px;" onchange="selectFrame(this)">
	                                      <option value="">请选择车牌号</option>
	                                     <c:forEach var="cmkey" items="${ckey}">
	                                    	
	                                     	<option value="${cmkey['frameNum'] }">${cmkey['carNumber'] }</option>
	                                     </c:forEach>
	                                      </select>
	                                     </c:if>
	                                     </td>
	                                 
	                                 
	                                    <td style="width: 100px;text-align: center;vertical-align: middle;color:#f00;">¥${tmkey['tprice']} </td>
	                                    <td style="width: 100px;text-align: center;vertical-align: middle;">
	                                        <p>
	                                        	x&nbsp;${tmkey['buyCount']}
	                                        </p>
	                                    </td>
	                                    <td style="width: 150px;text-align: center;vertical-align: middle;">-</td>
	                                    <td style="width: 100px;text-align: center;vertical-align: middle;color:#f00;">¥${tmkey['subTotal']} </td>
	                                </tr>
	                                
	                                <c:set var="index" value="${index+1 }"></c:set>
                                </c:forEach>
                                <tr class="tr-body-border">
                                	<td colspan="5">
                                		<div style="width: 100px; float: left;">给卖家留言：</div>
                                		<div style=" float: left;">
                                        	<textarea name="massage" class="form-control" style="width:400px;height: 60px;" maxlength="255"></textarea>
                                        </div>
                                    </td>
                                    	
                                     <td valign="bottom">
                                  
                                     <div style="width:100px;">邮费：<input type="text" readonly="readonly" 
                                     style="width:50px;border:0px;" name="youfei"  value="${mkey['sendCost']}"></div>
                                    </td> 
                                </tr>
                              
                              </c:forEach>
                                </tbody>
                            </table>
                             
                             
                            <p class="text-right">
                           		<input type="checkbox" style="width:30px;" name="isSelect" id="isSelect"  onclick="changeCheck(this)">
                           		<input type="hidden" name="cid" id="selectid" value="0">
                               	<label for="integral">使用积分：</label>
                                <input type="text" name="credits" style="width:100px;float: right;float: right;"  oninput="selCredits()"  id="credits" value="" maxlength="10">
                                <span id="showmsg" style="display: none;color:#f00;margin-top: 2px;"></span>
                            </p>
                            
                             <p class="text-right" style="height: 50px;display:none" id="creditDiv">
                               <input type="text" id="checkcode" style="width:100px;height: 30px" placeholder="请输入短信校验码">
                               <button   id="get-ucode" type="button">获取校验码</button>
                             </p>
                             
                            
                            <p class="text-right">
                               	您有<span style="color:#f00;" id="creditsText">${credits}</span>积分，可用积分<span style="color:#f00;" id="useCre">${credits}</span>积分。<br/>
                               	<span>${sysMsg}</span>
                            </p>
                            <hr style="background-color:#fff;border-bottom:2px solid #428bca;">
                     <%--        <div class="text-right" style="color:#666;">
                            	<c:forEach var="mkey" items="${dlist}">
	                            	<c:if test="${mkey['name']=='车队长'}">
	                            		<div style="float:right;width: 150px;">
		                            		${mkey['name']}
			                            	<input type="hidden" name="sendway" value="${mkey['id']}" />
			                            	<input type="hidden" name="sendwayName" value="${mkey['name']}" />
			                             </div>
	                            	</c:if>
	                             </c:forEach>
	                             <div style="float:right;width: 150px;">配送方式：</div>
	                        </div><br/>
                            <div class="text-right" style="color:#000;">
                            	<div style="float:right;width: 150px;">
	                            	<c:if test="${sum>39}">¥0.00<input type="hidden" name="sendPrice" value="0.00" /></c:if>
		                            <c:if test="${sum<=39}">¥10.00<input type="hidden" name="sendPrice" value="10.00" /></c:if>
		                         --%>
		                        <div>
	                            <div style="float:right;width: 150px;" ></div>
	                           
	                        </div><br/>
	                        
	                          <div class="text-right" style="color:#666;">
                            	<div style="float:right; width: 150px;">
                            		<div style="float:right;" id="yunfei1">0.0</div>
	                        		<div style="float:right;"></div>
                            	</div>
	                        	<div style="float:right;width: 150px;">运费：</div>
	                        </div><br/>
	                        
	                        
                            <div class="text-right" style="color:#666;">
                            	<div style="float:right; width: 150px;">
                            		<div style="float:right;" id="jifen">0.0</div>
	                        		<div style="float:right;">-</div>
                            	</div>
	                        	<div style="float:right;width: 150px;">积分：</div>
	                        </div><br/>
	                        
	                        <div class="text-right" style="color:#666;">
	                        	<div style="float:right; width: 150px;">
	                           		<div style="float:right;" id="toprice">
	                           		
	                           		</div>
	                           		<div style="float:right;"></div>
                           		</div>
                           		<div style="float:right;width: 150px;">应付总额：</div>
                           	</div>
                        </div>
					</div>
                    <div class="pull-right col-md-7 text-right" style="padding-top:0px;">
                      <c:if test="${typeId==3 ||typeId=='1'}">
                        <button type="submit"   class="btn btn-warning pull-right" style="margin-left:10px;">确认订单</button>
                      </c:if>  
                       
                       	<span style="line-height: 34px;"><strong>实付总额：</strong></span>
                       	<span style="padding-top:4px;line-height:34px;font-size: 20px;color:#E4393C;"></span>
                       	<span id="toprice2" style="padding-top:4px;line-height:34px;font-size: 20px;color:#E4393C;">
                      
                       	<a type="button" class="btn btn-default pull-right" href="<%=basePath%>pei/showCart"><i class="icon-reply"></i>返回购物车</a> 
                        <div class="clearfix"></div>
                    </div>
                     <input name="consigneeAddId" id="consigneeAddId" value="0" type="hidden">
                </form>
            </div>
        </div>
    

<%@ include file="./public/foot.jsp"%>
<script>

$('input').iCheck('destroy');

    $(document).ready(function () {
        /* $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        }); */

        $.ajax({
            type: "GET",
            url: "<%=basePath%>pei/getAddress",
            async:false,
            data:{addressId:$('#addr1').val(),sum:$('#sum').val()},
            dataType: "html",
            success: function(data) {
             $('#address').html(data);  
            },
            error: function() {
            _this.text('请求失败');
            }
        }); 
   
    });
    
    
	function selCredits(){
		
	
		var isSelect=document.getElementById("isSelect");
			var creditDiv=document.getElementById("creditDiv");
			
			
		var c1=$("#useCre").get(0).innerHTML;
	
		if(parseFloat(c1)=="0"){
		
		isSelect.checked=false;
		creditDiv.style.display="none";
		$("#selectid").val("0");
		document.getElementById("credits").value="";
		}
		
		if($('#isSelect').is(":checked")==false){
			isSelect.checked=true;
			creditDiv.style.display="";
			$("#selectid").val("1");
		}
 		var creditsText=document.getElementById("useCre").innerHTML;
		var cre=parseFloat(creditsText);
		
		
		var toprice=document.getElementById("sum").value;
		var ss=parseFloat(toprice);
		
		var credits=document.getElementById("credits").value;
		
		 credits=credits.replace(/\D/g,'');
		var kk=parseFloat(credits)/100-ss;
		
		if(isNaN(credits) || credits=="" || credits=="0"){
		
			isSelect.checked=false;
			creditDiv.style.display="";
			$("#selectid").val("0");
			/* document.getElementById("showmsg").innerHTML="";
			document.getElementById("showmsg").innerHTML="请输入数字！";
			document.getElementById("showmsg").style.display="block"; */
			document.getElementById("credits").value="";
			credits="";
			
		}else{
			document.getElementById("showmsg").style.display="none";
		}
		
		if(parseFloat(credits)>cre){
			
			/* document.getElementById("showmsg").innerHTML="";
			document.getElementById("showmsg").innerHTML="输入的数字大于您当前积分，请重新输入！";
			document.getElementById("showmsg").style.display="block"; */
			document.getElementById("credits").value=cre;
			credits=cre;
			
		}else{
			document.getElementById("showmsg").style.display="none";
		}
	
		if(kk>0){
			
			document.getElementById("credits").value=ss;
			credits=ss;
			
		}else{
			document.getElementById("showmsg").style.display="none";
		}
		
		if($('#isSelect').is(":checked")){
			creditDiv.style.display="";
			$("#selectid").val("1");
			if(credits!=""){
				document.getElementById("jifen").innerHTML="";
				document.getElementById("jifen").innerHTML="￥"+changeTwoDecimal_f(parseInt(credits)/100);
				/* document.getElementById("toprice").innerHTML="";
				document.getElementById("toprice").innerHTML=changeTwoDecimal_f(toprice)-parseFloat(credits)/100;  */
				document.getElementById("toprice2").innerHTML="";
				document.getElementById("toprice2").innerHTML=changeTwoDecimal_f(parseFloat(toprice)-parseFloat(credits)/100);
			}else{
			
				credits=0;
				document.getElementById("jifen").innerHTML="";
				document.getElementById("jifen").innerHTML="￥"+changeTwoDecimal_f(0);
				document.getElementById("toprice").innerHTML="";
				/* document.getElementById("toprice").innerHTML=changeTwoDecimal_f(toprice); 
				document.getElementById("toprice2").innerHTML=""; */
				document.getElementById("toprice2").innerHTML=changeTwoDecimal_f(toprice);
			}
		}else{
			var sum2=$("#sum").val();
			document.getElementById("jifen").innerHTML="￥"+changeTwoDecimal_f(0);
			document.getElementById("toprice2").innerHTML=changeTwoDecimal_f(sum2);
			creditDiv.style.display="none";
			$("#selectid").val("0");
		}
 	}	   
 
	function validatelegalAndZero1(thisEle) {
	 	var _this=document.getElementById(thisEle);
	  	if(!validateNullAndZero1(_this)){
	 		return false;
		} else{
			
	 	return 	true;
	 
		}
	}
	function validateNullAndZero1(obj){
		var province =document.getElementById("province-box").value;
		var message = $(obj).next().text();
		if (province=="9") {
			$(obj).next().next().text("");
			return true;
		}
		else if($(obj).val()==null||$(obj).val().length==0 || $(obj).val()=="0"){
	 		$(obj).next().next().text(message.split('[]')[0]);
	 		return false;
		}else{
	  		$(obj).next().next().text("");
	  	}
		return true;
	}
</script>
 

<%-- <script type="text/javascript" src="<%=basePath%>html/js/jquery-1.7.2.min.js"></script> --%>
 <script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
 <script>

 distSelect1("<%=basePath%>");
//getSelect("<%=basePath%>");
var addId="";
var elem;

function fun(){
	var check=true;
	if(!validatelegalName('nameNameId')){
		check=false;
	}
	if(!validatelegalTel('tel')){
		check=false;
	}
	if(!validatelegalAndZero1('area-box')){
		check=false;
	}
	if(!validatelegalName('address')){
		check=false;
	}
	if(check==false){
		return;
	}
	var name=document.getElementById("nameNameId").value;
	var tel=document.getElementById("tel").value;
	var address=document.getElementById("address").value;
	var province =document.getElementById("province-box").value;
	var city =document.getElementById("city-box").value;
	var area =document.getElementById("area-box").value;
	if (area=="0") {
		area="";
	}
	var provinceName =document.getElementById("provinceName").value;
	var cityName =document.getElementById("cityName").value;
	var areaName =document.getElementById("areaName").value;
	
	
	$.ajax({
		type: "post",
		url: "<%=basePath%>pei/newaddress", 
	    async:false,           
	    dataType: "html",
	    data:{id:addId,name:name,tel:tel,province:province,city:city,region:area,address:address,provinceName:provinceName,cityName:cityName,areaName:areaName},
	    success: successback1,
	    error: errorback1
		}); 
		
		}
		
		
function  successback1(data){
	var name=document.getElementById("nameNameId").value;
	var tel=document.getElementById("tel").value;
	var address=document.getElementById("address").value;
	var province =document.getElementById("province-box").value;
	var city =document.getElementById("city-box").value;
	var area =document.getElementById("area-box").value;
	var provinceName =document.getElementById("provinceName").value;
	var cityName =document.getElementById("cityName").value;
	var areaName =document.getElementById("areaName").value;
		var dd=data.split("*")[0];
		var tt=data.split("*")[1];
		if(dd==1){
		var ss=provinceName+" "+cityName+" "+areaName;
		$(elem).parent().children().children("span").get(0).innerHTML=ss;
		$(elem).parent().children("div").get(1).innerHTML=address+" ("+name+" 收)"+"<br>联系方式："+tel;
		var editAddr=document.getElementById("editAddr");
		editAddr.style.display="none";
		$('.addr1').get(0).onclick(); 
		}
		if(dd==2){
		var ss=provinceName+" "+cityName +" "+areaName;
		$('.addr1').children().children("span").get(0).innerHTML=ss;
		$('.addr1').children("div").get(1).innerHTML=address+" ("+name+" 收)"+"<br>联系方式："+tel;
		$('.addr-toolbar2').get(0).setAttribute("onclick","editAddr(this, '"+tt+"')");
		
		$('.addr1').get(0).setAttribute("onclick","getAddress(this, '"+tt+"')");
		
	
		 $('.addr1').get(0).onclick();  
		

		var editAddr=document.getElementById("editAddr");
		editAddr.style.display="none";
		var allHtml1=document.getElementById("allAddr").innerHTML;
		var allHtml2=allHtml1+"<div class='addr2' id='newAdd1' onclick='addAddr(this);'><div class='addr-hd'><span></span></div><div class='addr-bd'>添加新地址</div><div class='addr-toolbar' id='update1'>修改</div></div>";
		$('#allAddr').html(allHtml2);
		} 
 		document.getElementById("consigneeAddId").value="0010";
		}
		
	function errorback1(){
	
	}
    
	function updateInput(){
		$('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
        
	}
	/* function checkRadio(){
		$('input[name="addr1"]:checked').val();
	} */
	function changeTwoDecimal_f(x)//保留两位小数
	{
	   var f_x = parseFloat(x);
	   if (isNaN(f_x))
	   {
	      
	      return false;
	   }
	   var f_x = Math.round(x*100)/100;
	   var s_x = f_x.toString();
	   var pos_decimal = s_x.indexOf('.');
	   if (pos_decimal < 0)
	   {
	      pos_decimal = s_x.length;
	      s_x += '.';
	   }
	   while (s_x.length <= pos_decimal + 2)
	   {
	      s_x += '0';
	   }
	   return s_x;
	}
 </script>
<script>
function getAddress(thisElem, obj){

var editAddr=document.getElementById("editAddr");
editAddr.style.display="none";
var dizhi=document.getElementById("dizhi");
dizhi.value=obj;
$(thisElem).parent().children("div").attr("class","addr2");
thisElem.setAttribute("class","addr1");

$(thisElem).parent().find(".addr-toolbar2").attr("class","addr-toolbar");

$(thisElem).children("div").next().next().attr("class","addr-toolbar2");

var tt=$(thisElem).children().children("span").get(0).innerHTML;
var provinceName10=tt.split(" ")[0];

var provinceName11=document.getElementsByName("provinceName11");
var len1=provinceName11.length;

for(var i=0;i<len1;i++){
	var p11=provinceName11[i].value;
	if(provinceName10!=p11){
	document.getElementsByName("youfei")[i].value="20.00";
	}else{
	document.getElementsByName("youfei")[i].value="10.00";
	}
	
}
count();
}

function editAddr(thisElem,obj){
elem=thisElem;
addId=obj;
var name=document.getElementById("nameNameId");
var tel=document.getElementById("tel");
var address=document.getElementById("address");
var province =document.getElementById("province-box");
var city =document.getElementById("city-box");
var area =document.getElementById("area-box");
var provinceName =document.getElementById("provinceName");
var cityName =document.getElementById("cityName");
var areaName =document.getElementById("areaName");

 $.ajax({
            type: "POST",
            url: "<%=basePath%>pei/getTheAddr",
            data: {id:obj},
            dataType: "html",
            success: function(dat) {
            var editAddr=document.getElementById("editAddr");
            editAddr.style.display="";
             name.value=dat.split("*")[0]; 
             tel.value=dat.split("*")[1];
           	 province.options[0].text=dat.split("*")[2];
           	 provinceName.value=dat.split("*")[2];
           	 city.options[0].text=dat.split("*")[3];
           	 cityName.value=dat.split("*")[3];
           	 area.options[0].text=dat.split("*")[4];
           	 areaName.value=dat.split("*")[4];
           	 address.value=dat.split("*")[5];
           	 province.value=dat.split("*")[6];
           	 city.value=dat.split("*")[7];
           	 area.value=dat.split("*")[8];
           	 
            },
            error: function() {
                _this.text('发送失败');
            }
        });	

}

function addAddr(thisElem){
addId="";
$(thisElem).parent().children("div").attr("class","addr2");
thisElem.setAttribute("class","addr1");

$(thisElem).parent().find(".addr-toolbar2").attr("class","addr-toolbar");

$(thisElem).children("div").next().next().attr("class","addr-toolbar2");

thisElem.setAttribute("id","");

var editAddr=document.getElementById("editAddr");
editAddr.style.display="";



}
function addressList(){
	var credits=document.getElementById("credits").value;
	
	if(credits=="0" || credits==""){
		document.getElementById("selectid").value="0";
		$("#isSelect").get(0).checked==false;
	}else{
		var thtml=$("#get-ucode").get(0).innerHTML;
		if(thtml=="获取校验码"){
			$("#get-ucode").click();
		}
	}
	var tcheck=$("#isSelect").get(0).checked;
	if(tcheck){
	var checkcode=$("#checkcode").val();
	
	$.ajax({
				type : "post",
				url : "<%=basePath%>pei/checkCode",
				async : false,
				dataType : "json",
				data:{checkcode:checkcode},
				success : function(data){
					ttcode=data.code;
				},
				error : function(){
				}
			});	
	
	if(ttcode==0){
	alert("验证码不对，请重新输入！");
	return false;
	}
	}
	
	var len="${len}";
	 var dizhi=document.getElementById("dizhi").value;
	if(len==0){
		  if(dizhi==""){
  			alert("请添加收货地址！");
 			 return false;
  } 
	}else{
	var checkAdd=$(".addr1").children().get(1).innerHTML;
	if(checkAdd=="添加新地址" || dizhi==""){
  alert("请添加收货地址！");
  return false;
  }
	}
	
	
	
	var frameNo=document.getElementsByName("frameNo");
  /*  var AddressLength=document.getElementById("AddressLength").value;
   var consigneeAddId=document.getElementById("consigneeAddId").value; */
  
     
   
  var mailCost=document.getElementsByName("mailCost");
  var youfei=document.getElementsByName("youfei");
  var len1=mailCost.length;
  for(var i=0;i<len1;i++){
  	var j=0;
  	if(i==0){
  		document.getElementsByName("mailCost")[0].value=youfei[0].value;
  		j=j+1;
  	}else{
  		if(mailCost[i].value!=0){
  			document.getElementsByName("mailCost")[i].value=youfei[j].value;
  			j=j+1;
  		}
  	}
  }
  }


function selectFrame(thisElem){
	var aa=$(thisElem).val();
	$(thisElem).prev().get(0).value=aa;
	
}
</script>

<script>
var ttcode;
count();
function count(){

var toprice="${sum}";
var youfei=document.getElementsByName("youfei");
var len=youfei.length;
var mailFee=0;
for(var i=0;i<len;i++){
	mailFee=parseInt(youfei[i].value)+mailFee;
}
var toprice1=parseInt(toprice)+parseInt(mailFee);
$("#yunfei1").get(0).innerHTML="￥"+mailFee+".00";
$("#toprice").get(0).innerHTML="￥"+toprice1+".00";
$("#toprice2").get(0).innerHTML="￥"+toprice1+".00";
document.getElementById("sum").value=toprice1;

var credit1="${credits}";
var creStr=parseInt(credit1)/100;
if(creStr>toprice1){
	$("#useCre").get(0).innerHTML=toprice1*100;
}else{
	$("#useCre").get(0).innerHTML=credit1;
}
}

function changeCheck(thisEelm){
	var tkey=$(thisEelm).get(0).checked;
	var creditDiv=document.getElementById("creditDiv");
	var c1="${credits}";
	
	if(parseFloat(c1)=="0"){
		creditDiv.style.display="none";
		$("#selectid").val("0");
		document.getElementById("credits").value="";
		$(thisEelm).get(0).checked=false;
	}
	if(tkey==false){
		var toprice=$("#sum").val();
		document.getElementById("jifen").innerHTML="￥"+changeTwoDecimal_f(0);
		document.getElementById("toprice2").innerHTML=changeTwoDecimal_f(toprice);
		
		creditDiv.style.display="none";
		$("#selectid").val("0");
		document.getElementById("credits").value="";
	}else{
		creditDiv.style.display="";
		$("#selectid").val("1");
	}
}

  document.getElementById("get-ucode").onclick = ucodeClick;
var tel="${tel}";
 function ucodeClick(){
       var _this = $(this);
        $.ajax({
            type: "POST",
            url: "<%=basePath%>mobile/ucode",
            data: {mobile:tel,flag:"1"},
            dataType: "html",
            success: function(dat) {   
           
            	document.getElementById("get-ucode").onclick = deleteClick;
                _this.text('30秒之后重新发送');
                var wait = 30;
                _this.text(wait + '秒之后重新发送');
                var interval = setInterval(function() { 
                                   
                    _this.text(wait + '秒之后重新发送');
                    var time = --wait;
                  
                    $('.smsCode').html(time + '秒之后重新发送');
                    if (time <= 0) {  
                   
                    	 _this.text("获取验证码");
                     	document.getElementById("get-ucode").onclick = ucodeClick;                   
                                
                        clearInterval(interval);
                    };
                }, 1000);
            },
            error: function() {

            }
        });
        }
        
     function deleteClick(){  
     	  
    }
    
   
</script>