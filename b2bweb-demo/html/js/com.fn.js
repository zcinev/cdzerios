
/*
	区域选择
*/
function showSelectData(obj,url) {
    $.ajax({
        type: "POST",
        async: false,  
        url: url,
        dataType: "html",
        success: function (data) {
            $(obj).html("<option value='0'>-请选择-</option>" + data);
        }
    });
}

/*
 * ajax方式获取数据
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
 
function ajaxGetModelAnd(obj,url,brandId,factoryId,fctId,specId){
var len=$('#CarModelList').find("p").length;
$.ajax({
    type: "POST", 
    data:{'brandId':brandId,'factoryId':factoryId,'fctId':fctId,'specId':specId},
    url:url ,
    async:false,
    dataType: "html",
    success: function(data) {
    	var biaoji=document.getElementsByName("biaoji");
    	var len=biaoji.length-1;
    	if(data==""){
    		document.getElementsByName("biaoji")[len].value="0";
    	}else{
    		document.getElementsByName("biaoji")[len].value="1";
    	}
    	if(len==0){
    		 $('#CarModelList').html(data);
    	}
      
    },
    error: function() {
    	 alert("请求失败");
    
    }
});
}
/*
 * 地区选择
 */
function distSelect(basePath) {
 	ajaxGetData('#province-box',basePath+"member/getSelectValue?id=1");
 	
     $('#province-box').change(function() {
    	 ajaxGetData('#city-box',basePath+"member/getSelectValue?id="+$(this).children(':selected').val());
         $('#address').val($(this).children(':selected').text());
        $('#provinceName').val($(this).children(':selected').text());
    });

    $('#city-box').change(function() {
    	ajaxGetData('#area-box',basePath+"member/getSelectValue?id="+$(this).children(':selected').val());
        $('#address').val($(this).children(':selected').text());
        if ($('#centerId-box').length > 0) {
        	ajaxGetData('#centerId-box',basePath+"member/getCenter?id="+$(this).children(':selected').val());
        }
        $('#cityName').val($(this).children(':selected').text());
    });

    $('#area-box').change(function() {
    	  $('#address').val($(this).children(':selected').text());
        $('#areaName').val($(this).children(':selected').text());
    });
}

function setDefaultValue(basePath,provinceId,cityId,areaId){
	 
	 $("#province-box option[value='" +provinceId+ "'] ").attr("selected",true);
	 ajaxGetData('#city-box',basePath+"member/getSelectValue?id="+provinceId);
	 $("#city-box option[value='" + cityId + "'] ").attr("selected",true);
	 ajaxGetData('#area-box',basePath+"member/getSelectValue?id="+cityId);
	 $("#area-box option[value='" + areaId + "'] ").attr("selected",true);
	
}

// 厂商
function factoryValue(basePath,factoryId){
	  
 	 ajaxGetData('#manufacturer-select',basePath+"member/bcFactoryList?id="+factoryId);
 	      
	 $("#manufacturer-select option[value='" +factoryId+ "'] ").attr("selected",true);
	             
}
// 付款方式
function paymentwayValue(basePath,paymentway){
 	 ajaxGetData('#pay-way',basePath+"member/paymentwayList?id="+paymentway);
 	      
	 $("#pay-way option[value='" +paymentway+ "'] ").attr("selected",true);
	   
}
// 产品规格
function standardIdValue(basePath,standardId){
	 ajaxGetData('#guige-select',basePath+"member/standardIdList?id="+standardId);
	      
	 $("#guige-select option[value='" +standardId+ "'] ").attr("selected",true);
	  
}
// 产品质保
function qualityIdValue(basePath,qualityId){
	 ajaxGetData('#guidsecurity',basePath+"member/qualityIdList?id="+qualityId);
 	 $("#guidsecurity option[value='" +qualityId+ "'] ").attr("selected",true);
	  
 	 
}
// 产品类别
function indextypeIdValue(basePath,quality){
	 ajaxGetData('#indextypeId',basePath+"member/indextypeIdList?id="+quality);
 	 $("#indextypeId option[value='" +quality+ "'] ").attr("selected",true);
	  
 	 
}
// 配件分类 回显
function PeiJianIdValue(basePath,firstKindId,secondKindId,thirdKindId){
	  
 	 $("#firstKindId-box option[value='" +firstKindId+ "'] ").attr("selected",true);
	 ajaxGetData('#secondKind-box',basePath+"member/autopartList?id="+firstKindId);
	 $("#secondKind-box option[value='" + secondKindId + "'] ").attr("selected",true);
	 ajaxGetData('#thirdKind-box',basePath+"member/autopartInfoList?id="+secondKindId);
	 $("#thirdKind-box option[value='" + thirdKindId + "'] ").attr("selected",true);
	 
	                    
	      
}
// 配件分类级联
function PeiJianJLValue(basePath) {
	  
 	ajaxGetData('#firstKindId-box',basePath+"member/autopartTypeList?id=1");
     $('#firstKindId-box').change(function() {
        ajaxGetData('#secondKind-box',basePath+"member/autopartList?id="+$(this).children(':selected').val());
        $('#address').val($(this).children(':selected').text());
        $('#provinceName').val($(this).children(':selected').text());
    });
    $('#secondKind-box').change(function() {
        ajaxGetData('#thirdKind-box',basePath+"member/autopartInfoList?id="+$(this).children(':selected').val());
        $('#address').val($(this).children(':selected').text());
     });
    $('#thirdKind-box').change(function() {
        $('#address').val($(this).children(':selected').text());
        $('#areaName').val($(this).children(':selected').text());
    });
}


