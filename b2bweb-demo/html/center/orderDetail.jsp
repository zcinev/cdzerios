<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/mchead.jsp" %>
    <script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
    
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
.td-blue{
color: #00a9ff;;
}
#detail{
color:#333;
background-color: #e5f5ff;
border: 1px solid #40b3ff;
padding-left: 20px;
padding-top: 8px;
padding-bottom: 8px;
}
</style>
        <div class="container-fluid">
            <div class="row">
                <%@ include file="../public/centerSidebar.jsp" %>
                    <div class="col-xs-10 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                             <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">订单详情
                        </li>
                        
                    </ol>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered" style="width:100%;margin:20px auto;border:1px solid #ccc;">
                                   <!--  <tr class="tr-active">
                                        <th class="td-black text-center">订单号</th>
                                        <th class="td-black text-center">下单时间</th>
                                        <th class="td-black text-center">订购人</th>
                                        <th class="td-black text-center">联系方式</th>
                                      
                                    </tr> -->
                                     <tr class="active">
                                        <th class="text-center">订单号</th>
                                        <th class="text-center">下单时间</th>
                                        <th class="text-center">订购人</th>
                                        <c:if test="${key['mainOrderIdName']!=''}">
                                        	<th class="text-center">订单备注</th>
                                        </c:if>
                                          <th class="text-center">车架号</th>
                                        <th class="text-center">状态</th>
                                    </tr>
                                    <tr>
                                        <td class="text-center">${key['mainOrderId']}</td>
                                        <td class="text-center">${key['createTime']}</td>
                                        <td class="text-center">${key['contacts']}</td>
                                        <c:if test="${key['mainOrderIdName']!=''}">
                                        	<td class="text-center">${key['mainOrderIdName']}</td>
                                        </c:if>
                                          <td class="text-center">${key['frameNo']}</td>
                                        <td class="text-center">${key['stateName']}</td>
                                    </tr>
                                </table>
                                
                                
                                 <c:if test="${key['stateName'].equals('申请退货中') }">
                                 <dl class="order-detail">
                                    <dt class="td-blue"><h4>申请退款信息</h4></dt>
                                   <dd>申请原因：${key6['userNote']}（用户备注：${key6['userRemark']}）——— 用户申请退货日期${key6['userReDate']})</dd> 
                                </dl>
                                </c:if>
                                
                                 <span class="td-blue" style="color: #00a9ff;">车系车型</span><br/>
                                   <dd>${key['carModel']}</dd> 
                                   <br/>
                                   
                                <dl class="" id="detail">
                                <span class="td-blue" style="color: #00a9ff;">收货详情</span><br/>
                                  <!--   <dt class="td-blue">收货详情</dt> -->
                                    <dd>收货人：${key['contacts']}</dd>
                                    <dd>联系电话：${key['tel']}</dd>
                                    <dd>收货地址：${provinceIdName}&nbsp;${cityIdName}&nbsp;${regionIdName}${key['addressName']}</dd>
                                    <dd>付款方式：${str}</dd> 
                                    <dd>买家留言：${key['remarks']}</dd>
                                    <c:if test="${key['stateName'].equals('派送中') }">
                                     <dd>快递单号：${key['mailNo']}</dd> 
                                    </c:if>   
                                </dl>
                                
                                <table class="table table-bordered" style="width:100%;margin:20px auto;border:1px solid #ccc;">
                                    <caption class="text-left">
                                      <span class="td-blue" style="color: #00a9ff;">商品明细</span>
                                    </caption>
                                    
                                    <tr class="active">
                                        <th class="text-center">商品</th>
                                        <th class="text-center">货号</th>
                                        <th class="text-center">数量</th>
                                        <th class="text-center">单价（元）</th>
                                         <th class="text-center">邮费（元）</th>
                                        <th class="text-center">积分</th>
                                        <th class="text-center">小计（元）</th>
                                        <th class="text-center">配送方式</th>
                                    </tr>
                                     <c:forEach var="mkey" items="${key3}" >
                                    <tr>
                                        <td>
                                            <dl class="dl-horizontal td-dl">
                                              <%--   <dt><img src="<%=basePath%>html/plugin/Picswitch/images/${mkey['productImg']}" alt=""></dt> --%>
                                                <dd class="text-left">
                                                    <span class="member-main-warning" style="padding:0;"><a href="<%=basePath%>pei/detail?goodid=${mkey['goodId']}">${mkey['goodname']}</a></span>  
                                                </dd>
                                            </dl>
                                        </td> 
                                        <td class="text-center">
                                           ${mkey['goodId']}
                                        </td>
                                        <td class="text-center">
                                           ${mkey['quantity']}
                                        </td>
                                        <td class="text-center">
                                           ${mkey['price']}
                                        </td>
                                        <td class="text-center">
                                           ${mkey['sendPrice']}
                                        </td>
                                        <td class="text-center">
                                          ${mkey['credits']}
                                        </td>
                                        <td class="text-center">
                                           ${mkey['allPrice']}
                                        </td>
                                         <td class="text-center">
                                        	${mkey['sendWayName']}
                                        </td>
                                        
                                    </tr>
                                    </c:forEach>
                                </table>
                                
                                <form class="form-horizontal" role="form"  action="<%=basePath%>purchase/checkStoreList" method="post" <c:if test="${key['stateName'].equals('已付款') || key['stateName'].equals('货到付款')  }">onsubmit="return orderDetail();"</c:if> >
                                <input type="hidden" name="orderId" value="${key['id']}">
                                <input type="hidden" name="mainOrderId" value="${key['mainOrderId']}">
                                <input type="hidden" name="state" value="${key['state']}">
								<input type="hidden" name="price" value="${key['goodsPrice']}">
								
								
								
								
								<c:if test="${key['stateName'].equals('已付款') || key['stateName'].equals('货到付款')  }">
									<div class="form-group">
			                            <label class="col-sm-2 control-label">物流公司</label>
			                            <div class="col-sm-10 form-inline">
			                            	<select id="sendWay" name="sendWay" class="form-control" onblur="validatelegalName2('sendWay')" >
			                            	</select>
			                            	<span class="message" >物流公司不能为空[]</span>
                   				<span class="messageShow" ></span>
			                            	<input type="hidden" name="sendWayDefault" id="sendWayDefault" value="${key['sendWay']}" class="form-control">
			                            	<input type="hidden" name="sendWayName" id="sendWayName" value="${key['sendWayName']}" class="form-control">
			                        	</div>
			                        </div>   
			                        <div class="form-group">
			                            <label class="col-sm-2 control-label">快递单号</label>
			                            <div class="col-sm-10 form-inline">
			                            	<input type="text" name="mailNo" id="mailNo" class="form-control" onblur="validatelegalName('mailNo')" maxlength="30">
                                <span class="message" >快递单号不能为空[]</span>
                   				<span class="messageShow" ></span>
			                        	</div>
			                        </div>
        						</c:if> 
        						
        						<c:if test="${key['stateName'].equals('申请退货中') }">  
                                    <div class="form-group">
			                          <label class="col-sm-2 control-label">操作</label>
			                            <div class="col-sm-10 form-inline">
			                                <select name="oprate" class="form-control" onchange="changeOpreate(this)">
			                                    <option value="12">-同意退款-</option>
			                                    <option value="13">-拒绝退款-</option>
			                                </select>
			                            </div>
			                              </div>
			                              
			                              <input type="hidden" name="mark" value="${mark}">
			                              
			                             
			                            <c:if test="${mark=='0' }">
			                                <div class="form-group" id="backProject">
			                            <label class="col-sm-2 control-label">退款金额（元）</label>
			                            <div class="col-sm-10 form-inline">
			                             
			                             <input type="text" name="backNum" class="form-control" value="${sumPrice}"
			                             onkeyup="detailNumber(this);" onblur="detailNumber(this);">
			                             </div>
			                              </div>
			                             
			                             </c:if>
			                             
			                              <c:if test="${mark=='1' }">
			                                <div class="form-group" id="backCredit">
			                            <label class="col-sm-2 control-label">退还积分（个）</label>
			                            <div class="col-sm-10 form-inline">
			                             <input type="text" name="backCredit" class="form-control" 
			                              onkeyup="detailNumber1(this);" onblur="detailNumber1(this);"
			                             value="${credit_back}">
			                             </div>
			                             </div>
			                             </c:if>
			                             
			                             
			                             <c:if test="${mark=='2' }">
			                             
			                               <div class="form-group" id="backProject">
			                            <label class="col-sm-2 control-label">退款金额（元）</label>
			                            <div class="col-sm-10 form-inline">
			                             
			                             <input type="text" name="backNum" class="form-control" value="${sumPrice}"
			                             onkeyup="detailNumber(this);" onblur="detailNumber(this);">
			                             </div>
			                              </div>
			                                <div class="form-group" id="backCredit">
			                            <label class="col-sm-2 control-label">退还积分（个）</label>
			                            <div class="col-sm-10 form-inline">
			                             <input type="text" name="backCredit" class="form-control" 
			                              onkeyup="detailNumber1(this);" onblur="detailNumber1(this);"
			                             value="${credit_back}">
			                             </div>
			                             </div>
			                             </c:if>
			                               
        						 </c:if>
        						 
        					<%--   <c:if test="${key['stateName'].equals('等待退款') }">   
			                               <div class="form-group">
			                            <label class="col-sm-2 control-label">退款金额（元）</label>
			                            <div class="col-sm-10 form-inline">
			                             <input type="text" name="backNum" class="form-control">
			                                </div>
			                              </div>
        							</c:if>  --%>
        						 
        				 <c:if test="${key['stateName'].equals('申请退货中') || key['stateName'].equals('已付款') || key['stateName'].equals('等待退款') || key['stateName'].equals('货到付款')}"> 			
			                        <div class="form-group">
			                            <label class="col-sm-2 control-label">备注</label>
			                            <div class="col-sm-10 form-inline">
			                                <textarea name="content" class="form-control" style="width:90%;" rows="10" maxlength="200"></textarea>
			                            </div>
			                        </div>
			                        <div class="form-group">
			                            <div class="col-sm-offset-2 col-sm-10">
			                                <button type="submit" class="btn btn-primary">提交</button>
			                            </div>
			                        </div>
			                        </c:if>
			                        
			             <c:if test="${key['stateName'].equals('未付款')}">
			              			<div class="form-group">
			                            <label class="col-sm-2 control-label">备注</label>
			                            <div class="col-sm-10 form-inline">
			                                <textarea name="content" class="form-control" style="width:90%;" rows="10" maxlength="200">由于您长时间未付款，您的订单已经被商家取消！</textarea>
			                            </div>
			                        </div>
			                        
								   <div class="form-group">
			                            <div class="col-sm-offset-5 col-sm-10">
			                                <button type="submit" class="btn btn-primary">取消订单</button>
			                                 <button type="submit" class="btn btn-primary">返回</button>
			                            </div>
			                        </div>
								</c:if>
								
						
						 <c:if test="${key['stateName'].equals('派送中')}">
						 <c:if test="${str=='货到付款'}">
			              			<div class="form-group">
			                            <label class="col-sm-2 control-label">备注</label>
			                            <div class="col-sm-10 form-inline">
			                                <textarea name="content" class="form-control" style="width:90%;" rows="10" maxlength="200">由于您拒绝签收，您的订单已经被商家取消！</textarea>
			                            </div>
			                        </div>
			                        
								   <div class="form-group">
			                            <div class="col-sm-offset-5 col-sm-10">
			                                <button type="submit" class="btn btn-primary">取消订单</button>
			                                 <button type="submit" class="btn btn-primary">返回</button>
			                            </div>
			                        </div>
								</c:if>
							</c:if>			
			                    </form>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
        <%@ include file="../public/foot.jsp" %>
        <script>
			//物流方式
        ajaxGetData('#sendWay',"<%=basePath%>member/sendWay");
        var sendWayDefault=$('#sendWayDefault').val();
        $("#sendWay option[value='" + sendWayDefault + "'] ").attr("selected",true);
        $('#sendWay').change(function() {
    		$('#sendWayName').val($(this).children(':selected').text());
	    });
		</script>
		<script>
		function orderDetail(){
		  var check = true;
 	if (!validatelegalName('mailNo')) {
		check = false;
	} 
	if (!validatelegalName2('sendWay')) {
		check = false;
	}     
	return check;
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


function detailNumber(obj){
	 var maxNumberStr="${sumPrice}";
	 
	  var maxNumber=parseInt(maxNumberStr);
	  if(obj.value.length==1){
	  obj.value=obj.value.replace(/[^0-9]/g,0);
	  }else {
	  obj.value=obj.value.replace(/[^\d.]/g,'');
	  }
	  if(obj.value>maxNumber){
	      obj.value=maxNumber;
	  }
	  if(obj.value==""){
 	    obj.value="";
	  }
}


function detailNumber1(obj){
	 var maxNumberStr="${credit_back}";
	 
	  var maxNumber=parseInt(maxNumberStr);
	  if(obj.value.length==1){
	  obj.value=obj.value.replace(/[^1-9]/g,1);
	  }else {
	  obj.value=obj.value.replace(/\D/g,'');
	  }
	  if(obj.value>maxNumber){
	      obj.value=maxNumber;
	  }
	  if(obj.value==""){
 	    obj.value="";
	  }
}

function changeOpreate(thisElem){
	var keyvalue=$(thisElem).val();
	var mark="${mark}";
	if(mark==0){
		var backProject=document.getElementById("backProject");
		if(keyvalue=='12'){
		backProject.style.display="";
	}else{
		backProject.style.display="none";
	}
	}
	if(mark==1){
	var backCredit=document.getElementById("backCredit");
	if(keyvalue=='12'){
		backCredit.style.display="";
	}else{
		backCredit.style.display="none";
	}
	}
	if(mark==2){
			var backProject=document.getElementById("backProject");
	var backCredit=document.getElementById("backCredit");
	if(keyvalue=='12'){
		backProject.style.display="";
		backCredit.style.display="";
	}else{
		backProject.style.display="none";
		backCredit.style.display="none";
	}
	}
	
	
}
</script>