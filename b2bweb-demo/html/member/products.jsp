<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/head3.jsp"%>
<link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script src="<%=basePath%>html/js/Calendar3.js" type="text/javascript"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
/* 验证样式 */
.message {
	display: none;
}

.messageLabel {
	color: red;
}

.messageShow {
	font-size: 10px;
	color: red;
}

#upload-full-img {
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
#btn-5 {
	background-color:#3071A9;
	/* background-image: linear-gradient(to top, #f5fbef 0px, #eaf6e2 100%); */
	border: 1px solid #285E8E;
	border-radius: 2px;
	color: #fff;
	display: inline-block;
	height: 30px;
	line-height: 18px;
	padding: 2px 14px 3px;
}
</style>
<style>
.modal-content{
border-radius:0px;
border: 2px solid #00a9ff;
width: 800px;
}
button.close{
width:35px;
height:35px;
background-color: #00a9ff;

}
.close {
    color:white;
    float: right;
    font-size: 21px;
    font-weight: 700;
    line-height: 1;
}

.modal-title{
color:#222;font-size: 24px;margin-left: 14px;font-family: 'MicrosoftYahei','微软雅黑','Arial';
}
.li1{
background-image: url("<%=basePathpj%>html/img/carmodal1.png");
background-repeat: no-repeat;
width: 157px;
height: 38px;
}
.li2{
background-image: url("<%=basePathpj%>html/img/carmodal2.png");
background-repeat: no-repeat;
width: 157px;
height: 38px;
}
.modal-body .form-horizontal .form-group ul li{
list-style-type: none;
float: left;display: inline;
margin-left: 20px;
padding-left:20px;
width: 165px;
padding-top: 9px;
}
.modal-body .form-horizontal .form-group ul li .span1{

width: 20px;
height: 20px;
background-color: white;
float: left;
color:#00a9ff;
border-radius:13px;
padding-left:6px;
padding-top:2px;
}
.modal-body .form-horizontal .form-group ul li .span2{
width: 100px;
height: 20px;
float:left;
margin-left: 10px;
margin-top: 2px;
color: white;
}
.cpinpai span{
margin-left: 15px;
cursor: pointer;
}

.cdetail ul li{
float: left;
display: inline;
margin-left: 40px;
width: 100px;
height: 50px;
border: 1px solid #ddd;

margin-top: 20px;
}
.cdetail ul li img{
float: left;
width: 30px;
height: 24px;
margin-top: 3px;
}
.cdetail ul li span{
float: left;
min-width:70px;
height: 30px;
font-size: 14px;
padding-top:5px;
margin-left: 10px;
color: #6c6c6c;
}
.thisClass{
color: #00a9ff;
padding:5px;

}
#brandul li{
width: 160px;
}
#brandul li:hover{
border:1px solid #00a9ff;
cursor: pointer;
}
.glyphicon-remove1{
width:12px;
height:12px;
background-color:#00a9ff;
padding-bottom:10px;
border-radius:9px;
float: right;
margin-top: -8px;
color: white;
margin-right: -28px;
font-weight: normal;
padding-left:2px;
line-height: 7px;
}

