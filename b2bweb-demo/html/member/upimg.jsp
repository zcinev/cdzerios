<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/head3.jsp" %>

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
<style>
.btn-primary{
background-color: #3071A9;
border-color: #285E8E;
width: 60px;
}
.btn-primary:hover{
color: white;
background-color: #00A9FF;
border-color: #029ae8;
height: 34px;
}
.form-group label{
font-weight: normal;
}
#upload-full-img{
width: 160px;
border-radius:3px;

background-color: #ededed;
    background-image: linear-gradient(#fff, #e4e3e3);
    border: 1px solid #b1b1b1;
    color:#746D6D;
    font-family: "宋体";
    height:27px;
   
    font-size:12px;
    line-height: 15px;
    text-align: center;
}
#upload-file-honour{
width: 160px;
border-radius:3px;

background-color: #ededed;
    background-image: linear-gradient(#fff, #e4e3e3);
    border: 1px solid #b1b1b1;
    color:#746D6D;
    font-family: "宋体";
    height:27px;
   
    font-size:12px;
    line-height: 15px;
    text-align: center;
}
#upload-full-img-logo{
width: 160px;
border-radius:3px;

background-color: #ededed;
    background-image: linear-gradient(#fff, #e4e3e3);
    border: 1px solid #b1b1b1;
    color:#746D6D;
    font-family: "宋体";
    height:27px;
   
    font-size:12px;
    line-height: 15px;
    text-align: center;
}
</style>
<div class="container-fluid">
    <div class="row">
        <%--<%@ include file="../public/memberSidebar.jsp" %>
        --%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li><a href="#">店铺管理</a>
                        </li>
                        <li class="active">图片上传</li>
                    </ol>
                </div>

                <div class="container-fluid" style="width:80%;margin-top:20px;">
                   
                    <link rel="stylesheet" href="<%=basePath%>html/plugin/kindeditor/themes/default/default.css" />
                    <form class="form-horizontal" role="form" enctype="multipart/form-data" name="form1" >
                        <div class="form-group">
                            <label for="" class="col-sm-2 control-label">店铺全景图</label>
                            <div class="col-sm-10">
                                <a href="javascript:;" id="upload-full-img" class="btn btn-primary"><img alt="默认上传" src="<%=basePath %>html/img/moren-upload.png">&nbsp;请选择要上传的图片</a>
                            </div>
                        </div>
                        <div style="padding-left:110px;margin-top: -12px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>
                        <div class="form-group" style="margin-top: 8px;">
                            <label class="col-sm-2 control-label"></label>
                            <div class="col-sm-10" id="showImg">
                             <c:if test="${key2!= null}">
                            	 <c:forEach var="mkey" items="${key2}" >
							<div style="width: 160px;float: left;">
							<div>
							    <img id="carImg" src="${mkey['banner']}" width="150" height="150" alt="">
							</div>
							<div><input type="button"  value="删除" onclick="delStoreImg(this,'${mkey['banner']}')"></div>
							</div>
							</c:forEach>
                            	 </c:if>
                            	 <c:if test="${key2== null}">
                            
              				 <img id="faceImgId1" src="/b2bweb-demo/html/img/upimg2.png"  alt="请上传图片!">
              
                            	 </c:if>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-2 control-label">荣誉证书</label>
                            <div class="col-sm-10">
                                <a href="javascript:;" id="upload-file-honour" class="btn btn-primary"><img alt="默认上传" src="<%=basePath %>html/img/moren-upload.png">&nbsp;请选择要上传的图片</a>
                            </div>
                        </div>
                         <div style="padding-left:110px;margin-top: -12px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>
                        <div class="form-group" style="margin-top: 8px;">
                            <label class="col-sm-2 control-label"></label>
                            <div class="col-sm-10" id="certificate" >
                                <c:if test="${key4!= null}">
                                
                                 <c:forEach var="mkey" items="${key4}" >
							<div style="width: 160px;float: left;">
							<div>
							    <img id="carImg" src="${mkey['certificateOfHonor']}" width="150" height="150" alt="">
							</div>
							<div><input type="button"  value="删除" onclick="delStoreHonor(this,'${mkey['certificateOfHonor']}')"></div>
							</div>
							</c:forEach>
							
                                </c:if>
                               
                                  <c:if test="${key4== null}">
                      <img id="faceImgId1" src="/b2bweb-demo/html/img/upimg1.png"  alt="请上传图片!">
                                </c:if>
                            </div>
                        </div>
                          <div class="form-group">
                            <label for="" class="col-sm-2 control-label">店铺logo</label>
                            <div class="col-sm-10">
                                <a href="javascript:;" id="upload-full-img-logo" class="btn btn-primary"><img alt="默认上传" src="<%=basePath %>html/img/moren-upload.png">&nbsp;请选择要上传的图片</a>
                            </div>
                        </div>
                         <div style="padding-left:110px;margin-top: -12px;">仅支持JPG、GIF、PNG、JPEG、BMP格式，文件小于4M</div>
                        <div class="form-group" style="margin-top: 8px;">
                            <label class="col-sm-2 control-label"></label>
                            <div class="col-sm-10" id="logoImg" >
                                 <c:if test="${key3!= null}">
                            <c:forEach var="mkey" items="${key3}">
                     <img id="faceImgId3" src="${mkey['logo']}" width="150" height="150" alt="请上传图片!">
                                </c:forEach>
                                </c:if>
                                  <c:if test="${key3==null}">
                            
                      <img id="faceImgId3" src="/b2bweb-demo/html/img/upimg3.png"  alt="请上传图片!">
                             
                                </c:if>
                            </div>
                        </div>
                        <!--   
                         <label for="" class="col-sm-2 control-label">QQ号码 </label>
                         <div class="form-group">
                        <input type="text" name="qq" id="qq" placeholder="请输入您的QQ号码" class="form-control" style="width: 200px;">
                         </div>
                         -->
                        <div id="getUrl"></div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="button" class="btn btn-primary" id="updateTest" onclick="return updateImgTest();" >更新</button>
                            </div>
                        </div>
                        
                       <div id="card1"><input type="hidden" name="image1" id="image1" value=""></div>
                       <div id="card2"><input type="hidden" name="image2" id="image2" value=""></div>
                       <div id="card3"><input type="hidden" name="image3" id="image3" value=""></div> 
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../public/foot3.jsp"%>

