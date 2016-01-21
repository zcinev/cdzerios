<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../public/head3.jsp"%>

<input type="hidden" id="pageCount" value="${pageCount}" />

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
</style>

<div class="container-fluid">
	<div class="row">
		<%@ include file="../public/centerSidebar.jsp"%>
		<div class="col-md-10 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<ol class="breadcrumb bottom-spacing-0">
						<li><a href="#">评论管理</a></li>
						<li class="active">采购中心评论</li>
					</ol>
				</div>

				<form class="form-inline" role="form" style="margin:10px;"
					id="searchForm" action="<%=basePath%>purchase/storeList">
					<div class="form-group">
						<label class="sr-only" for="keyword">关键词</label> <select
							class="form-control" id="sel" onChange="chg()">
							<option value="txt">配件名称</option>
							<option value="btn">回复商家</option>
							<option value="plny">回复内容</option>
						</select> <input type="text" class="form-control" id="keyword"
							placeholder="请输入你要搜索的内容"> <input id="pageNo"
							name="pageNo" type="hidden" value="${page.pageNo}" /> <input
							id="pageSize" name="pageSize" type="hidden"
							value="${page.pageSize}" />
					</div>
					<button type="button" class="btn btn-primary" onclick="ssfun();">搜索</button>
				</form>
                    
				<table class="table table-striped">
					<tr></tr>
					<tr>
						<th>序号</th>
						<th>配件名称</th>
						<th>接受者</th>
						<th>回复内容</th>
						<th>回复时间</th>
						<th></th>
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
            alert("发送成功！");
              return true;
              },
            error: function() {
                 return false;
            _this.text('请求失败');
            }
        });
	 
	}
	
	</script>
<script> 
// 回复评论 显示页面内容
	function commentStoreLookReply(id){
 	            
 	     $.ajax({
		     type : "POST",
		     url : "<%=basePath%>comment/commentPeiJianLookReply",
		     dataType : "json",
			 async : true,
		     data : {'id':id},
		     success : function(data){
		      
				for(var i=0; i<data.length; i++){
		     		document.getElementById("content").innerHTML=data[i].content;
 		     		document.getElementById("nameId").value=data[i].sender;
 		     		  
 		     	}  
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
	var index = 1;
</script>
<c:forEach var="mkey" items="${key}">
	<script>	
  	
  		var teststr="";  
  		var testsh=" <a  href=\"<%=basePath%>pei/detail?id=${mkey['productId']}\"   title='查看配件信息'     target='blank' >&nbsp;&nbsp;查看</a>";
		
		var arr  =
		     {
		         "index" : index,
		         "productName" : "${mkey['productName']}",
		         "parentId":"${mkey['supplierName']}",
		         "Content":"${mkey['content']}",
		         "createTime": "${mkey['replyTime']}",
		     	 "bj":teststr,
		     	 "sc":testsh
		     	 	};
		jsonarray.push(arr);
		index++;
	</script>
</c:forEach>
<script>
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
				var trHtml = document.createElement("tr");
				trHtml.innerHTML = "<td>"
						+ jsonarray[i].index + "</td><td>"
						+ jsonarray[i].productName + "</td><td>"
						 + jsonarray[i].parentId + "</td><td>"
						 +jsonarray[i].Content+"</td><td>"
						+ jsonarray[i].createTime+ "</td><td>" 
						+ jsonarray[i].bj+ "</td><td>" + jsonarray[i].sc + "</td>";
				 
				if ((jsonarray[i].productName).indexOf(keywordValue) >= 0) {
					if (buffercount < 10)
						dpgltable.appendChild(trHtml);
					databuffer.push(trHtml.innerHTML);//存入数据到缓存
					buffercount++;
				}
			}
		} 
		if (selectcont == 1) {
			for ( var i = 0; i < jsonarray.length; i++) {
				var trHtml = document.createElement("tr");
			trHtml.innerHTML = "<td>"
						+ jsonarray[i].index + "</td><td>"
						+ jsonarray[i].productName + "</td><td>"
						 + jsonarray[i].parentId + "</td><td>"
						 +jsonarray[i].Content+"</td><td>"
						+ jsonarray[i].createTime+ "</td><td>" 
						+ jsonarray[i].bj+ "</td><td>" + jsonarray[i].sc + "</td>";
				if ((jsonarray[i].parentId).indexOf(keywordValue) >= 0) {
					if (buffercount < 10)
						dpgltable.appendChild(trHtml);
					databuffer.push(trHtml.innerHTML);//存入数据到缓存
					buffercount++;
				}
			}
		}
		if (selectcont == 2) {
			for ( var i = 0; i < jsonarray.length; i++) {
				var trHtml = document.createElement("tr");
				trHtml.innerHTML = "<td>"
						+ jsonarray[i].index + "</td><td>"
						+ jsonarray[i].productName + "</td><td>"
						 + jsonarray[i].parentId + "</td><td>"
						 +jsonarray[i].Content+"</td><td>"
						+ jsonarray[i].createTime+ "</td><td>" 
						+ jsonarray[i].bj+ "</td><td>" + jsonarray[i].sc + "</td>";
				if ((jsonarray[i].Content).indexOf(keywordValue) >= 0) {
					if (buffercount < 10)
						dpgltable.appendChild(trHtml);
					databuffer.push(trHtml.innerHTML);//存入数据到缓存
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
		var trHtml = document.createElement("tr");
		var trbuffer =  "<td>"
						+ jsonarray[i].index + "</td><td>"
						+ jsonarray[i].productName + "</td><td>"
						 + jsonarray[i].parentId + "</td><td>"
						 +jsonarray[i].Content+"</td><td>"
						+ jsonarray[i].createTime+ "</td><td>" 
						+ jsonarray[i].bj+ "</td><td>" + jsonarray[i].sc + "</td>";
		trHtml.innerHTML = trbuffer;
		databuffer.push(trbuffer);//存入数据到缓存
		if (buffercount < 10)
			dpgltable.appendChild(trHtml);
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
			var trHtml = document.createElement("tr");
			dpgltable.appendChild(trHtml);
			trHtml.innerHTML = databuffer[i];
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
</script>