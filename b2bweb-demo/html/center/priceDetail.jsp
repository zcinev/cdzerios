<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/mchead.jsp" %>
 <script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
.pdet > tbody > tr > td{
	vertical-align:middle;
}
</style>
        <div class="container-fluid">
            <div class="row">
                <%@ include file="../public/centerSidebar.jsp" %>
                    <div class="col-xs-10 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                            <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">询价详情</li>
                        
                    </ol>
                           
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered pdet" style="width:100%;margin:20px auto;border:1px solid #ccc;">
                                    <%--<caption class="text-left">
                                        <h2>询价详情</h2>
                                    </caption>
                                    --%><tr class="active">
                                        <th class="td-black text-center">商品图片</th>
                                        <th class="td-black text-center">商品名称</th>
                                        <th class="td-black text-center">商品所属车型</th>
                                        <th class="td-black text-center">商品编号</th>
                                        <th class="td-black text-center">询价人</th>
                                        <th class="td-black text-center">联系电话</th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dl class="dl-horizontal td-dl">
                                                <dt><a href="<%=basePath%>purchase/askPrice"><img src="${key.imgurl}" alt="图片" width="80px" height="80px"></a></dt>
                                            </dl>
                                        </td>
                                      
                                        <td class="text-center">
                                        <a href="<%=basePath%>purchase/askPrice">${key.productName}</a>

                                        </td>
                                         <td class="text-center">
                                           ${key.brandName}/${key.factoryName}/${key.fctName}/${key.specName}
                                        </td>
                                        <td class="text-center">
                                           ${key.productId}
                                        </td>
                                        <td class="text-center">
                                           ${key.inquirer}
                                        </td>
                                        <td class="text-center">
                                           ${key.tel}
                                        </td>
                                        
                                    </tr>
                                </table>
                                
                                <form class="form-horizontal" role="form"  action="" method="post" name="form1">
                                <input type="hidden" name="id" value="${key.id}">
                                 <input type="hidden"  name="tel"  value="${key.tel}">
                                 
                                 
                                 	
                                 	 <div class="form-group">
			                            <label class="col-sm-2 control-label">有无库存</label>
			                            <div class="col-sm-10 form-inline">
			                                <input type="radio" value="1"	 name="isExist" checked onclick="changeContent1(this)">有
			                                 <input type="radio"  value="0"	 name="isExist" onclick="changeContent2(this)">无
			                            </div>
			                        </div>
			                        
			           <div id="tcontent">             	
  					<div class="form-group">
						<label for="" class="col-sm-2 control-label">配件分类</label>
						
						<div class="col-sm-10 form-group form-inline"
							style="padding-left:30px;">
							<select name="firstKind" id="firstKindId-box"
								class="form-control">
								<option value="0">--请选择--</option>
							</select> <select name="secondKind" id="secondKind-box"
								class="form-control">
								<option value="0">--请选择--</option>
							</select>
							 <select name="thirdKind" id="thirdKind-box" class="form-control" onblur="validatelegalAndZero('thirdKind-box');">
							 <option value="0">--请选择--</option>
							</select>
								<span class="message">配件分类不能为空[]</span>
							<span class="messageShow"> </span>
						</div>
					</div>
					 
					 <div class="form-group">
						<label for="" class="col-sm-2 control-label">出产编号</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="leaveFactoryNumber" id="leaveFactoryNumber" class="form-control"
								placeholder="请输入出产编号" onblur="validatelegalName('leaveFactoryNumber');"
								maxlength="100"> <span class="message">出产编号不能为空[]</span>
							<span class="messageShow"></span>
						</div>
					</div>
			                        
			        
					 <div class="form-group">
						<label for="" class="col-sm-2 control-label">生产厂商</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="text" name="factoryName1" id="factoryName1" class="form-control"
								placeholder="请输入生产厂商" onblur="validatelegalName('factoryName1');"
								maxlength="100"> <span class="message">生产厂商不能为空[]</span>
							<span class="messageShow"></span>
						</div>
					</div>

					<div class="form-group">
						<label for="" class="col-sm-2 control-label">市&nbsp;场&nbsp;价</label>
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
						<label for="" class="col-sm-2 control-label">会&nbsp;员&nbsp;价</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;">
							<input type="" name="memberprice" id="memberprice" value=""
								class="form-control" placeholder="会员价" readonly="readonly">
							<span class="help-block">单位为人民币（元），输入整数。如输入为空或者0，则显示为面议。</span>
						</div>
					</div>
					
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">添加数量</label>
						<div class="col-sm-8 form-inline" style="padding-left:15px;"
							id="addNumberId">
							<input type="text" name="stocknum" id="stocknum"
								class="form-control" placeholder="添加数量"
								onblur="validateMileage('stocknum');" maxlength="20">&nbsp;&nbsp;
							<span class="message">添加数量S不能为空[]</span> <span
								class="messageShow"></span>
						</div>
					</div>
					
			            </div>            
			                        <div class="form-group">
			                            <label class="col-sm-2 control-label">回复</label>
			                            <div class="col-sm-10 form-inline">
			                                <textarea id="content" name="content" class="form-control" style="width:100%;" rows="10" placeholder="暂时还没有对该商品的询价进行回复"onblur="validatelegalName('content');" maxlength="200"></textarea>
			                                <span class="message" >回复内容不能为空[]</span>
                                                 <span class="messageShow" ></span>
			                            </div>
			                        </div>
			                        <div class="form-group">
			                            <div class="col-sm-offset-2 col-sm-10">
			                                <button type="button" class="btn btn-primary" onclick="basicTest();">回复</button>
			                                <a onclick="javascript:history.go(-1);" class="btn btn-primary" role="button">返回</a>
			                            </div>
			                        </div>
			                    </form>
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <%@ include file="../public/foot.jsp" %>
        <script>
        
        $('input').iCheck('destroy');
   
   var keyValue=1;
       
  function basicTest(){  
   var check = true;
   	if (!validatelegalName('content')) {
 		check = false;
	}   
	
	if(keyValue==1){
	
	if (!validatelegalName('leaveFactoryNumber')) {
 		check = false;
	}   
	if (!validatelegalName('factoryName1')) {
 		check = false;
	}   
	
	if (!validateMileage('marketprice')) {
		check = false;
	}
	
	if (!validateMileage('stocknum')) {
		check = false;
	}
	
	if (!validatelegalAndZero('thirdKind-box')) {
 		check = false;
	}
	
	}
	
	
 	if (check == false) {
    		return;
	} 
	 
	document.form1.action = "<%=basePath%>purchase/replyPrice";
	document.form1.submit();
   
  }
