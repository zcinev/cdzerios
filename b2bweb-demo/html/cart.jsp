<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
<%@ include file="public/head2.jsp"%>
<%
SessionService sessionService = new BccSession();
String toShopping=sessionService.getAttribute(request, "toShopping");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <style>
.btn-danger{
  background-color:#ff9100;border-color: #ed8802;width: 80px;
  }
.btn-danger:hover{
color: white;
background-color:#FAB04E;
border-color: #FAB04E;
}

  </style> 
    <div class="container-fluid" style="margin-top:30px;">
        <div class="row">
            <div class="col-md-12 paddingLeft0 paddingRight0">
                <form action="<%=basePath%>pei/consignee" method="post" name="form1" onsubmit="return list()">
                    <table class="table" id="dpgltable">
                        <tr class="tr-title-border" style="border-top-color: #999;">
           				<th><span class="ck-all-box btn btn-default">全选</span><br />
						</th>    
						<th style="font-weight: normal;vertical-align:middle;">商家</th>                        
						<th style="width:30%;font-weight: normal;vertical-align:middle;">商品名称</th>
                            <th style="font-weight: normal;vertical-align:middle;">单价（元）</th>
                            <th style="font-weight: normal;vertical-align:middle;">数量</th>
                            <th style="font-weight: normal;vertical-align:middle;">金额（元）</th>
                            <th style="font-weight: normal;vertical-align:middle;">操作</th>
                        </tr>                
                    </table>
                    <div class="well well-sm">
                    <a   class="btn btn-default pull-left" id="cart_shop_id">全选</a>
							 <button type="button" class="btn btn-warning pull-left" onclick="javascript:delAll_0003();">删除选定</button>
                        <button type="submit" class="btn btn-warning pull-right" style="margin-left:10px;">去结算</button>
                        <a type="button" class="btn btn-default pull-right" href="<%=toShopping%>">继续购物</a> 
                        <div class="clearfix"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
 
 
<script>
$(document).ready(function() {
		 $('#cart_shop_id').click(function() { 
		if($(this).text() == '取消') {
			$(this).text('全选');
			$('.ck-item-box').iCheck('uncheck');
		} else if($(this).text() == '全选') {
			$(this).text('取消');
			$('.ck-item-box').iCheck('check');
		}
	});
	});
</script>
<script type="text/javascript">
 function delAll_0003(){
       
              var checkboxId=document.getElementsByName("checkid");
               var boxName="";
               for(var i=0;i<checkboxId.length;i++){
                      if(checkboxId[i].checked){
                        boxName=boxName+checkboxId[i].value+",";
                        
                      }
                      
                    
              }
              var user_name="<%=session.getAttribute("userName")%>";
              if(user_name!=null && user_name!="null" && user_name!=""){
               if(boxName.length>0){
                  var con=confirm("您确定要删除吗?");
                          if(con==true){
                        $.ajax({
            type: "GET", 
            data:{'id':boxName},
            url: "<%=basePath%>pei/delAllCart",
            async:false,
            dataType: "html",
            success: function() {
                window.location.href="<%=basePath%>pei/showCart";
             },
            error: function() {
            _this.text('请求失败');
            }
        });
        }else{
        return false;
        }
                 
              }else{
               alert("请至少勾选一条数据！");
               return false;
              }
             }else{
             alert("数据已过期,请从新登陆!");
             
             }
 
 }
</script>
<script type="text/javascript">
function  delList(){
     var con=confirm("您确定要删除吗?");
    if(con==true){
       return true;
    }else{
    return false;
    }
}
</script>
<%@ include file="public/foot.jsp"%>
<script>
	$(document).ready(function() {
		$('input').iCheck({
			checkboxClass : 'icheckbox_square-blue',
			radioClass : 'iradio_square-blue',
			increaseArea : '20%' // optional
		});
	});
	 //全选
 //全选
	
	$('.ck-all-box').click(function() {
		if($(this).text() == '取消') {
			$(this).text('全选');
			$('.ck-item-box').iCheck('uncheck');
		} else if($(this).text() == '全选') {
			$(this).text('取消');
			$('.ck-item-box').iCheck('check');
		}
	});

	//提示信息
	 function list() {
		 var chks=document.getElementsByTagName('input'); 
		 var bl=true; 
		 for(var i=0;i<chks.length;i++) {
		      if(chks[i].checked)      {     
		          bl=false;   
		                break; 
		                    } }  
		                    if(bl) {
		                     alert('请选择商品');
		                     return false;
		                    }else{
		                    return true;
		                    }
		                   
		                     } 

