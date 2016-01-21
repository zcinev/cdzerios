<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="./public/header.jsp"%>
 
<script src="<%=basePath%>html/js/vaildateform.js" type="text/javascript"></script>
<script src="<%=basePath%>html/jquery.min.js"></script>
 <style>
#newreg{
background-color:#ff9100;border-color: #ed8802;width: 80px;
}
#main a{
color:white;
}
 #main a:hover{
background-color:#EFA84C;
}
#forget a{
color:Red;

}

.btn-primary:hover{
color: white;
background-color: #00A9FF;
border-color: #029ae8;
}
.btn-primary{
background-color: #428bca;
}
</style>

<div class="container-fluid">

    <div class="row">
 <div style="  background: none repeat scroll 0 0 #ffffff; border: 6px solid #e1e1e1; height: 320px;border-radius:5px;">
        <div class="panel panel-primary" style="border-color: #C8E5FF ;border-width: 2px;">
            <div class="panel-heading" style="border: none;background: transparent;padding-left:20px;padding-top:15px;">
                <h3 class="panel-title" style="color: #353535;font-weight: bold;">会员登录</h3>
            </div>
           
            <div class="panel-body paddingLeft0 paddingRight0" style="margin-top:-12px;">
                <div class="col-md-5 pull-left" style="margin-right:-3px;">
                    <div class="thumbnail" style="border:none;margin-bottom:0;padding-bottom:0;">
                    	<div id="centerMsg"><img alt="" src="<%=basePath%>html/img/login_user_03.png" ></div>
                       <%--  <%@ include file="./public/baidu2.jsp"%>  --%>
                    </div>
                </div>
                <div class="col-md-6 pull-right" style="margin-top:6px;font-size: 48px;color:#E10602;">
                   	<div id="completeLogin2" style="padding:20px 50px;font-size: 18px;color: #666">&nbsp;&nbsp;你已经登陆了</div>
                   	 <div id="completeLogin" style="font-size: 14px;text-align:center;"></div>
                 </div>
            </div>
        </div>
     </div>
    </div>
</div>
          
<%@ include file="./public/logoutfoot.jsp"%>
<script type="text/javascript"> 
	var userTel="${userTel}";
	var staffName="${staffName}";
	dlyzc = document.getElementById("completeLogin");
	var dlyzc2 = document.getElementById("completeLogin2");
	var user_speak="尊敬的"+strName+"会员，感谢登陆车队长—您最贴心的汽车管家,开启属于您的愉悦汽车之旅!您的专属汽车管家"+staffName+"（<font color=\"#0099ff\">"+userTel+"</font>）,随时恭候您!";
	str = "";
	if((strName==null)||(strName=="null")||(strName==""));
	else {
	
	if(typeId=="1")
		str = "<a  href=\"<%=basePathwx%>person/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">继续</a>&nbsp;&nbsp;<a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\" role=\"button\">注销</a>";
	if(typeId=="2")
		str = "<a  href=\"<%=basePath%>member/memberCenter?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">继续 </a>&nbsp;&nbsp;<a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="3")
		str = "<a  href=\"<%=basePathwx%>adv/index?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">继续</a>&nbsp;&nbsp;<a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="5")
		str = "<a  href=\"<%=basePath%>purchase/showIndex?id="+strId+"&userName="+strName+"&typeId="+typeId+"\">继续</a>&nbsp;&nbsp;<a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";
	if(typeId=="4")
		str = "<a  href=\"<%=trafficPath%>manager/showIndex\">继续</a>&nbsp;&nbsp;<a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";	
	if(typeId=="7")
   		str = "<a  href=\"<%=usedUrl%>estimate/showIndex\">继续</a>&nbsp;&nbsp;<a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";	
	if(typeId=="8")
   		str = "<a  href=\"<%=usedUrl%>carService/showIndex\">继续 </a>&nbsp;&nbsp;<a href=\"<%=basePath%>pei/logout\" class=\"navbar-link\">注销</a>";	   	
		
   		dlyzc.innerHTML = str;
		dlyzc2.innerHTML=user_speak;
	
	}


 var newWindow=document.getElementById("passWordWindow");
function passWord(){
 newWindow.style.display="";
 };
 function confrimPassWord(){
 var nameTelphone=document.getElementById("nameTelphone").value;
 var nameIdentity=document.getElementById("nameIdentity").value;
 alert(nameTelphone);
 alert(nameIdentity);
 document.form2.action="<%=basePath%>pei/userPassWordList?nameTelphone=nameTelphone&nameIdentity=nameIdentity";
 document.form2.submit();
 newWindow.style.display="none";
};
function removePassWord(){
  newWindow.style.display="none";
};
</script>

