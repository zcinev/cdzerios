<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="./public/head.jsp" %>
<script>
var id="";
var name="";
var imgurl="";
var autopartinfo = "";
$(function(){
	
	var top=$("#uldht li a");
	top.click(function(){
	
	$(this).addClass("color","white").siblings().removeClass("thisClass");
	});
	});
</script>	
<style>

#uldht li a{
/* color: #00a9ff; */

font-size: 14px;

}
.navbar-default .navbar-nav>li>a {
color: white;
}
#uldht li a:hover{
background-color: #195fa4;
color:white;
}
.pjname{
color: #00a9ff;

}
.pjnamenull{
color: #00a9ff;
margin-top: -16px;
}
.pjimg{
	line-height:20px;
}
.pjimg .pull-left .media-object{
width: 102px;
/*height: 92px;*/
}
.pjadd a:hover{
text-decoration: none;
}
.pjadd a img{
width: 25px;
}
.pjduibi{
background-color: #f60;
padding:3px;
padding-left:6px;
padding-right:6px;
margin-top: 15px;
color: white;
}
.pjxunjia{
padding:5px;
padding-left:15px;
padding-right:15px;
background-color: #00a9ff;
margin-top: 15px;
color: white;
}

.pjxunjia1{
padding:3px;
padding-left:6px;
padding-right:6px;
margin-top: 15px;
background-color: #ccc;
color: white;
}

.selectCar{
color: #ff6100;
}

 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}

