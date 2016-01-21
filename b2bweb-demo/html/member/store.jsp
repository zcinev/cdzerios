<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../public/head3.jsp"%>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
.form-group label{
font-weight: normal;
}
#address{
margin-top:15px;
}
</style>
<%--360兼容样式 --%>
<link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />

<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>html/js/img.preview.js"></script>
<script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<div class="container-fluid">
	<div class="row">
		<%--<%@ include file="../public/memberSidebar.jsp"%> --%>
		<div class="col-md-12 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
					<ol class="breadcrumb bottom-spacing-0">
						<li class="active">店铺管理</li>
						<li class="active">基本信息</li>
					</ol>
				</div>

				<div class="container-fluid" style="width:80%;margin-top:20px;">
					<form class="form-horizontal" role="form" action="<%=basePath%>member/updateStoreInfoTest" method="post">
						<c:forEach var="mkey" items="${key1}">
					    	<input type="hidden" name="id" value="${mkey['id']}">
                      		<input id="provinceid" name="provinceid" type="hidden" value="${mkey['province']}" />
                      		<input id="cityid" name="cityid" type="hidden" value="${mkey['city']}" /> 
                     		<input id="regionid" name="regionid" type="hidden" value="${mkey['region']}" />
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">店铺名称</label>
								<div class="col-sm-9 form-inline" style="padding-left:15px;">
									<input type="text" class="form-control" placeholder="店铺名称"
										name="name" value="${mkey['companyName']}" readonly="readonly">
								</div>
							</div>
						</c:forEach>
						
						<div class="form-group">
                        	<label class="col-sm-3 control-label">logo</label>
                            <div class="col-sm-9" id="showImg1">
                            	<c:if test="${logo!=''}">
                                	<img id="faceImgId" src="${logo}" width="150" height="150" alt="请上传图片">
                                </c:if>
                                <c:if test="${logo==''}">
                                	<img id="" src="/b2bweb-demo/html/img/upimg2.png"  alt="请上传图片!">
                                </c:if>
                            </div>
                            <div id="logoStrId"></div>
                        </div> 
                        
                        <div class="form-group">
	                        <label class="col-sm-3 control-label">营业执照</label>
	                        <div class="col-sm-9" id="showImg1">
	                            <c:if test="${businessLicenceStr!=''}">
	                            	<img id="faceImgId" src="${businessLicenceStr}" width="150" height="150" alt="请上传图片">
	                            </c:if>
	                            <c:if test="${businessLicenceStr==''}">
	                            	<img id="" src="/b2bweb-demo/html/img/upimg2.png"  alt="请上传图片!">
	                            </c:if>
                        	</div>
                        </div> 
                        
                        <div class="form-group">
                        	<label class="col-sm-3 control-label">荣誉证书</label>
                            <div class="col-sm-9" id="showImg1">
                            	<c:if test="${listStr3!=null}">
                                	<c:forEach var="mkey" items="${listStr3}">
                                    	<img id="faceImgId" src="${mkey['certificateOfHonorStr']}" width="150" height="150" alt="请上传图片">
                                    </c:forEach>
                                </c:if>
                                <c:if test="${listStr3==null }">
                                	<img id="" src="/b2bweb-demo/html/img/upimg2.png"  alt="请上传图片!">
                                </c:if>  
                        	</div>
                       	</div> 
                       	
						<c:forEach var="mkey" items="${key1}">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">联系方式</label>
								<div class="col-sm-9 form-inline" style="padding-left:15px;">
									<input type="text" class="form-control" placeholder="联系方式"
										name="telphone" id="telphone" value="${mkey['tel']}" maxlength="16" >
										<span class="message" >手机号码格式不正确！[]</span>
                   						<span class="messageShow" ></span>
								</div>
							</div> 
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">法人代表</label>
								<div class="col-sm-9 form-inline" style="padding-left:15px;">
									<input type="text" class="form-control" placeholder="法人代表"
										name="legalName" value="${mkey['legalName']}"  >
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">紧急联系人</label>
								<div class="col-sm-9 form-inline" style="padding-left:15px;">
									<input type="text" class="form-control" placeholder="紧急联系人"
										name="urgentUser" id="urgentUser" value="${mkey['urgentUser']}" onblur="validatelegalName('urgentUser');" maxlength="32">
										<span class="message" >紧急联系人不能为空！[]</span>
                   						<span class="messageShow" ></span>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-3 control-label" style="text-align:right;">紧急联系人电话</label>
								<div class="col-sm-9 form-inline" >
									<input type="text" class="form-control" placeholder="紧急联系人电话"
										name="urgentTel" id="urgentTel" value="${mkey['urgentTel']}"  onblur="validatelegalTel('urgentTel');"maxlength="16">
										<span class="message" >紧急联系人电话不能为空！[]</span>
                   						<span class="messageShow" ></span>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">店铺地址</label>
								<div class="col-sm-9">
									<div class="form-group form-inline" style="padding-left:15px;">
										<select name="province" id="province-box" class="form-control">
 										</select>
 										<select name="city" id="city-box" class="form-control">
 										</select>
 										<select name="area" id="area-box" class="form-control" onblur="validatelegalName2('area-box');">
 										</select>
 										<span class="message" >地址不能为空[]</span>
                   				        <span class="messageShow" ></span>
                                        <input type="text" value="${mkey['address']}" id="address" name="address" class="form-control" onblur="validatelegalName('address');" maxlength="100">
                                        <span class="message" >详细地址不能为空！[]</span>
                   						<span class="messageShow" ></span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">店铺简介</label>
								<div class="col-sm-9">
									<textarea name="intro" id="intro" style="width:100%;"
										 class="form-control" rows="15" onblur="validatelegalName('intro');" maxlength="3000">${mkey['detail']}</textarea>
										 <span class="message" >店铺简介不能为空！[]</span>
                   						 <span class="messageShow" ></span>
								</div>
							</div>
						</c:forEach>
						<c:if test="${key22==''}">
                        	<div class="form-group">
                            	<label for="" class="col-sm-3 control-label">客服QQ</label>
                            	<div class="col-sm-9 form-inline" style="padding-left:15px;">
                                	<input type="text" class="form-control" placeholder="1605904007" 
                                		name="service"   maxlength="22">
                          	  		<a class="btn btn-info" onclick="addService(this)">添加</a><span style="color:#ccc">（最多能添加6个客服）</span>
                            	</div>
                        	</div>
                    	</c:if>
                        <c:if test="${key22!=''}">
                       		<c:set var="index" value='1'></c:set>
                        	<c:forEach var="mkey" items="${key22 }">
	                       		<c:if test="${index=='1' }">
	                       			<div class="form-group">
	                            		<label for="" class="col-sm-3 control-label">客服QQ</label>
	                            		<div class="col-sm-9 form-inline" style="padding-left:15px;">
	                                		<input type="text" class="form-control" placeholder="1605904007"  value="${mkey.serviceQQ }"
	                                			name="service"   maxlength="22">
	                          	  			<a class="btn btn-info" onclick="addService(this)">添加</a><span style="color:#ccc">（最多能添加6个客服）</span>
	                            		</div>
	                        		</div>
	                        	</c:if>
	                        	<c:if test="${index!='1' }">
	                       			<div class="form-group">
	                            		<label for="" class="col-sm-3 control-label">客服QQ</label>
	                            		<div class="col-sm-9 form-inline" style="padding-left:15px;">
	                                		<input type="text" class="form-control" placeholder="1605904007"  value="${mkey.serviceQQ }"
	                                			name="service"   maxlength="22">
											<span style="margin-left:10px;" onclick="removeDiv(this)" 
												class="btn btn-info car-modal-delete-btn glyphicon glyphicon-trash">
											</span>
	                            		</div>
	                        		</div>
	                        	</c:if>
	                         	<c:set var="index" value=" $ {index++ } "></c:set>
                       		</c:forEach>
                       	</c:if>   
                       	<div id="tbody1">
                        </div>
						<div class="form-group">
					    	<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-primary"  onclick="return storeTest();">修改</button>
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
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">请在地图上标注您的地理位置</h4>
			</div>
			<div class="modal-body" id="baiduMap"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary save-coord">保存</button>
			</div>
		</div>
	</div>
