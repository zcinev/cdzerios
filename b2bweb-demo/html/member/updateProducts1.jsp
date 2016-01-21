<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/head3.jsp"%>
<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
<script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
#upload-full-img1 {
	width: 160px;
	border-radius: 3px;
	background-color: #ededed;
	background-image: linear-gradient(#fff, #e4e3e3);
	border: 1px solid #b1b1b1;
	color: #746D6D;
	font-family: "宋体";
	height: 27px;
	font-size: 12px;
	line-height: 15px;
	text-align: center;
} 
</style>
<script type="text/javascript">
	//检查图片的格式是否正确,同时实现预览
    function setImagePreview(obj, localImagId, imgObjPreview) {
        var array = new Array('gif', 'jpeg', 'png', 'jpg', 'bmp'); //可以上传的文件类型
        if (obj.value == '') {
            $.messager.alert("让选择要上传的图片!");
            return false;
        }
        else {
            var fileContentType = obj.value.match(/^(.*)(\.)(.{1,8})$/)[3]; //这个文件类型正则很有用 
            ////布尔型变量
            var isExists = false;
            //循环判断图片的格式是否正确
            for (var i in array) {
                if (fileContentType.toLowerCase() == array[i].toLowerCase()) {
                    //图片格式正确之后，根据浏览器的不同设置图片的大小
                    if (obj.files && obj.files[0]) {
                        //火狐下，直接设img属性 
                        //因为现在的IE和火狐都是基于相同的DOM技术
                        //所以预览图片的大小都是在这里设置
                        imgObjPreview.style.display = 'block';
                        imgObjPreview.style.width = '120px';
                        imgObjPreview.style.height = '90px';
                        //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式 
                        imgObjPreview.src = window.URL.createObjectURL(obj.files[0]);
                    }
                    else {
                        //IE下，使用滤镜 
                        obj.select();
                        var imgSrc = document.selection.createRange().text;
                        //必须设置初始大小 
                        localImagId.style.width = "400px";
                        localImagId.style.height = "400px";
                        //图片异常的捕捉，防止用户修改后缀来伪造图片 
                        try {
                            localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                            localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader=").src = imgSrc;
                        }
                        catch (e) {
                            $.messager.alert("您上传的图片格式不正确，请重新选择!");
                            return false;
                        }
                        imgObjPreview.style.display = 'none';
                        document.selection.empty();
                    }
                    isExists = true;
                    return true;
                }
            }
            if (isExists == false) {
                $.messager.alert("上传图片类型不正确!");
                return false;
            }
            return false;
        }
    }

        //显示图片  
        function over(imgid, obj, imgbig) {
            //大图显示的最大尺寸  4比3的大小  400 300  
            maxwidth = 400;
            maxheight = 300;

            //显示  
            obj.style.display = "";
            imgbig.src = imgid.src;

            //1、宽和高都超过了，看谁超过的多，谁超的多就将谁设置为最大值，其余策略按照2、3  
            //2、如果宽超过了并且高没有超，设置宽为最大值  
            //3、如果宽没超过并且高超过了，设置高为最大值  

            if (img.width > maxwidth && img.height > maxheight) {
                pare = (img.width - maxwidth) - (img.height - maxheight);
                if (pare >= 0)
                    img.width = maxwidth;
                else
                    img.height = maxheight;
            }
            else if (img.width > maxwidth && img.height <= maxheight) {
                img.width = maxwidth;                
            }
            else if (img.width <= maxwidth && img.height > maxheight) {
                img.height = maxheight;
            }
        }

	</script>
