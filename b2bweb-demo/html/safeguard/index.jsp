<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
<%@ include file="../public/shead.jsp"%>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
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
			 	<div><img src="<%=basePath%>html/img/safe/safe_advertisement.png"></img></div>
			</div>
			<div class="col-md-12">
				<div class="safe_tab pull-left">
					<ul class="nav nav-tabs" role="tablist" id="myTab">
						<li class=""><a href="<%=basePath%>carsaf/carSafeIndex"   id="tab">热门维权</a></li>
						<li class=""><a href="<%=basePath%>carsaf/carSafeIndex?complaint_object=ZCwq"  id="zcwq_id">整车维权</a></li>
						<li class=""><a href="<%=basePath%>carsaf/carSafeIndex?complaint_object=4Swq"  id="4swq_id" >4S店维权</a></li>
						<li class=""><a href="<%=basePath%>carsaf/carSafeIndex?complaint_object=BXwq"  id="bxwq_id">保险维权</a></li>
						<li class=""><a href="<%=basePath%>carsaf/carSafeIndex?complaint_object=QTwq"  id="qtwq_id" >其他维权</a></li>
						<input name="complaint_object_str" id="complaint_object_str" type="hidden" value="${complaint_object_str}">
						<div class="pull-right complaint">今日投诉：<font color="red">${now_time_safe}</font>条&nbsp;&nbsp; 投诉总量：<font color="red">${all_safe}</font>条</div>
					</ul>
					<div class="tab-content">
						<div class="pull-left">
						    <div class="savepw">搜索维权</div>
							<div class="sarchbarin">
							<form action="<%=basePath%>carsaf/carSafeIndex" method="post" >
								<input id="searchType" type="hidden">
								<input value="" autocomplete="off"   class="safeinput" id="searchText" name="searchText" placeholder="请输入关键字" type="text">
								<button   class="safenew" value="搜索" type="submit">搜索</button>
							</form>	
							</div>
						</div>
						<div class="pull-right">
						 <div class="topw" >直通维权</div>  
							<div class="sarchbarin">
								<form action="<%=basePath%>carsaf/newComplaintList" method="POST">
								<!-- <select class="valid" aria-invalid="false" name="bid" id="b" onchange="brandChange(this);">
									<option value="0">
										选择品牌
									</option>
								</select>
								<select class="valid" aria-invalid="false" name="bid" id="b" onchange="brandChange(this);">
									<option value="0">
										选择车系
									</option>
								</select> -->
								<button   class="safenew" value="进入" type="submit">发布维权</button>
								</form>
							</div>
						</div>
					</div>
					<div class="two_tab">
						<ul class="nav two-nav-tabs" role="tablist" id="myTab">
							<li><a href="<%=basePath%>carsaf/carSafeIndex" id="allts_id">全部投诉</a></li>
							<li class=""><a href="<%=basePath%>carsaf/carSafeIndex?state=0001" id="yjjts_id">已解决投诉</a></li>
							<input name="state_str" id="state_str" value="${state_str}" type="hidden">
						</ul>
					</div>
					<form action="<%=basePath%>carsaf/carSafeIndex" method="post" name="myform" id="myform">
					<div class="newslist">
						<ul>
 						      <c:forEach var="mkey09" items="${key5}">
							<li>
								<a target="_blank" href="#">
									<img src="${mkey09['imgurl']}" alt="车辆图片" height="105" width="160">
								</a>
								<div class="detail">
									<div class="news_title" style="float:left;">
										<a target="_blank" href="<%=basePath%>carsaf/complaintComment?id=${mkey09['id']}">${mkey09['title']}</a>
										
									</div>
									<div style="float:left;padding-top:5px;">
										<div style="width:54px;height:18px;float:left;padding-left:10px;background-image:url('<%=basePath%>html/img/safe/save3.png');background-repeat:no-repeat;"><font size="1.5" color="#fff">${mkey09['state_name']}</font></div>&nbsp;&nbsp;
										<em><a onclick="javascript:sameExample('${mkey09['id']}','${mkey09['title']}')" data-toggle="modal"  data-target="#same-model" ><img src="<%=basePath%>html/img/safe/save2.png"></img>添加案例</a></em>&nbsp;&nbsp;
										<em><a href="<%=basePath%>carsaf/timeAxisList?id=${mkey09['id']}&com_len=${mkey09['com_len']}"><img src="<%=basePath%>html/img/safe/save_1.png"></img>数量（${mkey09['count_all']}）</a></em>
									</div>
 
									 <p style="display:inline;">
									<span>${mkey09['detail_content']}</span>
										<%-- <span>诉讼分类:${mkey09['complaint_type_name']}</span>
 
									<p>
										<span>标题:${mkey09['title']}</span>
 
										 <span>诉讼城市：${mkey09['buy_car_city']}</span>
												<span>诉讼车型：${mkey09['brand_name']} - ${mkey09['speci_name']}</span> --%>
										 </p>
 
									 
 
									<div>
										<em class="gjz">
											关键字:<a class="hotbq hotbq-a" href="#">${mkey09['title']}</a><a href="#" class="hotbq hotbq-b">${mkey09['complaint_type_name']}</a></em> 
										<em class="time">
							                <img src="<%=basePath%>html/img/safe/save5.png"></img>${mkey09['complaint_time']}</em>
										<em class="ding dinga a_13815"><a href="<%=basePath%>carsaf/complaintComment?id=${mkey09['id']}"><img src="<%=basePath%>html/img/safe/save4.png"></img>${mkey09['com_len']}</a></em>
									</div>
								</div>
							</li>
							 </c:forEach>
						</ul>
					    
						<div class="morenews"><a href="<%=basePath%>carsaf/carSafeIndex">浏览更多精彩资讯</a>
					</div>
					</div>
					<ul><div style="padding-right: 140px;">${page}</div>  </ul>  
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
					</form>
				</div>
				<div class="pull-right hot_note">
					<div class="safe_title"><h1>每日热帖</h1></div>
					<div class="safe_menu">
						<ul>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
							<li>每日一帖每日一帖每日一帖</li>
						</ul>
					</div>
					<div class="safe_title"><h1>成功案例</h1></div>
				</div>
			</div>
			<div class="col-md-12 paddingRight0 paddingLeft0 pull-left contractor">
			 	<div class="c_title pull-left">维权合作伙伴</img></div>
				<div class="c_menu pull-left">
					<ul>
						<li><a href="#"><img src="<%=basePath%>html/img/safe/logo_one.png"></img></a></li>
						<li><a href="#"><img src="<%=basePath%>html/img/safe/logo_two.png"></a></li>
						<li><a href="#"><img src="<%=basePath%>html/img/safe/logo_three.png"></a></li>
						<li><a href="#"><img src="<%=basePath%>html/img/safe/logo_one.png"></a></li>
						<li><a href="#"><img src="<%=basePath%>html/img/safe/logo_two.png"></a></li>
						<li><a href="#"><img src="<%=basePath%>html/img/safe/logo_three.png"></a></li>
					</ul>
				</div>
			</div>
        </div>
    </div>