.glyphicon-remove1:before{
content: "×";


}
#brandul{
height:320px;
overflow: auto;
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
	<div class="row">
		<%--<%@ include file="../public/memberSidebar.jsp"%>
		--%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default a_panel" style="width:1100px">
				<div class="panel-heading"
					style="background-color: #ecf9ff;border-color: #ddd;">
					<ol class="breadcrumb bottom-spacing-0">
						<li><a href="#">产品管理</a>
						</li>
						<li class="active">添加配件</li>
					</ol>
				</div>

				<form action="" class="form-horizontal" role="form" method="post"
					style="margin-top:20px;">

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">配件分类：</label>
						<div class="col-sm-6 pei-kind-list">
							<input type="hidden" name="firstKindId" id="firstKindId" value="">
							<input type="hidden" name="secondKindId" id="secondKindId"value=""> 
							<input type="hidden" name="thirdKindId" id="thirdKindId" value=""> 
							<a class="btn btn-info pei-kind-btn">选择分类</a> 
							<span class="message">配件分类不能为空[]</span>
							<span class="messageShow"> </span>
						</div>
					</div>

		<!-- 	<div class="form-group">
						<label for="" class="col-sm-2 control-label">适配车型：</label>
						<div class="col-sm-10 car-model-list">
							<div class="clearfix">
								<a class="btn btn-info car-modal-btn1" id="modalIdStr">选择车型</a>

								<div class="hidden">
									<input type="hidden" name="brandId" id="brandId" value="">
									<input type="hidden" name="factoryId" id="factoryId" value="">
									<input type="hidden" name="seriesId" id="seriesId" value="">
									<input type="hidden" name="modalId" id="modalId" value="">
								</div>

								<span
									class="btn btn-info car-modal-plus-btn glyphicon glyphicon-plus"></span>
								<span id="modelidTestid"></span>
							</div>

						</div>
					</div>  -->
	
				<div class="form-group">
						<label for="" class="col-sm-2 control-label" id="suitId">适配车型：</label>
						<div class="col-sm-10 car-model-list">
							<div class="clearfix" style="min-width:440px;float:left;width:auto";display:inline-block;>
								<a class="btn btn-info car-modal-btn1"  id="modalIdStr"  onclick="modalShow()">选择车型</a>
								
									<input type="hidden" name="brandId1"  value="">
									<input type="hidden" name="factoryId1"  value=""> 
									<input type="hidden" name="fctId1"  value="">
									<input type="hidden" name="speciId1" id="speciId"  value="">
								<!-- 	<input type="hidden" name="carmodels" id="carmodels" value="">
									<input type="hidden" name="biaoji" id="biaoji"  value=""> -->
							<span
									class="btn btn-info car-modal-plus-btn glyphicon glyphicon-plus"></span>
								<span id="modelidTestid"></span>
							</div>
							
						</div>
					</div>
	
	
						<div class="form-group" >
						<label for="" class="col-sm-2 control-label"></label>
						<div class="col-sm-8 form-inline" style="padding-left:40px;" id='CarModelList'>
							
						</div>
					</div>
			
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品名称：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="name" id="name" class="form-control"
								placeholder="请输入产品名称" onblur="validatelegalName('name');"
								maxlength="100"> <span class="message">产品名称不能为空[]</span>
							<span class="messageShow"></span>
						</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">出产编号：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="leaveFactoryNumber" id="leaveFactoryNumber" class="form-control"
								placeholder="请输入出产编号" onblur="validatelegalName('leaveFactoryNumber');"
								maxlength="100"> <span class="message">出产编号不能为空[]</span>
							<span class="messageShow"></span>
						</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">选择生产商：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<select name="factory" id="factory" class="form-control"
								onblur="validatelegalAndZero('factory');">
							</select> <span class="message">产商不能为空[]</span> <span class="messageShow"></span>
						</div>
					</div>

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">市&nbsp;场&nbsp;价：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="" name="marketprice" id="marketprice" value=""
								class="form-control" placeholder="市场价"
								onblur="validateMileage('marketprice');" maxlength="20"
								oninput="priceList('${discount }');"> <span class="message">市场价不能为空[]</span>
							<span class="messageShow"></span>
						</div>
					</div>
					<input type="hidden" id="discount" value="${discount }">
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">会&nbsp;员&nbsp;价：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="" name="memberprice" id="memberprice" value=""
								class="form-control" placeholder="会员价" readonly="readonly">
							<span class="help-block">单位为人民币（元），输入整数。如输入为空或者0，则显示为面议。</span>
						</div>
					</div>

					<%-- <div class="form-group">
						<label for="" class="col-sm-2 control-label">付款方式：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<select name="paymentway" id="paymentway" class="form-control">

								<c:forEach var="mkey" items="${key}">
									<option value="${mkey['name']}">${mkey['name']}</option>
								</c:forEach>
							</select>
						</div>
					</div> --%>

					<%-- <div class="form-group">
						<label for="" class="col-sm-2 control-label">运费承担者：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<select name="sendcost" id="sendcost" class="form-control">

								<c:forEach var="mkey" items="${key2}">
									<option value="${mkey['name']}">${mkey['name']}</option>
								</c:forEach>
							</select>
						</div>
					</div> --%>

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">添加数量：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;"
							id="addNumberId">
							<input type="text" name="stocknum" id="stocknum"
								class="form-control" placeholder="添加数量"
								onblur="validateMileage('stocknum');" maxlength="20">&nbsp;&nbsp;
							<span class="message">添加数量S不能为空[]</span> <span
								class="messageShow"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品类别：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<select name="indextypeId" id="indextypeId" class="form-control" style="width:180px;"
								onblur="validatelegalName('indextypeId');">

								<c:forEach var="mkey" items="${key5}">
									<option value="${mkey['id']}">${mkey['name']}</option>
								</c:forEach>

							</select> <span class="message">产品类别不能为空[]</span> <span
								class="messageShow"></span>
						</div>
					</div>
					<%-- <div class="form-group">
						<label for="" class="col-sm-2 control-label">产品规格：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<select name="standard" id="standard" class="form-control">

								<c:forEach var="mkey" items="${key3}">
									<option value="${mkey['name']}">${mkey['name']}</option>
								</c:forEach>
							</select>
						</div>
					</div> 以后要用--%>

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品质保：</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<select name="guidsecurity" id="guidsecurity"
								class="form-control" onblur="validatelegalName('guidsecurity');">
								<c:forEach var="mkey" items="${key4}">
									<option value="${mkey['id']}">${mkey['name']}</option>
								</c:forEach>
							</select> <span class="message">产品质保不能为空[]</span> <span
								class="messageShow"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">产品图片：</label>
						<div class="col-sm-10">
							<a href="javascript:;" id="upload-full-img" 
								class="btn btn-primary"><img alt=""
								src="<%=basePathpj%>html/img/moren-upload.png">请上传一张产品图片</a>
						</div>
					</div>
					<div style="padding-left:190px;margin-top: -5px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>
					<div class="form-group" style="margin-top: 5px;">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-10" id="showImg1">
							<img id="faceImgId" src="" width="150" height="150" alt="请上传产品图片">
						</div>
					</div>
					<div id="card1">
						<input type="hidden" name="faceImg" id="faceImg" value="">
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
					<div style="padding-left:190px;margin-top: -5px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>
					<div class="form-group" style="margin-top: 5px;">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-10" id="showImg3">
							<img id="faceImgId3" src="" width="150" height="150" alt="请上传产品图片">
						</div>
					</div>
					<div id="card3">
						<input type="hidden" name="faceImg3" id="faceImg3" value="">
					</div>
					
					<!-- <div class="form-group">
						<label for="" class="col-sm-2 control-label">产品详情：</label>
						<div class="col-sm-8">
							<textarea class="form-control" rows="15" name="description"
								id="description" placeholder="请介绍您的产品！" maxlength="5000"></textarea>
						</div>
					</div> -->
					<!--   
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">排&nbsp;&nbsp;序&nbsp;&nbsp;号：</label>
                        <div class="col-sm-8 form-inline" style="padding-left:15px;">
                            <input type="" class="form-control" placeholder="0" id="sortId" name="sortId">
                        </div>
                    </div>
                    -->
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">&nbsp;</label>
						<div class="col-sm-10">
							<p>
								<button type="button" class="btn btn-primary"
									onclick="AddPeijianList('<%=basePath%>');" id="btn-5">确认</button>
								<button type="button" class="btn btn-default"
									onclick="javascript:history.go(-1);">取消</button>
							</p>
						</div>
					</div>
				</form>

			</div>
		</div>
	</div>