//编辑配件页面    配件分类级联
function kindofPart(basePath) {
	  
 	ajaxGetData('#firstKindId-box',basePath+"member/autopartTypeList?id=1");
     $('#firstKindId-box').change(function() {
        ajaxGetData('#secondKind-box',basePath+"member/autopartList?id="+$(this).children(':selected').val());
        $('#address').val($(this).children(':selected').text());
        $('#provinceName').val($(this).children(':selected').text());
        $('input[name="firstKindId"]').val($(this).children(':selected').val());
    });
    $('#secondKind-box').change(function() {
        ajaxGetData('#thirdKind-box',basePath+"member/autopartInfoList?id="+$(this).children(':selected').val());
        $('#address').val($(this).children(':selected').text());
        $('input[name="secondKindId"]').val($(this).children(':selected').val());
     });
    $('#thirdKind-box').change(function() {
        $('#address').val($(this).children(':selected').text());
        $('#areaName').val($(this).children(':selected').text());
        $('input[name="thirdKindId"]').val($(this).children(':selected').val());
    });
}


// 适配车型2
function CheXingJLValue(basePath) {
	   
	ajaxGetData('#brandId-box',basePath+"member/brandList");

	$('#brandId-box').change(function() {
	    ajaxGetData('#factoryId-box',basePath+"member/factoryList?id="+$(this).children(':selected').val());
	    _text = $(this).children(':selected').text();
	});

    $('#factoryId-box').change(function() {
        ajaxGetData('#seriesId-box',basePath+"member/fctList?id="+$(this).children(':selected').val());
        _text += '/'+$(this).children(':selected').text();
    });

	$('#seriesId-box').change(function() {
	    ajaxGetData('#modalId-box',basePath+"member/specList?id="+$(this).children(':selected').val());
	    _text += '/'+$(this).children(':selected').text();
	});

	$('#modalId-box').change(function() {
	    _text += '/'+$(this).children(':selected').text();
	});
}
// 适配车型 回显
function CheXingIdValue(basePath,brandId,factoryId,seriesId,modalId){
	  
 	 $("#brandId-box option[value='" +brandId+ "'] ").attr("selected",true);
	 ajaxGetData('#factoryId-box',basePath+"member/factoryList?id="+brandId);
	 $("#factoryId-box option[value='" + factoryId + "'] ").attr("selected",true);
	 ajaxGetData('#seriesId-box',basePath+"member/fctList?id="+factoryId);
	 $("#seriesId-box option[value='" + seriesId + "'] ").attr("selected",true);
	 ajaxGetData('#modalId-box',basePath+"member/specList?id="+seriesId);
	 $("#modalId-box option[value='" + modalId + "'] ").attr("selected",true);
	    
	      
}
/*
 * 选择详细地址
 */
