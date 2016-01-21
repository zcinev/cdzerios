<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../public/head3.jsp" %>
<style>
#personal a{
color:#767474;
}
#personal a:hover{
color:#428BCA;
}

.table-striped tr th{
font-weight: normal;
}

#ndingdan{
display: none;
}
#personal{
width: 60px;
border-radius:3px;
margin-top:1%;
margin-left:5%;
background-color: #ededed;
    background-image: linear-gradient(#fff, #e4e3e3);
    border: 1px solid #b1b1b1;
    color:#746D6D;
    font-family: "宋体";
    height:27px;
   
    font-size:12px;
    line-height: 27px;
    text-align: center;
}

</style>


<div class="container-fluid">
    <div class="row"><%--
         <%@ include file="../public/memberSidebar.jsp" %>     
        --%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li>首页</li>
                        <li class="active">配件商会员</li>
                    </ol>
                </div>
                <div  class="row"style="padding:10px 0; background:#fefbe8; overflow:hidden;">
                    <div class="col-md-2">
                        <div id="baidumap" style="width:auto;height:auto;border:1px solid #ccc;">
                        
                        <c:if test="${faceImg!= ''}">
                        
                        <img src="${faceImg}" width="100%" height="120px;">
                        </c:if>
                       
                         <c:if test="${faceImg== ''}">
                        <img src="<%=basePath %>html/img/1.jpg" width="100%" >
                        </c:if>
                        </div>
                        
                    </div>
                    <div class="col-md-9 col-md-offset-1" style="float:right;margin:0px auto;">
                    	<div class="col-md-3"style="width:25%;">
	                      <dl>
	                      	<dd><a href="<%=basePath%>member/receiveBoxNoReadTest"><img class="media-object" src="<%=basePath%>html/img/huzx_033.png" alt="站内信" id="znx" ></a></dd>
	                        <dd style="padding-left:12px;">站内信</dd>
	                        <dd><span style="color:#d60103;"><a href="<%=basePath%>member/receiveBoxNoReadTest">（${MesLength}）</a></span><a href="<%=basePath%>member/receiveBoxNoReadTest">未读</a></dd>
	                      </dl>
                      	</div>
                      	<div class="col-md-3" style="width:25%">
	                       <dl>
	                       	<dd ><a href="<%=basePath%>trade/tradeListNo?sName=1"><img class="media-object" src="<%=basePath%>html/img/huzx_055.png"  alt="订单管理" id="dingdan"></a></dd>
	                       	<dd style="margin-left: -6px;">订单管理<span style="color:#d60103;"><a href="<%=basePath%>trade/tradeListNo?sName=1">（${MainLength}）</a></span></dd>
	                       	<dd style="padding-left:16px;"><a href="<%=basePath%>trade/tradeListNoNonPay">未付款</a></dd>
	                       </dl>
	                    </div>
	                    <div class="col-md-3"style="width:25%">
                        	<dl>
                    		<dd><a href="<%=basePath%>member/producerNoEnterList"><img class="media-object" src="<%=basePath%>html/img/huzx_077.png"  alt="生厂商" id="scs"></a></dd>
                    		<dd style="margin-left: 3px;">生厂商<span style="color:#d60103;"><a href="<%=basePath%>member/producerNoEnterList">（${FacLength}）</a></span></dd>
                       
                       		<dd  style="padding-left:16px;"><a href="<%=basePath%>member/producerNoEnterList">未入驻</a></dd>
                        	</dl>
                        </div>
                        <div class="col-md-3" style="width:25%">
                       		<dl>
	                 		<dd><a href="<%=basePath%>member/productsLookNoAuditTest"><img class="media-object" src="<%=basePath%>html/img/huzx_099.png" alt="配件" id="pj"></a></dd>
	                  		<dd style="margin-left: 8px;">配件<span style="color:#d60103;"><a href="<%=basePath%>member/productsLookNoAuditTest">（${ProdLength}）</a></span></dd>
	                        <dd style="padding-left:15px;"><a href="<%=basePath%>member/productsLookNoAuditTest">未审核</a></dd>
                        	</dl>
                       	</div>
                    </div>
                    <div class="col-md-11">
                    	<dl>
                        	<dd id="personal"><a href="<%=basePath%>member/userBasicInformationTest"  id="get-ucode">编辑资料</a></dd>
                       	</dl>
                    </div>
                 </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <b style="font-weight: normal;">配件交易记录</b>
                </div>
                  <c:if test="${PJkey=='00010'}">
                <table class="table table-striped">
                    <tr></tr>
                    <tr>
                        <th width="20%">订单号</th>
                        <th width="15%">商品名称</th>
                        <th>买家</th>
                        <th>价格</th>
                        <th>付款状态</th>
                        <th width="20%">时间</th>
                        <th>查看</th>
                    </tr>
                    <c:forEach var="mkey" items="${key1}" >
                    <tr>
                        <td>${mkey['orderMainId']} </td>
                        <td>${mkey['goodname']} </td>
                        <td>${mkey['buyer']} </td>
                        <td>${mkey['goodsSumPrice']} </td>
                        <td>${mkey['stateName']}   </td>
                        <td>${mkey['addTime']}  </td>
                        <td><a href='javascript:;' class="a_t_detailed" data-toggle='modal' data-target='#myModal' onClick="javascript:peiJianDelRecord('${mkey['id']}');" style='text-decoration :none;' title='详细'>详细</a> </td>
                    </tr>
                    </c:forEach>      
                </table>
               </c:if>
                <%-- <c:if test="${PJkey=='10011'}">
                <b style="padding-left: 20%;font-weight: normal;">你还没有任何交易记录！</b>
        <img id="faceImgId" src="<%=basePathImg%>20141124114537tgU0fwpvqd.jpg" width="600" height="150" alt="xxx">
                
                </c:if> --%>
               <c:if test="${PJkey=='10011'}">  
              <div style="height: 173px;">
        <img id="faceImgId" src="<%=basePath%>html/img/cdzer-search.png" width="90" height="111" alt="cdzer" style="margin-left:35%;margin-top:4%; ">
         <b style="font-weight: normal;">你还没有任何交易记录！</b>
          </div> 
                </c:if>
              
            </div>
           <%--  <div class="panel panel-default">
                <div class="panel-heading">
                    <b style="color:#418bca;">评价记录</b>
                </div>
                <table class="table table-striped">
                        <tr></tr>
                        <tr>
                            <th>商品名称</th>
                            <th>评价人</th>
                            <th>打分</th>
                            <th>评价内容</th>
                            <th>时间</th>
                        </tr>
                        <c:forEach var="mkey" items="${key2}" >
                        <tr>
						 <td>${mkey['parts']} </td>
						<td>${mkey['reviewer']} </td>
						<td>${mkey['leverId']} </td>
						<td>${mkey['content']} 	</td>
						<td>${mkey['createTime']} 	</td>
						 </tr>
						</c:forEach>    
                </table>
            </div> --%>
        </div>
        <!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal" style="top:5%;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			   <div class="modal-dialog" style="width: 660px;">
			      <div class="modal-content" style="width: 660px;">
			         <div class="modal-header" style="width: 657px;">
			            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"style="width:25px;
                                height:25px;  margin-right: -14px;">×
			            </button>
			            <h4 class="modal-title" id="myModalLabel">
			               	配件交易记录详情
			            </h4>
			         </div>
			         <div class="modal-body" style="width: 660px;">
			         	<form class="form-horizontal" role="form">
							<div class="form-group">
							    <div class="col-sm-12 form-inline" >
							    	<span style="margin-left: 10%;"><strong>订单号&nbsp;:&nbsp;</strong><span id="orderMainId"></span></span>
							    </div>
							</div>
							<div class="form-group">
							    <div class="col-sm-12 form-inline" >
							    	<span style="margin-left: 10%;"><strong>买家&nbsp;:&nbsp;</strong><span id="buyer"></span></span>
							    </div>
							</div>
							<div class="form-group">
								<div class="col-sm-12 form-inline" >
							    	<span style="margin-left: 10%;"><strong>价格&nbsp;:&nbsp;</strong><span id="goodsSumPrice"></span></span>
							    </div>
							</div>
							 
							<div class="form-group">
								<div class="col-sm-12 form-inline" >
							    	<span style="margin-left: 10%;"><strong>付款状态&nbsp;:&nbsp;</strong><span id="stateName"></span></span>
							    </div>
							</div>
						    <div class="form-group">
								<div class="col-sm-12 form-inline" >
							    	<span style="margin-left: 10%;"><strong>时间&nbsp;:&nbsp;</strong><span id="addTime"></span></span>
							    </div>
							</div>
						</form>
			         </div>
			         <div class="modal-footer">
			            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			         </div>
			      </div><!-- /.modal-content -->
			   </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
    </div>