</style>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
        <div class="container-fluid">
            <div class="row">
                <%@ include file="./public/sidebarLeft.jsp" %>

                    <div class="col-md-9 paddingLeft0 paddingRight0 pull-left">
                        <%--<div class="width-auto">
                            <!-- <ol class="breadcrumb breadcrumb-marginBottom5">
                                <li class="active"><a href="#" id="hrefname">name</a>
                                </li>
                            </ol>  -->
                        <li><img width="100%" height="350" src="<%=basePath%>html/img/Engine.png"></li>
                        </div>
						--%>
						<div class="width-auto banner pull-left">
		                    <ul class="paddingLeft0" id="banner_img">
		                     <%--    <li><img width="100%" height="350" src="<%=basePath%>html/img/Engine.png"></li>
		                        <li><img width="100%" height="350" src="<%=basePath%>html/img/undercoating.png"></li>
		                        <li><img width="100%" height="350" src="<%=basePath%>html/img/bodyAccessories.png"></li>
		                        <li><img width="100%" height="350" src="<%=basePath%>html/img/Electronic.png"></li>
		                        <li><img width="100%" height="350" src="<%=basePath%>html/img/saveAccessories.png"></li> --%>
		                    </ul>
		                </div>
	                </div>
	                <div class="col-md-9 paddingLeft0 paddingRight0 pull-left">
                       <c:if test="${flag==1}">
                       <div id="dpgltable"></div>
                       <div class="page col-md-9 ">
	             	<table>
	                    <tr>
							<td colspan="9">
								<div>
									<form class="pager-form" role="form">
										<label>转到</label> <input id="zdid" type="text"
											class="form-control" onblur="zdfun();"> <label>页</label>
									</form>
									<ul class="pager pull-right"
										style="margin-left:2px;margin-right:2px;">
										<li><a id="syy">上一页</a>
										</li>
										<li><a id="xyy">下一页</a>
										</li>
									</ul>
									<span class="label label-default pull-right label-page">共<span
										id="djy">20</span>页</span> <span
										class="label label-primary pull-right label-page">当前第<span
										id="dqdjy">5</span>页</span>
									<ul class="pagination pull-right">
										<li><a id="syyf">&laquo;</a>
										</li>
										<li class="active"><a id="dqdjyf">1</a>
										<li class=""><a id="dqdjyf1">1</a>
										<li class=""><a id="dqdjyf2">1</a>
										<li class=""><a id="dqdjyf3">1</a></li>
										<li><a id="xyyf">&raquo;</a>
										</li>
									</ul>
								</div>
							</td>
						</tr>
					</table>
	             </div>
                      
                        
                        
                        <c:if test="${lkey3==null || fn:length(lkey3) == 0}"><span style="font:18px/150% Arial,Verdana,'宋体'; color:#000; margin-left: 35%;">没有找到符合您的商家</span></c:if>
                        </c:if>
                        <c:if test="${flag==0}">
                        <c:forEach var="mkey" items="${lkey4}">
                           <script>
				            	autopartinfo = "${mkey['name']}";
				           </script>	
                            <div class="panel">
                                <div class="panel-heading">
                                    <h3 class="panel-title"> ${mkey['name']}</h3>
                                </div>
                                <hr style="margin:0;padding:0;" />
                                <div class="panel-body media pjimg">
                                    <a class="pull-left" href="#">
                            <img class="media-object" src="${mkey['imgurl']}" alt="图片">
                        </a>
                                    <div class="media-body">
                                        <span>&nbsp;</span>
                                        <p class="pjnamenull">${mkey['name']}</p>
                                        <input name="productIdStr" type="hidden" value="${mkey['id']}" id="productIdStr">
                                        <div id="centerMsg"></div>
                                         <p>尺寸${mkey['size']}</p>
                                         <script>
                                         id="${mkey['id']}";
                                         name="${mkey['name']}";
									   	 imgurl="${mkey['imgurl']}";
                                         </script>
                                        <p>暂时缺货</p>
                                        <br />
                                        <p>
                                           <!--  <input type="checkbox" name="compare[]" value="1"> -->
                                           <%--  <a href="<%=basePath%>pei/index" class="pjduibi">对比</a> --%>
                                            <!--如果没有价格就询价，询价表单提交到采购中心后台-->
                                            <c:if test="${typeId=='1' || typeId=='3' || typeId==null}">
                                            <a href="#" onclick="asd()" class="pjxunjia">询价</a>
                                            </c:if>
                                            <c:if test="${typeId!='1' && typeId!='3' && typeId!=null}">
                                            <span class="pjxunjia1" title="注册个人会员或者加盟维修商可询价">询价</span>
                                            </c:if>
                                           
                                            
                                            <div style="float: right;">
			                                   <a href="javascript:;" class="selectCar" style="font: 13px/150% Arial,Verdana,'宋体';" ><img alt="" src="<%=basePath%>html/img/choicecar.png" style="width:25px;"><span style="color: #FF6100;">+选择车型</span></a>
			                               </div>
                                        </p>
                                    </div>
                                    <div style="float: left;margin-top:10px;color:#d2d2d2;">
                                     	<img src="<%=basePath%>html/images/msg001.png"></img> 温馨提示：车队长超市正品配件十万件以上，商家还没来得及添加您需要的配件信息，您可以前往询价。
                                    </div>
                                </div>
                            </div>
                            
                        </c:forEach>
                        </c:if>
                    </div>
                    <form action="" id="from5" name="from5">
                    	<input type="hidden" name="carModel" id="carModel"/>
						<input type="hidden" name="carModelId" id="carModelId"/>
                    </form>
                    
            </div>
        </div>

        <div class="modal fade bs-example-xunjia-modal" id="dlg" style="position: absolute;z-index: 10000;margin-top:310px;">
            <div class="modal-dialog">
                <div class="modal-content" style="width:600px;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title">请填写联系方式</h4>
                    </div>
                    <form class="form-horizontal" name="form1" role="form"  method="post" > 
                    <div class="modal-body">
                        <p style="width:80%;" id="recent"></p>
                        <div style="width:100%;">
                        <div id="center"></div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">联系人</label>
                                <div class="col-sm-8">
                                    <input type="text" name="userNameXJ" id="userNameXJ" class="form-control" placeholder="联系人（张三）" onblur="validatelegalName('userNameXJ');" maxlength="20" style="width:140px;">
                                	<span class="message" >请输入联系人[]</span>
                      				<span class="messageShow" ></span>
                               
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-4 control-label">联系电话</label>
                                <div class="col-sm-8">
                                    <input type="text" name="telphoneXJ" id="telphoneXJ" class="form-control" placeholder="联系电话（150****3012）" onblur="validatelegalTel('telphoneXJ');"  style="width:140px;">
                                 	<span class="message" >请输入正确的联系方式[]</span>
                      				<span class="messageShow" ></span>
                                
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-4 control-label">询价城市</label>
                                <div class="col-sm-8 form-inline">
                                	<select name="province" class="form-control select-form-control" id="province-box">
                                    	<option value="0">-请选择省-</option>
                                	</select>
                                	<select name="city" class="form-control select-form-control" id="city-box" onchange="cneterNameList();">
                                    	<option value="0">-请选择市-</option>
                               		</select>
                               		<span class="message" >请输入正确的省市[]</span>
                    				<span class="messageShow" ></span>
                                
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-4 control-label">配件超市</label>
                                <div class="col-sm-8">
                                	<select name="center" class="form-control select-form-control" id="center-box" onblur="validatelegalName2('center-box');">
                                    	<option value="0">-请选择配件超市-</option>
                               		</select>
                                    <span class="message" >请输入正确的配件超市名称[]</span>
                      				<span class="messageShow" ></span>
                                </div>
                            </div>
                            <div class="form-group">
                                  <div id="myid">  
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    <button   class="btn btn-default"  type="button" onclick="javascript:askPriceTest();">提交</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        
                    </div>
                    </form>
                </div>
            </div>
        </div>
        
        
       
          
        <%@ include file="./public/foot.jsp" %>
        
 <script>
 	var carModel="${carModel}";
	var jsonstr="[]";
	var jsonarray = eval('('+jsonstr+')');
	var index = 1;
