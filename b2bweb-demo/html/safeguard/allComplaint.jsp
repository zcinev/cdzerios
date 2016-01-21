<%@ page language="java" import="java.util.*,com.bc.session.*" pageEncoding="UTF-8"%>
<%@ include file="../public/shead.jsp"%>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 paddingRight0 paddingLeft0 pull-left">
			 	<div><span  style="color: #464646"><a href="<%=basePath%>carsaf/carSafeIndex">首页</a>&nbsp;>&nbsp;<a href="<%=basePath%>carsaf/carSafeIndex?complaint_object=ZCwq">整车维权</a>&nbsp;>&nbsp;</span><span style="color: #9C9C9C">发动机漏油</span></div>
			</div>
			<div class="col-md-12">
				<div class="tslist pull-left">
					<div class="tnote">
						<div class="listtitle">
							<strong>| 整车维权</strong>
							<span><font color="#666">汽车主机厂的产品质量问题，征集共同案例，携手维权！</font></span>
						</div>
						<div class="bd">
							<div class="head clearfix">
	                        	<font size="4">${key.title}</font>
	                            <div style="float:right;">
	                            	<p><a href="<%=basePath%>html/safeguard/sameComplaint.jsp">类似案例</a>：<font color="red">${same}</font>
	                            	</p>
                            	</div>
                           	</div> 
                            <div class="s">
								<div class="panel current" style="padding:10px;">
									<em class="gjz">
									关键字:<a href="#" class="hotbq hotbq-a">${key.brand_name}</a>
										 <a href="#" class="hotbq hotbq-c">${key.complaint_type_name}</a>
									</em>
									<br><br>
								<div>
									<p>投诉单号：${key.complaint_number}</p>
									<p>投诉车型：${key.brand_name}-${key.speci_name}</p>
									<p>所在城市：${key.buy_car_city}</p>
									<p>投诉企业：${key.buy_car_store}</p>
									<p>购买日期：${key.buy_car_time}</p>
									<p>投诉分类：${key.complaint_type_name}</p>
									<input  type="hidden" value="${key.complaint_number}" id="complaint_number">
								</div> 
								</div>
	                        </div>
						</div>
						<div class="listtitle">
							<span><font color="#666">案例征集中，时间截止于${key.now_time}</font></span>
						</div>
					</div>
					<div class="dContent">
						<div class="a_title">详细内容：</div>
						<div class="a_content">${key.detail_content}</div>
						<p style="float:left;"><a href="<%=basePath%>carsaf/sameComplaintList?id=${key.id}" class="btn sbtn" value="">我也有类似情况</a></p>
						<p style="float:right;"><a href="<%=basePath%>carsaf/newComplaintList"class="btn nbtn" value="" >发表新的投诉</a></p>
					</div>
					<div class="newComment">
						<ul class="nav nav-tabs" role="tablist" id="myTab">
							<li class="active"><a href="#" role="tab" data-toggle="tab" id="tab">最新评论</a></li>
						</ul>
						<table style="width:100%">
							<thead>
							 
								<tr>
									<th>评论者</th>
									<th>评论内容</th>
									<th>投诉对象</th>
									<th>发表时间</th>
								</tr>
								
							</thead>
							<tbody>
							 <c:forEach var="mkey" items="${comment}">
								<tr>
									<td>${mkey['sender_name']}</td>
									<td>${mkey['content']}</td>
									<td>${mkey['complaint_object']}</td>
									<td>${mkey['add_time']}</td>
								</tr> 
								 </c:forEach>
							</tbody>
						</table>
						<div class="publish">
							<div class="p_title"><strong>发表评论</strong>（<font color="#FE0000">${com_len}</font>条评论）</div>
						 
							<div class="p_content"><textarea id="p_editor" name="content" rows="10" cols="120"></textarea></div>
                                <input name="url" value="http://product.auto.163.com/series/complain/16991.html" type="hidden">
                              <!--   <label>用户名：<input class="textbox" name="username" type="text"></label>
                                <label>密码：<input class="textbox" name="password" type="password"></label> -->
                                <label><input class="chk"  value="1" name="savelogin" id="savelogin" type="checkbox">&nbsp;&nbsp;匿名</label>&nbsp;&nbsp;
                                <button onclick="javascript:commentList();">发布</button>
                           
						</div>
					</div>
				</div>
				<div class="col-r">
					<!-- Begin: 投诉案例检索 -->
              	<%@ include file="../public/right_select.jsp"%> 			
                <!-- End: 投诉案例检索 -->	
				<!-- Begin: 投诉平台使用说明 -->
                <div id="rm2" class="mod mod23">
                    <div class="hd"><h5>投诉平台使用说明</h5></div>
                    <div class="bd">                        
                        <ul>
                            <li>1、注册会员<p>如您已经是网易汽车会员，请直接<a style="color:#BA2636;" href="<%=basePath%>html/login.jsp">登录</a>，不是请您<a style="color:#BA2636;" href="<%=basePath%>html/register.jsp">注册</a></p></li>
                            <li>2、发表投诉<p>请将您遇到的问题在网易汽车投诉平台进行如实填写，并提交。</p></li>
                        	<li>3、专业审核<p>相关负责人会在后台进行审核，并将投诉转发给相关企业。</p></li>
                            <li>4、企业处理<p>我们会敦促企业在2周内对投诉作出反应，并解决车主的合理要求。</p></li>
                            <li>5、结果审核<p>针对企业的处理结果，我们会选择性的进行审核监督。</p></li>
                            <li>6、完毕</li>
                        </ul>
                    </div>
                </div>				
                <!-- End: 投诉平台使用说明 -->
                <!-- Begin: 投诉平台运行原则 -->
                <div id="rm3" class="mod mod23">
                    <div class="hd"><h5>投诉平台运行措施及原则</h5></div>
                    <div class="bd">                        
                        <ul>
                        	<li>1、运营原则<p>以解决问题为第一原则,突出沟通的桥梁作用，力争最大限度解决车主投诉的合理问题。</p></li>
                            <li>2、投诉平台运营措施<p>网友投诉平台化</p><p>信息传递准确化</p><p>解决问题快速化</p><p>力争网友满意化</p></li>
                        </ul>
                    </div>
                </div>				
                <!-- End: 投诉平台运行原则 -->	                 
			</div>
			</div>
        </div>
    </div>

