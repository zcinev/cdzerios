<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/mchead.jsp" %>
<style>
.td-black{
font-weight: normal;

}
.tr-active{
background-color: #ecf9ff;
}
.qtb > tbody > tr > td{
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
                        <li class="active">询价列表
                        </li>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered qtb" style="width:100%;margin:20px auto;border:1px solid #ccc;">
                                    
                                    <tr class="active">
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
                                                <dt><a href="<%=basePath%>pei/product?id=${key.id}"><img src="${key.imgurl}" alt="图片" width="80px" height="80px"></a></dt>
                                            </dl>
                                        </td>
                                      
                                        <td class="text-center">
                                           <a href="<%=basePath%>pei/product?id=${key.id}">${key.productName}</a>
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
                                    <tr>
                                    	<td class="td-black text-center">回复内容</td>
                                    	<td colspan="5" class="text-left">
                                           ${key.replyContent}
                                        </td>
                                    </tr>
                                    <tbody>
                                       <tr>
                                       <td colspan="6" class="text-center">
                                       <a href="<%=basePath%>purchase/askPrice" class="btn btn-primary" role="button">返回</a>
                                       </td>
                                       </tr>
                                    </tbody>
                                </table>
                                
                                <%-- <form class="form-horizontal" role="form"  action="<%=basePath%>purchase/replyPrice" method="post" onsubmit="return checkInput();">
                                <input type="hidden" name="id" value="${key.id}">
                                 <input type="hidden"  name="tel"  value="${key.tel}">
			                        <div class="form-group">
			                            <label class="col-sm-2 control-label">回复</label>
			                            <div class="col-sm-10 form-inline">
			                                <textarea id="content" name="content" class="form-control" style="width:90%;" rows="10" placeholder="暂时还没有对该商品的询价进行回复"></textarea>
			                            </div>
			                        </div>
			                        <div class="form-group">
			                            <div class="col-sm-offset-2 col-sm-10">
			                                <button type="submit" class="btn btn-primary">提交</button>
			                                <a href="<%=basePath%>purchase/askPrice" class="btn btn-primary" role="button">返回</a>
			                            </div>
			                        </div>
			                    </form> --%>
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <%@ include file="../public/foot.jsp" %>
        <script>
        $(document).ready(function () { 
	        getSelect("<%=basePath%>");
	         distSelect("<%=basePath%>");
	        detailAddress("<%=basePath%>");
	    });
    	<%-- function successback(data) {
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
   } --%>
 
</script>
        
