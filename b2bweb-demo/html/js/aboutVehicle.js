/*
 * 选择车辆类型
 */
	function getSelect(basePath) {
         $.ajax({
            type: "GET",
            url: basePath+"person/getVehicleType",
            async:false,
            dataType: "html",
            success: function(data) {
 			 $('#vehicleType').html("<option value='0'>-请选择-</option>"+data);
            },
            error: function() {
           	$('#vehicleType').text("<option value='0'>-URL请求失败-</option>");
            }
        });
        $('#car-brand-data').onclick(function() {
    	ajaxGetData('#car-brand-data',basePath+"member/brandList");
        });
    	$('#car-brand-data').change(function() {
    	    ajaxGetData('#car-factory-data',basePath+"member/factoryList?id="+$(this).children(':selected').val());
    	    _text = $(this).children(':selected').text();
    	});

        $('#car-factory-data').change(function() {
            ajaxGetData('#car-series-data',basePath+"member/fctList?id="+$(this).children(':selected').val());
            _text += '/'+$(this).children(':selected').text();
        });

    	$('#car-series-data').change(function() {
    	    ajaxGetData('#car-modal-year',basePath+"member/years?id="+$(this).children(':selected').val());
    	    _text += '/'+$(this).children(':selected').text();
    	});

    	$('#car-modal-year').change(function() {
    		 ajaxGetData('#car-modal-data',basePath+"member/specList?id="+$(this).children(':selected').val());
    	    _text += '/'+$(this).children(':selected').text();
    	});
/*
ajax方式获取数据
*/
function ajaxGetData(obj,url) {
$.ajax({
    type: "POST",
    async: false,  
    url: url,
    dataType: "html",
    success: function(data) {
        $(obj).html("<option value='0'>-请选择-</option>"+data);
    },
    error: function() {
        $(obj).text("<option value='0'>-URL请求失败-</option>");
    }
});
}
}