<div class="container-fluid">
	<link rel="stylesheet"
		href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
	<div class="row">
		<%--<%@ include file="../public/memberSidebar.jsp"%>
		--%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default a_panel">
				<div class="panel-heading">
					<ol class="breadcrumb bottom-spacing-0">
						<li><a href="#">产品管理</a>
						</li>
						<li class="active">配件编辑</li>
					</ol>
				</div>

				<form action="/b2bweb-demo/member/saveProducts"
					class="form-horizontal" role="form" method="post"
					style="margin-top:20px;" name="saveProducts">

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品名称：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="name" id="name" value="${mkey.name }" readonly="readonly"
								class="form-control" placeholder="" maxlength="100">
								
								<input type=hidden name="PeiJianId" id="PeiJianId" value="${mkey.id }" >
						</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">出产编号：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="leaveFactoryNumber" id="leaveFactoryNumber" class="form-control"
								placeholder="请输入出产编号" readonly="readonly" value="${mkey.leaveFactoryNumber}"
								maxlength="100"> 
						</div>
					</div>
					
					
  					<div class="form-group">
						<label for="" class="col-sm-2 control-label">配件分类：</label>
						<div class="col-sm-6 pei-kind-list">
							<input type="hidden" name="firstKindId" id="firstKindId"
								value="${mkey['autoparttype']}"> <input type="hidden"
								name="secondKindId" id="secondKindId"
								value="${mkey['autopartlist']}"> <input type="hidden"
								name="thirdKindId" id="thirdKindId"
								value="${mkey['autopartinfo']}" >
							<span class="message">配件分类不能为空[]</span>
							<span class="messageShow"> </span>
						</div>
						<div class="col-sm-10 form-group form-inline"
							style="padding-left:30px;">
							<select name="firstKind" id="firstKindId-box"
								class="form-control" readonly>
							</select> <select name="secondKind" id="secondKind-box" readonly
								class="form-control">
							</select> <select name="thirdKind" id="thirdKind-box" readonly class="form-control">
							</select>

						</div>
					</div>
					 
					  <c:if test="${key2!='null'}">
 						 <c:set var="index" value="1"/>  
 						 <c:forEach var="mkey" items="${key2}">
						<div class="form-group">
						<c:if test="${index=='1' }">
						<label for="" class="col-sm-2 control-label">适配车型：</label>
						 </c:if>
						 <c:if test="${index!='1' }">
						<label for="" class="col-sm-2 control-label"></label>
						 </c:if>
 						 <div class="col-sm-10 car-model-list" >
										<div class="clearfix">
											<a class="btn btn-info ">${mkey['brandName']}/${mkey['factoryName']}/${mkey['fctName']}/${mkey['speciName']}</a>
										</div>
									</div>
								
						</div>
					<c:set var="index" value="${index+1}"/> 	
					</c:forEach>
					</c:if>
					
					
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">选择产商：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input id="factoryIdall" name="factoryIdall" type="hidden"
								value="${mkey['factory']}" /> 
								<select name="factory" id="manufacturer-select" class="form-control"
								readonly>
 							</select>
 							
						</div>
					</div>

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">市&nbsp;&nbsp;场&nbsp;&nbsp;价：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="" name="marketprice" id="marketprice"
								value="${mkey.marketprice }" class="form-control" oninput="priceList('${discount }');"
								placeholder="市场价"  maxlength="20"> 
						</div>
					</div>

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">会&nbsp;&nbsp;员&nbsp;&nbsp;价：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="memberprice" id="memberprice"
								value="${mkey.memberprice }" class="form-control"
								placeholder="会员价" readonly="readonly"> <span class="help-block">单位为人民币（元），输入整数。如输入为空或者0，则显示为面议。</span>
						</div>
					</div>

					  <div class="form-group" style="display: none;">
						<label for="" class="col-sm-2 control-label">付款方式：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input id="paymentwayID" name="paymentwayID" type="hidden"
								value="${mkey['paymentway']}" /> <select name="paymentway"
								id="pay-way" class="form-control" readonly>
							</select>
						</div>
					</div>  

					 <div class="form-group" style="display: none;">
						<label for="" class="col-sm-2 control-label">运费承担者：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<select name="sendcost" id="sendcost" class="form-control">
								<c:if test="${mkey.sendcost=='14111809460644223322'}">
									<option selected="selected" value="${mkey.sendcost}">${mkey.sendcostName}</option>
									<option>买家</option>
								</c:if>
								<c:if test="${mkey.sendcost=='14111809455378489629'}">
									<option selected="selected" value="${mkey.sendcost}">${mkey.sendcostName}</option>
									<option>卖家</option>
								</c:if>
							</select>
						</div>
					</div>  
				
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品库存：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="" name="stocknum1" id="stocknum1"
								value="${mkey.stocknum }" class="form-control"
								placeholder="库存"  maxlength="20" readonly> 
						</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">添加数量：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="stocknum" id="stocknum"
								value="" class="form-control" placeholder="添加数量"  onblur="javascript:addNumberList();" maxlength="20">
							<input style="position: absolute;left: 35%;top: 10px;border: 0px;" id="kucunNumber" value="库存(${mkey.stocknum })件" onblur="validatelegalName('stocknum');">
								 <span class="message" >添加数量S不能为空[]</span>
                                                 <span class="messageShow" ></span>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品类别：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input id="indextype" name="indextype" type="hidden"
								value="${mkey['indextype']}" /> <select name="indextypeId"
								id="indextypeId" class="form-control" readonly >
							</select>
							
						</div>
					</div>
					<%-- <div class="form-group" style="display: none;">
						<label for="" class="col-sm-2 control-label">产品规格：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input id="standardId" name="standardId" type="hidden"
								value="${mkey['standard']}" /> <select name="standard"
								id="guige-select" class="form-control">
							</select>
						</div>
					</div> --%>

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品质保：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input id="qualityId" name="qualityId" type="hidden"
								value="${mkey['quality']}" /> <select name="guidsecurity"
								id="guidsecurity" class="form-control"  readonly>
							</select>
							
						</div>
					</div>

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品图片</label>
						<div class="col-sm-10">
							<a href="javascript:;" id="upload-full-img" 
								class="btn btn-primary"><img alt=""
								src="<%=basePathpj%>html/img/moren-upload.png">请上传一张产品图片</a>
						</div>
					</div>
					<div style="padding-left:120px;margin-top: -5px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>
					<div class="form-group" style="margin-top: 5px;">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-10" id="showImg1">
						<c:if test="${mkey['img']=='' }">
							<img id="faceImgId" src="" width="150" height="150" alt="请上传产品图片">
							</c:if>
						<c:if test="${mkey['img']!='' }">
							<img id="faceImgId" src="${mkey['img']}" width="150" height="150" alt="请上传产品图片">
							</c:if>
						</div>
					</div>
					<div id="card1">
						<input type="hidden" name="faceImg" id="faceImg" value="${mkey['img']}">
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-10" id="showImg"></div>
					</div>


						<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品详情：</label>
						<div class="col-sm-10">
							<a href="javascript:;" id="upload-full-img1" 
								class="btn btn-primary"><img alt=""
								src="<%=basePathpj%>html/img/moren-upload.png">请上传图片</a>
						</div>
					</div>
					<div style="padding-left:120px;margin-top: -5px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>
					<div class="form-group" style="margin-top: 5px;">
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
					
					<%-- <div class="form-group">
						<label for="" class="col-sm-2 control-label">产品详情：</label>
						<div class="col-sm-8">
							<textarea class="form-control" rows="15" name="description"
								id="description" maxlength="5000" > ${mkey.description}</textarea>
						</div>
					</div> --%>
					 
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">&nbsp;</label>
						<div class="col-sm-10">
							<p>
							
							<!-- 	<button type="button" class="btn btn-primary"
									onclick="UpdatePeijianList();">确认</button> -->
									<button type="button" class="btn btn-default"
									onclick="javascript:history.go(-1);">返回</button>
							</p>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="modal fade multiple-car-model">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">选择车型</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal">
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">品牌</label>
						<div class="col-sm-8">
							<select class="form-control car-brand-data">
								<option value="0">-请选择-</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">厂商</label>
						<div class="col-sm-8">
							<select class="form-control car-factory-data"></select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">车系</label>
						<div class="col-sm-8">
							<select class="form-control car-series-data"></select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">车型</label>
						<div class="col-sm-8">
							<select class="form-control car-modal-data"></select>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary save-car-modal">保存</button>
			</div>
		</div>
	</div>
