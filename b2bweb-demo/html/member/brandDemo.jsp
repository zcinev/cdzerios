<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../public/head3.jsp"%>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
/* 验证样式 */
.message {
	display: none;
}

.messageLabel {
	color: red;
}

.messageShow {
	font-size: 10px;
	color: red;
}

.form-group label {
	font-weight: normal;
	color: #333;
}

.btn-primary {
	background-color: #FF7400;
	border-color: #ed8802;
	width: 60px;
}

.btn-primary:hover {
	color: white;
	background-color: #ed8802;
	border: #FF7400;
	height: 34px;
}
</style>
<div class="container-fluid">
	<div class="row">
		<%@ include file="../public/memberSidebar.jsp"%>
		<div class="col-md-10 pull-right paddingRight0 paddingLeft0">
			<div class="panel panel-default">
				<div class="panel-heading"
					style="background-color: #ecf9ff;border-color: #ddd;">
					<ol class="breadcrumb bottom-spacing-0">
						<li><a href="#">会员中心</a>
						</li>
						<li class="active">车型车系</li>
					</ol>
				</div>
				<div class="container-fluid" style="width:80%;margin-top:20px;">

					<h6 style=" color: #014d7f;font-weight: bold;">车型车系模拟</h6>
					<form class="form-horizontal" action="" method="post" name="form1">


						<div class="form-group">
							<label for="" class="col-sm-2 control-label"
								style="margin-left: -21px;">选择区域</label>
							<div class="col-sm-10 form-group form-inline"
								style="margin-left: -6px;">

								<select name="brandId" id="brandId" class="form-control"
									style="margin-left: 8px;" onchange="factoryName();">
									<option value="0">-请选择-</option>
								</select> <select name="factoryId" id="factoryId" class="form-control"
									style="margin-left: 8px;" onchange="fctList();">
									<option value="0">-请选择-</option>
								</select> <select name="fctId" id="fctId" class="form-control"
									onchange="specList();">
									<option value="0">-请选择-</option>
								</select><br> <br> 
								<div style="padding-left: 1%">
								<select name="specId" id="specId"
									class="form-control">
									<option value="0">-请选择-</option>
								</select></div><br><br>
                               姓名： <input type="text" class="form-control"   name="name" id="name" value="" style="width: 200px;" readonly="readonly" >
                               年龄 ： <input type="text" class="form-control"   name="age" id="age" value="" style="width: 200px;"  readonly="readonly"><br><br>
                               星座： <input type="text" class="form-control"   name="constellation" id="constellation" value="" style="width: 200px;"  readonly="readonly">
                               恋否： <input type="text" class="form-control"   name="love" id="love" value="" style="width: 200px;"  readonly="readonly"><br><br>
                               自我评价：<input type="text" class="form-control"   name="comment" id="comment" value="" style="width: 200px;"  readonly="readonly">
                               
                          <br>  <br>
                          <div align="center">
                                                                 名字首字母： <input type="text" class="form-control"   name="namePing" id="namePing" value="" placeholder="请输入您名字的首字母,小写哦！" style="width: 200px;"   >
                                  <button type="button" class="btn btn-primary"  onclick="javascript:basicList();"  >获取资料</button>
</div>
 							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../public/foot3.jsp"%>


<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=tpK1nkTXV01FtyrBWwY2DpVq"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/measure.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/mark.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/searchInRectangle_min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>html/plugin/map/SearchControl_min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/map/map.js"></script>

<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script src="<%=basePath%>js/jquery.validate.js" type="text/javascript"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>