</script>
 <c:if test="${flag==1}">      
<c:forEach var="mkey" items="${lkey3}">
	<script>	
		var arr  =
		     {
		         "autopartinfoName" :"${mkey['autopartinfoName']}",
		         "id":"${mkey['id']}",
		         "img" : "${mkey['img']}",
		         "name":"${mkey['name']}",
		         "memberprice": "${mkey['memberprice']}",
		         "factoryName": "${mkey['factoryName']}",
		     	 "centerIdName": "${mkey['centerIdName']}"
		      };
		     	 	
		jsonarray.push(arr);
		index++;
	</script>
</c:forEach>
</c:if>
   <script>
   var selectcont = 0;
		databuffer = [];//数据缓存
		dqdjyf = document.getElementById("dqdjyf");
		dqdjyf1 = document.getElementById("dqdjyf1");
		dqdjyf2 = document.getElementById("dqdjyf2");
		dqdjyf3 = document.getElementById("dqdjyf3");
		dqdjyf1.parentNode.style.display = 'none';
		dqdjyf2.parentNode.style.display = 'none';
		dqdjyf3.parentNode.style.display = 'none';
		var dpgltable = document.getElementById("dpgltable");
		var buffercount = 0;
		dpgltable.innerHTML = "";
		for ( var i = 0; i < jsonarray.length; i++) {
			
			var trbuffer = " <div class='panel'><div class='panel-heading'>"+
							"<h3 class='panel-title'>"+jsonarray[i].autopartinfoName+"</h3>"+
							" </div> <hr style='margin:0;padding:0;' />"+
							"<div class='panel-body media pjimg'>"+
							"<a class='pull-left' href=\"<%=basePath%>pei/detail?id="+jsonarray[i].id+"\">"+
							"<img class='media-object'  src=\""+jsonarray[i].img+"\" title=''></a>"+
							" <div class='media-body'><div>"+
							" <p class='pjname'><font >名称：</font>"+jsonarray[i].name+"</p>"+
							"  <p><font>价格：</font> ￥<font color='red' style='font-weight: bolder;'>"+
							""+jsonarray[i].memberprice+"</font></p> </div><div>"+
							"<p><font >生产厂商：</font>"+jsonarray[i].factoryName+"</p>"+
							" <p><font >采购中心：</font>"+jsonarray[i].centerIdName+"</p> </div>"+
							"<div style='float: right;' class='pjadd'>"+
							" <a href='javascript:;' class='selectCar'"+
							" style=\"font: 13px/150% Arial,Verdana,'宋体';\""+
							"onclick=\"javascript:carModalSelect('<%=basePath%>');\">"+
							"<img alt='' src='<%=basePath%>html/img/choicecar.png'>"+
							"  <span style='color: #FF6100;'>"+carModel+"</span></a></div></div></div></div>";
		
			databuffer.push(trbuffer);//存入数据到缓存
			if (buffercount < 5)
				$("#dpgltable").append(trbuffer);
			buffercount++;
		}
	
		var bufferlength = databuffer.length;
		pagecount = 0;
		if (bufferlength % 5 == 0)
			pagecount = parseInt(bufferlength / 5);
		else
			pagecount = parseInt(bufferlength / 5) + 1;
	
		var djy = document.getElementById("djy");
		var dqdjy = document.getElementById("dqdjy");
		djy.innerHTML = pagecount;
		dqdjy.innerHTML = 1;
		dqdjyf.innerHTML = 1;
		dqdjyf1.innerHTML = 1;
		dqdjyf1.innerHTML = 1;
		dqdjyf1.innerHTML = 1;
		if (dqdjyf.innerHTML < pagecount) {
			dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
			dqdjyf1.parentNode.style.display = '';
		}
		if ((parseInt(dqdjyf.innerHTML) + 1) < pagecount) {
			dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
			dqdjyf2.parentNode.style.display = '';
		}
		if ((parseInt(dqdjyf.innerHTML) + 2) < pagecount) {
			dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
			dqdjyf3.parentNode.style.display = '';
		}
	
		function zuoyifun() {
			if (parseInt(dqdjyf.innerHTML) - 4 > 0) {
				dqdjyf.parentNode.setAttribute("class", "");
				dqdjyf1.parentNode.setAttribute("class", "");
				dqdjyf2.parentNode.setAttribute("class", "");
				dqdjyf3.parentNode.setAttribute("class", "");
				dqdjyf.innerHTML = parseInt(dqdjyf.innerHTML) - 4;
				dqdjyf.parentNode.setAttribute("class", "active");
				zdymfun(dqdjyf.innerHTML);
				dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
				dqdjyf1.parentNode.style.display = '';
				dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
				dqdjyf2.parentNode.style.display = '';
				dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
				dqdjyf3.parentNode.style.display = '';
			}
		}
	
		function youyifun() {
			if (parseInt(dqdjyf.innerHTML) + 4 <= pagecount) {
				dqdjyf.parentNode.setAttribute("class", "");
				dqdjyf1.parentNode.setAttribute("class", "");
				dqdjyf2.parentNode.setAttribute("class", "");
				dqdjyf3.parentNode.setAttribute("class", "");
				dqdjyf.innerHTML = parseInt(dqdjyf.innerHTML) + 4;wq
				dqdjyf.parentNode.setAttribute("class", "active");
				zdymfun(dqdjyf.innerHTML);
				dqdjyf1.parentNode.style.display = 'none';
				dqdjyf2.parentNode.style.display = 'none';
				dqdjyf3.parentNode.style.display = 'none';
				if (dqdjyf.innerHTML < pagecount) {
					dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
					dqdjyf1.parentNode.style.display = '';
				}
				if ((parseInt(dqdjyf.innerHTML) + 1) < pagecount) {
					dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
					dqdjyf2.parentNode.style.display = '';
				}
				if ((parseInt(dqdjyf.innerHTML) + 2) < pagecount) {
					dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
					dqdjyf3.parentNode.style.display = '';
				}
	
			}
		}
	
		dqdjyf.onclick = function() {
			zdid.value = "";
			dqdjyf.parentNode.setAttribute("class", "active");
			dqdjyf1.parentNode.setAttribute("class", "");
			dqdjyf2.parentNode.setAttribute("class", "");
			dqdjyf3.parentNode.setAttribute("class", "");
			zdymfun(dqdjyf.innerHTML);
		};
	
		dqdjyf1.onclick = function() {
			zdid.value = "";
			dqdjyf.parentNode.setAttribute("class", "");
			dqdjyf1.parentNode.setAttribute("class", "active");
			dqdjyf2.parentNode.setAttribute("class", "");
			dqdjyf3.parentNode.setAttribute("class", "");
			zdymfun(dqdjyf1.innerHTML);
		};
	
		dqdjyf2.onclick = function() {
			zdid.value = "";
			dqdjyf.parentNode.setAttribute("class", "");
			dqdjyf1.parentNode.setAttribute("class", "");
			dqdjyf2.parentNode.setAttribute("class", "active");
			dqdjyf3.parentNode.setAttribute("class", "");
			zdymfun(dqdjyf2.innerHTML);
		};
	
		dqdjyf3.onclick = function() {
			zdid.value = "";
			dqdjyf.parentNode.setAttribute("class", "");
			dqdjyf1.parentNode.setAttribute("class", "");
			dqdjyf2.parentNode.setAttribute("class", "");
			dqdjyf3.parentNode.setAttribute("class", "active");
			zdymfun(dqdjyf3.innerHTML);
		};
	
		var zdid = document.getElementById("zdid");
		syy = document.getElementById("syy");
		syyf = document.getElementById("syyf");
		xyy = document.getElementById("xyy");
		xyyf = document.getElementById("xyyf");
		syy.onclick = function() {
			syyfun();
		};
	
		syyf.onclick = function() {
			zuoyifun();
		};
	
		xyy.onclick = function() {
			xyyfun();
		};
	
		xyyf.onclick = function() {
			youyifun();
		};	
		
		function syyfun() {
		
			dqdjyf.parentNode.setAttribute("class", "");
			dqdjyf1.parentNode.setAttribute("class", "");
			dqdjyf2.parentNode.setAttribute("class", "");
			dqdjyf3.parentNode.setAttribute("class", "");
			zdid.value = "";
			var dpgltable = document.getElementById("dpgltable");
			var syycount = dqdjy.innerHTML;
			if (syycount == 1) {
				alert("已经是第一页");
			} else {
				syycount--;
				zdymfun(syycount);
			}
		}
	

	
		function xyyfun() {
			dqdjyf.parentNode.setAttribute("class", "");
			dqdjyf1.parentNode.setAttribute("class", "");
			dqdjyf2.parentNode.setAttribute("class", "");
			dqdjyf3.parentNode.setAttribute("class", "");
			zdid.value = "";
			var dpgltable = document.getElementById("dpgltable");
			var syycount = dqdjy.innerHTML;
			var djycount = djy.innerHTML;
			if (syycount == djycount) {
				alert("已经是最后一页");
			} else {
				syycount++;
				zdymfun(syycount);
			}
		}
	

	
	function zdymfun(syycount) {
		//alert("bj-s");
		dqdjy.innerHTML = syycount;
		var xhcount = 0;
		dpgltable.innerHTML = "";
						
		for ( var i = (syycount - 1) * 5; i < jsonarray.length; i++) {
			if (xhcount == 5)
				break;
			var trbuffer = " <div class='panel'><div class='panel-heading'>"+
							"<h3 class='panel-title'>"+jsonarray[i].autopartinfoName+"</h3>"+
							" </div> <hr style='margin:0;padding:0;' />"+
							"<div class='panel-body media pjimg'>"+
							"<a class='pull-left' href=\"<%=basePath%>pei/detail?id="+jsonarray[i].id+"\">"+
							"<img class='media-object'  src=\""+jsonarray[i].img+"\" title=''></a>"+
							" <div class='media-body'><div>"+
							" <p class='pjname'><font >名称：</font>"+jsonarray[i].name+"</p>"+
							"  <p><font>价格：</font> ￥<font color='red' style='font-weight: bolder;'>"+
							""+jsonarray[i].memberprice+"</font></p> </div><div>"+
							"<p><font >生产厂商：</font>"+jsonarray[i].factoryName+"</p>"+
							" <p><font >采购中心：</font>"+jsonarray[i].centerIdName+"</p> </div>"+
							"<div style='float: right;' class='pjadd'>"+
							" <a href='javascript:;' class='selectCar'"+
							" style=\"font: 13px/150% Arial,Verdana,'宋体';\""+
							"onclick=\"javascript:carModalSelect('<%=basePath%>');\">"+
							"<img alt='' src='<%=basePath%>html/img/choicecar.png'>"+
							"  <span style='color: #FF6100;'>"+carModel+"</span></a></div></div></div></div>";
			$("#dpgltable").append(trbuffer);
			
			xhcount++;
		}
		
		$(".phenomenon_table").toggle();
		$(".feel1").toggle(); 
		
	}
	
	function zdfun() {
		var zdvalue = zdid.value;
		var djycount = djy.innerHTML;
		if ((zdvalue <= djycount) && (zdvalue >= 1)) {
			zdymfun(zdvalue);
		} else {
			alert("页面输入超出范围");
		}
	}
	
	
	
   
   </script>     
