<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!--引用百度地图API-->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
</head>

<body>
  <!--百度地图容器-->
  <div style="width:350px;height:280px;border:#ccc solid 1px;" id="dituContent"></div>
</body>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("dituContent");
    var myGeo = new BMap.Geocoder();	
	myGeo.getPoint(coord, function(point){
		if (point) {
			map.centerAndZoom(point, 13);
			var myIcon = new BMap.Icon("<%=basePath%>html/images/point.png", new BMap.Size(20,28));//设置图片大小
			var marker = new BMap.Marker(point,{icon:myIcon});
			var content = "<div style='margin:0;line-height:20px;padding:2px;'>"+
                 "<img src='./img/logo.jpg' alt='' style='float:right;zoom:1;overflow:hidden;width:100px;height:100px;margin-left:3px;'/>"+
                 "车队长科技<br/>电话：(010)88865777<br/>车队长科技是一家致力于汽车后市场的软件公司</div>";
	 		 //判断是否为空
		    var searchInfoWindow = null;
			searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
				title  : "所在位置",      //标题
				width  : 290,             //宽度
				height : 100,              //高度
				panel  : "panel",         //检索结果面板
				enableAutoPan : true,     //自动平移
				searchTypes   :[
					BMAPLIB_TAB_SEARCH,   //周边检索
					BMAPLIB_TAB_TO_HERE,  //到这里去
					BMAPLIB_TAB_FROM_HERE //从这里出发
				]
			});
			map.addOverlay(marker);             
			//marker.enableDragging();           
			
			marker.addEventListener("click", function(e){
    			searchInfoWindow.open(marker);
    		});
			coor=point.lng + ", "  + point.lat; 
			document.getElementById("coor").value=coor;
		}
	}, coord);
    map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
</script>
</html>