</div>

<!--  <div class="modal fade multiple-car-model">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" style="float:right;">
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
				<button type="button" class="btn btn-primary save-car-modal" id="saveCarModelId">保存</button>
			</div>
		</div>
	</div>
</div> 
 -->


<div class="modal fade multiple-pei-kind">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">选择配件分类</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal">
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">一级分类</label>
						<div class="col-sm-8">
							<select class="form-control first-kind-data">
								<option value="0">-请选择-</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">二级分类</label>
						<div class="col-sm-8">
							<select class="second-kind-data form-control"></select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">三级分类</label>
						<div class="col-sm-8">
							<select class="third-kind-data form-control"></select>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary save-pei-kind"
					id="save-pei-kind">保存</button>
			</div>
		</div>
	</div>
</div>



	<div class="modal fade car-model" style="margin-left: -200px;" id="car-model">
        <div class="modal-dialog">
            <div class="modal-content" id="model1" >
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"style="float:right;">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
                    <h4 class="modal-title" ><img alt="" src="<%=basePathpj%>html/img/carmodal.png">选择车型</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                     <div class="form-group">
                           <ul id="urlNode">
                           <li class="li2"><span class="span1">1</span><span class="span2">选择品牌</span></li>
                            <li class="li1"><span class="span1">2</span><span class="span2">选择厂商</span></li>
                             <li class="li1"><span class="span1">3</span><span class="span2">选择车系</span></li>
                              <li class="li1"><span class="span1">4</span><span class="span2">选择车型</span></li>
                           </ul>
                        </div>
                     <div class="form-group cpinpai" id="cpinpai">
                     <span onclick="selectAll(this);">全选</span>
                           <span style="float: left;margin-left: 60px;">品牌首字母选择：
                           <span id="hot" class="thisClass" onclick="showBrands('热门');">热门</span> 
                           <span onclick="showBrands('A');">A</span>
                           
                           <span onclick="showBrands('B');">B</span>
                           <span onclick="showBrands('C');">C</span>
                           <span onclick="showBrands('D');">D</span>
                          
                           <span onclick="showBrands('F');">F</span>
                           <span onclick="showBrands('G');">G</span>
                            <span onclick="showBrands('H');">H</span>
                            <span onclick="showBrands('J');">J</span>
                             <span onclick="showBrands('K');">K</span>
                              <span onclick="showBrands('L');">L</span>
                               <span onclick="showBrands('M');">M</span>
                               <span onclick="showBrands('N');">N</span>
                               <span onclick="showBrands('O');">O</span>
                               <span onclick="showBrands('Q');">Q</span>
                                <span onclick="showBrands('R');">R</span>
                                <span onclick="showBrands('S');">S</span>
                                <span onclick="showBrands('T');">T</span>
                                <span onclick="showBrands('W');">W</span>
                                <span onclick="showBrands('X');">X</span>
                                <span onclick="showBrands('Y');">Y</span>
                                <span onclick="showBrands('Z');">Z</span>
                           </span>
                        </div>
                     <div class="form-group cdetail" id="cdetail">
                          <ul id="brandul">
                          
                          <li onclick="showFactory('33')"><img src="<%=basePathpj%>html/img/audi.png"/><span>奥迪</span></li>
                           <li onclick="showFactory('15')"><img src="<%=basePathpj%>html/img/BBM.png"/><span>宝马</span></li>
                            <li onclick="showFactory('14')"><img src="<%=basePathpj%>html/img/bentian.png"/><span>本田</span></li>
                             <li onclick="showFactory('13')"><img src="<%=basePathpj%>html/img/biaozhi.png"/><span>标致</span></li>
                              <li onclick="showFactory('38')"><img src="<%=basePathpj%>html/img/buick.png"/><span>别克</span></li>
                               <li onclick="showFactory('75')"><img src="<%=basePathpj%>html/img/byd.png"/><span>比亚迪</span></li>
                                <li onclick="showFactory('1')"><img src="<%=basePathpj%>html/img/dazhong.png"/><span>大众</span></li>
                                 <li onclick="showFactory('3')"><img src="<%=basePathpj%>html/img/fengtian.png"/><span>丰田</span></li>
                                  <li onclick="showFactory('8')"><img src="<%=basePathpj%>html/img/ford.png"/><span>福特</span></li>
                                   <li onclick="showFactory('12')"><img src="<%=basePathpj%>html/img/modern.png"/><span>现代</span></li>
                                    
                          </ul>
                          <div class="pull-right" style="margin-top:20px;margin-right:30px;">
                           <button type="submit" class="btn btn-primary" id="selectButton" onclick="selectAll1(this);">全选</button>
                          <button type="submit" class="btn btn-primary" id="saveButton" onclick="saveClose()">确定</button>
                          </div>
                        </div>
                    </div>
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
				<div class="modal-body" id="modalinfo" style="width:680px;height:400px;overflow:scroll">
				
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