function detailAddress(basePath) {
	$('#detail-address').on('click',function() {
        $('.detail-address').modal('show');

        $('.detail-address').on('shown.bs.modal', function(e) {
            $('#baiduMap').html('<div id="map-container" style="width:100%;height:400px;border:1px solid #ccc;"></div>');
          var address1=$("#province-box option:selected").text()+$("#city-box  option:selected").text()+$("#area-box  option:selected").text()+$("#address").val();
          
          newMap("map-container", address1, basePath+"html/plugin/map/map_icon.png");
        });

        $('.detail-address').on('hidden.bs.modal', function (e) {
            $('#map-container').remove();
        });

        $('.save-coord').click(function() {
            $('#map-container').remove();
            $('.detail-address').modal('hide');
        });

    });
}


/*
 * 采购中心查看店铺的地理位置
 */
function detailAddress1(basePath,map) {
	$('#detail-address').on('click',function() {
        $('.detail-address').modal('show');

        $('.detail-address').on('shown.bs.modal', function(e) {
            $('#baiduMap').html('<div id="map-container" style="width:100%;height:400px;border:1px solid #ccc;"></div>');
          var address1=$("#province-box option:selected").text()+$("#city-box  option:selected").text()+$("#area-box  option:selected").text()+$("#address").val();
          
          newMap1("map-container", map,address1, basePath+"html/plugin/map/map_icon.png");
        });

        $('.detail-address').on('hidden.bs.modal', function (e) {
            $('#map-container').remove();
        });

        $('.save-coord').click(function() {
            $('#map-container').remove();
            $('.detail-address').modal('hide');
        });

    });
}

  function carModalSelect(basePath) {
    var __this = '';
   /*
	 * $('.navbar-brand .car-modal-btn').click(function() {
	 * $('.car-model').modal('show');
	 */
        __this = $(this);
        var _text='';
        var _test='';
    	ajaxGetData('#car-brand-data',basePath+"member/brandList");
    	ajaxGetData('#car-factory-data',basePath+"member/factoryList");
    	ajaxGetData('#car-series-data',basePath+"member/fctList");
    	ajaxGetData('#car-modal-data',basePath+"member/specList");
                       
    	$('#car-brand-data').change(function() {
    	    ajaxGetData('#car-factory-data',basePath+"member/factoryList?id="+$(this).children(':selected').val());
    	    _text = $(this).children(':selected').text();
    	    _test=$(this).children(':selected').val();
    	});

        $('#car-factory-data').change(function() {
            ajaxGetData('#car-series-data',basePath+"member/fctList?id="+$(this).children(':selected').val());
            _text += '/'+$(this).children(':selected').text();
            _test+='/'+$(this).children(':selected').val();
        });

    	$('#car-series-data').change(function() {
    	    ajaxGetData('#car-modal-data',basePath+"member/specList?id="+$(this).children(':selected').val());
    	    _text += '/'+$(this).children(':selected').text();
    	    _test+='/'+$(this).children(':selected').val();
    	});

    	$('#car-modal-data').change(function() {
    	    _text += '/'+$(this).children(':selected').text();
    	    _test+='/'+$(this).children(':selected').val();
    	});

    	$("#save-car-modal").click(function() {
    	    if(_text) {
    	    	$('.car-modal-btn').text(_text);
    	    	$('.selectCar').text(_text);
            }
    	    saveCarModel(_text,_test);
    	    saveCarModel2(basePath,_text,_test);
    	    $(this).closest('.modal').modal('hide');
    	});
    
   /* }); */
    
    
    $('.selectCar').click(function() {
        $('.car-model').modal('show');
        __this = $(this);
        var _text='';
        var _test='';
    	ajaxGetData('#car-brand-data',basePath+"member/brandList");
                       
    	$('#car-brand-data').change(function() {
    	    ajaxGetData('#car-factory-data',basePath+"member/factoryList?id="+$(this).children(':selected').val());
    	    _text = $(this).children(':selected').text();
    	    _test=$(this).children(':selected').val();
    	});

        $('#car-factory-data').change(function() {
            ajaxGetData('#car-series-data',basePath+"member/fctList?id="+$(this).children(':selected').val());
            _text += '/'+$(this).children(':selected').text();
            _test+='/'+$(this).children(':selected').val();
        });

    	$('#car-series-data').change(function() {
    	    ajaxGetData('#car-modal-data',basePath+"member/specList?id="+$(this).children(':selected').val());
    	    _text += '/'+$(this).children(':selected').text();
    	    _test+='/'+$(this).children(':selected').val();
    	});

    	$('#car-modal-data').change(function() {
    	    _text += '/'+$(this).children(':selected').text();
    	    _test+='/'+$(this).children(':selected').val();
    	});

    	$("#save-car-modal").click(function() {
    	    if(_text) {
    	    	$('.car-modal-btn').text(_text);
    	    	$('.selectCar').text(_text);
            }
    	    saveCarModel2(basePath,_text,_test);
    	    $(this).closest('.modal').modal('hide');
    	});
    
    });
}
  function carModalSelect_all_list(basePath) {//2015-06-05 杨才文
 	    var __this = '';
	   /*
		 * $('.navbar-brand .car-modal-btn').click(function() {
		 * $('.car-model').modal('show');
		 */
	        __this = $(this);
	        var _text='';
	        var _test='';
	    	ajaxGetData('#car-brand-data_all',basePath+"member/brandList");
	    	ajaxGetData('#car-factory-data_all',basePath+"member/factoryList");
	    	ajaxGetData('#car-series-data_all',basePath+"member/fctList");
	    	ajaxGetData('#car-modal-data_all',basePath+"member/specList");
	                       
	    	$('#car-brand-data_all').change(function() {
	    	    ajaxGetData('#car-factory-data_all',basePath+"member/factoryList?id="+$(this).children(':selected').val());
	    	    _text = $(this).children(':selected').text();
	    	    _test=$(this).children(':selected').val();
	    	});

	        $('#car-factory-data_all').change(function() {
	            ajaxGetData('#car-series-data_all',basePath+"member/fctList?id="+$(this).children(':selected').val());
	            _text += '/'+$(this).children(':selected').text();
	            _test+='/'+$(this).children(':selected').val();
	        });

	    	$('#car-series-data_all').change(function() {
	    	    ajaxGetData('#car-modal-data_all',basePath+"member/specList?id="+$(this).children(':selected').val());
	    	    _text += '/'+$(this).children(':selected').text();
	    	    _test+='/'+$(this).children(':selected').val();
	    	});

	    	$('#car-modal-data_all').change(function() {
	    	    _text += '/'+$(this).children(':selected').text();
	    	    _test+='/'+$(this).children(':selected').val();
	    	});

	    	$("#save-car-modal_all").click(function() {
	    	    if(_text) {
	    	    	$('.car-modal-btn').text(_text);
	    	    	$('.selectCar').text(_text);
	            }
	    	    saveCarModel(_text,_test);
	    	    saveCarModel2(basePath,_text,_test);
	    	    $(this).closest('.modal').modal('hide');
	    	});
  	  
	}