</script> 


<script>
	var jsonstr="[]";
	var jsonarray = eval('('+jsonstr+')');
	var bufferarray = eval('('+jsonstr+')');
	var shopname="";
</script>

<c:forEach var="mkey" items="${key}">
	<script>			
		var arr  =
		     {	"centerName" : "${mkey['centerName']}",
		         "shopname" : "${mkey['shopname']}",
		         "productImg":"${mkey['productImg']}",
		         "productName": "${mkey['productName']}",
		         "tprice" : "${mkey['tprice']}",
		         "buyCount":"${mkey['buyCount']}",
		         "subTotal": "${mkey['subTotal']}",
		         "id" : "${mkey['productId']}",
		          "stocknum" : "${mkey['stocknum']}"
		     	 	};
		jsonarray.push(arr);
	</script>
</c:forEach>
<script>
var dpgltable = document.getElementById("dpgltable");

while(jsonarray.length>0){
	bufferarray = eval('('+jsonstr+')');
	var tbody = document.createElement("tbody");
	if(jsonarray.length>0) shopname = jsonarray[0].centerName;
	var str1 = "<td  colspan=\"7\">"
	         + "<input type=\"button\"    name=\"order[]\" value=\"全选此商家订单\" class=\"btn btn-default\" />"
	         + "<label for=\"order1\">"+shopname+"</label>"
	         + "</td>";
	var trHead = document.createElement("tr");
	trHead.setAttribute("class", "tr-body-border");	
	trHead.innerHTML = str1;
 	trHead.childNodes[0].childNodes[0].onclick = function() {
 		if(this.value=="全选此商家订单"){
 			this.value="取消此商家订单";
 			$(this.parentNode.parentNode.parentNode).find(".ck-item-box").iCheck('check');
 		}else{
 			this.value="全选此商家订单";
 			$(this.parentNode.parentNode.parentNode).find(".ck-item-box").iCheck('uncheck');
 		}
 		
 	};
	tbody.appendChild(trHead);
	while(jsonarray.length>0){
		var jsonObject = jsonarray.pop();
		if(shopname==jsonObject.centerName) {
		    var str = "<span class=\"glyphicon glyphicon-minus\" onclick=\"partSub(this,'"+jsonObject.id+"')\"></span>"
            
            + "<input style='margin-top:5px;text-align:center;' type=\"text\" name=\"number1[]\" size=\"2\" value=\""+jsonObject.buyCount+"\" onkeyup=\"detailNumber(this,'"+jsonObject.stocknum+"','"+jsonObject.id+"');\" onblur=\"detailNumber(this,'"+jsonObject.stocknum+"','"+jsonObject.id+"');\" onpaste=\"return false\">"
             + "<span class=\"glyphicon glyphicon-plus\" onclick=\"partPlus(this,'"+jsonObject.stocknum+"','"+jsonObject.id+"')\"></span>";
            var name = jsonObject.productName;
             if (RegExp("GPS普通版").test(name)||RegExp("GPS/OBD版").test(name)||RegExp("GPS/OBD专业版").test(name)) {
            	 
                str="<span class=\"glyphicon glyphicon-minus\"></span>"
                	+"<input readonly='true' style='margin-top:5px;text-align:center;' type=\"text\" name=\"number1[]\" size=\"2\" value=\"1\" onkeyup=\"detailNumber(this,'"+jsonObject.stocknum+"','"+jsonObject.id+"');\" onblur=\"detailNumber(this,'"+jsonObject.stocknum+"','"+jsonObject.id+"');\" onpaste=\"return false\">"
                	+ "<span class=\"glyphicon glyphicon-plus\"></span>";
			}
	            var str2 = "<td style='vertical-align:middle;width:22px;height:22px;'>"
	                      + "<input type=\"checkbox\" class=\"ck-item-box\"  name=\"checkid\" id=\"order1\" value=\""+jsonObject.id+"\">" 
	                      + "</td>"
	                      + "<td style='vertical-align:middle; '>"
	                      + "<img src="+jsonObject.productImg+" style='width:50px;height:50px;' onclick=\"jumpProduct('"+jsonObject.id+"')\">"
	                      + "</td>"
	                      + "<td style='vertical-align:middle; '><h4 class=\"media-heading\"><a href=\"javascript:void(0)\" onclick=\"jumpProduct('"+jsonObject.id+"')\">"+jsonObject.productName+"<a></h4></td>"
	                      + "<td style='vertical-align:middle; '>"+jsonObject.tprice+"</td>"
	                      + "<td style='vertical-align:middle; '>"
	                      + "<p>"
	                       + 
	                     str
	                      + "</p>"
	                      + "</td>"
	                      + "<td style='vertical-align:middle; '>"+jsonObject.subTotal+"</td>"
	                      + "<td style='vertical-align:middle; '>"
	                      + "<a href=\"javascript:colGoods(jsonObject.id);\">收藏</a>"
	                      + "&nbsp;&nbsp;<a href=\"<%=basePath%>pei/delCart?id="+jsonObject.id+"\" onclick=\"return delList();\">删除</a>"
	                      + "</td>"; 
	         var trHtml = document.createElement("tr");
	         trHtml.setAttribute("class", "tr-body-border");
	         trHtml.innerHTML = str2;
	         tbody.appendChild(trHtml);
		}else{
			 bufferarray.push(jsonObject);
		}
	}
	dpgltable.appendChild(tbody);
	jsonarray = bufferarray;
}
</script> 