<%@ include file="../public/foot.jsp"%>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=basePath%>html/plugin/kindeditor/lang/zh_CN.js"></script>
<script>
function commentList(){
var userName="<%=session.getAttribute("userName")%>";
var p_editor=$('#p_editor').val();
   var savelogin="";    
 var complaint_number=$('#complaint_number').val();
         if(userName==null &&userName=="" ||userName=="null"){
        alert("请先登陆，才能评论！");
           
        }else{
        if(p_editor!=null && p_editor!="" && p_editor!="null"){
                  if(document.getElementById("savelogin").checked){
                      savelogin="0";
                  }else{
                  savelogin="1";
                  }
                 
     $.ajax({
            type: "POST", 
            data:{p_editor:p_editor,savelogin:savelogin,complaint_number:complaint_number},
            url: "<%=basePath%>carsaf/confrimComplaintComment",
            async:false,
            dataType: "html",
            success: function(data) {
                if(data!=null &&data=="成功"){
                 alert("评论成功！");
                    window.location.reload();
                }
                if(data!=null && data=="大于3"){
                    alert("一个用户最多只能评论三条！");
                }
                    
 				},
				error : function() {
					alert("评论失败!");
				}
			});
 
         }else{
          alert("请填写评论内容！");
        }
        }


    
}

</script>
 <script type="text/javascript" src="<%=basePath%>html/js/right_select.js">
 </script>
<script>
 	carModalSelect_all_list_04("<%=basePath%>");
</script>
