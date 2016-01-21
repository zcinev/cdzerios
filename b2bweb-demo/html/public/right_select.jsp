<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="toususearch" class="mod">
    	<div class="hd"><h5>投诉案例检索</h5></div>
    	<div class="bd">
        	<form target="_self" method="post" action="<%=basePath%>carsaf/carSafeIndex">
                 <ul class="ul-1">
                      <!-- class="form-control" -->
                     <li>  <select name="brand_id"  id="car-brand-data_04" style="width:180px;">
                         <option value="0">-请选择品牌-</option>
                     </select></li>
                    
                     <li> <select name="factory_id"  id="car-factory-data_04" style="width:180px;">
                         <option value="0">-请选择厂商-</option>
                     </select></li>
                      <li>    <select name="fct_id"  id="car-series-data_04" style="width:180px;">
                         <option value="0">-请选择车系-</option>
                     </select></li>
                      <li>  <select name="speci_id"  id="car-modal-data_04" style="width:180px;">
                         <option value="0" style="width:160px;">-请选择车型-</option>
                     </select></li>
                     <li style="display:none"><span>投诉分类: </span> <select disabled="" class="s2"><option value="0">全部</option><option value="1">发动机</option></select></li>
                                                     
                     <li><button class="hidefocus btn0" type="submit">查询</button></li>							
                </ul>
            </form>
            <a class="btn-link" href="#">汽车投诉 <font size="2">维权入口</font></a>
            <p class="gray">(最佳受理时间：10:00-16:00)</p>
            <span class="line-square"> </span>
            <ul class="ul-2">
            	<li>今日投诉：<span class="count" id="now_count_id"></span> 条</li>
                <li>投诉总量：<span class="count" id="all_count_id"></span> 条</li>
            </ul>
        </div>
        </div>		
                
  