/*
 * 添加配件页面的车型选择
 */
function carModalItemSelect(basePath) {
	 
    var _this = '';
    $('.car-model-list').delegate('.car-modal-btn','click',function() {
        $('.multiple-car-model').modal('show');
        var _text = '';
        _this = $(this);
        ajaxGetData('.car-brand-data',basePath+"member/brandList");
        $('.car-brand-data').change(function() {
             ajaxGetData('.car-factory-data',basePath+"member/factoryList?id="+$(this).children(':selected').val());
            _text = $(this).children(':selected').text();
            _this.siblings('.hidden').children('input[name="brandId[]"]').val($(this).children(':selected').val());
        });

        $('.car-factory-data').change(function() {
             ajaxGetData('.car-series-data',basePath+"member/fctList?id="+$(this).children(':selected').val());
            _text += '/'+$(this).children(':selected').text();
            _this.siblings('.hidden').children('input[name="factoryId[]"]').val($(this).children(':selected').val());
        });

        $('.car-series-data').change(function() {
             ajaxGetData('.car-modal-data',basePath+"member/specList?id="+$(this).children(':selected').val());
            _text += '/'+$(this).children(':selected').text();
            _this.siblings('.hidden').children('input[name="seriesId[]"]').val($(this).children(':selected').val());
        });

        $('.car-modal-data').change(function() {
             _text += '/'+$(this).children(':selected').text();
            _this.siblings('.hidden').children('input[name="modalId[]"]').val($(this).children(':selected').val());
        });

        $(".save-car-modal").click(function() {
            if(_text) {
                _this.text(_text);
            }
            
            saveCarModel(_text);
             $(this).closest('.modal').modal('hide');
            
        });
    });
}


