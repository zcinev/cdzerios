<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bc.localhost.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
String pathwx = "/b2bweb-repair";
String basePathwx = BccHost.getHost()+pathwx+"/";
%>

<style>
/* 
 .normal {color:#767474;}
.start {color:#428BCA;}
.list-body a{

}
.list-body a:hover{
color:#428BCA;
}
.list-body a:ACTIVE{
color:#428BCA;
}  */


.list-title {
font-weight: normal;
color:#454545;
font-size: 13px;
}
.list-title a:hover{
color:#428BCA;
}
.glyphicon-plus-sign{
color:#8c9093;
width: 4px;
height: 4px;
cursor: pointer;
margin-right: 16px;
}
.glyphicon-minus-sign{color: #ff9721;cursor: pointer;margin-right: 10px;}

</style>
<div class="col-md-2 paddingLeft0 pull-left">
    <div class="panel panel-default">
        <div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
            <h3 class="panel-title">
            	<c:if test="${typeId ==1}">个人会员</c:if>
            	<c:if test="${typeId ==2}">配件商</c:if>
            	<c:if test="${typeId ==3}">维修商</c:if>
            	<c:if test="${typeId ==4}">企业</c:if>
            	<c:if test="${typeId ==5}">采购中心</c:if>
            </h3>
        </div>
        <div class="panel-body">
        <c:if test="${typeId ==1}">
        	<dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-arrow-right"></span> <a href="<%=basePath%>join/jumpJoin" >我要加盟</a></dt>
            </dl>
         </c:if>  

            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span>基本信息</dt>
                <c:if test="${typeId ==1}">
                <dd class="list-body" ><a  href="<%=basePathwx%>person/userBasicInformation">个人资料</a>
                </dd>
                </c:if>
                 <c:if test="${typeId ==2}">
                  <dd class="list-body"><a href="<%=basePath%>member/userBasicInformationTest">个人资料</a>
                </dd>
                 </c:if>
                <%-- <c:if test="${typeId !=2}">
                 <dd class="list-body"><a href="<%=basePathwx%>adv/jumpUpdateTe">修改手机/密码</a>
                </dd>
                </c:if> --%>
               <%-- <dd class="list-body"><a href="<%=basePath%>member/consigneeAddressList">收货地址列表</a>
                </dd> --%>
                 <c:if test="${typeId !=2}">
                 <dd class="list-body"><a href="<%=basePathwx%>person/userTimeAndPalce">密码安全</a>
                 </c:if>
                 <c:if test="${typeId ==2}">
                  <dd class="list-body"><a href="<%=basePath%>member/userTimeAndPalce">密码安全</a>
                 </c:if>
                </dd>
                <dd class="list-body"><a href="<%=basePath%>member/consigneeAddressList">收货地址列表</a>
                </dd>
               <%--  <c:if test="${typeId ==1}">
                <dd class="list-body"><a href="<%=basePath%>member/selectAddress">添加收货地址</a>
                </dd>
                </c:if> --%>
            </dl>
         
           <c:if test="${typeId ==2}">
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span style="margin-left: -6px;"> 店铺管理</span></dt>
                <dd class="list-body"><a href="<%=basePath%>member/storeInfo">基本信息</a>
                </dd>
                <dd class="list-body"><a href="<%=basePath%>member/uploadImgLookTest">图片上传</a>
                </dd>
               <%--  <dd class="list-body"><a href="<%=basePath%>html/member/storeDet.jsp">店铺详情</a>
                </dd> --%>
            </dl>

            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span style="margin-left: -1px;">生产商管理</span></dt>
                <dd class="list-body"><a href="<%=basePath%>member/producerList">生产商列表</a>
                </dd>
                <%-- <dd class="list-body"><a href="<%=basePath%>member/addManufacturerList">添加生产商</a>
                </dd> --%>
            </dl>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span style="margin-left: -4px;"> 产品管理</span></dt>
                <dd class="list-body"><a href="<%=basePath%>member/productsLookTest">配件列表</a>
                </dd>
                <%-- <dd class="list-body"><a href="<%=basePath%>member/productsAddList">添加配件</a>
                </dd> --%>
            </dl>
           </c:if>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span style="margin-left: -4px;"> 订单管理</span></dt>
                <!-- <dd class="list-body"><a href="<%=basePath%>/member/tradeOk">订单列表</a>
                </dd>-->
                <dd class="list-body"><a href="<%=basePath%>trade/tradeListNo">订单列表</a>
                </dd>
                <!--<dd class="list-body"><a href="<%=basePath%>member/tradeFail">退货列表</a>
                </dd>-->
                <c:if test="${typeId ==1}"> 
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> 我的积分</dt>
                <dd class="list-body"><a href="<%=basePathwx%>person/creditsList">积分消费</a></dd>
                    </c:if>
            </dl>
           <c:if test="${typeId ==1}"> 
         <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> 维修管理</dt>
               <dd class="list-body"><a href="<%=basePathwx%>person/appointList">预约列表</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>person/repairList">维修诊断单</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>person/repairEntrust">维修委托书</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>person/repairAccounts">维修结算单</a></dd>
            </dl>
            <%--  <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">保险</a></dt>
                <dd class="list-body"><a href="<%=basePathwx%>html/member/insuranceList.jsp">保险列表</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>html/member/recordsList.jsp">赔付记录</a></dd>
            </dl> --%>
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> 车辆管理</dt>
                <dd class="list-body"><a href="<%=basePathwx%>person/carList">我的车辆</a></dd>
                <%-- <dd class="list-body"><a href="<%=basePathwx%>html/member/carAdd.jsp">添加车辆</a></dd> --%>
            </dl>
           </c:if> 
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span style="margin-left: -4px;"> 评论管理</span></dt>
                 <c:if test="${typeId !=2}"> 
                 <dd class="list-body"><a href="<%=basePathwx%>person/caigouComments">评论配件</a>
                 </dd>
                 </c:if>
               <%--  <c:if test="${typeId ==1}"> 
                <dd class="list-body"><a href="<%=basePathwx%>person/merchantComments">评论商家</a>
                </dd>
                </c:if> --%>
                <c:if test="${typeId ==1}">  
               <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> 我的收藏</dt>
                <dd class="list-body"><a href="<%=basePathwx%>person/myColGoods">商品列表</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>person/myColStore">店铺列表</a></dd>
            </dl>
            <%-- <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> <a href="javascript:;">我的问答</a></dt>
                <dd class="list-body"><a href="<%=basePathwx%>html/member/ask.jsp">我的提问</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>html/member/ans.jsp">我的回答</a></dd>
            </dl>  --%> 
             </c:if>   
          <c:if test="${typeId ==2}">
                <dd class="list-body"><a href="<%=basePath%>member/commentPeiJIanUserList">客户评论</a>
              <%--   <dd class="list-body"><a href="<%=basePath%>member/commentPeiJIanHuiFuList">回复列表</a> --%>
                
                </dd>
             </c:if>
            </dl>   
            <c:if test="${typeId ==1}"> 
            <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> 询价管理</dt>
                <dd class="list-body"><a href="<%=basePathwx%>person/askPrice">询价列表</a></dd>
            </dl>
            </c:if>
            <c:if test="${typeId ==2}">
              <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span><span style="margin-left: -4px;"> 站内信息</span></dt>
                <dd class="list-body"><a href="<%=basePath%>member/receiveBoxTest">收件箱</a></dd>
                <dd class="list-body"><a href="<%=basePath%>member/sendBoxLookTest">发件箱</a></dd>
            </dl> 
            </c:if> 
            <c:if test="${typeId ==1}">
           <dl class="child-list">
                <dt class="list-title"><span class="glyphicon glyphicon-plus-sign"></span> GPS</dt>
                <dd class="list-body"><a href="javascript:jumpuserCarLocation();">车辆定位</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>person/carTrackPlayback">轨迹回放</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>person/safeFindpc">报警设置</a></dd>
                <dd class="list-body"><a href="<%=basePathwx%>person/userCarMessageList">消息列表</a></dd>
            </dl>
            </c:if>
        </div>
    </div>
</div>

<script>
function jumpuserCarLocation(){

$.ajax({
		type : "POST",
		url : "<%=basePathwx%>person/getUserinfo",
		async : false,
		dataType : "html",
		success : successback,
		error : errorback
	});
	}
 function successback(data){
 window.location.href="<%=basePathwx%>html/member/carLocation.jsp";
}
function errorback() {
		alert("失败");		
	}
</script>