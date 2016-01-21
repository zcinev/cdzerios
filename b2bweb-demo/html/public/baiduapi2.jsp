<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div style="width:678px;height:350px;" id="mybaidumap2"></div>
<script type="text/javascript">
	function getmybaidu2(){
		// 百度地图API功能
		var map2 = new BMap.Map("mybaidumap2");
		var top_left_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角，仅包含平移和缩放按钮
		map2.addControl(top_left_navigation);
		var pjsMap2=document.getElementById("pjsMap2").value.split("|");
		var longitude=pjsMap2[0];
		var latitude=pjsMap2[1];
	    var point2 = new BMap.Point(longitude,latitude);
	    map2.centerAndZoom(point2,13);
	    var companyName2=document.getElementById("companyName2").value;
	    var tel2=document.getElementById("tel2").value;
	    var address2=document.getElementById("address2").value;
	    var banner2=document.getElementById("banner2").value;
	    var content2 = "<div style='margin:0;line-height:20px;padding:2px;'>" +
		                    "<img src='"+banner2+"' alt='' style='float:right;zoom:1;overflow:hidden;width:100px;height:100px;margin-left:3px;'/>名称："+companyName2+""+
		                    "<br/>联系电话："+tel2+"<br/>地址："+address2+"";
			  //判断是否为空
	    var searchInfoWindow2 = null;
		searchInfoWindow2 = new BMapLib.SearchInfoWindow(map2, content2, {
			title  : companyName2,      //标题
			width  : 290,             //宽度
			height : 110,              //高度
			panel  : "panel",         //检索结果面板
			enableAutoPan : true,     //自动平移
			searchTypes   :[
				/* BMAPLIB_TAB_SEARCH,   //周边检索
				BMAPLIB_TAB_TO_HERE,  //到这里去
				BMAPLIB_TAB_FROM_HERE //从这里出发 */
			]
		});
		var myIcon2 = new BMap.Icon("<%=basePath%>html/images/point.png", new BMap.Size(20,28));//设置图片大小
		var marker2 = new BMap.Marker(point2,{icon:myIcon2});
	    	marker2.addEventListener("click", function(e){
	    	searchInfoWindow2.open(marker2);
	   	});
	    map2.addOverlay(marker2);             // 将标注添加到地图中
		map2.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
		map2.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
	};
</script>
</html>