<script>
$(function () {
    distSelect("<%=basePath%>");
     
});
function cneterNameList(){//根据 用户选择的城市 获取相应的采购中心
  var city_id=$('#city-box').val();
  if(city_id!=null && city_id!="" && city_id!="null"){
  $.ajax({
             type: "POST", 
            data:{city_id:city_id},
            url: "<%=basePath%>pei/askPriceCenterName",
            async:false,
            dataType: "json",
            success: function(data) {
                 if(data.no !=null && data.no!="null" && data.no=="该城市没有采购中心"){
                  alert("您当前城市没有采购中心，车队长给您默认选择长沙！");
                 }
                 ajaxGetData('#province-box',"<%=basePath%>member/getSelectValue?id=1");
                  $("#province-box option[value='14'] ").attr("selected",true);
                  ajaxGetData('#city-box',"<%=basePath%>member/getSelectValue?id="+14);
                  $("#city-box option[value='197'] ").attr("selected",true);
                $('#center-box').html(data.center_name);
             },
            error: function() {
             }
        });
  }
 
}
</script>
<script>
 var cityId="";
  //获取当前所在城市的id
  $('.pjxunjia').click(function(){
  $.ajax({
             type: "POST", 
            data:{},
            url: "<%=basePathRe%>ajax/cityGetipStr",
            async:false,
            dataType: "html",
            success: function(data) {
               cityId=data;  
               if(cityId!=null && cityId!="" && cityId!="null"){
               
               $.ajax({
                type:"POST",
               data:{city:cityId},
               url:"<%=basePath%>pei/cityProvince",
               async:false,
               dataType:"html",
               success:function(data){
                  if(data!=null && data !=""){
                   $("#province-box option[value='" +data+ "'] ").attr("selected",true);
                  ajaxGetData('#city-box',"<%=basePath%>member/getSelectValue?id="+data);
                  $("#city-box option[value='" +cityId+ "'] ").attr("selected",true);
                   cneterNameList();
                   
                  }
               
               },
               error:function(){
                        alert("网络超时!");
               }
                              });
               
               }
               
             },
            error: function() {
              alert("网络超时!");
             }
        });
  
  
  });

     
