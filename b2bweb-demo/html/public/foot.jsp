 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 <%@ page import="com.bc.localhost.*"%>
<style>
a {
color:#666;
}
.list-unstyled p{
font-weight: bold;color: #666;
}
.list-unstyled li{
line-height: 20px;
}
footer{
background: #f3f3f3;
padding: 20px 0;
}
.info a{
	color: #333;
	text-decoration: none;
	}
	.info a:hover{
	color: #00a9ff;
	text-decoration: none;
	}


</style>
<%
String pathr = "/b2bweb-repair";
String repairPath = BccHost.getHost()+pathr+"/";
%>
	<footer style="margin-top:30px;">
        <div class="container-fluid">
            <div class="row" style="height: 100px;">
                <div class="media cdzer-help" style="margin-left:20px;">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_03.png" alt="消费者保障中心">
                    </a>
                    <div class="media-body">
                       <ul class="list-unstyled">
                        <li><p  style="font-weight: bold;color: #666;">服务指南</a>
	                         </li>
                             <li style="margin-top: 8px;"><a href="<%=basePath2%>index/question">常见问题</a>
	                         </li>
	                         <li><a href="<%=basePath2%>index/fapiao">发票制度</a></li>
	                         <li><a href="<%=basePath2%>index/jiaoyi">交易条款</a>
	                         </li>
                        </ul>
                    </div>
                </div>
                <div class="media cdzer-help">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_05.png" alt="新手指引">
                    </a>
                    <div class="media-body">
                        <ul class="list-unstyled">
                         <li><p>特色服务</p>
                            </li>
                            <li><a href="<%=basePath2%>index/jifen">积分制度</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="media cdzer-help">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_07.png" alt="认证及保障">
                    </a>
                   <div class="media-body">
                        <ul class="list-unstyled">
                        <li ><p>售后服务</p>
                            </li>
                            <li style="margin-top: 6px;"><a href="<%=basePath2%>index/shouhou">服务承诺</a>
                            </li>
                            <li><a href="<%=basePath2%>index/kefu">联系客服</a>
                            </li>
                            <li><a href="<%=basePath2%>index/tuihuan">退换货流程</a>
                            </li>
                            <li><a href="<%=basePath2%>index/tuihuo">退换货政策</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="media cdzer-help">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_09.png" alt="交易服务">
                    </a>
                    <div class="media-body">
                       <ul class="list-unstyled">
                         <li><p>支付方式</p>
                            </li>
                            <li style="margin-top: 6px;"><a href="<%=basePath2%>index/online">在线支付</a>
                            </li>
                            <li><a href="<%=basePath2%>index/line">线下支付</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="media cdzer-help">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="<%=basePath%>html/img/huzx_11.png" alt="百城特色">
                    </a>
                    <div class="media-body">
                         <ul class="list-unstyled">
                         <li><p>配送方式</p>
                            </li>
                            <li style="margin-top: 6px;"><a href="<%=basePath2%>index/send">配送说明</a>
                            </li>
                            <li><a href="<%=basePath2%>index/logistics">配送状态查询</a>
                            </li>
                        </ul>
                    </div>
                </div>
                
            </div>
            
        </div>
         
    </footer>
     <div class="info " style="text-align: center;margin-top: 20px;">
        	
 <a href="/b2bweb-baike">车队长官网</a> @2014 Cdzer 用户协议 湘ICP备12014470号
 <p>版权所有：车队长科技（湖南 ）有限公司</p>
      
  
   