<div class="modal fade same-model" style="margin-left: -200px;" id="same-model">
        <div class="modal-dialog">
            <div class="modal-content" id="model2" >
                <div class="modal-header">
                    <h6 class="modal-title" >在线维权 </h6>
                    <%--<div class="modal-title pull-right" style="padding-right:10px;font-size:18px;">在线查询，及时反馈</div>
                --%>
                </div>
                <div class="modal-body">
                	爱车维权，强调的是车队长采用的是法律武器维权，可重新发表投诉，以便我们再次跟进协调，使消费者自身利益得到维护！
                <div class="panel current" style="box-shadow: 0px rgba(0, 0, 0, 0.05);">                                                   
                        	 <form class="form4" target="_self" method="post" action="<%=basePath%>carsaf/indexComplaintApplySame" onsubmit="javascript:return onsubmitlist04();">                            	<div class="group group0">
                            		<br>
                                    <h3>您要投诉的车型相关信息：</h3>
                                    <br>
                                    <span style="color: red;">温馨提示：你所投诉的问题必须累计超过三十个用户，我们才会帮您申请投诉！</span><br>
                                    <br>
                                     <p><em>*</em>车主姓名：<input name="car_name" id="car_name_03" maxlength="5" class="textbox" style="width:115px;" type="text" onblur="validatelegalName('car_name_03')">
                                     <span class="message" >车主姓名不能为空[]</span>
                   					 <span class="messageShow" ></span>   
                                     　							<em>*</em>联系电话：<input name="telephone" id="telephone_03" class="textbox" maxlength="20" style="width:115px;" type="text"  onblur="validatelegalTel('telephone_03');">
                                      <span class="message" >联系电话格式不正确[]</span>
                   					  <span class="messageShow" ></span>    
                                     <br><br><em>*</em>具体车型：
                                    	 <select name="brand"  id="car-brand-data_all">
                                    <option value="0">-请选择品牌-</option>
                                </select>
                                <select name="factory"  id="car-factory-data_all">
                                    <option value="0">-请选择厂商-</option>
                                </select>
                                <select name="fct"  id="car-series-data_all">
                                    <option value="0">-请选择车系-</option>
                                </select>
                                 <select name="speci"  id="car-modal-data_all" onblur="validatelegalModle_03('car-modal-data_all');">
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
									<p><em>*</em>购车城市：<select name="car_province_04"  id="car-province-data_04" >
                                    <option value="0">-请选择省-</option>
	                                </select>
	                                <select name="car_city_04"  id="car-city-data_04" onblur="validatelegalName('buy_car_city_04')">
	                                    <option value="0">-请选择市-</option>
                                    </select>
                                    <input name="buy_car_city_04" id="buy_car_city_04" maxlength="5" class="textbox" style="width:115px;" type="text" hidden>
									<span class="message" >购车城市不能为空[]</span>
                   				<span class="messageShow" ></span> 
									
									    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购车店面：<input name="buy_car_store" id="buy_car_store_03" class="textbox" maxlength="20" style="width:115px;" type="text" onblur="validatelegalName('buy_car_store_03')">
									    <span class="message" >购车店面不能为空[]</span>
                   				<span class="messageShow" ></span> 
									    </p><br>
									*标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：<input name="title_id" id="title_id" class="textbox" maxlength="10" type="text" disabled="disabled"><br>    
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
                   				<span class="messageShow" ></span>  <br><br>  
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
    </div>
    <%@ include file="../public/foot.jsp"%>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
