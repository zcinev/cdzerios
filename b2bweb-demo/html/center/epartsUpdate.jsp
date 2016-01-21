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