</div>
<style>
.modal-content{
border-radius:0px;
border: 2px solid #00a9ff;
width: 800px;
}
button.close{
width:35px;
height:35px;
background-color: #00a9ff;

}
.close {
    color:white;
    float: right;
    font-size: 21px;
    font-weight: 700;
    line-height: 1;
    margin-right: -15px;
    margin-top: -15px;
}
.modal-title{
color:#222;font-size: 24px;margin-left: 14px;font-family: 'MicrosoftYahei','微软雅黑','Arial';
}
.li1{
background-image: url("<%=repairPath%>html/img/carmodal1.png");
background-repeat: no-repeat;
width: 157px;
height: 38px;
}
.li2{
background-image: url("<%=repairPath%>html/img/carmodal2.png");
background-repeat: no-repeat;
width: 157px;
height: 38px;
}
.modal-body .form-horizontal .form-group ul li{
list-style-type: none;
float: left;display: inline;
margin-left: 20px;
padding-left:20px;
width: 165px;
padding-top: 9px;
}
.modal-body .form-horizontal .form-group ul li .span1{
font-size:13px;
width: 20px;
height: 20px;
background-color: white;
float: left;
color:#00a9ff;
border-radius:13px;
padding-left:6px;
padding-top:1px;
}
.modal-body .form-horizontal .form-group ul li .span2{
width: 100px;
height: 20px;
float:left;
margin-left: 10px;
margin-top: 2px;
color: white;
}
.cpinpai span{
margin-left: 15px;
cursor: pointer;
font-size: 12px;
}

.cdetail ul li{
float: left;
display: inline;
margin-left: 40px;
width: 100px;
height: 50px;
border: 1px solid #ddd;

margin-top: 20px;
}
.cdetail ul li img{
float: left;
width: 30px;
height: 24px;
margin-top: 3px;
}
.cdetail ul li span{
float: left;
min-width:70px;
height: 30px;
font-size: 14px;
padding-top:5px;
margin-left: 10px;
color: #6c6c6c;
}
.thisClass{
color: #00a9ff;
padding:5px;

}
#brandul li{
width: 160px;
}
#brandul li:hover{
border:1px solid #00a9ff;
cursor: pointer;
}
.glyphicon-remove{
width:13px;
height:12px;
background-color:#00a9ff;
padding-bottom:10px;
border-radius:9px;
float: right;
margin-top: -10px;
color: white;
margin-right: -28px;
font-weight: normal;
padding-left:2px;
line-height: 10px;
font-size: 9px;
}
.glyphicon-remove:before{
content: "×";
width: 8px;

}
#brandul{
height:320px;
overflow: auto;
margin-left: 40px;
}
#urlNode{
margin-left: 40px;
}

</style>
  <div class="modal fade car-model" style="margin-left: -200px;" id="car-model">
        <div class="modal-dialog">
            <div class="modal-content" id="model1" >
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" ><img alt="" src="<%=repairPath%>html/img/carmodal.png">选择车型</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                     <div class="form-group">
                           <ul id="urlNode">
                           <li class="li2"><span class="span1">1</span><span class="span2">选择品牌</span></li>
                            <li class="li1"><span class="span1">2</span><span class="span2">选择厂商</span></li>
                             <li class="li1"><span class="span1">3</span><span class="span2">选择车系</span></li>
                              <li class="li1"><span class="span1">4</span><span class="span2">选择车型</span></li>
                           </ul>
                        </div>
                     <div class="form-group cpinpai" id="cpinpai">
                           <span style="float: left;margin-left: 60px;">品牌首字母选择：
                           <span id="hot" class="thisClass" onclick="showBrands('热门');">热门</span> 
                           <span onclick="showBrands('A');">A</span>
                           
                           <span onclick="showBrands('B');">B</span>
                           <span onclick="showBrands('C');">C</span>
                           <span onclick="showBrands('D');">D</span>
                          
                           <span onclick="showBrands('F');">F</span>
                           <span onclick="showBrands('G');">G</span>
                            <span onclick="showBrands('H');">H</span>
                            <span onclick="showBrands('J');">J</span>
                             <span onclick="showBrands('K');">K</span>
                              <span onclick="showBrands('L');">L</span>
                               <span onclick="showBrands('M');">M</span>
                                <span onclick="showBrands('N');">N</span>
                                <span onclick="showBrands('O');">O</span>
                               <span onclick="showBrands('Q');">Q</span>
                                <span onclick="showBrands('R');">R</span>
                                <span onclick="showBrands('S');">S</span>
                                <span onclick="showBrands('T');">T</span>
                                <span onclick="showBrands('W');">W</span>
                                <span onclick="showBrands('X');">X</span>
                                <span onclick="showBrands('Y');">Y</span>
                                <span onclick="showBrands('Z');">Z</span>
                           </span>
                        </div>
                     <div class="form-group cdetail" id="cdetail">
                          <ul id="brandul">
                          
                          <li onclick="showFactory('33')"><img src="<%=repairPath%>html/img/audi.png"/><span>奥迪</span></li>
                           <li onclick="showFactory('15')"><img src="<%=repairPath%>html/img/BBM.png"/><span>宝马</span></li>
                            <li onclick="showFactory('14')"><img src="<%=repairPath%>html/img/bentian.png"/><span>本田</span></li>
                             <li onclick="showFactory('13')"><img src="<%=repairPath%>html/img/biaozhi.png"/><span>标致</span></li>
                              <li onclick="showFactory('38')"><img src="<%=repairPath%>html/img/buick.png"/><span>别克</span></li>
                               <li onclick="showFactory('75')"><img src="<%=repairPath%>html/img/byd.png"/><span>比亚迪</span></li>
                                <li onclick="showFactory('1')"><img src="<%=repairPath%>html/img/dazhong.png"/><span>大众</span></li>
                                 <li onclick="showFactory('3')"><img src="<%=repairPath%>html/img/fengtian.png"/><span>丰田</span></li>
                                  <li onclick="showFactory('8')"><img src="<%=repairPath%>html/img/ford.png"/><span>福特</span></li>
                                   <li onclick="showFactory('12')"><img src="<%=repairPath%>html/img/modern.png"/><span>现代</span></li>
                                    
                          </ul>
                        </div>
                    
                     
                    </div>
                </div>
              <!--   <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="save-car-modal" >下一步</button>
                </div> -->
            </div>
            
           
        </div>
    </div>

    <div class="modal fade pei-kind">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">选择配件</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="" class="col-sm-2 control-label">一级分类</label>
                            <div class="col-sm-8">
                                <select id="first-kind-data" class="form-control">
                                    <option value="0">-请选择-</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-2 control-label">二级分类</label>
                            <div class="col-sm-8">
                                <select id="second-kind-data" class="form-control"></select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-2 control-label">三级分类</label>
                            <div class="col-sm-8">
                                <select id="third-kind-data" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="save-pei-kind">保存</button>
                </div>
            </div>
        </div>
    </div>