</div>

<%@ include file="../public/foot.jsp" %>
<script>
function peiJianDelRecord(obj){
		$.ajax({
		     type : "POST",
		     url : "<%=basePath%>member/peiJianDelRecord",
		     dataType : "json",
			 async : true,
		     data : {id:obj},
		     success : function(data){
				for(var i=0; i<data.length; i++){
		     		document.getElementById("orderMainId").innerHTML=data[i].orderMainId; 
		     		document.getElementById("buyer").innerHTML=data[i].buyer;
		     		document.getElementById("goodsSumPrice").innerHTML=data[i].goodsSumPrice;
 		     		document.getElementById("stateName").innerHTML=data[i].stateName;
		     		document.getElementById("addTime").innerHTML=data[i].addTime;
		     	}
		     	  
		     },
		     error : function(){
		     	alert('失败');
		     }
		 });
	}
</script>
<!-- <script type="text/javascript">

$("#dingdan").hover(function(){
$("#dingdan").css("display","none");
$("#ndingdan").css("display","block");
},
function(){
$("#ndingdan").css("display","none");
$("#dingdan").css("display","block");
});


$("#znx").hover(function(){
$("#znx").css("display","none");
$("#nznx").css("display","block");
},
function(){
$("#nznx").css("display","none");
$("#znx").css("display","block");
});


$("#scs").hover(function(){
$("#scs").css("display","none");
$("#nscs").css("display","block");
},
function(){
$("#nscs").css("display","none");
$("#scs").css("display","block");
});


$("#pj").hover(function(){
$("#pj").css("display","none");
$("#npj").css("display","block");
},
function(){
$("#npj").css("display","none");
$("#pj").css("display","block");
});
</script>  -->