/**
 * 添加配件页面的车型选择
 * 
 * @param basePath
 */
var thirdKindStr="";
var thirdKind11="";
function carModalItemSelect22(basePath,thirdKindId) {
	
	thirdKind11=thirdKindId;
     $('.car-model-list').delegate('.car-modal-btn1','click',function() {
    	 thisElem11 = $(this);
    	 kvalue1="-1";
    	 $("#cpinpai").html(str22);
        $('#car-model').modal('show');
       
    });
}

/**
 * 编辑配件页面的车型选择
 * 
 * @param basePath
 */
function carModalItemSelect33(basePath) {
	
     $('.car-model-list').delegate('.car-modal-btn1','click',function() {
    	 thisElem11 = $(this);
    	 kvalue1="-1";
    	 $("#cpinpai").html(str22);
        $('#car-model').modal('show');
       
    });
}

/**
 * 添加配件页面的车型选择3 杨才文 2014-12-03
 * 
 * @param basePath
 */
 
function carModalItemSelect3(basePath,thirdKindId) {
	      
 	var brandId="";
	 var factoryId="";
	 var fctId="";
	 var specId="";
    var _this = '';
     $('.car-model-list').delegate('.car-modal-btn','click',function() {
        $('.multiple-car-model').modal('show');
        var _text = '';
        _this = $(this);
        ajaxGetData('.car-brand-data',basePath+"member/brandList");
        $('.car-brand-data').change(function() {
        	      brandId=$(this).children(':selected').val();
        	      
            ajaxGetData('.car-factory-data',basePath+"member/factoryList?id="+$(this).children(':selected').val());
            _text = $(this).children(':selected').text();
            _this.siblings('.hidden').children('input[name="brandId"]').val($(this).children(':selected').val());
        });

        $('.car-factory-data').change(function() {
          factoryId=$(this).children(':selected').val();
   	      
            ajaxGetData('.car-series-data',basePath+"member/fctList?id="+$(this).children(':selected').val());
            _text += '/'+$(this).children(':selected').text();
            _this.siblings('.hidden').children('input[name="factoryId"]').val($(this).children(':selected').val());
        });  

        $('.car-series-data').change(function() {
         fctId=$(this).children(':selected').val();
      	      
            ajaxGetData('.car-modal-data',basePath+"member/specList?id="+$(this).children(':selected').val());
            _text += '/'+$(this).children(':selected').text();
            _this.siblings('.hidden').children('input[name="fctId"]').val($(this).children(':selected').val());
        });

        $('.car-modal-data').change(function() {
          specId=$(this).children(':selected').val();
    	     
            _text += '/'+$(this).children(':selected').text();
            _this.siblings('.hidden').children('input[name="speciId"]').val($(this).children(':selected').val());
        });
        
        $(".save-car-modal").click(function() {
           	if(brandId !="" && factoryId !="" && fctId !="" && specId !="" ){
 	         	 
		            if(_text) {
		                _this.text(_text);
		            }
		            
 		            $(this).closest('.modal').modal('hide');
		            ajaxGetModelAnd('#CarModelList',basePath+"member/CarModelList?fiveModel="+thirdKindId,brandId,factoryId,fctId,specId);
	        	}else{
	        		alert("请将适配车型填写完整！");
	        	}
        });
    });
}
/*
 * 配件选择实现
 */
function peiKindSelect(basePath) {
	var _text;
    var __this = null;
    var first="";
    var second="";
    var third="";
    $('.navbar-brand .pei-kind-btn').click(function() {
        __this = $(this);
        $('.pei-kind').modal('show');
        ajaxGetData('#first-kind-data',basePath+"member/autopartTypeList");
    });

    $('#first-kind-data').change(function() {
        ajaxGetData('#second-kind-data',basePath+"member/autopartList?id="+$(this).children(':selected').val());
        first=$(this).children(':selected').val();
        _text = $(this).children(':selected').text();
    });

    $('#second-kind-data').change(function() {
        ajaxGetData('#third-kind-data',basePath+"member/autopartInfoList?id="+$(this).children(':selected').val());
        second=$(this).children(':selected').val();
        _text += '/'+$(this).children(':selected').text();
    });

    $('#third-kind-data').change(function() {
    	third=$(this).children(':selected').val();
        _text += '/'+$(this).children(':selected').text();
    });

    $('#save-pei-kind').click(function() {
    	if(third!=''){
        if (_text) {
            __this.text(_text);
        };
        savePartModel(basePath,_text,first,second,third);
        
        $(this).closest('.modal').modal('hide');
    	}
    });
}