</div>

<%@ include file="../public/foot.jsp"%>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
var editor;
KindEditor.ready(function(K) {
    
    editor = K.create('#intro', {
        resizeType : 1,
        allowPreviewEmoticons : true,
        allowImageUpload : true,
        allowFileManager : true,
        uploadJson: '<%=uploadUrl%>?root=demo-common-product-detail',
        fileManagerJson: '<%=uploadUrl%>?root=demo-common-product-detail',        
        items : [
            'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
            'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
            'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
            'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 
            'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
            'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
            'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'pagebreak',
            'anchor', 'link', 'unlink', '|', 'fullscreen']
    });
});
</script>

  

<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/measure.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/mark.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/searchInRectangle_min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/SearchControl_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/map.js"></script>

<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>

<script>
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
  function storeTest(){
   //  var faceImgId=document.getElementById("faceImgId").src;
     var telphone = document.getElementById("telphone");
	var busScope = document.getElementById("busScope");
	var urgentUser = document.getElementById("urgentUser");
	var urgentTel = document.getElementById("urgentTel");
	var address = document.getElementById("address");
	//var intro = document.getElementById("intro");
/* 	         
     var TJ="请上传logo！";
 var spa= "<span id='verifyCodeId'  style='color:#36c; '>"+TJ+"</span>"; */
    /* if(faceImgId==""){
      $('#logoStrId').html(spa);
      return false;
      } */
    
      var check = true;    
      
	/* if (!validatelegalTel('telphone')) {
	   
		check = false;
	}   */ 
	 
	/* if (!validatelegalName('busScope')) {
	 
		check = false;
	}   */ 
	 
	if (!validatelegalName('urgentUser')) {
	 
		check = false;
	}   
	 
	if (!validatelegalTel('urgentTel')) {
	 
		check = false;
	}   
 
	if (!validatelegalName('address')) {
		check = false;
	}   
	 
	/* if (!validatelegalName('intro')) {
	 
		check = false;
	}    */
	if (!validatelegalName2('area-box')) {
		check = false;
	}
	if (check == false) {
	 
 		return false;
	}else{
	  return true;
	}
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

 function addService(thisElem){
  var service=document.getElementsByName("service");
  if(service.length>5){
  		
  }else{
  		var thtml=" <div class='form-group'>"+
  					"<label class='col-sm-3 control-label'>客服QQ</label>"+
  					" <div class='col-sm-9 form-inline' style='padding-left:15px;'>"+
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