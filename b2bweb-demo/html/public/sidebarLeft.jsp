<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.bc.localhost.*"%>
<%-- <%
String path2 = "/b2bweb-gold";
String basePath2 = BccHost.getHost()+path2+"/";
 %> --%>
<style>
h3 {
	text-align: left;
	padding-left: 18px;
	color: #00a9ff;
}

.panel-title {
	margin-left: -13px;
}

a.list-group-item:hover,a.list-group-item:focus {
	color: #333;
}

.navbar-default {
	border-color: #ddd;
}

.list-group-item {
	min-height: 90px;
}
</style>
<div class="col-md-3 paddingLeft0 pull-left">
	<div class="panel panel-primary"
		style="border-color: #00A9FF;height: 350px;">
		<div class="panel-heading"
			style="background-color: #00a9ff;color: #FFF;border-color: #ddd;">
			<!-- 如果是一级分类，这个panel－title就显示全部分类，如果是二级分类，就显示二级分类名称，三级分类依此类推 -->
			<h3 class="panel-title">所有分类</h3>
		</div>
		<div class="list-group">

		 
			<div class="wrap">
				<div class="all-sort-list">
					<c:forEach var="mkey5" items="${autopart}">

						<div class="item">

							<c:if test="${mkey5['name']=='发动机'}">
								<div
									style="width: 234px;height: 62px;border-bottom: 1px solid #ddd;text-align: center;padding-top: 8px;">
									<img src="<%=basePath%>html/images/indexfdj.png"
										style="float: left;width: 28px;height:24px;margin-left: 20px;margin-top: 8px;" />
									<h3 style="float: left;width: 68px;height:24px;"><a href="<%=basePath%>pei/category?id=${mkey5['id']}" style="color: #00CCFF">${mkey5['name']}</a></h3> 
									<span style="float: left;margin-left: 9px;width: 138px;height:24px;">发动机总成，进气系统</span>
								</div>
							</c:if>

							<c:if test="${mkey5['name']=='底盘'}">
								<div
									style="width: 234px;height: 62px;border-bottom: 1px solid #ddd;text-align: center;padding-top: 8px;">
									<img src="<%=basePath%>html/images/indexdp.png"
										style="float: left;width: 28px;height:24px;margin-left: 20px;margin-top: 8px;" />
									<h3 style="float: left;width: 68px;height:24px;"><a href="<%=basePath%>pei/category?id=${mkey5['id']}" style="color: #00CCFF">${mkey5['name']}</a></h3>
									<span style="float: left;margin-left: -10px;width: 138px;height:24px;">变速器，离合器</span>
								</div>
							</c:if>
							<c:if test="${mkey5['name']=='车身及附件'}">
								<div
									style="width: 234px;height: 62px;border-bottom: 1px solid #ddd;text-align: center;padding-top: 8px;">
									<img src="<%=basePath%>html/images/indexcs.png"
										style="float: left;width: 28px;height:24px;margin-left: 20px;margin-top: 8px;" />
									<h3 style="float: left;width: 98px;height:24px;"><a href="<%=basePath%>pei/category?id=${mkey5['id']}" style="color: #00CCFF">${mkey5['name']}</a></h3>
									<span style="float: left;margin-left: -3px;width: 138px;height:24px;">车身，车身覆盖件</span>
								</div>
							</c:if>
							<c:if test="${mkey5['name']=='电子、电器'}">
								<div
									style="width: 234px;height: 62px;border-bottom: 1px solid #ddd;text-align: center;padding-top: 8px;">
									<img src="<%=basePath%>html/images/indexdz.png"
										style="float: left;width: 28px;height:24px;margin-left: 20px;margin-top: 8px;" />
									<h3 style="float: left;width: 98px;height:24px;"><a href="<%=basePath%>pei/category?id=${mkey5['id']}" style="color: #00CCFF">${mkey5['name']}</a></h3>
									<span style="float: left;margin-left: -14px;width: 138px;height:24px;">汽车空调系统</span>
								</div>
							</c:if>
							<c:if test="${mkey5['name']=='保养配件'}">
								<div style="width: 234px;height: 62px;border-bottom: 1px solid #ddd;text-align: center;padding-top: 8px;">
									<img src="<%=basePath%>html/images/indexby.png"
										style="float: left;width: 28px;height:24px;margin-left: 20px;margin-top: 8px;" />
									<h3 style="float: left;width: 98px;height:24px;"><a href="<%=basePath%>pei/category?id=${mkey5['id']}" style="color: #00CCFF">${mkey5['name']}</a></h3>
									<span style="float: left;margin-left: -14px;width: 138px;height:24px;">油品、化学品 </span>
								</div>
							</c:if>
							<div class="item-list clearfix">

								<div class="subitem">
									<c:forEach var="mkey6" items="${mkey5['autoPartList']}">
										<dl class="fore1">
											<dt>
												<a href="<%=basePath%>pei/listPart?id=${mkey6['id']}">${mkey6['name']}</a>
											</dt>
											<dd>
												<c:forEach var="mkey7" items="${mkey6['autoPartInfo']}">
													<em>
													  <c:if test="${mkey7['infoid']!=''}">
													<a
														href="<%=basePath%>pei/product?id=${mkey7['infoid']}">${mkey7['name']}</a></c:if>
														<c:if test="${mkey7['infoid']==''}">
													<a
														href="<%=basePath%>pei/product?id=${mkey7['id']}">${mkey7['name']}</a></c:if>
														</em>
												</c:forEach>
											</dd>
										</dl>
									</c:forEach>

								</div>

							</div>
						</div>
					</c:forEach>



				</div>
			</div>
 		</div>

	</div>
	<div class="panel panel-primary" style="border-color: #f60;">
		<div class="panel-heading"
			style="background-color: #f60;color: #FFF;border-color: #f60;">
			<h3 class="panel-title">最新交易记录</h3>
		</div>
		<div class="list-group">
			<c:forEach var="mkey" items="${skey}">
				<c:if test="${mkey['productType']=='配件' }">
					<a href="<%=basePath%>pei/detail?id=${mkey['gId'] }"
						class="list-group-item"> <span
						class="glyphicon glyphicon-bullhorn" style="float: left;"></span> <span
						style="color:#333;float:left;width:190px;height:20px;overflow: hidden;" title="${mkey['goodname'] }">${mkey['goodname'] }</span><br /> <span
						class="list-group-item-text" style="float:left;"> 订单号： ${mkey['mainOrderId']} <br />
							${mkey['buy']}
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span style="font-size:15px; font-weight:normal; color:#e4393c;float:right;">¥${mkey['goodsPrice']}</span>
							<span style="float: left;">${mkey['createTime']}</span>
					</span>
					</a>
				</c:if>
				<c:if test="${mkey['productType']=='官方商品' }">
					<a href="<%=basePath2%>index/detail?id=${mkey['gId'] }"
						class="list-group-item"> <span
						class="glyphicon glyphicon-bullhorn" style="float: left;"></span> <span
						style="color:#333;float: left;width:190px;height:20px;overflow: hidden;" title="${mkey['goodname'] }">${mkey['goodname'] }</span><br /> <span
						class="list-group-item-text" style="float: left;"> 订单号： ${mkey['mainOrderId']}
							<br /> <span style="float: left;">${mkey['buy']}</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span style="font-size:15px; font-weight:normal; color:#e4393c;float: right;">¥${mkey['goodsPrice']}</span>
							<span style="float:left;">${mkey['createTime']}</span>
					</span>
					</a>
				</c:if>
			</c:forEach>
		</div>
	</div>

