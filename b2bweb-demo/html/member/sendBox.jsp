<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
.table-striped tr th{
text-align: center;
}
.table-striped tr td{
text-align: center;
}



</style>
<div class="container-fluid">
    <div class="row">
        <%--<%@ include file="../public/memberSidebar.jsp" %>
        --%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">站内信息
                        </li>
                        <li class="active">发件箱</li>
                    </ol>
                </div>

				<form class="form-inline" role="form" style="margin:10px;"
					id="searchForm" >
					<div class="form-group">
						<label class="sr-only" for="keyword">关键词</label> <select
							class="form-control" id="sel" onChange="chg()">
							<option value="txt">接收者</option>
							<option value="btn">内容</option>
						</select> <input type="text" class="form-control" id="keyword"
							placeholder="请输入你要搜索的内容"> 
					</div>
					<button type="button" class="btn btn-primary" onclick="ssfun();" >搜索</button>
				</form>

                <table class="table table-striped">
                    <tr></tr>
                    <tr>
                        <th>选择</th>
                        <th>接收者</th>
                        <th>内容</th>
                        <th>发送时间</th>
                        <th>操作</th>
                    </tr>
                    <tbody id="dpgltable"></tbody>
                    <!-- <tbody>
						<tr>
							 <td><span class="ck-all-box btn btn-default">全选</span>
							 <button type="submit" class="delete-all-box btn btn-primary">删除选定</button>
							 </td>
						</tr>
					</tbody> -->
                    <tr>

						<td colspan="5">
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
     <!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal" style="top:5%;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			   <div class="modal-dialog" style="width: 860px;">
			      <div class="modal-content" style="width: 860px;">
			         <div class="modal-header" style="width: 860px;">
			            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
			            </button>
			            <h4 class="modal-title" id="myModalLabel">
			               	发件箱信息查看
			            </h4>
			         </div>
			         <div class="modal-body" style="width: 860px;">
			         	<form class="form-horizontal" role="form">
							<div class="form-group">
							    <div class="col-sm-10 form-inline" style="margin-left: 5%;">
							    	<span style="margin-left: 10%;"><strong>接收者&nbsp;:&nbsp;</strong><span id="receiverName"></span></span>
							    </div>
							</div>
							<div class="form-group">
							    <div class="col-sm-10 form-inline" style="margin-left: 5%;">
							    	<span style="margin-left: 10%;"><strong>发信内容&nbsp;:&nbsp;</strong><span id="content"></span></span>
							    </div>
							</div>
							<div class="form-group">
								<div class="col-sm-10 form-inline" style="margin-left: 5%;">
							    	<span style="margin-left: 10%;"><strong>接收时间&nbsp;:&nbsp;</strong><span id="createTime"></span></span>
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

<%@ include file="../public/foot.jsp"%>
<script type="text/javascript">
function  delList(obj){
     var con=confirm("您确定要删除吗?");
    if(con==true){
                       $.ajax({
            type: "POST", 
            data:{'id':obj},
            url: "<%=basePath%>member/delsendBox",
            async:false,
            dataType: "html",
            success: function(data) {
               location.reload();
             },
            error: function() {
            alert('请求失败');
            }
            });
    }else{
    return false;
    }
}
</script>
<script>
	var jsonstr="[]";
	var jsonarray = eval('('+jsonstr+')');
	/* var index = 1; */
</script>
<c:forEach var="mkey" items="${key}">
	<script>	
  	
  		var teststr="<a href='javascript:;' data-toggle='modal' data-target='#myModal' onClick='senderDetail(\"${mkey['id']}\")'>查看</a>";  
  		 var testsh="<a href=\"javascript:void(0)\" onclick=\"delList('${mkey['id']}');\">删除</a>"; 
		
		var arr  =  
		     {
		         "index" :"<input type=\"checkbox\" class=\"ck-item-box\">",
		         "nichen" : "${mkey['receiverName']}",
		         "content":"${mkey['content']}",
		         "createTime": "${mkey['createTime']}",
		     	 "bj":teststr
		     	 
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
				$(trHtml).html("<td>"
						+ jsonarray[i].index + "</td><td>" + jsonarray[i].nichen + "</td><td style='max-width:200px;white-space: nowrap;text-overflow:ellipsis;overflow:hidden;text-align:left;'>"+ jsonarray[i].content+ "</td><td>"+ jsonarray[i].createTime
						+ "</td><td>" + jsonarray[i].bj  + "</td>");
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
				$(trHtml).html("<td>"
						+ jsonarray[i].index + "</td><td>" + jsonarray[i].nichen + "</td><td style='max-width:200px;white-space: nowrap;text-overflow:ellipsis;overflow:hidden;text-align:left;'>"+ jsonarray[i].content+ "</td><td>"+ jsonarray[i].createTime
						+ "</td><td>" + jsonarray[i].bj  + "</td>");
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
		$(trHtml).html("<td>"
				+ jsonarray[i].index + "</td><td>" + jsonarray[i].nichen + "</td><td style='max-width:200px;white-space: nowrap;text-overflow:ellipsis;overflow:hidden;text-align:left;'>"+ jsonarray[i].content+ "</td><td>"+ jsonarray[i].createTime
				+ "</td><td>" + jsonarray[i].bj  + "</td>");
		databuffer.push(trHtml.innerHTML);//存入数据到缓存
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
		if (syycount == djycount || djycount==0) {
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
			var trHtml ="<tr>"+databuffer[i]+"</tr>";
			$(dpgltable).append(trHtml);
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
</script>
<script>
 //全选
	$(document).ready(function() {
		 $('.ck-all-box').click(function() {
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
function senderDetail(obj){
	 
	$.ajax({
	     type : "POST",
	     url : "<%=basePath%>member/sendDetailTest",
	     dataType : "json",
		 async : true,
	     data : {id:obj},
	     success : function(data){
	     	document.getElementById("receiverName").innerHTML=data[0].receiverName;
 	     	document.getElementById("content").innerHTML=data[0].content;
	     	document.getElementById("createTime").innerHTML=data[0].createTime;
	     },
	     error : function(){
	    	 
	     	alert('失败');
	     }
	 });
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