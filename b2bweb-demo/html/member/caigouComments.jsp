<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../public/head3.jsp" %>
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
<style>
#dpgltable{
text-align: center;

}
.table tr th{
text-align: center;
}
</style>
  <link rel="stylesheet"
	href="<%=basePath%>html/plugin/FontAwesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=basePath%>html/plugin/Picswitch/switch.css">
<style>


.vote-star {
	display: inline-block; /*内联元素转换成块元素，并不换行 weisay.com*/
	margin-right: 6px;
	width: 85px; /*5个星星的宽度 weisay.com*/
	height: 15px; /*1个星星的高度 weisay.com*/
	overflow: hidden;
	vertical-align: middle;
	background: url('<%=basePath%>html/images/star.gif') repeat-x 0 -1px;
}

.vote-star i {
	display: inline-block; /*内联元素转换成块元素，并不换行 weisay.com*/
	height: 15px; /*1个星星的高度 weisay.com*/
	background: url('<%=basePath%>html/images/star.gif') repeat-x 0 0;
}

</style>
<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/memberSidebar.jsp" %>
         <div class="col-md-10 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">评论管理
                        </li>
                        <li class="active">评论配件</li>
                    </ol>
                </div>

				<form class="form-inline" role="form" style="margin:10px;"
					id="searchForm" action="<%=basePath%>purchase/storeList">
					<div class="form-group">
						<label class="sr-only" for="keyword">关键词</label> <select
							class="form-control" id="sel" onChange="chg()">
							<option value="txt">评论者</option>
							<option value="btn">评论内容</option>
						</select> <input type="text" class="form-control" id="keyword"
							placeholder="请输入你要搜索的内容"> <input id="pageNo"
							name="pageNo" type="hidden" value="${page.pageNo}" /> <input
							id="pageSize" name="pageSize" type="hidden"
							value="${page.pageSize}" />
					</div>
					<button type="button" class="btn btn-primary" onclick="ssfun();" >搜索</button>
				</form>

                <table class="table table-striped">
                    <tr></tr>
                    <tr>
                        <th style="width:5%">序号</th>
                        <th style="width:10%">被评论者</th>
                        <th style="width:18%">配件名称</th>
                        <th style="width:5%">星级</th>
                        <th style="width:10%">评论时间</th>
                        <th style="width:6%">操作</th>
                         
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
         <div class="modal-body">
         	<form class="form-horizontal" role="form" action=" " method="">
				       
				  <div class="form-group">
				    <label class="col-sm-2 control-label">评论内容</label>
				    <div id="content" class="col-sm-10 form-inline" style="margin-top: 0.9%;">
				    </div>
				 </div>
				  <div class="form-group" style="display: none;" >
				    <label class="col-sm-2 control-label">id</label>
				    <div id="nameId" class="col-sm-10 form-inline" style="margin-top: 0.9%;">
				    </div>
				 </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">回复：</label>
				    <div id="quantity" class="col-sm-10 form-inline" style="margin-top: 0.9%;">
				    <textarea rows="6" cols="60" id="CommentReply" ></textarea>
				    
				    </div>
				 </div>
				   
 			 </form>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default"  data-dismiss="modal"  onclick="return caigouCommentReply();">回复</button>
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
<script>
	var jsonstr="[]";
	var jsonarray = eval('('+jsonstr+')');
	var index = 1;
</script>
<c:forEach var="mkey" items="${key}">
	<script>	
  		var teststr=""; 
  		var supplier="${mkey['supplier']}"+"*"+"${mkey['productId']}"; 
  		var testsh="<a  href=\"javascript:judgeType('"+supplier+"');\" title='查看配件详情' >查看</a>";
 		var arr  = 
		     {   
		         "index" : index,
		         "nichen" : "${mkey['supplierName']}",
		         "partsName" : "${mkey['productName']}",
		         "rank" : "${mkey['rank']}",
		         "createTime": "${mkey['createTime']}",
		     	 "bj":teststr,
		     	 "sc":testsh
		     	 	};
		jsonarray.push(arr);
		index++;
	</script>
	
</c:forEach>
<script type="text/javascript">
//显示回复页面 内容
	function caigouCommentLookReply(id){
 	           
 	     $.ajax({
		     type : "POST",
		     url : "<%=basePathpj%>adv/caigouCommentsLookReply",
		     dataType : "json",
			 async : true,
		     data : {'id':id},
		     success : function(data){
		      
				for(var i=0; i<data.length; i++){
		     		document.getElementById("content").innerHTML=data[i].content;
		     		document.getElementById("nameId").innerHTML=data[i].nameId; 
 		     	}  
		     },
		     error : function(){
		     	alert('失败');
		     }
		 });
	 
	}
	
	</script>
	
	<script type="text/javascript">
	//确定回复
 	function caigouCommentReply(){
	 
 	var CommentReply=document.getElementById("CommentReply").value;
 	var nameId=document.getElementById("nameId").value;
 	 
 	      $.ajax({
            type: "GET",
            data:{content:CommentReply},
            url: "<%=basePathpj%>adv/caigouCommentsReply",
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
						 + jsonarray[i].nichen + "</td><td>"
						 + jsonarray[i].partsName +"</td><td ><span class='vote-star'><i style='width:"+jsonarray[i].rank+"'></i></span></td><td>"
						 + jsonarray[i].createTime + "</td><td>"
						  + jsonarray[i].bj + jsonarray[i].sc + "</td>";
				if ((jsonarray[i].nichen).indexOf(keywordValue) >= 0) {
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
						 + jsonarray[i].nichen + "</td><td>"
						 + jsonarray[i].partsName +"</td><td ><span class='vote-star'><i style='width:"+jsonarray[i].rank+"'></i></span></td><td>"
						 + jsonarray[i].createTime
						+ "</td><td>" + jsonarray[i].bj + jsonarray[i].sc + "</td>";
				if ((jsonarray[i].content).indexOf(keywordValue) >= 0) {
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
		var trbuffer = "<td>"
						+ jsonarray[i].index + "</td><td>"
						 + jsonarray[i].nichen + "</td><td>"
						 + jsonarray[i].partsName +"</td><td ><span class='vote-star'><i style='width:"+jsonarray[i].rank+"'></i></span></td><td>"+ jsonarray[i].createTime
						+ "</td><td>" + jsonarray[i].bj + jsonarray[i].sc + "</td>";
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
		if (djycount==0){
			alert("暂时还没有数据");
		}
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

	}
	
	function judgeType(obj){
	var obj1=obj.split("*")[0];
	var obj2=obj.split("*")[1];
	$.ajax({
            type: "POST",
			data:{id:obj1}, 
            url: "<%=basePath%>member/judgeType",
            async:false,
            dataType: "html",
            success: function(data) {
           	if(data=="2"){
           	window.open("<%=basePath%>pei/detail?id="+obj2);
           	//window.location.href="<%=basePath%>pei/detail?id="+obj2;
           	}
           	if(data=="3"){
           	window.open("<%=basePathwx%>store/maintainStoreMessage?id="+obj1);
           	//window.location.href="<%=basePathwx%>store/maintainStoreMessage?id="+obj1;
           	}
              },
            error: function() {
            alert("fail");
            }
        });	
	}
</script>
