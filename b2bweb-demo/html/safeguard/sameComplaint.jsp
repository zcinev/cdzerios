<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
<%@ include file="../public/shead.jsp"%>
<script type="text/javascript">
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#myform").submit();
		return false;
	}
	function jump(s) {
	    var index=document.all('index').value; 
		$("#pageNo").val(index);
		$("#pageSize").val(s);
		$("#myform").submit();
		return false;
	}
</script>
 
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 paddingRight0 paddingLeft0 pull-left">
			 	<div><span  style="color: #464646"><a href="<%=basePath%>carsaf/carSafeIndex">首页</a>&nbsp;>&nbsp;<a href="#">维权</a>&nbsp;>&nbsp;<a href="#">发动机漏油</a>&nbsp;>&nbsp;</span><span style="color: #9C9C9C">发表新的投诉</span></div>
			</div>
			<div class="col-md-12">
				<div class="tslist pull-left">
					<div class="tnote">
						<div class="listtitle">
							<strong>| 投诉报告</strong>
						</div>
						<div class="bd">
							<div class="header clearfix">
	                        	<h4>此款车型相关投诉<strong>${row_count}</strong>条</h4>
	                            <div style="display:none">
	                            	<p>投诉排序：<a href="#111"><em>时间新→旧</em></a>
	                            	</p>
                            	</div>
	                        </div>
							<div class="panels">
								<div class="panel current">
					<form action="<%=basePath%>carsaf/sameComplaintList" method="post" name="myform" id="myform">
								
									<table cellpadding="0" cellspacing="0">
										<colgroup>
											<col class="col0">
											<col class="col1">
											<col class="col2">
											<col class="col3">
											<col class="col4">
										</colgroup>
										<tbody>
											<tr>
										<th>厂商</th> 
											<th>投诉分类</th> 
											<th>时间</th> 
										 <th>标题</th> 
											
											<th>投诉单号</th>
											</tr> 
 											<c:forEach var="mkey" items="${key}">
											<tr>
												<td>${mkey['factory_name']}</td>
											<td>${mkey['complaint_type_name']}</td> 
											<td>${mkey['complaint_time']}</td>
 											<td><a href="#">${mkey['title']}</a></td> 
											<td>${mkey['complaint_number']}</td>
											
											</tr>
											 </c:forEach>
 										</tbody>
 										<input id="id" name="id" type="hidden" value="${id}" />
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
									</table></form>
								</div>
							</div>
							<div   style="padding-right: 140px;"><ul ><li>${page}</li></ul></div>
							
						</div>  
						 
					 </div>
					 <br>
					<div class="tdisplay">
						<div class="listtitle">
							<strong>| 发表投诉</strong>
							<span style="width:300px;display:inline-block;margin-top:-40px;">(投诉加<font color="red">" * "</font>号的为必填项)</span>
						</div>
						<div class="bd">
							<div class="login" style="height:30px;">
	                            <div id="t1">
	                                <form method="post" target="hidden_iframe" action="<%=basePath%>html/login.jsp">
	                                    <input name="url" value="http://product.auto.163.com/series/complain/16991.html" type="hidden">
	                               <div style="padding-right: 40%;" id="login_confirm_no">  <span><a href="/b2bweb-demo/html/login.jsp"  style="font-size: 14px;color:red;text-decoration: underline;">登录&nbsp;</a> <a href="/b2bweb-demo/html/register.jsp" style="font-size: 14px;color:blue;text-decoration: underline;">&nbsp;注册</a></span><span style="font-size: 14px;color: #666666">(登录可以帮您获取更多精准的服务)</span></div>

	                                </form>
	                            </div>   
	                            <div id="t2" style="display:none;"> </div>	
	                        </div>
	                        <div class="panel current" style="box-shadow: 0px rgba(0, 0, 0, 0.05);">                                                   
                                  <form class="form3" target="_self" method="post" action="<%=basePath%>carsaf/complaintApplySame" onsubmit="javascript:return onsubmitlist03();">                            	<div class="group group0">
                            		<br>
                                    <h3>您要投诉的车型相关信息：</h3>
                                   
                                    <!-- <span style="color: red;">温馨提示：你所投诉的问题必须累计超过三十个用户，我们才会帮您申请投诉！</span><br> -->
                                    <br>
                                     <p><em>*</em>车主姓名：<input name="car_name" id="car_name_03" maxlength="5" class="textbox" style="width:115px;" type="text" onblur="validatelegalName('car_name_03')">
                                     <span class="message" >车主姓名不能为空[]</span>
                   				<span class="messageShow" ></span>   
                                     　					<em>*</em>联系电话：<input name="telephone" id="telephone_03" class="textbox" maxlength="20" style="width:115px;" type="text"  onblur="validatelegalTel('telephone_03');">
                                      <span class="message" >联系电话格式不正确[]</span>
                   				<span class="messageShow" ></span>    
                                     <br><br><em>*</em>具体车型：<select name="brand"  id="car-brand-data_03">
                                    <option value="0">-请选择品牌-</option>
                                </select>
                                <select name="factory"  id="car-factory-data_03">
                                    <option value="0">-请选择厂商-</option>
                                </select>
                                <select name="fct"  id="car-series-data_03">
                                    <option value="0">-请选择车系-</option>
                                </select>
                                 <select name="speci"  id="car-modal-data_03" onblur="validatelegalModle_03('car-modal-data_03');">
                                    <option value="0">-请选择车型-</option>
                                </select>
                                <span class="message" >请选择车型[]</span>
                   				<span class="messageShow" ></span>
									</p><br>
									<p><em>*</em>行驶里程：<input name="mileage" id="mileage_03" maxlength="5" class="textbox" style="width:115px;" type="text" onblur="validatelegalName('mileage_03')">
									<span class="message" >行驶里程不能为空[]</span>
                   				<span class="messageShow" ></span> 
									      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购车日期：<input name="buy_car_time" id="buy_car_time_03" class="textbox" maxlength="20" style="width:115px;" type="text" onclick="new Calendar().show(this);" onblur="validatelegalName('buy_car_time_03')" onmousemove="validatelegalName('buy_car_time_03')">
									      <span class="message" >购车日期不能为空[]</span>
                   				<span class="messageShow" ></span> 
									      
									      </p><br>
									<p><em>*</em>购车城市：<select name="car_province_03"  id="car-province-data_03">
                                    <option value="0">-请选择省-</option>
                                </select>
                                <select name="car_city_03"  id="car-city-data_03" onblur="validatelegalName('buy_car_city_03')">
                                    <option value="0">-请选择市-</option>
                                </select>
                                <input name="buy_car_city_03" id="buy_car_city_03" maxlength="5" class="textbox" style="width:115px;" type="text" hidden>
									<span class="message" >购车城市不能为空[]</span>
                   				<span class="messageShow" ></span> 
									
									    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购车店面：<input name="buy_car_store" id="buy_car_store_03" class="textbox" maxlength="20" style="width:115px;" type="text" onblur="validatelegalName('buy_car_store_03')">
									    <span class="message" >购车店面不能为空[]</span>
                   				<span class="messageShow" ></span> 
									    </p><br>
								标题：<input name="title_id" id="title_id" value="${title}" class="textbox" maxlength="10" type="text" disabled="disabled"><br>    
                                    <br> <p><em>*</em>投诉对象：<select id="complaint_object_03" name="complaint_object" class="s3" style="width:207px;" onblur="validatelegalModle_03('complaint_object_03');" onchange="complaintObjectList();">
										  <option value="0">-请选择-</option>
											<option value="1">整车维权</option>
											<option value="2">4S店维权</option>
											<option value="3">保险维权</option>
											<option value="4">其他维权</option>
										</select>
										<span class="message" >投诉对象不能为空[]</span>
                   				<span class="messageShow" ></span>
									</p><br>
									<p><em>*</em>车牌号码：<select name="recruitment"  id="recruitment"    onchange="carNumberAllShow();"><option value="0">-请选择-</option>
									<c:forEach var="mkeycar" items="${keycar}">
									<option value="${mkeycar['id']}">${mkeycar['name']}</option>
									</c:forEach></select><select name="letter"  id="letter"  onchange="carNumberLatter();"><option>-请选择-</option></select><input name="car_number" id="car_number" maxlength="32" class="textbox" style="width:112px;height: 30px;" type="text" onblur="validatelegalcarNumber('car_number')"> <span class="message" >车牌号码格式不正确[]</span>
                   				<span class="messageShow" ></span>  
									<input type="hidden" value="${id}" name="same-xample" id="same-xample">
									<div style="display:none;" id="inline-block-id"><span id="block_id">店铺名称：</span><input type="text" value="" name="store_complanint" id="store_complanint"></div>
									<br><span id="complaint_id_all"></span><br>
									<p>请填写详细内容/您希望如何解决<font color="red">（在线维权添加提示：为确保您的信息能正确发布，请确保维权信息完整，信息内容真实!）</font></p>
                                	<p><textarea name="detail_content" id="detail_content_03" cols="123" rows="10" onblur="validatelegalName('detail_content_03')"></textarea>
                                	<span class="message" >详细内容不能为空[]</span>
                   				<span class="messageShow" ></span>
                                	</p>
                                	<p style="float:right;"><button class="btn sbt"   type="submit">提交投诉信息</button></p>
                                </div>
                            </form>
                        </div>
						</div>
					</div>
				</div>
				<div class="col-r">
					<!-- Begin: 投诉案例检索 -->
			 	<%@ include file="../public/right_select.jsp"%>  
               		
                <!-- End: 投诉案例检索 -->	
				<!-- Begin: 投诉平台使用说明 -->
                <div id="rm2" class="mod mod23">
                    <div class="hd"><h5>投诉平台使用说明</h5></div>
                    <div class="bd">                        
                        <ul>
                            <li>1、注册会员<p>如您已经是网易汽车会员，请直接<a style="color:#BA2636;" href="<%=basePath%>html/login.jsp">登录</a>，不是请您<a style="color:#BA2636;" href="<%=basePath%>html/register.jsp">注册</a></p></li>
                            <li>2、发表投诉<p>请将您遇到的问题在网易汽车投诉平台进行如实填写，并提交。</p></li>
                        	<li>3、专业审核<p>相关负责人会在后台进行审核，并将投诉转发给相关企业。</p></li>
                            <li>4、企业处理<p>我们会敦促企业在2周内对投诉作出反应，并解决车主的合理要求。</p></li>
                            <li>5、结果审核<p>针对企业的处理结果，我们会选择性的进行审核监督。</p></li>
                            <li>6、完毕</li>
                        </ul>
                    </div>
                </div>				
                <!-- End: 投诉平台使用说明 -->
                <!-- Begin: 投诉平台运行原则 -->
                <div id="rm3" class="mod mod23">
                    <div class="hd"><h5>投诉平台运行措施及原则</h5></div>
                    <div class="bd">                        
                        <ul>
                        	<li>1、运营原则<p>以解决问题为第一原则,突出沟通的桥梁作用，力争最大限度解决车主投诉的合理问题。</p></li>
                            <li>2、投诉平台运营措施<p>网友投诉平台化</p><p>信息传递准确化</p><p>解决问题快速化</p><p>力争网友满意化</p></li>
                        </ul>
                    </div>
                </div>				
                <!-- End: 投诉平台运行原则 -->	                 
			</div>
			</div>
        </div>
    </div>

    <%@ include file="../public/foot.jsp"%>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
