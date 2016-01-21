<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!--引用百度地图API-->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
    html,body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>

</head>

<body>
  <!--百度地图容器-->
  <div style="width:400px;height:300px;border:#ccc solid 1px;" id="dituContent"></div>
</body>

	

<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
    }
    //创建地图函数：
    function createMap(){
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
         var point = new BMap.Point(112.979353,28.213478);//定义一个中心点坐标
        map.centerAndZoom(point,13);//设定地图的中心点和坐标并将地图显示在地图容器中
       
    	var marker = new BMap.Marker(point);// 创建标注
		map.addOverlay(marker);             // 将标注添加到地图中
         map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
   		 map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
    }	
    initMap();//创建和初始化地图
    
    
  function searchByStationName() {
 
  var map = map1;  
  var localSearch = new BMap.LocalSearch(map);
    localSearch.enableAutoViewport(); //允许自动调节窗体大小
    
    var keyword = document.getElementById("address").value;
    localSearch.setSearchCompleteCallback(function (searchResult) {

        var poi = searchResult.getPoi(0);
        document.getElementById("latlon").value = poi.point.lng + "|" + poi.point.lat;
        map.centerAndZoom(poi.point, 13);
   /*       var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
        map.addOverlay(marker);  */
        
        
      var icon = new BMap.Icon("/b2bweb-demo/html/images/point.png", new BMap.Size(50, 72), {//是引用图标的名字以及大小，注意大小要一样
    anchor: new BMap.Size(10, 30)//这句表示图片相对于所加的点的位置
	});
	var mkr = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat), {
    icon: icon
	});
	 map.addOverlay(mkr); 
	  
   
 	        var content = document.getElementById("address").value + "<br/><br/>经度：" + poi.point.lng + "<br/>纬度：" + poi.point.lat;
        var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
        mkr.addEventListener("onmouseover", function () { this.openInfoWindow(infoWindow); });
        // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    });
    localSearch.search(keyword);
       queryNearStore();
    
}   
    var map1 = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
  	 map1.enableScrollWheelZoom();
     
    
   function addMarker(longitude,latitude,wxsTelphone,serviceTime,wxsName,address,len){
		
		var point = new BMap.Point(longitude,latitude);//定义一个中心点坐标
		
		if(len==0){
		map1.centerAndZoom(point,13);//设定地图
		}
        
    
       /*   var marker = new BMap.Marker(new BMap.Point(longitude, latitude));  // 创建标注，为要查询的地方对应的经纬度
        map1.addOverlay(marker); */
        
      var icon = new BMap.Icon("/b2bweb-demo/html/images/point1.png", new BMap.Size(50, 72), {//是引用图标的名字以及大小，注意大小要一样
    anchor: new BMap.Size(10, 30)//这句表示图片相对于所加的点的位置
	});
	var mkr = new BMap.Marker(new BMap.Point(longitude, latitude), {
    icon: icon
	});
	  map1.addOverlay(mkr); 
	  
	  
         var content="当前城市:长沙";
        if(wxsTelphone==1 || serviceTime==1){
        
        }else{
         content =  "店铺名称：" + wxsName + "<br/>联系电话：" + wxsTelphone + "<br/>服务时间：" + serviceTime;
        
        }
        var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
        mkr.addEventListener("onmouseover", function () { this.openInfoWindow(infoWindow); });
        // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    
   
}  
    
   
 function addMarker1(longitude,latitude,companyName,urgentTel,address,len){
		
		var point = new BMap.Point(longitude,latitude);//定义一个中心点坐标
		
		if(len==0){
		map1.centerAndZoom(point,13);//设定地图
		}
        
    
      /*    var marker = new BMap.Marker(new BMap.Point(longitude, latitude));  // 创建标注，为要查询的地方对应的经纬度
        map1.addOverlay(marker); */
        
      var icon = new BMap.Icon("/b2bweb-demo/html/images/point1.png", new BMap.Size(50, 72), {//是引用图标的名字以及大小，注意大小要一样
    anchor: new BMap.Size(10, 30)//这句表示图片相对于所加的点的位置
	});
	var mkr = new BMap.Marker(new BMap.Point(longitude, latitude), {
    icon: icon
	});
	  map1.addOverlay(mkr); 
	  
	  
         var content =  "店铺名称：" + companyName + "<br/>联系电话：" + urgentTel + "<br/>详细地址：" + address;
        
        
        var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
        mkr.addEventListener("onmouseover", function () { this.openInfoWindow(infoWindow); });
        // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    
   
}  
    
   
</script>
</html>