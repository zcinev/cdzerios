<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/head3.jsp"%>
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
.table tr th{
font-weight: normal;
}
#dpgltable tr td{
width:90px;
}
</style>
<div class="container-fluid">
	<div class="row">
		<%--<%@ include file="../public/memberSidebar.jsp"%>
		--%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<ol class="breadcrumb bottom-spacing-0">
						<li class="active">产品管理</li>
						<li class="active">配件列表</li>
					</ol>
				</div>

				<form class="form-inline" role="form" style="margin:10px;"
					id="searchForm" >
					<div class="form-group">
						<label class="sr-only" for="keyword">关键词</label> <select
							class="form-control" id="sel" onChange="chg()">
							<option value="txt">商品名称</option>
							<option value="btn">商品分类</option>
						</select> <input type="text" class="form-control" id="keyword"
							placeholder="请输入你要搜索的内容"> 
					</div>
					<button type="button" class="btn btn-primary" onclick="ssfun();" >搜索</button>
					 					 <span style="margin-left:385px"><a href='javascript:;'  onclick="productsAddList();"  style='text-decoration : underline; color: red;' >添加配件</a></span>
					 
				</form>

				<table class="table table-striped">
					<tr>
						<th width="10px">选中</th>
						<th>图片</th>
						<th>商品名称</th>
						<th>会员价格</th>
						<th>市场价格</th>
						<th>库存</th>
						<th>商品分类</th>
						<th>添加时间</th>
						<th>状态</th>
						<th>管理操作</th>
					</tr>
					<tbody id="dpgltable"></tbody>
					<tbody>
						<tr>
							<td colspan="10"><span class="ck-all-box btn btn-default">全选</span>
								<button type="submit" class="delete-all-box btn btn-primary"
								onclick="return delAll();" >删除选定</button>
							</td>
						</tr>
					</tbody>

					<tr>

						<td colspan="10">
							<div>
								<form class="pager-form" role="form">
									<label>转到</label> <input id="zdid" type="text"
										class="form-control" onblur="zdfun();"> <label>页</label>
								</form>
								<ul class="pager pull-right"
									style="margin-left:2px;margin-right:2px;">
									<li><a id="syy">上一页</a></li>
									<li><a id="xyy">下一页</a></li>
								</ul>
								<span class="label label-default pull-right label-page">共<span
									id="djy">20</span>页</span> <span
									class="label label-primary pull-right label-page">当前第<span
									id="dqdjy">5</span>页</span>
								<ul class="pagination pull-right">
									<li><a id="syyf">&laquo;</a></li>
									<li class="active"><a id="dqdjyf">1</a>
									<li class=""><a id="dqdjyf1">1</a>
									<li class=""><a id="dqdjyf2">1</a>
									<li class=""><a id="dqdjyf3">1</a>
									</li>
									<li><a id="xyyf">&raquo;</a></li>
								</ul>
							</div></td>
					</tr>

				</table>
			</div>
		</div>
	</div>
</div>

<%@ include file="../public/foot.jsp"%>
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
function productsAddList(){
window.location.href="<%=basePath%>member/productsAddList";
}	
</script>
<script type="text/javascript">
 function delAll(){
               var checkboxId=document.getElementsByName("checkboxId");
               var boxName="";
               for(var i=0;i<checkboxId.length;i++){
                      if(checkboxId[i].checked){
                        boxName=boxName+checkboxId[i].value+",";
                       }
                }
                if(boxName.length>0){
                         var con=confirm("您确定要删除吗?");
                          if(con==true){
                            $.ajax({
            type: "GET", 
            data:{'boxName':boxName},
            url: "<%=basePath%>member/delPeiJianListTest",
            async:false,
            dataType: "html",
            success: function() {
               alert("删除成功！");
               window.location.href="<%=basePath%>member/productsLookTest";
             },
            error: function() {
            _this.text('请求失败');
            }
        });
                          }
                       
               }else{
               alert("请至少勾选一条数据！");
               return false;
              }
             
 
 }
</script>
<script>
	var jsonstr="[]";
	var jsonarray = eval('('+jsonstr+')');