KindEditor.ready(function (K) {
    var editor;
    editor = K.create('#same_ceditor', {
    	uploadJson : '<%=uploadUrl%>?root=demo-comment-icon',
        resizeType: 1,
        allowPreviewEmoticons: true,
        allowImageUpload: true,
        items: [
            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
            'insertunorderedlist', '|', 'emoticons', 'image', 'link']
    });
});
</script>
<script>
 var user_name_2="<%=session.getAttribute("userName")%>";
 if(user_name_2 !=null && user_name_2 != "null" && user_name_2 != ""){
 //$("#login_confirm_no").css("display","none");
     $("#login_confirm_no").html("温馨提示：你所投诉的问题必须累计超过三十个用户，我们才会帮您申请投诉！");
     $("#login_confirm_no").css("color","red");
 
  }else{
  }
  
</script>
<script>
     $(document).ready(function(){
    $(".label-primary").css("background-color","#1973d4");
     $(".active a").css("background-color","#1973d4");
   
    });
    function complaintObjectList(){
  var comp= $('#complaint_object_03').val();
   if(comp=="1"){
      var factory=$("#car-factory-data_03").find("option:selected").text();
      var factory_id=$("#car-factory-data_03").val();
       if(factory_id!="0"){
        $('#inline-block-id').css("display","none");
      $('#complaint_id_all').text("商家："+factory);
      } else{
     /*   $('#inline-block-id').css("display","none");
      $('#complaint_id_all').text("请选择具体车型");
      $('#complaint_id_all').css("color","red"); */
      }
   
   }
   if(comp=="2"){
    $('#block_id').text("店铺名称：");
    $('#inline-block-id').css("display","inline-block");
    $('#complaint_id_all').text("");
   }
   if(comp=="3"){
   $('#block_id').text("保险公司：");
   $('#inline-block-id').css("display","inline-block");
   $('#complaint_id_all').text("");
   }
   if(comp=="4"){
   $('#block_id').text("其他详情：");
   $('#inline-block-id').css("display","inline-block");
   $('#complaint_id_all').text("");
   }

}
</script>
<script>
  function carModalSelect_all_list_03(basePath) {//2015-06-05 杨才文
 	    var __this = '';
 	        __this = $(this);
	        var _text='';
	        var _test='';
	    	ajaxGetData('#car-brand-data_03',basePath+"member/brandList");
	    	ajaxGetData('#car-factory-data_03',basePath+"member/factoryList");
	    	ajaxGetData('#car-series-data_03',basePath+"member/fctList");
	    	ajaxGetData('#car-modal-data_03',basePath+"member/specList");
	                       
	    	$('#car-brand-data_03').change(function() {
	    	    ajaxGetData('#car-factory-data_03',basePath+"member/factoryList?id="+$(this).children(':selected').val());
	    	    _text = $(this).children(':selected').text();
	    	    _test=$(this).children(':selected').val();
	    	});

	        $('#car-factory-data_03').change(function() {
	            ajaxGetData('#car-series-data_03',basePath+"member/fctList?id="+$(this).children(':selected').val());
	            _text += '/'+$(this).children(':selected').text();
	            _test+='/'+$(this).children(':selected').val();
	        });

	    	$('#car-series-data_03').change(function() {
	    	    ajaxGetData('#car-modal-data_03',basePath+"member/specList?id="+$(this).children(':selected').val());
	    	    _text += '/'+$(this).children(':selected').text();
	    	    _test+='/'+$(this).children(':selected').val();
	    	});

	    	$('#car-modal-data_03').change(function() {
	    	    _text += '/'+$(this).children(':selected').text();
	    	    _test+='/'+$(this).children(':selected').val();
	    	});

	    	$("#save-car-modal_03").click(function() {
	    	    if(_text) {
	    	    	$('.car-modal-btn').text(_text);
	    	    	$('.selectCar').text(_text);
	            }
	    	    saveCarModel(_text,_test);
	    	    saveCarModel2(basePath,_text,_test);
	    	    $(this).closest('.modal').modal('hide');
	    	});
  	  
	}
	carModalSelect_all_list_03("<%=basePath%>");