</body>

</html>

<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script src="<%=basePath%>html/lib/dist/js/bootstrap.min.js"></script>
<script src="<%=basePath%>html/plugin/iCheck/icheck.min.js"></script>
<script src="<%=basePath%>html/plugin/HubSpot/js/messenger.min.js"></script>
<script>
(function () {
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    Messenger.options = {
        extraClasses: 'messenger-fixed messenger-on-bottom',
        theme: 'block'
    };
})();
</script>

<!--[if lte IE 6]>
<script type="text/javascript" src="<%=basePath%>html/bsie/js/bootstrap-ie.js"></script>
<![endif]-->
<script type="text/javascript" src="<%=basePath%>html/js/com.fn.js"></script>
<script type="text/javascript">
(function() {
    carModalSelect("<%=basePath%>");
    peiKindSelect("<%=basePath%>");
})();

$(function() {
    $('.list-title .glyphicon').click(function() {
        if ($(this).hasClass('glyphicon-plus-sign')) {
            $(this).removeClass('glyphicon-plus-sign').addClass('glyphicon-minus-sign');
            $(this).closest('.child-list').find('.list-body').slideUp('slow');
        } else if ($(this).hasClass('glyphicon-minus-sign')) {
            $(this).removeClass('glyphicon-minus-sign').addClass('glyphicon-plus-sign');
            $(this).closest('.child-list').find('.list-body').slideDown('fast');
        }
    });
});
</script>

<script>
	if(getCookie("carModel")!=null){
		var carModel_text=getCookie("carModel");
		var carId_text=getCookie("carId");
		var carModel_text2=carModel_text.replace("%2F","/");
		var carModel_text3=carModel_text2.replace("%2F","/");
		var carModel_text4=carModel_text3.replace("%2F","/");
		var carModel_text5=carModel_text4.replace("+"," ");
		var carModel_text6=carModel_text5.replace("+"," ");
		var carModel_text7=carModel_text6.replace("+"," ");
		
		var a1=carModel_text7.split("/")[0];
		var a2=carModel_text7.split("/")[1];
		var a3=carModel_text7.split("/")[2];
		var a4=carModel_text7.split("/")[3];
		$('.car-modal-btn').text(carModel_text7);
		var carId_text1=carId_text.replace("%2F","/");
		var carId_text2=carId_text1.replace("%2F","/");
		var carId_text3=carId_text2.replace("%2F","/");
		var b1=carId_text3.split("/")[0];
		var b2=carId_text3.split("/")[1];
		var b3=carId_text3.split("/")[2];
		var b4=carId_text3.split("/")[3];
		setDefaultCar('<%=basePath%>',b1,b2,b3,b4);
	}
	
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