function sameExample(obj,title){
   $('#same-xample').val(obj);
   $('#title_id').val(title);
   
  var userName = "<%=session.getAttribute("userName")%>";	
  if(userName==null ||userName =="" ||userName=="null"){
    alert("请先登录，否则填写的信息无效！");
   }  
};
 carModalSelect_all_list("<%=basePath%>");
 
function complaintObjectList(){
  var comp= $('#complaint_object_03').val();
   if(comp=="1"){
      var factory=$("#car-factory-data_all").find("option:selected").text();
      var factory_id=$("#car-factory-data_all").val();
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
 
 $(document).ready(function(){
   var object=$('#complaint_object_str').val();
      if(object==null || object=="" || object=="null"){
            $("#tab").css("background-color","#1973d4");
              $("#tab").css("color","white");    
       }
        if(object=="整车维权"){   
            $("#zcwq_id").css("background-color","#1973d4"); 
             $("#zcwq_id").css("color","white");   
               
       }
        if(object=="保险维权"){ 
            $("#bxwq_id").css("background-color","#1973d4");   
              $("#bxwq_id").css("color","white");
       }
        if(object=="4S店维权"){
            $("#4swq_id").css("background-color","#1973d4");   
              $("#4swq_id").css("color","white");
       }
        if(object=="其他维权"){
            $("#qtwq_id").css("background-color","#1973d4");   
              $("#qtwq_id").css("color","white");
       }
   
 });
 
 $(document).ready(function(){
   if($('#state_str').val()==null || $('#state_str').val()=="" ||$('#state_str').val()=="null"){
               $("#allts_id").css("color","#1973d4");  
   }
   if($('#state_str').val()=="0001" ){
               $("#yjjts_id").css("color","#1973d4");  
   }
 });
   $(document).ready(function(){
    $(".label-primary").css("background-color","#1973d4");
     $(".active a").css("background-color","#1973d4");
   
    });
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
 function onsubmitlist04(){
      var type=true;
    var userName = "<%=session.getAttribute("userName")%>";	
    if(userName==null ||userName =="" ||userName=="null"){
      alert("您还未登录，请先登录！");
    type = false;
    }
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
	if (!validatelegalName('buy_car_city_04')) {
 		type = false;
	} 
	if (!validatelegalName('buy_car_store_03')) {
 		type = false;
	} 
	 
	if (!validatelegalModle_03('complaint_object_03')) {
 		type = false;
	} 
	if (!validatelegalModle_03('car-modal-data_all')) {
 		type = false;
	} 
	if (!validatelegalName('detail_content_03')) {
 		type = false;
	} 
	if (!validatelegalcarNumber('car_number')) {
 		type = false;
	}
    return type;
 
};
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
<script type="text/javascript" src="<%=basePath%>html/js/right_select.js">
</script>
<script>
	distSelect("<%=basePath%>");
	carModalSelect_all_list_04("<%=basePath%>");
</script>
<script>
	distSelect("<%=basePath%>");
	carModalSelect_all_list_04("<%=basePath%>");
	distSelect4("<%=basePath%>");
	var _select4 = $(this);
    var dat4="";
    $.ajax({
        type: "POST",
        url: "/b2bweb-demo/pei/getUrl",
        async:false,
        dataType: "html",
        success: function(data) {
        dat4=data;
        },
        error: function() {
        	_select4.text('请求失败');
        }
    });
    function distSelect4(basePath) {
    	ajaxGetData('#car-province-data_04',basePath+"member/getSelectValue?id=1");

        $('#car-province-data_04').change(function() {
            ajaxGetData('#car-city-data_04',basePath+"member/getSelectValue?id="+$(this).children(':selected').val());
            $('#buy_car_city_04').val($(this).children(':selected').text());
        });

        $('#car-city-data_04').change(function() {
            $('#buy_car_city_04').val($(this).children(':selected').text());
        });
    }
</script>