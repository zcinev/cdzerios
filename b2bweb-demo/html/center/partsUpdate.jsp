<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/mchead.jsp" %>

<style>
a{
color: #666;
}
.newfont{
 	border: 0 none;
    color: #333;
    font-family: "Microsoft YaHei",arial,"Hiragino Sans GB",宋体,sans-serif;
    font-size: 13px;
    height: 24px;
    width: 180px;
   
}
</style>
<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/centerSidebar.jsp" %>
        <div class="col-md-10 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default a_panel">
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li><a href="#">产品管理</a></li>
                        <li class="active">审核配件</li>
                    </ol>
                </div>
                
                <form action="<%=basePath%>purchase/checkPartList" onsubmit="return checkList();" class="form-horizontal" role="form" method="post" style="margin-top:20px;">
					 
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">产品名称：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <input type="text" name="name" id="name" value="${mkey.name }" class="form-control" placeholder="" readonly="readonly">
                            <input type=hidden name="PeiJianId" id="PeiJianId"  value="${mkey.id }">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">产品编码：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                              <input type="text" name="number" value="${mkey.number }" style="color:#d60103;" class="form-control" placeholder="" readonly="readonly">
                        </div>
                    </div>
 
                    
                      <div class="form-group">
                        <label for="" class="col-sm-2 control-label">适配车型：</label>
                        <div class="col-sm-10 car-model-list">
                         <div class="col-sm-10 form-group form-inline">
                          <c:if test="${brandId=='' }">
                      		<a class="btn btn-info pei-kind-btn">    全部车型</a>
                          </c:if>  
                          
                            <c:if test="${brandId!='' }">
                      		<a class="btn btn-info pei-kind-btn" onclick="showModelInfo()">   查看详细</a>
                          </c:if> 
                          
                          </div>    
                               <%--   <div class="col-sm-10 form-group form-inline"
									style="padding-left:30px;">
									 <c:set var="index" value="1" /> 
									<c:forEach var="mkey" items="${key}">
									<p>${index}、${mkey['brandName']}/${mkey['factoryName']}/${mkey['fctName']}/${mkey['speciName']}</p><br>
								 <c:set var="index" value="${index+1}" />
                                    </c:forEach>
                             </div> --%>
                        </div>
                    </div>
                    
                    <div class="form-group">
                       <label for="" class="col-sm-2 control-label">配件分类：</label>
                       <div class="col-sm-6 pei-kind-list">
                           <input type="hidden" name="firstKindId" id="firstKindId" value="${mkey['autoparttypeName']}">
                           <input type="hidden" name="secondKindId"  id="secondKindId" value="${mkey['autopartlistName']}">
                           <input type="hidden" name="thirdKindId"  id="thirdKindId"value="${mkey['autopartinfoName']}">  
                           
                       </div>   
                       <div class="col-sm-10 form-group form-inline"
									style="padding-left:30px;">
									<select name="firstKind" id="firstKindId-box" class="form-control" disabled="false"> 
									<option value="${mkey['autoparttype']}">${mkey['autoparttypeName']}</option>
									</select> <select name="secondKind" id="secondKind-box" class="form-control" disabled="false">
									<option value="${mkey['autopartlist']}">${mkey['autopartlistName']}</option>
									</select> <select name="thirdKind" id="thirdKind-box" class="form-control"disabled="false">
									<option value="${mkey['autopartinfo']}">${mkey['autopartinfoName']}</option>
									</select>                                        

								</div>           
                    </div>

                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">选择产商：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                        	<input id="factoryId" name="factoryId" type="hidden"
								value="${mkey['factory']}" />
								<input id="id" name="id" type="hidden"
								value="${mkey['id']}" />
                            <select name="factory" id="manufacturer-select" class="form-control" disabled="false">
                            <option value="${mkey['factory']}">${mkey['factoryName']}</option>
                             </select>
                        </div>
                    </div>

                   <div class="form-group">
                        <label for="" class="col-sm-2 control-label">市&nbsp;场&nbsp;价：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <input type="" name="marketprice" id="marketprice" value="${mkey.marketprice }" class="form-control" placeholder="市场价" readonly="readonly">
                            <span class="help-block">单位为人民币（元），输入整数。</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">会&nbsp;员&nbsp;价：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <input type="" name="memberprice"  id="memberprice" value="${mkey.memberprice }" class="form-control" placeholder="会员价" readonly="readonly">
                            <span class="help-block">单位为人民币（元），输入整数。</span>
                        </div>
                    </div>
 
				 <div class="form-group" style="display: none;">
                        <label for="" class="col-sm-2 control-label">付款方式：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                        <input id="paymentwayID" name="paymentwayID" type="hidden"
								value="${mkey['paymentway']}" /> 
                            <select name="paymentway" id="pay-way" class="form-control" disabled="false">
                            <option value="${mkey['paymentway']}">${mkey['paymentwayName']}</option>
                             </select>
                        </div>
                    </div>
                  
                    <div class="form-group" style="display: none;"> 
                        <label for="" class="col-sm-2 control-label">运费承担者：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <select name="sendcost" id="sendcost" class="form-control" disabled="false">
                            <%-- // <c:if test="${mkey.sendcost=='14111809460644223322'}"> --%>
                            	<option selected="selected" value="${mkey.sendcost}">${mkey.sendcostName}</option>
                            <!-- 	<option >买家</option> -->
                            	<%-- </c:if> --%>
                            	<%-- <c:if test="${mkey.sendcost=='14111809455378489629'}"> --%>
                            	<option selected="selected" value="${mkey.sendcost}">${mkey.sendcostName}</option>
                            	<%-- <option >卖家</option>
                            	</c:if> --%>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">产品库存：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <input type="text" name="stocknum" id="stocknum" value="${mkey.stocknum}" class="form-control" placeholder="产品库存" readonly="readonly">
                            <span class="help-block">如输入为空，则在产品显示页上显示为空。</span>
                        </div>
                    </div>

                     <div class="form-group">
                        <label for="" class="col-sm-2 control-label">产品规格：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                        <input id="standardId" name="standardId" type="hidden"
								value="${mkey['indextype']}" /> 
                            <select name="standard" id="guige-select" class="form-control" disabled="disabled">
                            <option value="${mkey['indextype']}">${mkey['indextypeName']}</option>
                             </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">产品质保：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                         <input id="qualityId" name="qualityId" type="hidden"
								value="${mkey['quality']}" /> 
                            <select name="guidsecurity" id="quality-select" class="form-control" disabled="false">
                            <option value="${mkey['quality']}">${mkey['qualityName']}</option>
                             </select> 
                        </div>
                    </div>