/*
 * 添加配件页面的选择配件
 */
   
function peiKindItemSelect(basePath,thirdKindIdRR) {
    var _text;
    var __this = null;
    var sbuff1="";
    var sbuff2="";
    var sbuff3="";
    
    $('.pei-kind-list .pei-kind-btn').click(function() {
    	var tt=document.getElementsByName("speciId1");
    	tt[0].value="";
    	var typeName1=$("#firstKindId").val();
    	
        __this = $(this);
        $('.multiple-pei-kind').modal('show');
        ajaxGetData('.first-kind-data',basePath+"member/autopartTypeList");
        $(".first-kind-data option[value='"+typeName1+"']").attr("selected","selected"); 
    });

    $('.first-kind-data').click(function() {
        ajaxGetData('.second-kind-data',basePath+"member/autopartList?id="+$(this).children(':selected').val());
       
        $('input[name="firstKindId"]').val($(this).children(':selected').val());
        
        sbuff1=$(this).children(':selected').text();
    });

    $('.second-kind-data').change(function() {
    	
        ajaxGetData('.third-kind-data',basePath+"member/autopartInfoList?id="+$(this).children(':selected').val());
       
       
        $('input[name="secondKindId"]').val($(this).children(':selected').val());
        
        sbuff2=$(this).children(':selected').text();
    });

    $('.third-kind-data').change(function() {
    	
      
        thirdKindIdRR=$(this).children(':selected').val(); // 用于判断是否选择三级分类
															// 不要注释了
        sbuff3=$(this).children(':selected').text();
        
        $.ajax({
            type: "POST",  
            data:{id:thirdKindIdRR},
            url: basePath+"member/getPartImage",
            async:false,
            dataType: "json",
            success: function(data) {
                document.getElementById("faceImgId").src=data.imgurl;
                document.getElementById("faceImg").value=data.imgurl;
              },
            error: function() {
            }
        });	
        
        $('input[name="thirdKindId"]').val($(this).children(':selected').val());
    });

    $('#save-pei-kind').click(function() {
    	if(sbuff1!="" && sbuff2!="" && sbuff3!="")
    	{
    		_text=sbuff1+"/"+sbuff2+"/"+sbuff3;
            __this.text(_text);
        }
       
        carModalItemSelect22(basePath,thirdKindIdRR);
        $(this).closest('.modal').modal('hide');
        
    }); 
}

/**
 * 保存车型到cookie
 * 
 * @param obj
 */
function saveCarModel(obj,_test){
	 
	$.ajax({
		type: "POST",
		url: "saveHeadCarModel",  
		async:false,           
		// dataType: "html",
		data:{carModel:obj,carModelId:_test},
        success: function(){
        	  // alert('成功!');
        },
		error: function(){
			 alert('失败');
		}
	});
}

/*
 * function saveCarModel2(basePath,obj,_test){
 * document.getElementById("carModel").value=obj;
 * document.getElementById("carModelId").value=_test;
 * document.from5.method="post";
 * document.from5.action=basePath+"pei/saveHeadCarModel2";
 * document.from5.submit(); }
 */
/**
 * 保存配件到cookie
 * 
 * @param obj
 */
function savePartModel(basePath,obj,first,second,third){
	/*alert(obj+first+second+third);*/  //做测试用
	document.getElementById("partModel").value=obj;
	document.getElementById("category").value=first;
	document.getElementById("listPart").value=second;
	document.getElementById("product").value=third;
	document.form2.method="post";
	document.form2.action=basePath+"pei/saveHeadPartModel";
	document.form2.submit();
	/*
	 * $.ajax({ type: "POST", url: "saveHeadPartModel", async:true, dataType:
	 * "html",
	 * data:{partModel:obj,category:first,listPart:second,product:third},
	 * success: function(){ //alert('成功'); }, error: function(){ alert('失败'); }
	 * });
	 */
}


function savePartModel2(basePath,obj,first,second,third){
	alert(obj+first+second+third);
	
	/*
	 * $.ajax({ type: "POST", url: "saveHeadPartModel", async:true, dataType:
	 * "html",
	 * data:{partModel:obj,category:first,listPart:second,product:third},
	 * success: function(){ //alert('成功'); }, error: function(){ alert('失败'); }
	 * });
	 */
}

