<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../public/mchead.jsp" %>
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
.table tr th{
font-weight: normal;
}
</style>
<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/centerSidebar.jsp" %>
        <div class="col-md-10 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li class="active">首页
                        </li>
                        <li class="active">采购中心</li>
                    </ol>
                </div>
                <div style="padding:10px 0; background:#fefbe8; overflow:hidden;"> 
                    <div class="col-sm-2 paddingRight0">
                        <div id="baidumap" style="width:150px;height:150px;border:1px solid #ccc;">
							<img id="" src="/b2bweb-demo/html/img/upimg2.png" />
						</div> 
                    </div>
                    <div class="col-md-10" style="margin-top: 20px;">
                        <dl>
                            <dt>采购中心名称：${key['name']}</dt>
                            <dd>采购中心地址：<span style="color:#d60103;">${key['provinceName']} ${key['cityName']} ${key['address']}</span></dd>
                            <dd>上次登录时间：${loginTime}</dd>
                            
                        </dl>
                    </div>
                      <div class="col-md-2" style="position: absolute;left: 25%;top: 70px;">
                      <dl>
                      <dd><a href="<%=basePath%>purchase/receBox"><img class="media-object" src="<%=basePath%>html/img/huzx_033.png" alt="站内信" id="znx" ></a></dd>
                       <dd>站内信<span style="color:#d60103;"><a href="<%=basePath%>purchase/receiveBoxNoReadTest">（${MesLength}）</a></span></dd>
                       <dd style="padding-left:16px;"><a href="<%=basePath%>purchase/receiveBoxNoReadTest">未读</a></dd>
                      </dl>
                      </div>
                       <div class="col-md-2" style="position: absolute;left: 38%;top: 70px;">
                       <dl>
                       <dd><a href="<%=basePath%>purchase/storeList"><img class="media-object" src="<%=basePath%>html/img/dianpu-1_03.png" alt="店铺列表" id="znx" ></a></dd>
                       <dd>店铺列表<span style="color:#d60103;"><a href="<%=basePath%>purchase/storeList">（${PJSlength}）</a></span></dd>
                       <dd style="padding-left:16px;"><a href="<%=basePath%>purchase/storeList">未审核</a></dd>
                       
                       </dl>
                       </div>
                       <div class="col-md-2" style="position: absolute;left: 53%;top: 70px;">
                       <dl>
                   <dd ><a href="<%=basePath%>purchase/partsListNoTest"><img class="media-object" src="<%=basePath%>html/img/pejian-1_05.png"  alt="配件列表" id="dingdan"></a></dd>
                       <dd style="margin-left: -6px;">配件列表<span style="color:#d60103;"><a href="<%=basePath%>purchase/partsListNoTest">（${ProdLength}）</a></span></dd>
                       <dd style="padding-left:10px;"><a href="<%=basePath%>purchase/partsListNoTest">未审核</a></dd>
                        </dl>
                       </div>
                        <div class="col-md-2" style="position: absolute;left: 68%;top: 70px;">
                       <dl>
                 <dd ><a href="<%=basePath%>purchase/askPriceNoaudit"><img class="media-object" src="<%=basePath%>html/img/xunjia-1_07.png"  alt="询价列表" id="dingdan"></a></dd>
                       <dd style="margin-left: -6px;">询价列表<span style="color:#d60103;"><a href="<%=basePath%>purchase/askPriceNoaudit">（${XJLength}）</a></span></dd>
                       <dd style="padding-left:16px;"><a href="<%=basePath%>purchase/askPriceNoaudit">未回复</a></dd>
                        </dl>
                       </div>
                        <div class="col-md-2" style="position: absolute;left: 83%;top: 70px;">
                       <dl>
                <dd ><a href="<%=basePath%>purchase/tradeOkNopayment"><img class="media-object" src="<%=basePath%>html/img/huzx_055.png"  alt="订单列表" id="dingdan"></a></dd>
                       <dd style="margin-left: -6px;">订单列表<span style="color:#d60103;"><a href="<%=basePath%>purchase/tradeOkNopayment">（${MainLength}）</a></span></dd>
                       <dd style="padding-left:16px;"><a href="<%=basePath%>purchase/tradeOkNopayment">未付款</a></dd>
                        </dl>
                       </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span data-toggle="" data-target="">配件交易记录</span> 
                 </div>
                 
              <c:if test="${mainorder=='Y10011'}">
              <div id="" class="">
                <table class="table table-striped"   >
                    <tr></tr>
                    <tr>
                        <th>订单号</th>
                        <th>买家</th>
                        <th>价格</th>
                        <th>付款状态</th>
                        <th>时间</th>
                        <th>查看</th>
                    </tr>
                    <tbody id="dpgltable"></tbody>
                      <tr   id="demo" class="collapse">

						<td colspan="6" data-toggle="collapse">
							<div >
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
                 <!-- 不分页一个页面拉的太长 不好看 分页了 有分页机制显示
                                                                  与页面不协调 所以隐藏起来2015-01-06 -->
                   <div align="center">
                    <button id="nextPaging" type="button" class="btn" style="color: #0099FF;" data-toggle="collapse" data-target="#demo">显示页数</button>
                   </div>
                 </div>
                 
                </c:if>
                <c:if test="${mainorder=='N10010'}">
                               <div>您还没有任何交易记录！</div>   
                </c:if>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span>评价记录</span>
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
                    <c:forEach var="mkey" items="${comKey}" >
                    <tr>
                      <td>${mkey['productName']} </td>
						<td>${mkey['reviewerName']} </td>
 					<td ><span class='vote-star'><i style="width:${mkey['rank']}  "></i></span></td> 
						<td>${mkey['content']} 	</td>
						<td>${mkey['createTime']}</td>
                    </tr>
                    </c:forEach>
                    
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../public/foot3.jsp" %>
<script>
	var jsonstr="[]";
	var jsonarray = eval('('+jsonstr+')');
 </script>
