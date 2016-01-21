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
<script>
     $(document).ready(function(){
    $(".label-primary").css("background-color","#1973d4");
     $(".active a").css("background-color","#1973d4");
   
    });
</script>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 paddingRight0 paddingLeft0 pull-left">
			 	<div><span  style="color: #464646"><a href="<%=basePath%>carsaf/carSafeIndex">首页</a>&nbsp;>&nbsp;<a href="<%=basePath%>carsaf/carSafeIndex?complaint_object=ZCwq">维权</a>&nbsp;>&nbsp;<a href="#">发动机漏油</a>&nbsp;>&nbsp;</span><span style="color: #9C9C9C">发表新的投诉</span></div>
			</div>
			<div class="col-md-12">
				<div class="tslist pull-left">
					<div class="tnote">
						<div class="listtitle">
							<strong>| 投诉报告</strong>
						</div>
						<div class="bd">
							<div class="header clearfix">
	                        	<h4>最近投诉如下</h4>
	                            <div style="display:none">
	                            	<p>投诉排序：<a href="#111"><em>时间新→旧</em></a>
	                            	</p>
                            	</div>
	                        </div>
							<div class="panels">
								<div class="panel current">
								<form action="<%=basePath%>carsaf/newComplaintList" method="post" name="myform" id="myform">
 									<table >
										<tbody>
											<tr>
											<th style="width:25%;">厂商</th> 
											<th style="width:12.5%;">投诉分类</th> 
											<th style="width:12.5%;">投诉对象</th>
											<th style="width:12.5%;">时间</th> 
											<th style="width:12.5%;">同类问题</th> 
											<th style="width:25%;">投诉单号</th>
											</tr>
											<c:forEach var="mkey" items="${key}">
											<tr>     
											<td>${mkey['factory_name']}</td> 
											<td><a href="#">${mkey['complaint_type_name']}</a></td> 
											<td>${mkey['complaint_object_name']}</td>
											<td>${mkey['complaint_time']}</td>
											<td >${mkey['count_all']}</td>
											<td>${mkey['complaint_number']}</td>
											</tr>
											 </c:forEach>
										</tbody>
									</table>
									<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
									<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
									</form>
								</div>
							</div>
							<div   style="padding-right: 140px;"><ul ><li>${page}</li></ul></div>
						</div>
					 </div><br>
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
                                  <form class="form2" target="_self" method="post" action="<%=basePath%>carsaf/newComplaintApply" onsubmit="javascript:return onsubmitlist02();">
                            	<div class="group group0">
                                    <br>
                                    <p><em>*</em>车主姓名：<input name="car_name" id="car_name_02" maxlength="5" class="textbox" style="width:115px;height: 30px;" type="text" onblur="validatelegalName('car_name_02')" >
                   <span class="message" >车主姓名不能为空[]</span>
                   				<span class="messageShow" ></span>                 
                                    　<em>*</em>联系电话：<input name="telephone" id="telephone_02" class="textbox" maxlength="20" style="width:115px;height: 30px;" type="text" onblur="validatelegalTel('telephone_02');">
                                      <span class="message" >联系电话格式不正确[]</span>
                   				<span class="messageShow" ></span>    
                                    <br><br><em>*</em>具体车型：<select name="brand"  id="car-brand-data_02">
                                    <option value="0">-请选择品牌-</option>
                                </select>
                                <select name="factory"  id="car-factory-data_02">
                                    <option value="0">-请选择厂商-</option>
                                </select>
                                <select name="fct"  id="car-series-data_02">
                                    <option value="0">-请选择车系-</option>
                                </select>
                                 <select name="speci"  id="car-modal-data_02" onblur="validatelegalModle('car-modal-data_02');">
                                    <option value="0">-请选择车型-</option>
                                </select>
                                <span class="message" >请选择车型[]</span>
                   				<span class="messageShow" ></span> 
									</p>
									<br>
									<p><em>*</em>行驶里程：<input name="mileage" id="mileage_02" maxlength="5" class="textbox" style="width:115px;height: 30px;" type="text" onblur="validatelegalName('mileage_02')">
									<span class="message" >行驶里程不能为空[]</span>
                   				<span class="messageShow" ></span>       
									      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购车日期：<input name="buy_car_time" id="buy_car_time_02" class="textbox" maxlength="20" style="width:115px;height: 30px;" type="text" onclick="new Calendar().show(this);" onblur="validatelegalName('buy_car_time_02')" onmousemove="validatelegalName('buy_car_time_02')">
									      <span class="message" >购车日期不能为空[]</span>
                   				<span class="messageShow" ></span>  
									      </p><br>
									<p><em>*</em>购车城市：<select name="car_province_02"  id="car-province-data_02" >
                                    <option value="0">-请选择省-</option>
                                </select>
                                <select name="car_city_02"  id="car-city-data_02" onblur="validatelegalName('buy_car_city_02')">
                                    <option value="0">-请选择市-</option>
                                </select><input name="buy_car_city_02" id="buy_car_city_02" maxlength="5" class="textbox" style="width:115px;height: 30px;" type="text" hidden>
									 <span class="message" >购车城市不能为空[]</span>
                   				<span class="messageShow" ></span>  
									    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购车店面：<input name="buy_car_store" id="buy_car_store_02" class="textbox" maxlength="20" style="width:115px;height: 30px;" type="text" onblur="validatelegalName('buy_car_store_02')">
									     <span class="message" >购车店面不能为空[]</span>
                   				<span class="messageShow" ></span>  
									    </p> 
 									<br>
                                    <p><em>*</em>投诉对象：<select id="complaint_object_02" name="complaint_object" class="s3" style="width:207px;" onblur="validatelegalModle('complaint_object_02');" onchange="complaintObjectList();">
                                            <option value="0">-请选择-</option>
											<option value="1">整车维权</option>
											<option value="2">4S店维权</option>
											<option value="3">保险维权</option>
											<option value="4">其他维权</option>
										</select>
										 <span class="message" >投诉对象不能为空[]</span>
                   				<span class="messageShow" ></span>  
									</p><br>
									<div style="display:none;" id="inline-block-id"><span id="block_id">店铺名称：</span><input type="text" value="" name="store_complanint" id="store_complanint"></div>
									<br><span id="complaint_id_all"></span><br>
									<p><em>*</em>标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：<input name="title" id="title_02" maxlength="5" class="textbox" style="width:200px;height: 30px;" type="text" onblur="validatelegalName('title_02')" placeholder="最多输入十个字符">
									<span class="message" >标题不能为空[]</span>
                   				<span class="messageShow" ></span> <span style="color: gray;">如：一汽大众漏油</span>
									</p><br>
 									<p><em>*</em>车牌号码：<select name="recruitment"  id="recruitment"    onchange="carNumberAllShow();"><option value="0">-请选择-</option>
									<c:forEach var="mkeycar" items="${keycar}">
									<option value="${mkeycar['id']}">${mkeycar['name']}</option>
									</c:forEach></select><select name="letter"  id="letter"  onchange="carNumberLatter();"><option>-请选择-</option></select><input name="car_number" id="car_number" maxlength="32" class="textbox" style="width:112px;height: 30px;" type="text" onblur="validatelegalcarNumber('car_number')"> <span class="message" >车牌号码格式不正确[]</span>
                   				<span class="messageShow" ></span>  <br><br>  
									<div class="box0" onmouseover="validateNullCheck2_03();">
									 <h4><em>*</em>投诉分类：</h4>
									<c:forEach var="mkey01" items="${keyOneTypeAll}">
 									<h5>${mkey01['name']}</h5> 
 									<c:forEach var="mkey03" items="${mkey01['keytwo']}">
									 <ul class="clearfix">
									 	<li><label for="chk0"><input id="complaint_type_02" name="complaint_type" value="${mkey03['id']}" type="checkbox" >&nbsp;<span>${mkey03['name']}</span></label></li>
                                     </ul>
									
									</c:forEach>
                    				 
									</c:forEach>
                                    <span id="mesage_id_str01_02" style="color: red"></span>
									</div><br>
									<div class="box1" onmouseover="validateNullCheck2_04();">                                     
										<em>*</em>诉讼请求： 
                                         <ul class="clearfix">
                                             <c:forEach var="mkey02" items="${sqkey}">
	                                        <li><label for="chk60"><input id="lawsuit_request_02" name="lawsuit_request" value="${mkey02['id']}" type="checkbox">&nbsp;<span>${mkey02['name']}</span></label></li>
	                                        </c:forEach>
 	                                         
	                                    </ul><span id="mesage_id_str02_02" style="color: red"></span>
                                    </div><br>
									<p>请填写详细内容/您希望如何解决<font color="red">（在线维权添加提示：为确保您的信息能正确发布，请确保维权信息完整，信息内容真实!）</font></p>
                                	<p><textarea id="detail_content_02" name="detail_content" cols="123" rows="10" onblur="validatelegalName('detail_content_02')"></textarea>
                                	 <span class="message" >详细情况不能为空[]</span>
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
 var user_name_2="<%=session.getAttribute("userName")%>";
 if(user_name_2 !=null && user_name_2 != "null" && user_name_2 != ""){
 //$("#login_confirm_no").css("display","none");
     $("#login_confirm_no").html("温馨提示：你所投诉的问题必须累计超过三十个用户，我们才会帮您申请投诉！");
     $("#login_confirm_no").css("color","red");
 
  }else{
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
</script>
<script>
function complaintObjectList(){
  var comp= $('#complaint_object_02').val();
   if(comp=="1"){
      var factory=$("#car-factory-data_02").find("option:selected").text();
      var factory_id=$("#car-factory-data_02").val();
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
KindEditor.ready(function (K) {
    var editor;
    editor = K.create('#new_ceditor', {
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

 function carModalSelect_all_list_02(basePath) {//2015-06-05 杨才文
 	    var __this = '';
 	        __this = $(this);
	        var _text='';
	        var _test='';
	    	ajaxGetData('#car-brand-data_02',basePath+"member/brandList");
	    	ajaxGetData('#car-factory-data_02',basePath+"member/factoryList");
	    	ajaxGetData('#car-series-data_02',basePath+"member/fctList");
	    	ajaxGetData('#car-modal-data_02',basePath+"member/specList");
	                       
	    	$('#car-brand-data_02').change(function() {
	    	    ajaxGetData('#car-factory-data_02',basePath+"member/factoryList?id="+$(this).children(':selected').val());
	    	    _text = $(this).children(':selected').text();
	    	    _test=$(this).children(':selected').val();
	    	});

	        $('#car-factory-data_02').change(function() {
	            ajaxGetData('#car-series-data_02',basePath+"member/fctList?id="+$(this).children(':selected').val());
	            _text += '/'+$(this).children(':selected').text();
	            _test+='/'+$(this).children(':selected').val();
	        });

	    	$('#car-series-data_02').change(function() {
	    	    ajaxGetData('#car-modal-data_02',basePath+"member/specList?id="+$(this).children(':selected').val());
	    	    _text += '/'+$(this).children(':selected').text();
	    	    _test+='/'+$(this).children(':selected').val();
	    	});

	    	$('#car-modal-data_02').change(function() {
	    	    _text += '/'+$(this).children(':selected').text();
	    	    _test+='/'+$(this).children(':selected').val();
	    	});

	    	$("#save-car-modal_02").click(function() {
	    	    if(_text) {
	    	    	$('.car-modal-btn').text(_text);
	    	    	$('.selectCar').text(_text);
	            }
	    	    saveCarModel(_text,_test);
	    	    saveCarModel2(basePath,_text,_test);
	    	    $(this).closest('.modal').modal('hide');
	    	});
  	  
	}
	carModalSelect_all_list_02("<%=basePath%>");
</script>
<script type="text/javascript" src="<%=basePath%>html/js/right_select.js">
  </script>
  <script type="text/javascript" src="<%=basePath%>html/js/updataCheck.js">
  </script>
<script>
	distSelect("<%=basePath%>");
	carModalSelect_all_list_04("<%=basePath%>");
</script>
<script>
			distSelect2("<%=basePath%>");
			var _select2 = $(this);
	        var dat2="";
	        $.ajax({
	            type: "POST",
	            url: "/b2bweb-demo/pei/getUrl",
	            async:false,
	            dataType: "html",
	            success: function(data) {
	            dat2=data;
	            },
	            error: function() {
	            	_select2.text('请求失败');
	            }
	        });
	        function distSelect2(basePath) {
	        	ajaxGetData('#car-province-data_02',basePath+"member/getSelectValue?id=1");

	            $('#car-province-data_02').change(function() {
	                ajaxGetData('#car-city-data_02',basePath+"member/getSelectValue?id="+$(this).children(':selected').val());
	                $('#buy_car_city_02').val($(this).children(':selected').text());
	            });

	            $('#car-city-data_02').change(function() {
	                $('#buy_car_city_02').val($(this).children(':selected').text());
	            });
	        }
</script>