</script>
<script type="text/javascript" src="<%=basePath%>html/js/right_select.js">
 </script>
 <script>
	distSelect("<%=basePath%>");
	carModalSelect_all_list_04("<%=basePath%>");
</script>
<script>
 function validatelegalModle_03(thisEle) {
 	var _this=document.getElementById(thisEle);
  	if(!validateNullModel_03(_this)){
 		return false;
	} else{
  	return 	true;
 
	}
 
}

function validateNullModel_03(obj){
    	var message = $(obj).next().text();
	if($(obj).val()==null||$(obj).val().length==0 || $(obj).val()=="0" || $(obj).val()==0){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}

</script>
<script>
 function onsubmitlist03(){
      var type=true;
    
	if (!validatelegalTel('telephone_03')) {
 		type = false;
	} 
	if (!validatelegalName('car_name_03')) {
 		type = false;
	} 
	if (!validatelegalName('mileage_03')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_time_03')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_city_03')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_store_03')) {
 		type = false;
	} 
	 
	if (!validatelegalModle_03('complaint_object_03')) {
 		type = false;
	} 
	if (!validatelegalModle_03('car-modal-data_03')) {
 		type = false;
	} 
	if (!validatelegalName('detail_content_03')) {
 		type = false;
	} 
	if (!validatelegalcarNumber('car_number')) {
 		type = false;
	} 
    return type;
 
}   
</script>
<script>
var car_url="<%=basePathRe%>";
var recruitmentText="";
	 var letter="";
	function carNumberAllShow(){
 	var recruitment=$('#recruitment').val();
   recruitmentText=$("#recruitment").find("option:selected").text();     
 	 $.ajax({
		    type:"POST",
		    data:{id:recruitment},
		    url:car_url+"member/addCarNumberTwo",
		    async:false,
		    dataType:"html",
		    success:function(str){
		      $('#letter').html(str);
		      $('#car_number').val(recruitmentText);
		    },
		    error:function(){
		      alert("请求失败!");
		    }
		   }); 
  
};
function carNumberLatter(){
      letter=$("#letter").find("option:selected").text(); 
         $('#car_number').val(recruitmentText+letter);
}
//start
function validatelegalcarNumber(thisEle) {
   	var _this=document.getElementById(thisEle);
  	if(!validatecarNumber(_this)){
  		return false;
  		
	} else{
		
  	return 	true;
 
	}
 
}
function validatecarNumber(obj){
   	var message = $(obj).next().text();
   	var rules=/^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/;
  	if(!(rules.test($(obj).val()))){
 		$(obj).next().next().text(message.split('[]')[0]);
 		return false;
	}else{
  		$(obj).next().next().text("");
  	}
	return true;
}
</script>
<script>
			distSelect3("<%=basePath%>");
			var _select3 = $(this);
	        var dat3="";
	        $.ajax({
	            type: "POST",
	            url: "/b2bweb-demo/pei/getUrl",
	            async:false,
	            dataType: "html",
	            success: function(data) {
	            dat3=data;
	            },
	            error: function() {
	            	_select3.text('请求失败');
	            }
	        });
	        function distSelect3(basePath) {
	        	ajaxGetData('#car-province-data_03',basePath+"member/getSelectValue?id=1");

	            $('#car-province-data_03').change(function() {
	                ajaxGetData('#car-city-data_03',basePath+"member/getSelectValue?id="+$(this).children(':selected').val());
	                $('#buy_car_city_03').val($(this).children(':selected').text());
	            });

	            $('#car-city-data_03').change(function() {
	                $('#buy_car_city_03').val($(this).children(':selected').text());
	            });
	        }
</script>