<script charset="utf-8"
	src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8"
	src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript">
 function priceList(tt){
 	var discount=document.getElementById("discount").value;
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


var flag="";			//flag为0表示没有其他适配车型，flag为1表示有其他适配的车型

var thirdKindIdRR="";


$(function() {
         ajaxGetData('#factory',"<%=basePath%>member/producerBoxList");			//选择产商
         
          $('.car-modal-plus-btn').click(function() {
         
         var _html = '<div class="clearfix">';
            _html+= '<a class="btn btn-info car-modal-btn1" onclick="modalShow()">选择车型</a>';
             _html+= '<div class="hidden">';
            _html+= '<input type="hidden" name="brandId1"  value="">';
            _html+= '<input type="hidden" name="factoryId1"  value="">';
            _html+= '<input type="hidden" name="fctId1"  value="">';
            /*  _html+= '<input type="hidden" name="biaoji1"  value="">'; */
            _html+= '<input type="hidden" name="speciId1"  value=""></div>'; 
            _html+= ' <span class="btn btn-info car-modal-delete-btn glyphicon glyphicon-trash"></span></div>';
        $(this).closest('.car-model-list').append(_html);
         
    });
      

    $('.car-model-list').delegate('.car-modal-delete-btn','click',function() {
    	var index=$(this).parent().index();
    	var tt="."+index;
    	$("#modalinfo").find(tt).remove();
        $(this).closest('.clearfix').remove();
    });
                 
            peiKindItemSelect("<%=basePath%>",'thirdKindId');
         	
            document.getElementById("thirdKindId").value=thirdKindIdRR;
            
           
                
                        
              
     
});
</script>
<script>
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
 
</script>
<script>
function AddPeijianList(url){  
   var name=document.getElementById("name").value;					//产品名称
   var firstKindId=document.getElementById("firstKindId").value;	//配件一级分类
   var secondKindId=document.getElementById("secondKindId").value;	//配件二级分类
   var thirdKindId=document.getElementById("thirdKindId").value;	//配件三级分类
      var brandId=""; 
      var factoryId="";
      var seriesId="";
      var modalId="";
    var brand=document.getElementsByName("brandId");			//品牌
     var factory=document.getElementsByName("factoryId");		//厂商
      var series=document.getElementsByName("fctId");		//车型
       var modal=document.getElementsByName("speciId");		//车系
       
       var tbrandId=document.getElementsByName("brandId1")[0].value;
       
       if(tbrandId=="0"){
       	brandId=brandId+"-0";
       	factoryId=factoryId+"-0";
       	seriesId=seriesId+"-0";
       	modalId=modalId+"-0";
       }else{
       	 for(var i=0;i<brand.length;i++){
    	brandId=brandId+"-"+brand[i].value;
    	} 
    	for(var i=0;i<factory.length;i++){
    	factoryId=factoryId+"-"+factory[i].value;
    	} 
    	for(var i=0;i<series.length;i++){
    	seriesId=seriesId+"-"+series[i].value;
    	} 
    	for(var i=0;i<modal.length;i++){
    	modalId=modalId+"-"+modal[i].value;
    	} 
       }
       
    
    	
        var factory=document.getElementById("factory").value;		//配件生产商
     	var factoryName1=$("#factory option[value='" + factory + "']").text();
            
            
          var marketprice=document.getElementById("marketprice").value;		//市场价
          var memberprice=document.getElementById("memberprice").value;		//会员价
            var paymentway="";
                 
           var sendcost="";
          
             var stocknum=document.getElementById("stocknum").value;		//库存
              var standard ="";
              
               var guidsecurity=document.getElementById("guidsecurity").value;	//质保
               var guidsecurityName=$("#guidsecurity option[value='" + guidsecurity + "']").text();
               
                var description=document.getElementById("faceImg3").value;
                 var indextypeId=document.getElementById("indextypeId").value;		//类别
                  var indextypeName=$("#indextypeId option[value='" + indextypeId + "']").text();
                 
               var idCardfront = document.getElementById("faceImg").value;			//图片
               var leaveFactoryNumber=document.getElementById("leaveFactoryNumber").value;
               var check = true;
	if (!validatelegalName('name')) {
 		check = false;
	} 
	if (!validatelegalName('leaveFactoryNumber')) {
 		check = false;
	}   
	
	if (!validateMileage('marketprice')) {
		check = false;
	}
	if (!validatelegalName('stocknum')) {
		check = false;
	}
	 if (!validatelegalAndZero('factory')) {
		check = false;
	} 
	if(!validateMileage('stocknum')){
		check = false;
	}
	
	if (!validatelegalName3('thirdKindId')) {
 		check = false;
	}
	if(varValue!=2){
	if (!validatelegalName2()) {
 		check = false;
	}
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
            data:{'name':name,'firstKindId':firstKindId,
            'secondKindId':secondKindId,'thirdKindId':thirdKindId,
            'brandId':brandId,'factoryId':factoryId,
            'seriesId':seriesId,'modalId':modalId, 
            
            'factory':factory,
            'factoryName1':factoryName1,
            'marketprice':marketprice,'memberprice':memberprice,'paymentway':paymentway,
            'sendcost':sendcost,
            'stocknum':stocknum,'standard':standard,'guidsecurity':guidsecurity,
             'description':description,
             'guidsecurityName':guidsecurityName,
             'indextypeName':indextypeName,'indextypeId':indextypeId,
             'img':idCardfront,'leaveFactoryNumber':leaveFactoryNumber},
            url: "<%=basePath%>member/productsAddConfrim",
            async:false,
            dataType: "html",
            success: function(data) {
               alert("添加成功！");
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
<script>
 function validatelegalName2() {
  
	var len=$("#brandul").children("li").length;
	if(len==0){
 		 $('#modelidTestid').html("请选择适配车型！").css({"color":"red"});
 		return false;
	}else{
   		 $('#modelidTestid').html("");
  	}
	return true;
}
function validatelegalName3(thisEle) {
   	var obj=document.getElementById(thisEle);
 	var message = $(obj).next().next().text();
	if($(obj).val()==null||$(obj).val().length==0){
 		$(obj).next().next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().next().text("");
  			return true;
  	}
}

</script>
<script>
var kvalue1="-1";						//-1表示未从已选择的车型再添加
var varValue=0;							//0表示单选；1表示某个品牌下的车型全选；2代表品牌全选
var selectButton=document.getElementById("selectButton");
var saveButton=document.getElementById("saveButton");

var thisElem11="";
var str22=$("#cpinpai").html();
var hot=document.getElementById("hot");
hot.onclick();
var obj1="";
var obj2="";
var obj3="";
var obj4="";
var buffer="";
var buffer1="";
var buffer2="";
var buffer3="";
var buffer4="";
var buffer5="";
var buffer6="";
var buffer7="";
var buffer8="";
var car="";
var brand="";
var brandName="";
var factory="";
var factoryName="";
var fct="";
var fctName="";
var speci="";
var speciName="";
var spanNum=$("#cpinpai span span");
var value =$(this).text();
for(j=0;j<spanNum.length;j++){
spanNum.click(function(){
$(this).addClass("thisClass").siblings().removeClass("thisClass");
});
}


	
function showBrands(obj){

selectButton.style.display="none";
saveButton.style.display="none";
speci="";
speciName="";
obj1=obj;
  $.ajax({
        type: "post",
        data:{'value':obj},
        url: "/b2bweb-repair/cost/showBrand",
        async:true,
        dataType: "json",
        async: false,
		success: function(data) {
		document.getElementById("brandul").innerHTML="";
		for(var i=0; i<data.length; i++){
		document.getElementById("brandul").innerHTML+="<li onclick=\"showFactory('"+data[i].id+"','"+data[i].name+"')\"><img  src='"+data[i].imgurl+"'"+"/><span style='max-width:80px;white-space: nowrap; text-overflow:none; overflow:hidden;' title='"+data[i].name+"'>"+data[i].name+"</span></li>";
		}
		buffer1=document.getElementById("brandul").innerHTML;
		
		},
		error : function() {
		alert("fail");
		}
		});
}

function showFactory(obj,value){

selectButton.style.display="none";
saveButton.style.display="none";
brand=obj;
brandName=value;
obj2=obj;


		buffer2=$('#cpinpai').html();
		$('#cpinpai').html="";
		$('#cpinpai').html(" <span style=' float: left;margin-left: 60px;'>已选车型：</span>");
		var text =value;
		$('#cpinpai').append(" <span id='forchoice1' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove1\"></p></span>");
		
		buffer=$('#cpinpai').html();
		var len=$('#cpinpai').find("span").length-1;
		$("#urlNode").children("li").get(len).setAttribute("class","li2");
		$('#forchoice1').click(function(){
		$('#forchoice1').slideToggle();
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1);
		});
		
	  $.ajax({
        type: "post",
        data:{'id':obj},
        url: "/b2bweb-repair/cost/showFactory",
        async:true,
        dataType: "json",
        async: false,
		success: function(data) {
		buffer3=document.getElementById("brandul").innerHTML;
		document.getElementById("brandul").innerHTML="";
		for(var i=0; i<data.length; i++){
		document.getElementById("brandul").innerHTML+="<li onclick=\"showFct('"+data[i].id+"','"+data[i].name+"')\"><span title='"+data[i].name+"'>"+data[i].name+"</span></li>";
		}
		
		$('#forchoice1').click(function(){
		showBrands(obj1);
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1,value);
		});
		},
		error : function() {
		alert("fail");
		}
		});
}


function showFct(obj,value){
selectButton.style.display="none";
saveButton.style.display="none";
factory=obj;
factoryName=value;
obj3=obj;

$('#cpinpai').html=buffer;
		buffer4=$('#cpinpai').html();
		var text =value;
		$('#cpinpai').append(" <span id='forchoice2' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove1\"></p></span>");
		buffer=$('#cpinpai').html();
		var len=$('#cpinpai').find("span").length-1;
		$("#urlNode").children("li").get(len).setAttribute("class","li2");
		
		$('#forchoice2').click(function(){
		$('#cpinpai').html(buffer4);
		$('#brandul').html(buffer3);
		$("#urlNode").children("li").get(2).setAttribute("class","li1");
		showFactory(obj2,value);
		});
		
	  $.ajax({
        type: "get",
        data:{'id':obj},
        url: "/b2bweb-repair/cost/showFct",
        async:false,
        dataType: "json",
        async: false,
		success: function(data) {
		buffer5=document.getElementById("brandul").innerHTML;
		document.getElementById("brandul").innerHTML="";
		for(var i=0; i<data.length; i++){
		
		document.getElementById("brandul").innerHTML+="<li onclick=\"showSpeci('"+data[i].id+"','"+data[i].name+"')\"><img  src='"+data[i].imgurl+"'"+"/><span style='max-width:80px;white-space: nowrap; text-overflow:none; overflow:hidden;' title='"+data[i].name+"'>"+data[i].name+"</span></li>";
		
		}
	
	
		$('#forchoice2').click(function(){
		$('#cpinpai').html(buffer4);
		$('#brandul').html(buffer3);
		$("#urlNode").children("li").get(2).setAttribute("class","li1");
		showFactory(obj2,value);
		});
		$('#forchoice1').click(function(){
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1);
		});
		
		},
		error : function() {
		alert("fail");
		}
		});
	
}
	
function showSpeci(obj,value){
$("#selectButton").text("全选");
selectButton.style.display="";
saveButton.style.display="";
fct=obj;
fctName=value;
obj4=obj;


$('#cpinpai').html=buffer;
		buffer6=$('#cpinpai').html();
		var text =value;
		car=value;
	 	$('#cpinpai').append(" <span id='forchoice3' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove1\"></p></span><div></div>");
		buffer=$('#cpinpai').html();
		var len=$('#cpinpai').find("span").length-1;
		$("#urlNode").children("li").get(len).setAttribute("class","li2");
		$('#forchoice3').click(function(){
		$('#forchoice3').slideToggle();
		$('#cpinpai').html(buffer6);
		$('#brandul').html(buffer5);
		$("#urlNode").children("li").get(3).setAttribute("class","li1");
		showFct(obj3,value);
		});
		
	  $.ajax({
        type: "get",
        data:{'id':obj},
        url: "/b2bweb-repair/cost/showSpeci",
        async:true,
        dataType: "json",
        async: false,
		success: function(data) {
		buffer7=document.getElementById("brandul").innerHTML;
		document.getElementById("brandul").innerHTML="";
		$('#cpinpai').html=buffer;
		buffer8=$('#cpinpai').html();
		for(var i=0; i<data.length; i++){
		
		document.getElementById("brandul").innerHTML+="<li style='padding-left:0px;margin-left: 5px;width:175px;' onclick=\"saveCarModel('"+data[i].id+"','"+data[i].name+"',this)\"><span style='font-size: 12px;' title='"+data[i].name+"'>"+data[i].name+"</span></li>";
		}
		
		var dlNum  =$("#cdetail #brandul").find("li");
		
		var text =$(this).text();
		
		/* $('#cpinpai').append(" <span id='forchoice4' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove1\"></p></span>");
		buffer=$('#cpinpai').html(); */

		$('#forchoice4').click(function(){
		$('#forchoice4').slideToggle();
		$('#cpinpai').html(buffer8);
		$('#brandul').html(buffer7);
		showSpeci(obj4,value);
		
		});
		$('#forchoice3').click(function(){
		$('#forchoice3').slideToggle();
		$('#cpinpai').html(buffer6);
		$('#brandul').html(buffer5);
		$("#urlNode").children("li").get(3).setAttribute("class","li1");
		showFct(obj3,value);
		});
		$('#forchoice2').click(function(){
		$('#cpinpai').html(buffer4);
		$('#brandul').html(buffer3);
		$("#urlNode").children("li").get(2).setAttribute("class","li1");
		showFactory(obj2,value);
		});
		$('#forchoice1').click(function(){
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1);
		});
		},
		error : function() {
		alert("fail");
		}
		});
		
		if(kvalue1!="-1"){
			resultFun(kvalue1);
		}
}	