</div>


<%@ include file="../public/foot3.jsp"%>

<script charset="utf-8"
	src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8"
	src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script>
function autopartinfoTest(){
     alert("你确定");
}
</script>
<script>
function confirmList(){
    return false;
}

</script>
<script type="text/javascript">

var flag="";			//flag为0表示没有其他适配车型，flag为1表示有其他适配的车型
  var bufferdata = "";
    var bufferdata1 = "";
	var buffer = ""; 
     KindEditor.ready(function(K) {
      
        
     var editor1 = K.editor({
      uploadJson : '<%=uploadUrl%>?root=demo-common-product',
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
                        bufferdata=data.url;
                         document.getElementById("faceImg").value=bufferdata;
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
    
    
    
     var editor3 = K.editor({
      uploadJson : '<%=uploadUrl%>?root=demo-common-product',
    	//店铺全景图路径
         allowFileManager : true
    });
     K('#upload-full-img1').click(function() {  
        editor3.loadPlugin('multiimage', function() {
            editor3.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    $('#showImg3').html("");
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata1=bufferdata1+","+data.url;
                         document.getElementById("faceImg3").value=bufferdata1;
                         var objRow = document.getElementById("showImg3"); 
                           
                        $('#showImg3').append('<img id="litpic6" style="width:150px;height:150px;" src="' + data.url + '">');
                      
                     });
                     editor3.hideDialog();
                     
                  }
            });
        });
    });
 });
 
   function addNumberList(){
     var stocknumStr=document.getElementById("stocknum").value;
     if(stocknumStr==""){
     stocknumStr="0";
     }
       var stocknumStr1=document.getElementById("stocknum1").value;
      if(!isNaN(stocknumStr) ){
      var ss=parseInt(stocknumStr)+parseInt(stocknumStr1);
         var sumStr="库存("+ss+")件";
     document.getElementById("kucunNumber").value=sumStr;
             
      }else{
       alert("请输入数字！");
      }
   }
 
