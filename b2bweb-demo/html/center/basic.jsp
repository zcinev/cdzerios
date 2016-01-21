<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../public/mchead.jsp"%>
 <script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 #detail-address{
 margin-top: 6px;
 }
 #address{
 margin-top: 5px;
 }
</style>
<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/centerSidebar.jsp"%>
          <div class="col-md-10 pull-right paddingRight0 paddingLeft0"> 
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">会员中心
                        </li>
                        <li class="active">基本信息</li>
                    </ol>
                </div>

                <div class="container-fluid" style="width:100%;margin-top:20px;">
                   <!-- <blockquote style="margin-top:20px;">
								<p>
								<h6 style="color: red;">亲爱的百城，请填写真的资料，有助于好友找到你哦。</h6>
								</p>
							</blockquote> -->
                    <form class="form-horizontal" role="form" action="" method="post" name="form1">
                      <input type="hidden" name="id" value="${key['id']}">
                      <input id="provinceid" name="provinceid" type="hidden" value="${key['province']}" />
                      <input id="cityid" name="cityid" type="hidden" value="${key['city']}" /> 
                      <input id="regionid" name="regionid" type="hidden" value="${key['region']}" />

                        <div class="form-group">
                            <label for="" class="col-sm-2 control-label">名称</label>
                            <div class="col-sm-10 form-inline" style="padding-left:15px;">
                                <input type="text" class="form-control" placeholder="采购中心名称" name="userName"  id="userName" value="${key['name']}" onblur="validatelegalName('userName');" maxlength="32">
                                <span class="message" >厂商名称不能为空[]</span>
                                                 <span class="messageShow" ></span>
                            </div>
                        </div>
                        
                         
                          	<div class="form-group">
								<label for="" class="col-sm-2 control-label">店铺地址</label>
								<div class="col-sm-10">
									<div class="form-group form-inline" style="padding-left:15px;">

										<select name="province" id="province-box" class="form-control">
 										</select>
 										 <select name="city" id="city-box" class="form-control">
 										</select>
 										 <select name="area" id="area-box" class="form-control" onblur="validatelegalName2('area-box');">
 										</select>
 										 <span class="message" >地址不能为空[]</span>
                   			      		<span class="messageShow" ></span>
                                         <input type="text" value="${key['address']}" onkeypress="searchByStationName();"  id="address" name="address" class="form-control" onblur="validatelegalName('address');" maxlength="100" >
                                         <span class="message" >详细地址不能为空[]</span>
                                                 <span class="messageShow" ></span>
                                        <input type="hidden"
											id="coord" name="map" value="" > <a class="btn btn-info" id="detail-address">详细地理位置</a>
											
									</div>
								</div>
							</div>
                            
                      
                        
                        <div class="form-group" style="margin-top: -16px;">
                            <label class="col-sm-2 control-label">简要介绍</label>
                            <div class="col-sm-10 form-inline" style="padding-left:15px;">
                                <link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
                                <textarea class="form-control" name="introduce" id="introduce" rows="15" style="width:100%;" onblur="validatelegalName('introduce');" maxlength="500">${key['content']}</textarea>
                                <span class="message" >厂商名称不能为空[]</span>
                                                 <span class="messageShow" ></span>
                            </div>
                        </div>
                        
                        <c:if test="${key2==''}">
                        
                          <div class="form-group">
                            <label for="" class="col-sm-2 control-label">客服QQ</label>
                            <div class="col-sm-10 form-inline" style="padding-left:15px;">
                                <input type="text" class="form-control" placeholder="1605904007" 
                                name="service"   maxlength="22">
                          	  <a class="btn btn-info" onclick="addService(this)">添加</a><span style="color:#ccc">（最多能添加6个客服）</span>
                            </div>
                        </div>
                        	
                    </c:if>
                       <c:if test="${key2!=''}">
                       <c:set var="index" value='1'></c:set>
                       <c:forEach var="mkey" items="${key2 }">
                       	<c:if test="${index=='1' }">
                       		<div class="form-group">
                            <label for="" class="col-sm-2 control-label">客服QQ</label>
                            <div class="col-sm-10 form-inline" style="padding-left:15px;">
                                <input type="text" class="form-control" placeholder="1605904007"  value="${mkey.serviceQQ }"
                                name="service"   maxlength="22">
                          	  <a class="btn btn-info" onclick="addService(this)">添加</a><span style="color:#ccc">（最多能添加6个客服）</span>
                            </div>
                        </div>
                        </c:if>
                        
                        
                        	<c:if test="${index!='1' }">
                       		<div class="form-group">
                            <label for="" class="col-sm-2 control-label">客服QQ</label>
                            <div class="col-sm-10 form-inline" style="padding-left:15px;">
                                <input type="text" class="form-control" placeholder="1605904007"  value="${mkey.serviceQQ }"
                                name="service"   maxlength="22">
						<span style="margin-left:10px;" onclick="removeDiv(this)" 
						class="btn btn-info car-modal-delete-btn glyphicon glyphicon-trash"></span>
                            </div>
                        </div>
                        </c:if>
                         <c:set var="index" value=" $ {index++ } "></c:set>
                        </c:forEach>
                       </c:if>   
                       
                       	<div id="tbody1">
                        	
                        	</div>
                        		 
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="button" class="btn btn-warning" onclick="basicTest();">修改</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade detail-address">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" style="float:right;">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">请在地图上标注您的地理位置</h4>
			</div>
			<div class="modal-body" id="baiduMap"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

			</div>
		</div>
	</div>