<script>
//品牌 (json的list 数据)
       var bStr="<option value='0'>-请选择-</option>";
       var brandStr="";
        var btr="";
        var Bid="";
        var Bname="";
       $.ajax({
	     type : "POST",
	     url : "<%=basePathBrand%>connect/brandList",
	     dataType : "json",
		 async : true,
	     data : {},
	     success : function(json){
   	     for(var i in json){
  	      var  jsonStr=json[i];
                for(var j=0;j<jsonStr.length;j++){
                
             var id=jsonStr[j].id;
                if(id !=undefined){
                  Bid+=id+",";
               }
              var name=jsonStr[j].name;
                   if(name !=undefined){
                    Bname+=name+",";
                  }
                }
 }
 	         var BidStr=Bid.split(",");
	         var BnameStr=Bname.split(",");
       	     for(var i=0;i<BidStr.length-1;i++){
 	       brandStr+="<option value='"+BidStr[i]+
	       "'>"+BnameStr[i]+"</option>";
 	     	$('#brandId').html(bStr+brandStr);
 	     	}
 	     },
 	   
	     error : function(){
 	     	alert('失败');
	     }
	 });
	 //厂商 (json数据的 map 与list 数据混合)
 function factoryName(){
     var brandId=document.getElementById("brandId").value;
      var fStr="<option value='0'>-请选择-</option>";
       var factoryStr="";
       var str="";
        var Fid="";
        var Fname="";
        $.ajax({
	     type : "POST",
	     url : "<%=basePathBrand%>connect/factoryName",
	     dataType : "json",
		 async : true,
	     data : {'id':brandId},
	     success : function(json){
  	     for(var i in json){
  	      var  jsonStr=json[i];
               for(var j=0;j<jsonStr.length;j++){
             var id=jsonStr[j].id;
                if(id !=undefined){
                  Fid+=id+",";
               }
              var factory=jsonStr[j].factoryName;
                   if(factory !=undefined){
                    Fname+=factory+",";
                  }
                }
 }
 	         var FidStr=Fid.split(",");
	         var FnameStr=Fname.split(",");
       	     for(var i=0;i<FidStr.length-1;i++){
 	       factoryStr+="<option value='"+FidStr[i]+
	       "'>"+FnameStr[i]+"</option>";
 	     	$('#factoryId').html(fStr+factoryStr);
 	     	}
 	     },
	     error : function(){
 	     	alert('失败');
	     }
	 });
 }
        //车系
  function fctList(){
     var factoryId=document.getElementById("factoryId").value;
     var sStr="<option value='0'>-请选择-</option>";
       var SfctStr="";
       var sstr="";
        var Sid="";
        var Sname="";
         $.ajax({
	     type : "POST",
	     url : "<%=basePathBrand%>connect/fctList",
	     dataType : "json",
		 async : true,
	     data : {'id':factoryId},
	     success : function(json){
   	     for(var i in json){
  	      var  jsonStr=json[i];
  	     
               for(var j=0;j<jsonStr.length;j++){
              
             var id=jsonStr[j].id;
                if(id !=undefined){
                  Sid+=id+",";
               }
              var name=jsonStr[j].name;
                
                   if(name !=undefined){
                    Sname+=name+",";
                  }
                }
 } 
 	         var SidStr=Sid.split(",");
	         var SnameStr=Sname.split(",");
	        
       	     for(var i=0;i<SidStr.length-1;i++){
 	       SfctStr+="<option value='"+SidStr[i]+
	       "'>"+SnameStr[i]+"</option>";
 	     	$('#fctId').html(sStr+SfctStr);
 	     	}
 	     },
	     error : function(){
 	     	alert('失败');
	     }
	 });
 }
 //车型
   function specList(){
    var fctId=document.getElementById("fctId").value;
     var pStr="<option value='0'>-请选择-</option>";
       var pSpecStr="";
       var pstr="";
        var Pid="";
        var Pname="";
         $.ajax({
	     type : "POST",
	     url : "<%=basePathBrand%>connect/specList",
			dataType : "json",
			async : true,
			data : {
				'id' : fctId
			},
			success : function(json) {
				for ( var i in json) {
					var jsonStr = json[i];
					for ( var j = 0; j < jsonStr.length; j++) {
						var id = jsonStr[j].id;
						if (id != undefined) {
							Pid += id + ",";
						}

						var name = jsonStr[j].name;
						if (name != undefined) {
							Pname += name + ",";
						}
					}
				}
				var PidStr = Pid.split(",");
				var PnameStr = Pname.split(",");
				for ( var i = 0; i < PidStr.length - 1; i++) {
					pSpecStr += "<option value='"+PidStr[i]+  "'>"
							+ PnameStr[i] + "</option>";
					$('#specId').html(pStr + pSpecStr);
				}
			},
			error : function() {
				alert('失败');
			}
		});
	}
	//json的map数据
	function basicList(){
	 var  jsonStr="";
	 var namePing=$("#namePing").val();
  	 $.ajax({
	     type : "POST",
	     url : "<%=basePathBrand%>connect/basicList",
	     dataType : "json",
		 async : true,
	     data : {'namePing':namePing},
	     success : function(json){
  	   document.getElementById("name").value=json.name;
 	  document.getElementById("age").value=json.age;
 	  document.getElementById("constellation").value=json.constellation;
 	  document.getElementById("love").value=json.love;
 	  document.getElementById("comment").value=json.comment;
  	      
 	     },
	     error : function(){
 	     	alert('失败');
	     }
	 });
	
	}
</script>