 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="./public/head.jsp" %>
    <style>
    
#uldht li a{
/* color: #00a9ff; */

font-size: 14px;

}
.navbar-default .navbar-nav>li>a {
color: white;
}
#uldht li a:hover{
background-color: #195fa4;
color:white;
}
.pjimg .pull-left .media-object{

width: 162px;
height: 92px;}

    </style>
        <div class="container-fluid">
            <div class="row">
                <%@ include file="./public/sidebarLeft.jsp" %>

                    <div class="col-md-9 paddingLeft0 paddingRight0 pull-left">
                        <div class="width-auto banner">
                            <ul class="paddingLeft0" id="banner_img">
                            	<li><img width='100%' height='350' src='<%=basePath%>html/img/Engine.png' alt='图片'></li>	
                            </ul>
                        </div>
                     </div>
                      <div class="col-md-9 paddingLeft0 paddingRight0 pull-left">   
                    	<div  id="dpgltable">
                    	</div> 
                    	
                    	<div>
							<table>  
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
								
                   <%--  <%@ include file="./public/sidebarRight.jsp" %> --%>
            </div>
        </div>

        <div class="modal fade bs-example-xunjia-modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title">请填写联系方式</h4>
                    </div>
                    <form class="form-horizontal" action="#" role="form">
                    <div class="modal-body">
                        <p style="width:80%;margin:15px auto;">请您填写以下联系信息，我们的专业团队会及时给你答复</p>
                        <div style="width:80%;margin:15px auto;">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">联系人</label>
                                <div class="col-sm-9" >
                                    <input type="text" class="form-control" placeholder="联系人">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">手机号码</label>
                                <div class="col-sm-9">
                                    <input type="tel" class="form-control" placeholder="手机号码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">联系QQ</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" placeholder="qq">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">提交</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>        
 

        <%@ include file="./public/foot.jsp" %>
        
<script>
	var jsonstr="[]";
	var jsonarray = [];
</script>
<c:forEach var="mkey" items="${lkey2}">
	<script>	
     var  type_id="";
     var infoid="${mkey['infoid']}";
     if(infoid!=""){
     type_id="<a class=\"pull-left\" href=\"<%=basePath%>pei/product?id=${mkey['infoid']}\">";
     }else{
     type_id="<a class=\"pull-left\" href=\"<%=basePath%>pei/product?id=${mkey['id']}\">";
     }
	var arr  =  
                "<div class=\"panel-heading\">"
                +"<h3 class=\"panel-title\"> ${mkey['name']}</h3>"
                +"</div>"
                +"<hr style=\"margin:0;padding:0;\" />"
                +"<div class=\"panel-body media pjimg\">"                
                +type_id
                +"<img class=\"media-object\" src=\"${mkey['imgurl']}\" alt=\"...\" >"
                +"</a>"
                +"<div class=\"media-body\">"
                +"<span>&nbsp;</span>"
                +"<p>尺寸：${mkey['size']}</p>"
                +"<p>产品ID：${mkey['id']}</p>"
                +"</div>"
                +"</div>";
        
		jsonarray.push(arr);
	</script>
</c:forEach>  
<script>
	var selectcont = 0;
	var databuffer = [];//数据缓存
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
		var trHtml = document.createElement("div");
		trHtml.setAttribute("class", "panel");
		var trbuffer = jsonarray[i];
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
			var trHtml = document.createElement("div");
			trHtml.setAttribute("class", "panel");
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

	$(function(){
	
	var top=$("#uldht li a");
	top.click(function(){
	
	$(this).addClass("color","white").siblings().removeClass("thisClass");
	});
	});
</script>
<script>
var tname1="${partType}";

 $(function () {
 	if(tname1=="发动机"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/Engine.png' alt='图片'></li>";
 	}
 	if(tname1=="底盘"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/undercoating.png' alt='图片'></li>";
 	}
 	if(tname1=="车身及附件"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/bodyAccessories.png' alt='图片'></li>";
 	}
 	if(tname1=="电子、电器"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/Electronic.png' alt='图片'></li>";
 	}
 	if(tname1=="保养配件"){
 	$("#banner_img").get(0).innerHTML=" <li><img width='100%' height='350' src='<%=basePath%>html/img/saveAccessories.png' alt='图片'></li>";
 	}
});
</script>