</script>
        <script>
        $(document).ready(function () { 
        
           PeiJianJLValue("<%=basePath%>");
           PeiJianIdValue("<%=basePath%>", firstKindId,secondKindId,thirdKindId); 
	         distSelect("<%=basePath%>");
	        detailAddress("<%=basePath%>");
	    });
    	function successback(data) {
		alert("回复成功");
    	}
    
        function errorback() {
		alert("回复失败");
    	}
    
        function ajaxRequestDogetJsonp(getUrl){
 		var obj={"replyContent":"${'#content'}.val()","id":"${key.id}","tel":"${key.tel}"}; 
 		alert(getUrl); 
 		alert(replyContent);
        $.ajax({
             type: "post",
             url: getUrl,  
             async:false,           
             dataType: "html",
             data:obj,
             success: successback,
             error: errorback
         });         
         }
   
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
 
 
   var content = document.getElementById("content");   
   function checkInput() {
	  
		  if(content.value==""){
				alert("请填写回复信息");
			    return false; 
		  }
          //ajaxRequestDogetJsonp("<%=basePath%>purchase/replyPrice");
          //return true;  //表单提交   
    }
   //点击返回，则返回询价列表
   function changeHref(){
	   window.localtion.href ="./purchase/askPrice";
   }
 
 
 function changeContent1(){
 	keyValue=1;
 	var tcontent=document.getElementById("tcontent");
 	tcontent.style.display="";
 }
 
 function changeContent2(){
 	keyValue=0;
 	var tcontent=document.getElementById("tcontent");
 	tcontent.style.display="none";
 }
 
 function validatelegalName3(thisEle) {
   	var obj=document.getElementById(thisEle);
 	var message = $(obj).next().next().text();
 	alert(obj);
 	alert(message);
	if($(obj).val()==null||$(obj).val().length==0){
 		$(obj).next().next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().next().text("");
  			return true;
  	}
}
</script>
        