function saveCarModel(obj,value,thisElm){
speci=speci+"-"+obj;
speciName=speciName+"-"+value;

		var speci2=document.getElementsByName("speciId");
		var tag1="s";
		if(speci2.length==0){
			tag1="s";
		}else{
			for(var i=0;i<speci2.length;i++){
			if(speci2[i].value==obj){
				tag1=i;
				break;
			}
		}
		}
		
		if(tag1=="s"){
			$(thisElm).css("border","1px solid #00a9ff");
		}else{
			$(thisElm).css("border","1px solid #ccc");
			$("#modalinfo").children("div").get(tag1).remove();
			return;
		}
		
		var text =$(thisElm).text();
		 var len=$('#cpinpai').find("span").length-1;
		for(var i=4;i<=len;i++){
		$('#cpinpai').find("#forchoice4").remove();
		} 
		
	/* 	$('#cpinpai').html(buffer+" <span id='forchoice4' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove1\"></p></span>");
		/* buffer=$('#cpinpai').html(); */
 
		$('#forchoice4').click(function(){
		$('#forchoice4').slideToggle();
		$('#cpinpai').html(buffer8);
		$('#brandul').html(buffer7);
		showSpeci(obj4,fctName);
		});
	 	
	 	
	 	 
		$('#forchoice3').click(function(){
		$('#forchoice3').slideToggle();
		$('#cpinpai').html(buffer6);
		$('#brandul').html(buffer5);
		$("#urlNode").children("li").get(3).setAttribute("class","li1");
		showFct(obj3,value);
		});
		$('#forchoice2').click(function(){
		$('#cpinpai').html(buffer4);
		$('#brandul').html(buffer3);
		$("#urlNode").children("li").get(2).setAttribute("class","li1");
		showFactory(obj2,value);
		});
		$('#forchoice1').click(function(){
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1);
		});
	
		aa(obj,value);

