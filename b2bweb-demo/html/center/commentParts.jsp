<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../public/mchead.jsp"%>

<input type="hidden" id="pageCount" value="${pageCount}" />
  <link rel="stylesheet"
	href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=basePath%>html/plugin/Picswitch/switch.css">
    <style type="text/css">
  .vote-star {
	display: inline-block; /*内联元素转换成块元素，并不换行 weisay.com*/
	margin-right: 6px;
 	width: 85px; /*5个星星的宽度 weisay.com*/
	height: 17px; /*1个星星的高度 weisay.com*/
	overflow: hidden;
	vertical-align: middle;
	background: url('<%=basePath%>html/images/star.gif') repeat-x 0 -17px;
}

.vote-star i{
	display: inline-block; /*内联元素转换成块元素，并不换行 weisay.com*/
	height: 17px; /*1个星星的高度 weisay.com*/
	background: url('<%=basePath%>html/images/star.gif') repeat-x 0 0;
}

tbody tr td{

width:13%;
}
.table-striped tr th{
text-align: left;
}
#dpgltable tr td{
text-align: left;
}
</style>
<script>
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
	function jump(s) {
	    var index=document.all('index').value; 
		$("#pageNo").val(index);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>


<div class="container-fluid">
	<div class="row">
		<%@ include file="../public/centerSidebar.jsp"%>
		<div class="col-md-10 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<ol class="breadcrumb bottom-spacing-0">
						<li class="active">评论管理</li>
						<li class="active">评论列表</li>
					</ol>
				</div>

				<form class="form-inline" role="form" style="margin:10px;"
					id="searchForm" >
					<div class="form-group">
						<label class="sr-only" for="keyword">关键词</label> <select
							class="form-control" id="sel" onChange="chg()">
							<option value="txt">配件名称</option>
							<option value="btn">评论者</option>
							<option value="plny">评论内容</option>
						</select> <input type="text" class="form-control" id="keyword"
							placeholder="请输入你要搜索的内容"> 
					</div>
					<button type="button" class="btn btn-primary" onclick="ssfun();">搜索</button>
				</form>

				<table class="table table-striped">
					<tr></tr>
					<tr>
						
                         <th>评论配件</th>
                          <th>评论者</th>
                        <th >星级</th>
                        <th>评论内容</th>
                        <th>评论时间</th>
                         <th>状态</th>
                        <th>操作</th>
					</tr>

                    <tbody id="dpgltable"></tbody>

                    <tr>

						<td colspan="9">
							<div>
								<form class="pager-form" role="form">
									<label>转到</label> <input id="zdid" type="text"
										class="form-control" onblur="zdfun();"> <label>页</label>
								</form>
								<ul class="pager pull-right"
									style="margin-left:2px;margin-right:2px;">
									<li><a id="syy">上一页</a>
									</li>
									<li><a id="xyy">下一页</a>
									</li>
								</ul>
								<span class="label label-default pull-right label-page">共<span
									id="djy">20</span>页</span> <span
									class="label label-primary pull-right label-page">当前第<span
									id="dqdjy">5</span>页</span>
								<ul class="pagination pull-right">
									<li><a id="syyf">&laquo;</a>
									</li>
									<li class="active"><a id="dqdjyf">1</a>
									<li class=""><a id="dqdjyf1">1</a>
									<li class=""><a id="dqdjyf2">1</a>
									<li class=""><a id="dqdjyf3">1</a></li>
									<li><a id="xyyf">&raquo;</a>
									</li>
								</ul>
							</div>
						</td>
					</tr>

				</table>

			</div>
		</div>
	</div>
</div>
<!-- 模态框（Modal）评论回复 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	回复评论
            </h4>
         </div>
        
         <div class="modal-body"  style="width:860px;">
         	<form class="form-horizontal" role="form" action=" " method="">
				       
				  <div class="form-group">
				    <label class="col-sm-2 control-label">评论内容：</label>
				    <div id="content" class="col-sm-10 form-inline" style="margin-top: 0.9%;">
				    </div>
				 </div>
				  <div class="form-group"    style="display: none;">
				    <label class="col-sm-2 control-label">id</label>
				    <input id="nameId" name="nameId" value="" class="col-sm-10 form-inline"  >
				  
 				 </div>
				 
				  <div class="form-group">
				    <label class="col-sm-2 control-label">回复信息：</label>
				    <div id="quantity" class="col-sm-10 form-inline" style="margin-top: 0.9%;">
				    <textarea rows="6" cols="60" id="CommentReply" placeholder="请输入回复内容！" maxlength="200"></textarea>
				    
				      <div id="replyContetnt"></div>
				    
				    </div>
				 </div>
				   
 			 </form>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default"  data-dismiss="modal" id="saveButton" onclick="return peiJianReceListDetail();">回复</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
         </div>
      </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<%@ include file="../public/foot3.jsp"%>

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
<script type="text/javascript">
	//确定回复
 	function peiJianReceListDetail(){
	    
 	var content=document.getElementById("CommentReply").value;
  	 var nameId=document.getElementById("nameId").value; 
  	  
 	      $.ajax({
            type: "GET",
            data:{'content':content,'id':nameId},
            url: "<%=basePath%>comment/peiJianCommentListDetail",
            async:false,
            dataType: "html",
            success: function(data) {
            alert("回复成功！");
            location.reload(true);
              },
            error: function() {

            }
        });
	 
	}
	
	</script>
<script> 
// 回复评论 显示页面内容
	function commentStoreLookReply(id){
	
 	      document.getElementById("CommentReply").value="";  
 	     $.ajax({
		     type : "POST",
		     url : "<%=basePath%>comment/commentPeiJianLookReply",
		     dataType : "json",
			 async : true,
		     data : {'id':id},
		     success : function(data){
		    
				var aa=document.getElementById("saveButton");
				var bb=document.getElementById("replyContetnt");
				var cc=document.getElementById("CommentReply");
				if(data[0].repplyContent!=""){
					
					document.getElementById("replyContetnt").innerHTML=data[0].repplyContent;
					bb.style.display="";
					aa.style.display="none";
					cc.style.display="none";
					
				}else{
					cc.style.display="";
					bb.style.display="none";
					aa.style.display="";
					document.getElementById("CommentReply").innerHTML="";
				}
					
		     		document.getElementById("content").innerHTML=data[0].content;
 		     		document.getElementById("nameId").value=data[0].nameId;
 		     	  
		     },
		     error : function(){
		     	alert('失败');
		     }
		 });
	 
	}
</script>
<script>
	var jsonstr="[]";
	var jsonarray = eval('('+jsonstr+')');
</script>
<c:forEach var="mkey" items="${key11}">
	<script>	
  		var teststr="";  
  		var testsh=""; 
  		if("${mkey['stateName']}"=="已回复"){
  			 testsh="<a  href='javascript:;'  onClick='javascript:commentStoreLookReply(\"${mkey['id']}\");' class='a_t_detailed' data-toggle='modal' data-target='#myModal' style='text-decoration :none;' >详细</a>&nbsp;<a  href=\"<%=basePath%>pei/detail?id=${mkey['productId']}#comments\"   title='查看配件信息'    target='blank'  >查看</a>";
  		}else{
  			 testsh="<a  href='javascript:;'  onClick='javascript:commentStoreLookReply(\"${mkey['id']}\");' class='a_t_detailed' data-toggle='modal' data-target='#myModal' style='text-decoration :none;' >回复</a>&nbsp;<a  href=\"<%=basePath%>pei/detail?id=${mkey['productId']}#comments\"   title='查看配件信息'    target='blank'  >查看</a>";
		}
		var arr  =
		     {
		         "productName":"${mkey['productName']}",
		         "supplierName" : "${mkey['reviewerName']}",
		         "rank":"${mkey['rank']}",
		         "content":"${mkey['content']}",
		         "createTime": "${mkey['createTime']}",
		          "stateName": "${mkey['stateName']}",
		     	 "bj":teststr,
		     	 "sc":testsh
		     	 	};
		jsonarray.push(arr);
	
	</script>
</c:forEach>
<script>
	//alert(jsonarray.length);
	var selectcont = 0;
	var databuffer = [];//数据缓存	
	function ssfun() {
		databuffer = [];//清空二级缓存
		var dpglCount = 0;
		buffercount = 0;
		var dpgltable = document.getElementById("dpgltable");
		var keywordElement = document.getElementById("keyword");
		var keywordValue = keywordElement.value;
		dpgltable.innerHTML = "";
		if (selectcont == 0) {
			for ( var i = 0; i < jsonarray.length; i++) {
				var contentStr=jsonarray[i].content;
				  if(contentStr.length>10){
				  contentStr=contentStr.substring(0,10)+"……";
				  }
				  var productNameStr=jsonarray[i].productName;
				  if(productNameStr.length>10){
				  productNameStr=productNameStr.substring(0,10)+"……";
				  }
				var	trHtml = "<tr><td title='"+jsonarray[i].productName+"'>"
						+ productNameStr + "</td><td>"
						 + jsonarray[i].supplierName +  
						"</td><td ><span class='vote-star'><i style='width:"+jsonarray[i].rank+"'></i></span></td><td title='"+jsonarray[i].content+"'>"
						 +contentStr+"</td><td>"
						+ jsonarray[i].createTime
						+ "</td><td>" + jsonarray[i].stateName+"</td><td>" + jsonarray[i].bj + jsonarray[i].sc + "</td></tr>";
				if ((jsonarray[i].productName).indexOf(keywordValue) >= 0) {
					if (buffercount < 10)
						$("#dpgltable").append(trHtml);
					databuffer.push(trHtml);//存入数据到缓存
					buffercount++;
				}
			}
		} 
		if (selectcont == 1) {
			for ( var i = 0; i < jsonarray.length; i++) {
				var contentStr=jsonarray[i].content;
				  if(contentStr.length>10){
				  contentStr=contentStr.substring(0,10)+"……";
				  }
				  var productNameStr=jsonarray[i].productName;
				  if(productNameStr.length>10){
				  productNameStr=productNameStr.substring(0,10)+"……";
				  }
								var	trHtml = "<tr><td title='"+jsonarray[i].productName+"'>"
						+ productNameStr + "</td><td>"
						 + jsonarray[i].supplierName +  
						"</td><td ><span class='vote-star'><i style='width:"+jsonarray[i].rank+"'></i></span></td><td title='"+jsonarray[i].content+"'>"
						 +contentStr+"</td><td>"
						+ jsonarray[i].createTime
						+ "</td><td>" + jsonarray[i].stateName+"</td><td>" + jsonarray[i].bj + jsonarray[i].sc + "</td></tr>";
				if ((jsonarray[i].supplierName).indexOf(keywordValue) >= 0) {
					if (buffercount < 10)
						$("#dpgltable").append(trHtml);
					databuffer.push(trHtml);//存入数据到缓存
					buffercount++;
				}
			}
		}
		if (selectcont == 2) {
			for ( var i = 0; i < jsonarray.length; i++) {
				var contentStr=jsonarray[i].content;
				  if(contentStr.length>10){
				  contentStr=contentStr.substring(0,10)+"……";
				  }
				   var productNameStr=jsonarray[i].productName;
				  if(productNameStr.length>10){
				  productNameStr=productNameStr.substring(0,10)+"……";
				  }
								var	trHtml = "<tr><td title='"+jsonarray[i].productName+"'>"
						+ productNameStr + "</td><td>"
						 + jsonarray[i].supplierName +  
						"</td><td ><span class='vote-star'><i style='width:"+jsonarray[i].rank+"'></i></span></td><td title='"+jsonarray[i].content+"'>"
						 +contentStr+"</td><td>"
						+ jsonarray[i].createTime
						+ "</td><td>" + jsonarray[i].stateName+"</td><td>" + jsonarray[i].bj + jsonarray[i].sc + "</td></tr>";
				if ((jsonarray[i].content).indexOf(keywordValue) >= 0) {
					if (buffercount < 10)
						$("#dpgltable").append(trHtml);
					databuffer.push(trHtml);//存入数据到缓存
					buffercount++;
				}
			}
		}
		

		bufferlength = databuffer.length;
		pagecount = 0;
		if (bufferlength % 10 == 0)
			pagecount = parseInt(bufferlength / 10);
		else
			pagecount = parseInt(bufferlength / 10) + 1;

		djy.innerHTML = pagecount;
		dqdjy.innerHTML = 1;
		dqdjyf1.parentNode.style.display = 'none';
		dqdjyf2.parentNode.style.display = 'none';
		dqdjyf3.parentNode.style.display = 'none';
		dqdjyf.innerHTML = 1;
		dqdjyf1.innerHTML = 1;
		dqdjyf1.innerHTML = 1;
		dqdjyf1.innerHTML = 1;
		if (dqdjyf.innerHTML < pagecount) {
			dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
			dqdjyf1.parentNode.style.display = '';
		}
		if ((parseInt(dqdjyf.innerHTML) + 1) < pagecount) {
			dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
			dqdjyf2.parentNode.style.display = '';
		}
		if ((parseInt(dqdjyf.innerHTML) + 2) < pagecount) {
			dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
			dqdjyf3.parentNode.style.display = '';
		}
	}

	dqdjyf = document.getElementById("dqdjyf");
	dqdjyf1 = document.getElementById("dqdjyf1");
	dqdjyf2 = document.getElementById("dqdjyf2");
	dqdjyf3 = document.getElementById("dqdjyf3");
	dqdjyf1.parentNode.style.display = 'none';
	dqdjyf2.parentNode.style.display = 'none';
	dqdjyf3.parentNode.style.display = 'none';
	var dpgltable = document.getElementById("dpgltable");
	var buffercount = 0;
	dpgltable.innerHTML = "";
	for ( var i = 0; i < jsonarray.length; i++) {
		var contentStr=jsonarray[i].content;
				  if(contentStr.length>10){
				  contentStr=contentStr.substring(0,10)+"……";
				  }
				  var productNameStr=jsonarray[i].productName;
				  if(productNameStr.length>10){
				  productNameStr=productNameStr.substring(0,10)+"……";
				  }
		var	trbuffer = "<tr><td title='"+jsonarray[i].productName+"'>"
						+ productNameStr + "</td><td>"
						 + jsonarray[i].supplierName +  
						"</td><td ><span class='vote-star'><i style='width:"+jsonarray[i].rank+"'></i></span></td><td title='"+jsonarray[i].content+"'>"
						 +contentStr+"</td><td>"
						+ jsonarray[i].createTime
						+ "</td><td>" + jsonarray[i].stateName+"</td><td>" + jsonarray[i].bj + jsonarray[i].sc + "</td></tr>";
		databuffer.push(trbuffer);//存入数据到缓存
		if (buffercount < 10)
			$("#dpgltable").append(trbuffer);
		buffercount++;
	}

	var bufferlength = databuffer.length;
	var pagecount = 0;
	if (bufferlength % 10 == 0)
		pagecount = parseInt(bufferlength / 10);
	else
		pagecount = parseInt(bufferlength / 10) + 1;

	var djy = document.getElementById("djy");
	var dqdjy = document.getElementById("dqdjy");
	djy.innerHTML = pagecount;
	dqdjy.innerHTML = 1;
	dqdjyf.innerHTML = 1;
	dqdjyf1.innerHTML = 1;
	dqdjyf1.innerHTML = 1;
	dqdjyf1.innerHTML = 1;
	if (dqdjyf.innerHTML < pagecount) {
		dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
		dqdjyf1.parentNode.style.display = '';
	}
	if ((parseInt(dqdjyf.innerHTML) + 1) < pagecount) {
		dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
		dqdjyf2.parentNode.style.display = '';
	}
	if ((parseInt(dqdjyf.innerHTML) + 2) < pagecount) {
		dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
		dqdjyf3.parentNode.style.display = '';
	}

	function zuoyifun() {
		if (parseInt(dqdjyf.innerHTML) - 4 > 0) {
			dqdjyf.parentNode.setAttribute("class", "");
			dqdjyf1.parentNode.setAttribute("class", "");
			dqdjyf2.parentNode.setAttribute("class", "");
			dqdjyf3.parentNode.setAttribute("class", "");
			dqdjyf.innerHTML = parseInt(dqdjyf.innerHTML) - 4;
			dqdjyf.parentNode.setAttribute("class", "active");
			zdymfun(dqdjyf.innerHTML);
			dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
			dqdjyf1.parentNode.style.display = '';
			dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
			dqdjyf2.parentNode.style.display = '';
			dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
			dqdjyf3.parentNode.style.display = '';
		}
	}

	function youyifun() {
		if (parseInt(dqdjyf.innerHTML) + 4 <= pagecount) {
			dqdjyf.parentNode.setAttribute("class", "");
			dqdjyf1.parentNode.setAttribute("class", "");
			dqdjyf2.parentNode.setAttribute("class", "");
			dqdjyf3.parentNode.setAttribute("class", "");
			dqdjyf.innerHTML = parseInt(dqdjyf.innerHTML) + 4;
			dqdjyf.parentNode.setAttribute("class", "active");
			zdymfun(dqdjyf.innerHTML);
			dqdjyf1.parentNode.style.display = 'none';
			dqdjyf2.parentNode.style.display = 'none';
			dqdjyf3.parentNode.style.display = 'none';
			if (dqdjyf.innerHTML < pagecount) {
				dqdjyf1.innerHTML = parseInt(dqdjyf.innerHTML) + 1;
				dqdjyf1.parentNode.style.display = '';
			}
			if ((parseInt(dqdjyf.innerHTML) + 1) < pagecount) {
				dqdjyf2.innerHTML = parseInt(dqdjyf1.innerHTML) + 1;
				dqdjyf2.parentNode.style.display = '';
			}
			if ((parseInt(dqdjyf.innerHTML) + 2) < pagecount) {
				dqdjyf3.innerHTML = parseInt(dqdjyf2.innerHTML) + 1;
				dqdjyf3.parentNode.style.display = '';
			}

		}
	}

	dqdjyf.onclick = function() {
		zdid.value = "";
		dqdjyf.parentNode.setAttribute("class", "active");
		dqdjyf1.parentNode.setAttribute("class", "");
		dqdjyf2.parentNode.setAttribute("class", "");
		dqdjyf3.parentNode.setAttribute("class", "");
		zdymfun(dqdjyf.innerHTML);
	};

	dqdjyf1.onclick = function() {
		zdid.value = "";
		dqdjyf.parentNode.setAttribute("class", "");
		dqdjyf1.parentNode.setAttribute("class", "active");
		dqdjyf2.parentNode.setAttribute("class", "");
		dqdjyf3.parentNode.setAttribute("class", "");
		zdymfun(dqdjyf1.innerHTML);
	};

	dqdjyf2.onclick = function() {
		zdid.value = "";
		dqdjyf.parentNode.setAttribute("class", "");
		dqdjyf1.parentNode.setAttribute("class", "");
		dqdjyf2.parentNode.setAttribute("class", "active");
		dqdjyf3.parentNode.setAttribute("class", "");
		zdymfun(dqdjyf2.innerHTML);
	};

	dqdjyf3.onclick = function() {
		zdid.value = "";
		dqdjyf.parentNode.setAttribute("class", "");
		dqdjyf1.parentNode.setAttribute("class", "");
		dqdjyf2.parentNode.setAttribute("class", "");
		dqdjyf3.parentNode.setAttribute("class", "active");
		zdymfun(dqdjyf3.innerHTML);
	};

	var zdid = document.getElementById("zdid");
	syy = document.getElementById("syy");
	syyf = document.getElementById("syyf");
	xyy = document.getElementById("xyy");
	xyyf = document.getElementById("xyyf");
	syy.onclick = function() {
		syyfun();
	};

	syyf.onclick = function() {
		zuoyifun();
	};

	function syyfun() {
		dqdjyf.parentNode.setAttribute("class", "");
		dqdjyf1.parentNode.setAttribute("class", "");
		dqdjyf2.parentNode.setAttribute("class", "");
		dqdjyf3.parentNode.setAttribute("class", "");
		zdid.value = "";
		var dpgltable = document.getElementById("dpgltable");
		var syycount = dqdjy.innerHTML;
		if (syycount == 1) {
			alert("已经是第一页");
		} else {
			syycount--;
			zdymfun(syycount);
		}
	}

	xyy.onclick = function() {
		xyyfun();
	};

	xyyf.onclick = function() {
		youyifun();
	};

	function xyyfun() {
		dqdjyf.parentNode.setAttribute("class", "");
		dqdjyf1.parentNode.setAttribute("class", "");
		dqdjyf2.parentNode.setAttribute("class", "");
		dqdjyf3.parentNode.setAttribute("class", "");
		zdid.value = "";
		var dpgltable = document.getElementById("dpgltable");
		var syycount = dqdjy.innerHTML;
		var djycount = djy.innerHTML;
		if (syycount == djycount) {
			alert("已经是最后一页");
		} else {
			syycount++;
			zdymfun(syycount);
		}
	}

	function zdymfun(syycount) {
		dqdjy.innerHTML = syycount;
		var xhcount = 0;
		dpgltable.innerHTML = "";
		for ( var i = (syycount - 1) * 10; i < databuffer.length; i++) {
			if (xhcount == 10)
				break;
			$("#dpgltable").append(databuffer[i]);
			xhcount++;
		}
	}

	function zdfun() {
		var zdvalue = zdid.value;
		var djycount = djy.innerHTML;
		if ((zdvalue <= djycount) && (zdvalue >= 1)) {
			zdymfun(zdvalue);
		} else {
			alert("页面输入超出范围");
		}

	}

	function chg() {
		if (document.getElementById("sel").value == "txt") {
			selectcont = 0;
		}
		if (document.getElementById("sel").value == "btn") {
			selectcont = 1;
		}
		if (document.getElementById("sel").value == "plny") {
			selectcont = 2;
		}
		
	}
	
	  $(function(){
        $('#keyword').bind('keypress',function(event){
            if(event.keyCode == "13")    
            {
                ssfun();
                 return false;
            }
        });
    });
</script>
<script>
$(function(){
	  $('#centerComment').css("color","#428BCA"); 
	 });
</script>
