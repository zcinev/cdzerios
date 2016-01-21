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
.pagination .active a{
background-color: #ff4400;
border: #ff4400;
}
.pagination .active a:hover{
background-color: #E57850;
border: #ff4400;
}

.label-primary{
background-color: #ff4400;
border: #ff4400;
}
.pagination  li a{
color:#1D2F3F;
}
/* 搜索，全选，删除选定样式 */
.row input, .btn {
    border-radius: 0px;
}
</style>
<div class="container-fluid">
    <div class="row"><%--
        <%@ include file="../public/memberSidebar.jsp" %>
        --%><div class="col-md-12 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">会员中心
                        </li>
                        <li class="active">收货地址列表</li>
                    </ol>
                </div>
                
				<form class="form-inline" role="form" style="margin:10px;"
					id="searchForm" >
					<div class="form-group">
						<label class="sr-only" for="keyword">关键词</label> <select
							class="form-control" id="sel" onChange="chg()">
							<option value="txt">所在区域</option>
							<option value="btn">详细地址</option>
							<option value="nan">姓名</option>
						</select> <input type="text" class="form-control" id="keyword"
							placeholder="请输入你要搜索的内容" style="color:#A6A3A3;"> 
					</div>
					<button type="button" class="btn btn-primary" onclick="ssfun();" >搜索</button>
					<span style="margin-left:350px"><a href='javascript:;'  onclick="addAddress();"  style='text-decoration : underline; color: red;' >添加收货地址</a></span>
				</form>
                 <table class="table table-striped">
                    <tr></tr>
                    <tr>
                        <th style="width:10%">选中</th>
                        <th style="width:15%">姓名</th>
                        <th style="width:30%">所在区域</th>
                        <th style="width:30%">详细地址</th>
                        <th style="width:15%">管理操作</th>
                    </tr>
                     <tbody id="dpgltable"></tbody>
					<tbody>
						<tr>
							 <td colspan="5"><span class="ck-all-box btn btn-default">全选</span>
							 <button type="submit" class="btn btn-primary" onclick="javascript:delAll();" >删除选定</button>
							 </td>
						</tr>
					</tbody>
					<tr>

						<td colspan="9">
							<div>
								<form class="pager-form" role="form">
									<label style="font-weight: normal;">转到</label> <input id="zdid" type="text" style="height: 30px;border-radius:0px; "
										class="form-control" onblur="zdfun();"> <label style="font-weight: normal;">页</label>
								</form>
								<ul class="pager pull-right"
									style="margin-left:2px;margin-right:2px;">
									<li><a id="syy" style="border-radius:0px;">上一页</a>
									</li>
									<li><a id="xyy" style="border-radius:0px;">下一页</a>
									</li>
								</ul>
								 <span
									class="label label-primary pull-right label-page" style="border-radius:0px;font-weight: normal;">当前第<span
									id="dqdjy">5</span>页</span>
									<span class="label label-default pull-right label-page" style="background-color: #F5EFEF;color:#1D2F3F;font-weight: normal; ">共<span
									id="djy">20</span>页</span>
								<ul class="pagination pull-right">
									<li><a id="syyf" >&laquo;</a>
									</li>
									<li class="active"><a id="dqdjyf">1</a>
									<li class=""><a id="dqdjyf1">1</a>
									<li class=""><a id="dqdjyf2">1</a>
									<li class=""><a id="dqdjyf3">1</a></li>
									
									<li><a id="xyyf" >&raquo;</a>
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

<%@ include file="../public/foot3.jsp" %>
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
            url: "<%=basePath%>member/delAllListTest",
            async:false,
            dataType: "html",
            success: function() {
               alert("删除成功！");
               window.location.href="<%=basePath%>member/consigneeAddressList";
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
function addAddress(){
window.location.href="<%=basePath%>member/selectAddress";
}	
</script>
<script>
	var jsonstr="[]";
	var jsonarray = eval('('+jsonstr+')');
</script>

<c:forEach var="mkey" items="${key}">
	<script>			
  		var test="${mkey['status']}"; 
  		var teststr="";  
  		var testsh=""; 
		if(test==1) {teststr="<a href=\"<%=basePath%>member/setConsignee?id=${mkey['id']}\">设为默认地址</a>";}
		var arr  =
		     {             
		         "index" :"<input type=\"checkbox\" class=\"ck-item-box\" id=\"checkboxId\" name=\"checkboxId\" value=\"${mkey['id']}\">",
		         "name":"${mkey['name']}",
		         "sender" : "${mkey['provinceIdName']} ${mkey['cityIdName']} ${mkey['regionIdName']}",
		         "content":"${mkey['address']}",
		         "createTime": teststr,
		     	 "bj":"<a href=\"<%=basePath%>member/editConsignee?id=${mkey['id']}\">编辑</a>",
		     	 "sc":"&nbsp;&nbsp;<a href=\"<%=basePath%>member/delConsigneeTest?id=${mkey['id']}\" onclick=\"return delList();\">删除</a>"
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
				var trHtml = document.createElement("tr");
				$(trHtml).html("<td>"  
						+ jsonarray[i].index + "</td><td>" 
						+ jsonarray[i].name + "</td><td>"
						+ jsonarray[i].sender + "</td><td>"
						+ jsonarray[i].content+ "</td><td>"
						+ jsonarray[i].createTime
						+ jsonarray[i].bj + jsonarray[i].sc + "</td>");
				if ((jsonarray[i].sender).indexOf(keywordValue) >= 0) {
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
						+ jsonarray[i].index + "</td><td>" 
						+ jsonarray[i].name + "</td><td>"
						+ jsonarray[i].sender + "</td><td>"
						+ jsonarray[i].content+ "</td><td>"
						+ jsonarray[i].createTime
						+ jsonarray[i].bj + jsonarray[i].sc + "</td>");
				if ((jsonarray[i].content).indexOf(keywordValue) >= 0) {
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
				$(trHtml).html("<td>"  
						+ jsonarray[i].index + "</td><td>" 
						+ jsonarray[i].name + "</td><td>"
						+ jsonarray[i].sender + "</td><td>"
						+ jsonarray[i].content+ "</td><td>"
						+ jsonarray[i].createTime
						+ jsonarray[i].bj + jsonarray[i].sc + "</td>");
				if ((jsonarray[i].name).indexOf(keywordValue) >= 0) {
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
				+ jsonarray[i].index + "</td><td>" 
				+ jsonarray[i].name + "</td><td>"
				+ jsonarray[i].sender + "</td><td>"
				+ jsonarray[i].content+ "</td><td>"
				+ jsonarray[i].createTime
				+ jsonarray[i].bj + jsonarray[i].sc + "</td>");
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
		if (document.getElementById("sel").value == "nan") {
			selectcont = 2;
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