<%-- var url11="<%=basePath%>member/CarModelList?fiveModel="+thirdKind11;
 ajaxGetModelAnd('#CarModelList',url11,brand,factory,fct,speci);
 $('.close').click();

hot.onclick(); --%>

}	
function aa(obj,value){

	
var carModel=brandName+"/"+factoryName+"/"+fctName+"/"+"更多>>";

var carModel2=brandName+"/"+factoryName+"/"+fctName+"/"+value;

brand=brand;
factory=factory;
fct=fct;

if(kvalue1=="-1"){
thisElem11.text(carModel);

$(thisElem11).removeClass("car-modal-btn1");

$(thisElem11).get(0).setAttribute("onclick","showInfo()");


var index=$(thisElem11).parent().index();
			
			var class1=index;
	     	 var _html = "<div class='"+class1+"'><div class='clearfix'>";
            _html+= "<a class='btn btn-info'>"+carModel2+"</a>";
             _html+= "<div class='hidden'>";
            _html+= "<input type='hidden' name='brandId'  value='"+brand+"'>";
            _html+= "<input type='hidden' name='factoryId'  value='"+factory+"'>";
            _html+= "<input type='hidden' name='fctId'  value='"+fct+"'>";
            _html+= "<input type='hidden' name='speciId'  value='"+obj+"'></div>"; 
             _html+= " <span class='btn btn-info car-modal-delete-plus glyphicon glyphicon-plus' onclick=\"addInfo1(this);\"></span>";
            _html+= " <span class='btn btn-info car-modal-delete-btn glyphicon glyphicon-trash' onclick=\"removeInfo1(this);\"></span></div></div>";
        	$("#modalinfo").append(_html);	
}else{

	     	 var _html = "<div class='"+kvalue1+"'><div class='clearfix'>";
            _html+= "<a class='btn btn-info'>"+carModel2+"</a>";
             _html+= "<div class='hidden'>";
            _html+= "<input type='hidden' name='brandId'  value='"+brand+"'>";
            _html+= "<input type='hidden' name='factoryId'  value='"+factory+"'>";
            _html+= "<input type='hidden' name='fctId'  value='"+fct+"'>";
            _html+= "<input type='hidden' name='speciId'  value='"+obj+"'></div>"; 
             _html+= " <span class='btn btn-info car-modal-delete-plus glyphicon glyphicon-plus' onclick=\"addInfo1(this);\"></span>";
            _html+= " <span class='btn btn-info car-modal-delete-btn glyphicon glyphicon-trash' onclick=\"removeInfo1(this);\"></span></div></div>";
        	$("#modalinfo").append(_html);

}

		

var brandId1=document.getElementsByName("brandId");
var factoryId1=document.getElementsByName("factoryId");
var fctId1=document.getElementsByName("fctId");
var speciId1=document.getElementsByName("speciId");
var len=fctId1.length-1;

brandId1[len].value=brand;
factoryId1[len].value=factory;
fctId1[len].value=fct;
speciId1[len].value=obj;

if(varValue==0){
	var url11="<%=basePath%>member/CarModelList?fiveModel="+thirdKind11;
 	ajaxGetModelAnd1('#CarModelList',url11,brand,factory,fct,speci);
}

}