<%-- 
                   <div class="form-group">
                        <label for="" class="col-sm-2 control-label">产品详情：</label>
                        <div class="col-sm-8">
                            <textarea class="form-control" rows="15" name="description" id="description" readonly="readonly"> ${mkey.description}</textarea>
                        </div>
                    </div> --%>
                    
                    
                   
					<div class="form-group" >
					<label for="" class="col-sm-2 control-label">产品详情：</label>
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-10" id="showImg3">
						<c:if test="${imgKey=='null' }">
							<img id="faceImgId3" src="" width="150" height="150" alt="请上传产品图片">
						</c:if>
							<c:if test="${imgKey!='null' }">
							<c:forEach var="mkey" items="${imgKey}">
							<img  src="${mkey['imgUrl']}" width="150" height="150" alt="请上传产品图片">
							</c:forEach>
						</c:if>
						</div>
					</div>
					<div id="card3">
						<input type="hidden" name="faceImg3" id="faceImg3" value="${mkey['description']}">
					</div>
					

                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">审&nbsp;&nbsp;&nbsp;核：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                         <c:if test="${mkey.stateName=='未审核'}">
                        <input type="radio" class="form-control"  name="showIf" id="showIf" value="1" checked>审核通过
                        <input type="radio" class="form-control" style="margin-left:20px;" name="showIf" id="showIf" value="2">审核不过
                        </c:if>
                        
                          <c:if test="${mkey.stateName=='审核通过'}">
                          <input type="radio" class="form-control"  name="showIf" id="showIf" value="1" checked disabled >审核通过
                        <input type="radio" class="form-control" style="margin-left:20px;" name="showIf" id="showIf" disabled  value="2">审核不过
                          </c:if>
                          
                           <c:if test="${mkey.stateName=='未通过'}">
                          <input type="radio" class="form-control"  name="showIf" id="showIf" value="1"  disabled>审核通过
                        <input type="radio" class="form-control" style="margin-left:20px;" name="showIf" id="showIf" disabled checked value="2">审核不过
                          </c:if>
                           <%--  <select name="showIf" id="showIf" class="form-control" 
                             <c:if test="${mkey.stateName=='审核通过'}">disabled="disabled"</c:if> >  
                               <option value="1">审核通过</option>
                              <option value="2">未通过</option>
                            </select> --%>
                        </div>
                    </div>
                  
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">&nbsp;</label>
                        <div class="col-sm-10">
                            <p>
                            <c:if test="${mkey.stateName=='未审核'}">
                                <button type="submit" class="btn btn-primary" >确认</button>
                                </c:if>
                                <button type="button" onclick="history.go(-1);" class="btn btn-default">取消</button>
                            </p>
                        </div>
                    </div>
                  <%--   </c:forEach> --%>
                </form>
            </div>
        </div>
    </div>
</div>