<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
var bufferdata = "";
var buffer = "";
var bufferImg = "";
KindEditor.ready(function(K) {
    var editor1 = K.editor({
    	  uploadJson : '<%=uploadUrl%>?root=demo-common-panorama',
    	//店铺全景图路径
        allowFileManager : true
    });
    K('#upload-full-img').click(function() {
        editor1.loadPlugin('multiimage', function() {
            editor1.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    var objRow = document.getElementById("showImg"); 
                           var  img="";
                             objRow.innerHTML=img;
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferdata=bufferdata+data.url+",";
                       $('#showImg').append("<div style='width: 160px;float: left;'><div><img id='litpic2' style='width:150px;height:150px;' src='"+data.url+"'></div><div><input type='button'  value='删除' onclick=\"delStoreImg(this,'"+data.url+"')\"></div></div>");
                  	document.getElementById("image1").value=bufferdata;
                    });
                    editor1.hideDialog();
                }
            });
        });
    });
     var editor3 = K.editor({
    	  uploadJson : '<%=uploadUrl%>?root=demo-common-logo',
    	//店铺logo
        allowFileManager : true
    });
    K('#upload-full-img-logo').click(function() {
        editor3.loadPlugin('multiimage', function() {
            editor3.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                     var objRow = document.getElementById("logoImg"); 
                           var  img="";
                             objRow.innerHTML=img;
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                        bufferImg=data.url;
                        $('#logoImg').html('<img  id="logoImgSrc" style="width:100px;height:100px;" src="' + data.url + '">');
                     document.getElementById("image2").value=bufferdata;
                    });
                    
                    editor3.hideDialog();
                }
            });
        });
    });
    var editor2 = K.editor({
    	  uploadJson : '<%=uploadUrl%>?root=demo-common-honor',
    	//荣誉证书路径
        allowFileManager : true
    });
    K('#upload-file-honour').click(function() {
        editor2.loadPlugin('multiimage', function() {
            editor2.plugin.multiImageDialog({
                clickFn : function(urlList) {
                    var div = K('#J_imageView');
                    div.html('');
                    var objRow = document.getElementById("certificate"); 
                           var  img="";
                             objRow.innerHTML=img;
                    K.each(urlList, function(i, data) {
                        div.append('<img src="' + data.url + '">');
                           buffer=buffer+data.url+",";
                        $('#certificate').append("<div style='width: 160px;float: left;'><div><img id='litpic2' style='width:150px;height:150px;' src='"+data.url+"'></div><div><input type='button'  value='删除' onclick=\"delStoreHonor(this,'"+data.url+"')\"></div></div>");
                     document.getElementById("image3").value=bufferdata;
                    });
                    
                    editor2.hideDialog();
                }
            });
        });
    });
 });
 
   $('#update').click(function() {

  
	 $.ajax({
            type: "post",
            data:	{"bufferdata":bufferdata,"buffer":buffer},
            url: "<%=basePath%>member/uploadImg",
            async:false,
            dataType: "html",
            success: function(data) {
            	bufferdata = "";
           		alert("更新成功"); 
           		         		
            },
            error: function() {
           	    alert('请求失败');
            }
        });
     });
 

</script>
<script type="text/javascript">
   function updateImgTest(){
       if(bufferdata !="" || buffer !="" || bufferImg !=""){
      $.ajax({
            type: "GET", 
            data:{bufferdataId:bufferdata,bufferId:buffer,bufferImgId:bufferImg},
            url: "<%=basePath%>member/uploadImgTest",
            async:false,
            dataType: "html",
            success: function(data) {
               alert("更新成功！");
              window.location.href="<%=basePath%>member/uploadImgLookTest";  
             },
            error: function() {
            _this.text('请求失败');
            }
        });
          }else{
          alert("请上传图片");
          return false;
          }
          
   }
   
   
   function delStoreImg(thisEle,obj){
	$.ajax({
            type: "POST",
            url: "<%=basePathpj%>person/delStoreImg",
            data:{img:obj},
            async:false,
            dataType: "html",
            success: function(data) {
           	$(thisEle).parent().parent().remove();
            },
            error: function() {
            _this.text('请求失败');
            }
        });
	}
	
	
	function delStoreHonor(thisEle,obj){
	$.ajax({
            type: "POST",
            url: "<%=basePathpj%>person/delStoreHonor",
            data:{img:obj},
            async:false,
            dataType: "html",
            success: function(data) {
           	$(thisEle).parent().parent().remove();
            },
            error: function() {
            _this.text('请求失败');
            }
        });
	}
</script>