<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
</head>

	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
</head>
<body>
	<div style="width:400px;height:316px;border:#ccc solid 1px;" id="allmap"></div>
	
</body>
</html>
<script type="text/javascript">
	// 百度地图API功能
	function getBaidu(coord){
		var s=coord.split(",");
		var map = new BMap.Map("allmap");
		var point = new BMap.Point(s[0],s[1]);
		map.centerAndZoom(point,12);
		//map.centerAndZoom(coord,11);
		var myIcon = new BMap.Icon("<%=basePath%>html/images/point.png", new BMap.Size(20,28));//设置图片大小
	  	var marker = new BMap.Marker(point,{icon:myIcon});
	    marker.addEventListener("click", function(){ 
	    	var centerName=document.getElementById("centerName").value;
			var centerAddress=document.getElementById("centerAddress").value;
			var centerTel=document.getElementById("centerTel").value;
			var content = "<div style='margin:0;line-height:20px;padding:2px;'>"+
		                  "<img src='./img/logo.jpg' alt='' style='float:right;zoom:1;overflow:hidden;width:80px;height:100px;margin-left:3px;'/>"+
		                  "采购中心："+centerName+"<br/>电话："+centerTel+"<br/>地址："+centerAddress+"</div>";
				  //判断是否为空
		    var searchInfoWindow = null;
			searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
				title  : centerName,      //标题
				width  : 280,             //宽度
				height : 100,              //高度
				panel  : "panel",         //检索结果面板
				enableAutoPan : true,     //自动平移
				searchTypes   :[
					BMAPLIB_TAB_SEARCH,   //周边检索
					BMAPLIB_TAB_TO_HERE,  //到这里去
					BMAPLIB_TAB_FROM_HERE //从这里出发
				]
			});
	    	searchInfoWindow.open(marker);
	   	});
	    map.addOverlay(marker);             // 将标注添加到地图中
		map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
		map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
	}
</script>	
