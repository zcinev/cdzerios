  var  url_id="";
function carModalSelect_all_list_04(basePath) {//2015-06-05 杨才文
	url_id=basePath;
 	    var __this = '';
 	        __this = $(this);
	        var _text='';
	        var _test='';
	    	ajaxGetData('#car-brand-data_04',basePath+"member/brandList");
	    	ajaxGetData('#car-factory-data_04',basePath+"member/factoryList");
	    	ajaxGetData('#car-series-data_04',basePath+"member/fctList");
	    	ajaxGetData('#car-modal-data_04',basePath+"member/specList");
	                       
	    	$('#car-brand-data_04').change(function() {
	    	    ajaxGetData('#car-factory-data_04',basePath+"member/factoryList?id="+$(this).children(':selected').val());
	    	    _text = $(this).children(':selected').text();
	    	    _test=$(this).children(':selected').val();
	    	});

	        $('#car-factory-data_04').change(function() {
	            ajaxGetData('#car-series-data_04',basePath+"member/fctList?id="+$(this).children(':selected').val());
	            _text += '/'+$(this).children(':selected').text();
	            _test+='/'+$(this).children(':selected').val();
	        });

	    	$('#car-series-data_04').change(function() {
	    	    ajaxGetData('#car-modal-data_04',basePath+"member/specList?id="+$(this).children(':selected').val());
	    	    _text += '/'+$(this).children(':selected').text();
	    	    _test+='/'+$(this).children(':selected').val();
	    	});

	    	$('#car-modal-data_04').change(function() {
	    	    _text += '/'+$(this).children(':selected').text();
	    	    _test+='/'+$(this).children(':selected').val();
	    	});

	    	$("#save-car-modal_04").click(function() {
	    	    if(_text) {
	    	    	$('.car-modal-btn').text(_text);
	    	    	$('.selectCar').text(_text);
	            }
	    	    saveCarModel(_text,_test);
	    	    saveCarModel2(basePath,_text,_test);
	    	    $(this).closest('.modal').modal('hide');
	    	});
  	  
	}
function distSelect(basePath) {
	ajaxGetData('#car-province-data',basePath+"member/getSelectValue?id=1");
    $('#car-province-data').change(function() {
        ajaxGetData('#car-city-data',basePath+"member/getSelectValue?id="+$(this).children(':selected').val());
        $('#buy_car_city').val($(this).children(':selected').text());
    });

    $('#car-city-data').change(function() {
        $('#buy_car_city').val($(this).children(':selected').text());
    });
}
 $(document).ready(function(){
 	 $.ajax({
	     type: "POST", 
	     data:{},
	     url: url_id+"/carsaf/allSafeNowTimeSafe",
	     async:false,
	     dataType: "html",
	     success: function(data) {
 	         if(data!=null){
	        	 var count=data.split(",");
	        	 var now_count=count[0];//今日诉讼条数
	        	 var all_count=count[1];//总诉讼条数
	        	 $('#now_count_id').html(now_count);
	        	 $('#all_count_id').html(all_count);

	         }
	           
				},
				error : function() {
                    alert("加载失败!"); 	
                    
 				}
			});
	 
 });
 

 