<div class="modal fade" id="portlet-config5" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">适配车型</h4>
				</div>
				<div class="modal-body" id="modalinfo" style="width:580px;height:400px;overflow:scroll">
						 <c:if test="${brandId!='' }">
						<c:set var="index" value="1" /> 
									<c:forEach var="mkey" items="${key}">
									<p>${index}、${mkey['brandName']}/${mkey['factoryName']}/${mkey['fctName']}/${mkey['speciName']}</p><br>
								 <c:set var="index" value="${index+1}" />
                                    </c:forEach>
                                    </c:if>
				</div>
				
				
				<div class="modal-footer">
					<!-- 	<button type="button" class="btn btn-success" >保存</button> -->
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
<%@ include file="../public/foot3.jsp"%>

<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
//<script charset="utf-8" src="<%=basePath%>html/js/com.fn.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script>
$('input').iCheck('destroy');

var editor;
KindEditor.ready(function(K) {
    
    editor = K.create('#description', {
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
    editor.readonly();
});



</script>
<script>

function showModelInfo(){
	$("#portlet-config5").modal("show");
}
     function checkList(){
        var showIf=document.getElementById("showIf").value;
         var editor=document.getElementById("editor").value;
        var check=true;
        if(showIf=="1"){
           check=true;
        }
        if(showIf=="2"){
          if(editor==""){
          alert("请填写拒绝理由！");
            check=false;
          }
        }
        
        return check;
     }   
</script>

<%-- <script>
//厂商
     $(function () {
                  
          var factoryId=document.all('factoryId').value;
         factoryValue("<%=basePath%>", factoryId);
	});
</script>
<script> 
//付款方式
     $(function () {
     document.getElementById("car-modal-data").options[document.getElementById("car-modal-data").selectedIndex].text
           var paymentway=document.all('paymentwayID').value;
        // paymentwayValue("<%=basePath%>", paymentway);
        var payment=document.getElementById("pay-way").options.value=paymentway;
	});
</script>
<script> 
//产品规格
     $(function () {
           var standardId=document.all('standardId').value;
         standardIdValue("<%=basePath%>", standardId);
	});
</script>
<script> 
//质保
     $(function () {
           var qualityId=document.all('qualityId').value;
         qualityIdValue("<%=basePath%>", qualityId);
	});
</script>
<script> 
//配件分类
     $(function () { 
     
          var firstKindId=document.all('firstKindId').value;
           var secondKindId=document.all('secondKindId').value;
            var thirdKindId=document.all('thirdKindId').value;
          PeiJianJLValue("<%=basePath%>");
          PeiJianIdValue("<%=basePath%>", firstKindId,secondKindId,thirdKindId);
          
           var brandId=document.all('brandId[]').value;
           var factoryId=document.all('factoryId[]').value;
            var seriesId=document.all('seriesId[]').value;
            var modalId=document.all('modalId[]').value;
                 
          CheXingJLValue("<%=basePath%>");
          CheXingIdValue("<%=basePath%>", brandId,factoryId,seriesId,modalId);
	});
</script> --%>
 <%-- <script>
 //修改配件信息
function UpdatePeijianList(){ 
 
          var PeiJianId=document.getElementById("PeiJianId").value;
         
   var name=document.getElementById("name").value;
   var firstKindId=document.getElementById("firstKindId-box").value;
   var secondKindId=document.getElementById("secondKind-box").value;
   var thirdKindId=document.getElementById("thirdKind-box").value;
             
    var brandId=document.getElementById("brandId-box").value;
     var factoryId=document.getElementById("factoryId-box").value;
      var seriesId=document.getElementById("seriesId-box").value;
       var modalId=document.getElementById("modalId-box").value;
        var factory=document.getElementById("manufacturer-select").value;
                  
         var marketprice=document.getElementById("marketprice").value;
          var memberprice=document.getElementById("memberprice").value;
           var paymentway=document.getElementById("pay-way").value;
               
            var sendcost=document.getElementById("sendcost").value;
          
             var stocknum=document.getElementById("stocknum").value;
              var standard =document.getElementById("guige-select").value;
             
               var guidsecurity=document.getElementById("quality-select").value;
                var description=document.getElementById("description").value;
             
                 alert(PeiJianId);
                  
      $.ajax({
            type: "GET",  
            data:{'id':PeiJianId,'name':name,'firstKindId':firstKindId, 'secondKindId':secondKindId,
            'thirdKindId':thirdKindId,'brandId':brandId,'factoryId':factoryId,
            'seriesId':seriesId,
            'modalId':modalId,'factory':factory,
            'marketprice':marketprice,'memberprice':memberprice,'paymentway':paymentway,
            'sendcost':sendcost,
            'stocknum':stocknum,'standard':standard,'guidsecurity':guidsecurity,
             'description':description},
            url: "<%=basePath%>member/productsUpdateConfrim",
            async:false,
            dataType: "html",
            success: function(data) {
               alert("修改成功！");
              // window.location.href="<%=basePath%>member/productsLookTest";
             },
            error: function() {
            _this.text('请求失败');
            }
        });
}

</script> --%>