<script type="text/javascript">
	var strName = "<%=session.getAttribute("userName")%>";	
	var strId = "<%=session.getAttribute("id")%>";	
	var typeId = "<%=session.getAttribute("typeId")%>";	
	var dlyzc = document.getElementById("dlyzc");
	var str = "";
	var cart="";
	var tnum="0";
	if((strName==null)||(strName=="null")||(strName==""));
	else {
	
	  $.ajax({
            type: "POST",  
            data:{userName:strName},
            url: "<%=basePath%>pei/cartNumber",
            async:false,
            dataType: "json",
            success: function(data) {
            cart=data[0].len;
            tnum=data[0].num;
              },
            error: function() {
            alert('请求失败');
            }
        });	
	if(typeId=="1"){
			str ="<a href=\"<%=basePathwx%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\" target='_black'><img src='<%=basePath%>html/img/topmsg.png' style='margin-top: -3px;' > <span style='color: #777;'>消息</span><span style='color: red;'>"+tnum+"</span></a>"+
			"<a  href=\"<%=basePathwx%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> "
			+"<a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
 	}
	if(typeId=="2"){
			str = "<a href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\" target='_black'><img src='<%=basePath%>html/img/topmsg.png' style='margin-top: -3px;' > <span style='color: #777;'>消息</span><span style='color: red;'>"+tnum+"</span></a>"+
			" <a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
 	}
	if(typeId=="3"){

			str =	"<a href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\" target='_black'><img src='<%=basePath%>html/img/topmsg.png' style='margin-top: -3px;' > <span style='color: #777;'>消息</span><span style='color: red;'>"+tnum+"</span></a>"+
			 "<a  href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
 	}
 	if(typeId=="5"){
			str = " <a  href=\"<%=basePath%>purchase/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
 }
	if(typeId=="4"){
			str = " <a  href=\"<%=trafficPath%>manager/showIndex\">"+strName+" </a> <a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
 			}
 					dlyzc.innerHTML = str;
 			
 		}