function setDefaultCar(basePath,obj,obj2,obj3,obj4){
	 $("#car-brand-data option[value='" +obj+ "'] ").attr("selected",true);
	 ajaxGetData('#car-factory-data',basePath+"member/factoryList?id="+obj);
	 $("#car-factory-data option[value='" + obj2 + "'] ").attr("selected",true);
	 ajaxGetData('#car-series-data',basePath+"member/fctList?id="+obj2);
	 $("#car-series-data option[value='" + obj3 + "'] ").attr("selected",true);
	 ajaxGetData('#car-modal-data',basePath+"member/specList?id="+obj3);
	 $("#car-modal-data option[value='" + obj4 + "'] ").attr("selected",true);
}

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
var hot=document.getElementById("hot");
hot.onclick();
var obj1="";
var obj2="";
var obj3="";
var obj4="";
var buffer="";
var buffer1="";
var buffer2="";
var buffer3="";
var buffer4="";
var buffer5="";
var buffer6="";
var buffer7="";
var buffer8="";
var car="";
var brand="";
var brandName="";
var factory="";
var factoryName="";
var fct="";
var fctName="";
var speci="";
var speciName="";
var spanNum=$("#cpinpai span span");
var value =$(this).text();
for(j=0;j<spanNum.length;j++){
spanNum.click(function(){
$(this).addClass("thisClass").siblings().removeClass("thisClass");
});
}
function showBrands(obj){
//false为同步，这个 testAsync()方法中的Ajax请求将整个浏览器锁死，
//只有tet.php执行结束后，才可以执行其它操作。
 obj1=obj;
  $.ajax({
        type: "post",
        data:{'value':obj},
        url: "/b2bweb-repair/cost/showBrand",
        async:false,
        dataType: "json",
		success: function(data) {
		document.getElementById("brandul").innerHTML="";
		for(var i=0; i<data.length; i++){
		document.getElementById("brandul").innerHTML+="<li onclick=\"showFactory('"+data[i].id+"','"+data[i].name+"')\"><img  src='"+data[i].imgurl+"'"+"/><span style='max-width:80px;white-space: nowrap; text-overflow:none; overflow:hidden;' title='"+data[i].name+"'>"+data[i].name+"</span></li>";
		}
		buffer1=document.getElementById("brandul").innerHTML;
		
		var dlNum  =$("#cdetail #brandul").find("li");
		$('#cdetail #brandul li ').click(function(){
		buffer2=$('#cpinpai').html();
		$('#cpinpai').html="";
		$('#cpinpai').html(" <span style=' float: left;margin-left: 60px;'>已选车型：</span>");
		var text =$(this).text();
		$('#cpinpai').append(" <span id='forchoice1' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove\"></p></span>");
		buffer=$('#cpinpai').html();
		var len=$('#cpinpai').find("span").length-1;
		$("#urlNode").children("li").get(len).setAttribute("class","li2");
		$('#forchoice1').click(function(){
		$('#forchoice1').slideToggle();
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1);
		});
		});

		},
		error : function() {
		alert("出错了-A！");
		}
		});
}