<c:forEach var="mkey" items="${orderKey}">
	<script>	
  		var teststr="<a href='<%=basePath%>purchase/orderDetail?mainOrderId=${mkey['orderMainId']}' class='a_t_detailed' target='black'>详细</a>";  
 		var arr  =
		     {
		        "mainOrderId" : "${mkey ['mainOrderId']}",
		         "buyerName" : "${mkey['buyerName']}",
		         "goodsSumPrice":"${mkey['goodsSumPrice']}",
		         "stateName": "${mkey['stateName']}",
		          "addTime":"${mkey['addTime']}",
		     	 "bj":teststr
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
				var trHtml = "<tr><td>"
						+ jsonarray[i].mainOrderId + "</td><td>" 
						+ jsonarray[i].buyerName + "</td><td>"
						+ jsonarray[i].goodsSumPrice+ "</td><td>"
						+ jsonarray[i].stateName + "</td><td>"
						+ jsonarray[i].addTime + "</td><td>"
						 + jsonarray[i].bj + "</td></tr>";
				if ((jsonarray[i].mainOrderId).indexOf(keywordValue) >= 0) {
					if (buffercount < 5)
						$("#dpgltable").append(trHtml);
					databuffer.push(trHtml);//存入数据到缓存
					buffercount++;
				}
			}
		} 
		if (selectcont == 1) {
			for ( var i = 0; i < jsonarray.length; i++) {
				var trHtml = document.createElement("tr");
				var trHtml = "<tr><td>"
						+ jsonarray[i].mainOrderId + "</td><td>" 
						+ jsonarray[i].buyerName + "</td><td>"
						+ jsonarray[i].goodsSumPrice+ "</td><td>"
						+ jsonarray[i].stateName + "</td><td>"
						+ jsonarray[i].addTime + "</td><td>"
						 + jsonarray[i].bj + "</td></tr>";
				if ((jsonarray[i].buyerName).indexOf(keywordValue) >= 0) {
					if (buffercount < 5)
						$("#dpgltable").append(trHtml);
					databuffer.push(trHtml);//存入数据到缓存
					buffercount++;
				}
			}
		}
		

		bufferlength = databuffer.length;
		pagecount = 0;
		if (bufferlength % 5 == 0)
			pagecount = parseInt(bufferlength / 5);
		else
			pagecount = parseInt(bufferlength / 5) + 1;

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
		var trbuffer =  "<tr><td>"
						+ jsonarray[i].mainOrderId + "</td><td>" 
						+ jsonarray[i].buyerName + "</td><td>"
						+ jsonarray[i].goodsSumPrice+ "</td><td>"
						+ jsonarray[i].stateName + "</td><td>"
						+ jsonarray[i].addTime + "</td><td>"
						 + jsonarray[i].bj + "</td></tr>";
		databuffer.push(trbuffer);//存入数据到缓存
		if (buffercount < 5)
			$("#dpgltable").append(trbuffer);
		buffercount++;
	}

	var bufferlength = databuffer.length;
	var pagecount = 0;
	if (bufferlength % 10 == 0)
		pagecount = parseInt(bufferlength / 5);
	else
		pagecount = parseInt(bufferlength / 5) + 1;

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
		for ( var i = (syycount - 1) * 5; i < databuffer.length; i++) {
			if (xhcount == 5)
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

		
	}
</script>
<script>
  $(document).ready(function(){
    $("#nextPaging").click(function(){
      if($("#nextPaging").html()=='显示页数'){
     $("#nextPaging").text('隐藏页数'); 
     }else{
       if($("#nextPaging").html()=='隐藏页数'){
        $("#nextPaging").text('显示页数'); 
       }
     }
    });
  });
</script>