</div>

<%@ include file="../public/foot3.jsp"%>

<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/measure.min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/mark.min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/searchInRectangle_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/SearchControl_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/map.js"></script>

<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script>
//alert(document.getElementById("provinceid").value);
    $(function () {
        distSelect("<%=basePath%>");

        detailAddress("<%=basePath%>");
 
        var province=document.all('provinceid').value;
        var city=document. all('cityid').value;
        var region=document.all('regionid').value;
        setDefaultValue("<%=basePath%>",province,city,region);
        
    });
</script>
<script>
  function basicTest(){  
   var check = true;
   	if (!validatelegalName('userName')) {
 		check = false;
	}   
	if (!validatelegalName('address')) {
 		check = false;
	}
	if (!validatelegalName('introduce')) {
 		check = false;
	}
	if (!validatelegalName2('area-box')) {
		check = false;
	}
	if (check == false) {
    		return;
	} 
	 
	document.form1.action = "<%=basePath%>"+"purchase/updateBasicInfo";
	document.form1.submit();
   
  }
  
  
  function addService(thisElem){
  var service=document.getElementsByName("service");
  if(service.length>5){
  		
  }else{
  		var thtml=" <div class='form-group'>"+
  					"<label class='col-sm-2 control-label'>客服QQ</label>"+
  					" <div class='col-sm-10 form-inline' style='padding-left:15px;'>"+
  					"<input type='text' class='form-control' placeholder='1605904007'"+
  					" name='service'  maxlength='32'>"+
  					"<span style='margin-left:10px;' onclick=\"removeDiv(this)\" class='btn btn-info car-modal-delete-btn glyphicon glyphicon-trash'>"+
  					"</span></div></div></div>";
                          
                              
  		$("#tbody1").append(thtml);
  }		
  }
  
  function removeDiv(thisElem){
  	$(thisElem).parent().parent().remove();
  }
</script>
<script>
    KindEditor.ready(function (K) {
        var editor;
        editor = K.create('#editor', {
            resizeType: 1,
            allowPreviewEmoticons: true,
            allowImageUpload: true,
            allowFileManager : true,
            uploadJson: '<%=hostPath%>imgUpload/servlet/fileServlet',
            fileManagerJson: '<%=hostPath%>imgUpload/servlet/fileServlet',
            items: [
                'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'image', 'link']
        });
    });
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
}</script>

<script>
function validatelegalName2(thisEle) {
 	var _this=document.getElementById(thisEle);
  	if(!validateNull(_this)){
 		return false;
	} else{
		
 	return 	true;
 
	}
 
}
</script>
<script>
$(function(){
	  $('#centerInfo').css("color","#428BCA"); 
	 });
</script>