function showFactory(obj,value){
brand=obj;
brandName=value;
obj2=obj;
	  $.ajax({
        type: "post",
        data:{'id':obj},
        url: "/b2bweb-repair/cost/showFactory",
        async:true,
        dataType: "json",
		success: function(data) {
		buffer3=document.getElementById("brandul").innerHTML;
		document.getElementById("brandul").innerHTML="";
		for(var i=0; i<data.length; i++){
		document.getElementById("brandul").innerHTML+="<li onclick=\"showFct('"+data[i].id+"','"+data[i].name+"')\"><span title='"+data[i].name+"'>"+data[i].name+"</span></li>";
		}
		var dlNum  =$("#cdetail #brandul").find("li");
		$('#cdetail #brandul li ').click(function(){
		$('#cpinpai').html=buffer;
		buffer4=$('#cpinpai').html();
		var text =$(this).text();
		$('#cpinpai').append(" <span id='forchoice2' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove\"></p></span>");
		buffer=$('#cpinpai').html();
		var len=$('#cpinpai').find("span").length-1;
		$("#urlNode").children("li").get(len).setAttribute("class","li2");
		
		$('#forchoice2').click(function(){
		$('#cpinpai').html(buffer4);
		$('#brandul').html(buffer3);
		$("#urlNode").children("li").get(2).setAttribute("class","li1");
		showFactory(obj2,value);
		});
		
		});

		$('#forchoice1').click(function(){
		showBrands(obj1);
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1,value);
		});
		},
		error : function() {
		alert("出错了 -B");
		}
		});
}


function showFct(obj,value){
factory=obj;
factoryName=value;
obj3=obj;
	  $.ajax({
        type: "get",
        data:{'id':obj},
        url: "/b2bweb-repair/cost/showFct",
        async:true,
        dataType: "json",
		success: function(data) {
		buffer5=document.getElementById("brandul").innerHTML;
		document.getElementById("brandul").innerHTML="";
		for(var i=0; i<data.length; i++){
		document.getElementById("brandul").innerHTML+="<li onclick=\"showSpeci('"+data[i].id+"','"+data[i].name+"')\"><img  src='"+data[i].imgurl+"'"+"/><span style=\"max-width:80px;white-space: nowrap; text-overflow:none; overflow:hidden;\" title='"+data[i].name+"'>"+data[i].name+"</span></li>";
		}
		var dlNum  =$("#cdetail #brandul").find("li");
		$('#cdetail #brandul li ').click(function(){
		$('#cpinpai').html=buffer;
		buffer6=$('#cpinpai').html();
		var text =$(this).text();
		car=$(this).text();
		$('#cpinpai').append(" <span id='forchoice3' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove\"></p></span>");
		buffer=$('#cpinpai').html();
		var len=$('#cpinpai').find("span").length-1;
		$("#urlNode").children("li").get(len).setAttribute("class","li2");
		$('#forchoice3').click(function(){
		$('#forchoice3').slideToggle();
		$('#cpinpai').html(buffer6);
		$('#brandul').html(buffer5);
		$("#urlNode").children("li").get(3).setAttribute("class","li1");
		showFct(obj3,value);
		});
		});
		$('#forchoice2').click(function(){
		$('#cpinpai').html(buffer4);
		$('#brandul').html(buffer3);
		$("#urlNode").children("li").get(2).setAttribute("class","li1");
		showFactory(obj2,value);
		});
		$('#forchoice1').click(function(){
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1,value);
		});
		},
		error : function() {
		alert("出错了-C");
		}
		});
}
	
function showSpeci(obj,value){
fct=obj;
fctName=value;
obj4=obj;
	  $.ajax({
        type: "get",
        data:{'id':obj},
        url: "/b2bweb-repair/cost/showSpeci",
        async:true,
        dataType: "json",
		success: function(data) {
		buffer7=document.getElementById("brandul").innerHTML;
		document.getElementById("brandul").innerHTML="";
		$('#cpinpai').html=buffer;
		buffer8=$('#cpinpai').html();
		for(var i=0; i<data.length; i++){
		
		document.getElementById("brandul").innerHTML+="<li style='padding-left:0px;margin-left: 5px;width:175px;' onclick=\"fun5('"+data[i].id+"','"+data[i].name+"')\"><span style='font-size: 12px;' title='"+data[i].name+"'>"+data[i].name+"</span></li>";
		}
		var dlNum  =$("#cdetail #brandul").find("li");
		$('#cdetail #brandul li ').click(function(){
		
		var text =$(this).text();
		
		$('#cpinpai').append(" <span id='forchoice4' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove\"></p></span>");
		buffer=$('#cpinpai').html();

		$('#forchoice4').click(function(){
		$('#forchoice4').slideToggle();
		$('#cpinpai').html(buffer8);
		$('#brandul').html(buffer7);
		showSpeci(obj4,value);
		});
		});
		$('#forchoice3').click(function(){
		$('#forchoice3').slideToggle();
		$('#cpinpai').html(buffer6);
		$('#brandul').html(buffer5);
		$("#urlNode").children("li").get(3).setAttribute("class","li1");
		showFct(obj3,value);
		});
		$('#forchoice2').click(function(){
		$('#cpinpai').html(buffer4);
		$('#brandul').html(buffer3);
		$("#urlNode").children("li").get(2).setAttribute("class","li1");
		showFactory(obj2,value);
		});
		$('#forchoice1').click(function(){
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1,value);
		});
		},
		error : function() {
		alert("出错了-D");
		}
		});
}	