</div>
<script type="text/javascript">
	$('.all-sort-list > .item').hover(
			function() {
				var eq = $('.all-sort-list > .item').index(this), //获取当前滑过是第几个元素
				h = $('.all-sort-list').offset().top, //获取当前下拉菜单距离窗口多少像素
				s = $(window).scrollTop(), //获取游览器滚动了多少高度
				i = $(this).offset().top, //当前元素滑过距离窗口多少像素
				item = $(this).children('.item-list').height(), //下拉菜单子类内容容器的高度
				sort = $('.all-sort-list').height(); //父类分类列表容器的高度

				if (item < sort) { //如果子类的高度小于父类的高度
					if (eq == 0) {
						$(this).children('.item-list').css('top', (i - h));
					} else {
						$(this).children('.item-list').css('top', (i - h) + 1);
					}
				} else {
					if (s > h) { //判断子类的显示位置，如果滚动的高度大于所有分类列表容器的高度
						if (i - s > 0) { //则 继续判断当前滑过容器的位置 是否有一半超出窗口一半在窗口内显示的Bug,
							$(this).children('.item-list').css('top',
									(s - h) + 2);
						} else {
							$(this).children('.item-list').css('top',
									(s - h) - (-(i - s)) + 2);
						}
					} else {
						$(this).children('.item-list').css('top', 10);
					}
				}

				$(this).addClass('hover');
				$(this).children('.item-list').css('display', 'block');
				$(this).children('.item-list').css('left', 220);
			}, function() {
				$(this).removeClass('hover');
				$(this).children('.item-list').css('display', 'none');
			});

	$('.item > .item-list > .close').click(function() {
		$(this).parent().parent().removeClass('hover');
		$(this).parent().hide();
	});
</script>