/**
 * 获取Cookie
 * 
 * @param c_name
 * @returns
 */
function getCookie(name) {
	var cookies = document.cookie.split(";");
	for(var i=0;i<cookies.length;i++) {
		var cookie = cookies[i];
	    var cookieStr = cookie.split("=");
	    if(cookieStr && cookieStr[0].trim()==name) {
	    	return  decodeURI(cookieStr[1]);
	    }
	}
}
String.prototype.trim = function() {
	return this.replace(/^(\s*)|(\s*)$/g,"");
}

if(getCookie("carModel")!=null){
	var carModel_text=getCookie("carModel");
	var carModel_text2=carModel_text.replace("%2F","/");
	var carModel_text3=carModel_text2.replace("%2F","/");
	var carModel_text4=carModel_text3.replace("%2F","/");
	var carModel_text5=carModel_text4.replace("+"," ");
	var carModel_text6=carModel_text5.replace("+"," ");
	var carModel_text7=carModel_text6.replace("+"," ");
	$('.car-modal-btn').text(carModel_text7);
	$('.selectCar').text(carModel_text7);
}
if(getCookie("partModel")!=null){
	var partModel_text=getCookie("partModel");
	var partModel_text2=partModel_text.replace("%2F","/");
	var partModel_text3=partModel_text2.replace("%2F","/");
	// alert(partModel_text3);
	$('.navbar-brand .pei-kind-btn').text(partModel_text3);
}

function showCarModal2(url1){
	  
	if(getCookie("carModel")!=null){
		var carModel_text=getCookie("carModel");
		var carModel_text2=carModel_text.replace("%2F","/");
		var carModel_text3=carModel_text2.replace("%2F","/");
		var carModel_text4=carModel_text3.replace("%2F","/");
		var carModel_text5=carModel_text4.replace("+"," ");
		var carModel_text6=carModel_text5.replace("+"," ");
		var carModel_text7=carModel_text6.replace("+"," ");
		$('.car-modal-btn').text(carModel_text7);
		$('.selectCar').text(carModel_text7);
	}else{
		$('.car-model').modal('show');
	}
}


//发布配件页面

function ajaxGetModelAnd1(obj,url,brandId,factoryId,fctId,specId){

	$.ajax({
	    type: "POST", 
	    data:{'brandId':brandId,'factoryId':factoryId,'fctId':fctId,'specId':specId},
	    url:url ,
	    async:false,
	    dataType: "json",
	    success: function(data) {
	    	var len=$("#brandul").children("li").length;
	    	for(var j=0;j<data.length;j++){
	    		if(data[j].speciName=="0"){
	    			varValue=1;
	    			var len=$("#brandul").children("li").length;
	    			for(var i=0;i<len;i++){
	    				$("#brandul").children("li").get(i).onclick();
	    			}
	    			break;
	    		}else{
	    			for(var i=0;i<len;i++){
	    				var text1=$("#brandul").children().children("span").get(i).innerHTML;
	    				
	    				if(text1==data[j].speciName){
	    				
	    	    			$("#brandul").children("li").get(i).onclick();
	    	    		}
	    				
	    			}
	    		}
	    	}
	    	
	    },
	    error: function() {
	    	 alert("请求失败");
	    
	    }
	});
	}


/*
 * 前台收货地址的地区选择
 */
function distSelect1(basePath) {
 	ajaxGetData('#province-box',basePath+"member/getSelectValue?id=1");
 	
     $('#province-box').change(function() {
    	 ajaxGetData('#city-box',basePath+"member/getSelectValue?id="+$(this).children(':selected').val());
        
        $('#provinceName').val($(this).children(':selected').text());
    });

    $('#city-box').change(function() {
    	ajaxGetData('#area-box',basePath+"member/getSelectValue?id="+$(this).children(':selected').val());
       
        if ($('#centerId-box').length > 0) {
        	ajaxGetData('#centerId-box',basePath+"member/getCenter?id="+$(this).children(':selected').val());
        }
        $('#cityName').val($(this).children(':selected').text());
    });

    $('#area-box').change(function() {
    	 
        $('#areaName').val($(this).children(':selected').text());
    });
}
