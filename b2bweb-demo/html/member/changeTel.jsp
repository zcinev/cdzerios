<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../public/head3.jsp" %>
<style>
.form-group label{
font-weight: normal;
}
.btn-primary{
background-color:#FF7400;border-color: #ed8802;width: 60px;
}
.btn-primary:hover{
color: white;
background-color:#ed8802 ;
border: #FF7400;
height: 34px;
}
</style>
        <div class="container-fluid">
            <div class="row"><%--
                <%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-xs-12 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                              <ol class="breadcrumb bottom-spacing-0">
                        <li>绑定手机号
                        </li>
                       
                    </ol>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" role="form" method="post" action="">
                        <div class="form-group">
                            <label for="tel" class="col-sm-2 control-label">新号码</label>
                            <div class="col-sm-3" style="margin-left: -20px;">
                            
                                <input type="tel" class="form-control" name="oldTel" id="oldTel" placeholder="新手机号码" value="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="tel" class="col-sm-2 control-label">旧号码</label>
                            <div class="col-sm-3" style="margin-left: -20px;">
                                <input type="tel" id="telphone" class="form-control" name="telphone"   placeholder="旧手机号码" value="${sessionScope.userName}">
                               <input type="hidden" id="oldtelphone" class="form-control" name="mobileId" placeholder="旧手机号码" value="${sessionScope.userName}">
                                
                            </div>
                            <div class="col-sm-3">
                                <a href="javascript:;" class="btn btn-default" id="get-ucode-pass" onsubmit="return updateListTest();">获取校验码</a>
                            </div>
                        </div>
                        <div class="form-group" >
                            <label for="code" class="col-sm-2 control-label">校验码</label>
                            <div class="col-sm-3" style="margin-left: -20px;">
                                <input type="text" class="form-control" name="code" id="code" placeholder="手机校验码">
                            </div>
                            <div class="col-sm-3 help-block">
                                请输入手机校验码！
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="button" class="btn btn-primary" onclick="javascript:updateTelphoneList();">修改</button>
                            </div>
                             
                        </div>
                    </form>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
         <%@ include file="../public/footer.jsp" %>
         <script type="text/javascript">
 //修改手机号码 获取验证码
 var wait=30;
  
$('#get-ucode-pass').click(function() {
 var telphone=document.getElementById("telphone").value;
    var oldtelphone=document.getElementById("oldtelphone").value;
      
    var _this = $(this);
   if(telphone==oldtelphone){
    $.ajax({
        type: "POST",
        url: "<%=basePath%>mobile/ucode",
        data: {mobile:$("#telphone").val()},
        dataType: "json",
        success: function(dat){
                   
            _this.text('30秒之后重新发送');
            var wait = 30;
            _this.text(wait + '秒之后重新发送');
            var interval = setInterval(function() {
               wait--;
                 _this.text(wait + '秒之后重新发送');
                if (wait==0) {
                    
                        _this.text('获取校验码');
                    
                  
                    clearInterval(interval);
                   
                };
            }, 1000);
           
        },
         
        error: function() {
            _this.text('发送失败');
        }
    });
    
   }else{
    alert("旧手机号码错误,请重新输入！");
    return false;   
   }
   
});
</script>
<script>
 function updateTelphoneList(){
        $.ajax({
            type: "GET",  
            data:{oldTel:$('#oldTel').val(),mobile:$('#telphone').val(),code:$('#code').val()},
            url: "<%=basePath%>member/updateTelphone",
            async:false,
            dataType: "html",
            success: function(data) {
               alert("修改成功！");
               window.location.href="<%=basePath%>pei/logout";
               
             },
            error: function() {
            _this.text('请求失败');
            }
        });
 }
</script>

 
 