</script>
<script>
function colGoods(id) {
	 $.ajax({
            type: "post",
            data:{id:id},
            url: "<%=basePath%>pei/colGoods",
            async:false,
            dataType: "html",
            success: function(data) {
            	  alert(data);
             
          
            },
            error: function() {
            alert("请求失败！");
            }
        });
	}
 
 
function partPlus(thisElem,obj,obj1){
	var price1=$(thisElem).parent().parent().prev().get(0).innerHTML;
	var price2=$(thisElem).parent().parent().next().get(0).innerHTML;
	
	var num1=$(thisElem).prev().get(0).value;
	
	
	if(num1==obj){
		return;
	}
	var num2=parseFloat(num1)+1;
	$(thisElem).prev().get(0).value=num2;
	
	var total=parseFloat(price2)+parseFloat(price1)+".00";
	$(thisElem).parent().parent().next().get(0).innerHTML=total;
	
	 $.ajax({
             type: "post",
             url: "<%=basePath%>pei/changeGoods",  
             async:false,           
             dataType: "html",
             data:{id:obj1,num:num2,total:total},
             success: function(data){
             },
             error: function(){
             }
         });  
}


function partSub(thisElem,obj1){

	var price1=$(thisElem).parent().parent().prev().get(0).innerHTML;
	var price2=$(thisElem).parent().parent().next().get(0).innerHTML;
	var num1=$(thisElem).next().get(0).value;
	if(num1==1){
	return;
	}
	var num2=parseFloat(num1)-1;
	$(thisElem).next().get(0).value=num2;
	var total=parseFloat(price2)-parseFloat(price1)+".00";
	$(thisElem).parent().parent().next().get(0).innerHTML=total;
	
	 $.ajax({
             type: "post",
             url: "<%=basePath%>pei/changeGoods",  
             async:false,           
             dataType: "html",
             data:{id:obj1,num:num2,total:total},
             success: function(data){
             },
             error: function(){
             }
         });  
}


function detailNumber(obj,obj1,obj2){
 	 var maxNumberStr=obj1;
	  var maxNumber=parseInt(maxNumberStr);
	  if(obj.value.length==1){
	  obj.value=obj.value.replace(/[^1-9]/g,1);
	  }else {
	  obj.value=obj.value.replace(/\D/g,'');
	  }
	  if(obj.value>maxNumber){
	      obj.value=maxNumber;
	      alert("商品数量超限！");
	  }
	  if(obj.value==""){
 	    obj.value=1;
	  }
	  
	var num=obj.value;
	var price1=$(obj).parent().parent().prev().get(0).innerHTML;
	var total=parseFloat(price1)*parseFloat(num)+".00";	
	$(obj).parent().parent().next().get(0).innerHTML=total;
	
	 $.ajax({
             type: "post",
             url: "<%=basePath%>pei/changeGoods",  
             async:false,           
             dataType: "html",
             data:{id:obj2,num:num,total:total},
             success: function(data){
             },
             error: function(){
             }
         });  
	}
	
	function jumpProduct(obj){
	if (obj=="PD141120094853302030") {
		window.location.href="<%=pathbase%>b2bweb-gold/index/detail?gnumber=PD141120094853302030";
	} else {
if (obj=="PD141120094853302029") {
			window.location.href="<%=pathbase%>b2bweb-gold/index/detail?gnumber=PD141120094853302029";
} else {
	if (obj=="PD141120094853302028") {
		window.location.href="<%=pathbase%>b2bweb-gold/index/detail?gnumber=PD141120094853302028";
	} else {
	if (obj=="PD141208165054998228") {
		window.location.href="<%=pathbase%>b2bweb-gold/index/detail?gnumber=PD141208165054998228";
	} else {
window.location.href="<%=basePath%>pei/jumpProduct?id="+obj;
	}
	}
}
	}
        
		<%-- window.location.href="<%=basePath%>pei/jumpProduct?id="+obj; --%>
	}
</script>

	