function selectAll(thisElem){
varValue=2;
$(thisElem).addClass("thisClass");
	
var brandId1=document.getElementsByName("brandId1");
var factoryId1=document.getElementsByName("factoryId1");
var fctId1=document.getElementsByName("fctId1");
var speciId1=document.getElementsByName("speciId1");

brandId1[0].value="0";
factoryId1[0].value="0";
fctId1[0].value="0";
speciId1[0].value="0";

$('.glyphicon-plus').css("display","none");

thisElem11.text("全部车型");
 $('.close').click();

}

function showInfo(){
	$("#portlet-config5").modal("show");
}

function selectAll1(thisElem){
	var text=$(thisElem).text();
	if(text=="全选"){
		varValue=1;
		$(thisElem).text("取消");
	}
	if(text=="取消"){
		$(thisElem).text("全选");
	}
	var len=$("#brandul").children("li").length;
	for(var i=0;i<len;i++){
		$("#brandul").children("li").get(i).onclick();
	}
}

function saveClose(){
var len=$(thisElem11).parent().parent().find("a").length-1;

var brandId1=document.getElementsByName("brandId1");
var factoryId1=document.getElementsByName("factoryId1");
var fctId1=document.getElementsByName("fctId1");
var speciId1=document.getElementsByName("speciId1");
/* var len=fctId1.length-1; */

brandId1[len].value=brand;
factoryId1[len].value=factory;
fctId1[len].value=fct;
var s=speci.substring(1);
speciId1[len].value=s;

$('.close').click();
hot.onclick();
}