</script>

<script>
var tname1="${partType}";

 $(function () {
 	if(tname1=="发动机"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/Engine.png'></li>";
 	}
 	if(tname1=="底盘"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/undercoating.png'></li>";
 	}
 	if(tname1=="车身及附件"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/bodyAccessories.png'></li>";
 	}
 	if(tname1=="电子、电器"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/Electronic.png'></li>";
 	}
 	if(tname1=="保养配件"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/saveAccessories.png'></li>";
 	}
});
function askPriceTest(){  
    
    var productIdStr=document.getElementById("productIdStr").value;//询价商品id
    var userNameXJ=document.getElementById("userNameXJ").value;//联系人
    var telphoneXJ=document.getElementById("telphoneXJ").value;//联系方式 
     var center_id=$('#center-box').val();//采购中心id
     var center_name=$("#center-box").find("option:selected").text();
     var check=true;
    if(!validatelegalName('userNameXJ')){
    	check=false;
    }
     if(!validatelegalTel('telphoneXJ')){
    	check=false;
    }
    if(!validatelegalName2('center-box')){
    	check=false;
    }
         if(check==true){
         $.ajax({
             type: "POST", 
            data:{'productIdStr':productIdStr,'userNameXJ':userNameXJ,'telphoneXJ':telphoneXJ,'cityId':cityId,center_id:center_id,center_name:center_name},
            url: "<%=basePath%>pei/askPrice",
            async:false,
            dataType: "html",
            success: function() {
               	       alert("询价成功!");
               		$('#dlg').closest('.modal').modal('hide');
            },
            error: function() {
                   alert("询价失败");
                   $('#dlg').closest('.modal').modal('hide');
              
            }
        });
        }else{
        alert("请将信息填写完整！");
        }
    
}
 </script>
        <script>
	 //先判断是否有登录和有选择车型，然后再进行弹出询价框
	 function asd(){
		var userName = "<%=session.getAttribute("userName")%>";	
		var carModel=getCookie("carModel");
 		   if(userName==null || userName=="" || userName=="null"){
			     alert("请先登录，再进行询价");
			     window.location.href="<%=basePath%>html/login.jsp";
			 }else if(getCookie("carModel")==undefined || getCookie("carModel")==null){
				 alert("请先选择您要询问配件价格的车型");
		     }else{
			     $('.bs-example-xunjia-modal').modal('show');
		      } 
		  
	 }
        </script>
        <script>
	$(document).ready(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
        var _this = $(this);
        var dat="";
        
        
    });
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
</script>