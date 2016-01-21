function newMap(container, city, mapIcon) {
	
    var map = new BMap.Map(container);
    
    var localSearch = new BMap.LocalSearch(map);
    localSearch.enableAutoViewport(); //允许自动调节窗体大小
    
   
    localSearch.setSearchCompleteCallback(function (searchResult) {

        var poi = searchResult.getPoi(0);
        document.getElementById("coord").value = poi.point.lng + "|" + poi.point.lat;
        map.centerAndZoom(poi.point, 13);
        var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
        map.addOverlay(marker);
        var content = city + "<br/><br/>经度：" + poi.point.lng + "<br/>纬度：" + poi.point.lat;
        var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
        marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
        // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    });
    localSearch.search(city);
    
    
    var is_Scale = arguments[3] == 0 ? 0 : 1;
    var is_Navigation = arguments[4] == 0 ? 0 : 1;
    var is_Overview = arguments[5] == 0 ? 0 : 1;
    var is_myZoom = arguments[6] == 0 ? 0 : 1;

    if (is_Navigation == 1) {
        map.addControl(new BMap.NavigationControl());
    } else {
        var opts = {
            type: BMAP_NAVIGATION_CONTROL_ZOOM
        };
        map.addControl(new BMap.NavigationControl(opts));
    }
    if (is_Scale == 1) {
        map.addControl(new BMap.ScaleControl());
    };
    if (is_Overview == 1) {
        map.addControl(new BMap.OverviewMapControl());
    };

    function ZoomControl() {
        this.defaultAnchor = BMAP_ANCHOR_TOP_RIGHT;
        this.defaultOffset = new BMap.Size(10, 10);
    }

    ZoomControl.prototype = new BMap.Control();

   

    map.enableScrollWheelZoom(); //在地图中使用鼠标滚轮控制缩放
}

//获取详细地址
function getAreaName(coor_x,coor_y) {
    var myGeo = new BMap.Geocoder();
    myGeo.getLocation(new BMap.Point(coor_x, coor_y), function(result){
        if (result){
            $('#address').val(result.address);
        }
    });
};



function searchByStationName() {
	  $('#baiduMap').html('<div id="map-container" style="width:100%;height:400px;border:1px solid #ccc;"></div>');
	  
	  var map = new BMap.Map("map-container");//在百度地图容器中创建一个地图
	   
	  var localSearch = new BMap.LocalSearch(map);
	    localSearch.enableAutoViewport(); //允许自动调节窗体大小
	    
	    var address1=$("#province-box option:selected").text()+$("#city-box  option:selected").text()+$("#area-box  option:selected").text()+$("#address").val();
	    localSearch.setSearchCompleteCallback(function (searchResult) {

	        var poi = searchResult.getPoi(0);
	        document.getElementById("coord").value = poi.point.lng + "|" + poi.point.lat;
	        map.centerAndZoom(poi.point, 13);
	        var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
	        map.addOverlay(marker);
	        var content = address1 + "<br/><br/>经度：" + poi.point.lng + "<br/>纬度：" + poi.point.lat;
	        var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
	        marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
	        // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	    });
	    localSearch.search(address1);
	    
	    
	}   



function newMap1(container,coord, city, mapIcon) {
	
    var map = new BMap.Map(container);
    
    var localSearch = new BMap.LocalSearch(map);
    localSearch.enableAutoViewport(); //允许自动调节窗体大小
    
   
    localSearch.setSearchCompleteCallback(function (searchResult) {
    	var lng=coord.split("|")[0];
    	var lat=coord.split("|")[1];
    	
    	var point=new BMap.Point(lng,lat);
    	
        map.centerAndZoom(point, 13);
        
        var marker = new BMap.Marker(point);  // 创建标注，为要查询的地方对应的经纬度
        map.addOverlay(marker);
        var content = city + "<br/><br/>经度：" +point.lng + "<br/>纬度：" + point.lat;
        var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
        marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
        // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    });
    localSearch.search(city);
    
    
    var is_Scale = arguments[3] == 0 ? 0 : 1;
    var is_Navigation = arguments[4] == 0 ? 0 : 1;
    var is_Overview = arguments[5] == 0 ? 0 : 1;
    var is_myZoom = arguments[6] == 0 ? 0 : 1;

    if (is_Navigation == 1) {
        map.addControl(new BMap.NavigationControl());
    } else {
        var opts = {
            type: BMAP_NAVIGATION_CONTROL_ZOOM
        };
        map.addControl(new BMap.NavigationControl(opts));
    }
    if (is_Scale == 1) {
        map.addControl(new BMap.ScaleControl());
    };
    if (is_Overview == 1) {
        map.addControl(new BMap.OverviewMapControl());
    };

    function ZoomControl() {
        this.defaultAnchor = BMAP_ANCHOR_TOP_RIGHT;
        this.defaultOffset = new BMap.Size(10, 10);
    }

    ZoomControl.prototype = new BMap.Control();

   

    map.enableScrollWheelZoom(); //在地图中使用鼠标滚轮控制缩放
}