function removeInfo1(thisElem){
	var ss=$(thisElem).parent().parent().attr('class');
	$(thisElem).parent().parent().remove();
	var tt="."+ss;
	var len=$("#modalinfo").find(tt).length;
	var k=parseInt(ss);
	var len2=0;
		
	if(len>0){
	
	/* 	len2=$(thisElem11).parent().parent().children("div").length; */
		len2=$("#suitId").next().children().length;
	/* 	$(thisElem11).parent().parent().children("div").get(k).remove(); */
		
		var len3=$("#modalinfo").children("div").length;
		for(var j=0;j<len3;j++){
			var knode=$("#modalinfo").children("div").get(j);
			
			var kclass=$(knode).attr('class');
			if(kclass>k){
			var kclass1=parseInt(kclass)-1;
			$(knode).removeClass(kclass);
			$(knode).attr("class",kclass1);
			}
			
		}
	} else{
	
		$("#suitId").next().children().get(k).remove();
	} 
	
	if(k==0 && len==0){
		len2=$("#suitId").next().children().length;
		
		if(len2>1){
		
			var t1=$(thisElem11).parent().parent().children().find("span").get(0);
		
			$(t1).removeClass("glyphicon-trash");
			$(t1).addClass("glyphicon-plus");
		}else{
			var _html = '<div class="clearfix">';
            _html+= '<a class="btn btn-info car-modal-btn1">选择车型</a>';
             _html+= '<div class="hidden">';
            _html+= '<input type="hidden" name="brandId1"  value="">';
            _html+= '<input type="hidden" name="factoryId1"  value="">';
            _html+= '<input type="hidden" name="fctId1"  value="">';
            /*  _html+= '<input type="hidden" name="biaoji1"  value="">'; */
            _html+= '<input type="hidden" name="speciId1"  value=""></div>'; 
            _html+= ' <span class="btn btn-info car-modal-plus-btn glyphicon glyphicon-plus"></span></div>';
       		$('.car-model-list').append(_html);
	
		}
		
	}
}


function addInfo1(thisElem){

	var tindex=$(thisElem).parent().parent().attr('class');
	thisElem11=$(".car-model-list").children().find("a").get(tindex);
	
	var brand2=$(thisElem).prev().children().get(0).value;
	var factory2=$(thisElem).prev().children().get(1).value;
	var fct2=$(thisElem).prev().children().get(2).value;
	var speci2=$(thisElem).prev().children().get(3).value;
	
	
	 $("#cpinpai").html(str22);
	var klen= $("#cpinpai").children().children("span").length;
	
	$('#car-model').modal('show');
	$("#urlNode").children("li").attr("class","li2");
	
	$("#portlet-config5").modal("hide");
	kvalue1=tindex;
	$.ajax({
		type:"post",
		dataType:"json",
		async: false,
		url:"<%=basePath%>member/getAllNames",
		data:{brand:brand2,
		factory:factory2,
		fct:fct2,
		speci:speci2},
		success:function(data){
				
			 	showBrands(data[0].letter); 
				showFactory(brand2,data[0].brandName);
				showFct(factory2,data[0].factoryName);
				showSpeci(fct2,data[0].fctName);
				
			},
		error:function(){
		}
	});
}

function resultFun(tindex){
var tt="."+tindex;

var len1=$("#brandul").children("li").length;
var len2=$("#modalinfo").find(tt).length;
var mm=tt+" a";

for(var i=0;i<len2;i++){
	
		var svalue=$(mm).get(i).innerHTML;
		
		var svalue1=svalue.split("/")[3];
		
		for(var j=0;j<len1;j++){
		var dd=$("#brandul").children("li").find("span").get(j).innerHTML;
	
		if(svalue1==dd){
			var kl=$("#brandul").children("li").get(j);
			$(kl).css("border","1px solid #00a9ff");
		}
	
	}
	
}
}


	function modalShow(){
    	 var tag=$("#thirdKindId").val();
    	 $("#cpinpai").html(str22);
    	 hot.onclick();
    	 if(tag!="")
    	 {
    	 $('#car-model').modal('show');
    	 }
        
       
    };
    
</script>