function fun5(obj,value){
speci=obj;
speciName=value;
$('#cdetail #brandul li ').click(function(){
		
		var text =$(this).text();
		 var len=$('#cpinpai').find("span").length-1;
		for(var i=4;i<=len;i++){
		$('#cpinpai').find("#forchoice4").remove();
		} 
		var text =$(this).text();
		
		$('#cpinpai').append(" <span id='forchoice4' style='background-color:#dbf3ff;border:1px solid #00a9ff;float:left;font-size:14px;color:#00a9ff;padding-left:20px;padding-right:20px;padding-top:1px;'>"+text+"<p class=\"glyphicon glyphicon-remove\"></p></span>");
		buffer=$('#cpinpai').html();

		$('#forchoice4').click(function(){
		$('#forchoice4').slideToggle();
		$('#cpinpai').html(buffer8);
		$('#brandul').html(buffer7);
		showSpeci(obj4,fctName);
		});
		});
		$('#forchoice3').click(function(){
		$('#forchoice3').slideToggle();
		$('#cpinpai').html(buffer6);
		$('#brandul').html(buffer5);
		$("#urlNode").children("li").get(3).setAttribute("class","li1");
		showFct(obj3,value);
		});
		$('#forchoice2').click(function(){
		$('#cpinpai').html(buffer4);
		$('#brandul').html(buffer3);
		$("#urlNode").children("li").get(2).setAttribute("class","li1");
		showFactory(obj2,value);
		});
		$('#forchoice1').click(function(){
		$('#cpinpai').html(buffer2);
		$('#brandul').html(buffer1);
		$("#urlNode").children("li").get(1).setAttribute("class","li1");
		showBrands(obj1,value);
		});
	
		
var carModel=brandName+"/"+factoryName+"/"+fctName+"/"+speciName;
var carId=brand+"/"+factory+"/"+fct+"/"+speci;
$('.car-modal-btn').text(carModel);
brand=brand;
factory=factory;
fct=fct;
speci=speci;
$("#car-brand-data option[value='" +brand+ "'] ").attr("selected",true);
$("#car-factory-data option[value='" + factory + "'] ").attr("selected",true); 
$("#car-series-data option[value='" + fct + "'] ").attr("selected",true); 
$("#car-modal-data option[value='" + speci + "'] ").attr("selected",true);
$('.car-modal-btn').css("color","#00a9ff");



  $.ajax({
                   type: "POST",
                   data:{carModel:carModel},
                   url: "/b2bweb-repair/maintain/carModal",
                   async:false,
                   dataType: "html",
                   success: function(data) {
                   },
                   error: function() {
                  	alert("失败");
                   }
               });    
 
 $('.close').click();
 
 saveCarModel2(carModel,carId);
}	

function saveCarModel2(obj,_test){
	var carModel=obj;
	var carModelId=_test;
	window.location.href="/b2bweb-demo/pei/saveHeadCarModel2?carModel="+carModel+"&carModelId="+carModelId;
	
}
</script>

<%
String dialogue = BccHost.getUsedurl()+"/";
%>
<script type="text/javascript">
	   function successdialogue(data){
	    	var jsondata = data;
	   }
	   function errordialogue(){ 
	   }   
       function ajaxdialogue(getUrl){
        var sessionBufferId = "<%=(String) session.getAttribute("sessionBufferId")%>";
 		var obj={"sessionBufferId":sessionBufferId}; 
        $.ajax({
             type: "get",
             url: getUrl,             
             dataType: "jsonp",
             data:obj,
             success: successdialogue,
             error: errordialogue
         });         
         }
         
    	ajaxdialogue("<%=dialogue%>dialogue.jsp");
</script>