</script>
<script type="text/javascript">
 function priceList(tt){
    var marketprice=document.getElementById("marketprice").value;
       if(!isNaN(marketprice)){
           var sum=marketprice*parseFloat(tt);
        var Parse= Math.ceil(sum); 
        document.getElementById("memberprice").value=Parse;
    
       }else{
         alert("请输入数字！");
       }
    
 }
</script>
<script>
//厂商
     $(function () {
                  
          var factoryIdall=document.all('factoryIdall').value;
           factoryValue("<%=basePath%>", factoryIdall);
          
	});
</script>
<script> 
//付款方式
     $(function () {
           var paymentway=document.all('paymentwayID').value;
         paymentwayValue("<%=basePath%>", paymentway);
	});
</script>
<%-- <script> 
//产品规格
     $(function () {
           var standardId=document.all('standardId').value;
         standardIdValue("<%=basePath%>", standardId);
	});
</script> --%>
<script> 
//质保
     $(function () {
           var qualityId=document.all('qualityId').value;
         qualityIdValue("<%=basePath%>", qualityId);
	});
</script>
<script> 
//产品类别
     $(function () {
           var indextype=document.all('indextype').value;
         indextypeIdValue("<%=basePath%>", indextype);
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
        
	});
</script>
<script>
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
});


function UpdatePeijianList(){ 
  var PeiJianId=document.getElementById("PeiJianId").value;
      var marketprice=document.getElementById("marketprice").value;		//市场价
          var memberprice=document.getElementById("memberprice").value;		//会员价
           
          var stocknum=document.getElementById("stocknum").value;		//添加数量
          if(stocknum==""){
          stocknum="0";
          }
           var stocknum1=document.getElementById("stocknum1").value;		//库存
           
           var ss=parseInt(stocknum)+parseInt(stocknum1);
                
         var description=document.getElementById("faceImg3").value;
             
          var idCardfront = document.getElementById("faceImg").value;			//图片
              
           var check = true;
	if (!validatelegalName2('marketprice')) {
		check = false;
	}
	
	if (!validateMileage('marketprice')) {
		check = false;
	}
	

	
	if (idCardfront == "" ) {
		$('#showImg1').html("请上传图像！").css({"color":"red"});
		check = false;
	}
	if (description == "" ) {
		$('#showImg3').html("请上传图像！").css({"color":"red"});
		check = false;
	}
	 
 	 if(check==true){
       $.ajax({
            type: "POST",  
            data:{id:PeiJianId,
            'marketprice':marketprice,'memberprice':memberprice,
            'stocknum':ss,
             'description':description,
            'img':idCardfront},
            url: "<%=basePath%>member/productsUpdateConfrim1",
            async:false,
            dataType: "html",
            success: function(data) {
               alert(data);
               window.location.href="<%=basePath%>member/productsLookTest";
             },
            error: function() {
            alert('请求失败');
            }
        });
         }else{
          return ;
         }  
         } 


/**
 * 验证是否为空
 */
function validateNull2(obj){
  
   	var message = $(obj).next().text();
	if($(obj).val()==null||$(obj).val().length==0){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
function validatelegalName2(thisEle) {
         var marketprice=document.getElementById("marketprice").value;
       if(!isNaN(marketprice)){
           var sum=marketprice*0.95;
             var Parse= Math.ceil(sum); 
       document.getElementById("memberprice").value=Parse;
    
       }else{
         alert("请输入数字！");
       }
      
 	var _this=document.getElementById(thisEle);
 	if(!validateNull2(_this)){
 		return false;
	} else{
 	return 	true;
	}
 
}

</script>