</script>
<c:forEach var="mkey" items="${key}">
	<script>	
	 
  		var test="${mkey['stateName']}"; 
  		var teststr="";  
  		var testsh="";
		if(test=="未审核") {
		teststr="未审核";testsh="<a href=\"<%=basePath%>member/updateProductsTest?id=${mkey['id']}&number=${mkey['number']}\">编辑</a>";
		}
		if(test=="审核通过"){
		teststr="审核通过";testsh="<a href=\"<%=basePath%>member/updateProductsTest1?id=${mkey['id']}&number=${mkey['number']}\">查看</a>";
		} 
		if(test=="未通过"){
		 teststr="未通过";testsh="<a href=\"<%=basePath%>member/updateProductsTest?id=${mkey['id']}&number=${mkey['number']}\">编辑</a>";
		} 
		var arr  =  
		 
		     {
				 "index" :"<input type=\"checkbox\" class=\"ck-item-box\" id=\"checkboxId\" name=\"checkboxId\" value=\"${mkey['id']}\">",
		         "picture" : "<img src=\"${mkey['picture']}\" width=\"60\" height=\"50\">",
		         "autopartinfo":"${mkey['name']}",
		         "memberprice": "${mkey['memberprice']}",
		          "marketprice": "${mkey['marketprice']}",
                 "stocknum": "${mkey['stocknum']}",
                 "autopartlist":"${mkey['autoparttypeName']}",
		     	 "addtime":"${mkey['addtime']}",		     	 
		     	 "status":teststr,
		     	 "bj":testsh,
		     	 "sc":"<a href=\"<%=basePath%>member/delProductsTest?id=${mkey['id']}\" onclick=\"return delList();\">删除</a>"
		     	 	};
		jsonarray.push(arr);
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
			
				var trHtml = "<tr><td>"+ jsonarray[i].index + "</td><td>"
						+ jsonarray[i].picture + "</td><td>"+ jsonarray[i].autopartinfo + "</td><td>"+ jsonarray[i].memberprice
						+ "</td><td>" + jsonarray[i].marketprice+ "</td><td>" + jsonarray[i].stocknum+ "</td><td>" + jsonarray[i].autopartlist+ "</td><td>" + jsonarray[i].addtime + "</td><td>"
						+ jsonarray[i].status + "</td><td>" + jsonarray[i].bj
						+ jsonarray[i].sc + "</td></tr>";
				if ((jsonarray[i].autopartinfo).indexOf(keywordValue) >= 0) {
					if (buffercount < 10)
						$("#dpgltable").append(trHtml);
					databuffer.push(trHtml);//存入数据到缓存
					buffercount++;
				}
			}
		} 
		if (selectcont == 1) {
			for ( var i = 0; i < jsonarray.length; i++) {
				
			var	trHtml = "<tr><td>"+ jsonarray[i].index + "</td><td>"
						+ jsonarray[i].picture+ "</td><td>"+ jsonarray[i].autopartinfo + "</td><td>"+ jsonarray[i].memberprice
						+ "</td><td>" + jsonarray[i].marketprice+ "</td><td>" + jsonarray[i].stocknum+ "</td><td>" + jsonarray[i].autopartlist+ "</td><td>" + jsonarray[i].addtime + "</td><td>"
						+ jsonarray[i].status + "</td><td>" + jsonarray[i].bj
						+ jsonarray[i].sc + "</td></tr>";
				if ((jsonarray[i].autopartlist).indexOf(keywordValue) >= 0) {
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
		
		var trbuffer = "<tr><td>"+ jsonarray[i].index + "</td><td>"
						+ jsonarray[i].picture + "</td><td>"+ jsonarray[i].autopartinfo + "</td><td>"+ jsonarray[i].memberprice
						+ "</td><td>" + jsonarray[i].marketprice+ "</td><td>" + jsonarray[i].stocknum+ "</td><td>" + jsonarray[i].autopartlist+ "</td><td>" + jsonarray[i].addtime + "</td><td>"
						+ jsonarray[i].status + "</td><td>" + jsonarray[i].bj
						+ jsonarray[i].sc + "</td></tr>";
		
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
				
				var trHtml = databuffer[i];
				$("#dpgltable").append(trHtml);
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
	 //全选
 //全选
	
	
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
